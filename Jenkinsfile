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
			options {
				timeout(time: 30, unit: "SECONDS")
			}
			
			steps {
				//retry(3) {
					sh 'mvn clean'
					sh 'mvn install -Dmaven.test.skip=true'
				//}
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
			options {
				timeout(time: 30, unit: "SECONDS") 
			}
			
			steps {
				//retry(3) {
					echo 'Release'
					sh 'mvn package -Dmaven.test.skip=true'
				//}								
			}
        }

        stage('Build Image')
        {
			options {
				timeout(time: 30, unit: "SECONDS")
			}
			
			steps {
				sh 'docker build -t hello:latest .'
			}
        }

        stage('Release')
        {
			options {
				timeout(time: 30, unit: "SECONDS") 
			}
			
			steps {
				script {
					try {
						sh 'docker stop WebhookJenkins'				
					} catch (Exception e) {}
				}
				
				sh 'docker run --rm -d -p 8081:8080 --name WebhookJenkins hello'
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
                        //sh 'docker push tsudockerhub/aws-webhook:latest'		// O comando push é cobrado pela Amazon como saída de dados
																				// por isso esta linha foi comentada. 
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