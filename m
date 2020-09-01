Return-Path: <SRS0=yZyF=CK=lists.cip-project.org=bounce+64572+5359+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA3EC2D0A7
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 11:45:12 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B428620707
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 11:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="AgFifrLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B428620707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5359+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ONM9YY4521723xxUInzu4Lpo; Tue, 01 Sep 2020 04:45:12 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.11108.1598960491095779796
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Sep 2020 04:41:36 -0700
X-IronPort-AV: E=Sophos;i="5.76,378,1592838000"; 
   d="scan'208";a="55870271"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2020 20:41:36 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.50])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9363D400752B;
	Tue,  1 Sep 2020 20:41:34 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 10/10] ARM: dts: r8a7742: Add APMU nodes
Date: Tue,  1 Sep 2020 12:41:14 +0100
Message-Id: <20200901114114.3465-11-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200901114114.3465-1-biju.das.jz@bp.renesas.com>
References: <20200901114114.3465-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PoNsfqcfDJCm539YHbRK2RHdx4520388AA=
Content-Type: multipart/mixed; boundary="yNwiSPmsu1Emm4Ng01uy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598960712;
 bh=ruvdLiu4ggbF/dvFCM8XYbEuZ/zXmuOonbFTT1HqUZw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=AgFifrLy7kW7fMI8O4jOFaHirgHTYVRs9wE/Y3JZkvRL1w7X9teYR3OUu3JgPycAitj
 3/ZjGPHtFAQmLIt6TDi+8sqnGhmzHb2vtOAuvrXG4A2Gut2BeP/WXO7fOEQce08ElO6eI
 AliVGdXKn/4S0UB9+2w/Ljn+Srjq9+0HFS8=

--yNwiSPmsu1Emm4Ng01uy

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 57e7dad22bdb4bffa158d32a2e9d5b7145ab1e85 upstream.

Add DT nodes for the Advanced Power Management Units (APMU), and use the
enable-method to point out that the APMU should be used for SMP support.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/1589555337-5498-16-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742.dtsi b/arch/arm/boot/dts/r8a7742.dtsi
index 3f72658ba96d..1db3682a1deb 100644
--- a/arch/arm/boot/dts/r8a7742.dtsi
+++ b/arch/arm/boot/dts/r8a7742.dtsi
@@ -424,6 +424,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "renesas,apmu";
 
 		cpu0: cpu@0 {
 			device_type = "cpu";
@@ -695,6 +696,18 @@
 			reg = <0 0xe6060000 0 0x250>;
 		};
 
+		apmu@e6151000 {
+			compatible = "renesas,r8a7742-apmu", "renesas,apmu";
+			reg = <0 0xe6151000 0 0x188>;
+			cpus = <&cpu4 &cpu5 &cpu6 &cpu7>;
+		};
+
+		apmu@e6152000 {
+			compatible = "renesas,r8a7742-apmu", "renesas,apmu";
+			reg = <0 0xe6152000 0 0x188>;
+			cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
+		};
+
 		rst: reset-controller@e6160000 {
 			compatible = "renesas,r8a7742-rst";
 			reg = <0 0xe6160000 0 0x0100>;
-- 
2.17.1


--yNwiSPmsu1Emm4Ng01uy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5359): https://lists.cip-project.org/g/cip-dev/message=
/5359
Mute This Topic: https://lists.cip-project.org/mt/76554015/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--yNwiSPmsu1Emm4Ng01uy--
