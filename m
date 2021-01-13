Return-Path: <SRS0=l8wn=GQ=lists.cip-project.org=bounce+64572+6077+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B2DC433E0
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:01:14 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B365723406
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B365723406
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6077+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id JzxrYY4521723xIGbVxOei5d; Wed, 13 Jan 2021 08:01:13 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.10261.1610553672734300249
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 08:01:13 -0800
X-IronPort-AV: E=Sophos;i="5.79,344,1602514800"; 
   d="scan'208";a="68678587"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jan 2021 01:01:12 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2FD474009652;
	Thu, 14 Jan 2021 01:01:11 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 6/9] ARM: dts: r8a7742: Add TPU support
Date: Wed, 13 Jan 2021 16:00:59 +0000
Message-Id: <20210113160102.16310-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: F6GYPXmjryQo0JIIoqYnHFnQx4520388AA=
Content-Type: multipart/mixed; boundary="V5kT4QSFntmG46kQQQCL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610553673;
 bh=Mhffbm0GbbSaZ2VVvu+pYA7IcRPNXWJgCyXmyq4sYcY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Q0XONGP1yy/YQSJn1sMMyTDKoYcLjRavifZMUKqrpng229uwuqm1YQ9gC8NfFQyXsbD
 nmjCMw/jtcKmxe4rqTL+aRryuIheInvWDsUyLPTbG0Z5d8237fwIUdkMQOBq2lrQT+X5F
 A0nrvKBLIFrAJePgVVfGyxr1UKuQo63ebE8=

--V5kT4QSFntmG46kQQQCL

commit 02b24822953571d3ef83029e53bcd011d39dcb39 upstream.

Add TPU support to R8A7742 SoC DT.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/20200806183152.11809-6-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL:changed clocks and power-domain properties, removed resets property]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index d4087bacd6f2..755136f88b01 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -742,6 +742,16 @@
 			reg = <0 0xe6060000 0 0x250>;
 		};
 
+		tpu: pwm@e60f0000 {
+			compatible = "renesas,tpu-r8a7742", "renesas,tpu";
+			reg = <0 0xe60f0000 0 0x148>;
+			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7742_CLK_TPU0>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		apmu@e6151000 {
 			compatible = "renesas,r8a7742-apmu", "renesas,apmu";
 			reg = <0 0xe6151000 0 0x188>;
-- 
2.17.1


--V5kT4QSFntmG46kQQQCL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6077): https://lists.cip-project.org/g/cip-dev/message=
/6077
Mute This Topic: https://lists.cip-project.org/mt/79654004/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--V5kT4QSFntmG46kQQQCL--
