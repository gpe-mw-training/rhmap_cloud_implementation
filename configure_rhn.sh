# Purpose
#  Before installation of the MBaaS, you must first register each node in the cluster with the Red Hat Subscription Manager (RHSM).
#  The registration enables OSE to access the Docker container images of RHMAP components hosted in the Red Hat Docker Registry.
#  This script automates this registration across your OSE3 cluster
#
#  NOTE:  To use this scrpt, you will need to know (up front) the poolid of your subscription that includes entitlements to RHMAP bits.
#
# Usage
#    ,/configure_rhn.sh <RHN User Id> <RHN password> <poolId of subscription with RHMAP entitlements>

# Example
#   ./configure_rhn.sh rhn-gps-jab XXXXX  8a85f9843e3d687a013e3ddd471a083e

export MONGODB_IMAGE=rhmap41/mongodb
export MONGODB_IMAGE_VERSION=3.2-1

for node in infranode1.example.com  \
        node1.example.com \
        node2.example.com \
        node3.example.com \
        node4.example.com; 
do 
        echo -en "\nConfiguring RHN for: $node\n"; 
        ssh $node " subscription-manager register --username=$1 --password=$2; subscription-manager attach --pool=$3; mv /etc/yum.repos.d/open.repo /etc/yum.repos.d/open.repo.bk; yum install -y subscription-manager-plugin-container --disablerepo=* --enablerepo=rhel-7-server-optional-rpms; /usr/libexec/rhsmcertd-worker; docker pull $MONGODB_IMAGE:$MONGODB_IMAGE_VERSION"; 
done
