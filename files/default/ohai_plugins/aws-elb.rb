provides "aws/elb"
require_plugin "aws"

aws[:elb] = Mash.new unless aws[:elb]

elb_conn = AWS::ELB.new

aws[:elb][:load_balancers] ||= Mash.new

elb_conn.load_balancers.each do |i|
  r = {
    :id       => i.name,
    :dns_name  => i.dns_name,
    :scheme   => i.scheme,
    :subnet_ids => i.subnet_ids,
    :availability_zone_names => i.availability_zone_names,
    :policy_descriptions => i.policy_descriptions,
    :canonical_hosted_zone_name => i.canonical_hosted_zone_name,
    :canonical_hosted_zone_name_id => i.canonical_hosted_zone_name_id
  }
  aws[:elb][:load_balancers][r[:id]] = r
end
