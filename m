Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D91C43334
	for <webhook@archiver.kernel.org>; Thu, 14 Jul 2022 10:46:11 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web11.6173.1657795560731670105
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Jul 2022 03:46:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=xc8Gli4z;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.50,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ed1-f50.google.com with SMTP id w12so1826301edd.13
        for <cip-dev@lists.cip-project.org>;
 Thu, 14 Jul 2022 03:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TBr2PPAKtHrd9m0JG12iFBQWnxwjdJYNvsuab6Z6SDQ=;
        b=xc8Gli4zTjPfFSiuwQnnCC/TYKEdJkHqufhIW4G80sVAvb2H41Ulh6W+AT47rQTQEF
         QPByWA544Vs8Ggf8WX3CARE4ldnJCdnjEO1x3/2AGbc0hRwPvwTDGrreZ8S9FfLQ7v1s
         aRJTVpzjRZW9q40Mqvx/PPPk4hCw0qj/86kWVUJwieVSlMamXiUykB2aYAstFYz6yctb
         YLGkgS/571SsrPaVTDdOqWDxw55vW/Gf6z40KszKLN623+X1Wrl7xHAOlPD3FK6l1Mi4
         8LAfWFh1o2yEOiiNovvQNTHQ98Qi4+XjSeAPHpppg4pavV4Y1X1sZ8KMEGP6/ORQ/nfa
         Is8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TBr2PPAKtHrd9m0JG12iFBQWnxwjdJYNvsuab6Z6SDQ=;
        b=vnWFjzC5Ts0eskzSnMGHC4IrO3ycFesWItxprxomuaD+9l7UblGPHV2wv4WCtBfL5x
         Ha8zRqRAq3hv97sHzPNmK/PKw2zfrMjL98vmk0F9TmKmHJ2r7WGPv+s0qVx/RY+TKRiO
         BzPKAF44WW7+C2zFz4GjkIcSoqThHBxKkIFxkLIoC5igA82AfInlqWVf7YuHCYG2yu7m
         wsE4UxyZ1ZE5fax6OD1zT33ueCN5EWR4Cer5piitcegaKX3P6L5U/h0wxPoLMK/wdBlB
         xT8pdhRgbW3HtMIXoOVDegnppxljz7ToT0COGsy7yg23VDeED7m7sYU088ihtzq1d3MK
         aEGA==
X-Gm-Message-State: AJIora+avLuAEC5WDyhg13mnUnDskAz5NP5S7/Y6M7FtQ+8SRUoD6tUs
	NudSe2SVNFNIVSHlMvwjWHgTg7a2rpMw3JHGNlFh
X-Google-Smtp-Source: 
 AGRyM1uq4Rg0swJ983+JbJTuW4juKTFXiAJ6QlFVAeUmGoLaTjbAQqBtn6GgvH8Dk7zdglUJ/OX0npTvMyqs5hMY0es=
X-Received: by 2002:a05:6402:782:b0:43a:7387:39df with SMTP id
 d2-20020a056402078200b0043a738739dfmr11769318edy.251.1657795559017; Thu, 14
 Jul 2022 03:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220623181325.GA747@amd>
 <CANgtXuMGGqgBDqA=UCSnY6pd892Xppq+yb47if6Ek+0b90s0DA@mail.gmail.com>
 <55dec7b9bbacfc1e30524e8c5f2fa6a31447b2aa.camel@siemens.com>
 <CANgtXuNbpnPE9RJqr2kwMBuEnDq1wEaR8mCCG_hetORhCMvGqw@mail.gmail.com>
 <58751ddf9a708c00697d79d03c61f7fc49a64124.camel@siemens.com>
In-Reply-To: <58751ddf9a708c00697d79d03c61f7fc49a64124.camel@siemens.com>
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Thu, 14 Jul 2022 19:45:22 +0900
Message-ID: 
 <CANgtXuNv_2wPDNWURk5n8k0KhCKezB6JFK0x6iUCZnfTazCLrw@mail.gmail.com>
Subject: Re: [cip-dev] KernelCI reports
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "pavel@denx.de" <pavel@denx.de>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Jul 2022 10:46:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8759

hello Florian,

On Thu, Jul 14, 2022 at 7:27 PM Bezdeka, Florian
<florian.bezdeka@siemens.com> wrote:
>
> On Thu, 2022-07-14 at 19:17 +0900, Alice Ferrazzi wrote:
> > On Thu, Jul 14, 2022 at 6:45 PM florian.bezdeka@siemens.com
> > <florian.bezdeka@siemens.com> wrote:
> > >
> > > On Thu, 2022-07-14 at 18:20 +0900, Alice Ferrazzi via lists.cip-
> > > project.org wrote:
> > > > Hi Pavel,
> > > >
> > > > On Fri, Jun 24, 2022 at 3:13 AM Pavel Machek <pavel@denx.de> wrote:
> > > > >
> > > > > Hi!
> > > > >
> > > > > First... what I am currently using for testing: gitlab; I simply =
watch
> > > > > for green ticks there. It takes ~15 minutes to get results. Red c=
ross
> > > > > in compile stage is pretty sure sign of build error. Red cross in
> > > > > testing means I need to look at the results, but it is pretty eas=
y to
> > > > > see "network timeout" or "board unavailable" problems, and mostly=
 I
