Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C460BCA5FC5
	for <webhook@archiver.kernel.org>; Wed, 30 Sep 2026 15:09:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15758.1790780973462471825
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Sep 2026 08:09:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=1v+x=hw=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2688160008;
	Wed, 30 Sep 2026 15:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4FE1F000FF;
	Wed, 30 Sep 2026 15:09:30 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 0/4] Backport RZ/G2{E,H,N,M} iommu properties
Date: Wed, 30 Sep 2026 18:09:25 +0300
Message-ID: <20260930150929.597001-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Sep 2026 15:09:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24380

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports the missing IOMMU properties for RZ/G2{E,H,N,M} SoCs.
Without these, some boards fail to boot when CONFIG_MODULES=3Dy and no
other modules are enabled.

Thank you,
Claudiu

Geert Uytterhoeven (4):
  arm64: dts: renesas: r8a774a1: Add missing iommus properties
  arm64: dts: renesas: r8a774b1: Add missing iommus properties
  arm64: dts: renesas: r8a774c0: Add missing iommus properties
  arm64: dts: renesas: r8a774e1: Add missing iommus properties

 arch/arm64/boot/dts/renesas/r8a774a1.dtsi |  6 ++++++
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 26 +++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi |  3 +++
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi |  8 +++++++
 4 files changed, 43 insertions(+)

--=20
2.43.0


