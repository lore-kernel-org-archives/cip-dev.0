Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56A4C83F1B
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 11:55:31 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.76267.1752494128051279040
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 04:55:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=G0DNVrQL;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3937A10397286;
	Mon, 14 Jul 2025 13:55:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752494126; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ddzqD7BTBTzvyfPEruofX0ytEw1dasGeoi41lHFV3g8=;
	b=G0DNVrQLr6WyjbfKvh09xrIuQqMu5Cj2yJlbUQ/QvWyepHspN9qNl3zFUgL2W+frVf5kBd
	7YJu4Us4D2ZIXlDsWDi6BMVUg2s/YplUFNMVIh3qNXsFcAt7tN6IPA1V9HjWEX/gEnFa3H
	Lc6jkfYFlv/aRkQdmf6eeXJQ+DUPPFnd8s8k6I8fbh6mdd9Qg2sLi3asKj4SSO6KN9OYtD
	h1R1I0R/BB4Aqk+24rngUpCOQAXwTBzPc3Sc8ouo/26+X+57KnhcXtJnw1rVck8h0YxKns
	gKq3LFswYujlDWal/pcTQVH4AdIIB27riF/DuPGn1TMw3oSGKOMkUeLaXiDoWg==
Date: Mon, 14 Jul 2025 13:55:22 +0200
From: Pavel Machek <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: Re: [PATCH 6.12.y-cip 00/36] Add RZ/G3E CANFD support
Message-ID: <aHTwKsIBElBNeFH9@duo.ucw.cz>
References: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vm6FMJ+i3gUCLuZC"
Content-Disposition: inline
In-Reply-To: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 11:55:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19526


--vm6FMJ+i3gUCLuZC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds support for the RZ/G3E CANFD driver into 6.12.y-cip.
> All the patches in the series are cherry-picked from mainline.

First, this series is a bit long (and 6.1 even more so).

Anyway patches look reasonable and I can apply them if they pass
testing and there are no other comments.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--vm6FMJ+i3gUCLuZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaHTwKgAKCRAw5/Bqldv6
8u8uAJ0QNsi8zaiiZMK74lSK/Ra2PoE7SQCeOceVcdgEIYehG+aGsFxZFVMb1sI=
=PvWD
-----END PGP SIGNATURE-----

--vm6FMJ+i3gUCLuZC--

