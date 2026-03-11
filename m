Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748FE104BED7
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:17 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17648.1773223506189100975
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YtIjWdn/;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48529c325f0so36613675e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223504; x=1773828304; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udeq9iO+QhOsF9IuwzpZCz/PfB4IlnfCDriFbelZl58=;
        b=YtIjWdn/C2BRrgbt6OO/b+RTgFfpE7TtmBYxNP71ci+b/KQc+2VvNq/ThkLUGVrQ+A
         V7VaIgoN9sj7YtJnGLsmU4+JAWYrvXc5h6P7oaInA6+F552Mz7lwCuqhR6S68bmRTknd
         JZHdkgWfyO75hSgRPSyBEmwHp235QSA4Su1IyeqIf4oro1o2L762zHR4dm9ETTy37WkZ
         33qIsSkb8YhKEB0VQ61nB3qngHoXU1kc9ReqdERg6+lpNnMkfTpB2MnalDrxWu3sFy7k
         Zm303bSsv9R3D555QnpjkzfA1HMervAat2xSWQltaln2mNWsoj38U26rlF5o2zxn23f8
         H8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223504; x=1773828304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=udeq9iO+QhOsF9IuwzpZCz/PfB4IlnfCDriFbelZl58=;
        b=rhEhahiom5LZ3uOg8oqqvx3iAuukKrvrhFWJeqc+LHyyxBUG4495WqK2lcFY8/iwUZ
         o6sDy2fiRLHhpeG0IBK3jA7dAHrr8jX+r8ES/sH0mtv79tVaIAekWZlE+PNmny0GL5Ii
         92siAphUko1UII/8gTxE6m2j/nNO/gcY1q/vDnR0p/QnG2AIP4zYc1r3BvlnOmurFNZv
         kX4n76x4+4KnkZj1h74jaiEvC2I7MO6uVZtIXiyzArcaoFNW/jaAQBtkoH6hxFudAJCm
         RJm0eud/vP6L5K3AZEasGOez2MPJGx8dWERsfzGplSvXC+Gb/2PgplDv7+F/TFBi9Xmo
         BNEw==
X-Gm-Message-State: AOJu0YyHpCdasHIG0n0d7lH29eIV1/w5MxkKNIoi4Bfn/FZKejGmQYUN
	8zv1Da1M1LfnHKHqgXkCT1L/dzKdv/c5JeGykqLk4koZtBCrfxLkCKmEygHxRw==
X-Gm-Gg: ATEYQzyECDsa1Ugpy1qtSbbA6/VfiXDbRpPQ0IhPuCb7NsgZHKOfFYnD131R7Tf2mGJ
	IWyuEZhHOVTEGpnXBjvM/kxkLZv8/kxAI9U730CLJ7J3C8L67WhM4j31pwxVttP8qC1AsHneLY5
	v6k4LnQs7c5RcC90BQMW9jgDFITE2CTtyTMLgv1wQhillGbFGvkY5eup1LdCtKnNis0BWQe5hMV
	SrOrGlSzgqpQsg9nwDlgyfkVl8IbqdsD5VzyY6fguh51qiPEe4En+4kXtU3Xht4vNVIJRmekkn9
	8q4J/O596nhEEvaD+m20YpDImJ3r8EhrZdLuIEqEYKVmj4NRPOzSj6y0sgbtOtGPxmEgYdVChf3
	c6rcuBetoRnWRsmScoCVK/hWW1tEJlP9WQPW/T1dxhHD/jCNJkc0M2WR8aJXPzFP4TINuuGaG0t
	eDshhLbp12+N5DYBBt4nRHxXKIcEUQocw=
X-Received: by 2002:a05:600c:3b16:b0:485:3ee1:eba5 with SMTP id 5b1f17b1804b1-4854b10ed0emr28556525e9.27.1773223503337;
        Wed, 11 Mar 2026 03:05:03 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:03 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 07/27] serial: sh-sci: Merge sh-sci.h into sh-sci.c
Date: Wed, 11 Mar 2026 10:04:26 +0000
Message-ID: <20260311100458.162447-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22253

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 719f3df3e113e03d2c8cf324827da1fd17a9bd8f ]

