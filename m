Return-Path: <SRS0=zcH4=B7=lists.cip-project.org=bounce+64572+5191+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560E6C433F7
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:36 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289F0207BB
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="E2nJpCp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289F0207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5191+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NxmSYY4521723xznd807P0Hi; Fri, 21 Aug 2020 03:58:36 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.131155.1598003026037330255
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:43:46 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="55170326"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2020 18:43:45 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1B5AF4232061;
	Fri, 21 Aug 2020 18:43:43 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 16/36] arm64: defconfig: Enable R8A774E1 SoC
Date: Fri, 21 Aug 2020 10:42:52 +0100
Message-Id: <20200821094312.3249-17-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ajVbuKyqA7Q5TRAd2PDQFyM4x4520388AA=
Content-Type: multipart/mixed; boundary="X64IBES7DEkB5WUKjI2h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007516;
 bh=JjpHSAE0VTEmw7wZDIN8lATIO2H/yV3R6m8nf65Tegc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=E2nJpCp6sqcRBJ1cWUlHd/Ok+kdGHCDeBCedqQ+rcS4KVhbnVd7sUhz4LIiYSkWa2jJ
 xJHKmXM5inXQi24huhHLXULh2N05pQ2llxm/6kAIbfuyuskQWQ30Oiisz9KEBIIXfiidc
 LWGavqcyYINmkY35gTRcI0ChOxqM+1lv+d4=

--X64IBES7DEkB5WUKjI2h

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit 7f8fe81eb75004dca73aa19127093977a3c8a154 upstream.

Enable the Renesas RZ/G2H (R8A774E1) SoC in the ARM64 defconfig.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/1594230511-24790-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 64a116b1e98d..ef20c1f308fa 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -53,6 +53,7 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_R8A774A1=y
 CONFIG_ARCH_R8A774B1=y
 CONFIG_ARCH_R8A774C0=y
+CONFIG_ARCH_R8A774E1=y
 CONFIG_ARCH_R8A7795=y
 CONFIG_ARCH_R8A7796=y
 CONFIG_ARCH_R8A77965=y
-- 
2.17.1


--X64IBES7DEkB5WUKjI2h
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5191): https://lists.cip-project.org/g/cip-dev/message=
/5191
Mute This Topic: https://lists.cip-project.org/mt/76326730/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--X64IBES7DEkB5WUKjI2h--
