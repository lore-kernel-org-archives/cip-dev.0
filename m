Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8773FEA4FB9
	for <webhook@archiver.kernel.org>; Mon, 23 Feb 2026 12:47:05 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34352.1771850818774091535
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Feb 2026 04:46:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=dfZXawb9;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5707F10E6A9;
	Mon, 23 Feb 2026 13:46:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1771850817;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=3S2+bgVEwHy5hgN1jqOQa3oOVX3c6rUVbwzywEjFTuM=;
	b=dfZXawb9UjqnYT+5ezws3fVc6UZdzPzZMlWoQefJ9QVhK++v5bp6PwtYzz77zoFNtaPTvS
	4QWCCjbB7uiARTxmcGqo6SC1cSksAyQhsZVykkVjPxucLVah0AH7k/lb3lvC1D1Bfhrvxg
	WfohMlN3FSuZ0+7vRTUhNV++04jJn6hvUfige6cltkHa2owykf/2rteFQJLlnIZdvG++BZ
	qlH2yMSrIBjWsA5JnbuwbsQxGWuatCPNOzgEbrU0pGjnARS+eYi7pcjBBKuont/j99dsh6
	QzsUw32mQTP5WEsGKp0GYiEV3VUidHOXsg8JRL1rwY6n9UpORrtqE8gWShdlEA==
Date: Mon, 23 Feb 2026 13:46:52 +0100
From: Pavel Machek <pavel@nabladev.com>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/4] Add RZ/V2N GPU support
Message-ID: <aZxMPILbB/pLPwH/@duo.ucw.cz>
References: <20260223102738.119897-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F+Wjsl9S06XdXR8J"
Content-Disposition: inline
In-Reply-To: <20260223102738.119897-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Feb 2026 12:47:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21917


--F+Wjsl9S06XdXR8J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds GPU (Mali-G31) support for the Renesas RZ/V2N SoC.
>=20
> Patches were cherry-picked from mainline kernel.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--F+Wjsl9S06XdXR8J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaZxMPAAKCRAw5/Bqldv6
8qQkAKCqwVFPIaeeeL7oW41lSGs5OutvaACfY9OZR5EMWVzftUlkmfHIDsSHsgE=
=45R2
-----END PGP SIGNATURE-----

--F+Wjsl9S06XdXR8J--