> > > > > can just hit retry and get the green tick.
> > > > >
> > > > > What wories me about gitlab is that we have single board for 4.4-=
st,
> > > > > and just two for 4.4-cip.
> > > > >
> > > > > Now, kernelci.
> > > > >
> > > > > https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/06/cip.20=
22-06-23-12.01.html
> > > > >
> > > > > I got this link in the irc meeting:
> > > > >
> > > > > https://linux.kernelci.org/job/cip/
> > > > >
> > > > > Lets start with build results.
> > > > >
> > > > > linux-5.10.y-cip      v5.10.121-cip9 bd24696dd7ad23517733728da675=
a00cd3073916 169 7 3
> > > > >
> > > > > I click on "3" and get build error summary:
> > > > >
> > > > > Errors Summary
> > > > > 2      arm-linux-gnueabihf-gcc: error: unrecognized -march target=
: armv3m
> > > > > 2       arm-linux-gnueabihf-gcc: error: missing argument to =E2=
=80=98-march=3D=E2=80=99
> > > > >
> > > > > ...but those are not kernel problems, that's buildsystem incompat=
ible
> > > > > with config or something like that. Nothing for me to solve.
> > > > >
> > > > > Let me go through more:
> > > > >
> > > > > linux-4.19.y-cip        v4.19.246-cip75 38ce181ac6ca9f3decdd389cb=
fd0a38fecdb28c7  111 8 1
> > > > > linux-4.19.y-cip        v4.19.245-cip74 0be9d6774be9b192bcea6fdda=
da917ae3d22f22e  106 7 1
> > > > > linux-4.19.y-cip-rt     v4.19.245-cip74-rt25 c80ee3077a4ce344cf1c=
ffa23af767c9fd75d52c  181 16 6
> > > > > linux-4.4.y-cip v4.4.302-cip69-296-g52de9431d314 52de9431d314a28c=
4aa66d8f81144c9958c11168 164 18 5
> > > > > linux-5.10.y-cip-rt     v5.10.109-cip5-rt4 b41186882eaf0137277045=
da13ea649577c42c11 177 8 3
> > > > > linux-5.10.y-cip        v5.10.112-cip6 c8f6747dcd02a8f87731c324f4=
bc37bd120a8982 180 7 3
> > > > > linux-4.19.y-cip        v4.19.239-cip72 fdf770b2db8080de95dcf74cc=
7547319034a4a56 0 0 120
> > > > >
> > > > > That's 19 errors total + outlier of v4.19.239-cip72 with 120
> > > > > errors. None of the 19 errors is real. KernelCI needs to fix thei=
r
> > > > > configs/build environment.
> > > > >
> > > > > 120 errors are reported at https://linux.kernelci.org/build/cip/b=
ranch/linux-4.19.y-cip/kernel/v4.19.239-cip72/ . Wow. Except that I don't s=
ee that many errors there. I see lines such as
> > > > >
> > > > > cm_x2xx_defconfig =E2=80=90 arm =E2=80=90 gcc-10  0 warnings 0 er=
rors. When I click for details I get "No test results found".
> > > > >
> > > > > https://linux.kernelci.org/build/id/6266a495d40dfd0dacff948c/
> > > > >
> > > > > Nothing for me to debug, either, agreed? So lets look at test res=
ults.
> > > > >
> > > > > Branch  Kernel Commit Build Status      Test Results    Date
> > > > > linux-5.10.y-cip      v5.10.121-cip9    bd24696dd7ad23517733728da=
675a00cd3073916 169 7 3  2457 256 21 2022-06-12
> > > > >
> > > > > 21 failures.
> > > > >
> > > > > If I click that, I can see that most regressions (11) are at base=
line
> > > > > test plan. The machine that looks relevant to us is
> > > > > qemu_arm64-virt-gicv2 defconfig+arm64-chromebook --
> > > > >
> > > > > https://linux.kernelci.org/test/job/cip/branch/linux-5.10.y-cip/k=
ernel/v5.10.121-cip9/plan/baseline/
> > > > >
> > > > > New regression, last pass: v5.10.112-cip6
> > > > >
> > > > > I get to
> > > > > https://linux.kernelci.org/test/case/id/62a333452713980006a39c13/
> > > > > which looks quite useful, it lists successful run and failed run,
> > > > > v5.10.121-cip9 fails while v5.10.112-cip6 works.
> > > >
> > > > Yes, checking for regressions is quite useful.
> > > >
> > > > >
> > > > > Eventually I get to https://storage.kernelci.org/cip/linux-5.10.y=
-cip/v5.10.121-cip9/arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/ba=
seline-qemu_arm64-virt-gicv2.html .
> > > > >
> > > > > And sorry, no I don't see anything I could debug there. Did the d=
ocker
> > > > > fail to start? Hmm. Lets compare it with the older results.
> > > > >
> > > > > https://storage.kernelci.org/cip/linux-5.10.y-cip/v5.10.112-cip6/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-baylibre/baseline-qemu_arm64-vi=
rt-gicv2.html . Aha, 404. No comparison possible.
> > > >
> > > > The garbage collector removes everything that's older than 28 days.
> > > >
> > > > >
> > > > > Lets try one more.
> > > > >
> > > > > rk3399-gru-kevin defconfig+arm64-chromebook =E2=80=90 arm64 =E2=
=80=90 gcc-10
> > > > >
> > > > > https://linux.kernelci.org/test/plan/id/62a337700aadba677da39bdd/
> > > > >
> > > > > It gets me to:
> > > > >
> > > > > https://storage.kernelci.org/cip/linux-5.10.y-cip/v5.10.121-cip9/=
arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk3399-gru-k=
evin.html
> > > > >
> > > > > I see some errors... Like missing firmware (not a kernel problem)=
. At
> > > > > the end there's "tpm-chip-is-online: fail" . Is that what I shoul=
d be debugging?
> > > > >
> > > > >  1368 12:21:39.212881  /usr/bin/tpm2_getcap
> > > > >   1369 12:21:39.251829  ERROR:sys:src/tss2-sys/api/Tss2_Sys_Execu=
te.c:114:Tss2_Sys_ExecuteFinish() Unsupported device. The device is a TPM 1=
.2
> > > > >    1370 12:21:39.261387  ERROR:esys:src/tss2-esys/api/Esys_GetCap=
ability.c:307:Esys_GetCapability_Finish() Received a non-TPM Error
> > > > >     1371 12:21:39.272254  ERROR:esys:src/tss2-esys/api/Esys_GetCa=
pability.c:107:Esys_GetCapability() Esys Finish ErrorCode (0x00080001)
> > > > >      1372 12:21:39.281854  ERROR: Esys_GetCapability(0x80001) - s=
ys:Catch all for all errors not otherwise specified
> > > > >       1373 12:21:39.285316  ERROR: Unable to run tpm2_getcap
> > > > >
> > > > > Userland seems to say that it does not support this device. I gue=
ss I could compare it with older boot?
> > > > >
> > > > > https://storage.kernelci.org/cip/linux-5.10.y-cip/v5.10.83-cip1-1=
78-g2cf1d12aab81/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-rk3399-gru-kevin.html
> > > > >
> > > > > Aha, no, could not, 404.
> > > >
> > > > same here, the garbage collector removes everything that's older th=
an 28 days.
> > > >
> > > > >
> > > > > Now, let's go through Jan's
> > > > > example. https://linux.kernelci.org/build/id/61fbabe0cb6f27a6ce5d=
6f03/logs/?
> > > > > . Again, errors look like missconfigured build system, with
> > > > >
> > > > > arm-linux-gnueabihf-gcc: error: unrecognized -march target: armv3
> > > > > arm-linux-gnueabihf-gcc: error: missing argument to =E2=80=98-mar=
ch=3D=E2=80=99
> > > > >
> > > > > Full log https://storage.kernelci.org/stable-rc/linux-4.4.y/v4.4.=
302/arm/rpc_defconfig/gcc-10/logs gives 404.
> > > >
> > > > same here, the garbage collector removes everything that's older th=
an 28 days.
> > > >
> > > > >
> > > > > I spent quite some time trying to click around to find an error I
> > > > > could debug. I could not find one. All of above looks like kernel=
CI
> > > > > configuration problems. Can they be fixed and/or filtered out?
> > > > >
> > > >
> > > > If you can write which configurations you want to filter out (becau=
se
> > > > they are not needed for CIP)
> > > > to KernelCI, KernelCI could blocklist such configurations.
> > > >
> > > > for reference: https://github.com/kernelci/kernelci-core/issues/105=
3#issuecomment-1050679725
> > >
> > > Jan asked me to check the kernelci related issues you summarized here
> > > related to the 4.4-cip branch. I tried to find the latest 4.4 test
> > > report that failed. Can someone point me there?
> > >
> > > With some guidance from Alice it should be possible for me to come up
> > > with a exclude/blocklist to bring 4.4 back to a "green" state.
> > > Afterwards we would have to sort out all the problems (decoupled from
> > > Pavel's testing)
> > >
> >
> > Hello Florian
> >
> > Latest build 4.4 cip is here
> > https://linux.kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel/v=
4.4.302-cip69-296-g52de9431d314/
> > is a really old build as the latest 4.4 cip tag is v4.4.302-cip69
> > tagged on date 2022-04-04 13:18:30 +0900
> > Unfortunately as I previously said KernelCI garbage collector removes
> > everything that's older than 28 days.
> > You can find CIP builds here: https://linux.kernelci.org/job/cip/
>
> Thanks a lot Alice!
>
> Any chance for me to trigger a re-build?
>

I'm trying to triggering CIP_4.4 again it should appear in
https://staging.kernelci.org/job/
but Pavel have is own repository for triggering re-builds
"""
tree: cip-gitlab
branch: 'ci/pavel/linux-test'
variants: *cip_variants
cip_pavel-test:
"""

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

