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
        sh 'mix deps.get -y'
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