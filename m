Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7ABEB64D9
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 11:53:30 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
 by mx.groups.io with SMTP id smtpd.web11.16142.1686830002793190844
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jun 2023 04:53:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=1FcMUhV4;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.44, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-55b38fc0c70so1406126eaf.0
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 04:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1686830001; x=1689422001;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjL4TT6lduqrX4Ue5FDQzOGr/CQMwhpmR0YYHeEeNPA=;
        b=1FcMUhV4yTfEkZCQjfpwXPnnsfr0MuzTBH0JurFGH3zCi7bOIBaIfq1V8GaRU+wbjv
         k5DT523GIlGusm5pw8T5TUBPwtWF3iRp+ExwLJ/JrTESx9tFJU2l5p14cpyY8wmaeAYV
         zoEw8y5rQ5ss4xJvuQLjz9PoWFfdWQVd41BPhehxcg3XW+dlPsOeEA+DUiRyG3D2FnUW
         LK5AIh+EMaOkqFn/9TzwJpynP8Pzqc5tBzksLxscXFIy3bjRxi+g+eEumFhOe1QDoTi9
         cjTtHakJN3m7H5dmAegnN6rLShHWjaYmBXT7r8k/ZJcjtPSgyAr8LRL1sndzB0oxtbeY
         +P4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686830001; x=1689422001;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjL4TT6lduqrX4Ue5FDQzOGr/CQMwhpmR0YYHeEeNPA=;
        b=TjcfPxpEeWnJMR/VJ06uWCbyaYpHHQz+g1mHY2a4sD0RhcogYYeHofFsEXBSrFfg/K
         SRly+nZU8pRMJ9RuuGbw28a7O9OYdlvxt+KttuR75O+qCK5Gh+1oLLkQKpk0D0JJjN/0
         0EbFjLW8lkBIpNdzJG6ykzHHCvbVLk+y/Z3YbpV+QC3aHqW1W3x7ksbLsxU8Fp/GwhgK
         DWdsGmpdh7Pe55SIxEulI9u1Bo6CW/VHeY85IMXxV5vskIPViptIYSUwRMkJ8aUh8IDF
         6YsfxQlaukQl6lQHDyFxRcVqRPSaJ4H8CYr+wQvKu5Nt1abF9mmV9VFFfPgWgwhdLgLM
         71KA==
X-Gm-Message-State: AC+VfDyaKfC6/JSGzPszGL62dzU0XASjT4sBg77QsGAa/dKiFD41fTNf
	NzNsYhKBy891NfF1/xM2X7CwDttsghRqf3Nkt5juUK8PKMh8F5mpa4Q=
X-Google-Smtp-Source: ACHHUZ4sEwS+qNNVYEMa/MsnBkRJwGBms+Ullxm1nICcZJWSQLtovjZcZS70xcpcML5xqIX9B78+aakb89w8oeQLg8E=
X-Received: by 2002:a4a:a8cd:0:b0:558:a3c5:86cd with SMTP id
 r13-20020a4aa8cd000000b00558a3c586cdmr11934095oom.6.1686830001303; Thu, 15
 Jun 2023 04:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAODzB9oUr_wN0h73C4aAQg6qk+awCv6QpxD11bME1K4GPJFsmg@mail.gmail.com>
 <ZIrOzbbFV1zmYs61@duo.ucw.cz>
In-Reply-To: <ZIrOzbbFV1zmYs61@duo.ucw.cz>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 15 Jun 2023 20:52:44 +0900
Message-ID: <CAODzB9qe0=gXvYXUQxLcjnvBCJUcRcers9TGNT9oKhKbf1M_Sw@mail.gmail.com>
Subject: Re: [cip-dev] New CVE entries this week
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 11:53:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12056

Hi.

On Thu, Jun 15, 2023 at 5:41=E2=80=AFPM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > This week reported 4 new CVEs and 7 updated CVEs.
> >
> > * New CVEs
> >
> > CVE-2023-3141: memstick: r592: Fix UAF bug in r592_remove due to race c=
ondition
> >
> > CVSS v3 score is 5.9 MEDIUM.
> >
> > The client side in OpenSSH 5.7 through 8.4 has an Observable
> > Discrepancy leading to an information leak in the algorithm
> > negotiation. This allows man-in-the-middle attackers to target initial
> > connection attempts (where no host key for the server has been cached
> > by the client).
>
> Description seems wrong here. Here's better one:
>
> https://nvd.nist.gov/vuln/detail/CVE-2023-3141
>
> A use-after-free flaw was found in r592_remove in
> drivers/memstick/host/r592.c in media access in the Linux Kernel. This
> flaw allows a local attacker to crash the system at device disconnect,
> possibly leading to a kernel information leak.
>

Thank you for correcting this one.
CVE-2023-3141.yml in cip-kernel-sec contains the correct link to this CVE.
I may paste the wrong description.

> Best regards,
>                                                         Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12044): https://lists.cip-project.org/g/cip-dev/messa=
ge/12044
> Mute This Topic: https://lists.cip-project.org/mt/99538378/4520416
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

