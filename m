Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38179.1793895069877145900
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2026 08:11:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=CT/G0Z+l;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B3BCF10BC20;
	Thu, 05 Nov 2026 17:11:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793895064;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=pZ/+DfH/8iDxUdiBibsOiCzzKMEaXBE915BuDblDd4o=;
	b=CT/G0Z+llepX0ySPX5WZtfkt6ehChMch7tVh/aurQzIy8/xunVfV+9+gSJ2QHx8ew5E1f/
	TO2RIhvrn4IhnU1eoilS+LeGocdOBWOPxtNclwD+8ZjOTusJAt1mFYT0H8UI898kyBe065
	lwQOZgAzUiE5SiHEsyzvuzGVjadmzl+9H0kHJ+z9DHGrNDullkVKy+eHZe12xFzrTU0pmt
	EqXyyUVb0+Rog5tviCIflghQQDrGXUrX1Z9SApLRdgxdy4V//gbrDzeSRiy5kREhR2IcBZ
	MdO9bd3SDB7zuTXxTFM3FvF1i0+kLR8dLpbmn8eMXvlO0L6yfuMBsLycIWfWYA==
Date: Thu, 5 Nov 2026 17:11:02 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/7] Add PCIe support to Renesas RZ/V2H(P) SoC
Message-ID: <auyqluIRkxpRjoq8@duo.ucw.cz>
References: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4/aRxICmNN0T0s7U"
Content-Disposition: inline
In-Reply-To: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2026 16:11:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24647


--4/aRxICmNN0T0s7U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series backports PCIe support for the RZ/V2H(P) SoC and its EVK to
> the v6.1 CIP kernel.
>=20
> The series adds the PCIe DT binding support, updates the RZ/G3S host
> driver for shared reset controls and multiple controllers, and adds
> RZ/V2H(P)-specific lane and system-controller handling. It also adds
> the required clocks and resets, describes the PCIe controllers in the
> SoC DTS, and enables the ports on the EVK.
>=20
> The EVK DTS uses a fixed 100 MHz reference-clock node because the
> Versa3 clock-generator node is not present in this tree.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--4/aRxICmNN0T0s7U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauyqlgAKCRAw5/Bqldv6
8tRgAJsEXV+zGjMbWno4KXY4seRynPA0WgCfamE8V372MRVGY8Rg7Il+x+6dsO0=
=0Lgk
-----END PGP SIGNATURE-----

--4/aRxICmNN0T0s7U--
