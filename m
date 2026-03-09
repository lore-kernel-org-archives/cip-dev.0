Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24531F417EB
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:09 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15556.1773066366102735300
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:26:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GrsUNxuN;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439cb5af25bso2078494f8f.1
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066364; x=1773671164; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCF92UVf3WFBDSGBYtvu+P7MLhM5E+PbhZAaggGKCIw=;
        b=GrsUNxuN4rn435o0l3dHNpD8utYx5GlATxWyvTJIM8zAEbgD82s1kAV4sGj4kqwb8n
         9sJOwKwNxu1NmJUrfP5XtC16z3IOBsZHWFPwmNENrCyDy6oq7weKpAIuEfI9ZbFlQm10
         byApHbh+sn35rVCuE/hBfZ/ocZxa38r8mqVLBc6uasPJckd6eLyT07aeUU9HlyxIImzA
         jY9p1hlpRIupSwEF+okAJ3YERjeCzL81qvUm56eIPDk/Jo26Qskl3WIfGGZYen0QS1ob
         /+9OYkHDyRtSQTPjK2YeoCg0qSBOsa29H91LOv4Q2dpbP9rRnsLsAlWBDQV4lewpMc6T
         q5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066364; x=1773671164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lCF92UVf3WFBDSGBYtvu+P7MLhM5E+PbhZAaggGKCIw=;
        b=k0yO7I3chKTzzYSX9Qb3QAvP0tSI0StHob/vbk/kpwwioajV2qtTtmgQsZmTaznUT9
         xMfrrZmT3KdZ3Kq69cs/bTmh3ZTq9pkp+adq1Wa3yQ9/t3Cto6JYixdLvnnSFvm3ye1I
         aNz82FRqtkVNlWMpGoubNDwCwKGADIX8GSS/l17dHOYK4dkQoSL4CylU4DQVFfgYJryr
         yZWZaBiWj+EuPPl34r5kpGtAmhM/iMYAcOaGqQZpcCENA9ZFnIu1gqXS/cmyXp/QXhIf
         2CeCpExXcyOkuFq1RNR+AOJ3eob3CjZ6pdZ3nZyO7+TELqVUVW0Tz8ugOxCrcRQQhCHk
         mojg==
X-Gm-Message-State: AOJu0YwSiWR/05YH+qL+cdKViYhNHPmsYsAvnNQpoPlWcZ5PSerAyTCC
	KVu39o+iHEk+1Aw9nioHtACuBURF66q8UlqYZUEtmcg/DT8TQOu0mKkuVMYs9A==
X-Gm-Gg: ATEYQzy9O0KYQZaM8DrydxNt4mftWP8xarW8EJncGxFVOPONgtrQbCtZKrHts+xsXAA
	biW7BdFJtel2rb6CC15Le6na8xUhzXMyCB12xieEh2BZeSHYKiBg0H0o/jxeN5/CZjnMvjqDGcH
	Hax7+u9d0x8bNKSj+rkF/X6mKW9dcfECPSbHPHqwrwOOA9hB1hlvb87W1A99Pk9K+n89E/v9P12
	phr93ltGNaG3D6ZIsxnUx37RLjiRnvjDCT8asvmaxC5muRhXYXWVtjoYCdfC++JkT2AyMf1BS+m
	sAiiuXaM7cixpLJbOwGdsh5OQZj32gvigOK3r4JigbTGQD5Ba3w6WhPznzvj3+bB6J7cJVkXQas
	EWzZYvYrGAc3tCcZB0b7oR0WNAin+wrYgp+KmzCPRuACH6itlMesrH/wDwUcpQ3MUYgfwBV1aN6
	MNUI6Woh3wlUGnE5goEDfXbJ5uotL0gcBXNIci5ggqug==
X-Received: by 2002:a05:6000:220d:b0:439:c43a:acb1 with SMTP id ffacd0b85a97d-439da67c0bcmr20721665f8f.35.1773066364205;
        Mon, 09 Mar 2026 07:26:04 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:26:04 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 23/29] serial: rsci: Rename early_console data, port_params and callback() names
Date: Mon,  9 Mar 2026 14:25:23 +0000
Message-ID: <20260309142549.987737-24-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:26:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22191

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
index c5dbc424da2b..3e93c6aa765e 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -419,7 +419,7 @@ static const struct sci_port_params_bits rsci_port_param_bits = {
 	.poll_sent_bits = CSR_TDRE | CSR_TEND,
 };
 
-static const struct sci_port_params rsci_port_params = {
+static const struct sci_port_params rsci_rzt2h_port_params = {
 	.fifosize = 16,
 	.overrun_reg = CSR,
 	.overrun_mask = CSR_ORER,
@@ -461,22 +461,22 @@ static const struct sci_port_ops rsci_port_ops = {
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


