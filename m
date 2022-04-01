Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A793C43219
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 14:43:48 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.97])
 by mx.groups.io with SMTP id smtpd.web11.3312.1648840827418863122
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:20:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=swLz3AZh;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.97,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJg1yjVDmh/d/xMDDfpfj/iJ0VztvACxzlPlqHG8oSPpFgUKSF0LOSuNpSl4LNVNCpxGbdTi38RmmZl8ngXlH1L+jR0uwcATZLxQGNLqgYNMgRVnesVt46MsCQSPGfv+Sg4fNan62IwSYHy78u2EdMZ+UKnurabQHgOBccBlg76z8x7ssez5sJwwbapo4i0mETbMroy99vHC+S+4z4lHn3S5UO1aWJWlWsD33K3Ezt+VukqFaJ1wnBmFtZTdkYgmopKmtFZZ7deBlwOsclVdK9PpdADOnzw7uofkPxvI7VzS6s0eq8Zd0Y99DMMPqmOMLC3/Dtoj4yMbNXnKsirm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GS47cSKD26bvTHCgE8lJjTvwYmD9OPP7nTguaZ/EMFs=;
 b=UYwNXuPfy7F1KhS//molXEVKmmZU/wcYI5qPu8SAHPUvzXUrcSEaegczT+7Eul6kIK5HaBxo+ago+Ts35l+4SkOp5TLnyD9K3yxDEc1wr3ELXZ7wri316aPtw4eGbFUlxcnHBiH8QyTpRP6qAML1lRtT3DH8tcSOkkKDUC2LCJZkL4w84tBlMMuj0pOVgPYygr3FuBhd9v0SwUfy8Zvt+66jFyzw/WXlhqwMXVr2df8SJUkVY9jlRHEerk+/nUemIHVpVN9PQO2esOv6SCXlpXvfqCPJSGznsUf95qCA2AQ1lDtrKOiEMLZDlNhpMctpg/IzmyRS/+ijwxAP39IrLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS47cSKD26bvTHCgE8lJjTvwYmD9OPP7nTguaZ/EMFs=;
 b=swLz3AZhixgIFlRrjm42Llt8PLk4p7Q+OIx8wl6KASozPSwJMAdsINOaLqlBAF++bS/FjxwG1hU2l6LtmSkdB953Qay0msjqxB8zBCCLMmm7zIwh+f+j5iQdlhQpw/0+0FFwqJiLeYepexryflAR40sPP57OlYpiUE8/XUAEETc=
Received: from TYYPR01MB7024.jpnprd01.prod.outlook.com (2603:1096:400:dc::9)
 by TYAPR01MB5040.jpnprd01.prod.outlook.com (2603:1096:404:12c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.29; Fri, 1 Apr
 2022 19:20:25 +0000
Received: from TYYPR01MB7024.jpnprd01.prod.outlook.com
 ([fe80::9ad:c691:48a0:e92]) by TYYPR01MB7024.jpnprd01.prod.outlook.com
 ([fe80::9ad:c691:48a0:e92%9]) with mapi id 15.20.5123.028; Fri, 1 Apr 2022
 19:20:25 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 13/39] mmc: renesas_internal_dmac: add pre_req
 and post_req support
Thread-Topic: [PATCH 5.10.y-cip 13/39] mmc: renesas_internal_dmac: add pre_req
 and post_req support
Thread-Index: AQHYROhWoUMvqXbZ1UugXkf4xcO2QqzbcQ6A
Date: Fri, 1 Apr 2022 19:20:25 +0000
Message-ID: 
 <TYYPR01MB70246D94262A377B4C16C494AAE09@TYYPR01MB7024.jpnprd01.prod.outlook.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220330185454.10887-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220331101603.GC21513@amd>
