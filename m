Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1451.1794209972733448177
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Nov 2026 23:39:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=d2BR03bS;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	Content-Transfer-Encoding;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1794209963;x=1795419563;bh=aP9T50G6wpCE91ZkT/oETJm2wHk1/9oCgjLbuBaz5q4=;b=d2B
	R03bSVzG/xJFL0wlFBUxlO9e6AhvH1mtsw55/g2r4ej3FMZ+FziDAQ9JVlm4yPxovLn9V4gbHs5Q3
	+eegQ5fteMec5zNEvgrHQINqyUmxOwROSPSqCyvwD6Ee1VTOdGs8GlrabQMH6MkihKoExNkJyEmxB
	Og+F4Gg3HdjN0dyl5dQG661F7W/+EVoMGrl/oPdpgoSNBWR3Ku1OreV8itRWNBkU7E6A2TgSmxUB5
	Ehztk2V7OjxDpH7974Qn57/5e7pMLZaVSrLJ8gTJaMs32kGHl5A1qAy0MnH1V519KoaROkddIphP6
	1fBRtMS4BMlur5osf+ZflZKlDQysDvA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 6A97dNw64015947; Mon, 9 Nov 2026 16:39:23 +0900
X-Iguazu-Qid: 2rWgAJSOTq8sGYK8ag
X-Iguazu-QSIG: v=2; s=1; t=1794209963; q=2rWgAJSOTq8sGYK8ag; m=9S82O28XWUjTYwpmE+otELgDbMFORGBKLp/VUEnq0Fo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jNM9k527nz1xng; Mon,  9 Nov 2026 16:39:22 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org, uli@fpond.eu, biju.das.jz@bp.renesas.com,
        tommaso.merciai.xr@bp.renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 6.1.y-cip 3/5] clk: devres: fix cleanup in devm_clk_get_optional_enabled_with_rate()
Date: Mon,  9 Nov 2026 16:39:12 +0900
X-TSB-HOP2: ON
Message-Id: <1794209954-6205-4-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1794209954-6205-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1794209954-6205-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 07:39:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24683
Content-Type: text/plain; charset="utf-8"

From: Onur Özkan <work@onurozkan.dev>

commit 0d4d262c1664365e17e0a5ba2ab79f4db484b44e upstream.

devm_clk_get_optional_enabled_with_rate() registers its cleanup action
before setting the clock rate. If setting the rate fails, it attempts to
disable and unprepare a clock that was never enabled. This issue was
spotted while reviewing "rust: clk: add devres-managed clks" [1].

Register the cleanup action only after successfully preparing and enabling
the clock.

[1]: https://lore.kernel.org/rust-for-linux/20260706-clk-type-state-v5-3-67c5f326a16c@collabora.com

Fixes: 9934a1bd45b2 ("clk: provide devm_clk_get_optional_enabled_with_rate()")
Signed-off-by: Onur Özkan <work@onurozkan.dev>
Reviewed-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/clk/clk-devres.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 5368d92d9b39..09fd5e8fb72c 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -99,6 +99,11 @@ struct clk *devm_clk_get_optional_enabled(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL_GPL(devm_clk_get_optional_enabled);
 
+static void devm_clk_disable_unprepare(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
 struct clk *devm_clk_get_optional_enabled_with_rate(struct device *dev,
 						    const char *id,
 						    unsigned long rate)
@@ -106,8 +111,7 @@ struct clk *devm_clk_get_optional_enabled_with_rate(struct device *dev,
 	struct clk *clk;
 	int ret;
 
-	clk = __devm_clk_get(dev, id, clk_get_optional, NULL,
-			     clk_disable_unprepare);
+	clk = devm_clk_get_optional(dev, id);
 	if (IS_ERR(clk))
 		return ERR_CAST(clk);
 
@@ -119,6 +123,10 @@ struct clk *devm_clk_get_optional_enabled_with_rate(struct device *dev,
 	if (ret)
 		goto out_put_clk;
 
+	ret = devm_add_action_or_reset(dev, devm_clk_disable_unprepare, clk);
+	if (ret)
+		goto out_put_clk;
+
 	return clk;
 
 out_put_clk:
-- 
2.55.0


