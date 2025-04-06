FROM python:3.11

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Update pip
RUN pip install --upgrade pip

# Install reflex
RUN pip install reflex

# Create app directory
WORKDIR /workspace

# We'll install Python dependencies at runtime via requirements.txt
# This allows for faster rebuilds during development

# Set up a non-root user to use when the container is started
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Create a script to run the app
RUN echo '#!/bin/bash\nif [ -n "$OPENAI_API_KEY" ]; then\n  reflex run\nelse\n  echo "Warning: OPENAI_API_KEY is not set. The app may not function correctly."\n  echo "You can set it by running: export OPENAI_API_KEY=your-key-here"\n  reflex run\nfi' > /usr/local/bin/run-reflex-app \
    && chmod +x /usr/local/bin/run-reflex-app

# Switch back to dialog for any apt-get installations
ENV DEBIAN_FRONTEND=dialog