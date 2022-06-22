Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E78C43334
	for <webhook@archiver.kernel.org>; Wed, 22 Jun 2022 12:06:42 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.6374.1655899596430066862
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jun 2022 05:06:37 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 379431C0B9B; Wed, 22 Jun 2022 14:06:34 +0200 (CEST)
Date: Wed, 22 Jun 2022 14:06:33 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [4.4.y] cred_getsecid hook
Message-ID: <20220622120633.GB7458@duo.ucw.cz>
References: <PVAj.1655386250477927031.ATkI@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <PVAj.1655386250477927031.ATkI@lists.cip-project.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jun 2022 12:06:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8582


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> While working on backporting the fix for CVE-2021-39686 in the
>Android-"version" of the 4.4.y kernel I noticed the missing
>cred_getsecid hook introduced in e.g. 4.19.y by
>3ec30113264a7bcd389f51d1738e42da0f41bb5a (
>https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/?=
h=3Dlinux-4.19.y&id=3D3ec30113264a7bcd389f51d1738e42da0f41bb5a
>)
=2E..
> Anyway: Are there any plans to synchronize the hooks in 4.4 with those in=
 more recent kernels?
>

Let me see. 4.19 has that commit; it was merged during merge
window. 4.9 does not have that commit.

If CVE-2021-39686 is important to you, right way forward would be to
backport neccessary changes to 4.9, first. We would rather not have
changes in 4.4-st that are not present in 4.9.X.

I don't think we have any plans to work in this area.

commit 3ec30113264a7bcd389f51d1738e42da0f41bb5a
Author: Matthew Garrett <mjg59@google.com>
Date:   Mon Jan 8 13:36:19 2018 -0800

    security: Add a cred_getsecid hook
   =20
    For IMA purposes, we want to be able to obtain the prepared secid in the
    bprm structure before the credentials are committed. Add a cred_getsecid
    hook that makes this possible.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYrMFyQAKCRAw5/Bqldv6
8tzbAJ9S2HNUXaaV+kNNfWrMPBT4Fyzq4ACffoaqxGJAbOuX+DfMv6xd0X6H480=
=usq7
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--

