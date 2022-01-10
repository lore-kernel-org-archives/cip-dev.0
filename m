X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.102])
 by mx.groups.io with SMTP id smtpd.web09.36647.1641842283385782109
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 11:18:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=RnBhObni;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.102, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7OxNsLvw9jSsKCU83pYVrQLR5BYWPhnpKglEDL6avCeLN1Vy0ytPuW/5qllmvmxn17kWRxvVTd/PHvJ8M88LP8mpPUDqUFz6Sb8UibGwDrGg0vrumsZx34x5jWCCYGOVAzdTgo/N8oLBFlFvMdMcBokiTIZnhk2J2vT5fi5GGlO6Pb2qJrkmEGvjoT+G+jwrOYkmmMOYg20viBQUeriInV8U6dLXn3dWO6ZYOrW6xxigqcWHDXm+4PdSA7tDh0x7DfBLszoq9nxaNqaCA9FYIkmaye82ut+Pw4Mru6m+2DlD8uztKuMLQpjMA/xnG/XcFeaIdOjKY7Q3rZTpO8BUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wIlya4vsOIwb2xe5XQRhZ6p3yIbxNb536AZWP7C6J0=;
 b=Zn6e9yVInuOkCJ+B2xZyL0KW7fa/xpk8efbGMcFi2isX42N4KeGAzcLwtic4lGf3uE7JpW7L6bUHPD+qEca9VaI36SkAydn8dGTSCdi64AExM/Cba7tBMIu7YZQx8hOKzA0PIKH9clQGh6LNa5VR2T4sJkY544M3kkAF56/t8hb9h3oOLHf6EdLFvus2VH6pjm+HyVk9/zuuyCkaWUvaThZFx8dejDhwnCAibkQveWPVcpuBt/eGCFIihLv5dibvF1JdZBblnB0quLO3p7nER6c2SW/Cn/AR19fLlXVxGS1+JiP1+vz2GdeS3KXICpaQyQm3B+Xq9F9b2pw0wFIFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wIlya4vsOIwb2xe5XQRhZ6p3yIbxNb536AZWP7C6J0=;
 b=RnBhObnirKVXhP1NYe9euBKIsNjAiEFWjo+wnEVK6rgMCbLR3HOofHD16V9e6/8QV7Zt2G5QOvEq7uTLir1GiyBJheI25JdQBwBG8QkxJtc+MqkKm6AiC9RhVl+jp0PJir3nWfxqlpcj8gSZ8dL3o7vgiRAgDFyBHVoIA5bS6Ag=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSBPR01MB2517.jpnprd01.prod.outlook.com (2603:1096:604:1e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 19:17:58 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3847:4115:3fbe:619]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3847:4115:3fbe:619%7]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 19:17:58 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>, "jan.kiszka@siemens.com"
	<jan.kiszka@siemens.com>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: Inserting patch into history was Re: [PATCH v2 5.10.y-cip 15/15] clk: renesas: r9a07g044: Mark IA55_CLK and DMAC_ACLK critical
Thread-Topic: Inserting patch into history was Re: [PATCH v2 5.10.y-cip 15/15]
 clk: renesas: r9a07g044: Mark IA55_CLK and DMAC_ACLK critical
Thread-Index: AQHYBhjINLunRuMl4U6oVL9ByYP9baxcSr0wgABKMYCAAAZB0A==
Date: Mon, 10 Jan 2022 19:17:58 +0000
Message-ID: 
 <OS0PR01MB5922CE45A48FB7AE84CFD0F786509@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220110115348.14297-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220110115348.14297-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922EF302739734E1311CBF486509@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220110183329.GC3396@duo.ucw.cz>
