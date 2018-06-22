#!/bin/bash

read -p "Docker Name []: " name
read -p "Port Map []: " port
read -p "Volume Map []: " volume
read -p "Command [bash]: " cmd

sname=""
if [ -n "$name" ]; then sname="--name=$name"; fi

sport=""
for n in $port; do 
    sport="$sport -p $n"
done

svolume=""
for n in $volume; do 
    svolume="$svolume -v $n"
done

if [ -z "$cmd" ]; then 
    cmd="bash"
fi

docker run -itd $sname $sport $svolume $1 $cmd

tmpfile=/tmp/set-PS1-in-container.sh

cat << EOF > $tmpfile
#!/bin/bash

export TERM=xterm-256color

color=\$((\$RANDOM % 6 + 1))
COLOR="\\[\\\$(tput setaf \$color)\\]"
RESET="\\[\\\$(tput sgr0)\\]"

echo "export PS1=\"\${COLOR}[\u@host-$name \\W]\$ \${RESET}\"" >> /root/.bashrc

EOF

chmod +x $tmpfile
docker cp $tmpfile $name:/root/set-PS1-in-container.sh
docker exec $name "/root/set-PS1-in-container.sh"

