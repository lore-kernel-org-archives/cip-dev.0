Return-Path: <iwamatsu@nigauri.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C05C43334
	for <webhook@archiver.kernel.org>; Sat, 23 Jul 2022 23:12:46 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by mx.groups.io with SMTP id smtpd.web09.11737.1658617952342774269
 for <cip-dev@lists.cip-project.org>;
 Sat, 23 Jul 2022 16:12:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nigauri-org.20210112.gappssmtp.com header.s=20210112
 header.b=J6B7om0h;
 spf=none, err=permanent DNS error (domain: nigauri.org, ip: 209.85.128.175,
 mailfrom: iwamatsu@nigauri.org)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-31e7c4b593fso78138887b3.13
        for <cip-dev@lists.cip-project.org>;
 Sat, 23 Jul 2022 16:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=wHjTdmCRAOj8te+5GNJXEmB8XukgFh7NUSqhKX7hBVY=;
        b=J6B7om0hOB/+OiDWEpCaIFfJE4oFmU8BOBaUih52C9Sq3CB2XcmYU46Avu7fB5NyVL
         IiyeSkuHOb/H/rrLjA6/M/eVMlc7w8a0QgwcKVnVIYQaSrWZjYqzDiCOF/khdbyL301O
         v4Vj865SpfPJybvMPHJDDFn0YfrHpZpuyQxzriPzxwW9Xd+tDBvVxrqmnGZaEa6GSjRl
         yzF69S9c69vd/wiA62bx63qeQ3u0JvowXmITtoVm6kwh1dIGGAzZu5gxjLcutXbBYaln
         rfoeQNnhLI5x1XGWitI1fPniRsIvIYPiwfsYVVC9S0AO/OmltkJvVxWGmmC4ok+pZ72k
         14xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=wHjTdmCRAOj8te+5GNJXEmB8XukgFh7NUSqhKX7hBVY=;
        b=I4fL+eeLxY1osiWyp5J5bhUZktMvXO7ciitJ+vuAAn1iBpm65e89Ynx9BD0gt1UHgH
         K61pm84IgMauTN3EyUad0H1XSUopQF2MbkOkEar01rlAu+a7PN8lPsJM+HZWfiAnZc/N
         UUZR9+thUo6ANr9soIGJzhWaI7mukWx1lSWGM1Bxl5be401Sak4tONFmirFcsot7FK0F
         gCDIHzDXckTS2DojHBQGjVK0amU7J4rXVlr1EDbyuYsaN0DHE+wkUcnuJBvWcbhYtfwn
         W0D+x1sEhnzCnydtSA2ocuIvTr/S6C0OWbexm1YSKUelPqvIz3VPAtmnqPvI0rmLBrst
         uUrA==
X-Gm-Message-State: AJIora98saGG+bk5kHFHz1mZCqXA/Bg0qWeNhCER8JngRxpHdLH1c4N9
	X9n/+NrCQJdgXJJ2Ktj2gCc1Dmr9pcuTkmipbkx5AUqzPLMN18M=
X-Google-Smtp-Source: 
 AGRyM1v+cp+/iWtA3H8uY9LxNcqadL96Qg8IobMZUYYm7XKW0uwEWp/zepWpUtHZILsCrnpT7a++7VbFzRQqab1Mpoc=
X-Received: by 2002:a81:6e56:0:b0:31e:8e41:7357 with SMTP id
 j83-20020a816e56000000b0031e8e417357mr5051140ywc.434.1658617951489; Sat, 23
 Jul 2022 16:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220723210456.GA7918@duo.ucw.cz>
In-Reply-To: <20220723210456.GA7918@duo.ucw.cz>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Sun, 24 Jul 2022 08:11:42 +0900
Message-ID: 
 <CABMQnVK74F-VbNUecaNFqP4CB-fCns4ZBkyovkvqn9v_xpo0tg@mail.gmail.com>
Subject: Re: [cip-dev] Failures in 5.10, 4.4 testing
To: cip-dev@lists.cip-project.org
Cc: Chris.Paterson2@renesas.com, alice.ferrazzi@miraclelinux.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 23 Jul 2022 23:12:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8894

Hi Pavel,

2022=E5=B9=B47=E6=9C=8824=E6=97=A5(=E6=97=A5) 6:05 Pavel Machek <pavel@denx=
.de>:
>
> Hi!
>
> I see a lot of failures this week. 5.10.133-rc1:
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines=
/595045922
>
> 4.4:
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/595036439
> (renesas failure is expected).
>
> Is bbb expected to work in 4.4? What is going on with 5.10 testing?
>

Lava slave (Lava lab) seems to have NFS problems.

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6

