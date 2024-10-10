FROM node:14

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container
COPY . /app

# Install dependencies
RUN npm install

# Expose the application port (3000)
EXPOSE 3000

# Start the application
CMD ["node", "app.js"]
