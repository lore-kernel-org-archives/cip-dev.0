Return-Path: <SRS0=KTHA=D4=lists.cip-project.org=bounce+64572+5634+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D7FC4363A
	for <cip-dev@archiver.kernel.org>; Wed, 21 Oct 2020 19:01:07 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9DD223FB
	for <cip-dev@archiver.kernel.org>; Wed, 21 Oct 2020 19:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="XMEJ3Zuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9DD223FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5634+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id p9cEYY4521723xt0RXHy44Dh; Wed, 21 Oct 2020 12:01:05 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.16883.1603306864049581412
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Oct 2020 12:01:04 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A07071C0B88; Wed, 21 Oct 2020 21:00:30 +0200 (CEST)
Date: Wed, 21 Oct 2020 21:00:30 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [RFC PATCH 4.19.y-cip 28/50] PCI: endpoint: Add notification for core init completion
Message-ID: <20201021190030.GB10468@duo.ucw.cz>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201012141933.9652-29-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201012141933.9652-29-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7RWyaBwjoygUEQis9JaQDorox4520388AA=
Content-Type: multipart/mixed; boundary="WOzt4H4tGknuswQgi2cm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603306865;
 bh=HLBFtbrRDcarQsHHZJFXWtY/es3onljfaqZgonb+ZN8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=XMEJ3ZuyytIoM41e4e7wwPfomR9cBArwq67hgSf0OMclqwiIDzinsq4sirGqqGv1SF4
 2ABVaOzHzI8TjaxzE7w5Z2HmYQ5LMrrfMQA+s0JJiC4ktpJP/fSMbkyaW2W5qs8IdOgF0
 l1SMh+5MyMc+caOfOWKUA1PIs/rEaoD3DJM=

--WOzt4H4tGknuswQgi2cm
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline

--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Vidya Sagar <vidyas@nvidia.com>
>=20
> commit 0ef22dcf0c1871888c4c0ee46a9d9c494f2fe997 upstream.
>=20
> Add support to send notifications to EPF from EPC once the core
> registers initialization is complete.

> =20
> +/**
> + * pci_epc_init_notify() - Notify the EPF device that EPC device's core
> + *			   initialization is completed.
> + * @epc: the EPC device whose core initialization is completeds
> + *
> + * Invoke to Notify the EPF device that the EPC device's initialization
> + * is completed.
> + */
> +void pci_epc_init_notify(struct pci_epc *epc)
> +{
> +	if (!epc || IS_ERR(epc))
> +		return;
> +
> +	atomic_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_init_notify);

Is this used somewhere? This adds symbol but noone calls this, and
AFAICT it is not used in the rest of the series, either.

We can merge it, anyway, I guess, but... explanation would be welcome.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX5CFTgAKCRAw5/Bqldv6
8ppEAJ9Recy3+m5QIubxCbvz5Yj0qChzuwCgg9/LXbkyC8vaFibHXRN1NIeTcbs=
=3nB1
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--

--WOzt4H4tGknuswQgi2cm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5634): https://lists.cip-project.org/g/cip-dev/message=
/5634
Mute This Topic: https://lists.cip-project.org/mt/77461704/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--WOzt4H4tGknuswQgi2cm--
