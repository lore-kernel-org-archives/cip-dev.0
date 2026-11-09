Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1452.1794209972845047323
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2026 23:39:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=VHv4Lt2Y;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1794209963;x=1795419563;bh=q6
	rxciXzyMj8LVkmb9c4B3KxJgba1F9N05iZlqI1Q2U=;b=VHv4Lt2YW/cCxocSLTdQva44n9eGAXrI
	KGKABNnetXCFBOQvju7qmw5GIx+lkAa/4jRNcs7cC8H+2DhQDfj0kD5UT/9GdYaIoLl2WXh5aorgc
	V9kHAerLj7eA3U/ajubgjgCflEJLEF9c6wVwodB6KmK14qUQPN7vFob1qG7XSJ4BY84m4sf8ZOWli
	2W/XuecHGGzsyuD/S3OlGmgQPmthlAZG1pb8TjEuE9yHW4F+a6UOFQLg/Vz/vaHSEPI7fxMy8PBlY
	bi1LTYD63m2cD7nolLJ0uXyvmJmTkGzotFCdvwNyJLF35OJfZ2EQoV7eozkTXCQRzCF4m7oW1mQbv
	kQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 6A97dMX83592453; Mon, 9 Nov 2026 16:39:22 +0900
X-Iguazu-Qid: 2yAac6huvVr058c8a6
X-Iguazu-QSIG: v=2; s=1; t=1794209962; q=2yAac6huvVr058c8a6; m=lh6mPVM49y3ikBefgGaDE2ZPSrSzOMf5wW1ts3zO3sE=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jNM9j2n6kz1xnZ; Mon,  9 Nov 2026 16:39:21 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org, uli@fpond.eu, biju.das.jz@bp.renesas.com,
        tommaso.merciai.xr@bp.renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 6.1.y-cip 2/5] i3c: renesas: Fix out-of-bounds access for newdevs mask
Date: Mon,  9 Nov 2026 16:39:11 +0900
X-TSB-HOP2: ON
Message-Id: <1794209954-6205-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1794209954-6205-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1794209954-6205-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 07:39:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24681
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 50dec95c9d1f1f82819bc898ef2b60fa83fd4ccd upstream.

When software initiates DAA (Dynamic Address Assignment), the controller
reports the result via the NRSPQP (Normal Response Queue Port Register).
The data length field of the response descriptor, which is accessible
through the NRSPQP register, indicates the number of devices remaining
after DAA. Consequently, when the bus is empty, this field contains the
maximum number of devices supported by the controller (8 for the Renesas
I3C controller).

Adjust the condition that computes the newly discovered devices bitmask
to prevent an out-of-bounds when the I3C bus is empty.

Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260713130545.568657-9-claudiu.beznea+renesas@tuxon.dev
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/i3c/master/renesas-i3c.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-i3c.c
index faf116b70aef..86ea675a97d7 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -705,7 +705,11 @@ static int renesas_i3c_daa(struct i3c_master_controller *m)
 
 	renesas_i3c_wait_xfer(i3c, xfer);
 
-	newdevs = GENMASK(i3c->maxdevs - cmd->rx_count - 1, 0);
+	if (cmd->rx_count >= i3c->maxdevs)
+		newdevs = 0;
+	else
+		newdevs = GENMASK(i3c->maxdevs - cmd->rx_count - 1, 0);
+
 	newdevs &= ~olddevs;
 
 	for (pos = 0; pos < i3c->maxdevs; pos++) {
-- 
2.55.0


