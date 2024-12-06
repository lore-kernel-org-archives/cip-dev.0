Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5893E77173
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 09:11:29 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.33049.1733476286198683087
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 01:11:26 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: GUjejRO2STmUNWSKnDGYJw==
X-CSE-MsgGUID: enKvjEYrQWmRVJ1SmbPZag==
X-IronPort-AV: E=Sophos;i="6.12,213,1728918000"; 
   d="scan'208";a="231085654"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Dec 2024 18:11:25 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 25C7E41F3D94;
	Fri,  6 Dec 2024 18:11:23 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 00/16] Add RPC-IF support for RZ/G2UL SoC
Date: Fri,  6 Dec 2024 09:11:06 +0000
Message-ID: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 09:11:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17343

Hi All,

This patch series aims to add RPC-IF support for RZ/G2UL SoC and enable it
on SMARC platform, along with enabling tx width to 4 on RZ/G2L SMARC
platforms.

All the patches have been cherry picked from upstream kernel.

Cheers,
Prabhakar

Biju Das (5):
  spi: rpc-if: Add missing MODULE_DEVICE_TABLE
  memory: renesas-rpc-if: Use Hi-Z state as the default setting for IOVF
    pins
  arm64: dts: renesas: rzg2ul-smarc-som: Enable serial NOR flash
  arm64: dts: renesas: rzg2lc-smarc-som: Enable 4-bit tx support
  arm64: dts: renesas: rz{g2l,g2lc}-smarc-som: Update partition table
    for spi-nor flash

Cong Dang (1):
  memory: renesas-rpc-if: Remove redundant division of dummy

Geert Uytterhoeven (2):
  memory: renesas-rpc-if: Always use dev in rpcif_probe()
  memory: renesas-rpc-if: Improve Runtime PM handling

Michael Walle (6):
  mtd: spi-nor: sysfs: hide manufacturer if it is not set
  mtd: spi-nor: remember full JEDEC flash ID
  mtd: spi-nor: move function declaration out of sfdp.h
  mtd: spi-nor: fix select_uniform_erase to skip 0 erase size
  mtd: spi-nor: add generic flash driver
  mtd: spi-nor: sysfs: print JEDEC ID for generic flash driver

Miquel Raynal (1):
  spi: rpc-if: differentiate between unsupported and invalid requests

Wolfram Sang (1):
  memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting

 .../ABI/testing/sysfs-bus-spi-devices-spi-nor |  3 +
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     | 15 ++--
 .../boot/dts/renesas/rzg2lc-smarc-som.dtsi    | 16 +++--
 .../boot/dts/renesas/rzg2ul-smarc-som.dtsi    | 45 ++++++++++++
 .../boot/dts/renesas/rzfive-smarc-som.dtsi    |  4 ++
 drivers/memory/renesas-rpc-if.c               | 70 ++++++++++++-------
 drivers/mtd/spi-nor/core.c                    | 35 +++++++++-
 drivers/mtd/spi-nor/core.h                    |  3 +
 drivers/mtd/spi-nor/debugfs.c                 |  2 +-
 drivers/mtd/spi-nor/sfdp.c                    | 27 +++++++
 drivers/mtd/spi-nor/sfdp.h                    |  2 -
 drivers/mtd/spi-nor/sysfs.c                   |  8 ++-
 drivers/spi/spi-rpc-if.c                      | 19 +++--
 include/linux/mtd/spi-nor.h                   |  3 +
 14 files changed, 207 insertions(+), 45 deletions(-)

-- 
2.43.0


