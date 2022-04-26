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

                dir("MavenRepositoryHello") {
                    echo 'UPDATED PATH'
                    sh 'pwd'

                    sh 'mvn clean'
                    sh 'mvn install -Dmaven.test.skip=true'
                }
            }
        }

        stage('Tests')
        {
            steps
            {
                dir("MavenRepositoryHello") {
                    echo 'Tests'
                    sh 'mvn test'
                }
            }
        }

        stage('Release')
        {
            steps
            {
                dir("MavenRepositoryHello") {
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