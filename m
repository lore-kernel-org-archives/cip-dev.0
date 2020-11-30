Return-Path: <SRS0=FhYo=FE=lists.cip-project.org=bounce+64572+5890+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8755AC83012
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 14:19:30 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC81A20855
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 14:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="NfnX0Lcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC81A20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5890+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id WVwLYY4521723x3EftrtpXzv; Mon, 30 Nov 2020 06:19:29 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.60534.1606745960970067062
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Nov 2020 06:19:21 -0800
X-IronPort-AV: E=Sophos;i="5.78,381,1599490800"; 
   d="scan'208";a="64366332"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Nov 2020 23:19:18 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D5B124A31DA3;
	Mon, 30 Nov 2020 23:19:17 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 00/11] Renesas RZ/G1x add SoC detection support
Date: Mon, 30 Nov 2020 14:19:05 +0000
Message-Id: <20201130141916.8211-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: btNZFemZRruejY8JkFeYbvB0x4520388AA=
Content-Type: multipart/mixed; boundary="Rzjp0Me1DNYm98faiAI5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606745969;
 bh=m4YzRr7oy0Q0xEW9kjTslqxoL+xMpmIXiwDW7qlTNcI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=NfnX0Lcj1tpi426U7I1+tHlHWiZUX7+DCmDMRYX3OjhGBmKRDoHTGnToRKFDubtG86b
 wknqYSh+I3NEOhDtT2I9iY8EuqGqULo9T04hGE+RPJ/ecQo5iZ1LVeQC4SSO3xNbWe1ZJ
 k54T4zKDE6/LiWL+5y8eX0Ay7N0Of2rmFpo=

--Rzjp0Me1DNYm98faiAI5

Hi All,

This patch series adds SoC detection support for Renesas RZ/G1x SoC's.

All the patches apart from {7, 9, 11}/11 have been cherry picked from
Linux v5.10-rc6

Cheers,
Prabhakar

Biju Das (1):
  soc: renesas: Identify RZ/G1C

Geert Uytterhoeven (6):
  base: soc: Early register bus when needed
  soc: renesas: Identify SoC and register with the SoC bus
  ARM: dts: r8a7743: Add device node for PRR
  ARM: dts: r8a7745: Add device node for PRR
  soc: renesas: Identify RZ/G1N
  soc: renesas: Identify RZ/G1H

Lad Prabhakar (3):
  ARM: dts: r8a7744: Add device node for PRR
  ARM: dts: r8a7742: Add device node for PRR
  ARM: dts: r8a77470: Add device node for PRR

Simon Horman (1):
  dt-bindings: arm: renesas: Convert 'renesas,prr' to json-schema

 .../devicetree/bindings/arm/renesas,prr.yaml  |  37 +++++
 arch/arm/boot/dts/r8a7742.dtsi                |   5 +
 arch/arm/boot/dts/r8a7743.dtsi                |   5 +
 arch/arm/boot/dts/r8a7744.dtsi                |   5 +
 arch/arm/boot/dts/r8a7745.dtsi                |   5 +
 arch/arm/boot/dts/r8a77470.dtsi               |   5 +
 arch/arm/mach-shmobile/Kconfig                |   5 +
 drivers/base/soc.c                            |   9 ++
 drivers/soc/renesas/Makefile                  |   2 +
 drivers/soc/renesas/renesas-soc.c             | 147 ++++++++++++++++++
 10 files changed, 225 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/renesas,prr.yaml
 create mode 100644 drivers/soc/renesas/renesas-soc.c

-- 
2.17.1


--Rzjp0Me1DNYm98faiAI5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5890): https://lists.cip-project.org/g/cip-dev/message=
/5890
Mute This Topic: https://lists.cip-project.org/mt/78608799/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Rzjp0Me1DNYm98faiAI5--
