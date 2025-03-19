#!/bin/bash
echo "Building Sauco VM..."
cd $(dirname $0)
go build -o build/sauco ./cmd/sauco
echo "Build completed successfully!"
