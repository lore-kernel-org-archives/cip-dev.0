Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E24C433F5
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 13:09:58 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web12.27716.1643288996571323440
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 05:09:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=g4iTQTNJ;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.42,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ed1-f42.google.com with SMTP id w14so3552519edd.10
        for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 05:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LMBguNbK+BZlt5GtYYkfHPVi+zd/A5QJd6JF4xShpvI=;
        b=g4iTQTNJCQVGvmEeS4aZRz2PIpLsbpp41NI2r+oDX/q16znA+9kso9I3IAXHUIS7nD
         PMfWaiD43KpIrvoFmclRu08RZVRI8JzYh8JTWs4UeTpw7BPT+dH3V7Rr9AoEiB4VIZBt
         8KtlAxzDV77ISAPlwomuUkRF1CFqoGU08EW3chAev0Iz27nyQBDMSSDIiEcJgfQqsM1m
         x8FmGslq974TYFu4DmLLz+Aazx9hxYxzX/Hxejk8UnYcmd0BQ8GDcZ04EqYcdI4/MECk
         CCs+XUI23UM+YH6wKitTB1GJKlHRQ6/O2HzxRkPMTYOrSP1cPF9GhCCTSMX1+CBFmO/E
         t0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LMBguNbK+BZlt5GtYYkfHPVi+zd/A5QJd6JF4xShpvI=;
        b=gcgZW3pHvgeorjJ71ZPJQO4PALx7YXzsP3Merzd6Wi1pgfdoRQKsiTNUcxt2/+XuZj
         5LhteEY0TeMlFhJuGfDTbj6ruL5B73vfBV35eR5AbZ9eMF2YcSKmrmtTaaeUwevuK6WQ
         0Nzxhzgf8qXaw+lX1yFIJRpjfxYEhVY2SdW4c8yjBFqYdgt/bjdE3EPSH568h35h3y8S
         D5d0K8hXBTNW2YyCZeNJzaxvsV+Zizk5Efgibn0AHDC7SKrXm9044vOOHSs+vbgXF4j8
         mx1j78t+b2VZ6dSfu5mqWyzqHtVGH6ZbGlReA2nvyqe4BqtlAzNXysMjpT2IvdiW8mGG
         jW2Q==
X-Gm-Message-State: AOAM530aoZdPI69yA8oU+oU1H6/y3/O+t4uTxCbeIMYzsmCcvf9X7c8q
	ssH8Tj7JDCbwIcszDXTlx1BN0Xib5RjFQ5sD+SHk
X-Google-Smtp-Source: 
 ABdhPJx6kK4SJY4HfKUj4hwiOObJo/qGCAzodQE997zyGXLw/KJCzJHlX3ufdXwZMbq3n6DtFo4IMFrrJgSKiEgIXlk=
X-Received: by 2002:a05:6402:40c1:: with SMTP id
 z1mr3646796edb.23.1643288994870;
 Thu, 27 Jan 2022 05:09:54 -0800 (PST)
MIME-Version: 1.0
References: <20220120125418.236990-1-alice.ferrazzi@miraclelinux.com>
 <20220120125418.236990-3-alice.ferrazzi@miraclelinux.com>
 <4493f1b3-6559-8627-0725-faa35aa3508b@siemens.com>
In-Reply-To: <4493f1b3-6559-8627-0725-faa35aa3508b@siemens.com>
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Thu, 27 Jan 2022 22:09:15 +0900
Message-ID: 
 <CANgtXuPeQHOiUCKtK9MAd++whamLS-vLyTEqiRZ0yQe9mmEXYw@mail.gmail.com>
Subject: Re: [isar-cip-core][PATCH v2 2/4] Add dmesg filter needed for lava
 test result
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jan 2022 13:09:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7502

On Thu, Jan 27, 2022 at 8:19 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 20.01.22 13:54, Alice Ferrazzi wrote:
> > KernelCI is using a dmesg filter script for checking dmesg
> > logs result with lava.
> > Adding the script to the cip-core-image-kernelci.
> >
> > Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > ---
> >   .../kernelci-customizations/files/dmesg.sh    | 23 +++++++++++++++++++
> >   .../kernelci-customizations.bb                |  1 +
> >   2 files changed, 24 insertions(+)
> >   create mode 100644 recipes-core/kernelci-customizations/files/dmesg.sh
> >
> > diff --git a/recipes-core/kernelci-customizations/files/dmesg.sh b/recipes-core/kernelci-customizations/files/dmesg.sh
> > new file mode 100644
> > index 0000000..3b096e1
> > --- /dev/null
> > +++ b/recipes-core/kernelci-customizations/files/dmesg.sh
> > @@ -0,0 +1,23 @@
> > +#!/bin/sh
> > +
> > +set -e
> > +
> > +if [ "$KERNELCI_LAVA" = "y" ]; then
> > +    alias test-result='lava-test-case'
> > +else
> > +    alias test-result='echo'
> > +fi
> > +
> > +for level in crit alert emerg; do
> > +    dmesg --level=$level --notime -x -k > dmesg.$level
> > +    test -s dmesg.$level && res=fail || res=pass
> > +    count=$(cat dmesg.$level | wc -l)
> > +    cat dmesg.$level
> > +    test-result \
> > +        $level \
> > +        --result $res \
> > +        --measurement $count \
> > +        --units lines
> > +done
> > +
> > +exit 0
> > diff --git a/recipes-core/kernelci-customizations/kernelci-customizations.bb b/recipes-core/kernelci-customizations/kernelci-customizations.bb
> > index dca0891..c3f677c 100644
> > --- a/recipes-core/kernelci-customizations/kernelci-customizations.bb
> > +++ b/recipes-core/kernelci-customizations/kernelci-customizations.bb
> > @@ -18,6 +18,7 @@ DESCRIPTION = "CIP Core image demo & customizations"
> >   SRC_URI = " \
> >       file://postinst \
> >       file://ethernet \
> > +    file://dmesg.sh \
> >       file://99-silent-printk.conf"
> >
> >   DEPENDS += "sshd-regen-keys"
>
> This is a nop, you forgot to install it.
>
> Where should that script actually end up?

you are right.
The installation script got lost in the rebase.
sending a patch v3

--
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

