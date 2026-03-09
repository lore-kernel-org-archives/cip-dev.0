Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBBDF417E0
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:08 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15545.1773066363561577317
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:26:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VAcyRU4R;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so9054415e9.3
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066362; x=1773671162; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XBEnRFRgPCSBDufHs6fXkf6o775gvHlNxdUS7yAiYU=;
        b=VAcyRU4Rhl5pEST4D1xinMlFf6B22R1aXXkJaYIXHqYrvp//VNV5RSwucZpTeEX/dd
         FNoRwnXkSK+2KkDuyM2i16BhLESSH7yQa5eLypAogxg6qcsoHujGie+49WQ3nwT6q90o
         ur+3O58fDa6go5pCa/R6C1SXDLOUTnB4Zd/WtM3VgdMRTURAYaRjE9P2Gj94+jolKc6x
         KOx7oJX5M2FfIgfLKN645YvWk1SCAt5QDHNmmxwB8fqzayEpPIOjetdWSzIbtfDbrfFA
         l9s7vE4+j5bcy3unnb3Zx/Ame/bMdNTGqP+1t1hzF9XsEyXqtu47O7dM7aLs4RAJ6NMA
         8u3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066362; x=1773671162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4XBEnRFRgPCSBDufHs6fXkf6o775gvHlNxdUS7yAiYU=;
        b=ZCoO65g/MxBNqLDhE7mMMnr2mH33fdzwhCtcLfnqxqKI7VGilrKPLXg08J6+qJdxNX
         xV6reFvQf2a/8m2LV9ARHnezySKuE1j5qy7AV2bxrY+zEdjIPTr176ufpvnoQ/w4DHVr
         BlDLOcvAKV4LB5+6b3D3kMtFoYHcZWfhxxGO6+Rqovx+klQ/pn+CvUknpob5vNCrKq1j
         7hjRF08+skkBYL7ZvsGD/QRyRtieXyyDNrG22lABIkDjF8Bax/xgouPFsCBNlD7K05Lf
         LCGWVyt2J6IcjU7Twzp963+X9J2P4RA7WofJTHX4kvLx9pnIOf6rS7H4zLmMJX6aXtOC
         ozRA==
X-Gm-Message-State: AOJu0YzBu+FPF6fUqXBsaAwWfeO2/IQhLKZc2GPqhibpSgLZQBQ0BPGy
	bUJ0y3ubSx8UHtfpcke7E8ku112t90oKq+yDM9RVNAQHWY1lEahun2khJzNi/w==
X-Gm-Gg: ATEYQzzqzMZ08i/6CchzngeTLEgb3KUMW5TwiWX1+hgXHFsVLJJdUxbhuV8FuB/+2xM
	FkCuZJzyxAWS1DTl2PXo1mkwfT/h1FmpFuRTco6jYJiKVhnTi7LIuaPTowMRbsrMQl1P4stVa4s
	oMtZkbbq98vrS2/OI3K7msqMetfaRgNxoNioqeLu4DEHlj3nFe9fF/l3+sGmRddnUwXlO2vuGkY
	+SMInErZz389xw8wPuay0SvTE7IyRm52ZB/Cr2Ul84HNjpHgsWqKwhcUc1pkFzj2yShrJNZv/73
	YrEnuXGGYUebObHVXw1rK2AWRWHLEkESN+hX8CXIMHSRmjQhpJeb0VlypYqYxn0+Gpmz5cqL+PG
	Gmb8RqPsYTKdFixJaQX9wrWMLfR4fZ5d6oFzPiSe5TXa99f5DLdI2EwA/w+/OXi2eLcKEb/rTkO
	sbnTYhT+RSRUJGnibw0PR6ZOgUD981CQg=
X-Received: by 2002:a05:600c:3b29:b0:485:3fd1:9936 with SMTP id 5b1f17b1804b1-4853fd19ac9mr24030245e9.5.1773066361506;
        Mon, 09 Mar 2026 07:26:01 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:26:01 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 18/29] serial: sh-sci: Rename port SCI_PORT_RSCI->RSCI_PORT_SCIF16
Date: Mon,  9 Mar 2026 14:25:18 +0000
Message-ID: <20260309142549.987737-19-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:26:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22186

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
index 0d0202265a10..c5dbc424da2b 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -462,7 +462,7 @@ static const struct sci_port_ops rsci_port_ops = {
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


