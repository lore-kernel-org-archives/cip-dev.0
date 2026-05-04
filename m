Return-Path: <iwamatsu@nigauri.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DA0FF885A
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 11:14:18 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12318.1777893251385283011
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 May 2026 04:14:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nigauri-org.20251104.gappssmtp.com header.s=20251104 header.b=pXbe6M2x;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: iwamatsu@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8b9f2295a9dso2886586d6.3
        for <cip-dev@lists.cip-project.org>; Mon, 04 May 2026 04:14:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777893250; cv=none;
        d=google.com; s=arc-20240605;
        b=QLmrERREl4Vh97lJTHU/IWmMrW8LZ548KlywCIgisysf+vWKCLfKWO135DIbAsqHpf
         vNlhka0VEp2j9Nb5/F0fgKOWIXu0BFk0MiA00DR28PulTHZiAJkLhbVJWSCcoScDiKbg
         p/e4uReRtpcxlVqHTc3oLSIxpYykAiuwTlUn/dcA9uT7lHHGGg4+rnNL8giSHw/tiOne
         kplNbdG3UVpmiWDtdN43pI2CIJ+lb1Ot+weCVQK/S7Y+2mZeE6rkaymUrPLaUjroYdut
         q591653mv5We/w/aZPRmgaSxQyaY2695UfLtKKNX/b5LXaYItLWH8YAnquxsZxBBZLST
         eXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ch/J5k7eHtNCuStFnhOwYjBEOIVihKBTekMZCotq1H0=;
        fh=RywZYzt44LB+hEv6e5UhjHlMb9BaMcpOY7GrVgDdWro=;
        b=lcolI6KJ7/Cg9EI/rdnjbZEnbJlZ+DxhAyezQS7IEhFvOYWQYGpkVeTDedpg8LFD3B
         2P5EgANsa8rCbcuYzxdxQpdG4Nsh6ptRXDOvQHMMFw0ZC++EVS4KTmgJ16+XURPwFjYm
         BD62CYoVY0B1HHYafYVujFjQXMOHb18q8qeN3GOouRMY85+wvJZagFoCyMghy9ExGjWw
         uYLk1j1MHU8j/DHH08qbticOVGsT4waCK5NV3dbhpP17Sq0NbDSZcPD9hhIzWc0VNQYY
         89A3C92CAJvfYiPIjJftmvxxH6ZshrbfgEZ3aoCg1NQvjHLxUI1vAP9MY6Sel8VsLgAQ
         vNJg==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20251104.gappssmtp.com; s=20251104; t=1777893250; x=1778498050; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ch/J5k7eHtNCuStFnhOwYjBEOIVihKBTekMZCotq1H0=;
        b=pXbe6M2xaUt+JC/ih6xvJCMzn5XRlck2WwceLPSe3Msur53AqYQwX26Q2hfKTltuwg
         WzciKKDZyrmPgy6xz3hFt9XpS51niJ2NvQexyBKcivFe/1KWuq93dgAc34iSa7/Pb9RE
         vqUg23g5KcNkCwaMFZaHFUjE7Zgq0xYJaYt4ANOBHe08J5T7yGVgj8F0thpzGKD5LHEW
         tZenZe+g0JWPL3BnRKvE99IZxy7icUgPT7wXCTru8RdEMwwHkEIH60bmw9SuiJ5TOHfZ
         GBuk64gqM+9cmiHaBxCU1f1+3YlPoU0bxU8+mPlKBUy8AHYxobKcy2yCbOY+GxPEfA5a
         C4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777893250; x=1778498050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ch/J5k7eHtNCuStFnhOwYjBEOIVihKBTekMZCotq1H0=;
        b=XBxx6FsyOJmQ9bU5bu+o3vmLimvAEQzOoKOBhnsUP0beVj6v56fenBiAmwTT593ZsT
         4tI5S68vVXnPwkW61nluG1qLSX6+Ze/qmmsag11VHa/Yfty4736mAGy4Rq7QTYj1KNLl
         LkDj59QDRa9MSwEpg3blldCxsqmgoSxTLnbAdN9VRk9mp8yaZqKzsnpTpdDy9upUMrtk
         OtqyPpRc2H0gzPI3H5JG2x4MF+n1zYR8vem1fjIwut1D7b60f3uao2mdGzFBP+tO5qC1
         jx0i/AWWZSIR0iFgn3e5aiG8yIN3RKRU9BLJBfhSToDUffzVhNtNfpupWaLhOWzGzsKn
         Nufg==
