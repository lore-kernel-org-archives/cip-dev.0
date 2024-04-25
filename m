Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2C0C19F4F
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 11:51:30 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.14922.1714045883926239523
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Apr 2024 04:51:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=S9AIVGFg;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-2024042511512305056e84a2ab4409ae-biihvk@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024042511512305056e84a2ab4409ae
        for <cip-dev@lists.cip-project.org>;
        Thu, 25 Apr 2024 13:51:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=mPuWX8eXjCREpa8DbR98FYBoBPYAnh9srhqKtTNPw80=;
 b=S9AIVGFg+JkOJOrUNSZTh0f6F0lz+T/yWCf05h/G25ET+hxPecvoSAPUnQbvz40XosO5rb
 BnN+8tticBMDuocGZkLEGPWHeaD4d1DzTlIf3wSBe/Jb442ww7SSm84DEXiNtbIVFdTVWT9L
 /Ieplh6ckvzL6scPUVT94QvYFDhUc=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	johnxw@amazon.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 9/9] README.swupdate: Add section about partition selection
Date: Thu, 25 Apr 2024 13:50:37 +0200
Message-ID: <20240425115119.813384-10-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240425115119.813384-1-Quirin.Gylstorff@siemens.com>
References: <20240425115119.813384-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Apr 2024 11:51:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15760

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.swupdate.md | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index b7e13f7..defaba6 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -7,6 +7,25 @@ Start with cloning the isar-cip-core repository:
 ```
 host$ git clone https://gitlab.com/cip-project/cip-core/isar-cip-core.git
 ```
+
+## Update Partition selector(swupdate-handler-roundrobin)
+
+SWUpdate uses the handler [swupdate-handler-roundrobin](https://gitlab.com/cip-project/cip-sw-updates/swupdate-handler-roundrobin) to select the update partition.
+The hanlder uses the following information to select the update partition:
+ - by efibootguard selected unified kernel file. In the cip-core provided images
+ the boot partitions are labeled BOOT0 and BOOT1, see [ebg-sysparts.inc](../wic/ebg-sysparts.inc).
+
+The [sw-description](recipes-core/images/swu/sw-description.tmpl) contains the mapping from boot
+partition to rootfs partition, e.g.:
+```
+device = "C:BOOT0:linux.efi->${ABROOTFS_PART_ID_A},C:BOOT1:linux.efi->${ABROOTFS_PART_ID_B}";
+```
+The variables `ABROOTFS_PART_ID_A` and `ABROOTFS_PART_ID_B` describe the rootfs file system and
+can contain an path to a partition device(e.g. /dev/sdaX), label or uuid. The handler searches
+for the matching device and SWUpdate writes the image to the selected device.
+
+The default values for `ABROOTFS_PART_ID_A`/`ABROOTFS_PART_ID_B` is the content of `ABROOTFS_PART_UUID_A`/`ABROOTFS_PART_UUID_B` which are defined in [swupdate.bbclass](classes/swupdate.bbclass).
+
 ## SWUpdate Efibootguard update
 
 :warning: **If the efibootguard binary is corrupted the system can no longer boot**
-- 
2.43.0


