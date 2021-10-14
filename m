Return-Path: <srinuvasan_a@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217D7C433F5
	for <webhook@archiver.kernel.org>; Thu, 14 Oct 2021 09:28:00 +0000 (UTC)
Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web11.7230.1634203679142828414
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Oct 2021 02:27:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.141.98, mailfrom: srinuvasan_a@mentor.com)
IronPort-SDR: 
 s7DDKbaM7z7u0RhcnM3DLIDylvDcX78G41M7j2hlLyaf8NCXmUJBcZC4K4r0iJZu2n2C/X82c2
 VXth6lbExhiWmzD108y18p8YR6OFQfiHPxx1UkB7tte+3nbYLjWuzecTD9X6S8fscks+dYDKWA
 nw0IiOqlfg9ztheZ3yhVjQtobxDLm2AS4IB6/aPxIj64TJQL18BMZKQuwXlFgU3aCs0NnkUi//
 QOlcIyI+Xyvvu69czsstOAtWlaWoCTheGLq5CVV47VVAsShEshpsq9uC20av+w2p9fVCfj58Kl
 gYwE1mZnRG3nL3kM4JVo71Uy
X-IronPort-AV: E=Sophos;i="5.85,372,1624348800";
   d="scan'208";a="67180551"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 14 Oct 2021 01:27:57 -0800
IronPort-SDR: 
 KMd+oWcexagrokdyphfbrkvbsOQGE4C6Fw8qIIAY3H+IYiAnRZUk+TjFCAdvhJTtsGPhOYurw9
 tOF6lVSKU41Rchksf21wyy6iKXQDzj7Ndeeuz5B4vVT61nDXvvHsVEKiElmBgnOCgUjZ+NAi+G
 ifNnSOEVZ2uHVY3pFgZiK+2Ig6Ehwf4OqFxQdqGL6n3N4DM01VWXF6vU6RBBkPUpmojeL41+NM
 PQdhLu59xz4ICJbU240mgDqQksRLh+CZN8QDgRS2O5JM0Om95gOd55UCzoo3eGcJe7jyynMwAy
 1OU=
From: Srinuvasan A <Srinuvasan_A@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [isar-cip-dev] [PATCH] Update efibootguard to latest one
Date: Thu, 14 Oct 2021 14:57:37 +0530
Message-ID: <20211014092737.3911919-1-Srinuvasan_A@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Oct 2021 09:28:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6825

From: Srinuvasan A <srinuvasan_a@mentor.com>

Update efibootguard to latest one.

Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
---
 recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb b/recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb
index ebd848d..4e7b9b2 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.8-git+isar.bb
@@ -22,7 +22,7 @@ SRC_URI = "git://github.com/siemens/efibootguard.git;branch=master;protocol=http
 
 S = "${WORKDIR}/git"
 
-SRCREV = "ac1685aea75fb3e3d16c0c0e4f8261a2edb63536"
+SRCREV = "66d78b8d96e80caaf20007f08b5ca720de628d49"
 
 PROVIDES = "${PN}"
 PROVIDES += "${PN}-dev"
-- 
2.25.1


