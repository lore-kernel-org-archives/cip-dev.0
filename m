Return-Path: <SRS0=sHwY=M6=lists.cip-project.org=bounce+64572+6659+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F33C4338F
	for <cip-dev@archiver.kernel.org>; Sat,  7 Aug 2021 23:12:10 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B470361050
	for <cip-dev@archiver.kernel.org>; Sat,  7 Aug 2021 23:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B470361050
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id hyyrYY4521723xV9qvnplaoJ; Sat, 07 Aug 2021 16:12:09 -0700
X-Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
 by mx.groups.io with SMTP id smtpd.web11.3679.1628316682981826505
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Aug 2021 23:11:23 -0700
X-Received: by mail-ed1-f48.google.com with SMTP id b7so16294609edu.3;
        Fri, 06 Aug 2021 23:11:22 -0700 (PDT)
X-Gm-Message-State: FavUaIRBXnIZg3MY7t4Wx8Awx4520388AA=
X-Google-Smtp-Source: ABdhPJwX6eWuqCKhFjxGMBBBDtHXSzkAYK2WPz4C4SDI2JuNxyq8FPVl84PESSOAqYYFEfISYT1f81lNVr08k2GDrlE=
X-Received: by 2002:aa7:d285:: with SMTP id w5mr16843577edq.132.1628316681151;
 Fri, 06 Aug 2021 23:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <74f7b4cf-926f-d8bd-19c2-375cfe7a12b2@collabora.com> <OSZPR01MB6877A873F8EEFA24CC8D7331B7EF9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB6877A873F8EEFA24CC8D7331B7EF9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
From: Nobuhiro Iwamatsu <iwamatsu@gmail.com>
Date: Sat, 7 Aug 2021 15:11:09 +0900
Message-ID: <CACe6DC5p_Fwdar-cvGWi2xUaEC2wBK6JD575Rj8h8zPQ=tLGqA@mail.gmail.com>
Subject: Re: [cip-dev] [cip-members] FW: [kernelci-members] KernelCI Hackfest #2 - Sept 6-10 2021
To: cip-members@lists.cip-project.org
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, 
	"alice.ferrazzi@miraclelinux.com" <alice.ferrazzi@miraclelinux.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="6XBnyach9bzXIGVSZRO4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628377929;
 bh=wseHlB+vmaokKI8Zs9HUzbuVxFPKrP5Gzannu6DH8Cw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=EC/TdMJALFP3uIv2pHWEMRBIq7O342fSxFxxuhfipyDjg2rvvwaSS2uFQTs1agYYF8g
 f/kc/yYyn8msdGLuC8rVPxCOh+1oZvov36SjiRdtKCM6wk2be0U9yj/lD4i9JkhmX12Si
 W40d3E5jij0kaflMQTCK3kFvDjXW6a5VMzE=

--6XBnyach9bzXIGVSZRO4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

I am interested in this.
Do you still accept this?

Best regards,
  Nobuhiro

2021=E5=B9=B48=E6=9C=883=E6=97=A5(=E7=81=AB) 5:59 Chris Paterson <chris.pat=
erson2@renesas.com>:
>
> Hello all,
>
> The KernelCI project has announced it's second hackfest in September.
> The first one was pretty successful in getting some new features added to=
 KernelCI, and the hope is the same will happen next time as well.
>
> One hope from Alice and I is that we can get some CIP members involved to=
 try and advance KernelCI + CIP integration/collaboration.
> If you have any time available during the hackfest and would like to get =
involved, please let me and/or Guillaume know.
>
> Kind regards, Chris
>
>
> -----Original Message-----
> From: kernelci-members@groups.io <kernelci-members@groups.io> On Behalf O=
f Guillaume Tucker via groups.io
> Sent: 02 August 2021 10:00
> To: kernelci@groups.io
> Cc: kernelci-members <kernelci-members@groups.io>; automated-testing@list=
s.yoctoproject.org; Collabora Kernel ML <kernel@collabora.com>; linux-kerne=
l@vger.kernel.org; Jesse Barnes <jsbarnes@google.com>; Summer Wang <wangsum=
mer@google.com>; linux-kselftest@vger.kernel.org; workflows@vger.kernel.org=
; kunit-dev@googlegroups.com; clang-built-linux <clang-built-linux@googlegr=
oups.com>
> Subject: [kernelci-members] KernelCI Hackfest #2 - Sept 6-10 2021
>
> The first KernelCI hackfest[1] early June was successful in getting
> a number of kernel developers to work alongside the core KernelCI
> team.  Test coverage was increased in particular with kselftest,
> LTP, KUnit and a new test suite for libcamera.  We're now improving
> documentation and tooling to make it easier for anyone to get
> started.  Find out more about KernelCI on https://kernelci.org/.
>
> The second hackfest is scheduled for the 6th-10th September.  It
> should be a good opportunity to start discussing and working on
> upstream kernel testing topics ahead of the Linux Plumbers
> Conference[2].
>
> Here's the project board where anyone can already add some ideas:
>
> https://github.com/orgs/kernelci/projects/5
>
> There is no registration system, but please reply to this email or
> send a message on IRC (#kernelci libera.chat) or kernelci.slack.com
> if you would like to take part so you'll get email updates and
> invitations to the meetings and open hours sessions online.  You
> may just drop in and out at any point during the hackfest as you
> see fit.
>
> The hackfest features:
>
> * Daily open hours online using Big Blue Button to discuss things
>   and get support from the KernelCI team
>
> * KernelCI team members available across most time zones to provide
>   quick feedback
>
> * A curated list of topics and a project board to help set
>   objectives and coordinate efforts between all contributors
>
>
> As always, KernelCI is at the service of the kernel community so
> please share any feedback you may have to help shape this upcoming
> hackfest in the best possible way.
>
> Thanks,
> Guillaume
>
>
> [1] https://foundation.kernelci.org/blog/2021/06/24/the-first-ever-kernel=
ci-hackfest/
> [2] https://www.linuxplumbersconf.org/event/11/page/104-accepted-microcon=
ferences#cont-test
>
>
>
>=20
>
>


--=20
Nobuhiro Iwamatsu

--6XBnyach9bzXIGVSZRO4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6659): https://lists.cip-project.org/g/cip-dev/message/=
6659
Mute This Topic: https://lists.cip-project.org/mt/84738331/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6XBnyach9bzXIGVSZRO4--
