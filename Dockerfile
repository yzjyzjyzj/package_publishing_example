# Use an official Python runtime as a parent image.
FROM python:3.9-slim

LABEL authors="zijiang"

# Prevent Python from buffering stdout and stderr.
ENV PYTHONUNBUFFERED=1

# Set the working directory in the container.
WORKDIR /app

# Copy the project files into the container.
# Adjust file paths as necessary for your repository structure.
COPY pyproject.toml .
COPY src/ ./src/
COPY tests/ ./tests/

# Upgrade pip and install build tool.
RUN pip install --upgrade pip
RUN pip install build

# Build the package (creates wheel and sdist in the dist/ folder).
RUN python -m build

# Install the package from the built wheel.
RUN pip install $(ls dist/*.whl)

# Optionally, run tests here if you have a test suite.
# RUN pip install pytest && pytest

# Define the default command to verify installation.
# Replace with your application's start command if needed.
CMD ["python", "-c", "import package_publishing_example; print('Package installed successfully!')"]