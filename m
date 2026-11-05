Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38156.1793895001227751797
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2026 08:10:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=AIf/UTd7;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 402A010CF3A;
	Thu, 05 Nov 2026 17:09:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793894994;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=W6plggmuzoGzwnEdzahHKwM2vrmpjzLAOPRcw8vqrm0=;
	b=AIf/UTd7o30SOmhQUDk+3XsdFfTTYkx51Mfp3cCFWz4gXRvpXNIC2pt87qdJRQEzDMArrE
	vN3d9/lnMyqJJnkgTMhV2aoEomgtl5ZWR0Qv6sJYt4UqmzVlscrOoShoxBxmDvN88sbh/W
	q+CS/x0K/3GzzUOxZ9wjIxKEaXINWiJaRJ/zMaEw0IyNFpS0QBtU6d6UcZVXUk19DVyM1H
	4iKw+AJLEns9AULHqzCTxeImUMmJ8W4QJ1QbQfUIkT5sS01/yDt5cNIANAmsXkCxC2GWnC
	kAjmRi5onELxE6e5eHEC0ATCn6akD2ugNiON7iIQ/b+gyBSCTPv/fN3BWzvRTA==
Date: Thu, 5 Nov 2026 17:09:51 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 0/8] memory: renesas-rpc-if: Improve xSPI
 transfer handling
Message-ID: <auyqT5z7SD8GDuq8@duo.ucw.cz>
References: <20261102211132.22646-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rxSxsOdlmdUG1ft4"
Content-Disposition: inline
In-Reply-To: <20261102211132.22646-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2026 16:10:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24645


--rxSxsOdlmdUG1ft4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series improves transfer handling and runtime PM for the Renesas xSPI
> controller.
>=20
> The first patch configures runtime PM autosuspend in the SPI driver. The
> following patches reduce redundant register accesses in the RPC-IF transf=
er
> paths, move static bridge configuration out of the dirmap paths, and ensu=
re
> the data buffer register is not cached. A further patch uses autosuspend
> after transfers to avoid unnecessary suspend/resume cycles during closely
> spaced operations.
>=20
> The final patch marks the XSPI1 boot partitions on the RZ/T2H-N2H-EVK
> read-only, consistent with the existing XSPI0 partitions.
>=20
> Note all the patches have been cherr-picked from v7.4-rc1 kernel.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--rxSxsOdlmdUG1ft4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauyqTwAKCRAw5/Bqldv6
8lPVAJ9KBYSexBBHAVPSg0kXrz9Z9NY6OwCfdh1pUe76PAkPieEUwfCHpuTi4eA=
=qEBj
-----END PGP SIGNATURE-----

--rxSxsOdlmdUG1ft4--
