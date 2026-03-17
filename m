Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E785AFF6E8A
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 21:58:51 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.904.1773784727164971966
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 14:58:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Nw+g0XPB;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C01A31085B5;
	Tue, 17 Mar 2026 22:58:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773784724;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=wjJ4TU3lRyrg+5odOIZeOnGNJrkfIuUYQddfQCXjqfk=;
	b=Nw+g0XPBHYfdGLrOzxOccKqdSKPMDrl5fONxN1l47z4CIcUz42hDVX3nNXwii9iS2SRqDN
	AKnforwNt4/rX0DjUiQOwt+lHNPCguu+xbSKwQQf4mT78Niz/9OjxvXz/G56PZztuBE4Ud
	FAQXaI6/qBREyYrH3mPC0+zjTfqV1Ai2YbIIbVxCUWiXP+H/ZZ1bjr1GQkzQaN6wPK1A+L
	00o7LE/WGf+iKt7GljO0OVj1TkewNXOHEtPAhY43+lIKR9hMydzyO55+Syzc5o0h+M9K6Z
	VTF951jbWMafUePYjoIiiUw1ifgOJ6p1EMVzmpYxnsys9gjmNjQvYKFu4tih5Q==
Date: Tue, 17 Mar 2026 22:58:43 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 0/3] Add RZ/V2N DMAC support
Message-ID: <abnOk7EIdKVhxHTF@duo.ucw.cz>
References: <20260316143442.76659-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tTxfjP0zeD7dxNFW"
Content-Disposition: inline
In-Reply-To: <20260316143442.76659-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 21:58:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22492


--tTxfjP0zeD7dxNFW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds DMAC support for the Renesas RZ/V2N SoC.
>=20
> Patches were cherry-picked from mainline kernel.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--tTxfjP0zeD7dxNFW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCabnOkwAKCRAw5/Bqldv6
8oVLAJ4ivOgXcpNmzNqYpIG59lvVF/n2zQCeLZSSodl+9R0ODm4r0p8r5AgLLFU=
=ggQb
-----END PGP SIGNATURE-----

--tTxfjP0zeD7dxNFW--

