Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80524C6FA8F
	for <webhook@archiver.kernel.org>; Thu, 24 Aug 2023 11:53:35 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
 by mx.groups.io with SMTP id smtpd.web10.9009.1692878012964621070
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Aug 2023 04:53:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=42t8xgXN;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.43, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6bca857accbso5064852a34.0
        for <cip-dev@lists.cip-project.org>; Thu, 24 Aug 2023 04:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1692878011; x=1693482811;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6kmLetCYpL+crUvsjsWZ8Fsq1wK0C7Zazip1kBCQYs=;
        b=42t8xgXNtSLmpIbmn+GhgGrEdxC3M6i2tB6r9n+GQ3A5k2f6BVDc51UKzdtWBRCZt8
         K7clJQ0Ey9APcIc7D4N/gOlx7aeOl8Gd5RIMbfIHMqdAuUzTov9xDnUzLJ91SgXLTnvO
         PXRHQNZfdJ+pHKwRzIAN0vLubogYz/MJCRopEKerRYoxKjIbNXPJlJwKuSwM9/xue/fE
         IziX+sgWHRWKRQVT+1DVj/qxYBzoWfzx0YCmafSvnFCDJD8+9QpYbbUMI1JnLZLcHPgE
         Slm5ypjbkM1XjvJeztfSfg9J4m2ZTmUT0luyWi0SG9uS86vSHDXCinHAg3v0iS554lyU
         YIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692878011; x=1693482811;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6kmLetCYpL+crUvsjsWZ8Fsq1wK0C7Zazip1kBCQYs=;
        b=I2Mcx95ph5G2OFgGCen1vl1MAw1DmkR7zx3lRur7gn0TOUakF2DxE2gTMGfJ+2s4u8
         hVH59xCO/PzYHu5Vb7tU1jwUZe0XKjW1RxsU6olHOkkYmvHP1jGaWWPu3RJDfz76Cw7g
         Vn0dqiVXR4UxkLGS2hcLpPOG/S4iZEaqCjQe8ekGZIYN9++xpeVJKghwjn2iRxrA8sQc
         XnDdDgC1VmJD3Qr/K8gm1Iog47XSzJrBYxRBosYWNOSdS0ZfZIbBwC8ozVzlqlL9Qh6a
         7DrGhmwynUOhT6LYeXuvXjTRCc/H2fkZQ4OdvDBBJt/abVMIgpG1+l5ChpxnvGB0yQSg
         AjAw==
X-Gm-Message-State: AOJu0YyCDebjoB4rUFvLd+cVMAvNls7Z/ONgjo1QDbPihZGcbJxQMIa0
	QdSTulDkb6sLUYp53gAezFrXfC1Raq41I+P54SAJvHg/17y29WAU
X-Google-Smtp-Source: AGHT+IHqQkJXBFH4m5bLChV66oAwBGYYo+CjPPNMToKBtlhjp3cm6G9PTIwP+7D5GXbfVuP9eHtlEeDvama7wIF8Klg=
X-Received: by 2002:a05:6870:41cd:b0:1ad:4c06:15c with SMTP id
 z13-20020a05687041cd00b001ad4c06015cmr17037836oac.18.1692878011207; Thu, 24
 Aug 2023 04:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAODzB9orgFUeGCfjL4BeDmEazgTDSJg_SNrtCxbvOSDcoFiviw@mail.gmail.com>
 <ZOc448J0V1kIRFzl@duo.ucw.cz>
In-Reply-To: <ZOc448J0V1kIRFzl@duo.ucw.cz>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 24 Aug 2023 20:52:54 +0900
Message-ID: <CAODzB9q7TuAcVP=nH7forjsSsD=QZWOLF+WDP-bLSOZ4cKO42g@mail.gmail.com>
Subject: Re: CVE-2022-40307 was Re: [cip-dev] New CVE entries this week
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Aug 2023 11:53:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12847

Hi.

On Thu, Aug 24, 2023 at 8:03=E2=80=AFPM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > When I was reviewing CVE-2022-40307, I found commit
> > 7f7838c92740fa423a5a3f12c00ed02d92851254
> > ("efi: capsule-loader: Fix use-after-free in efi_capsule_write") is
> > not in the cip/4.4-st.
> > However, this commit exists in both cip/4.4 and cip/4.4-rt.
>
> Let me investigate. 7f7838c92740fa423a5a3f12c00ed02d92851254 is
> signed-off by me.
>
> It is in v4.14 as:
>
> commit 233d5c4d18971feee5fc2f33f00b63d8205cfc67
>     efi: capsule-loader: Fix use-after-free in efi_capsule_write
>     commit 9cb636b5f6a8cc6d1b50809ec8f8d33ae0c84c95 upstream.
>
> According to our scripts, our configurations do not compile this, at
> least in 5.10.
>
> It is in linux-4.4.y-cip: 7f7838c92740fa423a5a3f12c00ed02d92851254
> (not having "upstream) marking. My fault, I guess.
>
> It is not in linux-4.4.y-st, but we should have it in our -cip trees
> and it is not that important, anyway.
>
> I propose we leave it as it is.
>

Thank you for investigating.
I got it.

> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12846): https://lists.cip-project.org/g/cip-dev/messa=
ge/12846
> Mute This Topic: https://lists.cip-project.org/mt/100932945/4520416
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129101/452041=
6/1465703922/xyzzy [masami.ichikawa@miraclelinux.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

