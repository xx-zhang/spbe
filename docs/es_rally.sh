## esrally docker 使用。


# https://www.elastic.co/guide/en/elasticsearch/reference/6.8/zip-targz.html
# https://esrally.readthedocs.io/en/2.2.1/adding_tracks.html
#   --cpu-cpus 0 --cpu-quota=50000 --cpu-period=50000 -c 2048 \

docker run -it --rm  \
  -m 2048m --memory-reservation 1024m \
  -v  /srv/docker/rally:/rally \
  registry.cn-beijing.aliyuncs.com/bdpapp/esrally:2.2.1 \
  list races

docker run -it --rm  \
  -m 2048m --memory-reservation 1024m \
  -v  /srv/docker/rally:/rally \
  registry.cn-beijing.aliyuncs.com/bdpapp/esrally:2.2.1 \
  --offline --pipeline=benchmark-only --target-hosts=127.0.0.1:9200 \
  --track=geoip \
  --challenge=append-fast-no-conflicts
  --pipeline=benchmark-only


## 创建 tracks
docker run -it --rm  \
  -m 2048m --memory-reservation 1024m \
  -v  /srv/docker/rally:/rally \
  registry.cn-beijing.aliyuncs.com/bdpapp/esrally:2.2.1 \
  create-track \
  --track=topsa \
  --target-hosts=10.27.106.159:18400 \
  --indices="log_20210630,event_20210630" \
  --output-path=/rally/.rally/benchmarks/tracks

# esrally - 创建track

esrally create-track --track=acme \
  --target-hosts=abcdef123.us-central-1.gcp.cloud.es.io:9243 \
  --client-options="timeout:60,use_ssl:true,verify_certs:true,basic_auth_user:'elastic',basic_auth_password:'secret-password'" \
  --indices="products,companies" --output-path=~/tracks