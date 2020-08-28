Return-Path: <SRS0=f2kY=CG=lists.cip-project.org=bounce+64572+5295+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAD2C2BC0E
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:47 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE89208D5
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="tt5z1KfW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE89208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5295+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id F5RVYY4521723xaji4c3XDbP; Fri, 28 Aug 2020 09:07:46 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.45837.1598629320009468924
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:09 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55587840"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:08 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4CD12400D0D8;
	Sat, 29 Aug 2020 00:42:07 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 05/30] clk: shmobile: Document r8a7742 CPG clock support
Date: Fri, 28 Aug 2020 16:41:30 +0100
Message-Id: <20200828154155.5827-6-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fSQ9rB4gXr9niXZtBPLkYGWGx4520388AA=
Content-Type: multipart/mixed; boundary="Zt48oyzedaatPhI6A5hF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630866;
 bh=GaUvmKNoqWzprnK/Fv+QnUO78hh+NP+ytvny446DjqY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=tt5z1KfWZJXJgd7Qb0XTuPrENY5MtEcxh5NRwxC4krHQrSjjQMtDUc5T7TjS9KaGoZp
 ezcSC4q1le8BGwtCGAjpfnVjIbgp/G2V2kayWtmn8ysr+Wnv1ISrob7MuhvV542Ps5rKQ
 HbDfaoNlVz88CTWjW8YqzozaGB1j9ZUfl6M=

--Zt48oyzedaatPhI6A5hF

Document r8a7742 CPG clock support.

The clock driver architecture has changed quite dramatically
over time, there is nothing we can backport from mainline
for this, hence the new patch.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
index 631cd38792af..198d1da3f7a6 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
@@ -8,6 +8,7 @@ CPG Module Stop (MSTP) Clocks.
 Required Properties:
 
   - compatible: Must be one of
+    - "renesas,r8a7742-cpg-clocks" for the r8a7742 CPG
     - "renesas,r8a7743-cpg-clocks" for the r8a7743 CPG
     - "renesas,r8a7744-cpg-clocks" for the r8a7744 CPG
     - "renesas,r8a7745-cpg-clocks" for the r8a7745 CPG
-- 
2.17.1


--Zt48oyzedaatPhI6A5hF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5295): https://lists.cip-project.org/g/cip-dev/message=
/5295
Mute This Topic: https://lists.cip-project.org/mt/76477078/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Zt48oyzedaatPhI6A5hF--
