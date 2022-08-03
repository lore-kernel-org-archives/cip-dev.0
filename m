Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44FBC19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 07:20:01 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.127])
 by mx.groups.io with SMTP id smtpd.web09.5811.1659511196694241878
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Aug 2022 00:19:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=JkjRDHpU;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.127,
 mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ms4+ObVts7MrBzop1BEqB3mo97y4GYwfqT3b1X//ibId7NIEiAasZp67cs7F2YJ9+EJZ6tyLYftYMMmZKnDj5VmpvdBpoKhE6AlzflFQxkfnRoLwAtqhzwhNIVY3+anEXKJRhWwekRa/HceR+2k9nBkqibsVqMktjhadEsv5MtwO6HBqIP3hEjQBDEVWovkaPqXOhGou/OElQBUPuJ6gZsT+XodFaZ2zUPNVTeV8SeOsWzkyQfhSuBow6kuMsIAgbwGFd0axjytcjATYujb5HdKotFb0qdHQSlK7FrxPabjAcIJ1zW72azcRn2cuPPATfr+SqS+3g1vNV4WDTxTJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2KOqBjtfgZwiZe2R+fQ1k2F1G78uga1nhYwJ58h6ag=;
 b=FYsFCmSXLSjtQDGKLzv9npP9sCa7yDswPZN3nmfR6tr99ijlnznLE2E9GtW2zLP7aczNtB1QSwQIYBVtRC2XGnpqA737wMVHnEjFMmFLY/OMN6H/+5rMR5ymm3ZWDBhcpj/fBR43Bd373KfijBYU8C0n4u0BwwmdkJN5R9i/mWJpr87QfwxtWGBGldHh0hBu33aebjZuu94QEZXgskiscZ67QizvPOTmQW7Q9khTP/3F4P5NgpnazksNzYUQwrc4SHE2dzhH2+b0LW/t03S7fAh6ODATGKg9ueNOLolzOKCx8ytuO3JO9rBKCFqxbIpkS+Er0c9fLPmMpX3XSn/xVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2KOqBjtfgZwiZe2R+fQ1k2F1G78uga1nhYwJ58h6ag=;
 b=JkjRDHpUz93Mok7Y+KmiLogRuvnSzONCC01G6UKaJ6xolU+S9Euuww5EDTX7etXSVoRFmDS1/MPRtj8xNdILW2IsZyDjHlAGbJ8kcZwYEXJL1QFwaNw7mfUz3AaLUvMjk+qCiiW6kr6xpY1doeKC92g48EinoRvtaSc3DmBC0L8=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSAPR01MB2132.jpnprd01.prod.outlook.com (2603:1096:603:17::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Wed, 3 Aug
 2022 07:19:52 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::b046:d8a3:ac9c:75b5%4]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 07:19:52 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 5.10.y-cip 02/24] arm64: dts: renesas: Add initial device
 tree for RZ/G2LC SMARC EVK
Thread-Topic: [PATCH 5.10.y-cip 02/24] arm64: dts: renesas: Add initial device
 tree for RZ/G2LC SMARC EVK
Thread-Index: AQHYpmBD1qEJ4rhb2kWzfpuZjVJBLa2b0jIAgADzn7A=
Date: Wed, 3 Aug 2022 07:19:52 +0000
Message-ID: 
 <OS0PR01MB5922EDB178B246866065FB8C869C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
 <20220802110850.1496057-3-biju.das.jz@bp.renesas.com>
 <20220802164656.GA9523@duo.ucw.cz>
