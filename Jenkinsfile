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
            dir('/aws-mvn-hello/MavenRepositoryHello')
            {
                steps {
                    sh 'mvn clean'
                    sh 'mvn install -Dmaven.test.skip=true'
                }
            }
        }

        stage('Tests')
        {
            dir('/aws-mvn-hello/MavenRepositoryHello')
            {
                steps {
                    echo 'Tests'
                    sh 'mvn test'
                }
            }
        }

        stage('Release')
        {
            dir('/aws-mvn-hello/MavenRepositoryHello')
            {
                steps {
                    echo 'Release'
                    sh 'mvn package -Dmaven.test.skip=true'
                }
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