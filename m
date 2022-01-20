Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54609C433F5
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 09:45:54 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.9626.1642671952576719631
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jan 2022 01:45:53 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F2A711C0B9D; Thu, 20 Jan 2022 10:45:48 +0100 (CET)
Date: Thu, 20 Jan 2022 10:45:47 +0100
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE in this week
Message-ID: <20220120094547.GA12647@amd>
References: 
 <CAODzB9pRmJELdQHUS50MgS=9O+LSy9Z9B7cOQuqq+H2fJB+ghQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: 
 <CAODzB9pRmJELdQHUS50MgS=9O+LSy9Z9B7cOQuqq+H2fJB+ghQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jan 2022 09:45:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7471


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> CVE-2022-0185: vfs: fs_context: fix up param length parsing in
> legacy_parse_param
> mainline: [722d94847de29310e8aa03fcbdb41fc92c521756]

This one is queued up for 5.10.93. We likely don't need to do anything
here.

> CVE-2021-4095: 'KVM: NULL pointer dereference in kvm_dirty_ring_get()
> in virt/kvm/dirty_ring.c'
>=20
> This issue was fixed in the mainline this week. It introduced at
> commit 629b534 ("KVM: x86/xen: update wallclock region") which was
> merged in 5.12-rc1-dontuse.

As it does not affect "our" kernels, we don't need to do anything. Good.

> CVE-2021-4197: cgroup: Use open-time creds and namespace for migration
> perm checks
>=20
> Commit 1756d79 ("cgroup: Use open-time credentials for process
> migraton perm checks") failed to apply to 4.4, 4.9, 4.14, 4.19,
> 5.4,and 5.10. This commit fixes 187fe84 ("cgroup: require write perm
> on common ancestor when moving processes on the default hierarchy")
> which was merged in 4.2-rc1.

This one looks relatively simple.

> Commit 0d2b595 ("cgroup: Allocate cgroup_file_ctx for
> kernfs_open_file->priv") failed to apply to 4.14, 4.19, 5.4, and 5.10.
>=20
> Commit e574576 ("cgroup: Use open-time cgroup namespace for process
> migration perm checks") was failed to apply to 4.14, 4.19, 5.4, and
> 5.10. This commit fixes 5136f63 ("cgroup: implement "nsdelegate" mount
> option") which was merged in 4.13-rc1.

Unfortunatley these two are more complicated.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmHpL0sACgkQMOfwapXb+vLBkQCgkLzGIRLmcMKh0/YK7atHW6dj
BR8Anj4vvgsdCFoX1desM1Nrmz3tOq9e
=5K7+
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

