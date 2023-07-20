Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FC5C0015E
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 10:04:15 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.9353.1689847435190774745
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jul 2023 03:04:09 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,218,1684767600"; 
   d="scan'208";a="173888319"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 Jul 2023 19:04:09 +0900
Received: from localhost.localdomain (unknown [10.226.92.157])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 84DFD401227C;
	Thu, 20 Jul 2023 19:04:07 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip v2 07/13] pwm: Add a device-managed function to add PWM chips
Date: Thu, 20 Jul 2023 11:03:44 +0100
Message-Id: <20230720100350.247386-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720100350.247386-1-biju.das.jz@bp.renesas.com>
References: <20230720100350.247386-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 10:04:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12452

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

commit bcda91bf86c1ff7647df85029d69f2aed80f210e upstream.

This potentially simplifies low-level PWM drivers.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pwm/core.c  | 19 +++++++++++++++++++
 include/linux/pwm.h |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1f16f5365d3c..4817df38086b 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -383,6 +383,25 @@ int pwmchip_remove(struct pwm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
+static void devm_pwmchip_remove(void *data)
+{
+	struct pwm_chip *chip = data;
+
+	pwmchip_remove(chip);
+}
+
+int devm_pwmchip_add(struct device *dev, struct pwm_chip *chip)
+{
+	int ret;
+
+	ret = pwmchip_add(chip);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, devm_pwmchip_remove, chip);
+}
+EXPORT_SYMBOL_GPL(devm_pwmchip_add);
+
 /**
  * pwm_request() - request a PWM device
  * @pwm: global PWM device index
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index a13ff383fa1d..a28b3e1e50b9 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -396,6 +396,9 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 			      enum pwm_polarity polarity);
 int pwmchip_add(struct pwm_chip *chip);
 int pwmchip_remove(struct pwm_chip *chip);
+
+int devm_pwmchip_add(struct device *dev, struct pwm_chip *chip);
+
 struct pwm_device *pwm_request_from_chip(struct pwm_chip *chip,
 					 unsigned int index,
 					 const char *label);
-- 
2.25.1


