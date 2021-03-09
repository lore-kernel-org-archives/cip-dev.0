Return-Path: <SRS0=ipP9=IH=lists.cip-project.org=bounce+64572+6221+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74369C433E9
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:07 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD1F651BB
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD1F651BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6221+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id s9ONYY4521723x6Odp2FVFcK; Tue, 09 Mar 2021 08:37:06 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.11648.1615307826215431509
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:06 -0800
X-IronPort-AV: E=Sophos;i="5.81,234,1610377200"; 
   d="scan'208";a="74342191"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2021 01:36:59 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4E94840A2DBD;
	Wed, 10 Mar 2021 01:36:58 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 00/40] Renesas RZ/G2{E,H,M,N} add VIN, CSI2 support
Date: Tue,  9 Mar 2021 16:36:16 +0000
Message-Id: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: hDk5dv6xUemRntOZ8QqF7rSxx4520388AA=
Content-Type: multipart/mixed; boundary="wvCBqzVY4sZZFjyuLPz7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307826;
 bh=w+iO4ZtII+En2cPDwnMqS7UfJWwkT564bxiTvpDbfl0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=s9cAUsfdZTPyvH9Nv9+1o514dkrWoqPEut8JLuBPicRqwJOTAUnfRYgyNvSakqnULvE
 8r/qlbrKQmqjTIa3No+ddI/Th+Oix5bQME/tivNora9ugJLodhExTkUD1/EK99UnTEN0S
 xnJ/48KVDWGFjaXaBwQHzRrNCKdRgt3KNw4=

--wvCBqzVY4sZZFjyuLPz7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi All,

This patch series does the following:
* Drops unneeded regulator setup for OV5645 sensor
* Adds driver for IMX219 sensor
* Updates v4l2-async to accept endpoints for fwnode matching
* Various fixes for R-Car VIN driver
* Support to capture RAW format to VIN driver
* Support for RZ/G2{H,M,N,E} SoC's in VIN/CSI2 driver
* DTS changes for HiHope RZ/G2{H,M,N} and SI Linux RZ/G2E to
  enable VIN, CSI2 modules and OV5645, IMX219 sensors.

Cheers,
Prabhakar

Andrey Konovalov (1):
  media: dt-bindings: media: i2c: Add IMX219 CMOS sensor binding

Biju Das (10):
  media: dt-bindings: media: rcar_vin: Add r8a774a1 support
  media: rcar-vin: Enable support for r8a774a1
  media: dt-bindings: media: rcar-csi2: Add r8a774a1 support
  media: rcar-csi2: Enable support for r8a774a1
  arm64: dts: renesas: r8a774a1: Add VIN and CSI-2 nodes
  media: dt-bindings: rcar-vin: Add R8A774B1 support
  media: rcar-vin: Enable support for R8A774B1
  media: dt-bindings: rcar-csi2: Add R8A774B1 support
  media: rcar-csi2: Enable support for R8A774B1
  arm64: dts: renesas: r8a774b1: Add VIN and CSI-2 support

Dafna Hirschfeld (1):
  media: i2c: imx219: Fix a bug in imx219_enum_frame_size

Dave Stevenson (1):
  media: i2c: Add driver for Sony IMX219 sensor

Fabio Estevam (1):
  media: ov5645: Remove unneeded regulator_set_voltage()

Hans Verkuil (2):
  media: i2c: imx219: Selection compliance fixes
  media: i2c: imx219: take lock in imx219_enum_mbus_code/frame_size

Jacopo Mondi (1):
  media: i2c: imx219: Implement get_selection

