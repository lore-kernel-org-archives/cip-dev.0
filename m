Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6976.1794558721936619393
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Nov 2026 00:32:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=elDPwQdP;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 237B31088D5;
	Fri, 13 Nov 2026 09:31:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794558715;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=vaspXAZemcrVoUjTJmVAxPtGoyITNDsI7FwcRus9T/U=;
	b=elDPwQdPSmIvC4I0ves/ldK9/J4CCpjF8+DcfIdRyGSGkvbXmT4cYS3yWafSjF2A5uWNzF
	iuSYyccUR/SoEtMMPgQz0qJ2NF3aqds5Kxu1SwGNqWB7MOtfvDAfeCImGB9cobKlHzhpV/
	9TsTEehCQGynMi+VekorE3rgODeDS6jwunQ88Iftrc4iZwLFO4eZmzpR+rm+y0fOvgx4g5
	QNihGLDgAqAXWRawEGlndmQG+WL7histqBL9euX7nORbv2cowkJdfIzfYSM1eEVeSmLkwp
	cmns6OfrYd5/WkIJmBGizJvREClv65As1KR7Me0YSOAPxI+UuiIjz1w5tgHDfQ==
Date: Fri, 13 Nov 2026 09:31:51 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 00/24] Add Display support for RZ/T2H and
 RZ/N2H SoCs
Message-ID: <avbK92i8jrUrGjan@duo.ucw.cz>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o5miLszid4QUfwe3"
Content-Disposition: inline
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 13 Nov 2026 08:32:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24794


--o5miLszid4QUfwe3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This series backports upstream display support for the Renesas RZ/T2H
> and RZ/N2H SoCs to 6.12.y-cip. It adds support for the VSPD/FCPVD/DU
> display pipeline and board overlays for HDMI output through an external
> ADV7513 transmitter on the corresponding evaluation kits.

I had some minor comments here, but those should be fixed in mainline,
first, so they should not block the merge.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel


--o5miLszid4QUfwe3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavbK9wAKCRAw5/Bqldv6
8pf3AKCypQpqE1e4JGmuQIflq+6tSo0oJACfY/296nd2zgxNec2b6xZgkWbgc28=
=E5dI
-----END PGP SIGNATURE-----

--o5miLszid4QUfwe3--
