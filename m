Return-Path: <SRS0=71Dr=BB=lists.cip-project.org=bounce+64572+4973+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A46C433F2
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:09 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F286D207E8
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="EvJqNSpv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F286D207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4973+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id L7ztYY4521723xmo8GWouo11; Wed, 22 Jul 2020 10:47:08 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.23014.1595435704158275348
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 09:35:04 -0700
X-IronPort-AV: E=Sophos;i="5.75,383,1589209200"; 
   d="scan'208";a="52832225"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Jul 2020 01:35:03 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2E28A4004931;
	Thu, 23 Jul 2020 01:35:01 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 06/17] drm: rcar_lvds: Fix dual link mode operations
Date: Wed, 22 Jul 2020 17:34:38 +0100
Message-Id: <20200722163449.3513-7-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
References: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: StDOof7ztWwk2fh1fLI11LC1x4520388AA=
Content-Type: multipart/mixed; boundary="34NOiUbvSFdlnagqVNDK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595440028;
 bh=g8TexMeawZ8DIdeYz8qbeaYiIowEWSmXewd98qufEFs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=EvJqNSpv8+6X2lXpE8DYVL/1jpsvdsOdbg8IetxZIM+hNajiC14famjIwn3U7iRFbpA
 x0rVwypA5zP+ngvOPMpwqwf/7X/IN1YwaWNOWcZvAJ9MnFuGTvHGXpU+cuJS1Ox30uRFa
 tjZIzyYxHW4wFJlmyAixhLJHpDVvBBUUy30=

--34NOiUbvSFdlnagqVNDK

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

commit a53358a31c989c360ea59536d28762b9d2d68d19 upstream.

The R-Car LVDS encoder units support dual-link operations by splitting
the pixel output between the primary encoder and the companion encoder.

Currently the companion encoder fails at probe time, causing the
registration of the primary to fail as well, preventing the whole DU unit
from being registered at all.

Fix this by not bailing out from probe with error if the
"renesas,companion" property is not specified.

Fixes: fa440d870358 ("drm: rcar-du: lvds: Add support for dual-link mode")
Reported-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/rcar-du/rcar_lvds.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index 0774bd00dfac..2558067efe22 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -666,10 +666,8 @@ static int rcar_lvds_parse_dt_companion(struct rcar_lvds *lvds)
 
 	/* Locate the companion LVDS encoder for dual-link operation, if any. */
 	companion = of_parse_phandle(dev->of_node, "renesas,companion", 0);
-	if (!companion) {
-		dev_err(dev, "Companion LVDS encoder not found\n");
-		return -ENXIO;
-	}
+	if (!companion)
+		return 0;
 
 	/*
 	 * Sanity check: the companion encoder must have the same compatible
-- 
2.17.1


--34NOiUbvSFdlnagqVNDK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4973): https://lists.cip-project.org/g/cip-dev/message=
/4973
Mute This Topic: https://lists.cip-project.org/mt/75730035/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--34NOiUbvSFdlnagqVNDK--
