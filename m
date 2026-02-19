Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C402FE9A03B
	for <webhook@archiver.kernel.org>; Thu, 19 Feb 2026 12:37:34 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12809.1771504650733090005
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Feb 2026 04:37:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=FTQL0mUQ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-2026021912372714a1c2fef300020760-_qvuac@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026021912372714a1c2fef300020760
        for <cip-dev@lists.cip-project.org>;
        Thu, 19 Feb 2026 13:37:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=g0b5tHbOIE7zkUOnu2HNAJTV9wMs/8RCin7y7u2xZVM=;
 b=FTQL0mUQjN6TxMZC/P8FHwsG/j6ARc8TQva8rsQTw/GkdAMYji3lno/q1W5hdT7T5V3lKD
 q15hx9kHwq+eCvRL5BGrYKeBw3Th4eLRJlECfAHiQvEv9k1bhQK1isBpk3vX6mevzp2MjhaM
 8qkDa1odD/js7dFzPtHZicgEqC4TLsfrlKzStDW9MKh7zLfTxV9R7Cp0GBPVmKR5GEChwR6+
 bFkOXlgR/IIPESuEpdda5C2IJ1/Uc09VRDft588Yv5E2UZM4UDym6dsCZlll2XzTbZ815ebo
 I5CDRAAibOx9y6lXQwjqU0yDdwXbg5e9x5u3omTBj+yXWNa4SQ8boJUw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] fix: Disable bootloader interaction in case of ebg only updates
Date: Thu, 19 Feb 2026 13:36:02 +0100
Message-ID: <20260219123726.922484-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Feb 2026 12:37:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21897

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

During an update of the efibootguard binary the boot entries should
not be changed. Therefore disable the boot-loader state and transition
update.

This was found during testing for issue #149.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/images/swu/sw-description-ebg.tmpl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-core/images/swu/sw-description-ebg.tmpl b/recipes-core/images/swu/sw-description-ebg.tmpl
index c19157c..a63e38a 100644
--- a/recipes-core/images/swu/sw-description-ebg.tmpl
+++ b/recipes-core/images/swu/sw-description-ebg.tmpl
@@ -12,6 +12,8 @@ software =
 {
     version = "${SWU_VERSION}";
     name = "${SWU_NAME}";
+    bootloader_transaction_marker = false;
+    bootloader_state_marker = false;
     ${SWU_HW_COMPAT_NODE}
     files: (${SWU_BOOTLOADER_FILE_NODE});
 }
-- 
2.52.0


