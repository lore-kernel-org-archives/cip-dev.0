Return-Path: <SRS0=uSez=JM=lists.cip-project.org=bounce+64572+6378+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,WEIRD_PORT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5F8C433B4
	for <cip-dev@archiver.kernel.org>; Thu, 15 Apr 2021 02:05:08 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A11E610FA
	for <cip-dev@archiver.kernel.org>; Thu, 15 Apr 2021 02:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A11E610FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6378+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id kri8YY4521723xVEGIdixNRp; Wed, 14 Apr 2021 19:05:06 -0700
X-Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web10.1425.1618452304080495223
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Apr 2021 19:05:06 -0700
X-Received: by mail-ej1-f46.google.com with SMTP id r12so34397261ejr.5
        for <cip-dev@lists.cip-project.org>; Wed, 14 Apr 2021 19:05:03 -0700 (PDT)
X-Gm-Message-State: mOzwrdJ76GtGAuMJIbF6TId5x4520388AA=
X-Google-Smtp-Source: ABdhPJxVSiZse0qcDgiWxmrxCjssKd+Ek9K5TjqLzuB56Hu5LuOiTi7SNCRgZkH4AH0BrKWwONHELp5XLdS3eOQ8xwY=
X-Received: by 2002:a17:906:88b:: with SMTP id n11mr978988eje.26.1618452302577;
 Wed, 14 Apr 2021 19:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <CANgtXuP5wVfj7x_ef=oSV6S80zMnAG4JPa_N_W4hNUAE7qmHQA@mail.gmail.com>
 <OSAPR01MB23856FC69ACA82D31DBE9519B74F9@OSAPR01MB2385.jpnprd01.prod.outlook.com>
In-Reply-To: <OSAPR01MB23856FC69ACA82D31DBE9519B74F9@OSAPR01MB2385.jpnprd01.prod.outlook.com>
From: "Alice Ferrazzi" <alice.ferrazzi@miraclelinux.com>
Date: Thu, 15 Apr 2021 11:04:26 +0900
Message-ID: <CANgtXuNS0S6G2sdYdxX4272kXfDp63MYXOeLFtSW3+kcrYQ0AQ@mail.gmail.com>
Subject: Re: [cip-dev] Kselftest implementation
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="zJAVsa7gUncsAnJeJLRH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1618452306;
 bh=CZHUnKVCNAIUkFYbReRcTzh1quBO0qgzRu2AH09P2EQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Zxq5/c2ZhGZW9l+gM5rLvWfODvpbXxWTbfLQcKdIpbfol4Ft6keigZGNmxE1AIThS68
 mdrFlG4n//5TM53plSNmfdJM34lpUUa1mkg7MzT0fAv6or6eGoDksvP1kTpl+Nc2EbAJk
 8i81PJowSoBOqCilKXBC7Q4LqPThrMFWtoI=

--zJAVsa7gUncsAnJeJLRH
Content-Type: multipart/alternative; boundary="00000000000094d77805bff94adc"

--00000000000094d77805bff94adc
Content-Type: text/plain; charset="UTF-8"

Hello Chris,

On Wed, Apr 14, 2021 at 7:27 AM Chris Paterson <Chris.Paterson2@renesas.com>
wrote:

> Hello Alice,
>
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Alice Ferrazzi via lists.cip-project.org
> > Sent: 13 April 2021 18:30
> >
> > Hi everyone,
> >
> > I'm Alice Ferrazzi from Cybertrust Japan.
> >
> > I'm currently working on adding Kselftest to the current CIP CI tests of
> linux-
> > cip Kernel
>
> Thank you for your work on this!
>
> >
> > I made and tested kselftest on a testing instance of lava, currently
> tested
> > only on qemu x86_64
>
> If you'd like to test on a wider range of platforms then get in touch and
> we'll get you access to the CIP LAVA instance.
>

This would be nice!


> > I implemented a simple skiplist in the kselftest envelope for skipping
> tests
> > that are currently not working.
> > The usage is similar to how spectre-meltdown-checker-test is currently
> > working.
> >
> > Raw log:
> >
> > http://140.211.166.173:10080/scheduler/job/329
> > Results list:
> > http://140.211.166.173:10080/results/329/1_kselftest
>
> It looks like a great start.
>
>
Thanks

