Return-Path: <SRS0=/OiK=KC=lists.cip-project.org=bounce+64572+6437+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8F2C433ED
	for <cip-dev@archiver.kernel.org>; Fri,  7 May 2021 07:30:12 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D2C613D9
	for <cip-dev@archiver.kernel.org>; Fri,  7 May 2021 07:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D2C613D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6437+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yiQwYY4521723xkVi1GdU3VX; Fri, 07 May 2021 00:30:10 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web12.7058.1620372608502608398
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 May 2021 00:30:10 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 1477U6ms009136
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 7 May 2021 09:30:06 +0200
X-Received: from md2dvrtc.fritz.box ([139.22.46.186])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 1477U596021484;
	Fri, 7 May 2021 09:30:05 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH] kas/opt: Restructure ebg-swu.yml and qemu-swupdate.yml
Date: Fri,  7 May 2021 09:30:05 +0200
Message-Id: <20210507073005.26972-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: xsK0mszRwhw8H9I0GJgGrdpOx4520388AA=
Content-Type: multipart/mixed; boundary="0dGBAjvFrgqlWWJjv8sC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620372610;
 bh=PR5a/v/Elw3p2kY/k70YDTim5D1TSFzNB6wbmvd871s=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Wk9pCH+kb/0Cfw/YXExQI0i3UDrRTexgySOVmDp7C7UD7EyvJoTId6aPAI/Z3CjSeFL
 WkUtltw5L1ffX7DRTJT9QlwN+8T954OXXT2Fz/uHRTZqHhACXj1z/1qemoc7NRO+0gSlA
 8TdxIufLpkHFosCLdIVSsjgPFKD9aGyc/A4=

--0dGBAjvFrgqlWWJjv8sC
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The kas files ebg-swu.yml and qemu-swupdate.yml overlap in
some cases. Clarify their use by moving all efibootguard related
configuration to efibootguard.yml. Configuration items corresponding
with SWUpdate are moved to swupdate.yml. The option swupdate.yml is
independent of the bootloader/cpu-architecture.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.secureboot.md                    |  5 ++---
 kas/opt/ebg-secure-boot-base.yml            |  2 ++
 kas/opt/{ebg-swu.yml => efibootguard.yml}   | 12 ++++++------
 kas/opt/{qemu-swupdate.yml => swupdate.yml} | 10 +++++++---
 4 files changed, 17 insertions(+), 12 deletions(-)
 rename kas/opt/{ebg-swu.yml => efibootguard.yml} (66%)
 rename kas/opt/{qemu-swupdate.yml => swupdate.yml} (52%)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 0996edc..b5056f2 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -142,7 +142,7 @@ Build the image with a signed efibootguard and unified kernel image
 with the snakeoil keys by executing:
 
 ```
-kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/ebg-secure-boot-snakeoil.yml
+kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-secure-boot-snakeoil.yml
 ```
 
 For user-generated keys, create a new option file in the repository. This option file could look like this:
@@ -150,7 +150,6 @@ For user-generated keys, create a new option file in the repository. This option
 header:
   version: 10
   includes:
-   - kas/opt/ebg-swu.yml
    - kas/opt/ebg-secure-boot-base.yml
 
 local_conf_header:
@@ -169,7 +168,7 @@ need to stored in the folder `recipes-devtools/ebg-secure-boot-secrets/files`.
 Build the image with user-generated keys by executing the command:
 
 ```
-kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:<path to the new option>.yml
+kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:<path to the new option>.yml
 ```
 
 ### Start the image
diff --git a/kas/opt/ebg-secure-boot-base.yml b/kas/opt/ebg-secure-boot-base.yml
index 30ca35a..35fb42e 100644
--- a/kas/opt/ebg-secure-boot-base.yml
+++ b/kas/opt/ebg-secure-boot-base.yml
@@ -11,6 +11,8 @@
 
 header:
   version: 10
+  includes:
+   - efibootguard.yml
 
 local_conf_header:
   initramfs: |
diff --git a/kas/opt/ebg-swu.yml b/kas/opt/efibootguard.yml
similarity index 66%
rename from kas/opt/ebg-swu.yml
rename to kas/opt/efibootguard.yml
index 63dda09..544c740 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/efibootguard.yml
@@ -8,19 +8,19 @@
 #
 # SPDX-License-Identifier: MIT
 #
+# This kas file adds efibootguard as the bootloader to the image
 
 header:
   version: 10
 
 local_conf_header:
-  swupdate: |
-    IMAGE_INSTALL_append = " swupdate efibootguard"
+  efibootguard: |
+    IMAGE_INSTALL_append = " efibootguard"
+
+  efibootguard-swupdate: |
     SWUPDATE_BOOTLOADER = "efibootguard"
 
-  efibootguard: |
+  efibootguard-wic: |
     WDOG_TIMEOUT = "0"
     WICVARS += "WDOG_TIMEOUT"
 
-  wic: |
-    IMAGE_TYPE = "wic-swu-img"
-    WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
diff --git a/kas/opt/qemu-swupdate.yml b/kas/opt/swupdate.yml
similarity index 52%
rename from kas/opt/qemu-swupdate.yml
rename to kas/opt/swupdate.yml
index daebd2c..e622972 100644
--- a/kas/opt/qemu-swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -8,12 +8,16 @@
 #
 # SPDX-License-Identifier: MIT
 #
-
+# This kas file adds swupdate and generates a ${IMAGE_NAME}.swu
+# from the first wic partition
 
 header:
   version: 10
 
 local_conf_header:
-  qemu-wic: |
+  swupdate: |
+    IMAGE_INSTALL_append = " swupdate"
+
+  wic-swu: |
     IMAGE_TYPE ?= "wic-swu-img"
-    WKS_FILE = "qemu-amd64-${SWUPDATE_BOOTLOADER}.wks"
+    WKS_FILE = "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
-- 
2.20.1


--0dGBAjvFrgqlWWJjv8sC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6437): https://lists.cip-project.org/g/cip-dev/message=
/6437
Mute This Topic: https://lists.cip-project.org/mt/82649959/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--0dGBAjvFrgqlWWJjv8sC--
