Return-Path: <SRS0=/ZEk=JU=lists.cip-project.org=bounce+64572+6385+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,WEIRD_PORT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E37C433B4
	for <cip-dev@archiver.kernel.org>; Fri, 23 Apr 2021 08:49:46 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DEAD6141C
	for <cip-dev@archiver.kernel.org>; Fri, 23 Apr 2021 08:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DEAD6141C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6385+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 50tmYY4521723x1mgbIJt3kx; Fri, 23 Apr 2021 01:49:43 -0700
X-Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.web10.7036.1619167781313663514
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Apr 2021 01:49:43 -0700
X-Received: by mail-ed1-f53.google.com with SMTP id z5so20095279edr.11
        for <cip-dev@lists.cip-project.org>; Fri, 23 Apr 2021 01:49:41 -0700 (PDT)
X-Gm-Message-State: Sg5WYqmrDnex8wJIDUfDHTCfx4520388AA=
X-Google-Smtp-Source: ABdhPJz3NG844qJYreuxqKo5MxINt2EeTGBtKChYB6v2oYdv1tjTLyo/Tyz3SrZaWBPUE70Hvrp7F/GqilnD+BFtzu4=
X-Received: by 2002:aa7:dd4d:: with SMTP id o13mr3227039edw.53.1619167779647;
 Fri, 23 Apr 2021 01:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <CANgtXuP5wVfj7x_ef=oSV6S80zMnAG4JPa_N_W4hNUAE7qmHQA@mail.gmail.com>
 <OSAPR01MB23856FC69ACA82D31DBE9519B74F9@OSAPR01MB2385.jpnprd01.prod.outlook.com>
 <CANgtXuNS0S6G2sdYdxX4272kXfDp63MYXOeLFtSW3+kcrYQ0AQ@mail.gmail.com> <20210422073455.cygkkkglll4fuv24@toshiba.co.jp>
In-Reply-To: <20210422073455.cygkkkglll4fuv24@toshiba.co.jp>
From: "Alice Ferrazzi" <alice.ferrazzi@miraclelinux.com>
Date: Fri, 23 Apr 2021 17:49:03 +0900
Message-ID: <CANgtXuMOrBUXEHN5BBrSOt84JT++G5cpxeBvfhQZD1VCjpfSPA@mail.gmail.com>
Subject: Re: [cip-dev] Kselftest implementation
To: cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="7f8qMEcdYw2E1eAvyznn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619167783;
 bh=tCCTehysJaHg7V69wkl6r/hvMe/MHhKPyHizz/BTbTs=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=wkUySun4PXEZlhWJRA3C19PyNkVaCQ4gIpAYRWWMdwNJZmw0iAGcOKiIpJhZ3uQCrL3
 u3kqvRqaEmqzkDXcj577wSfPsMrZCGSgXygZvzPWQZ+fHhprjNldV+P47FL7ScDq06VC+
 gA4J4bfp0G+lb2G4VdADG0kLoYgp5z082pg=

--7f8qMEcdYw2E1eAvyznn
Content-Type: multipart/alternative; boundary="0000000000005686a905c09fe067"

--0000000000005686a905c09fe067
Content-Type: text/plain; charset="UTF-8"

Hi,

thanks for the review,


On Thu, Apr 22, 2021 at 4:35 PM Nobuhiro Iwamatsu <
nobuhiro1.iwamatsu@toshiba.co.jp> wrote:

