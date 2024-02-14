pipeline {
    agent any
    stages {

        stage('Run Ansible Playbook') {
            steps {
                ansiblePlaybook(
                    playbook: 'Vagrant_Playbook.yml',
                    extraVars: [
                        disableHostKeyChecking: true,
                        installation: 'Ansible',
                        vaultTmpPath: ''
                    ]
                )
            }
        }

        stage('Send Email Notification for Success') {
            when {
                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
            steps {
                emailext (
                    attachLog: true,
                    subject: "Vagrant VM Deployment Result for Sonarqube VM: Successful",
                    body: 'Successful Virtual Machine Initialized on Windows PC.',
                    to: 'zacharytang@outlook.com'
                )
            }
        }

        stage('Send Email Notification for Failure') {
            when {
                expression { currentBuild.resultIsBetterOrEqualTo('FAILURE') }
            }
            steps {
                emailext (
                    attachLog: true,
                    subject: "Vagrant VM Deployment Result for Sonarqube VM: Error",
                    body: 'VM had issues starting up, log output shown below',
                    to: 'zacharytang@outlook.com'
                )
            }
        }        
    }
}
