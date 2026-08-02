Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21547C55162
	for <webhook@archiver.kernel.org>; Sun,  2 Aug 2026 15:48:02 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25568.1785685679238090801
 for <cip-dev@lists.cip-project.org>;
 Sun, 02 Aug 2026 08:47:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=NVMhdAnB;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 669D711BCA1;
	Sun, 02 Aug 2026 17:47:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1785685672;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=rSj7dKkosCgdwpVLPBw3/YWwqR5gKspiBAhZpJlznMc=;
	b=NVMhdAnBYqL0lTwugAfxIYugzpUq7fXPYHWH6VHlmC4AYlJ5AX00XBOKP6GazB0vePoxi2
	YTZZ54Ox57P0/PjVO4ZMAv4AVahzssi3VrFXlUiNe93QuZiEIQdEq32kMEnhe2IRiuaTH7
	MJ0bMyXMOc4DDxDkRxc6pPKeas1yLEIi6ALm8tf/mqUslRV2NOqx+Uui+eWPfWDHVHhCW4
	+IrxHhmwf0vXlqh3tqelz2E4O6NZEIacku6jVh67OpTFOiejU/00mMjiqmqnrlFsiEvJ/o
	y4rIBb9xwAQLFmjUiKIMv12wEk+I1hJZExkzf8BCR85WPYtWah5cwMH6M+cQZA==
Date: Sun, 2 Aug 2026 17:47:48 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 00/19] Add RZ/G3L I2C, WDT, Audio support
Message-ID: <am9mpF90lb7xIyg5@duo.ucw.cz>
References: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aw3GmCRRx61pnqKW"
Content-Disposition: inline
In-Reply-To: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 02 Aug 2026 15:48:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23847


--aw3GmCRRx61pnqKW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Hi All,
>=20
> This patch series aims to add I2C, WDT, Audio support on RZ/G3L platform.
> All the patches in this series are cherry picked from mainline.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--aw3GmCRRx61pnqKW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCam9mpAAKCRAw5/Bqldv6
8sfHAJwOwPBWRx4QJi8/PsZeHfKc7joy8QCeOyd29sOub3ej98IhotkEn2fGhEI=
=3j3x
-----END PGP SIGNATURE-----

--aw3GmCRRx61pnqKW--

