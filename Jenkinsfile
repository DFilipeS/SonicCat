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
        parallel(
          "build": {
            echo 'Hello!'
            sh '''whoami
mix local.hex --force
mix deps.get'''
            
          },
          "test": {
            echo 'sadsadsad'
            
          }
        )
      }
    }
    stage('deploy') {
      steps {
        input 'asdasdasd'
      }
    }
  }
}