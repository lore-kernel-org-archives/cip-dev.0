Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7033.1794559329738307556
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Nov 2026 00:42:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=WeYNv4hy;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DF22210E6AA;
	Fri, 13 Nov 2026 09:42:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794559324;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=AKpyNk5rXI+Lvd3u0KPzzh/3knHq4btKYOJNrKoc4TE=;
	b=WeYNv4hyNPbesv2FPXU8sS8hpbHdhTDYsXygtkBIbuXb6S4S1JHUq9p8uXra87wLR+pZ7R
	evEsTQsCZsjc9uzzdPlpmpACUjQngsLhAf0rHOW+EBZL5eT6nPC8z2lCx/NO69PRRz6em4
	PIOqKicCe5878PgVjj8fR1qh7ryrNawJtgqEh4QQZV0jEYXUA4rPnK55Vepy+Smdc5at4K
	RhwzOBp3jWV6s/tPhj4yTTVrPc8hTrwD225VbH/s5wuoSKlgwjK4RlvhOVoHOBj1LsJgEQ
	LTM3Q7t/I3CT8Q6+RpN2a/lbsHh2EceuXakgVMdXvyhtKJ+/URekREWYDX2X4Q==
Date: Fri, 13 Nov 2026 09:42:01 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 00/21] Add RTC support for RZ/T2H and RZ/N2H
 SoCs
Message-ID: <avbNWbVYQpNBPVq_@duo.ucw.cz>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GhF6xXngw4E3wACK"
Content-Disposition: inline
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 13 Nov 2026 08:42:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24796


--GhF6xXngw4E3wACK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This series backports RTC support for the Renesas RZ/T2H (R9A09G077) and
> RZ/N2H (R9A09G087) SoCs to 6.12.y-cip. Both SoCs use an RTC that is
> compatible with the RZ/N1 RTC IP, so support is added to the existing
> rtc-rzn1 driver.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--GhF6xXngw4E3wACK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavbNWQAKCRAw5/Bqldv6
8tT6AKCOU/vhWnHqf5KBwVsaXd2R9oC69ACfScvJHB6GbHnucdrsJ6mD8G5xTUI=
=YrHL
-----END PGP SIGNATURE-----

--GhF6xXngw4E3wACK--
