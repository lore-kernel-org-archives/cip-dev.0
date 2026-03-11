Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54345106288F
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 12:36:44 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20384.1773232602165262372
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 05:36:42 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: zDOWYOkuRdynIe0vbDWG8A==
X-CSE-MsgGUID: TirIcPwVRAawJ8CeUjY8wg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 Mar 2026 21:36:40 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.227])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3CCD2400F2D4;
	Wed, 11 Mar 2026 21:36:39 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 0/2] arm64: dts: renesas: r9a09g077/r9a09g087: Add DT nodes for SCI channels 1-5
Date: Wed, 11 Mar 2026 12:36:36 +0000
Message-ID: <20260311123638.25773-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 12:36:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22340

Hi all,

The RZ/T2H and RZ/N2H SoCs expose six SCI controllers; sci0 was already
present in the SoC DTSI. This patch adds the remaining SCI nodes
(sci1-sci5) to the respective SoC DTSIs.

Note the patches have been picked up from upstream and manually merged
to resolve conflicts.

Note, these patches apply on top of the RSPI series [0].

[0] https://lore.kernel.org/all/20260309150619.761962-1-cosmin-gabriel.tanislav.xa@renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (2):
  arm64: dts: renesas: r9a09g077: Add DT nodes for SCI channels 1-5
  arm64: dts: renesas: r9a09g087: Add DT nodes for SCI channels 1-5

 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 70 ++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 70 ++++++++++++++++++++++
 2 files changed, 140 insertions(+)

-- 
2.43.0


