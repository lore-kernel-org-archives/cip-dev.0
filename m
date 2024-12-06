Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617FBE77179
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 09:05:49 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.32981.1733475934872725095
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 01:05:35 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: LLmdEaHXQKeVdBANfo51IQ==
X-CSE-MsgGUID: 7WIqI3jxSfSP8LCUTyT9dA==
X-IronPort-AV: E=Sophos;i="6.12,212,1728918000"; 
   d="scan'208";a="227108023"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Dec 2024 18:05:33 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 88C394009437;
	Fri,  6 Dec 2024 18:05:25 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 0/8] Add RPC-IF support for RZ/G2UL SoC
Date: Fri,  6 Dec 2024 09:05:16 +0000
Message-ID: <20241206090524.66639-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 09:05:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17334

Hi All,

This patch series aims to add RPC-IF support for RZ/G2UL SoC and enable
it on SMARC platform, along with enabling tx width to 4 on RZ/G2L SMARC
platforms.

All the patches have been cherry picked from upstream kernel apart from
patch 1/8.

Cheers,
Prabhakar

Biju Das (5):
  spi: rpc-if: Add missing MODULE_DEVICE_TABLE
  memory: renesas-rpc-if: Use Hi-Z state as the default setting for IOVF
    pins
  arm64: dts: renesas: rzg2lc-smarc-som: Enable 4-bit tx support
  arm64: dts: renesas: rz{g2l,g2lc}-smarc-som: Update partition table
    for spi-nor flash
  arm64: dts: renesas: rzg2ul-smarc-som: Enable serial NOR flash

Lad Prabhakar (1):
  mtd: spi-nor: atmel: Add support for AT25QL128A serial NOR flash

Miquel Raynal (1):
  spi: rpc-if: differentiate between unsupported and invalid requests

Wolfram Sang (1):
  memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting

 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     | 15 +++++--
 .../boot/dts/renesas/rzg2lc-smarc-som.dtsi    | 16 +++++--
 .../boot/dts/renesas/rzg2ul-smarc-som.dtsi    | 45 +++++++++++++++++++
 .../boot/dts/renesas/rzfive-smarc-som.dtsi    |  4 ++
 drivers/memory/renesas-rpc-if.c               | 29 ++++++++----
 drivers/mtd/spi-nor/atmel.c                   |  1 +
 drivers/spi/spi-rpc-if.c                      | 19 +++++---
 include/memory/renesas-rpc-if.h               |  7 ++-
 8 files changed, 112 insertions(+), 24 deletions(-)

-- 
2.43.0


