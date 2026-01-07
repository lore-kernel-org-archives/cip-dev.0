Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9238D0D174
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 20:28:38 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16073.1767817714565044346
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 12:28:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Jbjn4/Se;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8B3D6103762;
	Wed,  7 Jan 2026 21:28:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767817712;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=wXBMLaU0N7aiUTiDHGlaNH8HheP+t4P7fYuIuWrahlQ=;
	b=Jbjn4/Se9m9PKGvKLKhCbX3xelYIXzKhG8eV9s+vumIAsYKmCmW5BQW1eB4SMOOv2eYswh
	Ndhub3+W6iPgzVU7gb6+ZqG7q7oEFWGwDW46anld3t8xh3wl6fjTzYpymkbGBR4CPLfqPs
	7TRfmLWi/9jBpci/yUgy6yJQ0jY/GRXVPzwCVlI2ZSWNlcfiHrZfAmpU/aqnh4t/xNWkU1
	HvvxsHWtckB8TFkWjSb0stZWzJHXURRc2IO213Jl17OtEittK3j9mQQV2CGTtHhfHVLIve
	OjblF248veZ4v7iNxwRBtKuZ5W6g0kpJj0e+Lww8V9TpVsRyo+ZqPizxSnQtPA==
Date: Wed, 7 Jan 2026 21:28:29 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Pavel Machek <pavel@nabladev.com>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, ovidiu.panait.rb@renesas.com,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 0/8] net: stmmac: Fix EEE-related issues
Message-ID: <aV7B7drla+Q87n7k@duo.ucw.cz>
References: <20251229084132.3624-1-ovidiu.panait.rb@renesas.com>
 <TY7PR01MB14818BF6479C1E24FEC289040CD84A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aV7AQHWo1Un9oZsN@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4E4IBkWXwX/kAUwK"
Content-Disposition: inline
In-Reply-To: <aV7AQHWo1Un9oZsN@duo.ucw.cz>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 20:28:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21420


--4E4IBkWXwX/kAUwK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > The following EEE-related issues were observed on the Renesas RZ/V2H =
and
> > > RZ/V2N platforms with 6.12-cip:
> >=20
> > Looks OK to me.
> > I can apply this if testing is no issue and there are no other comments.
> >=20
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
> Looks ok to me too, and it passed testing, so I applied it added your
> reviewed-by tag and pushed out. I plan to do the same with 6.1 version
> next.

Aha, 6.1 was already applied, so there's nothing to do there.

Thanks,
								Pavel
--=20
In cooperation with Nabla.

--4E4IBkWXwX/kAUwK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaV7B7QAKCRAw5/Bqldv6
8qJqAJ4n9+drcDOEuDi8v1paMsEASZkmhwCbBxSAsz4RYrpweeoHVDZ71tQ6WnY=
=PG+j
-----END PGP SIGNATURE-----

--4E4IBkWXwX/kAUwK--

