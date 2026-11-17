Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16051.1794916188301269257
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:49:48 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1DB8B402F4;
	Tue, 17 Nov 2026 11:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126351F000C4;
	Tue, 17 Nov 2026 11:49:46 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 17/34] i3c: renesas: Use the "dev_name:irq_name" format for the interrupt name
Date: Tue, 17 Nov 2026 13:49:03 +0200
Message-ID: <20261117114921.1485204-18-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
References: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:49:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24928
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 0c863015fcd6d58843f0f012b69ae9e22c00d9dc upstream.

Use the "dev_name:irq_name" format for the interrupt names. This makes it
easier to identify interrupts in systems where multiple devices may reque=
st
interrupts with the same name.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260713130545.568657-16-claudiu.beznea+re=
nesas@tuxon.dev
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesa=
s-i3c.c
index 2f6df04c9317..46f0b1fd6538 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -1433,12 +1433,19 @@ static int renesas_i3c_probe(struct platform_devi=
ce *pdev)
 		return ret;
=20
 	for (i =3D 0; i < ARRAY_SIZE(renesas_i3c_irqs); i++) {
+		const char *irqname;
+
 		ret =3D platform_get_irq_byname(pdev, renesas_i3c_irqs[i].name);
 		if (ret < 0)
 			return ret;
=20
+		irqname =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s:%s", dev_name(&=
pdev->dev),
+					 renesas_i3c_irqs[i].desc);
+		if (!irqname)
+			return -ENOMEM;
+
 		ret =3D devm_request_irq(&pdev->dev, ret, renesas_i3c_irqs[i].isr,
-				       0, renesas_i3c_irqs[i].desc, i3c);
+				       0, irqname, i3c);
 		if (ret)
 			return ret;
 	}
--=20
2.43.0

