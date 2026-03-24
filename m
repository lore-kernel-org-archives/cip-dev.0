Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CDEE9A772
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 11:24:36 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.62])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17568.1774351466001010824
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Mar 2026 04:24:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=lMnuUrQe;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.62, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onFHJ+RBB1IcnNnwGsWjOZuQIft4AWm2b8PdJcDtp6WfY4tihAeq0Kn1tUA5v3rnijnSqDQ8Ob4Y4J/7KTgTzVyxSKU41lKfmkR0AgcdvbL7LPJ4FbAHm4HykBpDXxXx5MufYqXVnJSodOPHmZa9T10PaEXcPVTe5+m6F3yLdWReECmAWwSY/DWE0GABJ6MWatkHMYBEiwz1QVyNa+s19BIypqKPW6w9N3kSJip8zCE9ttAuQF9F4hLb1tbGGpS/O5McEsG+9HFXoENbpNcQTvDiMTBMjMFQQjmwcvtgbK60J+vGt0A9Ba5gMbAKqqMuIzfPMF5S+pyamkn7JRiTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2ycBtpFUVhoe7XhTuOZp1HgF0vO7XE/mUv/7bgpAHs=;
 b=qoaNODvWNSVDgFvAPHYFhI6MYH8xgRzHeZiLe9bAoxUJvZxqGmVlx7d9wR6w0YDyfWtytvHOqc95t2heUoOtx8sP/h0aInhjT49/IiDCGoVx4UEA3fnqeKZ9hc/l83ijgR5XQU4pjKq10xVY5PVBYX0+M23KNEva2Z5WfK1eU5/+8Kp2oaZin2gcKo7mx4EzYRosW48WmqgiuyiigAToN5nvC4yRn/foechhb49/qPyYHsr7BM/ykPZRkluy5zQ46izrxe7lV0/Cb/hXhntllgvZSxrG0n/22jALwtOe23fKbh+CoH3D4n9cWinR9ZocHpE1KROFqpTpXvyfD+FnYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2ycBtpFUVhoe7XhTuOZp1HgF0vO7XE/mUv/7bgpAHs=;
 b=lMnuUrQevyDZsGbnPwnA2xUxjB2XfV4WD+npuV6pblYp/VtXi+RnrtfCKF9cedPRXxpw0yGMdCDjbGFlAqg8LsM1GtjMt8wwqciSu2LprVkbwhNZjgtlEQCf6uO4+YeUcZe+xfldSVGegZrM699wtoqhfUKk3rw3jPf+KxRkcI8=
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com (2603:1096:604:39f::5)
 by TY4PR01MB13994.jpnprd01.prod.outlook.com (2603:1096:405:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 11:24:03 +0000
Received: from OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796]) by OSCPR01MB14315.jpnprd01.prod.outlook.com
 ([fe80::66f:fac9:2ef6:9796%4]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 11:24:21 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.12.y-cip 19/35] net: stmmac: dwmac-renesas-gbeth: Add
 support for RZ/T2H SoC
Thread-Topic: [PATCH 6.12.y-cip 19/35] net: stmmac: dwmac-renesas-gbeth: Add
 support for RZ/T2H SoC
Thread-Index: AQHcu27qZkgJSp33RUOXx8VrS8KP3bW9ioSw
Date: Tue, 24 Mar 2026 11:24:21 +0000
Message-ID: 
 <OSCPR01MB143155362BD20B3934F158C06AA48A@OSCPR01MB14315.jpnprd01.prod.outlook.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260316145915.8580-20-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <acJWamLEv29luwWG@duo.ucw.cz>
