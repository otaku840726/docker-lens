# docker-lens
require privileged 
docker run --privileged -p 3000:3000 -v ~/lens-data:/config docker-lens:latest
