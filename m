Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80415C54E58
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 09:07:53 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.18063.1709629665358118200
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 01:07:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=hDUBdqIV;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-20240305090734d96e15f2e23b9a9d01-qtrgnz@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240305090734d96e15f2e23b9a9d01
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 Mar 2024 10:07:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=5KZk2mp+xoXOAiwM7pVpnlZNlnSvAoSD/7HVOFaDjhY=;
 b=hDUBdqIVv1r36oaH8suVOKCbKjHCHbLKH3hdohtG9BdJ9B7Li2wgdmSjEe2wrA5sZ3NOwE
 LaeyZTAefQOUuDqG0Wl8Db2FGgUMe8eifXuyW2vu5pjvdijMOe4u8q+1qPfdm148iW/wXZxP
 0dGroqSHND/tr94cyfPljzJhfDwTQ=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 3/4] Update Isar to release 0.10
Date: Tue,  5 Mar 2024 10:07:32 +0100
Message-Id: <4d79d4e3a30ffeec2ceb25095e602f7b56dd5827.1709629653.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1709629653.git.jan.kiszka@siemens.com>
References: <cover.1709629653.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 09:07:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15211

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 0b209141..d10161fa 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 07573d7a6030b8b381518387867b6406b1441f09
+    commit: 9dc362cd7115074c0f60843e687ed89db5c9339a
     layers:
       meta:
 
-- 
2.35.3


