for node in infranode1.example.com  \
        node1.example.com \
        node2.example.com \
        node3.example.com \
        node4.example.com; 
do 
        echo -en "\nConfiguring RHN for: $node\n"; 
        ssh $node " subscription-manager register --username=$1 --password=$2; subscription-manager attach --pool=$3; mv /etc/yum.repos.d/open.repo /etc/yum.repos.d/open.repo.bk; yum install -y subscription-manager-plugin-container --disablerepo=* --enablerepo=rhel-7-server-optional-rpms; /usr/libexec/rhsmcertd-worker"; 
done
