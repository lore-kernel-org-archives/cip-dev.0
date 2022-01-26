Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B08FC2BA4C
	for <webhook@archiver.kernel.org>; Wed, 26 Jan 2022 10:28:21 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.web09.10815.1643192898574009732
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jan 2022 02:28:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=M0mbRi6z;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.41,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ed1-f41.google.com with SMTP id m11so68206870edi.13
        for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jan 2022 02:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOTkCqjt4oaSahQ/IsIEgLDAqlhf1a6ZVnl9IwUSYR4=;
        b=M0mbRi6z09sBSmKTMrEiXd/pKicwGnnyvcSCxOwXKUxuDJ54JOtqQTf/bfm5JqnlVC
         hsAInh1/XI1lCpfLvNvh/pB3F4jBO+EMTxH8xAQxiqnsvWunmCrl9cNyAindjeU1QNqg
         y+t4yBcPL8JVYp6Ree7wyHi3DRlm5Jatn2svd5j13CxqIO5K4b+IAyJEc0FeCV7XtCHF
         UYgQps4Ne1PEHsIs37YwMMrRXF2niCflZtb+1D2uJNi8emTt6p/9QXl8sm9sNab/P+F6
         kXHZ0MSezY6CyNGzgIUV1oK6XGDxdAO48x21fKHGZVu+R/PIll7ugHYsXWN+8yYayoXD
         7Pqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOTkCqjt4oaSahQ/IsIEgLDAqlhf1a6ZVnl9IwUSYR4=;
        b=1luNsHPmqKkpC+ofiQCh97Rmx+QCNQFCb5pZoYyyqxFB9x7JAqpyKiQdI6p7ZGhQBF
         RIUI7ew6ts72ierWzYdTeV+vxCOXfGXSxJMSdNia/sd+tfsOVOjrzQBEu+FJ/1t/2Swz
         LmhB7IR2YPXWXggn5i8vRsfPpihMacBRtrxCm82thMwvx+nAHdxQD/rg4HgthzeSH0h8
         Fe1N0Inm1Ggnw5cFPwWSaCox/Jk98V7ASWU0WKaHMrSI9fLTQgnMtYJQ30CGkh4b1LnW
         S3wCkr1wFyIUG6HxQHgqO+c7alsW94WCy6Ymd/qmQITgcTItXSCZu8dgqpfNYCGQF3ys
         phzA==
X-Gm-Message-State: AOAM531jr9A26yt0ZAx3FKppC8pqL93MWPVG9ZsuuakLNVWNRuNVxVv6
	jHjlqgQL/IZJEIJvRmBNklCX7izImBNdFQzPBRu9
X-Google-Smtp-Source: 
 ABdhPJzJmL/P0I41q6sq5/R3r6Fx5p6UG3USLpo1+zyAyuVFbigkeVEpe3WgP/Bhb/29nJquqKqH/WkrUjMV5TQ7cM8=
X-Received: by 2002:a05:6402:5244:: with SMTP id
 t4mr8205854edd.42.1643192896821;
 Wed, 26 Jan 2022 02:28:16 -0800 (PST)
MIME-Version: 1.0
References: <20220120125418.236990-1-alice.ferrazzi@miraclelinux.com>
 <5de7f456-6428-ed67-de99-797058f6ede5@siemens.com>
In-Reply-To: <5de7f456-6428-ed67-de99-797058f6ede5@siemens.com>
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Wed, 26 Jan 2022 19:27:38 +0900
Message-ID: 
 <CANgtXuMcfX6JUBj_pf46Ukhd9rMK1j53a+E53jseUmzXkVQu2Q@mail.gmail.com>
Subject: Re: [isar-cip-core][PATCH v2 0/4] Add cip-core-image-kernelci
 building and uploading system
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jan 2022 10:28:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7485

On Wed, Jan 26, 2022 at 6:37 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 20.01.22 13:54, Alice Ferrazzi wrote:
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
> > v2:
> > * drop trailing semicolon from gitlab-ci.yml
> >
>
> Didn't you also want to de-duplicate the customization recipe, build
> kernelci on top of the common one?
>
from my understanding we decided to don't go in that way,
because changes in the common part could break the more generics
KernelCI settings.

Thanks,
Alicef

-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

