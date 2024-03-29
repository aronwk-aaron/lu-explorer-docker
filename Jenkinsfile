properties([
  parameters([
    gitParameter(
        branch: '',
        branchFilter: 'origin/(.*)',
        defaultValue: 'origin/main',
        description: '',
        name: 'GIT_BRANCH',
        quickFilterEnabled: true,
        selectedValue: 'DEFAULT',
        sortMode: 'NONE',
        tagFilter: '*',
        useRepository: 'git@github.com:LUDevNet/lu-explorer.git',
        type: 'PT_BRANCH',
        listSize: "1"
    )
  ])
])

node('worker'){
    ansiColor('xterm'){
        currentBuild.setDescription(params.GIT_BRANCH)

        stage('Clone Code'){
            checkout([
                $class: 'GitSCM',
                branches: [[name: params.GIT_BRANCH]],
                extensions: [],
                userRemoteConfigs: [
                    [
                        credentialsId: 'aronwk',
                        url: 'git@github.com:LUDevNet/lu-explorer.git'
                    ]
                ]
            ])
        }
        def tag = ''
        stage('Build Container'){
            if (params.GIT_BRANCH.contains('main')){
                tag = 'latest'
            } else {
                tag = params.GIT_BRANCH.replace('\\', '-')
            }
            sh "docker build --no-cache -t aronwk/lu-explorer:$tag ."
        }
        stage('Push Container'){
            withCredentials([usernamePassword(credentialsId: 'docker-hub-token', passwordVariable: 'password', usernameVariable: 'username')]) {
                sh "docker login -u $username -p $password"
                sh "docker push aronwk/lu-explorer:$tag"
                sh "docker logout"
            }
        }
    }
}
