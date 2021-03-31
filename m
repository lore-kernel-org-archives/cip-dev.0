Return-Path: <SRS0=07o0=I5=lists.cip-project.org=bounce+64572+6336+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575BBC433ED
	for <cip-dev@archiver.kernel.org>; Wed, 31 Mar 2021 17:27:26 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE3360FF2
	for <cip-dev@archiver.kernel.org>; Wed, 31 Mar 2021 17:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE3360FF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6336+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nL5FYY4521723xkdBVFUDLjX; Wed, 31 Mar 2021 10:27:25 -0700
X-Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web09.883.1617211644116012395
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Mar 2021 10:27:24 -0700
X-Received: by mail-lj1-f178.google.com with SMTP id f26so24779798ljp.8
        for <cip-dev@lists.cip-project.org>; Wed, 31 Mar 2021 10:27:23 -0700 (PDT)
X-Gm-Message-State: kOdyy4107dWZQWxhZX9zUXzEx4520388AA=
X-Google-Smtp-Source: ABdhPJzFczvqK2p4EfSOyTgRI1c1deEDHYHCNJM2LJO63ZarSQdOfCNEC/BUI+6kkDVrBdY+G9RcUQ==
X-Received: by 2002:a05:651c:212a:: with SMTP id a42mr2717482ljq.505.1617211642128;
        Wed, 31 Mar 2021 10:27:22 -0700 (PDT)
X-Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id r1sm304654ljn.71.2021.03.31.10.27.21
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 10:27:21 -0700 (PDT)
X-Received: by mail-lj1-f171.google.com with SMTP id u4so24821614ljo.6
        for <cip-dev@lists.cip-project.org>; Wed, 31 Mar 2021 10:27:21 -0700 (PDT)
X-Received: by 2002:a2e:7d04:: with SMTP id y4mr2888425ljc.94.1617211641525;
 Wed, 31 Mar 2021 10:27:21 -0700 (PDT)
MIME-Version: 1.0
Reply-To: cip-dev@lists.cip-project.org
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 1 Apr 2021 01:27:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v65SkZpyGfFGF51NSDjWj=rH1m8eddYy7gy4y+RA5j8nWQ@mail.gmail.com>
Message-ID: <CAGb2v65SkZpyGfFGF51NSDjWj=rH1m8eddYy7gy4y+RA5j8nWQ@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2021-04-01
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Content-Type: multipart/mixed; boundary="biMCX1XSrjDH6dT40foN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1617211645;
 bh=Pq7Sdz/dInnj11mk58lPv/XSWzT3jE0ktVh0n0njOWE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=oEGpw4wwxGl5QGUmii4GuN4oS5BWpnjxcQkjxhoxBJssWll+RQATJFI5FCKHGWJdont
 SH8cw55r5n/bbnaQa4u/CXt/GkZYoBrsZ6JOylEL2+uC6sSYQnBuxiKgIFuE5d5i8kClK
 ePtf9JY4Jv282270FJQTg2nCxDagHQgfGr0=

--biMCX1XSrjDH6dT40foN
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Nine new CVEs this week:

- CVE-2021-28688 [xen: blkback leak persistent grants] - fixed (ignore for CIP)
- CVE-2021-29264 [gianfar: jumbo frame overrun] - fixed (ignore for CIP)
  Needs backport to 4.9 and 4.14.
- CVE-2021-29265 [usbip: access race] - fixed (ignore for CIP)
- CVE-2021-29266 [vhost: vdpa: UAF] - fixed (ignore for CIP)
- CVE-2021-29646 [net: tipc: user data validation] - fixed
- CVE-2021-29647 [net: qrtr: kernel info leak] - fixed (ignore for CIP)
- CVE-2021-29648 [bpf: vmlinux BTF usage leads to crash] - fixed
- CVE-2021-29649 [bpf: umd: memleak] - fixed (ignore for CIP)
- CVE-2021-29650 [netfilter: x_tables: incorrect memory barrier led to
crash] - fixed
  Needs backport to 4.14 and earlier.


Regarding issues from last week,

CVE-2021-3444 - Debian added the following notes:

This last pre-requisite commit though would depend on
092ed0968bb6 ("bpf: verifier support JMP32") which does not
seem to make it possible to backport the fixes in 4.19.y
easily.

CVE-2021-20292 - Ubuntu tagged the commit introducing the
issue as 8e7e70522d76 ("drm/ttm: isolate dma data from ttm_tt V4")
from v3.3-rc1. So it looks like the fix needs to be backport to
v4.4 as well.


Regards
ChenYu

--biMCX1XSrjDH6dT40foN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6336): https://lists.cip-project.org/g/cip-dev/message=
/6336
Mute This Topic: https://lists.cip-project.org/mt/81755792/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--biMCX1XSrjDH6dT40foN--
