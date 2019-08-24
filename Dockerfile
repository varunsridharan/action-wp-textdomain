FROM composer:1

RUN git config --global user.email "githubactionbot+wp@gmail.com" && git config --global user.name "WP Textdomain Github Bot"

COPY entrypoint.sh /entrypoint.sh
COPY add-textdomain.php /add-textdomain.php

RUN chmod +x /entrypoint.sh
RUN chmod +x /add-textdomain.php

ENTRYPOINT ["/entrypoint.sh"]