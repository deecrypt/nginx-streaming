## Nginx Streaming supporting HLS & DASH
Dockerfile for Nginx Streaming

#### Buid the docker from Dockerfile
```
docker build --no-cache -t nginx-streaming .
```
#### Launch the Nginx Streaming container
```
docker run -p 80:80 -p 1935:1935 -d nginx-streaming 
```
#### RTMP endpoint example on localhost
```
rtmp://localhost/live/stream
```
#### HLS URL for the above RTMP endpoint
```
http://localhost/hls/stream.m3u8
```
#### DASH URL for the above RTMP endpoint
```
http://localhost/dash/stream.mpd
```
