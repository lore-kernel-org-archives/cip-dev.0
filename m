Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB7ED5E143
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 12:00:35 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20638.1765886425250434465
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 04:00:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=iAuGhBmU;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 48402106680B9;
	Tue, 16 Dec 2025 13:00:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1765886418; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=oQwK5ZHWOhZ1JAAPqRx0Y/h2BmWapxAHwMoIldxGrxY=;
	b=iAuGhBmUVB0R/I1dB52F/RYHUGEtMcMN9askZAIdtolKddiHK9PJrVozf1fBTL7exEqswl
	x8u39hXGRAXaOZRngFE6qkZDgTLz/9hfQG4yvaNKk07odTteWtL5ih8+x+JGkbtvXlhPb4
	avKS8dhpALo54vVFV/nzyse8uzpbgLfiQQdBqj4BZcGsx6nshEGYU8uJdslO9zQAknKxFu
	MWg8LYgaHAg633Avo9kDGc5xull/Baj602mYvoEZlS+safe7/+fM6UGTz5nc/xlbkXziDe
	GGsYAyF0CYGw8MmxpaRu5Y6pUVBvl7sHTPkXcMS1bbpPF5NcxWj5jCHznwx/Eg==
Date: Tue, 16 Dec 2025 13:00:13 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip] net: stmmac: dwmac-renesas-gbeth: Add PM
 suspend/resume callbacks
Message-ID: <aUFJzat5zuhxSBiK@duo.ucw.cz>
References: <20251214120313.3924-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qdxwpJ9vUMaPD+T+"
Content-Disposition: inline
In-Reply-To: <20251214120313.3924-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 12:00:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21082


--qdxwpJ9vUMaPD+T+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add PM suspend/resume callbacks for RZ/G3E SMARC EVK.
>=20
> The PM deep entry is executed by pressing the SLEEP button and exit from
> entry is by pressing the power button.

> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Link: https://patch.msgid.link/20250717071109.8213-1-biju.das.jz@bp.renes=
as.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thank you, applied.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qdxwpJ9vUMaPD+T+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaUFJzQAKCRAw5/Bqldv6
8hqvAKCm++H2kDjd4oQ/McpagqkiSmI+/ACgoV09zYFiljBKkVBaUYlE3Vkuino=
=+mJu
-----END PGP SIGNATURE-----

--qdxwpJ9vUMaPD+T+--

