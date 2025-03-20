Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED8EC28B30
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 11:50:18 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.5512.1742471409876834443
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Mar 2025 04:50:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Br95bXZP;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 98C94101E9087;
	Thu, 20 Mar 2025 12:50:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742471407; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=06EWAYPnlMamyTtLX77E5k7tE30Q5ne+369/kngYgW8=;
	b=Br95bXZPvd0JvfkkenAeVfqM+xgBvp7DQKfw81u72Y2Dr3jaOzBis/4EuG0e0JUORDW1+N
	C5Tmvu4/5UueHaMRUEairqYP7SjHYeMsvNJ69at1V4nG7wfFIVDEt3NPzR6Tv/mCNBvlSl
	hJoPRCTzaoCv9zi/bHtaFYgzazo1fxNf2fW8ehoudi57KHEdzKWkE1R8H2JY/qk4gNsAbD
	DnQ+vpOoNwRiOlzIquvQpHNlre5uAGOfdbwyUSI38jrpDnjq58OjGNo/asKL5L1xnnE/l2
	hvNsC9Zv4zAEeQPgMaYwdtICB5lIxzL9uOWKC062CX7827fB9pZeo55WrXLLow==
Date: Thu, 20 Mar 2025 12:50:02 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip v2 00/12] serial: sh-sci: Add support
 for RZ/G3E serial driver
Message-ID: <Z9wA6lxJxbodUrO6@duo.ucw.cz>
References: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
 <182E2D5440856AF6.20726@lists.cip-project.org>
 <Z9qcRBPx38dI4QtV@duo.ucw.cz>
 <Z9qdLZ6MSVEaMpj0@tom-desktop>
 <Z9vns4WDhX0uvZ2N@duo.ucw.cz>
 <Z9vqHMBvy1O1qB8i@tom-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2BLYgYcvkCuF9yo/"
Content-Disposition: inline
In-Reply-To: <Z9vqHMBvy1O1qB8i@tom-desktop>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Mar 2025 11:50:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18295


--2BLYgYcvkCuF9yo/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Thanks for this.
> I'm going to prepare next series with a minimal support for RZ/G3E then.

Ok, thanks. Please note we'll need 6.12 version at this point, too.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--2BLYgYcvkCuF9yo/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9wA6gAKCRAw5/Bqldv6
8gSmAJ4gezao4b6xk3xXJW/4PyumgywhPACgnXsCGtBzi8gua6XSRqD66IDgbtk=
=ZR5P
-----END PGP SIGNATURE-----

--2BLYgYcvkCuF9yo/--

