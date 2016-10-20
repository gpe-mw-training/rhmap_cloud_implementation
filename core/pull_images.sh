export MAP_VERSION=rhmap42
export IMAGE_VERSION=latest

# Pull necessary images on RHMAP CORE nodes
for node in infranode1.example.com  \
        node5.example.com \
        node6.example.com;
do
        echo -en "\nPulling images for: $node\n";
        for i in fh-messaging \
                fh-supercore \
                gitlab-shell \
                httpd \
                gitlab-shell \
                fh-scm \
                ups-eap \
                millicore \
                fh-ngui \
                fh-appstore \
                fh-sdks;
        do
            ssh $node " docker pull $MAP_VERSION/$i:$IMAGE_VERSION";
        done
done
echo -en "\n\n *******  Done pulling images on RHMAP nodes   ********** \n\n";
