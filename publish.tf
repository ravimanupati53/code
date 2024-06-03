pipeline {
    agent any

    environment {
        // Define your environment variables
        GITHUB_REPO = 'your_github_repo_url'
        GITHUB_TOKEN = credentials('github_token') // GitHub personal access token stored in Jenkins credentials
        TF_CLOUD_ORG = 'your_tf_organization'
        TF_CLOUD_TOKEN = credentials('terraform_token') // Terraform Cloud API token stored in Jenkins credentials
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the GitHub repository
                git url: "${env.GITHUB_REPO}", credentialsId: 'github_credentials_id'
            }
        }

        stage('Validate') {
            steps {
                // Validate the Terraform configuration
                sh 'terraform init'
                sh 'terraform validate'
            }
        }

        stage('Publish') {
            steps {
                script {
                    // Prepare the module for publication
                    def modulePath = 'path/to/your/module' // Adjust the path as needed
                    sh "cd ${modulePath} && terraform init"

                    // Publish to Terraform Cloud
                    sh """
                        curl -X POST \
                        -H 'Authorization: Bearer ${env.TF_CLOUD_TOKEN}' \
                        -H 'Content-Type: application/vnd.api+json' \
                        -d '{
                          "data": {
                            "type": "registry-modules",
                            "attributes": {
                              "name": "your-module-name",
                              "namespace": "${env.TF_CLOUD_ORG}",
                              "provider": "your-provider",
                              "version": "your-module-version",
                              "source": "${env.GITHUB_REPO}",
                              "tags": ["tag1", "tag2"]
                            }
                          }
                        }' \
                        https://app.terraform.io/api/v2/organizations/${env.TF_CLOUD_ORG}/registry-modules
                    """
                }
            }
        }
    }

    post {
        always {
            // Cleanup actions, such as deleting temporary files
            cleanWs()
        }
    }
}
