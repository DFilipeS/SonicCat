pipeline {
  agent {
    docker {
      image 'elixir'
      args '-u root'
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
        sh 'mix test'
      }
    }
  }
}