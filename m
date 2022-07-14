Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D981AC43334
	for <webhook@archiver.kernel.org>; Thu, 14 Jul 2022 09:21:20 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web08.5496.1657790475858434281
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Jul 2022 02:21:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=ysR6pDOH;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.42,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ed1-f42.google.com with SMTP id v12so1581215edc.10
        for <cip-dev@lists.cip-project.org>;
 Thu, 14 Jul 2022 02:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AyJ9fLQEhlEu1o9YyQWRWWAYOI23+NGGxtYxumjrhcE=;
        b=ysR6pDOHvMbdjHOn8IJOV5ZGFI+FfrhBoVgxYj24RSZh8WYaSGniTG52k4KEZEXWZ4
         6uvJhrJRU5t6k9AgdtrXNM4HpA6sDs/OP9AkU/lbFY+yda9IbmX0JHEM78C742mpHu3j
         nfDTkcW48WLntKNT9X0rFoEe3h9DUHETH9ObDf8DoXTHfW2ANWzsksSXtqMqhwHQ9nsu
         jVfb9eSf4phpw9Ku6qB2qo8x02R3elb91pGAOTVg60P6qSbV1MXjHRQ8/nHcCu7EApbT
         8JRLuydZ7lxsOI2bZc4FdSt7xoc6kG0TWZTxwdOrkssitVUkfM9bHuRMU49knFUaAIv2
         yUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AyJ9fLQEhlEu1o9YyQWRWWAYOI23+NGGxtYxumjrhcE=;
        b=dy3nCFLmPzyTOctbye/sOTmr0EYa6+SeXOtAm+4gi8qdy/gZUkooxntCUPzsyAoj1N
         HsdDxd60hy4aIkI2vw7wnMwsu6vwVaDl+rWEYE+FB1nzkHCnNxGsgdvnn3tPYnbnKZs4
         diye4aNkEnZojpaUwTddhwpfQEb9zMuVCEx1kFjBZsFUjybstfEevBhW/NvqTESddTQw
         fqJ9y06K4fjkYqWyGAciGSzcwy9FftwOvhCVZE6V4ggM0kqNUqTWbErObr5wk/d8GflR
         yU4nctlLSZQb2Vya3Oe1VCBkW0LDVuX7RpeBLZuLiAeVwu+0m9j7GeRrqYugoJc4z+0i
         Eo+A==
X-Gm-Message-State: AJIora+9Wsfl8EcG7Ev5Ev/GfXZgVzZV4fkc2s6DI89nQi3F/eZhUX6F
	IidcuKs5amqGYFxiLMt/T1aWcUdfoc5DSl2+cF7I
X-Google-Smtp-Source: 
 AGRyM1sfS5QZSu+FApIOCyUgysowGPkbMPYSwKT8OydxMYN0ZgMv6kQqzF5YXOQNEtSUbIde23eCdIWy2t9NhZSIAEM=
X-Received: by 2002:a05:6402:4301:b0:43a:e374:1557 with SMTP id
 m1-20020a056402430100b0043ae3741557mr11226274edc.229.1657790474158; Thu, 14
 Jul 2022 02:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220623181325.GA747@amd>
In-Reply-To: <20220623181325.GA747@amd>
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Thu, 14 Jul 2022 18:20:38 +0900
Message-ID: 
 <CANgtXuMGGqgBDqA=UCSnY6pd892Xppq+yb47if6Ek+0b90s0DA@mail.gmail.com>
Subject: Re: KernelCI reports
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org, chris.paterson2@renesas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Jul 2022 09:21:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8754

Hi Pavel,

