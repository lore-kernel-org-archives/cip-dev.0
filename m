Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C19C79F9F
	for <webhook@archiver.kernel.org>; Thu, 10 Sep 2026 19:33:06 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23298.1789068776385414186
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Sep 2026 12:32:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=HFZUt/NE;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 678DA102F35;
	Thu, 10 Sep 2026 21:32:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1789068769;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OpGufO0tWE0QOdl6KRiAYOk6HvNeN+O/Zq6n6b44jiw=;
	b=HFZUt/NEd/6M/UUL9FqYbgTE1bed4l3gFo6jfqvc+4npoddCP5STAHm2d9oOBPF0nkL6bF
	J0o7BWwzIRrIsLTK2suPbGfXqSnFbHY613ArQ72GrG0vAMuqAvID5i84xPx1sRNm+kqiMb
	eSfdnsQDYANa4lxPNLIIQqwKmTKZi3auWjlZJxiku6gYVq8D4bP4jnRl/C8y/W4/E5ktg5
	1jslWHQtEaeZ3uFveLZhmk0XfKwS/ooqYstuysP3vfjxWzUv6XuvlmMCioCjWLDvfxYwa3
	O8de60whsE+2MOe+OxW/D8O/YcuOQQXJFAOuUCVVH2cd6/5tDRPoh1VrmAyUfA==
Date: Thu, 10 Sep 2026 21:32:45 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ulrich Hecht <uli@fpond.eu>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: Re: Request for review for 4.19-st20, 4.19-cip136
Message-ID: <aqMF3bvKF4A-mzbV@duo.ucw.cz>
References: <588742173.259606.1788373971804@webmail.strato.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iyLzuYeOWn6Pc6w2"
Content-Disposition: inline
In-Reply-To: <588742173.259606.1788373971804@webmail.strato.de>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Sep 2026 19:33:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24116


--iyLzuYeOWn6Pc6w2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Here are the "manual" backports for the upcoming 4.19 kernel release. The=
re's a total of 68; 40 by me, and 28 by LLM. (The latter are labeled with "=
Assisted-by: SLTR:qwen-3.8".)
>=20
> As always they can be found in https://git.kernel.org/pub/scm/linux/kerne=
l/git/cip/linux-cip.git/log/?h=3Dlinux-4.19.y-st-rc
>

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Most of the patches look good to me, some questions are below.

Thanks and sorry that it took so long.

Best regards,
								Pavel

a > 231854d20f22b KVM: nVMX: Hide shadow VMCS right after VMCLEAR
a > c4bc9e59cd758 perf/x86/amd/core: Always use the NMI latency mitigation
a > a0aef239f4722 i2c: core: fix adapter registration race
a just a API fix > 6cff48ecf1d69 net: ip_gre: require CAP_NET_ADMIN in the =
device netns for changelink
a > c7b13e80811aa nfsd: release layout stid on setlease failure
a > d75140d1212a2 i2c: imx: fix locked bus on SMBus block-read of 0 (atomic)
a > e33cc57dadde8 selinux: avoid sk_socket dereference in selinux_sctp_bind=
_connect()
a > b8c1bbd016710 net/openvswitch: check Ethernet header length in key_extr=
act()
a > f965a98a469c3 net: ipv6: fix dif and sdif mismatch in raw6_icmp_error
a original patch could use function reordering > 7bdb312c113d2 smb: client:=
 restrict implied bcc[0] exemption to responses without data area
a > 8f223fbe6b2d4 batman-adv: retrieve ethhdr after potential skb realloc o=
n RX

I guess I'm confused here. This one is not correct on its own, as it
creates non-balanced situation. Is the 1c72d53630aa3 fixing it up?
Where does 1c72d53630aa3 come from? Will it cause bisect problems?

!! > 1c72d53630aa3 NFS: Pin the 'struct nfs_server' during a FREE_STATEID c=
all

This one does not have "upstream commit" annotation, and I could not
find where it comes from. I checked 6.12-cip version, and it looks
very different from this.

!! no upstream annotation > f1f7d30dcdfaa NFS: Decrement refcounts if alloc=
ating nfs_free_stateid_data fails



--iyLzuYeOWn6Pc6w2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaqMF3QAKCRAw5/Bqldv6
8jKSAJ0bjo1HRtnyeBbfXSdk0zyyNvCLuQCeInKNqQwPqCGcK5sQT959zFGz22M=
=fkVL
-----END PGP SIGNATURE-----

--iyLzuYeOWn6Pc6w2--

