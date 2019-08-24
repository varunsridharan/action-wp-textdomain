FROM composer:1

COPY entrypoint.sh /entrypoint.sh
COPY add-textdomain.php /add-textdomain.php

RUN chmod +x /entrypoint.sh
RUN chmod +x /add-textdomain.php

ENTRYPOINT ["/entrypoint.sh"]