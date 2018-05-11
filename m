From: gitlab@mg.gitlab.com (Robert Marshall)
Date: Fri, 11 May 2018 16:36:09 +0000
Subject: [cip-dev]
 [Git][cip-project/cip-testing/board-at-desk-single-dev][master] 2 commits:
 Change necessary now that LAVA has moved to python 3 #184
Message-ID: <5af5c679b57d9_7c9b3fcc1bec8e6c86311@sidekiq-asap-05.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Robert Marshall pushed to branch master at cip-project / cip-testing / board-at-desk-single-dev


Commits:
304b6d65 by Robert Marshall at 2018-05-09T12:46:03Z
Change necessary now that LAVA has moved to python 3 #184

The change to the shutdown message does not appear to be necessary.

- - - - -
42e332d7 by Robert Marshall at 2018-05-11T16:36:04Z
Merge branch &#39;lava2018.4change&#39; into &#39;master&#39;

Change necessary now that LAVA has moved to python 3 #184

See merge request cip-project/cip-testing/board-at-desk-single-dev!59
- - - - -


1 changed file:

- integration-scripts/configure_lava.sh


Changes:

=====================================
integration-scripts/configure_lava.sh
=====================================
--- a/integration-scripts/configure_lava.sh
+++ b/integration-scripts/configure_lava.sh
@@ -62,9 +62,4 @@ cp -v /vagrant/device-dictionary/myiwg20m.jinja2 ~/myrenesas.dat
 sudo DEBIAN_FRONTEND=noninteractive chown lavaserver.lavaserver /etc/lava-server/dispatcher-config/devices/*
 sudo DEBIAN_FRONTEND=noninteractive chown lavaserver.lavaserver /etc/lava-server/dispatcher-config/device-types/*
 
-# Change the default shutdown message for kernel v4.4 - comment these lines out if using older kernel with a Shutdown message of "The system is going down for reboot NOW"
-cd /usr/lib/python2.7/dist-packages/lava_dispatcher/pipeline/utils/
-sudo DEBIAN_FRONTEND=noninteractive sed -ie "/SHUTDOWN_MESSAGE/s/The system is going down for reboot NOW/Restarting system/" constants.py
-cd ~
-
 echo "END: configure_lava.sh"



View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/4dbfc937754626b0284a8e307cd3ca2048a2f5a7...42e332d726083b8ccca95d783f9c0fd1c7af9bcf

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/compare/4dbfc937754626b0284a8e307cd3ca2048a2f5a7...42e332d726083b8ccca95d783f9c0fd1c7af9bcf
You're receiving this email because of your account on gitlab.com.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180511/22afe064/attachment.html>
