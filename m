Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ABCCF318E
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 10:49:55 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3901.1763549391212573225
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Nov 2025 02:49:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=RKKLz2KX;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB009101E0E76;
	Wed, 19 Nov 2025 11:49:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763549388; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LHSH0uRDDWdI9knqzHHVQPpu7AuhT5EVLgz321QWqJc=;
	b=RKKLz2KXAS/C0FyJuFvrNr7CGnRMuN6SPQmLxstRjYEHQMTryEEX4T66r5K9AoebG4Lw3O
	VCK/51It7728X5ExiSJfIca8ehWixFnGZEtYKqPe3mK2R4xDJbrwJxvXwHb1K09EqZwDgT
	HBd6V2sTd7VMPFq3d9ploI9PE65aRURTqzc8knEcIt/kwoVoDpbPe0N/Lv25k7ATBpPmf5
	H+NNDQJXE+U1RA/PP3wJdXmK+Gdfh9s2s5hnbfr3i+9Ao6LJDQzR3/t8dMAEM940kkLS+W
	iLFibUwx/46uNYfeYCvF6ETGjk0WkZSjENGJh9ypG0mJWBw+CPn4pBhfaxGKBA==
Date: Wed, 19 Nov 2025 11:49:46 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: ovidiu.panait.rb@renesas.com, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip 0/2] Add RZ/V2H eMMC support
Message-ID: <aR2gypM5VXArQa0C@duo.ucw.cz>
References: <20251114111343.74438-1-ovidiu.panait.rb@renesas.com>
 <TY7PR01MB148184357312FADB4809BCD1ECDD7A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uv4abJfrohHN9+o3"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB148184357312FADB4809BCD1ECDD7A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Nov 2025 10:49:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20626


--uv4abJfrohHN9+o3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >  arch/arm64/boot/dts/renesas/Makefile          |  6 ++
> >  .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    |  9 +++
> >  .../boot/dts/renesas/rzv2-evk-cn15-emmc.dtso  | 50 ++++++++++++++
> >  .../boot/dts/renesas/rzv2-evk-cn15-sd.dtso    | 69
> > +++++++++++++++++++
> >  scripts/Makefile.lib                          |  3 +
> >  5 files changed, 137 insertions(+)
>=20
> I reviewed this series, looks good to me.
> I can apply this series if there are no other comments.
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Thank you, applied.

BR,
								Pavel

--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--uv4abJfrohHN9+o3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaR2gygAKCRAw5/Bqldv6
8uKzAJ9qyRINTP+GbA71/QsGCjKwGxnTdwCeOUYlFeEf9k9FISdEfnkibi7IQiA=
=R/I4
-----END PGP SIGNATURE-----

--uv4abJfrohHN9+o3--

