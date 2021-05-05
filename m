Return-Path: <SRS0=sTcK=KA=lists.cip-project.org=bounce+64572+6422+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5580DC433ED
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 08:12:47 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF89613CD
	for <cip-dev@archiver.kernel.org>; Wed,  5 May 2021 08:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF89613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6422+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 1uv6YY4521723xDE8xBNEA8O; Wed, 05 May 2021 01:12:46 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web10.5073.1620202365014597685
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 May 2021 01:12:45 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 1458Chf9005298
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 5 May 2021 10:12:43 +0200
X-Received: from md2dvrtc.fritz.box ([167.87.16.18])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 14585I0S018849;
	Wed, 5 May 2021 10:05:20 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v3 2/2] swupdate-config: add prefix to variables
Date: Wed,  5 May 2021 10:05:18 +0200
Message-Id: <20210505080518.18186-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210505080518.18186-1-Quirin.Gylstorff@siemens.com>
References: <bebc037e-654a-ea94-70a2-7f8502cbb17d@siemens.com>
 <20210505080518.18186-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: hYEo8XynjFREyqUEtUOSzluqx4520388AA=
Content-Type: multipart/mixed; boundary="aKlDuMJhwUJBuPRp3H5A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1620202366;
 bh=5a4RM6D52p4G4j8FOhaIz41lizUFzORbIY4/Gt7o7kw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=v5FWT3N2mALauLaoWVuZi6vJsBg2lhFkS4IaW2k2B20o3i39UAS4pu6PUgqwBsHYUSQ
 5jcdoPrQ/7TK0y/F+z9pPl9FnKhOn/bxvBYx/UnvuccXydygKSw581HYLOQ8Y6LyUa8KX
 CJY3DuoXxNqpmc1P8sufl+Rz4ApNEdSQ1kw=

--aKlDuMJhwUJBuPRp3H5A
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The variables U_BOOT and BOOTLOADER are only used for swupdate.
Add the prefix SWUPDATE to indicate the intended usage.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate-config.bbclass      | 8 ++++----
 kas/opt/ebg-secure-boot-snakeoil.yml | 2 +-
 kas/opt/ebg-swu.yml                  | 4 ++--
 kas/opt/qemu-swupdate.yml            | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/classes/swupdate-config.bbclass b/classes/swupdate-config.bbclass
index 5af4eba..4e46b37 100644
--- a/classes/swupdate-config.bbclass
+++ b/classes/swupdate-config.bbclass
@@ -60,7 +60,7 @@ KFEATURE_u-boot[KCONFIG_SNIPPETS] = "file://swupdate_defconfig_u-boot.snippet"
 SWUPDATE_LUASCRIPT ?= "swupdate_handlers.lua"
 
 def get_bootloader_featureset(d):
-    bootloader = d.getVar("BOOTLOADER", True) or ""
+    bootloader = d.getVar("SWUPDATE_BOOTLOADER", True) or ""
     if bootloader == "efibootguard":
         return "efibootguard"
     if bootloader == "u-boot":
@@ -71,11 +71,11 @@ SWUPDATE_KFEATURES ??= ""
 KFEATURES = "${SWUPDATE_KFEATURES}"
 KFEATURES += "${@get_bootloader_featureset(d)}"
 
-# Astonishingly, as an anonymous python function, BOOTLOADER is always None
+# Astonishingly, as an anonymous python function, SWUPDATE_BOOTLOADER is always None
 # one time before it gets set. So the following must be a task.
 python do_check_bootloader () {
-    bootloader = d.getVar("BOOTLOADER", True) or "None"
+    bootloader = d.getVar("SWUPDATE_BOOTLOADER", True) or "None"
     if not bootloader in ["efibootguard", "u-boot"]:
-        bb.warn("swupdate: BOOTLOADER set to incompatible value: " + bootloader)
+        bb.warn("swupdate: SWUPDATE_BOOTLOADER set to incompatible value: " + bootloader)
 }
 addtask check_bootloader before do_fetch
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index 8a72084..c0ed1a2 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -20,7 +20,7 @@ local_conf_header:
     # Add snakeoil and ovmf binaries for qemu
     IMAGER_BUILD_DEPS += "ebg-secure-boot-snakeoil ovmf-binaries"
     IMAGER_INSTALL += "ebg-secure-boot-snakeoil"
-    WKS_FILE = "${MACHINE}-${BOOTLOADER}-secureboot.wks"
+    WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks"
 
   ovmf: |
     # snakeoil certs are only part of backports
diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index aa3aed1..63dda09 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -15,7 +15,7 @@ header:
 local_conf_header:
   swupdate: |
     IMAGE_INSTALL_append = " swupdate efibootguard"
-    BOOTLOADER = "efibootguard"
+    SWUPDATE_BOOTLOADER = "efibootguard"
 
   efibootguard: |
     WDOG_TIMEOUT = "0"
@@ -23,4 +23,4 @@ local_conf_header:
 
   wic: |
     IMAGE_TYPE = "wic-swu-img"
-    WKS_FILE ?= "${MACHINE}-${BOOTLOADER}.wks"
+    WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
diff --git a/kas/opt/qemu-swupdate.yml b/kas/opt/qemu-swupdate.yml
index 3f5fedf..daebd2c 100644
--- a/kas/opt/qemu-swupdate.yml
+++ b/kas/opt/qemu-swupdate.yml
@@ -16,4 +16,4 @@ header:
 local_conf_header:
   qemu-wic: |
     IMAGE_TYPE ?= "wic-swu-img"
-    WKS_FILE = "qemu-amd64-${BOOTLOADER}.wks"
+    WKS_FILE = "qemu-amd64-${SWUPDATE_BOOTLOADER}.wks"
-- 
2.20.1


--aKlDuMJhwUJBuPRp3H5A
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6422): https://lists.cip-project.org/g/cip-dev/message=
/6422
Mute This Topic: https://lists.cip-project.org/mt/82599502/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--aKlDuMJhwUJBuPRp3H5A--
