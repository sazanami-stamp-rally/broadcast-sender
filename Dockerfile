FROM node:22

WORKDIR /app

COPY . .

RUN npm install

RUN npm run build

ENV NITRO_PORT=3000
ENV NITRO_HOST="0.0.0.0"

CMD ["npm", "run", "start"]

