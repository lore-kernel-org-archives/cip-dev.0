Return-Path: <SRS0=CBUB=EE=lists.cip-project.org=bounce+64572+5691+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29ACCC55178
	for <cip-dev@archiver.kernel.org>; Thu, 29 Oct 2020 11:46:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF7620780
	for <cip-dev@archiver.kernel.org>; Thu, 29 Oct 2020 11:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="v013LFHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF7620780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5691+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Zd4NYY4521723xnVqaT3tKfN; Thu, 29 Oct 2020 04:46:09 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.7488.1603971967890388148
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2020 04:46:08 -0700
X-IronPort-AV: E=Sophos;i="5.77,429,1596466800"; 
   d="scan'208";a="60945213"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 29 Oct 2020 20:46:07 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2759E42E288E;
	Thu, 29 Oct 2020 20:46:05 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 2/4] arm64: dts: renesas: r8a774b1: Add SATA controller node
Date: Thu, 29 Oct 2020 11:46:00 +0000
Message-Id: <20201029114602.9107-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201029114602.9107-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201029114602.9107-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5KvAjITTB5lwyFUUS085nTxvx4520388AA=
Content-Type: multipart/mixed; boundary="fPe64ts8AIXzRZQpQySM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603971969;
 bh=z0d18BZaUq3KEymJ+lBjyaIiJGXQRj/Lur5H/xq+eT4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=v013LFHGZ+WHU2+E1+XKDse/LwlUdMpzKAkrJqvusmUulsqiFojoPvkS3yCk60kQWsA
 +llu3NZaMHfw3jNraf1LMzD0d7ueFpaMIujqab2EPCziiQVxohwxSqXxCf9def+B1qLYT
 p8AxkzEtZpFdD9yr97IJuOj1OzhwSM4rtRg=

--fPe64ts8AIXzRZQpQySM

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 1510faee309010194ebb6ad3068cc9c0f7bc761b upstream.

Add the SATA controller node to the RZ/G2N SoC specific
dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Link: https://lore.kernel.org/r/1571761279-17347-3-git-send-email-fabrizio.castro@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
index 62d011107cc5..11cc0f274ef3 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
@@ -1902,6 +1902,17 @@
 			status = "disabled";
 		};
 
+		sata: sata@ee300000 {
+			compatible = "renesas,sata-r8a774b1",
+				     "renesas,rcar-gen3-sata";
+			reg = <0 0xee300000 0 0x200000>;
+			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 815>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			resets = <&cpg 815>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@f1010000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
2.17.1


--fPe64ts8AIXzRZQpQySM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5691): https://lists.cip-project.org/g/cip-dev/message=
/5691
Mute This Topic: https://lists.cip-project.org/mt/77885350/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--fPe64ts8AIXzRZQpQySM--
