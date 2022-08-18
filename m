Return-Path: <iwamatsu@nigauri.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873E1C32773
	for <webhook@archiver.kernel.org>; Thu, 18 Aug 2022 08:12:10 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com
 [209.85.128.172])
 by mx.groups.io with SMTP id smtpd.web10.39479.1660810327335087483
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Aug 2022 01:12:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nigauri-org.20210112.gappssmtp.com header.s=20210112
 header.b=Y/wCDrtS;
 spf=none, err=permanent DNS error (domain: nigauri.org, ip: 209.85.128.172,
 mailfrom: iwamatsu@nigauri.org)
Received: by mail-yw1-f172.google.com with SMTP id
 00721157ae682-3321c2a8d4cso21379637b3.5
        for <cip-dev@lists.cip-project.org>;
 Thu, 18 Aug 2022 01:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=VNGg28pViGbH+SynuRZpUKXFvbGfkFAq9a1y7DdFZpo=;
        b=Y/wCDrtStWGzTAG1SeKUScQ/CYldcwe2oHidbonxV2cjqbDoRm65mRW7DapoMU2eOk
         Tm5vajnTz6NZwlHPgjKLck64RT5Xtifb8FZ5cz9T27sIJ47ArqTHBxJ/lB5defz4EyLv
         olWjmYJ2B5r+sH2G/Dl2P5vIJkmEHXV+8v0hWmhe3cJRXziY/gRz7yiX5DqC7cF9rOdW
         RNuG4n1oSI0aduBsR4aQBTN7TI9K5MNARH4QZGY5YnfPAFKxLtNqt/3Yb1OpavssJ5Dn
         B50PcTEVIQdu5nnC4pRn4VnlXwWaVidG7U0c0KZwXZSS/K9sHE3/xhyBjEgcP5r7+4vB
         IIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=VNGg28pViGbH+SynuRZpUKXFvbGfkFAq9a1y7DdFZpo=;
        b=KDor9jsWimTh/fy7D1ylHOq0TEn35PqmxcfEOStqT8YdrYtADTATnIc/rW9unvo4qq
         gSiu2HoKUmBozGcirQTXHXDMdSM1ssu2vD2GahjfvQXMGdH7rqE9/43shE0LpIuJnubn
         /wWsOv+ldvL5UzNIuTSdWOb9hS+2lUnFJRIx9vMS3cq5ok561Z3Rsa8NlJnAji9XfKg5
         WkfrCy2eN4UIO6aeKJY0kpQalB/g8rVpuk+A2z2A99yWGca5JS2ByKN8vd26yhalKBzo
         6p90jujpZrDfHi33EdYk5C9aE+uYbrSQOA0zr+YSlmTxXakGOzvZVlJpAKKWUSDJHLjV
         56iw==
X-Gm-Message-State: ACgBeo14NXSSEBbgXC/STJDvXeIKPsqXQjYn3jUczl424XcHq3WeDlYe
	vqNlEHQe8TUmDlzRnMHL3peELRn1bkAbINszvFmyHZ7m36IEK14=
X-Google-Smtp-Source: 
 AA6agR6NHWXzFSdkSYfQMkW3n46j4nwU1fZt8Lw0DCsUU1O2/l6NB15biLcR21lem/XqNJDQRMaK93Re4PdQNo8NHyI=
X-Received: by 2002:a0d:cd43:0:b0:329:febf:8c25 with SMTP id
 p64-20020a0dcd43000000b00329febf8c25mr1753765ywd.90.1660810326334; Thu, 18
 Aug 2022 01:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220812082204.GA16699@duo.ucw.cz>
 <170C50D82759C5F9.6839@lists.cip-project.org>
 <OS3PR01MB1013643AC251163B981EB14BCE16D9@OS3PR01MB10136.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB1013643AC251163B981EB14BCE16D9@OS3PR01MB10136.jpnprd01.prod.outlook.com>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Thu, 18 Aug 2022 17:11:40 +0900
Message-ID: 
 <CABMQnVKNUdxitxWrmQnEVoeXa1gQjmn6M8nw73d2mYmSVTyRBw@mail.gmail.com>
Subject: Re: [cip-dev] Root filesystem for risc-v board
To: cip-dev@lists.cip-project.org
Cc: pavel@denx.de, Chris.Paterson2@renesas.com, tho1.nguyendat@toshiba.co.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Aug 2022 08:12:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9290

Hi,

As another suggestion,  I've put the riscv64 debian rootfs image below.
  https://people.debian.org/~iwamatsu/riscv64-unstable-base.tar.gz

Please feel free to use.

