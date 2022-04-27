pipeline
{
    agent any

    environment {
        DOCKERHUB_CREDENTIALS=credentials('dockerhub-cred-raja')
    }

    stages
    {
        stage('Build')
        {
            steps
            {
                echo 'CURRENT PATH: '
                sh 'pwd'

                echo 'UPDATED PATH'
                sh 'pwd'

                sh 'mvn clean'
                //sh 'mvn install -Dmaven.test.skip=true'
            }
        }

//         stage('Tests') {
//             steps {
//                 echo 'Tests'
//                 sh 'mvn test'
//             }
//         }

        stage('Release')
        {
            steps
            {
                echo 'Release'
                sh 'mvn package -Dmaven.test.skip=true'
            }
        }

        stage('Build Image')
        {
            steps {
                sh 'docker build -t hello:latest .'
            }
        }

        stage('Run image on Container')
        {
            steps {
                sh 'docker run --rm -d -p 8081:8080 --name WebhookJenkins hello'
            }
        }

        parallel firstBranch:
        {
            stage('Push image to Docker Hub')
            {
                build job: 'Pushing image', parameters: [string(name: 'Environment', value: "$env.Environment")]

                steps {
                    echo 'Login'
                    sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                }

                steps {
                    //  docker tag local-image:tagname new-repo:tagname
                    sh 'docker tag hello:latest tsudockerhub/aws-webhook:latest'

                    //  docker push new-repo:tagname
                    sh 'docker push tsudockerhub/aws-webhook:latest'
                }
            }
        },
        secondBranch:
        {
            stage ('Update container') {
                build job: 'Updating container', parameters: [string(name: 'Environment', value: "$env.Environment")]
            }
        }
    }
}

//======================================================================================================================
/*
pipeline
{
    agent any
//     triggers {
//         pollSCM '* * * * *'
//     }
    stages
    {
        stage('Build')
        {
            steps {
                sh 'mvn clean'
                sh 'mvn install -Dmaven.test.skip=true'
            }
        }

        stage('Tests')
        {
            steps {
                echo 'Tests'
                sh 'mvn test'
            }
        }

        stage('Release')
        {
            steps {
                echo 'Release'
                sh 'mvn package -Dmaven.test.skip=true'
            }
        }

//         stage('Update image')
//         {
//             steps {
//                 echo 'TESTE: Update image'
//                 sh 'docker --version'
//             }
//         }
    }
}
//*/