# all below is referred to the build phase
FROM node:alpine AS builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine

# tell ElasticBeanstalk to listen on this port
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html