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

//         stage('Tests')
//         {
//             steps
//             {
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

//         stage('Update image')
//         {
//             steps {
//                 echo 'TESTE: Update image'
//                 sh 'docker --version'
//             }
//         }

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