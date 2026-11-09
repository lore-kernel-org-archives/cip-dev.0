Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1500.1794209973042983013
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2026 23:39:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=VaAH14zy;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1794209965;x=1795419565;bh=RP
	Ft+aDJJfZCeZYqyWTk3/lXQgK3n+WfYjpFw1W1q9s=;b=VaAH14zyqt1VBPsiNJNsTSVHl0Q1Bl+b
	P1auVYEwUVa3bzaQpCuxR4FuaNtbs+86ko6rgQq59TN5TUE0Va0C3BQI0wUMpvJk7FR+UNP6YvabW
	OnUBHVl5EP3V7PxoowuPg2B0mzNrzaRavzOU9x/fVLOLzyIxgSOT14149OUtk+I9ylAirAvyhn7Y/
	Nky6IW2ae0NetKUUJXsFEZhHsAHquW2TV+UpToSNK7h8oQYgtU3V7D5DKMg8C42M5KKE15bsL1Mkm
	h2goRDSy2R2LVffr8FPDA8ONzO4vJ810XSbcvHSXx7tXVrOG9e0C76k+3bES43rI31zzBGDUzqYRd
	hQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 6A97dNqa2946960; Mon, 9 Nov 2026 16:39:23 +0900
X-Iguazu-Qid: 2yAaXyEeU2KkivcOcN
X-Iguazu-QSIG: v=2; s=1; t=1794209962; q=2yAaXyEeU2KkivcOcN; m=Pd6JsqA+GHl3MpxmDc0ZfnlPR3a5KDyRf4n829zfrus=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jNM9j70qQzyPm; Mon,  9 Nov 2026 16:39:21 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org, uli@fpond.eu, biju.das.jz@bp.renesas.com,
        tommaso.merciai.xr@bp.renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 6.1.y-cip 5/5] watchdog: rzv2h: Avoid division by zero
Date: Mon,  9 Nov 2026 16:39:14 +0900
X-TSB-HOP2: ON
Message-Id: <1794209954-6205-6-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1794209954-6205-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1794209954-6205-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 07:39:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24686
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Tzung-Bi Shih <tzungbi@kernel.org>

commit 6274281c41efa8dd1aa5234c59ad904ff89d7af4 upstream.

clk_get_rate() could return 0.  Avoid a division by zero panic.

Fixes: f6febd0a30b6 ("watchdog: Add Watchdog Timer driver for RZ/V2H(P)")
Cc: stable@vger.kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Link: https://patch.msgid.link/20260913064851.8239-4-tzungbi@kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[iwamatsu: adjust context]
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/watchdog/rzv2h_wdt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
index 8defd0241213..4c486244fd5b 100644
--- a/drivers/watchdog/rzv2h_wdt.c
+++ b/drivers/watchdog/rzv2h_wdt.c
@@ -207,6 +207,7 @@ static int rzv2h_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rzv2h_wdt_priv *priv;
+	unsigned long rate;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -230,8 +231,12 @@ static int rzv2h_wdt_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(priv->rstc),
 				     "failed to get cpg reset");
 
+	rate = clk_get_rate(priv->oscclk);
+	if (!rate)
+		return dev_err_probe(dev, -EINVAL, "Invalid clock rate\n");
+
 	priv->wdev.max_hw_heartbeat_ms = (MILLI * MAX_TIMEOUT_CYCLES * CLOCK_DIV_BY_256) /
-					 clk_get_rate(priv->oscclk);
+					 rate;
 	dev_dbg(dev, "max hw timeout of %dms\n", priv->wdev.max_hw_heartbeat_ms);
 
 	ret = devm_pm_runtime_enable(dev);
-- 
2.55.0


