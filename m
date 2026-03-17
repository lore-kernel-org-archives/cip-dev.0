Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218A1FD708D
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:34 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.73433.1773746247919799968
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=G8UCGPQK;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so49678025e9.0
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746246; x=1774351046; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRRle2QWt3I0wmeR2TNFZliSmD9rboFromn6Nxg5/X8=;
        b=G8UCGPQKV9SnRPd1wlSDaJMl7o8yoha2HHsib8ySyI72Kps6ZDfRRJeTm1r5bWUafa
         sFM7wut7XGDdBb8BQZ9PjDEyDmy1sw+AjkV2Y8rJp0UijU298iaUnZrllmr1WfF1JcH/
         YCSU3sqoVuwfItCA5lMDduuAImZwot9MpROVgKM82EwzRT3QiIVVoh0Pg1E/lD6IKZDk
         kQShpojZnjqqy4rzKORar8II/M+Xa/8RIwMriaaZuCqSyQZGXwTeOVqn4llSLOgUuQ1o
         PQF01QFyTypXgY2KTapJugVIyxEtlbNeTgG/pAM19obg9X9wLF+s5CCfS1ZV3/ZyhWbg
         Cm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746246; x=1774351046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PRRle2QWt3I0wmeR2TNFZliSmD9rboFromn6Nxg5/X8=;
        b=eGfy1BuVMg38vE4zVI1NOkXRs2YlweI1JiKNeFxydtbbKCbB5SEaSEw6KsD8bE6Q16
         m4lBtHSRbeGOQ/6diySXKllj+8ZttZlp0kU6n6pI2Pr/ccKv26hfsmGT4Hp19+Vylwqs
         o3GsJFph9sWI2FRYbK5EZE9vniZa03YjJmvElOZjWIVupFIRK///EyF4nwmU8gGYOJwQ
         Uy8YNouiYec6Ea9+Z1DACdl0eDjPdlSHXtiRL4RyKDyTtHm3HYkaxFjjXhFMO0f6ipYW
         hSIi7AbbltDsQ4wcbPdFDUvca249xofbqXoQHSglTSOH2m+y2M6Ameraat0gUaQa+sI9
         mtTw==
X-Gm-Message-State: AOJu0YwL1jSNnU4lshpMcnQUOQksnurpI8bk8m8WgxlAPnFD+2ZM/Pz5
	/mXVPNKeDS5oXdOs9aybiA7ZdqbEE+s8ddXSj6I5BZjsyi8Ln4HR2lGqgeKNIg==
X-Gm-Gg: ATEYQzxZa4NmfzvrDOtY0XZEK3Nb+YpdujaDK/mERL6H9hOoBNM7gB5gAgOtrZhyFgJ
	S/Ca6WDUFimwtRuYeaqFct0JHnzlCYzs+emETiurw2OK1h9E4dpeyPrAxbZHsjTZMIUE/LfNZg5
	oi/G/FTyhSnOT6tPpsifAZ+PFoYgRmWx7UzmkP2jTlWJKK6PXFdHKZC/v9r/6cW3nYFly864OCy
	7isfZLVEp9fpCxa6gg4j252vFcxgq0S/WsfVnrI+Bx3vDJjxqZQjDelBv7SmU1NmFSh0l21zmhz
	u2byRM7PZcwQCkxSEIf8vLM5k23z7SqfPlb0Tbpzb83pjaYdsbkC6Hyg17wIAu5UMy514/CdiK1
	Eet+1tu3EIn5Op2MVRZEreAmwKDvq5Viza4GEOhvnO4xKFVBd8LyP7Q5qz9X6Se3ocBZVM8Lk6U
	ZFwUfWkWcW5Aei2WluZomTWfrRRaZs8hmIwghHswipny1tSHYd
X-Received: by 2002:a05:600c:8b6a:b0:485:40c6:f528 with SMTP id 5b1f17b1804b1-48556711e74mr289104315e9.30.1773746245794;
        Tue, 17 Mar 2026 04:17:25 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:25 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 08/39] serial: sh-sci: Introduced function pointers
Date: Tue, 17 Mar 2026 11:16:33 +0000
Message-ID: <20260317111718.281633-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22441

From: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>

[ Upstream commit 21fc3d6b45ba42c471fb718ce922d1f9abe26238 ]

The aim here is to prepare support for new sci controllers like
the T2H/RSCI whose registers are too much different for being
handled in common code.

This named serial controller also has 32 bits register,
so some return types had to be changed.

The needed generic functions are no longer static, with prototypes
defined in sh-sci-common.h so that they can be used from specific
implementation in a separate file, to keep this driver as little
changed as possible.