In-Reply-To: <20220802164656.GA9523@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab1843ed-21f9-41a5-00f3-08da75208ede
x-ms-traffictypediagnostic: OSAPR01MB2132:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8wjjslNtOL4d5GJc2THUvgRz0Q/w4tg0mRFq38CA4lGw/yEOmQGXp9HlmtvknEiHEUWDbLqSS6L8qPBT84+T2zOH0aVOvDrz8Kk9wbJ2iqYDEgph4dzlc+XMgUFgudctf7n5VC2mdd13ML8LIygdPjCOYI1iV2GkfTem6oQuSteqKfgs7Aq3JIOY8EJYrofZRush8ATtSwCBvVu+zvYzE2md3RL/AHsvNn1JQpmsyjLTZAvgHqfK590tiDs9uk75M8LfU0cJe9dqE1Emb6WuMhIYzGykdvN5SCd3v8ZjRhl4wgroqDq4/6/DwwZKlZgTlNrdqxZRb+tDczk5uaPohK1uhnNCYcLGEtEWpIUNmBO3MrNS0RVu/vqXO4xPfi7mKGgpYJO7S9XdWuJT3K060jMfuchRROtR4/0eudyW1HYxXdcrXVECME0WbdLc0wE/e78uZG79iFrZq9Q5ZbUb914opm/CtELr/KJd9dBDjJniN54KQPeYdPPw8L6torgKm6fRnSwky2r+/MpV57EM0j0733DGNBIw2IUMkZhp6XX2Rvugrcf2JPfSF8JuVuhE37oH0XhFVthxgxcT10PFqGN5SXiq9pKp3PvD0TB2n5h3kbeV+ZrIJYOCxwth8zm2pY19nua3dyrhI6cV2NlhNg9OtxTa1r7SKmmw9Ap1Ss/IH2rVSuR6/e09vNm626DTgqs5YbC2myAEhIbatAnyiZEkoupDXofrlrO/E1SdGhq3EExvf0P9ed52o5ZbijsZAi5qM0Vo+Rr2ThmhxTtpqNJhCeKYl7ng1In+mE4AWqX6DkpsPu2LTHtGYzXu7Isb
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(86362001)(83380400001)(26005)(9686003)(6506007)(7696005)(2906002)(41300700001)(186003)(33656002)(122000001)(38100700002)(6916009)(38070700005)(316002)(76116006)(4744005)(71200400001)(54906003)(4326008)(52536014)(8676002)(66446008)(55016003)(66476007)(64756008)(8936002)(66556008)(478600001)(5660300002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?jSvzSYsxSQlzdbIPXJm+J897lKFm4OSkaHXBuJfkxTZl51Ra0j/Aq4KlwINo?=
 =?us-ascii?Q?Rw3BSqnMxRSG4E6oHoNyYmfTdWjXDJBSkEq98E0PLMfwNF1AAGH2/2a234s9?=
 =?us-ascii?Q?yvu9OlltlfkDb3UBaP2YF5rjs+Odhkc0vKhTR5w0NoMj4A8FbYA48KDBNucS?=
 =?us-ascii?Q?Lm84VFZEXyuyxiFbUxB3k9mtyuMN6+qjKC7Fkgi6F2XgAufgEcitywW1VAUs?=
 =?us-ascii?Q?2TO85iAOd4NxMm5lGIlFNi+rPFqOua+bDmRRawRKRuq5zld5dqLjVL1c381/?=
 =?us-ascii?Q?3kKDOeAIUB3kG5g1l6AQ4ZautQNUPPIv/Ujb0DRX/N8e3L7R0eEQ3K/iVdgI?=
 =?us-ascii?Q?VwUlN+dsbUOH3BaghkwbLU1Qha7ORvxKUxVRO2XZwbnEoKO9PYYh2MxWZ8+3?=
 =?us-ascii?Q?Zf0hnBXI04yqpmCKrQzkyA/0cplHwZw1e3ec5qzqL++5QPbCqJg+PCbJwleD?=
 =?us-ascii?Q?ypEMwpVi2ZdmnK+wfcC/wSRDrVB1waqtKvcw4Wxn4oGIvqxuqa4eSogymrtP?=
 =?us-ascii?Q?HeHT+kQutr/7MclGNpR6IovgO9UgAwW3har+wxTTRX250my6o29iEd89WAZh?=
 =?us-ascii?Q?NJa8KJ+IbEOgN/MYGlecFPXTJmzdkrRBKWmQAbS3KLseVBsDy+J31vO1wT2k?=
 =?us-ascii?Q?JeTjuCJABh9p+PTYVufOaFlStRP08tPgIqhVbutHsQruI1rJ/A7cte1ZZxoj?=
 =?us-ascii?Q?2Ws9hjdZ/AkrBWHO9hEoeAjAhZ9uUnZkYTjmUgmjfN2mKIoQv1HcGmvsV8OQ?=
 =?us-ascii?Q?vxO9E5inz5i7+KeOKvs6jo+g5+CkMGVHToqB1UaqstT5yCogVuEtt4j1IobN?=
 =?us-ascii?Q?pVBvx4YCJ5yEH26li1qtyMs6dn7+LGmiBB/LwmJqrxRy2vIUk/g3nuRM1aCI?=
 =?us-ascii?Q?khv3A7vc23mNdonZIqGx5YxYDI47Om0X9V9ZRmtxTxNrheOpN69B5nDEYCMQ?=
 =?us-ascii?Q?S4v59Wv2JjDt7BiOVmdXTHiDEojo51Pn7aDP3RizwoHguXSZNct7yNkCndp7?=
 =?us-ascii?Q?NvEs9lxHJ6+LneOVr4feLOBGiKZtFhLeV4X9qFvyAm8JaOP8i3oYF2MLloxI?=
 =?us-ascii?Q?bOOD2ZUqsSrycYNcSKHhS3i4ZHxjEifYRx2iHn081nHaHGb4ol1CJRioLj+7?=
 =?us-ascii?Q?21RTvlzw2mag7onHUdo3axEzvbbCSzI3Qq140su7S9AlGd7/lkYmiAkhKCF4?=
 =?us-ascii?Q?9zRJ/y5BEAXM5+nmc8xIzuJSftOs6e9sn0fR8dvq4m9jkpUZUMvmhzhHL4Cp?=
 =?us-ascii?Q?ubt8wNnkRqmzbGWsHA3pJbj7i86L8256BWBKIAEaDbS+a+N3MctijDIthnR/?=
 =?us-ascii?Q?ZAEcBWwpfDugIC0/BGj2loDIVRHwoVrBXR51zKBFR66Giu7xAP/TLJ0CB5gy?=
 =?us-ascii?Q?lAYSNbwGTA8yBJvhTlBnPbSMxNIs/YhnvyM5oguMSWicQDeqPi72acL1tbyb?=
 =?us-ascii?Q?/uVKUCgrKjpZZxF7S/DJrEEdz4CbuucJAF4jfW1rZFHLrxe6FY4CF1ywObbJ?=
 =?us-ascii?Q?FgY4RoqkyXBfTX4Ks4TwzR8MjbnFKwY7O1U2uFlUhHw08fxU9vWpBmxAK8FT?=
 =?us-ascii?Q?SgpiivTVPyD/Nybb9jn75Y2nrbz8P8JZsd8eR1AssDQVgF15nB/BGqcLa+7i?=
 =?us-ascii?Q?Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ab1843ed-21f9-41a5-00f3-08da75208ede
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 07:19:52.2507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 z1YJ9bn0yXQsiAqMYr6IT09CnaA/Q2ZjkMLxWkwDEz9sXiMNtFQPwLKLZjlXKl6SMC7UV9pHUCKEvj9vLV5gz0SJsLXjm+6ZST7yaZM+j58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2132
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 07:20:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9038

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 5.10.y-cip 02/24] arm64: dts: renesas: Add initial
> device tree for RZ/G2LC SMARC EVK
>=20
> Hi!
> >
> > Add basic support for the RZ/G2LC SMARC EVK (based on R9A07G044C2):
> > - memory
> > - External input clock
> > - SCIF
> > - GbEthernet
> > - Audio Clock
> >
> > It shares the same carrier board with RZ/G2L, but the pin mapping is
> > different.  Disable the device nodes which are not tested and delete
> > the corresponding pinctrl definitions.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Git is a bit unhappy with blank lines --
>=20
> Applying: arm64: dts: renesas: Add initial device tree for RZ/G2LC SMARC
> EVK
> .git/rebase-apply/patch:171: new blank line at EOF.
> +
> .git/rebase-apply/patch:253: new blank line at EOF.
> +
>=20
> -- but as before that is probably not worth solving in separate patch.

OK, will fix this in mainline when I get a chance to work on this file.

Cheers,
Biju

