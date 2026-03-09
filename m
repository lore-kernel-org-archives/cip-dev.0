Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7ABEFCD9B
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:08 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15550.1773066364607540403
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:26:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fzIx+XUR;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439a89b6fd0so8415309f8f.2
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066363; x=1773671163; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qm17LgjAKsPm40gvdYSyo25U9Gy8S3VLDJg37jzEfAE=;
        b=fzIx+XURpFkAHGbWY2OIMGic2+MkTADXq/xzgtPk+3BqgSxMknJse5xzlEe7gBGY3W
         ibHgvqKiGW+JEavTCYro44ffJZkOAQrARlPOHsuSeghUtOhnNMy8JTZQ+eWLQxm4y63h
         dOAES9MhaG6veOUjn5dZ6qDZirpMhcQMB8BsaYsJi2qz1jWQxqSDDC/ICUGiL36S8WbJ
         qLDwbbLwyjgdesLS/8y/4J6kqtvzkPKZY57AmRr4EkKJ6BmqEfJ69BFqH/P9rGQTSQZM
         t43vM0QjEDR2J3sis4vaZt5YGIb6UnY6ev05wH2eyImbi1jO5RUdWc/u+J5yEcZE5x0W
         KA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066363; x=1773671163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qm17LgjAKsPm40gvdYSyo25U9Gy8S3VLDJg37jzEfAE=;
        b=HXIpUfSc6uIJ+E6f7nIj1TXC18qUlvsdnsNqWC5Ks1q+ikXYZnhHRAJi1a5ofAObd8
         Xn6rYrVj0MoiF9nTg21XG1WKrYibuY6VD9M3U9hStDWFF6MhsOScRU/wM8e5wt6kDBDj
         fUd7+wxHvkho7EHmZF3N5pJM648YyETJmK9FQH58Q6qg1Nt3ERJNimexdehAqlKeMo6s
         HvwMQqvQPIMeJxvYKAeFVPt7xznR+sjXo4A/buR5CnBBDFRH9fEFvf4lCFPxIpSKF12p
         8pUJBJkbhC7kiiZBaCCnAIaK271+L13CnJtt1QFtn5HPr7Cpfv0VciwkITuYnjmdLeqK
         3wBQ==
X-Gm-Message-State: AOJu0YyFh/2o2ay7RAWf0yQlZiSM7+pTIn8v8S5kTqinj6req1+GJpze
	KuLrnte6Nh8Hb7MsZ5wJB4YdwIm16Ut5BdfT6rPaAI5DUKVWznF8ijn9Em8c1g==
X-Gm-Gg: ATEYQzzTzMBBs2ywY6s/7E1KI4itXVsqGHwzHe87GEbnGH+lg924pG7XCE9dWAM1BQL
	Cc6q3niXzb3JM1kS3pEl6lK04dnqI/f5z1Fn+ezClykUe4DRHHLxAGqFoiYOTDfuF9thMUxoPSu
	buHY3Psls1JiYNgJQHRvwkhwWS/jOAZiixJop95+nFLNGW5Db9cYkKAnSgLPx2RbZQl25j9kLEB
	aY43NlwvDcjAZHRnbOqOh3yfCpYIvcXf6sLOG2B6ZIpW3/3de80ctlSN9+e0pdaFTSYcVyEYcM5
	SW0zA9zHDGnf7LOiJOJ/N3UlZKhQKWUqerUli3y6wwmL3D70N4Kf7qT05gWJFNI1n/tPB9t7ASz
	oMKLzgP3W+kLpuAiFHVOMFAAMfPuwbfjBlHK22lh/71gKWdfuAu573nAohimtePNtdiEs0BNORa
	cY4sWmR/YiCsbqsgbL3oEpRoY/Tz2z/Dc=
X-Received: by 2002:a05:6000:2881:b0:437:711c:8754 with SMTP id ffacd0b85a97d-439da55541cmr20764059f8f.7.1773066362603;
        Mon, 09 Mar 2026 07:26:02 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:26:02 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 20/29] serial: sh-sci: Add support for RZ/G3E RSCI clks
Date: Mon,  9 Mar 2026 14:25:20 +0000
Message-ID: <20260309142549.987737-21-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:26:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22188

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
index 0a38fd760c4f..6e9cd8044b89 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3173,6 +3173,9 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 		[SCI_SCK] = "sck",
 		[SCI_BRG_INT] = "brg_int",
 		[SCI_SCIF_CLK] = "scif_clk",
+		[SCI_FCK_DIV4] = "tclk_div4",
+		[SCI_FCK_DIV16] = "tclk_div16",
+		[SCI_FCK_DIV64] = "tclk_div64",
 	};
 	struct clk *clk;
 	unsigned int i;
@@ -3182,6 +3185,9 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 	} else if (sci_port->type == RSCI_PORT_SCIF16) {
 		clk_names[SCI_FCK] = "operation";
 		clk_names[SCI_BRG_INT] = "bus";
+	} else if (sci_port->type == RSCI_PORT_SCIF32) {
+		clk_names[SCI_FCK] = "tclk";
+		clk_names[SCI_BRG_INT] = "pclk";
 	}
 
 	for (i = 0; i < SCI_NUM_CLKS; i++) {
@@ -3195,6 +3201,10 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
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


