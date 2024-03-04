Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE58C54E55
	for <webhook@archiver.kernel.org>; Mon,  4 Mar 2024 10:54:58 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.95414.1709549696454636052
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Mar 2024 02:54:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=KxHmIKZu;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-2024030410545459c941f432f9711cfa-b067me@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024030410545459c941f432f9711cfa
        for <cip-dev@lists.cip-project.org>;
        Mon, 04 Mar 2024 11:54:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=6OqQFU6hvv8q5bfRrlfB0qBicIpEZX4ajEnA3a+t6Fw=;
 b=KxHmIKZu53vqdpBUvi0T6HV7ZbWangtQ88L2LXlo20MvVdUcntSN4aBvL7O48d+XMZlqxj
 5jLXytZrk/Tgg0VopcWgMJalr78NlOsQFtCN9QIuZwvvWEHSOMoEAqRAo4tk5g7+js62ioCl
 HXl5H8MJ0Nws1GSJFxAv1pfmVXsQU=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 3/4] swupdate.bbclass: weak default assignment for SWU_HW_COMPAT
Date: Mon,  4 Mar 2024 11:54:51 +0100
Message-ID: <20240304105453.984881-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240304105453.984881-1-Quirin.Gylstorff@siemens.com>
References: <20240304105453.984881-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Mar 2024 10:54:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15192

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to set SWU_HW_COMPAT in recipe-core/images/swupdate.inc
and in downstream layers.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 2c69892..aaff072 100644
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


