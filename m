Return-Path: <SRS0=LBWU=BN=lists.cip-project.org=bounce+64572+5081+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60C8C433E0
	for <cip-dev@archiver.kernel.org>; Mon,  3 Aug 2020 11:27:57 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424B020738
	for <cip-dev@archiver.kernel.org>; Mon,  3 Aug 2020 11:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="gOl/rZty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424B020738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5081+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rWuFYY4521723xDLTCrosgBy; Mon, 03 Aug 2020 04:27:57 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.8800.1596453286802143413
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Aug 2020 04:14:47 -0700
X-IronPort-AV: E=Sophos;i="5.75,429,1589209200"; 
   d="scan'208";a="53741060"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Aug 2020 20:14:44 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0552B423591D;
	Mon,  3 Aug 2020 20:14:42 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip] drm: of: Fix double-free bug
Date: Mon,  3 Aug 2020 12:14:41 +0100
Message-Id: <20200803111441.3157-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mS8XN9e5Hb3caVOzSgpbc0XCx4520388AA=
Content-Type: multipart/mixed; boundary="b6J4bcCmwLpuFXZQLbCI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596454077;
 bh=/rMrpz5AGYajL8c4+PXznXvd0nZtQYQTZf6q89VAW3c=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=gOl/rZtyXGsiHX2IypdPdAXaP1U1sXnjvxazuz7v8jXE5iYsiPeOlP36NMFc1WTQRGV
 s5NQO6fUifLOfP3qWW/lEvKKjKthV9s6uL+/rx6UxUUPZNFhJ5bnOWDSTbhAbjhgzljHW
 +e8gZ6/GlUmbufMLBfP3WPtSEFU2B7EK6MQ=

--b6J4bcCmwLpuFXZQLbCI

commit 4ee48cc5586bf519df19894273002aa8ef7b70ad upstream.

Fix double-free bug in the error path.

Fixes: 6529007522de ("drm: of: Add drm_of_lvds_get_dual_link_pixel_order")
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/1595502654-40595-1-git-send-email-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/drm_of.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 4f0bc1363fbe..f2e7f953cc93 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -323,10 +323,8 @@ static int drm_of_lvds_get_remote_pixels_type(
 		 * configurations by passing the endpoints explicitly to
 		 * drm_of_lvds_get_dual_link_pixel_order().
 		 */
-		if (!current_pt || pixels_type != current_pt) {
-			of_node_put(remote_port);
+		if (!current_pt || pixels_type != current_pt)
 			return -EINVAL;
-		}
 	}
 
 	return pixels_type;
-- 
2.17.1


--b6J4bcCmwLpuFXZQLbCI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5081): https://lists.cip-project.org/g/cip-dev/message=
/5081
Mute This Topic: https://lists.cip-project.org/mt/75963411/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--b6J4bcCmwLpuFXZQLbCI--
