FROM python:3.9

# Create a non-root user
RUN useradd -ms /bin/bash appuser

WORKDIR /app/backend

# Copy requirements.txt and install dependencies
COPY requirements.txt /app/backend

# Switch to root user to modify /etc/resolv.conf
USER root
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

# Switch back to appuser
USER appuser

# Update pip
RUN pip install --user --no-cache-dir --upgrade pip

# Install dependencies
RUN pip install --user --no-cache-dir -r requirements.txt

# Add scripts to PATH
ENV PATH="/home/appuser/.local/bin:${PATH}"

# Copy application code
COPY . /app/backend

# Expose port 8000
EXPOSE 8000

# Set default command to run
CMD ["gunicorn", "--workers", "3", "--bind", "0.0.0.0:8000", "backend.wsgi:application"]
