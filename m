Return-Path: <SRS0=hyYj=DH=lists.cip-project.org=bounce+64572+5481+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0921C4727C
	for <cip-dev@archiver.kernel.org>; Wed, 30 Sep 2020 02:10:24 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0547620B1F
	for <cip-dev@archiver.kernel.org>; Wed, 30 Sep 2020 02:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="s4jq2+14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0547620B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5481+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YBEfYY4521723x4m77ZBYxBW; Tue, 29 Sep 2020 19:10:23 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web12.6011.1601431820622451517
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Sep 2020 19:10:22 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 08U2AII2032442; Wed, 30 Sep 2020 11:10:18 +0900
X-Iguazu-Qid: 34trveODeX8bZIUl96
X-Iguazu-QSIG: v=2; s=0; t=1601431818; q=34trveODeX8bZIUl96; m=qkOKlGnN3pOiieSFJstHjXocEighSih0F3fyPPb9TxA=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1513) id 08U2AH2R011644;
	Wed, 30 Sep 2020 11:10:17 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 08U2AHhT024781;
	Wed, 30 Sep 2020 11:10:17 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 08U2AHnU023646;
	Wed, 30 Sep 2020 11:10:17 +0900
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: jan.kiszka@siemens.com
Cc: cip-dev@lists.cip-project.org
Subject: [cip-dev] [isar-cip-core] export dpkg status for debsecan
Date: Wed, 30 Sep 2020 11:08:14 +0900
X-TSB-HOP: ON
Message-Id: <20200930020815.2474349-1-daniel.sangorrin@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KFKWMnb7kCAdjSv04i4VBH6tx4520388AA=
Content-Type: multipart/mixed; boundary="e1jGNTmTmgVQduZiakQg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601431823;
 bh=4VpuT+UIudD+C8+KZRP+xXtDhA6ukjqh+uMRMJND4gU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=s4jq2+14MO+BVLIVZ0jyyjfyrwzxKyK6vJ9ALXeYdrZtKq/CCdQeRrh5rjv/QyE3Efh
 HiDqkDSjenLFnYpVFui0AICQwrliHlP51sKiv1V5AqfUOZ/KF3GbokjKGRT7JuqnYyLtw
 Yl2hnw8+gVJImX289JqqxsjNJMeeMp5+kTo=

--e1jGNTmTmgVQduZiakQg
Content-Transfer-Encoding: 8bit

Hi Jan,

This is a patch to isar-cip-core for exporting the dpkg 
status file which is needed by debsecan and its wrapper
cip-core-sec.

At the moment the code is duplicated for each image target.
I could use the trick of putting the code in customizations.bb
instead if you prefer, because currently it is imported from 
both image targets (cip-core-image.bb and cip-core-image-security.bb)

[isar-cip-core] image: export dpkg status file for debsecan

Thanks,
Daniel


--e1jGNTmTmgVQduZiakQg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5481): https://lists.cip-project.org/g/cip-dev/message=
/5481
Mute This Topic: https://lists.cip-project.org/mt/77210405/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--e1jGNTmTmgVQduZiakQg--
