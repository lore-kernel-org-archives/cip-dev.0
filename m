Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FAED25B7F
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 13:54:33 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13380.1769608471311939601
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 05:54:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=PuIjKMxG;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 972D910BF6D;
	Wed, 28 Jan 2026 14:54:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1769608468;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=tlAslipM/IT2nIgPmtrggxALwX+OwaqR1baYpnKs1n8=;
	b=PuIjKMxGqokG2YxX4w5Q8QMOxEGeYM29HxXEqjQDp9ENaCV8pS3vw/LsERNymxqSvophtA
	NmbVfPXSCFI6R0kTHRwYZXh6LzDZfsfkC1bdYikg/rIZhJENYN9D7lUtdhcckbYOfUWpJr
	bx0+BpY9I4WdTYv/V1AO1euJohflGFpWnS94H07Ef6nczIB76AWbARDGaTNpl6EzNncEYm
	jpFGcCDtrZVIpTOFt+ZpWX7V81tFJ61oKP3ABB2/10Nze5T2Y7wu72gfNsLzLkhDOIzKlP
	R1uxD06wYoJO7DoQ+xp4nyEzDHYIg4ldOXmNlJzc/xn1eNfu+GA7ga/AYqd9FQ==
Date: Wed, 28 Jan 2026 14:54:24 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.19-st12, 4.19-cip128
Message-ID: <aXoVEA630cFSQcO6@duo.ucw.cz>
References: <604968144.210835.1769572263316@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opdlsvqWb+R3q1Kk"
Content-Disposition: inline
In-Reply-To: <604968144.210835.1769572263316@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 13:54:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21762


--opdlsvqWb+R3q1Kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the manual backports for the upcoming 4.19 kernel release. As al=
ways they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/c=
ip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>

Thank you, patches look okay to me.

Best regards,
								Pavel

a > 121401e5518ea NFSv4: ensure the open stateid seqid doesn't go backwards
a > bac7d26012926 libceph: make calc_target() set t->paused, not just clear=
 it
a > 2c6059deee2ea crypto: af_alg - zero initialize memory allocated via soc=
k_kmalloc
a > 829f2fc2a8274 jbd2: fix the inconsistency between checksum and data in =
memory for journal sb
a > 0bbbb40b6c0bd f2fs: fix to detect recoverable inode during dryrun of fi=
nd_fsync_dnodes()
a > dd8bfd7aed8c6 iommu/omap: fix device leaks on probe_device()
a > fd2c1fac2d53a crypto: seqiv - Do not use req->iv after crypto_aead_encr=
ypt
a > d8e936ec8cc01 f2fs: fix return value of f2fs_recover_fsync_data()
a just a preparation > f32fa18502fed ext4: remove unused return value of __=
mb_check_buddy
a > 7f128710dc0ad clk: renesas: r9a06g032: Fix memory leak in error path
a > 6bfdb8fc2cea5 nbd: defer config put in recv_work
a just a robustness against fs corruption > d81df85afdfef jbd2: avoid bug_o=
n in jbd2_journal_get_create_access() when file system corrupted
a > 2a606c6fd4baa NFS: Label the dentry with a verifier in nfs_rmdir() and =
nfs_unlink()
>=20

--=20
In cooperation with Nabla.

--opdlsvqWb+R3q1Kk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaXoVEAAKCRAw5/Bqldv6
8libAJ0Tqn/wsfAD28/yOCqLu2m3xaEa4gCfcaQW/1DunC0jZvwjSxIfmAiBJDQ=
=VKG8
-----END PGP SIGNATURE-----

--opdlsvqWb+R3q1Kk--

