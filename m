Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D65C282EC
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 08:45:18 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.29])
 by mx.groups.io with SMTP id smtpd.web10.47568.1742201115489740270
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Mar 2025 01:45:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=fE29q/XV;
 spf=pass (domain: renesas.com, ip: 52.101.229.29, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvLgb1mIHd/TclwPRM06vVVDC2XK2fvdw9sg2cbHE5Ae32RQeXKlLIaVQT/dO87PFZnCWtFjOjur5QBMowGpJKSu95ho1efiZRAjxwn3vfstRnmSBZ3X95028uQnrZR03iOkJgj/b0nYgsNJOk7AtiJRg9+8sdXg76YK/o+0J4qfUBV6GZq9QKB6r8tXaz6vvwbDDA1k/3WB6Z+8vUMbQKWpy+DwWcIxiHd48m14sWaaDk2G2LEHTp+JVADR8hy2zoSwipFBg21YwRd3s8yvzGBijp74XEyA8Rq3a5RcY9ybmGQT3SqeiQPbSjAFPfG5npvvfwE4RV68Be4XIry09g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsmp7clFknEacrP/0cKr3pLzroalb/L47B0/VqziaXQ=;
 b=VSaRBiGtLdh/RyRpzzlq1QpNCzQD7uXLo3sZ0l4PdelP/vHUPwRyEXRzbqkSn8xUNd0wYK59ctyAMowquijfTJV7bvU4nGWifehitTIeyqMku+VuiLpiCPOnfGxq39tHtpDbwrzsR2s9kQBEDhCYlkfF1cz+xZj61loJd4YXmpv8/fPEhISpjCCLddW4RbvYlTXpCJH7kvC21lyOItaBPlqHRS2Ndb1uQ3WQ/hK/JPfaekAYc2ZX6y+hoFFwo1wxL3KG7RyeMWS0iglSF09rQKS15SlZ+bI/pzxcVDwwnc5LwS27B7sxntzU4s1j9aPzbYCeUDlsh/gNM5TYwr63DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsmp7clFknEacrP/0cKr3pLzroalb/L47B0/VqziaXQ=;
 b=fE29q/XVOpbkJ5JgTWSANoxI+X3DozwrmEyjCS8zsJuTG7AfmvtLTCr2iNFyeNo8UKiWboDDrBDWwMBvIGiKaADJBHDgzQLfryiAfYQL77PP2UDPxA8BUsnCylEcViSgNbQeS3oOu63s/npIV4z8rBRgR+mmZHd/o6MMA4NBZvU=
Received: from OS3PR01MB5896.jpnprd01.prod.outlook.com (2603:1096:604:c6::8)
 by TYRPR01MB12789.jpnprd01.prod.outlook.com (2603:1096:405:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 08:45:11 +0000
Received: from OS3PR01MB5896.jpnprd01.prod.outlook.com
 ([fe80::1b62:57c6:c2cf:641b]) by OS3PR01MB5896.jpnprd01.prod.outlook.com
 ([fe80::1b62:57c6:c2cf:641b%5]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 08:45:10 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Tommaso
 Merciai <tommaso.merciai.xr@bp.renesas.com>
CC: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Tommaso
 Merciai <tomm.merciai@gmail.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 00/85] soc: renesas: Add RZ/G3E
 support
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 00/85] soc: renesas: Add RZ/G3E
 support
Thread-Index: 
 AQHbk7fDNtmVaM6CMUi767vMM6EdLbNw5FCAgAAROQCAAXSOgIAAF1gAgAACw4CAA6N3AIAA4aCg
Date: Mon, 17 Mar 2025 08:45:10 +0000
Message-ID: 
 <OS3PR01MB58963E92D4C36FFDB75B271DB7DF2@OS3PR01MB5896.jpnprd01.prod.outlook.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
 <Z9K4sW1iyC+0lJCg@duo.ucw.cz> <Z9LHJC92Bp3HxjT2@tom-desktop>
 <Z9P/qUzPfn368iGo@duo.ucw.cz> <Z9QTPtKb5Y3E3vqP@tom-desktop>
 <Z9QVjxYJH4OSm0sP@tom-desktop> <Z9ci7jj/Dne7qADQ@duo.ucw.cz>
In-Reply-To: <Z9ci7jj/Dne7qADQ@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB5896:EE_|TYRPR01MB12789:EE_
x-ms-office365-filtering-correlation-id: 9baafd22-3030-46fa-7a4f-08dd65300724
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?5VAna6WEdCj9ApfgHhyQHB92t50Q7xjhDTeL3E7i9iBeQdl2bC5Abuh0?=
 =?Windows-1252?Q?B495gasSYuKP9jjcMMFGAjXqgRdZvuvs4Pol//dK1MV/+Do+VwoAQg33?=
 =?Windows-1252?Q?KQx+C8G5vhrkJOw+XoV8K6r+AE1RRs5ZUQGzhf5sh4mgqSyZgNDO9xHB?=
 =?Windows-1252?Q?bJeLE6M6AC9WKiGyUGNrk9iRvah40imHtpdzuWu/I0ykDyQqIkx44FEL?=
 =?Windows-1252?Q?vtLNdgoeupFzLmI5DGiyUp3xi4ngHN3Bz+L+tLuWpitICdgUyHVAp6uF?=
 =?Windows-1252?Q?j8ER8+4pdqs4dxT9XsflEw1a3kDN5U0UE1LVsndbqIxUkZAqx8hHMvrN?=
 =?Windows-1252?Q?bYdvOFqxywQc2NTmopegYWo/CUwqKuECXvPno7Nrd3vGMkuNB/9NdsO1?=
 =?Windows-1252?Q?CGWDXZC7obb8wBv0hWr6Y3FCrHNQzksnqxleny6JUwxXjEoju9a8EPVS?=
 =?Windows-1252?Q?xY8NrHVcO8O+qeniQXCKgWZflRwyFTRNbQ0Nvq2xKOTveKSrKz6YGO8g?=
 =?Windows-1252?Q?J8cq3eR7s5A+Vkqan3N6MSWly0CL1lnIJwBtTcoviD6ZVOJ7TO+mI4+f?=
 =?Windows-1252?Q?cXhn+rd1KSZ0PSJdZOh6akV1uk6RffvjAqzuxaaDZNHpiqWyw1Xr+5zA?=
 =?Windows-1252?Q?xGqKrXT7uqXzPFpTJEqZP+7fImffpmZRZFXbbV1HO9DtNjqbA4kBCMWP?=
 =?Windows-1252?Q?fEfc5S0xogneuFkLPjhV8B6p+uAccpS5/NgkyAYWOT/rxD1PGQTgaNeY?=
 =?Windows-1252?Q?M/riP+VKRIQbAozke42Of/VvScWV1KVNlVc3d8pcZh7rTAQS3e6a1JKO?=
 =?Windows-1252?Q?l6g9IQObhWcGOIuI82D/jiOb2yxyNSOQKfr79mRaBDjpt9rhRExXfc88?=
 =?Windows-1252?Q?axxdjCu4EnTDVJyo6Y625ZypZrAICSK2D+Zy6CPJp1mWQIvwRvAucws7?=
 =?Windows-1252?Q?W1S1EkJCze6d6JGjEaZ3chfLX5Gl65+DV1FtHfkSqzNDeZnVoTSly5dk?=
 =?Windows-1252?Q?AoINfa8W7UisoELmsBUMd5jTemXFVO6x/3NnC4VItQM7B0Ide4EXidCn?=
 =?Windows-1252?Q?IS/T+oCyg8IHdSPzcubWeO3V19cadyLQ/rC1k5FXRNrqqGx/mnoVEfqI?=
 =?Windows-1252?Q?3TrlufBe5Ay9jOFkNH4Rx2+WPeb0gaRTxD5eCZrWogl6BOVm09pAwTW+?=
 =?Windows-1252?Q?MiXmQKZHFb/lCLoRL97oiyQQSktiT42B+WSRVGzMRBY3mGlkvMzUmjXE?=
 =?Windows-1252?Q?c/eWFp86KzdfaIGwt1u9Mofau3Mxnj6vH/DrDtN0MKNg+A3E+3Fq8bL5?=
 =?Windows-1252?Q?RSBb96J3u+nioXMzPpJX35jDcCLEwSyZd2hfd713Rvpk38kvf719UJMu?=
 =?Windows-1252?Q?aCOOLvkUKE9y7lAmBdjgB7q0FfixZcLM7nR5PqVZxrIT7VLj7gEyBIJQ?=
 =?Windows-1252?Q?9cxFqrYoodrzDxfea1Z1BYQDuO1vyJMBAl0btcaCrcurR1dC30J1WXvK?=
 =?Windows-1252?Q?bomZ7ZTK?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB5896.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?MjVJcwQpd+grU7SIWbYzLK8UjNFA0jdNyts9NEL7oPLYOteYTdiYdAVe?=
 =?Windows-1252?Q?9Mf5AlnnKNlkeaHFSb5rRkRYSmhqqwcWM4aiQuxJjEA8oNTmcRqG2n3Q?=
 =?Windows-1252?Q?Vw2t/Oagk9KoPg/otJQhyVvAx7Wj4BU+MQz+3vAdWTE/U2MJPw3F8+Wv?=
 =?Windows-1252?Q?9rU+fckq7hsIqvQ47KI1yLPyi38tUvTM9fk4tBHtwgzfVnSDcyB/pKMp?=
 =?Windows-1252?Q?8upHS8eVIl+966v7rQKF5Ybxgcq3szbkqXr8CyrG9Nq/tsSl38OAcgxy?=
 =?Windows-1252?Q?FAEKBCZm27UoI1ON1BrETalFGIPvn1GO4tsL7dA+Y9/Dbx+ECBBakXFJ?=
 =?Windows-1252?Q?nQxp47QliNqZclTFZ0Q3pOzDaLrDn9CDzrnDfYID9eq/os6IW13sE8Mg?=
 =?Windows-1252?Q?dsVI7c/C3ew/EEWh4DO1ohd+M21E1ZaG+EJjY455k48wCHp6WhdMwQhH?=
 =?Windows-1252?Q?FOcKW7Rf4gPH6VnRLHTvl8botUzYcUXaiJTicKtf2SHljkqorubCl1jf?=
 =?Windows-1252?Q?+rNEyu6kouZDnUGX5ZHcaWyIJ+8ksMFr0tOP4n6iaaZLWhf9gpnjBwg5?=
 =?Windows-1252?Q?zDoPizDE+5RAIIwb2x55E+VG7juxcM2hyljEOwWf3HcOFqIsjJ4DvHfV?=
 =?Windows-1252?Q?QOxzznxfVChGI9MTzA5FpnvwKQdC/yjatv8Ffy6nGi6nYVSWjpGFyoJt?=
 =?Windows-1252?Q?iT3PkiBH789tGS9MnDvNLx3YHNZM4fTnq9qCJj5mJfrPG0Ky5hwv67t4?=
 =?Windows-1252?Q?GZmuy+RdFk5floQwdCKBl7LrURJyZJDdefm4Ku1sOGcIM+PeycviHscS?=
 =?Windows-1252?Q?SWUJCYRAreNknoty0HaNiu/JsZNqFSjgyX6w+nIlPwuzI7cLEb7jfgFy?=
 =?Windows-1252?Q?ycW6cqXfEG2N5DAZutsTuRyBvP9vme8X0fvrB0QllpcL6iHNL4R7tXN8?=
 =?Windows-1252?Q?GHsEuHjTsNXnwh2fLqtsvDcUbA/R6lhdEUk6wfTpK+F2AHW1/fgct5v+?=
 =?Windows-1252?Q?uwQhmrBAXprZPQHDfL1fnMCdqa1g2kosteiKmyUGqmt9KP3+mXr6rdsM?=
 =?Windows-1252?Q?qfapW6t9cZPJd7sATAW4uJb+hxfP6JBU24NxrirbR/AMT2VVcLxLfNEs?=
 =?Windows-1252?Q?F0pQyl48y3keZwpX0E88ft3J8g78jhQA+vmYkJO0hztCz1eBbz4d9CsV?=
 =?Windows-1252?Q?8Omcv91oqNaYH3oxy4/MpE87f2+fbjJXpuKpq2A8HS2D0YsCI+DV5BEp?=
 =?Windows-1252?Q?IYeH+CMvYFrNLniEwKy2LTo+dYtEsbQ7FDw2GqpddqyzzR1EguNApHFu?=
 =?Windows-1252?Q?6vw3QvDRPBOwGWEAjjCGeX3BN4xXi+QTlydVj6B8HzOPW0i+elJMHvzh?=
 =?Windows-1252?Q?z3yyfBKeojTm4dFzDsg+rMtCvE0XIGZE4owo8yW+5P04bAnrD6cp0Ck/?=
 =?Windows-1252?Q?G3u1VjMBjWg3JpXdo3XCxr7ZIbuUrfJxNH3H0oFuCvhIP6h7kbBmSCt3?=
 =?Windows-1252?Q?N01w84tlkRJX+I0EhGy6FmGGNQGPQEwgP2DXyulHVkOhAhkkqlyzH7d4?=
 =?Windows-1252?Q?OUjP8IljoAa0NifY7IOYBHS3OpqAqQRMxgu34dPKTjDEMc3V+oPpUuUq?=
 =?Windows-1252?Q?cQbyjZRdooLsGKigJYSZSf5yNCEuruARU8EpFszZfDshb5mXS5DxP0rK?=
 =?Windows-1252?Q?EEYlpq0LKzqWH9rXWRTOESMacXCyb90pvDQt4laRWWujrrmmJTvOQw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB5896.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9baafd22-3030-46fa-7a4f-08dd65300724
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 08:45:10.6740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2YfcB7912/UQiZfxXAV3NCiTSV+gsGcUzcpu6UCTYg8zg6g0sk7MRXCXZlOBwKVHU2tu5C33y1KSjGr8PQ7myDg0tFuYAxVr+471ib4Aw7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12789
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Mar 2025 08:45:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18221

Hello Pavel,

As always, thank you for your reviews.

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: 16 March 2025 19:14
>=20
> Hi!
>=20
> > > > What is relation between RZ/G3E and rzg2l? Because early patches
> seem
> > > > to be for rzg2l support, not RZ/G3E. Splitting those preparations u=
p
> > > > would be good.
> > >
> > > Thanks for your comment.
> > >
> > > RZ/G3E and RZ/G2L SoC have some similar IP's.
> >
> > Sorry, to be more precise:
> > RZ/G3E, RZ/V2H and RZ/G2L SoC have some similar IP's.
>=20
> Thank you. One day I'd like to understand that naming scheme and how
> different SoCs are related to each other.

This guide can help from a top level:
https://www.renesas.com/ja/document/gde/rz-family-product-part-number-guide
(note: not all the latest SoCs are in this guide yet)

However, there is no definitive guide as to which SoCs share the same IP bl=
ocks.
A lot is shared, a lot is not shared.
We do our best to reuse drivers for the same/similar IP as much as we can :=
)

Kind regards, Chris

>=20
> > > Fully agree.
> > > I will split backporting in smaller patchset as you suggested.
> > > Thanks.
>=20
> Thank you. I went through the series up-to 23 or so, and it looked
> mostly good.
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

