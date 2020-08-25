Return-Path: <SRS0=zupz=CD=lists.cip-project.org=bounce+64572+5244+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC29C433ED
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 13:42:00 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC2320786
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 13:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dDbFK3eK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC2320786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5244+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KZkOYY4521723xEIt30ofVNs; Tue, 25 Aug 2020 06:42:00 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.13479.1598361721660454951
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2020 06:22:07 -0700
X-IronPort-AV: E=Sophos;i="5.76,352,1592838000"; 
   d="scan'208";a="55486197"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 25 Aug 2020 22:22:06 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.65])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 38717400517E;
	Tue, 25 Aug 2020 22:22:05 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 04/10] thermal/drivers/rcar_gen3: Fix undefined temperature if negative
Date: Tue, 25 Aug 2020 14:21:50 +0100
Message-Id: <20200825132156.7839-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
References: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jaLEoU3C260Hp0hA9iPNlny8x4520388AA=
Content-Type: multipart/mixed; boundary="c88Ft8UJCLEVdHsmLzWu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598362920;
 bh=xvste9SSJgNBvJXDvV3Sy1zRd/P9RoAgr1qZ6pL5rE0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=dDbFK3eKv6NcXotIL3uUycuc51w0u+h7S69siVjBLChhwYijMQZulKH03pMq6ifwgd1
 vF6io+Vb3p87u3A7hRkXTmeTy8U4VAhX20WypRJzrAp4uDsvZA7g3V9sEAUS0yo85+xMq
 qudpzgfY5xqd0wGX+/vWb1NAiIpzvtsa73g=

--c88Ft8UJCLEVdHsmLzWu

From: Dien Pham <dien.pham.ry@renesas.com>

commit 5f8f06425a0dcdad7bedbb77e67f5c65ab4dacfc upstream.

As description for DIV_ROUND_CLOSEST in file include/linux/kernel.h.
  "Result is undefined for negative divisors if the dividend variable
   type is unsigned and for negative dividends if the divisor variable
   type is unsigned."

In current code, the FIXPT_DIV uses DIV_ROUND_CLOSEST but has not
checked sign of divisor before using. It makes undefined temperature
value in case the value is negative.

This patch fixes to satisfy DIV_ROUND_CLOSEST description
and fix bug too. Note that the variable name "reg" is not good
because it should be the same type as rcar_gen3_thermal_read().
However, it's better to rename the "reg" in a further patch as
cleanup.

Signed-off-by: Van Do <van.do.xw@renesas.com>
Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
[shimoda: minor fixes, add Fixes tag]
Fixes: 564e73d283af ("thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal driver")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>
Tested-by: Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1593085099-2057-1-git-send-email-yoshihiro.shimoda.uh@renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 166cadf4bf02..92758445c574 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -167,7 +167,7 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
 {
 	struct rcar_gen3_thermal_tsc *tsc = devdata;
 	int mcelsius, val;
-	u32 reg;
+	int reg;
 
 	/* Read register and convert to mili Celsius */
 	reg = rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
-- 
2.17.1


--c88Ft8UJCLEVdHsmLzWu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5244): https://lists.cip-project.org/g/cip-dev/message=
/5244
Mute This Topic: https://lists.cip-project.org/mt/76406708/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--c88Ft8UJCLEVdHsmLzWu--
