Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62F9C3ABAA
	for <webhook@archiver.kernel.org>; Fri,  2 May 2025 10:19:27 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.15826.1746181164709682969
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 May 2025 03:19:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=DIqVbSUj;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7678910267FBE;
	Fri,  2 May 2025 12:19:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746181162; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OqNM1WJXeRbDYTb+XCGZDpJOZ5winGgziTp4vKwJsdU=;
	b=DIqVbSUjPvdqVnGTHoWmtUzZozPYBMGgUVS9/eEiESke1uRAIffFioceetMJ1pNuzCUc6F
	9aKnG6Was5aLEMf+E/4gD0zn7Pe56k5xwTlwSL5ZPet4GRUCGlQAAeV6JbvBTcnposxq6J
	NgNac+j5Q3Ms9iYjfW/lDOQzeAZykAftgnz+iMwUDXrVwnrwjdoQ3y/6EUd51WoPqyNU5t
	ySzATta8dg8r9J0x75MLQyFSffKquDifMJG/25yCVeDhNnobtpUieydvzBsQEIWDDrqXN/
	8MiurPuyHoqUrd6oiHs+mKXBvcbVzUIjxnsSzMK7axB/5NFr/09DdB9d8YU5NQ==
Date: Fri, 2 May 2025 12:19:15 +0200
From: Pavel Machek <pavel@denx.de>
To: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	cip-dev@lists.cip-project.org, bigeasy@linutronix.de,
	tglx@linutronix.de, rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 4.4 4.9 v1 0/2] Fix repeated WARNING in
 unpin_current_cpu()
Message-ID: <aBScIx13vT5c1i8V@duo.ucw.cz>
References: <1738629964-11977-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RB7aPg18wey2WPOX"
Content-Disposition: inline
In-Reply-To: <1738629964-11977-1-git-send-email-kazuhiro3.hayashi@toshiba.co.jp>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 May 2025 10:19:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18759


--RB7aPg18wey2WPOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is a patch series for v4.4-rt and v4.9-rt to resolve problem that
> WARNING in unpin_current_cpu() happens repeatedly while kernel is booting.
> Please see commit message of the second patch (2/2) for more details about
> the problem and how it's resolved. The first patch (1/2) is a preparation
> for the fix (2/2), considering compatibility issue in future updates.
>=20
> As the both v4.4-rt and v4.9-rt have been EOL already, it's not expected
> that this series is applied to the branches anymore.
> On the other hand, the Civil Infrastructure Platform Project (CIP)
> has been maintaining its 4.4 SLTS RT kernel[1][2] based on v4.4-rt,
> and needs to fix the problem above by this series.
>=20
> It is much appreciated if RT experts could take a look at the series
> and give feedbacks about its way to resolve the problem, which is
> based on the same approach as changes happend around v4.14-rt.

Thanks for patches, and sorry for the delays. 4.4.302-cip98-rt55 is
out, and it should contain your fixes.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--RB7aPg18wey2WPOX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaBScIwAKCRAw5/Bqldv6
8r6uAJ0Wfp1mrQfZbs5JoLLK1Gy932Kv/ACeN4n7KoD7fon814lWlDROkejw4Do=
=szFd
-----END PGP SIGNATURE-----

--RB7aPg18wey2WPOX--