>
> >
> > My idea is to start implementing kselftest tests for at least qemu x86_64
> > architecture and expand in the future to other architectures.
> > As Iwamatsu-san pointed, we need also to create kselftest binary.
> >
> > I'm currently thinking of implementing kselftest binary creation
> mechanism
> > on linux-cip-ci kernel build script but I still didn't start to work on
> this yet.
> >
> > Kselftest test code:
> >
> > https://gitlab.com/alice.ferrazzi/cip-kselftest
>
>
Is there any work we can leverage from the Linaro test-definitions repo?
>
> https://github.com/Linaro/test-definitions/tree/master/automated/linux/kselftest
>
> That was the first thing I tried out but was not working correctly on the
cip rootfs enviroment


> KernelCI also recently implemented kselftest support if that's useful at
> all, this'll include the build side of things.
> https://github.com/kernelci/kernelci-core/tree/main/config/lava/kselftest
>
>
I know about KernelCI effort for kselftest and I think to use a similar
approach about the kselftest binary creation implementation.

The code I wrote is based on Glava-tests that is part of GKernelCI.
GKernelCI is the current Gentoo kernel CI system that is reporting and
collaborating with KernelCI.
https://github.com/GKernelCI/Glava-tests
Using a different repository currently is helpful for self managing the
skiplist, but it could be changed in the future.

>
> >
> > linux-cip Kernel Kselftest implementation (currently in draft):
> > https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/merge_requests
>
> Please assign the MR to me when you're ready for it to be reviewed, or if
> you need any help.
>
> Also let me know if you want write access to the linux-cip-ci repo.
> If you push your branch to our repo directly the CI will be able to run,
> making it easier for you to test.
>

Testing the kselftest branch directly on CIP CI test environment from
linux-cip-ci
repo would be really helpful.

Thanks,
Alicef


-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

--00000000000094d77805bff94adc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><div style=3D"font-size:small" class=3D"gmail=
_default">Hello Chris,</div><br><div class=3D"gmail_quote"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Wed, Apr 14, 2021 at 7:27 AM Chris Paterson &lt;<a=
 href=3D"mailto:Chris.Paterson2@renesas.com">Chris.Paterson2@renesas.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hel=
lo Alice,<br>
<br>
&gt; From: <a href=3D"mailto:cip-dev@lists.cip-project.org" target=3D"_blan=
k">cip-dev@lists.cip-project.org</a> &lt;<a href=3D"mailto:cip-dev@lists.ci=
p-project.org" target=3D"_blank">cip-dev@lists.cip-project.org</a>&gt; On<b=
r>
&gt; Behalf Of Alice Ferrazzi via <a href=3D"http://lists.cip-project.org" =
rel=3D"noreferrer" target=3D"_blank">lists.cip-project.org</a><br>
&gt; Sent: 13 April 2021 18:30<br>
&gt; <br>
&gt; Hi everyone,<br>
&gt; <br>
&gt; I&#39;m Alice Ferrazzi from Cybertrust Japan.<br>
&gt; <br>
&gt; I&#39;m currently working on adding Kselftest to the current CIP CI te=
sts of linux-<br>
&gt; cip Kernel<br>
<br>
Thank you for your work on this!<br>
<br>
&gt; <br>
&gt; I made and tested kselftest on a testing instance of lava, currently t=
ested<br>
&gt; only on qemu x86_64<br>
<br>
If you&#39;d like to test on a wider range of platforms then get in touch a=
nd we&#39;ll get you access to the CIP LAVA instance.<br></blockquote><div>=
<br></div><div><div style=3D"font-size:small" class=3D"gmail_default">This =
would be nice!</div><br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
&gt; I implemented a simple skiplist in the kselftest envelope for skipping=
 tests<br>
