Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADBBC88E58
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 14:03:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40090.1789135374742687457
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 07:02:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=xuxu=hd=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4552F40807;
	Fri, 11 Sep 2026 14:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6211F000FF;
	Fri, 11 Sep 2026 14:02:52 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH linux-6.1.y-cip 0/2] mmc: renesas_sdhi: Backport support for RZ/G2{E,N}
Date: Fri, 11 Sep 2026 17:02:49 +0300
Message-ID: <20260911140251.2119701-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 14:03:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24147

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backport patches to enable SDHI for RZ/G2{E,N} though their
own compatibles.

Thank you,
Claudiu

Lad Prabhakar (2):
  mmc: renesas_sdhi: Add OF entry for RZ/G2N SoC
  mmc: renesas_sdhi: Add OF entry for RZ/G2E SoC

 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 2 ++
 1 file changed, 2 insertions(+)

--=20
2.43.0


