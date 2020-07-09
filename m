Return-Path: <SRS0=+l1N=AU=lists.cip-project.org=bounce+64572+4917+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DEBC433E0
	for <cip-dev@archiver.kernel.org>; Thu,  9 Jul 2020 21:10:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B8A720672
	for <cip-dev@archiver.kernel.org>; Thu,  9 Jul 2020 21:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="u0pq8opC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8A720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4917+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Y1itYY4521723xjcFDxErRdP; Thu, 09 Jul 2020 14:10:41 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.5142.1594329039761936926
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jul 2020 14:10:40 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2D60A1C0BD4; Thu,  9 Jul 2020 23:10:34 +0200 (CEST)
Date: Thu, 9 Jul 2020 23:10:33 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] v4.19-rt status
Message-ID: <20200709211033.GB9193@amd>
References: <20200702093244.GA12176@duo.ucw.cz>
MIME-Version: 1.0
In-Reply-To: <20200702093244.GA12176@duo.ucw.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: VUUWjpLsp3EvHHhcB1e9am1Ix4520388AA=
Content-Type: multipart/mixed; boundary="4DeflSbW0Yz6W9hGpX7d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594329041;
 bh=gRmhq6PkC4NciHxxPuoD0S1wR7BIbzkP2MXYbgVWR7k=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=u0pq8opCwc7uIbmBSnTUmAdCDMtdYpC+EScOZLTJBSXCA3ZgIeA5ZYExbDn93XDyY4H
 h2heBfRFYgcXQj9Ek+fUVxgFQcgRIzGVPaCq/QJdVnEtGyeoKEmREfDiwY8fwEUqktZgK
 TE1ZiamkG6zfPs+mF7iCXbO9NxTvhE+nkeg=

--4DeflSbW0Yz6W9hGpX7d
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline

--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Newest 4.19-rt kernel is currently v4.19.127-rt54. That's not good
> match for us, as -cip kernels are v4.19.128-cip28 and v4.19.130-cip29.
>=20
> I could do kernel based on v4.19.127-rt54 and v4.19.124-cip27, but I
> believe it makes more sense to wait for newer v4.19-rt release.

Still no new -rt release.

In April, Tom Zanussi took over 4.19-rt releases:

Apr 20 Linux 4.19.115-rt49
Apr 28 Linux 4.19.115-rt50
May 3  Linux 4.19.116-rt51
May 4  Linux 4.19.120-rt52
May 20 Linux 4.19.124-rt53
Jun 7  Linux 4.19.127-rt54
Jun 10 Linux 4.19.127-rt55

Based on past releases, I'd expect new -rt release real soon
now. Hmm. I guess easiest option is to just ask Tom ;-)... and I did
that.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8Hh8kACgkQMOfwapXb+vJwLACfdDRLOxVGJTtsIv2xhwbHQSut
5V4AoJ2aEY/3nYKR9fq2reTF/BE16E9X
=sIAh
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--

--4DeflSbW0Yz6W9hGpX7d
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4917): https://lists.cip-project.org/g/cip-dev/message=
/4917
Mute This Topic: https://lists.cip-project.org/mt/75254805/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--4DeflSbW0Yz6W9hGpX7d--
