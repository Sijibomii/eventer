project = "eventer-jenkins-cluster"
region     = "us-central1"
credentials_path= "./credentials.json"
zone = "us-central1-a"
ssh_user = "packer"
ssh_public_key = "../packer/master/ssh.pub"
jenkins_username = "jenkins"
jenkins_password = "jenkins"
jenkins_credentials_id ="../packer/master/ssh" #used jenkins_cred

#bastion = "35.192.146.223"
#jenkins = "34.67.137.170"