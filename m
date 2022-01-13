Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04A9C433EF
	for <webhook@archiver.kernel.org>; Thu, 13 Jan 2022 08:07:50 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.6276.1642061269017019205
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jan 2022 00:07:50 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6D2C71C0B76; Thu, 13 Jan 2022 09:07:44 +0100 (CET)
Date: Thu, 13 Jan 2022 09:07:43 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries in this week
Message-ID: <20220113080742.GA15000@amd>
References: 
 <CAODzB9ojKHaZ13TykpwVx3ot7Y45qQaZt7S0gCfag2E9Ad-Apw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: 
 <CAODzB9ojKHaZ13TykpwVx3ot7Y45qQaZt7S0gCfag2E9Ad-Apw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jan 2022 08:07:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7457


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> * New CVEs
>=20
> CVE-2021-39633: ip_gre: add validation for csum_start
>=20
> CVSS v3 score is not provided
>=20
> An information leak bug was found in gre_handle_offloads() which is in
> net/ipv4/ip_gre.c.
> This fix uses skb_checksum_start() to check data but this function was
> introduced at 4.6-rc1 commit 08b64fc ("net: Store checksum result for
> offloaded GSO checksums") so applying this patch requires commit
> 08b64fc too.
>=20
> Fixed status
>=20
> mainline: [1d011c4803c72f3907eccfc1ec63caefb852fcbf]
> stable/4.9: [41d5dfa408130433cc5f037ad89bed854bf936f7]

So this needs more investigation and possibly 4.4 port? 08b64fc looks
quite small/simple.

> CVE-2021-39634: epoll: do not insert into poll queues until all sanity
> checks are done
>=20
> CVSS v3 score is not provided
>=20
> A local attacker could gain his privilege by abusing this bug. All
> stable kernels and the mainline kernels have already been fixed.
>=20
> Fixed status

=2E..and 4.19 and older is fixed, and 5.10 already contains
f8d4f44df056c5b504b0d49683fb7279218fd207, so nothing to do here. Good.

> CVE-2021-4204: eBPF Improper Input Validation Vulnerability
>=20
> CVSS v3 score is not provided
>=20
> A local attacker can escalate privileges via this bug.
> This bug is affecting the 5.8 or later kernel. The commit 457f4436
> ("bpf: Implement BPF ring buffer and verifier support for it")
> introduced this issue.
>=20
> To mitigate this issue, set kernel.unprivileged_bpf_disabled to 1.
>=20
> Fixed status
>=20
> Not fixed yet.

Apparently Ubuntu has a fix for this. But I guess we can wait till it
hits mainline.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHf3c4ACgkQMOfwapXb+vI31ACgloq1AdFQnJP7yXbjfkgJicnM
sQ4An1knXcIsrfnRVh39MG1MiAYyH+wS
=M3wD
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

