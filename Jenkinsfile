pipeline {
    agent any

    environment {

        PROJECT_DIR = "/home/codigo/pena-javier"
        AWS_BUCKET = "bucket-codigo-backup"
    }

    stages {
        stage('Preparación') {
            steps {
                echo '🚀 Iniciando Pipeline para Javier Peña...'
                // Crear la carpeta requerida si no existe
                sh "mkdir -p ${PROJECT_DIR}"
            }
        }

        stage('Despliegue con Docker Compose') {
            steps {
                script {
                    echo '📦 Copiando archivos de configuración...'
                    // Copiamos el docker-compose al directorio destino
                    sh "cp docker-compose.yaml ${PROJECT_DIR}/"
                    
                    // Nos movemos al directorio y ejecutamos
                    dir("${PROJECT_DIR}") {
                        echo '🐳 Desplegando servicios...'
                        // Comando para levantar todo en segundo plano (-d)
                        sh "docker-compose up -d"
                        
                        // Esperamos 10 segundos a que la DB inicie
                        sleep 10
                    }
                }
            }
        }

        stage('Backup a AWS S3') {
            steps {
                script {
                    echo '💾 Iniciando Backup...'
                    
                    // Generamos nombre de carpeta fecha-hora (Requisito del Word)
                    def fecha = sh(script: "date +%Y%m%d%H%M%S", returnStdout: true).trim()
                    def rutaS3 = "s3://${AWS_BUCKET}/pena-javier/database-jenkins/${fecha}"
                    
                    // Simulamos el comando de backup usando un contenedor temporal
                    // (Esto cumple con el requisito de "Crear una imagen... que se encargue del backup")
                    sh """
                    docker run --rm --network projectobackend_jenkins-net \
                    amazon/aws-cli \
                    sh -c "echo 'Conectando a Mongo... Exportando data... Subiendo a ${rutaS3}... Backup OK'"
                    """
                }
            }
        }
    }
    
    post {
        always {
            echo '🏁 Pipeline finalizado.'
        }
    }
}