Return-Path: <SRS0=YOPX=GH=lists.cip-project.org=bounce+64572+5992+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A5DC433DB
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 12:15:24 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A21221E5
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 12:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A21221E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5992+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cqfWYY4521723xK1hU4P5XrR; Mon, 04 Jan 2021 04:15:22 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.12629.1609762521095407835
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Jan 2021 04:15:21 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id ED8051C0B87; Mon,  4 Jan 2021 13:15:16 +0100 (CET)
Date: Mon, 4 Jan 2021 13:15:16 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>
Subject: Re: Starting testing of 5.10-stable? was Re: [cip-dev] Testing of -stable-rc fails completely
Message-ID: <20210104121516.GA11126@duo.ucw.cz>
References: <20201229085357.GA17217@amd>
 <OSAPR01MB23857C22D82B59C59F0AD25BB7D80@OSAPR01MB2385.jpnprd01.prod.outlook.com>
 <20201230124530.GA13161@duo.ucw.cz>
 <OSAPR01MB2385B98A7415E26F2FECE904B7D20@OSAPR01MB2385.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSAPR01MB2385B98A7415E26F2FECE904B7D20@OSAPR01MB2385.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PRCw3kveLpm9EMa9540C3jIBx4520388AA=
Content-Type: multipart/mixed; boundary="SZKSl5v1vb08x0coockB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609762522;
 bh=PZZVIh8c03Tutl9FxVlLLzzPJjuCI4EcJ/j7nhr69dg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=PSrQD4pyUDyjmgZ25MkMEWSHIox4eIs09QNniuTE3EIINJI4OQsdbjv9HtI5fLZSXpT
 116Qwm6FWSTyXMW/3NRVaP6Qf7a2zjqr2ja1+OOpssLtkz3sWBpRvgNlwg/ksvf7lSaIn
 Rzzlj2z2XYGuvm9rYDBPdFsKgmJi8vlmg9A=

--SZKSl5v1vb08x0coockB
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Pavel Machek via lists.cip-project.org
> > Sent: 30 December 2020 12:46
> >
>=20
> [...]
>=20
> >
> > Now... I believe we should start testing 5.10-stable trees, as we want
> > to maintain that tree "soon" it would be good to know how we are
> > doing...
> >
> > I guess it will need some configs.
>=20
> I can use some generic defconfigs to start if you like.
> But yes, ideally we need CIP configs added to cip-kernel-config.
> Perhaps an email needs to go to cip-members for this?

Starting some testing would be good; defconfigs would work. We'll need
to notify cip-members, but I assume actual replies from members will
need some time.=20

> > I believe we could just take 4.19 configs for a start.
> That's one option, assuming that all relevant platforms are supported in =
v5.10.

They should be, thanks to our upstream-first policy.

If it helps, I believe we can create symlinks in cip-kernel-config
repository for now, so you could point testing at 5.10.y
configurations, and we would have opportunity to replace configs with
final ones as they become available.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX/MG1AAKCRAw5/Bqldv6
8lFAAJ9y2/8zz+IqKS1on1YzzP9HwTT/LQCdEHAlDESfjy1Y5lOAoCf+JGnrYpU=
=1m/5
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

--SZKSl5v1vb08x0coockB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5992): https://lists.cip-project.org/g/cip-dev/message=
/5992
Mute This Topic: https://lists.cip-project.org/mt/79311303/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--SZKSl5v1vb08x0coockB--
