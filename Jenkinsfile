#!groovy
properties([
  parameters([
    string(defaultValue: '1.11.10', description: 'Kubectl Version', name: 'KubectlVersion')
  ])
])

node {
  kubectlVersion = params.KubectlVersion
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
    }
  }
}
