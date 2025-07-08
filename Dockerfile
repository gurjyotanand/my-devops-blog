# Stage 1: Build the Hugo site
FROM hugomods/hugo:exts-0.118.2 AS build
WORKDIR /app
COPY . .
RUN npm install --ignore-scripts  # Only if your theme requires it
RUN hugo --minify

# Stage 2: Serve with Nginx high-performance web server
FROM nginx:alpine
COPY --from=build /app/public /usr/share/nginx/html

# Copy custom nginx config that handles both HTTP and HTTPS
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]