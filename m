Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D15FB5EAD
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:46 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73446.1773746265614344782
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kCckTn+r;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so64073485e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746264; x=1774351064; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9j4IujBFkyUkaXfKRtPrIfmRmtVzRunUdjdAtdCfJQ=;
        b=kCckTn+r2Sx3VeJJb4MDP2FyBV758l71XDF/7fgFogNDz0oChqFoiZD9MKudZGQdR1
         ZYFhCRc2s+WuivlUe7fV1GOdUqMoRK975vVyLrYcEIaduzPABsFFCtFIVxuFkav7phjm
         o468zs7PVhjcjnzbYTK0dhNOzz1WemlGgfJI8dcdJ0sbVyesAbA0rJl7PT/tKcNo1lmX
         Gi0Igls9BnDPIulERm9dD704jwDoIKuK5IJqOyRBoahUun5jrqHd0GbADYGxXw99w9GW
         0aW9OC/9b1YBOmHIJnY2UULAYHIA9hglCzOKez5f1/MSvDyx+LC5W0IkafvnKbi6Za0a
         odlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746264; x=1774351064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o9j4IujBFkyUkaXfKRtPrIfmRmtVzRunUdjdAtdCfJQ=;
        b=bGi5WaEfQa72XpjJYxOH/L/f4baxnmloeLPuuDDfLHt8fWZVgb1xNqzbyEy5YqgMdl
         LJcoNpdT4I1iFAcYXDgqphqvr1ibblI/h58Ci3P6IhdcuJGavzwqsI4+4nZiZTkRnynf
         VZA6Fx2QubiB5XX9QrnpcRw1A6FNsDO0w2/6BdeKs/Umjl3lYg3et3bsm1KmaSVHVJ7y
         ilRIxkfhuoxCXPxNm8Jn14wfzbt3ahw5v8leNKnbravcLFKhGa582idOt8Ggd8UD21KC
         pSjkOY4hn9241674YW2Z+AwLQUoIocbREf8z3oiTavtYlKnGVjZ4AfylRASufcdSDDOx
         o+YA==
X-Gm-Message-State: AOJu0YxZ1W+Hk/1cJt0J0/wzPFRlBhUU++zUTSVtBo8EuXtT41M/aj79
	EzT8NGAojGOx0+49xCzpPSK3yNrzkoVawEJhqcILjV807AdCg88ujkyGJsQs7Q==
X-Gm-Gg: ATEYQzxJyY5s87CNkqXG7OqUSSGJ3EAs8sKVk1Vbg81mE+l7Gery5btMusdeGaG4dbQ
	jA9rRW+QOjMsbXB4BtvJvRphni+kRl3C3ANkQlz4umCYBd4wmrCsshVK66vlQByjzBMWEiaQT9x
	1zZgarjv+zgMgoO2/MtIQp7isyPijsPDr32LBtKH6hqh1Kr3iiAeijlFAzPpvZqJmR9fnDVC4y1
	MwrcMCDHZ26a2pRQ0dqlVzM8zhecV+5V7UBmXGr+aKCpaLv99A3BLzKKEIPS80THs3zFbJk0Loo
	k5tennmzIeAkCjMuTVbdeOZ0GIi/QTfgGb4bUaLD858sgZZjaydVZ94EGVhkHTmpdgSzH63873E
	gPs0a4D5UAUhEEmdq/msP1pRRNjoyyxEzQjmepvwEGlpx/tlaGV3VnCpKiH7Gy3jVn/tXVEqLEI
	VEPzCoymJp1B7x/ShJAFig1SvpVzsO0beQMc5C9nKN8vbhgJmF
X-Received: by 2002:a05:600c:3b14:b0:485:3aa1:a7f0 with SMTP id 5b1f17b1804b1-485566cfbadmr292516785e9.4.1773746263627;
        Tue, 17 Mar 2026 04:17:43 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:43 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 30/39] serial: sh-sci: Rename port SCI_PORT_RSCI->RSCI_PORT_SCIF16
Date: Tue, 17 Mar 2026 11:16:55 +0000
Message-ID: <20260317111718.281633-31-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22463

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
index 4fea7a3d74ec..8d089c65eff0 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -464,7 +464,7 @@ static const struct sci_port_ops rsci_port_ops = {
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
index a85e9aaf792f..680edd9d1771 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1186,7 +1186,7 @@ static int sci_handle_errors(struct uart_port *port)
 
 static bool sci_is_rsci_type(u8 type)
 {
-	return (type == SCI_PORT_RSCI);
+	return (type == RSCI_PORT_SCIF16);
 }
 
 static int sci_handle_fifo_overrun(struct uart_port *port)
@@ -3186,7 +3186,7 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 
 	if (sci_port->type == PORT_HSCIF) {
 		clk_names[SCI_SCK] = "hsck";
-	} else if (sci_port->type == SCI_PORT_RSCI) {
+	} else if (sci_port->type == RSCI_PORT_SCIF16) {
 		clk_names[SCI_FCK] = "operation";
 		clk_names[SCI_BRG_INT] = "bus";
 	}
@@ -3198,7 +3198,7 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 		if (IS_ERR(clk))
 			return PTR_ERR(clk);
 
-		if (!clk && sci_port->type == SCI_PORT_RSCI &&
+		if (!clk && sci_port->type == RSCI_PORT_SCIF16 &&
 		    (i == SCI_FCK || i == SCI_BRG_INT))
 			return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
 
@@ -3336,7 +3336,7 @@ static int sci_init_single(struct platform_device *dev,
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


