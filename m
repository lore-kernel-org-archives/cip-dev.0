Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D0BC3DA7F
	for <webhook@archiver.kernel.org>; Thu, 15 Aug 2024 10:51:08 +0000 (UTC)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.web11.120342.1723719064329849433
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Aug 2024 03:51:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Y2pI9vmE;
 spf=pass (domain: gmail.com, ip: 209.85.160.171, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44fee8813c3so4729051cf.2
        for <cip-dev@lists.cip-project.org>; Thu, 15 Aug 2024 03:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723719063; x=1724323863; darn=lists.cip-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skVR4iPsbPTcHmSNlZk+t90iOkdIgnckM1k7OtfmUyE=;
        b=Y2pI9vmEeK6Qn6IZt036e5kbtxe1gtEd1trgtQKYv76hoiHSzYRRFCUKi0ZyvVbb65
         jOZ0tgRI0Z6MLCmPVcopa2+wST++VHQMJywZ4dBjNPPwCt2spGfUH7HA9XFsKmz0/oGY
         CdoHB1QnkhZtHmHA1fbCRbkLzpeGzxJkFFQQuauBn/9IKim4RHj+h4rqHXY3rH5+JIze
         1SAUyXxz6VOvjwNrQRJXRHSrHd/ZU1N/WIYD1+ww/hVqqe9QYDpOTslT20IKZ879Sa3x
         nUBobQ5aWWfH8sg2wYP9jVTWA37lVPY0zsgTeZDpYr+UNEpFBHsbU7mO81mNMYKVQJ1/
         zzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723719063; x=1724323863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skVR4iPsbPTcHmSNlZk+t90iOkdIgnckM1k7OtfmUyE=;
        b=lkFa4PjdhjEiAFwIW8eoTG0/7o6Spd/bOb++PBQ2/1HCmU05/smlFiLOQXxdJIYWIt
         0OfADv3B8R9bajFcuLx8kDxvqTxDfEVeinY1Iphtc7eckX8yHX3yUtAE0kZlxLv6vQqF
         zhUmQRtpvOOE11ByaXhf3B286LDtuFYBwZHk19BhkNZToEwZcqcacP0g9H1FN+3ZKa13
         SxfOvk7vn6+cYPFmQusUTX7Gk7D1kDz/93ePN+WDAI2q7nJYhgAbpMbPtKjjHsi7Ajm/
         Oz8iqCWL8/pM6FJ1x20cnegKfasuL85NaAmNIdiDqxpoNq+76Pjt5Ij/6JmK2qnoOuK0
         IBlQ==
X-Gm-Message-State: AOJu0YxtAXybBqlb8MlTbHV5qEa3yKYHL5CJNi5muIPmQh2F56k+xkaY
	qfXdkBzL4SKkyRpotntRLZkfsodPUB3lQr9m1NTTmWhXvrlXOLqOVBC1SdIfnj4cEci7ij/jTQP
	yMB5u+TOSE/X3X1WYVQ6hH/GNFqiHZ2/c
X-Google-Smtp-Source: AGHT+IEQPLRo+4du6+QyMwVms9+h/UqHIc63fgBjjmO4KfzUtu9arElc8dUQWEqDS9mXlBfxh6TC9CN3IkWgx++X4L4=
X-Received: by 2002:a05:622a:4c05:b0:453:4b39:c740 with SMTP id
 d75a77b69052e-4535ba9b35emr63119481cf.5.1723719063129; Thu, 15 Aug 2024
 03:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <OS0PR01MB63887DCF9F2F6CB68BFD718E92BA2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <ZrfMq6o3hhYAzfLQ@duo.ucw.cz>
In-Reply-To: <ZrfMq6o3hhYAzfLQ@duo.ucw.cz>
From: Nobuhiro Iwamatsu <iwamatsu@gmail.com>
Date: Thu, 15 Aug 2024 19:50:52 +0900
Message-ID: <CACe6DC6Z4n_jSSneCjiSLv+-9ru7_YhUdueKuhauc4+mmGe15A@mail.gmail.com>
Subject: Re: [cip-dev] [ANNOUNCE] Release v5.10.223-cip51
To: cip-dev@lists.cip-project.org
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de, jan.kiszka@siemens.com, 
	masami.ichikawa@cybertrust.co.jp, uli@fpond.eu, Chris.Paterson2@renesas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Aug 2024 10:51:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16791

Hi Pavel,

I was not aware of this email due to vacation.
Thank you for the 6.1y-cip release.

Best regards,
  Nobuhiro


2024=E5=B9=B48=E6=9C=8811=E6=97=A5(=E6=97=A5) 5:25 Pavel Machek via lists.c=
ip-project.org
<pavel=3Ddenx.de@lists.cip-project.org>:

>
> Hi!
>
> > CIP kernel team has released Linux kernel v5.10.223-cip51.
> > The linux-5.10.y-cip tree has been updated base version from v5.10.221 =
to v5.10.223.
> > And this release includes patches for Renesas SoC and its reference
> > board.
>
> Thanks a lot!
>
> Next due is 6.1-cip-rt. We do have v6.1.102-rt37, but v6.1 is at
> v6.1.101-cip25. So, unless 6.1-rt is released, soon, my plan is to
> release v6.1.102-cip26, then do -rt release on top of that.
>
> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16767): https://lists.cip-project.org/g/cip-dev/messa=
ge/16767
> Mute This Topic: https://lists.cip-project.org/mt/107804929/4520494
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/13258555/45204=
94/222682861/xyzzy [iwamatsu@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--
Nobuhiro Iwamatsu

