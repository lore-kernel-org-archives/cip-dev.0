Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3B4FD7089
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:33 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73434.1773746248485060712
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ITkOgHqn;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-485392de558so33518335e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746247; x=1774351047; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9AreNth117ES3qp+p7rGl0R5bEQDUHeriQMRwa27tU=;
        b=ITkOgHqnIMlGWYX1ENA/jd4YHCdcrtrgIEsf1V/wYCsWTzWCGcwrxjGjdbEbZdGeNq
         tB9LPC/omgCJKMK1/pNJDud+XAGgIAsm2+CNqU4UIQSV4/gkvn840EZ1Sj7KdyWA1zLM
         9uoNicGvuA9WMOccB2ls27HFVE3kB98NqeKJf9eaCMNKppVU1dWgBB1V5/rq8VBcfZdF
         5esAGp9bjsFSGhenOtngxNh4BuvfvgP2jn4BKsjBAX6jiEysHDPywRMp2v9VF9c67XWu
         mHr15VNxqVYaPXj4+OiW+vypTYRjq8wS/oIwcdIJX8aOCHh0qidprc/JUgk8QIgkTmpt
         Vlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746247; x=1774351047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W9AreNth117ES3qp+p7rGl0R5bEQDUHeriQMRwa27tU=;
        b=dRjlfGsINtnYka9aib5ISTNePC/FDnnqS5XFDyBv8fd05uCqeyIpuUV8fQmqanX+FY
         Q5crGp49mNsu5hEbiOiHyl3Mh59CpZf4nav6lLJ7ttt41/F4KLhrZ1cs/iwu0lxjm0+p
         qwHBkHMbmqFI7b2YiDW5XYHpMi1ilAfKr54hjG6l4RUyi/bc5uUki/DHxQjgfLrJPUaM
         lTptGxKnCGOzLLGR/JKteTKUCwjzN1+5+C/+kOYqMgYUkVNoyTGt7uMG4ir6S/0R8rD0
         Tlqv4Y6GF+THoc6jG817n5raJkHzM3vvhfZQZO83A4EjQToUKYx0OLT2DnU7khqThYYq
         /nLg==
X-Gm-Message-State: AOJu0YxaMWwJev8COEkWgv/r1mnQQootxjmHZw4g8Hx9+m2fPwdrmMAX
	4odTJuEWBiMqZ+sD6TighYLYO+J1BP4AWvnMXV43dRaMLS+Mbe8kxBw2MGwJnw==
X-Gm-Gg: ATEYQzzIdzM0bjZFPS+q0VhMBpVyKZaG1Ox2pNV7xpq99QJP7qW0h6hT0ulziyf/ynb
	Enaj8bJYeFyzwRMVRJqsi5YxgUdF+QvTKmOEIERRG3Eef4wRcWQTx22cDDFYLg4knDQCwROznqU
	3q/+C+bHzTHR6inyODN6/40vD0P2OlKV5C/bOSydmtxlI2BWSRFW3IXVZJaVxLJSv7KFkC/hVPU
	e4tBesvTQIAsPlzM4rFjPfXCTAhkhxZ1HRSOhFnjvR6QYHcfICYLZXK8JoH5pypex2nA6S7B1dg
	9awtdDla1FlLN1GBVwOVU/Rzdo4x8aTW4mr3E9FXoaGm17MnnjY0UqI35dhHXnFuHRW4B3h8uwE
	/ENFvagjnVCaN9jZDg6JiPw5Ea7H0BEthcaXQ4aUFa91c2e7+Z823W8QQGFulLcDbw4pdGrECH1
	teISgO4FTeHPmGiRsDhYAmW7nrE8PXGs+NMruc6c0wRj6krIeQ
X-Received: by 2002:a05:600c:3e11:b0:485:6bcc:87dc with SMTP id 5b1f17b1804b1-4856bcc87fdmr87709495e9.14.1773746246507;
        Tue, 17 Mar 2026 04:17:26 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:26 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 09/39] serial: sh-sci: Introduced sci_of_data
Date: Tue, 17 Mar 2026 11:16:34 +0000
Message-ID: <20260317111718.281633-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22442

From: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>

[ Upstream commit 043806bc9dbc6597dd15e6ca9220ae2746425f2f ]

The aim here is to provide an easier support to more different SCI
controllers, like the RZ/T2H one.

The existing .data field of_sci_match is changed to a structure containing
all what that can be statically initialized, and avoid a call to
'sci_probe_regmap', in both 'sci_init_single', and 'early_console_setup'.

'sci_probe_regmap' is now assumed to be called in the only case where the
device description is from a board file instead of a dts.

