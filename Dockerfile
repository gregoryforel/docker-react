# BUILD PHASE
# We can tag this phase (or stage) with `as <STAGE>`
FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

RUN npm run build

# BUILD PHASE
FROM nginx
# This copies from the previous BUILD PHASE's build folder and dumps everything else.
COPY --from=builder /app/build /usr/share/nginx/html
# There is no cmd to run nginx needed. Running the container will run nginx
# Build this image with `docker build .`
# Launch with `docker run -p 8080:80 -t -d <CONTAINER_ID>` (note that nginx default port is 80)