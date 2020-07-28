Return-Path: <SRS0=jAqW=BH=lists.cip-project.org=bounce+64572+5035+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF13C433EA
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:28 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8702074F
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="TStM7vTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8702074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5035+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Fs7FYY4521723xItR3vAzCJB; Tue, 28 Jul 2020 04:52:28 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.9581.1595933025628482315
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2020 03:43:45 -0700
X-IronPort-AV: E=Sophos;i="5.75,406,1589209200"; 
   d="scan'208";a="53245253"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Jul 2020 19:43:45 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.253])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8F87840041B6;
	Tue, 28 Jul 2020 19:43:43 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 6/9] drm: rcar-du: Use the DRM panel API
Date: Tue, 28 Jul 2020 11:43:27 +0100
Message-Id: <20200728104330.6182-7-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
References: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: vZzKAecV3MVc4L2zk1kUySybx4520388AA=
Content-Type: multipart/mixed; boundary="7sMKfcmRVg2ECKmVZ06Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595937148;
 bh=xyfHQNOJwCvQoi/uwkyt7LBwf5UL4JPq+dluU+O8uFc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=TStM7vTfblGRSfIjJYyYc+5rQeO62Zp44xg1oGkfXvpl0WpHBtlX7yDFkwQCFWhNrzm
 TFI/Xtmg4YIitS9p9vp+gvbge4iOtS2ce0MKGiEmp0Y91C4x7RBZXeN2soD7O8CeiqB2N
 IJ2+NRvT9kEB7FiUv0GzYm4ZWijySoNJD6c=

--7sMKfcmRVg2ECKmVZ06Y

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit bf7149f34241dcd6c95ea76b2b5ab4ff33f1c9b9 upstream.

Instead of parsing the panel device tree node manually, use the panel
API to delegate panel handling to a panel driver.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
[Removed all other changes except Kconfig. This config is
 required for building simple panel driver]
---
 drivers/gpu/drm/rcar-du/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rcar-du/Kconfig b/drivers/gpu/drm/rcar-du/Kconfig
index d4e0a39568f6..4261a302e051 100644
--- a/drivers/gpu/drm/rcar-du/Kconfig
+++ b/drivers/gpu/drm/rcar-du/Kconfig
@@ -21,6 +21,7 @@ config DRM_RCAR_HDMI
 config DRM_RCAR_LVDS
 	bool "R-Car DU LVDS Encoder Support"
 	depends on DRM_RCAR_DU
+	select DRM_PANEL
 	depends on ARCH_R8A7790 || ARCH_R8A7791 || COMPILE_TEST
 	help
 	  Enable support for the R-Car Display Unit embedded LVDS encoders
-- 
2.17.1


--7sMKfcmRVg2ECKmVZ06Y
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5035): https://lists.cip-project.org/g/cip-dev/message=
/5035
Mute This Topic: https://lists.cip-project.org/mt/75842040/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--7sMKfcmRVg2ECKmVZ06Y--
