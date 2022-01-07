Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF4CC433EF
	for <webhook@archiver.kernel.org>; Fri,  7 Jan 2022 10:17:39 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web08.4772.1641550657683162554
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jan 2022 02:17:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=uj2c3RzK;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.46,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ed1-f46.google.com with SMTP id m21so20476059edc.0
        for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jan 2022 02:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m9AfkXB3z8idMNk+rraOzrKzrmPKeIFxQ/VtsvyceFk=;
        b=uj2c3RzKZ5JIAMW6KnaoJFfWpPmxtSEYyjyAIYNnbbP7XSw1T64a0aWPnBTwqWlmud
         1YmsqJ78yyi1mLL9puMb+ehwYngaOB42HEDeGjLRcXvuvoCQrmKLQXNKeXlV66INDLDR
         ptbbYSp5eMEaUKuVDe62/ti4IaCvtz4KFVDn1A6XxBZJYLKDWNK1A9x3BHwCvE/fbaX3
         C7NgPSosnyteP9QdAxv3mLWOgk1VCvURJEfLZJp/oVmReUDTMcZYmh+apNxlt5fva4uc
         akg5MQ2J5gUBtXUKAbh6MiExWNGw/YWScT0WB+/0LBzDinLrEmpPPAdjkg92VgL0B5zj
         7LNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m9AfkXB3z8idMNk+rraOzrKzrmPKeIFxQ/VtsvyceFk=;
        b=QiG7g0UNHQNKmpiM+xOP/nygj6Rk2DSIXeRpzCnVx2oMxHdA3SkI7kD0rwOHeNCoEq
         ecS9QUyWgJZDt9z3l/yqF4u0lHtUu2IrF1FzN4AbzB6P/IW7rfRPMDSbKFpnyJuDlRDc
         /9OE6AWrvoBluPDx50ttt5hs9qJJ9/A43isvOU31rF6ZgCtv1HuSeVkdEJymdrIZD9+1
         mZcl/ClCOYnxYRKOkMklofluA97DvanLMOM/miawKZIja6WC2xhMXFKzG9t4ZGTJaA7N
         zsaxIlB4M1Nixa6kS/a9rN/BUsV8q8nW6eBvb3QgJ/d1AVnOYYsWGLheug9oQAEu/uXv
         5Sug==
X-Gm-Message-State: AOAM533gRIAvtwPXIT7m1i+Gfzjn1paRlkOOaa5nK0q+DNZEo0wmYMfk
	yv4u/LdDbbbBkX1aBAGrrIZyQBwL9ihl3lhBMxJw
X-Google-Smtp-Source: 
 ABdhPJybX4vuFNZjZbO+VQaizqbV3pZ8mEVIvs8g7Q0a6G+SU9FMck24//sHSuVsvMxPXEkCBZNrUEjqG5jJIQh5a1g=
X-Received: by 2002:a05:6402:354b:: with SMTP id
 f11mr60642209edd.342.1641550656073;
 Fri, 07 Jan 2022 02:17:36 -0800 (PST)
MIME-Version: 1.0
References: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
 <20220106111614.218823-2-alice.ferrazzi@miraclelinux.com>
 <e4a55c2b-64dd-6281-c9d9-bf568a6fb732@siemens.com>
In-Reply-To: <e4a55c2b-64dd-6281-c9d9-bf568a6fb732@siemens.com>
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Fri, 7 Jan 2022 19:16:59 +0900
Message-ID: 
 <CANgtXuOj--ce1t=z4jaPMwo1DVT+RSXJXjSSdvwKEaeT5cUSjA@mail.gmail.com>
Subject: Re: [isar-cip-core][PATCH 1/4] Add cip-core-image-kernelci
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jan 2022 10:17:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7341

