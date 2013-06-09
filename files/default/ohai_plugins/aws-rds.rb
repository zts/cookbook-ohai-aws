provides "aws/rds"
require_plugin "aws"

aws[:rds] = Mash.new unless aws[:rds]

rds_conn = AWS::RDS.new

aws[:rds][:instances] ||= Mash.new

rds_conn.instances.each do |i|
  r = {
    :id       => i.db_instance_identifier,
    :status   => i.db_instance_status,
    :host     => i.endpoint_address,
    :port     => i.endpoint_port,
    :db_name  => i.db_name,
    :username => i.master_username,
    :engine => {
      :type    => i.engine,
      :version => i.engine_version
    },
    :instance_type     => i.db_instance_class,
    :allocated_storage => i.allocated_storage,
    :availability_zone => i.availability_zone_name,
    :multi_az          => i.multi_az,
    :created           => i.creation_date_time
  }
  aws[:rds][:instances][r[:id]] = r
end
