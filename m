Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B9CC433F5
	for <webhook@archiver.kernel.org>; Tue, 11 Jan 2022 17:54:04 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.11266.1641923642811862315
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Jan 2022 09:54:03 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 86FCC1C0B80; Tue, 11 Jan 2022 18:53:56 +0100 (CET)
Date: Tue, 11 Jan 2022 18:53:56 +0100
From: Pavel Machek <pavel@denx.de>
To: Amy Fong <Amy_Fong@mentor.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 1/6] Backport netfilter: nf_tables:
 autoload modules from the abort path
Message-ID: <20220111175356.GA6859@duo.ucw.cz>
References: <16C8EE09FDEB733D.27414@lists.cip-project.org>
 <Ydw+c4lHNdN0zAE6@cat>
 <20220110175519.GA3396@duo.ucw.cz>
 <20220110180635.GB3396@duo.ucw.cz>
 <YdyTRgrErYXoQzti@cat>
 <20220111090218.GA22781@amd>
 <Yd2XhiWzYwTbFp/c@cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <Yd2XhiWzYwTbFp/c@cat>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jan 2022 17:54:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7446


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Is there reason not to submit it to stable? You are describing it is
> > as a bugfix, and Greg takes those. [Advantages are a) community
> > review, b) less patches to maintain for us, c) bug fixed for everyone,
> > not just us].

> I will submit the patches to stable.

Thank you. The patches look good to me. You may want to include sha1
hash on the first line of changelog as

[ Upstream commit c1833c3964d5bd8c163bd4e01736a38bc473cb8a ]

=2E..as that's what's usually used in stable AFAICT. If they apply to
more than one -stable version, you should mention that. Feel free to
Cc me.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYd3ENAAKCRAw5/Bqldv6
8vPKAJ0eOjVcviRjDSKVRa6Yd0970lVO0QCePq8yB6RsuG2sRIaaqkmnEeUneCM=
=ZCbS
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--

