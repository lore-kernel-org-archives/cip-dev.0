Return-Path: <SRS0=Rouo=CM=lists.cip-project.org=bounce+64572+5390+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_NO_HEADERS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39258C433E9
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:27:24 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2E2F206EB
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="aer2hwOc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E2F206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5390+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cihyYY4521723x0elU8fIobS; Thu, 03 Sep 2020 07:27:23 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.15150.1599143242092612777
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 07:27:22 -0700
X-IronPort-AV: E=Sophos;i="5.76,387,1592838000"; 
   d="scan'208";a="56080643"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2020 23:27:21 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 953A140062CD;
	Thu,  3 Sep 2020 23:27:20 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 0/4] serial mctrl_gpio/sh-sci Fixes
Date: Thu,  3 Sep 2020 15:27:15 +0100
Message-Id: <20200903142719.13010-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Yz6vFA9bdnfDLgJltqH09b2Jx4520388AA=
Content-Type: multipart/mixed; boundary="ICfqCP8OEdgDrgYa97El"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599143243;
 bh=VyMMhOsDbT8A9cUVhVUIRklnWHhyMl2kt7ph6k2ZGf8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=aer2hwOcAABC6QfKmHR+YI28ZOdxYRr/IV3bGem3YOeaVotaWUEYIyaIYxyYh5Nj51s
 HjhtfnUcDdIk2ciSCFtR/Z69oszo5c8FOBtWEKOsoqwe4YNvvFNErcxTRCji1tcdNUF7V
 z+AADn8sEFlp+LeQqm+b+ni9Q3snh4W24TA=

--ICfqCP8OEdgDrgYa97El

Hi All,

This patch series adds minor fixes to sh-sci and serial_mctrl_gpio driver.
All patches in this series are cherry-picked from mainline.

Cheers,
Prabhakar


Frieder Schrempf (1):
  serial: sh-sci: Don't check for mctrl_gpio_init() returning -ENOSYS

Geert Uytterhoeven (2):
  serial: sh-sci: Terminate TX DMA during buffer flushing
  serial: sh-sci: Don't check for mctrl_gpio_to_gpiod() returning error

Stefan Roese (1):
  serial: mctrl_gpio: Check if GPIO property exisits before requesting
    it

 drivers/tty/serial/serial_mctrl_gpio.c | 15 +++++++++++++++
 drivers/tty/serial/sh-sci.c            | 25 +++++++++++++++----------
 2 files changed, 30 insertions(+), 10 deletions(-)

-- 
2.17.1


--ICfqCP8OEdgDrgYa97El
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5390): https://lists.cip-project.org/g/cip-dev/message=
/5390
Mute This Topic: https://lists.cip-project.org/mt/76607960/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ICfqCP8OEdgDrgYa97El--
