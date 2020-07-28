Return-Path: <SRS0=vBKP=BH=lists.cip-project.org=bounce+64572+5033+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F21C433E8
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:28 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D58206D7
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LSgbQti/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D58206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5033+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id t7i1YY4521723xZz6lghdmRG; Tue, 28 Jul 2020 04:52:27 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.9577.1595933016078170413
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2020 03:43:36 -0700
X-IronPort-AV: E=Sophos;i="5.75,406,1589209200"; 
   d="scan'208";a="53033308"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 28 Jul 2020 19:43:35 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.253])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 001D240062A4;
	Tue, 28 Jul 2020 19:43:33 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 1/9] drm: Add an encoder and connector type enum for DPI.
Date: Tue, 28 Jul 2020 11:43:22 +0100
Message-Id: <20200728104330.6182-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
References: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: zNqoCRxKzVOEPRfIiieAcwj8x4520388AA=
Content-Type: multipart/mixed; boundary="NRQNPqFNKHIFcycriUF1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595937147;
 bh=2mV1nGUlFUgHqutDFS0trZhSfUTUunSiq9qXM2/IZNY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=LSgbQti/12sia/3gu3ykwelmyJPktkOsybdo2dm4nI64d1drL2/nHuMazGIV1tCgSGl
 m22IAnoHUPGA8dz7vCuX9UqQKET/iCzDAj0sQqYQBNNtdKQ5Edr3eMAmIe09ec4w9JG+0
 cZ0Z803sR8hTWI1slyX3I+fXsGzeoOyDMwQ=

--NRQNPqFNKHIFcycriUF1

From: Eric Anholt <eric@anholt.net>

commit 0b27c02a7f1c697694f2ad6d6517e7dbf9ecfa39 upstream.

Right now exynos is exposing DPI as a TMDS encoder and VGA connector,
which seems rather misleading.  This isn't just an internal detail,
since xrandr actually exposes "VGA" as the output name.  Define some
new enums so that vc4's DPI can have a more informative name.

I considered other names for the connector as well.  For VC4, the
Adafruit DPI kippah takes the 28 GPIO pins and routes them to a
standard-ish 40-pin FPC connector, but "40-pin FPC" doesn't uniquely
identify an ordering of pins (apparently some other orderings exist),
doesn't explain things as well for the user (who, if anything, knows
their product is a DPI kippah/panel combo), and actually doesn't have
to exist (one could connect the 28 GPIOs directly to something else).
Simply "DPI" seems like a good compromise name to distinguish from the
HDMI, DSI, and TV connectors .

Signed-off-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/drm_crtc.c  | 2 ++
 include/uapi/drm/drm_mode.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 5e4bb4837bae..34538444fd19 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -168,6 +168,7 @@ static struct drm_conn_prop_enum_list drm_connector_enum_list[] = {
 	{ DRM_MODE_CONNECTOR_eDP, "eDP" },
 	{ DRM_MODE_CONNECTOR_VIRTUAL, "Virtual" },
 	{ DRM_MODE_CONNECTOR_DSI, "DSI" },
+	{ DRM_MODE_CONNECTOR_DPI, "DPI" },
 };
 
 static const struct drm_prop_enum_list drm_encoder_enum_list[] = {
@@ -179,6 +180,7 @@ static const struct drm_prop_enum_list drm_encoder_enum_list[] = {
 	{ DRM_MODE_ENCODER_VIRTUAL, "Virtual" },
 	{ DRM_MODE_ENCODER_DSI, "DSI" },
 	{ DRM_MODE_ENCODER_DPMST, "DP MST" },
+	{ DRM_MODE_ENCODER_DPI, "DPI" },
 };
 
 static const struct drm_prop_enum_list drm_subpixel_enum_list[] = {
diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index 6c11ca401de8..325e9eb3d812 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -202,6 +202,7 @@ struct drm_mode_get_plane_res {
 #define DRM_MODE_ENCODER_VIRTUAL 5
 #define DRM_MODE_ENCODER_DSI	6
 #define DRM_MODE_ENCODER_DPMST	7
+#define DRM_MODE_ENCODER_DPI	8
 
 struct drm_mode_get_encoder {
 	__u32 encoder_id;
@@ -241,6 +242,7 @@ struct drm_mode_get_encoder {
 #define DRM_MODE_CONNECTOR_eDP		14
 #define DRM_MODE_CONNECTOR_VIRTUAL      15
 #define DRM_MODE_CONNECTOR_DSI		16
+#define DRM_MODE_CONNECTOR_DPI		17
 
 struct drm_mode_get_connector {
 
-- 
2.17.1


--NRQNPqFNKHIFcycriUF1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5033): https://lists.cip-project.org/g/cip-dev/message=
/5033
Mute This Topic: https://lists.cip-project.org/mt/75842038/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--NRQNPqFNKHIFcycriUF1--
