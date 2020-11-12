Return-Path: <SRS0=XThY=ES=lists.cip-project.org=bounce+64572+5796+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE77CC388F7
	for <cip-dev@archiver.kernel.org>; Thu, 12 Nov 2020 12:12:47 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA97207BB
	for <cip-dev@archiver.kernel.org>; Thu, 12 Nov 2020 12:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="uKQ6d+oF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA97207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5796+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id k9dRYY4521723xNSChQ0iOnK; Thu, 12 Nov 2020 04:12:46 -0800
X-Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web11.337.1605159193381729019
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2020 21:33:13 -0800
X-Received: by mail-lj1-f177.google.com with SMTP id x9so4672913ljc.7
        for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2020 21:33:13 -0800 (PST)
X-Gm-Message-State: UpiCcaBKfCbEcCrCl7nYkndUx4520388AA=
X-Google-Smtp-Source: ABdhPJxpfJMuMC5GQe4ki+/Z+t8ibiitgRw4Mn2MGcXiZpqPDmWLmPXb6QFh9gHZz+yqT57JNZXTsm0rqqum0/Ys76s=
X-Received: by 2002:a2e:3c1a:: with SMTP id j26mr192523lja.294.1605159190909;
 Wed, 11 Nov 2020 21:33:10 -0800 (PST)
MIME-Version: 1.0
From: Chen-Yu Tsai <wens213@gmail.com>
Date: Thu, 12 Nov 2020 13:33:00 +0800
Message-ID: <CAGb2v67BbNNDp9roG54HwiwigV8T2pJsiVtxV2eQiRbzezrBCQ@mail.gmail.com>
Subject: [cip-dev] cip-kernel-sec Updates for Week of 2020-11-12
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="rGaFUNTMBHfg4voiXiXT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605183166;
 bh=WDUyqE27dfuu6qdw/OeLUXC0KpUoRRUVGMDsOVMyF5E=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=uKQ6d+oFBJ3odOMhTkd1cDV2HORy0EmwG7xKaf671gp+G6o5tXlYLAxJo1zdQOy2Ljp
 h8fSb0ubizXFZ8mDOoifdSEGQWoPjX3qek1c24br3P+Ig429uXgeKv0I4Yhwf00ygnMS/
 Ym3ElEwSNe4rLI4HWDJLoDsYCG/gFCWz7+U=

--rGaFUNTMBHfg4voiXiXT
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

This week we have four new issues:

- CVE-2020-25669 [input/sunkbd UAF] - No fix yet.

  We can ignore this. This is ancient hardware.

  It's weird that Siemens enabled it in their v4.4 config, but not
their v4.19 one.
  I believe we can remove this from their v4.4 config as well.

- CVE-2020-25704 [perf memory leak] - Fix backported to 4.19+

  Based on the fixes tag, this was introduced in v4.7-rc1.

- CVE-2020-8694 [powercap non-root access] - Fixed for all stable kernels

- CVE-2020-slab-out-of-bounds-read-fbcon [fbcon out-of-bounds read] -
Fixed for all stable kernels

  Fix basically removes the broken KD_FONT_OP_SET ioctl.


Regards
ChenYu
Moxa

--rGaFUNTMBHfg4voiXiXT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5796): https://lists.cip-project.org/g/cip-dev/message=
/5796
Mute This Topic: https://lists.cip-project.org/mt/78204881/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--rGaFUNTMBHfg4voiXiXT--
