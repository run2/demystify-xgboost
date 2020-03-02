#!/bin/bash
sudo -H -u ml-user -- sh -c '. /home/ml-user/.bashrc ; \
cd ; pwd ; chown ml-user /ml-disk ; chgrp ml-user /ml-disk ; \
PATH=$PATH:/home/ml-user/.local/bin:/home/ml-user/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games; \
export PATH; jupyter lab &'
bash
