Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F990F33838
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:56 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73449.1773746269512193249
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=O/XbE8d7;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso51002165e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746268; x=1774351068; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T54bXMiEuwaBOhzSTkOQJa/iPgPm6FMKk7vswrmdHRc=;
        b=O/XbE8d7ikMnKwqbOEskcq/o1s6chZFU1w2DR6oouPkwV3cB2o/0KptQzFbBbmMEmh
         4dNdtyklgI7X6DjhKIVh9YgY2wo3c7BZJb8Rme7zjigicJ3Gmkn6iIu/xC1szpKrIb36
         hXG15HuL8/kmlYL/iGgIXMfId9OB+HlLkKzT2BM+BCtL0q7uMXhrbIooAOzmw3liJ6fd
         iZIFkvsTYFloCmR+UZTsagV6pX8tHIUkH7ABzeZ9U7ChP3ISsU+xYVa6fPI62fTcCMLs
         QwucUif8COOXgO1mZi5ylwSnnkRQOH/cO4PEt6OW+BugymkhxUGIhUJXgmkmdt663rm/
         GTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746268; x=1774351068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T54bXMiEuwaBOhzSTkOQJa/iPgPm6FMKk7vswrmdHRc=;
        b=sWbgqQgKc6My2RBzpwDrj+c7Wlh6cjVCQXCh+KFjV7vI6wAiYzAGwXnzd8pry7mmnR
         8iXUG/Z/DCRxmm01zNyIR0fwi6+l60trlsOHgET14jEkGZCcDYL3e2IH1bMS5xauRf75
         KBo1ec4FQiR2kpxdNHGNuk3Nk4IBdwmw/E/cyGPUgFJRhS6z7eaCJ4g2+iOP+rcKDFsY
         TiP5Npq5fFoLL5LHncbeXqglsC2i1rAUTNPNM5AJLOKf9tp8qJyzLFDYSMSfU/8yjcGL
         EHUVZNMxJDQXKx6Tc98rrpHGe/KnArsmz7C4NHcb+uqsLJvVBPr1WKpQaiHa6pSeE6Jr
         x6BA==
X-Gm-Message-State: AOJu0Yzf4Y6NJ6l4bd9Tn7XUIHOXarf9T+tAh6u1xd4U0G4DQKmCjff3
	V+/XXr7H9wgLxrCn8NQYVZHnn3g5hYqeBf9jDPN3kyRY33fZi7PcgpLZAecxbg==
X-Gm-Gg: ATEYQzz2k0DqmUaUj4oB6Q6sDu3MwVovLz91Ym08yHp5zOZIpktAjiJpm07SrK+b5eE
	1CcUNkc5Ph+f6EeEMLyH3Czhw0oOqvO4Bgp2DQdUBYUosltTlha9VZmKWxIr7PtCa7WKG/07zvN
	3N1dSxjTEchQ9iqDmoknzIqsuHsZ4nh8dgFo8fNO7nMw2cz35XVNxvpbNVPesdNyaXGoV1egzuS
	Bvko+zzLLUvyiSfd8eruDl6dNfrqtaqoqFuB38RbvbE+lOD+jVxGAHVAoHRYcKmyjJzlWUhKfnJ
	PsUKghquG9Wg/nA4w0jdUB3/gYkpOIMxTmD2tJeAAi2mbcxRIZmLTs167f628uRN4vBqhsXR+Go
	aF0cDdv+pQJjozr51a7HyfZ+Lr/e0eDSTJcaw+r45gRnJ45XPEZKjfqaN5puppH/tMasI/hB3KA
	Y1FfY6n7N86FjlljPpYawPSNGsDPtuyEt/gkQYCug8prHJ0bY6
X-Received: by 2002:a05:600c:1d0f:b0:485:309c:2984 with SMTP id 5b1f17b1804b1-485566d2dfbmr280833775e9.13.1773746267381;
        Tue, 17 Mar 2026 04:17:47 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:47 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 35/39] serial: rsci: Rename early_console data, port_params and callback() names
Date: Tue, 17 Mar 2026 11:17:00 +0000
Message-ID: <20260317111718.281633-36-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22468

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
index 8d089c65eff0..0dd2c2359744 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -421,7 +421,7 @@ static const struct sci_port_params_bits rsci_port_param_bits = {
 	.poll_sent_bits = CSR_TDRE | CSR_TEND,
 };
 
-static const struct sci_port_params rsci_port_params = {
+static const struct sci_port_params rsci_rzt2h_port_params = {
 	.fifosize = 16,
 	.overrun_reg = CSR,
 	.overrun_mask = CSR_ORER,
@@ -463,22 +463,22 @@ static const struct sci_port_ops rsci_port_ops = {
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
index bb38396b7764..af896bafc69d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3662,7 +3662,7 @@ static const struct of_device_id of_sci_match[] __maybe_unused = {
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


