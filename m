Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73983C05052
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:48 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web11.15283.1713514721672585289
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=QnUtImla;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5269c3f9c7so192718066b.2
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514720; x=1714119520; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2eXjV+F/+5KHT6uf6mZP/Jg1OsLGV/kZu9GpTBKKuk=;
        b=QnUtImlaWXuailWIJIeHg/Q3HEXYUUY+Kdx+kU3DBojr02/BgNJALKF/eBmOLHonm0
         s1h4SbkLaLshpF9YyD3hPU+QvBgsTboA70ZSB5O13DRFh8AyahETiTys11PWka1COFha
         K2LGb+0Uo4ZlKnrroTiluRlmmvUbVhiF86RZyHFD4s7DUlBK0VTLJnFQCxdCeVR3pA6w
         HKPqJ3d/QziGI8hM78MHDiQT1aEjpiEG1MYRe1wTQkZFk8An7SAduIyznJwABwCCxY6Y
         u9NxcuhfuZ7y4HH8ivrY5XS/+fLIzaW06HKOkPt6iPQj4H1bebl6RS4jNG/2jSCSQ+/f
         Bt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514720; x=1714119520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2eXjV+F/+5KHT6uf6mZP/Jg1OsLGV/kZu9GpTBKKuk=;
        b=HH1XCQ7YTmiVSyZQRPAEKQ9Ex7FacoPuwDXwYsHBjAFsG5b6tadrYJHCy74sfs1+67
         x/xGaejeFDWLn680MI0nHOPxuQIGuaYT+NFDra9H+Gbf2Xod4HIynAqj1wz6WdPvqYCD
         Cso5ArtRfptXcVKzt2gcEW7UuwFySRrWK9+9mujK6j2yvYOyJfY9TjBYTdfCPya7y5po
         eKG/3jTeUVCExW8tHT5embo2R91O1CVS5IDJKdJoNcxuLGcv2VSQmEZq90IwURYQpW5c
         D0aAF/ypVlMgUGkTZkkTM6IdWoz8S8dOpBy0MzBkFlcwJoj4CVYPrZsKit/IGbN/pmIE
         P6Kw==
X-Gm-Message-State: AOJu0YxQXv4ynOfsK9qJrQ28YrmADXNINtyiS+J96rlWbV3Q79tBXnyO
	N7ncoOg74ydUwq6hnlRHvYShK8ZpWVPgXeIVmHlo3uY3oATRgB29BorzhJwOKW/JJL1hkI9gGmy
	r
X-Google-Smtp-Source: AGHT+IFrhAH/J2cIzWogJon2BcjFbCQECe2AYl45/BdZ/AX6x8f9ncX7/h2mneW/5iOBBJw7eArKsw==
X-Received: by 2002:a17:906:ae4a:b0:a55:5507:9907 with SMTP id lf10-20020a170906ae4a00b00a5555079907mr968668ejb.9.1713514719994;
        Fri, 19 Apr 2024 01:18:39 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:39 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 37/53] pinctrl: renesas: rzg2l: Add support for different DS values on different groups
Date: Fri, 19 Apr 2024 11:17:26 +0300
Message-Id: <20240419081742.3496709-38-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15624

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit ae5b425faf1074a757fad093085f6be654b7db99 upstream.

RZ/G3S supports different drive strength values for different power
sources and pin groups (A, B, C).  On each group there could be up to 4
drive strength values per power source.  Available power sources are
1v8, 2v5, 3v3.  Drive strength values are more fine tuned than what was
previously available on the driver thus the necessity of having
micro-amp support.  As drive strength and power source values are linked
together the hardware setup for these was moved at the end of
rzg2l_pinctrl_pinconf_set() to ensure proper validation of the new
values.

The drive strength values are expected to be initialized though the
SoC-specific hardware configuration data structure.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-19-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 323 ++++++++++++++++++++----
 1 file changed, 272 insertions(+), 51 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 9791df26e149..a3f6f2507e7c 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -51,6 +51,8 @@
 #define PIN_CFG_FILONOFF		BIT(10)
 #define PIN_CFG_FILNUM			BIT(11)
 #define PIN_CFG_FILCLKSEL		BIT(12)
