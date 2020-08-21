Return-Path: <SRS0=iRhD=B7=lists.cip-project.org=bounce+64572+5180+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886EAC433F1
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:35 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7C02078D
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="sAwQfyy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7C02078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5180+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KHDZYY4521723xAf7tnBRB3k; Fri, 21 Aug 2020 03:58:35 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.130425.1598002998984331784
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:43:19 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="55170273"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2020 18:43:18 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BE313423205B;
	Fri, 21 Aug 2020 18:43:16 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 01/36] dt-bindings: power: Add r8a774e1 SYSC power domain definitions
Date: Fri, 21 Aug 2020 10:42:37 +0100
Message-Id: <20200821094312.3249-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: K0rc92oJbM4rbZhavzTCdnNix4520388AA=
Content-Type: multipart/mixed; boundary="Sazw89YJkiG2YMAp6POA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007515;
 bh=zR71dt2Igq8yICgDdSQlIOFK66wLVRNxVsWm2W0lh8c=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=sAwQfyy6F/4cC7blftLSsmkVXPABX5fOG5xefesKOE4nsYmchQ9a0xS4m4AyYuvXE1O
 6VK6docKfUlL2bwUt5qDUzX+hOYV7sTPTPX4CpNU/rUJTwcG27hf4PXO3t+8YrbvswtAC
 eW92Lg6XnKcJZGpuKwFChlcl0CAh0psZYJQ=

--Sazw89YJkiG2YMAp6POA

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit e24779649c840ce1ecb638a30e7c821075630184 upstream.

This patch adds power domain indices for the RZ/G2H (r8a774e1) SoC.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/1594138692-16816-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 include/dt-bindings/power/r8a774e1-sysc.h | 36 +++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 include/dt-bindings/power/r8a774e1-sysc.h

diff --git a/include/dt-bindings/power/r8a774e1-sysc.h b/include/dt-bindings/power/r8a774e1-sysc.h
new file mode 100644
index 000000000000..7edb8161db36
--- /dev/null
+++ b/include/dt-bindings/power/r8a774e1-sysc.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_POWER_R8A774E1_SYSC_H__
+#define __DT_BINDINGS_POWER_R8A774E1_SYSC_H__
+
+/*
+ * These power domain indices match the numbers of the interrupt bits
+ * representing the power areas in the various Interrupt Registers
+ * (e.g. SYSCISR, Interrupt Status Register)
+ */
+
+#define R8A774E1_PD_CA57_CPU0		 0
+#define R8A774E1_PD_CA57_CPU1		 1
+#define R8A774E1_PD_CA57_CPU2		 2
+#define R8A774E1_PD_CA57_CPU3		 3
+#define R8A774E1_PD_CA53_CPU0		 5
+#define R8A774E1_PD_CA53_CPU1		 6
+#define R8A774E1_PD_CA53_CPU2		 7
+#define R8A774E1_PD_CA53_CPU3		 8
+#define R8A774E1_PD_A3VP		 9
+#define R8A774E1_PD_CA57_SCU		12
+#define R8A774E1_PD_A3VC		14
+#define R8A774E1_PD_3DG_A		17
+#define R8A774E1_PD_3DG_B		18
+#define R8A774E1_PD_3DG_C		19
+#define R8A774E1_PD_3DG_D		20
+#define R8A774E1_PD_CA53_SCU		21
+#define R8A774E1_PD_3DG_E		22
+#define R8A774E1_PD_A2VC1		26
+
+/* Always-on power area */
+#define R8A774E1_PD_ALWAYS_ON		32
+
+#endif /* __DT_BINDINGS_POWER_R8A774E1_SYSC_H__ */
-- 
2.17.1


--Sazw89YJkiG2YMAp6POA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5180): https://lists.cip-project.org/g/cip-dev/message=
/5180
Mute This Topic: https://lists.cip-project.org/mt/76326719/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Sazw89YJkiG2YMAp6POA--
