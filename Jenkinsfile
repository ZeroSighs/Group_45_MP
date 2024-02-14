pipeline {
    agent any

    environment {
        branch = "vagrant"
        githubRepoURL = "https://github.com/ZeroSighs/Group_45_MP.git"
    }

    stages {
        stage('Checkout from GitHub') {
            steps {
                script {
                    git branch: "${branch}",
                    url: "${githubRepoURL}"
                    dir("WinHost_Playbook/${version}") {
                        sh "cat cp Vagrant_Playbook.yml"  // Display the content of the playbook file
                        sh "cp Vagrant_Playbook.yml ${WORKSPACE}/Vagrant_Playbook.yml"
                    }
                }
            }
        }  

        stage('Run Ansible Playbook') {
            steps {
                ansiblePlaybook([extraVars: 
                    	disableHostKeyChecking: true, 
                    	installation: 'Ansible', 
                    	playbook: 'Vagrant_Playbook.yml', 
                    	vaultTmpPath: ''])
            }
        }

        stage('Send Email Notification') {
        	when {
		                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
		            }
            steps {
                emailext attachLog: true, (
                    subject: "Vagrant VM Deployment Result for Sonarqube VM: Successful"
                    body: 'Successful Virtual Machine Initialised on Windows PC.',
                    to: 'zacharytang@outlook.com'
                )
            }
        }

        stage('Send Email Notification') {
        	when {
		                expression { currentBuild.resultIsBetterOrEqualTo('FAILURE') }
		            }
            steps {
                emailext attachLog: true, (
                    subject: "Vagrant VM Deployment Result for Sonarqube VM: Error"
                    body: 'VM had issues starting up, log output shown below',
                    to: 'zacharytang@outlook.com'
                )
            }
        }        
    }
}