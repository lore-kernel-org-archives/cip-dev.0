Return-Path: <SRS0=r6b7=DV=lists.cip-project.org=bounce+64572+5575+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4492C433E7
	for <cip-dev@archiver.kernel.org>; Wed, 14 Oct 2020 09:39:21 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23452076D
	for <cip-dev@archiver.kernel.org>; Wed, 14 Oct 2020 09:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="cBbNJsbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23452076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5575+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fcz8YY4521723xZqxRzDMlYQ; Wed, 14 Oct 2020 02:39:20 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.8173.1602668358578601718
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Oct 2020 02:39:19 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 503001C0B87; Wed, 14 Oct 2020 11:39:15 +0200 (CEST)
Date: Wed, 14 Oct 2020 11:39:14 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] If you are using PCIe EP, speak up was Re: [RFC PATCH 4.19.y-cip 00/50] Add PCIe EP support for Renesas R-Car Gen3 and RZ/G2x
Message-ID: <20201014093914.GB1866@amd>
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
X-Gm-Message-State: BGwQIVOdWtjQVpsunjxsbxWdx4520388AA=
Content-Type: multipart/mixed; boundary="I3bxYgX0E3445Jsu1iD8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1602668360;
 bh=a57yUszNKZePHLKDKv/d6fO8FCI82ufQ8AzFMPhBNWw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=cBbNJsbmdqr5kTXaUeqpUYy8PgrJBsWRwLxRYkVu4aIgsa1eZ7kw9TwJ63/QhAqmTvx
 wv1lgHsQ3V45F3b17RvKukS1EJ6mGgMWZGBsBpRD4WXlNl9NfuJOtF7YzM/qRNowLEfGv
 R4sXM7EGjXVtDZt9CbXJOi9wWU6t6PKC/XE=

--I3bxYgX0E3445Jsu1iD8
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline

--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds support for PCIe EP on Renesas R-Car Gen3 and
> RZ/G2x platforms.

I quickly went through a series and code seems reasonably nice.

> * Since the changes are huge I am sending the patches as RFC.

And yes, it is quite big, which might be a problem. OTOH only Renesas
seems to have PCIe EP drivers enabled in their CIP defconfigs, so
there's good chance noone else in CIP project is using this code.

[If someone else _is_ using it or is considering using it, please
speak up.]

Could we get better explanation for 24/ of the series? spinlock is
okay as long as code inside does not sleep, does not neccessarily have
to do with interrupts.

Should 30/ and 31/ be submitted to stable?

> * Required EP framework changes and fixes are ported as well.
> * All the patches have been cheery picked from upstream kernel.
> * Patches [43, 44, 45, 46, 48]/50 are picked from linux-next.

Ok, so we definitely want them in upstream, not in -next. And it might
be good to wait a bit after merge, so it gets some testing in upstream.

> * I was skeptic with patch 36/50 "Rename pcie-rcar.c to pcie-rcar-host.c"
>   this is required as patch 38/50 adds a new file named pcie-rcar.c. Open
>   for suggestions if this can be handled differently.
> * In patch 37/48 I have dropped the changes for host driver as the patch
>   doesn't apply cleanly and manually applying it was resulting in a
>   big diff.

Let me take a look at these in bigger detail.

> * As the changes touches three other controller drivers I have build test=
ed them
>   as done similarly while upstreaming R-Car Gen3 PCIe EP driver.

Will this be tested somehow by our automated tests?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+Gx0IACgkQMOfwapXb+vJJoQCffVAZePui+NMu+7ylHz0yBzrJ
B5cAoKwECKWmh3My5gIkhtQgnvpMSfXZ
=g9lT
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--

--I3bxYgX0E3445Jsu1iD8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5575): https://lists.cip-project.org/g/cip-dev/message=
/5575
Mute This Topic: https://lists.cip-project.org/mt/77501866/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--I3bxYgX0E3445Jsu1iD8--
