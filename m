Return-Path: <SRS0=dLyp=BB=lists.cip-project.org=bounce+64572+4960+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC6FC433E0
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:03 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C09207BB
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="IJsn/tDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C09207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4960+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jRbAYY4521723xlQ8WEarQyp; Wed, 22 Jul 2020 10:47:02 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.23008.1595435694445769823
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 09:34:54 -0700
X-IronPort-AV: E=Sophos;i="5.75,383,1589209200"; 
   d="scan'208";a="52832214"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Jul 2020 01:34:52 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E69A340078CA;
	Thu, 23 Jul 2020 01:34:50 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 00/17] Add RZ/G2E Dual LVDS display
Date: Wed, 22 Jul 2020 17:34:32 +0100
Message-Id: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mr5qUBfczoN0TyzKHu2BueZbx4520388AA=
Content-Type: multipart/mixed; boundary="3qRi0cIy8jxE6nzCHlUz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595440022;
 bh=0LksnXYA7oKTSrUPH3SUtWZyD3ol6M59dfWMtaSOGig=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=IJsn/tDQp8mbeow/0xSTlKyN6bklUGF6s0fcYmWxPj2GaHnUHtGnMD3UfdG/GYATL66
 qtdCK2kcP8DZ/Vi5HH3RKl/3sF9jj2dB+PnQMzhuPMp1uACh7HpKc3KS6wbkZ5Uzc7ARS
 4rS4FKiPL35zaqA4bHTWSBg+O+v51aYDSbI=

--3qRi0cIy8jxE6nzCHlUz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add RZ/G2E Dual LVDS display support. All patches in this series are 
cherry-picked from upstream kernel.

Fabrizio Castro (7):
  drm: rcar-du: lvds: Improve identification of panels
  drm: of: Add drm_of_lvds_get_dual_link_pixel_order
  drm: rcar-du: lvds: Get dual link configuration from DT
  drm: rcar-du: lvds: Allow for even and odd pixels swap
  arm64: dts: renesas: r8a774c0: Point LVDS0 to its companion LVDS1
  dt-bindings: display: Add idk-2121wr binding
  arm64: dts: renesas: Add EK874 board with idk-2121wr display support

Geert Uytterhoeven (1):
  arm64: dts: renesas: rzg2: Add reset control properties for display

Jacopo Mondi (1):
  drm: rcar_lvds: Fix dual link mode operations

Laurent Pinchart (7):
  drm: rcar-du: lvds: Remove LVDS double-enable checks
  drm: bridge: Add dual_link field to the drm_bridge_timings structure
  dt-bindings: display: renesas: lvds: Add renesas,companion property
  drm: rcar-du: lvds: Add support for dual-link mode
  drm: rcar-du: Skip LVDS1 output on Gen3 when using dual-link LVDS mode
  drm: Add drm_atomic_get_(old|new)_connector_for_encoder() helpers
  drm: rcar-du: lvds: Get mode from state

Sean Paul (1):
  drm: Add atomic variants for bridge enable/disable

 .../bindings/display/bridge/renesas,lvds.txt  |  18 +-
 .../display/panel/advantech,idk-2121wr.yaml   | 122 ++++++
 arch/arm64/boot/dts/renesas/Makefile          |   3 +-
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi     |   5 +-
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi     |   5 +-
 .../dts/renesas/r8a774c0-ek874-idk-2121wr.dts | 116 ++++++
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi     |   8 +-
 drivers/gpu/drm/drm_atomic.c                  | 113 ++++++
 drivers/gpu/drm/drm_atomic_helper.c           |   8 +-
 drivers/gpu/drm/drm_bridge.c                  | 110 ++++++
 drivers/gpu/drm/drm_of.c                      | 116 ++++++
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c     |  12 +
 drivers/gpu/drm/rcar-du/rcar_du_kms.c         |   2 +-
 drivers/gpu/drm/rcar-du/rcar_lvds.c           | 348 +++++++++++-------
 drivers/gpu/drm/rcar-du/rcar_lvds.h           |   5 +
 include/drm/drm_atomic.h                      |   7 +
 include/drm/drm_bridge.h                      | 114 ++++++
 include/drm/drm_connector.h                   |   9 +
 include/drm/drm_of.h                          |  20 +
 19 files changed, 996 insertions(+), 145 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0-ek874-idk-2121wr.dts

-- 
2.17.1


--3qRi0cIy8jxE6nzCHlUz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4960): https://lists.cip-project.org/g/cip-dev/message=
/4960
Mute This Topic: https://lists.cip-project.org/mt/75730020/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--3qRi0cIy8jxE6nzCHlUz--
