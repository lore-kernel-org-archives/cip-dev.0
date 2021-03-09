Return-Path: <SRS0=k9Yd=IH=lists.cip-project.org=bounce+64572+6216+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55C0C433E6
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:03 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00BB564FF3
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00BB564FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6216+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 0TpoYY4521723xQJuDfOGlXX; Tue, 09 Mar 2021 08:37:02 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.11724.1615307821262695682
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:01 -0800
X-IronPort-AV: E=Sophos;i="5.81,234,1610377200"; 
   d="scan'208";a="74342196"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:00 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A786240A2DBD;
	Wed, 10 Mar 2021 01:36:59 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 01/40] media: ov5645: Remove unneeded regulator_set_voltage()
Date: Tue,  9 Mar 2021 16:36:17 +0000
Message-Id: <20210309163656.20944-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: xuBZXdgQw9THsn2rfRJR2Qn6x4520388AA=
Content-Type: multipart/mixed; boundary="egrN0270jfPkX7UD9rA5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307822;
 bh=vTUKpmMBpctPUaQmXhgi6waDVNhEKUcP2ADdiZ8W8ZU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=fsswVpZKEwbK3tS/wJGS4ph3/y4q6GY741XaFVqclzGiBYZkJsmtZ3aAAKd7Ed2ygBx
 nYN/XOKjfPJrYN3MyRlVbWK2MiLNxE9ztFlhNAbW6otgJG3nJev2r5GGf1/ULpcrye895
 w4MlunPZINj2sY4xMhpJwlQQDmy/HIWw7Vc=

--egrN0270jfPkX7UD9rA5

From: Fabio Estevam <festevam@gmail.com>

commit 45ffbd15ede6add6e4fb150e4bab7a27cfe62552 upstream.

There is no need to call regulator_set_voltage() for each regulator
that powers the camera.

The voltage value for each regulator should be retrieved from the
device tree, so remove the unneeded regulator_set_voltage().

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/i2c/ov5645.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 34343bc10007..5f3229bc68a5 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -42,10 +42,6 @@
 #include <media/v4l2-fwnode.h>
 #include <media/v4l2-subdev.h>
 
-#define OV5645_VOLTAGE_ANALOG               2800000
-#define OV5645_VOLTAGE_DIGITAL_CORE         1500000
-#define OV5645_VOLTAGE_DIGITAL_IO           1800000
-
 #define OV5645_SYSTEM_CTRL0		0x3008
 #define		OV5645_SYSTEM_CTRL0_START	0x02
 #define		OV5645_SYSTEM_CTRL0_STOP	0x42
@@ -1174,42 +1170,18 @@ static int ov5645_probe(struct i2c_client *client,
 		return PTR_ERR(ov5645->io_regulator);
 	}
 
-	ret = regulator_set_voltage(ov5645->io_regulator,
-				    OV5645_VOLTAGE_DIGITAL_IO,
-				    OV5645_VOLTAGE_DIGITAL_IO);
-	if (ret < 0) {
-		dev_err(dev, "cannot set io voltage\n");
-		return ret;
-	}
-
 	ov5645->core_regulator = devm_regulator_get(dev, "vddd");
 	if (IS_ERR(ov5645->core_regulator)) {
 		dev_err(dev, "cannot get core regulator\n");
 		return PTR_ERR(ov5645->core_regulator);
 	}
 
-	ret = regulator_set_voltage(ov5645->core_regulator,
-				    OV5645_VOLTAGE_DIGITAL_CORE,
-				    OV5645_VOLTAGE_DIGITAL_CORE);
-	if (ret < 0) {
-		dev_err(dev, "cannot set core voltage\n");
-		return ret;
-	}
-
 	ov5645->analog_regulator = devm_regulator_get(dev, "vdda");
 	if (IS_ERR(ov5645->analog_regulator)) {
 		dev_err(dev, "cannot get analog regulator\n");
 		return PTR_ERR(ov5645->analog_regulator);
 	}
 
-	ret = regulator_set_voltage(ov5645->analog_regulator,
-				    OV5645_VOLTAGE_ANALOG,
-				    OV5645_VOLTAGE_ANALOG);
-	if (ret < 0) {
-		dev_err(dev, "cannot set analog voltage\n");
-		return ret;
-	}
-
 	ov5645->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
 	if (IS_ERR(ov5645->enable_gpio)) {
 		dev_err(dev, "cannot get enable gpio\n");
-- 
2.17.1


--egrN0270jfPkX7UD9rA5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6216): https://lists.cip-project.org/g/cip-dev/message=
/6216
Mute This Topic: https://lists.cip-project.org/mt/81205337/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--egrN0270jfPkX7UD9rA5--
