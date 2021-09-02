Return-Path: <SRS0=z5Qp=NY=lists.cip-project.org=bounce+64572+6717+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E411C432BE
	for <cip-dev@archiver.kernel.org>; Thu,  2 Sep 2021 12:17:58 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EFA4603E9
	for <cip-dev@archiver.kernel.org>; Thu,  2 Sep 2021 12:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8EFA4603E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id WQiZYY4521723xif9jrfd6zL; Thu, 02 Sep 2021 05:17:57 -0700
X-Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
 by mx.groups.io with SMTP id smtpd.web11.5934.1630585074679848022
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Sep 2021 05:17:56 -0700
X-Received: by mail-oi1-f176.google.com with SMTP id h133so2229900oib.7
        for <cip-dev@lists.cip-project.org>; Thu, 02 Sep 2021 05:17:54 -0700 (PDT)
X-Gm-Message-State: 8h7OMKk3snIRg5FwQwTzAEncx4520388AA=
X-Google-Smtp-Source: ABdhPJwPhiAIhcNLR0mMRan4IoF3R66RJftArL89d6hSxPcYMPw9ZS5m0K9P7mFgnJO75xCCS7mMdCP74PEy+Rd9CUg=
X-Received: by 2002:a54:4389:: with SMTP id u9mr1884877oiv.132.1630585073418;
 Thu, 02 Sep 2021 05:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAODzB9orf2AFV9fRwu-VBJxOiJTKvcyhHmihpy3EXH3yB5PEXA@mail.gmail.com>
 <20210902062759.GA25051@amd>
In-Reply-To: <20210902062759.GA25051@amd>
From: "Masami Ichikawa" <masami.ichikawa@miraclelinux.com>
Date: Thu, 2 Sep 2021 21:17:17 +0900
Message-ID: <CAODzB9p0Vz5CDazYeBgZCQHxgPrc9Uut4HNN88a9FWZR3BVznw@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entry this week
To: cip-dev <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="TQGrVBz1gEL4MaMQnHcL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1630585077;
 bh=dvBPoPxM1GQUb+8KUdNjRqIlMhDDu9gppxnQ/KTWoEg=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=IrQs25svrSa0xFgMTn1VO0LvBJYgGo13SaYV06rSGpW1a8NV/ar7sYRRBDWSjr7nesY
 Q3kIKFhEgmVRe6EcaCG8nW3Rt2JFN9KLfxG34yV0sJhkg+C34Efft77NcCHDqHeSes/cI
 tI4O9rVM78senrv5lRdSI3jlTyvMhqzi+bI=

--TQGrVBz1gEL4MaMQnHcL
Content-Type: text/plain; charset="UTF-8"

Hi !

On Thu, Sep 2, 2021 at 3:28 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > * CVE short summary
>
> These summaries are not so short; I simply skip them and go to full
> list. Perhaps they don't need to be included, or could include only
> CVEs where we need to take an action?
>

Thank you for the comment.
This weekly report mail contains full list which are new CVEs, updated
CVEs, and currently tracking CVEs, so summary can be removed or make
it simple I think.
I'll write a new summary style that includes CVEs which we need to take care of.

> > * CVE detail
> >
> > New CVEs
> >
> > CVE-2021-3739: btrfs: fix NULL pointer dereference when deleting
> > device by invalid id
> >
> > Fixed in btrfs tree but not fixed in mainline yet.
> > This vulnerability has been introduced since 4.20-rc1 so before 4.20
> > kernel aren't affected this vulnerability.
> >
> > Fixed status
> >
> > mainline: [e4571b8c5e9ffa1e85c0c671995bd4dcc5c75091]
>
> This one is queued for 5.10.62, so this is getting fixed for us.
>
> > CVE-2021-3743: out-of-bound Read in qrtr_endpoint_post in net/qrtr/qrtr.c
> >
> > The Qualcomm's IPC router protocol(qrtr) has been introduced since
> > 4.15-rc1 so before 4.15 kernels aren't affected.
> > Checked on cip-kernel-config, it looks like no CIP member enables QRTR.
> >
> > Fixed status
> >
> > mainline: [7e78c597c3ebfd0cb329aa09a838734147e4f117]
>
> Fixes are queued for 4.19 and 5.10.62, so this is getting fixed for us.
>
> > CVE-2021-3753: A out-of-bounds caused by the race of KDSETMODE in vt
> >
> > Commit ffb324e6f874121f7dce5bdae5e05d02baae7269 introduced race
> > condition and oob bug. The commit ffb324e6f874 have been backported to
> > 4.4 and 4.19.
>
> Agreed, fixed in 4.19.192 and 4.4.270. Nothing for us to do there.
>
> > Updated CVEs
> >
> > CVE-2020-3702: Specifically timed and handcrafted traffic can cause
> > internal errors in a WLAN device that lead to improper layer 2 Wi-Fi
> > encryption with a consequent possibility of information disclosure
> > over the air for a discrete set of traffic
> >
> > Vulnerability in ath9k driver. 4.4.y-cip/arm/siemens_imx6_defconfig
> > and 4.4.y-cip/arm/moxa_mxc_defconfig use ath9k.
>
> Fixed in 4.14 but not 4.4.
>
> > stable/4.14: [2cbb22fd4b4fb4d0822d185bf5bd6d027107bfda,
> > 20e7de09cbdb76a38f28fb71709fae347123ddb7,
> >   995586a56748c532850870523d3a9080492b3433,
> > f4d4f4473129e9ee55b8562250adc53217bad529,
> >   61b014a8f8de02bedc56f76620170437f5638588]
>
> Diffstat looks like this:
>
>  key.c |   11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>  main.c |    5 +++++
>  1 file changed, 5 insertions(+)
>  ath.h |    1 +
>  key.c |    4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>  ath.h                |    2 +-
>  ath5k/mac80211-ops.c |    2 +-
>  ath9k/htc_drv_main.c |    2 +-
>  ath9k/main.c         |    5 ++---
>  key.c                |   34 +++++++++++++++++-----------------
>  5 files changed, 22 insertions(+), 23 deletions(-)
>  hw.h   |    1
>  main.c |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 87 insertions(+), 1 deletion(-)
>
> Best regards,
>                                                                 Pavel
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> 
>

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--TQGrVBz1gEL4MaMQnHcL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6717): https://lists.cip-project.org/g/cip-dev/message/=
6717
Mute This Topic: https://lists.cip-project.org/mt/85318439/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--TQGrVBz1gEL4MaMQnHcL--