For doing so, a set of 'ops' is added to struct sci_port.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
Link: https://lore.kernel.org/r/20250403212919.1137670-9-thierry.bultel.yh@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Biju: Retained spin_lock_irq{save,restore} and uart_circ_* ]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci-common.h | 159 ++++++++++
 drivers/tty/serial/sh-sci.c        | 484 +++++++++++++++--------------
 drivers/tty/serial/sh-sci.h        |   2 -
 3 files changed, 407 insertions(+), 238 deletions(-)
 create mode 100644 drivers/tty/serial/sh-sci-common.h

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
new file mode 100644
index 000000000000..2ed742bca83f
--- /dev/null
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __SH_SCI_COMMON_H__
+#define __SH_SCI_COMMON_H__
+
+#include <linux/serial_core.h>
+
+enum SCI_CLKS {
+	SCI_FCK,		/* Functional Clock */
+	SCI_SCK,		/* Optional External Clock */
+	SCI_BRG_INT,		/* Optional BRG Internal Clock Source */
+	SCI_SCIF_CLK,		/* Optional BRG External Clock Source */
+	SCI_NUM_CLKS
+};
+
+/* Offsets into the sci_port->irqs array */
+enum {
+	SCIx_ERI_IRQ,
+	SCIx_RXI_IRQ,
+	SCIx_TXI_IRQ,
+	SCIx_BRI_IRQ,
+	SCIx_DRI_IRQ,
+	SCIx_TEI_IRQ,
+	SCIx_NR_IRQS,
+
+	SCIx_MUX_IRQ = SCIx_NR_IRQS,	/* special case */
+};
+
+/* Bit x set means sampling rate x + 1 is supported */
+#define SCI_SR(x)		BIT((x) - 1)
+#define SCI_SR_RANGE(x, y)	GENMASK((y) - 1, (x) - 1)
+
+void sci_release_port(struct uart_port *port);
+int sci_request_port(struct uart_port *port);
+void sci_config_port(struct uart_port *port, int flags);
+int sci_verify_port(struct uart_port *port, struct serial_struct *ser);
+void sci_pm(struct uart_port *port, unsigned int state,
+		   unsigned int oldstate);
+
+struct plat_sci_reg {
+	u8 offset;
+	u8 size;
+};
+
+struct sci_port_params_bits {
+	unsigned int rxtx_enable;
+	unsigned int te_clear;
+	unsigned int poll_sent_bits;
+};
+
+struct sci_common_regs {
+	unsigned int status;
+	unsigned int control;
+};
+
+/* The actual number of needed registers. This is used by sci only */
+#define SCI_NR_REGS 20
+
+struct sci_port_params {
+	const struct plat_sci_reg regs[SCI_NR_REGS];
+	const struct sci_common_regs *common_regs;
+	const struct sci_port_params_bits *param_bits;
+	unsigned int fifosize;
+	unsigned int overrun_reg;
+	unsigned int overrun_mask;
+	unsigned int sampling_rate_mask;
+	unsigned int error_mask;
+	unsigned int error_clear;
+};
+
+struct sci_port_ops {
+	u32 (*read_reg)(struct uart_port *port, int reg);
+	void (*write_reg)(struct uart_port *port, int reg, int value);
+	void (*clear_SCxSR)(struct uart_port *port, unsigned int mask);
+
+	void (*transmit_chars)(struct uart_port *port);
+	void (*receive_chars)(struct uart_port *port);
+
+	void (*poll_put_char)(struct uart_port *port, unsigned char c);
+
+	int (*set_rtrg)(struct uart_port *port, int rx_trig);
+	int (*rtrg_enabled)(struct uart_port *port);
+
+	void (*shutdown_complete)(struct uart_port *port);
+
+	void (*prepare_console_write)(struct uart_port *port, u32 ctrl);
+	void (*console_save)(struct uart_port *port);
+	void (*console_restore)(struct uart_port *port);
+	size_t (*suspend_regs_size)(void);
+};
+
+struct sci_port {
+	struct uart_port	port;
+
+	/* Platform configuration */
+	const struct sci_port_params *params;
+	const struct plat_sci_port *cfg;
+
+	unsigned int		sampling_rate_mask;
+	resource_size_t		reg_size;
+	struct mctrl_gpios	*gpios;
+
+	/* Clocks */
+	struct clk		*clks[SCI_NUM_CLKS];
+	unsigned long		clk_rates[SCI_NUM_CLKS];
+
+	int			irqs[SCIx_NR_IRQS];
+	char			*irqstr[SCIx_NR_IRQS];
+
+	struct dma_chan			*chan_tx;
+	struct dma_chan			*chan_rx;
+
+	struct reset_control		*rstc;
+	struct sci_suspend_regs		*suspend_regs;
+
+#ifdef CONFIG_SERIAL_SH_SCI_DMA
+	struct dma_chan			*chan_tx_saved;
+	struct dma_chan			*chan_rx_saved;
+	dma_cookie_t			cookie_tx;
+	dma_cookie_t			cookie_rx[2];
+	dma_cookie_t			active_rx;
+	dma_addr_t			tx_dma_addr;
+	unsigned int			tx_dma_len;
+	struct scatterlist		sg_rx[2];
+	void				*rx_buf[2];
+	size_t				buf_len_rx;
+	struct work_struct		work_tx;
+	struct hrtimer			rx_timer;
+	unsigned int			rx_timeout;	/* microseconds */
+#endif
+	unsigned int			rx_frame;
+	int				rx_trigger;
+	struct timer_list		rx_fifo_timer;
+	int				rx_fifo_timeout;
+	u16				hscif_tot;
+
+	const struct sci_port_ops *ops;
+
+	bool has_rtscts;
+	bool autorts;
+	bool tx_occurred;
+};
+
+#define to_sci_port(uart) container_of((uart), struct sci_port, port)
+
+void sci_port_disable(struct sci_port *sci_port);
+void sci_port_enable(struct sci_port *sci_port);
+
+int sci_startup(struct uart_port *port);
+void sci_shutdown(struct uart_port *port);
+
+#define min_sr(_port)		ffs((_port)->sampling_rate_mask)
+#define max_sr(_port)		fls((_port)->sampling_rate_mask)
+
+#ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
+int __init scix_early_console_setup(struct earlycon_device *device, int);
+#endif
+
+#endif /* __SH_SCI_COMMON_H__ */
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 61d7081043e8..4dc1df9cc8d1 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -57,19 +57,7 @@
 
 #include "serial_mctrl_gpio.h"
 #include "sh-sci.h"
