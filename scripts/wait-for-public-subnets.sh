#!/bin/bash

set -euxo pipefail

AWS_DEFAULT_OUTPUT=json
export AWS_DEFAULT_OUTPUT

while (( $(aws ec2 describe-subnets --filters Name=vpc-id,Values="${1}" --filters Name=tag:type,Values=public --region "${2}" | jq -e '.Subnets[].AvailabilityZone' | wc -l | xargs) < 2 ));
do
  sleep 1;
done
