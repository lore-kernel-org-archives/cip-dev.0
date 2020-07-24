Return-Path: <SRS0=u8Lh=BD=lists.cip-project.org=bounce+64572+4995+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC42C433DF
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 08:58:37 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF552070B
	for <cip-dev@archiver.kernel.org>; Fri, 24 Jul 2020 08:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="oLV0FYgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF552070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4995+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3JzkYY4521723xAacOYCZ51T; Fri, 24 Jul 2020 01:58:37 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.2357.1595581114813765022
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jul 2020 01:58:35 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id AA5571C0BD2; Fri, 24 Jul 2020 10:58:30 +0200 (CEST)
Date: Fri, 24 Jul 2020 10:58:29 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Resource describing the Deby workflow?
Message-ID: <20200724085829.GB28645@amd>
References: <CALkjhPoWijfuk3aJn+z6A0JqzeAZVUFuGpr=_iWR2Qi4YcAOag@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALkjhPoWijfuk3aJn+z6A0JqzeAZVUFuGpr=_iWR2Qi4YcAOag@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sG0SQhvXVmzeA7pR1ooroNUPx4520388AA=
Content-Type: multipart/mixed; boundary="pi7vssG95fLH1JETCOys"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595581117;
 bh=rE/gM2UCPQ8RoDAl92YQHeGZ4HdNkzUbgxC1TW9CXbo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=oLV0FYgpK7vQPP6q4O/xODv1dc+TFMrzrD7QWaFSaq/y+xRxc5TE9PJwp+yGl1wscwX
 c5XuMJlecKUJsGtlRfpK0Amky/OK5ZMkC53CfZQbqNfkHIMFpPAJmyDPK5LOb72tcjFyH
 sRY93b7CvMY6WpKVg0BtropkAZCeYDu2F9o=

--pi7vssG95fLH1JETCOys
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline

--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm almost done getting SSL working between the BBB and hawkbit. The last
> piece of the puzzle is to get NTP working on the BBB (since I need valid
> time to ensure that the server certificate is valid). Unfortunately,
> I'm

Notice that in this case SSL is not adding as much security as you
think it does.

SSL attempts to protect against active attackers, and those can
manipulate NTP easily.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8aorUACgkQMOfwapXb+vJXEwCfXKLXwZXz/pDHBPaJHdizYIKR
u48AoLqb1QKJKsAWhUUrIjFmW3Utjfy8
=4lek
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--

--pi7vssG95fLH1JETCOys
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4995): https://lists.cip-project.org/g/cip-dev/message=
/4995
Mute This Topic: https://lists.cip-project.org/mt/75736954/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--pi7vssG95fLH1JETCOys--
