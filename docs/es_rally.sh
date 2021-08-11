## esrally docker 使用。


# https://www.elastic.co/guide/en/elasticsearch/reference/6.8/zip-targz.html

# https://esrally.readthedocs.io/en/2.2.1/adding_tracks.html
#   --cpu-cpus 0 --cpu-quota=50000 --cpu-period=50000 -c 2048 \

docker run -it --rm --name $(/usr/bin/uuid)  \
  -m 2048m --memory-reservation 1024m \
  -v  /srv/docker/rally:/rally \
  registry.cn-beijing.aliyuncs.com/bdpapp/esrally:2.2.1 \
  list cars

  docker run -it --rm --name $(/usr/bin/uuid)  \
  -m 2048m --memory-reservation 1024m \
  -v  /srv/docker/rally:/rally \
  registry.cn-beijing.aliyuncs.com/bdpapp/esrally:2.2.1 \
  --offline --pipeline=benchmark-only --target-hosts=127.0.0.1:9200 --track=geoip --challenge=append-fast-no-conflicts
esrally --pipeline=benchmark-only