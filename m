Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE47D103E168
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 12:02:24 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12303.1773835340597597203
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Mar 2026 05:02:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=AVBh+n8c;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6326010E42B;
	Wed, 18 Mar 2026 13:02:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773835334;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=DXXwAHvUyzWIuKvy5Ny+VmQEZZOLvOk/AqDpcOBegAU=;
	b=AVBh+n8cN3dn8IG28BvTQcIq2/xnXOaaL2R0DszLMu0F/mNC4o78WLOzzft/qdZ1rnaQxi
	bMyZNuck3zUFjnxUWFoSAGNqI6aoYorKk0fZdPotPkCN03Onzeqb6+cOmF+68uPxsOKtal
	LR7F+1RMYkyGO7eGZcoe/XlWjGMszGLnLbNUPVWjns/sa2agSslT2+yBKEKcYp0kZgz4I4
	ZtD9PFL6FAk7bGWwTbbLkdZh0IK1oxEEnX6VWv3LmlqSSqfCKv+RlCApED4fNRx3AtE6Aq
	smEX+9fZR+Mc53hJy3Oh8RafTk/a3r1xtaklVaXFlT3BwKnnMsraZn/juXzKMA==
Date: Wed, 18 Mar 2026 13:02:08 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 0/3] Add RZ/V2N DMAC support
Message-ID: <abqUQGLqVng5eQ3H@duo.ucw.cz>
References: <20260316143442.76659-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rH4Bmmzb0Aobwy7K"
Content-Disposition: inline
In-Reply-To: <20260316143442.76659-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Mar 2026 12:02:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22501


--rH4Bmmzb0Aobwy7K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds DMAC support for the Renesas RZ/V2N SoC.
>=20
> Patches were cherry-picked from mainline kernel.

Thank you, applied.

Best regards,
							Pavel

--rH4Bmmzb0Aobwy7K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabqUQAAKCRAw5/Bqldv6
8rkuAKCJzY/L+H1kJlBBhwTsV7lX5zaTFACdHVKGz1Tbm6hpqSExD+cObj5X1RM=
=kx1r
-----END PGP SIGNATURE-----

--rH4Bmmzb0Aobwy7K--

