pipeline
{
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub_token')
    }

    stages
    {
        stage('Build')
        {
			steps {
				timeout(30) {
					sh 'mvn clean'
					sh 'mvn install -Dmaven.test.skip=true'
				}			
			}
        }

//         stage('Tests') {
//             steps {
//                 echo 'Tests'
//                 sh 'mvn test'
//             }
//         }

        stage('Package')
        {
			steps {
				retry(3) {
					timeout(30) {
						echo 'Release'
						sh 'mvn package -Dmaven.test.skip=true'
					}								
				}
			}
        }

        stage('Build Image')
        {
			steps {
				timeout(30) {
					sh 'docker build -t hello:latest .'
				}
			}
        }

        stage('Release')
        {
			steps {
				timeout(30) {
					sh 'docker stop WebhookJenkins'
					sh 'docker run --rm -d -p 8081:8080 --name WebhookJenkins hello'
				}
			}
        }

        stage('Deploy')
        {
            parallel
            {
                stage('Login')
                {
                    steps {
                        echo 'Login'
                        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                    }
                }

                stage('Update image')
                {
                    steps
                    {
                        //  docker tag local-image:tagname new-repo:tagname
                        //sh 'docker tag hello:latest tsudockerhub/aws-webhook:latest'

                        //  docker push new-repo:tagname
                        sh 'docker push tsudockerhub/aws-webhook:latest'
                    }
                }

                stage('Update container')
                {
                    steps {
                        echo 'Updating container...'
                    }
                }
            }
        }
    }
}