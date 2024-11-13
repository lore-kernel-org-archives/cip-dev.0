Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B9DD41C15
	for <webhook@archiver.kernel.org>; Wed, 13 Nov 2024 08:15:20 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.7110.1731485712701569227
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Nov 2024 00:15:13 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=fail (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BC1881C00A0; Wed, 13 Nov 2024 09:15:09 +0100 (CET)
Date: Wed, 13 Nov 2024 09:15:09 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com, pavel@denx.de,
	uli@fpond.eu, masami.ichikawa@cybertrust.co.jp,
	Chris.Paterson2@renesas.com
Subject: Re: [ANNOUNCE] Release v4.19.323-cip114 and v5.10.226-cip54
Message-ID: <ZzRgDXsbJUTO86kp@duo.ucw.cz>
References: <OS3PR01MB6391DAC4B6A1B643A7D2218D925A2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xPU2bG2KgY3rjCGf"
Content-Disposition: inline
In-Reply-To: <OS3PR01MB6391DAC4B6A1B643A7D2218D925A2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Nov 2024 08:15:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17244


--xPU2bG2KgY3rjCGf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> CIP kernel team has released Linux kernel v4.19.323-cip114 and v5.10.226-=
cip54.
=2E..
> the linux-5.10.y-cip tree has been updated base version from v5.10.226 to=
 v5.10.226.
>

Ok, so according to this, base version did not change,

>   v5.10.226-cip54:
>     repository:
>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>     branch:
>       linux-5.10.y-cip
>     commit hash:
>       35cd32f84ab6b210d2be9a26963d82f4ca4afd41
>     fixed CVEs:
>       CVE-2024-50045: netfilter: br_netfilter: fix panic with metadata_ds=
t skb
>       CVE-2024-47685: netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr=
_put()
>       CVE-2024-47756: PCI: keystone: Fix if-statement expression in ks_pc=
ie_quirk()
>       CVE-2024-41016: ocfs2: strict bound check before memcmp in
>     ocfs2_xattr_find_entry()

=2E..but we have ton of CVEs fixed. Ouch. Let me take a closer look at
this.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--xPU2bG2KgY3rjCGf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZzRgDQAKCRAw5/Bqldv6
8gJQAJ9L6KzCieHfoxh1ISHHGufexQ8K7gCfSDdHAtGUt8lelhsV4S/A6QgM1LU=
=Q0qe
-----END PGP SIGNATURE-----

--xPU2bG2KgY3rjCGf--

