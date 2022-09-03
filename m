Return-Path: <pavel@ucw.cz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA72ECAAD4
	for <webhook@archiver.kernel.org>; Sat,  3 Sep 2022 13:29:19 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.3107.1662211753359202199
 for <cip-dev@lists.cip-project.org>;
 Sat, 03 Sep 2022 06:29:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ucw.cz header.s=gen1 header.b=gRzKG0nd;
 spf=none, err=permanent DNS error (domain: ucw.cz, ip: 46.255.230.98,
 mailfrom: pavel@ucw.cz)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3BD3D1C0004; Sat,  3 Sep 2022 15:29:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1662211750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VXNg5qC7CyE+SzNuYJbPeHVY1QrgwC185sG4koob1fI=;
	b=gRzKG0ndTN6yuWxAWLAenLATWkCjTcBvXMYIuOQ7waHRrkowx3tEPE7A4MAvUj4uY2ycBm
	17jub0jIc9QtmbNVQvcCu0NTX1S1kJdfeNmJgJqV44DhBHhq9aDYjuwLZCKaVXzsPaEy9m
	+/LYXbaWVAEb1En7JmdcaSxYWRKjJMI=
Date: Sat, 3 Sep 2022 15:28:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/25] Add more support to RZ/G2UL SMARC EVK
Message-ID: <20220903132855.GA4305@duo.ucw.cz>
References: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 03 Sep 2022 13:29:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9459


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add CANFD, WDT, USB2.0, AUDIO, Serial NOR Flash,
> OSTM, ADC and RSPI on SMARC EVK based on RZ/G2UL SoC.

Series looks okay to me. If there are no other comments and it passes
testing, I can apply it.

Best regards,
									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYxNWlwAKCRAw5/Bqldv6
8v0IAJ4uxE9Wj+aVFzjNuLZyUCv0VKBAugCgvqaelU3fDq4bJMKwCwWYZhhmvfc=
=/4fZ
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