In-Reply-To: <20220331101603.GC21513@amd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c12e00f-dbf8-4da6-74fa-08da1414acb6
x-ms-traffictypediagnostic: TYAPR01MB5040:EE_
x-microsoft-antispam-prvs: 
 <TYAPR01MB5040FDA3DBA02989812EBA4BAAE09@TYAPR01MB5040.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /t0+ZDP/XBGWsQSQk7PhFh77JXb04+dp/ctMxM9PAn49ef47ImbkyTlPmgFQycyRXc2JGhCeSzEf94UoiaeJIgFjvyySgRtlVNcM/XTdXiXyB4PPu8X+eOuy5CopSfIySANCn2iHTZRu9+6FZsXeMt57UN6hfpK0pcWnDcllKyTuj3mVTfIjBuaaRk3QdXIGuVx7s2yINwYomlM6v1xmcLr8Hi8yHc6V1S1i7CNVs+UabAlbzpCSRtBnCTLioZk37i1vN8P/p8FQwZ9+70FxETGQJSW689qLc/HAdGscUmsnH55m64wsHvNBY4N3G+eJkVYFfYTyOA08zIRhViEeRU+reDYB7QLLvNX0FGIl6cq/WHzr4sqeHuuZ0/oxHe89nuihyI0BU0K5lVf18C4qvscZ8ebPV8MxghqvpvBHw2xpik+0fdrp9P3OA4JFrytgXh1fUfZQ4bhk6Obwis7JIorlxpxQQQVOc21iv+BUXpOsuG58ACU10uDbj93FRMwuRzKgneM52d/PzntRMyofy2LOZuA+ZLeIVP8Ky8aS0hrjTkqqOZoNg04DkUinfD8aaiH/b4p39H1zhE0MnVVZqVqb6FxhVhOKroFtMJ9txt6IGqmcaPtYkI88xFLk6pW3ebvqb+Ovg4T8mPH9RhlkmuH7oJB1/svyJUGpcdzABv1tXN08XTaBlPMP9vG415+j6wwV4aCT+3tC3WJP6i2cSw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB7024.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(107886003)(186003)(26005)(83380400001)(38070700005)(122000001)(38100700002)(86362001)(6916009)(316002)(2906002)(54906003)(55016003)(5660300002)(8936002)(52536014)(4744005)(76116006)(66556008)(66476007)(66946007)(66446008)(4326008)(64756008)(8676002)(71200400001)(33656002)(6506007)(7696005)(9686003)(53546011)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?B4W7yzrOlsdNF6LB3+maN2ahzhEIcwXNOKvt476sI5ssIq54FM76xsginZ4e?=
 =?us-ascii?Q?WVTa4bZlBPHNuABSGgiTtHgFud1DJiiUqgvJR9m5yunH4+hsaaCmCWtMOemr?=
 =?us-ascii?Q?GuWmZ9TDlyqPYH4X7Dtq640zrQ8vMfQyJPxTiXh1Km8RD1tM225PKIOmwu4F?=
 =?us-ascii?Q?ryY1QBxaIBqSe4Mp2hSmnFcADRBu6XPZ1K2Tb4c/Ypy8c0wXeCXDghvnWvja?=
 =?us-ascii?Q?H+/4o46+fSjXX3EYY8Dg0A2zvn5vBe1pMs9l5QSyN09rDrHJdmBNDpoJoYI6?=
 =?us-ascii?Q?vYQKVlQPBoiNb6xySEg5D2v8Rhu2gzWA64qNCEMERvXOHKSiFwz/9/jT+nyh?=
 =?us-ascii?Q?43fPAXsXD0o1otCN2J/3SUP++c3OAttETbAXt50HNMGEKf/a4gZv6eEI8nkP?=
 =?us-ascii?Q?/U4dWd/RcjW/UCXMC3/32iJzWAmzrvCwskWdZ+7abXwUe7uxN6zYBkH94nsF?=
 =?us-ascii?Q?8eoZhGAijasuBS8FKoHojnvBhckrYvVZdWM/QZ1nH0gy9iRUfre9F4KBC5vM?=
 =?us-ascii?Q?PIE6JvmehHWL5n9+O9K9zh11bnOkXQLiEgAhrgUtBgz7M9eGrji6edwfFKVT?=
 =?us-ascii?Q?xR4GWizPEdPeJWNBXDw0zUxR4bsyb2jJa8zQRyFV4iwbaIl8NYRzLScOyJ8a?=
 =?us-ascii?Q?l/2aPBzZWtLvY94YpwI+Z+ua8Ymuj2EO0HgiyYctiQEB8hlR0QxeiLheFfNr?=
 =?us-ascii?Q?nCsSeCnZtT/mFOEsjXpEuGFruyXuMiZ7EmYnvE8tAWsd6lPXW/QQSDba1MFo?=
 =?us-ascii?Q?yS/GLiMN3Cot8PQYMkLXrUj9RhUehgj9lcM4x0bMZuzm/bgTBlQJcoTMoa3W?=
 =?us-ascii?Q?X9FsJyxT11tIEd/BrJ3/j49omM3prBTnmE6y0G4/k9FmZ/W1IDvnAS4ig6o9?=
 =?us-ascii?Q?SLXeeIW2hMz/KH/DNEnrTyevjLDdKym7OrQUTs3yk+nmNitRM3XyeGeG9lH+?=
 =?us-ascii?Q?1hMBNuwS+j91X6tDcDPDnM+0GBYky0THz0XSmDI8kvisKoqR1rbwSCbktcdR?=
 =?us-ascii?Q?EkIASlSWnyvxjIvjDP0Q99gyPKIyNkpymRIhVkEZ6BnRAWUCq0muohlyUm6J?=
 =?us-ascii?Q?FOT/cUNAOCVI8gRqYcrB8eCkun2RHgBP1EomtqkGtO9qEGfoOL4yL1X8tMm7?=
 =?us-ascii?Q?dUK6pcOjpvc7n6xM7fYMovAg86FlcdrTE8FiycjrnDeyqRwtVibDfAJl8LSy?=
 =?us-ascii?Q?TypGpi3f0COJcUmO2gEVFVlnh/AjFFqTmBQGpKB9qEIrxfebaw71fIvNp1WG?=
 =?us-ascii?Q?REeF1dN82rCUySX/PtHFtINkNd/tEc6ji9IbcM6DftRQX3/smuTU6pq9zKEd?=
 =?us-ascii?Q?i7b+Z7bnXWbC1Cf4TD/1chxiD/C36tvyFZfcj1h1Ki9AvUfYl1B7/BUWGBy1?=
 =?us-ascii?Q?14xr1vaY81NsqEzQCvjbZX9h+1357JhenlVm/tJdPVzwesGME4e0fy4J3bwP?=
 =?us-ascii?Q?A2ETBW60gzRl4GFL9lnWeFUQ4TzaNkn+hMXk9Wv4DoS0wl3xKL6qhtywkYyY?=
 =?us-ascii?Q?VTwbKrPuX9GoCdy27oPG1xr7Aj+tfoQgFmGG+/mnF+vSVuzwupHUnHxuXKjR?=
 =?us-ascii?Q?Im5QttSFpyQ935AqC4iJoh0oPMox8GAOMvAXK87XZ1GOO+iKsEhra6v7Pa1H?=
 =?us-ascii?Q?TPkaREiuA8j9qT3TCrAVgqrAW4tSbvuX9j6/nlRnNgyOKb0QnLPHCDwgJAl+?=
 =?us-ascii?Q?Uu7vRNLsO1IeBzHVq9eyOct2X8I1OTDCjJjWcxI1RktfQ/fTitlALAnRWyuY?=
 =?us-ascii?Q?Uv0oZLmihLNLRAAw6q4yGXjEHJyjqkLmKWgkRED/kxmZF/i3Ra1c?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB7024.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6c12e00f-dbf8-4da6-74fa-08da1414acb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 19:20:25.5261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Vk98TaJnR/33jLwQWWKAyXep0Otc8Gb7s5Ak0EzJEhYhCts5o4N/yz/TCq/AEmBqtrR+HzCbD5OJXYe3OfeEmo6EVI5ckK5xrATJekZKaY01Ob/PY9DZ4zqVHm311DnM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5040
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 14:43:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7906

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 31 March 2022 11:16
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>; Biju Da=
s
> <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 13/39] mmc: renesas_internal_dmac: add
> pre_req and post_req support
>=20
> Hi!
>=20
> > commit 69e7d76afdb54243df957351804c0f1afca46d0f upstream.
> >
> > Add pre_req and post_req support to improve performance.
> >
> > Inspired by a patch in the BSP by Masaharu Hayakawa.
> >
>=20
> > +/*
> > + * renesas_sdhi_internal_dmac_map() will be called with two difference
>=20
> "two different"?
>
Agreed.
=20
> > +	/* This DMAC cannot handle if buffer is not 128-bytes alignment */
>=20
> "aligned"?
>=20
Ditto.

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

