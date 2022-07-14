Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A18C433EF
	for <webhook@archiver.kernel.org>; Thu, 14 Jul 2022 10:18:31 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web11.5979.1657793907667001646
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Jul 2022 03:18:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=RVnm1SxC;
 spf=pass (domain: miraclelinux.com, ip: 209.85.218.42,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ej1-f42.google.com with SMTP id z23so2547399eju.8
        for <cip-dev@lists.cip-project.org>;
 Thu, 14 Jul 2022 03:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RfPLUjxqsxfpeeG1TZlFKhtK9d9QyL1WndouM2qMzt4=;
        b=RVnm1SxCEvFdui/nu8AzJy5S/d9220JVTnAhdVt0hAD1rQqOW+9fHfO4oCUpEHJ/o0
         AhHcf/WxQqVNXxhB4RX6LD14DHg6UjjzUb6q4pdd+pzPkyY4oiYh4KmYjHSLawnErdhL
         IKQj3F8j8h7uO9dZQFY94AMo+ugNVuhszNO/ORPi9yZ1mhNYITCB1WdUHVTXkvqgt5fj
         M4x3m/HfGna7f1nRzMEEO9E6mNrOIE4B+UuSOYjWitGB957GWNAHltfFTGf+k+5HPHTc
         Sl0yl7E3xXaeMswlUKnp/EJ8Rrrdn+XYKgpx1r8kIvne29cISZLqg1RFMbUA4VVxencM
         M1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RfPLUjxqsxfpeeG1TZlFKhtK9d9QyL1WndouM2qMzt4=;
        b=B5ZUnfzUJOhPmD4GV+jLvqaPdb+9PCrm90llkbGU5wtWBWQdr1hw1Zgg+NXT2RT9gm
         Doa9vPB4Y+ODwrZlbIksm9dDleQfML+w3SMryd2PyViRFnBa5znfDSCqbmkgsrGXlJ3J
         Jct99GaSJoNk9gSUKadzCvmFbQNE5FrkGjLg5Lno0Yilpbh7LBJXkPEsBCGqZjn0L1qt
         e3c/6B1T+rrJl2zq5bCrETKC4wVUzr/eiB4CKxTlfLjncoe641O9hBOG7uvxxiTSGCOJ
         u1S85pQvKdQg6U73BvQrH844F/TRWBefjHE7YOqayTAGBU8+B5ZgiWf09fgjREBGa2eM
         D1zg==
X-Gm-Message-State: AJIora/pnhKkuO6iFqcnzV1Vje2GCHWbNupAuOyCcti7Flf1bmh8JieG
	/dVSfttVnTiXDJEIbVkhElfJMBRzCsxJdL7Ryt5mKK7LsL9D
X-Google-Smtp-Source: 
 AGRyM1saEhJscUiHzUt45kAHhzChtBKK9kGDv2TTGdnmNFCvJ+nPXxwfzYTT94MnKhaOeEcw5iBjbs5ipjElj+k5d1c=
X-Received: by 2002:a17:906:b782:b0:726:f979:7adb with SMTP id
 dt2-20020a170906b78200b00726f9797adbmr7940821ejb.498.1657793905743; Thu, 14
 Jul 2022 03:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220623181325.GA747@amd>
 <CANgtXuMGGqgBDqA=UCSnY6pd892Xppq+yb47if6Ek+0b90s0DA@mail.gmail.com>
 <55dec7b9bbacfc1e30524e8c5f2fa6a31447b2aa.camel@siemens.com>
In-Reply-To: <55dec7b9bbacfc1e30524e8c5f2fa6a31447b2aa.camel@siemens.com>
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Thu, 14 Jul 2022 19:17:49 +0900
Message-ID: 
 <CANgtXuNbpnPE9RJqr2kwMBuEnDq1wEaR8mCCG_hetORhCMvGqw@mail.gmail.com>
Subject: Re: [cip-dev] KernelCI reports
To: cip-dev@lists.cip-project.org
Cc: "pavel@denx.de" <pavel@denx.de>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
 florian.bezdeka@siemens.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Jul 2022 10:18:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8757

On Thu, Jul 14, 2022 at 6:45 PM florian.bezdeka@siemens.com
<florian.bezdeka@siemens.com> wrote:
>
> On Thu, 2022-07-14 at 18:20 +0900, Alice Ferrazzi via lists.cip-
> project.org wrote:
> > Hi Pavel,
> >
> > On Fri, Jun 24, 2022 at 3:13 AM Pavel Machek <pavel@denx.de> wrote:
> > >
> > > Hi!
> > >
> > > First... what I am currently using for testing: gitlab; I simply watc=
h
> > > for green ticks there. It takes ~15 minutes to get results. Red cross
> > > in compile stage is pretty sure sign of build error. Red cross in
> > > testing means I need to look at the results, but it is pretty easy to
> > > see "network timeout" or "board unavailable" problems, and mostly I
> > > can just hit retry and get the green tick.
> > >
> > > What wories me about gitlab is that we have single board for 4.4-st,
> > > and just two for 4.4-cip.
> > >
> > > Now, kernelci.
> > >
> > > https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/06/cip.2022-0=
6-23-12.01.html
> > >
> > > I got this link in the irc meeting:
> > >
> > > https://linux.kernelci.org/job/cip/
> > >
> > > Lets start with build results.
> > >
> > > linux-5.10.y-cip      v5.10.121-cip9 bd24696dd7ad23517733728da675a00c=
d3073916 169 7 3
> > >
> > > I click on "3" and get build error summary:
> > >
> > > Errors Summary
> > > 2      arm-linux-gnueabihf-gcc: error: unrecognized -march target: ar=
mv3m
> > > 2       arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98=
-march=3D=E2=80=99
> > >
> > > ...but those are not kernel problems, that's buildsystem incompatible
> > > with config or something like that. Nothing for me to solve.
> > >
> > > Let me go through more:
> > >
> > > linux-4.19.y-cip        v4.19.246-cip75 38ce181ac6ca9f3decdd389cbfd0a=
38fecdb28c7  111 8 1
> > > linux-4.19.y-cip        v4.19.245-cip74 0be9d6774be9b192bcea6fddada91=
7ae3d22f22e  106 7 1
> > > linux-4.19.y-cip-rt     v4.19.245-cip74-rt25 c80ee3077a4ce344cf1cffa2=
3af767c9fd75d52c  181 16 6
> > > linux-4.4.y-cip v4.4.302-cip69-296-g52de9431d314 52de9431d314a28c4aa6=
6d8f81144c9958c11168 164 18 5
> > > linux-5.10.y-cip-rt     v5.10.109-cip5-rt4 b41186882eaf0137277045da13=
ea649577c42c11 177 8 3
> > > linux-5.10.y-cip        v5.10.112-cip6 c8f6747dcd02a8f87731c324f4bc37=
bd120a8982 180 7 3
> > > linux-4.19.y-cip        v4.19.239-cip72 fdf770b2db8080de95dcf74cc7547=
319034a4a56 0 0 120
> > >
> > > That's 19 errors total + outlier of v4.19.239-cip72 with 120
> > > errors. None of the 19 errors is real. KernelCI needs to fix their
> > > configs/build environment.
> > >
> > > 120 errors are reported at https://linux.kernelci.org/build/cip/branc=
h/linux-4.19.y-cip/kernel/v4.19.239-cip72/ . Wow. Except that I don't see t=
hat many errors there. I see lines such as
> > >
> > > cm_x2xx_defconfig =E2=80=90 arm =E2=80=90 gcc-10  0 warnings 0 errors=
. When I click for details I get "No test results found".
> > >
> > > https://linux.kernelci.org/build/id/6266a495d40dfd0dacff948c/
> > >
> > > Nothing for me to debug, either, agreed? So lets look at test results=
.
> > >
> > > Branch  Kernel Commit Build Status      Test Results    Date
> > > linux-5.10.y-cip      v5.10.121-cip9    bd24696dd7ad23517733728da675a=
00cd3073916 169 7 3  2457 256 21 2022-06-12
> > >
> > > 21 failures.
> > >
> > > If I click that, I can see that most regressions (11) are at baseline
> > > test plan. The machine that looks relevant to us is
> > > qemu_arm64-virt-gicv2 defconfig+arm64-chromebook --
> > >
> > > https://linux.kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.121-cip9/plan/baseline/
> > >
> > > New regression, last pass: v5.10.112-cip6
> > >
> > > I get to
> > > https://linux.kernelci.org/test/case/id/62a333452713980006a39c13/
> > > which looks quite useful, it lists successful run and failed run,
> > > v5.10.121-cip9 fails while v5.10.112-cip6 works.
> >
> > Yes, checking for regressions is quite useful.
> >
> > >
> > > Eventually I get to https://storage.kernelci.org/cip/linux-5.10.y-cip=
/v5.10.121-cip9/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseli=
ne-qemu_arm64-virt-gicv2.html .
> > >
> > > And sorry, no I don't see anything I could debug there. Did the docke=
r
> > > fail to start? Hmm. Lets compare it with the older results.
> > >
> > > https://storage.kernelci.org/cip/linux-5.10.y-cip/v5.10.112-cip6/arm6=
4/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-virt-g=
icv2.html . Aha, 404. No comparison possible.
> >
> > The garbage collector removes everything that's older than 28 days.
> >
> > >
> > > Lets try one more.
> > >
> > > rk3399-gru-kevin defconfig+arm64-chromebook =E2=80=90 arm64 =E2=80=90=
 gcc-10
> > >
> > > https://linux.kernelci.org/test/plan/id/62a337700aadba677da39bdd/
> > >
> > > It gets me to:
> > >
> > > https://storage.kernelci.org/cip/linux-5.10.y-cip/v5.10.121-cip9/arm6=
4/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin=
.html
> > >
> > > I see some errors... Like missing firmware (not a kernel problem). At
> > > the end there's "tpm-chip-is-online: fail" . Is that what I should be=
 debugging?
> > >
> > >  1368 12:21:39.212881  /usr/bin/tpm2_getcap
> > >   1369 12:21:39.251829  ERROR:sys:src/tss2-sys/api/Tss2_Sys_Execute.c=
:114:Tss2_Sys_ExecuteFinish() Unsupported device. The device is a TPM 1.2
> > >    1370 12:21:39.261387  ERROR:esys:src/tss2-esys/api/Esys_GetCapabil=
ity.c:307:Esys_GetCapability_Finish() Received a non-TPM Error
> > >     1371 12:21:39.272254  ERROR:esys:src/tss2-esys/api/Esys_GetCapabi=
lity.c:107:Esys_GetCapability() Esys Finish ErrorCode (0x00080001)
> > >      1372 12:21:39.281854  ERROR: Esys_GetCapability(0x80001) - sys:C=
atch all for all errors not otherwise specified
> > >       1373 12:21:39.285316  ERROR: Unable to run tpm2_getcap
> > >
> > > Userland seems to say that it does not support this device. I guess I=
 could compare it with older boot?
> > >
> > > https://storage.kernelci.org/cip/linux-5.10.y-cip/v5.10.83-cip1-178-g=
2cf1d12aab81/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline=
-rk3399-gru-kevin.html
> > >
> > > Aha, no, could not, 404.
> >
> > same here, the garbage collector removes everything that's older than 2=
8 days.
> >
> > >
> > > Now, let's go through Jan's
> > > example. https://linux.kernelci.org/build/id/61fbabe0cb6f27a6ce5d6f03=
/logs/?
> > > . Again, errors look like missconfigured build system, with
> > >
> > > arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv3
> > > arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-march=
=3D=E2=80=99
> > >
> > > Full log https://storage.kernelci.org/stable-rc/linux-4.4.y/v4.4.302/=
arm/rpc_defconfig/gcc-10/logs gives 404.
> >
> > same here, the garbage collector removes everything that's older than 2=
8 days.
> >
> > >
> > > I spent quite some time trying to click around to find an error I
> > > could debug. I could not find one. All of above looks like kernelCI
> > > configuration problems. Can they be fixed and/or filtered out?
> > >
> >
> > If you can write which configurations you want to filter out (because
> > they are not needed for CIP)
> > to KernelCI, KernelCI could blocklist such configurations.
> >
> > for reference: https://github.com/kernelci/kernelci-core/issues/1053#is=
suecomment-1050679725
>
> Jan asked me to check the kernelci related issues you summarized here
> related to the 4.4-cip branch. I tried to find the latest 4.4 test
> report that failed. Can someone point me there?
>
> With some guidance from Alice it should be possible for me to come up
> with a exclude/blocklist to bring 4.4 back to a "green" state.
> Afterwards we would have to sort out all the problems (decoupled from
> Pavel's testing)
>

Hello Florian

Latest build 4.4 cip is here
https://linux.kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel/v4.4.=
302-cip69-296-g52de9431d314/
is a really old build as the latest 4.4 cip tag is v4.4.302-cip69
tagged on date 2022-04-04 13:18:30 +0900
Unfortunately as I previously said KernelCI garbage collector removes
everything that's older than 28 days.
You can find CIP builds here: https://linux.kernelci.org/job/cip/

Thanks,
Alicef


--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