+#define PIN_CFG_IOLH_C			BIT(13)
+#define PIN_CFG_SOFT_PS			BIT(14)
 
 #define RZG2L_MPXED_PIN_FUNCS		(PIN_CFG_IOLH_A | \
 					 PIN_CFG_SR | \
@@ -131,12 +133,16 @@ struct rzg2l_register_offsets {
 
 /**
  * enum rzg2l_iolh_index - starting indices in IOLH specific arrays
+ * @RZG2L_IOLH_IDX_1V8: starting index for 1V8 power source
+ * @RZG2L_IOLH_IDX_2V5: starting index for 2V5 power source
  * @RZG2L_IOLH_IDX_3V3: starting index for 3V3 power source
  * @RZG2L_IOLH_IDX_MAX: maximum index
  */
 enum rzg2l_iolh_index {
-	RZG2L_IOLH_IDX_3V3 = 0,
-	RZG2L_IOLH_IDX_MAX = 4,
+	RZG2L_IOLH_IDX_1V8 = 0,
+	RZG2L_IOLH_IDX_2V5 = 4,
+	RZG2L_IOLH_IDX_3V3 = 8,
+	RZG2L_IOLH_IDX_MAX = 12,
 };
 
 /* Maximum number of driver strength entries per power source. */
@@ -146,13 +152,19 @@ enum rzg2l_iolh_index {
  * struct rzg2l_hwcfg - hardware configuration data structure
  * @regs: hardware specific register offsets
  * @iolh_groupa_ua: IOLH group A uA specific values
+ * @iolh_groupb_ua: IOLH group B uA specific values
+ * @iolh_groupc_ua: IOLH group C uA specific values
  * @iolh_groupb_oi: IOLH group B output impedance specific values
+ * @drive_strength_ua: drive strength in uA is supported (otherwise mA is supported)
  * @func_base: base number for port function (see register PFC)
  */
 struct rzg2l_hwcfg {
 	const struct rzg2l_register_offsets regs;
 	u16 iolh_groupa_ua[RZG2L_IOLH_IDX_MAX];
+	u16 iolh_groupb_ua[RZG2L_IOLH_IDX_MAX];
+	u16 iolh_groupc_ua[RZG2L_IOLH_IDX_MAX];
 	u16 iolh_groupb_oi[4];
+	bool drive_strength_ua;
 	u8 func_base;
 };
 
@@ -171,6 +183,16 @@ struct rzg2l_pinctrl_data {
 	const struct rzg2l_hwcfg *hwcfg;
 };
 
+/**
+ * struct rzg2l_pinctrl_pin_settings - pin data
+ * @power_source: power source
+ * @drive_strength_ua: drive strength (in micro amps)
+ */
+struct rzg2l_pinctrl_pin_settings {
+	u16 power_source;
+	u16 drive_strength_ua;
+};
+
 struct rzg2l_pinctrl {
 	struct pinctrl_dev		*pctl;
 	struct pinctrl_desc		desc;
@@ -188,8 +210,12 @@ struct rzg2l_pinctrl {
 
 	spinlock_t			lock; /* lock read/write registers */
 	struct mutex			mutex; /* serialize adding groups and functions */
+
+	struct rzg2l_pinctrl_pin_settings *settings;
 };
 
+static const u16 available_ps[] = { 1800, 2500, 3300 };
+
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 pin, u8 off, u8 func)
 {
@@ -549,6 +575,156 @@ static void rzg2l_rmw_pin_config(struct rzg2l_pinctrl *pctrl, u32 offset,
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 }
 
+static int rzg2l_caps_to_pwr_reg(const struct rzg2l_register_offsets *regs, u32 caps)
+{
+	if (caps & PIN_CFG_IO_VMC_SD0)
+		return SD_CH(regs->sd_ch, 0);
+	if (caps & PIN_CFG_IO_VMC_SD1)
+		return SD_CH(regs->sd_ch, 1);
+	if (caps & PIN_CFG_IO_VMC_QSPI)
+		return QSPI;
+
+	return -EINVAL;
+}
+
+static int rzg2l_get_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps)
+{
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
+	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
+	int pwr_reg;
+
+	if (caps & PIN_CFG_SOFT_PS)
+		return pctrl->settings[pin].power_source;
+
+	pwr_reg = rzg2l_caps_to_pwr_reg(regs, caps);
+	if (pwr_reg < 0)
+		return pwr_reg;
+
+	return (readl(pctrl->base + pwr_reg) & PVDD_MASK) ? 1800 : 3300;
+}
+
+static int rzg2l_set_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps, u32 ps)
+{
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
+	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
+	int pwr_reg;
+
+	if (caps & PIN_CFG_SOFT_PS) {
+		pctrl->settings[pin].power_source = ps;
+		return 0;
+	}
+
+	pwr_reg = rzg2l_caps_to_pwr_reg(regs, caps);
+	if (pwr_reg < 0)
+		return pwr_reg;
+
+	writel((ps == 1800) ? PVDD_1800 : PVDD_3300, pctrl->base + pwr_reg);
+	pctrl->settings[pin].power_source = ps;
+
+	return 0;
+}
+
+static bool rzg2l_ps_is_supported(u16 ps)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(available_ps); i++) {
+		if (available_ps[i] == ps)
+			return true;
+	}
+
+	return false;
+}
+
+static enum rzg2l_iolh_index rzg2l_ps_to_iolh_idx(u16 ps)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(available_ps); i++) {
+		if (available_ps[i] == ps)
+			break;
+	}
+
+	/*
+	 * We multiply with RZG2L_IOLH_MAX_DS_ENTRIES as we have
+	 * RZG2L_IOLH_MAX_DS_ENTRIES DS values per power source
+	 */
+	return i * RZG2L_IOLH_MAX_DS_ENTRIES;
+}
+
+static u16 rzg2l_iolh_val_to_ua(const struct rzg2l_hwcfg *hwcfg, u32 caps, u8 val)
+{
+	if (caps & PIN_CFG_IOLH_A)
+		return hwcfg->iolh_groupa_ua[val];
+
+	if (caps & PIN_CFG_IOLH_B)
+		return hwcfg->iolh_groupb_ua[val];
+
+	if (caps & PIN_CFG_IOLH_C)
+		return hwcfg->iolh_groupc_ua[val];
+
+	/* Should not happen. */
+	return 0;
+}
+
+static int rzg2l_iolh_ua_to_val(const struct rzg2l_hwcfg *hwcfg, u32 caps,
+				enum rzg2l_iolh_index ps_index, u16 ua)
+{
+	const u16 *array = NULL;
+	unsigned int i;
+
+	if (caps & PIN_CFG_IOLH_A)
+		array = &hwcfg->iolh_groupa_ua[ps_index];
+
+	if (caps & PIN_CFG_IOLH_B)
+		array = &hwcfg->iolh_groupb_ua[ps_index];
+
+	if (caps & PIN_CFG_IOLH_C)
+		array = &hwcfg->iolh_groupc_ua[ps_index];
+
+	if (!array)
+		return -EINVAL;
+
+	for (i = 0; i < RZG2L_IOLH_MAX_DS_ENTRIES; i++) {
+		if (array[i] == ua)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static bool rzg2l_ds_is_supported(struct rzg2l_pinctrl *pctrl, u32 caps,
+				  enum rzg2l_iolh_index iolh_idx,
+				  u16 ds)
+{
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
+	const u16 *array = NULL;
+	unsigned int i;
+
+	if (caps & PIN_CFG_IOLH_A)
+		array = hwcfg->iolh_groupa_ua;
+
+	if (caps & PIN_CFG_IOLH_B)
+		array = hwcfg->iolh_groupb_ua;
+
+	if (caps & PIN_CFG_IOLH_C)
+		array = hwcfg->iolh_groupc_ua;
+
+	/* Should not happen. */
+	if (!array)
+		return false;
+
+	if (!array[iolh_idx])
+		return false;
+
+	for (i = 0; i < RZG2L_IOLH_MAX_DS_ENTRIES; i++) {
+		if (array[iolh_idx + i] == ds)
+			return true;
+	}
+
+	return false;
+}
+
 static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 				     unsigned int _pin,
 				     unsigned long *config)
@@ -556,13 +732,11 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 	struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	enum pin_config_param param = pinconf_to_config_param(*config);
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
-	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
 	unsigned int *pin_data = pin->drv_data;
 	unsigned int arg = 0;
-	unsigned long flags;
-	void __iomem *addr;
 	u32 off, cfg;
+	int ret;
 	u8 bit;
 
 	if (!pin_data)
@@ -588,40 +762,49 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 			return -EINVAL;
 		break;
 
-	case PIN_CONFIG_POWER_SOURCE: {
-		u32 pwr_reg = 0x0;
-
-		if (cfg & PIN_CFG_IO_VMC_SD0)
-			pwr_reg = SD_CH(regs->sd_ch, 0);
-		else if (cfg & PIN_CFG_IO_VMC_SD1)
-			pwr_reg = SD_CH(regs->sd_ch, 1);
-		else if (cfg & PIN_CFG_IO_VMC_QSPI)
-			pwr_reg = QSPI;
-		else
-			return -EINVAL;
-
-		spin_lock_irqsave(&pctrl->lock, flags);
-		addr = pctrl->base + pwr_reg;
-		arg = (readl(addr) & PVDD_MASK) ? 1800 : 3300;
-		spin_unlock_irqrestore(&pctrl->lock, flags);
+	case PIN_CONFIG_POWER_SOURCE:
+		ret = rzg2l_get_power_source(pctrl, _pin, cfg);
+		if (ret < 0)
+			return ret;
+		arg = ret;
 		break;
-	}
 
 	case PIN_CONFIG_DRIVE_STRENGTH: {
 		unsigned int index;
 
-		if (!(cfg & PIN_CFG_IOLH_A))
+		if (!(cfg & PIN_CFG_IOLH_A) || hwcfg->drive_strength_ua)
 			return -EINVAL;
 
 		index = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
+		/*
+		 * Drive strenght mA is supported only by group A and only
+		 * for 3V3 port source.
+		 */
 		arg = hwcfg->iolh_groupa_ua[index + RZG2L_IOLH_IDX_3V3] / 1000;
 		break;
 	}
 
+	case PIN_CONFIG_DRIVE_STRENGTH_UA: {
+		enum rzg2l_iolh_index iolh_idx;
+		u8 val;
+
+		if (!(cfg & (PIN_CFG_IOLH_A | PIN_CFG_IOLH_B | PIN_CFG_IOLH_C)) ||
+		    !hwcfg->drive_strength_ua)
+			return -EINVAL;
+
+		ret = rzg2l_get_power_source(pctrl, _pin, cfg);
+		if (ret < 0)
+			return ret;
+		iolh_idx = rzg2l_ps_to_iolh_idx(ret);
+		val = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
+		arg = rzg2l_iolh_val_to_ua(hwcfg, cfg, iolh_idx + val);
+		break;
+	}
+
 	case PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS: {
 		unsigned int index;
 
-		if (!(cfg & PIN_CFG_IOLH_B))
+		if (!(cfg & PIN_CFG_IOLH_B) || !hwcfg->iolh_groupb_oi[0])
 			return -EINVAL;
 
 		index = rzg2l_read_pin_config(pctrl, IOLH(off), bit, IOLH_MASK);
@@ -645,14 +828,13 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 {
 	struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
-	unsigned int *pin_data = pin->drv_data;
 	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
-	const struct rzg2l_register_offsets *regs = &hwcfg->regs;
+	struct rzg2l_pinctrl_pin_settings settings = pctrl->settings[_pin];
+	unsigned int *pin_data = pin->drv_data;
 	enum pin_config_param param;
-	unsigned long flags;
-	void __iomem *addr;
 	unsigned int i;
 	u32 cfg, off;
+	int ret;
 	u8 bit;
 
 	if (!pin_data)
@@ -683,34 +865,15 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			break;
 		}
 
-		case PIN_CONFIG_POWER_SOURCE: {
-			unsigned int mV = pinconf_to_config_argument(_configs[i]);
-			u32 pwr_reg = 0x0;
-
-			if (mV != 1800 && mV != 3300)
-				return -EINVAL;
-
-			if (cfg & PIN_CFG_IO_VMC_SD0)
-				pwr_reg = SD_CH(regs->sd_ch, 0);
-			else if (cfg & PIN_CFG_IO_VMC_SD1)
-				pwr_reg = SD_CH(regs->sd_ch, 1);
-			else if (cfg & PIN_CFG_IO_VMC_QSPI)
-				pwr_reg = QSPI;
-			else
-				return -EINVAL;
-
-			addr = pctrl->base + pwr_reg;
-			spin_lock_irqsave(&pctrl->lock, flags);
-			writel((mV == 1800) ? PVDD_1800 : PVDD_3300, addr);
-			spin_unlock_irqrestore(&pctrl->lock, flags);
+		case PIN_CONFIG_POWER_SOURCE:
+			settings.power_source = pinconf_to_config_argument(_configs[i]);
 			break;
-		}
 
 		case PIN_CONFIG_DRIVE_STRENGTH: {
 			unsigned int arg = pinconf_to_config_argument(_configs[i]);
 			unsigned int index;
 
-			if (!(cfg & PIN_CFG_IOLH_A))
+			if (!(cfg & PIN_CFG_IOLH_A) || hwcfg->drive_strength_ua)
 				return -EINVAL;
 
 			for (index = RZG2L_IOLH_IDX_3V3;
@@ -725,11 +888,19 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			break;
 		}
 
+		case PIN_CONFIG_DRIVE_STRENGTH_UA:
+			if (!(cfg & (PIN_CFG_IOLH_A | PIN_CFG_IOLH_B | PIN_CFG_IOLH_C)) ||
+			    !hwcfg->drive_strength_ua)
+				return -EINVAL;
+
+			settings.drive_strength_ua = pinconf_to_config_argument(_configs[i]);
+			break;
+
 		case PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS: {
 			unsigned int arg = pinconf_to_config_argument(_configs[i]);
 			unsigned int index;
 
-			if (!(cfg & PIN_CFG_IOLH_B))
+			if (!(cfg & PIN_CFG_IOLH_B) || !hwcfg->iolh_groupb_oi[0])
 				return -EINVAL;
 
 			for (index = 0; index < ARRAY_SIZE(hwcfg->iolh_groupb_oi); index++) {
@@ -748,6 +919,39 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 		}
 	}
 
+	/* Apply power source. */
+	if (settings.power_source != pctrl->settings[_pin].power_source) {
+		ret = rzg2l_ps_is_supported(settings.power_source);
+		if (!ret)
+			return -EINVAL;
+
+		/* Apply power source. */
+		ret = rzg2l_set_power_source(pctrl, _pin, cfg, settings.power_source);
+		if (ret)
+			return ret;
+	}
+
+	/* Apply drive strength. */
+	if (settings.drive_strength_ua != pctrl->settings[_pin].drive_strength_ua) {
+		enum rzg2l_iolh_index iolh_idx;
+		int val;
+
+		iolh_idx = rzg2l_ps_to_iolh_idx(settings.power_source);
+		ret = rzg2l_ds_is_supported(pctrl, cfg, iolh_idx,
+					    settings.drive_strength_ua);
+		if (!ret)
+			return -EINVAL;
+
+		/* Get register value for this PS/DS tuple. */
+		val = rzg2l_iolh_ua_to_val(hwcfg, cfg, iolh_idx, settings.drive_strength_ua);
+		if (val < 0)
+			return val;
+
+		/* Apply drive strength. */
+		rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, val);
+		pctrl->settings[_pin].drive_strength_ua = settings.drive_strength_ua;
+	}
+
 	return 0;
 }
 
@@ -1462,6 +1666,7 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
 
 static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 {
+	const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
 	struct pinctrl_pin_desc *pins;
 	unsigned int i, j;
 	u32 *pin_data;
@@ -1504,6 +1709,22 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 		pins[index].drv_data = &pin_data[index];
 	}
 
+	pctrl->settings = devm_kcalloc(pctrl->dev, pctrl->desc.npins, sizeof(*pctrl->settings),
+				       GFP_KERNEL);
+	if (!pctrl->settings)
+		return -ENOMEM;
+
+	for (i = 0; hwcfg->drive_strength_ua && i < pctrl->desc.npins; i++) {
+		if (pin_data[i] & PIN_CFG_SOFT_PS) {
+			pctrl->settings[i].power_source = 3300;
+		} else {
+			ret = rzg2l_get_power_source(pctrl, i, pin_data[i]);
+			if (ret < 0)
+				continue;
+			pctrl->settings[i].power_source = ret;
+		}
+	}
+
 	ret = devm_pinctrl_register_and_init(pctrl->dev, &pctrl->desc, pctrl,
 					     &pctrl->pctl);
 	if (ret) {
-- 
2.39.2


