Return-Path: <SRS0=qea0=JT=lists.cip-project.org=bounce+64572+6383+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,
	SPF_PASS,WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C286C433ED
	for <cip-dev@archiver.kernel.org>; Thu, 22 Apr 2021 07:35:05 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC2366145E
	for <cip-dev@archiver.kernel.org>; Thu, 22 Apr 2021 07:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2366145E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6383+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5uIeYY4521723xIN2EmeYwjV; Thu, 22 Apr 2021 00:35:04 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web09.8987.1619076901822043306
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Apr 2021 00:35:03 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 13M7YvQC022860; Thu, 22 Apr 2021 16:34:58 +0900
X-Iguazu-Qid: 34trMIny0ENeZJFjhO
X-Iguazu-QSIG: v=2; s=0; t=1619076897; q=34trMIny0ENeZJFjhO; m=XQNw4ZYCnFMFByA3ys3cwTrh8zq8QgY7SJXrTwlfNXQ=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1513) id 13M7YuWs020172
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 22 Apr 2021 16:34:57 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id B0BE91000EF;
	Thu, 22 Apr 2021 16:34:56 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 13M7YuuM024457;
	Thu, 22 Apr 2021 16:34:56 +0900
Date: Thu, 22 Apr 2021 16:34:55 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [cip-dev] Kselftest implementation
X-TSB-HOP: ON
Message-ID: <20210422073455.cygkkkglll4fuv24@toshiba.co.jp>
References: <CANgtXuP5wVfj7x_ef=oSV6S80zMnAG4JPa_N_W4hNUAE7qmHQA@mail.gmail.com>
 <OSAPR01MB23856FC69ACA82D31DBE9519B74F9@OSAPR01MB2385.jpnprd01.prod.outlook.com>
 <CANgtXuNS0S6G2sdYdxX4272kXfDp63MYXOeLFtSW3+kcrYQ0AQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANgtXuNS0S6G2sdYdxX4272kXfDp63MYXOeLFtSW3+kcrYQ0AQ@mail.gmail.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uBkAtpp4Vh3hpfmw7CF9DlTGx4520388AA=
Content-Type: multipart/mixed; boundary="NuyqiWJa2HoQ4jrq5FLb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619076904;
 bh=XMsjryPHbfcxLAHDoHQYK3k0J0MqCLHFsWzxLaNzdhI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=wQkBGwuUL+FqLECtyYWKA1tgubI2yfGLgJSbGRsO5dI5CjTBZgzjqXCIU18j9u8eQo6
 uJCnYws5+k5HIlY+l6wfXEvipnYinWtxiaeFASaaoaRDJTen2rwlIqJsitg/tdhdk3NfK
 b1IfJctf8CUZj/cy8AyZR67F6P3rl+s57KY=

--NuyqiWJa2HoQ4jrq5FLb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Thanks for your work.

On Thu, Apr 15, 2021 at 11:04:26AM +0900, Alice Ferrazzi wrote:
> Hello Chris,
> 
> On Wed, Apr 14, 2021 at 7:27 AM Chris Paterson <Chris.Paterson2@renesas.com>
> wrote:
> 
> > Hello Alice,
> >
> > > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > > Behalf Of Alice Ferrazzi via lists.cip-project.org
> > > Sent: 13 April 2021 18:30
> > >
> > > Hi everyone,
> > >
> > > I'm Alice Ferrazzi from Cybertrust Japan.
> > >
> > > I'm currently working on adding Kselftest to the current CIP CI tests of
> > linux-
> > > cip Kernel
> >
> > Thank you for your work on this!
> >
> > >
> > > I made and tested kselftest on a testing instance of lava, currently
> > tested
> > > only on qemu x86_64
> >
> > If you'd like to test on a wider range of platforms then get in touch and
> > we'll get you access to the CIP LAVA instance.
> >
> 
> This would be nice!
> 
> 
> > > I implemented a simple skiplist in the kselftest envelope for skipping
> > tests
> > > that are currently not working.
> > > The usage is similar to how spectre-meltdown-checker-test is currently
> > > working.
> > >
> > > Raw log:
> > >
> > > http://140.211.166.173:10080/scheduler/job/329
> > > Results list:
> > > http://140.211.166.173:10080/results/329/1_kselftest
> >
> > It looks like a great start.
> >
> >
> Thanks
> 
> >
> > >
> > > My idea is to start implementing kselftest tests for at least qemu x86_64
> > > architecture and expand in the future to other architectures.
> > > As Iwamatsu-san pointed, we need also to create kselftest binary.
> > >
> > > I'm currently thinking of implementing kselftest binary creation
> > mechanism
> > > on linux-cip-ci kernel build script but I still didn't start to work on
> > this yet.
> > >
> > > Kselftest test code:
> > >
> > > https://gitlab.com/alice.ferrazzi/cip-kselftest
> >
> >
> Is there any work we can leverage from the Linaro test-definitions repo?
> >
> > https://github.com/Linaro/test-definitions/tree/master/automated/linux/kselftest
> >
> > That was the first thing I tried out but was not working correctly on the
> cip rootfs enviroment

As you write, cip rootfs lacks the software to run kselftest. Therefore,
it is necessary to make a separate flavor of rootfs.
There are also two types of cip rootfs, and we need to use either or
both for kernel testing.

> 
> 
> > KernelCI also recently implemented kselftest support if that's useful at
> > all, this'll include the build side of things.
> > https://github.com/kernelci/kernelci-core/tree/main/config/lava/kselftest
> >
> >
> I know about KernelCI effort for kselftest and I think to use a similar
> approach about the kselftest binary creation implementation.
> 
> The code I wrote is based on Glava-tests that is part of GKernelCI.
> GKernelCI is the current Gentoo kernel CI system that is reporting and
> collaborating with KernelCI.
> https://github.com/GKernelCI/Glava-tests
> Using a different repository currently is helpful for self managing the
> skiplist, but it could be changed in the future.


I think this needs to be done first.
I also think there are several approaches to creating kselftest
binaries.

- Continue to use a particular kernel version of ksefltests.
- Use CIP kernel kselftest.
- Use the latest kernel kselftest.

I used to build an environment using the latter.

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/tree/ci/iwamatsu/linux-cip-kselftest

By the way, do you know which kernelci they are using?

> 
> >
> > >
> > > linux-cip Kernel Kselftest implementation (currently in draft):
> > > https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/merge_requests
> >
> > Please assign the MR to me when you're ready for it to be reviewed, or if
> > you need any help.
> >
> > Also let me know if you want write access to the linux-cip-ci repo.
> > If you push your branch to our repo directly the CI will be able to run,
> > making it easier for you to test.
> >
> 
> Testing the kselftest branch directly on CIP CI test environment from
> linux-cip-ci
> repo would be really helpful.
> 
> Thanks,
> Alicef


Best regards,
  Nobuhiro

--NuyqiWJa2HoQ4jrq5FLb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6383): https://lists.cip-project.org/g/cip-dev/message=
/6383
Mute This Topic: https://lists.cip-project.org/mt/82071182/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--NuyqiWJa2HoQ4jrq5FLb--
