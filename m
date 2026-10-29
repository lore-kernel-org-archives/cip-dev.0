Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9910.1793274436080239789
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Oct 2026 04:47:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=YKAN11Gr;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B738E10AA36;
	Thu, 29 Oct 2026 12:47:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793274429;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=JXdFLmJ/OOKl/KMV0+WL3YKQrHl+srfD3VzVJnvb480=;
	b=YKAN11GrS1jZsStkSMlVT/PorTT6fJo3v2UAgybCZXgDVrMvxBbZnndeJYdqqlAfEARh1R
	YBABK8cCF7nMoP0qaj5fY4IIhHkDPqzjpOMQsz9DphLR8rLSQTWmcccPpv9XkDQ5YJmF48
	SeRiiXft4nqOoRIr52qiYlTl2Iwsj2odXEHiwEWUzjQ8qPy8MiJ6o6TJvkBbyl+tZiX7KG
	4YOlLLMKtkKwamlT1f1kBI0Hjv3NRuyYw2R0E4n2exu9DfLqjqdhzJUsUCq7pDKx6yPX5p
	pwoyllnkbUpZxFRAxD0kPQC8TvLJ8pogI0QkkZc+BWLwSWULWfvoTUxVlsgzKA==
Date: Thu, 29 Oct 2026 12:47:06 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Nobuhiro Iwamatsu <iwamatsu@gmail.com>
Cc: pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
Message-ID: <auMyOkxCLjnNhxbI@duo.ucw.cz>
References: <TY7PR01MB14818B13FA2A81593C33A4DFCCD6E2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <auMhnCWA5XBg9vln@duo.ucw.cz>
 <CACe6DC4h=wq8f9ryZuXcrSaOMPWaZD_p2A277r=Ayi1Q0ALWYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SAP1AC1GLk1p1hsZ"
Content-Disposition: inline
In-Reply-To: <CACe6DC4h=wq8f9ryZuXcrSaOMPWaZD_p2A277r=Ayi1Q0ALWYQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 29 Oct 2026 11:47:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24568


--SAP1AC1GLk1p1hsZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > USWest    USEast    UK        DE        TW        JP
> > > 05:00     08:00     13:00     14:00     20:00     21:00
> >
> > Note this is no longer correct. Daylight savings changed, and 12 UTC
> > is 13 MET.
>=20
> USWest    USEast    UK        DE        TW        JP
> 04:00     07:00     12:00     13:00     20:00     21:00
>=20
> Is this correct?

I believe that is correct. Start in 14 minutes.

Best regards,
								Pavel

--SAP1AC1GLk1p1hsZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauMyOgAKCRAw5/Bqldv6
8q3qAKC8b6JWXJUI9SpyuG1k/LR5hno1cQCgheEG4Nb+yb6XAkWieVLx58CNuAI=
=xDvl
-----END PGP SIGNATURE-----

--SAP1AC1GLk1p1hsZ--