&gt; that are currently not working.<br>
&gt; The usage is similar to how spectre-meltdown-checker-test is currently=
<br>
&gt; working.<br>
&gt; <br>
&gt; Raw log:<br>
&gt; <br>
&gt; <a href=3D"http://140.211.166.173:10080/scheduler/job/329" rel=3D"nore=
ferrer" target=3D"_blank">http://140.211.166.173:10080/scheduler/job/329</a=
><br>
&gt; Results list:<br>
&gt; <a href=3D"http://140.211.166.173:10080/results/329/1_kselftest" rel=
=3D"noreferrer" target=3D"_blank">http://140.211.166.173:10080/results/329/=
1_kselftest</a><br>
<br>
It looks like a great start.<br>
<br></blockquote><div><br></div><div><div style=3D"font-size:small" class=
=3D"gmail_default">Thanks</div><br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
&gt;<br>
&gt; <br>
&gt; My idea is to start implementing kselftest tests for at least qemu x86=
_64<br>
&gt; architecture and expand in the future to other architectures.<br>
&gt; As Iwamatsu-san pointed, we need also to create kselftest binary.<br>
&gt; <br>
&gt; I&#39;m currently thinking of implementing kselftest binary creation m=
echanism<br>
&gt; on linux-cip-ci kernel build script but I still didn&#39;t start to wo=
rk on this yet.<br>
&gt; <br>
&gt; Kselftest test code:<br>
&gt; <br>
&gt; <a href=3D"https://gitlab.com/alice.ferrazzi/cip-kselftest" rel=3D"nor=
eferrer" target=3D"_blank">https://gitlab.com/alice.ferrazzi/cip-kselftest<=
/a><br>=C2=A0 <br></blockquote><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
Is there any work we can leverage from the Linaro test-definitions repo?<br=
>
<a href=3D"https://github.com/Linaro/test-definitions/tree/master/automated=
/linux/kselftest" rel=3D"noreferrer" target=3D"_blank">https://github.com/L=
inaro/test-definitions/tree/master/automated/linux/kselftest</a><br>
<br></blockquote><div><div style=3D"font-size:small" class=3D"gmail_default=
"></div><div style=3D"font-size:small" class=3D"gmail_default">That was the=
 first thing I tried out but was not working correctly on the cip rootfs en=
viroment</div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
KernelCI also recently implemented kselftest support if that&#39;s useful a=
t all, this&#39;ll include the build side of things.<br>
<a href=3D"https://github.com/kernelci/kernelci-core/tree/main/config/lava/=
kselftest" rel=3D"noreferrer" target=3D"_blank">https://github.com/kernelci=
/kernelci-core/tree/main/config/lava/kselftest</a><br>
<br></blockquote><div><br></div><div><div style=3D"font-size:small" class=
=3D"gmail_default">I know about KernelCI effort for kselftest and I think t=
o use a similar approach about the kselftest binary creation implementation=
.</div><div style=3D"font-size:small" class=3D"gmail_default"><br></div><di=
v style=3D"font-size:small" class=3D"gmail_default">The code I wrote is bas=
ed on Glava-tests that is part of GKernelCI.<br>GKernelCI is the current Ge=
ntoo kernel CI system that is reporting and collaborating with KernelCI.</d=
iv><div style=3D"font-size:small" class=3D"gmail_default"><a href=3D"https:=
//github.com/GKernelCI/Glava-tests">https://github.com/GKernelCI/Glava-test=
s</a></div><div style=3D"font-size:small" class=3D"gmail_default">Using a d=
ifferent repository currently is helpful for self managing the skiplist, bu=
t it could be changed in the future.</div><div style=3D"font-size:small" cl=
ass=3D"gmail_default"><br></div></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
&gt;<br>
&gt; <br>
&gt; linux-cip Kernel Kselftest implementation (currently in draft):<br>
&gt; <a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/m=
erge_requests" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/cip-=
project/cip-testing/linux-cip-ci/-/merge_requests</a><br>
<br>
Please assign the MR to me when you&#39;re ready for it to be reviewed, or =
if you need any help.<br>
<br>
Also let me know if you want write access to the <span class=3D"gmail_defau=
lt" style=3D"font-size:small"></span>linux-cip-ci repo.<br>
If you push your branch to our repo directly the CI will be able to run, ma=
king it easier for you to test.<br>
</blockquote><div><span class=3D"gmail_default" style=3D"font-size:small"><=
br></span></div><div><span class=3D"gmail_default" style=3D"font-size:small=
">Testing the kselftest branch directly on CIP CI test environment from <sp=
an class=3D"gmail_default" style=3D"font-size:small"></span>linux-cip-ci re=
po would be really helpful.</span><span class=3D"gmail_default" style=3D"fo=
nt-size:small"><br></span></div></div><div><br></div><div><div style=3D"fon=
t-size:small" class=3D"gmail_default">Thanks,</div><div style=3D"font-size:=
small" class=3D"gmail_default">Alicef</div><br></div><div><br></div>-- <br>=
<div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=
=3D"ltr"><div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><span>Cybertrust =
Japan Co.,Ltd.</span><br>Alice Ferrazzi<br><a href=3D"mailto:alice.ferrazzi=
@miraclelinux.com" target=3D"_blank">alice.ferrazzi@miraclelinux.com</a><br=
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br></div></div></div></div></div=
></div>

--00000000000094d77805bff94adc--

--zJAVsa7gUncsAnJeJLRH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6378): https://lists.cip-project.org/g/cip-dev/message=
/6378
Mute This Topic: https://lists.cip-project.org/mt/82071182/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zJAVsa7gUncsAnJeJLRH--
