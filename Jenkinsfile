

podTemplate(label: 'jnlp-slave', // See 1
  containers: [
     
    containerTemplate(
      name: 'jnlp',
      //image: 'jenkinsci/jnlp-slave:3.10-1-alpine',        
      image: 'jenkins/jnlp-slave:3.35-5-alpine',
      args: '${computer.jnlpmac} ${computer.name}'
    ), 
   
       containerTemplate(
      name: 'docker',
      image: 'docker:1.11',
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
   
  ],
  volumes: [ // See 2
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'), // See 3
    //hostPathVolume(mountPath: '/root/.m2', hostPath: '/Users/jasonx/Downloads/acs/jenkins'),
  ]
)
{
  node ('jnlp-slave') {
        
    
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
    

        
  }
}
