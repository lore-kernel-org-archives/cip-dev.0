Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EB8C3DA79
	for <webhook@archiver.kernel.org>; Mon, 15 Jan 2024 19:50:53 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.93631.1705348249055848550
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jan 2024 11:50:49 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 77D891C0050; Mon, 15 Jan 2024 20:50:46 +0100 (CET)
Date: Mon, 15 Jan 2024 20:50:45 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: uli+cip@fpond.eu
Subject: Re: [cip-dev] [PATCH 4.4 4/4] Bluetooth: hci_sock: Correctly bounds
 check and pad HCI_MON_NEW_INDEX name
Message-ID: <ZaWMlWpoE4XLX7Yq@duo.ucw.cz>
References: <20240111190658.153488-1-theflamefire89@gmail.com>
 <20240111190658.153488-5-theflamefire89@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CqwKfvY3DX0fhXOM"
Content-Disposition: inline
In-Reply-To: <20240111190658.153488-5-theflamefire89@gmail.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jan 2024 19:50:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14386


--CqwKfvY3DX0fhXOM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Kees Cook <keescook@chromium.org>

commit cb3871b1cd135a6662b732fbc6b3db4afcdb4a64 upstream.

=2E.afaict.

Best regards,
								Pavel
							=09
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--CqwKfvY3DX0fhXOM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZaWMlQAKCRAw5/Bqldv6
8u1lAKCrfD5n0L3GqQyPf11yAfs1cKzZEgCgqgR5Gy6cn9rbLMOx1nkuWPkoimA=
=jOF+
-----END PGP SIGNATURE-----

--CqwKfvY3DX0fhXOM--

