list=$(oc get pods | grep mongodb-'[0-9]' | awk '{ print $1}');
for pod in ${list[@]} ; do
     ip=$(oc describe pod ${pod} | grep IP: | awk '{print $2}' | tr -d '\r')
      echo $pod : ${ip}
done

