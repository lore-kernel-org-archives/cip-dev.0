Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360ABCD5BB1
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 10:26:24 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13249.1779704775758519444
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 May 2026 03:26:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=jM7X00za;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 634D61122F6;
	Mon, 25 May 2026 12:26:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779704773;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=5L2o9DNcJbDpvnGt78XiwN5aTz2xk3AxHsXCMMMRR6s=;
	b=jM7X00zax0+AWmyPxjyQIxl8FxWDR9numRFELVzjCVOmB2AMY04j73ksMHL9TuAlv2blzG
	rPnLVgstNanaQBsUXdAN8mfcE3zwkqQxKUnW26PTjmACi12c1cobcRV3sEPBWr7URujrZy
	UsanH7o6KKKOxfboiC96m2LNZTmHk6l9fAtvucKRpu5w3LrkBpVSJ2K7jeQXWD4DQxf5cQ
	XQS4XzNTgloctapHNUtXL6fwWf4X8pLE10NwkkPLI+2Qc7k9Dk2CHc6WJ+8QOQZvS+F/99
	kCO+XPbPuUoLrWE8dVUc5dqR8msFUWaJxo+9VGhVaw3Nts26NtP6yjRu0fZvcQ==
Date: Mon, 25 May 2026 12:26:08 +0200
From: Pavel Machek <pavel@nabladev.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>, john.madieu@gmail.com
Subject: Re: [PATCH 6.1.y-cip] PCI: rzg3s-host: Revert generic field helpers,
 use a local field_prep()
Message-ID: <ahQjwPfOxYphNczU@duo.ucw.cz>
References: <20260525075916.3817626-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R7IU4lXBn84BXTnU"
Content-Disposition: inline
In-Reply-To: <20260525075916.3817626-1-john.madieu.xa@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 May 2026 10:26:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23006


--R7IU4lXBn84BXTnU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Commits bd9b74372900 ("bitfield: Add non-constant field_{prep,get}()
> helpers") and 8f685ab55408 ("bitfield: Add less-checking
> __FIELD_{GET,PREP}()") introduced warnings, as other drivers already
> carry their own local implementations.
>=20
> Revert both and add a local helper instead:
>=20
>   #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
>=20
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Looks good to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply this if it passes testing and there are no other comments.

Best regards,
                                                                Pavel

--R7IU4lXBn84BXTnU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCahQjwAAKCRAw5/Bqldv6
8lfEAJ9Asg0qxgQD9k2MC+G8z6CScdsQnACfTiSR+CsFkP1wkwaxhFcv4aw55pY=
=c+OJ
-----END PGP SIGNATURE-----

--R7IU4lXBn84BXTnU--

