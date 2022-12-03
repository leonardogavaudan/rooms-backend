FROM node:14-alpine

# Create app directory
WORKDIR /app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package*.json ./

RUN yarn

# Bundle app source
COPY . .

EXPOSE 3000
CMD [ "yarn", "start" ]
