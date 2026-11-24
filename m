Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16197.1795520528515948026
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Nov 2026 03:42:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=dMmQbrZC;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8AE8310F402;
	Tue, 24 Nov 2026 12:42:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795520522;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=1BTzLle5nxrxUiE+5oEgh3HbhtQAXwFUjkHvqEE8BAA=;
	b=dMmQbrZCgWCv5NFYY24uQMTH10OqtcFGWu6HZyOvlRJeSEJrxZsciryhexCU0FbmO4VZ9G
	p2C+LdNd6pjWV4o/t27DU5H6I/Al4Vn2vabzc2FGD/wzKaz+w+JCmE4sNmev5jz07annc4
	UsxGU2mzmjUNDV+BqVhgGkuWT853v425Qn6ptLBds/viU0FXOsZR4cSdgWqFyZ44f7l/OA
	VwVnonNfhH6fLu8Wbe0FNeUMXYGpLBrJjjGtcfoAclBkVbAkmPCMB6GwFcxwPAIBBrAdPd
	iKtYIONF0ONt5YNAYUlTKw0yx8NqjWdfm9D+uR8rFLLy8rM6R9rQbL89BctOxw==
Date: Tue, 24 Nov 2026 12:41:58 +0100
From: Pavel Machek <pavel@nabladev.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: Pavel Machek <pavel@nabladev.com>, nobuhiro.iwamatsu.x90@mail.toshiba,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip 00/34] i3c: Backport I3C support for Renesas
 RZ/G3S
Message-ID: <awV4BrsEcu6HeHgX@duo.ucw.cz>
References: <20261117114921.1485204-1-claudiu.beznea@tuxon.dev>
 <awStSzX0cNPoVR5E@duo.ucw.cz>
 <732ba6e4-f3e1-42d9-9f00-5c42e1471a6e@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yeBMYbf2wj1dGMav"
Content-Disposition: inline
In-Reply-To: <732ba6e4-f3e1-42d9-9f00-5c42e1471a6e@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 24 Nov 2026 11:42:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25062


--yeBMYbf2wj1dGMav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2026-11-24 13:34:47, claudiu beznea wrote:
> Hi, Pavel,
>=20
> On 11/23/26 23:16, Pavel Machek wrote:
> > Hi!
> >=20
> > > Series backports the I3C support for the Renesas RZ/G3S.
> > >=20
> > > Please provide your feedback.
> >=20
> > I'd be happier if series were closer to 20 patches than 35 or
> > 70...
>=20
> For future patch submission: would you prefer submitting individual series
> to enable a feature? E.g. for this series, instead of a single 34 patch
> series, would it have been easier for you if I had submitted it as 3
> separate series, as follows:
>=20
> - one series containing I3C patches (21 patches)
> - one series containing pinctrl and clock patches (8 patches)
> - one series containing device tree patches (5 patches)
>=20
> ?

For this one, one series with I3C patches and one series with pinctrl
+ clock + dts would be nice. Even better would be if the split was
something like

Series A+B for 6.12
Series A+B for 6.1
Series A+B+C for 5.10

> Also, would you prefer to submit them at the same time or submit one seri=
es,
> wait for it to be integrated then go with the next series?

You can do it at the same time, but expect delays.

Thanks and best regards,
									Pavel

--yeBMYbf2wj1dGMav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCawV4BgAKCRAw5/Bqldv6
8ofdAKC1WrLJGbbOY2u4QqvG1K6TM1G6dACfTwMbn55yJJ+V2hfeA2JpXym1eT4=
=6W/g
-----END PGP SIGNATURE-----

--yeBMYbf2wj1dGMav--