In this way, there is no need to patch 'sci_probe_regmap' for adding new
SCI type, and also, the specific sci_port_params for a new SCI type can be
provided by an external file.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
Link: https://lore.kernel.org/r/20250403212919.1137670-10-thierry.bultel.yh@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci-common.h |  10 +-
 drivers/tty/serial/sh-sci.c        | 164 +++++++++++++++++++++--------
 2 files changed, 131 insertions(+), 43 deletions(-)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index 2ed742bca83f..bd9d9cfac1c8 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -89,6 +89,14 @@ struct sci_port_ops {
 	size_t (*suspend_regs_size)(void);
 };
 
+struct sci_of_data {
+	const struct sci_port_params *params;
+	const struct uart_ops *uart_ops;
+	const struct sci_port_ops *ops;
+	unsigned short regtype;
+	unsigned short type;
+};
+
 struct sci_port {
 	struct uart_port	port;
 
@@ -153,7 +161,7 @@ void sci_shutdown(struct uart_port *port);
 #define max_sr(_port)		fls((_port)->sampling_rate_mask)
 
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
-int __init scix_early_console_setup(struct earlycon_device *device, int);
+int __init scix_early_console_setup(struct earlycon_device *device, const struct sci_of_data *data);
 #endif
 
 #endif /* __SH_SCI_COMMON_H__ */
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4dc1df9cc8d1..591ea7bcb1fe 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3004,10 +3004,13 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 }
 
 static const struct sci_port_params *
