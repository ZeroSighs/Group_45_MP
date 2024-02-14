pipeline {
    agent any

    stages {
        stage('Run CMD Commands') {
            steps {
                bat 'vagrant package --base 4cf729b2-bb5c-4188-bca8-510cc7332f98 --output sonarqubevm.box'
                bat 'vagrant box add sonarqubevm.box --name "sonarqubevm"'
                bat 'vagrant init sonarqubevm'

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
