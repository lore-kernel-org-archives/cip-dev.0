Return-Path: <SRS0=AVYw=BO=lists.cip-project.org=bounce+64572+5088+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7843C433E1
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 04:47:38 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C092177B
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 04:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="QOEGyNz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C092177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5088+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KaJ1YY4521723xUhVT9ir26K; Mon, 03 Aug 2020 21:47:38 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.12722.1596516455852485940
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Aug 2020 21:47:37 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 0744lXv9007479; Tue, 4 Aug 2020 13:47:33 +0900
X-Iguazu-Qid: 2wGrCcip2906sndq2c
X-Iguazu-QSIG: v=2; s=0; t=1596516452; q=2wGrCcip2906sndq2c; m=A4wryJ8lktH0a3LHw8bDEeUXwjjbjApqBGV7lUrUNPk=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1112) id 0744lVRB003096;
	Tue, 4 Aug 2020 13:47:32 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 0744lVqk001754;
	Tue, 4 Aug 2020 13:47:31 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 0744lVdk026285;
	Tue, 4 Aug 2020 13:47:31 +0900
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com
Subject: [cip-dev] [isar-cip-core] remove remaining configs from isar-cip-core
Date: Tue,  4 Aug 2020 13:47:23 +0900
X-TSB-HOP: ON
Message-Id: <20200804044724.629026-1-daniel.sangorrin@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fjwIpJwK1mb51KYPCaLsHjXjx4520388AA=
Content-Type: multipart/mixed; boundary="iHoaFG24EyIhpNT7LNrw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596516458;
 bh=MXLh6eZf8gMtXu7FFnHpVdEy+VcC+C4GJ8A1ZffA4e0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=QOEGyNz06UGOH/sLUJrdv5meFZ9eckC0GgkPXKAKN2qTEpriNVMu287HWbHDVrHiWCy
 w+JOFqigh3HtA5aoE88l4knzWEpz9NZBx2PycXI4JVG5SHeuOsFHAT0FgZ/GdFjHErlp8
 dzojjqXgOrfsZzeqU98OyZ2MKVdB/Ll0ADU=

--iHoaFG24EyIhpNT7LNrw
Content-Transfer-Encoding: 8bit

Hi Jan,

This patch just removes the already unused defconfigs from isar-cip-core

[isar-cip-core] kernel: remove configs that are already in

I didn't know what to do with bbb_defconfig because it does not seem to
be used at all by isar-cip-core (maybe it is in a rather obscure way).
However, that should also be removed and use cip_bbb_defconfig.

Thanks,
Daniel


--iHoaFG24EyIhpNT7LNrw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5088): https://lists.cip-project.org/g/cip-dev/message=
/5088
Mute This Topic: https://lists.cip-project.org/mt/75981585/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--iHoaFG24EyIhpNT7LNrw--
