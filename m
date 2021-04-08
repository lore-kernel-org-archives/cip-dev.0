Return-Path: <SRS0=6nZW=JF=lists.cip-project.org=bounce+64572+6354+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A162C433B4
	for <cip-dev@archiver.kernel.org>; Thu,  8 Apr 2021 07:24:05 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9EB610F8
	for <cip-dev@archiver.kernel.org>; Thu,  8 Apr 2021 07:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9EB610F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6354+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qMf7YY4521723xoRpblg82BA; Thu, 08 Apr 2021 00:24:04 -0700
X-Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web08.4694.1617866643100228780
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Apr 2021 00:24:03 -0700
X-Received: by mail-lf1-f51.google.com with SMTP id n8so2320394lfh.1
        for <cip-dev@lists.cip-project.org>; Thu, 08 Apr 2021 00:24:02 -0700 (PDT)
X-Gm-Message-State: jrEhAVPlgerBa3oLitsGvWusx4520388AA=
X-Google-Smtp-Source: ABdhPJz7jaOHQFAWjKUQov5BiULDXTs1G9cVvfPDhU6T796whO0iZd8bt8/i/cF30rYpNWzr2ylQIQ==
X-Received: by 2002:ac2:5a02:: with SMTP id q2mr5134267lfn.367.1617866640888;
        Thu, 08 Apr 2021 00:24:00 -0700 (PDT)
X-Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id z9sm2767315lji.139.2021.04.08.00.24.00
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 00:24:00 -0700 (PDT)
X-Received: by mail-lj1-f171.google.com with SMTP id u9so1048099ljd.11
        for <cip-dev@lists.cip-project.org>; Thu, 08 Apr 2021 00:24:00 -0700 (PDT)
X-Received: by 2002:a2e:1649:: with SMTP id 9mr4906391ljw.74.1617866640287;
 Thu, 08 Apr 2021 00:24:00 -0700 (PDT)
MIME-Version: 1.0
Reply-To: cip-dev@lists.cip-project.org
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 8 Apr 2021 15:23:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v66M1mjZjBfHAwv1yECqCDHALzk4_fVD-bdB0V-4R=DPLg@mail.gmail.com>
Message-ID: <CAGb2v66M1mjZjBfHAwv1yECqCDHALzk4_fVD-bdB0V-4R=DPLg@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2021-04-08
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
Content-Type: multipart/mixed; boundary="EJIy3bzlH2K0ZHJ8fMhF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1617866644;
 bh=2l0RZedTc2OGbjMu2RtYvCYu2M5nV39YjchwJ8pSJEA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=L9jnLUHnY504WeZfy6S3qZU6WCpGNH2niCBvgw7MMkYbY/FtDhDhVecBIVuySWQO7t+
 P5oEpaexH82iEdFSTQCPOcJ0V4eTwTBihF4O4z5G7Lp5GVRrmx4Cgz3kxrec/J/fTXQXX
 CTIdF9tsmLj1+MS7HwUxBxGneE9Nt8UNGGk=

--EJIy3bzlH2K0ZHJ8fMhF
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Eight new issues this week:

- CVE-2020-36310 [x86/kvm: svm: infinite loop] - fixed
  auto-backport failed.
- CVE-2020-36311 [x86/kvm: svm: sev: softhang] - fixed (ignore for CIP)
- CVE-2020-36312 [kvm: mem leak] - fixed
- CVE-2020-36313 [kvm: out-of-bounds access] - fixed
- CVE-2021-29657 [x86/kvm: svm: data race] - fixed
- CVE-2021-30002 [media/v4l2: ioctl mem leak] - fixed
- CVE-2021-30178 [x86/kvm: hyperv: NULL ptr deref] - fixed
- CVE-2021-3483 [firewire: nosy: UAF] - fixed (ignore for CIP) - fixed

No updates on CVE-2021-3444, CVE-2021-20292 or CVE-2021-29650 from
previous weeks.


Regards
ChenYu

--EJIy3bzlH2K0ZHJ8fMhF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6354): https://lists.cip-project.org/g/cip-dev/message=
/6354
Mute This Topic: https://lists.cip-project.org/mt/81936606/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--EJIy3bzlH2K0ZHJ8fMhF--
