Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C8EC433EF
	for <webhook@archiver.kernel.org>; Fri,  7 Jan 2022 10:21:03 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web12.4809.1641550860831184421
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jan 2022 02:21:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=K4xUKPux;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.41,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ed1-f41.google.com with SMTP id bm14so20288200edb.5
        for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jan 2022 02:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SuoPGS4CSIfzjiiA9t3gmDBq0BfYo8V65nwnKFZPFMg=;
        b=K4xUKPuxJD5SoEYVnqIMNBKuXXuL3zL1dV7oJHXYx5QgIypD6OriOcR1cpmo3dRiCF
         Lk8QeHlnib7eaJSPB//AknSdbBYVkCVp8yn4zIgeZFgCe7hT+gFJSAB3eRmWw+ypA0X3
         UlcRxKMP5l/pmQPiNIrlTpNioDEkqR+A0bgUgWtkXmmmggbNvuHpB1hSkrAu7icN4WOn
         pZeJBewe9MrNUg+lHQ+I+X6t3iKic9T7wmn1wfjEjXA5F10Fl/0INkZLYdJBF6FFiq/c
         H+Mq/UPDx6+UguM8k96AAXm9iPeD8GPrA9FT3rRhv5FPSfWkY2bIHPsRLcyzwGCRYFL2
         Z7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SuoPGS4CSIfzjiiA9t3gmDBq0BfYo8V65nwnKFZPFMg=;
        b=rU+tMElI2suZnxcOpOvm6GT328YtcxYfB/kWvVhpowmbiMbsxwlUj0KyH8hQr7SVGn
         9hI9kLh54e8DIkHaGn8hTH2FF7NUPZugzLXi6jIPEimoUNJ1kuLHFMHYo1Muhj9UhLsY
         i9gu4nJuNG39HCOFGZPpL7V1DeSfmXmOJJSvkbyzI4Y3jqzMXOuluhBKUOp2ETdOJ3Yc
         Coa1pHt6e9B/60xgnlhPvnAORVRHGj0soE8rig42InX9qQRksmtDqSf8BSzYkHXXznO/
         1QNJWyhn9TSWK+ibp/penL36fG/h7k/Afw2M+gWAno2RW8y42sGSISfaw0QGCLJcThJk
         ofqA==
X-Gm-Message-State: AOAM533h5GIiQIJzMO88jNxOVAQnDpnjBRiqW6vlpHATGs0mU0mjynaO
	FS+71ulq3gia1+rj6RKX7WPp9knI0li6zWvAU0YPzca0y07s
X-Google-Smtp-Source: 
 ABdhPJykZ6a75wBq66f6V9hZTJrOVVM/ag4Inhlcu/RTW1YgOgyrL2/Y4NaoHMTtgrt9b1hXAlmDXTdEV/6fLkVsDlo=
X-Received: by 2002:a17:906:1585:: with SMTP id
 k5mr48237594ejd.83.1641550859288;
 Fri, 07 Jan 2022 02:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
 <5f7b82d7-cda1-192c-9a09-e229fb1c3339@siemens.com>
 <CANgtXuNVEsC3pa2Tzz6a7i65uJap+Ga7yGSobC9UZZbwYds5cw@mail.gmail.com>
 <b0bd23e7-2ad9-69c7-41a7-bed2b3db7009@siemens.com>
In-Reply-To: <b0bd23e7-2ad9-69c7-41a7-bed2b3db7009@siemens.com>
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Fri, 7 Jan 2022 19:20:23 +0900
Message-ID: 
 <CANgtXuOwNUF7CG_zi2aT3a-WYwOP6X63rnT4Wh3NQp4N52xfCA@mail.gmail.com>
Subject: Re: [isar-cip-core][PATCH 0/4] Add cip-core-image-kernelci building
 and uploading system
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jan 2022 10:21:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7342

On Fri, Jan 7, 2022 at 7:11 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 07.01.22 10:57, Alice Ferrazzi wrote:
> > On Thu, Jan 6, 2022 at 11:18 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> On 06.01.22 12:16, Alice Ferrazzi wrote:
> >>> This patch series add a new image with settings for
> >>> KernelCI.
> >>>
> >>> This new image is called cip-core-image-kernelci and is
> >>> based on isar-cip-core general image with some changes
> >>> needed for make it work with KernelCI and taken from
> >>> KernelCI image base settings.
> >>> The cip-core-image-kernelci images are built by GitlabCI
> >>> and uploaded to KernelCI production fileserver.
> >>> https://storage.kernelci.org/images/rootfs/cip/
> >>>
> >>> These patches are already integrated in the
> >>> isar-cip-core:alicef/kernelci_master_refactor repository branch
> >>> and are generating the images that are currently
> >>> used by KernelCI.
> >>>
> >>> cip-core-image-kernelci as been tested and are
> >>> already used in KernelCI production with good results.
> >>> https://linux.kernelci.org/test/job/stable-rc/branch/queue%2F5.14/kernel/v5.14.17-9-g9f7eecaa70b3/plan/baseline-cip-nfs/
> >>>
> >>
> >> Thanks a lot for enabling this!
> >>
> >> One meta-question: How does this image relate to what happens to a
> >> standard image when adding kas/opt/test.yml? Does
> >> kas/opt/kernelci.yml:kas/opt/test.yml make sense? Or should the former
> >> actually include the latter?
> >
> > Currently it doesn't make too much sense to add such testing packages.
> > CIP kernel image testing is done using ad-hoc images with a KernelCI
> > built version of the
> > testing packages for having a common base and better compare results
> > with other kernels.
> > cip-core-image-kernelci is currently tested as booting image with
> > dmesg checks for each kernel (but still using specific KernelCI
> > configurations and scripts).
> > We are currently trying to implement the iec-security test as user
> > space test that will use cip-core-image-kernelci,
> > I sent a pull request for implementing the user space test
> > iec-security but is still in progress.
> > Because KernelCI testings and test environments differs from CIP
> > gitlab pipeline test environment,
> > we have to use a different file and merging both would currently make
> > such different environments unstable.
> >
> > I hope that this answer your question.
>
> Ok, we just need to keep an eye on target configs and options that deal
> with "testing" so that things are consistent and intuitive.
>
> >
> >> These things you may ask yourself when try to add the image also to our
> >> Kconfig menu ("kas-container menu"). That would be nice to have for a v3
> >> as well, but more important is sorting out the option relationships.
> >
> > cip-core-image-kernelci are build using gitlab pipeline and there is
> > currently no benefit to have such
> > images manual build.
> >
>
> So, the case that a test fails on kernel CI and someone want to
> reproduce the image that triggered this does not exist? One would rather
> build a regular image for the target then?
>

Why not just using the pre made image from
https://storage.kernelci.org/images/rootfs/cip/
for reproducing errors ?

Thanks,
Alicef

-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

