pipeline {
  agent {
    dockerfile {
      filename 'docker/ci/Dockerfile'
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