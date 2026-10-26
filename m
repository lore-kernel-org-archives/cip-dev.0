Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2091.1793034447384222406
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Oct 2026 10:07:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=KBRXNBbv;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B83A2109DB0;
	Mon, 26 Oct 2026 18:07:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793034441;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=izd8E9Ka9TOm9iQhQIT9GKaI28RPxWk4hrpWbiavxfg=;
	b=KBRXNBbvJMlaWgd75unJBiNJ/MbTUquF8MffcKjUj/fqHp8NVlh9usbrmZOJ3o8za9GFq8
	JOl8cMQBE3dJBcGTJxAZ0yK5z5tF0DHeNfKZhnmngTpOY00onaj2AOgi8wSTGMia0Fhlvn
	atV97AdFvgfQMrxVvD9lQRsF5F/3vc4gmyjQ2V2wHnvwfWzHXpAg4MZ80vjdW3vea7XtP2
	/pJuRqubXpDVWjos3R/4u70QvVhfm5aJOLS2I8prPjCVgg+J1ORLoWMJuYbmanN8gDUVRj
	RL/7PVpO32ZUvpL87qUfOSHQT/32eBduVmhLR+fHs2jb1iYO0OQJpWSDGMIR5A==
Date: Mon, 26 Oct 2026 18:07:19 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com, uli@fpond.eu,
	tommaso.merciai.xr@bp.renesas.com, claudiu.beznea.uj@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 1/2] i3c: master: renesas: Fix
 memory leak in renesas_i3c_i3c_xfers()
Message-ID: <at-Ix0TT_a618Vy8@duo.ucw.cz>
References: <1792979286-32200-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1792979286-32200-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vou0rHjkmH4pH4Wt"
Content-Disposition: inline
In-Reply-To: <1792979286-32200-2-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 26 Oct 2026 17:07:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24549


--Vou0rHjkmH4pH4Wt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The xfer structure allocated by renesas_i3c_alloc_xfer() was never freed
> in the renesas_i3c_i3c_xfers() function. Use the __free(kfree) cleanup
> attribute to automatically free the memory when the variable goes out of
> scope.
>=20
> Fixes: d028219a9f14 ("i3c: master: Add basic driver for the Renesas I3C c=
ontroller")
> Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> Link: https://patch.msgid.link/20260406-renesas-v3-1-4b724d7708f4@gmail.c=
om


=2E..

> --- a/drivers/i3c/master/renesas-i3c.c
> +++ b/drivers/i3c/master/renesas-i3c.c
> @@ -817,13 +818,12 @@ static int renesas_i3c_priv_xfers(struct i3c_dev_de=
sc *dev, struct i3c_priv_xfer
>  	struct i3c_master_controller *m =3D i3c_dev_get_master(dev);
>  	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
>  	struct renesas_i3c_i2c_dev_data *data =3D i3c_dev_get_master_data(dev);
> -	struct renesas_i3c_xfer *xfer;
>  	int i;
> =20
>  	/* Enable I3C bus. */
>  	renesas_i3c_bus_enable(m, true);
> =20
> -	xfer =3D renesas_i3c_alloc_xfer(i3c, 1);
> +	struct renesas_i3c_xfer *xfer __free(kfree) =3D renesas_i3c_alloc_xfer(=
i3c, 1);
>  	if (!xfer)
>  		return -ENOMEM;
> =20

We don't usually mix declarations and code like this. Some compilers
may even warn...? It may be ok as mainline already has it.

Best regards,
								Pavel

--Vou0rHjkmH4pH4Wt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCat+IxwAKCRAw5/Bqldv6
8pGSAJ96SYEhtBAOxp0hkgLYjNrSfQtZcACcDY4dGkv8o2Aa0WSY+Ob065YmMbY=
=scnS
-----END PGP SIGNATURE-----

--Vou0rHjkmH4pH4Wt--
