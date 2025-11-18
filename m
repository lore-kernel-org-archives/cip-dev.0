Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECF2CEE35C
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 21:17:31 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7755.1763500643149215822
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Nov 2025 13:17:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=XcTowstr;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A514101E0E56;
	Tue, 18 Nov 2025 22:17:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763500638; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=IDTkSNsThXxNCYdiRk04DdYwVcL4OOgFF3ugBpP81Ww=;
	b=XcTowstrWadth6Gb5Lkr4oYIA+UFuzPr/OZbDZemjyIKAiKT6SukfFt90wfuyhHZ+pFFVL
	NSvUoZFL34ki30lFC8sPO2G4aHkG+p6LJbvoTehMdpISI3tw6vLww9z/BAgw3TcozDEkff
	py4P6e08GChSgDcJJcDXME5i1XxBuzEBaaP+5o2MNXfCmYNx610IjiSMPRS47cDXDek/2I
	EUWDpsv+WM5Z78eV1jJSw+KfpbJZv4Uqbu2900vdum/3qpLia+eG8eofII5NtGdSBt+32v
	RFHW0aWUWwbcKttP7diGYs+9MhJr+kPTqNwwh9tGU6vZVfV6DbBNIIbBGfV7Fw==
Date: Tue, 18 Nov 2025 22:17:13 +0100
From: Pavel Machek <pavel@denx.de>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/2] Add RZ/V2H eMMC support
Message-ID: <aRziWZLWjVUBMgo6@duo.ucw.cz>
References: <20251114111343.74438-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YTbRN31D6svzPAe6"
Content-Disposition: inline
In-Reply-To: <20251114111343.74438-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Nov 2025 21:17:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20621


--YTbRN31D6svzPAe6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds support in 6.1.y-cip for the eMMC and microSD sub-boards
> connected via the CN15 connector on the RZ/V2H evaluation kit.
>=20
> Patches were cherry-picked from mainline kernel. Note that only the RZ/V2H
> part of the eMMC patch was backported, as there is no support currently f=
or
> the RZ/V2N SoC in 6.1.y-cip.

This series looks ok to me. I can apply it if it passes testing and
there are no other comments.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YTbRN31D6svzPAe6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaRziWQAKCRAw5/Bqldv6
8ubpAJwLvzPyzrmd5bm4Nz+C9q9s8xi/qwCgoIlUO8pKIoWnfEpXz2abtDYvW88=
=TM3u
-----END PGP SIGNATURE-----

--YTbRN31D6svzPAe6--

