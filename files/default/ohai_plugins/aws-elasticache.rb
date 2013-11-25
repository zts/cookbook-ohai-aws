provides "aws/elasticache"
require_plugin "aws"

res = aws[:elasticache] = Mash.new unless aws[:elasticache]

ec_client = AWS::ElastiCache.new.client

aws[:elasticache][:clusters] = Mash.new unless res[:clusters]

cache_clusters = ec_client.describe_cache_clusters(:show_cache_node_info => true)[:cache_clusters]
cache_clusters.each do |cc|
  cluster_data = {
    :id     => cc[:cache_cluster_id],
    :status => cc[:cache_cluster_status],
    :engine => {
      :type    => cc[:engine],
      :version => cc[:engine_version],
    },
    :node_type => cc[:cache_node_type],
    :nodes     => [],
  }

  if cc[:engine] == 'memcached'
    cluster_data[:configuration] = {
      :host => cc[:configuration_endpoint][:address],
      :port => cc[:configuration_endpoint][:port],
    }
  end

  cc[:cache_nodes].each do |cn|
    cluster_data[:nodes] << {
      :id      => cn[:cache_node_id],
      :status  => cn[:cache_node_status],
      :host    => cn[:endpoint][:address],
      :port    => cn[:endpoint][:port],
      :created => cn[:cache_node_create_time],
      :parameter_group_status => cn[:parameter_group_status],
    }

    res[:clusters][cc[:cache_cluster_id]] = cluster_data
  end
end



    
    
