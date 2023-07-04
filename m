Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E1FEB64D9
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 10:33:38 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.101])
 by mx.groups.io with SMTP id smtpd.web11.55601.1688466815735362109
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Jul 2023 03:33:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=PzaY897+;
 spf=pass (domain: renesas.com, ip: 40.107.113.101, mailfrom: fabrizio.castro.jz@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npANnUEghSA0ehrNDXwhRHXWwUornXzHijlBbR1LLO9fvv8fls+PNTubDlrC66sKlld/IFWnHEEUh1gly0m54uNM9yPZVUYvGAMhW1RA62nCbMkJSkG7tzHu7EQ/3k28+Yewx+N2lBqdt8PqgEHwTPtlFXCbqnQTj4+kYuoZ2EctKyff2xG60oscUlLTdAmUdobex3C+pm41zTGONeM4WGmU+t/fzVqPlD3fmrHGCo5UenCgQO9fXbnjf+bXZDDfnKFPj8HuZ5oMemBCdvoS0RQ4om3ANJTAcePVzGMeTNUmBXAzv3AT8i3KaBZuDg3Q+9u7zEZtXnoAdAiTkKhOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDEqMad0di8LoTOPkpWPuyogYm9p5wMRMmxiwt1tMuI=;
 b=DGV31WIi+y+Czv1TK3w1JzyUCdbsik1SDw1HAWv5L9+AIMYJj0sTTAVXFRsAeId1kacnPZ4w6dFLdvTf4yCByCI4l/D6PADEB3WzDkOUo80DZ62dnxPZX9lWOw25tqGr6xw2QaBGDQZ16wBI8bXMMVomssSy7byq8tlcpog/UzFb4x/JljCwRuadrEiyMpZso/xTazSs9dnuD25ZDj5agCnoHDhFLpGui1pFgVZkAXYcQ6E2gns3nSXRvGFVLZGu0z8euc56q7k4SGRHKWR5tdTjb25wpsI4+DYVXTiZwdHBnC4FddkKlP/emtOioSyjZXy/Id3Zqef+YQazM9u0GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDEqMad0di8LoTOPkpWPuyogYm9p5wMRMmxiwt1tMuI=;
 b=PzaY897+FOeJzESQ4wMN5i8C5hhAAVOApyvsdmwedp2DpxRqb9w0TQHq1ybYkk9VhumD3R+rJoiHckIfofTWlsUSC7wtw3dDC1k7AiUZTDd0qN+j2HFeUx62yLTiUWVy21qm9cRJuxt2WrECOutXCn7pftv95PIxfHLKTUuNIVM=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYCPR01MB7751.jpnprd01.prod.outlook.com (2603:1096:400:180::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:33:30 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::16e4:67a4:68fe:f297]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::16e4:67a4:68fe:f297%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 10:33:30 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>
Subject: RE: [PATCH 5.10.y-cip 2/4] soc: renesas: Add PWC support for RZ/V2M
Thread-Topic: [PATCH 5.10.y-cip 2/4] soc: renesas: Add PWC support for RZ/V2M
Thread-Index: AQHZrdAmhEORTh9a+0me1+EhbGI3Ma+pBj0AgABjSvA=
Date: Tue, 4 Jul 2023 10:33:30 +0000
Message-ID: 
 <TYWPR01MB87752AFE6723CB34DCF625C1C22EA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230703170211.15484-1-fabrizio.castro.jz@renesas.com>
 <20230703170211.15484-3-fabrizio.castro.jz@renesas.com>
 <TYWPR01MB9420F2EADFD20272DE1E5588922EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB9420F2EADFD20272DE1E5588922EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYCPR01MB7751:EE_
x-ms-office365-filtering-correlation-id: 5dcb6dfc-d9da-463c-8821-08db7c7a1c5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 9MACa3f3nvWOTs3aggLjXRzci99kpUbaY4XddlboyCR6udGVqY64CrwlpxRQdMAwY0LYrYDa+aN5ZUIObG82w9SUi3axXWGoaLUAq6B05IPlbOuXdKiL8Aa+AooI6a7f42UcRD0IsHwShaCyaExWWA9FwtlWVD8qBqGJLAom+aGIHwgxHFN2xNl1gEPP0rAPXLiuDUxKtO+8HixNfh1FG4qt/Cce9/lJar2NTj3t6/RFWe7EL0mxmbkdDjIeMr/BE/dzt2tRzz3awk7qXWXoWt2Jbu+sLjCo5ieNO7YxNRsDp4k8lHzJXuZiA9hDxq9eGXdOiGV2Pjw87hFRGCrBgjov9ENZ0ahVGsYAvrji/Lf2qlNgD0hohAMkwu0I3mY8wLKaEEiRcT/Gr0RixXfnOhzTg2A44nx7VCcBNyNgMusOkM4VPPyEy7Rwh0xb1u6tQnqyVmg9TrKClmvIO2nk5M5p4vDX0ic6PSJ5w0vi3px4P028bG+IoE7W2uL4aV3exM1VEfvXReWvBtxirZB503vuaWNVTnLphvHT3m/YmsA+deExciKSOQ9Lr/PY1oi/LLA8CggQhBMEdwTuQug4/9SwIf26GmxsoVx/8oPCkyWH5edMy2k/g5QpMQiEj5bp
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(122000001)(71200400001)(478600001)(110136005)(52536014)(5660300002)(8676002)(8936002)(38070700005)(86362001)(4744005)(2906002)(33656002)(38100700002)(66476007)(76116006)(66946007)(66446008)(66556008)(64756008)(55016003)(316002)(41300700001)(26005)(186003)(9686003)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?wIRY6p4yhx0nDxu3Xi8tMHISY+g+xFtGLIO3RUBK9xS6HGuaNt6kYyUunU75?=
 =?us-ascii?Q?Rdbd9Vg/e+UiCz6NJLDbrgkzNaYL+GHdbHPjdK/5LUigrb2bLvzMlwLtu7tz?=
 =?us-ascii?Q?tJBRYcnLiTJqMa33szaeNC+huLpYn2NCxx8uZmtqauvgw8g8StTVWPbZOtp8?=
 =?us-ascii?Q?v+mIKEDc6oCYjop36CI2wITgzrLdYHjV+QtN6gRbLj3PeYcM2G3MTfbagtWJ?=
 =?us-ascii?Q?SZrhm7ZyHPR61P2wZ2y6Bzv29oKu2Fq5P9/ZEftvhuy3ldcLi+UrMLcWYjiw?=
 =?us-ascii?Q?mZ42YdINROjwXe6JwspwKhvuzkf9Z/8trOFYLDswMVnmBEuchOoSx+taWtu2?=
 =?us-ascii?Q?LhbRBvl4NdqQjH/rtABfZPmtWz9IZ6fYY4FlSygrqhSH925buTIkNnHiOerb?=
 =?us-ascii?Q?GJXvf2fmME4FwoofNHXu9aVcnf7KKxezZ5QGy/1uMg8TCEq1WHMn0n7CugGu?=
 =?us-ascii?Q?yqSf+Y7eDRgzGWaSE3LsmDSFUflwis2L8q2elpKayri0JeuQaZyxKBcXf+wt?=
 =?us-ascii?Q?tPKT8GoD5B25w/gx6SYCN905iIA8dHbCiO+/f9r5/WrIvtrJCDvtFyWQW0/b?=
 =?us-ascii?Q?uZG906ZXhKqtFFNrNMD99yauVNlA1FboCiYQ1q8EytUXPdpLV5YQ6E+HSLP+?=
 =?us-ascii?Q?olXN/YqCYSMPMksh0bc0qPizq0rkIHCoLZuM+Rwxf1SrevwcPAlI+adhAZRS?=
 =?us-ascii?Q?Sbaoak54yKj6p06bSIADkWmWHbamWTsGaR3f19sDB36fy++6XSe1Zu9I2haA?=
 =?us-ascii?Q?hkaFPODEirv3w+3AIxec+SAvcxh7eBSHArdfxK+PoN2/5SPvP5x9JHFHGtl2?=
 =?us-ascii?Q?qfMfpYbdzf6w2m6e4honLQ9IPRxif2RA/zRk/YmZY9L0C9Zpyu5XBanBPbH/?=
 =?us-ascii?Q?dewoHseK6pYMWZIxs4sIAlR8W953UcDqdCZg70L4DqTrMIhZYy/oGTkDYWiG?=
 =?us-ascii?Q?wP4BX3Do0qOWxZT5Opsor2GKTW2jANcGh48tDmzNHudrEZLkarj2v3APFNAz?=
 =?us-ascii?Q?eVMkjecWQ3JFFGcdYAACesLq3NiofuQJuN8B237AU7Ztotb/UnX8pgz61ZJp?=
 =?us-ascii?Q?VfD4wZxTL5tVm0aHdwS/6X/5Cq7cab2oi3bUfbBQLd/yPhzYtLQh0jiiGEu7?=
 =?us-ascii?Q?z9jrkpWqrUu/YUbeG/SQQzYPYqvdeXxWJMlXTWy6XvanzQXxWUmhyGDcFwBh?=
 =?us-ascii?Q?NBeF8xbCZz3bAIscH7TJfzgZeRmQfQC9oxH/Bs1XeCIeFtgEu78w5uapnXrf?=
 =?us-ascii?Q?obA8OGmOcrECICQ4lweqPAjaTF1BeJCsvmVYVIO05LY2gkW8j0xgVTz2JneT?=
 =?us-ascii?Q?d7e53OD5CxSvg0kNYzOHpjMM+SM67rzrGoH70PZYs2Laq24lnLHe1iSX1WD3?=
 =?us-ascii?Q?j6XjegPPS+ZrUzScISwb9PhsVKE9FxgAYzTxXWR/vXLlzA3YXxZoNfKXAZft?=
 =?us-ascii?Q?RQFxL0RRPj8852hQ+6v2QHspyjI/yvjaTyfQ3MZSMNWnh0nKTK4VyP6hfDU4?=
 =?us-ascii?Q?GfQhx9X0c4LGkp8lcNkhS2as4V7kbSlEZ/qnjrO5YUgsTOtkMP1+AiWdagNI?=
 =?us-ascii?Q?LwnRdJmFhBfL819eXLlec32H2SK/n5oRx/lxJAixhNUzGgnsw8TQcj+hvkr+?=
 =?us-ascii?Q?MA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dcb6dfc-d9da-463c-8821-08db7c7a1c5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 10:33:30.6203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ACYQPUaTvGeMitioYGOthgHvMMbCaIGF1db0DfZZdKJerCbI5GM3ue6J/p52mnGsrWvhmqJoVB8Z8gsd9Cpc5qUU4eysv6G6tlmNwaIZXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7751
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 10:33:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12212

Hi Iwamatsu-san,

> From: nobuhiro1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: RE: [PATCH 5.10.y-cip 2/4] soc: renesas: Add PWC support for RZ/=
V2M
>=20
> > +static int rzv2m_pwc_probe(struct platform_device *pdev) {
> > +	struct rzv2m_pwc_priv *priv;
> > +	char symname[KSYM_NAME_LEN];
>=20
> It's not a big, but we can declare symname in ' if (pm_power_off) {'.
>=20

I'll send a v2 for this, no problem at all

Cheers,
Fab

