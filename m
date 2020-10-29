Return-Path: <SRS0=jFP/=EE=lists.cip-project.org=bounce+64572+5692+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7C6C56202
	for <cip-dev@archiver.kernel.org>; Thu, 29 Oct 2020 11:46:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F93B20796
	for <cip-dev@archiver.kernel.org>; Thu, 29 Oct 2020 11:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="mz/aqTSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F93B20796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5692+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 69XZYY4521723xTHvzx8zNM2; Thu, 29 Oct 2020 04:46:09 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.7488.1603971967890388148
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2020 04:46:08 -0700
X-IronPort-AV: E=Sophos;i="5.77,429,1596466800"; 
   d="scan'208";a="60945217"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 29 Oct 2020 20:46:08 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7025B42E288A;
	Thu, 29 Oct 2020 20:46:07 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 3/4] arm64: dts: renesas: r8a774b1-hihope-rzg2n-ex: Enable sata
Date: Thu, 29 Oct 2020 11:46:01 +0000
Message-Id: <20201029114602.9107-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201029114602.9107-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201029114602.9107-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Bjy4MAeQ19CXIkMUJuv2FwOrx4520388AA=
Content-Type: multipart/mixed; boundary="puvXC7mDjJh8e3TfelbO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603971969;
 bh=FIAnINQfoyXifLodRTB5NbTGIYWER5SljQZm22K6BTQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=mz/aqTSMEjK/8sicPr0pyuHWTdZUfNse8y2Reo8OdeyhM/F1bMMD3UnXoNHiUlngCye
 ndSM4O79x3zRTt46iWBertqEjVqtF5c6bEVTsKf3HKONVvz3ct5O8oTjO4OLGYkb8QNkV
 /rYj+5LjcLBVbPE266ieFdp29/48Y716Wds=

--puvXC7mDjJh8e3TfelbO

commit e7cc614be7886b464a429f83162171128c205b2e upstream.

Enable sata interface on HiHope RZ/G2N board.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20200810171239.30401-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts b/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts
index a3edd55113df..60d7c8adea02 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts
@@ -14,3 +14,8 @@
 	compatible = "hoperun,hihope-rzg2-ex", "hoperun,hihope-rzg2n",
 		     "renesas,r8a774b1";
 };
+
+/* Set SW43 = ON and SW1001[7] = OFF for SATA port to be activated */
+&sata {
+	status = "okay";
+};
-- 
2.17.1


--puvXC7mDjJh8e3TfelbO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5692): https://lists.cip-project.org/g/cip-dev/message=
/5692
Mute This Topic: https://lists.cip-project.org/mt/77885351/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--puvXC7mDjJh8e3TfelbO--
