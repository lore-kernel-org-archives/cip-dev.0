Return-Path: <SRS0=s0aW=EZ=lists.cip-project.org=bounce+64572+5809+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1492C2D0E4
	for <cip-dev@archiver.kernel.org>; Thu, 19 Nov 2020 04:57:34 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32BD3246E8
	for <cip-dev@archiver.kernel.org>; Thu, 19 Nov 2020 04:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="c1cIzJcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BD3246E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5809+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Xm0gYY4521723xVqgJ4jzdrL; Wed, 18 Nov 2020 20:57:32 -0800
X-Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web12.4906.1605761851431850782
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2020 20:57:31 -0800
X-Received: by mail-lf1-f49.google.com with SMTP id r9so6346502lfn.11
        for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2020 20:57:31 -0800 (PST)
X-Gm-Message-State: TYk704j9a5hmT9pE1vszhETQx4520388AA=
X-Google-Smtp-Source: ABdhPJxwOj4m2FP6Z5ZH+MdUFSKMHLFgkVLE2blpJxdKE0Z7jCgYnHXr+Vw2JobwVvme0cEVgoMcEQ==
X-Received: by 2002:a19:5c8:: with SMTP id 191mr4851466lff.111.1605761849216;
        Wed, 18 Nov 2020 20:57:29 -0800 (PST)
X-Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id w28sm3821630lfk.202.2020.11.18.20.57.28
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 20:57:28 -0800 (PST)
X-Received: by mail-lf1-f43.google.com with SMTP id e139so6410916lfd.1
        for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2020 20:57:28 -0800 (PST)
X-Received: by 2002:a19:8605:: with SMTP id i5mr5312505lfd.356.1605761848597;
 Wed, 18 Nov 2020 20:57:28 -0800 (PST)
MIME-Version: 1.0
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 19 Nov 2020 12:57:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v64b_90=ZdHamu5Sf-iQp8_2J5TPxYhzdXGp8Rk_LBxvVw@mail.gmail.com>
Message-ID: <CAGb2v64b_90=ZdHamu5Sf-iQp8_2J5TPxYhzdXGp8Rk_LBxvVw@mail.gmail.com>
Subject: [cip-dev] cip-kernel-sec Updates for Week of 2020-11-19
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="PmJEs0wBiS1GSQezq21W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605761852;
 bh=7UdH9Y+a5td6tC/adtrPQKZH68g7IHXLDhWt3YDvHT8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=c1cIzJcGnh5Ag8Q9zFxkT+s5WDcmptjpdyDsqNkvb6m4XZXSGtf4tcnvLydtId/gq2M
 IqdFG2s2cURS3BoG6aTqQUjCC63xRryEzb6/JZWt5asgWiBRmxrZTk3D2KJnrqgW4qWzV
 4UpnxPDBRsN07MQuMLkkfWJbVkj4SATuBfc=

--PmJEs0wBiS1GSQezq21W
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

This week we have two new issues:

- CVE-2020-12912 [hwmon/amd_energy] - Fixed in relevant stable kernels

  This driver was introduced in v5.8, so no members actually use it.

- CVE-2020-25705 [icmp global rate limiter / saddns] - Fixed in all
stable kernels


In addition, the sunkbd issue from last week is now fixed in mainline.
Looks like it hasn't been selected for stable yet.

Regards
ChenYu

--PmJEs0wBiS1GSQezq21W
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5809): https://lists.cip-project.org/g/cip-dev/message=
/5809
Mute This Topic: https://lists.cip-project.org/mt/78358851/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--PmJEs0wBiS1GSQezq21W--