> Hi,
>
> Thanks for your work.
>
> On Thu, Apr 15, 2021 at 11:04:26AM +0900, Alice Ferrazzi wrote:
> > Hello Chris,
> >
> > On Wed, Apr 14, 2021 at 7:27 AM Chris Paterson <
> Chris.Paterson2@renesas.com>
> > wrote:
> >
> > > Hello Alice,
> > >
> > > > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
> On
> > > > Behalf Of Alice Ferrazzi via lists.cip-project.org
> > > > Sent: 13 April 2021 18:30
> > > >
> > > > Hi everyone,
> > > >
> > > > I'm Alice Ferrazzi from Cybertrust Japan.
> > > >
> > > > I'm currently working on adding Kselftest to the current CIP CI
> tests of
> > > linux-
> > > > cip Kernel
> > >
> > > Thank you for your work on this!
> > >
> > > >
> > > > I made and tested kselftest on a testing instance of lava, currently
> > > tested
> > > > only on qemu x86_64
> > >
> > > If you'd like to test on a wider range of platforms then get in touch
> and
> > > we'll get you access to the CIP LAVA instance.
> > >
> >
> > This would be nice!
> >
> >
> > > > I implemented a simple skiplist in the kselftest envelope for
> skipping
> > > tests
> > > > that are currently not working.
> > > > The usage is similar to how spectre-meltdown-checker-test is
> currently
> > > > working.
> > > >
> > > > Raw log:
> > > >
> > > > http://140.211.166.173:10080/scheduler/job/329
> > > > Results list:
> > > > http://140.211.166.173:10080/results/329/1_kselftest
> > >
> > > It looks like a great start.
> > >
> > >
> > Thanks
> >
> > >
> > > >
> > > > My idea is to start implementing kselftest tests for at least qemu
> x86_64
> > > > architecture and expand in the future to other architectures.
> > > > As Iwamatsu-san pointed, we need also to create kselftest binary.
> > > >
> > > > I'm currently thinking of implementing kselftest binary creation
> > > mechanism
> > > > on linux-cip-ci kernel build script but I still didn't start to work
> on
> > > this yet.
> > > >
> > > > Kselftest test code:
> > > >
> > > > https://gitlab.com/alice.ferrazzi/cip-kselftest
> > >
> > >
> > Is there any work we can leverage from the Linaro test-definitions repo?
> > >
> > >
> https://github.com/Linaro/test-definitions/tree/master/automated/linux/kselftest
> > >
> > > That was the first thing I tried out but was not working correctly on
> the
> > cip rootfs enviroment
>
> As you write, cip rootfs lacks the software to run kselftest. Therefore,
> it is necessary to make a separate flavor of rootfs.
> There are also two types of cip rootfs, and we need to use either or
> both for kernel testing.
>


ok.



> >
> >
> > > KernelCI also recently implemented kselftest support if that's useful
> at
> > > all, this'll include the build side of things.
> > >
> https://github.com/kernelci/kernelci-core/tree/main/config/lava/kselftest
> > >
> > >
> > I know about KernelCI effort for kselftest and I think to use a similar
> > approach about the kselftest binary creation implementation.
> >
> > The code I wrote is based on Glava-tests that is part of GKernelCI.
> > GKernelCI is the current Gentoo kernel CI system that is reporting and
> > collaborating with KernelCI.
> > https://github.com/GKernelCI/Glava-tests
> > Using a different repository currently is helpful for self managing the
> > skiplist, but it could be changed in the future.
>
>
> I think this needs to be done first.
> I also think there are several approaches to creating kselftest
> binaries.
>
> - Continue to use a particular kernel version of ksefltests.
> - Use CIP kernel kselftest.
> - Use the latest kernel kselftest.
>
> I used to build an environment using the latter.
>
>
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/tree/ci/iwamatsu/linux-cip-kselftest
>
> By the way, do you know which kernelci they are using?
>

KernelCI is using a docker container for building kselftest
https://github.com/kernelci/kernelci-core/blob/26924e6b1a90833bcdf8eb28d038fa2fac19885f/config/docker/gcc-8_x86/Dockerfile

KernelCI is building kselftest in production for at least linux-next and
mainline any time a new revision is discovered on the branches. on
staging.kernelci.org kselftest is built for each job.
This was yesterday staging build with kselftest
https://staging.kernelci.org/build/kernelci/branch/staging-mainline/kernel/staging-mainline-20210422.0/

Currently I'm working on a similar implementation for CIP testing.

Thanks,
Alicef



-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

--0000000000005686a905c09fe067
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"font-size:small" class=3D"gmail_default"></d=
iv><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small">=
Hi,</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><=
/div><div><div style=3D"font-size:small" class=3D"gmail_default">thanks for=
 the review,</div><br></div><div><br></div><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 22, 2021 at 4:35 PM Nobuhiro I=
