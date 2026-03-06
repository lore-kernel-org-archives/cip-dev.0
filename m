Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D286F01817
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 09:33:32 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.65812.1772789599123619811
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Mar 2026 01:33:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Ty5e17i8;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B537C109D66;
	Fri,  6 Mar 2026 10:33:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772789597;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=JDTRlOuK18czb7/5dyxwWQ9zwcixHkBqUibS3RgyAhA=;
	b=Ty5e17i8+fE8zmNojLFoBDpJeQV3vp1ZaGPR8Gyx8qeQlYfL5hBVXWSQVnWtEQ6+WeS9mP
	ZahE5OkpyBwlnuR27Z13rSz/96Pa97o/Ur/jO7Sg4QfdbYB4J5ZvSTBDkUj1jdeOMSrLk6
	qgLOKSnzuaFPL50URclT9pxod/YVooUUbD7nJxlWAiOVqNCUl/1HTRLCKUiWRkZhKwSd0b
	NuCsG92949y2p8fYgRHZYDS4505kb6CjBo9uO8debM4nVteeaMFWmMWnYW3sKnm/jbbZKX
	b+j/gbwQAwAFHrtYpzxgi93TmfagZWVzfjYUyU41TzrRGFwSvck21hMSGUwM+w==
Date: Fri, 6 Mar 2026 10:33:15 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 0/8] Add RZ/V2N display support
Message-ID: <aaqfW0E9ggkwJlJL@duo.ucw.cz>
References: <20260305153725.19821-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w/nO26s91496XZy7"
Content-Disposition: inline
In-Reply-To: <20260305153725.19821-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Mar 2026 09:33:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22100


--w/nO26s91496XZy7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds display support for the Renesas RZ/V2N SoC and EVK
> board.
>=20
> All patches were cherry-picked from mainline kernel.
>=20
> Note: This series depends on:
> https://lore.kernel.org/cip-dev/20260225121232.129678-1-ovidiu.panait.rb@=
renesas.com/

Similar to 6.12, this looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--w/nO26s91496XZy7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaaqfWwAKCRAw5/Bqldv6
8tf1AKCwrPSP6hg2bQ5rFzlOcT/AHJoN9wCeO2NPr/5qcaBf7YpsyhGMxCdC/uw=
=ky3J
-----END PGP SIGNATURE-----

--w/nO26s91496XZy7--

