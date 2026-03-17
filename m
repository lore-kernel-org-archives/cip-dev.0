Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72441FB5EAD
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:56 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73448.1773746267289237304
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bGaOkVNm;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48628ce9ab5so6830735e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746265; x=1774351065; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlICd4IErceGUm6pCXvQp/h9br4mx65jEH3Inlm7XmU=;
        b=bGaOkVNm1jZy1HL+q6PgtYyG2ukgVJ6khqPT5z3006ifGKJ1lEY7h5OM1ebnEfSGUT
         lvtEvSHYHYIRX49oajDdcamXVExxWJcQ/5MVh2dO07ahgshjwBrKovGpMeRf2LquS7MC
         Jv0cBGDoHvb4VJZj29wUT+1LWg9S3+4C09MEnWZJ7tvh9qHaNcCAkpBGOJLVQdaXjPJC
         OHyXWYP9G/kyUyupwnArGIhHYtmNUwkuqBE287X5LCnjh4+meMiH7NqmkAg8R7Y+GLEy
         jNvnFQI6W+235G+dD4fTRX6oF6P7niCGphWpcCqC3sxtJb2mZguAx6gLe0NuBFbDoicn
         TXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746265; x=1774351065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OlICd4IErceGUm6pCXvQp/h9br4mx65jEH3Inlm7XmU=;
        b=hQbBYAOH5pXtSVwk/6+9Waqd8XoSBu+JEnWm/xSKi0ms+gPzbAQnYTdmI3uwyY2fo3
         cOrVrU2ebnzzJ5m02OGqV19ZVXWULAErv6j5OlERYxaZ4ZpcbGQBkgn2QfWx9lzMEWgs
         /hIkz18FepihfpLsrih6VGSxW8ldxqcGes7M/jBclOPNfcg90uPj5WQjdP30KWVfAKwl
         fhHNDLnFZWfJmpthaUvAdFNUb6l94D6n6zOLwj6KhNh9zqLMa8ezZmh2VYQU/cCzvZ27
         cVkwio+X+EoQwYChWEAUCrA7VyB2TmeG0cuG5Rq54JqzKfn7KonpbDqE8on5Xuy+wSM0
         GrQg==
X-Gm-Message-State: AOJu0Yzt+jfb/2gqznKqyNjTsDz/7R+dOqlqefZP2xAysy1Gw/cPACBJ
	BJcq6PNdVB0Rw8OwGGDgqEHopLgBUq+e1+uleAXG5qZg8AUAAEFCdHM9ciRWCA==
X-Gm-Gg: ATEYQzw5bTKNwfO2fosjeQFeZrURKaBqMHpj84cCKzkfGW5UxiiLQRhg5ghK5nzAIgH
	d/eyBVaEpX2KpxFJRWx70Qeqmx3agd9bNC8TncCVi1825qe94aqmNfIN3SNhW5CmIrkwSoAWF6O
	Q2CWrFTOOTbSFmL9O3RiEaf8q77K9TjwABOL8LOO5K2FAy9j0FrzrWFoHviXnWtSvQtAg+m+UPG
	qtj/jEd6sqM4wf8rZUPP1Ox3em3u4clv5ekZBeCwVXf0bqxtZaRu84rtSi45CsfWBzwzI2cOYy6
	42jOSOvx1UjbwrZ0mw/doKf5mmtZ8lBWvXKTHrofUkba4XoUHs82Nyuk5TRlvtQPveziBymvwpB
	ZzfxdsBj6SzTqNgF0rg9c0zNRgu052YdEndXYCwzI6WGavazMDk4bxqyBhYusbYYwL/G9SxnfKA
	vzQlaKi9JvHFKLOnQYSiHV7zqa3KNIucZKDNz8hSUMLFWD/Ibm
X-Received: by 2002:a05:600c:45d5:b0:485:4535:73d with SMTP id 5b1f17b1804b1-485566cfb8amr264164805e9.2.1773746265240;
        Tue, 17 Mar 2026 04:17:45 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:44 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 32/39] serial: sh-sci: Add support for RZ/G3E RSCI clks
Date: Tue, 17 Mar 2026 11:16:57 +0000
Message-ID: <20260317111718.281633-33-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22465

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 83c405ec3a340a334c46bb59b07e5799f6d205a4 ]

RZ/G3E RSCI has 6 clocks (5 module clocks + 1 external clock). Add
support for the module clocks.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-14-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci-common.h |  3 +++
 drivers/tty/serial/sh-sci.c        | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index abcd5bcc7c36..5d30771278b4 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -16,6 +16,9 @@ enum SCI_CLKS {
 	SCI_SCK,		/* Optional External Clock */
 	SCI_BRG_INT,		/* Optional BRG Internal Clock Source */
 	SCI_SCIF_CLK,		/* Optional BRG External Clock Source */
+	SCI_FCK_DIV4,		/* Optional Functional Clock frequency-divided by 4 */
+	SCI_FCK_DIV16,		/* Optional Functional Clock frequency-divided by 16 */
+	SCI_FCK_DIV64,		/* Optional Functional Clock frequency-divided by 64 */
 	SCI_NUM_CLKS
 };
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 54274112c3f5..13a1c6671cc9 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3180,6 +3180,9 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 		[SCI_SCK] = "sck",
 		[SCI_BRG_INT] = "brg_int",
 		[SCI_SCIF_CLK] = "scif_clk",
+		[SCI_FCK_DIV4] = "tclk_div4",
+		[SCI_FCK_DIV16] = "tclk_div16",
+		[SCI_FCK_DIV64] = "tclk_div64",
 	};
 	struct clk *clk;
 	unsigned int i;
@@ -3189,6 +3192,9 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 	} else if (sci_port->type == RSCI_PORT_SCIF16) {
 		clk_names[SCI_FCK] = "operation";
 		clk_names[SCI_BRG_INT] = "bus";
+	} else if (sci_port->type == RSCI_PORT_SCIF32) {
+		clk_names[SCI_FCK] = "tclk";
+		clk_names[SCI_BRG_INT] = "pclk";
 	}
 
 	for (i = 0; i < SCI_NUM_CLKS; i++) {
@@ -3202,6 +3208,10 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 		    (i == SCI_FCK || i == SCI_BRG_INT))
 			return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
 
+		if (!clk && sci_port->type == RSCI_PORT_SCIF32 &&
+		    (i != SCI_SCK && i != SCI_SCIF_CLK))
+			return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
+
 		if (!clk && i == SCI_FCK) {
 			/*
 			 * Not all SH platforms declare a clock lookup entry
-- 
2.43.0


