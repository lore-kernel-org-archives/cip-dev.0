Return-Path: <SRS0=BjqW=BH=lists.cip-project.org=bounce+64572+5036+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310B5C433E5
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:28 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6727F2070B
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Uo+/WYb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6727F2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5036+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TZ6IYY4521723xcZizkpkTo0; Tue, 28 Jul 2020 04:52:27 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.9581.1595933025628482315
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2020 03:43:47 -0700
X-IronPort-AV: E=Sophos;i="5.75,406,1589209200"; 
   d="scan'208";a="53245259"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Jul 2020 19:43:46 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.253])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 79F9A40062A4;
	Tue, 28 Jul 2020 19:43:45 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 7/9] ARM: shmobile: defconfig: Enable frame buffer console for armadillo800eva
Date: Tue, 28 Jul 2020 11:43:28 +0100
Message-Id: <20200728104330.6182-8-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
References: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: oCFNJJgYLZB60LV43QH40i4Jx4520388AA=
Content-Type: multipart/mixed; boundary="6PjqgATjVE26KqINZhod"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595937147;
 bh=3/H4ai+2+MoE+2OLP5todN2zKNRokjHr0QsrA4CMIRE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Uo+/WYb515iPYhrbSPRhebfcbXtEFWdBR5IBaIv+NOpuN5UCGggbS2K8Ih+F10+HzGG
 E17SNF9asLWZegGDQ2n8iZtYShbvLmfXVGBRsicedv22oMlzBGbucW06ikZLC4jdiy0GD
 sm4zIfQnk1Jf2ZRPUV+8olwEYeeTp2dm3/M=

--6PjqgATjVE26KqINZhod

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit af48156ff3a1762989627fba7c56e77743fc0fdc upstream.

Enabling the frame buffer device on armadillo800eva requires the board
staging code.
Also enable the frame buffer, so you will actually see output during
boot.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
[Removed staging related configs]
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 9e48febd5956..f21de1bec37c 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -161,6 +161,7 @@ CONFIG_FB_SH_MOBILE_MERAM=y
 # CONFIG_BACKLIGHT_GENERIC is not set
 CONFIG_BACKLIGHT_PWM=y
 CONFIG_BACKLIGHT_AS3711=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
-- 
2.17.1


--6PjqgATjVE26KqINZhod
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5036): https://lists.cip-project.org/g/cip-dev/message=
/5036
Mute This Topic: https://lists.cip-project.org/mt/75842041/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--6PjqgATjVE26KqINZhod--
