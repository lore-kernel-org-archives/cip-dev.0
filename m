Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976B9C433F5
	for <webhook@archiver.kernel.org>; Thu,  2 Dec 2021 12:25:06 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web12.7632.1638447904614473147
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Dec 2021 04:25:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=5HNJXQfY;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.47,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ed1-f47.google.com with SMTP id x6so114929412edr.5
        for <cip-dev@lists.cip-project.org>;
 Thu, 02 Dec 2021 04:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W+ZVtCOQkVlDI/QwQPM3d++dbmRueFztlWxAJ0xBX+4=;
        b=5HNJXQfYDSjJsMvj76YqZADmKaD327gsmdRsVlbH1SSggpE2akARN9L37Xzi/GIQND
         vh6iyUwIwdUh9D8nTMGkDIZG0gOaifQcAmLXwIFqiplUN/+gGAMwDA2WC1YQR2TQxbXT
         8qFeGHfFQmRC7LYi1L+KylotvnfQ4rPJN2+/d8dJVLWu4ZVsC5giQxzEtElAewnLDB38
         By2ETK9dAhSOURf+QpItAD5Oxue3aF9ZsIzU9uR46DKuvURJxZzwiOAKLjMRuOvW9p0N
         jJZrr7gieDGJNPbKbnUjkGJiwk4EvR5p7Zh7EHAezbwEidE99mKtZMlc5pODX3BdoVR5
         FFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W+ZVtCOQkVlDI/QwQPM3d++dbmRueFztlWxAJ0xBX+4=;
        b=eoJYaZg0fQOR0cBf0GtGUMExRv2ykAIQsLmx1QslMlWJVYppibNsfOkgApCA5e1ON1
         huwZixOcWzR07/kwio+2IuLGDpF2XYbJO4AXSiYDMC5d7Ej6wErnXb+yJthu/vZ3s1PG
         Itp9K9XMtPwXJFxuKWKR9yxRXg7ZFDrMcbfWBMoO55WPUdN0tfUG3Bg74NGWvyfwJzsk
         xKErYF/qtu1PtcWzG9TGih3wSdLohT1B4A9M7BCHKkdqcy0UrY9NybNkJER0D9fpW+FM
         +h4ryj269KXsdEZs+UVhKxffr9xNvsaF8aX2TST1qs2G2xKwQeXIV1OLllCBW3OwBOnU
         qbyQ==
X-Gm-Message-State: AOAM5320yUGaw1hsP6zG2E/GsoSlTTxxRTxQPawsfBmHePzW4Y0Hq1wf
	wcKLDDl9dx+PQpWgSrTsq5PlCy9IabLF0ti/o4Te
X-Google-Smtp-Source: 
 ABdhPJypky/neKUTtZ7B45Wa/syHcWY6Pihl8Rp0gYYeIfwYXDkmEeuSCapBUJ/jjBhVDxRjS81dtSr4S1pMyXY6zUw=
X-Received: by 2002:a17:906:fb17:: with SMTP id
 lz23mr14976038ejb.149.1638447902491;
 Thu, 02 Dec 2021 04:25:02 -0800 (PST)
MIME-Version: 1.0
References: <61a58f0e.1c69fb81.ac5ac.8c21@mx.google.com>
 <20211130084137.GB2355@amd>
In-Reply-To: <20211130084137.GB2355@amd>
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Thu, 2 Dec 2021 21:22:12 +0900
Message-ID: 
 <CANgtXuPkArhGMO1-WuA971CJn4qKrs+6qpufk5_us0D5TSHLPw@mail.gmail.com>
Subject: Re: [cip-dev] cip/linux-4.19.y-cip baseline: 121 runs, 1 regressions
 (v4.19.217-cip62) #kernelci
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org, bot@kernelci.org,
	Chris.Paterson2@renesas.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Dec 2021 12:25:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7059

