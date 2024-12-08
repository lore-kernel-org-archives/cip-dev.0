Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22C1E77173
	for <webhook@archiver.kernel.org>; Sun,  8 Dec 2024 12:42:34 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.1])
 by mx.groups.io with SMTP id smtpd.web11.77848.1733661748594832159
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Dec 2024 04:42:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=STCm947D;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.1, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuN4C6zigf2mh2y/Kx4JtwpczKbSDzf9KHmK+YX36xFXYHPjK6DbU7/2pTqougpGU5Bf9NPMViBSSQmKCc330/SpJmlsrJtUc3XH/FJgKrRjbJPgMM22hwLSYz1Zw67RDCoPB/RWmB22skBu2DGJ9cBqxhMCSDRvHBT3VHPaopdJMTA8s6+meqJhM9Xo9VSZCb0LKhuQHQvFIBOd1kYpNpjWe1BUJiq/9DvVFBk6f8cf9rPVTIR5ApF0iogBAlupIAlfBGfwChpJdKHTnt8IrLuHoxTJT2gm46MCCi1gBMTfUkJgKp0t1CGg4C+pLdTg7SnUDRXOx/0Cs9jLN5WEug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZz7zup6zcIdyGiJxJ6gAEZH1qXe0O8neh6FKZhqsoM=;
 b=T/S3ATh49dkjlihmsimkIn8QvgditEAqy1DvallCv6v0s39CwOZYT+0YiGfP89c/P4PKJX1Be5ConCwrDbtfaOL0Yn1Ft0wfZF16k146ixbS9Pg1Pf2GYuK0eL/uFxgak8d61rlNAzrDY6nZoYPEHOWcHoFcd7rPUC9x2xySD4sWG8Z+ghwoD4XiuiNJB+OREUDbIMtQx7NMkKTHJvGwflRNNy1OHs3wYPmIpxYlJ0ZOzoAMoTbRgMwRV1AiBaqjh1daQPRWlZin0UU9iBB8Z3tPEVGV4rsRyL5M+qt/Mh//SDyi+qqbZSg//v596yUkEuAM2Glq4HrK2Sp2WTQ27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZz7zup6zcIdyGiJxJ6gAEZH1qXe0O8neh6FKZhqsoM=;
 b=STCm947DWSNzT/o5In50HRzPUMsT6Zxyfmb4WTR0Mswo2r62HWCU14ETnWSKugjpjmVTZ6oi68APCKWJLd3hQ55TajsaxxO/MEyGsNVZCsUOVWTGTDRPkZeC7tPLxOzxJHUNkeTxo/t6k4PJtK3gaJr1WG901Zuc8iDeSRffVlA=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS7PR01MB11630.jpnprd01.prod.outlook.com (2603:1096:604:249::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Sun, 8 Dec
 2024 12:42:23 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%7]) with mapi id 15.20.8230.010; Sun, 8 Dec 2024
 12:42:22 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 00/16] Add RPC-IF support for RZ/G2UL SoC
Thread-Topic: [PATCH 6.1.y-cip 00/16] Add RPC-IF support for RZ/G2UL SoC
Thread-Index: AQHbSM55EHTh7nR7bUWmvaG2v2z0JbLcSvNQ
Date: Sun, 8 Dec 2024 12:42:22 +0000
Message-ID: 
 <OSZPR01MB70198E94FF57F3D018F67AC4AA332@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Z1SHd8kL1316T9WX@duo.ucw.cz>
