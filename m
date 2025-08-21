Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ECFCA0EF8
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 11:15:11 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.6915.1755774905517963319
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Aug 2025 04:15:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=AsvKltCZ;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 86B591038C11E;
	Thu, 21 Aug 2025 13:14:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1755774903; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=8Bcg8hwkLh4GSbPqq422VxisYfH0eKhps0OO7YdPVCw=;
	b=AsvKltCZJ3CkDjqtgfm+R/sc/0Y+FbqECnrwmdSKRlmB9fs3Cf9j1zmQ9dut/tn0z8j0px
	6NaDV4VXx1uvXnhjg2wfSCcq29w1P7x94Zt1krEKgne0I4lW2wbM81McfNaOC8y2oslXX0
	qEkxaMk63ySQWO9vkAmRxxMyXMx4cYFYqZ1htaXKAjT8fxbAm5uynpSFuKE9R0/rsGTLCO
	HoyW1FRhB85x3+eHd5DuAVbt0X+HKTPHiDFDJZLuhpj1mnpHX/hnnAS13fyd0Rujfp/KAP
	9CUpeQCP6XyXiy4QVryjqfr3BVNcqZxD1PqwxNboNWXRNLhMDPjor8+9iDIUnQ==
Date: Thu, 21 Aug 2025 13:14:57 +0200
From: Pavel Machek <pavel@denx.de>
To: biju.das.jz@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/22] Add RZ/G3E XSPI support
Message-ID: <aKb/sTvmvET1jdS4@duo.ucw.cz>
References: <20250820083855.6337-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NsQ8PIhnrgT8j/fR"
Content-Disposition: inline
In-Reply-To: <20250820083855.6337-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Aug 2025 11:15:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19933


--NsQ8PIhnrgT8j/fR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add RZ/G3E XSPI support to cip-6.1. Also backported
> clk and irq patches.

Thank you, series looks ok to me, and I can apply it provided it
passes testing and there are no other comments.

Reviewed-by: Pavel Machek <pavel@denx.de>

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--NsQ8PIhnrgT8j/fR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaKb/sQAKCRAw5/Bqldv6
8i9YAJ9wS4J55EO1JaXNHNjAFBnJMQjqJwCaAtSMze4exoSzDTEySJguzlsUNQI=
=KNJU
-----END PGP SIGNATURE-----

--NsQ8PIhnrgT8j/fR--

