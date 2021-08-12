Return-Path: <SRS0=ShlL=ND=lists.cip-project.org=bounce+64572+6676+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB5FC4338F
	for <cip-dev@archiver.kernel.org>; Thu, 12 Aug 2021 09:52:12 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68DBB60FBF
	for <cip-dev@archiver.kernel.org>; Thu, 12 Aug 2021 09:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 68DBB60FBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NuxbYY4521723xrSO0bVrDB9; Thu, 12 Aug 2021 02:52:08 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.20113.1628761926974384709
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Aug 2021 02:52:08 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E72241C0B76; Thu, 12 Aug 2021 11:52:01 +0200 (CEST)
Date: Thu, 12 Aug 2021 11:52:01 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: xilinx_emaclite CVE -- was Re: [cip-dev] New CVE entries this week
Message-ID: <20210812095201.GA32674@duo.ucw.cz>
References: <CAODzB9q2GjB-rsuq-Ro43yZvVKHY-joQKiXWYx_iqowfwexVCA@mail.gmail.com>
 <20210812054337.GA26920@duo.ucw.cz>
 <CAODzB9p0uk5rg9ctkoXyD7VJVAzVQxqqdWwQmOhZYK=7UyShXw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODzB9p0uk5rg9ctkoXyD7VJVAzVQxqqdWwQmOhZYK=7UyShXw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: dhWqVac5CdXiXhQehlhUpWuzx4520388AA=
Content-Type: multipart/mixed; boundary="4h9ABWZSX4TejiAr8w7n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628761928;
 bh=ZbilqP2VD94b0AxfZB8jwLlVsVZFDMmgihQmmZ/j9fI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=fDKazDqh68gwCx0xnNYCUuI+/K2D0WeygENKleH8aP0F8YNqhgXt/SAIj6TbeqEIrVb
 sXgxRtTKzttSTVvSjhX/xI9z2gqTnZA0pJQcqXHoU7bH9rGFAo9EFt4p9jVDSqHtEd0NP
 KEDdyEy/Um6NJXFWp42/BRhmSYEsJAMltLE=

--4h9ABWZSX4TejiAr8w7n
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline

--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > * CVE detail
> > >
> > > New CVEs
> >
> > > CVE-2021-38205: net: xilinx_emaclite: Do not print real IOMEM pointer
> > >
> > > xemaclite_of_probe() in drivers/net/ethernet/xilinx/xilinx_emaclite.c
> > > leaks kernel memory layout.
> > >
> > > Fixed status
> > >
> > > mainline: [d0d62baa7f505bd4c59cd169692ff07ec49dde37]
> > > stable/5.13: [8722275b41d5127048e1422a8a1b6370b4878533]
> >
> > This affects our kernels (I looked at 5.10.57 and 4.4.277). On one
> > hand we could ask for backport, on the other... I'm not sure it is
> > serious enough to warrant any action.
> >
>=20
> I think this vulnerability seems to be low priority because an
> attacker needs another vulnerability to abuse this vulnerability.
> However, it would be nice to backport the patch too.

So I tried to apply the patch to 4.4, but it rejects, because types
changed in the meantime.

In particular eccd5403814b4e762e270ef0464bb86fb217b1bf and
18af77c50fede5b3fc22aa9f0a9b255a5c5285c9 change the printk.

It seems we are actually using the driver in one of the configs:

=2E/4.4.y-cip/arm/toshiba_zynq.sources:drivers/net/ethernet/xilinx/xilinx_e=
maclite.c

Patch for 4.4 should look like this:

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/et=
hernet/xilinx/xilinx_emaclite.c
index 909a008f9927..26cd42bfef0c 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1180,9 +1180,8 @@ static int xemaclite_of_probe(struct platform_device =
*ofdev)
 	}
=20
 	dev_info(dev,
-		 "Xilinx EmacLite at 0x%08X mapped to 0x%08X, irq=3D%d\n",
-		 (unsigned int __force)ndev->mem_start,
-		 (unsigned int __force)lp->base_addr, ndev->irq);
+		 "Xilinx EmacLite at 0x%08X mapped to 0x%p, irq=3D%d\n",
+		 (unsigned int __force)ndev->mem_start, lp->base_addr, ndev->irq);
 	return 0;
=20
 error:

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYRTvQQAKCRAw5/Bqldv6
8sDlAKCehGUNyS2fecdrSGc+6lOYWsXJYgCgpDqM8u83dlhOimGnLENPqvnaf04=
=1dlC
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--

--4h9ABWZSX4TejiAr8w7n
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6676): https://lists.cip-project.org/g/cip-dev/message/=
6676
Mute This Topic: https://lists.cip-project.org/mt/84836349/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--4h9ABWZSX4TejiAr8w7n--
