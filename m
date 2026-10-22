Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1147.1792699363016400637
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2026 13:02:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=GxkEfJ7/;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B422C104F6D;
	Thu, 22 Oct 2026 22:02:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792699356;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=D9lZWxfDITL00aPVlGlFCM7rUW/m3Y8d9MN27Wvo5q8=;
	b=GxkEfJ7/PLuhQCaeIr0VacmcFuns+eGmHu/GbHZ4ZUrGcbe75VojhpbnHkiSA0UDTn/paF
	afwLDyj2nrVGe7XAiz23NIcIOApYog2J7ELsv3sAuZ7rzAe2PaOJA6pXl50jjjbfPg6Ae7
	2f2S6pNA8/95w+/5x4qjFGlDSYcnxjqVO4LuYu6+f5AexpOxQxk/Ml++1riqPfWegXkzkT
	zk3mOB17KYCzsEItxmJA5NjYDFPZ7q4XSQeYw4q/5/1FLdqCs/RV3Pu/yFmG539Wb/3UJv
	9/G6HqZyMArmrTfyekyW9MRw3wmnF4X4JN576ROXLfTBlrnlJ8LX13krXGn7Og==
Date: Thu, 22 Oct 2026 22:02:35 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju Das <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 0/5] Add RZ/G3L RSCI support
Message-ID: <atpr2xe3h0fPVx3X@duo.ucw.cz>
References: <20261022134021.217964-1-biju.das.au@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="utjWy3A+uMfAb9+J"
Content-Disposition: inline
In-Reply-To: <20261022134021.217964-1-biju.das.au@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 22 Oct 2026 20:02:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24517


--utjWy3A+uMfAb9+J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> This patch series aims to enable RSCI support on RZ/G3L SMARC EVK.
> All the patches in this series are cherry-picked from mainline.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--utjWy3A+uMfAb9+J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCatpr2wAKCRAw5/Bqldv6
8jY4AJwMoDvKYYrYals/1p2Te5UKTm4nxACePAdTjXMS+1pjWbi0PXn1PAs2MK8=
=t5ri
-----END PGP SIGNATURE-----

--utjWy3A+uMfAb9+J--
