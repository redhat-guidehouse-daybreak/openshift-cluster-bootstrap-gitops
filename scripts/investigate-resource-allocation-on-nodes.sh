#!/bin/bash
# loop through the nodes using the oc cli and parse out the allocated resources
# sample output of "oc get nodes" looks like this:
# NAME                           STATUS   ROLES                  AGE   VERSION
# ip-10-0-177-236.ec2.internal   Ready    infra,worker           8d    v1.26.3+b404935
# ip-10-0-188-202.ec2.internal   Ready    worker                 45h   v1.26.3+b404935
# ip-10-0-191-62.ec2.internal    Ready    worker                 8d    v1.26.3+b404935
# ip-10-0-194-183.ec2.internal   Ready    control-plane,master   8d    v1.26.3+b404935
# ip-10-0-217-96.ec2.internal    Ready    worker                 11h   v1.26.3+b404935
# ip-10-0-221-148.ec2.internal   Ready    worker                 8d    v1.26.3+b404935
# ip-10-0-223-195.ec2.internal   Ready    worker                 8d    v1.26.3+b404935
# ip-10-0-235-145.ec2.internal   Ready    infra,worker           8d    v1.26.3+b404935
# ip-10-0-237-89.ec2.internal    Ready    control-plane,master   8d    v1.26.3+b404935
# ip-10-0-245-21.ec2.internal    Ready    control-plane,master   8d    v1.26.3+b404935

# using "oc get nodes", create two arrays, one for NODES and one for ROLES

NODES=( $(oc get nodes | awk '{print $1}' | grep -v NAME) );
ROLES=( $(oc get nodes | awk '{print $3}' | grep -v ROLES) );


# loop through the associative array and use "oc describe node" to print out the allocated resources. 
# Make sure to include the node name and role in the output
# example: 
# Node: ip-10-0-177-236.ec2.internal; Role: infra,worker
# Allocated resources:
#   (Total limits may be over 100 percent, i.e., overcommitted.)
#   Resource                    Requests      Limits
#   --------                    --------      ------
#   cpu                         1867m (23%)   100m (1%)
#   memory                      7866Mi (27%)  992Mi (3%)
#   ephemeral-storage           0 (0%)        0 (0%)
#   hugepages-1Gi               0 (0%)        0 (0%)
#   hugepages-2Mi               0 (0%)        0 (0%)
#   attachable-volumes-aws-ebs  0             0
# --------------------------------------------------
# end examples

# loop through the nodes and roles arrays
for idx in "${!NODES[@]}"; do
    echo "Node: ${NODES[$idx]}; Role: ${ROLES[$idx]}";
    oc describe node ${NODES[$idx]} | grep -A 9 "Allocated resources:";
    echo "--------------------------------------------------";
done
