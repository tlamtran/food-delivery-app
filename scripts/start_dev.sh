#!/bin/bash

MONGO_CONTAINER_NAME="mongo"
MONGO_PORT=27017


# Check if the MongoDB container already exists
if [ $(docker ps -a -q -f name="^${MONGO_CONTAINER_NAME}$") ]; then
    echo "MongoDB container already exists."

    # Check if the container is not running, then start it
    if [ $(docker ps -q -f name="^${MONGO_CONTAINER_NAME}$") ]; then
        echo "MongoDB container is already running."
    else
        echo "Starting MongoDB container."
        docker start "$MONGO_CONTAINER_NAME"
    fi
else
    # Run a new MongoDB container
    echo "Creating and starting MongoDB container."
    docker run --name "$MONGO_CONTAINER_NAME" -d -p "${MONGO_PORT}:${MONGO_PORT}" mongo
fi


echo "Starting FastAPI application..."
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
