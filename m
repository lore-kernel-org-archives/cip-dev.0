Return-Path: <SRS0=BfvP=CD=lists.cip-project.org=bounce+64572+5243+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D60C433EB
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 13:42:00 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3FF2076C
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 13:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="JITkAZ7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3FF2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5243+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id l9GuYY4521723x5PoyMPW73J; Tue, 25 Aug 2020 06:42:00 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.13293.1598361720422412146
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2020 06:22:05 -0700
X-IronPort-AV: E=Sophos;i="5.76,352,1592838000"; 
   d="scan'208";a="55269194"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 25 Aug 2020 22:22:04 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.65])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4FA404004950;
	Tue, 25 Aug 2020 22:22:03 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 03/10] thermal: rcar_gen3_thermal: Generate interrupt when temperature changes
Date: Tue, 25 Aug 2020 14:21:49 +0100
Message-Id: <20200825132156.7839-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
References: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: EFN5sgkwEPmvzyWeUjFD380mx4520388AA=
Content-Type: multipart/mixed; boundary="VRLBIPfErPmCUCOOYnY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598362920;
 bh=5SLeMXIDZ/EBOdPJZibBpOblbiWdeVlCYbmd7ijME3E=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=JITkAZ7KEYbVUI7Oq9zReGT/0QsH978mKk2XJT8G9KwvAIeH/8sW7KSA+MiZ8eZvWTl
 8+wnXrCqefUegysGtN4nOiqZqTPDJlhnDGNQWnqFAmx0sJNex7IeduBcIGWCG000SzRi/
 j0BlpY3kV/surcmisveFYGEXu1g6fnZwaFU=

--VRLBIPfErPmCUCOOYnY5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

commit 267c4d8d132c8646fc90a58d40e3117656a4e9b5 upstream.

The desired behavior of the driver is to generate an interrupt and call
thermal_zone_device_update() as soon as the temperature have changed
more then one degree.

When the set_trips operation was implemented it was believed that the
trip window set by the framework would move around the current
temperature and the hysteresis value described in devicetree. The
behavior of the framework is however to set a window based on the trip
points described in devicetree.

Remove the set_trips operation which was not used correctly and update
the temperatures that triggers interrupts directly from the interrupt
handler.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200212224917.737314-1-niklas.soderlund+renesas@ragnatech.se
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index e7a0c7fc9897..166cadf4bf02 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -81,8 +81,6 @@ struct rcar_gen3_thermal_tsc {
 	void __iomem *base;
 	struct thermal_zone_device *zone;
 	struct equation_coefs coef;
-	int low;
-	int high;
 	int tj_t;
 	int id; /* thermal channel id */
 };
@@ -204,12 +202,14 @@ static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar_gen3_thermal_tsc *tsc,
 	return INT_FIXPT(val);
 }
 
-static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
+static int rcar_gen3_thermal_update_range(struct rcar_gen3_thermal_tsc *tsc)
 {
-	struct rcar_gen3_thermal_tsc *tsc = devdata;
+	int temperature, low, high;
+
+	rcar_gen3_thermal_get_temp(tsc, &temperature);
 
-	low = clamp_val(low, -40000, 120000);
-	high = clamp_val(high, -40000, 120000);
+	low = temperature - MCELSIUS(1);
+	high = temperature + MCELSIUS(1);
 
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP1,
 				rcar_gen3_thermal_mcelsius_to_temp(tsc, low));
@@ -217,15 +217,11 @@ static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
 	rcar_gen3_thermal_write(tsc, REG_GEN3_IRQTEMP2,
 				rcar_gen3_thermal_mcelsius_to_temp(tsc, high));
 
-	tsc->low = low;
-	tsc->high = high;
-
 	return 0;
 }
 
 static const struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops = {
 	.get_temp	= rcar_gen3_thermal_get_temp,
-	.set_trips	= rcar_gen3_thermal_set_trips,
 };
 
 static void rcar_thermal_irq_set(struct rcar_gen3_thermal_priv *priv, bool on)
@@ -246,9 +242,11 @@ static irqreturn_t rcar_gen3_thermal_irq(int irq, void *data)
 	for (i = 0; i < priv->num_tscs; i++) {
 		status = rcar_gen3_thermal_read(priv->tscs[i], REG_GEN3_IRQSTR);
 		rcar_gen3_thermal_write(priv->tscs[i], REG_GEN3_IRQSTR, 0);
-		if (status)
+		if (status) {
+			rcar_gen3_thermal_update_range(priv->tscs[i]);
 			thermal_zone_device_update(priv->tscs[i]->zone,
 						   THERMAL_EVENT_UNSPECIFIED);
+		}
 	}
 
 	return IRQ_HANDLED;
@@ -451,6 +449,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		if (ret < 0)
 			goto error_unregister;
 
+		rcar_gen3_thermal_update_range(tsc);
+
 		dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
 	}
 
@@ -489,7 +489,7 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct device *dev)
 		struct rcar_gen3_thermal_tsc *tsc = priv->tscs[i];
 
 		priv->thermal_init(tsc);
-		rcar_gen3_thermal_set_trips(tsc, tsc->low, tsc->high);
+		rcar_gen3_thermal_update_range(tsc);
 	}
 
 	rcar_thermal_irq_set(priv, true);
-- 
2.17.1


--VRLBIPfErPmCUCOOYnY5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5243): https://lists.cip-project.org/g/cip-dev/message=
/5243
Mute This Topic: https://lists.cip-project.org/mt/76406707/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--VRLBIPfErPmCUCOOYnY5--
