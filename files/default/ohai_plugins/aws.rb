require "aws-sdk"

provides "aws"
aws Mash.new

require_plugin "ec2"
aws[:region] = ec2[:placement_availability_zone].gsub(/[a-z]$/, '')

AWS.config(
           :region => aws[:region],
           :max_retries => 10,
           )
