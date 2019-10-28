############ build stage ###############
FROM node:10-stretch as Wiki-okr

RUN npm install -g gitbook-cli 

COPY ./ /code

RUN cd /code && \
    gitbook install ./ && \
    gitbook build && \
    mv ./_book/ /prod 
    

######## production stage ############
FROM nginx:mainline-alpine

RUN rm /etc/nginx/conf.d/*

ADD nginx.conf /etc/nginx/conf.d/

COPY --from=Wiki-okr /prod/ /etc/nginx/html/okr/

