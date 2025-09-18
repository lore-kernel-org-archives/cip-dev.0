Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A71FCAC597
	for <webhook@archiver.kernel.org>; Thu, 18 Sep 2025 08:04:20 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.8509.1758182648402208020
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Sep 2025 01:04:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=AhoCXdWr;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 02CD81038C109;
	Thu, 18 Sep 2025 10:04:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1758182645; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=a+mqzRPPhX1KGADBC1CfkGXL2EWRAUMBQ6jrw3LdrKI=;
	b=AhoCXdWrsUefOif/RXteH4T7tuW3PQBI1UFb9pxyhH6klzTJVRJtUJu/Rsxw+ABBm85DBB
	qEYBAy+HTe6thFMX1SrHmhAp/CMF1ahpolrysb1Yd0QMxgXEJmC4d3ivm1VmWahXc9zNID
	hzWldaEyIcv9WDMC9M0FhHcXzOOFOtOVltWrLdlklvwpPpKlGBWIvXBOeyzK5o4isvAsI4
	C12/wQRVd/ovqBkUc76GHWy9lNs6/FJy+/Cn6EXR5KLy85Esxy3aoPWgNby4P2V4I5uogo
	hRHbdNFKDqx1EgC6ubBpqo0tFayJQ+i5IDVpVuERIxhti3KzbmmJIj/Q9lmMHA==
Date: Thu, 18 Sep 2025 10:04:00 +0200
From: Pavel Machek <pavel@denx.de>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Request for review for 4.19-st8, 4.19-cip124
Message-ID: <aMu88B3vQn1iC0Lu@duo.ucw.cz>
References: <1522250355.247103.1758035031215@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iHtxc8ydoUhmHyl9"
Content-Disposition: inline
In-Reply-To: <1522250355.247103.1758035031215@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Sep 2025 08:04:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20083


--iHtxc8ydoUhmHyl9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> Here are the manual backports for the upcoming 4.19 kernel release. As al=
ways they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/c=
ip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
> (At least that's what I assume; I'm no longer able to get past the bot pr=
otection...)

I have seen it randomly fail on me, too. Could LF tone it down?

Patches look ok to me, ddc44ffdaa7d8 should probably return
-EFSCORRUPTED but I doubt anyone cares.

Best regards,
								Pavel

a just a robustness against fs corruption > c50175dd232f1 f2fs: fix to do s=
anity check on ino and xnid
a > c5da7386ca038 squashfs: fix memory leak in squashfs_fill_super
a critical section could be shorter > 8004a014004f3 pNFS: Handle RPC size l=
imit for layoutcommits
a > 73d1fa319709c wifi: iwlwifi: fw: Fix possible memory leak in iwl_fw_dbg=
_collect
a just a printk tweak > a2cab05b5667d usb: core: usb_submit_urb: downgrade =
type check
a just a robustness against fs corruption, -EFSCORRUPTED? > ddc44ffdaa7d8 u=
df: Verify partition map count
a just a robustness against fs corruption > 68def4bf2c714 f2fs: fix to avoi=
d panic in f2fs_evict_inode
a > a2f0f298a3bc6 usb: hub: Fix flushing and scheduling of delayed work tha=
t tunes runtime pm
a just a robustness against fs corruption > 0f86291316a33 f2fs: fix to avoi=
d out-of-boundary access in dnode page
>=20


--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--iHtxc8ydoUhmHyl9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaMu88AAKCRAw5/Bqldv6
8i5MAKCRXn5I8MBCKNsoM+U1kclTFBu+xgCeKMkbTWuyjfszbyBiRT5OTUwGZTU=
=XM0v
-----END PGP SIGNATURE-----

--iHtxc8ydoUhmHyl9--

