Return-Path: <SRS0=wDNP=B7=lists.cip-project.org=bounce+64572+5204+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C2DC433E3
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:45 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC8E20656
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PUEa++eK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC8E20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5204+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id VvZJYY4521723x63uktSg5p7; Fri, 21 Aug 2020 03:58:45 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.131155.1598003026037330255
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:43:57 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="55170349"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2020 18:43:56 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1E5094231AD9;
	Fri, 21 Aug 2020 18:43:54 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 22/36] pinctrl: sh-pfc: rcar-gen3: Retain TDSELCTRL register across suspend/resume
Date: Fri, 21 Aug 2020 10:42:58 +0100
Message-Id: <20200821094312.3249-23-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FsKiiseOCKoojnaZb5MgjTS9x4520388AA=
Content-Type: multipart/mixed; boundary="XyIju3GAxHz6yX1WiuPo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007525;
 bh=rVdqi8U00a26bvJzGaUg/2vazcr8w0KAyceaKn786vg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=PUEa++eKRqGx5+Opd08cTmF4BTj0NIk4h832LLzAJfNGzvdFwXcex2V64aK1g+8eW4U
 qZhpgQh0ZFB/T93R5O50JgVc5XbDveqSlXtSsRu6Nq5dR1dVFfRX+k4t1+hTi7FNVG8Sx
 efegwTqzEYW0Bj2c0oSTPRRj3cMCHbzyboo=

--XyIju3GAxHz6yX1WiuPo

From: Marek Vasut <marek.vasut+renesas@gmail.com>

commit d92ee9cf8ec8d7fe1d7dbc4b3ee459419b1e5533 upstream.

The TDSELCTRL register is responsible for configuring the SDHI/MMC clock
return path delay and may be adjusted by the bootloader. Retain the value
across suspend/resume to prevent hardware instability after resume.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[Biju: Removed R8A77970 and R8A77980 related changes]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c |  2 ++
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c     |  2 ++
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c    |  2 ++
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c    | 10 ++++++++++
 4 files changed, 16 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
index 897b7923074f..d92c979dfb98 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
@@ -5521,10 +5521,12 @@ static const struct pinmux_drive_reg pinmux_drive_regs[] = {
 
 enum ioctrl_regs {
 	POCCTRL,
+	TDSELCTRL,
 };
 
 static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
 	[POCCTRL] = { 0xe6060380, },
+	[TDSELCTRL] = { 0xe60603c0, },
 	{ /* sentinel */ },
 };
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 8edeb4d823f0..944dfd943541 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -5872,10 +5872,12 @@ static const struct pinmux_drive_reg pinmux_drive_regs[] = {
 
 enum ioctrl_regs {
 	POCCTRL,
+	TDSELCTRL,
 };
 
 static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
 	[POCCTRL] = { 0xe6060380, },
+	[TDSELCTRL] = { 0xe60603c0, },
 	{ /* sentinel */ },
 };
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
index 816341230c08..6616f5210b9d 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77965.c
@@ -6126,10 +6126,12 @@ static const struct pinmux_drive_reg pinmux_drive_regs[] = {
 
 enum ioctrl_regs {
 	POCCTRL,
+	TDSELCTRL,
 };
 
 static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
 	[POCCTRL] = { 0xe6060380, },
+	[TDSELCTRL] = { 0xe60603c0, },
 	{ /* sentinel */ },
 };
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
index 104ba4b51c9f..20b58e4602c9 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
@@ -2470,6 +2470,15 @@ static int r8a77995_pin_to_pocctrl(struct sh_pfc *pfc, unsigned int pin, u32 *po
 	return bit;
 }
 
+enum ioctrl_regs {
+	TDSELCTRL,
+};
+
+static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
+	[TDSELCTRL] = { 0xe60603c0, },
+	{ /* sentinel */ },
+};
+
 static const struct sh_pfc_soc_operations r8a77995_pinmux_ops = {
 	.pin_to_pocctrl = r8a77995_pin_to_pocctrl,
 };
@@ -2489,6 +2498,7 @@ const struct sh_pfc_soc_info r8a77995_pinmux_info = {
 	.nr_functions = ARRAY_SIZE(pinmux_functions),
 
 	.cfg_regs = pinmux_config_regs,
+	.ioctrl_regs = pinmux_ioctrl_regs,
 
 	.pinmux_data = pinmux_data,
 	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
-- 
2.17.1


--XyIju3GAxHz6yX1WiuPo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5204): https://lists.cip-project.org/g/cip-dev/message=
/5204
Mute This Topic: https://lists.cip-project.org/mt/76326744/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--XyIju3GAxHz6yX1WiuPo--
