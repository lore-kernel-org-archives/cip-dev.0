Return-Path: <SRS0=60gs=BH=lists.cip-project.org=bounce+64572+5038+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4179EC433F2
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:29 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 162432070B
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="T0X2RX8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162432070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5038+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id tzaVYY4521723xhtTGg8kJJF; Tue, 28 Jul 2020 04:52:28 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.9579.1595933019852967366
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2020 03:43:41 -0700
X-IronPort-AV: E=Sophos;i="5.75,406,1589209200"; 
   d="scan'208";a="53033318"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 28 Jul 2020 19:43:41 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.253])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A84E040062A4;
	Tue, 28 Jul 2020 19:43:39 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 4/9] drm/panel: simple: Add EDT panel support
Date: Tue, 28 Jul 2020 11:43:25 +0100
Message-Id: <20200728104330.6182-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
References: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: IhWkUlXPmSWtkserSZNIYzs7x4520388AA=
Content-Type: multipart/mixed; boundary="UWo4FsmQIYPIfQPYDdjP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595937148;
 bh=4/WunuSRM+yACLu48fwa7g5ZnP8Btj3/rOB0Wb0DO2o=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=T0X2RX8DPXFoqxRi3FNhoPigMMOZMEu1FAlBqMYuKQpOT9Sh3gWXF75CHbf6B5a2lys
 uC1OL+Rm8s9FCd4dv2HYENbvayviI4Yb4t4TCAAeTv4LKPh3k4FUOvYvy2MczczRoW5JO
 5J6FacB0aPOy2A26bqCEMK79NSQd4aMMjL4=

--UWo4FsmQIYPIfQPYDdjP

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit 82d57a590f51eb86e1ad0f24db257739ce0bfd74 upstream.

EDT ET043080DH6-GP is a 4.3" WQVGA 480x272 RGB LCD panel used on the iWave
Generic SODIMM Development Platform.

Changes in v2:
	-added mandatory .connector_type field
	-changed the .bus_format MEDIA_BUS_FMT_RGB666_1X18

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/1580386118-22895-3-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
[Removed connector type. Supporting the same requires framework changes]
---
 drivers/gpu/drm/panel/panel-simple.c | 33 ++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index ecad4d7c6cd1..2b2a2f3da9a4 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -614,6 +614,36 @@ static const struct panel_desc chunghwa_claa101wb01 = {
 	},
 };
 
+static const struct drm_display_mode edt_etm043080dh6gp_mode = {
+	.clock = 10870,
+	.hdisplay = 480,
+	.hsync_start = 480 + 8,
+	.hsync_end = 480 + 8 + 4,
+	.htotal = 480 + 8 + 4 + 41,
+
+	/*
+	 * IWG22M: Y resolution changed for "dc_linuxfb" module crashing while
+	 * fb_align
+	 */
+
+	.vdisplay = 288,
+	.vsync_start = 288 + 2,
+	.vsync_end = 288 + 2 + 4,
+	.vtotal = 288 + 2 + 4 + 10,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc edt_etm043080dh6gp = {
+	.modes = &edt_etm043080dh6gp_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 100,
+		.height = 65,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+};
+
 static const struct drm_display_mode edt_et057090dhu_mode = {
 	.clock = 25175,
 	.hdisplay = 640,
@@ -1129,6 +1159,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "chunghwa,claa101wb01",
 		.data = &chunghwa_claa101wb01
+	}, {
+		.compatible = "edt,etm043080dh6gp",
+		.data = &edt_etm043080dh6gp,
 	}, {
 		.compatible = "edt,et057090dhu",
 		.data = &edt_et057090dhu,
-- 
2.17.1


--UWo4FsmQIYPIfQPYDdjP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5038): https://lists.cip-project.org/g/cip-dev/message=
/5038
Mute This Topic: https://lists.cip-project.org/mt/75842043/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--UWo4FsmQIYPIfQPYDdjP--
