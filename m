Return-Path: <SRS0=r0wv=B7=lists.cip-project.org=bounce+64572+5190+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38158C433F8
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:36 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 075DD2078D
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PjynYefC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075DD2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5190+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uKPlYY4521723xQh9wovDWdD; Fri, 21 Aug 2020 03:58:35 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.130425.1598002998984331784
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:43:34 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="55170311"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2020 18:43:34 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1A5034231AD9;
	Fri, 21 Aug 2020 18:43:32 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 10/36] clk: renesas: Add r8a774e1 CPG Core Clock Definitions
Date: Fri, 21 Aug 2020 10:42:46 +0100
Message-Id: <20200821094312.3249-11-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fnSWEklem9T2C1F5ejHFFTlWx4520388AA=
Content-Type: multipart/mixed; boundary="nIPsblncqIkkup9f0eis"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007515;
 bh=CwzK2tYEKHgTeQmTBqCKTwd5tJxF/xtADSWMOS/tmFQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=PjynYefC40HC55BXvh65xMnSYHyG1Qbf7kDhDvUw6Zjl3qHnvIPZ5CiAAsNSwsvu5A7
 EqpAKjAkQzDJn0HEoJV6mzptn/R6H+rh1jlYMxLV99T9YqTiiq3H/MPueEiUN8NHE1i8y
 ZnA309xVo/RQHu3R0k20gy3uuTsJrDFB+Z4=

--nIPsblncqIkkup9f0eis

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit ef1c9924287d11660cfc7900aeeeb4732188743e upstream.

Add all RZ/G2H Clock Pulse Generator Core Clock Outputs, as listed in
Table 11.2 ("List of Clocks [RZ/G2H]") of the RZ/G2H Hardware User's
Manual.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/1594138692-16816-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 include/dt-bindings/clock/r8a774e1-cpg-mssr.h | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 include/dt-bindings/clock/r8a774e1-cpg-mssr.h

diff --git a/include/dt-bindings/clock/r8a774e1-cpg-mssr.h b/include/dt-bindings/clock/r8a774e1-cpg-mssr.h
new file mode 100644
index 000000000000..b2fc1d1c3c47
--- /dev/null
+++ b/include/dt-bindings/clock/r8a774e1-cpg-mssr.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_CLOCK_R8A774E1_CPG_MSSR_H__
+#define __DT_BINDINGS_CLOCK_R8A774E1_CPG_MSSR_H__
+
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+/* R8A774E1 CPG Core Clocks */
+#define R8A774E1_CLK_Z			0
+#define R8A774E1_CLK_Z2			1
+#define R8A774E1_CLK_ZG			2
+#define R8A774E1_CLK_ZTR		3
+#define R8A774E1_CLK_ZTRD2		4
+#define R8A774E1_CLK_ZT			5
+#define R8A774E1_CLK_ZX			6
+#define R8A774E1_CLK_S0D1		7
+#define R8A774E1_CLK_S0D2		8
+#define R8A774E1_CLK_S0D3		9
+#define R8A774E1_CLK_S0D4		10
+#define R8A774E1_CLK_S0D6		11
+#define R8A774E1_CLK_S0D8		12
+#define R8A774E1_CLK_S0D12		13
+#define R8A774E1_CLK_S1D2		14
+#define R8A774E1_CLK_S1D4		15
+#define R8A774E1_CLK_S2D1		16
+#define R8A774E1_CLK_S2D2		17
+#define R8A774E1_CLK_S2D4		18
+#define R8A774E1_CLK_S3D1		19
+#define R8A774E1_CLK_S3D2		20
+#define R8A774E1_CLK_S3D4		21
+#define R8A774E1_CLK_LB			22
+#define R8A774E1_CLK_CL			23
+#define R8A774E1_CLK_ZB3		24
+#define R8A774E1_CLK_ZB3D2		25
+#define R8A774E1_CLK_ZB3D4		26
+#define R8A774E1_CLK_CR			27
+#define R8A774E1_CLK_CRD2		28
+#define R8A774E1_CLK_SD0H		29
+#define R8A774E1_CLK_SD0		30
+#define R8A774E1_CLK_SD1H		31
+#define R8A774E1_CLK_SD1		32
+#define R8A774E1_CLK_SD2H		33
+#define R8A774E1_CLK_SD2		34
+#define R8A774E1_CLK_SD3H		35
+#define R8A774E1_CLK_SD3		36
+#define R8A774E1_CLK_RPC		37
+#define R8A774E1_CLK_RPCD2		38
+#define R8A774E1_CLK_MSO		39
+#define R8A774E1_CLK_HDMI		40
+#define R8A774E1_CLK_CSI0		41
+#define R8A774E1_CLK_CP			42
+#define R8A774E1_CLK_CPEX		43
+#define R8A774E1_CLK_R			44
+#define R8A774E1_CLK_OSC		45
+#define R8A774E1_CLK_CANFD		46
+
+#endif /* __DT_BINDINGS_CLOCK_R8A774E1_CPG_MSSR_H__ */
-- 
2.17.1


--nIPsblncqIkkup9f0eis
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5190): https://lists.cip-project.org/g/cip-dev/message=
/5190
Mute This Topic: https://lists.cip-project.org/mt/76326729/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--nIPsblncqIkkup9f0eis--
