Return-Path: <SRS0=FWcM=CG=lists.cip-project.org=bounce+64572+5299+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27216C2BBD9
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:47 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF54B208C9
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="pfOJQvUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF54B208C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5299+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2mTnYY4521723xRl8EfuRNl5; Fri, 28 Aug 2020 09:07:46 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.45837.1598629320009468924
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:18 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55587855"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:17 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9D061400C4F0;
	Sat, 29 Aug 2020 00:42:15 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 09/30] ARM: shmobile: r8a7742: Basic SoC support
Date: Fri, 28 Aug 2020 16:41:34 +0100
Message-Id: <20200828154155.5827-10-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sZphGyRu8WN0WpNjTNW3VTypx4520388AA=
Content-Type: multipart/mixed; boundary="wY9hlFUUYMBXJg59lYSR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630866;
 bh=Z2TJMSQgAzIv+o5zuEp8IaWwKGiq8skjMgcbHVdZCMQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=pfOJQvUrDiziOQ0vNOsKeJpP/cm/Nnz17Y0J5BZmioAIFc3AakPXLjxu3qKphuN9WY5
 UFMi3sikevbCEoMLAFCP5fUE9PakNZUytMVPnZv5W0vDANSpNlGP0KXt0T7VefRmyZnkW
 xRudq0l1CURiD1DiVzA355ael8XehmwYVjk=

--wY9hlFUUYMBXJg59lYSR

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 135e7a156ae2c1a7a1f0c1d44bf2b3daece04bbf upstream.

Add minimal support for the RZ/G1H (R8A7742) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1587678050-23468-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: removed compatible string renesas,r8a7742-cpg-mssr, added config option for rz/g1h]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/mach-shmobile/pm-rcar-gen2.c    | 2 ++
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index dd1c9e08f3ea..c0c52458d9c9 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -97,6 +97,8 @@ void __init rcar_gen2_pm_init(void)
 		syscier = 0x013111ef;
 	else if (of_machine_is_compatible("renesas,r8a7791"))
 		syscier = 0x00111003;
+	else if (of_machine_is_compatible("renesas,r8a7742"))
+		syscier = 0x013111ef;
 	else if (of_machine_is_compatible("renesas,r8a7743"))
 		syscier = 0x00101003;
 	else if (of_machine_is_compatible("renesas,r8a7744"))
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 50c57c8c4f40..bd9985459651 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -207,6 +207,7 @@ DT_MACHINE_START(RCAR_GEN2_DT, "Generic R-Car Gen2 (Flattened Device Tree)")
 MACHINE_END
 
 static const char * const rz_g1_boards_compat_dt[] __initconst = {
+	"renesas,r8a7742",
 	"renesas,r8a7743",
 	"renesas,r8a7744",
 	"renesas,r8a7745",
-- 
2.17.1


--wY9hlFUUYMBXJg59lYSR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5299): https://lists.cip-project.org/g/cip-dev/message=
/5299
Mute This Topic: https://lists.cip-project.org/mt/76477082/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--wY9hlFUUYMBXJg59lYSR--
