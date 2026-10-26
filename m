Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34112.1792979250986764607
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Oct 2026 18:47:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=bf/u3ItZ;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id:In-Reply-To:References;i=
	nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1792979245;x=1794188845;bh=LU
	ryxCs1riFbL0fhiMGHIMHzgd8A0h+cxHDgwkTHsvM=;b=bf/u3ItZN7jJpdldd5TWM20Vp25NQHeY
	rBrzFLw2kj/S21RwCvZ4IViT29j+3AH/5uzBwnAtryDhOvIsyhwIdnLY7CE2OzQKAD2hJdxG+rx39
	MS+8Xt0e7JPC5EhTqvapluR5cDue8m3soUZKtwnmfQA/ynjLzd4QZHtsiD2vIv9I+TeSxJaB2QVHi
	eozX5nTclSBJPxX7K60/72NVSOgSSBSEvyVFnz6Wkmxn5uMXOhcgLEg0bj8zVBEp27WGtUz5CME1d
	ZRS2hIRsT+PNaEjAjVJL3/U6w3oq4/AuXOuwzJkX/9JL/T0cU6tPzQVvGApPignH3+uMcMOQpzHKB
	dA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 69Q1lOQd128375; Mon, 26 Oct 2026 10:47:24 +0900
X-Iguazu-Qid: 2yAaKKNbLebYEEbaxv
X-Iguazu-QSIG: v=2; s=1; t=1792979244; q=2yAaKKNbLebYEEbaxv; m=/gLOWGG15s4NOQI7fNfvpVBbCPqdqophM/KEJdcPYrI=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jCc241lPbzyPZ; Mon, 26 Oct 2026 10:47:24 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: cip-dev@lists.cip-project.org
Cc: pavel@nabladev.com, uli@fpond.eu, tommaso.merciai.xr@bp.renesas.com,
        fabrizio.castro.jz@renesas.com, claudiu.beznea.uj@bp.renesas.com,
        cosmin-gabriel.tanislav.xa@renesas.com,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 6.1.y-cip 2/5] dmaengine: sh: rz-dmac: fix device leak on probe failure
Date: Mon, 26 Oct 2026 10:47:19 +0900
X-TSB-HOP2: ON
Message-Id: <1792979242-32127-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1792979242-32127-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
References: <1792979242-32127-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 01:47:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24527
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Johan Hovold <johan@kernel.org>

commit 9fb490323997dcb6f749cd2660a17a39854600cd upstream.

Make sure to drop the reference taken when looking up the ICU device
during probe also on probe failures (e.g. probe deferral).

Fixes: 7de873201c44 ("dmaengine: sh: rz-dmac: Add RZ/V2H(P) support")
Cc: stable@vger.kernel.org	# 6.16
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Link: https://patch.msgid.link/20251117161258.10679-10-johan@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 drivers/dma/sh/rz-dmac.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 6f16d343a10968..da566fe13c3a6d 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -863,6 +863,13 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	return ret;
 }
 
+static void rz_dmac_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int rz_dmac_parse_of_icu(struct device *dev, struct rz_dmac *dmac)
 {
 	struct device_node *np = dev->of_node;
@@ -885,6 +892,10 @@ static int rz_dmac_parse_of_icu(struct device *dev, struct rz_dmac *dmac)
 		return -ENODEV;
 	}
 
+	ret = devm_add_action_or_reset(dev, rz_dmac_put_device, &dmac->icu.pdev->dev);
+	if (ret)
+		return ret;
+
 	dmac_index = args.args[0];
 	if (dmac_index > RZV2H_MAX_DMAC_INDEX) {
 		dev_err(dev, "DMAC index %u invalid.\n", dmac_index);
@@ -1047,8 +1058,6 @@ static int rz_dmac_remove(struct platform_device *pdev)
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	platform_device_put(dmac->icu.pdev);
-
 	return 0;
 }
 
-- 
2.55.0


