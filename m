Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE1FC433F5
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 12:56:00 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web08.11233.1642683359124317340
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jan 2022 04:55:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=yNHwcy6y;
 spf=pass (domain: miraclelinux.com, ip: 209.85.215.169,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pg1-f169.google.com with SMTP id e9so1755941pgn.4
        for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jan 2022 04:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RRYhDsiQqxp8TXb60neak8ciHC84xt/O57ONpJQOLQo=;
        b=yNHwcy6yYye3kkIXU409ioVgZymkFiJFGXLD4qIKRq37W7JhYU0rVxSWigALdRW6SP
         lFMXqWUzAbKEloBRtP/Q/+CgBGcTv3jUjve7rbMT4WIeNbt/NFoeGkLy0nCXLOjSb+EO
         5U0VuJbtCDx6L3GQoFByejjDXxIzqZGmpdAjlyCZuvSX9M+7NYkDfQpvKn1zpAIYGqMD
         8u0PqNGz+n8AihMg/DufBWXlXYXl5/afl+vWd0H5DqiVSwjx5TrKvlfFpmkdXJecYaRB
         GfNMgRIbIb8fgYmzpVa6IljF/5LxvMjO3igK0heN+ca/zDpbn5tfyNDFFpKAZRXrkZnY
         yXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRYhDsiQqxp8TXb60neak8ciHC84xt/O57ONpJQOLQo=;
        b=NE+LxLDKIFXGIyj/xruf3jQtLgP9bpXHS58g8gJ24OF3f3p69eFpm5dJZZzKl9cI7D
         rFoyjR6fQeqivvDX4cNymTIwlbJw2VhlXraqsg/4MdfzS8kReHE4lyuzvEa3itHN8P0D
         KJVZCPoUunT4yQT6kMkecPZkgE1VwQ8hFa6Y1RcqDLlPJKwweFLAtQEtNnyfQT46UDCW
         UqdgFYAddSTMA0XaoBKIU06SIweh3pYGvHRIaN6snISu1ZbATME++VpUMtY3oC4SgNYK
         LO6yJTSWfMfi2mxjY4Zugd78EaI8/kYZYecROWmN8m0irguQ5kfKuloSe8cjxz1reabS
         Dbug==
X-Gm-Message-State: AOAM5315CUMd3qPCNsYHeITZnH/gHvsfb//Tzcajb9XNtHYJ+17Np6Uc
	B7hyRl4XKpBpWe6S3IcJT9X5EMbbbHWo
X-Google-Smtp-Source: 
 ABdhPJwBIrV+O7lvRdIzA6mDVJMlbYMZXqBr5UEGtZS8oXBHsR23ZGJoVLpPz1y3hZ5JDuDh6H07dg==
X-Received: by 2002:aa7:81cf:0:b0:4c0:6242:c14e with SMTP id
 c15-20020aa781cf000000b004c06242c14emr35383167pfn.83.1642683358564;
        Thu, 20 Jan 2022 04:55:58 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 n11sm9975634pjf.29.2022.01.20.04.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 04:55:57 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH v2 3/4] Add script deploy-kernelci.py for
 upload the cip-core-image-kernelci
Date: Thu, 20 Jan 2022 21:54:17 +0900
Message-Id: <20220120125418.236990-4-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120125418.236990-1-alice.ferrazzi@miraclelinux.com>
References: <20220120125418.236990-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jan 2022 12:56:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7475

The cip-core-image-kernelci need to be uploaded to the KernelCI
production storage for been used by KernelCI.
This script use the KernelCI API for uploading the
cip-core-image-kernelci to the production storage.
The images are uploaded in the following link:
https://storage.kernelci.org/images/rootfs/cip/

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
---
 scripts/deploy-kernelci.py | 55 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100755 scripts/deploy-kernelci.py

diff --git a/scripts/deploy-kernelci.py b/scripts/deploy-kernelci.py
new file mode 100755
index 0000000..5a8adca
--- /dev/null
+++ b/scripts/deploy-kernelci.py
@@ -0,0 +1,55 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+
+import subprocess
+import requests
+import os
+import sys
+import time
+from urllib.parse import urljoin
+
+cdate=time.strftime("%Y%m%d")
+api="https://api.kernelci.org/upload"
+token=os.getenv("KERNELCI_TOKEN")
+
+release=sys.argv[1]
+target=sys.argv[2]
+extension=sys.argv[3]
+
+rootfs_filename="cip-core-image-kernelci-cip-core-"+release+"-"+target+".tar.gz"
+initrd_filename="cip-core-image-kernelci-cip-core-"+release+"-"+target+"-initrd.img"
+initrd_gz_filename="cip-core-image-kernelci-cip-core-"+release+"-"+target+"-initrd.img.gz"
+
+input_dir="build/tmp/deploy/images/"+target
+upload_path="/images/rootfs/cip/"+cdate+"/"+target+"/"
+upload_path_latest="/images/rootfs/cip/latest/"+target+"/"
+rootfs=input_dir+"/"+rootfs_filename
+initrd=input_dir+"/"+initrd_filename
+
+def upload_file(api, token, path, input_file, input_filename):
+    headers = {
+        'Authorization': token,
+    }
+    data = {
+        'path': path,
+    }
+    files = {
+        'file': (input_filename, open(input_file, 'rb').read()),
+    }
+    url = urljoin(api, 'upload')
+    resp = requests.post(url, headers=headers, data=data, files=files)
+    resp.raise_for_status()
+
+if os.path.exists(rootfs) and os.path.exists(initrd):
+    print("uploading rootfs to KernelCI")
+    upload_file(api, token, upload_path, rootfs, rootfs_filename)
+    print("uploading initrd to KernelCI")
+    upload_file(api, token, upload_path, initrd, initrd_gz_filename)
+    print("uploaded to: https://storage.kernelci.org"+upload_path)
+
+    # Upload latest
+    print("uploading rootfs to KernelCI CIP latest")
+    upload_file(api, token, upload_path_latest, rootfs, rootfs_filename)
+    print("uploading initrd to KernelCI CIP latest")
+    upload_file(api, token, upload_path_latest, initrd, initrd_gz_filename)
+    print("uploaded to: https://storage.kernelci.org"+upload_path_latest)
-- 
2.33.1


