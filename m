Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8217FCCD1A5
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 09:15:03 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.6980.1761038094675435808
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Oct 2025 02:14:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=QlU1lmdH;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7EEB1038C10E;
	Tue, 21 Oct 2025 11:14:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1761038092; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=URDGWy/FFcJwimrCYybI/QS7fMK/qcdrs0sWLvSarBE=;
	b=QlU1lmdH0D42nwYKCA2oeGbqEKTL3uaaBfKpnXqhFN172zmuVl2sf9A141X1AGxpECiGfu
	jdQ//yjpP/PMX6z7O5umUhdQ1QOJ0kv4kNmC+YWc9eL/QfpBI4cOPT87KPjVPI7xwLMfwF
	BkJiU04ql0JX0/BYl5Pck15zmicoDIothFMHDOQ+LI6ouOj0j5q3UDC4N23g418Z1d40UP
	hRmybE/Yw/ODeg3cLMwX8zC098GrQl7SDAkyqSYZELnXYpX/KFouF+YccKy2jCGVBjoXRC
	Nzpv4Vz6mUJkPeLrW30w1OFk8nLYmYBNM1l33i8fBqsTzDJOYOZViA5KRDmwAw==
Date: Tue, 21 Oct 2025 11:14:48 +0200
From: Pavel Machek <pavel@denx.de>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
Subject: Re: [ANNOUNCE] v6.1.155-cip47-rt25
Message-ID: <aPdPCJT/yrkRBioC@duo.ucw.cz>
References: <aPXvod6tgxfsFIJI@duo.ucw.cz>
 <c4a955ac-d3da-4631-bcc7-ef0e1f5b645c@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FiXZ67ahfTMYfBw+"
Content-Disposition: inline
In-Reply-To: <c4a955ac-d3da-4631-bcc7-ef0e1f5b645c@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Oct 2025 09:15:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20200


--FiXZ67ahfTMYfBw+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > New realtime trees should be available at kernel.org.
> >=20
> > Trees are available at
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-6.1.y-cip-rt
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?=
h=3Dlinux-6.1.y-cip-rt-rebase
> >=20
> > And their content should be identical. There are also tar archives, at:
> >=20
> > https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/

> v6.1.156-rt56 was released today - already checked if it contains
> something that justifies an update for us as well?

Release announcement does not mention anything, and v6.1.156 does not
contain anything too scary AFAICT, so my recommendation would be to
continue with one month cycle as usual.

If you know something I don't, or just want v6.1.156-rt56 -based cip
kernel, let me know.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FiXZ67ahfTMYfBw+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaPdPCAAKCRAw5/Bqldv6
8u0EAJ4hnKxAjS54YmqX6V/lf6k2lmb91gCfWBEHaOBmdMTkRmzXAms/Gp7qJcQ=
=sOOG
-----END PGP SIGNATURE-----

--FiXZ67ahfTMYfBw+--

