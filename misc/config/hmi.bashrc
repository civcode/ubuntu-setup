wacker-old() {                                                                                
    IP_ADDR='192.168.3.26'
    echo Connecting to root@$IP_ADDR
    rm ~/.ssh/known_hosts
    #ssh -o StrictHostKeyChecking=no root@$IP_ADDR#
    ssh root@$IP_ADDR     
}                                        

wacker() {                                   
    IP_ADDR='169.254.3.26'                                                                                                                                                                  
    ROOT_PWD=''
    echo Connecting to root@$IP_ADDR
    #ssh -o HostKeyAlgorithms=+ssh-rsa root@$IP_ADDR
    rm ~/.ssh/known_hosts
    sshpass -p $ROOT_PWD ssh -o HostKeyAlgorithms=+ssh-rsa -o StrictHostKeyChecking=no root@$IP_ADDR
}                                        
                                               
topcon-old() {
    IP_ADDR='169.254.3.27' 
    ROOT_PWD=''
    echo Connecting to root@$IP_ADDR
    rm ~/.ssh/known_hosts    
    #ssh -o HostKeyAlgorithms=+ssh-rsa root@$IP_ADDR
    sshpass -p $ROOT_PWD ssh -o HostKeyAlgorithms=+ssh-rsa -o StrictHostKeyChecking=no root@$IP_ADDR
}                   

topcon() {
    IP_ADDR='169.254.3.27'
    echo Connecting to root@$IP_ADDR
    #ssh -o HostKeyAlgorithms=+ssh-rsa root@$IP_ADDR
    rm ~/.ssh/known_hosts
    sshpass -p "6Y8wwW8w8SwXWgUB" ssh -o HostKeyAlgorithms=+ssh-rsa -o StrictHostKeyChecking=no root@$IP_ADDR
}

# rafi cross-compilation
rafi-source() {
    echo "sourcing RBBAFI SDK"
    echo "unset LD_LIBRARY_PATH"
    echo "source /opt/rafi/BSP-Yocto-FSL-RAFI/environment-setup-cortexa9t2hf-neon-rafi-linux-gnueabi"
    unset LD_LIBRARY_PATH
    source /opt/rafi/BSP-Yocto-FSL-RAFI/environment-setup-cortexa9t2hf-neon-rafi-linux-gnueabi
}

topcon-source() {
    source /opt/we-wayland-qt5/2.7.4/environment-setup-armv7at2hf-neon-poky-linux-gnueabi
}

raficp-old() {
    IP_ADDR='192.168.3.26'
    echo "Copying $1 to root@$IP_ADDR:$2"
    scp $1 root@$IP_ADDR:$2
}

raficp() {
    IP_ADDR='169.254.3.26'
    ROOT_PWD=''
    echo "Copying $1 to root@$IP_ADDR:$2"
    #sshpass -p $ROOT_PWD scp -o HostKeyAlgorithms=+ssh-rsa -o StrictHostKeyChecking=no $1 root@$IP_ADDR:$2
    sshpass -p $ROOT_PWD scp -o StrictHostKeyChecking=no $1 root@$IP_ADDR:$2
}

topconcp-old() {
    IP_ADDR='169.254.3.27'
    ROOT_PWD=''
    echo "Copying $1 to root@$IP_ADDR:$2"
    sshpass -p $ROOT_PWD scp -o HostKeyAlgorithms=+ssh-rsa -o StrictHostKeyChecking=no $1 root@$IP_ADDR:$2
}

topconcp() {
    IP_ADDR='169.254.3.27'
    ROOT_PWD=''
    echo "Copying $1 to root@$IP_ADDR:$2"
    sshpass -p $ROOT_PWD scp -o HostKeyAlgorithms=+ssh-rsa -o StrictHostKeyChecking=no $1 root@$IP_ADDR:$2
}

#export RAFI="192.168.3.26"
export RAFI="169.254.3.26"
#export TOPCON="192.168.3.27"
export TOPCON="169.254.3.27"