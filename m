Return-Path: <SRS0=nf1V=GQ=lists.cip-project.org=bounce+64572+6071+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC275C433DB
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:01:08 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318B123406
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318B123406
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6071+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id c4tiYY4521723x1senWpzt8v; Wed, 13 Jan 2021 08:01:07 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.10260.1610553666209977940
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 08:01:06 -0800
X-IronPort-AV: E=Sophos;i="5.79,344,1602514800"; 
   d="scan'208";a="68678566"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jan 2021 01:01:04 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5B82E400C9EE;
	Thu, 14 Jan 2021 01:01:03 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 0/9] Renesas RZ/G1 add support for DU, TPU, PWM, LCD
Date: Wed, 13 Jan 2021 16:00:53 +0000
Message-Id: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GVFLbdWJEKhBnz43OpQMRAPEx4520388AA=
Content-Type: multipart/mixed; boundary="ZWc2bJK9KVmIad6YU64U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610553667;
 bh=RHZw/DOA4gc/MZKTluq6q6mIClXCvApDdMxkUR6twHA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=B4KtEZBr95KDVPPNQfP0tGycmNITPo57P71HuxbXn1pKY48lTiQLhWZUldn9hwzHlRB
 zq2tAIRAk9Vi4YmgALRkPFLT2KirAOjRUsmhfpeBbxuvivYxwhLAVbSy4HV6pN6GpLtpg
 QR8e0x8Gcvlrp9gzppQac2p7c6m1qUTWNNU=

--ZWc2bJK9KVmIad6YU64U
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi All,

This patch series adds support for TPU, PWM, DU to R8A7742 SoC and
enable LCD on iwg21d board.

All the patches have been cherry picked from v5.11-rc3.

Cheers,
Prabhakar

Biju Das (1):
  pinctrl: renesas: r8a7790: Optimize pinctrl image size for R8A7742

Lad Prabhakar (8):
  display: renesas,du: Document the r8a7742 bindings
  drm: rcar-du: Add r8a7742 support
  ARM: dts: r8a7742: Add DU support
  dt-bindings: pwm: renesas,tpu-pwm: Document r8a7742 support
  ARM: dts: r8a7742: Add TPU support
  dt-bindings: pwm: renesas,pwm-rcar: Add r8a7742 support
  ARM: dts: r8a7742: Add PWM SoC support
  ARM: dts: r8a7742-iwg21d-q7: Add LCD support

 .../bindings/display/renesas,du.txt           |   2 +
 .../bindings/pwm/renesas,pwm-rcar.txt         |   1 +
 .../bindings/pwm/renesas,tpu-pwm.txt          |   1 +
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts       |  73 ++++++++++++
 arch/arm/boot/dts/r8a7742.dtsi                | 112 ++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_drv.c         |  27 +++++
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c          |  14 +++
 7 files changed, 230 insertions(+)

-- 
2.17.1


--ZWc2bJK9KVmIad6YU64U
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6071): https://lists.cip-project.org/g/cip-dev/message=
/6071
Mute This Topic: https://lists.cip-project.org/mt/79653996/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ZWc2bJK9KVmIad6YU64U--
