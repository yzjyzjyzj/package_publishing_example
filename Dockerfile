# Use an official Python runtime as a parent image.
FROM python:3.9-slim

LABEL authors="zijiang"

# Prevent Python from buffering stdout and stderr.
ENV PYTHONUNBUFFERED=1

# Set a fallback version for uv-dynamic-versioning
ENV UV_DYNAMIC_VERSIONING_FALLBACK_VERSION=0.1.0

# Set the working directory in the container.
WORKDIR /app

# Copy the project files into the container.
# Adjust file paths as necessary for your repository structure.
COPY pyproject.toml .
COPY src/ ./src/
COPY tests/ ./tests/
COPY .git/ .
# Upgrade pip and install build tool.
RUN apt-get update && \
    apt-get install -y git && \
    pip install --upgrade pip && \
    pip install build

# Build the package (creates wheel and sdist in the dist/ folder).
RUN pip install -e .

# Optionally, run tests here if you have a test suite.
RUN pip install pytest && pytest

# Define the default command to verify installation.
# Replace with your application's start command if needed.
CMD ["python", "-c", "import package_publishing_example; print('Package installed successfully!')"]
