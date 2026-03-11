Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665BF104BED5
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:17 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17334.1773223512759320936
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ngksDOUg;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439af7d77f0so9127013f8f.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223511; x=1773828311; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDcfLASpAYa7eshvOSyuV8ylsidwiaTVyQzHBwE/ya0=;
        b=ngksDOUgcPqvnPAvasKKp7L+8rfpy6Z+lhQu/AiaEGlYJasIPt4pbaXj5LEB5L6dHO
         2wLsN9OPTw9r/C7vDwusSGC692Wg9u0PQoJWUIgCHDlypfAtRy7xV2eDa90et2g1aTwX
         vELqtMA6OpjyVej7e6dFLO1kDI2ejKKOdeDvXP096j92PrwNsQ58lLHEILO6CbaLteUk
         i6vi2awH6p1hX782AFDsW0+hpxcWzTmzEb7kulRMd6B47fkcwVsV+BoHGv/KLgUjfIN1
         mi75TEzkRLxlWG9cUx+86JtafWY+5pBcFaXSHuuLVq9yKXZr4/SnCquO65j8v2xNtVPV
         XNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223511; x=1773828311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rDcfLASpAYa7eshvOSyuV8ylsidwiaTVyQzHBwE/ya0=;
        b=vRmwnnxXT5gGLaIpNp4OMSaxBcb8y7PkrmFF9ba3W+yp0cIJ3ZX550tjUCCa4oZyFJ
         ZF4Muoip/bRQ3It1bcHqiEtE8n7OohTvZYjcDxzm2Ni8gZeFi9xMQDyVuG/cRL4rZjqa
         IXlO7N+PjQwHeljvWYJKR20pgpo8OlBMz3/i9TzAiUuhUXL2pnLLftZhD+roUtEy8bM+
         wxQ9wlSCnvOlUCRTjBwUM79XufA61JC+K1nT1QcCJIQUzgVUhK3F1dUegV+qIw4V7U1t
         WMw13Y8AP7Sq3Fmv2akB50dTK1kp+BgwK5yy6whyjYbkJOHfizSGrNKUfTD9C/aGTohz
         SUuw==
X-Gm-Message-State: AOJu0YwIFm7DrKPuLPlnbc2VkGkpU0qqbrJ1Qk60hIiN0B7VZaGVGoyp
	QdN/+QC+TdY/HKIbG4hQzYUKCUsLjVCy05aTELgO3BBpmBvg6eaZBpReNxhEdQ==
X-Gm-Gg: ATEYQzzzY3R0r441x1Zh6pdqLT1+kj5r3Yw8LugQeNehzagQzy4+6z3bWNjo7j56F26
	9UyUYU04RFLoCz2wGnY7I2LxzpXiIb0XOJQiGmM2IoxPphef+VgoKpqHJBr2jHOXlGMwzG5O44h
	314PcWvnaTVu7Z3om/PfBBuWdgLco7I1Fox9z/CJ5NzANHS5pgSIXG8Ke0VvABJTZBnvy4MhJKi
	3i4ORV9ffN6BkmaYHsSR9/mES4KYS2uq/4V8XdIB8FJMQZ6SHYMZ/oy73VJCbxj+DS8C+F4sb5n
	JMNTw9tv//cKNrK6e89bOd+UnM9fZCyUoKofj3Va0xCHKFAor7kl0VhDeC6Fs6B9v18//Va4RmX
	+nZd9pD8UunRHrW2X609oSaWW1GLcsry5yoDc4JJ3ggcvJ8+RlKovqRvm4Dk5tyyYQuwOheTmiH
	UlJ/4fJ1btIX5ik8ijd47KJWsnEtja3Us=
X-Received: by 2002:a5d:588f:0:b0:439:d755:a895 with SMTP id ffacd0b85a97d-439f843412amr3577981f8f.42.1773223510869;
        Wed, 11 Mar 2026 03:05:10 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:10 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 18/27] serial: sh-sci: Rename port SCI_PORT_RSCI->RSCI_PORT_SCIF16
Date: Wed, 11 Mar 2026 10:04:37 +0000
Message-ID: <20260311100458.162447-19-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22264

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit d53f4aa9edaafda28e426d8e5eda7dc50f7ca94e ]

Rename port SCI_PORT_RSCI->RSCI_PORT_SCIF16 to differentiate it from
RZ/G3E port that has 32-stage FIFO.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-12-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/rsci.c          | 2 +-
 drivers/tty/serial/sh-sci-common.h | 2 +-
 drivers/tty/serial/sh-sci.c        | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index fb419f34f35d..8a4f2618e53c 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -461,7 +461,7 @@ static const struct sci_port_ops rsci_port_ops = {
 };
 
 struct sci_of_data of_sci_rsci_data = {
-	.type = SCI_PORT_RSCI,
+	.type = RSCI_PORT_SCIF16,
 	.ops = &rsci_port_ops,
 	.uart_ops = &rsci_uart_ops,
 	.params = &rsci_port_params,
diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index e3c028df14f1..1b9480c7f4cb 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -7,7 +7,7 @@
 
 /* Private port IDs */
 enum SCI_PORT_TYPE {
-	SCI_PORT_RSCI = BIT(7) | 0,
+	RSCI_PORT_SCIF16 = BIT(7) | 0,
 };
 
 enum SCI_CLKS {
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 0be3d5c45388..69cd9aa60922 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1184,7 +1184,7 @@ static int sci_handle_errors(struct uart_port *port)
 
 static bool sci_is_rsci_type(u8 type)
 {
-	return (type == SCI_PORT_RSCI);
+	return (type == RSCI_PORT_SCIF16);
 }
 
 static int sci_handle_fifo_overrun(struct uart_port *port)
@@ -3179,7 +3179,7 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 
 	if (sci_port->type == PORT_HSCIF) {
 		clk_names[SCI_SCK] = "hsck";
-	} else if (sci_port->type == SCI_PORT_RSCI) {
+	} else if (sci_port->type == RSCI_PORT_SCIF16) {
 		clk_names[SCI_FCK] = "operation";
 		clk_names[SCI_BRG_INT] = "bus";
 	}
@@ -3191,7 +3191,7 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 		if (IS_ERR(clk))
 			return PTR_ERR(clk);
 
-		if (!clk && sci_port->type == SCI_PORT_RSCI &&
+		if (!clk && sci_port->type == RSCI_PORT_SCIF16 &&
 		    (i == SCI_FCK || i == SCI_BRG_INT))
 			return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
 
@@ -3329,7 +3329,7 @@ static int sci_init_single(struct platform_device *dev,
 		else
 			sci_port->rx_trigger = 8;
 		break;
-	case SCI_PORT_RSCI:
+	case RSCI_PORT_SCIF16:
 		sci_port->rx_trigger = 16;
 		break;
 	default:
-- 
2.43.0


