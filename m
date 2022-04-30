Return-Path: <iwamatsu@nigauri.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8EBC433EF
	for <webhook@archiver.kernel.org>; Sat, 30 Apr 2022 22:37:22 +0000 (UTC)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com
 [209.85.217.50])
 by mx.groups.io with SMTP id smtpd.web12.28021.1651358236577267028
 for <cip-dev@lists.cip-project.org>;
 Sat, 30 Apr 2022 15:37:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nigauri-org.20210112.gappssmtp.com header.s=20210112
 header.b=A6/gy+PA;
 spf=none, err=permanent DNS error (domain: nigauri.org, ip: 209.85.217.50,
 mailfrom: iwamatsu@nigauri.org)
Received: by mail-vs1-f50.google.com with SMTP id m62so10092186vsc.2
        for <cip-dev@lists.cip-project.org>;
 Sat, 30 Apr 2022 15:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9HRMiq91qIN22AfdWms+umrMVVJ+60uf6Kx0SkqRUTc=;
        b=A6/gy+PARZM2sPdbzQs1DptLUBtVtcxCQjHezBjPUmYlemLkQ4NqeFVYRqvwNz293g
         EN2iT+tuiljUcUjgY0Os0yRWdg3XyUI/p75U/Rwkx7cIpk+qFyxscQHP9wKGJDF8FV1l
         xFcl+mdNdglnzkfudwrhnDqsUTTV2oRtnTUoGznumeXQpfOrrKc248OyZib/5tEQa1w6
         GbWvSSU0ff3DmLWT2N11pUo1/Asq0jgiiH43Mf8phRC83d/G/TyMJEjirskLx+KK0OlA
         0uPJQeMzQ33C6rgWnIakdQkFiNoiSe3/kUAASHXL8laJoZlkOBaTU0qBVtwc5WWvdhhf
         hxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9HRMiq91qIN22AfdWms+umrMVVJ+60uf6Kx0SkqRUTc=;
        b=dbTfvGOTU5GvWIbBEgp1lQCIEy+mWNVdyRY85RSDA398csuROBRoe5kyp4n0oUA031
         SmUfoUvPqkLcqvyk8iIMwrU1FlYT3GSFdNXoY4r5U0/QzIaL6+2GG1KTq0P9gjoAdk5Y
         niuyGE0+wgDMWXmqpi+1SZ7MqQ8pMGv1cwUtb8X6V/WJkZDYbZcru8XYCPUd1W387XCq
         Ui21dvX6akpkAn6nzi0OKMOB5Srl+D/wfre1a7xR4Z3/Xus6zQw8IyeKQ2hbeZX/17fn
         FW9A95GbxrsrSdrchhmA3tC+sgBjrfD+rbjDCigv5CxUnVn7uUfg45Pky03DtqjqZsmj
         niSg==
X-Gm-Message-State: AOAM530wJ3gIhRvQME0smxeHHciAZNI9qwKKefuWWEjIdv08UsSDKqqC
	e2KhQCl/Z5otzK4Lh1dP4LXJNiRwnJ/qHD7PSWMe7L/Mx6wYK6E=
X-Google-Smtp-Source: 
 ABdhPJyYB7rhCMOz2XIiVqRygjI09adKT2/zqtijsIYh+VJQY9XrjwVj4dWVhVuR2blNJIjJGmPuOK713o9o/2XiVw8=
X-Received: by 2002:a05:6102:5490:b0:32d:2f86:2daf with SMTP id
 bk16-20020a056102549000b0032d2f862dafmr607125vsb.84.1651358235327; Sat, 30
 Apr 2022 15:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <16EA1EC5D11818E9.15794@lists.cip-project.org>
 <20220428173525.GA32556@duo.ucw.cz>
 <CACOXgS8EVEsHWe-548a3zQuYrTrXJp8EjcTJyr91L=2mTHLyZw@mail.gmail.com>
 <CABMQnVKzp7B+EF+9vFPLbT0qjfYk8-=_UgFVk6afq3AOO+vPWA@mail.gmail.com>
In-Reply-To: 
 <CABMQnVKzp7B+EF+9vFPLbT0qjfYk8-=_UgFVk6afq3AOO+vPWA@mail.gmail.com>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Sun, 1 May 2022 07:36:49 +0900
Message-ID: 
 <CABMQnVLKZ6XW+mvOb2JbREz7RR42faZ9QDfAquLAi8-CXjmGGA@mail.gmail.com>
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
 <cip-dev@lists.cip-project.org>; Sat, 30 Apr 2022 22:37:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8232

Hi,

2022=E5=B9=B44=E6=9C=8829=E6=97=A5(=E9=87=91) 15:07 Nobuhiro Iwamatsu <iwam=
atsu@nigauri.org>:
>
> Hi,
>
> 2022=E5=B9=B44=E6=9C=8829=E6=97=A5(=E9=87=91) 8:57 Masami Ichikawa <masam=
i256@gmail.com>:
> >
> > Hello.
> >
> > On Fri, Apr 29, 2022 at 2:35 AM Pavel Machek <pavel@denx.de> wrote:
> > >
> > > Hi!
> > >
> > >
> > > > There's oops during boot on socfpga:
> > > >
> > > > 4.19.240-cip72-00010-g0ffbb4b1066 -- https://lava.ciplatform.org/sc=
heduler/job/669893
> > > > 4.19.240-rc1-g5e5c9d690926 -- https://lava.ciplatform.org/scheduler=
/job/669259
> > > >
> > > > This commit may be relevant:
> > > >
> > > > commit e2423aa174e6c3e9805e96db778245ba73cdd88c
> > > >     net: ethernet: stmmac: fix altr_tse_pcs function when using a f=
ixed-link
> > > >     [ Upstream commit a6aaa00324240967272b451bfa772547bd576ee6 ]
> > > >
> > > > Let me investigate a bit more.
> > >
> > > I tried to do some testing, but it fails on two targets:
> > >
> > > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/52221=
1501
> > >
> > > And failed test says:
> > >
> > > https://lava.ciplatform.org/scheduler/job/670508
> > >
> > > ob error: Invalid job data: ["Resource unavailable at
> > > 'https://s3.eu-central-1.amazonaws.com/download2.cip-project.org/cip-=
testing/linux-cip/zImage_siemens_de0-nano-soc_defconfig_4.19.239_e5e741fbf/=
arm/siemens_de0-nano-soc_defconfig/dtb/socfpga_cyclone5_de0_nano_soc.dtb'
> > > (404)"]
> > >
> > > which sounds like a test problem, not kernel problem.
> > >
> > > Any ideas?
> > >
> >
> > It looks like the pipeline 522211501's build job didn't build
> > socfpga_cyclone5_de0_nano_soc.dtb.
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/2364180684#L=
2417
> >
> > An old build job(pipeline #523704627 . kernel 4.19.239-cip72) builds
> > the dtb file.
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/2371451342#L=
2907
> >
>
> This is the backport patch is imported into the CIP kernel.
>     https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/com=
mit/?h=3Dlinux-4.19.y-cip&id=3D64729dc0be4847961550cdcca4ddc66adf556aaa
>
> I was revert E2423AA174E6 with a CIP kernel and confirmed. I think
> this is the cause.
>     https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commit/009b7940=
a6ca52f2b39099c2c4d10bab337829b5
>     https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/2392927535
>
> I will check the board supported by LTS.
>

This was also reproduced on other SOCFPGA boards.
And as you know, this commit has already been Revert in LTS.

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6