wamatsu &lt;<a href=3D"mailto:nobuhiro1.iwamatsu@toshiba.co.jp" target=3D"_=
blank">nobuhiro1.iwamatsu@toshiba.co.jp</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
Thanks for your work.<br>
<br>
On Thu, Apr 15, 2021 at 11:04:26AM +0900, Alice Ferrazzi wrote:<br>
&gt; Hello Chris,<br>
&gt; <br>
&gt; On Wed, Apr 14, 2021 at 7:27 AM Chris Paterson &lt;<a href=3D"mailto:C=
hris.Paterson2@renesas.com" target=3D"_blank">Chris.Paterson2@renesas.com</=
a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; Hello Alice,<br>
&gt; &gt;<br>
&gt; &gt; &gt; From: <a href=3D"mailto:cip-dev@lists.cip-project.org" targe=
t=3D"_blank">cip-dev@lists.cip-project.org</a> &lt;<a href=3D"mailto:cip-de=
v@lists.cip-project.org" target=3D"_blank">cip-dev@lists.cip-project.org</a=
>&gt; On<br>
&gt; &gt; &gt; Behalf Of Alice Ferrazzi via <a href=3D"http://lists.cip-pro=
ject.org" rel=3D"noreferrer" target=3D"_blank">lists.cip-project.org</a><br=
>
&gt; &gt; &gt; Sent: 13 April 2021 18:30<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Hi everyone,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I&#39;m Alice Ferrazzi from Cybertrust Japan.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I&#39;m currently working on adding Kselftest to the current=
 CIP CI tests of<br>
&gt; &gt; linux-<br>
&gt; &gt; &gt; cip Kernel<br>
&gt; &gt;<br>
&gt; &gt; Thank you for your work on this!<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I made and tested kselftest on a testing instance of lava, c=
urrently<br>
&gt; &gt; tested<br>
&gt; &gt; &gt; only on qemu x86_64<br>
&gt; &gt;<br>
&gt; &gt; If you&#39;d like to test on a wider range of platforms then get =
in touch and<br>
&gt; &gt; we&#39;ll get you access to the CIP LAVA instance.<br>
&gt; &gt;<br>
&gt; <br>
&gt; This would be nice!<br>
&gt; <br>
&gt; <br>
&gt; &gt; &gt; I implemented a simple skiplist in the kselftest envelope fo=
r skipping<br>
&gt; &gt; tests<br>
&gt; &gt; &gt; that are currently not working.<br>
&gt; &gt; &gt; The usage is similar to how spectre-meltdown-checker-test is=
 currently<br>
