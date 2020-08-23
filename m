Return-Path: <SRS0=UEAh=CB=lists.cip-project.org=bounce+64572+5231+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D993C433DF
	for <cip-dev@archiver.kernel.org>; Sun, 23 Aug 2020 19:37:48 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC278207BB
	for <cip-dev@archiver.kernel.org>; Sun, 23 Aug 2020 19:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Vf+yunMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC278207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5231+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id CSVdYY4521723x3lXwskvMNi; Sun, 23 Aug 2020 12:37:47 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.180152.1598211466861921312
 for <cip-dev@lists.cip-project.org>;
 Sun, 23 Aug 2020 12:37:47 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 477621C0BB7; Sun, 23 Aug 2020 21:37:44 +0200 (CEST)
Date: Sun, 23 Aug 2020 21:37:43 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/12] Support RZ/G2[MN] rev4 board
Message-ID: <20200823193743.GE25365@duo.ucw.cz>
References: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
 <20200819173857.GA5567@amd>
 <OSAPR01MB238513FFAB73D179C17BDE5CB75A0@OSAPR01MB2385.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSAPR01MB238513FFAB73D179C17BDE5CB75A0@OSAPR01MB2385.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: rCwNObncN7aKtLDG1HWnAYJjx4520388AA=
Content-Type: multipart/mixed; boundary="DpGJiO6rz46MR9tjFSlh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598211467;
 bh=r6i73qImlkh4O+9yXz26KOXAL7u8J4LSQraoP8kxuGI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Vf+yunMCnMTgfnWuo2UhWfor0X5jwICWhc3aEqUAUHlL+Sg5GX6HY7yZSCERY3NvbzY
 ENf/xwk+J4ZsM7ICSXwddHiBVQSc4/TGkXMTy2sdxbd2zLS62bcp0Qk25KEGhHcjHPhFr
 QSWbpFIcjGkMkg1xN4Nhvv5y68iEBlXUGxU=

--DpGJiO6rz46MR9tjFSlh
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Content-Disposition: inline

--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > *** gpg4o | The signature of this email could not be verified because t=
he
> > following public key is missing. Click here to search and import the key
> > 30E7F06A95DBFAF2 ***
> >
> > Hi!
> >
> > > This patch series for supporting RZ/G2[MN] rev4 board to cip-4.19.y
> > > kernel.
> >
> > >=A0 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 11 -----------
> > >=A0 1 file changed, 11 deletions(-)
> >
> > I'm pretty sure this is not the real diffstat.
> >
> > Let me go through the changes. One concern: you are renaming dts
> > files. New names make a lot of sense, but that will likely break the
> > users, including our test infrastructure, no?

>  Technically yes, it would cause problems. However this seems to be
> the way of doing things upstream.  I guess upstream is a bit
> different though as users would expect such things when upgrading
> Kernel versions.

Yes, it is upstream problem, and should be fixed upstream.

And no, not even upgrading kernel versions should break anything.

> lab-cip-renesas uses rev4 boards, so from a CIP testing point of
>  view there will be no issues.

Ok, good to know, it seems -rev2 boards are kind of rare?

I guess we could create "README.cip" explaining such non-standard
issues, and mention it in release changelog.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX0LFhwAKCRAw5/Bqldv6
8sSlAJ9MhOMUXhBbQkl4gaUKryEXSr5vGACgryGsnC5kE0h1NB8sqQtrbbB7wlU=
=LBnx
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--

--DpGJiO6rz46MR9tjFSlh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5231): https://lists.cip-project.org/g/cip-dev/message=
/5231
Mute This Topic: https://lists.cip-project.org/mt/76290780/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--DpGJiO6rz46MR9tjFSlh--
