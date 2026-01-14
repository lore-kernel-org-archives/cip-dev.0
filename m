Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0235DD29FF0
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 11:33:34 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7986.1768390407023819749
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jan 2026 03:33:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=WrlBgScS;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A764310B425;
	Wed, 14 Jan 2026 12:33:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768390404;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=XZVvkUOhsG4AmuH8hDpCHrBkfHCLpXPlEWY7ZxqqUWs=;
	b=WrlBgScSZts4POHfV7xxUp2XUO/L2WbhKI5Yo7H7nXQMWoFtmikSA5LBWggLvPvXefbmUD
	1+6dGED/Y8h9ktLwb3pr87/OvsSb1gM5C3PwvBDnNBefKTpDhn6W6htrFzQIzEhg14BCs7
	3ZU0+DhUlt52qiXJyU62vQ/nNMbf9FYqm9W6149qO9YvdKNfjdRfZgJSTIU/qtZHgGOPRg
	ENplpUlwhkTPR3RTdE8p6WgxXXBiy3tvanL1QbAAOfflnVN9vr2ZlkwMM8gEfotj1TDpmd
	57/7y+2tjT1tuLZDp4lH6JgPrLs6tYbRrlR1B6wKLlEHzlDbQfIl2g6AkA8b1Q==
Date: Wed, 14 Jan 2026 12:33:18 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.12.y-cip 00/19] Add I3C support for RZ/G3E
Message-ID: <aWd+/s/T0+w3Do9p@duo.ucw.cz>
References: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0WkxiptkP8W/wz19"
Content-Disposition: inline
In-Reply-To: <20260108093023.489513-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jan 2026 11:33:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21539


--0WkxiptkP8W/wz19
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds I3C support for the Renesas RZ/G3E SoC into
> linux-6.12.y-cip kernel. This includes also nxp,p3t1085 I3C backporting
> for testing purposes.
>=20
> Tested using the NXP P3T1085UK-ARD connected to the RZ/G3E SMARC SoM
> via the RZ/G3E SMARC BREAKOUT board.

So I applied first 13 patches from this series. I added Nobihuro-san's
Reviewed-by, since he sent that for 6.1 version. I hope that's okay.

Thanks and best regards,
								Pavel
--=20
In cooperation with Nabla.

--0WkxiptkP8W/wz19
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWd+/gAKCRAw5/Bqldv6
8nE2AJ40f5oYimfg9xQFWGUEyvpoQHYJEwCggVVBEvbSRVt+EkrgGARxyejvOy4=
=wqiO
-----END PGP SIGNATURE-----

--0WkxiptkP8W/wz19--

