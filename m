Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.29980.1793135994198367752
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Oct 2026 14:19:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=QsF0exCI;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2AF1D10B851;
	Tue, 27 Oct 2026 22:19:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793135987;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+wc0c3uI30HiIrCV1H8VGud9zw3mcoI/dFyLXOfeoWg=;
	b=QsF0exCIHN90kbtdOKI8DhzcszSD/2Traq3FJhdjZYF/S9+kslJKubgFsijDaY69pOcHXM
	/w13y3Dx3d5yRHWljF9gZX+48wuOLahqWNPFX6Yg5lmp05SnrEo3ETi9Jmm9cAE7sCRyjV
	2ve+ZZo4wsEBWTMsJlKDIuMXPGOneZRhCkx9if5DwbxGTOLXt6YKtkvSZ5n8vbo2u5jZZs
	gppErICdOhHow8whNqdNtdTEJO843lk1R5nv4ysl3g0ubf2cK50FbmTCEw976XuaR7pewf
	0USfQhYEs91phM4i9Vd+X50Xg1TKHsPpBhatC8OSaCntc7NgmS5Dbn7eUpvMHA==
Date: Tue, 27 Oct 2026 22:19:44 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com, uli@fpond.eu,
	tommaso.merciai.xr@bp.renesas.com, fabrizio.castro.jz@renesas.com,
	claudiu.beznea.uj@bp.renesas.com,
	cosmin-gabriel.tanislav.xa@renesas.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/5] Fix CVEs related to patches
 backported to the CIP kernel
Message-ID: <auEVcDXlxfho0Dgs@duo.ucw.cz>
References: <1792979242-32127-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gFuJ1m9DaVl/LlHd"
Content-Disposition: inline
In-Reply-To: <1792979242-32127-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 27 Oct 2026 21:20:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24554


--gFuJ1m9DaVl/LlHd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Claudiu Beznea (1):
>   iio: adc: rzg2l_adc: Set driver data before enabling runtime PM

> Cosmin Tanislav (2):
>   counter: rz-mtu3-cnt: prevent counter from being toggled multiple
>     times
>   counter: rz-mtu3-cnt: do not use struct rz_mtu3_channel's dev member
>=20
> Felix Gu (1):
>   i3c: master: renesas: Fix memory leak in renesas_i3c_i3c_xfers()
>=20
> Johan Hovold (1):
>   dmaengine: sh: rz-dmac: fix device leak on probe failure

Thank you, applied.

Best regards,
							Pavel

--gFuJ1m9DaVl/LlHd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauEVcAAKCRAw5/Bqldv6
8mZWAKCYXGGAv9ml10nGGJnP1NI2bVMHHACgrrn/cbGdGaq6zZ2kUewi4Y62rSg=
=q2dd
-----END PGP SIGNATURE-----

--gFuJ1m9DaVl/LlHd--
