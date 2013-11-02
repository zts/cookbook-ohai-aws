provides "aws/cloudformation"
require_plugin "aws"
require_plugin "ec2"

aws[:cloudformation] = Mash.new unless aws[:cloudformation]

# Get the name and logical id of the stack this instance is part of
tags = AWS::EC2.new.instances[ec2[:instance_id]].tags
stack_name = aws[:cloudformation][:stack_name] = tags["aws:cloudformation:stack-name"]
aws[:cloudformation][:logical_id] = tags["aws:cloudformation:logical-id"]

# Get the details of every stack we can see
cfn_conn = AWS::CloudFormation.new
stack = cfn_conn.stacks[stack_name]

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

# For backwards compatibility, copy this stack's params and resources
aws[:cloudformation][:parameters] = aws[:cloudformation][:stacks][stack_name][:parameters]
aws[:cloudformation][:resources] = aws[:cloudformation][:stacks][stack_name][:resources]