In-Reply-To: <Z1SHd8kL1316T9WX@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OS7PR01MB11630:EE_
x-ms-office365-filtering-correlation-id: c3278d6d-0817-4de8-fa5e-08dd1785c30a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?xipuN09jxgFASc3rrr01cLccCGuKEIf2Eh1yI9P9/8sPSI86wZ67K5nM3Qc9?=
 =?us-ascii?Q?TpctJ3PV+7+wjbO8FHxB/OdCoQN0kgoRoEUkRIQc0787Ud+2IsNGvS1lRdDB?=
 =?us-ascii?Q?bJm5Bae5ACWPvueqTDNbj0t/qBTnxs7XGqWgzrg8sZS9I+CathJ0OKr9p6CT?=
 =?us-ascii?Q?PZcTIZ+v65CAzvNvFRSsF9LmzxiAPH38mC0djuSYpkAlXJaUAIP8aX3I46xW?=
 =?us-ascii?Q?wTykFCsUco55HTYOLrcG2PIvqxKgMejT4g4YFOm6quvC5eWH46yMIi2odNL+?=
 =?us-ascii?Q?7KBIejRN9o9y2HhpfcRKDC5UdOkm/VpP4HnIKl/1WfTI01gJ3si3UCZOI0B9?=
 =?us-ascii?Q?v5u5GkLjFK3wvRvOsEcqOwST3Dv4Ze/GtrKly4s2v/DJpFKC9cJ7qi/e9PzR?=
 =?us-ascii?Q?Jnmjcid2qE4gq2iDSnchdN/VB6YCv8Qzutetzs4e+Waj/XMfWIK2RIqAAHxt?=
 =?us-ascii?Q?8kIbPNS3TG4s3JwZmDLnN9WnesJO62gYT7BlZogjGtJt8OIOct00/TGMHAZr?=
 =?us-ascii?Q?O/hTC1z4YJWPAMDpmeapiSq7IaFDfw3KmqiF7EbM3ItZHDkfwk7yJLMJhTR6?=
 =?us-ascii?Q?WsZhouk8C8yMEeLwpKhvpj26tzDEolCFg/QlooFpkXHhrXrS8npuy+gQoi7j?=
 =?us-ascii?Q?o667JDLfk6NjDimuzxFzHWqVAQmNPkbHwHX55LS/JuHJZ0oehVhdhWJNT7gS?=
 =?us-ascii?Q?BuFvbEqiFqJODPksH22C6tucxTTsa8eUrSy+dnTv/Qmys+mjwnOczlMiEAup?=
 =?us-ascii?Q?DMjHdUMBjCyS0Vl93HvbbxDcab6qwNJgz8YGs9eu2jIkjlJgiguMW7xwRzuD?=
 =?us-ascii?Q?v08kiEaUQhi/AYKZBJMVlsJcFtx6IOzCCvlUnIQdEMePSWwjR1oS7fmTRefE?=
 =?us-ascii?Q?tJXprcdelc/9/ZSUKzckxNANRl4WC2smbCgCeEoxGZFPVDDnkNv8EIjLGjrD?=
 =?us-ascii?Q?wfbAjUj/bbXT+PTewzXwND29VCPZfyL/5Uyd5B46VWt9fuQ/w3CBhY4Hwd0b?=
 =?us-ascii?Q?0jzqGT/0CaQlyBuHGfLp9MU/Fyawj8w0/YsFOyzhGA85j1GpUBEJAHYdgkv/?=
 =?us-ascii?Q?FIxff3+TaxzVqr74JVl/pwIacwxaPkTVl0ft3dJgx4gwlxFqYJHS89YPzBiM?=
 =?us-ascii?Q?5nE30X/x5yuobuq7yR2TpyNLXLz+R86uee6nDuBB69OPJnTiOuX2H8MHsTZe?=
 =?us-ascii?Q?w49mdjWtUd4HvOcQvUzOK5MyDIexK3YVYOAJ5e0fmY1YywiCQBGphfoKPoRK?=
 =?us-ascii?Q?u5W6+2sG4kCUCOja0b9CmpK095qtDOsELLtXgJZowf8Rv7n2+TBL5gqHgiHb?=
 =?us-ascii?Q?IpNT1kQtmktnQP+AxkDj4OJUhB+KHBBziCEvKPjdunZuc05xrmD80doapXBG?=
 =?us-ascii?Q?OF7GvpzNNSJURXwO0W0muLeAlZ02FVzNKpxoR5tZXF2drbBLGg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?WvAPiNQkojQ2VerQ/IMfCUnUAh0LAZ7mpA2dkpCCLD6eriKtLa8I7ReYaHWC?=
 =?us-ascii?Q?4d7jz/kf9PZKDSEiESO8osBW9O1aZFqF/D+WmL4MzvbypD4lGQe17mUwyn4h?=
 =?us-ascii?Q?cWi37IgDgQ28O5Jvo5czvFktkAKoDAJYLzjhfdnpVnMgU6hNCjL5OE5R8LTt?=
 =?us-ascii?Q?Nplt1M7P6VUoiNwxfe9G2ntBc5lwX2iE1SYvEJYNdv/h19YL3XXIq6EBluGc?=
 =?us-ascii?Q?gn3ipuUbS3YL5KoicLCRX37HUpIk68rxg/pmEgfglR5g09KawvKUNns3REyZ?=
 =?us-ascii?Q?81g6s5F/qTNFxAJcCcnI2Jzxtb8/3/Zqsd+WYcrCvz5OAdLmTrLEXEABsC8W?=
 =?us-ascii?Q?jCLX6hpT0f5auNmsbZ3UxSXwFRy4FVH1fo5th6+QPxxNU+Ag83Yq4mjcrdQY?=
 =?us-ascii?Q?5lrS+fu/Tqrwes/cf3J1vx7JctX9+Waky0diJ8P+yHyaDZ/R5d45nWR7IPZi?=
 =?us-ascii?Q?1EALrPoCRUv7NN5FLM+CTRQ0OjIOImgbSIxYqF07w0WTSDaif5AvzDSYOHZY?=
 =?us-ascii?Q?MiZbHm1a4kjUIkb3TbrDQ2Sy2jCQjZpwZlroaoypqXTUs7RsXUH0mjT7mqSs?=
 =?us-ascii?Q?Tyk6PakvXawA2EYlBpnjWIAzRqeLkoqeE6UYBHDzxr/Lm91Jh5UexhYs+5YE?=
 =?us-ascii?Q?yXkvc3XGAwA3exD1mWZMBQlFrxBSHe61v8n5bK3GdgtC/Cb6GbsUVmFJZkkt?=
 =?us-ascii?Q?iDhCnd09wEv+oG3QCgM320nYEx3HNqworuhUWCkSOvCdePCaCBEkI4giJLxk?=
 =?us-ascii?Q?xFEguBnew71LbYhrHCrw0yp8xV52zfIe/vx/n+rnpvoFM8wcRrOw9VvfR0r8?=
 =?us-ascii?Q?3LMg8Cbs9QuuVF9+kgjC8MojcSJNeKVVpqRbOrBP0USLY07T6rXX75TM+HjJ?=
 =?us-ascii?Q?tgw+hnYLM2Go8TbhnNGQoWoUqfy+N07BGs6PTFOyv1spG7ZQGWUsvjWfEvUH?=
 =?us-ascii?Q?QU9f2gjKRw8+/VLaK3+07YzIt51S9IAyZBpKP1I5DHWpn/TWkaBZ3es2JCPN?=
 =?us-ascii?Q?LieAgptTV2JUzxHRmtv97ojCgK1XS6cSxu+0MZ7+lw4kyoi4zOVWpuPlYdV2?=
 =?us-ascii?Q?TXzapV1lfp67B5jVNcFcKkAJY3mWcDT9E4OaX6LJi/4cQWE6AsvyZ67mZ1rF?=
 =?us-ascii?Q?DHBxdZ2zCYniFY5kcZcRY9erHuQp22q18QHjSAGiDKR2dqLuDEbLJ66jmtQn?=
 =?us-ascii?Q?VztZtzhk9P61iC/64wDhgnv6LnqUya2ZAZo5Hohh2+QL3zEkkh38kekwRzba?=
 =?us-ascii?Q?jnsu+JWq9pryIOIa+Uv1FjLkZfTaq/4LlK272ektzVzFl91ZnSU7prhypStx?=
 =?us-ascii?Q?SAwBbFVWztEjHYEVq5FVWAECJ7Eavxfbd9P9HVMnCC+apTNeJnsquoGP7cOy?=
 =?us-ascii?Q?sr8OoldiqEe9U3b8wGpPTCegBRWBhdSzJyqtk/iVAMsWCIsVRhKUu4MLW/76?=
 =?us-ascii?Q?hixPos7U7IahJ0YSypvPIJM9pbMMK+I4FfOtRy+0Sx4Uq8mkwYtrSF30TqnP?=
 =?us-ascii?Q?V5bM89KX7a2GwV5CxJGo+jzI4xMhU4Zr5q4d0l6ge4Iq2f5SEy+mzofFURz6?=
 =?us-ascii?Q?4p1zmgeguSb7ZiaJ2QgmBrq1icqc/zsoPTwfHF41cq2GoN3nD7VIe2lc/PIt?=
 =?us-ascii?Q?/oa2pDTCqwEnjSZ9DCDFNPw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3278d6d-0817-4de8-fa5e-08dd1785c30a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2024 12:42:22.6237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cXdg1Mr3LKzZk4Ob/gIvlqKYXXiN1Ys9XuijuZhpegtyeEW929Fxw1Y1z3t0JX3qKtgNU6JdXIE9q7yd/NsR9FV3JXZtfWOH5bpTjb3w/C7hTGqHC/qV7HgYWC7Lfm7/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11630
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 08 Dec 2024 12:42:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17374

HI Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 07 December 2024 17:36
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Da=
s
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 6.1.y-cip 00/16] Add RPC-IF support for RZ/G2UL SoC
>=20
> Hi!
>=20
> > This patch series aims to add RPC-IF support for RZ/G2UL SoC and
> > enable it on SMARC platform, along with enabling tx width to 4 on
> > RZ/G2L SMARC platforms.
> >
> > All the patches have been cherry picked from upstream kernel.
>=20
> It is a bit strange that 5.10 series is smaller than this.
>
On the 5.10-cip kernel the generic flash driver lacks lots of features as c=
ompared to upstream which cannot be easily backported. So instead choose a =
simpler approach while backporting to 5.10-cip hence less patches there.

> But this looks okay, too, and I can merge it if it passes testing etc.
>=20
Thanks.

Cheers,
Prabhakar

