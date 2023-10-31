Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F3AC001B0
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 08:49:49 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.182063.1698742187492191971
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Oct 2023 01:49:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=LUX8Fu8s;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20231031084944119d385af1786ade5e-qd9oqu@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20231031084944119d385af1786ade5e
        for <cip-dev@lists.cip-project.org>;
        Tue, 31 Oct 2023 09:49:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Ci4RvofAW6V9OV3FbM9k9//VUWNSYaXYeVKO0AdBJ78=;
 b=LUX8Fu8sIOJYmhlaFGeUQRHFLr7WbTrsGxgdkLhBn1hV9bt4wqIzmHF4bn//FwQeC3cTE8
 3VQrNm6QnsUhbn0BsovOgPJLtWwLftVlKdv0vqo/uLd8TqrtNrEqGESc0Qe6NCLs0LtGraAE
 1miZ0H1Qmqr55rn/pI75zyjm41AjE=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	venkata.pyla@toshiba-tsip.com,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp
Subject: [cip-dev][isar-cip-core][RFC v2 1/9] scripts/deploy-kernelci: Format python code and remove unused import
Date: Tue, 31 Oct 2023 09:37:35 +0100
Message-ID: <20231031084943.3105056-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231031084943.3105056-1-Quirin.Gylstorff@siemens.com>
References: <20231031084943.3105056-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Oct 2023 08:49:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13500

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Use flake8 for to check for issues.

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


