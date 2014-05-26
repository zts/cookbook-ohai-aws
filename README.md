# ohai-aws cookbook

Provides ohai plugins to expose additional information about AWS
services available to an instance on EC2.

I'm using this, but I no longer think it is a good idea.  Among other
things, it is slow to run, and you may find your use of the AWS API
rate limited (in which case, these plugins may silently fail).

I'm more likely to ditch this whole idea than fix it, but patches
welcome.

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

Add `recipe[ohai-aws]` to the node's run_list.

# Attributes

# Recipes

# Author

Author:: Zachary Stevens (<zts@cryptocracy.com>)
