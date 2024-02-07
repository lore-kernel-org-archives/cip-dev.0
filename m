Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAEAC4828D
	for <webhook@archiver.kernel.org>; Wed,  7 Feb 2024 13:45:12 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.20592.1707313508548888710
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Feb 2024 05:45:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=OWfQ/fxz;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20240207134506d5cebf275408ff984d-j_ifbs@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240207134506d5cebf275408ff984d
        for <cip-dev@lists.cip-project.org>;
        Wed, 07 Feb 2024 14:45:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=14xxIJOFRbAunhBs3gz9ine5QuCF+qAL6VkVCmdw2QE=;
 b=OWfQ/fxzE6mKYsIGNa91m5aas5vjCpjWc9N4no6fRjs2oTn4mzYP/dXmeOBv8qmCEZAdnR
 pXAitRUD1Cja3aImI81A3KWtp5exDDnrf6z2UnuKddeYAX9o8cgQxmAlk0SPp+U7NlNSj8Ps
 d/nzW2sTLW2WamVSZXcaeANCd8fwE=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 3/3] swupdate.bbclass: weak default assignment for SWU_HW_COMPAT
Date: Wed,  7 Feb 2024 14:44:27 +0100
Message-ID: <20240207134505.3286003-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240207134505.3286003-1-Quirin.Gylstorff@siemens.com>
References: <20240207134505.3286003-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Feb 2024 13:45:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14882

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to set SWU_HW_COMPAT in recipe-core/images/swupdate.inc
and in downstream layers.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 403bdef..20589f3 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -20,7 +20,7 @@ SWU_ROOTFS_PARTITION_NAME ?= "${SWU_ROOTFS_NAME}.${SWU_ROOTFS_TYPE}${@get_swu_co
 SWU_VERSION ?= "0.2"
 SWU_NAME ?= "cip software update"
 # space separated list of supported hw. Leave empty to leave out
-SWU_HW_COMPAT ?= ""
+SWU_HW_COMPAT ??= ""
 
 SWU_EBG_UPDATE ?= ""
 SWU_EFI_BOOT_DEVICE ?= "/dev/disk/by-uuid/4321-DCBA"
-- 
2.43.0


