echo -en "\n***** Delete DeploymentConfig resources\n"
oc delete dc --all

echo -en "\n***** Delete ReplicationController resources\n"
oc delete rc --all

echo -en "\n***** Delete build resources\n"
oc delete build --all

echo -en "\n***** Delete BuildConfig resources\n"
oc delete bc --all

echo -en "\n***** Delete ImageStream resources\n"
oc delete is --all

echo -en "\n***** Delete Pods\n"
oc delete pod --all

echo -en "\n***** Delete service resources\n"
oc delete service --all

echo -en "\n***** Delete Routes\n"
oc delete route --all

echo -en "\n***** Delete PVCs\n"
oc delete pvc --all

echo -en "\n***** Delete ConfigMaps\n"
oc delete configmaps --all

echo -en "\n ***** DONE DELETING OSE resources.  Don't forget to clean out all NFS shares at:   oselab.example.com:/src/nfs/vol*\n\n"
