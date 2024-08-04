Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0514C3DA64
	for <webhook@archiver.kernel.org>; Sun,  4 Aug 2024 18:24:32 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.31480.1722795864644555973
 for <cip-dev@lists.cip-project.org>;
 Sun, 04 Aug 2024 11:24:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: ucw.cz, ip: 46.255.230.98, mailfrom: pavel@ucw.cz)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 780861C009B; Sun,  4 Aug 2024 20:24:21 +0200 (CEST)
Date: Sun, 4 Aug 2024 20:24:19 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for reviews for 4.4-st55, 4.4-cip90
Message-ID: <Zq/HU+sxyEa4gEQy@duo.ucw.cz>
References: <706736547.3348482.1722609934265@webmail.strato.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bP3OxuSb8fMGpdCG"
Content-Disposition: inline
In-Reply-To: <706736547.3348482.1722609934265@webmail.strato.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Aug 2024 18:24:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16713


--bP3OxuSb8fMGpdCG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here's the manual backports to review for the next 4.4 release which, as =
always, can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip=
/linux-cip.git/log/?h=3Dlinux-4.4.y-st-rc

Thanks for series.

Most of these look good, but I believe we should just drop
"5e5344dac2f00 usb: misc: uss720: check for incompatible versions of
the Belkin F5U002". First, it simply drops support for some hardware
without really understanding the problem. Second, AFAICT error
handling is wrong, there's probe_abort label that does some kind of
cleanup but this just returns directly. Problem likely exists in
mainline, too. Should I try to report it?

Best regards,
										Pavel

a just an API fix > f419702e01650 media: mc: mark the media devnode as regi=
stered from the, start
a > 65ea5a47714a3 nilfs2: fix nilfs_empty_dir() misjudgment and long loop o=
n I/O errors
a just a WARN removal > dff699deb3395 HID: core: remove unnecessary WARN_ON=
() in implement()
!! this is not right; should goto probe abort; this may break someone's con=
fig > 5e5344dac2f00 usb: misc: uss720: check for incompatible versions of t=
he Belkin F5U002
a just a robustness> f13500b98a507 udf: udftime: prevent overflow in udf_di=
sk_stamp_to_time()
a > 2efb5ca24b08f net: usb: rtl8150 fix unintiatilzed variables in rtl8150_=
get_link_ksettings
a just a autorepeat tweak > 3ffc17009d168 ARM: dts: samsung: smdkv310: fix =
keypad no-autorepeat
a just a autorepeat tweak > cccb925ba214a ARM: dts: samsung: exynos4412-ori=
gen: fix keypad no-autorepeat
a just a autorepeat tweak > a666ac1afa8ca ARM: dts: samsung: smdk4412: fix =
keypad no-autorepeat
a > a950059ab72ae netfilter: nf_tables: fully validate NFT_DATA_VALUE on st=
ore to data registers
a > 9a626ec9815e8 batman-adv: Don't accept TT entries for out-of-spec VIDs
a just an API fix > 18df69aa504b6 ftruncate: pass a signed offset
a just a _ONCE annotation > 0ca4b05662224 ipv6: annotate some data-races ar=
ound sk->sk_prot
a just a _ONCE annotation > b04d56f62c5dd ipv6: Fix data races around sk->s=
k_prot.
a > 9193eb58d4dc0 UPSTREAM: tcp: fix DSACK undo in fast recovery to call tc=
p_try_to_open()
a > d467eda9f8982 nilfs2: fix inode number range checks
a > 0c5c578a19ef6 i2c: pnx: Fix potential deadlock warning from del_timer_s=
ync() call in isr
a > 8267db6d29ea8 nilfs2: fix incorrect inode allocation from reserved inod=
es
a not a minimum fix> 1df198bc10b67 libceph: fix race between delayed_work()=
 and ceph_monc_stop()
a > 66d3371a26e02 SUNRPC: Fix RPC client cleaned up the freed pipefs dentri=
es
a just a tiny performance tweak > e2be94637020f fs/file: fix the check in f=
ind_next_fd()
a > d469b14c3f2ad fs: better handle deep ancestor chains in is_subdir()
>=20
> There is also a fix-up for an error in a previous backport:

a > 3ffe90bcdadb8 nilfs2: fix incorrect use of nilfs_error()

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bP3OxuSb8fMGpdCG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZq/HUwAKCRAw5/Bqldv6
8jc8AJ4vTPLSATiTD5uhubz4vue6hz7GigCgjTyEYS7q9fI3z9zCL+S2SYb2X2c=
=qvIk
-----END PGP SIGNATURE-----

--bP3OxuSb8fMGpdCG--

