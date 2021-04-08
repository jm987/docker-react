FROM node:alpine
WORKDIR '/app'
RUN chown -R node:node /app
USER node
COPY --chown=node:node ./package.json .
RUN npm install
COPY --chown=node:node ./ ./
RUN npm run build

USER root
FROM nginx
COPY --from=0 /app/build /usr/share/nginx/html