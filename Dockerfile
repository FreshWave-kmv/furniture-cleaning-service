FROM node:24.8-alpine3.22 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:24.8-alpine3.22
WORKDIR /app

COPY --from=build /app ./
# COPY --from=build /app/.next ./.next
# COPY --from=build /app/public ./public
# COPY --from=build /app/package*.json ./
# COPY --from=build /app/next.config.ts ./

EXPOSE 3000
CMD ["npm", "run", "start"]