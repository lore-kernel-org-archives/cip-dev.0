Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A425104C003
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:18 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17660.1773223516332982653
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=f39ZDBFY;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439c6fc2910so5584969f8f.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223514; x=1773828314; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ycWYFf85FyphEBBDsym8UYul7/Xv3plyklwSfg8Rmo=;
        b=f39ZDBFYSDdqyz5mn1aU4U3sb4YwfyfvhlM2DrDL0zz8nCa7QcCBzbz0C2Jh/5hZ7b
         SgEw2edOFBReT/l8KlLygzXrfkMkQnTOXuz6XYCGwCD3Y0uR7X8rrUEunwOdMJJDQfK8
         8molXJVb8eDldK5vOBHiat8TgFuJclY5bNaZHaxCHa3GsofRJrAsF4jvNpTPtGPxr8lb
         te+wcVxRrufVtiTauqBSQ5md6EoO9VfB3xycnh9wEX/rh+6G+ZCLp8Nx2qsGQ7cQOZ0F
         BAOIksMt3NSHWptaGjPsV3EK/KBbUw/DUxH3RlkDuGGBFvzURtl9upNf9a4zHFyIn/5s
         SQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223514; x=1773828314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ycWYFf85FyphEBBDsym8UYul7/Xv3plyklwSfg8Rmo=;
        b=m1sLMbCs18Xifc2TWepV3+oRcNaF+HzyvtAHU0B4YFbkgwUhUs8CFdvfVPnPuoV/8w
         u0/kntfta7MmFJsGSwhnkMl58TMovbbvAcZa/kQ05ZY+2e9G12tiih5g2ib/xC2R+zYr
         tcS/2tc/j7GaD5heWwVlVlEf+WuBi305T7C1DWZpKZtrzbnpfIxMtGZ+Sy0Db7mwot8d
         quYLArAhkG5RdHTcUbJvNVqI0vFgOka9zw+wVy2O9wakotXlSRQjPpdV1KJTQUSowfet
         7CXovdn7Y2TGDnah5nzYf7jVWzYejHVjgngYewhLcjHQpaIbXkaQR7Bh89k0Znv9wDgX
         VSrA==
X-Gm-Message-State: AOJu0YxoElHAJHwq2MDUQmH71zX0MT1bjZ28gAwn2OWdN8+eQSzKOcdE
	SQyXHjh67hk3mL+BPkNeLzL3kAygG2X5aetjFLIMNHXLbr0muLr2yIF9pblBaA==
X-Gm-Gg: ATEYQzz1iETUmKOTbJVbI9CiKGIq4C7wjk4/2wsQdlF1XOxYGf4BhZSV4On1O3dyJft
	3/v+zmcYhL42uBK9eAJNdYrLo3kA5JT4eXoTAlITr2oXm8MxVWCv0mxaHxcgFkaioc6onMyQ/HY
	loF4aTSYut4Zn135ZdcQbU5ou3sA1LuQ/1wS9a7/qmN00Dcq3S6FOL2T6wjajcdyPvVTgP5QoQP
	rXMXwxnChCgCbJJifsSCbfKkasqdiBvOEHbPcyGBFPxEpt4MEtyqAHfxQxT0B1/tW/zMFMdM5ut
	SRj6FfPV8AyvQ73cqzC2I1ErUUPc/lv5lnlAXngpdieRQeW4x/TeEJdeaw0z0RH7eKcM5oDSXaf
	1bWquETlRTCZHVr+C6VXDgc1XOkKL+MKtB5yKui//sdboOAR1vpE1tVS+rEmxTUQ3i51mzdwyd7
	IOShYWVymicim6B6L6d0YGAUd3jKeL2R8=
X-Received: by 2002:a05:6000:2282:b0:439:c2ce:1230 with SMTP id ffacd0b85a97d-439f843cd02mr3659102f8f.57.1773223513989;
        Wed, 11 Mar 2026 03:05:13 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:13 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 23/27] serial: rsci: Rename early_console data, port_params and callback() names
Date: Wed, 11 Mar 2026 10:04:42 +0000
Message-ID: <20260311100458.162447-24-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22268

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 068b862f5025920e3e10228e9904c2560e08b855 ]

Rename rsci_early_console_setup()->rsci_rzt2h_early_console_setup(),
the early_console data of_sci_rsci_data->of_rsci_rzt2h_data and the
port_params rsci_port_params->rsci_rzt2h_port_params to support RZ/G3E
RSCI that uses different data and callback().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-17-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/rsci.c   | 14 +++++++-------
 drivers/tty/serial/rsci.h   |  2 +-
 drivers/tty/serial/sh-sci.c |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 8a4f2618e53c..62a64fa73b74 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -418,7 +418,7 @@ static const struct sci_port_params_bits rsci_port_param_bits = {
 	.poll_sent_bits = CSR_TDRE | CSR_TEND,
 };
 
-static const struct sci_port_params rsci_port_params = {
+static const struct sci_port_params rsci_rzt2h_port_params = {
 	.fifosize = 16,
 	.overrun_reg = CSR,
 	.overrun_mask = CSR_ORER,
@@ -460,22 +460,22 @@ static const struct sci_port_ops rsci_port_ops = {
 	.shutdown_complete	= rsci_shutdown_complete,
 };
 
-struct sci_of_data of_sci_rsci_data = {
+struct sci_of_data of_rsci_rzt2h_data = {
 	.type = RSCI_PORT_SCIF16,
 	.ops = &rsci_port_ops,
 	.uart_ops = &rsci_uart_ops,
-	.params = &rsci_port_params,
+	.params = &rsci_rzt2h_port_params,
 };
 
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
 
-static int __init rsci_early_console_setup(struct earlycon_device *device,
-					   const char *opt)
+static int __init rsci_rzt2h_early_console_setup(struct earlycon_device *device,
+						 const char *opt)
 {
-	return scix_early_console_setup(device, &of_sci_rsci_data);
+	return scix_early_console_setup(device, &of_rsci_rzt2h_data);
 }
 
-OF_EARLYCON_DECLARE(rsci, "renesas,r9a09g077-rsci", rsci_early_console_setup);
+OF_EARLYCON_DECLARE(rsci, "renesas,r9a09g077-rsci", rsci_rzt2h_early_console_setup);
 
 #endif /* CONFIG_SERIAL_SH_SCI_EARLYCON */
 
diff --git a/drivers/tty/serial/rsci.h b/drivers/tty/serial/rsci.h
index 2af3f28b465a..9547148e8bd1 100644
--- a/drivers/tty/serial/rsci.h
+++ b/drivers/tty/serial/rsci.h
@@ -5,6 +5,6 @@
 
 #include "sh-sci-common.h"
 
-extern struct sci_of_data of_sci_rsci_data;
+extern struct sci_of_data of_rsci_rzt2h_data;
 
 #endif /* __RSCI_H__ */
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 588027a8068f..29e14e224d02 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3665,7 +3665,7 @@ static const struct of_device_id of_sci_match[] __maybe_unused = {
 #ifdef CONFIG_SERIAL_RSCI
 	{
 		.compatible = "renesas,r9a09g077-rsci",
-		.data = &of_sci_rsci_data,
+		.data = &of_rsci_rzt2h_data,
 	},
 #endif	/* CONFIG_SERIAL_RSCI */
 	/* Family-specific types */
-- 
2.43.0


