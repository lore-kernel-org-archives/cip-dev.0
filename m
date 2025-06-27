Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E5EC77B7F
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 12:53:57 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.12832.1751028834184218011
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Jun 2025 05:53:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=CXOUtbHV;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1330684-20250627125350653a8f0bfd947b5926-y4pezt@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250627125350653a8f0bfd947b5926
        for <cip-dev@lists.cip-project.org>;
        Fri, 27 Jun 2025 14:53:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=XlYYYhrOAZXh5zNlOO0OBDsoiyy8KvJWblX5Lc99ghA=;
 b=CXOUtbHVprntMvZUtdWqxaLfqAOfqGMFHfKLQ2N6Sq8tnw4utYyhx1D+JHS7g4CLeKaIBw
 IXbDa8va9FS4AjSp1ICSC3PzTARKm/WZCcjO6TohVgjSGGTr+aVghL8jHacH65IaqAl3OiWH
 fhOiCpst3Mkg0wg5DEv7fBRACwsFCTxFZaMX7v41Fu68j331PqNcqK/6jZQ9ddVZjmLU1fGa
 oJavPHu2b+mixQ6i6+Vhz7rneLrgAPhPvnR12Ci1nhfI2Xo5qzeHXe+cM1f9CNuxg++BR/Ca
 fTeY/cns6qNdHk/GjzGHemsHMyTR3NUYPsuJIBG3UW9/f2iZ5EupBLXw==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH] gitignore: added .kas_shell_history
Date: Fri, 27 Jun 2025 14:53:48 +0200
Message-Id: <20250627125348.895382-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Jun 2025 12:53:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19247

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index c657e77..a825b8b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,3 +2,4 @@ build/
 isar/
 __pycache__
 .config.yaml*
+.kas_shell_history
-- 
2.39.5