-
-/* Offsets into the sci_port->irqs array */
-enum {
-	SCIx_ERI_IRQ,
-	SCIx_RXI_IRQ,
-	SCIx_TXI_IRQ,
-	SCIx_BRI_IRQ,
-	SCIx_DRI_IRQ,
-	SCIx_TEI_IRQ,
-	SCIx_NR_IRQS,
-
-	SCIx_MUX_IRQ = SCIx_NR_IRQS,	/* special case */
-};
+#include "sh-sci-common.h"
 
 #define SCIx_IRQ_IS_MUXED(port)			\
 	((port)->irqs[SCIx_ERI_IRQ] ==	\
@@ -77,32 +65,38 @@ enum {
 	((port)->irqs[SCIx_ERI_IRQ] &&	\
 	 ((port)->irqs[SCIx_RXI_IRQ] < 0))
 
-enum SCI_CLKS {
-	SCI_FCK,		/* Functional Clock */
-	SCI_SCK,		/* Optional External Clock */
-	SCI_BRG_INT,		/* Optional BRG Internal Clock Source */
-	SCI_SCIF_CLK,		/* Optional BRG External Clock Source */
-	SCI_NUM_CLKS
-};
-
-/* Bit x set means sampling rate x + 1 is supported */
-#define SCI_SR(x)		BIT((x) - 1)
-#define SCI_SR_RANGE(x, y)	GENMASK((y) - 1, (x) - 1)
-
 #define SCI_SR_SCIFAB		SCI_SR(5) | SCI_SR(7) | SCI_SR(11) | \
 				SCI_SR(13) | SCI_SR(16) | SCI_SR(17) | \
 				SCI_SR(19) | SCI_SR(27)
 
-#define min_sr(_port)		ffs((_port)->sampling_rate_mask)
-#define max_sr(_port)		fls((_port)->sampling_rate_mask)
-
 /* Iterate over all supported sampling rates, from high to low */
 #define for_each_sr(_sr, _port)						\
 	for ((_sr) = max_sr(_port); (_sr) >= min_sr(_port); (_sr)--)	\
 		if ((_port)->sampling_rate_mask & SCI_SR((_sr)))
 
-struct plat_sci_reg {
-	u8 offset, size;
+#define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
+
+static struct sci_port sci_ports[SCI_NPORTS];
+static unsigned long sci_ports_in_use;
+static struct uart_driver sci_uart_driver;
+static bool sci_uart_earlycon;
+static bool sci_uart_earlycon_dev_probing;
+
+static const struct sci_port_params_bits sci_sci_port_params_bits = {
+	.rxtx_enable = SCSCR_RE | SCSCR_TE,
+	.te_clear = SCSCR_TE | SCSCR_TEIE,
+	.poll_sent_bits = SCI_TDRE | SCI_TEND
+};
+
+static const struct sci_port_params_bits sci_scif_port_params_bits = {
+	.rxtx_enable = SCSCR_RE | SCSCR_TE,
+	.te_clear = SCSCR_TE | SCSCR_TEIE,
+	.poll_sent_bits = SCIF_TDFE | SCIF_TEND
+};
+
+static const struct sci_common_regs sci_common_regs = {
+	.status = SCxSR,
+	.control = SCSCR,
 };
 
 struct sci_suspend_regs {
@@ -119,77 +113,9 @@ struct sci_suspend_regs {
 	u8 semr;
 };
 
-struct sci_port_params {
-	const struct plat_sci_reg regs[SCIx_NR_REGS];
-	unsigned int fifosize;
-	unsigned int overrun_reg;
-	unsigned int overrun_mask;
-	unsigned int sampling_rate_mask;
-	unsigned int error_mask;
-	unsigned int error_clear;
-};
-
-struct sci_port {
-	struct uart_port	port;
-
-	/* Platform configuration */
-	const struct sci_port_params *params;
-	const struct plat_sci_port *cfg;
-	unsigned int		sampling_rate_mask;
-	resource_size_t		reg_size;
-	struct mctrl_gpios	*gpios;
-
-	/* Clocks */
-	struct clk		*clks[SCI_NUM_CLKS];
-	unsigned long		clk_rates[SCI_NUM_CLKS];
-
-	int			irqs[SCIx_NR_IRQS];
-	char			*irqstr[SCIx_NR_IRQS];
-
-	struct dma_chan			*chan_tx;
-	struct dma_chan			*chan_rx;
-
-	struct reset_control		*rstc;
-
-#ifdef CONFIG_SERIAL_SH_SCI_DMA
-	struct dma_chan			*chan_tx_saved;
-	struct dma_chan			*chan_rx_saved;
-	dma_cookie_t			cookie_tx;
-	dma_cookie_t			cookie_rx[2];
-	dma_cookie_t			active_rx;
-	dma_addr_t			tx_dma_addr;
-	unsigned int			tx_dma_len;
-	struct scatterlist		sg_rx[2];
-	void				*rx_buf[2];
-	size_t				buf_len_rx;
-	struct work_struct		work_tx;
-	struct hrtimer			rx_timer;
-	unsigned int			rx_timeout;	/* microseconds */
-#endif
-	unsigned int			rx_frame;
-	int				rx_trigger;
-	struct timer_list		rx_fifo_timer;
-	int				rx_fifo_timeout;
-	struct sci_suspend_regs		suspend_regs;
-	u16				hscif_tot;
-
-	bool has_rtscts;
-	bool autorts;
-	bool tx_occurred;
-};
-
-#define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
-
-static struct sci_port sci_ports[SCI_NPORTS];
-static unsigned long sci_ports_in_use;
-static struct uart_driver sci_uart_driver;
-static bool sci_uart_earlycon;
-static bool sci_uart_earlycon_dev_probing;
-
-static inline struct sci_port *
-to_sci_port(struct uart_port *uart)
+static size_t sci_suspend_regs_size(void)
 {
-	return container_of(uart, struct sci_port, port);
+	return sizeof(struct sci_suspend_regs);
 }
 
 static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
@@ -212,6 +138,8 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 		.sampling_rate_mask = SCI_SR(32),
 		.error_mask = SCI_DEFAULT_ERROR_MASK | SCI_ORER,
 		.error_clear = SCI_ERROR_CLEAR & ~SCI_ORER,
+		.param_bits = &sci_sci_port_params_bits,
+		.common_regs = &sci_common_regs,
 	},
 
 	/*
@@ -234,6 +162,8 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 		.sampling_rate_mask = SCI_SR(32),
 		.error_mask = SCI_DEFAULT_ERROR_MASK | SCI_ORER,
 		.error_clear = SCI_ERROR_CLEAR & ~SCI_ORER,
+		.param_bits = &sci_scif_port_params_bits,
+		.common_regs = &sci_common_regs,
 	},
 
 	/*
@@ -258,6 +188,8 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 		.sampling_rate_mask = SCI_SR_SCIFAB,
 		.error_mask = SCIF_DEFAULT_ERROR_MASK | SCIFA_ORER,
 		.error_clear = SCIF_ERROR_CLEAR & ~SCIFA_ORER,
+		.param_bits = &sci_scif_port_params_bits,
+		.common_regs = &sci_common_regs,
 	},
 
 	/*
@@ -283,6 +215,8 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 		.sampling_rate_mask = SCI_SR_SCIFAB,
 		.error_mask = SCIF_DEFAULT_ERROR_MASK | SCIFA_ORER,
 		.error_clear = SCIF_ERROR_CLEAR & ~SCIFA_ORER,
+		.param_bits = &sci_scif_port_params_bits,
+		.common_regs = &sci_common_regs,
 	},
 
 	/*
@@ -308,6 +242,8 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 		.sampling_rate_mask = SCI_SR(32),
 		.error_mask = SCIF_DEFAULT_ERROR_MASK,
 		.error_clear = SCIF_ERROR_CLEAR,
+		.param_bits = &sci_scif_port_params_bits,
+		.common_regs = &sci_common_regs,
 	},
 
 	/*
@@ -336,6 +272,8 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 		.sampling_rate_mask = SCI_SR(32),
 		.error_mask = SCIF_DEFAULT_ERROR_MASK,
 		.error_clear = SCIF_ERROR_CLEAR,
+		.param_bits = &sci_scif_port_params_bits,
+		.common_regs = &sci_common_regs,
 	},
 
 	/*
@@ -367,6 +305,8 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 		.sampling_rate_mask = SCI_SR(32),
 		.error_mask = SCIF_DEFAULT_ERROR_MASK,
 		.error_clear = SCIF_ERROR_CLEAR,
+		.param_bits = &sci_scif_port_params_bits,
+		.common_regs = &sci_common_regs,
 	},
 
 	/*
@@ -389,6 +329,8 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 		.sampling_rate_mask = SCI_SR(32),
 		.error_mask = SCIF_DEFAULT_ERROR_MASK,
 		.error_clear = SCIF_ERROR_CLEAR,
+		.param_bits = &sci_scif_port_params_bits,
+		.common_regs = &sci_common_regs,
 	},
 
 	/*
@@ -413,6 +355,8 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 		.sampling_rate_mask = SCI_SR(32),
 		.error_mask = SCIF_DEFAULT_ERROR_MASK,
 		.error_clear = SCIF_ERROR_CLEAR,
+		.param_bits = &sci_scif_port_params_bits,
+		.common_regs = &sci_common_regs,
 	},
 
 	/*
@@ -440,6 +384,8 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 		.sampling_rate_mask = SCI_SR(32),
 		.error_mask = SCIF_DEFAULT_ERROR_MASK,
 		.error_clear = SCIF_ERROR_CLEAR,
+		.param_bits = &sci_scif_port_params_bits,
+		.common_regs = &sci_common_regs,
 	},
 
 	/*
@@ -469,6 +415,8 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 		.sampling_rate_mask = SCI_SR_RANGE(8, 32),
 		.error_mask = SCIF_DEFAULT_ERROR_MASK,
 		.error_clear = SCIF_ERROR_CLEAR,
+		.param_bits = &sci_scif_port_params_bits,
+		.common_regs = &sci_common_regs,
 	},
 
 	/*
@@ -493,6 +441,8 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 		.sampling_rate_mask = SCI_SR(32),
 		.error_mask = SCIF_DEFAULT_ERROR_MASK,
 		.error_clear = SCIF_ERROR_CLEAR,
+		.param_bits = &sci_scif_port_params_bits,
+		.common_regs = &sci_common_regs,
 	},
 
 	/*
@@ -520,6 +470,8 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 		.sampling_rate_mask = SCI_SR(32),
 		.error_mask = SCIF_DEFAULT_ERROR_MASK,
 		.error_clear = SCIF_ERROR_CLEAR,
+		.param_bits = &sci_scif_port_params_bits,
+		.common_regs = &sci_common_regs,
 	},
 
 	/*
@@ -543,6 +495,8 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 		.sampling_rate_mask = SCI_SR(16),
 		.error_mask = SCIF_DEFAULT_ERROR_MASK | SCIFA_ORER,
 		.error_clear = SCIF_ERROR_CLEAR & ~SCIFA_ORER,
+		.param_bits = &sci_scif_port_params_bits,
+		.common_regs = &sci_common_regs,
 	},
 };
 
@@ -580,7 +534,7 @@ static void sci_serial_out(struct uart_port *p, int offset, int value)
 		WARN(1, "Invalid register access\n");
 }
 
-static void sci_port_enable(struct sci_port *sci_port)
+void sci_port_enable(struct sci_port *sci_port)
 {
 	unsigned int i;
 
@@ -596,7 +550,7 @@ static void sci_port_enable(struct sci_port *sci_port)
 	sci_port->port.uartclk = sci_port->clk_rates[SCI_FCK];
 }
 
-static void sci_port_disable(struct sci_port *sci_port)
+void sci_port_disable(struct sci_port *sci_port)
 {
 	unsigned int i;
 
@@ -736,12 +690,13 @@ static void sci_clear_SCxSR(struct uart_port *port, unsigned int mask)
 static int sci_poll_get_char(struct uart_port *port)
 {
 	unsigned short status;
+	struct sci_port *s = to_sci_port(port);
 	int c;
 
 	do {
 		status = sci_serial_in(port, SCxSR);
 		if (status & SCxSR_ERRORS(port)) {
-			sci_clear_SCxSR(port, SCxSR_ERROR_CLEAR(port));
+			s->ops->clear_SCxSR(port, SCxSR_ERROR_CLEAR(port));
 			continue;
 		}
 		break;
@@ -754,7 +709,7 @@ static int sci_poll_get_char(struct uart_port *port)
 
 	/* Dummy read */
 	sci_serial_in(port, SCxSR);
-	sci_clear_SCxSR(port, SCxSR_RDxF_CLEAR(port));
+	s->ops->clear_SCxSR(port, SCxSR_RDxF_CLEAR(port));
 
 	return c;
 }
@@ -762,14 +717,16 @@ static int sci_poll_get_char(struct uart_port *port)
 
 static void sci_poll_put_char(struct uart_port *port, unsigned char c)
 {
-	unsigned short status;
+	struct sci_port *s = to_sci_port(port);
+	const struct sci_common_regs *regs = s->params->common_regs;
+	unsigned int status;
 
 	do {
-		status = sci_serial_in(port, SCxSR);
+		status = s->ops->read_reg(port, regs->status);
 	} while (!(status & SCxSR_TDxE(port)));
 
 	sci_serial_out(port, SCxTDR, c);
-	sci_clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
+	s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port) & ~SCxSR_TEND(port));
 }
 #endif /* CONFIG_CONSOLE_POLL || CONFIG_SERIAL_SH_SCI_CONSOLE ||
 	  CONFIG_SERIAL_SH_SCI_EARLYCON */
