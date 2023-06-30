Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C317BEB64D7
	for <webhook@archiver.kernel.org>; Fri, 30 Jun 2023 15:54:08 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.16142.1688140438681775430
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Jun 2023 08:54:02 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,171,1684767600"; 
   d="scan'208";a="169866055"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Jul 2023 00:54:02 +0900
Received: from localhost.localdomain (unknown [10.226.93.15])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D0495400D4BA;
	Sat,  1 Jul 2023 00:54:00 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 3/3] i2c: rzv2m: Disable the operation of unit in case of error
Date: Fri, 30 Jun 2023 16:53:52 +0100
Message-Id: <20230630155352.584589-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630155352.584589-1-biju.das.jz@bp.renesas.com>
References: <20230630155352.584589-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Jun 2023 15:54:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12170

commit c3cc5c59cb16dbf14d8c52ac4df6650438613b5b upstream.

The remove and suspend callbacks disable the operation of the unit.
Do the same in probe() in case of error.

While at it, introduce a helper function rzv2m_i2c_disable() for
disabling the operation of the unit and this function is shared
between probe error path, remove and suspend callbacks.

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/i2c/busses/i2c-rzv2m.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rzv2m.c b/drivers/i2c/busses/i2c-rzv2m.c
index b97e29871558..7acde5133e51 100644
--- a/drivers/i2c/busses/i2c-rzv2m.c
+++ b/drivers/i2c/busses/i2c-rzv2m.c
@@ -389,6 +389,20 @@ static u32 rzv2m_i2c_func(struct i2c_adapter *adap)
 	       I2C_FUNC_10BIT_ADDR;
 }
 
+static int rzv2m_i2c_disable(struct device *dev, struct rzv2m_i2c_priv *priv)
+{
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	bit_clrl(priv->base + IICB0CTL0, IICB0IICE);
+	pm_runtime_put(dev);
+
+	return 0;
+}
+
 static const struct i2c_adapter_quirks rzv2m_i2c_quirks = {
 	.flags = I2C_AQ_NO_ZERO_LEN,
 };
@@ -461,8 +475,10 @@ static int rzv2m_i2c_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 
 	ret = i2c_add_numbered_adapter(adap);
-	if (ret < 0)
+	if (ret < 0) {
+		rzv2m_i2c_disable(dev, priv);
 		pm_runtime_disable(dev);
+	}
 
 	return ret;
 }
@@ -473,7 +489,7 @@ static int rzv2m_i2c_remove(struct platform_device *pdev)
 	struct device *dev = priv->adap.dev.parent;
 
 	i2c_del_adapter(&priv->adap);
-	bit_clrl(priv->base + IICB0CTL0, IICB0IICE);
+	rzv2m_i2c_disable(dev, priv);
 	pm_runtime_disable(dev);
 
 	return 0;
@@ -482,16 +498,8 @@ static int rzv2m_i2c_remove(struct platform_device *pdev)
 static int rzv2m_i2c_suspend(struct device *dev)
 {
 	struct rzv2m_i2c_priv *priv = dev_get_drvdata(dev);
-	int ret;
-
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0)
-		return ret;
-
-	bit_clrl(priv->base + IICB0CTL0, IICB0IICE);
-	pm_runtime_put(dev);
 
-	return 0;
+	return rzv2m_i2c_disable(dev, priv);
 }
 
 static int rzv2m_i2c_resume(struct device *dev)
-- 
2.25.1


