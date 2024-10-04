Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D11CFA775
	for <webhook@archiver.kernel.org>; Fri,  4 Oct 2024 12:47:44 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.21116.1728046055521685925
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Oct 2024 05:47:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 137D61C0082; Fri,  4 Oct 2024 14:47:34 +0200 (CEST)
Date: Fri, 4 Oct 2024 14:47:33 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 03/15] ASoC: sh: rz-ssi: Add full duplex
 support
Message-ID: <Zv/j5Q5v9S8DvIBE@duo.ucw.cz>
References: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
 <20241002170712.655449-4-biju.das.jz@bp.renesas.com>
 <OS0PR01MB6388556A5A29232D4FB90B7292712@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346D77ACA74093D61B9AD4A86712@TY3PR01MB11346.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wCREExNs6rmQxKwP"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346D77ACA74093D61B9AD4A86712@TY3PR01MB11346.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Oct 2024 12:47:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17003


--wCREExNs6rmQxKwP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +	/* Wait for idle */
> > > +	timeout =3D 100;
> > > +	while (--timeout) {
> > > +		if (rz_ssi_reg_readl(ssi, SSISR) & SSISR_IIRQ)
> > > +			break;
> > > +		udelay(1);
> > > +	}
> > > +
> > > +	if (!timeout)
> > > +		dev_info(ssi->dev, "timeout waiting for SSI idle\n");
> > > +
> >=20
> > We do not need to process to timeout?
>=20
> HW manual flowchart(Figure 27.57) mentions to wait for ever. So, I have a=
dded
> a safe time out.

If the documentation says timeout should never happen, should we have
dev_err() or even WARN() instead of dev_info()?

Best regards,

								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wCREExNs6rmQxKwP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZv/j5QAKCRAw5/Bqldv6
8oU2AJ9vmilWUxBexk/GEMjWiQaYQugWfwCeOUPczeIGesrxDfjPJFONCKbaoIY=
=5lHW
-----END PGP SIGNATURE-----

--wCREExNs6rmQxKwP--

