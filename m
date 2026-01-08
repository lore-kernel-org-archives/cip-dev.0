Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCFFD1D477
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 15:17:12 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8643.1767885422826856892
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 07:17:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=WAiIj9y7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20260108151701096b11136b00020784-j1gtwi@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260108151701096b11136b00020784
        for <cip-dev@lists.cip-project.org>;
        Thu, 08 Jan 2026 16:17:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=YRuAaTaD5PC4ndF9+jDNdM+xOcBM/EY3rT3doBkKthk=;
 b=WAiIj9y7OKLUywz8agRpUvS9+sFLkkKpYZIxCygHdM0fMCh965FR1sOKxvmrsYgNZo7dB6
 xb060tuy+Niiccw5B6JvH0Oi+WuVAns5DCKUm+tcTGF5gLPLsGmFhDbE9f7vhkllUQq8Dx5W
 km/sRCPRYeZ4TdI0O5R5gVtZLl54nXjTqozVSHs5mRf9RXLaW2gIP/GcBSdDrvlV90deMluh
 5AV461a1OyMnfO2fj+SwNz1VZg48atf30dDYCS6nwuenPvTJoGhTEv6Ao1YP/fR2Uf7v6m/w
 S5pbI9g9N/hQTVY1AEmDJoku5WX2/hDQUnuIE333CoGfTq1hAiFZHbPA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	clara.kowalsky@siemens.com,
	benedikt.niedermayr@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 6/7] Add documentation how to integrate isar-cip-core
Date: Thu,  8 Jan 2026 16:16:13 +0100
Message-ID: <20260108151650.124306-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260108151650.124306-1-Quirin.Gylstorff@siemens.com>
References: <20260108151650.124306-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 15:17:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21487

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.layer-integration.md | 51 +++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 doc/README.layer-integration.md

diff --git a/doc/README.layer-integration.md b/doc/README.layer-integration.md
new file mode 100644
index 0000000..1e1973c
--- /dev/null
+++ b/doc/README.layer-integration.md
@@ -0,0 +1,51 @@
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
-- 
2.51.2


