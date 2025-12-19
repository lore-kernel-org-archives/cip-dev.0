Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F2FD767CC
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 10:33:58 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14213.1766140433469810359
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Dec 2025 02:33:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=HlwW3Ozt;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20251219103351f50b551e76000207ab-s7buao@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251219103351f50b551e76000207ab
        for <cip-dev@lists.cip-project.org>;
        Fri, 19 Dec 2025 11:33:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=fe6k3xgDy4HSTvLyyc0L9Y1hDNLs0+0PFFE4APf7Fn0=;
 b=HlwW3OztwtKYp5O7m7eE3WwODXPXz18A8LZtAUN2rQrR4u5cGwVAfwdSSnggUH8Ur3GLmp
 hPawd+WMjf1u6Bor04jw5ON72yOWF+ysxImOi6cNsU/iXJd/y1pUU70OtufR0I4xBe2+PkW6
 CKTMl4C2RZ4aDeH/0tfA+Kfw/HEFonsjKZcwUN0Uf5xp+MnqG6lrTAakK0KvgxcnYTm6/BKJ
 GZlZfWUT7E+QcVUjvtXGS8TWb3tiEdx0ZM9x8mfRD7J6+hxc6jXLDsj4W5/rrieai82L/G4x
 a53tilnJEM+OWhI4Y/xmxqCmzspSMLXXKH1L0RfGvm5CnZAB6OMKda5Q==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	clara.kowalsky@siemens.com,
	cip-dev@lists.cip-project.org,
	benedikt.niedermayr@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 6/6] Add documentation how to integrate isar-cip-core
Date: Fri, 19 Dec 2025 11:31:26 +0100
Message-ID: <20251219103349.1227710-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20251219103349.1227710-1-Quirin.Gylstorff@siemens.com>
References: <20251219103349.1227710-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 10:33:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21171

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.usage.md | 55 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 doc/README.usage.md

diff --git a/doc/README.usage.md b/doc/README.usage.md
new file mode 100644
index 0000000..b11152a
--- /dev/null
+++ b/doc/README.usage.md
@@ -0,0 +1,55 @@
+# Integrate isar-cip-core in an Isar layer
+
+This document describes how to integrate isar-cip-core into a existing isar layer and build a
+A/B root file system which can be updated with SWUpdate.
+
+## Add cip-core to a kas.yaml
+
+Add the isar-cip-core layer to a kas-file:
+```yaml
+  cip-core:
+    url: https://gitlab.com/cip-project/cip-core/isar-cip-core.git
+    branch: master
+```
+
+## Configure the root filesystem for A/B Updates
+
+Add this line switches the root file system to a read-only file system
+with /etc as overlay. It also installs and configures efibootguard and SWUpdate.
+An additional image type is generated with contains the update artifacts.
+
+```bitbake
+require recipes-core/images/swupdate.inc
+```
+
+## Create a image description
+
+Create a new wks file to describe the image. It is recommended to use
+ [wic/qemu-amd64-efibootguard.wks.in](../wic/qemu-amd64-efibootguard.wks.in) as
+ the base for this image. As all necessary variables are set.
+
+## Set variables
+
+Generate the uuid for the root file system partitions. These variables are used
+by SWUpdate to select the update partition.
+```
+ABROOTFS_PART_UUID_A = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
+ABROOTFS_PART_UUID_B = "YYYYYYYY-YYYY-YYYY-YYYY-YYYYYYYYYYYY"
+```
+
+Set the certificate source and mechanism to sign the update artifact.
+
+```
+PREFERRED_PROVIDER_swupdate-certificates-key = "swupdate-certificates-key-snakeoil"
+PREFERRED_PROVIDER_swupdate-certificates = "swupdate-certificates-snakeoil"
+PREFERRED_PROVIDER_swupdate-signer = "swupdate-signer-cms"
+```
+
+Set  the variable `OVERRIDES` to `:swupdate` to customize the initramfs:
+```
+OVERRIDES .= ":swupdate"
+```
+Set the boot-loader to efibootguard which provides a mechanism to switch between the root partitions:
+```
+SWUPDATE_BOOTLOADER = "efibootguard"
+```
-- 
2.51.2


