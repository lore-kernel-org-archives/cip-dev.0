Return-Path: <SRS0=7eFv=BH=lists.cip-project.org=bounce+64572+5032+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4D8C433E4
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:28 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D37C206D7
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Or77beD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D37C206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5032+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IkUcYY4521723xgsS9sPcb04; Tue, 28 Jul 2020 04:52:28 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.9340.1595933015481872691
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2020 03:43:35 -0700
X-IronPort-AV: E=Sophos;i="5.75,406,1589209200"; 
   d="scan'208";a="53033304"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 28 Jul 2020 19:43:33 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.253])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0E43740062A4;
	Tue, 28 Jul 2020 19:43:31 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 0/9] Add LCD Panel support for RZ/G1E board
Date: Tue, 28 Jul 2020 11:43:21 +0100
Message-Id: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: lxgUJZTsUmoV5iyFn8JGdTPQx4520388AA=
Content-Type: multipart/mixed; boundary="Vyvk55zmvfNbweOLrIqJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595937148;
 bh=D1GbJGgxnWxR4SVW+EwGDp0VOESV408AL0cg5O4NSwI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Or77beD4Hbr7TKHbaSenqGR61AbGkdKVkvlDZSqavUIPI4aGiaFqi5fPZN0W6m38TSf
 xgBLsCjzkYSaTDXzvuYiWItveXJCMGcvfZKQorlBpeXsFLPjnH3TpsE1B8+gKDBV9OZhW
 wgefLr8U5Lanr/GqtQNOFOBZ2JeXo16KVZQ=

--Vyvk55zmvfNbweOLrIqJ

Add LCD Panel support for iWave RZ/G1E board based on r8a7745 SoC.

Backporting the panel patch as it is, requires drm bridge Api changes, 
which is not present at 4.4 kernel. So used the 4.4 rm framework to attach
the simple panel driver with rgb connector driver. The rgb connector is
based on the workdone for the lvds connector. The display panel binding
patch is backported to 4.4 kernel,since the mainline uses yaml file and
it conflict with corresponding .txt in 4.4 kernel.

Other patches in this series are cherry picked from mainline.


Biju Das (2):
  dt-bindings: display: Add bindings for EDT panel
  drm: rcar-du: Support panels connected directly to the DPAD outputs

Eric Anholt (1):
  drm: Add an encoder and connector type enum for DPI.

Fabrizio Castro (1):
  ARM: shmobile: defconfig: Enable support for panels from EDT

Geert Uytterhoeven (1):
  ARM: shmobile: defconfig: Enable frame buffer console for
    armadillo800eva

Laurent Pinchart (1):
  drm: rcar-du: Use the DRM panel API

Marian-Cristian Rotariu (2):
  drm/panel: simple: Add EDT panel support
  ARM: dts: iwg22d-sodimm: Enable LCD panel

Rob Herring (1):
  of: add node name compare helper functions

 .../display/panel/edt,etm043080dh6gp.txt      |   9 ++
 .../dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts     |   6 +
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts   |  59 ++++++++++
 arch/arm/configs/shmobile_defconfig           |   3 +
 drivers/gpu/drm/drm_crtc.c                    |   2 +
 drivers/gpu/drm/panel/panel-simple.c          |  33 ++++++
 drivers/gpu/drm/rcar-du/Kconfig               |   1 +
 drivers/gpu/drm/rcar-du/Makefile              |   1 +
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c     |  36 ++++++
 drivers/gpu/drm/rcar-du/rcar_du_rgbcon.c      | 105 ++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_rgbcon.h      |  22 ++++
 drivers/of/base.c                             |  22 ++++
 include/linux/of.h                            |  13 +++
 include/uapi/drm/drm_mode.h                   |   2 +
 14 files changed, 314 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/edt,etm043080dh6gp.txt
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_rgbcon.c
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_rgbcon.h

-- 
2.17.1


--Vyvk55zmvfNbweOLrIqJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5032): https://lists.cip-project.org/g/cip-dev/message=
/5032
Mute This Topic: https://lists.cip-project.org/mt/75842037/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Vyvk55zmvfNbweOLrIqJ--