&gt; &gt; &gt; working.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Raw log:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; <a href=3D"http://140.211.166.173:10080/scheduler/job/329" r=
el=3D"noreferrer" target=3D"_blank">http://140.211.166.173:10080/scheduler/=
job/329</a><br>
&gt; &gt; &gt; Results list:<br>
&gt; &gt; &gt; <a href=3D"http://140.211.166.173:10080/results/329/1_kselft=
est" rel=3D"noreferrer" target=3D"_blank">http://140.211.166.173:10080/resu=
lts/329/1_kselftest</a><br>
&gt; &gt;<br>
&gt; &gt; It looks like a great start.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; Thanks<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; My idea is to start implementing kselftest tests for at leas=
t qemu x86_64<br>
&gt; &gt; &gt; architecture and expand in the future to other architectures=
.<br>
&gt; &gt; &gt; As Iwamatsu-san pointed, we need also to create kselftest bi=
nary.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I&#39;m currently thinking of implementing kselftest binary =
creation<br>
&gt; &gt; mechanism<br>
&gt; &gt; &gt; on linux-cip-ci kernel build script but I still didn&#39;t s=
tart to work on<br>
&gt; &gt; this yet.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Kselftest test code:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; <a href=3D"https://gitlab.com/alice.ferrazzi/cip-kselftest" =
rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/alice.ferrazzi/cip-=
kselftest</a><br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; Is there any work we can leverage from the Linaro test-definitions rep=
o?<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://github.com/Linaro/test-definitions/tree/master=
/automated/linux/kselftest" rel=3D"noreferrer" target=3D"_blank">https://gi=
thub.com/Linaro/test-definitions/tree/master/automated/linux/kselftest</a><=
br>
&gt; &gt;<br>
&gt; &gt; That was the first thing I tried out but was not working correctl=
y on the<br>
&gt; cip rootfs enviroment<br>
<br>
As you write, cip rootfs lacks the software to run kselftest. Therefore,<br=
>
it is necessary to make a separate flavor of rootfs.<br>
There are also two types of cip rootfs, and we need to use either or<br>
both for kernel testing.<br>
=C2=A0</blockquote><div><br></div><div><div style=3D"font-size:small" class=
=3D"gmail_default">ok.<br></div><br></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
&gt; <br>
&gt; <br>
&gt; &gt; KernelCI also recently implemented kselftest support if that&#39;=
s useful at<br>
&gt; &gt; all, this&#39;ll include the build side of things.<br>
&gt; &gt; <a href=3D"https://github.com/kernelci/kernelci-core/tree/main/co=
nfig/lava/kselftest" rel=3D"noreferrer" target=3D"_blank">https://github.co=
m/kernelci/kernelci-core/tree/main/config/lava/kselftest</a><br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; I know about KernelCI effort for kselftest and I think to use a simila=
r<br>
&gt; approach about the kselftest binary creation implementation.<br>
&gt; <br>
&gt; The code I wrote is based on Glava-tests that is part of GKernelCI.<br=
>
&gt; GKernelCI is the current Gentoo kernel CI system that is reporting and=
<br>
&gt; collaborating with KernelCI.<br>
&gt; <a href=3D"https://github.com/GKernelCI/Glava-tests" rel=3D"noreferrer=
" target=3D"_blank">https://github.com/GKernelCI/Glava-tests</a><br>
&gt; Using a different repository currently is helpful for self managing th=
e<br>
&gt; skiplist, but it could be changed in the future.<br>
<br>
<br>
I think this needs to be done first.<br>
I also think there are several approaches to creating kselftest<br>
binaries.<br>
<br>
- Continue to use a particular kernel version of ksefltests.<br>
- Use CIP kernel kselftest.<br>
- Use the latest kernel kselftest.<br>
<br>
I used to build an environment using the latter.<br>
<br>
<a href=3D"https://gitlab.com/cip-project/cip-kernel/linux-cip/-/tree/ci/iw=
amatsu/linux-cip-kselftest" rel=3D"noreferrer" target=3D"_blank">https://gi=
tlab.com/cip-project/cip-kernel/linux-cip/-/tree/ci/iwamatsu/linux-cip-ksel=
ftest</a><br>
<br>
By the way, do you know which kernelci they are using?<br></blockquote><div=
><br></div><div><div style=3D"font-size:small" class=3D"gmail_default">Kern=
elCI is using a docker container for building kselftest <br><a href=3D"http=
s://github.com/kernelci/kernelci-core/blob/26924e6b1a90833bcdf8eb28d038fa2f=
ac19885f/config/docker/gcc-8_x86/Dockerfile" target=3D"_blank">https://gith=
ub.com/kernelci/kernelci-core/blob/26924e6b1a90833bcdf8eb28d038fa2fac19885f=
/config/docker/gcc-8_x86/Dockerfile</a><br></div><div style=3D"font-size:sm=
all" class=3D"gmail_default"><br></div><div style=3D"font-size:small" class=
=3D"gmail_default">KernelCI is building kselftest in production for at leas=
t linux-next and mainline any time a new revision is discovered on the bran=
ches. on <a href=3D"http://staging.kernelci.org" target=3D"_blank">staging.=
kernelci.org</a> kselftest is built for each job.</div><div style=3D"font-s=
ize:small" class=3D"gmail_default">This was yesterday staging build with ks=
elftest<br><a href=3D"https://staging.kernelci.org/build/kernelci/branch/st=
aging-mainline/kernel/staging-mainline-20210422.0/" target=3D"_blank"> http=
s://staging.kernelci.org/build/kernelci/branch/staging-mainline/kernel/stag=
ing-mainline-20210422.0/</a></div><div style=3D"font-size:small" class=3D"g=
mail_default"><br></div><div style=3D"font-size:small" class=3D"gmail_defau=
lt">Currently I&#39;m working on a similar implementation for CIP testing.<=
/div></div><div><br></div><div><div style=3D"font-size:small" class=3D"gmai=
l_default">Thanks,</div><div style=3D"font-size:small" class=3D"gmail_defau=
lt">Alicef<br></div><br></div></div><br clear=3D"all"><br>-- <br><div dir=
=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr"><div>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br><span>Cybertrust Japan Co.,Ltd.</span><br>Alice Ferra=
zzi<br><a href=3D"mailto:alice.ferrazzi@miraclelinux.com" target=3D"_blank"=
>alice.ferrazzi@miraclelinux.com</a><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br></div></div></div></div></div></div>

--0000000000005686a905c09fe067--

--7f8qMEcdYw2E1eAvyznn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6385): https://lists.cip-project.org/g/cip-dev/message=
/6385
Mute This Topic: https://lists.cip-project.org/mt/82071182/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--7f8qMEcdYw2E1eAvyznn--
