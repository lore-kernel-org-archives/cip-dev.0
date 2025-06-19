Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1866C7115A
	for <webhook@archiver.kernel.org>; Thu, 19 Jun 2025 13:48:54 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.web10.15549.1750340927850131780
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jun 2025 06:48:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Lc8EQ9Ir;
 spf=pass (domain: gmail.com, ip: 209.85.160.182, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a43e277198so3931461cf.1
        for <cip-dev@lists.cip-project.org>; Thu, 19 Jun 2025 06:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750340927; x=1750945727; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xToX+BCsU44D+Uv0+V7U/42bWzd7dHzH8jDiJuBipNE=;
        b=Lc8EQ9IrRkDPX/1XTAWoGenJ3wpyLlyS2A5JQgnpbfFA5JOfle4rMW9wQiNJ7WLrfe
         X2CqovGe+oZVW8kL5YHQSyeqF+Qc/UI+HDGsc1/juH6+vC4rNaus/l8S14+3c19V7Vfz
         6dMqt8LMwwN4I+xzLF4W+Fm2SsvHcndqfyy8IWoYt4aCq+jLAKNmxBbe+QHQEV+RFrS9
         dNrNUqqC45NngutA79kEGfA3v7VqiWDoXV9e5S6RuH1dzPbCzPfG1iAK92xNNoe6SRR/
         XG71R/qLBdHXIZnNritrCdI+NTUuOrONzQ6wmxm7FLIfhJ0GI0XGSr99GhX2gT8o/gV1
         cn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750340927; x=1750945727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xToX+BCsU44D+Uv0+V7U/42bWzd7dHzH8jDiJuBipNE=;
        b=cMDoyP6hQdtU9mqNKi4t32Hhx5Hqi3qUkqI1zOFBywb5JQo5ohNwERbvI21ycn0IzI
         LLbJM35ZIQPSYULTUW7Yrncgz9mXsMKzqwjsJ8VsZX3eKnWFRKlWb0jsLKiEd08e+5kr
         mh8+ZID7ertCBa9+QmDLPKcuYcSWTPCjbE/GJrDbMYazOpEDAyyq3PhbJP4cDiV/2n5v
         bUQE1Mby3vM4f0Dtuwepx15pxGYKiKx0KWwEOSRtX60AtF0WBRalc+BIWQITJq/8BAIq
         pcOg67gvfsEetaqtErgYG6PdROGixxAD+LeUtA0GS/jEAZf1yV++cMWnzL+RriCQd/9O
         SF7g==
X-Gm-Message-State: AOJu0YxgqsNdXglta8ugp9XDavIn256AJakJvrvSfsEFpK99+XYwJev0
	jGto7211aSgcVrI3lE7PIomne0R5TK3W9qCv8q72QDfJYyDN8q4xT6RaNQIm0YM+s6UAm0NWo5I
	XsdkO610zkm31H5yRj9Lu/nPRbo7R/Xk=
X-Gm-Gg: ASbGncvi/N3SLx7rTA0AJZFlPrYYssgR14iUJo0OWVRcpKK0nd59jUdzJdNCaz1QFr3
	HGsdRZj5xtcrLVuxi/I8k6xusg1nK+Y9gQHbbQBiMn62CiRwxolI2LjOGs/AH+zeo9Tonvihneq
	wIIYvTaThEwI1gr4PiPtuQETYb1Z0uxSBnbbKabvsE
X-Google-Smtp-Source: AGHT+IF6o7J3TlNPk0lTeH45vOGFhlSeG7qMnCf/RIOcQziDawSP+jhZddBAPTHKWxOUOigPPRecHX6RLvt/6KXNmcM=
X-Received: by 2002:ac8:594e:0:b0:4a6:ef76:c265 with SMTP id
 d75a77b69052e-4a73c5a7dc7mr289071821cf.36.1750340925937; Thu, 19 Jun 2025
 06:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <184A639C5862A401.23068@lists.cip-project.org> <aFPR0THrbjSZ5m8B@duo.ucw.cz>
In-Reply-To: <aFPR0THrbjSZ5m8B@duo.ucw.cz>
From: Nobuhiro Iwamatsu <iwamatsu@gmail.com>
Date: Thu, 19 Jun 2025 22:48:35 +0900
X-Gm-Features: AX0GCFsUJZgf_HDBDmIA6pY-FyW8ALrd_2a0S5-uNXDrRGRoq8LOdt4yqYv4HiY
Message-ID: <CACe6DC5N2ZHbYrEsPp-3reo7uy+iZ1NYmAPEvhdnhUo8Sc=rpw@mail.gmail.com>
Subject: Re: [cip-dev] Testing 6.15, bbb target has problems?
To: pavel@denx.de
Cc: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jun 2025 13:48:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19140

Hi all,

I've looked into this issue a bit.
It appears that this issue has been fixed upstream
(929d8490f8790164f5f63671c1c58d6c50411cb2).
The patch has not been backported to 6.1.y or 6.6.y, where the issue exists=
.
I will apply this patch and test it.

 - 929d8490f8790164f5f63671c1c58d6c50411cb2
 - b9bf5612610aa7e38d58fee16f489814db251c01
 - 623cef652768860bd5f205fb7b741be278585fba

Best regards,
   Nobuhiro

2025=E5=B9=B46=E6=9C=8819=E6=97=A5(=E6=9C=A8) 18:01 Pavel Machek via lists.=
cip-project.org
<pavel=3Ddenx.de@lists.cip-project.org>:

>
> Hi!
> >
> > 6.15.X is out, it would be nice to start testing it.
> >
> > Plus, I see bbb failures way too often. Any idea what is going on
> > there or how to debug that:
> >
> > One example is here:
> >
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelin=
es/1874747536
> > https://lava.ciplatform.org/scheduler/job/1282821
> >
> >
> > [    3.556545] Sending DHCP requests .
> > [    3.567340] mmc0: new high speed SDHC card at address 0007
> > [    3.579884] mmcblk0: mmc0:0007 SD4GB 3.71 GiB
> > [    3.590452]  mmcblk0: p1
> > [    3.600982] mmc1: new high speed MMC card at address 0001
> > [    3.607395] mmcblk1: mmc1:0001 MMC02G 1.79 GiB
> > [    3.615388] mmcblk1boot0: mmc1:0001 MMC02G 1.00 MiB
> > [    3.622199] mmcblk1boot1: mmc1:0001 MMC02G 1.00 MiB
> > [    3.628670] mmcblk1rpmb: mmc1:0001 MMC02G 128 KiB, chardev (236:0)
> > [    6.136382] ..... timed out!
> > [   86.523950] IP-Config: Retrying forever (NFS root)...
> > [   86.529327] cpsw-switch 4a100000.switch: starting ndev. mode:
> > dual_mac
> >
> > seems like a network problem.
>
> Another example is here:
>
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines=
/1875019823
>
> I can retry, but it can take more than one retry to get it to pass.
>
> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19139): https://lists.cip-project.org/g/cip-dev/messa=
ge/19139
> Mute This Topic: https://lists.cip-project.org/mt/113722233/4520494
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [iwamatsu@gmai=
l.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--
Nobuhiro Iwamatsu

