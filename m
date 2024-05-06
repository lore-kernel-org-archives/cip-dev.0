Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D307AC10F16
	for <webhook@archiver.kernel.org>; Mon,  6 May 2024 14:18:44 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.21769.1715005119304099102
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 May 2024 07:18:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=AwC/UgaG;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20240506141836e40efdc7622a20c43d-3hkmjc@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240506141836e40efdc7622a20c43d
        for <cip-dev@lists.cip-project.org>;
        Mon, 06 May 2024 16:18:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Mv6BrqES+TFIt6Y3qs76aegn7DxdkxAZNwB3G2DQFDg=;
 b=AwC/UgaG2ZnS4AtMxo8RKMnC1PK8tkJdaC2Ehp+Fr7w6eiMqRWRyPcwDQSoGliFjysSrau
 kkpL+h9sVIxeU4bweos/oDr3OGk+vDAe+EIlxxEy7ZsJ8492KBobUYXztGhkwJOdlrcGw52N
 gy7y0FRnNowrgiR3On8Geyrciaxx8=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	johnxw@amazon.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 09/11] README.swupdate: Add section about partition selection
Date: Mon,  6 May 2024 16:17:30 +0200
Message-ID: <20240506141833.3622989-10-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240506141833.3622989-1-Quirin.Gylstorff@siemens.com>
References: <20240506141833.3622989-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 May 2024 14:18:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15840

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.swupdate.md | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index b7e13f7..0c4473b 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -7,6 +7,22 @@ Start with cloning the isar-cip-core repository:
 ```
 host$ git clone https://gitlab.com/cip-project/cip-core/isar-cip-core.git
 ```
+
+## Update Partition selector(swupdate-handler-roundrobin)
+
+SWUpdate uses the handler [swupdate-handler-roundrobin](https://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin) to select the partition to update.
+The handler uses the information from sw-description file  to select the boot partition.
+In the cip-core provided images the boot partitions are labeled `BOOT0`
+and `BOOT1`, see [ebg-sysparts.inc](../wic/ebg-sysparts.inc).
+
+The [sw-description](recipes-core/images/swu/sw-description.tmpl) contains the mapping from boot
+partition to root file system partition, e.g.:
+```
+device = "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_UUID_B}";
+```
+The variables `ABROOTFS_PART_UUID_A` and `ABROOTFS_PART_UUID_B` contain partition uuids. The handler searches
+for the matching device and SWUpdate writes the image to the selected device.
+
 ## SWUpdate Efibootguard update
 
 :warning: **If the efibootguard binary is corrupted the system can no longer boot**
-- 
2.43.0


