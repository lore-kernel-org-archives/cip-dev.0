Return-Path: <iwamatsu@nigauri.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF2BC433EF
	for <webhook@archiver.kernel.org>; Fri, 29 Apr 2022 06:07:55 +0000 (UTC)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46])
 by mx.groups.io with SMTP id smtpd.web09.6978.1651212473438731544
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Apr 2022 23:07:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nigauri-org.20210112.gappssmtp.com header.s=20210112
 header.b=PuMjRaPd;
 spf=none, err=permanent DNS error (domain: nigauri.org, ip: 209.85.217.46,
 mailfrom: iwamatsu@nigauri.org)
Received: by mail-vs1-f46.google.com with SMTP id i186so6612104vsc.9
        for <cip-dev@lists.cip-project.org>;
 Thu, 28 Apr 2022 23:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+JzvPJq6BRH71cejZfHR0nPYM68Ank6PMSiPXBSwRT4=;
        b=PuMjRaPd8STQ004TiCxTAogYmNbAaK0B8pzBn6DoP3a2Kk4KuinIJZlhZRDBOFRII8
         r5Hh9cQBsHe4ZHdGZgeiKFB1Y6BNNh2y5lW+3SalY1Hn5pxreLmv6FADTzK9nU6dZl1W
         X4+eIuexFAPGwMq8PsOAYKAySrSJPq+tfc506iLZRCiPh327btt/hHxWWCXcrDwPah26
         5vZmPst6bY7KDXGfjwsuX+cWWPukv7CSaGHZWzERHrEx76HBkdwaxqhOTr+2AKbuaWPr
         xA57DaU4s6zXudaClWJfdmga7T8H/oFMWv0ih2g/imtKjUcRLOV60BU0qODsdJhRHPCN
         nSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+JzvPJq6BRH71cejZfHR0nPYM68Ank6PMSiPXBSwRT4=;
        b=PIb4yMVE8gHYIWLls3HyeEweJMyOKgEIXjoLFCgxUguUB+RFgCpVlFXomFROmy4819
         l7Lh8xFylRZvFx/jM02Z/OSo9g0xD/MbVYY+h4sKPhHB18DxgW0w46HQKM9IJNjNILdG
         QKoAm3AW3oMfmfhZEtJ3uvcjN85eYWhiM/NVYCYX1dooowYr8w0m9nm6C9WjN3IMDjqb
         zVafFBimmvZ0yU/y3AmOe8613G3daP0qEGJj0udrFYqOujnFviXradIAz+qMvWUmua8Q
         rvMQpZtI3xeHMUjAQV3g8qiYBidSXm4GNw9aFq9x7oabVpb5ZnuZCQKQbf/CI3+g7zMf
         jDrw==
X-Gm-Message-State: AOAM532yjJ+vSJf/PPWWfiYTVUOt9QTeNITBMk9XdvaQ2zvIQxLTPMPa
	y3AmD3BzDo1R6FNMvs8fg9GY50sHL0VGkkC4iaP0UYg0WrGnwFg=
X-Google-Smtp-Source: 
 ABdhPJxION2SYMHAI5Phjr2t94KGN7uN4K/+hnntnIr5mHESTS76GTkl5piwkRvgmlMoqwolGnFhexgFQfgWjpUzax0=
X-Received: by 2002:a67:fc8e:0:b0:32c:e442:3634 with SMTP id
 x14-20020a67fc8e000000b0032ce4423634mr5737214vsp.5.1651212472186; Thu, 28 Apr
 2022 23:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <16EA1EC5D11818E9.15794@lists.cip-project.org>
 <20220428173525.GA32556@duo.ucw.cz>
 <CACOXgS8EVEsHWe-548a3zQuYrTrXJp8EjcTJyr91L=2mTHLyZw@mail.gmail.com>
In-Reply-To: 
 <CACOXgS8EVEsHWe-548a3zQuYrTrXJp8EjcTJyr91L=2mTHLyZw@mail.gmail.com>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Fri, 29 Apr 2022 15:07:26 +0900
Message-ID: 
 <CABMQnVKzp7B+EF+9vFPLbT0qjfYk8-=_UgFVk6afq3AOO+vPWA@mail.gmail.com>
Subject: Re: [cip-dev] 4.19 oopses on socfpga
To: cip-dev@lists.cip-project.org
Cc: Chris Paterson <Chris.Paterson2@renesas.com>,
 alice.ferrazzi@miraclelinux.com,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Apr 2022 06:07:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8231

Hi,

2022=E5=B9=B44=E6=9C=8829=E6=97=A5(=E9=87=91) 8:57 Masami Ichikawa <masami2=
56@gmail.com>:
>
> Hello.
>
> On Fri, Apr 29, 2022 at 2:35 AM Pavel Machek <pavel@denx.de> wrote:
> >
> > Hi!
> >
> >
> > > There's oops during boot on socfpga:
> > >
> > > 4.19.240-cip72-00010-g0ffbb4b1066 -- https://lava.ciplatform.org/sche=
duler/job/669893
> > > 4.19.240-rc1-g5e5c9d690926 -- https://lava.ciplatform.org/scheduler/j=
ob/669259
> > >
> > > This commit may be relevant:
> > >
> > > commit e2423aa174e6c3e9805e96db778245ba73cdd88c
> > >     net: ethernet: stmmac: fix altr_tse_pcs function when using a fix=
ed-link
> > >     [ Upstream commit a6aaa00324240967272b451bfa772547bd576ee6 ]
> > >
> > > Let me investigate a bit more.
> >
> > I tried to do some testing, but it fails on two targets:
> >
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/5222115=
01
> >
> > And failed test says:
> >
> > https://lava.ciplatform.org/scheduler/job/670508
> >
> > ob error: Invalid job data: ["Resource unavailable at
> > 'https://s3.eu-central-1.amazonaws.com/download2.cip-project.org/cip-te=
sting/linux-cip/zImage_siemens_de0-nano-soc_defconfig_4.19.239_e5e741fbf/ar=
m/siemens_de0-nano-soc_defconfig/dtb/socfpga_cyclone5_de0_nano_soc.dtb'
> > (404)"]
> >
> > which sounds like a test problem, not kernel problem.
> >
> > Any ideas?
> >
>
> It looks like the pipeline 522211501's build job didn't build
> socfpga_cyclone5_de0_nano_soc.dtb.
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/2364180684#L24=
17
>
> An old build job(pipeline #523704627 . kernel 4.19.239-cip72) builds
> the dtb file.
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/2371451342#L29=
07
>

This is the backport patch is imported into the CIP kernel.
    https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commi=
t/?h=3Dlinux-4.19.y-cip&id=3D64729dc0be4847961550cdcca4ddc66adf556aaa

I was revert E2423AA174E6 with a CIP kernel and confirmed. I think
this is the cause.
    https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commit/009b7940a6=
ca52f2b39099c2c4d10bab337829b5
    https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/2392927535

I will check the board supported by LTS.

Best regards,
  Nobuhiro

