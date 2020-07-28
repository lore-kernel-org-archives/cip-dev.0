Return-Path: <SRS0=Hv8i=BH=lists.cip-project.org=bounce+64572+5031+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F65DC433ED
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:29 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A67206D7
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="fLHFl2m7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A67206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5031+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id oR2OYY4521723xTd0FJsIaLO; Tue, 28 Jul 2020 04:52:28 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.9581.1595933025628482315
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2020 03:43:49 -0700
X-IronPort-AV: E=Sophos;i="5.75,406,1589209200"; 
   d="scan'208";a="53245264"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Jul 2020 19:43:48 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.253])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4D92740041B6;
	Tue, 28 Jul 2020 19:43:47 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 8/9] ARM: shmobile: defconfig: Enable support for panels from EDT
Date: Tue, 28 Jul 2020 11:43:29 +0100
Message-Id: <20200728104330.6182-9-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
References: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jwR0uJJN0PWJspdQhWwu7vFUx4520388AA=
Content-Type: multipart/mixed; boundary="3MY3c3MHLxg4F163FbzE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595937148;
 bh=/zXV8wnJF9+mDe6zDHfkO+b3sBdpTHkFlPI9E3lnbZE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=fLHFl2m7Hlvibpe6XolKqrtdkA8GYBSaXBu547cHaUToAF4M+IuflB7cPQVdUiO/IC3
 I5WzIpkaDdOBULZeS7DQj/shGWDPgqQl1Y3oSG18jDR5c4WzEEukNksmEfi+fmDoTeCq2
 4QmqQZWpPT24Nd7zfDqpkq3WspTbo8iHSHw=

--3MY3c3MHLxg4F163FbzE

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit a630a6121bef3e9598482a49eda6b1fa715385d6 upstream.

The iwg20d comes with an LCD panel from Emerging Display
Technologies Corporation (EDT), therefore enable what's
required to support it.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/1573660292-10629-12-git-send-email-fabrizio.castro@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
[Removed DRM_LVDS_CODEC configuration]
---
 arch/arm/configs/shmobile_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index f21de1bec37c..151fad5c0b8d 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -98,6 +98,7 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
 CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_EDT_FT5X06=y
 CONFIG_TOUCHSCREEN_ST1232=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_ADXL34X=y
@@ -155,6 +156,7 @@ CONFIG_DRM_I2C_ADV7511=y
 CONFIG_DRM_RCAR_DU=y
 CONFIG_DRM_RCAR_HDMI=y
 CONFIG_DRM_RCAR_LVDS=y
+CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_FB_SH_MOBILE_LCDC=y
 CONFIG_FB_SH_MOBILE_MERAM=y
 # CONFIG_LCD_CLASS_DEVICE is not set
-- 
2.17.1


--3MY3c3MHLxg4F163FbzE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5031): https://lists.cip-project.org/g/cip-dev/message=
/5031
Mute This Topic: https://lists.cip-project.org/mt/75842036/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--3MY3c3MHLxg4F163FbzE--
