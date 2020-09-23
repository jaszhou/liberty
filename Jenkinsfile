// 执行Helm的方法
def helmDeploy(Map args) {
    if(args.init){
        println "Helm 初始化"
        sh "helm init --client-only --stable-repo-url ${args.url}"
    } else if (args.dry_run) {
        println "尝试 Helm 部署，验证是否能正常部署"
        sh "helm upgrade --install ${args.name} --namespace ${args.namespace} ${args.values} --set ${args.image},${args.tag} stable/${args.template} --dry-run --debug"
    } else {
        println "正式 Helm 部署"
        sh "helm upgrade --install ${args.name} --namespace ${args.namespace} ${args.values} --set ${args.image},${args.tag} stable/${args.template}"
    }
}

podTemplate(label: 'jnlp-slave', // See 1
  containers: [
      /*
    containerTemplate(
      name: 'jnlp',
      //image: 'jenkinsci/jnlp-slave:3.10-1-alpine',        
      image: 'jenkins/jnlp-slave:3.35-5-alpine',
      args: '${computer.jnlpmac} ${computer.name}'
    ), */
   
       containerTemplate(
      name: 'docker',
      image: 'docker:1.11',
      command: 'cat',
      ttyEnabled: true
    ),
       containerTemplate(
      name: 'mongoclient',
      image: 'mongoclient/mongoclient',
      command: 'cat',
      ttyEnabled: true
    ),
       containerTemplate(
      name: 'maven',
      image: 'maven:3.6.3-jdk-8',
      command: 'sleep',
      args: 'infinity',
      ttyEnabled: true
    ),
       containerTemplate(
      name: 'helm-kubectl',
      image: 'registry.cn-shanghai.aliyuncs.com/mydlq/helm-kubectl:2.13.1',
      command: 'cat',
      ttyEnabled: true
    ),
  ],
  volumes: [ // See 2
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'), // See 3
    hostPathVolume(mountPath: '/root/.m2', hostPath: '/Users/jasonx/Downloads/acs/jenkins'),
  ]
)
{
  node ('jnlp-slave') {

    
   
      stage('Maven Stage'){
          git 'https://github.com/jaszhou/Watson.git'
            container('maven') {
            echo "Maven stage"
            //sleep(10000000)
            stage('Build a Maven project') {
                    //sh 'mvn -B clean install'
                    sh 'ls -ltr target'
                    sh 'cp target/blog-1.0-SNAPSHOT.jar .'
                    sh 'ls -ltr'
                }
                //sh "mvn -version"
            }
        }
        
         stage('Mongo Stage'){
          //git 'https://github.com/jaszhou/Watson.git'
             container('docker') {
              // docker run -d -p 3000:3000 mongoclient/mongoclient
                 sh 'docker run --rm -d --name mongo mongo:latest mongo'
             }
        }
      
        stage('Build Docker image') {
      
         git 'https://github.com/jaszhou/liberty.git'
         container('docker') {
         //sh "docker build -t ${image} ."
         sh 'docker version'
         sh 'ls -ltr'
         
         hub = "hub.docker.com"
                // set project name
                project_name = "jaszhou"
                echo "build Docker image"
                
             /*
                docker.withRegistry("https://registry.hub.docker.com", "DockerHub") {
                    
                    def customImage = docker.build("jaszhou/liberty:latest")
                    echo "推送镜像"
                    customImage.push()
                    //echo "删除镜像"
                    //sh "docker rmi ${hub}/${project_name}/${pom.artifactId}:${pom.version}" 
                }
             */
         
         }
    }
    
            stage('Deploy') {
                echo "6. Deploy Stage"
                //sh 'kubectl apply -f k8s.yaml'
                sh 'ls -l'
               // sh 'which kubectl'
            }
      
      post {
        always {
            sh 'docker stop mongo'
        }
    }
      
        
  }
}
