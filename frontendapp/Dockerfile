# Step 1 - Build step from the multistep Dockerfile
FROM node:alpine as builder

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

# Step 2 - Run the application built on the first step
FROM nginx
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html