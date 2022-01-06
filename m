Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224D7C433F5
	for <webhook@archiver.kernel.org>; Thu,  6 Jan 2022 11:17:18 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web10.7280.1641467836187794243
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jan 2022 03:17:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=tLox63eP;
 spf=pass (domain: miraclelinux.com, ip: 209.85.215.174,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pg1-f174.google.com with SMTP id i30so2317338pgl.0
        for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jan 2022 03:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RRYhDsiQqxp8TXb60neak8ciHC84xt/O57ONpJQOLQo=;
        b=tLox63ePH2gH1+U7X6Rn4c8wuESmvrB+6EbdoD9rhppBi5fheKfU9YFgIWqsHTNvJb
         yqTLI7XFqHKXrdaDi0VXqtiEQZ+NJL3x17ZxU7CaAGsvVwHdCPiErYRjFHDfr5df1fV4
         HfZksr3VotgirWzLnw5bUZNXvwlmLp6yENfnSzYkqcS5SiKIn9ZxeW+iieWUC3pLGUu3
         F5r+zmONSSKgG34MgcrJ5g2uaeBNssPFBQV4PoCwYusX7iEdQjw38dO+wFscuvRB0/I2
         nwNh3UWGd6qoIRud7M5+XPBg7ETHwdnO9JNDKzV/d6Jaz5FT6OT+6695TtQlh2ICegFs
         Eqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRYhDsiQqxp8TXb60neak8ciHC84xt/O57ONpJQOLQo=;
        b=esTl3BrjJ9c2vkldImVByAr54JIkx2aQa/I36RgTywct9y+NkUzLOzwkMHd+acpvtj
         6dEcuYqlnSj+rgJadUfNL2LSgxAHDKWbfj6LG04iM6IeabhwUtZa3GxUI/KNDisMHDiI
         4X7Wzq33g1coVsgTyfKQIf7EUfMy1jFJ8ZOcOgi3JMGdacl1Z4lMiMYcLxaPgcUix9Q9
         SsrFQYM0rGdyb+y+2fW/65p7/rvaaDCAGegpDWvzMyhfGcZV+xMxZOptUVu6/yuyiLFd
         zPyMSOY7eNPBnovsnP/7UIJwKth4Jrv/hQuDWevVigAHsPbqX6iLEwprfy3yhuJo/lhT
         C74g==
X-Gm-Message-State: AOAM532NcP0lrjY+9TzBUGLcQOFbtOjo+FpXtPvTRdx8TXNjnuFNOh0+
	MBHpaAsoFEijmR7um0jmH4vBjw9bwbj8
X-Google-Smtp-Source: 
 ABdhPJzmMdhrlmZGThXK7RGiBOi1kDSJOaF9GFv5afCrTxRxTcpbVZRofaTNNRSET1/IWBL/SqCRLw==
X-Received: by 2002:aa7:8b0b:0:b0:4bc:d5eb:93c6 with SMTP id
 f11-20020aa78b0b000000b004bcd5eb93c6mr9397624pfd.71.1641467835756;
        Thu, 06 Jan 2022 03:17:15 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 x6sm1766325pge.50.2022.01.06.03.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 03:17:15 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH 3/4] Add script deploy-kernelci.py for upload
 the cip-core-image-kernelci
Date: Thu,  6 Jan 2022 20:16:13 +0900
Message-Id: <20220106111614.218823-4-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
References: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jan 2022 11:17:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7329

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


