Return-Path: <SRS0=t+sb=A7=lists.cip-project.org=bounce+64572+4939+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E5AC433E1
	for <cip-dev@archiver.kernel.org>; Mon, 20 Jul 2020 18:04:20 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FEB22B4E
	for <cip-dev@archiver.kernel.org>; Mon, 20 Jul 2020 18:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dgLBpg+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FEB22B4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4939+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LvKCYY4521723x6dmr96MNOF; Mon, 20 Jul 2020 11:04:19 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.1002.1595267771289416772
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Jul 2020 10:56:11 -0700
X-IronPort-AV: E=Sophos;i="5.75,375,1589209200"; 
   d="scan'208";a="52619180"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Jul 2020 02:56:10 +0900
X-Received: from be1yocto.ree.adwin.renesas.com (unknown [172.29.43.62])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2E42940031DF;
	Tue, 21 Jul 2020 02:56:09 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 2/2] arm64: defconfig: Enable additional support for Renesas platforms
Date: Mon, 20 Jul 2020 18:52:23 +0100
Message-Id: <1595267543-32854-2-git-send-email-biju.das.jz@bp.renesas.com>
In-Reply-To: <1595267543-32854-1-git-send-email-biju.das.jz@bp.renesas.com>
References: <1595267543-32854-1-git-send-email-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6rMCKmIzmNDuOtu5T2snTAdKx4520388AA=
Content-Type: multipart/mixed; boundary="WtVB2iyLsMSATyaHRRFO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595268259;
 bh=+y8y4lbzAFZQYt3VecaVceKLeDIa0+Eg1JbdFBiMAyc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=dgLBpg+zwYvH/WtRhtxwcc1ppmTepEF1pa+lvKTE4hoVo5Wgeo7xheDAHzL23KE/43y
 gy9OMFA3lNvsuRwN9UdSVlnwyofnSMUpkxFtBlYi6J7RyC646Am4cE5ciptw+zyAikF+m
 pLIqZ8YVjPrNdptLYThVrmYbZjGqMpTq7iE=

--WtVB2iyLsMSATyaHRRFO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit bf9e333ec0d54f7428d9192ad403c3cb523584c7 upstream

Increase build and test coverage by enabling support for more hardware
present on Renesas SoCs and boards:
  - R-Car CAN and CAN-FD controllers,
  - MSIOF SPI controllers,
  - ROHM BD9571 GPIO support,
  - R-Car MIPI CSI-2 receivers,
  - R-Car Video Input,
  - Renesas Fine Display Processors,
  - Renesas Digital Radio Interfaces,
  - R-Car Gen3 internal HDMI encoders,
  - Generic LVDS panel support,
  - Dumb VGA DAC Bridge support,
  - Thine THC63LVD1024 LVDS decoder bridges,
  - Synopsys Designware AHB Audio and CEC interfaces,
  - Renesas USBHS HCD support,
  - IDT VersaClock 5,6 devices,
  - Maxim max9611/max9612 ADCs,
  - ARM TrustZone CryptoCell security processors.

All of the above are modular, except for the VC5 clock driver, and the
SDR config gatekeepers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se> (VIN, CSI-2)
Link: https://lore.kernel.org/r/20200217103251.5205-1-geert+renesas@glider.be
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
[ Removed the following R-Car Specific configs
  - ROHM BD9571 GPIO support,
  - Renesas Digital Radio Interfaces,
  - Dumb VGA DAC Bridge support,
  - Thine THC63LVD1024 LVDS decoder bridges,
  - Maxim max9611/max9612 ADCs,
  - ARM TrustZone CryptoCell security processors.
  Added Synopsys Designware HDMI I2S interface
]
---
 arch/arm64/configs/defconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8ae8008..64a116b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -154,6 +154,9 @@ CONFIG_VLAN_8021Q=m
 CONFIG_VLAN_8021Q_GVRP=y
 CONFIG_VLAN_8021Q_MVRP=y
 CONFIG_BPF_JIT=y
+CONFIG_CAN=m
+CONFIG_CAN_RCAR=m
+CONFIG_CAN_RCAR_CANFD=m
 CONFIG_BT=m
 CONFIG_BT_HIDP=m
 # CONFIG_BT_HS is not set
@@ -329,6 +332,7 @@ CONFIG_SPI_PL022=y
 CONFIG_SPI_ROCKCHIP=y
 CONFIG_SPI_QUP=y
 CONFIG_SPI_S3C64XX=y
+CONFIG_SPI_SH_MSIOF=m
 CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
 CONFIG_PINCTRL_SINGLE=y
@@ -424,9 +428,12 @@ CONFIG_VIDEO_V4L2_SUBDEV_API=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
+CONFIG_VIDEO_RCAR_CSI2=m
+CONFIG_VIDEO_RCAR_VIN=m
 CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
 CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
 CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
+CONFIG_VIDEO_RENESAS_FDP1=m
 CONFIG_VIDEO_RENESAS_FCP=m
 CONFIG_VIDEO_RENESAS_VSP1=m
 CONFIG_DRM=m
@@ -446,10 +453,15 @@ CONFIG_ROCKCHIP_DW_HDMI=y
 CONFIG_ROCKCHIP_DW_MIPI_DSI=y
 CONFIG_ROCKCHIP_INNO_HDMI=y
 CONFIG_DRM_RCAR_DU=m
+CONFIG_DRM_RCAR_DW_HDMI=m
 CONFIG_DRM_RCAR_LVDS=m
 CONFIG_DRM_TEGRA=m
+CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_SIMPLE=m
 CONFIG_DRM_I2C_ADV7511=m
+CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
+CONFIG_DRM_DW_HDMI_I2S_AUDIO=m
+CONFIG_DRM_DW_HDMI_CEC=m
 CONFIG_DRM_VC4=m
 CONFIG_DRM_HISI_HIBMC=m
 CONFIG_DRM_HISI_KIRIN=m
@@ -493,6 +505,7 @@ CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_EXYNOS=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_RENESAS_USBHS_HCD=m
 CONFIG_USB_RENESAS_USBHS=m
 CONFIG_USB_STORAGE=y
 CONFIG_USB_MUSB_HDRC=y
@@ -584,6 +597,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_CLK_QORIQ=y
 CONFIG_COMMON_CLK_PWM=y
+CONFIG_COMMON_CLK_VC5=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_CLK_SMD_RPM=y
 CONFIG_IPQ_GCC_8074=y
-- 
2.7.4


--WtVB2iyLsMSATyaHRRFO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4939): https://lists.cip-project.org/g/cip-dev/message=
/4939
Mute This Topic: https://lists.cip-project.org/mt/75687531/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--WtVB2iyLsMSATyaHRRFO--
