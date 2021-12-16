Return-Path: <Vijaikumar_Kanagarajan@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930FEC433EF
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 13:36:40 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web10.10615.1639661796675434522
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 05:36:36 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: vijaikumar_kanagarajan@mentor.com)
IronPort-SDR: 
 c24q2YCZ36JxLy49Lu/69iaPQT/fseaE3xe/X1FhrvccQvpyAWxrF9K4EHVA2Or2wkWAjRR86o
 vDuSsThU/KBq0PddJw0jR9vGStSQ4hEntfxAWm5/67medEPfiEDFMtQBk7oEhe/laELHL4e7xP
 BPzIvHiZ+aYAMTOTviNykl80gs6YPg0dUTNBLnOs7Xu82tRakxmdXE2ThkzuMv3jyyJbBV/aUh
 B3kNmOoHeLdakEliSHMGG4Bm6TWNYo+zm1IJ0crg+ugJBAxied09OjWfSu3+w5gFJ/amcd+YrA
 VYXYovThfv85vtLMMArtb1aA
X-IronPort-AV: E=Sophos;i="5.88,211,1635235200";
   d="scan'208";a="69632699"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 16 Dec 2021 05:36:35 -0800
IronPort-SDR: 
 J9jlIz9HYsTrnzm3s8s6Z4am/5fmAdAwIwtcsR0HvjFi6UzwpgJllWSzV9/w8Neo2P9CGUKu2c
 IuIDow8EYL6hAuoiVABQczxPm9h0Rv6kZRhoGfszAejof8Kn68Aq1Up+SSP7CLW4T/jtQNt7KY
 QEFW3g+zxx37vZ8TTiHEK9sCuxv2WBj6bEjXt33FreLaZ05CfxCmCR/zNa87nxpyKbsW29nyza
 /CLruYG9u8L/OOflA0WLss6IMTLQTr+NYpatGou2iFUOnWSS7zjV6xZ1u2OH74d9NgBAezyENz
 MvY=
From: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
Subject: [isar-cip-core][PATCH v2 0/2] Drop Stretch support
Date: Thu, 16 Dec 2021 19:06:15 +0530
Message-ID: <20211216133617.3403412-1-Vijaikumar_Kanagarajan@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-05.mgc.mentorg.com (147.34.90.205) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 13:36:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7155

Changes since v1:
- Change P1 commit message
- Bring back conditional include of buster patch for swupdate

This series has 2 patches

P1 drops stretch support
P2 cleans up overrides / conditional includes for buster/bullseye

CI Job is successful:
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/430980698

Thanks,
Vijai Kumar K

Vijai Kumar K (2):
  Drop stretch support
  swupdate: Drop conditional includes for buster

 Kconfig                                          |  4 ----
 conf/distro/cip-core-stretch.conf                | 16 ----------------
 conf/machine/bbb.conf                            |  4 ----
 kas/opt/stretch.yml                              | 15 ---------------
 .../swupdate/swupdate_2021.04-1+debian-gbp.bb    | 12 ++++++------
 start-qemu.sh                                    |  2 --
 6 files changed, 6 insertions(+), 47 deletions(-)
 delete mode 100644 conf/distro/cip-core-stretch.conf
 delete mode 100644 kas/opt/stretch.yml

-- 
2.25.1


