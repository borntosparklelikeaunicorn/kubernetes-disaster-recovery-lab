# Kubernetes Disaster Recovery Lab

A pet project for backing up and restoring Kubernetes
applications using Velero, MinIO and PostgreSQL.

## Technologies

- Kubernetes (kind)
- Docker
- PostgreSQL
- MinIO
- Velero
- Python
- Bash

## Project Goals

1. Deploy a local Kubernetes cluster.
2. Deploy PostgreSQL with persistent storage.
3. Configure S3-compatible storage using MinIO.
4. Configure Velero backups.
5. Restore the application into a new namespace.
6. Verify PostgreSQL data integrity.
7. Test failure and recovery scenarios.

## Status

In development.