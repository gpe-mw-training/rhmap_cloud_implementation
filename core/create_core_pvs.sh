# Purpose


function createPVs() {

echo -en "\n\n Creating the following PVs $startVol .. $endVol of the following size: $volsize   ********** \n";

for i in $(seq ${startVol} ${endVol}) ; do
volume=`echo vol$i`;

cat <<EOF > /root/pvs/${volume}
{
    "apiVersion": "v1",
    "kind": "PersistentVolume",
    "metadata": {
        "name": "${volume}"
    },
    "spec": {
    "capacity": {
        "storage": "${volsize}"
    },
    "accessModes": [ "ReadWriteOnce" ],
    "nfs": {
        "path": "/srv/nfs/${volume}",
        "server": "192.168.0.254"
    },
    "persistentVolumeReclaimPolicy": "Recycle"
    }
}
EOF
echo "created def file for: ${volume}";
done;

}

# MongoDB and FH SCM PVs
volsize="10Gi"
startVol=5
endVol=6
createPVs

# GitLab Shell, MySQL and Metrics Backup Log PVs
volsize="5Gi"
startVol=7
endVol=9
createPVs

# Nagios PV
volsize="1Gi"
startVol=10
endVol=10
createPVs
