Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145C9C25B78
	for <webhook@archiver.kernel.org>; Tue,  4 Jun 2024 12:23:41 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.19931.1717503817372637125
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jun 2024 05:23:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 669A11C0082; Tue,  4 Jun 2024 14:23:34 +0200 (CEST)
Date: Tue, 4 Jun 2024 14:23:33 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for reviews for 4.4-st53, 4.4-cip88
Message-ID: <Zl8HRY8DFKE/PxlQ@duo.ucw.cz>
References: <1638796688.696518.1717408079442@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wdLOtnpVEfj0SGwr"
Content-Disposition: inline
In-Reply-To: <1638796688.696518.1717408079442@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jun 2024 12:23:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16104


--wdLOtnpVEfj0SGwr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here's the manual backports to review for the next 4.4 release which, as =
always, can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip=
/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc
>=20

a | 4a5a57338 d10129 o+ | ipv6: fib6_rules: avoid possible NULL dereference=
 in fib6_rule_action()
a | 6ffbcb370 9af503 o+ | btrfs: add missing mutex_unlock in btrfs_relocate=
_sys_chunks()
a | 1f959e564 008ab3  + | speakup: Fix sizeof() vs ARRAY_SIZE() bug
a quite an interesting workaround | 8a4d133b7 e57b7d o+ | wifi: ath10k: pol=
l service ready message before failing
a | 7c251ae91 d301a7 .+ | macintosh/via-macii: Fix "BUG: sleeping function =
called from invalid context"
a | e3291754f 59162e f+ | x86/insn: Fix PUSH instruction in x86 instruction=
 decoder opcode map

Ok, so the patches look good to me.

I'd not mind moving ecbb82ce18d073400afead62c777e18a6b64ef28 ("new
helper: memdup_user_nul()") before commit
5631da623a09e27d57a088411ababe1e44f9a428 ("scsi: bfa: Ensure the
copied buf is NUL terminated") where it is actually used, to preserve
bisectability.

Bigger concern is that "x86/insn: Fix PUSH instruction in x86
instruction decoder opcode map" is in in 4.19-stable-rc, but not yet
in 4.19-stable. I believe we need to wait for 4.19-stable release
here, and ensure commits we picked were not dropped, before we release
this. -stable-rc commits are too experimental.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wdLOtnpVEfj0SGwr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZl8HRQAKCRAw5/Bqldv6
8pXSAKC69+s+rfFhSNdMPLmOie0HW1ovnQCfadqZ3grPgUvMgjoSvwWBwbyzdek=
=oaDH
-----END PGP SIGNATURE-----

--wdLOtnpVEfj0SGwr--

