Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32948C25B46
	for <webhook@archiver.kernel.org>; Mon, 23 Oct 2023 15:02:52 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.123303.1698073368273104004
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Oct 2023 08:02:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=YLuDH072;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-2023102315024555dde4533e7b3e985a-sngi3l@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2023102315024555dde4533e7b3e985a
        for <cip-dev@lists.cip-project.org>;
        Mon, 23 Oct 2023 17:02:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=/Sz9C6l9A/PBioN5WMmzX12cB42SN+LBEoaxCQpcoXo=;
 b=YLuDH072uOh818PLpFAl+F1hLj+XRmrkKqZnQPaTtdveDF+yd9WpsGVreg4DU/7EB1KeFP
 y8I50ofnBmHcVwUJlSiOApNqQLyO7jHkGw3mF9oapZ6314nkxiNLRdUvoiH8Ypz9mBjkibZt
 OVsTNlZqV0WQu4x3rwZRhP3eZnbgY=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	venkata.pyla@toshiba-tsip.com,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp
Subject: [cip-dev][isar-cip-core][RFC 1/9] scripts/deploy-kernelci: Format python code and remove unused import
Date: Mon, 23 Oct 2023 16:59:59 +0200
Message-ID: <20231023150243.3990309-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
References: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Oct 2023 15:02:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13434

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/deploy-kernelci.py | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/scripts/deploy-kernelci.py b/scripts/deploy-kernelci.py
index 5a8adca..62f3f01 100755
--- a/scripts/deploy-kernelci.py
+++ b/scripts/deploy-kernelci.py
@@ -1,30 +1,30 @@
 #!/usr/bin/env python3
 # -*- coding: utf-8 -*-
 
-import subprocess
 import requests
 import os
 import sys
 import time
 from urllib.parse import urljoin
 
-cdate=time.strftime("%Y%m%d")
-api="https://api.kernelci.org/upload"
-token=os.getenv("KERNELCI_TOKEN")
+cdate = time.strftime("%Y%m%d")
+api = "https://api.kernelci.org/upload"
+token = os.getenv("KERNELCI_TOKEN")
 
-release=sys.argv[1]
-target=sys.argv[2]
-extension=sys.argv[3]
+release = sys.argv[1]
+target = sys.argv[2]
+extension = sys.argv[3]
 
-rootfs_filename="cip-core-image-kernelci-cip-core-"+release+"-"+target+".tar.gz"
-initrd_filename="cip-core-image-kernelci-cip-core-"+release+"-"+target+"-initrd.img"
-initrd_gz_filename="cip-core-image-kernelci-cip-core-"+release+"-"+target+"-initrd.img.gz"
+rootfs_filename = "cip-core-image-kernelci-cip-core-"+release+"-"+target+".tar.gz"
+initrd_filename = "cip-core-image-kernelci-cip-core-"+release+"-"+target+"-initrd.img"
+initrd_gz_filename = "cip-core-image-kernelci-cip-core-"+release+"-"+target+"-initrd.img.gz"
+
+input_dir = "build/tmp/deploy/images/"+target
+upload_path = "/images/rootfs/cip/"+cdate+"/"+target+"/"
+upload_path_latest = "/images/rootfs/cip/latest/"+target+"/"
+rootfs = input_dir+"/"+rootfs_filename
+initrd = input_dir+"/"+initrd_filename
 
-input_dir="build/tmp/deploy/images/"+target
-upload_path="/images/rootfs/cip/"+cdate+"/"+target+"/"
-upload_path_latest="/images/rootfs/cip/latest/"+target+"/"
-rootfs=input_dir+"/"+rootfs_filename
-initrd=input_dir+"/"+initrd_filename
 
 def upload_file(api, token, path, input_file, input_filename):
     headers = {
@@ -40,6 +40,7 @@ def upload_file(api, token, path, input_file, input_filename):
     resp = requests.post(url, headers=headers, data=data, files=files)
     resp.raise_for_status()
 
+
 if os.path.exists(rootfs) and os.path.exists(initrd):
     print("uploading rootfs to KernelCI")
     upload_file(api, token, upload_path, rootfs, rootfs_filename)
-- 
2.42.0