On Tue, Nov 30, 2021 at 5:41 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > platform | arch | lab           | compiler | defconfig           | regressions
> > ---------+------+---------------+----------+---------------------+------------
> > panda    | arm  | lab-collabora | gcc-10   | omap2plus_defconfig | 1
> >
> >   Details:     https://kernelci.org/test/plan/id/61a587a0ab3b0079bd18f6d7
> >
> >   Results:     5 PASS, 1 FAIL, 0 SKIP
> >   Full config: omap2plus_defconfig
> >   Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 20210110)
> >   Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.217-cip62/arm/omap2plus_defconfig/gcc-10/lab-collabora/baseline-panda.txt
> >   HTML log:
> > https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.217-cip62/arm/omap2plus_defconfig/gcc-10/lab-collabora/baseline-panda.html
>
> So this has enough information to tell me that we have a kernel
> problem there, good:
>
> 02:08:17.792502  <6>[   18.847320] omap-mailbox 4a0f4000.mailbox: omap
> mailbox rev 0x400
> 02:08:17.800596  <0>[   18.857543] BUG: spinlock bad magic on CPU#0,
> udevd/110
> 02:08:17.808843  <6>[   18.857788] emif 4c000000.emif: emif_probe:
> device configured with addr = (ptrval) and IRQ26
> 02:08:17.818753  <0>[   18.863311]  lock: emif_lock+0x0/0xffffecfc
> [emif], .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1
> 02:08:17.825277  <4>[   18.877502] CPU: 0 PID: 110 Comm: udevd Not
> tainted 4.19.217-cip62 #1
> 02:08:17.831655  <4>[   18.888275] Hardware name: Generic OMAP4
> (Flattened Device Tree)
> 02:08:17.839660  <4>[   18.894195] [<c01123bc>] (unwind_backtrace)
> from [<c010cc28>] (show_stack+0x10/0x14)
> 02:08:17.847570  <4>[   18.900482] [<c010cc28>] (show_stack) from
> [<c0949dd4>] (dump_stack+0xe0/0x114)
> 02:08:17.855211  <4>[   18.905761] [<c0949dd4>] (dump_stack) from
> [<c01a9168>] (do_raw_spin_lock+0xbc/0x124)
>
> Unfortunately, not enough information to debug the problem, I'm
> afraid. Questions to start debugging this would be:
>
> a) is the problem deterministic?
>

as the testing board are actually different is unclear.
The board and results can be seen here:
https://linux.kernelci.org/test/plan/id/61a587a0ab3b0079bd18f6d7/

the output log is here:
https://storage.kernelci.org/cip/linux-4.19.y-cip/v4.19.217-cip62/arm/omap2plus_defconfig/gcc-10/lab-collabora/baseline-panda.html
working board example log is here (works for 4.19.216-cip61 but using
a board on baylibre that could be different from the board on
collabora):
https://storage.kernelci.org/cip/linux-4.19.y-cip/v4.19.216-cip61/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-panda.html
looks like there is also a passed test on lab-baylibre for the panda
board with the same kernel:
https://storage.kernelci.org/cip/linux-4.19.y-cip/v4.19.217-cip62/arm/omap2plus_defconfig/gcc-10/lab-baylibre/baseline-panda.html

The job json file for replicate the job on a lava lab with panda board
can be found here:
https://lava.collabora.co.uk/scheduler/job/5113437/definition


> b) is the problem present in v4.19.217 ?
>

here is the diff with 4.19.217 stable
https://www.diffchecker.com/JjmXiP7b

> c) what were the last -stable and -cip kernels that worked?
>

if you click on the link on the details or the link here under:
https://linux.kernelci.org/test/case/id/61a587a0ab3b0079bd18f6dd/
is wrote:
New regression, last pass: v4.19.216-cip61

This is the one that passed:
https://linux.kernelci.org/test/plan/id/618f6407f33d0dd1e633595d/


- About bisecting the kernel.
We are currently in the process of activating CIP to the list of
automated bisected kernel
for getting more information on this and future problems.
The following issue is the request to KernelCI for adding CIP to the
automated bisected kernel list.
https://github.com/kernelci/kernelci-core/issues/922



Thanks,
Alice


--
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

