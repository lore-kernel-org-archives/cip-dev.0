Return-Path: <SRS0=qir/=DV=lists.cip-project.org=bounce+64572+5576+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EB8C433E7
	for <cip-dev@archiver.kernel.org>; Wed, 14 Oct 2020 10:07:46 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A28F62068E
	for <cip-dev@archiver.kernel.org>; Wed, 14 Oct 2020 10:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="WrLvkx6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28F62068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5576+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id WOruYY4521723xaGuMKQfOku; Wed, 14 Oct 2020 03:07:44 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.8603.1602670063243985462
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Oct 2020 03:07:44 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DDFC31C0B8B; Wed, 14 Oct 2020 12:07:36 +0200 (CEST)
Date: Wed, 14 Oct 2020 12:07:35 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [RFC PATCH 4.19.y-cip 00/50] Add PCIe EP support for Renesas R-Car Gen3 and RZ/G2x
Message-ID: <20201014100735.GC1866@amd>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ZMk8jeqf4ceZg9j2pzj7s0tGx4520388AA=
Content-Type: multipart/mixed; boundary="2ZrIlW0EY8UITfP2Be9a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602670064;
 bh=0L4ya0HM9o6Jgvv2b1YY3RZ5d+dmXcmXAjLeGgRQfKM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=WrLvkx6pVJFycJqVfLJZKf6NIGCJ2AfIb4zHqpc0ImD49xqzg6iUsibVVifzqCX6Olb
 HgMkmKahliRmNID0PaVmMfn0ho1bsHQs9WWuZ7LXVeF83AX4S8Tds6xWmiJZnslm2eq6o
 2DEQ9DFQJY1es3bsBjr7nm68LfMlHuiDOe4=

--2ZrIlW0EY8UITfP2Be9a
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline

--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> * I was skeptic with patch 36/50 "Rename pcie-rcar.c to pcie-rcar-host.c"
>   this is required as patch 38/50 adds a new file named pcie-rcar.c. Open
>   for suggestions if this can be handled differently.
> * In patch 37/48 I have dropped the changes for host driver as the patch
>   doesn't apply cleanly and manually applying it was resulting in a
>   big diff.

I have no good ideas how to avoid rename.

Given the change in locking previously in the series, manual review of
changes in this area might be good idea, anyway.

In 4.19, there were 75 patches in this area so far, and 5 patches that
would reject due to the rename.

pavel@amd:~/cip/krc$ git log --pretty=3Doneline v4.19.. drivers/pci/control=
ler/ | wc -l
75
pavel@amd:~/cip/krc$ git log --pretty=3Doneline v4.19.. drivers/pci/control=
ler/pcie-rcar*.c | wc -l
5

=2E..so we'll get a bit of additional workload from this. It would be
more scary if there were -rt specific changes in this area, but
hopefully there are none.

I expect that you are willing to help if -stable or -rt introduces
conflicting patches in this area?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+GzecACgkQMOfwapXb+vIXEACgppZ8mSVhhl2iwKLVvQQADe0C
EXwAn0EDXQb7Kjn8lnwcVT+moz2lxP1C
=VYDc
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--

--2ZrIlW0EY8UITfP2Be9a
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5576): https://lists.cip-project.org/g/cip-dev/message=
/5576
Mute This Topic: https://lists.cip-project.org/mt/77461654/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--2ZrIlW0EY8UITfP2Be9a--
