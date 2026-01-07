Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C251CFD632
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 13:27:25 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5706.1767792443621506731
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 05:27:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=SedyrNa7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20260107132718a98dea552500020714-ttuw7p@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260107132718a98dea552500020714
        for <cip-dev@lists.cip-project.org>;
        Wed, 07 Jan 2026 14:27:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=uPGlxbW6Mo5j5zbe4NxnwsxjdsImz7BWdQUJkgLSTlM=;
 b=SedyrNa7uCRensmdS/v1mH8caJUvCrbtRWsdqzHYOD/3/pYW9vhK/F2zRVUe5mRk7egThu
 2dfc55Zah0o42PoTlLnu5UImSuK0ag1SDWfmKTxeuc1TOa4+t7+8gtGmr5xcFU4mktkpSYCq
 xEdWRw2bDRLo1tWvRqG0sru7/L6BIujOksrwK4aGtX7DlfPEbdiS4uE/UzFVIWgQUoR58lM/
 zjmY/VOMepEvqqtAbyspn8u4ueGLOgB0CGoZaYbHCZPvtJvO9k2//urbBknkTlQtbfTqWLj0
 6ZDyXDvk2LV29BT0pE9faVvh867O3detQG+BXUHhvI9GjWHrt9Uo0M7A==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	clara.kowalsky@siemens.com,
	cip-dev@lists.cip-project.org,
	benedikt.niedermayr@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 6/7] Add documentation how to integrate isar-cip-core
Date: Wed,  7 Jan 2026 14:26:29 +0100
Message-ID: <20260107132707.733180-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260107132707.733180-1-Quirin.Gylstorff@siemens.com>
References: <20260107132707.733180-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 13:27:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21407

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.usage.md | 51 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 doc/README.usage.md

diff --git a/doc/README.usage.md b/doc/README.usage.md
new file mode 100644
index 0000000..1e1973c
--- /dev/null
+++ b/doc/README.usage.md
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


