list=$(oc get pv | grep rhmap-mbaas | awk '{ print $1}');
for pv in ${list[@]} ; do
 path=$(oc describe pv ${pv} | grep Path: | awk '{print $2}' | tr -d '\r')
 echo ${path}
done

