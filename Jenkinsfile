pipeline {
  agent {
    dockerfile {
      filename 'docker/ci/Dockerfile'
      args '--link postgres:postgres'
    }
    
  }
  stages {
    stage('build') {
      steps {
        sh 'mix deps.get'
        sh '''cd assets
npm install'''
      }
    }
    stage('test') {
      steps {
        sh '''mix ecto.create
mix ecto.migrate
mix test'''
      }
    }
  }
}