Return-Path: <SRS0=pJQ3=CG=lists.cip-project.org=bounce+64572+5297+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A365BC433E2
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:45 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0DE5207DF
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ehfEzrrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0DE5207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5297+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jPe8YY4521723xzppeRfUi1r; Fri, 28 Aug 2020 09:07:44 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.45766.1598629333618283759
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:13 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55804707"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:13 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 73E78400C4F0;
	Sat, 29 Aug 2020 00:42:11 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 07/30] clk: shmobile: Document r8a7742 CPG DIV6 clock support
Date: Fri, 28 Aug 2020 16:41:32 +0100
Message-Id: <20200828154155.5827-8-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mySV3pqMT9xZJkMMjhobmRWox4520388AA=
Content-Type: multipart/mixed; boundary="yvoIYPoNtfVYGS7U0RHO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630864;
 bh=OhtvipTrgcBnMKSoqHT03rUxfJ1WWS13yavwxlON5bs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ehfEzrrXibhZv4endXQdJFrmHRChepkaBfuES9WXGRr3DGYbRf0FGUk/V+qz0WGRLhS
 kqjcBx0gCULRx1qF5djFOEZ15tddS1uaejUafsnhB9Qgr3xrqTFPDSTIFx2JEWDpyYlXC
 uVzCm5+thGH2w1Mp2sIJ13CfnMZLXwAJ99E=

--yvoIYPoNtfVYGS7U0RHO

Document r8a7742 CPG DIV6 clock support.

The clock driver architecture has changed quite dramatically
over time, there is nothing we can backport from mainline
for this, hence the new patch.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/clock/renesas,cpg-div6-clocks.txt        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
index 7b05affc93f1..c60b174e3350 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
@@ -9,6 +9,7 @@ Required Properties:
   - compatible: Must be one of the following
     - "renesas,r8a73a4-div6-clock" for R8A73A4 (R-Mobile APE6) DIV6 clocks
     - "renesas,r8a7740-div6-clock" for R8A7740 (R-Mobile A1) DIV6 clocks
+    - "renesas,r8a7742-div6-clock" for R8A7742 (RZ/G1H) DIV6 clocks
     - "renesas,r8a7743-div6-clock" for R8A7743 (RZ/G1M) DIV6 clocks
     - "renesas,r8a7744-div6-clock" for R8A7744 (RZ/G1N) DIV6 clocks
     - "renesas,r8a7745-div6-clock" for R8A7745 (RZ/G1E) DIV6 clocks
-- 
2.17.1


--yvoIYPoNtfVYGS7U0RHO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5297): https://lists.cip-project.org/g/cip-dev/message=
/5297
Mute This Topic: https://lists.cip-project.org/mt/76477080/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--yvoIYPoNtfVYGS7U0RHO--
