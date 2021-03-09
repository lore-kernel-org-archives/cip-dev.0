Return-Path: <SRS0=C/3+=IH=lists.cip-project.org=bounce+64572+6253+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F76C433E6
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:50 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC77464FF3
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC77464FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6253+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id gaQGYY4521723xp65zZEWjTy; Tue, 09 Mar 2021 08:37:49 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11727.1615307829143333394
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:49 -0800
X-IronPort-AV: E=Sophos;i="5.81,234,1610377200"; 
   d="scan'208";a="74342278"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:48 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AF38140A3D27;
	Wed, 10 Mar 2021 01:37:47 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 37/40] arm64: dts: renesas: aistarvision-mipi-adapter-2.1: Add parent macro for each sensor
Date: Tue,  9 Mar 2021 16:36:53 +0000
Message-Id: <20210309163656.20944-38-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: VPdFhutdRMna4nsE7juZd2xJx4520388AA=
Content-Type: multipart/mixed; boundary="mCo3ooqbXetb6vuCsFDk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307869;
 bh=U6U7L+cs+RjdD0GJSelDTSr1Ky1U9KmLxYPUE93FtPE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=O9ltZIpX+br48uXWJL75B/4tjnVOc0eRGwy13ibn1YkgZQlNcJ4w9W2FkVoZBTVq3Xu
 QEJDbf5Fy/ufYwrF0ooXdC1TkWQ6kmO5y3I+RLizIL1BMiK091Ho3mwYkckqbZpGv4poB
 MY27w2giF72Tg/UJgSzmDCvEoNhqWtIPY1g=

--mCo3ooqbXetb6vuCsFDk

commit 622007d172fbb1d7556329bafd72dc28c0baf1b8 upstream.

For HiHope RZ/G2H the OV5645 sensor is populated on i2c2 whereas the imx219
sensor is populated on i2c3 so add support for handling such cases by
adding a parent macro for each sensor.

Also update r8a774c0-ek874-mipi-2.1.dts to incorporate the changes.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20201020125134.22625-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi | 4 +++-
 arch/arm64/boot/dts/renesas/r8a774c0-ek874-mipi-2.1.dts       | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi b/arch/arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi
index dac6ff49020f..7ce986f0a06f 100644
--- a/arch/arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi
+++ b/arch/arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi
@@ -61,7 +61,7 @@
 	};
 };
 
-&MIPI_PARENT_I2C {
+&MIPI_OV5645_PARENT_I2C {
 	ov5645: ov5645@3c {
 		compatible = "ovti,ov5645";
 		reg = <0x3c>;
@@ -77,7 +77,9 @@
 			};
 		};
 	};
+};
 
+&MIPI_IMX219_PARENT_I2C {
 	imx219: imx219@10 {
 		compatible = "sony,imx219";
 		reg = <0x10>;
diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-ek874-mipi-2.1.dts b/arch/arm64/boot/dts/renesas/r8a774c0-ek874-mipi-2.1.dts
index f0829e905506..e7b4a929bb17 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0-ek874-mipi-2.1.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774c0-ek874-mipi-2.1.dts
@@ -8,7 +8,8 @@
 
 /dts-v1/;
 #include "r8a774c0-ek874.dts"
-#define MIPI_PARENT_I2C i2c3
+#define MIPI_OV5645_PARENT_I2C i2c3
+#define MIPI_IMX219_PARENT_I2C i2c3
 #include "aistarvision-mipi-adapter-2.1.dtsi"
 
 / {
-- 
2.17.1


--mCo3ooqbXetb6vuCsFDk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6253): https://lists.cip-project.org/g/cip-dev/message=
/6253
Mute This Topic: https://lists.cip-project.org/mt/81205396/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--mCo3ooqbXetb6vuCsFDk--