On Fri, Jun 24, 2022 at 3:13 AM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> First... what I am currently using for testing: gitlab; I simply watch
> for green ticks there. It takes ~15 minutes to get results. Red cross
> in compile stage is pretty sure sign of build error. Red cross in
> testing means I need to look at the results, but it is pretty easy to
> see "network timeout" or "board unavailable" problems, and mostly I
> can just hit retry and get the green tick.
>
> What wories me about gitlab is that we have single board for 4.4-st,
> and just two for 4.4-cip.
>
> Now, kernelci.
>
> https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/06/cip.2022-06-23=
-12.01.html
>
> I got this link in the irc meeting:
>
> https://linux.kernelci.org/job/cip/
>
> Lets start with build results.
>
> linux-5.10.y-cip      v5.10.121-cip9 bd24696dd7ad23517733728da675a00cd307=
3916 169 7 3
>
> I click on "3" and get build error summary:
>
> Errors Summary
> 2      arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv3m
> 2       arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-mar=
ch=3D=E2=80=99
>
> ...but those are not kernel problems, that's buildsystem incompatible
> with config or something like that. Nothing for me to solve.
>
> Let me go through more:
>
> linux-4.19.y-cip        v4.19.246-cip75 38ce181ac6ca9f3decdd389cbfd0a38fe=
cdb28c7  111 8 1
> linux-4.19.y-cip        v4.19.245-cip74 0be9d6774be9b192bcea6fddada917ae3=
d22f22e  106 7 1
> linux-4.19.y-cip-rt     v4.19.245-cip74-rt25 c80ee3077a4ce344cf1cffa23af7=
67c9fd75d52c  181 16 6
> linux-4.4.y-cip v4.4.302-cip69-296-g52de9431d314 52de9431d314a28c4aa66d8f=
81144c9958c11168 164 18 5
> linux-5.10.y-cip-rt     v5.10.109-cip5-rt4 b41186882eaf0137277045da13ea64=
9577c42c11 177 8 3
> linux-5.10.y-cip        v5.10.112-cip6 c8f6747dcd02a8f87731c324f4bc37bd12=
0a8982 180 7 3
> linux-4.19.y-cip        v4.19.239-cip72 fdf770b2db8080de95dcf74cc75473190=
34a4a56 0 0 120
>
> That's 19 errors total + outlier of v4.19.239-cip72 with 120
> errors. None of the 19 errors is real. KernelCI needs to fix their
> configs/build environment.
>
> 120 errors are reported at https://linux.kernelci.org/build/cip/branch/li=
nux-4.19.y-cip/kernel/v4.19.239-cip72/ . Wow. Except that I don't see that =
many errors there. I see lines such as
>
> cm_x2xx_defconfig =E2=80=90 arm =E2=80=90 gcc-10  0 warnings 0 errors. Wh=
en I click for details I get "No test results found".
>
> https://linux.kernelci.org/build/id/6266a495d40dfd0dacff948c/
>
> Nothing for me to debug, either, agreed? So lets look at test results.
>
> Branch  Kernel Commit Build Status      Test Results    Date
> linux-5.10.y-cip      v5.10.121-cip9    bd24696dd7ad23517733728da675a00cd=
3073916 169 7 3  2457 256 21 2022-06-12
>
> 21 failures.
>
> If I click that, I can see that most regressions (11) are at baseline
> test plan. The machine that looks relevant to us is
> qemu_arm64-virt-gicv2 defconfig+arm64-chromebook --
>
> https://linux.kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kernel/v5=
.10.121-cip9/plan/baseline/
>
> New regression, last pass: v5.10.112-cip6
>
> I get to
> https://linux.kernelci.org/test/case/id/62a333452713980006a39c13/
> which looks quite useful, it lists successful run and failed run,
> v5.10.121-cip9 fails while v5.10.112-cip6 works.

Yes, checking for regressions is quite useful.

>
> Eventually I get to https://storage.kernelci.org/cip/linux-5.10.y-cip/v5.=
10.121-cip9/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-q=
emu_arm64-virt-gicv2.html .
>
> And sorry, no I don't see anything I could debug there. Did the docker
> fail to start? Hmm. Lets compare it with the older results.
>
> https://storage.kernelci.org/cip/linux-5.10.y-cip/v5.10.112-cip6/arm64/de=
fconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2=
.html . Aha, 404. No comparison possible.

The garbage collector removes everything that's older than 28 days.

>
> Lets try one more.
>
> rk3399-gru-kevin defconfig+arm64-chromebook =E2=80=90 arm64 =E2=80=90 gcc=
-10
>
> https://linux.kernelci.org/test/plan/id/62a337700aadba677da39bdd/
>
> It gets me to:
>
> https://storage.kernelci.org/cip/linux-5.10.y-cip/v5.10.121-cip9/arm64/de=
fconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.htm=
l
>
> I see some errors... Like missing firmware (not a kernel problem). At
> the end there's "tpm-chip-is-online: fail" . Is that what I should be deb=
ugging?
>
>  1368 12:21:39.212881  /usr/bin/tpm2_getcap
>   1369 12:21:39.251829  ERROR:sys:src/tss2-sys/api/Tss2_Sys_Execute.c:114=
:Tss2_Sys_ExecuteFinish() Unsupported device. The device is a TPM 1.2
>    1370 12:21:39.261387  ERROR:esys:src/tss2-esys/api/Esys_GetCapability.=
c:307:Esys_GetCapability_Finish() Received a non-TPM Error
>     1371 12:21:39.272254  ERROR:esys:src/tss2-esys/api/Esys_GetCapability=
.c:107:Esys_GetCapability() Esys Finish ErrorCode (0x00080001)
>      1372 12:21:39.281854  ERROR: Esys_GetCapability(0x80001) - sys:Catch=
 all for all errors not otherwise specified
>       1373 12:21:39.285316  ERROR: Unable to run tpm2_getcap
>
> Userland seems to say that it does not support this device. I guess I cou=
ld compare it with older boot?
>
> https://storage.kernelci.org/cip/linux-5.10.y-cip/v5.10.83-cip1-178-g2cf1=
d12aab81/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3=
399-gru-kevin.html
>
> Aha, no, could not, 404.

same here, the garbage collector removes everything that's older than 28 da=
ys.

>
> Now, let's go through Jan's
> example. https://linux.kernelci.org/build/id/61fbabe0cb6f27a6ce5d6f03/log=
s/?
> . Again, errors look like missconfigured build system, with
>
> arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv3
> arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-march=3D=E2=
=80=99
>
> Full log https://storage.kernelci.org/stable-rc/linux-4.4.y/v4.4.302/arm/=
rpc_defconfig/gcc-10/logs gives 404.

same here, the garbage collector removes everything that's older than 28 da=
ys.

>
> I spent quite some time trying to click around to find an error I
> could debug. I could not find one. All of above looks like kernelCI
> configuration problems. Can they be fixed and/or filtered out?
>

If you can write which configurations you want to filter out (because
they are not needed for CIP)
to KernelCI, KernelCI could blocklist such configurations.

for reference: https://github.com/kernelci/kernelci-core/issues/1053#issuec=
omment-1050679725

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

