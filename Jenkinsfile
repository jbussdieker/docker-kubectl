#!groovy
latest = "1.15.0-alpha.3"
stable = "1.14.1"

properties([
  parameters([
    string(defaultValue: '1.14.1', description: 'Version', name: 'Version')
  ])
])

node {
  kubectlVersion = params.Version
  credentialsId = 'docker-hub-credentials'

  stage('clone') {
    checkout scm
  }

  stage('build') {
    image = docker.build("jbussdieker/kubectl:${kubectlVersion}", "--build-arg kubectl_version=${kubectlVersion} .")
  }

  stage('test') {
    image.inside {
      sh "kubectl version --client | grep ${kubectlVersion}"
    }
  }

  stage('publish') {
    docker.withRegistry("", credentialsId) {
      image.push()
      if (kubectlVersion == latest)
        image.push('latest')
      else if (kubectlVersion == stable)
        image.push('stable')
    }
  }
}
