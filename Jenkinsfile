#!/usr/bin/env groovy
// Liquibase declarative pipeline
//
//
pipeline {
agent any
  environment {
    PROJ="oracle_project"
    GITURL="https://github.com/Mcho11"
    ENVIRONMENT_STEP="${params.step}"
    BRANCH="${params.pipeline}"
    PATH="C:\\Liquibase\\liquibase-4.3.1;${env.PATH}"
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
   // full command example with flags: call liquibase --url=%URL% --username=%USERNAME% --password=%PASSWORD% --contexts=%ENVIRONMENT_STEP%  --changeLogFile=changelog.sql --classpath=<JDBC_DRIVER>.jar tag version1
      steps {
        bat '''
          cd %PROJ%
          call liquibase --version
          echo "------------------------------------"
          echo "----------liquibase status----------"
          echo "------------------------------------"
          call liquibase status --verbose
          echo "---------------------------------------"
          echo "----------liquibase updateSQL----------"
          echo "---------------------------------------"
          call liquibase updateSQL
          echo "--------------------------------------------------------"
          echo "----------liquibase tag database with version1----------"
          echo "--------------------------------------------------------"
          call liquibase tag version1
          echo "------------------------------------"
          echo "----------liquibase update----------"
          echo "------------------------------------"
          call liquibase update
          echo "------------------------------------------------------------"
          echo "----------liquibase rollback to version1--------------------"
          echo "------------------------------------------------------------"
          rem call liquibase rollback version1
        '''
      } // steps
    }   // Environment stage
  } // stages
  
}  // pipeline