Lad Prabhakar (16):
  media: rcar-vin: Invalidate pipeline if conversion is not possible on
    input formats
  media: rcar-vin: Add support for MEDIA_BUS_FMT_SRGGB8_1X8 format
  media: rcar-csi2: Add support for MEDIA_BUS_FMT_SRGGB8_1X8 format
  media: i2c: imx219: Fix power sequence
  media: i2c: imx219: Add support for RAW8 bit bayer format
  media: i2c: imx219: Add support for cropped 640x480 resolution
  arm64: dts: renesas: r8a774c0-cat874: Add support for AISTARVISION
    MIPI Adapter V2.1
  media: dt-bindings: media: renesas,vin: Add R8A774E1 support
  media: rcar-vin: Enable support for R8A774E1
  media: dt-bindings: media: renesas,csi2: Add R8A774E1 support
  media: rcar-csi2: Enable support for R8A774E1
  arm64: dts: renesas: r8a774e1: Add VIN and CSI-2 nodes
  arm64: dts: renesas: aistarvision-mipi-adapter-2.1: Add parent macro
    for each sensor
  arm64: dts: renesas: Add support for MIPI Adapter V2.1 connected to
    HiHope RZ/G2H
  arm64: dts: renesas: Add support for MIPI Adapter V2.1 connected to
    HiHope RZ/G2M
  arm64: dts: renesas: Add support for MIPI Adapter V2.1 connected to
    HiHope RZ/G2N

Laurent Pinchart (4):
  media: device property: Add a function to test is a fwnode is a graph
    endpoint
  media: v4l2-async: Accept endpoints and devices for fwnode matching
  media: v4l2-async: Pass notifier pointer to match functions
  media: v4l2-async: Log message in case of heterogeneous fwnode match

Niklas Söderlund (2):
  media: rcar-vin: fix wrong return value in rvin_set_channel_routing()
  media: rcar-csi2: Update V3M and E3 start procedure

Sakari Ailus (1):
  media: v4l: ctrl: Provide unlocked variant of v4l2_ctrl_grab

 .../devicetree/bindings/media/i2c/imx219.yaml |  114 ++
 .../devicetree/bindings/media/rcar_vin.txt    |    3 +
 .../bindings/media/renesas,rcar-csi2.txt      |    3 +
 MAINTAINERS                                   |    8 +
 arch/arm64/boot/dts/renesas/Makefile          |   10 +-
 .../aistarvision-mipi-adapter-2.1.dtsi        |   96 +
 ...rzg2-ex-aistarvision-mipi-adapter-2.1.dtsi |  109 ++
 .../r8a774a1-hihope-rzg2m-ex-mipi-2.1.dts     |   29 +
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi     |  367 ++++
 .../r8a774b1-hihope-rzg2n-ex-mipi-2.1.dts     |   16 +
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi     |  366 ++++
 .../dts/renesas/r8a774c0-ek874-mipi-2.1.dts   |   73 +
 .../r8a774e1-hihope-rzg2h-ex-mipi-2.1.dts     |   16 +
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi     |  334 ++++
 drivers/media/i2c/Kconfig                     |   11 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/imx219.c                    | 1582 +++++++++++++++++
 drivers/media/i2c/ov5645.c                    |   28 -
 drivers/media/platform/rcar-vin/rcar-core.c   |   49 +
 drivers/media/platform/rcar-vin/rcar-csi2.c   |   23 +-
 drivers/media/platform/rcar-vin/rcar-dma.c    |   17 +-
 drivers/media/platform/rcar-vin/rcar-v4l2.c   |    4 +
 drivers/media/v4l2-core/v4l2-async.c          |   83 +-
 drivers/media/v4l2-core/v4l2-ctrls.c          |    8 +-
 include/linux/property.h                      |    5 +
 include/media/v4l2-ctrls.h                    |   26 +-
 26 files changed, 3330 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/imx219.yaml
 create mode 100644 arch/arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/hihope-rzg2-ex-aistarvision-mipi-adapter-2.1.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-mipi-2.1.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-mipi-2.1.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0-ek874-mipi-2.1.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-mipi-2.1.dts
 create mode 100644 drivers/media/i2c/imx219.c

-- 
2.17.1


--wvCBqzVY4sZZFjyuLPz7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6221): https://lists.cip-project.org/g/cip-dev/message=
/6221
Mute This Topic: https://lists.cip-project.org/mt/81205345/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--wvCBqzVY4sZZFjyuLPz7--
