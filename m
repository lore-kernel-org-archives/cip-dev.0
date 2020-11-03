Return-Path: <SRS0=3OgX=EJ=lists.cip-project.org=bounce+64572+5723+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4670C388F7
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:53 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0601921D91
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="woIlLL5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0601921D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5723+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PlOhYY4521723xOt6uuGFkMx; Tue, 03 Nov 2020 09:33:52 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.810.1604424820973392125
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Nov 2020 09:33:51 -0800
X-IronPort-AV: E=Sophos;i="5.77,448,1596466800"; 
   d="scan'208";a="61561048"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Nov 2020 02:33:51 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 88DE44009BE5;
	Wed,  4 Nov 2020 02:33:50 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 10/17] drm: rcar-du: lvds: Add support for R8A774E1 SoC
Date: Tue,  3 Nov 2020 17:33:29 +0000
Message-Id: <20201103173336.2829-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NBTDRP66VvGR8MCyXvBlKbuFx4520388AA=
Content-Type: multipart/mixed; boundary="zFWfr9snr4m2UrMuEin3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604424832;
 bh=eX5giHufYbdmuI4WdwcKlANFosMFkHZtQzJnLOEW4dI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=woIlLL5xm8nr761Azii7CqzqTIDXtfnOtoTS2hHBsWY8tFaE681YnGRrMew1dQiNr4Q
 IMW337FFXIqXgqBhp2dUIDuhAdwWYsIOTTVLIT0KPF0Oc65DpJNYa01KvMtTd+MiooQb6
 Y8JZVEfy7+goyegAwfuWYGCVua4PdoDJY7I=

--zFWfr9snr4m2UrMuEin3

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit 6d981d276110c7d6e866179db4bb1c6cbfcd1819 upstream.

The LVDS encoder on RZ/G2H (R8A774E1) SoC is identical to R-Car Gen3 so
just reuse the rcar_lvds_gen3_info structure to hookup R8A774E1 to LVDS
encoder driver.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[PL: Manually applied changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_lvds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index e4d0bd043613..fe39b54975b0 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -953,6 +953,7 @@ static const struct of_device_id rcar_lvds_of_table[] = {
 	{ .compatible = "renesas,r8a774a1-lvds", .data = &rcar_lvds_gen3_info },
 	{ .compatible = "renesas,r8a774b1-lvds", .data = &rcar_lvds_gen3_info },
 	{ .compatible = "renesas,r8a774c0-lvds", .data = &rcar_lvds_r8a77990_info },
+	{ .compatible = "renesas,r8a774e1-lvds", .data = &rcar_lvds_gen3_info },
 	{ .compatible = "renesas,r8a7790-lvds", .data = &rcar_lvds_r8a7790_info },
 	{ .compatible = "renesas,r8a7791-lvds", .data = &rcar_lvds_gen2_info },
 	{ .compatible = "renesas,r8a7793-lvds", .data = &rcar_lvds_gen2_info },
-- 
2.17.1


--zFWfr9snr4m2UrMuEin3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5723): https://lists.cip-project.org/g/cip-dev/message=
/5723
Mute This Topic: https://lists.cip-project.org/mt/78011702/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zFWfr9snr4m2UrMuEin3--
