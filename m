Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2636ECFC51E
	for <webhook@archiver.kernel.org>; Sat, 22 Nov 2025 09:01:49 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6199.1763802092156127586
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Nov 2025 01:01:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=V7IpSlso;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D48410092103;
	Sat, 22 Nov 2025 10:01:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763802089; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=87zjz81e9p1ruWyui5wq3reLvhMUNE6AzYA7GICqp/M=;
	b=V7IpSlsoxP0ETsl8tewI/3knVs1yyYkq4set+Jk/+ume6QJ9MI2vF85RYwCDTraPYLbS3M
	zWiHSmraAHtqqo9XDjQydasUmRhcm21iwPgIITD4yRyHKRqXYWxn96em0xqF6EZwwfQHyU
	D/2jT+u1YSD9WXpfyUBDOcifQchyti0iAUAizznseZoPlmg+w/gNPqer4c5oU2nE6cLxnX
	4pCGZOhfQEEPbebTjG/bLsN8DdXRMJYYak+/PcOXC5dJFo6R7iqIFJ432smWN2foUvi2A5
	82SkM6gzWVCcjI8OxjcDXtiS9webucwL8VkW+Gw0oXKVUh1UOO1IdymyFpOejg==
Date: Sat, 22 Nov 2025 10:01:24 +0100
From: Pavel Machek <pavel@denx.de>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 0/6] Add RZ/V2H XSPI support
Message-ID: <aSF75Hal2wUi4FX3@duo.ucw.cz>
References: <20251121080737.20611-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LJYwhuwh2gZV4r7a"
Content-Disposition: inline
In-Reply-To: <20251121080737.20611-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 09:01:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20684


--LJYwhuwh2gZV4r7a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds XSPI support for the Renesas RZ/V2H SoC and enables the
> MT25QU512ABB8E12 flash device used on the RZ/V2H EVK board.
>=20
> Patches were cherry-picked from mainline kernel.

Thank you, applied, along with "Add RZ/V2H USB2.0 support" series.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--LJYwhuwh2gZV4r7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSF75AAKCRAw5/Bqldv6
8h63AKCHoX508fw4IG+PYX7MciCEH/p38wCgruX+Cs7sfw0ZXEtQReuJ1agDpD0=
=kZtl
-----END PGP SIGNATURE-----

--LJYwhuwh2gZV4r7a--

