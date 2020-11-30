Return-Path: <SRS0=rtBA=FE=lists.cip-project.org=bounce+64572+5895+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799B8C64E7B
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 14:19:28 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9394920870
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 14:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="mtrS74IK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9394920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5895+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KQR2YY4521723xG0uOoaPKFp; Mon, 30 Nov 2020 06:19:27 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.60324.1606745963854532164
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Nov 2020 06:19:26 -0800
X-IronPort-AV: E=Sophos;i="5.78,381,1599490800"; 
   d="scan'208";a="64149808"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 30 Nov 2020 23:19:25 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E78FD49708F6;
	Mon, 30 Nov 2020 23:19:24 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 05/11] ARM: dts: r8a7745: Add device node for PRR
Date: Mon, 30 Nov 2020 14:19:10 +0000
Message-Id: <20201130141916.8211-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201130141916.8211-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201130141916.8211-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XJlQoCDAA8UjPQc0xhMoXZqvx4520388AA=
Content-Type: multipart/mixed; boundary="hoS41EA3QeEeqOjsQtp9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606745967;
 bh=GEaHv6xbh8pki2pILfnZcoKpMBcoq7XryUmyO/6d3GA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=mtrS74IKENfWOwS6iB7+FhcjHW2c3w8LYmxh5jzXVq+rpU9QBGXW8w2RP6loQLfg8nG
 fXDCYM/e8A0orM++Y6iABN7IIJg3BnVblZapfKPxI9xt0dr/vZzhzdN3N1zP3LM31F6+m
 tQ7b+oldOosT8cTN3rxUX3DFacdQxw00F+8=

--hoS41EA3QeEeqOjsQtp9

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 8916c7b58319fa27eae25c0c9b9a4cd68b9b30bd upstream.

Add a device node for the Product Register, which provides SoC product
and revision information.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[PL: sorted the node as per address]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 5f603d9eafea..58bf2e52523e 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -1356,6 +1356,11 @@
 			};
 		};
 
+		prr: chipid@ff000044 {
+			compatible = "renesas,prr";
+			reg = <0 0xff000044 0 4>;
+		};
+
 		cmt0: timer@ffca0000 {
 			compatible = "renesas,cmt-48-r8a7745",
 				     "renesas,cmt-48-gen2";
-- 
2.17.1


--hoS41EA3QeEeqOjsQtp9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5895): https://lists.cip-project.org/g/cip-dev/message=
/5895
Mute This Topic: https://lists.cip-project.org/mt/78608806/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--hoS41EA3QeEeqOjsQtp9--