On Thu, Jan 6, 2022 at 11:01 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 06.01.22 12:16, Alice Ferrazzi wrote:
> > This image is currently used by KernelCI production for testing purpose.
> > The purpose of this image is that KernelCI need to be able to autologin
> > without password and to detect the login shell using special characters.
> > Currently added are the default settings used by KernelCI images.
> >
> > Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > ---
> >  kas/opt/kernelci.yml                          | 16 +++++++++
> >  .../images/cip-core-image-kernelci.bb         | 16 +++++++++
> >  .../files/99-silent-printk.conf               |  1 +
> >  .../kernelci-customizations/files/ethernet    | 23 +++++++++++++
> >  .../kernelci-customizations/files/postinst    | 34 +++++++++++++++++++
> >  .../kernelci-customizations.bb                | 34 +++++++++++++++++++
> >  6 files changed, 124 insertions(+)
> >  create mode 100644 kas/opt/kernelci.yml
> >  create mode 100644 recipes-core/images/cip-core-image-kernelci.bb
> >  create mode 100644 recipes-core/kernelci-customizations/files/99-silent-printk.conf
> >  create mode 100644 recipes-core/kernelci-customizations/files/ethernet
> >  create mode 100644 recipes-core/kernelci-customizations/files/postinst
> >  create mode 100644 recipes-core/kernelci-customizations/kernelci-customizations.bb
> >
> > diff --git a/kas/opt/kernelci.yml b/kas/opt/kernelci.yml
> > new file mode 100644
> > index 0000000..9c67864
> > --- /dev/null
> > +++ b/kas/opt/kernelci.yml
> > @@ -0,0 +1,16 @@
> > +#
> > +# CIP Core, generic profile
> > +#
> > +# Copyright (c) Toshiba Corporation, 2020
> > +# Copyright (c) Cybertrust Japan Co., Ltd., 2021
> > +#
> > +# Authors:
> > +#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>
> > +#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > +#
> > +# SPDX-License-Identifier: MIT
> > +#
> > +header:
> > +  version: 10
> > +
> > +target: cip-core-image-kernelci
> > diff --git a/recipes-core/images/cip-core-image-kernelci.bb b/recipes-core/images/cip-core-image-kernelci.bb
> > new file mode 100644
> > index 0000000..479c14c
> > --- /dev/null
> > +++ b/recipes-core/images/cip-core-image-kernelci.bb
> > @@ -0,0 +1,16 @@
> > +#
> > +# A reference image for KernelCI
> > +#
> > +# Copyright (c) Cybertrust Japan Co., Ltd., 2021
> > +#
> > +# Authors:
> > +#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > +#
> > +# SPDX-License-Identifier: MIT
> > +#
> > +
> > +inherit image
> > +
> > +DESCRIPTION = "CIP Core image for KernelCI"
> > +
> > +IMAGE_INSTALL += "kernelci-customizations"
> > diff --git a/recipes-core/kernelci-customizations/files/99-silent-printk.conf b/recipes-core/kernelci-customizations/files/99-silent-printk.conf
> > new file mode 100644
> > index 0000000..ad24d3a
> > --- /dev/null
> > +++ b/recipes-core/kernelci-customizations/files/99-silent-printk.conf
> > @@ -0,0 +1 @@
> > +kernel.printk = 3 4 1 3
> > diff --git a/recipes-core/kernelci-customizations/files/ethernet b/recipes-core/kernelci-customizations/files/ethernet
> > new file mode 100644
> > index 0000000..fa47d1a
> > --- /dev/null
> > +++ b/recipes-core/kernelci-customizations/files/ethernet
> > @@ -0,0 +1,23 @@
> > +#
> > +# CIP Core, generic profile
> > +#
> > +# Copyright (c) Siemens AG, 2019
> > +#
> > +# Authors:
> > +#  Jan Kiszka <jan.kiszka@siemens.com>
> > +#
> > +# SPDX-License-Identifier: MIT
> > +#
> > +
> > +allow-hotplug eth0
> > +allow-hotplug enp0s2
> > +allow-hotplug enp2s0
> > +
> > +# used on BBB
> > +iface eth0 inet dhcp
> > +
> > +# used on qemu-amd64
> > +iface enp0s2 inet dhcp
> > +
> > +# used on simatic-ipc227e
> > +iface enp2s0 inet dhcp
> > diff --git a/recipes-core/kernelci-customizations/files/postinst b/recipes-core/kernelci-customizations/files/postinst
> > new file mode 100644
> > index 0000000..7ae30e8
> > --- /dev/null
> > +++ b/recipes-core/kernelci-customizations/files/postinst
> > @@ -0,0 +1,34 @@
> > +#!/bin/sh
> > +#
> > +# CIP Core, generic profile
> > +#
> > +# Copyright (c) Siemens AG, 2019
> > +# Copyright (c) Cybertrust Japan Co., Ltd., 2021
> > +#
> > +# Authors:
> > +#  Jan Kiszka <jan.kiszka@siemens.com>
> > +#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > +#
> > +# SPDX-License-Identifier: MIT
> > +#
> > +
> > +echo "CIP Core Demo & Test Image" > /etc/issue
> > +
> > +# permit root login without password
> > +echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
> > +echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config
> > +passwd root -d
> > +
> > +# serial getty service for autologin
> > +mkdir -p /etc/systemd/system/serial-getty@.service.d/
> > +echo "[Service]" > /etc/systemd/system/serial-getty@.service.d/override.conf
> > +echo "ExecStart=" >> /etc/systemd/system/serial-getty@.service.d/override.conf
> > +echo "ExecStart=-/sbin/agetty --autologin root --keep-baud 115200,38400,9600 %I $TERM" >> /etc/systemd/system/serial-getty@.service.d/override.conf
> > +
> > +# set the profile for KernelCI
> > +echo "PS1='\$(pwd) # '" > /root/.profile
> > +echo "cd /" >> /root/.profile
> > +
> > +HOSTNAME=demo
> > +echo "$HOSTNAME" > /etc/hostname
> > +echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
> > diff --git a/recipes-core/kernelci-customizations/kernelci-customizations.bb b/recipes-core/kernelci-customizations/kernelci-customizations.bb
> > new file mode 100644
> > index 0000000..dca0891
> > --- /dev/null
> > +++ b/recipes-core/kernelci-customizations/kernelci-customizations.bb
> > @@ -0,0 +1,34 @@
> > +#
> > +# CIP Core, generic profile
> > +#
> > +# Copyright (c) Siemens AG, 2019
> > +# Copyright (c) Cybertrust Japan Co., Ltd., 2021
> > +#
> > +# Authors:
> > +#  Jan Kiszka <jan.kiszka@siemens.com>
> > +#  Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > +#
> > +# SPDX-License-Identifier: MIT
> > +#
> > +
> > +inherit dpkg-raw
> > +
> > +DESCRIPTION = "CIP Core image demo & customizations"
> > +
> > +SRC_URI = " \
> > +    file://postinst \
> > +    file://ethernet \
> > +    file://99-silent-printk.conf"
> > +
> > +DEPENDS += "sshd-regen-keys"
> > +
> > +DEBIAN_DEPENDS = " \
> > +    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys"
> > +
> > +do_install() {
> > +  install -v -d ${D}/etc/network/interfaces.d
> > +  install -v -m 644 ${WORKDIR}/ethernet ${D}/etc/network/interfaces.d/
> > +
> > +  install -v -d ${D}/etc/sysctl.d
> > +  install -v -m 644 ${WORKDIR}/99-silent-printk.conf ${D}/etc/sysctl.d/
> > +}
>
> This is duplicating the default customization package, IIUC, for the
> purpose of adding further things. And you already miss some things due
> to this (WIRELESS_FIRMWARE_PACKAGE, INSTALL_WIRELESS_TOOLS).
>
> How about installing both and carrying in kernelci-customization only
> the delta? Or at least reuse artifacts from customizations package, e.g.
> via symlinks?

KernelCI enviroment and gitlab-ci eviroment are mostly different.
Changes on the symlink could possibly broke the KernelCI testing
image or the gitlab-ci image.
KernelCI working workflow is to have different files and porting changes
manually so that we can be sure it doesn't create problems and revert
on necessity.


Thanks,
Alicef

-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

