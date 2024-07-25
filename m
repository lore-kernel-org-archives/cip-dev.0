Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AD5C3DA49
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 08:12:25 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.69])
 by mx.groups.io with SMTP id smtpd.web10.31524.1721895136867596599
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jul 2024 01:12:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=bkFhHgPC;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.69, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFfBI4Uoo7QaD0gxOzMwuSR6TRqBw4qj/mEZmla31IGw8szQNSd/4uIXp8AHTxRBcphNNyncpepY2Ge0/gtugvS5f9FzFcsQevg3t0ZjJLAR4T2bD+ohLjufX85F9tigJtluadqSPSjRV1r4+X7yDNGKFWaYDqhjolD8unFZiLAKvHJzGpRhRakidfyAE4cVBe1lXFuHIhSivLrVHwJqmW2Yt/KhDrUY4PMOhOr6C8ow6MQQ8yhOeppEATmqOfHKsS1lnWSXDphL1WnT6sSwnELkZEtqEZ7zxGg70A8+pwG8ZQ2+Ix937+rldz0vHpGy5FYjKysKa/Ym+sXRpXeU1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yesZsIQmTC3zEHbn1lr9iuHr83WexHS5eud7KRakXo0=;
 b=Da0k7DPP6xsXXBoi7RMnTccprTjuPrqe2S8sU3BqDnDRt8wK6VJlWRQsnaGp5bbuSeU/F3iwKnkuJvPnaq2gxP0bOQGshq7jOE3Mzq/4AD5NcKHzDbVO4cOURKY4fAMJMn6bmBu2XcHUHbe/iM5ImmenQd5TeS7Bz2P7QafvVGEqaAMqpWqtYbk7a5Zzk6N+vSQlXE7Jl1w0tH30FqD7CCqmU6z2bWWEtHcRGW0STXL01oD9DFeja5zcK+sArnrApo5MJ+eUCeAAkWEU3SK1uqGGrDcHBp4OhNKp/xjLLRWxgcKMJBhI1fq3GlaDYn16LVVtgpm1nZyINUR2MsK7tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yesZsIQmTC3zEHbn1lr9iuHr83WexHS5eud7KRakXo0=;
 b=bkFhHgPC2TOBJcVxNA8/X4LDpHAYL1coi+b7KDDJOj+8QWTNgC6RJD/R8XADmeoWEa8hzMHchBm6tEhCaFHNQ86QnFvnwu+3/lv2hudOwJhn7psoHvrsI3hBOqU2NL0Z7OQjXJ60b2QaGMsWHWVw6OunJuVnTRBd2UBVIvt6N6Y=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSRPR01MB11534.jpnprd01.prod.outlook.com (2603:1096:604:231::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 08:12:12 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 08:12:07 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 1/1] Revert "arm64: dts: renesas: rzg2l: Add
 missing cache-level properties"
Thread-Topic: [PATCH 6.1.y-cip 1/1] Revert "arm64: dts: renesas: rzg2l: Add
 missing cache-level properties"
Thread-Index: AQHa3ammdmOsvB5klUiugPfd2ONgjrIHGM8AgAAAPsA=
Date: Thu, 25 Jul 2024 08:12:07 +0000
Message-ID: 
 <TY3PR01MB1134687E9A8D8A6C49889A46086AB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20240724091240.67115-1-biju.das.jz@bp.renesas.com>
 <20240724091240.67115-2-biju.das.jz@bp.renesas.com>
 <ZqIIYuOTQQi6YlVA@duo.ucw.cz>
