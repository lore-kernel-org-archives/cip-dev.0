Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2689.1794216140925952776
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 01:22:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=HYhyi8Gd;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9888310AC9D;
	Mon, 09 Nov 2026 10:22:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794216134;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hLv0m97Cp/9Pcb7y5O+52RXkzDOFH/jpeUy0dm/XD6g=;
	b=HYhyi8GdBT2RYq99NBdwGKaJGuQTBR+je/9ecK53hA9qGCwqhJc4RvBWeKIlEbV46KrcuB
	4g+ypFbP4MFrMJ2OItL9gTCMz/FxwNpH2kO/EX7NXWV5OiqPBHFaqUypYaWQjoQ4H/usI9
	0VqEJ/ymimoqw0qJo7H5wz4oekMjZNL/5n4hNvaRNES3kc7k8laqpEn6UuWoB3/wPQoTBg
	5F1QSWHa/51XdXi10DbESXYava8gPv+ksLladyn60qZPc79fFJiB4lrsDaUpsVD8aATqQa
	LqsVDkHmge/QJEZv0I+ERp247o4Jd9HJeVq8OlWXCd8IhPL6nScBECnMTkq/Mw==
Date: Mon, 9 Nov 2026 10:22:11 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: pavel@nabladev.com, cip-dev@lists.cip-project.org, uli@fpond.eu,
	biju.das.jz@bp.renesas.com, tommaso.merciai.xr@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/5] Fix CVEs related to patches
 backported to the CIP kernel
Message-ID: <avGQw1hZybt3lR9a@duo.ucw.cz>
References: <1794209954-6205-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vQ/iL/JC8BcmjImO"
Content-Disposition: inline
In-Reply-To: <1794209954-6205-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 09:22:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24689


--vQ/iL/JC8BcmjImO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Alex Bereza (1):
>   dmaengine: xilinx_dma: Fix CPU stall in xilinx_dma_poll_timeout
>=20
> Claudiu Beznea (2):
>   i3c: renesas: Check that the transfer is valid before accessing it
>   i3c: renesas: Fix out-of-bounds access for newdevs mask
>=20
> Onur =D6zkan (1):
>   clk: devres: fix cleanup in devm_clk_get_optional_enabled_with_rate()

I don't think attacker can trigger the next one, looks like it is just
a robustness against invalid dts.

> Tzung-Bi Shih (1):
>   watchdog: rzv2h: Avoid division by zero

Anyway, patches seem good, but I believe we should get them into 6.12
branch, first.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
								Pavel

--vQ/iL/JC8BcmjImO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavGQwwAKCRAw5/Bqldv6
8nHtAJ99++jdnkdZ7Z6DFXazIAiP3glR3ACgqt3iCrkqgSL1h2piN2c8dOYzRH0=
=AQxO
-----END PGP SIGNATURE-----

--vQ/iL/JC8BcmjImO--
