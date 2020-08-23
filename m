Return-Path: <SRS0=UJZq=CB=lists.cip-project.org=bounce+64572+5230+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A4BC433E1
	for <cip-dev@archiver.kernel.org>; Sun, 23 Aug 2020 19:35:07 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9A520768
	for <cip-dev@archiver.kernel.org>; Sun, 23 Aug 2020 19:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PQmbFxFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9A520768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5230+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NdVjYY4521723xOln9lZMPEV; Sun, 23 Aug 2020 12:35:07 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.180673.1598211305730080727
 for <cip-dev@lists.cip-project.org>;
 Sun, 23 Aug 2020 12:35:06 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A65ED1C0BBF; Sun, 23 Aug 2020 21:35:02 +0200 (CEST)
Date: Sun, 23 Aug 2020 21:35:02 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 01/12] arm64: dts: renesas: r8a774a1-hihope-rzg2m[-ex/-ex-idk-1110wr]: Rename HiHope RZ/G2M boards
Message-ID: <20200823193502.GD25365@duo.ucw.cz>
References: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
 <20200819163634.5430-2-biju.das.jz@bp.renesas.com>
 <20200819180505.GB5567@amd>
 <TYBPR01MB5309709F469C1BBDCB012749865A0@TYBPR01MB5309.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TYBPR01MB5309709F469C1BBDCB012749865A0@TYBPR01MB5309.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: IunUGcjqIQNHDsJQ429j6TEpx4520388AA=
Content-Type: multipart/mixed; boundary="15vFtEacJq5pSe8coHda"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598211307;
 bh=Jfol2t3QHX60b8+KPg6IJlna8d47T0xOj0NUPLy8dbk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=PQmbFxFyA+3Po27johevzfEZC9q2RG9lbxfiRPBxePcKmAM2AcW651tLsF8qzfqG/H0
 v14Je3PCcCDYl0GP4bjMBUciSEyrs21YWlPoUKZ4IY7i6FE1qZ+BPKU+kpVrzWAY8Q9Ff
 KCIxsyCa+HhpikItLP+Yt/Id/gCQZmr90pU=

--15vFtEacJq5pSe8coHda
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline

--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Ok, so this is anti-social:
> >
> > > -dtb-$(CONFIG_ARCH_R8A774A1) +=3D r8a774a1-hihope-rzg2m.dtb
> > > +dtb-$(CONFIG_ARCH_R8A774A1) +=3D r8a774a1-hihope-rzg2m-rev2.dtb
> >
> > This renames dts away, but at the end of series, new dts is created wit=
h the
> > r8a774a1-hihope-rzg2m.dts name, but this time it is for rev4 (not rev2)=
 board.
> >
> > So... people with rev2 boards and existing build script will get rev4 d=
ts..
> > without any error.
>=20
> Yes, that is true. But if you agree, We need to use our latest/greatest S=
oC/board as the main SoC/Board and rest are with explicit revision in dts/d=
tb .
>

I believe it would be better to always use explicit revision in these
cases; anything else is fairly confusing, as kernel update breaks your
setup (aka a regresssion).

Now, if -rev2 had few copies, and people really have -rev4, there will
not be much breakage. But imagine if rare -rev5 is released in future...

But mainline already made the choice. I'd just prefer not making same
choice in future.

Now, what to do here? One way would be to apply a series, but add a
README.cip file explaining incompatible change (and any future stuff
people need to know).

Best regards,

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX0LE5gAKCRAw5/Bqldv6
8vVaAJ0W9dOi+z1i0waZz/5w9xhKZOBhIACgvtS9ffe8Wbp/R8rdqAsKymnd1fs=
=0oOM
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--

--15vFtEacJq5pSe8coHda
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5230): https://lists.cip-project.org/g/cip-dev/message=
/5230
Mute This Topic: https://lists.cip-project.org/mt/76290781/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--15vFtEacJq5pSe8coHda--
