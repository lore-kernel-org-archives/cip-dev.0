Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E986C88E53
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 12:23:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21609.1789475005865617258
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Sep 2026 05:23:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.105.4.254, mailfrom: srs0=yjg9=hh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6AE46600D1;
	Tue, 15 Sep 2026 12:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0721F00893;
	Tue, 15 Sep 2026 12:23:22 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: claudiu.beznea@tuxon.dev,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH linux-5.10.y-cip 0/2] Backport RZ/G2L GPIO set_config functionality
Date: Tue, 15 Sep 2026 15:23:19 +0300
Message-ID: <20260915122321.2531353-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Sep 2026 12:23:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24182

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series backports RZ/G2L GPIO set_config functionality.

Thank you,
Claudiu

Claudiu Beznea (2):
  pinctrl: renesas: rzg2l: Use -ENOTSUPP instead of -EOPNOTSUPP
  pinctrl: renesas: rzg2l: Populate struct gpio_chip::set_config

 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--=20
2.43.0


