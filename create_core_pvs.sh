# Purpose


function createPVs() {
    echo -en "\n\n Creating the following PVs $startVol .. $endVol of the following size: $volsize   ********** \n";

    for volume in vol{$startVol..$envVol} ; do
    cat << EOF > /root/pvs/${volume}
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
    done;
}

volsize="10Gi"
startVol=4
endVol=5
createPVs
