Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBD1105D279
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:08 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18640.1773227047919651445
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=rFZeT0bp;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48374014a77so165549285e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227046; x=1773831846; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4YeGpkPXsY+wCacfxPGS9043KwrQxJRyDJiQ1ZNPm4=;
        b=rFZeT0bp1HvHjE9cuVdOfwy1pH/BGgnuo9IrLRAAUaRhLLveSq2tPhNTCJIjvOwdhN
         SWXYlExJC1hG6F9lXB/DbLqrO8VDAj8Ez5YmPSE6ODb4rK1cXlZLmwSFOznNmm7LcwcP
         m38nmgC9qh784OfKylzixB5R00niefirHSE7hJBcqwz4gS4YT18m8O2LqPcb5O5E49Dp
         6x7GNK20/PRcZDXP4eJBBDTwPDF8FT1v7cjkvHAQBwRyeGTi4Oj33XNNYcEQtv30M7l4
         4TOrM8b7pFrWH26emF7tkAhTLUdMf0b2MziO6kzhBjttMGa3poi57WEne+IGg3LcRcZD
         qtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227046; x=1773831846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C4YeGpkPXsY+wCacfxPGS9043KwrQxJRyDJiQ1ZNPm4=;
        b=bggeMzX1YjsZ5X75P5UCFJJ3KaCUjyBzFyh6JnIKC8WjzyBestK/IecTtqOfK2oFvH
         q+5JDII5oQXiHB7Zi9epWnVr9sWPYY1AyGUMlXmVfSWuGvhQB8dNaFuE5MK1BxI6of2k
         L1I/9L+vP8a4gAt3a5SamkEL0lYNU/mXNKgTbsA2pfIVQZXaHnEGhV5DOwPOtK62aU85
         hNIOu40lRtMh+z3RzfqzJTNJR//ZrjMDteAZzlm6rM4U0P7ixIFRWpEHFhtcjXlKRM5X
         vlDsOB+is5/88mx0/MHOfi3z1A9P8hl6J3y+CzY3gW2VgoVYuzbdlyKmHOv4CGZrfPXV
         PaLw==
X-Gm-Message-State: AOJu0Yw2tzBtrjFgow3y8GSaJ7/JtJi4im86rc+LFsDAtULMUtm2FJv9
	/FKhZl6f2YYlEbsGEQIjAW3pxoT0SiF00jdxTXAKr13xhZOkVDf7MGxoHmg3J5Xg25Y=
X-Gm-Gg: ATEYQzyZzTBdLat9zeRbqlrrag7ZFHd84SGFnxTbKZn9Q80wT/guobxgV4ZNNcxyoco
	wSt9+xLeM4c+F6N95OxNxiICxCDtUeBMI8auf3xsSjtxSYeEwCafFwKaMil7ZmI8Foof7/1EbtK
	lX5CR667NlCjaKEReXPz5WPCLuo+SBcuT4JlCkgSZ8UWeQJWUM5HqfnWeIMokOMMfeQSfkGVv93
	TRWdl5udvO/CrAvzy61vM1FH3wv7mjmPSsW1ehMDnD6YM0d/j5wQIai7NrYf+v70tudSpdL6Tll
	ecbNRZ+u5vrt6cHUPLF5CIV7zHyMHI4mOqFCilj+p23Hx53dW0ptue4QFdkHu2f6pcboSpDhyBJ
	cWD0eG80LP7oWy9W1saXXr5sz4finVI/6VOpX6MEl+5w6sf8ktcZ2EE1RbvbMENi1dR4l+i7MsY
	E6ZzhC2BjGV1GVOHJ1lk34wcU3yd/t+8Y+MVpt6ku4oGnRPxA5HcfB
X-Received: by 2002:a05:600c:1e88:b0:485:3ff1:d5c3 with SMTP id 5b1f17b1804b1-4854b0cb356mr34793405e9.5.1773227046062;
        Wed, 11 Mar 2026 04:04:06 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:05 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 05/28] soc: renesas: rz-sysc: Populate readable_reg/writeable_reg in regmap config
Date: Wed, 11 Mar 2026 13:03:34 +0200
Message-ID: <20260311110357.1938200-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22284

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c432180a7d95081353a96fd6d5bd75b0fc8a27c3 upstream.

Not all system controller registers are accessible from Linux. Accessing
such registers generates synchronous external abort. Populate the
readable_reg and writeable_reg members of the regmap config to inform the
regmap core which registers can be accessed. The list will need to be
updated whenever new system controller functionality is exported through
regmap.

