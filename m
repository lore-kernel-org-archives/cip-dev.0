Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FEB104BEDB
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:37:48 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18128.1773225460517686939
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:37:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=CaZOV/Lh;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0947110CD3;
	Wed, 11 Mar 2026 11:37:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773225458;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=9aSVR4vyci+00suCrZIwDDxYJFvYZxo10qmEOTtJfsU=;
	b=CaZOV/LhUjGHOx8j2Kwc9SAelFfiu9hJf62mfXJz3ET6NqIrbb0u3ywVm7ZBzwDR2fPl0d
	Ch1Kx01X87YgSlyZ+Wv222SdgY81OWV4fqJFg7ss47I4fbSgz78iH7h9dlqkGaG1ZwYh8K
	/sKBXIun7e8BSFO+uspY2dbK5Gups0sY9hQ/kPrXwmDswIsJ+unSYlcJkuu0pIKgjgxyKP
	y/W36KlAjdKdrL+Wui+9peJeh3pTvsWWQ2nWVxOZTe4tjF2GJWqahuYKMP0T7uobngDMOH
	UE7HIRDjdh34uqn4vsnVXMheCtZQyMEnJhZDnW2WbUsg74YFcdJMRmJBWy7ZUQ==
Date: Wed, 11 Mar 2026 11:37:36 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 10/29] serial: rsci: Add set_rtrg() callback
Message-ID: <abFF8BSjpvnrXaaV@duo.ucw.cz>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
 <20260309142549.987737-11-biju.das.jz@bp.renesas.com>
 <TYCPR01MB113328C3D06959DBB94D6BC118646A@TYCPR01MB11332.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PF0Ar8wfqgacP+5Z"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB113328C3D06959DBB94D6BC118646A@TYCPR01MB11332.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:37:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22277


--PF0Ar8wfqgacP+5Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > +	fcr &=3D ~FCR_RTRG4_0;
> > +	fcr |=3D field_prep(FCR_RTRG4_0, rx_trig);
>=20
> field_prep is not present on 6.12, later patch#29 convert it to PREP_MODI=
FY
>=20
> I will send v2, squashing this patch with patch#29.

Thank you.

For the record, just noting the fact and keeping the patches would
likely be acceptable solution, too, as would be backporting
field_prep() stuff.

But v2 works for me, too.

Best regards,
								Pavel

--PF0Ar8wfqgacP+5Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabFF8AAKCRAw5/Bqldv6
8lFUAKDBo/dp5a6u/KC3IC+gLqKVZ2T00gCbBpr8qTXJC2W5mlarLjj2w2lgzi8=
=2gN9
-----END PGP SIGNATURE-----

--PF0Ar8wfqgacP+5Z--

