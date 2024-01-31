Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1DCC47DDF
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 11:17:16 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.11725.1706699826671138551
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jan 2024 03:17:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 62CD91C0079; Wed, 31 Jan 2024 12:17:04 +0100 (CET)
Date: Wed, 31 Jan 2024 12:17:03 +0100
From: Pavel Machek <pavel@denx.de>
To: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de, biju.das.jz@bp.renesas.com, yuki.saito@toshiba.co.jp
Subject: Re: [PATCH 1/1] clk: Fix best_parent_rate after moving code into a
 separate function
Message-ID: <ZbosLzzxqI4FyNpq@duo.ucw.cz>
References: <20240131135604.1488157-1-kazuhiro3.hayashi@toshiba.co.jp>
 <20240131135604.1488157-2-kazuhiro3.hayashi@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TUl6VHq0TSI5kQnB"
Content-Disposition: inline
In-Reply-To: <20240131135604.1488157-2-kazuhiro3.hayashi@toshiba.co.jp>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jan 2024 11:17:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14557


--TUl6VHq0TSI5kQnB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Is there something wrong with the time here?

Date: Wed, 31 Jan 2024 22:56:04 +0900
=46rom: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
On Wed 2024-01-31 22:56:04, Kazuhiro Hayashi wrote:

pavel@duo:~$ date
Wed 31 Jan 2024 12:15:57 PM CET

This will "fix" itself in two hours, but I wonder what went wrong
there.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--TUl6VHq0TSI5kQnB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZbosLwAKCRAw5/Bqldv6
8kvYAJ9rKJzzjhgDYyv6jrrXxf+XpYpT3QCeKhZidQUsYAA1oEVI9iA47Yan1dc=
=E0Tz
-----END PGP SIGNATURE-----

--TUl6VHq0TSI5kQnB--

