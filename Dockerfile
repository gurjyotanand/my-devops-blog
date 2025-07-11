# Stage 1: Build the Hugo site
FROM hugomods/hugo:exts-0.147.9 AS build
WORKDIR /app
COPY . .
RUN npm install --ignore-scripts  # Only if your theme requires it
RUN hugo --minify

# Stage 2: Serve with Nginx high-performance web server
FROM nginx:alpine
COPY --from=build /app/public /usr/share/nginx/html

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
