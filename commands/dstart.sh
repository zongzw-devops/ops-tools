#!/bin/bash

read -p "Docker Image []: " image

while [ -z "$image" ]; do
    echo "Select Image to Run: "
    docker images --format "table {{.Repository}}\t{{.Repository}}:{{.Tag}}\t{{.CreatedSince}}\t{{.Size}}"
    read -p "Docker Image []: " image
done

##################### container name ###########################
namedefault="container-`date +%s`"
read -p "Container Name [$namedefault]: " name

sname=""
if [ -n "$name" ]; then 
    sname="--name=$name"
else 
    name=$namedefault
    sname="--name=$name"
fi

##################### exposed ports ###########################
read -p "Port Map []: " port
sport=""
for n in $port; do 
    sport="$sport -p $n"
done

##################### volume maps ###########################
voldefault="$PWD : /root/$name"
read -p "Volume Map [ $voldefault ]: ('n' to skip) " volume
svolume=""
if [ -z "$volume" ]; then 
    svolume="-v `echo $voldefault | sed 's/ : /:/'`"
elif [ "$volume" = "n" ]; then 
    svolume=""
else
    for n in $volume; do 
        svolume="$svolume -v $n"
    done
fi

##################### command ###########################
read -p "Command [bash]: " cmd

if [ -z "$cmd" ]; then 
    cmd="bash"
fi

##################### docker run ###########################
docker run -itd --privileged $sname $sport $svolume $image $cmd
if [ $? -ne 0 ]; then 
    echo "Failed to start container: $name"
    exit 1
fi

##################### configure container ###########################
tmpfile=/tmp/set-PS1-in-container.sh

cat << EOF > $tmpfile
#!/bin/bash

export TERM=xterm-256color

color=\$((\$RANDOM % 6 + 1))
COLOR="\\[\\\$(tput setaf \$color)\\]"
RESET="\\[\\\$(tput sgr0)\\]"

echo "export PS1=\"\${COLOR}[\u@container-$name \\W]\$ \${RESET}\"" >> /root/.bashrc

EOF

chmod +x $tmpfile
docker cp $tmpfile $name:/root/set-PS1-in-container.sh
docker exec $name "/root/set-PS1-in-container.sh"