In-Reply-To: <acJWamLEv29luwWG@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14315:EE_|TY4PR01MB13994:EE_
x-ms-office365-filtering-correlation-id: d4aab3ef-8e7d-421d-6199-08de8997e573
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 wkplle8mIU5+67TBBi9lw/L3AYrq7aQBpHlT6XDqtVkPCXAzY1ag5oJjn1pNFdK2jdVNHXGPdWbov6cS7DIvWzs45LfPOCsHsnsL+6IGTrf1hjlLLXyCH0UMn/TEU+eU3ORDXPck88HxxqMZdn8BJp1OtQO2iHOHA4y7lnPsLlp6NiWgapogX5M72psPoDxd8wUUyfiX1lWFwLNTyggNxdAmkwPISm8SmUM/TED0d/XfH11xBoaWnlq+RDlF5qnZRJQA0eLnR7pR7oUEPCQmNHtYercbaBgb+3lSyWvl7LexKh3F4TPfTULH8n+2tw48M9GO2jI3mWI8MQ5bHMP5BGSUMhHiaUUvFW4yZWHad42FudJgYF41HNsQ82FbdC+Umo/F5a3L5NlLIHDsF+7Gq8LcKtvOwcgJozINA8PBotvoLAJhnO9a7CeGqtX/2YtBhgPOHdVShGP+dEQRVKLrKHstTkqEJ6gTWEbM7RAPL5GshsNVMKEXfUVL9K8fQ9GKY9PNBb8kTNYlN7lpONM2fEBYOFOhhCfKpZnPMnKypYokN6Cy4CiMuEHTENJAGD2OOug0hzHrob6UHd9LRoNt8kVvqXAxf9hFjWJ+upkcpbWURUQRgSvKzsiOyprZeonI0EikqGnLDOlF1Hho2PZAE66+6H4Y+QBPNT3+lzwD6fZ8y5pnqiDtnFT+hcJH4JW2OL1yt2ffcXXSGULVGyzPhxsKUivaD/FeHaqFyXqTPHh9uRtURz6XnYNbSApVIsAwo5Q8fAmbI1+yrMeqa0PJ1P5zbO9P0ACDeDarSfeZwiU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14315.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?gnyuzf0OKlA/SHc/PNatLgO+AhF3RQ+pG0W9Lh2WnMMLWuVGYlJ2XWywCLzh?=
 =?us-ascii?Q?enLIsGRxPu56PpEwvhRMybpxGMCICFVKJhvB9x1A7wPKRpF1OF6pvu/hjqmr?=
 =?us-ascii?Q?eFRAU5GhqEjGULdnvPLyLzH5SrPyJe3wfWTJnT+7N5D84KG8KLAddHOCRCtr?=
 =?us-ascii?Q?/Y2sFcZiBgsLVD3fnEz8ZY2o5UPHvRu2IDjZA4TDQB+Qu6Lz7Uut93qCoBBU?=
 =?us-ascii?Q?pEvfkZ1ac+SIpvFIdz9B5S0vpVKPrXXKO94IkvkgIZKmz0sfmw8KfaZL0Kl7?=
 =?us-ascii?Q?MCeN0m6A0/Ny/v5p05z8JqqQ0TS5oyDlhhzDoJpwDZ8glmh0rLcsH79rT63S?=
 =?us-ascii?Q?EHkJjmnMKJt2C5bmyzfjgp6R9rLDUBvtzfqpMo5J/rN5mx1gplml0eV5Kam3?=
 =?us-ascii?Q?Satem76iNSuWefELev288r+1Rqq61mLUFTdV+J6lIXx7MrIiChXwh+rLWm+t?=
 =?us-ascii?Q?0VaGmd2WgiUso2JeeKtsiDmOdsXQlCRAJQr5gfIrDWQoBfSFCP3amHMW/B1j?=
 =?us-ascii?Q?yKPR4YVNZB4UjckLCEmA01/qNmLRdmlDmRVZa6/Wr98UJd8fIffpwIjb0sEM?=
 =?us-ascii?Q?NHoEWY6OFjFm5xQ+z97QN1Pli7OTu1NmPcpeyfz9s4as7Ajh9/mdnH2yk0tf?=
 =?us-ascii?Q?hoaoLxkWr9d2A4/Op+Sm5aHwNB7ULhz1VF/zEajuWkkpT/aQrStxazDg2ixJ?=
 =?us-ascii?Q?UfDHshKDZMXg46/vbGQ93/4T8Y0U/9y6TMpBpncyBw1QyOewevxbSSw3wPfd?=
 =?us-ascii?Q?ea1fCo5+NlyZFe9ocnjELJ6wInJtL45IJQsUQjqlEhIwMriz1ZxHxZgD2JQY?=
 =?us-ascii?Q?LShKN1DpDptokxquEMwuY5rF1Wj+w+t+ymKaaL8OxfXHJuCda1ou6pxrnbzT?=
 =?us-ascii?Q?i59ZjSt5EQI9Yqj8F50HiZWKTsaMTschk5BUFxfSGMi/lE1wsN3iqsMgrGyG?=
 =?us-ascii?Q?kw+CCbYnTKLWxjlqFONlUAv0qWT3u3C8XqCW0UFuoVjbwCiQ7I0VcTksN1t1?=
 =?us-ascii?Q?n8aB6TdFGZ1D3TLeIda1tp9Wp8YNT+HBxBW20Y3GF1XzDYIKQRjT4ju9SjWn?=
 =?us-ascii?Q?IR+TWyoW7XsCB5AMRDVuJ7SsT42Wk/u/ctqs55tbLMgIUAbrt6HITeYA3yfn?=
 =?us-ascii?Q?bEg7VuOp+eA3rh8CMwFnLuq9HIPMCD6YX2wm0cXbjgYWD2Q/gQ7eeGEVq806?=
 =?us-ascii?Q?MK7GS7IasXGnz3RGtEaLRzT7hQA+QY2Stt6ajoqn3ZbWctIzdhWukpfZo33B?=
 =?us-ascii?Q?DJdnBhE96+jSMU8j6QVoXff67n4XPr8JwrRAS+3RO/li3FFzu4mympm89hVA?=
 =?us-ascii?Q?Ug8JDAzuJbAsBX470hoHkFTN9VTfPNwXgpSJOEdIDUM+hkxwdX0Cteid0Cz6?=
 =?us-ascii?Q?nP0g+ayon0abU1jauSpQZrjXPI6uuL83ve48+1sgPttcXzTNGN7P6fvLvbRq?=
 =?us-ascii?Q?zilrj/+eGYDvVlYbKzKi+dEAYRPpsHaCaRPttNhHLzvYD5G+lWGmyh4hpDu6?=
 =?us-ascii?Q?54fsDiOQsztt7FFoFHeiWVI/B4R65Lvs6tEtjHkYN4H8/plmMbxRTc/amBV/?=
 =?us-ascii?Q?AZHnT8n4Io7DETx+Cr/Aqqi10Rj69VmZA+XgVZdo3ewx7TeWPwUBKHOvG31A?=
 =?us-ascii?Q?R8nnQYHNRw3rS5cEimzlWLoSa8jUgaw2vUsyA8PeP3LoOz3yRHDIHurvovKz?=
 =?us-ascii?Q?NbkEGEmsQYQlOU6urZs6hh1mDgKa4Rx257QKsxDpBRMWW7oGaRXCzpM5WLgu?=
 =?us-ascii?Q?r8gJniG2BdSWI/EdsUYx3+M14IIWHsxkKzyz0OWZ/4ak63Yi/7Wh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14315.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4aab3ef-8e7d-421d-6199-08de8997e573
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 11:24:21.5206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VLR/Ghtd8W4uhzUuMwPmMYSA++3LLPXKaSEpyidyoqMyVbyL4Ze81l79Pjotv2mptpuxzqfQKARYIBIAhxlQeXLxY8vsDeo7iE6/VI52Skm86qEYoqzWypzpsnGrQOkX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13994
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Mar 2026 11:24:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22548

