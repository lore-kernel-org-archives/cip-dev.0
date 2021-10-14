Return-Path: <SRS0=BjyL=PC=lists.cip-project.org=bounce+64572+6825+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB84C433EF
	for <cip-dev@archiver.kernel.org>; Thu, 14 Oct 2021 09:28:01 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48A3361152
	for <cip-dev@archiver.kernel.org>; Thu, 14 Oct 2021 09:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 48A3361152
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7AaZYY4521723xaFLMpDcw7o; Thu, 14 Oct 2021 02:27:59 -0700
X-Received: from esa2.mentor.iphmx.com (esa2.mentor.iphmx.com [68.232.141.98])
 by mx.groups.io with SMTP id smtpd.web11.7230.1634203679142828414
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Oct 2021 02:27:59 -0700
IronPort-SDR: s7DDKbaM7z7u0RhcnM3DLIDylvDcX78G41M7j2hlLyaf8NCXmUJBcZC4K4r0iJZu2n2C/X82c2
 VXth6lbExhiWmzD108y18p8YR6OFQfiHPxx1UkB7tte+3nbYLjWuzecTD9X6S8fscks+dYDKWA
 nw0IiOqlfg9ztheZ3yhVjQtobxDLm2AS4IB6/aPxIj64TJQL18BMZKQuwXlFgU3aCs0NnkUi//
 QOlcIyI+Xyvvu69czsstOAtWlaWoCTheGLq5CVV47VVAsShEshpsq9uC20av+w2p9fVCfj58Kl
 gYwE1mZnRG3nL3kM4JVo71Uy
X-IronPort-AV: E=Sophos;i="5.85,372,1624348800"; 
   d="scan'208";a="67180551"
X-Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 14 Oct 2021 01:27:57 -0800
IronPort-SDR: KMd+oWcexagrokdyphfbrkvbsOQGE4C6Fw8qIIAY3H+IYiAnRZUk+TjFCAdvhJTtsGPhOYurw9
 tOF6lVSKU41Rchksf21wyy6iKXQDzj7Ndeeuz5B4vVT61nDXvvHsVEKiElmBgnOCgUjZ+NAi+G
 ifNnSOEVZ2uHVY3pFgZiK+2Ig6Ehwf4OqFxQdqGL6n3N4DM01VWXF6vU6RBBkPUpmojeL41+NM
 PQdhLu59xz4ICJbU240mgDqQksRLh+CZN8QDgRS2O5JM0Om95gOd55UCzoo3eGcJe7jyynMwAy
 1OU=
From: "Srinuvasan A" <srinuvasan_a@mentor.com>
To: <cip-dev@lists.cip-project.org>
CC: Srinuvasan A <srinuvasan_a@mentor.com>
Subject: [cip-dev] [isar-cip-dev] [PATCH] Update efibootguard to latest one
Date: Thu, 14 Oct 2021 14:57:37 +0530
Message-ID: <20211014092737.3911919-1-Srinuvasan_A@mentor.com>
MIME-Version: 1.0
X-ClientProxiedBy: SVR-ORW-MBX-07.mgc.mentorg.com (147.34.90.207) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: o9lVQHZHJwFyMITqcebPzac3x4520388AA=
Content-Type: multipart/mixed; boundary="zOzqDOnMxgkTUmpPsF0Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1634203679;
 bh=z54D5W7Wm7HkoImsPpjME+stBLxkwlZUDWektw1rcBo=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=PDTZ4G1faAuHhRWWGYwgiT4MGXYUwFkfg7uOvf+2SLgF7qF6yHKR3WrktkBXRo/DXD3
 PC/i00a7D1MJPzk0kr21xGcpSSjcAHX0kUf8PR3NZye/IWUrLxqQtBWNBx6PnDY7+8ywa
 XsIu/AFumTk87hezPhVOEm6KPIxAWq//B5o=
Message-ID: <20211014092737.LMRaJ4JqDZ9P47abaI_FpJ8UgH-w8ENW1WSZfI3dIk8@z>

--zOzqDOnMxgkTUmpPsF0Z
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

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


--zOzqDOnMxgkTUmpPsF0Z
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6825): https://lists.cip-project.org/g/cip-dev/message/=
6825
Mute This Topic: https://lists.cip-project.org/mt/86308311/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zOzqDOnMxgkTUmpPsF0Z--
