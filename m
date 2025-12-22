Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097DFE6749A
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:21 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78197.1766402233761841616
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OgiSeGlE;
 spf=pass (domain: gmail.com, ip: 209.85.218.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7636c96b9aso665643966b.2
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402232; x=1767007032; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5t1dXKI/rcHKkOBOh0/moCRK9y6fLQVu/rFLTaITtNE=;
        b=OgiSeGlEWAQW1Rufk9Tlwt1LZuDZhuMUWW/XLM5EVlrEfBp+dNMmfOP3FKfprDhdx/
         WFZcRwdp9cJBf719dL/SfTotIArQwH5Caqeal8aSvt3Nh0zSNmEgHuRFsbJoCa7nsWj/
         bCHJ54ygolTAeHMTMqNTjML2nGtfuF1/FmW6Hj9ocW5aRDhizcb6rKgOW629R5mEiiDW
         AGAm+dEngXaZFmoDbQBJa/KSgmw02oHXx/gCu1ucj9gKt7n/PxaY/oKmLyYv1w9Zsv4M
         IBSqpbohFpZR2AbMrqHo5TP94hOSQu6EaGfgoiZFvZQ+t2ORSK1m4ELnpKMdIDf6Ypfu
         obWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402232; x=1767007032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5t1dXKI/rcHKkOBOh0/moCRK9y6fLQVu/rFLTaITtNE=;
        b=I8ssmkEW+tl4NXfPzLdWQ/kMsn8tTRL6OKLS4VLgmWLOzjgB9egMyp0T/10R7HT31q
         i/Ac3wVZ2kdPL1b2sEf7Rrc6yDv9EHYHjc90oDUsA8yYmlMU6Bbpqldu7UKlxfji6jEY
         35giWK2PwwlMb33nFRgpGaqv+QSsvp6W1AKe4/tf2OUmzUFVL+5oG5lsVIO/KwuAZhAI
         58AsFQME4VNmh6VwuEXBvTFUhhvhj7nUlXoyLMmW6c0Q9UChB33ipb3v5A0ZMJzx5FGf
         11XaCOykeZkfCcCXSdlUHMZO5DMMHUOUqyRi2Evokvy2q98qlF9N9STwu8+x+bkTbq9n
         xcSw==
X-Gm-Message-State: AOJu0YxJBl9dbKIgtJwQ7kgFEHGBHhZWZUSbiSZz86J/yB5k1xeQpRzK
	H/BfcBCBI+2eE5I1msZqQf6bZTSefzPIZcKF7KVEBe9S5qPRsUMcBeVM1UnKhw==
X-Gm-Gg: AY/fxX7ileRqIYssL+HTJviMTgQ/6gBAKlUab04cVUv1IinaNbrglOma0811j3ufrQI
	R7g1Oi5aJ47yOhwAFnJRNRd1sGXetZ1mcb7rUJ5+I3CFe3evwr/wc5Cjuy0qR4ES0iqg3V+x0Bu
	Ihngz/F92m7lE3sgKhdhcmRDP1yyu0USv2XqZ7ziids5N7HWsCJSpIuT7Vu+Nwe6umuFSZ33l/f
	8BX6y6KSHHoJHQJJVJNzpbugFjasexGy4PDYqPzgqPQ+xfz6pVViH20kUl2O1cS76JA5VnvtSLA
	PTHP2YQk6VM+BX2J4zAlrwvFDYydjbdfKPHF7WGDfqeehlbSQemFV3+riCv+TABHpsuG7dwGy4V
	uC+Wnwp+6jsKqrmxn3wBRMs8m22kYtWApDZL/NLatNrBXYxbwpM+IvdQqBo4FutLoU+UggG6po/
	4et00bLnYLBtgeLkoShOw/G9W/iCDOLq5fnuQ=
X-Google-Smtp-Source: AGHT+IGmyonpUtfd5eizWENA/wDGZZPIRv9n9DtsydyUZi9XRdMJAJBJILeEsEMJ/YdJGG7LrYqKSw==
X-Received: by 2002:a17:907:984:b0:b72:3765:eda9 with SMTP id a640c23a62f3a-b8037256c76mr1109744966b.60.1766402231753;
        Mon, 22 Dec 2025 03:17:11 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:11 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 11/24] can: rcar_canfd: Describe channel-specific FD registers using C struct
Date: Mon, 22 Dec 2025 11:16:43 +0000
Message-ID: <20251222111705.27028-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21197

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit ab2aa5453bb83d05e764a1207a61109c6fd4fe4c ]

The rcar_canfd_f_*() inline functions to obtain channel-specific CAN-FD
register offsets really describe a memory layout.  Hence replace them by
a C structure, to simplify the code, and reduce kernel size.

This also gets rid of warnings about unused rcar_canfd_f_*() inline
functions, which are reported by recent versions of clang.

Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/20250618183827.5bebca8f@kernel.org
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/292b75b3bc8dd95f805f0223f606737071c8cf86.1750327217.git.geert+renesas@glider.be
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 64 +++++++++++++------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index ec6790d11fec..2c1b0f0912bf 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -439,6 +439,16 @@
 
 /* CAN FD mode specific register map */
 
+/* RSCFDnCFDCmXXX -> gpriv->fcbase[m].xxx */
+struct rcar_canfd_f_c {
+	u32 dcfg;
+	u32 cfdcfg;
+	u32 cfdctr;
+	u32 cfdsts;
+	u32 cfdcrc;
+	u32 pad[3];
+};
+
 /* RSCFDnCFDGAFLXXXj offset */
 #define RCANFD_F_GAFL_OFFSET		(0x1000)
 
