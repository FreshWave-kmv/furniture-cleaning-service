FROM node:24.8-alpine3.22 AS base
WORKDIR /app
COPY package*.json ./
EXPOSE 3000


FROM base AS build
WORKDIR /app
RUN npm install
COPY . .
RUN npm run build


FROM base AS production
WORKDIR /app
ENV NODE_ENV=production
RUN npm ci
COPY --from=build /app/.next ./.next
COPY --from=build /app/package.json ./package.json
COPY --from=build /app/public ./public

CMD ["npm", "start"]
