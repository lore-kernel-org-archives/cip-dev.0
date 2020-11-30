Return-Path: <SRS0=Cy7u=FE=lists.cip-project.org=bounce+64572+5897+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641DAC64E7B
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 14:19:31 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9ED2084C
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 14:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ExdxFjsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9ED2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5897+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ZEBkYY4521723x1ZQoF5eOrm; Mon, 30 Nov 2020 06:19:30 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.60324.1606745963854532164
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Nov 2020 06:19:29 -0800
X-IronPort-AV: E=Sophos;i="5.78,381,1599490800"; 
   d="scan'208";a="64149814"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 30 Nov 2020 23:19:28 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BD7E549708F6;
	Mon, 30 Nov 2020 23:19:27 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 07/11] ARM: dts: r8a7744: Add device node for PRR
Date: Mon, 30 Nov 2020 14:19:12 +0000
Message-Id: <20201130141916.8211-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201130141916.8211-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201130141916.8211-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NgOmYYsW5c9LfzUGbJoXSRg3x4520388AA=
Content-Type: multipart/mixed; boundary="EnAr1OFPyzPdtl97O8K1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606745970;
 bh=Zwb+ThoCbNaCCdwY3f3HdE3X7qkPjG3piKyRLfZ8+GM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ExdxFjsCGzmmtpDkh56hzEV8SwuPgOdH4fjBTsqKLFSsDiQ8kv4nrlnDnau7bm4Vcrq
 SWMiSEHC8g6xApy5qyfk/BlZtW+/qXduNh++gMM4T07zFtIB3YdLZvFXD7lh/rByPpZSj
 d0aAW+76dMMCHALhXbL1ot+VhzdWqETUKYc=

--EnAr1OFPyzPdtl97O8K1

Add a device node for the Product Register, which provides SoC product
and revision information.

Changes are already present in upstream but the PRR node is part of
initial SoC DTSI and cannot be individually backported hence this
new commit.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7744.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index 079f46f17049..312c9aae8a10 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -1526,6 +1526,11 @@
 			};
 		};
 
+		prr: chipid@ff000044 {
+			compatible = "renesas,prr";
+			reg = <0 0xff000044 0 4>;
+		};
+
 		cmt0: timer@ffca0000 {
 			compatible = "renesas,cmt-48-r8a7744",
 				     "renesas,cmt-48-gen2";
-- 
2.17.1


--EnAr1OFPyzPdtl97O8K1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5897): https://lists.cip-project.org/g/cip-dev/message=
/5897
Mute This Topic: https://lists.cip-project.org/mt/78608808/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--EnAr1OFPyzPdtl97O8K1--