X-Forwarded-Encrypted: i=1; AFNElJ8JQFsKlO3xBHogs1I3Zc5VvzBRjdx0rD6CPmrEPiog1BUY68l5JVD20+JW8m/YJz73SBZh4ZUp@lists.cip-project.org
X-Gm-Message-State: AOJu0Yxu5Ko+EVhZdNxQxQ7DFH2QgasfNfk9xMMwQonIsC2A4Lqa779N
	0nPRSuhW/uPjFHasBwIY9C7RU+HcK4UOoPKPa/SkpqGisfNejunQwHzAR1SoNsysjEBFWypBTBA
	ndJtP1I9/CZ8d6QLMN1Cp2EBWaojq1Mg=
X-Gm-Gg: AeBDietcOioowz/++mVOuK/qy5hOLyCU7BnM0SN9dM3SSQB4kDGLWHHcqLWFq+ZwC/y
	YNpTL95Cc5hu4V+BBFnDNyBexcvMq+AFLvUdqG6gKrWw/uMEpSogZvFMy+MYedUF3FY5Bmurt5+
	zLe0aK4M9vTmSmaXz+x6ID5a0xg+WIXhXWWAJgoHSB4ljaBlM3B6QL5ti3rAITOB4uQjQI9b8BG
	b2RPnXVMR9rasXLZjF+x5joCOJTxT/chn/ypgy1luzeJzENMzhrtQ/iYFuGA0Wd2llHKbqZXoqL
	TcjWVYcElm+XeOk=
X-Received: by 2002:a05:6214:3d85:b0:89c:d424:aceb with SMTP id
 6a1803df08f44-8b66882df04mr149742986d6.31.1777893250288; Mon, 04 May 2026
 04:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260501225859.504868-1-nobuhiro.iwamatsu.x90@mail.toshiba> <afhkX2Ys2BG1gnqy@duo.ucw.cz>
In-Reply-To: <afhkX2Ys2BG1gnqy@duo.ucw.cz>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Mon, 4 May 2026 20:13:58 +0900
X-Gm-Features: AVHnY4LqxiCDUo8FVMP_7ti3ORbzUPkHt5mSScKq2VJijp6pPFIiVuxRCG4svIE
Message-ID: <CACe6DC5BJzWxi8xXP2akE4ffTfLiHXrj=W=4OxFnPA-8UOdhaQ@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH for 5.10.y] phy: renesas: rcar-gen3-usb2: Fix
 the use of msleep during spinlock
To: pavel@nabladev.com
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, 
	cip-dev@lists.cip-project.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 May 2026 11:14:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22861

Hi Pavel,

2026=E5=B9=B45=E6=9C=884=E6=97=A5(=E6=9C=88) 18:18 Pavel Machek via lists.c=
ip-project.org
<pavel=3Dnabladev.com@lists.cip-project.org>:
>
> Hi!
>
> > From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> >
> > This fixes an issue caused by the use of msleep during spinlock.
> > In the original commit, msleep was changed to mdelay, but this fix was =
not
> > carried over during the backport to 5.10.y tree.
>
> Doing this as a quick fix is probably okay, but this should not be
> final version.
>
> You are right that msleep inside spinlock will blow up immediately:
>
> > ```
> > [   62.677594] BUG: scheduling while atomic: kworker/1:2/126/0x00000002
> > [   62.683957] Modules linked in:
>
> But mdelay for 20 msec inside irqsave spinlock is borderline
> unacceptable, too.

Thanks for pointing that out.
You=E2=80=99re absolutely right.
I had completely forgotten about that....

>
> I believe we'll need Renesas to analyze/fix this properly after the
> CVE emergency is done.
>
> This fix is good for now, but better fix is needed.
>
> Claudiu, are you right person for this, or should we cc someone else?
>
> Best regards,
>                                                                 Pavel

Best regards,
  Nouhiro
--=20
Nobuhiro Iwamatsu

