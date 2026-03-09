Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16A8F417E7
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:08 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15527.1773066359290919537
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:25:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Mr6yJqGr;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439ce3605ecso3163746f8f.0
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066357; x=1773671157; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiMKaFX4bXVJjRm5rNkO79+GKXOYFyAz3TFI/oBgSG4=;
        b=Mr6yJqGrTJWuP408uSKsoHp4JQQaCQYpxVMZNTJhcAwprrmFQPjBoue0XvUbVlDD1f
         jxobmy70bc6njZjskNOX6K7DjV4eJjiNrF5DaYawYHP6EaR95gbAP+vBGVPj99FoyxGq
         t81mWc2u79CpxE4HLcEgnodSUza7E9ROD3h7raA+msiVFxduGpQ4JGgcmqKU7RYHa/Xu
         /jF5LyqmMLdCidMlU4Spfx1qD5iPm2sZvjEBt5B4Za8ImqB345GczOwrLxLvlLZR76m2
         PbKrjgaoxPlosI85j4LnvuRZvJj6EM/X+8jehfodQ2Pt6mbGG5wWghQWARyMRd9yRoO9
         aqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066357; x=1773671157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JiMKaFX4bXVJjRm5rNkO79+GKXOYFyAz3TFI/oBgSG4=;
        b=BRG8c8mWSLjdxsWH+5/5ogUiXtrCSseTsaEU4KkEOGujOBdGSMvpa61kophAGtqxaa
         TnLckEHlTQA/GEivJV0m71sLdvoZ5uCHrMJSi9S1fT5bBfc3LzsHT8gJQv5wZgCYTZhp
         M08SXwB98XD6CBIkEeR3CGz5rjPRAjd1jry67FJiytpB8R1l64D+MR6/xzIiZm+tnR0f
         ixjXlgUdwmRQS+8P+Qf2GMQRB+hOsDI4Dembt9Wo4fzy8fMzZ6rKbXTVlGaba+hZOSd5
         EcpUNRAS1vmnsYrRAWEFfgTP/Q3AXkrbOgwOiF4lFPOLR6tsUq12oaJXZ03tu4Klodvh
         wsjg==
X-Gm-Message-State: AOJu0YycP0HG7d8wLsh7j/oMHl/GCTH0uobvCjBUl0VLWB9+nn5xuLCZ
	rfBnTq1yFzwihmHtl8HITXCSbalYoVDGYlzE+IHLCI1jf/DiYSQcaXqbMxJz3g==
X-Gm-Gg: ATEYQzxua5L670f3o+wpdRkn5cdn6VToI968LteVfzC3+t+P8VGyBdPUaP6NHGpPsYL
	gZr6C60TAMRfg3ObjpjihTbVVQk7GGAZ1OlNBpXSsOPgf2XtjGo+/y760YMMjSuF9RGru+g38PD
	Pt7HqRulkYPG3yrCZRI8GzMfhuvU8A8w5d1YywIRDMiqS/XaYEAm/yahiTOXjCN/XwNxOj0XzIb
	YeYEuZGYkvnnQ65PbHJhZtuhNYwqrqH/B1KRYxvmYxerquRsYwfEYhrmsc9G2O3gjsFKWMGIkJ2
	P2kO5cFoOiobtI7o6tsux82J9lRa6mOYdJWjzxUFeLMGtw2e7tm/2RS8i91fGZLquIylHicMF+K
	W2eTF2Z6b+Sl9gAzhmyRta+lTjh3q71OfPbsHe1JBrK/ml/jGrz4kDhSbtGmuS8IEdsWxVAYJix
	cAP26P6OvgV4MeShfBb/ixy4T3YO8+Dug=
X-Received: by 2002:a05:6000:144b:b0:439:ac33:5082 with SMTP id ffacd0b85a97d-439da66b72cmr20821080f8f.26.1773066357348;
        Mon, 09 Mar 2026 07:25:57 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:25:57 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 11/29] serial: sh-sci: Drop checking port type for device file{create, remove}
Date: Mon,  9 Mar 2026 14:25:11 +0000
Message-ID: <20260309142549.987737-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:26:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22179

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 42f7303c5f668403f06d9b938d3de2bda3736530 ]

Ports that support FIFO has fifosize > 1. Replace checking the port type
with fifosize for device file{create, remove}.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-5-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4da0251c0b10..7f23b63eca13 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3550,16 +3550,14 @@ static struct uart_driver sci_uart_driver = {
 static void sci_remove(struct platform_device *dev)
 {
 	struct sci_port *s = platform_get_drvdata(dev);
-	unsigned int type = s->type;	/* uart_remove_... clears it */
 
 	sci_ports_in_use &= ~BIT(s->port.line);
 	uart_remove_one_port(&sci_uart_driver, &s->port);
 
-	if (s->port.fifosize > 1)
+	if (s->port.fifosize > 1) {
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
-	if (type == PORT_SCIFA || type == PORT_SCIFB || type == PORT_HSCIF ||
-	    type == SCI_PORT_RSCI)
 		device_remove_file(&dev->dev, &dev_attr_rx_fifo_timeout);
+	}
 }
 
 static const struct sci_of_data of_sci_scif_sh2 = {
@@ -3915,15 +3913,10 @@ static int sci_probe(struct platform_device *dev)
 		ret = device_create_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 		if (ret)
 			return ret;
-	}
-	if (sp->type == PORT_SCIFA || sp->type == PORT_SCIFB ||
-	    sp->type == PORT_HSCIF || sp->type == SCI_PORT_RSCI) {
+
 		ret = device_create_file(&dev->dev, &dev_attr_rx_fifo_timeout);
 		if (ret) {
-			if (sp->port.fifosize > 1) {
-				device_remove_file(&dev->dev,
-						   &dev_attr_rx_fifo_trigger);
-			}
+			device_remove_file(&dev->dev, &dev_attr_rx_fifo_trigger);
 			return ret;
 		}
 	}
-- 
2.43.0


