Return-Path: <SRS0=NmTo=NE=lists.cip-project.org=bounce+64572+6678+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E078FC4338F
	for <cip-dev@archiver.kernel.org>; Fri, 13 Aug 2021 19:46:44 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13CE610EA
	for <cip-dev@archiver.kernel.org>; Fri, 13 Aug 2021 19:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F13CE610EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PbRDYY4521723xw8incs6tKj; Fri, 13 Aug 2021 12:46:43 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.41490.1628884000943768063
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Aug 2021 12:46:42 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 136181C0B76; Fri, 13 Aug 2021 21:46:36 +0200 (CEST)
Date: Fri, 13 Aug 2021 21:46:35 +0200
From: "Pavel Machek" <pavel@denx.de>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] -stable-rc tests failing
Message-ID: <20210813194635.GB23237@duo.ucw.cz>
References: <20210811063943.GA23723@duo.ucw.cz>
 <OSZPR01MB68775BA605A2B969F3B22612B7F89@OSZPR01MB6877.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSZPR01MB68775BA605A2B969F3B22612B7F89@OSZPR01MB6877.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: H9GcNtCNI6pyECzfBgyuX7d0x4520388AA=
Content-Type: multipart/mixed; boundary="lu588PrNAB1BiMWsMY3V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628884003;
 bh=OIURXguuv3YcHIxFiLidv8L/zmXeVCMjHAWmUbprCAU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=E79Vob8laaDOjlqlloZtIAX6PPWO4QXh5mi4eoO7EyUEp0JO79eLyKmi1QQH8tI2Sz9
 dvumcisbwzgpeC/J5SJIeEwtMin50xbKof5ObAofl645zwzgtRBabnysENkDthWdYFM7z
 UokxWNUdXOUrfLo7xKDJ2TgOwf8OxBeIWhs=

--lu588PrNAB1BiMWsMY3V
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline

--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > WARNING: Retrying...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error=3Dinvalid argument
> > 2170ERROR: Downloading artifacts from coordinator... error couldn't exe=
cute
> > GET against https://gitlab.com/api/v4/jobs/1492901612/artifacts?: Get
> > https://gitlab.com/api/v4/jobs/1492901612/artifacts?: dial tcp: i/o tim=
eout
> > id=3D1492901612 token=3D9gNGsuaZ
> > 2171FATAL: invalid argument
> > 2173
> > Uploading artifacts for failed job
> >
> > But I don't usually see this one:
> >
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> > /jobs/1492901660
> >
> > Job #371616: Submitted
> > 219Health: Unknown
> > 220Device Type: r8a7743-iwg20d-q7
> > 221Device: None
> > 222Test: boot
> > 223URL: https://lava.ciplatform.org/scheduler/job/371616
> > 224
> > 226ERROR: Job failed: execution took longer than 2h0m0s seconds
>=20
> It looks like the LAVA server has stopped processing jobs. Our queue has =
become very large!
> I'll have to see what died and no doubt reboot it and the labs.
>=20
> Sorry for the pain.

Thank you, it seems to be better now, and it looks like ctj_zynqmp is
available, too (I have not yet seen successful test, but it at least
tries).

But I still see problems with x86_qemu... the "2h timeout".

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYRbMGwAKCRAw5/Bqldv6
8hqBAKCtI8Tz+xwhbY8Zy7TwJFb1jZEHuQCgjdEBEFv+DDqF7d57rvvuN0k2vgo=
=lrbE
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--

--lu588PrNAB1BiMWsMY3V
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6678): https://lists.cip-project.org/g/cip-dev/message/=
6678
Mute This Topic: https://lists.cip-project.org/mt/84811238/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--lu588PrNAB1BiMWsMY3V--
