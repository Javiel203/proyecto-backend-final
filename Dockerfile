# Usamos una versión ligera de Node
FROM node:18-alpine

# Creamos el directorio de trabajo
WORKDIR /app

# 1. Instalamos dependencias del sistema necesarias
# (El cliente de mysql y postgres a veces requieren librerías extra,
# y necesitamos 'bash' para tu script .sh)
RUN apk add --no-cache bash

# 2. Copiamos los archivos de definición de paquetes
COPY package*.json ./

# 3. Instalamos las dependencias de Node
RUN npm install

# 4. Copiamos TODO el código fuente 
COPY . .

# 5. Damos permisos de ejecución al script (por si acaso se necesite)
RUN chmod +x ./script/initdb.sh

# 6. Exponemos el puerto
EXPOSE 3000

# 7. Comando de arranque
CMD ["npm", "start"]