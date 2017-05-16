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
        sh '''sudo mix local.hex --force
mix deps.get'''
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