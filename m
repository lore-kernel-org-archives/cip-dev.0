Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F466C83F1A
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 11:54:42 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.76248.1752494072197562543
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 04:54:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=FwJYrifp;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 000F410397286;
	Mon, 14 Jul 2025 13:54:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752494070; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Ua57k8SVzBPxr1kuMQHC7dLeQX3yGfdXuCECOfcGkwg=;
	b=FwJYrifpkIiELHrI7xOkEfrliHmlNFDWC+FmMWST01omINdtDnShcAmSqaqb8eoUkv//Y0
	9awdf/kw3RguHnECN7xLKE08p8qeODc7FiVr43jp8KZj6p0nXMb0Yc4FdL1lc5qaClz2Pq
	u5OrBc6lhjtBj7qX8chHOQYa+sK2KCswHmEvvLNQKiDt9FJW6S52/szY7qT3rWKhk0N96A
	3lpGf7rTblPbnoUSBZw6yLxpjTnPFjLutNNMW2jdFx+O8BXgb4eoJ71eIbe7MWay3DIQot
	Fh8oktCmATLALcQWxdoMG+/ZgIiBTmVmMtM9UAnz15xWSotLOOSZHg+i4oeo5w==
Date: Mon, 14 Jul 2025 13:54:24 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 12/36] clk: renesas: rzv2h: Support static
 dividers without RMW
Message-ID: <aHTv8F55OADqQUsT@duo.ucw.cz>
References: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
 <20250714101650.80381-13-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Uh12WXz9IwIecf95"
Content-Disposition: inline
In-Reply-To: <20250714101650.80381-13-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 11:54:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19525


--Uh12WXz9IwIecf95
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>   * @width: width of the divider
>   * @monbit: monitor bit in CPG_CLKSTATUS0 register
> + * @no_rmw: flag to indicate if the register is read-modify-write
> + *        (1: no RMW, 0: RMW)
>   */

For the record, I'm not pleased with flag doing what feels like double
negation, but...

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Uh12WXz9IwIecf95
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaHTv8AAKCRAw5/Bqldv6
8h7/AJwOzFzqvHD/XcO9AfzEy9Q1uZfJ/ACY1EO7VmKn+a2eomoSIJlvgLg0KQ==
=/jzx
-----END PGP SIGNATURE-----

--Uh12WXz9IwIecf95--

