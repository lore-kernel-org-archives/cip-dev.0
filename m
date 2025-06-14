Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3880CC7114A
	for <webhook@archiver.kernel.org>; Sat, 14 Jun 2025 19:30:39 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.16070.1749929431922759488
 for <cip-dev@lists.cip-project.org>;
 Sat, 14 Jun 2025 12:30:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=iYSRaliQ;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9415D10272092;
	Sat, 14 Jun 2025 21:30:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1749929429; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OEbF7FXSO4LNLDTPvK0zi68Zp7B4SdRrEOkx0m1TKgI=;
	b=iYSRaliQnE117J710CZX5QGwKgn0Gtd2v78ehrBrQYVEJnLQcSMsQuS42H4gU49cSgbuUx
	IUGk0Uf12jTvRf0DcsdEueXpMsWT/1NC0UMmd6Pdx6GXiRnu+IxnqIHOhY6Va2fvmDCBRB
	fdDcn1VtlEA8UK4Ca+gqDCKxDT9hhQATP89mrc70p0ZqhQUK/ck1OztpDwKDUQGnrrffW4
	kTkiVSzf/86XsZWUYt9FzG734zBEZjdMQ1GGmtEMAo4Ft7QLgnjyZ1sdRjtElPN4ak/XFe
	07AHUxxCH9QYbdvGTYtY/67ZLYSlzRCUc2NjO8x5AgCRnkyIcMALIFJ74LroZA==
Date: Sat, 14 Jun 2025 21:30:26 +0200
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.1.y-cip 00/14] RZ/G3S: Backport ADC support
Message-ID: <aE3N0nozpktp7jAy@duo.ucw.cz>
References: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP7jsC/SZhAik6JP"
Content-Disposition: inline
In-Reply-To: <20250613101537.279131-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 14 Jun 2025 19:30:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19088


--JP7jsC/SZhAik6JP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the Renesas RZ/G3S ADC support to v6.1.y CIP.

AFAICT 1/ is different and 4/ and 6/ are only for 6.1 and 6.12.

This looks okay to me. I can apply it if it passes testing and there
are no other comments.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--JP7jsC/SZhAik6JP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaE3N0gAKCRAw5/Bqldv6
8tV/AKC3I2MyO5b1NeGfPCVVRLWQ+opdPACfSAV0rmG19dba5bQHEWvjpOj/QA8=
=QETT
-----END PGP SIGNATURE-----

--JP7jsC/SZhAik6JP--

