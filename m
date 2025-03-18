Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22403C282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 19:47:37 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.4549.1742327253801613113
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Mar 2025 12:47:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=VIh3sGQ8;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6CCA310210BE7;
	Tue, 18 Mar 2025 20:47:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742327251; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=zoHeYM8nPDCc9v9MS0Qoal39ASQrUsVd1MgZX50GSxE=;
	b=VIh3sGQ8xYDRHQipr2yPS0fjB2067UDttHspLbBcKjwlCLb1NOiNqaDhvw1QdzBZ5F3rHu
	UpGWGwJlT9ndVytSth3erdR6077Bwko8bcJj0gxIIRrEF6RV+1JAFWRSU/lC7IKiFpXCYQ
	Ilqq4AhJV7iuHk4IrFbvcTNYus3+84eQL5ckkKsu+DIvXvCqUCVPrzmrOEA+GZnAnxHzke
	2nhLCeEpnbKUlGXlsrqLJlMjxDlIp7UEa9KMVYpKEQz9eEeva7cA7GcQcqOfWGp8NX3I+Q
	SDspeDA0wqylGXhV4TPczHmPm+u/jn4GwDI3MjP7iCfiGITHOxqsR/6HJUQIYg==
Date: Tue, 18 Mar 2025 20:47:25 +0100
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
	Chris.Paterson2@renesas.com
Subject: Re: v5.10.234-cip57-rt25 (rt127)
Message-ID: <Z9nNzWKbo/8hY4p7@duo.ucw.cz>
References: <Z9kv4aijWXNBDCrj@duo.ucw.cz>
 <1998774e-bfde-42fd-a4b5-ccb3bdd668d4@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sxLWUOWP84HThmpl"
Content-Disposition: inline
In-Reply-To: <1998774e-bfde-42fd-a4b5-ccb3bdd668d4@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Mar 2025 19:47:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18241


--sxLWUOWP84HThmpl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > New realtime trees should be available at kernel.org.
> >=20
> > Trees are available at
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-5.10.y-cip-rt
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-5.10.y-cip-rt-rebase
> >=20
> > And their content should be identical. There are also tar archives, at:
> >=20
> > https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
> >=20
>=20
> "[ANNOUNCE]" tag missing - did you change your "scripting"? ;)
>=20
> Seriously, part of consolidating the release workflow is unifying the
> announcement emails. These inconsistency force users into manual filter
> modes.

Sorry about that. Mails are really difficult to scripts.

For tracking news, I find git quite good. Newest cip release can be
queried using=20

git remote update
git log origin/linux-$BR.y-cip -- localversion-cip

Similar code works for -rt (and stable).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--sxLWUOWP84HThmpl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9nNzQAKCRAw5/Bqldv6
8j/WAJ98e+gAvxdpnNnQYYmwDNDeg8uJ+ACeNEM/Ln41MWGexsuTriuRbZx/Goc=
=q5FR
-----END PGP SIGNATURE-----

--sxLWUOWP84HThmpl--

