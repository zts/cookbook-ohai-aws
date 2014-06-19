## 0.4.3

 * Include instance name in the list of instances returned for
   cloudformation stacks.

## 0.4.2

 * Increase the number of AWS API retries from 3 to 10.

## 0.4.1

 * Specify ohai plugin path (we can't use the attribute from the ohai
   cookbook, as we no longer depend on it).

## 0.4.0

 * Restore details for the stack which started this instance.  These
   are used, and were mistakenly removed.
 * Don't use the ohai cookbook to install the plugins, as this forces
   an additional reload of ohai each run.

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
 
