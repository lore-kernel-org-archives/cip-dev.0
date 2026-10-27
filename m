Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.30027.1793136169278647485
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Oct 2026 14:22:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=WMQw4+D2;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9187510B2BC;
	Tue, 27 Oct 2026 22:22:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793136163;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+pDTpJrZ2cT6tGz5hR6iUTdiakgVKEYWHp82NNZRKq4=;
	b=WMQw4+D2xJToyx2QUD+Uwy2yAUW6jkSE79NzyGDNa9RSWuSEBkWLrr0aNhmJP7VMo+QHlZ
	i/VyF5pk1mBQaRWDv8OdqRya6dR8Kn5A2+oFtHlsQOgZUpKqnx3TmNdCWBByo5qCUqqc60
	7a2kp6IgHJGJ/D1kCxs0/w+9hGkgYCRxLWg7ek1z460wGy74Wic4OtYBYVrbHe2578C9ZY
	K8tPmQfOfot2X8/EXI2fi+5ubAIAWqBg37MMHeyVPSJdNR6QqnpHaEvFzb09F7RaeDRnGc
	ltfgJlHOUNuKJDmf6CalXgjKhv/30X+jvdc/JNYzSfQBy3WDQJccBi1G5bhwlg==
Date: Tue, 27 Oct 2026 22:22:41 +0100
From: Pavel Machek <pavel@nabladev.com>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org,
	pavel@nabladev.com, uli@fpond.eu, claudiu.beznea.uj@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 5.10.y-cip 1/1] iio: adc: rzg2l_adc: Set driver
 data before enabling runtime PM
Message-ID: <auEWISmECW91wII2@duo.ucw.cz>
References: <1792979104-32023-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1792979104-32023-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <2aef2cc8-8d1a-4b4a-afaa-de8cac59a8bd@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uxtKOl9c77vsYk+2"
Content-Disposition: inline
In-Reply-To: <2aef2cc8-8d1a-4b4a-afaa-de8cac59a8bd@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 27 Oct 2026 21:22:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24555


--uxtKOl9c77vsYk+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>
> >=20
> > commit c69e13965f26b8058f538ea8bdbd2d7718cf1fbe upstream.
> >=20
> > When stress-testing the system by repeatedly unbinding and binding the =
ADC
> > device in a loop, and the ADC is a supplier for another device (e.g., a
> > thermal hardware block that reads temperature through the ADC), it may
> > happen that the ADC device is runtime-resumed immediately after runtime=
 PM
> > is enabled, triggered by its consumer. At this point, since drvdata is =
not
> > yet set and the driver's runtime PM callbacks rely on it, a crash can
> > occur. To avoid this, set drvdata just after it was allocated.
> >=20
> > Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code=
")
> > Signed-off-by: Claudiu Beznea<claudiu.beznea.uj@bp.renesas.com>
> > Link:https://patch.msgid.link/20250810123328.800104-3-claudiu.beznea.uj=
@bp.renesas.com
> > Cc:<Stable@vger.kernel.org>
> > Signed-off-by: Jonathan Cameron<Jonathan.Cameron@huawei.com>
> > Signed-off-by: Nobuhiro Iwamatsu<nobuhiro.iwamatsu.x90@mail.toshiba>
>=20
> Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for review, applied.

Best regards,
								Pavel

--uxtKOl9c77vsYk+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauEWIQAKCRAw5/Bqldv6
8pxDAKCky2vjfI10WZHjN42EmZlMfbi/1gCePdLP4zlKkrG8gcc3+GI1dLojjco=
=EL2W
-----END PGP SIGNATURE-----

--uxtKOl9c77vsYk+2--
