Return-Path: <SRS0=UF7n=M4=lists.cip-project.org=bounce+64572+6657+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14891C4338F
	for <cip-dev@archiver.kernel.org>; Thu,  5 Aug 2021 09:00:16 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22BE060F38
	for <cip-dev@archiver.kernel.org>; Thu,  5 Aug 2021 09:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 22BE060F38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id wboPYY4521723xXkpcauVfLo; Thu, 05 Aug 2021 02:00:14 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.6445.1628154012888407044
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Aug 2021 02:00:13 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F34B41C0B7C; Thu,  5 Aug 2021 11:00:08 +0200 (CEST)
Date: Thu, 5 Aug 2021 11:00:08 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] New CVE entries this week
Message-ID: <20210805090007.GA10560@amd>
References: <CAODzB9rBLCkGEOCZN03W4kX2KwTk58Jkar3r3nHVAzKOGVktNA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODzB9rBLCkGEOCZN03W4kX2KwTk58Jkar3r3nHVAzKOGVktNA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: T57FyyqyEudpGPr5pVMwi63lx4520388AA=
Content-Type: multipart/mixed; boundary="VMAZzq8IuQeTQgnzSrRB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628154014;
 bh=UjDnOJ72fVdaulhH+ge4l07h4lTlmMjrG30uB7CJWUs=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=bmAdvPAtZ3CpdkEh+ROv0hGFdWhwMb9+RFTWOtkDLGGw8HzZ7vcS4QVntvAfg6So0K7
 rZHZ+CLfeoxA7jJo9QFdZZ8Jol02r3fyNMJX59A1BVg57+a5Ornn+YBcoPGyFX5LwbdKY
 djqNKSPuD16Q8TvXcfhjohDZSscz0qH/q28=

--VMAZzq8IuQeTQgnzSrRB
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> ** Updated CVEs

> CVE-2021-22543: v4.19 and v5.10 are fixed. v4.4 uses another way to
> get pfn. If v4.4 is vulnerable it needs to write its own patch.

4.4 is very different in that area, and KVM is not exactly our
focus. A lot of research would be needed. I guess we can simply ignore
this one.

> * CVE detail
>=20
> CVE-2021-35477: unprivileged BPF program can obtain sensitive
> information from kernel memory via a speculative store bypass
> side-channel attack because the technique used by the BPF verifier to
> manage speculation is unreliable
>=20
> CVE-2021-34556 and CVE-2021-35477 are fixed by the same commits.
> commit 2039f26f3aca fixes af86ca4e3088(introduced by v4.17-rc7) and
> f7cf25b2026d(introduced by v5.3-rc1).
>=20
> Fixed status
> mainline: [f5e81d1117501546b7be050c5fbafa6efd2c722c,
> 2039f26f3aca5b0e419b98f65dd36481337b86ee]
> stable/5.10: [bea9e2fd180892eba2574711b05b794f1d0e7b73,
> 0e9280654aa482088ee6ef3deadef331f5ac5fb0]
> stable/5.13: [ddab060f996e17b38bb181c5fd11a83fd1bfa0df,
> 0b27bdf02c400684225ee5ee99970bcbf5082282]

Yes, speculation is huge problem, and getting BPF right with broken
CPUs will be hard. I'd hope CIP people are not using untrusted BTF
programs, and that we can ignore it.

> CVE-2021-3669: reading /proc/sysvipc/shm does not scale with large
> shared memory segment counts
>=20
> According to redhat bugzilla, it said "Not reported upstream, patches
> are being worked on.  It is not considered high impact because of the
> requirements and need to have massive amount of shm (usually well
> above ulimits) ".
>=20
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1986473#c10

DoS only, and only in unusual configuration. I believe we can ignore
this one.

> CVE-2021-37159: hso_free_net_device in drivers/net/usb/hso.c in the
> Linux kernel through 5.13.4 calls unregister_netdev without checking
> for the NETREG_REGISTERED state, leading to a use-after-free and a
> double free.
>=20
> The mainline, 5.10, 5.13 are fixed.
>=20
> Fixed status
> mainline: [a6ecfb39ba9d7316057cea823b196b734f6b18ca]
> stable/5.10: [115e4f5b64ae8d9dd933167cafe2070aaac45849]
> stable/5.13: [eeaa4b8d1e2e6f10362673d283a97dccc7275afa]

I guess we could try to rework the function in similar way 5.10 did,
but... we are not using HSO in our configs, and I have hard time
imagining how "attacker" would trigger it. So this is... just a
bug. I'd suggest ignoring.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmELqJcACgkQMOfwapXb+vKTAgCdFwkCPqNKu5rXA8SpNlCf17qz
cMYAn2oMozvSZbTENfmIJ6IUfDyGmkGR
=/9LJ
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--

--VMAZzq8IuQeTQgnzSrRB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6657): https://lists.cip-project.org/g/cip-dev/message=
/6657
Mute This Topic: https://lists.cip-project.org/mt/84675707/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--VMAZzq8IuQeTQgnzSrRB--
