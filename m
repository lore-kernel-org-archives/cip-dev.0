Return-Path: <SRS0=2RnZ=IH=lists.cip-project.org=bounce+64572+6249+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C41C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:44 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C44B651BB
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C44B651BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6249+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id iDthYY4521723xTh1jhQQkdO; Tue, 09 Mar 2021 08:37:44 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11727.1615307829143333394
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:43 -0800
X-IronPort-AV: E=Sophos;i="5.81,234,1610377200"; 
   d="scan'208";a="74342267"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:43 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5547D40A2DC7;
	Wed, 10 Mar 2021 01:37:42 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 33/40] media: rcar-vin: Enable support for R8A774E1
Date: Tue,  9 Mar 2021 16:36:49 +0000
Message-Id: <20210309163656.20944-34-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: BBF0lvaMffuniBE9nWowomVNx4520388AA=
Content-Type: multipart/mixed; boundary="iNfmeAZd2pmKmLoX7FFz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307864;
 bh=h/8Z2wtVD+HbxmwMdTqASHxYJARUfmhIwHXgdHMp60M=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ME8VhEFcRH+cosf/0037qIg5w3Pwz7s79MnJfk046IGG1Z0ZkatEnRkiyJzFsDniBrG
 FCczs6uOV5flV9q/5cVPWgMhBIKWsCI0i0oLIqLi95tOeEk3rgxyyTDcZD7gntFcMWh0V
 yJEqy9mtvgNLcVVkDiiGl8YvNgMMKQDjwx4=

--iNfmeAZd2pmKmLoX7FFz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit fe98df32bd9e41b5ac2cdbd8c8ce97182b81b495 upstream.

Add the SoC specific information for RZ/G2H (R8A774E1) SoC. Also add
the routing information between CSI2 and VIN (which is similar to
R-Car H3 except it lacks CSI41).

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/platform/rcar-vin/rcar-core.c | 40 +++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/media/platform/rcar-vin/rcar-core.c b/drivers/media/platform/rcar-vin/rcar-core.c
index 734686810438..d6d0056c5976 100644
--- a/drivers/media/platform/rcar-vin/rcar-core.c
+++ b/drivers/media/platform/rcar-vin/rcar-core.c
@@ -888,6 +888,42 @@ static const struct rvin_info rcar_info_gen2 = {
 	.max_height = 2048,
 };
 
+static const struct rvin_group_route rcar_info_r8a774e1_routes[] = {
+	{ .csi = RVIN_CSI40, .channel = 0, .vin = 0, .mask = BIT(0) | BIT(3) },
+	{ .csi = RVIN_CSI20, .channel = 0, .vin = 0, .mask = BIT(1) | BIT(4) },
+	{ .csi = RVIN_CSI40, .channel = 1, .vin = 0, .mask = BIT(2) },
+	{ .csi = RVIN_CSI20, .channel = 0, .vin = 1, .mask = BIT(0) },
+	{ .csi = RVIN_CSI40, .channel = 1, .vin = 1, .mask = BIT(1) | BIT(3) },
+	{ .csi = RVIN_CSI40, .channel = 0, .vin = 1, .mask = BIT(2) },
+	{ .csi = RVIN_CSI20, .channel = 1, .vin = 1, .mask = BIT(4) },
+	{ .csi = RVIN_CSI20, .channel = 1, .vin = 2, .mask = BIT(0) },
+	{ .csi = RVIN_CSI40, .channel = 0, .vin = 2, .mask = BIT(1) },
+	{ .csi = RVIN_CSI20, .channel = 0, .vin = 2, .mask = BIT(2) },
+	{ .csi = RVIN_CSI40, .channel = 2, .vin = 2, .mask = BIT(3) },
+	{ .csi = RVIN_CSI20, .channel = 2, .vin = 2, .mask = BIT(4) },
+	{ .csi = RVIN_CSI40, .channel = 1, .vin = 3, .mask = BIT(0) },
+	{ .csi = RVIN_CSI20, .channel = 1, .vin = 3, .mask = BIT(1) | BIT(2) },
+	{ .csi = RVIN_CSI40, .channel = 3, .vin = 3, .mask = BIT(3) },
+	{ .csi = RVIN_CSI20, .channel = 3, .vin = 3, .mask = BIT(4) },
+	{ .csi = RVIN_CSI20, .channel = 0, .vin = 4, .mask = BIT(1) | BIT(4) },
+	{ .csi = RVIN_CSI20, .channel = 0, .vin = 5, .mask = BIT(0) },
+	{ .csi = RVIN_CSI20, .channel = 1, .vin = 5, .mask = BIT(4) },
+	{ .csi = RVIN_CSI20, .channel = 1, .vin = 6, .mask = BIT(0) },
+	{ .csi = RVIN_CSI20, .channel = 0, .vin = 6, .mask = BIT(2) },
+	{ .csi = RVIN_CSI20, .channel = 2, .vin = 6, .mask = BIT(4) },
+	{ .csi = RVIN_CSI20, .channel = 1, .vin = 7, .mask = BIT(1) | BIT(2) },
+	{ .csi = RVIN_CSI20, .channel = 3, .vin = 7, .mask = BIT(4) },
+	{ /* Sentinel */ }
+};
+
+static const struct rvin_info rcar_info_r8a774e1 = {
+	.model = RCAR_GEN3,
+	.use_mc = true,
+	.max_width = 4096,
+	.max_height = 4096,
+	.routes = rcar_info_r8a774e1_routes,
+};
+
 static const struct rvin_group_route rcar_info_r8a7795_routes[] = {
 	{ .csi = RVIN_CSI40, .channel = 0, .vin = 0, .mask = BIT(0) | BIT(3) },
 	{ .csi = RVIN_CSI20, .channel = 0, .vin = 0, .mask = BIT(1) | BIT(4) },
@@ -1130,6 +1166,10 @@ static const struct of_device_id rvin_of_id_table[] = {
 		.compatible = "renesas,vin-r8a774c0",
 		.data = &rcar_info_r8a77990,
 	},
+	{
+		.compatible = "renesas,vin-r8a774e1",
+		.data = &rcar_info_r8a774e1,
+	},
 	{
 		.compatible = "renesas,vin-r8a7778",
 		.data = &rcar_info_m1,
-- 
2.17.1


--iNfmeAZd2pmKmLoX7FFz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6249): https://lists.cip-project.org/g/cip-dev/message=
/6249
Mute This Topic: https://lists.cip-project.org/mt/81205388/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--iNfmeAZd2pmKmLoX7FFz--
