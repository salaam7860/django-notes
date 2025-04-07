FROM python:3.9

# Create a non-root user
RUN useradd -ms /bin/bash appuser
USER appuser

WORKDIR /app/backend

# Copy requirements.txt and install dependencies
COPY requirements.txt /app/backend
RUN pip install --user -r requirements.txt

# Copy application code
COPY . /app/backend

# Expose port 8000
EXPOSE 8000

# Set default command to run
CMD ["gunicorn", "--workers", "3", "--bind", "0.0.0.0:8000", "backend.wsgi:application"]