Hi Pavel,

Thank you for the review.

> From: Pavel Machek <pavel@nabladev.com>
> Sent: 24 March 2026 09:16
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.x90@mail.toshiba>; Pavel Machek <pavel@nabladev.com>;
> Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 6.12.y-cip 19/35] net: stmmac: dwmac-renesas-gbeth:
> Add support for RZ/T2H SoC
>=20
> Hi!
>=20
> > Extend the Renesas GBETH stmmac glue driver to support the RZ/T2H SoC,
> > where the GMAC is connected through a MIIC PCS. Introduce a new
> > `has_pcs` flag in `struct renesas_gbeth_of_data` to indicate when PCS
> > handling is required.
> >
> > When enabled, the driver parses the `pcs-handle` phandle, creates a
> > PCS instance with `miic_create()`, and wires it into phylink. Proper
> > cleanup is done with `miic_destroy()`. New init/exit/select hooks are
> > added to `plat_stmmacenet_data` for PCS integration.
> >
> > Update Kconfig to select `PCS_RZN1_MIIC` when building the Renesas
> > GBETH driver so the PCS support is always available.
>=20
> > index 0156a974db1d..62a33b3fb00d 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
> > +
> > +static int renesas_gmac_pcs_init(struct stmmac_priv *priv) {
> > +	struct device_node *np =3D priv->device->of_node;
> > +	struct device_node *pcs_node;
> > +	struct phylink_pcs *pcs;
> > +
> > +	pcs_node =3D of_parse_phandle(np, "pcs-handle", 0);
> > +	if (pcs_node) {
> > +		pcs =3D miic_create(priv->device, pcs_node);
> > +		of_node_put(pcs_node);
> > +		if (IS_ERR(pcs))
> > +			return PTR_ERR(pcs);
> > +
> > +		priv->hw->phylink_pcs =3D pcs;
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> You can simply do "if (!pcs_node) return 0" to reduce ammount of nesting.
>
Agreed.

Cheers,
Prabhakar

