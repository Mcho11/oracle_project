#!/usr/bin/env groovy
// Liquibase declarative pipeline
//
//
pipeline {
agent any
  environment {
    PROJ="<project_name>"
    GITURL="https://github.com/<username>"
    ENVIRONMENT_STEP="${params.step}"
    BRANCH="${params.pipeline}"
    PATH="C:\\Program Files\\liquibase;${env.PATH}"
  }
  stages {

    stage ('Precheck') {
		steps {
			bat '''
        echo "Current project: "%PROJ%
        echo "Current scm branch: "%BRANCH%
        echo "Current environment: "%ENVIRONMENT_STEP%
	echo "Current PATH: "%PATH%
			'''
		} // steps
	} // stage 'precheck'

    stage ('Checkout') {
      steps {
        // checkout Liquibase project from CLO repo
        bat '''
          git clone %GITURL%/%PROJ%.git
          cd %PROJ%
          git checkout %BRANCH%
          git status
          '''
      } // steps for checkout stages
    } // stage 'checkout'

   stage ('liquibase commands'){
      steps {
        bat '''
          cd %PROJ%
          call liquibase --version
          echo "------------------------------------"
          echo "----------liquibase status----------"
          echo "------------------------------------"
          call liquibase --url=%URL% --username=%USERNAME% --password=%PASSWORD% --contexts=%ENVIRONMENT_STEP% --changeLogFile=changelog.sql --classpath=<JDBC_DRIVER>.jar status --verbose
          echo "---------------------------------------"
          echo "----------liquibase updateSQL----------"
          echo "---------------------------------------"
          call liquibase --url=%URL% --username=%USERNAME% --password=%PASSWORD% --contexts=%ENVIRONMENT_STEP%  --changeLogFile=changelog.sql --classpath=<JDBC_DRIVER>.jar updateSQL
          echo "--------------------------------------------------------"
          echo "----------liquibase tag database with version1----------"
          echo "--------------------------------------------------------"
          call liquibase --url=%URL% --username=%USERNAME% --password=%PASSWORD% --contexts=%ENVIRONMENT_STEP%  --changeLogFile=changelog.sql --classpath=<JDBC_DRIVER>.jar tag version1
          echo "------------------------------------"
          echo "----------liquibase update----------"
          echo "------------------------------------"
          call liquibase --url=%URL% --username=%USERNAME% --password=%PASSWORD% --contexts=%ENVIRONMENT_STEP%  --changeLogFile=changelog.sql --classpath=<JDBC_DRIVER>.jar update
          echo "------------------------------------------------------------"
          echo "----------liquibase rollback to version1--------------------"
          echo "------------------------------------------------------------"
          call liquibase --url=%URL% --username=%USERNAME% --password=%PASSWORD% --contexts=%ENVIRONMENT_STEP%  --changeLogFile=changelog.sql --classpath=<JDBC_DRIVER>.jar rollback version1
        '''
      } // steps
    }   // Environment stage
  } // stages
  
}  // pipeline