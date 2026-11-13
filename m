Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9819.1794573019630811864
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Nov 2026 04:30:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=DARq826P;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EA6C210BE60;
	Fri, 13 Nov 2026 13:30:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794573013;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=9nCv3JiomWDkT9vFsjKXwIplo6R0wRlJD6v7UhlgGUY=;
	b=DARq826PtgStHymj4pl/uVCeDW4SNpyPNRC4GN9eEKSHXCq2kpbDrcO/ep2RsZtL2eaHiQ
	EnQttmxRm1hoJzkz4yihgusaNyEz/a8FXBTm8hO2V9i6Y4Dhpcn9BSBdZryHzpuch/YcJp
	IU0lug2K/NgFmtd+K5xfQ0rbvDxkCfdGAZYZv6jZpv8GKW8SjHNKml7Z4qtXum/5SoBxKB
	S29pUwqUqFB4e+BjG7WbriOV9imMlIpL5qR+LGgKGzdVGZT8vDZDbcQ3ltCPjkguTFf1um
	DkOlK+c5pkcW+YCTmelmHSk+Az17N8fpd5aYBXBx8PiP2+CoEMkJ01RRtf8f9A==
Date: Fri, 13 Nov 2026 13:30:09 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Pavel Machek <pavel@nabladev.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 10/24] clk: divider: Add KUnit tests for
 clk_divider_bestdiv() ULONG_MAX handling
Message-ID: <avcC0dSGw7kk-uUc@duo.ucw.cz>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261109121451.6042-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <avYagTe3duUCQ328@duo.ucw.cz>
 <TY4PR01MB44392967D341C138EC7EAAE395AA7F2@TY4PR01MB443929.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EG8RjFyz1CGrLMp1"
Content-Disposition: inline
In-Reply-To: <TY4PR01MB44392967D341C138EC7EAAE395AA7F2@TY4PR01MB443929.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 13 Nov 2026 12:30:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24799


--EG8RjFyz1CGrLMp1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Hi!
> >=20
> > > commit 50ca555d6ae8205374e406b411ae0e8e9447568d upstream.
> > >
> > > Add KUnit tests to verify the behaviour of clk_divider_bestdiv() when
> > > clk_round_rate() is called with ULONG_MAX, which is the canonical way
> > > to probe the maximum rate a clock can produce.
> >=20
> > Do we strictly need the kunit tests in -cip? They should not be required
> > for functionality.
> >=20
> Agreed, I will drop it.

I'm now in the middle of the testing, and this will not hurt anything,
so it is easier for me to just keep it (unless something else happens
to stop the merge). Just remember it for next submissions :-).

Thanks and best regards,
								Pavel

--EG8RjFyz1CGrLMp1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavcC0QAKCRAw5/Bqldv6
8iKwAKCRwmNS+x8FOaLPHLzzKSUVK/WOzACgtAWVHOaV4rbNeeZJ/+0stnEpZx4=
=tDEt
-----END PGP SIGNATURE-----

--EG8RjFyz1CGrLMp1--
