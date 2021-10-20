# CDN

## Goal
Ability to deploy static site - `frontend-app` on a Content Delivery Network (CDN)

## Base Infrastructure

1. AWS CDN - to deliver static site
2. S3 Bucket - to host static site raw content
3. Roles/Permissions - to allow CI/CD pipeline to post static content to S3

## CI/CD Using GitHub Actions

1. Workflow to build & test static site code regularly
    - Build code on pull requests from feature branches
2. Workflow to deploy static site to development environments
    - Build code on merges to development branch & deploy to development environment
3. Workflow to deploy static site to production environments
    - Deploy code to production environment on releasing new stable version
    - Rollback to previous version if deployment fails
4. [Optional] Workflow to deploy arbitrary version of the static site to production

## CDN Cache Invalidation

Build a pipeline to detect static content that was modified and invalidate it from CDN cache.