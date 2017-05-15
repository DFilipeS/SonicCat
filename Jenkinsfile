pipeline {
  agent {
    docker {
      image 'elixir'
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