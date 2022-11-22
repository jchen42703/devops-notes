# Toy Frontend

1. Build toy frontend that interacts with the toy backend.
2. Create Dockerfile.
3. Build and upload image to Docker Hub
   ```bash
   # in /client
   docker build -t jchen42703/go-react-k8s-client:latest -f Dockerfile .
   docker push jchen42703/go-react-k8s-client:latest
   ```
