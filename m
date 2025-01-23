Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DD6C02182
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 21:38:35 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.23709.1737668313768657454
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jan 2025 13:38:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=dLVm5VYQ;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 43ACC10408F83;
	Thu, 23 Jan 2025 22:38:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1737668311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Pe0RfpGruRSbZTisRN48NofVgyv2rGKbt5GvkxJvnk=;
	b=dLVm5VYQk/2Cvfbb4Z9BYpmaDMO53QiKzC7M0c3BG63E6ClBf5hdCsFNpNs/Zqf9U2VVGZ
	993U6kIQiMvpG/rDkuY414zBHnyfnWjnLd43kYXssrRR/00dENpCZzayzX9ropcyB3MTdB
	eToodY+69JGzrpOSRPipfdhF2wevq3HATl+G7HxawGQHIjR1EMhGtiGcMFMBCHnnjYvGKr
	Sx9qnsvsbm8wp647E/3Q4wr4CknnaP3Mj54VI+WUkDTrmypbyGWMtnWLBpNA9xe5tRCYeH
	yxXzrY74TDoI/xoRpAne43cbe4hYB2W0uD1X0JzWbFSWN4rKGGwry1mA7sIUNA==
Date: Thu, 23 Jan 2025 22:38:23 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH v5.10.y-cip 00/16] renesas: rzg3s: backport the RTC
 support
Message-ID: <Z5K2z6Dt+UDRG00J@duo.ucw.cz>
References: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aLX+LHIcNp1Z0zpt"
Content-Disposition: inline
In-Reply-To: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jan 2025 21:38:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17611


--aLX+LHIcNp1Z0zpt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the RTC support for the Renesas RZ/G3S SoC.
> Along with a clock driver for the clock provided the VBATTB
> is included as this is critical for the RTC to work, as it feeds
> the RTC counter.

1/ "clk: Add Sunplus SP7021 clock driver" will need either update or
changed description. For the rest you can add

Reviewed-by: Pavel Machek <pavel@denx.de>

I'll have some minor comments for 10/, but that's best tweaked in
mainline.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--aLX+LHIcNp1Z0zpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ5K2zwAKCRAw5/Bqldv6
8gFoAJ0XNm4eHl3IvckE7JOTRO57tow29wCdFLHqNekZoV0tBJYapbipdOhYilE=
=27sl
-----END PGP SIGNATURE-----

--aLX+LHIcNp1Z0zpt--

