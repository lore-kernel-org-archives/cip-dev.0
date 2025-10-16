Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C46CCD194
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 06:25:49 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
 by mx.groups.io with SMTP id smtpd.web11.2091.1760595946777117069
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Oct 2025 23:25:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=BbBtHPRp;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.176, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-781421f5be6so4997497b3.0
        for <cip-dev@lists.cip-project.org>; Wed, 15 Oct 2025 23:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1760595946; x=1761200746; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpoIUV7JcG1ALL7dHCZB6SKXG8ZGhfy7V0AhjSaekso=;
        b=BbBtHPRpI/a778S+VCgAUUKWj4ljRavqRvG4POg8pcyXgMRQXX5fjFSdrQi6yyyqfi
         xsnngKYqhdq1UudJdySUOb01gqqC0ypRIH1X+x/tVs1hyjl/v18eLuvZr6NVQqquImtK
         rThLqGoWJuSp5op8Aby1pRDj2xtAxo0fs5BDmlmOfftqbhVt6P534L6DvsgZ2BcRhmIm
         v8oW32rqBeDfjpnVzkANMqixpDnxUsOOCPYLV+Dx4WvPJTuTo92+MOcDf70RpGC3h3Ir
         sVITTtXqWN3shn5BJDMbADt9wR+tWQKxilkNUWLTQqBn3hupdk1nxMFiucDBpLipVlFZ
         dMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760595946; x=1761200746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpoIUV7JcG1ALL7dHCZB6SKXG8ZGhfy7V0AhjSaekso=;
        b=AG2/Vs9lvhDAqMp9Sie61zd6msRdyl5a4ij3BHb1dg86JfLMSWuhOl2ulhKs5p4nW0
         nScpAwA/TsdgEve9xtDmlruRbUCe1+GOoyYMuK1zcbpR2rk30ESmmJ6BVV9y0k4R0lws
         /Nzf7wRuSBRxA3bX00DDPd02H06/0L1fzLbx5iqLrynl5GPOIB0/BlsrI/zKjE8L9a2F
         POiQvB6OfxzmUkN5Ln1sFzyIYCf9TztsVeZwaAFQjYiAYjZdggxm+/xXeOA4zg5nZ5vV
         Ld7sbrsNSgoE6a9OSlVjh9eNwHoWpPEi72V/+j+L/whbpPnd9FoNk249tmIx6tGuqv7u
         Q4Fw==
X-Gm-Message-State: AOJu0YzA48ty+romsP5yxuBL/rk+iAGBR9uvpLEuGDjYfWVCXUagc/K+
	ypvsE9bjKuyUfCCTGmDEcsMXS75dWGn6JWEz8Ja+eL+uijDL55yiEOC4hn/f9NxFyi3LD2u0oh1
	dV1y7VaNKiHEzopg11NibgpOLYBaDf5RPzXNBVa22tQ==
X-Gm-Gg: ASbGnctUh0j0wRHaPthg+knRVRab3FD+PftWEOGqUBpEjKjRfaYsVEOyIoK7usTQ1Ap
	N5a4wiCMZ0NCYfiZr5g6kFTG/Z7Nl4t/rA7N2SkDqrBR09McPciSyZ1FT+oTLqiQJeA6Fb6ZBFG
	OGyivYytDeXBczcpWDeBkl8URQWyS36O01mSiqJGLT4IjccDFr0mkAbO0YsNVc9zzLSTsPn42jA
	1ei+Kq2QnFEf6IAe/rFOaCcYXnWsMAZfPBQhP7/tcp/N6uKtXHXeY1E5Hf1g2omMBEQMaqOq/U/
	VPz8QhI=
X-Google-Smtp-Source: AGHT+IHGX1709mkk2sjfHfZexY9wHgzPwx00emtRYrJvNIj6N7//h1D6yyk0O9ovS/lCtmETxcJ8BnArDxG0Zs/COSg=
X-Received: by 2002:a05:690e:c4a:b0:63c:f5a6:f302 with SMTP id
 956f58d0204a3-63cf5a707e3mr15695761d50.68.1760595945772; Wed, 15 Oct 2025
 23:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <fb148554-926a-4363-bead-0e451fa655e0@siemens.com>
