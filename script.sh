#!/bin/bash

RG="rg-terrabyte"
LOCATION="brazilsouth"
VNET="vnet-terrabyte"
SUBNET="subnet-terrabyte"
NSG="nsg-terrabyte"
VM_NAME="vm-terrabyte"
USER_NAME="rm564555"
PASSWORD="TerraByteGS$"
SIZE="Standard_E2s_v3"

az group create --name $RG --location $LOCATION -o none

az network vnet create --resource-group $RG --name $VNET --address-prefix 10.0.0.0/16 \
  --subnet-name $SUBNET --subnet-prefix 10.0.1.0/24 -o none

az network nsg create --resource-group $RG --name $NSG -o none

az network nsg rule create --resource-group $RG --nsg-name $NSG --name Allow-SSH \
  --priority 100 --destination-port-ranges 22 --access Allow --protocol Tcp -o none

az network nsg rule create --resource-group $RG --nsg-name $NSG --name Allow-HTTP \
  --priority 110 --destination-port-ranges 80 --access Allow --protocol Tcp -o none

az network nsg rule create --resource-group $RG --nsg-name $NSG --name Allow-8080 \
  --priority 120 --destination-port-ranges 8080 --access Allow --protocol Tcp -o none

cat << 'EOF' > settings-script.sh
#!/bin/bash
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile none swap sw 0 0" >> /etc/fstab

apt-get update -y
apt-get install -y ca-certificates curl gnupg lsb-release

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl start docker
systemctl enable docker

git config --global --add safe.directory /home/rm564555/java-devops

cd /home/rm564555
if [ ! -d "java-devops" ]; then
  git clone https://github.com/juliakina/java-devops.git
else
  cd java-devops
  git pull
  cd ..
fi

chown -R rm564555:rm564555 /home/rm564555/java-devops
cd /home/rm564555/java-devops/TerraByte-Java/backend
docker compose up -d --build
EOF

az vm create \
  --resource-group $RG \
  --name $VM_NAME \
  --image Ubuntu2204 \
  --size $SIZE \
  --admin-username $USER_NAME \
  --admin-password "$PASSWORD" \
  --authentication-type password \
  --vnet-name $VNET \
  --subnet $SUBNET \
  --nsg $NSG \
  --public-ip-sku Standard -o none

az vm run-command invoke \
  -g $RG \
  -n $VM_NAME \
  --command-id RunShellScript \
  --scripts @settings-script.sh