In-Reply-To: <ZqIIYuOTQQi6YlVA@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSRPR01MB11534:EE_
x-ms-office365-filtering-correlation-id: ca4a9ea0-95d7-4e13-ede4-08dcac817a15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?XL/dS5AACqfTOpyKi2HPetTbNPpvmEVk+ndP4gBIw+m/HPEu3K/UxIZcZeIA?=
 =?us-ascii?Q?tQd/cVCY7a/eyf5gLfsMQKKJNLDth996Bm+QWT2iW6hv64jVrBMK+s9ebiZq?=
 =?us-ascii?Q?aonKokl85zl2blqobRPYe7t9LPPxmpHbxo0o1HnCRHRt5iLCBtl3Tin0gLpg?=
 =?us-ascii?Q?e7IFRIrtIeXJH2njaTND3E2nxePBdyyU8SIVaXkXoznL+VfV+oXZCDS3G/7s?=
 =?us-ascii?Q?lIj1NcqF01NG8CVpF4dg6OJVHlYvTufJEWYo7P/ZyLj103e6l0ghq8K8Y/68?=
 =?us-ascii?Q?IiTUxuQGYjhTo1ZjAB5XHO+6Xf+TGGyXhRFlwT9cNvKvy93xlg4muuy2HAIN?=
 =?us-ascii?Q?u7uDCfgZ5a0iONJrkhpUjDKXOsCT/W0nRcggaYRSTcSAByg4YZ+085fj9ppy?=
 =?us-ascii?Q?G2tm9wjoc6Nwq4FiCPHgIFFI6hGi6PATSK7DY1JxqCH4kLkE5HCHf/D6O7vS?=
 =?us-ascii?Q?u6kyeHE+P3VZR5Il20LTq6UzFuWhZxM5tjhusaR2TLneYeaoqQS0q/4CLssh?=
 =?us-ascii?Q?0gPwiLO/1T1+fcgSlOb9W5v4lNlHfjsGj2D8LAJvHg8z3Gv4AdzoLZrSkp8t?=
 =?us-ascii?Q?pAaML1aMuFNimLPWSTBRdEfD9Nd46pRlwMALo6+9xkX0HDbtebszVdyPa7tL?=
 =?us-ascii?Q?4VGHj4ib61PN8iwvM774B040bnvSChZbtfClm4+h7nWNBtVnNWjyc9dcpBVw?=
 =?us-ascii?Q?aulCq+YxP1yZL4A8v92e3SWZQdnOb7w6xh5UGTlNSDOYT523zhNqvGzeE7Qz?=
 =?us-ascii?Q?UNSiiMH/Pr5RekVlbL3KyQp05qZ7K+CTjXe5bgtk5VRf18vXxkvUrrL2/TBu?=
 =?us-ascii?Q?cW0adAMsNV+mkfpbQdKT5AVx6iqlTcvQf2Tm/HGuzW0b32/rTrDsTnDaHeAS?=
 =?us-ascii?Q?g/mHGAZwa0EwYj4m/8Uv1x+7B1lrA8Tkl1a9pViFGafS0Y9ZRLZYUbt1AM/p?=
 =?us-ascii?Q?QxraoViFj0e3tTr+9wtAD/I7VLcx98ajCuN47wP6SeiUPXLNYANOyB7a6CbP?=
 =?us-ascii?Q?OWLHPAUYl55+LCII9cCXBGDkaW99Juhjyyhn6ST+EMHYYhMnHqZp/heNmXN/?=
 =?us-ascii?Q?1HfsQ00MgUZIsOd8MpSi3kwvnpflJ5f++JmgqvPVBZVjFRDEkGp1c3N76xB1?=
 =?us-ascii?Q?4tTR0wgsUqk7NZigd5vvxOiZ64cZaMMBBf0u9i1VVedyND/JpNTlRBcTGYhT?=
 =?us-ascii?Q?Cf4r9TMGj1+zZgT6wRfdGhfutANLgd48C4GlpaNNAko6SelArV0qggtHki4K?=
 =?us-ascii?Q?Z8KzkVXoQANFXS0zt7pXj/DPoAhCkbxYEhgqvec/+4YD5BEMTi8GwLwTcKyq?=
 =?us-ascii?Q?dFjrtJ/QFVFTzjHC/GKAPZKfZeiz/DKxvUOk1EiQPPVc3SDmdWkAxrIOZ/dX?=
 =?us-ascii?Q?NWyYgcpIiGQ1vRT364d/wCMxTWXaz7YK6D1/J+gdKc06V4TFbw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?3j9EJ50htu+j1ahHrjqEOhz2U5qE6uFNx6GH9Ry+BYGVDvXQdzCryCSV1Zao?=
 =?us-ascii?Q?QRunLAc+CcqBJxO9VLwUtNaFTYO87/5aWtZxQzpe8suBy5MSLRQcuzxQIOXn?=
 =?us-ascii?Q?gcsYvynW6bDtO4i8y6adkyCZeHVaBg7/N2F30TqF2rtDCbLmn5+fV8KxbYvJ?=
 =?us-ascii?Q?PZ+kFKU29SheQiJNfodUTVYjzRkr1WiG60VTVv2FyLTX/jrLHh54SYiTVINv?=
 =?us-ascii?Q?W8kJdJiTDGJxTmIE8R4tj/VTs3OmHV70TbmPkwteaJKsbtd7kFjFhFqO2b6M?=
 =?us-ascii?Q?8VmD72MXrym5HhpB6JeMmfGqNIQu/kvXWh+qro7kanqRk/LSs1lXXtAkZoxv?=
 =?us-ascii?Q?B+AQBimZek1w1llSwmdUP2GRy0Krbwz/gHvAmYVxIFOYANJQ7iulCU0jDwP8?=
 =?us-ascii?Q?fSICJnt5p7EzV/XAcJtepXHc+SvCZQ+U33SFKO/Drb0aIHTn8eKzM+KUqQ1d?=
 =?us-ascii?Q?LTf8VfQVrB3ufdLyrKf9KGrGWv/WZ5K0WTlo25Tro3JJBrXZhQYgVB6WdL/Y?=
 =?us-ascii?Q?N3JDIOY8+h2233257v81rCpI4fAMzuxbt+rtPVoqmzoKnYBpLwNfoAaZbOwL?=
 =?us-ascii?Q?wYbtoJR3ToWtv/T+YhZYbjC6jQfYQ2fQ6iALmr4kgg1ZbN7C2h9N+NRxl+Pf?=
 =?us-ascii?Q?R9KhV3thC9kBsmFif20t3c+hmnjv5SyF78LxbzTO0J236ks4EtDATtch8fLu?=
 =?us-ascii?Q?Ei3MY51oZ6Yxx3f+SgV3jpFmfXi1Da4XSft6EFyeyJ5iuoKb9NGUFwAfor32?=
 =?us-ascii?Q?/VABLgMWYu3bSwrsVtcL8fHNWR/9Y3tlwpPf72TO1+EY4PPfgykAj6CAnfD3?=
 =?us-ascii?Q?dl2UonIDilSQFlHyiKcYjd6ULEcfi+6InSFRSUth2RT4ReNlv1tkqITYOfhR?=
 =?us-ascii?Q?5agzNB+2V9PKjA7OrhJA+5yCDQuKkumYIiqIrBU9XtVJkOCSBDW5RvwSv1xi?=
 =?us-ascii?Q?wT2UsA7NR2pejtNathpMaiOOSTfdU89OVtI4o0qDHYbaHr+qGZKID22L7oWy?=
 =?us-ascii?Q?O73BaXQpAHpf3mI5broLosB3vgWlosEG3AEDmeMwtTgEI6N2IX2yg/VczM65?=
 =?us-ascii?Q?Dt8ljvyrT5ABhV7B7Qsf8EBrF6bXZjW1rTII5uldrrd622z9BozYgf153fyd?=
 =?us-ascii?Q?GajTyf9Y4COqNbMlClKeQGmSIm2xF4xqsBcxwmtPOzaWSJS0B/Kk9S9cqr8D?=
 =?us-ascii?Q?Bk9T3H+28UGuePJDLi8taakFumIE8gsSPP+aL9iRPyABs4lFnye0cvysvH1y?=
 =?us-ascii?Q?LBvfKvbyq05X6YgtPaQ8kui4vR3fQDCKVjL57QNd+7cvrZbc8gFjQKh/MJ/f?=
 =?us-ascii?Q?C/IdA86e8RrG8Z/QhB/rowXVPxM44DGcbQLw01XfgNFmReq2fRY1UAobGd0l?=
 =?us-ascii?Q?l12W4Z6dMDMbxO/DVS7PKXfvTtNuA3ke7uv1KoQ6i6iXoN/RoTugE2n1IQr1?=
 =?us-ascii?Q?hcMUNdbpqIWOeVcGHA9EvnRIOdnE4G1QuJp4TltQCIgxJgIeazot19aiYh5f?=
 =?us-ascii?Q?zPTGYLaWQqz+B/R0jTnnQ7OyJw1fnSQXVmvay/L2GOMic0sIOXyksSvgm8uV?=
 =?us-ascii?Q?Ok3zIb0lv7jfd/qUJngcOy/M+a0wyXHq+YXSHtXE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4a9ea0-95d7-4e13-ede4-08dcac817a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 08:12:07.8377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kbjy8eqgOuTRIzd4bCKhjreNenQCRWYtv9VUz1Fr8GZfi5/B/9hIOXXhsQz+P2NTfL5BemCL+tHU45hHwcqwOI0UggLBC7kBwqEoBypOXwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11534
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Jul 2024 08:12:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16621

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Thursday, July 25, 2024 9:10 AM
> Subject: Re: [PATCH 6.1.y-cip 1/1] Revert "arm64: dts: renesas: rzg2l: Ad=
d missing cache-level
> properties"
>=20
> Hi!
>=20
> > This reverts commit f703a1ddec6a36b67e895921951666e0ffe58c54.
> >
> > It is triggering a warning on linux-6.1.y-cip:
> > "cacheinfo: Unable to detect cache hierarchy for CPU 0"
> >
> > Backporting the generic patches may not suitable for linux-6.1.y-cip.
>=20
> Sorry I missed it before. Can I add your signed-off-by: here?

Yes please.

Cheers,
Biju