Inline the contents of sh-sci.h into sh-sci.c and remove the
header file. The header only contained register definitions
and macros used exclusively by the sh-sci driver, making the
separate header unnecessary.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251023104313.210989-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 176 ++++++++++++++++++++++++++++++++++-
 drivers/tty/serial/sh-sci.h | 178 ------------------------------------
 2 files changed, 175 insertions(+), 179 deletions(-)
 delete mode 100644 drivers/tty/serial/sh-sci.h

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ceb16b964f63..1cb9d474c0f1 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -17,6 +17,7 @@
  */
 #undef DEBUG
 
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/cpufreq.h>
@@ -28,6 +29,7 @@
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/ktime.h>
 #include <linux/major.h>
@@ -40,6 +42,7 @@
 #include <linux/reset.h>
 #include <linux/scatterlist.h>
 #include <linux/serial.h>
+#include <linux/serial_core.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_dma.h>
 #include <linux/slab.h>
@@ -57,7 +60,178 @@
 #include "rsci.h"
 #include "serial_mctrl_gpio.h"
 #include "sh-sci-common.h"
-#include "sh-sci.h"
+
+#define SCI_MAJOR		204
+#define SCI_MINOR_START		8
+
+/*
+ * SCI register subset common for all port types.
+ * Not all registers will exist on all parts.
+ */
+enum {
+	SCSMR,		/* Serial Mode Register */
+	SCBRR,		/* Bit Rate Register */
+	SCSCR,		/* Serial Control Register */
+	SCxSR,		/* Serial Status Register */
+	SCFCR,		/* FIFO Control Register */
+	SCFDR,		/* FIFO Data Count Register */
+	SCxTDR,		/* Transmit (FIFO) Data Register */
+	SCxRDR,		/* Receive (FIFO) Data Register */
+	SCLSR,		/* Line Status Register */
+	SCTFDR,		/* Transmit FIFO Data Count Register */
+	SCRFDR,		/* Receive FIFO Data Count Register */
+	SCSPTR,		/* Serial Port Register */
+	HSSRR,		/* Sampling Rate Register */
+	SCPCR,		/* Serial Port Control Register */
+	SCPDR,		/* Serial Port Data Register */
+	SCDL,		/* BRG Frequency Division Register */
+	SCCKS,		/* BRG Clock Select Register */
+	HSRTRGR,	/* Rx FIFO Data Count Trigger Register */
+	HSTTRGR,	/* Tx FIFO Data Count Trigger Register */
+	SEMR,		/* Serial extended mode register */
+};
+
+/* SCSMR (Serial Mode Register) */
+#define SCSMR_C_A	BIT(7)	/* Communication Mode */
+#define SCSMR_CSYNC	BIT(7)	/*   - Clocked synchronous mode */
+#define SCSMR_ASYNC	0	/*   - Asynchronous mode */
+#define SCSMR_CHR	BIT(6)	/* 7-bit Character Length */
+#define SCSMR_PE	BIT(5)	/* Parity Enable */
+#define SCSMR_ODD	BIT(4)	/* Odd Parity */
+#define SCSMR_STOP	BIT(3)	/* Stop Bit Length */
+#define SCSMR_CKS	0x0003	/* Clock Select */
+
+/* Serial Mode Register, SCIFA/SCIFB only bits */
+#define SCSMR_CKEDG	BIT(12)	/* Transmit/Receive Clock Edge Select */
+#define SCSMR_SRC_MASK	0x0700	/* Sampling Control */
+#define SCSMR_SRC_16	0x0000	/* Sampling rate 1/16 */
+#define SCSMR_SRC_5	0x0100	/* Sampling rate 1/5 */
+#define SCSMR_SRC_7	0x0200	/* Sampling rate 1/7 */
+#define SCSMR_SRC_11	0x0300	/* Sampling rate 1/11 */
+#define SCSMR_SRC_13	0x0400	/* Sampling rate 1/13 */
+#define SCSMR_SRC_17	0x0500	/* Sampling rate 1/17 */
+#define SCSMR_SRC_19	0x0600	/* Sampling rate 1/19 */
+#define SCSMR_SRC_27	0x0700	/* Sampling rate 1/27 */
+
+/* Serial Control Register, SCI only bits */
+#define SCSCR_TEIE	BIT(2)  /* Transmit End Interrupt Enable */
+
+/* Serial Control Register, SCIFA/SCIFB only bits */
+#define SCSCR_TDRQE	BIT(15)	/* Tx Data Transfer Request Enable */
+#define SCSCR_RDRQE	BIT(14)	/* Rx Data Transfer Request Enable */
+
+/* Serial Control Register, HSCIF-only bits */
+#define HSSCR_TOT_SHIFT	14
+
+/* SCxSR (Serial Status Register) on SCI */
+#define SCI_TDRE	BIT(7)	/* Transmit Data Register Empty */
+#define SCI_RDRF	BIT(6)	/* Receive Data Register Full */
+#define SCI_ORER	BIT(5)	/* Overrun Error */
+#define SCI_FER		BIT(4)	/* Framing Error */
+#define SCI_PER		BIT(3)	/* Parity Error */
+#define SCI_TEND	BIT(2)	/* Transmit End */
+#define SCI_RESERVED	0x03	/* All reserved bits */
+
+#define SCI_DEFAULT_ERROR_MASK (SCI_PER | SCI_FER)
+
+#define SCI_RDxF_CLEAR	(u32)(~(SCI_RESERVED | SCI_RDRF))
+#define SCI_ERROR_CLEAR	(u32)(~(SCI_RESERVED | SCI_PER | SCI_FER | SCI_ORER))
+#define SCI_TDxE_CLEAR	(u32)(~(SCI_RESERVED | SCI_TEND | SCI_TDRE))
+#define SCI_BREAK_CLEAR	(u32)(~(SCI_RESERVED | SCI_PER | SCI_FER | SCI_ORER))
+
+/* SCxSR (Serial Status Register) on SCIF, SCIFA, SCIFB, HSCIF */
+#define SCIF_ER		BIT(7)	/* Receive Error */
+#define SCIF_TEND	BIT(6)	/* Transmission End */
+#define SCIF_TDFE	BIT(5)	/* Transmit FIFO Data Empty */
+#define SCIF_BRK	BIT(4)	/* Break Detect */
+#define SCIF_FER	BIT(3)	/* Framing Error */
+#define SCIF_PER	BIT(2)	/* Parity Error */
+#define SCIF_RDF	BIT(1)	/* Receive FIFO Data Full */
+#define SCIF_DR		BIT(0)	/* Receive Data Ready */
+/* SCIF only (optional) */
+#define SCIF_PERC	0xf000	/* Number of Parity Errors */
+#define SCIF_FERC	0x0f00	/* Number of Framing Errors */
+/*SCIFA/SCIFB and SCIF on SH7705/SH7720/SH7721 only */
+#define SCIFA_ORER	BIT(9)	/* Overrun Error */
+
+#define SCIF_DEFAULT_ERROR_MASK (SCIF_PER | SCIF_FER | SCIF_BRK | SCIF_ER)
+
+#define SCIF_RDxF_CLEAR		(u32)(~(SCIF_DR | SCIF_RDF))
+#define SCIF_ERROR_CLEAR	(u32)(~(SCIF_PER | SCIF_FER | SCIF_ER))
+#define SCIF_TDxE_CLEAR		(u32)(~(SCIF_TDFE))
+#define SCIF_BREAK_CLEAR	(u32)(~(SCIF_PER | SCIF_FER | SCIF_BRK))
+
+/* SCFCR (FIFO Control Register) */
+#define SCFCR_RTRG1	BIT(7)	/* Receive FIFO Data Count Trigger */
+#define SCFCR_RTRG0	BIT(6)
+#define SCFCR_TTRG1	BIT(5)	/* Transmit FIFO Data Count Trigger */
+#define SCFCR_TTRG0	BIT(4)
+#define SCFCR_MCE	BIT(3)	/* Modem Control Enable */
+#define SCFCR_TFRST	BIT(2)	/* Transmit FIFO Data Register Reset */
+#define SCFCR_RFRST	BIT(1)	/* Receive FIFO Data Register Reset */
+#define SCFCR_LOOP	BIT(0)	/* Loopback Test */
+
+/* SCLSR (Line Status Register) on (H)SCIF */
+#define SCLSR_TO	BIT(2)	/* Timeout */
+#define SCLSR_ORER	BIT(0)	/* Overrun Error */
+
+/* SCSPTR (Serial Port Register), optional */
+#define SCSPTR_RTSIO	BIT(7)	/* Serial Port RTS# Pin Input/Output */
+#define SCSPTR_RTSDT	BIT(6)	/* Serial Port RTS# Pin Data */
+#define SCSPTR_CTSIO	BIT(5)	/* Serial Port CTS# Pin Input/Output */
+#define SCSPTR_CTSDT	BIT(4)	/* Serial Port CTS# Pin Data */
+#define SCSPTR_SCKIO	BIT(3)	/* Serial Port Clock Pin Input/Output */
+#define SCSPTR_SCKDT	BIT(2)	/* Serial Port Clock Pin Data */
+#define SCSPTR_SPB2IO	BIT(1)	/* Serial Port Break Input/Output */
+#define SCSPTR_SPB2DT	BIT(0)	/* Serial Port Break Data */
+
+/* HSSRR HSCIF */
+#define HSCIF_SRE	BIT(15)	/* Sampling Rate Register Enable */
+#define HSCIF_SRDE	BIT(14) /* Sampling Point Register Enable */
+
+#define HSCIF_SRHP_SHIFT	8
+#define HSCIF_SRHP_MASK		0x0f00
+
+/* SCPCR (Serial Port Control Register), SCIFA/SCIFB only */
+#define SCPCR_RTSC	BIT(4)	/* Serial Port RTS# Pin / Output Pin */
+#define SCPCR_CTSC	BIT(3)	/* Serial Port CTS# Pin / Input Pin */
+#define SCPCR_SCKC	BIT(2)	/* Serial Port SCK Pin / Output Pin */
+#define SCPCR_RXDC	BIT(1)	/* Serial Port RXD Pin / Input Pin */
+#define SCPCR_TXDC	BIT(0)	/* Serial Port TXD Pin / Output Pin */
+
+/* SCPDR (Serial Port Data Register), SCIFA/SCIFB only */
+#define SCPDR_RTSD	BIT(4)	/* Serial Port RTS# Output Pin Data */
+#define SCPDR_CTSD	BIT(3)	/* Serial Port CTS# Input Pin Data */
+#define SCPDR_SCKD	BIT(2)	/* Serial Port SCK Output Pin Data */
+#define SCPDR_RXDD	BIT(1)	/* Serial Port RXD Input Pin Data */
+#define SCPDR_TXDD	BIT(0)	/* Serial Port TXD Output Pin Data */
+
+/*
+ * BRG Clock Select Register (Some SCIF and HSCIF)
+ * The Baud Rate Generator for external clock can provide a clock source for
+ * the sampling clock. It outputs either its frequency divided clock, or the
+ * (undivided) (H)SCK external clock.
+ */
+#define SCCKS_CKS	BIT(15)	/* Select (H)SCK (1) or divided SC_CLK (0) */
+#define SCCKS_XIN	BIT(14)	/* SC_CLK uses bus clock (1) or SCIF_CLK (0) */
+
+#define SCxSR_TEND(port)	(((port)->type == PORT_SCI) ? SCI_TEND   : SCIF_TEND)
+#define SCxSR_RDxF(port)	(((port)->type == PORT_SCI) ? SCI_RDRF   : SCIF_DR | SCIF_RDF)
+#define SCxSR_TDxE(port)	(((port)->type == PORT_SCI) ? SCI_TDRE   : SCIF_TDFE)
+#define SCxSR_FER(port)		(((port)->type == PORT_SCI) ? SCI_FER    : SCIF_FER)
+#define SCxSR_PER(port)		(((port)->type == PORT_SCI) ? SCI_PER    : SCIF_PER)
+#define SCxSR_BRK(port)		(((port)->type == PORT_SCI) ? 0x00       : SCIF_BRK)
+
+#define SCxSR_ERRORS(port)	(to_sci_port(port)->params->error_mask)
+
+#define SCxSR_RDxF_CLEAR(port) \
+	(((port)->type == PORT_SCI) ? SCI_RDxF_CLEAR : SCIF_RDxF_CLEAR)
+#define SCxSR_ERROR_CLEAR(port) \
+	(to_sci_port(port)->params->error_clear)
+#define SCxSR_TDxE_CLEAR(port) \
+	(((port)->type == PORT_SCI) ? SCI_TDxE_CLEAR : SCIF_TDxE_CLEAR)
+#define SCxSR_BREAK_CLEAR(port) \
+	(((port)->type == PORT_SCI) ? SCI_BREAK_CLEAR : SCIF_BREAK_CLEAR)
 
 #define SCIx_IRQ_IS_MUXED(port)			\
 	((port)->irqs[SCIx_ERI_IRQ] ==	\
diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
deleted file mode 100644
index 951681aba586..000000000000
--- a/drivers/tty/serial/sh-sci.h
+++ /dev/null
@@ -1,178 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <linux/bitops.h>
-#include <linux/serial_core.h>
-#include <linux/io.h>
-
-#define SCI_MAJOR		204
-#define SCI_MINOR_START		8
-
-
-/*
- * SCI register subset common for all port types.
- * Not all registers will exist on all parts.
- */
-enum {
-	SCSMR,				/* Serial Mode Register */
-	SCBRR,				/* Bit Rate Register */
-	SCSCR,				/* Serial Control Register */
-	SCxSR,				/* Serial Status Register */
-	SCFCR,				/* FIFO Control Register */
-	SCFDR,				/* FIFO Data Count Register */
-	SCxTDR,				/* Transmit (FIFO) Data Register */
-	SCxRDR,				/* Receive (FIFO) Data Register */
-	SCLSR,				/* Line Status Register */
-	SCTFDR,				/* Transmit FIFO Data Count Register */
-	SCRFDR,				/* Receive FIFO Data Count Register */
-	SCSPTR,				/* Serial Port Register */
-	HSSRR,				/* Sampling Rate Register */
-	SCPCR,				/* Serial Port Control Register */
-	SCPDR,				/* Serial Port Data Register */
-	SCDL,				/* BRG Frequency Division Register */
-	SCCKS,				/* BRG Clock Select Register */
-	HSRTRGR,			/* Rx FIFO Data Count Trigger Register */
-	HSTTRGR,			/* Tx FIFO Data Count Trigger Register */
-	SEMR,				/* Serial extended mode register */
-};
-
-
-/* SCSMR (Serial Mode Register) */
-#define SCSMR_C_A	BIT(7)	/* Communication Mode */
-#define SCSMR_CSYNC	BIT(7)	/*   - Clocked synchronous mode */
-#define SCSMR_ASYNC	0	/*   - Asynchronous mode */
-#define SCSMR_CHR	BIT(6)	/* 7-bit Character Length */
-#define SCSMR_PE	BIT(5)	/* Parity Enable */
-#define SCSMR_ODD	BIT(4)	/* Odd Parity */
-#define SCSMR_STOP	BIT(3)	/* Stop Bit Length */
-#define SCSMR_CKS	0x0003	/* Clock Select */
-
-/* Serial Mode Register, SCIFA/SCIFB only bits */
-#define SCSMR_CKEDG	BIT(12)	/* Transmit/Receive Clock Edge Select */
-#define SCSMR_SRC_MASK	0x0700	/* Sampling Control */
-#define SCSMR_SRC_16	0x0000	/* Sampling rate 1/16 */
-#define SCSMR_SRC_5	0x0100	/* Sampling rate 1/5 */
-#define SCSMR_SRC_7	0x0200	/* Sampling rate 1/7 */
-#define SCSMR_SRC_11	0x0300	/* Sampling rate 1/11 */
-#define SCSMR_SRC_13	0x0400	/* Sampling rate 1/13 */
-#define SCSMR_SRC_17	0x0500	/* Sampling rate 1/17 */
-#define SCSMR_SRC_19	0x0600	/* Sampling rate 1/19 */
-#define SCSMR_SRC_27	0x0700	/* Sampling rate 1/27 */
-
-/* Serial Control Register, SCI only bits */
-#define SCSCR_TEIE	BIT(2)  /* Transmit End Interrupt Enable */
-
-/* Serial Control Register, SCIFA/SCIFB only bits */
-#define SCSCR_TDRQE	BIT(15)	/* Tx Data Transfer Request Enable */
-#define SCSCR_RDRQE	BIT(14)	/* Rx Data Transfer Request Enable */
-
-/* Serial Control Register, HSCIF-only bits */
-#define HSSCR_TOT_SHIFT	14
-
-/* SCxSR (Serial Status Register) on SCI */
-#define SCI_TDRE	BIT(7)	/* Transmit Data Register Empty */
-#define SCI_RDRF	BIT(6)	/* Receive Data Register Full */
-#define SCI_ORER	BIT(5)	/* Overrun Error */
-#define SCI_FER		BIT(4)	/* Framing Error */
-#define SCI_PER		BIT(3)	/* Parity Error */
-#define SCI_TEND	BIT(2)	/* Transmit End */
-#define SCI_RESERVED	0x03	/* All reserved bits */
-
-#define SCI_DEFAULT_ERROR_MASK (SCI_PER | SCI_FER)
-
-#define SCI_RDxF_CLEAR	(u32)(~(SCI_RESERVED | SCI_RDRF))
-#define SCI_ERROR_CLEAR	(u32)(~(SCI_RESERVED | SCI_PER | SCI_FER | SCI_ORER))
-#define SCI_TDxE_CLEAR	(u32)(~(SCI_RESERVED | SCI_TEND | SCI_TDRE))
-#define SCI_BREAK_CLEAR	(u32)(~(SCI_RESERVED | SCI_PER | SCI_FER | SCI_ORER))
-
-/* SCxSR (Serial Status Register) on SCIF, SCIFA, SCIFB, HSCIF */
-#define SCIF_ER		BIT(7)	/* Receive Error */
-#define SCIF_TEND	BIT(6)	/* Transmission End */
-#define SCIF_TDFE	BIT(5)	/* Transmit FIFO Data Empty */
-#define SCIF_BRK	BIT(4)	/* Break Detect */
-#define SCIF_FER	BIT(3)	/* Framing Error */
-#define SCIF_PER	BIT(2)	/* Parity Error */
-#define SCIF_RDF	BIT(1)	/* Receive FIFO Data Full */
-#define SCIF_DR		BIT(0)	/* Receive Data Ready */
-/* SCIF only (optional) */
-#define SCIF_PERC	0xf000	/* Number of Parity Errors */
-#define SCIF_FERC	0x0f00	/* Number of Framing Errors */
-/*SCIFA/SCIFB and SCIF on SH7705/SH7720/SH7721 only */
-#define SCIFA_ORER	BIT(9)	/* Overrun Error */
-
-#define SCIF_DEFAULT_ERROR_MASK (SCIF_PER | SCIF_FER | SCIF_BRK | SCIF_ER)
-
-#define SCIF_RDxF_CLEAR		(u32)(~(SCIF_DR | SCIF_RDF))
-#define SCIF_ERROR_CLEAR	(u32)(~(SCIF_PER | SCIF_FER | SCIF_ER))
-#define SCIF_TDxE_CLEAR		(u32)(~(SCIF_TDFE))
-#define SCIF_BREAK_CLEAR	(u32)(~(SCIF_PER | SCIF_FER | SCIF_BRK))
-
-/* SCFCR (FIFO Control Register) */
-#define SCFCR_RTRG1	BIT(7)	/* Receive FIFO Data Count Trigger */
-#define SCFCR_RTRG0	BIT(6)
-#define SCFCR_TTRG1	BIT(5)	/* Transmit FIFO Data Count Trigger */
-#define SCFCR_TTRG0	BIT(4)
-#define SCFCR_MCE	BIT(3)	/* Modem Control Enable */
-#define SCFCR_TFRST	BIT(2)	/* Transmit FIFO Data Register Reset */
-#define SCFCR_RFRST	BIT(1)	/* Receive FIFO Data Register Reset */
-#define SCFCR_LOOP	BIT(0)	/* Loopback Test */
-
-/* SCLSR (Line Status Register) on (H)SCIF */
-#define SCLSR_TO	BIT(2)	/* Timeout */
-#define SCLSR_ORER	BIT(0)	/* Overrun Error */
-
-/* SCSPTR (Serial Port Register), optional */
-#define SCSPTR_RTSIO	BIT(7)	/* Serial Port RTS# Pin Input/Output */
-#define SCSPTR_RTSDT	BIT(6)	/* Serial Port RTS# Pin Data */
-#define SCSPTR_CTSIO	BIT(5)	/* Serial Port CTS# Pin Input/Output */
-#define SCSPTR_CTSDT	BIT(4)	/* Serial Port CTS# Pin Data */
-#define SCSPTR_SCKIO	BIT(3)	/* Serial Port Clock Pin Input/Output */
-#define SCSPTR_SCKDT	BIT(2)	/* Serial Port Clock Pin Data */
-#define SCSPTR_SPB2IO	BIT(1)	/* Serial Port Break Input/Output */
-#define SCSPTR_SPB2DT	BIT(0)	/* Serial Port Break Data */
-
-/* HSSRR HSCIF */
-#define HSCIF_SRE	BIT(15)	/* Sampling Rate Register Enable */
-#define HSCIF_SRDE	BIT(14) /* Sampling Point Register Enable */
-
-#define HSCIF_SRHP_SHIFT	8
-#define HSCIF_SRHP_MASK		0x0f00
-
-/* SCPCR (Serial Port Control Register), SCIFA/SCIFB only */
-#define SCPCR_RTSC	BIT(4)	/* Serial Port RTS# Pin / Output Pin */
-#define SCPCR_CTSC	BIT(3)	/* Serial Port CTS# Pin / Input Pin */
-#define SCPCR_SCKC	BIT(2)	/* Serial Port SCK Pin / Output Pin */
-#define SCPCR_RXDC	BIT(1)	/* Serial Port RXD Pin / Input Pin */
-#define SCPCR_TXDC	BIT(0)	/* Serial Port TXD Pin / Output Pin */
-
-/* SCPDR (Serial Port Data Register), SCIFA/SCIFB only */
-#define SCPDR_RTSD	BIT(4)	/* Serial Port RTS# Output Pin Data */
-#define SCPDR_CTSD	BIT(3)	/* Serial Port CTS# Input Pin Data */
-#define SCPDR_SCKD	BIT(2)	/* Serial Port SCK Output Pin Data */
-#define SCPDR_RXDD	BIT(1)	/* Serial Port RXD Input Pin Data */
-#define SCPDR_TXDD	BIT(0)	/* Serial Port TXD Output Pin Data */
-
-/*
- * BRG Clock Select Register (Some SCIF and HSCIF)
- * The Baud Rate Generator for external clock can provide a clock source for
- * the sampling clock. It outputs either its frequency divided clock, or the
- * (undivided) (H)SCK external clock.
- */
-#define SCCKS_CKS	BIT(15)	/* Select (H)SCK (1) or divided SC_CLK (0) */
-#define SCCKS_XIN	BIT(14)	/* SC_CLK uses bus clock (1) or SCIF_CLK (0) */
-
-#define SCxSR_TEND(port)	(((port)->type == PORT_SCI) ? SCI_TEND   : SCIF_TEND)
-#define SCxSR_RDxF(port)	(((port)->type == PORT_SCI) ? SCI_RDRF   : SCIF_DR | SCIF_RDF)
-#define SCxSR_TDxE(port)	(((port)->type == PORT_SCI) ? SCI_TDRE   : SCIF_TDFE)
-#define SCxSR_FER(port)		(((port)->type == PORT_SCI) ? SCI_FER    : SCIF_FER)
-#define SCxSR_PER(port)		(((port)->type == PORT_SCI) ? SCI_PER    : SCIF_PER)
-#define SCxSR_BRK(port)		(((port)->type == PORT_SCI) ? 0x00       : SCIF_BRK)
-
-#define SCxSR_ERRORS(port)	(to_sci_port(port)->params->error_mask)
-
-#define SCxSR_RDxF_CLEAR(port) \
-	(((port)->type == PORT_SCI) ? SCI_RDxF_CLEAR : SCIF_RDxF_CLEAR)
-#define SCxSR_ERROR_CLEAR(port) \
-	(to_sci_port(port)->params->error_clear)
-#define SCxSR_TDxE_CLEAR(port) \
-	(((port)->type == PORT_SCI) ? SCI_TDxE_CLEAR : SCIF_TDxE_CLEAR)
-#define SCxSR_BREAK_CLEAR(port) \
-	(((port)->type == PORT_SCI) ? SCI_BREAK_CLEAR : SCIF_BREAK_CLEAR)
-- 
2.43.0