@@ -913,7 +870,7 @@ static void sci_transmit_chars(struct uart_port *port)
 		port->icount.tx++;
 	} while (--count > 0);
 
-	sci_clear_SCxSR(port, SCxSR_TDxE_CLEAR(port));
+	s->ops->clear_SCxSR(port, SCxSR_TDxE_CLEAR(port));
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
@@ -932,6 +889,7 @@ static void sci_transmit_chars(struct uart_port *port)
 static void sci_receive_chars(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
+	struct sci_port *s = to_sci_port(port);
 	int i, count, copied = 0;
 	unsigned short status;
 	unsigned char flag;
@@ -986,7 +944,7 @@ static void sci_receive_chars(struct uart_port *port)
 		}
 
 		sci_serial_in(port, SCxSR); /* dummy read */
-		sci_clear_SCxSR(port, SCxSR_RDxF_CLEAR(port));
+		s->ops->clear_SCxSR(port, SCxSR_RDxF_CLEAR(port));
 
 		copied += count;
 		port->icount.rx += count;
@@ -999,16 +957,17 @@ static void sci_receive_chars(struct uart_port *port)
 		/* TTY buffers full; read from RX reg to prevent lockup */
 		sci_serial_in(port, SCxRDR);
 		sci_serial_in(port, SCxSR); /* dummy read */
