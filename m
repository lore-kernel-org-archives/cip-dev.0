Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1473.1795021369491705617
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 09:02:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=dUrYKU3U;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5363D10DECD;
	Wed, 18 Nov 2026 18:02:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1795021363;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Km3Tmg0mxCuPUaRUhK4OIOTWlP/CFnHLu6D87WDbgyo=;
	b=dUrYKU3UtiAkPd3WDzDRAE0Nz+t7EADZB/lovMUog4UcB77Tvi7+Q65ruEB9Q7QgQhRDZd
	kYtUrkZtauokSHQ/fZv2dhFErZdIxMkLWoUjyADFao/g8QSmX8zf88/zVNzr0FgQbKRW4I
	K+3grL0bq+YlyV7fekCwRsxOq/7SXhjSbityg7CFGYOOt0YOhnn/VbjUfafLB/M9hFdKil
	CSz3GHykUNa5GTY2Q6++5av3RCFEtnpF2hpC5O40vEL4poF/WRkFz6kbl9CCFZKJopwvJj
	xZY/oduI3KYJikBioisyoECUHAlcjn/KBImNQ/4NWiG5wSaEbo+l31hTG+HAeA==
Date: Wed, 18 Nov 2026 18:02:42 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Pavel Machek <pavel@nabladev.com>, cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/4] Backport sign-file,extract-cert
 patches for OpenSSL 4 compatibility
Message-ID: <av3aMo0GWifKLOv8@duo.ucw.cz>
References: <20261112-openssl4-419cip-v1-0-2f56859669bb@fairphone.com>
 <avyUNwowVKWAJDj9@duo.ucw.cz>
 <DMY8IM8YE31V.28096PQXT9KV5@fairphone.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wue7uKP9fEm0X1vK"
Content-Disposition: inline
In-Reply-To: <DMY8IM8YE31V.28096PQXT9KV5@fairphone.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 17:02:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25000


--wue7uKP9fEm0X1vK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> On Arch Linux the extract-cert tool from 4.19.y-cip doesn't compile
> >> anymore due to OpenSSL 4 upgrade which removed some APIs used in the
> >> host tools.
> >>=20
> >> Backport some patches, taken from linux-6.1.y to fix compilation.
> >>=20
> >> Note, this is the first time I'm sending patches to cip-dev, so I hope
> >> I'm not missing some contribution guidelines.
> >
> > I believe these are not yet in 5.10, that would be first step.
> >
> > This is not usual kind of bugfix, nor is it backport from a member
> > company. Still, I'd not be opposed in taking these, provided 5.10
> > version is taken first.
>=20
> I've submitted the patches now for inclusion for 5.15 & 5.10 stable:
>=20
> https://lore.kernel.org/stable/20261118-openssl4-515-v1-0-e1fbd1da96d4@fa=
irphone.com/T/
>=20
> Let's see when they get in!

Thank you, that's the right way to do this.

I believe we'll pick them up automatically after they reach
-stable. If not, you can ping us on the mailing list.

Best regards,
							Pavel

--wue7uKP9fEm0X1vK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCav3aMgAKCRAw5/Bqldv6
8n+TAJ94/PZUhhiQve8eMV7JDmahSFIq+ACgv5+EImIzIn7vM9AJWlDR9k1pZ2s=
=kbxC
-----END PGP SIGNATURE-----

--wue7uKP9fEm0X1vK--
