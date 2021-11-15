Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1702C433EF
	for <webhook@archiver.kernel.org>; Mon, 15 Nov 2021 16:20:20 +0000 (UTC)
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by mx.groups.io with SMTP id smtpd.web11.24490.1636993219056954099
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=UMgmQ2yt;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.195,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pf1-f195.google.com with SMTP id 8so3555452pfo.4
        for <cip-dev@lists.cip-project.org>;
 Mon, 15 Nov 2021 08:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KkKoPRta3CjjLEn/Kh7baUS+JKV3w0vLt+gcKcz31MY=;
        b=UMgmQ2yt1cEKG9an59gGspDtVvHZ+OZqkkB64P++BEnE44FMJsW9QtXToKPXIQCvT6
         403K6tyl5hb9NEXulQmgXLaTJLkwTGG3nWt4em4RFPZpF6501+Rpfm7zjHso2ibqaKlL
         f+77NMGQX+FuZ43WJ0CEI/Mw1d7ElhSPkB+H/crX96RHShvwOyVxmPNc5E3dZy6Xm4rg
         KXv91z4700k/bQcB5930JM+nZVs0CaVyae0oVag3ZNkn2u+87yIUwWpQnR8tia0hL6vK
         ul5gk0FyXVCSkoOoQNLuxqlkOJVA+dz79ud74fyDV4q65v9d75QINj/T78VsAXirsa8D
         L8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KkKoPRta3CjjLEn/Kh7baUS+JKV3w0vLt+gcKcz31MY=;
        b=hTbhNDFhmjsZReaVcga7l/GLHJsDfuSZDmu0ASMX/C9SGO+BrGVJAKtoCTNehB2NxH
         Tz248Akb5wHf7dIH4gTVoNl9ZaLjE0evTLzSs3oC/UdwDBgUEqEhZERm5Fs5xhBcbG6K
         moUY0yeMrnpjJrgPO8drQRzN99ZKj4bI9rswj2qY+W6bvaTO4vucVtunrEkt+nsEz/B0
         WIpuD6rOs7afQmNLVCvlExVOmdufo+a/wPwXg8UDQSMvxSkn8jcdlsPHNyq4eHr0LDCq
         GdQd5lNJ+0w0746ozRUdtg2pLl5vRNxsf82f+/24zAfnW1Rlv5JvDPdCntWHnytds7cx
         g9pg==
X-Gm-Message-State: AOAM530dicdh2OCTHSQhUTUVzBbd6BHG4f7ZU+IDHyIF5Oxtk/8U6X1H
	HnEyxjH+NIT43MVLWBBgl/vizfjXE1cAlZo=
X-Google-Smtp-Source: 
 ABdhPJzFhD6m0/kPbO2d+1Thn/LAWtgVWcF/dFbxGT2LZNdD8JJxEiNljihQ6OhqJc0O5Rbger5W1A==
X-Received: by 2002:a05:6a00:1411:b0:4a0:3472:e438 with SMTP id
 l17-20020a056a00141100b004a03472e438mr34009235pfu.68.1636993218659;
        Mon, 15 Nov 2021 08:20:18 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 h186sm13850289pfg.64.2021.11.15.08.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 08:20:18 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH 01/11] Deploy tarballs and initrd to kernelci
Date: Tue, 16 Nov 2021 01:17:14 +0900
Message-Id: <20211115161724.19516-2-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
References: <20211115161724.19516-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Nov 2021 16:20:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6904

Create script for deploy images to KernelCI file server using
KernelCI api

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
---
 .gitlab-ci.yml             |  4 +++-
 scripts/deploy-kernelci.py | 48 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100755 scripts/deploy-kernelci.py

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5becd37..dd7d9cc 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -9,6 +9,7 @@ variables:
   targz: disable
   dtb: none
   deploy: enable
+  deploy_kernelci: enable
 
 stages:
   - build
@@ -37,7 +38,8 @@ default:
     - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi;
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
-    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extention} ${dtb}; fi
+    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extention} ${dtb}; fi;
+    - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extention} ${dtb}; fi
 
 # base image
 build:simatic-ipc227e-base:
diff --git a/scripts/deploy-kernelci.py b/scripts/deploy-kernelci.py
new file mode 100755
index 0000000..931504c
--- /dev/null
+++ b/scripts/deploy-kernelci.py
@@ -0,0 +1,48 @@
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
+api="https://api.staging.kernelci.org/upload"
+token=os.getenv("KERNELCI_TOKEN")
+
+release=sys.argv[1]
+target=sys.argv[2]
+extension=sys.argv[3]
+
+rootfs_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+".tar.gz"
+initrd_filename="cip-core-image-"+extension+"-cip-core-"+release+"-"+target+"-initrd.img"
+input_dir="build/tmp/deploy/images/"+target
+upload_path="/images/rootfs/cip/"+cdate+"/"+target+"/"
+rootfs=input_dir+"/"+rootfs_filename
+initrd=input_dir+"/"+initrd_filename
+
+print("build directory contents:")
+print(os.listdir(input_dir))
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
+    upload_file(api, token, upload_path, initrd, initrd_filename)
+    print("uploaded to: https://storage.staging.kernelci.org"+upload_path)
-- 
2.33.1


