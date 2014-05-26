## 0.3.0

 * Only show details for top-level CloudFormation stacks.  Chef runs
   have been failing when our AWS API calls are being throttled, so we
   want to reduce the amount of required calls.  While the names of
   all cfn stacks will be listed, we only return details for some
   stacks.  A top-level stack is one with 0 or 1 dashes in its name -
   this may need to be improved upon.

## 0.2.0

 * Add support for ElastiCache-Redis

## 0.1.3

 * List running EC2 instances for each cfn stack
 * Expose all running cfn stacks
 