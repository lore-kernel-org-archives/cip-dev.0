Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359C4CE7AE8
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:13:59 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15562.1763118828799841630
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 03:13:49 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: Ci9xoafbSZeAD5vq/Hzxpw==
X-CSE-MsgGUID: XZkiHdIxRSa8Nv66Epes7g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Nov 2025 20:13:46 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.4])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3D5F54575F02;
	Fri, 14 Nov 2025 20:13:44 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.1.y-cip 0/2] Add RZ/V2H eMMC support
Date: Fri, 14 Nov 2025 11:13:41 +0000
Message-ID: <20251114111343.74438-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 11:13:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20549

Hi,

This series adds support in 6.1.y-cip for the eMMC and microSD sub-boards
connected via the CN15 connector on the RZ/V2H evaluation kit.

Patches were cherry-picked from mainline kernel. Note that only the RZ/V2H
part of the eMMC patch was backported, as there is no support currently for
the RZ/V2N SoC in 6.1.y-cip.

Best regards,
Ovidiu

Andrew Davis (1):
  kbuild: Allow DTB overlays to built from .dtso named source files

Lad Prabhakar (1):
  arm64: dts: renesas: Add CN15 eMMC and SD overlays for RZ/V2H and
    RZ/V2N EVKs

 arch/arm64/boot/dts/renesas/Makefile          |  6 ++
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    |  9 +++
 .../boot/dts/renesas/rzv2-evk-cn15-emmc.dtso  | 50 ++++++++++++++
 .../boot/dts/renesas/rzv2-evk-cn15-sd.dtso    | 69 +++++++++++++++++++
 scripts/Makefile.lib                          |  3 +
 5 files changed, 137 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/rzv2-evk-cn15-emmc.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso

-- 
2.51.0


