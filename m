Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4DFCFA466
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 10:22:07 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13808.1763979720442828198
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 02:22:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=OB2cO74/;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 39633101C384A;
	Mon, 24 Nov 2025 11:21:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763979717; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=rifHORm/a8JUsfLi3hloNvS/2n5OPtT7g8kZ5Vk7kJc=;
	b=OB2cO74/tktKVrQ7lADACV2piK4F33Ka6WtCkgPBhjKesG4VJF+MkoPZLeQa2ROHy0VINP
	/djdxcmRK1TMl24RkeLA6tpQldqfNIxgULhqxgDfhcMiI1IrRBS6XiJjujCIcZ0Ka0O9/P
	OszhLyliXRtZJrMz0pVRynG8e58hNyCIK+mijMGsGbso5xOt+mRmZdvgEsLTjC1kpDHqNX
	PfJVh3ma+99f2J+wMLGSyM9zhSuqNfJqCf67KxAatjggWdBWptS3bJjL9VfAxDm+NYhH2h
	pKRQ29vqtAItQes1ab5kz/KLYbXJIANBNoB/6WlMjAoIJzVwA8BTy8fwih2pPg==
Date: Mon, 24 Nov 2025 11:21:51 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 2/2] ASoC: renesas: rz-ssi: Use proper
 dma_buffer_pos after resume
Message-ID: <aSQxv6iREysaFLVQ@duo.ucw.cz>
References: <20251122105116.2782841-1-claudiu.beznea.uj@bp.renesas.com>
 <20251122105116.2782841-3-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="USePKZsa51x/z8an"
Content-Disposition: inline
In-Reply-To: <20251122105116.2782841-3-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 10:22:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20709


--USePKZsa51x/z8an
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit 22897e568646de5907d4981eae6cc895be2978d1 upstream.
>=20
> When the driver supports DMA, it enqueues four DMA descriptors per
> substream before the substream is started. New descriptors are enqueued in
> the DMA completion callback, and each time a new descriptor is queued, the
> dma_buffer_pos is incremented.
>=20
> During suspend, the DMA transactions are terminated. There might be cases
> where the four extra enqueued DMA descriptors are not completed and are
> instead canceled on suspend. However, the cancel operation does not take
> into account that the dma_buffer_pos was already incremented.

Ok. So if you suspend the board in the middle of music playback, few
notes may be dropped or something? Don't do that, then. Suspending in
the middle of audio playback will sound horrible, anyway.

I guess this may result in some alert beep being lost (instead of
delayed), and I'm not against applying this, but...

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--USePKZsa51x/z8an
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSQxvwAKCRAw5/Bqldv6
8t0PAJ9rnLWj5PhEGPdLYda+yod8OtvOPgCfcqUaaGgsT4pXtixnNBeIMu3JaPs=
=2+xL
-----END PGP SIGNATURE-----

--USePKZsa51x/z8an--

