Return-Path: <SRS0=aLhZ=EE=lists.cip-project.org=bounce+64572+5687+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B20C4363A
	for <cip-dev@archiver.kernel.org>; Thu, 29 Oct 2020 02:42:26 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE5C2076A
	for <cip-dev@archiver.kernel.org>; Thu, 29 Oct 2020 02:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="RcsbGyPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE5C2076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5687+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id DCEWYY4521723xLzQqrknbsi; Wed, 28 Oct 2020 19:42:24 -0700
X-Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
 by mx.groups.io with SMTP id smtpd.web09.3132.1603939343809465468
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Oct 2020 19:42:24 -0700
X-Received: by mail-lj1-f182.google.com with SMTP id y16so1504310ljk.1
        for <cip-dev@lists.cip-project.org>; Wed, 28 Oct 2020 19:42:23 -0700 (PDT)
X-Gm-Message-State: VA3JcW5tvfE2YFogNtnTdpJxx4520388AA=
X-Google-Smtp-Source: ABdhPJyOepUkrOF2jQPvvnDX5GA8oBt9xv9TXmynDiVF1Xc2a90esK6FWAmWsvgpEeADh6EMefz7YQ==
X-Received: by 2002:a2e:9890:: with SMTP id b16mr804694ljj.295.1603939341351;
        Wed, 28 Oct 2020 19:42:21 -0700 (PDT)
X-Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id e14sm132412lfn.165.2020.10.28.19.42.21
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 19:42:21 -0700 (PDT)
X-Received: by mail-lf1-f45.google.com with SMTP id v6so1343226lfa.13
        for <cip-dev@lists.cip-project.org>; Wed, 28 Oct 2020 19:42:21 -0700 (PDT)
X-Received: by 2002:a19:ae13:: with SMTP id f19mr666950lfc.193.1603939340956;
 Wed, 28 Oct 2020 19:42:20 -0700 (PDT)
MIME-Version: 1.0
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 29 Oct 2020 10:42:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v65-9JX36eScv7_ZUo7Yx69cpb331qYrLaUTvda7H3cf6A@mail.gmail.com>
Message-ID: <CAGb2v65-9JX36eScv7_ZUo7Yx69cpb331qYrLaUTvda7H3cf6A@mail.gmail.com>
Subject: [cip-dev] cip-kernel-sec Updates for Last Week of October
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="foA0OqRsLzDSe2yVgHKy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603939344;
 bh=3660l7+jvIiH5yYd1ZdJle05G4ESylaIaKTYs5Lzy9Y=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=RcsbGyPfpOCVCUP4ebn9MTLx+gI8yDNdvCZG6hsbu5+XiaOYp9AzapkI1S0oU5tuvTa
 7VkxhMYmb/HQae/GoG8Yfk41WFysK9OksRDnEN/9nzNnwnLARpMPcNYKK7VMNge0/SvOw
 ouP/v4JBD3lqMsjdA4rWa6aOwcS2d++xluU=

--foA0OqRsLzDSe2yVgHKy
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Since there's no CIP weekly meeting this week, I'm sharing the details
on the mailing list. If people prefer this format, I can also do this
in the future. This could make up for the merge request which summarized
the information.

Here's this week's update:

New CVEs:
- CVE-2019-0146 [net/i40e] - likely fixed
- CVE-2020-27673 [xen/dom0] - fixed in mainline
- CVE-2020-27675 [xen/dom0] - fixed in mainline

Old CVEs now fixed:
- CVE-2020-14351 [perf] - fixed in mainline
- CVE-2020-27152 [KVM] - fixed in mainline

So we have yet another Intel i40e CVE that has a nearly useless
description.

For the rest, they are all fixed in v5.10-rc1.

- Fixes for CVE-2020-14351 and CVE-2020-27152 have been queued
  up for v5.8 and v5.9.

- Fix for CVE-2020-27675 has been queued up for v5.9

- Fix for CVE-2020-27673 has not been backported yet.


Regards
ChenYu
Moxa

--foA0OqRsLzDSe2yVgHKy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5687): https://lists.cip-project.org/g/cip-dev/message=
/5687
Mute This Topic: https://lists.cip-project.org/mt/77879900/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--foA0OqRsLzDSe2yVgHKy--
