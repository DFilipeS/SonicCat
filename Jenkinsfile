pipeline {
  agent {
    dockerfile {
      filename 'docker/ci/Dockerfile'
      args '-u root'
    }

  }
  stages {
    stage('build') {
      steps {
        sh '''mix local.hex --force
mix local.rebar --force
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
