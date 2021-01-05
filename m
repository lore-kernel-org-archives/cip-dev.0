Return-Path: <SRS0=rngk=GI=lists.cip-project.org=bounce+64572+6018+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EECC433E0
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 14:17:43 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9F122AAB
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 14:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9F122AAB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6018+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id idfBYY4521723xqrgDQanjBa; Tue, 05 Jan 2021 06:17:42 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.5744.1609856256841821527
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 06:17:37 -0800
X-IronPort-AV: E=Sophos;i="5.78,477,1599490800"; 
   d="scan'208";a="67869418"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Jan 2021 23:17:36 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5BA304005158;
	Tue,  5 Jan 2021 23:17:35 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 0/3] Add missing rpc-if clock on RZ/G2{E,M,N} SoC's
Date: Tue,  5 Jan 2021 14:17:31 +0000
Message-Id: <20210105141734.11528-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: f2qOauCSF9YLRWmtFBOf78bRx4520388AA=
Content-Type: multipart/mixed; boundary="kJMTCvYmvUxRbDG81TL6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609856262;
 bh=133yGwVuFRWVPhaAdd2a3f9dBRTTMZijXdzQWM8fdNs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=KqEt6aKuht+ey0iJ5jvRyUkqw3xMFQEPHKgygmgvqj11bRW3RS2C4DMAW+oZaoTO30o
 ES4FwfoXaM268jd9xjIN8Ky0KkLNBg1UuzGxs1AM9ZS4bU0ZwTTHAhZVFwllf/Za+CCVh
 5jQoatioJ5L1q2qKyobCjQifxz5IukgOOgk=

--kJMTCvYmvUxRbDG81TL6

Hi All,

This patch series adds missing rpc-if clock on RZ/G2{E,M,N} SoC's.

All the patches have been cherry picked from v5.11-rc2.

Cheers,
Prabhakar

Biju Das (2):
  clk: renesas: r8a774a1: Add RPC clocks
  clk: renesas: r8a774b1: Add RPC clocks

Lad Prabhakar (1):
  clk: renesas: r8a774c0: Add RPC clocks

 drivers/clk/renesas/r8a774a1-cpg-mssr.c |  8 +++++++
 drivers/clk/renesas/r8a774b1-cpg-mssr.c |  8 +++++++
 drivers/clk/renesas/r8a774c0-cpg-mssr.c |  9 ++++++++
 drivers/clk/renesas/rcar-gen3-cpg.c     | 28 +++++++++++++++++++++++++
 drivers/clk/renesas/rcar-gen3-cpg.h     |  5 +++++
 5 files changed, 58 insertions(+)

-- 
2.17.1


--kJMTCvYmvUxRbDG81TL6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6018): https://lists.cip-project.org/g/cip-dev/message=
/6018
Mute This Topic: https://lists.cip-project.org/mt/79450573/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--kJMTCvYmvUxRbDG81TL6--
