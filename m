Return-Path: <SRS0=VGi8=B5=lists.cip-project.org=bounce+64572+5141+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EB0C433E4
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 16:45:12 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA8A208DB
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 16:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dv5Lq2lZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA8A208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5141+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3AtqYY4521723xBDuOJHSVkN; Wed, 19 Aug 2020 09:45:12 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.91601.1597855005191174500
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Aug 2020 09:36:59 -0700
X-IronPort-AV: E=Sophos;i="5.76,332,1592838000"; 
   d="scan'208";a="54769746"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 Aug 2020 01:36:58 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.200])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 81F30400B9C0;
	Thu, 20 Aug 2020 01:36:57 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 12/12] arm64: dts: renesas: r8a774a1: Remove audio port node
Date: Wed, 19 Aug 2020 17:36:34 +0100
Message-Id: <20200819163634.5430-13-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
References: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 87wEKd7FzHWWA7SPegFWfwJWx4520388AA=
Content-Type: multipart/mixed; boundary="PQV5vIdaLqwveIcJdWJD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597855512;
 bh=Jvz6bth3dgeyJ2v+aTn9chEefewhWFheGaQX1r0KwJw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=dv5Lq2lZhl6SZ1ub83jN+TgFz5ym2zHDk+IFzzyexe0VzWgTFOq9iX4cGBOXdffiZJu
 ItUrKAxBqzQUO+Qr3hGNBPJ0QlFOMyAGgPuRLh5X6+cWHBC+nO/vmWdQARB6zad2DH6rE
 jozfUnhBi2Hoz7YoRj0N1+/A7eV5DU3CDU0=

--PQV5vIdaLqwveIcJdWJD

From: Biju Das <biju.das@bp.renesas.com>

commit a381325812691f57aece60aaee76938ac8fc6619 upstream.

This patch removes audio port node from SoC device tree and
fixes the below dtb warning

Warning (unit_address_vs_reg): /soc/sound@ec500000/ports/port@0: node has a unit name, but no reg property

Fixes: e2f04248fcd4 ("arm64: dts: renesas: r8a774a1: Add audio support")
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Link: https://lore.kernel.org/r/1570200761-884-1-git-send-email-biju.das@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(Dropped hihope-common.dtsi changes as they have been already merged)
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 86ad9b34810f..e299343697c6 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -1813,17 +1813,6 @@
 					dma-names = "rx", "tx";
 				};
 			};
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				port@0 {
-					reg = <0>;
-				};
-				port@1 {
-					reg = <1>;
-				};
-			};
 		};
 
 		audma0: dma-controller@ec700000 {
-- 
2.17.1


--PQV5vIdaLqwveIcJdWJD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5141): https://lists.cip-project.org/g/cip-dev/message=
/5141
Mute This Topic: https://lists.cip-project.org/mt/76290770/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--PQV5vIdaLqwveIcJdWJD--
