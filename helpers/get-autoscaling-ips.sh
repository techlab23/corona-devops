#!/bin/bash

# Use custom profile name if applicable otherwise leave it blank. 
#Usage: ./get-autoscaling-ips.sh AWSProfileName

if [ $1 ]
then
    profile=`echo --profile=$1`
else
    profile=''
fi

instanceIds=`aws autoscaling describe-auto-scaling-instances --query 'AutoScalingInstances[*].InstanceId' --output text $profile`
publicIps=`aws ec2 describe-instances --instance-ids ${instanceIds} --query 'Reservations[*].Instances[*].PublicIpAddress' --output text $profile`
echo $publicIps
