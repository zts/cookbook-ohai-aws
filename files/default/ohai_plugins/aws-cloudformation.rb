provides "aws/cloudformation"
require_plugin "aws"
require_plugin "ec2"

aws[:cloudformation] = Mash.new unless aws[:cloudformation]

ec2_conn = AWS::EC2.new
instance = ec2_conn.instances[ec2[:instance_id]]
tags = instance.tags

aws[:cloudformation][:stack_name] = tags["aws:cloudformation:stack-name"]
aws[:cloudformation][:logical_id] = tags["aws:cloudformation:logical-id"]

cfn_conn = AWS::CloudFormation.new
stack_name = tags["aws:cloudformation:stack-name"]
stack = cfn_conn.stacks[stack_name]

aws[:cloudformation][:parameters] = stack.parameters
aws[:cloudformation][:resources] ||= Mash.new
stack.resource_summaries.each do |rs|
  resource = {
    :type          => rs[:resource_type],
    :logical_id    => rs[:logical_resource_id],
    :physical_id   => rs[:physical_resource_id],
    :status        => rs[:resource_status],
    :status_reason => rs[:resource_status_reason],
    :last_updated  => rs[:last_updated_timestamp],
  }
  id = rs[:logical_resource_id]
  aws[:cloudformation][:resources][id] = resource
end

aws[:cloudformation][:stacks] ||= Mash.new
stack = cfn_conn.stacks.each do |stack|
  aws[:cloudformation][:stacks][stack.name] ||= Mash.new
  aws[:cloudformation][:stacks][stack.name][:parameters] = stack.parameters
  aws[:cloudformation][:stacks][stack.name][:resources] ||= Mash.new

  stack.resource_summaries.each do |rs|
    resource = {
      :type          => rs[:resource_type],
      :logical_id    => rs[:logical_resource_id],
      :physical_id   => rs[:physical_resource_id],
      :status        => rs[:resource_status],
      :status_reason => rs[:resource_status_reason],
      :last_updated  => rs[:last_updated_timestamp],
    }
    id = rs[:logical_resource_id]
    aws[:cloudformation][:stacks][stack.name][:resources][id] = resource
  end
end
