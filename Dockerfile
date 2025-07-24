# # Build Stage
# FROM node:22-alpine
# WORKDIR /app
# COPY package*.json ./
# RUN npm install
# COPY . .
# RUN npm run build
 
# # Production Stage
# # FROM nginx:stable-alpine AS production
# # COPY --from=build /app/build /usr/share/nginx/html
# # EXPOSE 80
# # CMD ["nginx", "-g", "daemon off;"]


# FROM nginx:stable-alpine AS production 
# COPY --from=builder /app/dist /usr/share/nginx/html 
# COPY nginx.conf /etc/nginx/conf.d/default.conf 
# EXPOSE 80 
# CMD ["nginx", "-g", "daemon off;"]


# Build stage
FROM node:22-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM nginx:stable-alpine AS production
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/  
# Explicitly copy root index.html if needed
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]