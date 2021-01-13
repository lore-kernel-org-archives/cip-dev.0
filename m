Return-Path: <SRS0=CTYu=GQ=lists.cip-project.org=bounce+64572+6074+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31890C433E9
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:01:10 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B2E023433
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2E023433
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6074+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ESKpYY4521723xsuF9uJT7Fc; Wed, 13 Jan 2021 08:01:09 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.10141.1610553666445693623
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 08:01:08 -0800
X-IronPort-AV: E=Sophos;i="5.79,344,1602514800"; 
   d="scan'208";a="68896937"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jan 2021 01:01:08 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 44120400C9EE;
	Thu, 14 Jan 2021 01:01:07 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 3/9] drm: rcar-du: Add r8a7742 support
Date: Wed, 13 Jan 2021 16:00:56 +0000
Message-Id: <20210113160102.16310-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: UGfp8aZnC22DTE4hhQFULNapx4520388AA=
Content-Type: multipart/mixed; boundary="vXhgwoAJSGu23Uj0FDsa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610553669;
 bh=SDYtcjz1LoWrmTMJUbEoLrs4JyoDv/icUGdzegCf0Xc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=MyDscARTl0Ud9GCE7JbCUibiM8MF0S8THupqk59ySIaaeU4Lb5t1j0/j26/qReO2U6E
 5TKPTLYWmmR57wZJy4gl3+K016LhSoxs0MliVlrWy/bm+XRXIfnhJjUTcFF9zgjfQYgkg
 f+rzGWAz5HlDeyywgI+mlWT4rXaN17zBdco=

--vXhgwoAJSGu23Uj0FDsa

commit 9edf73fece3d27e6fb5a764b732eca94c941838e upstream.

Add display support for the r8a7742 (RZ/G1H).

The RZ/G1H shares a common, compatible configuration with the r8a7790
(R-Car H2) so that device info structure is reused, the only difference
being TCON is unsupported on RZ/G1H (Currently unsupported by the driver).

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[PL:LVDS lanes 1 and 3 are switched in ES1 hardware (R8A7790) due to which
RCAR_DU_QUIRK_LVDS_LANES quirk was introduced, this quirk is not valid on
R8A7742 SoC so instead added new device info structure for R8A7742 SoC;
fixed typo in commit message direct->display]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_drv.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
index edb9c3f0b862..586bc28b641e 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
@@ -35,6 +35,32 @@
  * Device Information
  */
 
+static const struct rcar_du_device_info rcar_du_r8a7742_info = {
+	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
+		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
+	.quirks = RCAR_DU_QUIRK_ALIGN_128B,
+	.num_crtcs = 3,
+	.routes = {
+		/* R8A7742 has one RGB output and two LVDS outputs. */
+		[RCAR_DU_OUTPUT_DPAD0] = {
+			.possible_crtcs = BIT(2) | BIT(1) | BIT(0),
+			.encoder_type = DRM_MODE_ENCODER_NONE,
+			.port = 0,
+		},
+		[RCAR_DU_OUTPUT_LVDS0] = {
+			.possible_crtcs = BIT(0),
+			.encoder_type = DRM_MODE_ENCODER_LVDS,
+			.port = 1,
+		},
+		[RCAR_DU_OUTPUT_LVDS1] = {
+			.possible_crtcs = BIT(2) | BIT(1),
+			.encoder_type = DRM_MODE_ENCODER_LVDS,
+			.port = 2,
+		},
+	},
+	.num_lvds = 2,
+};
+
 static const struct rcar_du_device_info rzg1_du_r8a7743_info = {
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
@@ -174,6 +200,7 @@ static const struct rcar_du_device_info rcar_du_r8a7794_info = {
 };
 
 static const struct of_device_id rcar_du_of_table[] = {
+	{ .compatible = "renesas,du-r8a7742", .data = &rcar_du_r8a7742_info },
 	{ .compatible = "renesas,du-r8a7743", .data = &rzg1_du_r8a7743_info },
 	{ .compatible = "renesas,du-r8a7744", .data = &rzg1_du_r8a7743_info },
 	{ .compatible = "renesas,du-r8a7745", .data = &rzg1_du_r8a7745_info },
-- 
2.17.1


--vXhgwoAJSGu23Uj0FDsa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6074): https://lists.cip-project.org/g/cip-dev/message=
/6074
Mute This Topic: https://lists.cip-project.org/mt/79654001/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--vXhgwoAJSGu23Uj0FDsa--
