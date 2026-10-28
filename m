Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8768.1793226169700013347
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Oct 2026 15:22:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=YCtrH1WD;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1C2A1083F7;
	Wed, 28 Oct 2026 23:22:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793226162;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=QAa2BKTiZdH2NPf1kG1vRLf3Jv8OdD3BNvq0kk9zTOo=;
	b=YCtrH1WDhNIQZe8Zpa1MRIVx4QqJZ0CXPsY8Gf40uBjHXtmLYAb0zcM7kANlAuqc4koCv0
	UVQuqiMxvzSITLrYNg4QGxFlusE9da/zBTTc141Nwc7JxjLzX4t33/kxWMav7O0DeAMcEC
	S/y0gGWkpyg590buuRBj3N+IhCvx7K9lUBhSlLqx1ovWS75C2+OrmLbD8FAS9MK7eY05xF
	FrlofrHM2GCNukmsiPJXxtLyLRbbZHv5eEzCAcLAIGKafw7qdMU4RdTPTbAHQBRjEqU49Q
	Wr1C0kYaQPNIdCxRaghqKF31Qwbfhq+CBtAfb4ZqWJfTUsuDOjBknCuZ6QsxtQ==
Date: Wed, 28 Oct 2026 23:22:39 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Garpur Hnefill Emiliuson <garpurhnefill.emiliuson.d47@mail.toshiba>
Cc: nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com, uli@fpond.eu,
	claudiu.beznea.uj@bp.renesas.com, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip] PM: domains: Mark
 dev_pm_domain_allow_detach_on_unbind_cleanup() as inline
Message-ID: <auJ1r4H8R_vnwy5O@duo.ucw.cz>
References: <1793085576-6789-1-git-send-email-garpurhnefill.emiliuson.d47@mail.toshiba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qakt/ht8+QXELz2k"
Content-Disposition: inline
In-Reply-To: <1793085576-6789-1-git-send-email-garpurhnefill.emiliuson.d47@mail.toshiba>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 28 Oct 2026 22:23:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24561


--Qakt/ht8+QXELz2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Building with CONFIG_PM=3Dn and CONFIG_PREEMPT_RT=3Dy triggers a
> -Wunused-function warning for the stub implementation of
> dev_pm_domain_allow_detach_on_unbind_cleanup() in pm_domain.h.
>=20
> This issue only affects the -cip tree. Unlike the surrounding stub
> helpers, this function was not declared inline. Mark the stub
> implementation as inline so unused configurations do not trigger
> compiler warnings.

Thank you, applied.

Best regards,
								Pavel

--Qakt/ht8+QXELz2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauJ1rwAKCRAw5/Bqldv6
8sgnAJwKlhmc0KAI/NUu++4zLGM1OEKMegCfRUYznMWZBT8TDLIy3s78F4bOz1c=
=UwBi
-----END PGP SIGNATURE-----

--Qakt/ht8+QXELz2k--
