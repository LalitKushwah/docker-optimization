# STAGE 1

FROM node:14-alpine as builder

WORKDIR /app

COPY package*.json ./

RUN yarn install

COPY . .

RUN npm run build

# STAGE 2

FROM node:14-alpine

RUN npm install -g serve

WORKDIR /app

COPY --from=builder /app/build .

EXPOSE 80

CMD ["serve", "-p", "80", "-s", "."]