# ohai-aws cookbook

Provides ohai plugins to expose additional information about AWS
services available to an instance on EC2.

# Requirements

The instance must have an IAM instance profile granting access to the
required AWS API calls.

A suitable PolicyDocument might look like this:

    "PolicyDocument" : {
        "Statement" : [{
            "Effect"   :"Allow",
            "Action"   : [
                "autoscaling:Describe*",
                "cloudformation:Describe*",
                "cloudformation:ListStackResources*",
                "elasticache:Describe*",
                "ec2:Describe*"
            ],
            "Resource" : "*"
        }]
    }

# Usage

Add `recipe[ohai-ec2]` to the node's run_list.

# Attributes

# Recipes

# Author

Author:: Zachary Stevens (<zts@cryptocracy.com>)
