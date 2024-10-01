Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B80CE7D0F
	for <webhook@archiver.kernel.org>; Tue,  1 Oct 2024 10:39:09 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.78352.1727779139944562723
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Oct 2024 03:39:00 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7E6A21C00AB; Tue,  1 Oct 2024 12:38:58 +0200 (CEST)
Date: Tue, 1 Oct 2024 12:38:58 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Message-ID: <ZvvRQmpIm4UHHhGS@duo.ucw.cz>
References: <TYCPR01MB11385E3CDF05544B63F7EF9C1E1622@TYCPR01MB11385.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F3jCqvPWvZFAjzz9"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB11385E3CDF05544B63F7EF9C1E1622@TYCPR01MB11385.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Oct 2024 10:39:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16943


--F3jCqvPWvZFAjzz9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm facing a problem while running 4.4 CIP RT on x86 machines.
> Let me report the things I observed so far.
> It's appreciate if you can look at them once and give me your feedback.
>=20
> =3D=3D=3D Appearance of the problem =3D=3D=3D
>=20
> The following WARNING (and call trace) is printed on console repeatedly
> and very frequently.
> It seems kernel cannot process anything (but still does not panic)
> while the WARNING is printed.
>=20
> WARNING: CPU: 1 PID: 18 at /path/to/linux-cip/kernel/cpu.c:197 unpin_curr=
ent_cpu+0x60/0x70()
>

Can we get full warning in the email (and perhaps link for full
bootlog with the warning)?

It may be as simple as some kind of driver doing kmalloc(GFP_KERNEL)
with interrupts disabled.

If you could enable CONFIG_DEBUG_ATOMIC_SLEEP and try to re-create the
failure, that would be helpful.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--F3jCqvPWvZFAjzz9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZvvRQgAKCRAw5/Bqldv6
8kplAJ9hMbTx7rOEQNrY0OON5kMHQjE6KQCfWpWSGw9ot1ukwbwEPjyXbvbBDYk=
=0ZEV
-----END PGP SIGNATURE-----

--F3jCqvPWvZFAjzz9--

