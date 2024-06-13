Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E87C27C75
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 09:29:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.4100.1718270956876207732
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 02:29:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 45D9TDQX2481057; Thu, 13 Jun 2024 18:29:13 +0900
X-Iguazu-Qid: 2rWh7TpbACNFpy5660
X-Iguazu-QSIG: v=2; s=0; t=1718270952; q=2rWh7TpbACNFpy5660; m=XKvILf9POwAwZbd48AZkELhy9RBST/fa4OqmyFNp+1o=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 45D9TB11130179
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 18:29:12 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, adithya.balakumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1] doc/README.swupdate.md: Minor updates to verification steps and additional information on usage of zchunk handler
Date: Thu, 13 Jun 2024 14:58:57 +0530
X-TSB-HOP2: ON
Message-Id: <20240613092857.354965-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 13 Jun 2024 09:29:09.0951 (UTC) FILETIME=[253DBCF0:01DABD74]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jun 2024 09:29:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16199

This change includes some additional information regarding delta(zchunk)
handler in swupdate. Also removed command "cat /sys/kernel/realtime" in the
rt-kernel section since its no longer available in current rt-kernel image.

This resolves most of the remarks mentioned in #106

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 doc/README.swupdate.md | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index 8b03422..a5fbab9 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -208,8 +208,6 @@ root@demo:~# uname -a
 Linux demo 4.19.233-cip69-rt24 #1 SMP PREEMPT RT Tue Apr 12 09:23:51 UTC 2022 x86_64 GNU/Linux
 root@demo:~# ls /lib/modules
 4.19.233-cip69-rt24
-root@demo:~# cat /sys/kernel/realtime
-1
 ```
 
 Now apply swupdate and reboot
@@ -217,6 +215,7 @@ Now apply swupdate and reboot
 root@demo:~# swupdate -i cip-core-image-cip-core-bullseye-qemu-amd64.swu
 root@demo:~# reboot
 ```
+Use the `-v` flag when running swupdate for verbose logs of any errors.
 
 Check which partition is booted, e.g. with lsblk and the rootfs should have changed
 ```
@@ -384,7 +383,7 @@ First build an image using the following command:
 ```
 host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/rt.yml
 ```
-The above image will be used as the base image to which the update is applied.
+The image is built with the RT kernel just so that there are some differences between the two images used. The above image will be used as the base image to which the update is applied.
 
 ## Delta Software Update using rdiff_image handler
 
@@ -413,7 +412,10 @@ host$ scp -P 22222 ./cip-core-image-cip-core-bookworm-qemu-amd64.swu root@localh
 
 ## Delta Software Update using zchunk handler
 
-Currently zchunk based delta updates are supported only in Sid images. Make sure to build the first image with Sid as the distribution (use `sid.yml` file as part of the build command).
+Currently zchunk based delta updates are supported only in Sid images. Make sure to build the first image with Sid as the distribution with the following command:
+```
+host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/sid.yml
+```
 For Delta update with zchunk, set the variable `DELTA_ZCK_URL` with the URL of the zck file that is hosted in a http server and set the `DELTA_UPDATE_TYPE` to `zchunk` in `delta-update.yml` file.
 
 Build the second image with the modification as shown above with the following command:
@@ -430,6 +432,7 @@ host$ cd build-v2/tmp/deploy/images/qemu-amd64/
 host$ scp -P 22222 ./cip-core-image-cip-core-sid-qemu-amd64.swu root@localhost:
 ```
 The `cip-core-image-cip-core-sid-qemu-amd64.zck` file must be hosted in a http server.
+Any http server (service) can be used to host the .zck file as long as the http server supports http range requests. Copy the `build-v2/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-sid-qemu-amd64.zck` to the server directory. For more information on the integration of zchunk handler in swupdate, refer the [documentation](https://sbabic.github.io/swupdate/delta-update.html#integration-in-swupdate-the-delta-handler)
 
 ## Delta Software Update Verification
 
-- 
2.39.2



