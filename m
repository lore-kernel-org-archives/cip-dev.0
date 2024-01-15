Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A68C3DA79
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 20:05:53 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.93478.1705349146598740216
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jan 2024 12:05:47 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3325C1C0050; Mon, 15 Jan 2024 21:05:44 +0100 (CET)
Date: Mon, 15 Jan 2024 21:05:43 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: uli+cip@fpond.eu
Subject: Re: [cip-dev] [PATCH 4.4 0/4] Bluetooth: hci_sock: Fix possible OOB
 write in create_monitor_event
Message-ID: <ZaWQF/fWwQSvfz2H@duo.ucw.cz>
References: <20240111190658.153488-1-theflamefire89@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6FC4tW5PD3zbRacA"
Content-Disposition: inline
In-Reply-To: <20240111190658.153488-1-theflamefire89@gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jan 2024 20:05:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14387


--6FC4tW5PD3zbRacA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Series looks ok to me (with missing "upstream" annotation). Uli, will
you handle this?

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6FC4tW5PD3zbRacA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZaWQFwAKCRAw5/Bqldv6
8njiAJ9Hq5YXxNXIpmgmfybYzZikqXMFRwCgrLsoLEbZ8E91Wyx5Y+dglqieHq0=
=C8hi
-----END PGP SIGNATURE-----

--6FC4tW5PD3zbRacA--