@@ -564,6 +574,7 @@ struct rcar_canfd_channel {
 struct rcar_canfd_global {
 	struct rcar_canfd_channel *ch[RCANFD_NUM_CHANNELS];
 	void __iomem *base;		/* Register base address */
+	struct rcar_canfd_f_c __iomem *fcbase;
 	struct platform_device *pdev;	/* Respective platform device */
 	struct clk *clkp;		/* Peripheral clock */
 	struct clk *can_clk;		/* fCAN clock */
@@ -803,6 +814,16 @@ static void rcar_canfd_update_bit(void __iomem *base, u32 reg,
 	rcar_canfd_update(mask, val, base + reg);
 }
 
+static void rcar_canfd_set_bit_reg(void __iomem *addr, u32 val)
+{
+	rcar_canfd_update(val, val, addr);
+}
+
+static void rcar_canfd_update_bit_reg(void __iomem *addr, u32 mask, u32 val)
+{
+	rcar_canfd_update(mask, val, addr);
+}
+
 static void rcar_canfd_get_data(struct rcar_canfd_channel *priv,
 				struct canfd_frame *cf, u32 off)
 {
@@ -825,37 +846,6 @@ static void rcar_canfd_put_data(struct rcar_canfd_channel *priv,
 		rcar_canfd_write(priv->base, off + i * sizeof(u32), data[i]);
 }
 
-/* RSCFDnCFDCmXXX -> rcar_canfd_f_xxx(gpriv, ch) */
-static inline unsigned int rcar_canfd_f_dcfg(struct rcar_canfd_global *gpriv,
-					     unsigned int ch)
-{
-	return gpriv->info->regs->coffset + 0x00 + 0x20 * ch;
-}
-
-static inline unsigned int rcar_canfd_f_cfdcfg(struct rcar_canfd_global *gpriv,
-					       unsigned int ch)
-{
-	return gpriv->info->regs->coffset + 0x04 + 0x20 * ch;
-}
-
-static inline unsigned int rcar_canfd_f_cfdctr(struct rcar_canfd_global *gpriv,
-					       unsigned int ch)
-{
-	return gpriv->info->regs->coffset + 0x08 + 0x20 * ch;
-}
-
-static inline unsigned int rcar_canfd_f_cfdsts(struct rcar_canfd_global *gpriv,
-					       unsigned int ch)
-{
-	return gpriv->info->regs->coffset + 0x0c + 0x20 * ch;
-}
-
-static inline unsigned int rcar_canfd_f_cfdcrc(struct rcar_canfd_global *gpriv,
-					       unsigned int ch)
-{
-	return gpriv->info->regs->coffset + 0x10 + 0x20 * ch;
-}
-
 static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
 {
 	u32 i;
@@ -883,8 +873,7 @@ static void rcar_canfd_set_mode(struct rcar_canfd_global *gpriv)
 
 		for_each_set_bit(ch, &gpriv->channels_mask,
 				 gpriv->info->max_channels)
-			rcar_canfd_set_bit(gpriv->base,
-					   rcar_canfd_f_cfdcfg(gpriv, ch), val);
+			rcar_canfd_set_bit_reg(&gpriv->fcbase[ch].cfdcfg, val);
 	} else {
 		if (gpriv->fdmode)
 			rcar_canfd_set_bit(gpriv->base, RCANFD_GRMCFG,
@@ -1534,7 +1523,7 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 	cfg = (RCANFD_DCFG_DTSEG1(gpriv, tseg1) | RCANFD_DCFG_DBRP(brp) |
 	       RCANFD_DCFG_DSJW(gpriv, sjw) | RCANFD_DCFG_DTSEG2(gpriv, tseg2));
 
-	rcar_canfd_write(priv->base, rcar_canfd_f_dcfg(gpriv, ch), cfg);
+	writel(cfg, &gpriv->fcbase[ch].dcfg);
 
 	/* Transceiver Delay Compensation */
 	if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_AUTO) {
@@ -1547,8 +1536,8 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		tdco = min(tdc->tdcv + tdc->tdco, tdc_const->tdco_max) - 1;
 	}
 
-	rcar_canfd_update_bit(gpriv->base, rcar_canfd_f_cfdcfg(gpriv, ch), mask,
-			      tdcmode | FIELD_PREP(RCANFD_FDCFG_TDCO, tdco));
+	rcar_canfd_update_bit_reg(&gpriv->fcbase[ch].cfdcfg, mask,
+				  tdcmode | FIELD_PREP(RCANFD_FDCFG_TDCO, tdco));
 }
 
 static int rcar_canfd_start(struct net_device *ndev)
@@ -1862,7 +1851,7 @@ static int rcar_canfd_rx_poll(struct napi_struct *napi, int quota)
 static unsigned int rcar_canfd_get_tdcr(struct rcar_canfd_global *gpriv,
 					unsigned int ch)
 {
-	u32 sts = rcar_canfd_read(gpriv->base, rcar_canfd_f_cfdsts(gpriv, ch));
+	u32 sts = readl(&gpriv->fcbase[ch].cfdsts);
 	u32 tdcr = FIELD_GET(RCANFD_FDSTS_TDCR, sts);
 
 	return tdcr & (gpriv->info->tdc_const->tdcv_max - 1);
@@ -2171,6 +2160,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		goto fail_dev;
 	}
 	gpriv->base = addr;
+	gpriv->fcbase = addr + gpriv->info->regs->coffset;
 
 	/* Request IRQ that's common for both channels */
 	if (info->shared_global_irqs) {
-- 
2.43.0


