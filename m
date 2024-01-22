Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7036C47DDF
	for <webhook@archiver.kernel.org>; Mon, 22 Jan 2024 12:38:00 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.72486.1705927076205220107
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jan 2024 04:37:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=P1WusKxQ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-2024012212375328fc495fd7a5a8cc3a-j0k5no@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2024012212375328fc495fd7a5a8cc3a
        for <cip-dev@lists.cip-project.org>;
        Mon, 22 Jan 2024 13:37:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=uCbvdigdQq1b07hDw2e7XyQqiTU9E95pDoDgo8CoRr4=;
 b=P1WusKxQ2zokWgY6njTce/Q0RH3IxTMhXqS5Qxce+z/TKPR44JWBUkHG2mbTvVhiScQw8n
 r9ac0FEEHHbOgf39NFGRs9GqPCapgElj37xVsdvOLuPogO+xIn5VdXNh677neUsJEyOy60lt
 v2gnM3OvmWn64x9ng4Q8tJ0Zymhtg=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 3/4] swupdate.bbclass: weak default assignment for SWU_HW_COMPAT
Date: Mon, 22 Jan 2024 13:37:14 +0100
Message-ID: <20240122123751.83696-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240122123751.83696-1-Quirin.Gylstorff@siemens.com>
References: <20240122123751.83696-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jan 2024 12:38:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14437

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to set SWU_HW_COMPAT in recipe-core/images/swupdate.inc
and in downstream layers.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 8f1215d..b2c10db 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -21,7 +21,7 @@ SWU_ROOTFS_PARTITION_NAME ?= "${SWU_ROOTFS_NAME}.${SWU_ROOTFS_TYPE}${@get_swu_co
 SWU_VERSION ?= "0.2"
 SWU_NAME ?= "cip software update"
 # space separated list of supported hw. Leave empty to leave out
-SWU_HW_COMPAT ?= ""
+SWU_HW_COMPAT ??= ""
 
 SWU_EBG_UPDATE ?= ""
 SWU_EFI_BOOT_DEVICE ?= "/dev/disk/by-uuid/4321-DCBA"
-- 
2.43.0


