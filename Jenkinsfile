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
        echo 'Hello!'
        sh '''whoami
mix local.hex --force
mix deps.get'''
      }
    }
    stage('cenas') {
      steps {
        input 'sdsfsdfsdf'
        echo 'GO'
      }
    }
  }
}