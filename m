Return-Path: <SRS0=94jD=D6=lists.cip-project.org=bounce+64572+5667+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F3CC388F9
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 19:41:36 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8D42192A
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 19:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="meXv/1p9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8D42192A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5667+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 9RUtYY4521723x84YYm9vuNp; Fri, 23 Oct 2020 12:41:34 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1827.1603482094123944971
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Oct 2020 12:41:34 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 895691C0B8F; Fri, 23 Oct 2020 21:41:31 +0200 (CEST)
Date: Fri, 23 Oct 2020 21:41:31 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 4/6] PCI: rcar: Add endpoint mode support
Message-ID: <20201023194131.GC6002@duo.ucw.cz>
References: <20201023165805.1910-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201023165805.1910-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201023165805.1910-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: EDj8I7b7VmOlhJaabYaTmlVYx4520388AA=
Content-Type: multipart/mixed; boundary="HAXEr8Rqkesns8OhrgmQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603482094;
 bh=Yqf3KBuffHoo3UsjYNqQA/woUSpX8MRXRzk92hOLQuM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=meXv/1p9ABwb+WTObiuSAhSX6rLUPuYNGVNo60KnBAR2BcyEZIQbwIpNk1UUVmzi/y9
 fWEuQu4uYjSmCP4wJH0mf0MkTGeGvR+VrsY+kF5abNHj8kb6nRRL3Sa1DSyNusB3JTf2b
 sic0EJ+A94Xt99iZiUxjIm1e/ZpNApQ3HvE=

--HAXEr8Rqkesns8OhrgmQ
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline

--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> Add support for R-Car PCIe controller to work in endpoint mode.
>=20

> +static int rcar_pcie_ep_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct rcar_pcie_endpoint *ep;
> +	struct rcar_pcie *pcie;
> +	struct pci_epc *epc;
> +	int err;
> +
> +	ep =3D devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> +	if (!ep)
> +		return -ENOMEM;
> +
> +	pcie =3D &ep->pcie;
> +	pcie->dev =3D dev;
> +
> +	pm_runtime_enable(dev);
> +	err =3D pm_runtime_get_sync(dev);
> +	if (err < 0) {
> +		dev_err(dev, "pm_runtime_get_sync failed\n");
> +		goto err_pm_disable;
> +	}

I believe this should go to pm_put.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX5Mx6wAKCRAw5/Bqldv6
8uvJAJ9hEeVsooJuBAvuh78rWCy+vjEdlQCgjG1GmSclxLNW8x/b1eHBFvFjh24=
=NUDr
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--

--HAXEr8Rqkesns8OhrgmQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5667): https://lists.cip-project.org/g/cip-dev/message=
/5667
Mute This Topic: https://lists.cip-project.org/mt/77756297/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--HAXEr8Rqkesns8OhrgmQ--