In-Reply-To: <fb148554-926a-4363-bead-0e451fa655e0@siemens.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 16 Oct 2025 15:25:10 +0900
X-Gm-Features: AS18NWBk7DVQ-5nfWfP0eNit34ZaSM2bjrPkbK_T0xMyaxi8YiqjIgkELfUXiyM
Message-ID: <CAODzB9rOPk1-Xsq7ycbDNOZiQ20hNtM3iEqCNVOmH+_A=CNFVQ@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: jan.kiszka@siemens.com
Cc: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Oct 2025 06:25:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20183

Hi,

I'm sorry. I'll be absent today.

On Thu, Oct 16, 2025 at 3:13=E2=80=AFPM Jan Kiszka via lists.cip-project.or=
g
<jan.kiszka=3Dsiemens.com@lists.cip-project.org> wrote:
>
> Hi all,
>
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
>
>     irc:irc.libera.chat:6667/cip
>
> The IRC meeting is scheduled to UTC (GMT) 13:00:
>
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2025&mo=
nth=3D10&day=3D16&hour=3D13&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=
=3D37&p5=3D241&p6=3D248
>
> USWest    USEast    UK        DE        TW        JP
> 06:00     09:00     14:00     15:00     21:00     22:00
>
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/10/cip.2025-10-09=
-13.01.log.html
>
> * Action items
> * Kernel maintenance updates
> * Kernel release status [*]
> * Kernel testing
> * AOB
>
> Jan
>
> [*]
> Date the data is created: Thu Oct 16 06:12:34 AM UTC 2025
> linux-4.4.y-cip: interval 30 day
>   latest version release date: Mon Sep 29 02:11:50 PM UTC 2025
>   limit date: Wed Oct 29 02:11:50 PM UTC 2025
>   Status: On track
> linux-4.4.y-cip-rt: interval 60 day
>   latest version release date: Sat Sep  6 09:10:31 AM UTC 2025
>   limit date: Wed Nov  5 09:10:31 AM UTC 2025
>   Status: On track
> linux-4.19.y-cip: interval 30 day
>   latest version release date: Mon Sep 22 08:38:34 AM UTC 2025
>   limit date: Wed Oct 22 08:38:34 AM UTC 2025
>   Status: On track
> linux-4.19.y-cip-rt: interval 60 day
>   latest version release date: Tue Sep 23 10:53:07 AM UTC 2025
>   limit date: Sat Nov 22 10:53:07 AM UTC 2025
>   Status: On track
> linux-5.10.y-cip: interval 30 day
>   latest version release date: Wed Oct 15 11:57:26 PM UTC 2025
>   limit date: Fri Nov 14 11:57:26 PM UTC 2025
>   Status: On track
> linux-5.10.y-cip-rt: interval 60 day
>   latest version release date: Fri Sep 12 01:11:18 PM UTC 2025
>   limit date: Tue Nov 11 01:11:18 PM UTC 2025
>   Status: On track
> linux-6.1.y-cip: interval 30 day
>   latest version release date: Wed Sep 17 11:15:11 AM UTC 2025
>   limit date: Fri Oct 17 11:15:11 AM UTC 2025
>   Status: On track
> linux-6.1.y-cip-rt: interval 60 day
>   latest version release date: Wed Sep 17 07:30:39 PM UTC 2025
>   limit date: Sun Nov 16 07:30:39 PM UTC 2025
>   Status: On track
> linux-6.12.y-cip: interval 15 day
>   latest version release date: Thu Oct  9 07:01:15 AM UTC 2025
>   limit date: Fri Oct 24 07:01:15 AM UTC 2025
>   Status: On track
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#20182): https://lists.cip-project.org/g/cip-dev/messa=
ge/20182
> Mute This Topic: https://lists.cip-project.org/mt/115785107/4520416
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [masami.ichika=
wa@miraclelinux.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