Fixes: 2da2740fb9c8 ("soc: renesas: rz-sysc: Add syscon/regmap support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251105070526.264445-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: dropped sysc file for:
 - RZ/G3E (drivers/soc/renesas/r9a09g047-sys.c)
 - RZ/V2N (drivers/soc/renesas/r9a09g056-sys.c)
 - RZ/V2H (drivers/soc/renesas/r9a09g057-sys.c)
 as these are not present in v5.10 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/soc/renesas/r9a08g045-sysc.c | 69 ++++++++++++++++++++++++++++
 drivers/soc/renesas/rz-sysc.c        |  2 +
 drivers/soc/renesas/rz-sysc.h        |  4 ++
 3 files changed, 75 insertions(+)

diff --git a/drivers/soc/renesas/r9a08g045-sysc.c b/drivers/soc/renesas/r9a08g045-sysc.c
index 0504d4e68761..03d653d5cde5 100644
--- a/drivers/soc/renesas/r9a08g045-sysc.c
+++ b/drivers/soc/renesas/r9a08g045-sysc.c
@@ -6,10 +6,29 @@
  */
 
 #include <linux/bits.h>
+#include <linux/device.h>
 #include <linux/init.h>
 
 #include "rz-sysc.h"
 
+#define SYS_XSPI_MAP_STAADD_CS0		0x348
+#define SYS_XSPI_MAP_ENDADD_CS0		0x34c
+#define SYS_XSPI_MAP_STAADD_CS1		0x350
+#define SYS_XSPI_MAP_ENDADD_CS1		0x354
+#define SYS_GETH0_CFG			0x380
+#define SYS_GETH1_CFG			0x390
+#define SYS_PCIE_CFG			0x3a0
+#define SYS_PCIE_MON			0x3a4
+#define SYS_PCIE_ERR_MON		0x3ac
+#define SYS_PCIE_PHY			0x3b4
+#define SYS_I2C0_CFG			0x400
+#define SYS_I2C1_CFG			0x410
+#define SYS_I2C2_CFG			0x420
+#define SYS_I2C3_CFG			0x430
+#define SYS_I3C_CFG			0x440
+#define SYS_USB_PWRRDY			0xd70
+#define SYS_PCIE_RST_RSM_B		0xd74
+
 static const struct rz_sysc_soc_id_init_data rzg3s_sysc_soc_id_init_data __initconst = {
 	.family = "RZ/G3S",
 	.id = 0x85e0447,
@@ -18,7 +37,57 @@ static const struct rz_sysc_soc_id_init_data rzg3s_sysc_soc_id_init_data __initc
 	.specific_id_mask = GENMASK(27, 0),
 };
 
+static bool rzg3s_regmap_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case SYS_XSPI_MAP_STAADD_CS0:
+	case SYS_XSPI_MAP_ENDADD_CS0:
+	case SYS_XSPI_MAP_STAADD_CS1:
+	case SYS_XSPI_MAP_ENDADD_CS1:
+	case SYS_GETH0_CFG:
+	case SYS_GETH1_CFG:
+	case SYS_PCIE_CFG:
+	case SYS_PCIE_MON:
+	case SYS_PCIE_ERR_MON:
+	case SYS_PCIE_PHY:
+	case SYS_I2C0_CFG:
+	case SYS_I2C1_CFG:
+	case SYS_I2C2_CFG:
+	case SYS_I2C3_CFG:
+	case SYS_I3C_CFG:
+	case SYS_USB_PWRRDY:
+	case SYS_PCIE_RST_RSM_B:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool rzg3s_regmap_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case SYS_XSPI_MAP_STAADD_CS0:
+	case SYS_XSPI_MAP_ENDADD_CS0:
+	case SYS_XSPI_MAP_STAADD_CS1:
+	case SYS_XSPI_MAP_ENDADD_CS1:
+	case SYS_PCIE_CFG:
+	case SYS_PCIE_PHY:
+	case SYS_I2C0_CFG:
+	case SYS_I2C1_CFG:
+	case SYS_I2C2_CFG:
+	case SYS_I2C3_CFG:
+	case SYS_I3C_CFG:
+	case SYS_USB_PWRRDY:
+	case SYS_PCIE_RST_RSM_B:
+		return true;
+	default:
+		return false;
+	}
+}
+
 const struct rz_sysc_init_data rzg3s_sysc_init_data __initconst = {
 	.soc_id_init_data = &rzg3s_sysc_soc_id_init_data,
+	.readable_reg = rzg3s_regmap_readable_reg,
+	.writeable_reg = rzg3s_regmap_writeable_reg,
 	.max_register = 0xe20,
 };
diff --git a/drivers/soc/renesas/rz-sysc.c b/drivers/soc/renesas/rz-sysc.c
index 115961483845..805994c9710e 100644
--- a/drivers/soc/renesas/rz-sysc.c
+++ b/drivers/soc/renesas/rz-sysc.c
@@ -127,6 +127,8 @@ static int rz_sysc_probe(struct platform_device *pdev)
 	regmap_cfg->val_bits = 32;
 	regmap_cfg->fast_io = true;
 	regmap_cfg->max_register = data->max_register;
+	regmap_cfg->readable_reg = data->readable_reg;
+	regmap_cfg->writeable_reg = data->writeable_reg;
 
 	regmap = devm_regmap_init_mmio(dev, sysc->base, regmap_cfg);
 	if (IS_ERR(regmap))
diff --git a/drivers/soc/renesas/rz-sysc.h b/drivers/soc/renesas/rz-sysc.h
index 8a3507989c04..5b85b6431a47 100644
--- a/drivers/soc/renesas/rz-sysc.h
+++ b/drivers/soc/renesas/rz-sysc.h
@@ -29,10 +29,14 @@ struct rz_sysc_soc_id_init_data {
 /**
  * struct rz_sysc_init_data - RZ SYSC initialization data
  * @soc_id_init_data: RZ SYSC SoC ID initialization data
+ * @writeable_reg: Regmap writeable register check function
+ * @readable_reg: Regmap readable register check function
  * @max_register: Maximum SYSC register offset to be used by the regmap config
  */
 struct rz_sysc_init_data {
 	const struct rz_sysc_soc_id_init_data *soc_id_init_data;
+	bool (*writeable_reg)(struct device *dev, unsigned int reg);
+	bool (*readable_reg)(struct device *dev, unsigned int reg);
 	u32 max_register;
 };
 
-- 
2.43.0


