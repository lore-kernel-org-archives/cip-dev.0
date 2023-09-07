Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2B1EE14D3
	for <webhook@archiver.kernel.org>; Thu,  7 Sep 2023 06:08:16 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
 by mx.groups.io with SMTP id smtpd.web10.7135.1694066888314000422
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Sep 2023 23:08:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=WCyOC9og;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.175, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3a7ca8720a0so417225b6e.2
        for <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 23:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1694066887; x=1694671687; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xW5+eUBTvEeTK/AldzUuYymWiB5GIlBM/MXOFb9PvKg=;
        b=WCyOC9ogow1Cetd2IzEVa87U+ED6oYvHALTMhoXCJUNp0Yikfdoi7rIK8M1C7YmYpN
         vGkX2Ws9Y8KY+hcnkoAShth9uyl6J+A56ZPHYXB6UT8TK/j8G6pF+aOdpT/FGf00q0Kv
         jLnQ0pcI9Gyy8Sn8lBtUE7ykQwf0AqH7/oSvhE90JXxbmoziAbP+9SS9Z7mr3gPxq1br
         Bd97yUraG2bYPmqUHI04gUdhhGAjg8+/gsGNl22F1KafdfCxPdpZCNS0laTsF7VMsfil
         D5QFcVc2U42PaUQOWXEPjNI5tvvogDD8T/+cijlY1PVP6R6rbkBEvXUb4ttDnGPmPgwb
         xVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694066887; x=1694671687;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xW5+eUBTvEeTK/AldzUuYymWiB5GIlBM/MXOFb9PvKg=;
        b=HjXeVfp2Qb+h/Oxcx+f2FAgA6DUn1g0JZjFyAAvuhDOc/jHaNfZOTHONQn60YXvMlk
         Gmj3/1CoZAWRtwSt0+nkNExyO+3FzcxWrbfAgJuaS1wkUtH2VjDG9bpXOu73Iuy9aYWs
         pQPsT99lYjZ/sM3XEFX8rBP6PR5u/xesGr93yx+htSr1ElsDUO+nsWz+yc31klo7K1/o
         7XryLe6bHJtmKm9tx9+O4+zesD3zxrw1Mke6OTwA9KUt0+4OCWKCD3ZO3AB164feiZLr
         wKoerH5AfuMszpaoWOHhBwWjlPaMBHgJaRjcl/e48ywJVjpSWGZ3leN9ZTZZ9z1MM4x7
         S9bQ==
X-Gm-Message-State: AOJu0YyE3HhQ69AdENO1lwUXDj1PE1dtcIF0QxcQ4M2X8/HqR68Q/8Yi
	y0vcJ7iagLKno8ADemMZ4hupWHWUDAq95r54IciTi68+0wxamqvA
X-Google-Smtp-Source: AGHT+IHFtHcxr0/PctwDU2kUjYJjo+lVnvljV/Jagq50pamzcbs75xiR/7IBxef7C4m/YDMVUccKhFENkhLYsf73c/M=
X-Received: by 2002:a05:6808:5:b0:3a7:215c:e34 with SMTP id
 u5-20020a056808000500b003a7215c0e34mr19558624oic.15.1694066886737; Wed, 06
 Sep 2023 23:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <261b35bd-3e2e-4841-a6ce-b6e95479c131@siemens.com>
In-Reply-To: <261b35bd-3e2e-4841-a6ce-b6e95479c131@siemens.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 7 Sep 2023 15:07:31 +0900
Message-ID: <CAODzB9rea_9fEcJws+yNOR00v3P9mXb+rGTX5DMryW1QT=nKYQ@mail.gmail.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Sep 2023 06:08:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13000

Hi.

I'm sorry. I'll be absent today.

On Thu, Sep 7, 2023 at 2:46=E2=80=AFPM Jan Kiszka via lists.cip-project.org
<jan.kiszka=3Dsiemens.com@lists.cip-project.org> wrote:
>
> Hi all,
>
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
>
>     irc:irc.libera.chat:6667/cip
>
> The IRC meeting is scheduled to UTC (GMT) 12:00:
>
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2023&mo=
nth=3D9&day=3D7&hour=3D12&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D3=
7&p5=3D241&p6=3D248
>
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     13:00     14:00     20:00     21:00
>
> Last meeting minutes:
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/08/cip.2023-08-31=
-12.01.log.html
>
> * Action items
>   1. create kernelci pipeline for buster images (arisut)
> * Kernel maintenance updates
> * Kernel release status
>   - 4.4
>   - 4.19
>   - 5.10
>   - 6.1
> * Kernel testing
> * AOB
>   - kernel.org tarball hosting
>
> Jan
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12999): https://lists.cip-project.org/g/cip-dev/messa=
ge/12999
> Mute This Topic: https://lists.cip-project.org/mt/101209604/4520416
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129101/452041=
6/1465703922/xyzzy [masami.ichikawa@miraclelinux.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