-sci_probe_regmap(const struct plat_sci_port *cfg)
+sci_probe_regmap(const struct plat_sci_port *cfg, struct sci_port *sci_port)
 {
 	unsigned int regtype;
 
+	sci_port->ops = &sci_port_ops;
+	sci_port->port.ops = &sci_uart_ops;
+
 	if (cfg->regtype != SCIx_PROBE_REGTYPE)
 		return &sci_port_params[cfg->regtype];
 
@@ -3054,9 +3057,7 @@ static int sci_init_single(struct platform_device *dev,
 	int ret;
 
 	sci_port->cfg	= p;
-	sci_port->ops	= &sci_port_ops;
 
-	port->ops	= &sci_uart_ops;
 	port->iotype	= UPIO_MEM;
 	port->line	= index;
 	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_SH_SCI_CONSOLE);
@@ -3096,10 +3097,6 @@ static int sci_init_single(struct platform_device *dev,
 		for (i = 1; i < ARRAY_SIZE(sci_port->irqs); i++)
 			sci_port->irqs[i] = sci_port->irqs[0];
 
-	sci_port->params = sci_probe_regmap(p);
-	if (unlikely(sci_port->params == NULL))
-		return -EINVAL;
-
 	switch (p->type) {
 	case PORT_SCIFB:
 		sci_port->rx_trigger = 48;
@@ -3271,13 +3268,18 @@ static char early_serial_buf[32];
 static int sci_probe_earlyprintk(struct platform_device *pdev)
 {
 	const struct plat_sci_port *cfg = dev_get_platdata(&pdev->dev);
+	struct sci_port *sp = &sci_ports[pdev->id];
 
 	if (early_serial_console.data)
 		return -EEXIST;
 
 	early_serial_console.index = pdev->id;
 
-	sci_init_single(pdev, &sci_ports[pdev->id], pdev->id, cfg, true);
+	sp->params = sci_probe_regmap(cfg, sp);
+	if (!sp->params)
+		return -ENODEV;
+
+	sci_init_single(pdev, sp, pdev->id, cfg, true);
 
 	serial_console_setup(&early_serial_console, early_serial_buf);
 
@@ -3330,58 +3332,126 @@ static int sci_remove(struct platform_device *dev)
 	return 0;
 }
 
-#define SCI_OF_DATA(type, regtype)	(void *)((type) << 16 | (regtype))
-#define SCI_OF_TYPE(data)		((unsigned long)(data) >> 16)
-#define SCI_OF_REGTYPE(data)		((unsigned long)(data) & 0xffff)
+static const struct sci_of_data of_sci_scif_sh2 = {
+	.type = PORT_SCIF,
+	.regtype = SCIx_SH2_SCIF_FIFODATA_REGTYPE,
+	.ops = &sci_port_ops,
+	.uart_ops = &sci_uart_ops,
+	.params = &sci_port_params[SCIx_SH2_SCIF_FIFODATA_REGTYPE],
+};
+
+static const struct sci_of_data of_sci_scif_rz_scifa = {
+	.type = PORT_SCIF,
+	.regtype = SCIx_RZ_SCIFA_REGTYPE,
+	.ops = &sci_port_ops,
+	.uart_ops = &sci_uart_ops,
+	.params = &sci_port_params[SCIx_RZ_SCIFA_REGTYPE],
+};
+
+static const struct sci_of_data of_sci_scif_rzv2h = {
+	.type = PORT_SCIF,
+	.regtype = SCIx_RZV2H_SCIF_REGTYPE,
+	.ops = &sci_port_ops,
+	.uart_ops = &sci_uart_ops,
+	.params = &sci_port_params[SCIx_RZV2H_SCIF_REGTYPE],
+};
+
+static const struct sci_of_data of_sci_rcar_scif = {
+	.type = PORT_SCIF,
+	.regtype = SCIx_SH4_SCIF_BRG_REGTYPE,
+	.ops = &sci_port_ops,
+	.uart_ops = &sci_uart_ops,
+	.params = &sci_port_params[SCIx_SH4_SCIF_BRG_REGTYPE],
+};
+
+static const struct sci_of_data of_sci_scif_sh4 = {
+	.type = PORT_SCIF,
+	.regtype = SCIx_SH4_SCIF_REGTYPE,
+	.ops = &sci_port_ops,
+	.uart_ops = &sci_uart_ops,
+	.params = &sci_port_params[SCIx_SH4_SCIF_REGTYPE],
+};
+
+static const struct sci_of_data of_sci_scifa = {
+	.type = PORT_SCIFA,
+	.regtype = SCIx_SCIFA_REGTYPE,
+	.ops = &sci_port_ops,
+	.uart_ops = &sci_uart_ops,
+	.params = &sci_port_params[SCIx_SCIFA_REGTYPE],
+};
+
+static const struct sci_of_data of_sci_scifb = {
+	.type = PORT_SCIFB,
+	.regtype = SCIx_SCIFB_REGTYPE,
+	.ops = &sci_port_ops,
+	.uart_ops = &sci_uart_ops,
+	.params = &sci_port_params[SCIx_SCIFB_REGTYPE],
+};
+
+static const struct sci_of_data of_sci_hscif = {
+	.type = PORT_HSCIF,
+	.regtype = SCIx_HSCIF_REGTYPE,
+	.ops = &sci_port_ops,
+	.uart_ops = &sci_uart_ops,
+	.params = &sci_port_params[SCIx_HSCIF_REGTYPE],
+};
+
+static const struct sci_of_data of_sci_sci = {
+	.type = PORT_SCI,
+	.regtype = SCIx_SCI_REGTYPE,
+	.ops = &sci_port_ops,
+	.uart_ops = &sci_uart_ops,
+	.params = &sci_port_params[SCIx_SCI_REGTYPE],
+};
 
 static const struct of_device_id of_sci_match[] __maybe_unused = {
 	/* SoC-specific types */
 	{
 		.compatible = "renesas,scif-r7s72100",
-		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH2_SCIF_FIFODATA_REGTYPE),
+		.data = &of_sci_scif_sh2,
 	},
 	{
 		.compatible = "renesas,scif-r7s9210",
-		.data = SCI_OF_DATA(PORT_SCIF, SCIx_RZ_SCIFA_REGTYPE),
+		.data = &of_sci_scif_rz_scifa,
 	},
 	{
 		.compatible = "renesas,scif-r9a07g044",
-		.data = SCI_OF_DATA(PORT_SCIF, SCIx_RZ_SCIFA_REGTYPE),
+		.data = &of_sci_scif_rz_scifa,
 	},
 	{
 		.compatible = "renesas,scif-r9a09g057",
-		.data = SCI_OF_DATA(PORT_SCIF, SCIx_RZV2H_SCIF_REGTYPE),
+		.data = &of_sci_scif_rzv2h,
 	},
 	/* Family-specific types */
 	{
 		.compatible = "renesas,rcar-gen1-scif",
-		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
+		.data = &of_sci_rcar_scif,
 	}, {
 		.compatible = "renesas,rcar-gen2-scif",
-		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
+		.data = &of_sci_rcar_scif,
 	}, {
 		.compatible = "renesas,rcar-gen3-scif",
-		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
+		.data = &of_sci_rcar_scif
 	}, {
 		.compatible = "renesas,rcar-gen4-scif",
-		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_BRG_REGTYPE),
+		.data = &of_sci_rcar_scif
 	},
 	/* Generic types */
 	{
 		.compatible = "renesas,scif",
-		.data = SCI_OF_DATA(PORT_SCIF, SCIx_SH4_SCIF_REGTYPE),
+		.data = &of_sci_scif_sh4,
 	}, {
 		.compatible = "renesas,scifa",
-		.data = SCI_OF_DATA(PORT_SCIFA, SCIx_SCIFA_REGTYPE),
+		.data = &of_sci_scifa,
 	}, {
 		.compatible = "renesas,scifb",
-		.data = SCI_OF_DATA(PORT_SCIFB, SCIx_SCIFB_REGTYPE),
+		.data = &of_sci_scifb,
 	}, {
 		.compatible = "renesas,hscif",
-		.data = SCI_OF_DATA(PORT_HSCIF, SCIx_HSCIF_REGTYPE),
+		.data = &of_sci_hscif,
 	}, {
 		.compatible = "renesas,sci",
-		.data = SCI_OF_DATA(PORT_SCI, SCIx_SCI_REGTYPE),
+		.data = &of_sci_sci,
 	}, {
 		/* Terminator */
 	},
@@ -3400,7 +3470,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	struct reset_control *rstc;
 	struct plat_sci_port *p;
 	struct sci_port *sp;
-	const void *data;
+	const struct sci_of_data *data;
 	int id, ret;
 
 	if (!IS_ENABLED(CONFIG_OF) || !np)
@@ -3447,8 +3517,12 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	sp->rstc = rstc;
 	*dev_id = id;
 
-	p->type = SCI_OF_TYPE(data);
-	p->regtype = SCI_OF_REGTYPE(data);
+	p->type = data->type;
+	p->regtype = data->regtype;
+
+	sp->ops = data->ops;
+	sp->port.ops = data->uart_ops;
+	sp->params = data->params;
 
 	sp->has_rtscts = of_property_read_bool(np, "uart-has-rtscts");
 
@@ -3555,6 +3629,7 @@ static int sci_probe(struct platform_device *dev)
 		p = sci_parse_dt(dev, &dev_id);
 		if (IS_ERR(p))
 			return PTR_ERR(p);
+		sp = &sci_ports[dev_id];
 	} else {
 		p = dev->dev.platform_data;
 		if (p == NULL) {
@@ -3563,9 +3638,12 @@ static int sci_probe(struct platform_device *dev)
 		}
 
 		dev_id = dev->id;
+		sp = &sci_ports[dev_id];
+		sp->params = sci_probe_regmap(p, sp);
+		if (!sp->params)
+			return -ENODEV;
 	}
 
-	sp = &sci_ports[dev_id];
 	sp->suspend_regs = devm_kzalloc(&dev->dev,
 					sp->ops->suspend_regs_size(),
 					GFP_KERNEL);
@@ -3712,19 +3790,23 @@ static int early_console_exit(struct console *co)
 }
 
 int __init scix_early_console_setup(struct earlycon_device *device,
-				      int type)
+				    const struct sci_of_data *data)
 {
 	const struct sci_common_regs *regs;
 
 	if (!device->port.membase)
 		return -ENODEV;
 
-	device->port.type = type;
+	device->port.type = data->type;
 	sci_ports[0].port = device->port;
-	port_cfg.type = type;
+
+	port_cfg.type = data->type;
+	port_cfg.regtype = data->regtype;
+
 	sci_ports[0].cfg = &port_cfg;
-	sci_ports[0].ops = &sci_port_ops;
-	sci_ports[0].params = sci_probe_regmap(&port_cfg);
+	sci_ports[0].params = data->params;
+	sci_ports[0].ops = data->ops;
+	sci_ports[0].port.ops = data->uart_ops;
 	sci_uart_earlycon = true;
 	regs = sci_ports[0].params->common_regs;
 
@@ -3741,41 +3823,39 @@ int __init scix_early_console_setup(struct earlycon_device *device,
 static int __init sci_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
-	return scix_early_console_setup(device, PORT_SCI);
+	return scix_early_console_setup(device, &of_sci_sci);
 }
 static int __init scif_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
-	return scix_early_console_setup(device, PORT_SCIF);
+	return scix_early_console_setup(device, &of_sci_scif_sh4);
 }
 static int __init rzscifa_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
-	port_cfg.regtype = SCIx_RZ_SCIFA_REGTYPE;
-	return scix_early_console_setup(device, PORT_SCIF);
+	return scix_early_console_setup(device, &of_sci_scif_rz_scifa);
 }
 
 static int __init rzv2hscif_early_console_setup(struct earlycon_device *device,
 						const char *opt)
 {
-	port_cfg.regtype = SCIx_RZV2H_SCIF_REGTYPE;
-	return scix_early_console_setup(device, PORT_SCIF);
+	return scix_early_console_setup(device, &of_sci_scif_rzv2h);
 }
 
 static int __init scifa_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
-	return scix_early_console_setup(device, PORT_SCIFA);
+	return scix_early_console_setup(device, &of_sci_scifa);
 }
 static int __init scifb_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
-	return scix_early_console_setup(device, PORT_SCIFB);
+	return scix_early_console_setup(device, &of_sci_scifb);
 }
 static int __init hscif_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
-	return scix_early_console_setup(device, PORT_HSCIF);
+	return scix_early_console_setup(device, &of_sci_hscif);
 }
 
 OF_EARLYCON_DECLARE(sci, "renesas,sci", sci_early_console_setup);
-- 
2.43.0


