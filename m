Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBD0C7EE22
	for <webhook@archiver.kernel.org>; Wed, 17 May 2023 23:02:03 +0000 (UTC)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
 by mx.groups.io with SMTP id smtpd.web10.2124.1684364519083415170
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 May 2023 16:01:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=E1NSxdae;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.172, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-394690088acso1060805b6e.0
        for <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 16:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1684364517; x=1686956517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbMi//8SwPUtSBzApfy5+3G3VC/AXsRE47MApBp6zz4=;
        b=E1NSxdaeB9wqplmJL9D1I2qc5wCI/X+b18pc4E+ly+9hnfQCTE+kTwzYnc+Q9y2U24
         liMCQ179sbMpNYBJkFdy6JZ/u2DzmzVxA4D8zii9+huqicSBRgRd9KlTC2kwxK8liZuX
         gSzEm8iUgNDdxrxRZXkU0O+hyHCAWoVtteY84Hi+9Fm7BUNZ6ZsPfJm/OJ6CA4Rkwoc8
         n+CU5y4og1MDdRXxELXrhZAfI4U0N6I77uC2m3TNqnBl1S7JkARk0mcfUncnu+uUcQ5/
         77+T8mHFZgdzgpKKEbl9O73nYCmzq5dtwXZ4VMppZG59floz46VtCRfDbmA7lB2AC5kb
         a0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684364517; x=1686956517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbMi//8SwPUtSBzApfy5+3G3VC/AXsRE47MApBp6zz4=;
        b=g4VE2Qt3a8gTWTeElWaH23wTwebiAQ+hgfhyqtywzecSSX6Rnhy+kouMyJvwe1TlGw
         hl5Kh3Y7M2r84Ug/xUSbVfjI0/9Rr8LWXSTBGSKQDMlO6RfuYiSIVtP/vQlVPH5WfbeM
         GcGhLwLkgmp6BUPULuPMZQT676Fy5UqexS9rr9c5hSqYNgrnyNG9KKGOPMGjcItrxC8T
         ZoxwcH4jHxBDR5e/uKD6ioobI7wjqfkkRY3QJEUvLrQ7krNKVp2139ndJMxthoDPFYbY
         6LUAb/MkDQoo9kdtG01AkDoCaTkVaTtQsOaIVGN43WJeOWbWc0hKaLGzvVsG7SnrITl+
         p37w==
X-Gm-Message-State: AC+VfDzaK9m6l7yItrPJxja7Dpr7NdoqtG29Kn5pkgJsshU6IHFrvqiY
	70UyxI5AYdjkaPqFIufvCwUEjOwA34dskowaqNl1jrJvYenK0jKf
X-Google-Smtp-Source: ACHHUZ7aTIhtSQbYWcRidKutPmsao+yE3V2u1TiePFsQT1baX6pVIz0oD6DFrlR7JlQdBD1VZ+S2gYU+CRUpQTxWQxY=
X-Received: by 2002:a05:6808:14d0:b0:394:31c9:2ee2 with SMTP id
 f16-20020a05680814d000b0039431c92ee2mr222580oiw.40.1684364517594; Wed, 17 May
 2023 16:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <08f9b5e5-e68d-7105-6e15-c742abb0c563@siemens.com>
In-Reply-To: <08f9b5e5-e68d-7105-6e15-c742abb0c563@siemens.com>
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 18 May 2023 08:01:20 +0900
Message-ID: <CAODzB9qqmXVQFtbi6tzc1pZ+aq5EsUnh5FzjF4pZx1=Q_goOXQ@mail.gmail.com>
Subject: Re: [cip-dev] gitlab oddities again
To: cip-dev@lists.cip-project.org
Cc: Chris Paterson <Chris.Paterson2@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 May 2023 23:02:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11509

Hi.

On Thu, May 18, 2023 at 2:07=E2=80=AFAM Jan Kiszka via lists.cip-project.or=
g
<jan.kiszka=3Dsiemens.com@lists.cip-project.org> wrote:
>
> Hi Chris,
>
> remote:    Your push has been rejected, because this repository has excee=
ded
> remote:     its size limit of 0 Bytes by 140 MB. Please contact your GitL=
ab
> remote:                   administrator for more information.
>
> Are you our admin? :D But you talked to gitlab last time, right?
>
> Is anyone else seeing that on pushes? The issue is currently harmless as
> pushing still works. But there might be more behind it.
>

I saw it again today when I pushed to the cip-kernel-sec repo.

> Jan
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#11508): https://lists.cip-project.org/g/cip-dev/messa=
ge/11508
> Mute This Topic: https://lists.cip-project.org/mt/98952836/4520416
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

