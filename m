Return-Path: <pavel@ucw.cz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F313C38145
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 09:51:49 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.4722.1662112306773130751
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 02:51:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ucw.cz header.s=gen1 header.b=PIpcCK/O;
 spf=none, err=permanent DNS error (domain: ucw.cz, ip: 46.255.230.98,
 mailfrom: pavel@ucw.cz)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 934731C000B; Fri,  2 Sep 2022 11:51:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1662112304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lrU2qtGwbTnlM5Ao8rFTaPBRRnbQf7/pPeiS+9KC+NA=;
	b=PIpcCK/OxL10WENKanqiiY52IZxjRZa2sOs+/ZSSfF/+pPkIwkfB6oE+3R31pQ0RT0mXMw
	NQa/qc0Ifx6BAhlB0LPlm2Wcq8xb9lMvNfZ/ojtmd3yJ9qMP5tYSlk/pNHMP7h8vjEWvaE
	kEvGbGHmN7W9qhG3zZ0Kog6VtsH8jeI=
Date: Fri, 2 Sep 2022 11:50:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip 00/10] Document RZ/G2UL SOC bindings
Message-ID: <20220902095059.GB16210@duo.ucw.cz>
References: <20220831163735.2112470-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <20220831163735.2112470-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 09:51:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9452


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to document various IP's present in
> RZ/G2UL SoC.

This series looks okay to me.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYxHSAwAKCRAw5/Bqldv6
8gUyAJ90BMpL397MBfjL0Fn69mqVMWYGLQCfcOZRjtGwRd3cL1uR7nc4uIYW/JY=
=HtZp
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--

