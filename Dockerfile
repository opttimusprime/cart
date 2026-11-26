# Base image
FROM node:24-alpine

# Set working directory
WORKDIR /app

# Set production environment
ENV NODE_ENV=production

# Copy dependency file first
COPY package.json ./

# Install production dependencies
RUN npm install --omit=dev && \
    npm cache clean --force

# Create a non-root user
RUN addgroup -S roboshop && \
    adduser -S roboshop -G roboshop

# Copy remaining application code and assign ownership
COPY --chown=roboshop:roboshop . .

# Switch to non-root user
USER roboshop

# Expose application port
EXPOSE 8080

# Start application
CMD ["node", "server.js"]