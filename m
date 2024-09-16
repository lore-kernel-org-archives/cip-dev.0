Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D17EC3ABB2
	for <webhook@archiver.kernel.org>; Mon, 16 Sep 2024 12:55:24 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.7845.1726491322507718782
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Sep 2024 05:55:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=C6OXBzZx;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20240916125519777a7dfad8b56f8346-mhd59j@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240916125519777a7dfad8b56f8346
        for <cip-dev@lists.cip-project.org>;
        Mon, 16 Sep 2024 14:55:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=hS2TlsFzwsVVB1xc4/Ud+BKIxl+tx2bJPFSpPuluSEE=;
 b=C6OXBzZxa+JOJKd5p4gpNNd8KqVT2mUaaXppV51RLn/8cSI68vDUwtBU21v6myV661yakW
 JvUwxnwovLBe90annGxm03XsxmUCGyhVetO1687QRM2i0pb7gm2seG2nfBY2IOx4goIFImMF
 PuuANq8GGcLetMG5RjGxryxr1ouVNkFEZ3KkEk+rNNCkqQDa4bZmMpTDAL/tdPdRaxq5BZ6Y
 n7d08DByxmZib/6fUu5EzYS9LMvLASPnVCQDPISNRgcr1kLMbUbwiwQl9eeb7UvwtH0mmSwH
 8wWe9Yo9Psl1sfbqKhJinhi/Rls22uHy75mWDs/Z96pkADiY0INhC38g==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 3/3] Update README for swupdate signing
Date: Mon, 16 Sep 2024 14:54:55 +0200
Message-ID: <20240916125518.614224-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240916125518.614224-1-Quirin.Gylstorff@siemens.com>
References: <20240916125518.614224-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Sep 2024 12:55:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16902

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.swupdate.md                        | 25 ++++++++++++++++---
 .../swupdate-signer/swupdate-signer-empty.bb  | 22 ++++++++++++++++
 2 files changed, 44 insertions(+), 3 deletions(-)
 create mode 100644 recipes-devtools/swupdate-signer/swupdate-signer-empty.bb

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index a5fbab9..99df9ba 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -136,8 +136,9 @@ To use other key and certificate the following variables must be set:
 ```
 PREFERRED_PROVIDER_swupdate-certificates-key = "swupdate-certificates-key"
 PREFERRED_PROVIDER_swupdate-certificates = "swupdate-certificates"
-SWU_SIGN_CERT = "<sigining certificate file name>"
+PREFERRED_PROVIDER_swupdate-signer = "swupdate-signer-cms"
 SWU_SIGN_KEY  = "<siging key file name>"
+IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 ```
 
 The files `<sigining certificate file name>` and `<siging key file name>` need to be stored
@@ -145,8 +146,26 @@ in `recipes-devtools/swupdate-certificates/files/` or in a path defined by an bb
 
 ### signing script
 
-The provided [cms signing script](./recipes-devtools/swupdate-certificates/files/sign-swu-cms)
-can be replaced by setting the variable `SWU_SIGN_SCRIPT`.
+The package [swupdate-signer-cms](recipes-devtools/swupdate-signer/) provides a [cms signing script](./recipes-devtools/swupdate-certificates/files/sign-swu-cms).
+When signing requires a project specific signing script,
+e.g. for using a hardware security module(HSM), an own package can be added.
+The package can replace the default package by adding the following lines:
+
+```
+PREFERRED_PROVIDER_swupdate-signer = "<own swupdate signer>"
+PREFERRED_PROVIDER_swupdate-certificates = "<own certificate provider>"
+```
+
+The packages `swupdate-signer` and `swupdate-certificate` must be set to sign the swu-binary
+and verify the signed swu-binary during an update.
+An key to the signing script can be provided with:
+```
+PREFERRED_PROVIDER_swupdate-certificates-key = "<own key provider>"
+```
+
+The package `<own signing package>` needs to install a executable to `/usr/bin/sign-swu`.
+
+An empty signer to be used as a template is provided in [swupdate-signer-empty](recipes-devtools/swupdate-signer/swupdate-signer-empty.bb).
 
 ## SWUpdate Hardware compatibility
 
diff --git a/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb b/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
new file mode 100644
index 0000000..8522e5e
--- /dev/null
+++ b/recipes-devtools/swupdate-signer/swupdate-signer-empty.bb
@@ -0,0 +1,22 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw
+DPKG_ARCH = "all"
+DEBIAN_MULTI_ARCH = "foreign"
+
+PROVIDES = "swupdate-signer"
+DEBIAN_PROVIDES = "swupdate-signer"
+
+do_install[cleandirs] = "${D}/usr/bin/"
+do_install() {
+    printf "#!/bin/sh\necho "empty-signer" > \$2 \n" > ${WORKDIR}/empty-signer
+    install -m 0755 ${WORKDIR}/empty-signer ${D}/usr/bin/sign-swu
+}
-- 
2.45.2


