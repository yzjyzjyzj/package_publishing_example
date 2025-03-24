# Use an official Python runtime as a parent image.
FROM python:3.9-slim

LABEL authors="zijiang"

# Prevent Python from buffering stdout and stderr.
ENV PYTHONUNBUFFERED=1
# Disable uv-dynamic-versioning to avoid Git dependency during build.
ENV UV_DYNAMIC_VERSIONING_DISABLE=1

# Set the working directory in the container.
WORKDIR /app

# Copy the project files into the container.
COPY pyproject.toml .
COPY src/ ./src/
COPY tests/ ./tests/

# Update apt and install Git (optional, if needed for your build backend)
RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip and install build tool.
RUN pip install --upgrade pip && \
    pip install build

# Build the package (creates wheel and sdist in the dist/ folder) in editable mode.
RUN pip install -e .

# Optionally, run tests if you have a test suite.
RUN pip install pytest && pytest

# Define the default command to verify installation.
CMD ["python", "-c", "import package_publishing_example; print('Package installed successfully!')"]

