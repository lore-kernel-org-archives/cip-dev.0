Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2594.1794215442855419851
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 01:10:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=fCOyUYT4;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E8A110971D;
	Mon, 09 Nov 2026 10:10:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794215436;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=uTtgeRHCVuJv//XUCJkyE8gPOR+OJboxW0jbpqaa2zk=;
	b=fCOyUYT49sBd7ld/MdwavK1JJXz22gZOCs8ijltoySHHWiCDeI37X7TCO34hLjCFXf+2DR
	12lYzphy2ZD+ZBwZxMQN22cySAY6BUXrscbV32bDdRUJm10JRnjCkIsVqBwduVPNGA/zGc
	wsQq7qYVkG6Jf9tSCu2qyUDp5H7iJEZt65W6tVBJbq6ENQ05Msq8DTzvJrfTJmqdXwwHBC
	vlVqggOVtoQG688rurms+wGRYDp2tsvmY1pH6i/WQGsKtIz6kZR15F7vAraLbWxNi8yYZ/
	+TJsmxYMm4O+0zyt6Bwbzmq8qXiiId9s3JU5eWJmzS0cZ0wR/wAl+3+jtPaa3Q==
Date: Mon, 9 Nov 2026 10:10:32 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: pavel@nabladev.com, cip-dev@lists.cip-project.org, uli@fpond.eu,
	biju.das.jz@bp.renesas.com, tommaso.merciai.xr@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/5] Fix CVEs related to patches
 backported to the CIP kernel
Message-ID: <avGOCF83NRdd3Nk4@duo.ucw.cz>
References: <1794209954-6205-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GeRrJVcyebtx8Vto"
Content-Disposition: inline
In-Reply-To: <1794209954-6205-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 09:10:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24688


--GeRrJVcyebtx8Vto
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is patch series that fixes CVEs related to patches backported to
> CIP kernel.
> The following CVEs and commits are addressed:

Thanks, I will take a look.

I don't see these in 6.12 (c8fba74056). Should we get them into 6.12
before merging them to 6.1?

> Claudiu Beznea (2):
>   i3c: renesas: Check that the transfer is valid before accessing it
>   i3c: renesas: Fix out-of-bounds access for newdevs mask
>=20
> Tzung-Bi Shih (1):
>   watchdog: rzv2h: Avoid division by zero

Best regards,
								Pavel
--GeRrJVcyebtx8Vto
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavGOCAAKCRAw5/Bqldv6
8qBtAJ9bxhXoA4ei8qx5oYbKmPP/YW45uACfRY0LTnHX1/Kh/T8U+A+6jsqpDA0=
=ONlw
-----END PGP SIGNATURE-----

--GeRrJVcyebtx8Vto--
