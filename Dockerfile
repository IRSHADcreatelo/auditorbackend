# Use official Python image
FROM python:3.10-slim

# Set environment variables to avoid writing .pyc files and buffering logs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /app

# Copy dependency file and install
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the app code
COPY . .

# Default port Cloud Run uses
ENV PORT=8080

# Command to run the app using gunicorn (more production-ready than flask run)
CMD ["gunicorn", "--bind", ":$PORT", "main:app"]