-		sci_clear_SCxSR(port, SCxSR_RDxF_CLEAR(port));
+		s->ops->clear_SCxSR(port, SCxSR_RDxF_CLEAR(port));
 	}
 }
 
 static int sci_handle_errors(struct uart_port *port)
 {
 	int copied = 0;
-	unsigned short status = sci_serial_in(port, SCxSR);
-	struct tty_port *tport = &port->state->port;
 	struct sci_port *s = to_sci_port(port);
+	const struct sci_common_regs *regs = s->params->common_regs;
+	unsigned int status = s->ops->read_reg(port, regs->status);
+	struct tty_port *tport = &port->state->port;
 
 	/* Handle overruns */
 	if (status & s->params->overrun_mask) {
@@ -1167,7 +1126,7 @@ static void rx_fifo_timer_fn(struct timer_list *t)
 	struct uart_port *port = &s->port;
 
 	dev_dbg(port->dev, "Rx timed out\n");
-	scif_set_rtrg(port, 1);
+	s->ops->set_rtrg(port, 1);
 }
 
 static ssize_t rx_fifo_trigger_show(struct device *dev,
@@ -1192,9 +1151,9 @@ static ssize_t rx_fifo_trigger_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	sci->rx_trigger = scif_set_rtrg(port, r);
+	sci->rx_trigger = sci->ops->set_rtrg(port, r);
 	if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
-		scif_set_rtrg(port, 1);
+		sci->ops->set_rtrg(port, 1);
 
 	return count;
 }
@@ -1237,7 +1196,7 @@ static ssize_t rx_fifo_timeout_store(struct device *dev,
 		sci->hscif_tot = r << HSSCR_TOT_SHIFT;
 	} else {
 		sci->rx_fifo_timeout = r;
-		scif_set_rtrg(port, 1);
+		sci->ops->set_rtrg(port, 1);
 		if (r > 0)
 			timer_setup(&sci->rx_fifo_timer, rx_fifo_timer_fn, 0);
 	}
@@ -1366,7 +1325,7 @@ static void sci_dma_rx_reenable_irq(struct sci_port *s)
 	    s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE) {
 		enable_irq(s->irqs[SCIx_RXI_IRQ]);
 		if (s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE)
-			scif_set_rtrg(port, s->rx_trigger);
+			s->ops->set_rtrg(port, s->rx_trigger);
 		else
 			scr &= ~SCSCR_RDRQE;
 	}