In-Reply-To: <20220110183329.GC3396@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b766acd-7015-46c7-2dd7-08d9d46de971
x-ms-traffictypediagnostic: OSBPR01MB2517:EE_
x-microsoft-antispam-prvs: 
 <OSBPR01MB25178CBB11651EC8DFE87CC886509@OSBPR01MB2517.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 FsVLFnkRIVTXiWL1spfq4PhW6K5hvzJCdBvSsuWKkyIRHt97M3GQ2ricVacJ+4lOUQseAcAsxGWwVb/fJaXJojHj+oK+CED+SL2MZsYEggL/TnkpwKf5oFgIUKbBh30e4tufAzMiCQYiKBXuiyuzdhsx0BSZfBcwfrvJB+iMK2mnEf0P96oP1PBdSforbjVVxF8JQA0lNCt6XWfik4WfmTdWOCLNoCLS2ASPdlrvMK2y+APY7opz79QfoCqVg0GHD3JapwM5NqDmj53FO1T+nJBRLOyAnKpf1XgfmpswFNKkxyp2kBxO6hbuS8MWYyDnjIFWiYjG9QOa5P7nVTpVs7MzmEQLv1tdooqQASgbr9+6gSbbz/XAcc1cT8LB72J1aLJ0M/XuPQD41cLRaaevm8t4tuG+SiaVKW6QEAdfbpH8gpCy9AdZ2m0+L6P8g6sqHYoMoGXhmkx+abyuVoOpiVFxZhL9C47dq6M6VgINexFNmSit6JSDPQTNeEkwBtdaBkbeiQoZSdoTfXbb0s+Xi3CT32EbAyqw1SVsNn3RKBIN51pzJ5UuOZKK36I9WN7+drY5SLd+QPMBd8IWGZsS2r1lIbfYS6dJFJ6Pc5wZRkjVPjs+7b1w/XYJ4QbZkxnqORPnNoeZObM4RSUKHD7YDW6QMoYnMUFXeDsoAhxibQgtTCPGsQx5OlHoyjoznZJJ6T077I93q91HzujaBxgb6mLPq72y43Edf/DOXCVFcQ1yZHkBKL3kiGqwXI/CM8TNVBPqVp+qxyoM4wQ7W+Gaok1D+j9pLQU83X9jkG/brR7gvF7sb5chYgUO87zKm3dfy4bm/6xEWrmGcYoH2bL0aA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(7696005)(4326008)(966005)(508600001)(8936002)(64756008)(66556008)(5660300002)(9686003)(83380400001)(86362001)(26005)(6506007)(316002)(71200400001)(52536014)(54906003)(122000001)(38100700002)(8676002)(76116006)(33656002)(66946007)(186003)(66446008)(110136005)(2906002)(55016003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?DFp26vLSCZE3veXKNNRhfrMjJYo1LXY5JYZOvkISsrJuguZxLG49UtJUUl9+?=
 =?us-ascii?Q?aqlM7SzKvgXzRTVIK/+BFP1FMtDM2oQki4pG1kEA4yUHu+ey42OptUC+q+f8?=
 =?us-ascii?Q?YcNiCvUZcbngUzJwf9Y9f5T+1qzwDA1b2HBgXx7+q5r27YA58FrnMxmEYf5f?=
 =?us-ascii?Q?Fi6OCMzVWlnj/A/PuOmNA5XUTRAu75TbExq3/b0CFfFC6B/22AKT7mJa8MEg?=
 =?us-ascii?Q?FRmy82rYcOa3N+O5R6Y99MqYeRmLoj+UhwdqCisEuYyXf2JW14hdvor/l6fK?=
 =?us-ascii?Q?Ds/+klsDKwrCh5yVApV1Ck8aYiCg2FLi6tCsfCJtaGuxZyV7c9WsBcf2Ii2C?=
 =?us-ascii?Q?YPNvLTay+5gYMsuWyomVZ+ATDKKplZ5xuMqOQqbaATiLwXSuPi+mWdOuUj7V?=
 =?us-ascii?Q?8mEt+qhCbz8kppcXQ1ZEXNCFE73JwjR46ZHQ3ZRggFBZOjAKaLp4hDPW23lo?=
 =?us-ascii?Q?ja1cgdsODO0/HMqiCpQLBLO8oaJ7gjyCrlY2aDEyYXpapCQ5LY2dfqa3v+N2?=
 =?us-ascii?Q?bs45c0C04ZSPRGq5rWIgb1ooZ6rKqn3nvkX/6mnuzJzQp5a20Rr+oGLsSEMy?=
 =?us-ascii?Q?s+/FppIRXcvTqPTeS3ZAHtyouquIDKqtvXtXiEQIQSiy7MwOsaxXJSMFNiut?=
 =?us-ascii?Q?poXtV7h0TkjicZQ0KgqnQnmsfbn9FM7rUKlfSXmC1ilnOiqWOsWP1Cazj+OM?=
 =?us-ascii?Q?LTzdj9aLTiBAlukNYtcDVcB0RRfb2oXPWsGnGqhAFA2oeybLnwCZ1t0Kv7dL?=
 =?us-ascii?Q?hzQ2PI50L/2dd6prz/xRle8mFGwIXtnd3ngOQAffrR6qL0MJoUJznRQxYTAF?=
 =?us-ascii?Q?+lgwGYe8Dk+kKIZng2EpIk9TBfy4VlZvocQFw0/GYThgIRJw6rogbD0uNZnD?=
 =?us-ascii?Q?HaWNKmjx+y5NJ+P0IeBHwXrqAkgWoIsAJpTHzCXOSJ4qD6bQpq/sEEGbSpG6?=
 =?us-ascii?Q?RCva1rjTMuyeRnEYUF3lu2shgrs8qoWmnloomc2ncCQDpxK3nn9vy+4jlI22?=
 =?us-ascii?Q?K5yso0GlRimyraa3DIXWuGoPX82bZ5pBUDx650xIRU8K9/4t4pIbSOutetyo?=
 =?us-ascii?Q?QHW1TYrTubIkosrUWphHylLsLHWa+RbGT4YkNgr1CbzJlkqv+sEUQJ7W7tRm?=
 =?us-ascii?Q?PdKYedjFsdBeGhZckdhK86oNk4L1fP0nDkciCk84lAHBRx2UPm6adopVZyHr?=
 =?us-ascii?Q?4H/nnN1v5Gr+oN9gNMQb0Y5ba+NRFZgf9HlV1SmpxUg0uoTVcXuQyQIcUyDg?=
 =?us-ascii?Q?7+Vc/Z/BCvdO9wSwFIbIZNQ5sjjfMHe9lGe8gkXWQ1Z11d+64F/GAvU+wBkZ?=
 =?us-ascii?Q?fwJGfSpoztaxCli2gO4WlYbgFKXobINASp0LiTkKTjzLS0PY25D7fTSZnTOI?=
 =?us-ascii?Q?jbKl4FxvdYwqrv79WRJh6QLGqcGcNB6jFVeA4IEoxedEV7yocs1jNNbttIhb?=
 =?us-ascii?Q?AIrJeoQVmlHmSF9GjGr+3qag0qj2EvSpW5Xg1DkcW4rqDTT2Um4i+kX7hbdb?=
 =?us-ascii?Q?+x6oHR+b9XGVG+K6RHNG1+Vf8qiwrjT7+p4wku8ZtY1nBabG8IQhZuc+/Ji6?=
 =?us-ascii?Q?NPdMrvzZhJKgeTmnIFi2gKm7T1XC40HwhkNi1+/f8c6GbF/kiD80sCWq9rTM?=
 =?us-ascii?Q?AB6Z8sEOYaAjU30QXZK2s9x8cqUdKnKGV0Nmqsj0OaTvR4ZUj5jxAfdc6UZ2?=
 =?us-ascii?Q?QQFY7g=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b766acd-7015-46c7-2dd7-08d9d46de971
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 19:17:58.1730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nuLUt7EQMCWJuspL9uIU1qwV7XiAG3ri8/kh/SuyKG/e2NcFoz+VJLFeIkPjugSFUr64wSfeCDlN0uvC+Lxbe/Hwh2Es5LL3uylvYVUG+xI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2517
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>

Hi Pavel,

Thanks for the feedback.

> Subject: Inserting patch into history was Re: [PATCH v2 5.10.y-cip 15/15]
> clk: renesas: r9a07g044: Mark IA55_CLK and DMAC_ACLK critical
>=20
> Hi!
>=20
> > Is it possible to rearrange this patch before [1] and after [2]?
> >
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/comm
> > it/?h=3Dlinux-5.10.y-cip&id=3Ddcbef66029571fbada7522b2db0790e5ff054c66
> >
> > [2]https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/c
> > ommit/?h=3Dlinux-5.10.y-cip&id=3De2568c0c7de565a5688544907422ca470844df=
87
> >
>=20
> Wow.
>=20
> It means changing history. We usually try to avoid that, as it will cause
> problems for people using git head. But we did not yet do a release with
> those commits, so it is not completely out of question.

I thought it is simple.

Since we haven't made any release, history modification  and force pushing =
is not required,
as this patch will be part of upcoming release.

>=20
> How important is that?=20

Some how this patch, becomes out of order from our internal huge cherry-pic=
ked patchset from mainline,
which we use for testing before posting to ML.

It will stop booting after[1], without this.

Any way, this patch is going to be part of upcoming release. So History mod=
ification and
Force pushing is not required.

Regards,
Biju

At the very least I'll need to know that rest of
> the kernel team is okay with it.
>=20
> commit e2568c0c7de565a5688544907422ca470844df87
> Author: Biju Das <biju.das.jz@bp.renesas.com>
> Date:   Mon Dec 20 13:31:30 2021 +0000
>=20
> commit dcbef66029571fbada7522b2db0790e5ff054c66
> Author: Biju Das <biju.das.jz@bp.renesas.com>
> Date:   Thu Dec 16 12:54:46 2021 +0000
>=20
>      clk: renesas: rzg2l: Fix clk status function
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

