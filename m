Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38173.1793895046860349689
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2026 08:10:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=VZ7gZITC;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C174610BC20;
	Thu, 05 Nov 2026 17:10:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793895040;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=BvRTnSYZ6gWFiBwr+NiPFq4l4/8BpE5z8rUBfj/vLNQ=;
	b=VZ7gZITCRwAQzGXlpZt8wYeUIYNXlasEcZVUXD1J97c6yssxza58FzaLTy/mTJgIYCn+km
	ID1gdEWlF539BcbIPPe8AcCsn1g/HpUrN96kDxUOQKhndl2j+8xRKg25m3eRA/fEm6SgS4
	1kYJ0bxIOK5UfW4paz/GICPQPL1I0s3njGvJoE0v4nnuylS0Fr/rcIXu7f2/8bilzMn6Hv
	VW7t6Y/MXjkSGM0kjBnhkOdkAhoqWjXbtm0skezH3e2D559csVuq7Y1KZBK1elIzTs1ALZ
	FdE0SKiVDqodDhTp8eYCR3YTgh+kZZjuwa2l2qoS5+KPjMP9+K+5xVNvivsU5w==
Date: Thu, 5 Nov 2026 17:10:39 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 0/7] Add PCIe support to Renesas RZ/V2H(P) SoC
Message-ID: <auyqf5fY_t_IPxiJ@duo.ucw.cz>
References: <20261102130212.8115-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YM+I+dJi9Pf/8Bky"
Content-Disposition: inline
In-Reply-To: <20261102130212.8115-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2026 16:10:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24646


--YM+I+dJi9Pf/8Bky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series backports PCIe support for the RZ/V2H(P) SoC and its EVK to
> the v6.12 CIP kernel.
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

--YM+I+dJi9Pf/8Bky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauyqfwAKCRAw5/Bqldv6
8kAeAJ9NzJ7GyM6Upf9vTb+7PGD/xi6ulQCgj7xlUklr90ro5A4JGmLukFjN1Ak=
=o291
-----END PGP SIGNATURE-----

--YM+I+dJi9Pf/8Bky--
