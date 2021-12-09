Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD079C433F5
	for <webhook@archiver.kernel.org>; Thu,  9 Dec 2021 09:21:05 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.9449.1639041663385375196
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Dec 2021 01:21:04 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 617D11C0BA7; Thu,  9 Dec 2021 10:20:54 +0100 (CET)
Date: Thu, 9 Dec 2021 10:20:52 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries in this week
Message-ID: <20211209092052.GA14638@amd>
References: 
 <CAODzB9om4QmKLw-ABYqwWSBKL0Sndapov8FWLmhPQKtq1ZvQKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: 
 <CAODzB9om4QmKLw-ABYqwWSBKL0Sndapov8FWLmhPQKtq1ZvQKA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Dec 2021 09:21:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7079


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> * New CVEs
>=20
> CVE-2021-39636: "no details"
>=20
> CVSS v3 score is not provided
>=20
> There is no vulnerability details yet. However, there is five patches
> are addressed so the bug is in the netfilter module.
>=20
> f32815d ("xtables: add xt_match, xt_target and data copy_to_user
> functions"): merged in 4.11-rc1
> f77bc5b ("iptables: use match, target and data copy_to_user helpers"):
> merged in 4.11-rc1
> e47ddb2 ("ip6tables: use match, target and data copy_to_user
> helpers"): merged in 4.11-rc1
> ec23189 ("xtables: extend matches and targets with .usersize"): merged
> in 4.11-rc1
> 1e98ffe ("netfilter: x_tables: fix pointer leaks to userspace"):
> merged in 4.16-rc1. This fixes commit ec23189 ("xtables: extend
> matches and targets with .usersize") that was merged in 4.11-rc1.
>=20
> Fixed status
>=20
> mainline: [f32815d21d4d8287336fb9cef4d2d9e0866214c2,
> f77bc5b23fb1af51fc0faa8a479dea8969eb5079,
>   e47ddb2c4691fd2bd8d25745ecb6848408899757,
> ec23189049651b16dc2ffab35a4371dc1f491aca,
>   1e98ffea5a8935ec040ab72299e349cb44b8defd]
> stable/4.14: [f32815d21d4d8287336fb9cef4d2d9e0866214c2,
> f77bc5b23fb1af51fc0faa8a479dea8969eb5079,
>   e47ddb2c4691fd2bd8d25745ecb6848408899757,
> ec23189049651b16dc2ffab35a4371dc1f491aca,
>   ad10785a706e63ff155fc97860cdcc5e3bc5992d]

Hmm. Fun. 1e98ffea5a8935ec040ab72299e349cb44b8defd may have a clue:

    This leads to kernel pointer leaks if a match/target is set
    and then read back to userspace.

So that sounds like KASLR workaround? iptables are normally limited to
priviledged users, and KASLR is just a technology to make exploitation
hard. I don't think we care too much here.

> CVE-2018-25020: bpf: fix truncated jump targets on heavy expansions
>=20
> CVSS v3 score is not provided
>=20
> Fixed status
>=20
> The BPF subsystem in the kernel through 4.17-rc7 has overflow bug.
>=20
> mainline: [050fad7c4534c13c8eb1d9c2ba66012e014773cb]

Fun. JITs are hard to get right. I guess "avoid BPF" and "certainly
don't allow unpriviledged access to BPF" is good advice.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmGxynQACgkQMOfwapXb+vJCdQCdEmpM3HLkTSYrtBUS4vf/5i+s
h6gAnijCQx4bO0DZTXeW1ZB7cJbmT0vp
=Q3o0
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

