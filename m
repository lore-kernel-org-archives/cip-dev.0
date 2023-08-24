Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5DBC71145
	for <webhook@archiver.kernel.org>; Thu, 24 Aug 2023 10:41:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.7986.1692873684463083201
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Aug 2023 03:41:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 37OAfMjA1262604; Thu, 24 Aug 2023 19:41:22 +0900
X-Iguazu-Qid: 2yAasULiH8P474gvtx
X-Iguazu-QSIG: v=2; s=0; t=1692873682; q=2yAasULiH8P474gvtx; m=LS/1RQGZIbcJ0B0+4dag85ElOxHZ9bUBhQ0Lbpk4KJk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 37OAfLgR2436734
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 24 Aug 2023 19:41:21 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 0/2] Fix reproducible issues due to
Date: Thu, 24 Aug 2023 16:11:17 +0530
X-TSB-HOP2: ON
Message-Id: <20230824104119.5464-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <177DF6549CC2A4D6.6662@lists.cip-project.org>
References: <177DF6549CC2A4D6.6662@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 24 Aug 2023 10:41:19.0585 (UTC) FILETIME=[8474F510:01D9D677]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Aug 2023 10:41:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12843

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Hi,

This series patch fixes the reproducible issues due to filesystem UUID's
are not constant.

Change from v2:
 - Remove "--invariant" option and instead pass the filesystem UUID to
   the mkdosfs.
 - Fix filesystem UUID's for the home and var partitions.

venkata pyla (2):
  ebg-sysparts: Add filesystem UUID's to fat images
  qemu*.wks.in: Add filessystem UUID for reproducible builds

 scripts/lib/wic/plugins/source/efibootguard-boot.py | 4 ++--
 scripts/lib/wic/plugins/source/efibootguard-efi.py  | 4 ++--
 wic/ebg-sysparts.inc                                | 6 +++---
 wic/qemu-amd64-efibootguard-secureboot.wks.in       | 4 ++--
 wic/qemu-arm64-efibootguard-secureboot.wks.in       | 4 ++--
 wic/qemu-arm64-efibootguard.wks.in                  | 4 ++--
 wic/x86-efibootguard.wks.in                         | 4 ++--
 7 files changed, 15 insertions(+), 15 deletions(-)

-- 
2.20.1



