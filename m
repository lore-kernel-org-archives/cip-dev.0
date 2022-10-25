Return-Path: <iwamatsu@nigauri.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E185C04A95
	for <webhook@archiver.kernel.org>; Tue, 25 Oct 2022 09:26:48 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
 by mx.groups.io with SMTP id smtpd.web08.5131.1666690002589729529
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Oct 2022 02:26:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nigauri-org.20210112.gappssmtp.com header.s=20210112 header.b=In9mTj3M;
 spf=none, err=permanent DNS error (domain: nigauri.org, ip: 209.85.128.178, mailfrom: iwamatsu@nigauri.org)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-367b8adf788so108018597b3.2
        for <cip-dev@lists.cip-project.org>; Tue, 25 Oct 2022 02:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgfdzC5UwhesABhO9EGSqrujXJFA3arQijVRrOZXQH4=;
        b=In9mTj3MTiStC4AfIcUlFIO8u1COD6J3aW/V5ADOVpNIAxC/T6uujIaAzU0MWhq1PX
         u33VoWk+8+J0TKfdNE9TXZMALhJI6SuQH2IlGq7GG4G4jl0lqOWqLm8MUHgc6cR6/ey1
         /TKRyR8seNNB7GUiJxFJd6M7+6ct5081v9MoZpIMttpNfHQNPlNMdIXjTap/5O68PG+B
         H28ZPC2q9I5JGEewNJmR1FtXNqbe6KE4uNQklwi89H+4AoGBgZ0PrcY1VJ4bl8DPeBoU
         2+66xtBqCaw2avSj3XduXOMCWPLH/PsDOWPaJoN9bAA6YhJlFQzMrLXNvN+EMrJwwuNp
         nEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgfdzC5UwhesABhO9EGSqrujXJFA3arQijVRrOZXQH4=;
        b=mm7JzSpmJ64LiJU2oRvm5ATjS3Nv0UMGtwMEJGOzawJgrGhrYb/V0Sl18VxPUTIv6S
         1Yzi6w5axfu3f82aobQAVyEPlhEqAvLCp78ghg4FU9YOX1V8HThkDQt+s7CztgenDRxf
         hHhiMZ7E4bss08OiJVYnddzHAzcWgd7aSkOSf2f6703Fir//gEFw9UY2CsmYfM0N/B0a
         vgGUzOXhH8Hrcmpj6+QgLuymxg+G/K+obPXp6E+IgaLEXNEWGZEzhxOZOxFDk2EzfZDf
         H1FKDChuWkX7I8/fWys+IJwwcA+tcXpT+2yfMUxbFWxCSOmyRuCxxOunS67BUFjS9AfJ
         rg/A==
X-Gm-Message-State: ACrzQf25z8+rNDmLogG4ColT0YrNf5MiQHWY1OMNYgPT0boAaOWz+bqL
	27TsVOlW58EI6YyEYVAeTJ5pjGPVEGLrV2e7v80A
X-Google-Smtp-Source: AMsMyM4FynBzrj3FX9Z7zYhY8iTEmrAgqQ0gDAWtHGwd1MAMOEoENJeD/kfCsMbHSZ5fcaj9ciLrX2SOp7EVRLElW/M=
X-Received: by 2002:a0d:cb82:0:b0:36b:3015:cf0f with SMTP id
 n124-20020a0dcb82000000b0036b3015cf0fmr14542957ywd.255.1666690001713; Tue, 25
 Oct 2022 02:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221022145808.zuftgygxfkizeowp@debian>
In-Reply-To: <20221022145808.zuftgygxfkizeowp@debian>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Tue, 25 Oct 2022 18:26:15 +0900
Message-ID: <CABMQnVLDc7h9o-w7QPH8JAqDT6uWREXQHBKjfukMaZL-JdtgRQ@mail.gmail.com>
Subject: Re: The brief status of Debian riscv porting --2022/10/22
To: Bo YU <tsu.yubo@gmail.com>
Cc: debian-riscv@lists.debian.org, cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Oct 2022 09:26:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9818

Hi!

Thank you for sharing the porting status of RISCV64.

When I make this a Debian official port, I'm worried about what is a blocke=
r.
Of course, there is a porting package coverage, but do you know what
the support status
such as infrastructure and others when it becomes an official port?
If possible, I would like to cooperate with this.

According to architecture requalification[0] and other
information[1][2], Buildd-DSA[3] and
porterbox seem to be major blockers. Are you or other member working on the=
se?

[0]: https://release.debian.org/testing/arch_qualify.html
[1]: https://wiki.debian.org/Ports/riscv64
[2]: https://wiki.debian.org/ArchiveQualification/riscv64
[3]: https://dsa.debian.org/ports/hardware-requirements/

Best regards,
  Nobuhiro

2022=E5=B9=B410=E6=9C=8822=E6=97=A5(=E5=9C=9F) 23:58 Bo YU <tsu.yubo@gmail.=
com>:
>
> Hi,
>
> In the past two weeks, due to the atomic problem and the cargo build
> dependency problem, the number of riscv64 built packages has been
> maintained at about 15k[0], which is a little lower than before.
> Because when is unknown the upstream of GCC will be able to merge
> the patch of solving the atomic issue, and the porter sends the
> patch to build the affected package.
>
> Another thanks to pabs, we maybe have some work to do about
> cross-build for Debian riscv64. But limited by personal experience,
> I cannot evaluate these specific jobs. Here, I just grep the pabs's
> wiki[1] here.
>
> ```
> Make the port available for maintainers and users to cross-build packages=
 to:
>
>     Add support to the binutils source package
>
>     Add libc6*-dev-$arch-cross, libc6*-$arch-cross and linux-libc-dev-$ar=
ch-cross
> packages to the cross-toolchain-base (for ftp-master.d.o arches) or
> cross-toolchain-base-ports (for ports.d.o arches) source packages
>
>     Add support to the current gcc-N source package
>
>     Add metapackages to the gcc-defaults source package
>
>     Add a crossbuild-essential-$arch metapackage to the build-essential
> source package
> ```
>
> I've tried building some of these packages and obviously need to add
> riscv64 support (maybe with some help from the Debian toolchain folks for=
 me).
>
> [0]: https://buildd.debian.org/status/architecture.php?a=3Driscv64&suite=
=3Dsid
> [1]: https://wiki.debian.org/PortsDocs/New#Other_work
>
> --
> Regards,
> --
>    Bo YU
>


--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org / kernel.org}
   GPG ID: 32247FBB40AD1FA6

