Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B6FC3F6B0
	for <webhook@archiver.kernel.org>; Thu, 18 Aug 2022 04:12:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web12.38188.1660795953068685255
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Aug 2022 21:12:33 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155,
 mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 27I4CVG4029037;
 Thu, 18 Aug 2022 13:12:31 +0900
X-Iguazu-Qid: 34tKN94ia25jE9FW5t
X-Iguazu-QSIG: v=2; s=0; t=1660795950; q=34tKN94ia25jE9FW5t;
 m=y28rsl2etG6Bha82S3AzhPXZb5GUHB5fzsJ38ihyz1s=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1511) id 27I4CT5d008349
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Aug 2022 13:12:30 +0900
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 0/4] SWUpdate on BBB
Date: Thu, 18 Aug 2022 09:34:24 +0530
X-TSB-HOP2: ON
Message-Id: <20220818040428.11124-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Aug 2022 04:12:28.0095 (UTC)
 FILETIME=[BA8CDCF0:01D8B2B8]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Aug 2022 04:12:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9284

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

The patches are related to swupdate on BBB using u-boot as bootloader.
I confirmed swupdate on BBB board with all these patches. These patches
are prepared by referring a branch[1] and patches are available at 
isar-cip-core branch[2].

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/cip-sw-updates/swupdate
[2] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/shiva/swupdate-bbb

Shivanand Kunijadar (4):
  U-Boot: Add custom BBB U-Boot and partitioning
  SWUpdate: add SWUpdate
  customizations: add custom modifications for swupdate
  Added README for BBB swupdate

 conf/machine/bbb.conf                         |  23 ++++-
 doc/README.swupdate.bbb.md                    |  90 ++++++++++++++++++
 recipes-bsp/u-boot-bbb/files/boot-bbb.scr.in  |  79 +++++++++++++++
 recipes-bsp/u-boot-bbb/files/fw_env.config    |   1 +
 recipes-bsp/u-boot-bbb/files/ubootenv-bbb     | Bin 0 -> 131072 bytes
 recipes-bsp/u-boot-bbb/u-boot-bbb_2022.05.bb  |  59 ++++++++++++
 recipes-core/customizations/common.inc        |   5 +-
 recipes-core/customizations/files/interfaces  |   6 ++
 recipes-core/images/cip-core-image.bb         |   9 ++
 recipes-core/images/files/sw-description.tmpl |  15 +--
 recipes-core/images/swupdate.inc              |   7 +-
 .../files/swupdate.handler.u-boot.ini         |  26 +++++
 wic/bbb-u-boot.wks.in                         |  13 +++
 13 files changed, 315 insertions(+), 18 deletions(-)
 create mode 100644 doc/README.swupdate.bbb.md
 create mode 100644 recipes-bsp/u-boot-bbb/files/boot-bbb.scr.in
 create mode 100644 recipes-bsp/u-boot-bbb/files/fw_env.config
 create mode 100644 recipes-bsp/u-boot-bbb/files/ubootenv-bbb
 create mode 100644 recipes-bsp/u-boot-bbb/u-boot-bbb_2022.05.bb
 create mode 100644 recipes-core/customizations/files/interfaces
 create mode 100644 recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boot.ini
 create mode 100644 wic/bbb-u-boot.wks.in

-- 
2.20.1



