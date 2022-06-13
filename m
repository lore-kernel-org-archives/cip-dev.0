Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DFEC433EF
	for <webhook@archiver.kernel.org>; Mon, 13 Jun 2022 12:34:26 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.5097.1655123661575594151
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jun 2022 05:34:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=UndMqiVN;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228,
 mailfrom: fm-51332-20220613123417de62b3fa0f7df57649-_zqbjr@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20220613123417de62b3fa0f7df57649
        for <cip-dev@lists.cip-project.org>;
        Mon, 13 Jun 2022 14:34:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=qWonOpjnFv59yOJDECJ4aQoNWTLsUDnzwahVrL4w+9A=;
 b=UndMqiVNNTkfjdGww+DIvJaPF2c47OEdPseFIn+LnlpbDT//ejPJOTkcAyxn+dGOK8EiD3
 O++sLH+VpzqsIirJ9LhzJ2fGMV/+TMu7OUF/plNtZvrM8zDCiqUT4AjP/Jddl+q8o63Aj93U
 XdqCton3DVNy4lCW+U6yULujzCJYo=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2] .gitlabci: add qemu-arm64
 secureboot and swupdate
Date: Mon, 13 Jun 2022 14:34:17 +0200
Message-Id: <20220613123417.1200092-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jun 2022 12:34:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8552

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

Changes in V2:
 - remove qemu-arm64-swupdate build
 - add qemu-amd64-secure-boot for Debian buster

 .gitlab-ci.yml | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 75856e1..b1a4dc0 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -218,6 +218,18 @@ build:qemu-amd64-swupdate:
     targz: disable
     deploy: disable
 
+# secure boot images arm64
+build:qemu-arm64-secure-boot:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-arm64
+    extension: ebg-secure-boot-snakeoil
+    use_rt: disable
+    wic_targz: disable
+    targz: disable
+    deploy: disable
+
 # buster images
 build:simatic-ipc227e-buster:
   extends:
@@ -249,3 +261,15 @@ build:hihope-rzg2m-buster:
     target: hihope-rzg2m
     dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
     release: buster
+
+build:qemu-amd64-secure-boot-buster:
+  extends:
+    - .build_base
+  variables:
+    release: buster
+    target: qemu-amd64
+    extension: ebg-secure-boot-snakeoil
+    use_rt: disable
+    wic_targz: disable
+    targz: disable
+    deploy: disable
-- 
2.35.1


