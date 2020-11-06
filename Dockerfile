FROM varunsridharan/actions-alpine-php:latest

COPY entrypoint.sh /entrypoint.sh

COPY add-textdomain.php /add-textdomain.php

RUN chmod 777 /entrypoint.sh

RUN chmod 777 /add-textdomain.php

ENTRYPOINT ["/entrypoint.sh"]