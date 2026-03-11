Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEB9104BEC3
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:16 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17335.1773223513799156964
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jmbojj1J;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b6d9c981so562782f8f.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223512; x=1773828312; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qm17LgjAKsPm40gvdYSyo25U9Gy8S3VLDJg37jzEfAE=;
        b=jmbojj1JpuaR7VwRfC86m3tRBFuXoo7k2a3w+egNGoXY6VWV8aT9yP8XGcwtMIBOyA
         jGvz8h5nD4VYCvflp0lAPFRYT1wXiQqXP4qsV2BTuK4PypshHVzbG//Ed6b0fV7M2qsM
         /FjNSo2isW2Y6Q6c1SPUBl2UaOD8AHJNRQXsiLlQpmSdz08HrkBUJazTW/u+gOB1KpCX
         o00+A3YNRbKrFnp0vcrNU8i8VhEwzvqjUXhxn24a+rEBwEW1d1pvBcLFquA+8sbnMG0W
         KR99OyTeuVe8Qkfi3F7hwtiw9Z8rYi+U2Voz4pZ3vW8gx6gU1FM9kzJqQe6S4q/tux8/
         NRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223512; x=1773828312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qm17LgjAKsPm40gvdYSyo25U9Gy8S3VLDJg37jzEfAE=;
        b=GzjZPOMqG1de9PKYkXo1sRTE23zUG5DzQesyKZpeFMVI29GNvqI3aPda6B3mX3CR42
         A9BEXkYPey4Yt5wWTuJ7ua52RppKIg18FxXRUe4Q/Dc5o54XywHyDr3/xmu4SrHg7BIm
         PLYEiy78ao+pKMzbqA3dAJCvA7req7LuqxnCq9IS7xFPMEeAXe7gnBKnlkRKIWAHx/lq
         9rHP/iaHP0pz5xipnatRmu77dpjUeqU031BUKLLIhJ5XBv++XU2xMZfjs37dkw/OaioR
         ddxnjJuok/xG2EFR446mGPdJEYE0y0JjUwsCw/jiF7A75cNHxQDQSQ5IC9X23CXMDxpF
         3kjw==
X-Gm-Message-State: AOJu0YzB1zrEIFqsonTR605R6nAjWRTjrgbslpttb91NBznYPSDxxX1Z
	+DQqUtsZcrgU7A8Wvg8ypfa/HcgWbknr/i41ChFaWIrqVglDMVI+RkuqGGc/eg==
X-Gm-Gg: ATEYQzxzboLmu9Y6RCEdQSsL2Oxnyy4x7FsXEkUYKL5pWYnohU5ozwDj1KuPivZnjpJ
	sKazLkkFsGrxj7CK2eLW0F+cRwBueGNsGXbPtesr4K7lV0Bh1BH2EvIl7f1kVcJfSn+g67Quosf
	Jp3hssQT4uQhcyFk1VXQnVx6hiO8vfFahAYLUigGPtWdwweKSgYQYfw+3xcGdl05dfNl8hwLwZ+
	7M1P1HdtDRxUqyfAj0091o/lK67lWRtbp5OM49v89ZdWHGfQLU+assFCkj0nx3r9b82aEowk4zw
	+MwkjBlNt1A7DP05sH16ItfiX6wjc3A4H/3Co0uj8axC5HbU70RWslfpm3NYUpBkoN1iRRdYXfn
	0cIoPwZo6Cs+G8+NzGbq5g+zwFPdDO1XAIBVMYkESb2I6EUCXQKeFu8dXS1ukxEg4TwtdxMDUqg
	m6oWnlCm7bXI3/IZ/kxf9JHxJO0Ljw/XI=
X-Received: by 2002:a05:6000:26cf:b0:439:c24b:ec27 with SMTP id ffacd0b85a97d-439f8bbd5f4mr3458561f8f.10.1773223511882;
        Wed, 11 Mar 2026 03:05:11 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:11 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 20/27] serial: sh-sci: Add support for RZ/G3E RSCI clks
Date: Wed, 11 Mar 2026 10:04:39 +0000
Message-ID: <20260311100458.162447-21-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22266

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


