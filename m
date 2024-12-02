Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9874ED7832B
	for <webhook@archiver.kernel.org>; Mon,  2 Dec 2024 14:51:39 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web10.174652.1733151094403796516
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Dec 2024 06:51:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=VC+ZkgaV;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-294854-202412021451310a6b7da53022a62353-zp2p8g@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202412021451310a6b7da53022a62353
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Dec 2024 15:51:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=CxGj68hCDEZzsflw7VfbvZyiP9FVtNJbqqsm+HBOJSY=;
 b=VC+ZkgaVqjbmHiwYRJCpWpn1ldB/Uqj16O9VF0U3vD135uQQToUNhkT8+Ie7jbrdMWajQJ
 ywKjgfv96Wv6x7jbmuawtjihl8wODBfFVEEOSYZode2RfSRHqCMY0U08qhEydB/qTT8RrCp/
 p055IX8MOVR2x5LCW8jTgSbdMA0n9Uu9YGQP3YGl8got4UpeuapxjQv/yRzfx0fHl5+Zha+v
 IyDdaz+IkM0NmZkl2GZbw9OX2S0ujebRcMkiudCP98w7icBy/yqCl2zdQmsMri/KXVjg9h9D
 eOiq4sHAu8AiPY+mzW+Dxv/w+t7p7JFjm5HFYWpWfrTdmWOqhzXGp/zA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Alexander Heinisch <alexander.heinisch@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 01/10] Update isar revision
Date: Mon,  2 Dec 2024 15:51:04 +0100
Message-ID: <75593f244100cc726e7e337298f54f2e80b82a6d.1733151072.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1733151072.git.jan.kiszka@siemens.com>
References: <cover.1733151072.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Dec 2024 14:51:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17309

From: Jan Kiszka <jan.kiszka@siemens.com>

Brings initramfs helpers and mmdebstrap support.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 6c83a0d3..abdf92af 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: b92e9076e27bf22b8296dd3440bf25ebf348e2c6
+    commit: a6171856de84da3deca1355da7aa9c09588e7ea2
     layers:
       meta:
 
-- 
2.43.0


