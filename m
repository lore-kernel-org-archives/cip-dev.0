Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1F1C433F5
	for <webhook@archiver.kernel.org>; Fri,  7 Jan 2022 09:57:53 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web08.4628.1641549470777855844
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jan 2022 01:57:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=8SS/pgyp;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.42,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ed1-f42.google.com with SMTP id b13so20030413edd.8
        for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jan 2022 01:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/f2n5XJOYWCT5/3PNwjGENS5o3zYVD8OILnSTCMoHCc=;
        b=8SS/pgypOlWs9uBvljtuHpmkXod3yBFbDkNVNsBIN3iWwMYEQgxXpzQ0CIvxWlV+ss
         539PUoX0C4n9eTKKjQsW2MKkR2JW+di75E86L3W11RWTBHZPzHN4wgDcvXEfguhREkcs
         E2D/TExDBg854VdMSejOzmIeELOEMbQdun/kLia1DYbVb10jZtVGQkc5dvlh827GXO5C
         6fgX+JRcYaDT6Tri6BxS0MAzmD8g0zPqM3OK8jaGNzdajCcjnM0bwN92Xx8yi1BA5W8M
         dqLXxKIHaLf+L4QsG2f9UwI1RunH7wSoQgRcW3ihoYfNCe5YXH94+ixnka2LHHa8+Br9
         vY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/f2n5XJOYWCT5/3PNwjGENS5o3zYVD8OILnSTCMoHCc=;
        b=d9iPGDJKhT5NsBLRL4F2t8V27S0np4vjGgpiQfYSPeClsJiWLK+aBwC9XofLr6gngy
         SpMgHPH2Ltu1eS9dBaZdUJzN0M2zfHPy7Y4HJ7baIfCeNQLq6f56XLRcQHtiIaV7wwGh
         5Vi/4wAcqKoFccQpPLCExBrTpFEL/jbgq6Q+OJbzDOA8HXVVZ7/awm0/xTR51BQTllM9
         TOLrfvBySAyVKKplG0liTTBfrPUUmlAMQvjo4X5o2RH06+9Zal+VkTjRRzsgOwA6re/P
         atAYRZJXlTAmFrKpQG11EkxC7vVGDkIMu8CTozG3WyQE+h/W78SckpX8z06QURZlfgf+
         cmOw==
X-Gm-Message-State: AOAM5335xwJLZD9/myF4MuL+8Gx5j2HhN5RiKIgmgiyPKU4R8Mh/8DYX
	32t6JC5PeSljeBHY+WeRPBIZjh5oxMkhnguguSUU
X-Google-Smtp-Source: 
 ABdhPJwqEnuLxWP25o8txRMgMUL78Aal2IHO7mCYVCoS9Ru4HyOSRjzkonl2ic7DIoNMGcdu8sCrowWeoqZhR42bwT0=
X-Received: by 2002:a05:6402:42d5:: with SMTP id
 i21mr63187589edc.23.1641549468964;
 Fri, 07 Jan 2022 01:57:48 -0800 (PST)
MIME-Version: 1.0
References: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
 <5f7b82d7-cda1-192c-9a09-e229fb1c3339@siemens.com>
In-Reply-To: <5f7b82d7-cda1-192c-9a09-e229fb1c3339@siemens.com>
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Fri, 7 Jan 2022 18:57:12 +0900
Message-ID: 
 <CANgtXuNVEsC3pa2Tzz6a7i65uJap+Ga7yGSobC9UZZbwYds5cw@mail.gmail.com>
Subject: Re: [isar-cip-core][PATCH 0/4] Add cip-core-image-kernelci building
 and uploading system
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jan 2022 09:57:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7337

On Thu, Jan 6, 2022 at 11:18 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 06.01.22 12:16, Alice Ferrazzi wrote:
> > This patch series add a new image with settings for
> > KernelCI.
> >
> > This new image is called cip-core-image-kernelci and is
> > based on isar-cip-core general image with some changes
> > needed for make it work with KernelCI and taken from
> > KernelCI image base settings.
> > The cip-core-image-kernelci images are built by GitlabCI
> > and uploaded to KernelCI production fileserver.
> > https://storage.kernelci.org/images/rootfs/cip/
> >
> > These patches are already integrated in the
> > isar-cip-core:alicef/kernelci_master_refactor repository branch
> > and are generating the images that are currently
> > used by KernelCI.
> >
> > cip-core-image-kernelci as been tested and are
> > already used in KernelCI production with good results.
> > https://linux.kernelci.org/test/job/stable-rc/branch/queue%2F5.14/kernel/v5.14.17-9-g9f7eecaa70b3/plan/baseline-cip-nfs/
> >
>
> Thanks a lot for enabling this!
>
> One meta-question: How does this image relate to what happens to a
> standard image when adding kas/opt/test.yml? Does
> kas/opt/kernelci.yml:kas/opt/test.yml make sense? Or should the former
> actually include the latter?

Currently it doesn't make too much sense to add such testing packages.
CIP kernel image testing is done using ad-hoc images with a KernelCI
built version of the
testing packages for having a common base and better compare results
with other kernels.
cip-core-image-kernelci is currently tested as booting image with
dmesg checks for each kernel (but still using specific KernelCI
configurations and scripts).
We are currently trying to implement the iec-security test as user
space test that will use cip-core-image-kernelci,
I sent a pull request for implementing the user space test
iec-security but is still in progress.
Because KernelCI testings and test environments differs from CIP
gitlab pipeline test environment,
we have to use a different file and merging both would currently make
such different environments unstable.

I hope that this answer your question.

> These things you may ask yourself when try to add the image also to our
> Kconfig menu ("kas-container menu"). That would be nice to have for a v3
> as well, but more important is sorting out the option relationships.

cip-core-image-kernelci are build using gitlab pipeline and there is
currently no benefit to have such
images manual build.

Thanks,
Alice

-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

