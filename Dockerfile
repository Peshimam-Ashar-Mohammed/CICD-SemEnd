# ---------- Stage 1: Build the frontend ----------
FROM node:18-alpine AS build
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy full project and build it
COPY . .
RUN npm run build

# ---------- Stage 2: Serve using Nginx ----------
FROM nginx:stable-alpine

# Copy build output to Nginx HTML directory
COPY --from=build /app/dist /usr/share/nginx/html

# If your build folder is "build" instead of "dist", use this:
# COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
