Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32846CE7AE5
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:14:09 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15685.1763118846899523216
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 03:14:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 3r++9RCcRCCD1WjHuykd2g==
X-CSE-MsgGUID: Nn5FkcR6TUGVCzJAt46iSQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Nov 2025 20:14:06 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.4])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3CDBE4575F02;
	Fri, 14 Nov 2025 20:14:04 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.12.y-cip 0/1] Add RZ/V2H eMMC support
Date: Fri, 14 Nov 2025 11:14:02 +0000
Message-ID: <20251114111403.74450-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 11:14:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20551

Hi,

This series adds support in 6.12.y-cip for the eMMC and microSD sub-boards
connected via the CN15 connector on the RZ/V2H evaluation kit.

Patch was cherry-picked from mainline kernel. Note that only the RZ/V2H
part of the patch was backported, as there is no support currently for
the RZ/V2N SoC in 6.12.y-cip.

Best regards,
Ovidiu

Lad Prabhakar (1):
  arm64: dts: renesas: Add CN15 eMMC and SD overlays for RZ/V2H and
    RZ/V2N EVKs

 arch/arm64/boot/dts/renesas/Makefile          |  6 ++
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    |  9 +++
 .../boot/dts/renesas/rzv2-evk-cn15-emmc.dtso  | 50 ++++++++++++++
 .../boot/dts/renesas/rzv2-evk-cn15-sd.dtso    | 69 +++++++++++++++++++
 4 files changed, 134 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/rzv2-evk-cn15-emmc.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso

-- 
2.51.0


