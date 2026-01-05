Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BA9FA3724
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 11:45:10 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.62263.1767613509500265385
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jan 2026 03:45:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=UURh6PQ8;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8219D10014B;
	Mon,  5 Jan 2026 12:45:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767613507;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+TGowvD8RNhoh9MPKTqFw4sajx49UFavMj/frWf81p8=;
	b=UURh6PQ8m/1c9tTyFkKhY+ZyQ3oY5sHJSgZWhlBLal+Gqq3bHmtyiLqQul4blf8b86hOgG
	E3vA3D//KCgAwcZUxwG43QhI7ztmhNtNgy99bZrDVrmSwo1Bgc7sKyVPZUioHVvq8XzBMi
	Gp1pJeF3pKoEjkwsF3Xcg77p2ScGCBgn/2LUgkpsnszujGIE/OJOje/yDlPVCLYEbO/os5
	vYL0gF9AkoOEdh/iRXpZvqTDSpxfrZEK7khp8/qv8toC0v1GuR6q93XT0fsswo3Q11+BBD
	cI+BrQ/ciddfevNSxx6hzTQtJASBL8sgbLYA9f4+ve6yqiQZqI2P/TiJ5JvUgg==
Date: Mon, 5 Jan 2026 12:45:04 +0100
From: Pavel Machek <pavel@nabladev.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] Add I2C support to RZ/T2H and
 RZ/N2H SoCs
Message-ID: <aVukQHvWZ1H8C2uF@duo.ucw.cz>
References: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+tXLRqqNDB/tW5pd"
Content-Disposition: inline
In-Reply-To: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jan 2026 11:45:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21312


--+tXLRqqNDB/tW5pd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add I2C support to Renesas RZ/T2H and RZ/N2H
> SoCs and enable the I2C support on the EVKs. Note, all the patches have
> been cherry picked from upstream kernel.

I had some nit picks here, but those should be fixed in mainline,
first, so they should not block the merge.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--+tXLRqqNDB/tW5pd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVukQAAKCRAw5/Bqldv6
8mxIAKChio0lkpFr1WlLt66gT2cv0I+vtQCfQNHWdMgmg78AnVha8PC+e1I6ch0=
=4hzm
-----END PGP SIGNATURE-----

--+tXLRqqNDB/tW5pd--

