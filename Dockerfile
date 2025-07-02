FROM node:22-alpine AS builder

WORKDIR /usr/src/app

COPY . .

RUN npm ci
RUN npm run build


FROM node:22-alpine AS final

WORKDIR /usr/src/app

COPY --from=builder ./usr/src/app .
COPY package.json .
COPY package-lock.json .

RUN npm ci --omit=dev

EXPOSE 8080
CMD [ "npm", "run", "start:prod" ]