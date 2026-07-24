Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCC2C53216
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 12:40:49 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18261.1784896843147758159
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2026 05:40:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=AbCSGH0f;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20260724124040c24cb7ee900002074a-umrnu_@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20260724124040c24cb7ee900002074a
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Jul 2026 14:40:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=dMVUPVbktJHtaw9q0K3ZRLzvYOz9LHRcazHXCD7Qbl4=;
 b=AbCSGH0fRJoCHfX5Lsuc6ZP+yNOFVto+v0+DpXkoodDCo5NGEQGMwZ7N7oSqk1xD7z7kyj
 yqikOZoHpaahUfWko+gMWlXOnxS4cA0u1PIZIWZ1jBiQcrCRDqWeiCw9SbuAHGom6bIRLk9z
 I1NTKSObxlVQv5UONp8P+9JIVEFMb5S6tv2RajvCVndlpCB4IPUisZ57z+K0bn5p16z9NLCk
 z9/S8o0ERpaWXTxfZJ2r9nOVMqqRpLK1tIvtGaUYe2vtAv4Lv8X/3GIrhgZIXWk1JOBEuRPQ
 Q0FdbTxl50mjRV2uY4wVG/HVAJf3cdZ/+nUcR4uv6Y7siLtbVUhNDijA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christoph.steiger@siemens.com,
	clara.kowalsky@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 01/14] isar: Update for sstate fixes
Date: Fri, 24 Jul 2026 14:39:03 +0200
Message-ID: <20260724124038.3633611-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jul 2026 12:40:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23740

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 23bbba4..2ee8258 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 3c645ee8dcd3d2161b93a3b2f9808fe1829850e7
+    commit: d008ef091e8e3521578543c397d6d39c586d1283
     layers:
       meta:
 
-- 
2.53.0