@@ -1806,7 +1765,7 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 		    s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE) {
 			disable_irq_nosync(s->irqs[SCIx_RXI_IRQ]);
 			if (s->cfg->regtype == SCIx_RZ_SCIFA_REGTYPE) {
-				scif_set_rtrg(port, 1);
+				s->ops->set_rtrg(port, 1);
 				scr |= SCSCR_RIE;
 			} else {
 				scr |= SCSCR_RDRQE;
@@ -1832,8 +1791,8 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 #endif
 
 	if (s->rx_trigger > 1 && s->rx_fifo_timeout > 0) {
-		if (!scif_rtrg_enabled(port))
-			scif_set_rtrg(port, s->rx_trigger);
+		if (!s->ops->rtrg_enabled(port))
+			s->ops->set_rtrg(port, s->rx_trigger);
 
 		mod_timer(&s->rx_fifo_timer, jiffies + DIV_ROUND_UP(
 			  s->rx_frame * HZ * s->rx_fifo_timeout, 1000000));
@@ -1843,7 +1802,7 @@ static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 	 * of whether the I_IXOFF is set, otherwise, how is the interrupt
 	 * to be disabled?
 	 */
-	sci_receive_chars(port);
+	s->ops->receive_chars(port);
 
 	return IRQ_HANDLED;
 }
@@ -1852,9 +1811,10 @@ static irqreturn_t sci_tx_interrupt(int irq, void *ptr)
 {
 	struct uart_port *port = ptr;
 	unsigned long flags;
+	struct sci_port *s = to_sci_port(port);
 
 	spin_lock_irqsave(&port->lock, flags);
-	sci_transmit_chars(port);
+	s->ops->transmit_chars(port);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	return IRQ_HANDLED;
@@ -1863,16 +1823,18 @@ static irqreturn_t sci_tx_interrupt(int irq, void *ptr)
 static irqreturn_t sci_tx_end_interrupt(int irq, void *ptr)
 {
 	struct uart_port *port = ptr;
+	struct sci_port *s = to_sci_port(port);
+	const struct sci_common_regs *regs = s->params->common_regs;
 	unsigned long flags;
-	unsigned short ctrl;
+	u32 ctrl;
 
 	if (port->type != PORT_SCI)
 		return sci_tx_interrupt(irq, ptr);
 
 	spin_lock_irqsave(&port->lock, flags);
-	ctrl = sci_serial_in(port, SCSCR);
-	ctrl &= ~(SCSCR_TE | SCSCR_TEIE);
-	sci_serial_out(port, SCSCR, ctrl);
+	ctrl = s->ops->read_reg(port, regs->control) &
+		~(s->params->param_bits->te_clear);
+	s->ops->write_reg(port, regs->control, ctrl);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	return IRQ_HANDLED;
@@ -1881,6 +1843,7 @@ static irqreturn_t sci_tx_end_interrupt(int irq, void *ptr)
 static irqreturn_t sci_br_interrupt(int irq, void *ptr)
 {
 	struct uart_port *port = ptr;
+	struct sci_port *s = to_sci_port(port);
 
 	/* Handle BREAKs */
 	sci_handle_breaks(port);
@@ -1888,7 +1851,7 @@ static irqreturn_t sci_br_interrupt(int irq, void *ptr)
 	/* drop invalid character received before break was detected */
 	sci_serial_in(port, SCxRDR);
 
-	sci_clear_SCxSR(port, SCxSR_BREAK_CLEAR(port));
+	s->ops->clear_SCxSR(port, SCxSR_BREAK_CLEAR(port));
 
 	return IRQ_HANDLED;
 }
@@ -1916,15 +1879,15 @@ static irqreturn_t sci_er_interrupt(int irq, void *ptr)
 		if (sci_handle_errors(port)) {
 			/* discard character in rx buffer */
 			sci_serial_in(port, SCxSR);
-			sci_clear_SCxSR(port, SCxSR_RDxF_CLEAR(port));
+			s->ops->clear_SCxSR(port, SCxSR_RDxF_CLEAR(port));
 		}
 	} else {
 		sci_handle_fifo_overrun(port);
 		if (!s->chan_rx)
-			sci_receive_chars(port);
+			s->ops->receive_chars(port);
 	}
 
-	sci_clear_SCxSR(port, SCxSR_ERROR_CLEAR(port));
+	s->ops->clear_SCxSR(port, SCxSR_ERROR_CLEAR(port));
 
 	/* Kick the transmission */
 	if (!s->chan_tx)
@@ -2294,7 +2257,17 @@ static void sci_break_ctl(struct uart_port *port, int break_state)
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-static int sci_startup(struct uart_port *port)
+static void sci_shutdown_complete(struct uart_port *port)
+{
+	struct sci_port *s = to_sci_port(port);
+	u16 scr;
+
+	scr = sci_serial_in(port, SCSCR);
+	sci_serial_out(port, SCSCR,
+		       scr & (SCSCR_CKE1 | SCSCR_CKE0 | s->hscif_tot));
+}
+
+int sci_startup(struct uart_port *port)
 {
 	struct sci_port *s = to_sci_port(port);
 	int ret;
@@ -2313,11 +2286,10 @@ static int sci_startup(struct uart_port *port)
 	return 0;
 }
 
-static void sci_shutdown(struct uart_port *port)
+void sci_shutdown(struct uart_port *port)
 {
 	struct sci_port *s = to_sci_port(port);
 	unsigned long flags;
-	u16 scr;
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
@@ -2327,13 +2299,7 @@ static void sci_shutdown(struct uart_port *port)
 	spin_lock_irqsave(&port->lock, flags);
 	sci_stop_rx(port);
 	sci_stop_tx(port);
-	/*
-	 * Stop RX and TX, disable related interrupts, keep clock source
-	 * and HSCIF TOT bits
-	 */
-	scr = sci_serial_in(port, SCSCR);
-	sci_serial_out(port, SCSCR,
-		       scr & (SCSCR_CKE1 | SCSCR_CKE0 | s->hscif_tot));
+	s->ops->shutdown_complete(port);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
@@ -2410,8 +2376,8 @@ static int sci_brg_calc(struct sci_port *s, unsigned int bps,
 
 /* calculate sample rate, BRR, and clock select */
 static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
-			  unsigned int *brr, unsigned int *srr,
-			  unsigned int *cks)
+		   unsigned int *brr, unsigned int *srr,
+		   unsigned int *cks)
 {
 	unsigned long freq = s->clk_rates[SCI_FCK];
 	unsigned int sr, br, prediv, scrate, c;
@@ -2488,9 +2454,9 @@ static void sci_reset(struct uart_port *port)
 	if (reg->size)
 		sci_serial_out(port, SCFCR, SCFCR_RFRST | SCFCR_TFRST);
 
-	sci_clear_SCxSR(port,
-			SCxSR_RDxF_CLEAR(port) & SCxSR_ERROR_CLEAR(port) &
-			SCxSR_BREAK_CLEAR(port));
+	s->ops->clear_SCxSR(port,
+			    SCxSR_RDxF_CLEAR(port) & SCxSR_ERROR_CLEAR(port) &
+			    SCxSR_BREAK_CLEAR(port));
 	if (sci_getreg(port, SCLSR)->size) {
 		status = sci_serial_in(port, SCLSR);
 		status &= ~(SCLSR_TO | SCLSR_ORER);
@@ -2499,14 +2465,14 @@ static void sci_reset(struct uart_port *port)
 
 	if (s->rx_trigger > 1) {
 		if (s->rx_fifo_timeout) {
-			scif_set_rtrg(port, 1);
+			s->ops->set_rtrg(port, 1);
 			timer_setup(&s->rx_fifo_timer, rx_fifo_timer_fn, 0);
 		} else {
 			if (port->type == PORT_SCIFA ||
 			    port->type == PORT_SCIFB)
-				scif_set_rtrg(port, 1);
+				s->ops->set_rtrg(port, 1);
 			else
-				scif_set_rtrg(port, s->rx_trigger);
+				s->ops->set_rtrg(port, s->rx_trigger);
 		}
 	}
 }
@@ -2766,7 +2732,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 		sci_enable_ms(port);
 }
 
-static void sci_pm(struct uart_port *port, unsigned int state,
+void sci_pm(struct uart_port *port, unsigned int state,
 		   unsigned int oldstate)
 {
 	struct sci_port *sci_port = to_sci_port(port);
@@ -2829,7 +2795,7 @@ static int sci_remap_port(struct uart_port *port)
 	return 0;
 }
 
-static void sci_release_port(struct uart_port *port)
+void sci_release_port(struct uart_port *port)
 {
 	struct sci_port *sport = to_sci_port(port);
 
@@ -2841,7 +2807,7 @@ static void sci_release_port(struct uart_port *port)
 	release_mem_region(port->mapbase, sport->reg_size);
 }
 
-static int sci_request_port(struct uart_port *port)
+int sci_request_port(struct uart_port *port)
 {
 	struct resource *res;
 	struct sci_port *sport = to_sci_port(port);
@@ -2863,7 +2829,7 @@ static int sci_request_port(struct uart_port *port)
 	return 0;
 }
 
-static void sci_config_port(struct uart_port *port, int flags)
+void sci_config_port(struct uart_port *port, int flags)
 {
 	if (flags & UART_CONFIG_TYPE) {
 		struct sci_port *sport = to_sci_port(port);
@@ -2873,7 +2839,7 @@ static void sci_config_port(struct uart_port *port, int flags)
 	}
 }
 
-static int sci_verify_port(struct uart_port *port, struct serial_struct *ser)
+int sci_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
 	if (ser->baud_base < 2400)
 		/* No paper tape reader for Mitch.. */
@@ -2882,6 +2848,75 @@ static int sci_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return 0;
 }
 
+static void sci_prepare_console_write(struct uart_port *port, u32 ctrl)
+{
+	struct sci_port *s = to_sci_port(port);
+	u32 ctrl_temp =
+		s->params->param_bits->rxtx_enable |
+		(s->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0)) |
+		(ctrl & (SCSCR_CKE1 | SCSCR_CKE0)) |
+		s->hscif_tot;
+	sci_serial_out(port, SCSCR, ctrl_temp);
+}
+
+static void sci_console_save(struct uart_port *port)
+{
+	struct sci_port *s = to_sci_port(port);
+	struct sci_suspend_regs *regs = s->suspend_regs;
+
+	if (sci_getreg(port, SCDL)->size)
+		regs->scdl = sci_serial_in(port, SCDL);
+	if (sci_getreg(port, SCCKS)->size)
+		regs->sccks = sci_serial_in(port, SCCKS);
+	if (sci_getreg(port, SCSMR)->size)
+		regs->scsmr = sci_serial_in(port, SCSMR);
+	if (sci_getreg(port, SCSCR)->size)
+		regs->scscr = sci_serial_in(port, SCSCR);
+	if (sci_getreg(port, SCFCR)->size)
+		regs->scfcr = sci_serial_in(port, SCFCR);
+	if (sci_getreg(port, SCSPTR)->size)
+		regs->scsptr = sci_serial_in(port, SCSPTR);
+	if (sci_getreg(port, SCBRR)->size)
+		regs->scbrr = sci_serial_in(port, SCBRR);
+	if (sci_getreg(port, HSSRR)->size)
+		regs->hssrr = sci_serial_in(port, HSSRR);
+	if (sci_getreg(port, SCPCR)->size)
+		regs->scpcr = sci_serial_in(port, SCPCR);
+	if (sci_getreg(port, SCPDR)->size)
+		regs->scpdr = sci_serial_in(port, SCPDR);
+	if (sci_getreg(port, SEMR)->size)
+		regs->semr = sci_serial_in(port, SEMR);
+}
+
+static void sci_console_restore(struct uart_port *port)
+{
+	struct sci_port *s = to_sci_port(port);
+	struct sci_suspend_regs *regs = s->suspend_regs;
+
+	if (sci_getreg(port, SCDL)->size)
+		sci_serial_out(port, SCDL, regs->scdl);
+	if (sci_getreg(port, SCCKS)->size)
+		sci_serial_out(port, SCCKS, regs->sccks);
+	if (sci_getreg(port, SCSMR)->size)
+		sci_serial_out(port, SCSMR, regs->scsmr);
+	if (sci_getreg(port, SCSCR)->size)
+		sci_serial_out(port, SCSCR, regs->scscr);
+	if (sci_getreg(port, SCFCR)->size)
+		sci_serial_out(port, SCFCR, regs->scfcr);
+	if (sci_getreg(port, SCSPTR)->size)
+		sci_serial_out(port, SCSPTR, regs->scsptr);
+	if (sci_getreg(port, SCBRR)->size)
+		sci_serial_out(port, SCBRR, regs->scbrr);
+	if (sci_getreg(port, HSSRR)->size)
+		sci_serial_out(port, HSSRR, regs->hssrr);
+	if (sci_getreg(port, SCPCR)->size)
+		sci_serial_out(port, SCPCR, regs->scpcr);
+	if (sci_getreg(port, SCPDR)->size)
+		sci_serial_out(port, SCPDR, regs->scpdr);
+	if (sci_getreg(port, SEMR)->size)
+		sci_serial_out(port, SEMR, regs->semr);
+}
+
 static const struct uart_ops sci_uart_ops = {
 	.tx_empty	= sci_tx_empty,
 	.set_mctrl	= sci_set_mctrl,
@@ -2907,6 +2942,25 @@ static const struct uart_ops sci_uart_ops = {
 #endif
 };
 
+static const struct sci_port_ops sci_port_ops = {
+	.read_reg		= sci_serial_in,
+	.write_reg		= sci_serial_out,
+	.clear_SCxSR		= sci_clear_SCxSR,
+	.transmit_chars		= sci_transmit_chars,
+	.receive_chars		= sci_receive_chars,
+#if defined(CONFIG_SERIAL_SH_SCI_CONSOLE) || \
+    defined(CONFIG_SERIAL_SH_SCI_EARLYCON)
+	.poll_put_char		= sci_poll_put_char,
+#endif
+	.set_rtrg		= scif_set_rtrg,
+	.rtrg_enabled		= scif_rtrg_enabled,
+	.shutdown_complete	= sci_shutdown_complete,
+	.prepare_console_write	= sci_prepare_console_write,
+	.console_save		= sci_console_save,
+	.console_restore	= sci_console_restore,
+	.suspend_regs_size	= sci_suspend_regs_size,
+};
+
 static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 {
 	const char *clk_names[] = {
@@ -3000,6 +3054,7 @@ static int sci_init_single(struct platform_device *dev,
 	int ret;
 
 	sci_port->cfg	= p;
+	sci_port->ops	= &sci_port_ops;
 
 	port->ops	= &sci_uart_ops;
 	port->iotype	= UPIO_MEM;
@@ -3112,7 +3167,7 @@ static int sci_init_single(struct platform_device *dev,
     defined(CONFIG_SERIAL_SH_SCI_EARLYCON)
 static void serial_console_putchar(struct uart_port *port, unsigned char ch)
 {
-	sci_poll_put_char(port, ch);
+	to_sci_port(port)->ops->poll_put_char(port, ch);
 }
 
 /*
@@ -3124,7 +3179,9 @@ static void serial_console_write(struct console *co, const char *s,
 {
 	struct sci_port *sci_port = &sci_ports[co->index];
 	struct uart_port *port = &sci_port->port;
-	unsigned short bits, ctrl, ctrl_temp;
+	const struct sci_common_regs *regs = sci_port->params->common_regs;
+	unsigned int bits;
+	u32 ctrl;
 	unsigned long flags;
 	int locked = 1;
 
@@ -3136,21 +3193,21 @@ static void serial_console_write(struct console *co, const char *s,
 		spin_lock_irqsave(&port->lock, flags);
 
 	/* first save SCSCR then disable interrupts, keep clock source */
-	ctrl = sci_serial_in(port, SCSCR);
-	ctrl_temp = SCSCR_RE | SCSCR_TE |
-		    (sci_port->cfg->scscr & ~(SCSCR_CKE1 | SCSCR_CKE0)) |
-		    (ctrl & (SCSCR_CKE1 | SCSCR_CKE0));
-	sci_serial_out(port, SCSCR, ctrl_temp | sci_port->hscif_tot);
+
+	ctrl = sci_port->ops->read_reg(port, regs->control);
+	sci_port->ops->prepare_console_write(port, ctrl);
 
 	uart_console_write(port, s, count, serial_console_putchar);
 
 	/* wait until fifo is empty and last bit has been transmitted */
-	bits = SCxSR_TDxE(port) | SCxSR_TEND(port);
-	while ((sci_serial_in(port, SCxSR) & bits) != bits)
+
+	bits = sci_port->params->param_bits->poll_sent_bits;
+
+	while ((sci_port->ops->read_reg(port, regs->status) & bits) != bits)
 		cpu_relax();
 
 	/* restore the SCSCR */
-	sci_serial_out(port, SCSCR, ctrl);
+	sci_port->ops->write_reg(port, regs->control, ctrl);
 
 	if (locked)
 		spin_unlock_irqrestore(&port->lock, flags);
@@ -3273,7 +3330,6 @@ static int sci_remove(struct platform_device *dev)
 	return 0;
 }
 
-
 #define SCI_OF_DATA(type, regtype)	(void *)((type) << 16 | (regtype))
 #define SCI_OF_TYPE(data)		((unsigned long)(data) >> 16)
 #define SCI_OF_REGTYPE(data)		((unsigned long)(data) & 0xffff)
@@ -3510,6 +3566,11 @@ static int sci_probe(struct platform_device *dev)
 	}
 
 	sp = &sci_ports[dev_id];
+	sp->suspend_regs = devm_kzalloc(&dev->dev,
+					sp->ops->suspend_regs_size(),
+					GFP_KERNEL);
+	if (!sp->suspend_regs)
+		return -ENOMEM;
 
 	/*
 	 * In case:
@@ -3561,64 +3622,6 @@ static int sci_probe(struct platform_device *dev)
 	return 0;
 }
 
-static void sci_console_save(struct sci_port *s)
-{
-	struct sci_suspend_regs *regs = &s->suspend_regs;
-	struct uart_port *port = &s->port;
-
-	if (sci_getreg(port, SCDL)->size)
-		regs->scdl = sci_serial_in(port, SCDL);
-	if (sci_getreg(port, SCCKS)->size)
-		regs->sccks = sci_serial_in(port, SCCKS);
-	if (sci_getreg(port, SCSMR)->size)
-		regs->scsmr = sci_serial_in(port, SCSMR);
-	if (sci_getreg(port, SCSCR)->size)
-		regs->scscr = sci_serial_in(port, SCSCR);
-	if (sci_getreg(port, SCFCR)->size)
-		regs->scfcr = sci_serial_in(port, SCFCR);
-	if (sci_getreg(port, SCSPTR)->size)
-		regs->scsptr = sci_serial_in(port, SCSPTR);
-	if (sci_getreg(port, SCBRR)->size)
-		regs->scbrr = sci_serial_in(port, SCBRR);
-	if (sci_getreg(port, HSSRR)->size)
-		regs->hssrr = sci_serial_in(port, HSSRR);
-	if (sci_getreg(port, SCPCR)->size)
-		regs->scpcr = sci_serial_in(port, SCPCR);
-	if (sci_getreg(port, SCPDR)->size)
-		regs->scpdr = sci_serial_in(port, SCPDR);
-	if (sci_getreg(port, SEMR)->size)
-		regs->semr = sci_serial_in(port, SEMR);
-}
-
-static void sci_console_restore(struct sci_port *s)
-{
-	struct sci_suspend_regs *regs = &s->suspend_regs;
-	struct uart_port *port = &s->port;
-
-	if (sci_getreg(port, SCDL)->size)
-		sci_serial_out(port, SCDL, regs->scdl);
-	if (sci_getreg(port, SCCKS)->size)
-		sci_serial_out(port, SCCKS, regs->sccks);
-	if (sci_getreg(port, SCSMR)->size)
-		sci_serial_out(port, SCSMR, regs->scsmr);
-	if (sci_getreg(port, SCSCR)->size)
-		sci_serial_out(port, SCSCR, regs->scscr);
-	if (sci_getreg(port, SCFCR)->size)
-		sci_serial_out(port, SCFCR, regs->scfcr);
-	if (sci_getreg(port, SCSPTR)->size)
-		sci_serial_out(port, SCSPTR, regs->scsptr);
-	if (sci_getreg(port, SCBRR)->size)
-		sci_serial_out(port, SCBRR, regs->scbrr);
-	if (sci_getreg(port, HSSRR)->size)
-		sci_serial_out(port, HSSRR, regs->hssrr);
-	if (sci_getreg(port, SCPCR)->size)
-		sci_serial_out(port, SCPCR, regs->scpcr);
-	if (sci_getreg(port, SCPDR)->size)
-		sci_serial_out(port, SCPDR, regs->scpdr);
-	if (sci_getreg(port, SEMR)->size)
-		sci_serial_out(port, SEMR, regs->semr);
-}
-
 static __maybe_unused int sci_suspend(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
@@ -3626,8 +3629,10 @@ static __maybe_unused int sci_suspend(struct device *dev)
 	if (sport) {
 		uart_suspend_port(&sci_uart_driver, &sport->port);
 
-		if (!console_suspend_enabled && uart_console(&sport->port))
-			sci_console_save(sport);
+		if (!console_suspend_enabled && uart_console(&sport->port)) {
+			if (sport->ops->console_save)
+				sport->ops->console_save(&sport->port);
+		}
 		else
 			return reset_control_assert(sport->rstc);
 	}
@@ -3641,7 +3646,8 @@ static __maybe_unused int sci_resume(struct device *dev)
 
 	if (sport) {
 		if (!console_suspend_enabled && uart_console(&sport->port)) {
-			sci_console_restore(sport);
+			if (sport->ops->console_restore)
+				sport->ops->console_restore(&sport->port);
 		} else {
 			int ret = reset_control_deassert(sport->rstc);
 
@@ -3705,9 +3711,11 @@ static int early_console_exit(struct console *co)
 	return 0;
 }
 
-static int __init early_console_setup(struct earlycon_device *device,
+int __init scix_early_console_setup(struct earlycon_device *device,
 				      int type)
 {
+	const struct sci_common_regs *regs;
+
 	if (!device->port.membase)
 		return -ENODEV;
 
@@ -3715,11 +3723,15 @@ static int __init early_console_setup(struct earlycon_device *device,
 	sci_ports[0].port = device->port;
 	port_cfg.type = type;
 	sci_ports[0].cfg = &port_cfg;
+	sci_ports[0].ops = &sci_port_ops;
 	sci_ports[0].params = sci_probe_regmap(&port_cfg);
 	sci_uart_earlycon = true;
-	port_cfg.scscr = sci_serial_in(&sci_ports[0].port, SCSCR);
-	sci_serial_out(&sci_ports[0].port, SCSCR,
-		       SCSCR_RE | SCSCR_TE | port_cfg.scscr);
+	regs = sci_ports[0].params->common_regs;
+
+	port_cfg.scscr = sci_ports[0].ops->read_reg(&sci_ports[0].port, regs->control);
+	sci_ports[0].ops->write_reg(&sci_ports[0].port,
+				    regs->control,
+				    sci_ports[0].params->param_bits->rxtx_enable | port_cfg.scscr);
 
 	device->con->write = serial_console_write;
 	device->con->exit = early_console_exit;
@@ -3729,41 +3741,41 @@ static int __init early_console_setup(struct earlycon_device *device,
 static int __init sci_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
-	return early_console_setup(device, PORT_SCI);
+	return scix_early_console_setup(device, PORT_SCI);
 }
 static int __init scif_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
-	return early_console_setup(device, PORT_SCIF);
+	return scix_early_console_setup(device, PORT_SCIF);
 }
 static int __init rzscifa_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
 	port_cfg.regtype = SCIx_RZ_SCIFA_REGTYPE;
-	return early_console_setup(device, PORT_SCIF);
+	return scix_early_console_setup(device, PORT_SCIF);
 }
 
 static int __init rzv2hscif_early_console_setup(struct earlycon_device *device,
 						const char *opt)
 {
 	port_cfg.regtype = SCIx_RZV2H_SCIF_REGTYPE;
-	return early_console_setup(device, PORT_SCIF);
+	return scix_early_console_setup(device, PORT_SCIF);
 }
 
 static int __init scifa_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
-	return early_console_setup(device, PORT_SCIFA);
+	return scix_early_console_setup(device, PORT_SCIFA);
 }
 static int __init scifb_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
-	return early_console_setup(device, PORT_SCIFB);
+	return scix_early_console_setup(device, PORT_SCIFB);
 }
 static int __init hscif_early_console_setup(struct earlycon_device *device,
 					  const char *opt)
 {
-	return early_console_setup(device, PORT_HSCIF);
+	return scix_early_console_setup(device, PORT_HSCIF);
 }
 
 OF_EARLYCON_DECLARE(sci, "renesas,sci", sci_early_console_setup);
diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index 0b65563c4e9e..951681aba586 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -32,8 +32,6 @@ enum {
 	HSRTRGR,			/* Rx FIFO Data Count Trigger Register */
 	HSTTRGR,			/* Tx FIFO Data Count Trigger Register */
 	SEMR,				/* Serial extended mode register */
-
-	SCIx_NR_REGS,
 };
 
 
-- 
2.43.0


