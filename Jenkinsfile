pipeline{
    agent any
    stages{
      stage('Git checkout')
        {
            steps
            {
                script
                {
                    try 
                    {
                        checkout([$class: 'GitSCM', branches: [[name: "${GIT_BRANCH}"]], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'jenkins-master-private-key', url: 'git@github.com:akshaysharma25/Jenkinsrepo.git']]])
                        sh """
                        #!/bin/bash
                        git clone git@github.com:akshaysharma25/Jenkinsrepo.git
                        git checkout ${GIT_BRANCH}
                        """
                    }
                    catch (exc)
                    {
                        echo 'Git checkout failed'
                        throw exc
                    }
                }
            }
        }



    }




    }
