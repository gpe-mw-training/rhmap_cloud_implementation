# Purpose
#  Before installation of the MBaaS, you must first register each node in the cluster with the Red Hat Subscription Manager (RHSM).
#  The registration enables OSE to access the Docker container images of RHMAP components hosted in the Red Hat Docker Registry.
#  This script automates this registration across your OSE3 cluster
#
#  NOTE:  To use this scrpt, you will need to know (up front) the poolid of your subscription that includes entitlements to RHMAP bits.
#
# Usage (execute the following from master1.example.com)
#    ,/configure_rhn.sh <RHN User Id> <RHN password> <poolId of subscription with RHMAP entitlements>
#
# TO-DO:  replace with ansible script:  https://github.com/redhat-gpe/rhmap_cloud_implementation/issues/38#issuecomment-266460245

# Example
#   ./configure_rhn.sh rhn-gps-jab 'XXXXX'  8a85f9843e3d687a013e3ddd471a083e







thisHost=`hostname`

if [ x$1 == x ];then
    echo -en "\nERROR: Please pass RHN userId as first command line parameter to this script.\n\n"
    exit 1;
fi
if [ x$2 == x ];then
    echo -en "\nERROR: Please pass RHN password as second command line parameter to this script.\n\n"
    exit 1;
fi
if [ x$3 == x ];then
    echo -en "\nERROR: Please pass RHMAP enabled poolId as third command line parameter to this script.\n\n"
    exit 1;
fi
if [[ "$thisHost" != "master1"* ]]  || [["$thisHost" != "oselab"*]];then
   echo -en "\nERROR: Please execute this script on either the oselab or master1 nodes.  You are currently on: $thisHost \n\n"
   exit 1;
fi 

export MONGODB_IMAGE=rhmap42/mongodb
export MONGODB_IMAGE_VERSION=latest

# Configure RHMAP subscription for all RHMAP nodes
for node in infranode1.example.com  \
        node1.example.com \
        node2.example.com \
        node3.example.com \
        node4.example.com \
        node5.example.com \
        node6.example.com;
do 
        echo -en "\nConfiguring RHN for: $node\n"; 
        ssh $node " subscription-manager register --username=$1 --password=$2; subscription-manager attach --pool=$3; mv /etc/yum.repos.d/open.repo /etc/yum.repos.d/open.repo.bk; yum install -y subscription-manager-plugin-container --disablerepo=* --enablerepo=rhel-7-server-optional-rpms; /usr/libexec/rhsmcertd-worker; docker pull $MONGODB_IMAGE:$MONGODB_IMAGE_VERSION"; 
done
echo -en "\n\n *******  Done configuring subscription-manager on RHMAP nodes   ********** \n\n";

# Configure RHMAP subscription on OSE master1 (so as to be able to install rhmap-fh-openshift-templates)
subscription-manager register --username=$1 --password=$2;
subscription-manager attach --pool=$3;
mv /etc/yum.repos.d/open.repo /etc/yum.repos.d/open.repo.bk;
yum install -y rhmap-fh-openshift-templates --disablerepo=* --enablerepo=rhel-7-server-rhmap-4.2-rpms
echo -en "\n\n *******  Done configuring subscription-manager on master node   ********** \n";
