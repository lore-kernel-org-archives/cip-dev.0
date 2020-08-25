Return-Path: <SRS0=kKQY=CD=lists.cip-project.org=bounce+64572+5242+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F235C433EC
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 13:42:00 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 523D820786
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 13:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="KDNKg0qO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523D820786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5242+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id gIlyYY4521723xKWOrrvs8Di; Tue, 25 Aug 2020 06:42:00 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.13293.1598361720422412146
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2020 06:22:03 -0700
X-IronPort-AV: E=Sophos;i="5.76,352,1592838000"; 
   d="scan'208";a="55269188"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 25 Aug 2020 22:22:02 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.65])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7F2A64008C59;
	Tue, 25 Aug 2020 22:22:01 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 02/10] thermal: rcar_gen3_thermal: Remove temperature bound
Date: Tue, 25 Aug 2020 14:21:48 +0100
Message-Id: <20200825132156.7839-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
References: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: L1wvE5SxtLHT0W3UEPTE4irJx4520388AA=
Content-Type: multipart/mixed; boundary="TvTAmxmDd4Fr0QGulKFo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598362920;
 bh=7J8LXh4A79C8rDh3mJfIac+ISpI+fCmod6SaqyZ1cDk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=KDNKg0qOPQkn26sKdRot80ODqRtoYP0qUEHhkGjU7tNbu+cS7ro+v574CiRan/qylYG
 h7dZmaXakEf0Bg28YK9WhfRjOnAdRe6zQtvEJwLgkUeXFga0TEvrJCqEXQiOaSERKBnUy
 oBNNTyp42yqUpTDy3APPWA01du15NzVHohk=

--TvTAmxmDd4Fr0QGulKFo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

commit 0f510a2457cbbba18a98492bab1bf540be57ebd1 upstream.

The hardware manual states that the operation of the sensor is not
guaranteed with temperatures above 125°C, not that the readings are
invalid. Remove the bound check and try to deliver temperature readings
even if we are outside the guaranteed operation range.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200117160554.3812787-3-niklas.soderlund+renesas@ragnatech.se
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 42ec69d29540..e7a0c7fc9897 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -182,9 +182,7 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
 				tsc->coef.a2);
 	mcelsius = FIXPT_TO_MCELSIUS(val);
 
-	/* Make sure we are inside specifications */
-	if ((mcelsius < MCELSIUS(-40)) || (mcelsius > MCELSIUS(125)))
-		return -EIO;
+	/* Guaranteed operating range is -40C to 125C. */
 
 	/* Round value to device granularity setting */
 	*temp = rcar_gen3_thermal_round(mcelsius);
-- 
2.17.1


--TvTAmxmDd4Fr0QGulKFo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5242): https://lists.cip-project.org/g/cip-dev/message=
/5242
Mute This Topic: https://lists.cip-project.org/mt/76406706/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--TvTAmxmDd4Fr0QGulKFo--
