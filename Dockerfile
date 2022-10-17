FROM node:16-alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install
# No need to make use of volume system as we are 
# no longer developing our application
# We are not changing our code in production
COPY . . 
# build directory will be created in /app -> ./app/build
RUN npm run build


# Start of new block, last one is done
FROM nginx
# '--from=builder' - specifies that we want to copy 
# something from the builder phase
COPY --from=builder /app/build /usr/share/nginx/html