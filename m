Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF22C71135
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 07:22:12 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.24870.1750058525298309828
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jun 2025 00:22:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=VsLJ4QpO;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 81BBB1039EF12;
	Mon, 16 Jun 2025 09:22:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750058523; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=LbEs0OpYXaYUVRNjxH9QIteRPGtXm4eDw7XnUd2WnGw=;
	b=VsLJ4QpOssCiPRpsuNkl4CQ3yh3tXjmoYLMnD1qHfqfgSWtIxyrPiNh/Hhx8bqGnplJqP/
	xVYhTNwjDDlFPabkfDaBqByNFXrdcdYU0L/Uefa5PFo3OpNDgeXpKfXLVPuqo4qR/yjScR
	tfSgphqTQwfH5LdJ6yltOhzGizIZu3BDLfsxPgGX6X3B4Do/Nyse7GxsPJQa24qjDvB4qr
	gQiwRMutU/0a221iJ7FpTYM5M68P9xc6g/ZiWEZ6sKAC+cyI7hYZDuTYD4sOvjfDwsWoF6
	jQ2bPKi5JxZHSwxmO0dTcDdvrovVFCmVP77aAafAVzNudhrVUXPlf0b/0tVKOg==
Date: Mon, 16 Jun 2025 09:21:59 +0200
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: claudiu.beznea@tuxon.dev, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip 00/14] RZ/G3S: Backport ADC support
Message-ID: <aE/GF8igNtO9OsSQ@duo.ucw.cz>
References: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
 <TY7PR01MB14818B847F7102C9CC3CC1DCB9270A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7+S3XgI4et5goDW8"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818B847F7102C9CC3CC1DCB9270A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 07:22:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19096


--7+S3XgI4et5goDW8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I reviewed this series, LGTM.
> I can apply, if there are no other comments.

Thank you, applied.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7+S3XgI4et5goDW8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaE/GFwAKCRAw5/Bqldv6
8rieAKCjgA/XbCOCdW43AxDofZ4Kb2K++gCeNCYZWsKh5EzhEN/F/A4IbRX1jEM=
=r6DU
-----END PGP SIGNATURE-----

--7+S3XgI4et5goDW8--

