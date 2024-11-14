FROM node:22

ARG API_BASE_URL
ENV API_BASE_URL=$API_BASE_URL


WORKDIR /app

COPY . .

RUN npm install

RUN npm run build

ENV NITRO_PORT=3000
ENV NITRO_HOST="0.0.0.0"

EXPOSE 3000

CMD ["npm", "run", "start"]

