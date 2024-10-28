 #!/bin/bash
      sudo apt update
      sudo apt install openjdk-17-jdk -y
      java -version
      curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
      echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
      sudo apt update
      sudo apt install jenkins -y
      sudo systemctl start jenkins
      sudo systemctl enable jenkins