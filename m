Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8018CD2F7D1
	for <webhook@archiver.kernel.org>; Wed, 16 Oct 2024 22:08:20 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
 by mx.groups.io with SMTP id smtpd.web11.36173.1729116497338667933
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Oct 2024 15:08:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Z/WJcr/G;
 spf=pass (domain: gmail.com, ip: 209.85.160.179, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4603d3e456bso2542851cf.2
        for <cip-dev@lists.cip-project.org>; Wed, 16 Oct 2024 15:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729116496; x=1729721296; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnXrg2PuT9/nSGSesShPC2ZMOfkzmmHgTHIYn9OuiwQ=;
        b=Z/WJcr/GpTZDGqrTAsSPi0KrU8OV7/GOfo9seqoqcSQk+YK7Gzg/4pVrpgt015jQT4
         H3ddA7DpWsJ010H5xwjKwMU6/GHf7BDSEXz2t2TOiqqeAj8Xrtn/1+E423PDg+hGQqk6
         b1bHXqpyWQwAg1jCvPTNmhcOptf2bSzsnI0Ozmn1v9AG6h+i9T8idflHiVYxDDSGgDZJ
         1s7fOWAK062pKqLP/5DJa4fNqEJLItMpU3XIlc1D+sAl/lCsP4kiRvlnSlPWSmjs2zug
         5X7DX9WXaTOTt0jc4NIes2bXFdnh4J41XuXQfb+B5lGqY3w1lk4SbtVF5z3Jfn/6VI5Y
         huNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729116496; x=1729721296;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnXrg2PuT9/nSGSesShPC2ZMOfkzmmHgTHIYn9OuiwQ=;
        b=sihMLJyW7sK/Yn92E+04w9+DDK4hVamyY5cBG74S5kExmJLrJ6opyxbqvAnPHefRSU
         VOaGOVJzBqi6knkG1elqqY1Z7+YwoomVjpQHE/O608c84dB5GiFQkfHd+0AE+CKzECH2
         X6kO8vVHj/7UWQpClE7SEL1RmcGWKBcnSBFfvjrlIXuGDIL8jBoTkMvNTtXH8l94//on
         P65OnSY2jptsAoM/5Od5vmWmcwl0GVY5KZpfrsKgTQ22+LRjHl7OkpOHHfk7KGjhYSM2
         wbCx5It4HwXkhrnP9Zw561hW+Mnu6lyvVzqtyHWKKGJRk2Vzs2vtL/O2IuY/rzLLdqgM
         rSgQ==
X-Gm-Message-State: AOJu0Yxc+4py7yxFVf9WP30KhgnPZgJ/dpDtmGw+sGrouvT2uPKPx2iv
	si954OM/uexF1p81o+fnFJBT4cF9BSn8y37OUbzHbTFIMU5t6hV67I3DegSb8jnwhASZvxDdB/i
	Ef6OdSDBLay620swyY1zSCOkyyLD+B2dc0mE=
X-Google-Smtp-Source: AGHT+IFlmFFvvzOEGqD3zZggS9+BV6Myy305bT6x5k9dHpIH9uxS64HHIpb2b1bZ2jX4ijZYUsK3W/JSAAahe7Vvf4c=
X-Received: by 2002:ac8:5a46:0:b0:460:3a44:2587 with SMTP id
 d75a77b69052e-4604bbda53cmr291252231cf.34.1729116496082; Wed, 16 Oct 2024
 15:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <17FCBD68B18E5703.22523@lists.cip-project.org> <OS9PR01MB1238945B29EF3F4A00C31B355B77F2@OS9PR01MB12389.jpnprd01.prod.outlook.com>
 <Zw4uFWi6kWekKeCd@duo.ucw.cz> <OS9PR01MB123893C05CD686E7DE75B14C7B7452@OS9PR01MB12389.jpnprd01.prod.outlook.com>
In-Reply-To: <OS9PR01MB123893C05CD686E7DE75B14C7B7452@OS9PR01MB12389.jpnprd01.prod.outlook.com>
From: Nobuhiro Iwamatsu <iwamatsu@gmail.com>
Date: Thu, 17 Oct 2024 07:08:05 +0900
Message-ID: <CACe6DC6p+G47ET8XSrk4X+WpjuKKqQZkC8p+jj8WUg80At2XqQ@mail.gmail.com>
Subject: Re: [cip-dev] lab-cip-renesas offline
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Oct 2024 22:08:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17045

Hi all,

> [0] https://lava.ciplatform.org/scheduler/device/de0-nano-soc-03?recent_s=
earch=3D&recent_length=3D100#recent_
> [1] https://lava.ciplatform.org/scheduler/job/1205245
> [2] https://lava.ciplatform.org/scheduler/job/1206169

https://lava.ciplatform.org/scheduler/job/1206169#L394
```
[...]
bootz 0x01000000 - 0x02000000
SOCFPGA_CYCLONE5 # bootz 0x01000000 - 0x02000000
[...]
```

load address of DTB is wrong.

Does that worker use old lava-docker?
  https://gitlab.com/cip-project/cip-testing/lava-docker/-/commit/517737f75=
c556b4d204d0fe2445c23dacbd494c2

Best regards,
  Nobuhiro

2024=E5=B9=B410=E6=9C=8815=E6=97=A5(=E7=81=AB) 22:46 Chris Paterson via lis=
ts.cip-project.org
<chris.paterson2=3Drenesas.com@lists.cip-project.org>:
>
> Hello Pavel,
>
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Pavel Machek via lists.cip-project.org
> > Sent: 15 October 2024 09:56
> >
> > Hi!
> >
> > > > lab-cip-renesas is currently offline (since last night) due to some
> > power
> > > > issues.
> > > > Hopefully it'll be back online later today or tomorrow.
> > >
> > > All back online now :)
> >
> > I still see failures like this:
> >
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> > /jobs/8086067433
>
> lab-cip-renesas doesn't have any de0-nano-soc boards.
> We were seeing some issues with other labs, but now we have 2x de0-nano-s=
oc available from lab-cip-denx.
>
> >
> > Other branches show test:arm_multi_v7_defconfig_de0nanosoc failures,
> > too.
>
> Interesting.
> The de0-nano-soc device seems to be working from a LAVA point of view, it=
's just the kernel that isn't loading.
>
> If you look at the job history [0] for one of the de0-nano-soc devices yo=
u can see that it's booting okay for various kernels, but not all of them.
> multi_v7_defconfig seemed to boot okay with 6.12.0-rc2_d3d155669 [1], but=
 not since 6.12.0-rc3_6485cf5ea [2].
>
>
>
> [0] https://lava.ciplatform.org/scheduler/device/de0-nano-soc-03?recent_s=
earch=3D&recent_length=3D100#recent_
> [1] https://lava.ciplatform.org/scheduler/job/1205245
> [2] https://lava.ciplatform.org/scheduler/job/1206169
>
>
> Kind regards, Chris
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17040): https://lists.cip-project.org/g/cip-dev/messa=
ge/17040
> Mute This Topic: https://lists.cip-project.org/mt/108905694/4520494
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/13258555/45204=
94/222682861/xyzzy [iwamatsu@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--=20
Nobuhiro Iwamatsu

