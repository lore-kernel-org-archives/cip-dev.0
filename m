Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78C7C88CB6
	for <webhook@archiver.kernel.org>; Tue, 13 Jun 2023 13:26:36 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.13086.1686662787431718548
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Jun 2023 06:26:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,239,1681138800"; 
   d="scan'208";a="163406168"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Jun 2023 22:26:26 +0900
Received: from localhost.localdomain (unknown [10.226.92.247])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id F010142701B6;
	Tue, 13 Jun 2023 22:26:24 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 1/7] serial: 8250_em: Simplify probe()
Date: Tue, 13 Jun 2023 14:26:14 +0100
Message-Id: <20230613132620.150832-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613132620.150832-1-biju.das.jz@bp.renesas.com>
References: <20230613132620.150832-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Jun 2023 13:26:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11989

commit 6b5f1e2e22ffd562075eaf6e018607e7dffe154d upstream.

Simplify probe() by using dev_err_probe() instead of dev_err() and
add a local variable 'dev' to replace '&pdev->dev'.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230227114152.22265-3-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/8250/8250_em.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_em.c b/drivers/tty/serial/8250/8250_em.c
index d94c3811a8f7..17c0aa424df8 100644
--- a/drivers/tty/serial/8250/8250_em.c
+++ b/drivers/tty/serial/8250/8250_em.c
@@ -79,6 +79,7 @@ static void serial8250_em_serial_dl_write(struct uart_8250_port *up, int value)
 static int serial8250_em_probe(struct platform_device *pdev)
 {
 	struct serial8250_em_priv *priv;
+	struct device *dev = &pdev->dev;
 	struct uart_8250_port up;
 	struct resource *regs;
 	int irq, ret;
@@ -88,27 +89,23 @@ static int serial8250_em_probe(struct platform_device *pdev)
 		return irq;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!regs) {
-		dev_err(&pdev->dev, "missing registers\n");
-		return -EINVAL;
-	}
+	if (!regs)
+		return dev_err_probe(dev, -EINVAL, "missing registers\n");
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	priv->sclk = devm_clk_get(&pdev->dev, "sclk");
-	if (IS_ERR(priv->sclk)) {
-		dev_err(&pdev->dev, "unable to get clock\n");
-		return PTR_ERR(priv->sclk);
-	}
+	priv->sclk = devm_clk_get(dev, "sclk");
+	if (IS_ERR(priv->sclk))
+		return dev_err_probe(dev, PTR_ERR(priv->sclk), "unable to get clock\n");
 
 	memset(&up, 0, sizeof(up));
 	up.port.mapbase = regs->start;
 	up.port.irq = irq;
 	up.port.type = PORT_16750;
 	up.port.flags = UPF_FIXED_PORT | UPF_IOREMAP | UPF_FIXED_TYPE;
-	up.port.dev = &pdev->dev;
+	up.port.dev = dev;
 	up.port.private_data = priv;
 
 	clk_prepare_enable(priv->sclk);
@@ -122,9 +119,8 @@ static int serial8250_em_probe(struct platform_device *pdev)
 
 	ret = serial8250_register_8250_port(&up);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "unable to register 8250 port\n");
 		clk_disable_unprepare(priv->sclk);
-		return ret;
+		return dev_err_probe(dev, ret, "unable to register 8250 port\n");
 	}
 
 	priv->line = ret;
-- 
2.25.1


