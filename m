Return-Path: <Vijaikumar_Kanagarajan@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A664C433FE
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 13:05:20 +0000 (UTC)
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web11.10264.1639659913028134020
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 05:05:13 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.252, mailfrom: vijaikumar_kanagarajan@mentor.com)
IronPort-SDR: 
 x/aHn7UYsgO19Z5q9YlupFbfW4hph7S4dDtEhPoysUCBttVU4kKwuoNvI3pjI1/ARE+unT1X/D
 J0T0MBF9yPue2w6i/gTMxl0FTBjVD2xZ560fKJ3+xEPB58tvSnMlfGFCyineMRuH+htXRDSUS7
 Teutc1eETUvnQuplpg3yoTqm3SxZbOYgH6wjgCBufRMgmFUjoCCTSwqgCXY/HojTt4eEC5Yegx
 X1/YqCjUwcd3698sbEprkybvPmMhfwj8izwTbc/GT36i4McrF/SiYjiKdn2TDxz80lRlIczs9O
 +Jdj3m0Nolg4+LXvU1grSdt5
X-IronPort-AV: E=Sophos;i="5.88,211,1635235200";
   d="scan'208";a="69782845"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 16 Dec 2021 05:05:10 -0800
IronPort-SDR: 
 HQ5n46cC8JudPo68dZMzQZrkzK/PGNkEBbmBWlG45dWoRRsBkwYrjzjAzXa3lZ1S5vtldrxpoZ
 5Sfi7LBHsl47gM2bCcNkoyppkuIQpmLEOOt+jRdsryWkG9S9qw2erg9aUMP050J8d7F9gh3cr6
 /x9oWBQx3PMqPQIXgcNn/VBn9vqWmSC0Cn9gXeDJ4l9xIsUifAMO7fc2erHvjS1mHb1SJvjsjT
 +s7pIqtDj07Q6+9cP3Xf6aSkYd8tn7VN3shJm5jaJrnIO6mGAqj7NUMu/GLydZ10j1o4hOOqp7
 vTo=
From: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
Subject: [isar-cip-core][PATCH 0/2] Drop Stretch support
Date: Thu, 16 Dec 2021 18:34:48 +0530
Message-ID: <20211216130450.3402865-1-Vijaikumar_Kanagarajan@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SVR-ORW-MBX-05.mgc.mentorg.com (147.34.90.205) To
 svr-orw-mbx-01.mgc.mentorg.com (147.34.90.201)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 13:05:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7148

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

 Kconfig                                        |  4 ----
 conf/distro/cip-core-stretch.conf              | 16 ----------------
 conf/machine/bbb.conf                          |  4 ----
 kas/opt/stretch.yml                            | 15 ---------------
 .../swupdate/swupdate_2021.04-1+debian-gbp.bb  | 18 ++++++++----------
 start-qemu.sh                                  |  2 --
 6 files changed, 8 insertions(+), 51 deletions(-)
 delete mode 100644 conf/distro/cip-core-stretch.conf
 delete mode 100644 kas/opt/stretch.yml

-- 
2.25.1


