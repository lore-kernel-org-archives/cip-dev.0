Return-Path: <SRS0=QZcr=CD=lists.cip-project.org=bounce+64572+5245+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0FFC433DF
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 13:41:58 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C6092075F
	for <cip-dev@archiver.kernel.org>; Tue, 25 Aug 2020 13:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Vx4q7F4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6092075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5245+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yhzHYY4521723xNlkrzE6nkY; Tue, 25 Aug 2020 06:41:57 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.13479.1598361721660454951
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2020 06:22:08 -0700
X-IronPort-AV: E=Sophos;i="5.76,352,1592838000"; 
   d="scan'208";a="55486200"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 25 Aug 2020 22:22:08 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.65])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0FBB64004950;
	Tue, 25 Aug 2020 22:22:06 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 05/10] thermal: rcar_gen3_thermal: Add r8a774e1 support
Date: Tue, 25 Aug 2020 14:21:51 +0100
Message-Id: <20200825132156.7839-6-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
References: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Xh4uopQzjHLb8ZZpV0khYnJbx4520388AA=
Content-Type: multipart/mixed; boundary="Mbbp8O4ZqiThrPxWniml"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598362917;
 bh=CnjHXE8+rqMNi4Gj6eB/puoWk/N5mHa0yf7abPXbV5A=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Vx4q7F4kYBF8mYjQhIC6HEI+CTmmpOu43Rfo3aWZHyvhLh8oFagft5K4ll5wVAvb+aV
 gGtm8XkQoc4Vf9sy3zpTy3+fMemnlV8hnm0lloOV+QTQUusvf8aWI7qypsm2RmdK3WFWs
 dKNBmU/sTFkft+tlR29d2g/k4WcUkAeKB7o=

--Mbbp8O4ZqiThrPxWniml
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit 947d85f00c030aa88eef0c065b6f4636547257d7 upstream.

Add r8a774e1 specific compatible string.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1594811350-14066-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 92758445c574..9ebcbb07bbc0 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -314,6 +314,10 @@ static const struct of_device_id rcar_gen3_thermal_dt_ids[] = {
 		.compatible = "renesas,r8a774b1-thermal",
 		.data = &rcar_gen3_ths_tj_1,
 	},
+	{
+		.compatible = "renesas,r8a774e1-thermal",
+		.data = &rcar_gen3_ths_tj_1,
+	},
 	{
 		.compatible = "renesas,r8a7795-thermal",
 		.data = &rcar_gen3_ths_tj_1,
-- 
2.17.1


--Mbbp8O4ZqiThrPxWniml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5245): https://lists.cip-project.org/g/cip-dev/message=
/5245
Mute This Topic: https://lists.cip-project.org/mt/76406709/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Mbbp8O4ZqiThrPxWniml--
