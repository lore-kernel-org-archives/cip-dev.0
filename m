Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292D0CD4F54
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 21:07:53 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31042.1779916071579989894
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 14:07:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=UDDfQ4SW;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 94D281169FD;
	Wed, 27 May 2026 23:07:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779916068;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=slyyz/yTAOJWTANy99NLHSs/7+HwROZxS4xg3Is7A7U=;
	b=UDDfQ4SWSlzSdUw44cBsh35+ZS+ojq3I36A1eezySq2fqsrIjcPsH+5gFVH7IwgiPkrD88
	jTrpL4cNfBp0FdFlcPE2n3eB4HGpJfLkpzS9/mhKuA471jEXLFb3I/Kvlo/RM9sHy0dn6W
	ynwDgakPAxrVHAXvwLux17HAK9+wN1MP7VWfMOT0dGmNFAkvVqbhfBqC2jdKhYHMir7y5K
	NTWf7uN/3AAL2PTXeqFIK3IMCb6Gxfhazis31t5vE4eU6DP30p4Sd1fBdZNBGHldAVJer4
	MFx6zY0tziXdOyD1VveALPaRBqpgIhHhNFP4mdpHCD6jb9gnDhhrsCLPa2vGGA==
Date: Wed, 27 May 2026 23:07:44 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip] i2c: riic: Implement bus recovery
Message-ID: <ahddIAv7e7UneixV@duo.ucw.cz>
References: <20260527162119.52245-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FHIEFeEwgBAjFAOl"
Content-Disposition: inline
In-Reply-To: <20260527162119.52245-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 May 2026 21:07:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23026


--FHIEFeEwgBAjFAOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI!

> commit ba9e1b5254783528e10b45b1f0fb40e21f4ff88a upstream.
>=20
> Implement I2C bus recovery support for the RIIC controller by making use
> of software-controlled SCL and SDA line manipulation. The controller allo=
ws
> forcing SCL and SDA levels through control bits, which enables generation
> of manual clock pulses and a stop condition to free a stuck bus.
>=20
> This implementation wires up the bus recovery mechanism using
> i2c_generic_scl_recovery and provides get/set operations for SCL and SDA.
>=20
> This allows the RIIC driver to recover from bus hang scenarios where SDA
> is held low by a slave.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply this if it passes testing and there are no other comments.

Best regards,
                                                                Pavel

--FHIEFeEwgBAjFAOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCahddIAAKCRAw5/Bqldv6
8icVAJ9lxguTX9v9UQus+wjOCHK+G10rrwCgn8v8khHmXKymWdMoVQNOn6eShmI=
=trc4
-----END PGP SIGNATURE-----

--FHIEFeEwgBAjFAOl--