Best regards,
  Nobuhiro

2022=E5=B9=B48=E6=9C=8818=E6=97=A5(=E6=9C=A8) 14:04 Kazuhiro Hayashi <kazuh=
iro3.hayashi@toshiba.co.jp>:
>
> Hello Pavel,
>
> > then you can see the rootfs tarball at:
> > build/tmp/deploy/images/qemu-riscv64/cip-core-image-cip-core-sid-ports-=
qemu-riscv64.tar.gz
>
> Sorry, it seems the image is generated as .ext4 by default:
> build/tmp/deploy/images/qemu-riscv64/cip-core-image-cip-core-sid-ports-qe=
mu-riscv64.ext4
>
> > > Unfortunately, I can't get debootstrap --second-stage to work (I get
> > > sigsegv in ldconfig, I guess testing may be too experimental?). Is it
> > > possible to debootstrap stable or testing distributions?
>
> My understanding is debian ports only provides packages for sid/experimen=
tal suites
> so there is no package provided as stable/testing.
> http://ftp.ports.debian.org/debian-ports/dists/
>
> Best regards,
> Kazu
>
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On =
Behalf Of Kazuhiro Hayashi
> > Sent: Thursday, August 18, 2022 11:54 AM
> > To: pavel@denx.de; cip-dev@lists.cip-project.org; Chris.Paterson2@renes=
as.com
> > Cc: nguyen dat tho(=EF=BC=B4=EF=BC=B3=EF=BC=A4=EF=BC=B6 =EF=BC=A5=EF=BD=
=8E=EF=BD=87=E3=80=80=EF=BC=91) <tho1.nguyendat@toshiba.co.jp>
> > Subject: Re: [cip-dev] Root filesystem for risc-v board
> >
> > Hello Pavel,
> >
> > We have a development branch in isar-cip-core, by which
> > we can generate a rootfs for QEMU riscv64.
> >
> > https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/thond/risc=
v-dev
> >
> > Please note that this is not an official recipes of isar-cip-core and
> > there is no plan to be merged into master because it uses sid-ports rep=
ository.
> >
> > Step to build rootfs (tarball):
> >
> > $ git clone -b thond/riscv-dev https://gitlab.com/cip-project/cip-core/=
isar-cip-core
> > $ cd isar-cip-core
> > $ wget https://raw.githubusercontent.com/siemens/kas/3.0.2/kas-containe=
r
> > $ chmod a+x kas-container
> > $ ./kas-container build kas-cip.yml:kas/board/qemu-riscv64.yml:kas/opt/=
sid-ports.yml:kas/opt/debian-kernel.yml
> >
> > then you can see the rootfs tarball at:
> > build/tmp/deploy/images/qemu-riscv64/cip-core-image-cip-core-sid-ports-=
qemu-riscv64.tar.gz
> >
> > By the latest CI, the rootfs image (tarball) was uploaded to S3:
> > https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/2702654409=
#L1586
> >
> > Please let me know if you need more information.
> >
> > Best regards,
> > Kazu
> >
> > > -----Original Message-----
> > > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> O=
n Behalf Of Pavel Machek
> > > Sent: Friday, August 12, 2022 5:22 PM
> > > To: cip-dev@lists.cip-project.org; Chris.Paterson2@renesas.com
> > > Subject: [cip-dev] Root filesystem for risc-v board
> > >
> > > Hi!
> > >
> > > So... how do you get root filesystem for RISC-V board? Ideally I'd
> > > like to get something Debian based.
> > >
> > > Best I could try is debootstrap for Debian testing:
> > >
> > > sudo debootstrap --no-check-gpg --foreign --arch=3Driscv64 --keyring
> > > /usr/share/keyrings/debian-ports-archive-keyring.gpg
> > > --include=3Ddebian-ports-archive-keyring unstable /some/suitable/dir
> > > http://deb.debian.org/debian-ports
> > >
> > > Unfortunately, I can't get debootstrap --second-stage to work (I get
> > > sigsegv in ldconfig, I guess testing may be too experimental?). Is it
> > > possible to debootstrap stable or testing distributions?
> > >
> > > I don't think CIP project provides binary images somewhere. What is
> > > recommended way to get a root filesystem? Is there suitable
> > > documentation I should follow?
> > >
> > > Thanks and best regards,
> > >                                                             Pavel
> > > --
> > > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#9289): https://lists.cip-project.org/g/cip-dev/messag=
e/9289
> Mute This Topic: https://lists.cip-project.org/mt/92975993/3616729
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129081/361672=
9/2027256985/xyzzy [iwamatsu@nigauri.org]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>


--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6

