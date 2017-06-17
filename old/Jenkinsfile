pipeline {
  agent {
    dockerfile {
      filename 'docker/ci/Dockerfile'
      args '-u root --link postgres:postgres'
    }
    
  }
  stages {
    stage('build') {
      steps {
        sh '''mix local.hex --force
mix deps.get'''
        sh '''cd assets
npm install'''
      }
    }
    stage('test') {
      steps {
        sh '''MIX_ENV=test mix ecto.create
MIX_ENV=test mix ecto.migrate
mix test'''
      }
    }
  }
  post {
    always {
      junit 'tests_report.xml'
      
    }
    
  }
}