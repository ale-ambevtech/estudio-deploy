# Para o backend
docker buildx build --platform linux/arm/v8,linux/arm64,linux/amd64 \
  -t localhost:5000/estudio-backend:latest \
  --push .

# Para o frontend
docker buildx build --platform linux/arm/v8,linux/arm64,linux/amd64 \
  -t localhost:5000/estudio-frontend:latest \
  --push .
  