//*
pipeline
{
    agent any

    triggers {
        pollSCM '* * * * *'
    }
    stages
    {
        stage('Build')
        {
            steps
            {
                sh 'mvn clean'
                sh 'mvn install -Dmaven.test.skip=true'
            }
        }

        stage('Tests')
        {
            steps
            {
                echo 'Tests'
                sh 'mvn test'
            }
        }

        stage('Release')
        {
            steps
            {
                echo 'Release'
                sh 'mvn package -Dmaven.test.skip=true'
            }
        }
    }
}
//*/

/*
pipeline
{
    agent any
    triggers {
        pollSCM '* * * * *'
    }
    stages
    {
        stage('Build')
        {
            steps
            {
                dir("workspace/MavenHello/hello") {
                    sh 'mvn clean'
                    sh 'mvn install -Dmaven.test.skip=true'
                }
            }
        }

        stage('Tests')
        {
            steps
            {
                echo 'Tests'
                dir("hello/") {
                    sh 'mvn test'
                }
            }
        }

        stage('Release')
        {
            steps
            {
                echo 'Release'
                dir("hello/") {
                    sh 'mvn package -Dmaven.test.skip=true'
                }
            }
        }
    }
}
//*/