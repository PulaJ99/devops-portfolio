# Base image: official python image (slim keeps the image small)
FROM python:3.11-slim

# Setting the working directory
WORKDIR /app

# Copying the requirement file
COPY app/requirements.txt .

# Installing python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copying the application code
COPY app/ .

# Meta Data: Container listen on port 5000
EXPOSE 5000

# Running the application when container starts
CMD ["gunicorn","--bind", "0.0.0.0:5000","--workers", "2", "--timeout", "120", "--access-logfile","-","--error-logfile","-","app:app"]


