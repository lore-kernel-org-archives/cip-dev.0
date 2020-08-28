Return-Path: <SRS0=pp/c=CG=lists.cip-project.org=bounce+64572+5300+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7654DC2BC11
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:47 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B6B20872
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="pZb8FNrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B6B20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5300+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ymxMYY4521723x6bRT9wX5IQ; Fri, 28 Aug 2020 09:07:47 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.45844.1598629340391480166
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:20 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55804720"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:19 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3B343400C4F0;
	Sat, 29 Aug 2020 00:42:17 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 10/30] soc: renesas: Add Renesas R8A7742 config option
Date: Fri, 28 Aug 2020 16:41:35 +0100
Message-Id: <20200828154155.5827-11-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: JBzBlLBieMGHhbMuUQ2XPy73x4520388AA=
Content-Type: multipart/mixed; boundary="eCdBje32yhItSJlh8qO1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630867;
 bh=YXSf+dJjF/2/vXSNK7eP34sTsL7InTiHNhniaoDmNQs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=pZb8FNrCHDNHpnh3iMmROcTYWvlfztXF2QsUZQ5n9unAwWBa5S+KicgIjdALR8aig05
 ZBegLdDS43iw71oZ8Gp971pVU8KV5qkyswLkPgmBlh1Q93CkzJnSVaoTahw2g/k1uWR7n
 El9b77nlU/++bMeJn8mbdbbxs+BkzgtjHfA=

--eCdBje32yhItSJlh8qO1

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit cdc8abe763c99a6c2b854d7096eaf1ea21017a42 upstream.

Add configuration option for the RZ/G1H (R8A77420) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1588197415-13747-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: Moved config option from soc/renesas/Kconfig to here]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/mach-shmobile/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 79b66a1ce96b..a51df53f0914 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -64,6 +64,11 @@ config ARCH_R8A7740
 	select ARCH_RMOBILE
 	select RENESAS_INTC_IRQPIN
 
+config ARCH_R8A7742
+	bool "RZ/G1H (R8A77420)"
+	select ARCH_RCAR_GEN2
+	select ARM_ERRATA_798181 if SMP
+
 config ARCH_R8A7743
 	bool "RZ/G1M (R8A77430)"
 	select ARCH_RCAR_GEN2
-- 
2.17.1


--eCdBje32yhItSJlh8qO1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5300): https://lists.cip-project.org/g/cip-dev/message=
/5300
Mute This Topic: https://lists.cip-project.org/mt/76477083/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--eCdBje32yhItSJlh8qO1--
