Return-Path: <SRS0=MQWN=HU=lists.cip-project.org=bounce+64572+6184+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C829C433DB
	for <cip-dev@archiver.kernel.org>; Thu, 18 Feb 2021 09:52:53 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022E364E79
	for <cip-dev@archiver.kernel.org>; Thu, 18 Feb 2021 09:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022E364E79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6184+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 52GXYY4521723xhJhtQdVsq9; Thu, 18 Feb 2021 01:52:52 -0800
X-Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web12.4755.1613641971277278246
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Feb 2021 01:52:51 -0800
X-Received: by mail-lf1-f42.google.com with SMTP id e7so5554981lft.2
        for <cip-dev@lists.cip-project.org>; Thu, 18 Feb 2021 01:52:50 -0800 (PST)
X-Gm-Message-State: BLq4JZxE8sNJV935VDY0n7oox4520388AA=
X-Google-Smtp-Source: ABdhPJyrQh1bkHN640e/06sod6erS5px1iTXGqblujc4rl4B7be9X9keUmFeyhbuMUcDj5AJrr4xCA==
X-Received: by 2002:ac2:4846:: with SMTP id 6mr2091172lfy.6.1613641969005;
        Thu, 18 Feb 2021 01:52:49 -0800 (PST)
X-Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id w10sm547869ljm.133.2021.02.18.01.52.48
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 01:52:48 -0800 (PST)
X-Received: by mail-lf1-f46.google.com with SMTP id m22so5490934lfg.5
        for <cip-dev@lists.cip-project.org>; Thu, 18 Feb 2021 01:52:48 -0800 (PST)
X-Received: by 2002:ac2:558f:: with SMTP id v15mr713189lfg.57.1613641968550;
 Thu, 18 Feb 2021 01:52:48 -0800 (PST)
MIME-Version: 1.0
References: <CAGb2v67v7o16fV4s7GTgO96P5=g3icjNUNGNs0mDdcm2BZYm=w@mail.gmail.com>
 <20210218094923.GA28023@amd>
In-Reply-To: <20210218094923.GA28023@amd>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 18 Feb 2021 17:52:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v66RODCVTdiway7SiNVQHDcgFiVHH0XYJmktQSa+_hdFnQ@mail.gmail.com>
Message-ID: <CAGb2v66RODCVTdiway7SiNVQHDcgFiVHH0XYJmktQSa+_hdFnQ@mail.gmail.com>
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-02-18
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org, 
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="b1IzABE15pFrRp7iTOkU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1613641972;
 bh=rNSqi18FbhqHauqVT4Cg5XSysZ2VI74JshQJOVyhWQs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=OfIvUKBjecv63IzkYMpxzkz+rcwqPjLGOBWR3RyFMYFWY+HvmHBwb1QgBJ4sRid3cUn
 YF5XVo/BHUDQs7ErehBVwNkGuEkpp/hMvlYJVUHVBBnjxzHqVh4S1MMzKhY/rUnY5EwLH
 TsKM/nKyhjPQCQZj9F8e2UEc8/szyp/qMgc=

--b1IzABE15pFrRp7iTOkU
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 18, 2021 at 5:49 PM Pavel Machek <pavel@denx.de> wrote:
>
> On Thu 2021-02-18 17:21:57, Chen-Yu Tsai wrote:
> > Hi everyone,
> >
> > Five new issues this week:
> >
> > CVE-2021-20239 [setsockopt copy_from_user error] - fixed in 5.4 and
> > removed from 5.10
> > CVE-2021-26930 [xen-blkback error handling] - PR sent
> > CVE-2021-26931 [xen backends: BUG_ON in error handling] - PR sent
> > CVE-2021-26932 [xen grant mapping error handling] - PR sent
> > CVE-2021-26934 [xen unsupported driver] - Xen documentation change
> > stating be-alloc display driver is unsupported
> >
> > Linus doesn't seem to be processing PRs for the new merge window yet,
> > so we might have to wait a while before the Xen ones are fixed and
> > backported.
>
> Well, Xen is not a typical thing to run on embbeded hardware, but I
> did not check the configs.

I see Renesas and Siemens have it enabled. Is Xen still relevant?
Or has everyone switched over to KVM + QEMU?

> It seems Linus is having power problems:

I read the headline on Phoronix, but didn't know it was this bad.
That also explains why lkml.org was completely empty yesterday.


ChenYu

> Best regards,
>                                                                 Pavel
>
> Date: Tue, 16 Feb 2021 12:25:06 -0800
> From: Linus Torvalds <torvalds@linuxfoundation.org>
> To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> Cc: users@linux.kernel.org
> Subject: Re: [kernel.org users] Partial power outage in the PDX
> datacentre
>
> [-- Attachment #1 --]
> [-- Type: multipart/alternative, Encoding: 7bit, Size: 2.2K --]
>
> Sadly, the power at my house is still entirely out, although cell
> service
> has now been fixed so at least I can read some email without walking
> outside.
>
> But with no power for my laptop or workstation, I won't be starting
> the
> merge window until power is back more widely in they Portland area.
>
> My neighborhood is likely not a priority, so it very possibly will be
> a few
> more days (so far without power since Sunday evening).
>
> Even the local highway 43 (ok, not a big highway, but still) is still
> closed down two days later due to downed trees.
>
>         Linus
>
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--b1IzABE15pFrRp7iTOkU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6184): https://lists.cip-project.org/g/cip-dev/message=
/6184
Mute This Topic: https://lists.cip-project.org/mt/80725760/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--b1IzABE15pFrRp7iTOkU--
