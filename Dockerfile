FROM node:alpine as builder

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm i -g @nestjs/cli

RUN npm ci --omit=dev

COPY . .

RUN npm run build

FROM node:alpine AS runner

WORKDIR /app

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules

CMD ["node", "dist/main"]

