Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A85CC282EC
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 13:27:10 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.52285.1742218019586397517
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Mar 2025 06:26:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=VHF3oxCC;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8686410382F1B;
	Mon, 17 Mar 2025 14:26:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742218017; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=yN3X4OD9l4qXnzq0AO2FA3yjyTuOk1g+MnJuc4qyWzU=;
	b=VHF3oxCCYOEt7RpZVEXO2uTJB7P5DS5EBn7O00XEX9XiT4/JWoD9Unp4Jmk7CycH/wiYPc
	8386jOmxuhldUw10qrNKiEGGb25nENYTcn9wxW92z23mFIRlerzftwfiS0HMeEQNXW2nZY
	QqrXIPSJNS4yXImyQ0W7oTNbc8qWsmYGy3szuLjio6kD1Gta0POjvi4nKvbbE3Wp7SH0yB
	0qshZxqkTMYrTC6xYzgIUyCQ5BhSYeN6PP0s1NuF+12qg7sBMkon59pVs4YvZBHloZMVL6
	8/xaQ5Zj05hr8ZVNGErvzVeJDxzw2uuywdqtcZP179HH1roUmLADtBeMqRj45A==
Date: Mon, 17 Mar 2025 14:26:51 +0100
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	Pavel Machek <pavel@denx.de>,
	Michael Adler <michael.adler@siemens.com>,
	cip-dev@lists.cip-project.org, Ulrich Hecht <uli@kernel.org>
Subject: Re: [cip-dev] Mailing list inventing addresses for people
Message-ID: <Z9gjG+wML3dUdjSK@duo.ucw.cz>
References: <Z9LQ6u3m4LRFTCPM@duo.ucw.cz>
 <80dca55b-9632-46d5-9dab-74dde8ba4424@siemens.com>
 <whqvkav5o3ofm2kubxknu4mpctdtce76jiplvg7aemtn2d3q4g@f7ehpky3zjqp>
 <Z9LkCoI8fcTIPlvq@duo.ucw.cz>
 <e38f2f2f-e51a-4c4d-95b5-f9f952e5fd09@bp.renesas.com>
 <7554ef00-6a86-41a4-837a-183681f9e1a0@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O6iVjeUgjyLeOpKv"
Content-Disposition: inline
In-Reply-To: <7554ef00-6a86-41a4-837a-183681f9e1a0@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Mar 2025 13:27:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18230


--O6iVjeUgjyLeOpKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Indeed. Happened to me in the past as well, but now I have local tooling
> in place that warns here when it checks from: against signed-off-by.
>=20
> Jan
>=20
> PS: Pavel, you wanted to forward a message to me where the sender is
> mangled and the "reply-to" is set to the list.

I can't get you full message. Mailing list is stupid enough to include
secrets (!) in it. Here are important headers:

=46rom: "Quirin Gylstorff via lists.cip-project.org" <quirin.gylstorff=3Dsi=
emens.com@lists.cip-project.org>
To: jan.kiszka@siemens.com,
        felix.moessbauer@siemens.com,
        cip-dev@lists.cip-project.org,
        gokhan.cetin@siemens.com
Subject: [cip-dev][isar-cip-core][RFC] Add documentation to provide project=
 specific signing methods
Message-ID: <20250317112102.609922-1-Quirin.Gylstorff@siemens.com>
Delivered-To: mailing list cip-dev@lists.cip-project.org
Resent-Date: Mon, 17 Mar 2025 04:21:08 -0700
Resent-From: quirin.gylstorff@siemens.com
Reply-To: cip-dev@lists.cip-project.org

I'll get you redacted copy in private email

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--O6iVjeUgjyLeOpKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ9gjGwAKCRAw5/Bqldv6
8jEIAJ4i8f58fjueRt5d9poWd3sS1R4gOQCffda+oU/niVCFcb41SHoPwvrBPPc=
=f0yx
-----END PGP SIGNATURE-----

--O6iVjeUgjyLeOpKv--

