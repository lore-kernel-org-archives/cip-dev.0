Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F03C7EE29
	for <webhook@archiver.kernel.org>; Tue, 13 Jun 2023 13:26:36 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.13085.1686662784973652723
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Jun 2023 06:26:34 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,239,1681138800"; 
   d="scan'208";a="166947246"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 13 Jun 2023 22:26:34 +0900
Received: from localhost.localdomain (unknown [10.226.92.247])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6995642701B6;
	Tue, 13 Jun 2023 22:26:32 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 4/7] serial: 8250_em: Use devm_clk_get_enabled()
Date: Tue, 13 Jun 2023 14:26:17 +0100
Message-Id: <20230613132620.150832-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613132620.150832-1-biju.das.jz@bp.renesas.com>
References: <20230613132620.150832-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Jun 2023 13:26:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11992

commit 7eada8a122a2683ec63ad43982a4552b054d59ca upstream.

Simplify clk handling in probe() by replacing devm_clk_get()->devm_
clk_get_enabled(). This replaces the usage of clk_prepare_enable/clk_
disable_unprepare() in probe()/remove(). After that sclk is no
longer required in struct serial8250_em_priv and is replaced by a
local variable sclk in probe().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230227114152.22265-6-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/8250/8250_em.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_em.c b/drivers/tty/serial/8250/8250_em.c
index 621abca93694..dcf1761e8ef5 100644
--- a/drivers/tty/serial/8250/8250_em.c
+++ b/drivers/tty/serial/8250/8250_em.c
@@ -20,7 +20,6 @@
 #define UART_DLM_EM 10
 
 struct serial8250_em_priv {
-	struct clk *sclk;
 	int line;
 };
 
@@ -82,6 +81,7 @@ static int serial8250_em_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct uart_8250_port up;
 	struct resource *regs;
+	struct clk *sclk;
 	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
@@ -96,9 +96,9 @@ static int serial8250_em_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->sclk = devm_clk_get(dev, "sclk");
-	if (IS_ERR(priv->sclk))
-		return dev_err_probe(dev, PTR_ERR(priv->sclk), "unable to get clock\n");
+	sclk = devm_clk_get_enabled(dev, "sclk");
+	if (IS_ERR(sclk))
+		return dev_err_probe(dev, PTR_ERR(sclk), "unable to get clock\n");
 
 	memset(&up, 0, sizeof(up));
 	up.port.mapbase = regs->start;
@@ -108,8 +108,7 @@ static int serial8250_em_probe(struct platform_device *pdev)
 	up.port.dev = dev;
 	up.port.private_data = priv;
 
-	clk_prepare_enable(priv->sclk);
-	up.port.uartclk = clk_get_rate(priv->sclk);
+	up.port.uartclk = clk_get_rate(sclk);
 
 	up.port.iotype = UPIO_MEM32;
 	up.port.serial_in = serial8250_em_serial_in;
@@ -118,10 +117,8 @@ static int serial8250_em_probe(struct platform_device *pdev)
 	up.dl_write = serial8250_em_serial_dl_write;
 
 	ret = serial8250_register_8250_port(&up);
-	if (ret < 0) {
-		clk_disable_unprepare(priv->sclk);
+	if (ret < 0)
 		return dev_err_probe(dev, ret, "unable to register 8250 port\n");
-	}
 
 	priv->line = ret;
 	platform_set_drvdata(pdev, priv);
@@ -133,7 +130,6 @@ static int serial8250_em_remove(struct platform_device *pdev)
 	struct serial8250_em_priv *priv = platform_get_drvdata(pdev);
 
 	serial8250_unregister_port(priv->line);
-	clk_disable_unprepare(priv->sclk);
 	return 0;
 }
 
-- 
2.25.1


