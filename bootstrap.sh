#sincronizar hora del sistema
#instalar ntp
sudo apt install -y ntp
sudo systemctl start ntp
sudo systemctl enable ntp
#instalar nptdate
sudo apt install ntpdate
#activar la sincronizacion
sudo ntpdate -s time.nist.gov


# Establecimiento de la contraseña
echo 'vagrant:test' | sudo chpasswd
echo "Script de aprovisionamiento ejecutado" >> /home/vagrant/provision.log

# Instalación de SSH Server
sudo apt install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh

# Firewall
sudo ufw allow ssh

# Habilitar la autenticación por contraseña en SSH
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

# Reiniciar el servicio SSH
sudo systemctl restart ssh

#Instalar Jenkins
sudo apt install -y openjdk-11-jdk
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5BA31D57EF5975CA
sudo apt update
sudo apt install -y jenkins
#iniciar Jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins

#Agregar Jenkis al groupo docker
sudo usermod -aG docker jenkins
sudo service jenkins restart
sudo groups jenkins

# Instalar Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Agregar el usuario "vagrant" al grupo "docker"
sudo groupadd docker
sudo usermod -aG docker vagrant

# Activar los cambios
newgrp docker

#Mover archivos del Desafio 14
cp Dockerfile /var/lib/jenkins/workspace/pipeline_desafio_15/
cp docker-compose.yml /var/lib/jenkins/workspace/pipeline_desafio_15/
cp .htpasswd /var/lib/jenkins/workspace/pipeline_desafio_15/
cp -r app /var/lib/jenkins/workspace/pipeline_desafio_15/