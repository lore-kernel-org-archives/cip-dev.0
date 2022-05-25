Return-Path: <hannah.kiekens@essensium.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE76C433F5
	for <webhook@archiver.kernel.org>; Wed, 25 May 2022 09:20:35 +0000 (UTC)
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by mx.groups.io with SMTP id smtpd.web08.4753.1653470427133184779
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 May 2022 02:20:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@essensium.com header.s=google header.b=fDR7dw5d;
 spf=pass (domain: essensium.com, ip: 209.85.218.67,
 mailfrom: hannah.kiekens@essensium.com)
Received: by mail-ej1-f67.google.com with SMTP id i27so40393261ejd.9
        for <cip-dev@lists.cip-project.org>;
 Wed, 25 May 2022 02:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Se1hCPOc4+tXfMkBRsxq5mE5mDxa2qwInoi80Bq5Kxc=;
        b=fDR7dw5d45BJZiKhPL+vQla4FZ2q1HJyzMKRH1xdYWz5zFw6/z/UdDDYflmSlmHEz1
         g1jlJ7JcEH/Ip4f1iiZq/n+heyViBB4dJfvz4mBIM43d2XIuZLozQqDtqapc+Xa4FbOO
         UB+v/Qf6tEf/OrGbZnZi8P3/r3ca8Uz6CqZdsRDGz9os4n289+s2v63zMn13nHAnvJKp
         sP5RnEgJBAcH71Pqi9/rDqPBIYLd5fuZppyQ2xlsW5GpTdc+mMSMjJRbq3ZSh3ZfnfKw
         +QGsH1EMh57VdLQfS6tqv7AgJ9hcMJcoysckWKAtmY5kzzwuIQgwAIx3skfJzkWZvU2K
         jPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Se1hCPOc4+tXfMkBRsxq5mE5mDxa2qwInoi80Bq5Kxc=;
        b=EU/lJuQAgDyaRK3TGy0mL77lqK7r+6TuMb839V1uxAdictqaWVn+6KgqlwtGhSX7xn
         XVKRcQf9eORtwwedYRSQQIzod3KR40SR6qZa6RD1XiGmLFrUP++TzUZpc4jqgigS8VFt
         +VHWNuC/Qf5VWdPsp6ruQ7JJE9LkyOOOeGXLcDSvVKh5pgMKm557gYTpEQ7T5NQU2x1E
         txdlbjG7lBk0NmMkv2mapSYn/aVErkhMkDYjmojl0vv2sG/AtfmHjz/FXSpzFAAwPMK4
         lR5gZurbR5+jL8wQFUxbX1IJZQfMvLEnf9G1ivZgiZX5evvGJYyqCSiB+o4MlIV0Iyvs
         CntQ==
X-Gm-Message-State: AOAM531Ub0j1ODX3595yJLcoWXYU/0qplc93tF1Xo3ZTBjxmfMyKpl7N
	6+5qC8R7r6xKPb79y1y13TGc32eRVjZ7h9vr
X-Google-Smtp-Source: 
 ABdhPJxQ4k4jKoRETx2ghuNRLuzlfV+9PsoTvb2vryGp4eUNGAUQlbj8iXjxfAl/VbmwAneFu1ylYQ==
X-Received: by 2002:a17:907:7b9e:b0:6fe:d8df:d1e7 with SMTP id
 ne30-20020a1709077b9e00b006fed8dfd1e7mr13863693ejc.225.1653470425206;
        Wed, 25 May 2022 02:20:25 -0700 (PDT)
Received: from werkhannah.. (d8D87D23B.access.telenet.be. [141.135.210.59])
        by smtp.gmail.com with ESMTPSA id
 fu7-20020a170907b00700b006fed062c68esm3398208ejc.182.2022.05.25.02.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 02:20:24 -0700 (PDT)
From: Hannah Kiekens <hannah.kiekens@essensium.com>
To: cip-dev@lists.cip-project.org
Cc: Hannah Kiekens <hannah.kiekens@essensium.com>
Subject: [isar-cip-core][PATCH] Update README.swupdate.md for bullseye & 5.10
Date: Wed, 25 May 2022 11:20:17 +0200
Message-Id: <20220525092017.445653-1-hannah.kiekens@essensium.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 May 2022 09:20:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8436

Signed-off-by: Hannah Kiekens <hannah.kiekens@essensium.com>
---
 doc/README.swupdate.md | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index e28db24..ab957f1 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -13,13 +13,13 @@ host$ git clone https://gitlab.com/cip-project/cip-core/isar-cip-core.git
 Set up `kas-container` as described in the [top-level README](../README.md).
 Then build the image which will later serve as update package:
 ```
-host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
+host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/5.10.yml:kas/opt/bullseye.yml:kas/opt/ebg-swu.yml
 ```
-Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-buster-qemu-amd64.swu` into a separate folder (ex: /tmp).
+Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-bullseye-qemu-amd64.swu` into a separate folder (ex: /tmp).
 
 Next, rebuild the image, switching to the RT kernel as modification:
 ```
-host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/rt.yml
+host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/5.10.yml:kas/opt/bullseye.yml:kas/opt/ebg-swu.yml:kas/opt/rt.yml
 ```
 
 Now start the image which will contain the RT kernel:
@@ -27,9 +27,9 @@ Now start the image which will contain the RT kernel:
 host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
 ```
 
-Copy `cip-core-image-cip-core-buster-qemu-amd64.swu` file from `tmp` folder into the running system:
+Copy `cip-core-image-cip-core-bullseye-qemu-amd64.swu` file from `tmp` folder into the running system:
 ```
-host$ scp -P 22222 /tmp/cip-core-image-cip-core-buster-qemu-amd64.swu root@localhost:
+host$ scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@localhost:~
 ```
 
 Check which partition is booted, e.g. with lsblk:
@@ -47,16 +47,16 @@ sda      8:0    0    2G  0 disk
 Also check that you are running the RT kernel:
 ```
 root@demo:~# uname -a
-Linux demo 4.19.233-cip69-rt24 #1 SMP PREEMPT RT Tue Apr 12 09:23:51 UTC 2022 x86_64 GNU/Linux
+Linux demo 5.10.109-cip5-rt4 #1 SMP PREEMPT_RT Wed May 25 08:02:24 UTC 2022 x86_64 GNU/Linux
 root@demo:~# ls /lib/modules
-4.19.233-cip69-rt24
+5.10.109-cip5-rt4
 root@demo:~# cat /sys/kernel/realtime
 1
 ```
 
 Now apply swupdate and reboot
 ```
-root@demo:~# swupdate -i cip-core-image-cip-core-buster-qemu-amd64.swu
+root@demo:~# swupdate -i cip-core-image-cip-core-bullseye-qemu-amd64.swu
 root@demo:~# reboot
 ```
 
@@ -75,9 +75,9 @@ sda      8:0    0    2G  0 disk
 Check the active kernel:
 ```
 root@demo:~# uname -a
-Linux demo 4.19.235-cip70 #1 SMP Tue Apr 12 09:08:39 UTC 2022 x86_64 GNU/Linux
+Linux demo 5.10.115-cip7 #1 SMP Wed May 25 07:46:12 UTC 2022 x86_64 GNU/Linux
 root@demo:~# ls /lib/modules
-4.19.235-cip70
+5.10.115-cip7
 ```
 
 Check bootloader ustate after swupdate
@@ -121,12 +121,12 @@ root@demo:~# bg_setenv -c
 Build the image for swupdate with a service which causes kernel panic during system boot using below command:
 
 ```
-host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/kernel-panic.yml
+host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/5.10.yml:kas/opt/bullseye.yml:kas/opt/ebg-swu.yml:kas/opt/kernel-panic.yml
 ```
-Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-buster-qemu-amd64.swu` in a separate folder.
+Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-bullseye-qemu-amd64.swu` in a separate folder.
 Then build the image without `kernel-panic.yml` recipe using below command:
 ```
-host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
+host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/5.10.yml:kas/opt/bullseye.yml:kas/opt/ebg-swu.yml
 ```
 
 Start the target on QEMU:
@@ -134,14 +134,14 @@ Start the target on QEMU:
 host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
 ```
 
-Copy `cip-core-image-cip-core-buster-qemu-amd64.swu` file from `tmp` folder into the running system:
+Copy `cip-core-image-cip-core-bullseye-qemu-amd64.swu` file from `tmp` folder into the running system:
 ```
-host$ scp -P 22222 /tmp/cip-core-image-cip-core-buster-qemu-amd64.swu root@localhost:
+host$ scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@localhost:~
 ```
 
 Apply swupdate as below:
 ```
-root@demo:~# swupdate -i cip-core-image-cip-core-buster-qemu-amd64.swu
+root@demo:~# swupdate -i cip-core-image-cip-core-bullseye-qemu-amd64.swu
 ```
 
 Check bootloader ustate after swupdate. If the swupdate is successful then **revision number** should be **3** and status should be changed to **INSTALLED** for Partition #1.
-- 
2.36.1


