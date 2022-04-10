FROM servercontainers/samba AS samba_classic

#RUN apk del samba \
#	&& apk add --no-cache "samba=4.10.18-r0" \
#		--repository=https://dl-cdn.alpinelinux.org/alpine/v3.10/main

COPY ./nmbd /container/config/runit/nmbd

RUN chmod +x /container/config/runit/nmbd/run
		
EXPOSE 137/udp
EXPOSE 138/udp

CMD [ "runsvdir","-P", "/container/config/runit" ]
