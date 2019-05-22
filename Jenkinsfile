#!groovy
latest = "1.16.0-alpha.0"
stable = "1.14.2"

properties([
  parameters([
    string(defaultValue: '1.14.2', description: 'Version', name: 'Version')
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
      if (kubectlVersion == stable)
        image.push('stable')
    }
  }
}
