Return-Path: <SRS0=x3T4=FF=lists.cip-project.org=bounce+64572+5917+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF7CC83011
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 08:39:52 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB29206D8
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 08:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="KYQuNEmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB29206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5917+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KMZRYY4521723xnXRWOVyNCc; Tue, 01 Dec 2020 00:39:49 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.7146.1606811983019624389
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Dec 2020 00:39:46 -0800
X-IronPort-AV: E=Sophos;i="5.78,383,1599490800"; 
   d="scan'208";a="64471863"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Dec 2020 17:39:46 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 096874256B62;
	Tue,  1 Dec 2020 17:39:44 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH v2 4.4.y-cip 04/11] ARM: dts: r8a7743: Add device node for PRR
Date: Tue,  1 Dec 2020 08:39:31 +0000
Message-Id: <20201201083938.32688-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201201083938.32688-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201201083938.32688-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7APqdCFdFNBhMtMWGSuUC7Zqx4520388AA=
Content-Type: multipart/mixed; boundary="j5V121ptCnggZFvYzbFW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606811989;
 bh=Xakfr78qUWR/fUnkA/dQz1it5XNgz7KN2b63f7vWzzA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=KYQuNEmra4ZNngcECn9lIA/khvY/NfBXKhXYo24XrYZgrTf33xArLWLrs6jsFDDASXa
 /zA0/YpLYuh4Ov3I7RpxRXYbM9wQF/R3pM7YbQiMxHHy6Qq4DHyt2GlxNyw4uZgemTGGy
 JzRYmAteCj96jNyJED+UZrbLgUyJ5ECyuGk=

--j5V121ptCnggZFvYzbFW

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 11d4407e939e74e89a29df88b1557b59ece9e9f9 upstream.

Add a device node for the Product Register, which provides SoC product
and revision information.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[PL: sorted the node]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index aff5ebbdb4bd..73b8f7f341f4 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -1781,6 +1781,11 @@
 			status = "disabled";
 		};
 
+		prr: chipid@ff000044 {
+			compatible = "renesas,prr";
+			reg = <0 0xff000044 0 4>;
+		};
+
 		cmt0: timer@ffca0000 {
 			compatible = "renesas,cmt-48-r8a7743",
 				     "renesas,cmt-48-gen2";
-- 
2.17.1


--j5V121ptCnggZFvYzbFW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5917): https://lists.cip-project.org/g/cip-dev/message=
/5917
Mute This Topic: https://lists.cip-project.org/mt/78628862/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--j5V121ptCnggZFvYzbFW--
