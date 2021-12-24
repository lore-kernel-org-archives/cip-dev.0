Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85515C433F5
	for <webhook@archiver.kernel.org>; Fri, 24 Dec 2021 07:33:23 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web11.43152.1640331202703203464
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Dec 2021 23:33:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=fmIUdIvx;
 spf=pass (domain: miraclelinux.com, ip: 209.85.215.175,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-pg1-f175.google.com with SMTP id 200so7015021pgg.3
        for <cip-dev@lists.cip-project.org>;
 Thu, 23 Dec 2021 23:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RRYhDsiQqxp8TXb60neak8ciHC84xt/O57ONpJQOLQo=;
        b=fmIUdIvxp5+TvebzZJbKjs8feOoma/M4a2Y4XRBqGNCrH3+wWJl48fJZdQYRNGROcj
         fLxXzEXw5ClT6Jt3P8eZE1HdN1ki2pDANuszzDuNOUaZFZbO3Gwpzcny+tzTgIWsVbKv
         I4p072oj9M7G66KkBD2Adk3rT9OgYLCjsNFrBjV8oveh93VuDatqEKrQlhTTkQg1m5Ry
         y08p2zFBH9XXvuI/EWlzbZZ9VM7jmLObkjKg+Wn6eTZ+m/D8np1PzZ9VMPUPeXDhoAaA
         OE3H77S+8uF9z7s89DdTTGpD7Aiut9N7N9B9DcTIIjVBWXaLbR1wGKbxcCFST0mUR/DM
         jJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRYhDsiQqxp8TXb60neak8ciHC84xt/O57ONpJQOLQo=;
        b=K4DwbCeyfvZ5qGFmAgM5Wp4W6dcRYYZpuASKwAZim+W5qtSa6XlJPlJBsnd6MU3GUC
         54parOkJqZU3mGSxZGytV/6JJIJOeQm3Nem9dvvOq+KEA4PCNlJ1uuSMHSeIuP3vCRTn
         Myqq/51UH2e47E5OrFchn1LsLPueJVCyjiug+QxRAfq1oMASADJ15X8AkiavW5saSosD
         sMo07jnWW1+umC7Ify1PLOdZfge/nLS6QQEX3bWFbyFQtwCEuq1BOaSCWHxrRUjdLQkN
         7AHq6zpm+nK4PoYdi6i9vwWau3Jlu4VmC/AlmvJz0YmY/HC2/17SZQZ8pthqq5I5e+VA
         GhXQ==
X-Gm-Message-State: AOAM530fX6MhDEDn0MbJ+WTm3X8nmKOWXtggiYjgKjHX6Ck+8A18OzZN
	KrPZ7b/Ot3KO06aSS7bMMY+R8zcSS7lw
X-Google-Smtp-Source: 
 ABdhPJzBxSTP8iRXaPa1VW4NgfSRwLJEBzF/SzPd1HOY1LqcXd7CPi5UoWrZiaG7OBeC48nWWw0QEA==
X-Received: by 2002:a63:8849:: with SMTP id l70mr5014602pgd.433.1640331202283;
        Thu, 23 Dec 2021 23:33:22 -0800 (PST)
Received: from alicef-pc.nkano1.kt.home.ne.jp (27-139-229-132.rev.home.ne.jp.
 [27.139.229.132])
        by smtp.gmail.com with ESMTPSA id
 u18sm8763175pfi.158.2021.12.23.23.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 23:33:21 -0800 (PST)
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [PATCH 3/4] Add script deploy-kernelci.py for upload the
 cip-core-image-kernelci
Date: Fri, 24 Dec 2021 16:32:41 +0900
Message-Id: <20211224073242.69676-4-alice.ferrazzi@miraclelinux.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211224073242.69676-1-alice.ferrazzi@miraclelinux.com>
References: <20211224073242.69676-1-alice.ferrazzi@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Dec 2021 07:33:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7267

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


