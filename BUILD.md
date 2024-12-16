# Para o backend
```bash
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v8 \
  -t localhost:5000/estudio-backend:latest \
  --push \
  --file $(if [ "$(uname -m)" = "x86_64" ]; then echo Dockerfile; else echo Dockerfile.arm64v8; fi) .
```

# Para o frontend
```bash
docker buildx build --platform linux/arm/v8,linux/arm64,linux/amd64 \
  -t localhost:5000/estudio-frontend:latest \
  --push .
```
