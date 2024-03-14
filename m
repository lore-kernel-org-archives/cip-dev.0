Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E701C54E60
	for <webhook@archiver.kernel.org>; Thu, 14 Mar 2024 19:48:32 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.8])
 by mx.groups.io with SMTP id smtpd.web10.2276.1710445706373677604
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Mar 2024 12:48:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=NP5E/aaT;
 spf=pass (domain: renesas.com, ip: 52.101.228.8, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLQU4M69UpT8hnw669v+GmDkVHmEucBjCGiEh1TmI3j3V3U8yhdjgPYF8PuR0tFK12ap1K5krhJhGMeo9VjmObjHebxrv1dt3V7R268NcSq+uvaSdNVBcFX1adRAU5gdyBe7Vd9JVRya3oZEZNZosSKm6dNhFWnd4kxoa6T0VeDCEPgskjs3cFy4FrXejRCaIjgMGh9Z2KPBUf+POtqblvcDTZtfCiyTqbAGU65haYx5DKH3ADcTubM3FNOngEe3jvgiuyap7LS0S5Zc4pe8igxteEl+TSZe1C20i1bzo8awCpUDFjFIUJSBQvIAsUB3/HbKw2OpcAJSsHbq4IhttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eW1heOCaFJUr+JMZEpSj7swPol8Xj81HenfJe5/dNiY=;
 b=UsmWLo3l/6WKD9fIe4yYIJ4c0Mwga9rbD2xzL9EtU/T8NhJz8+X+tk6vhVdv7heHkIz4sdO/jEqH0hpHxRLnj+9zAPBzszldOAvFgLfBthKUVYENHKZHacFWe73gzAtgTS90S/bJz4iXp9cI31LYOxqK+jTDJqhxc5YfS8KYMPEYJ7NqC8kskNBScVr9gQHUdyRtfcBPw1GP0Sj92y2Igy0RFrS5tgZjsMzMzAhYNaQ2rhjYmLUS7QzhW4DHsWxcJeXmjOiqeSpPi+uNkHv2VcVHGQRtt+RJGiRWhaoYDH5WGlZuJSEc7Xf37mjBJ1M4lqQ2iiD9sUKwHSdrYMasGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eW1heOCaFJUr+JMZEpSj7swPol8Xj81HenfJe5/dNiY=;
 b=NP5E/aaT6i2pn6N5ok0pB7vnh7ArJY0iAdxggTh8Z4zubGgO/HZfXuait6N4JCRKLpV3t4uhLoYqW+MCfS5vIy/UcKJELV/sgjPwoMs9owyIcVU3hrM8p875xFsg6Bt3apQGmZWoH4OfhhM4QV4S4pRBNqj5bAt3V13RUGCUKYw=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by OS3PR01MB8304.jpnprd01.prod.outlook.com (2603:1096:604:1a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Thu, 14 Mar
 2024 19:48:21 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::fbad:9a9e:9e5:7cfa%4]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 19:48:21 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 4.19.y-cip 0/9] Add RPC-IF support for
 RZ/G2{EHMN}
Thread-Topic: [cip-dev] [PATCH 4.19.y-cip 0/9] Add RPC-IF support for
 RZ/G2{EHMN}
Thread-Index: AQHadkYB2LfSz85sNUecDBLBwMfarrE3pGsg
Date: Thu, 14 Mar 2024 19:48:21 +0000
Message-ID: 
 <TYWPR01MB11862FC46D37E44BE7A415016B7292@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: <20240314192950.27343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240314192950.27343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|OS3PR01MB8304:EE_
x-ms-office365-filtering-correlation-id: 2fb8b333-a939-43a0-3d75-08dc445fb40a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 +T3nO3o08d5ztthrwv6Tu+kKq1J2kzTQj1uW+IIWnhy+syfryKwYTAnfA2L9TRtcXanJFLZu7E72oAHKwTYX7fp1Zqk5lc+jKNesYfErZ+03n7RkMgcoJRP3x/hMNOi6oJ7yr+39eIbn0TT5lr5LayIlXyCJCi0RHALWgjL/YMN5gIQEU/NY5dqdt2QE6Iep6kmYqF/0KHOh95YHqHNXAvDWx+9m52ca2C+BieXmrESjCdU2oY/BnYCyd+i70kwxmqGqGQPS0fJvJ3ee6fQCRhL4syL/ROj1g47R9dUehR1Y/F05rNhcVlrs9diKumfuahlp4qIytK27iWbt5fwtZAE/PHM+RhE+YRgt10605oBPraK9OyuvfNn2Flm8F1jJM6C5dyep6AxCHbwxeO6I0p2j8ms3K/EmgHXMQqaiIVBH3IHfxNSZthyJb2cKJ9TRgOX3DeFOOxDaix15Ab1L+CbwUGrO3vst7BUnG1UCYrw0EOFFLIj0BO2SP2jCTshK8/MtDPN5RhnHamkAQuuSgNVCJYKB3IamcB9/JPXE8mHSNFT1qyUGAxgUuWlXAp1l5RD+gw3G3WImZgAyB1iJTZCcp721F4WEav2cpc9Fe3ZS2RV8ijUH0vo24DUsLCaNUnUqKy9qdK64tvv/gYYGz6nOvfKcYfnBE1jJCK8PxdAcCn+aIUpv2DncfcjdgmttyzQh1GMlFpDSma9rpeliVOd+nJh9EgGOHyqCH8YcW70=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?bWOJQAcOh+imBWWnNOIGFPdY5zWouFDOShvGdx2hJBGlxHdCs8AwmkWU?=
 =?Windows-1252?Q?5u051iNcoPdMcS+lpiqv0wswGTJD2tcnq4TsQFNADiCcEmph55K5hBv/?=
 =?Windows-1252?Q?jyzToBNPAFQ9WmZmriMo0OChVtqRFyBG5KHg976RiFDr9szGwoof+x6w?=
 =?Windows-1252?Q?+rs446WqbtKIBYZpRJV0daq3l2uSF0lM8THiQ+02mh6VdmTyOTXFuxyk?=
 =?Windows-1252?Q?c7ZcmJMAtRxSguVD0HHxqGnzYaJU5xYSi70Nw2QJ8QpcO4QhGE4uZuRW?=
 =?Windows-1252?Q?A8TBAoYpc+SYMzauda4wzgMcfngeZXAY1lhto6EE8GGSBMKGCyU4N0iE?=
 =?Windows-1252?Q?wkboJ9ein3hd+Q6itxqwDy9asPWowpKk35nBxEa1aLTjGSb+9lfpvWNO?=
 =?Windows-1252?Q?/Mwn/N+DUeqcH2ttdg02aEaBB3ydNTwpHwSKmtocxK12/ad6EvNpiZJt?=
 =?Windows-1252?Q?pyJWa9608yThbcas97gZ7rET1/uqqh9qS8u2jdtN0W073ypqjaY88NXe?=
 =?Windows-1252?Q?7gCJoKXzW/V2nKw2JcWygSauT99+dGayRT9mzVkulqF/y8xBu7ikYlhg?=
 =?Windows-1252?Q?wvjkEowqsP1npCkS0pZX0WwS7q55RFtq2RD8e8OQs9jzMipO335+xM4k?=
 =?Windows-1252?Q?tkmwscPTmbZnAmWS0LUMJiZMlEHa6B6OvYEGXE1qzFAc2lx6c/B06JTk?=
 =?Windows-1252?Q?xOT2W7BiGr5ZcMb1U0YoGGpQK5Q/bRK+g0FQxg1VIKlRHBEpbpSAXWIW?=
 =?Windows-1252?Q?BBec/YDILXpB4NvraeMJnq8AyWy2VFGxM5itwTCLSmpC9mohrxJpZ4LF?=
 =?Windows-1252?Q?5CN3zWJYWkOFVTTOB0HL6GH3Kw/f5AUyGwr7DYOHkXUHfXqs1d9tEa1H?=
 =?Windows-1252?Q?e0qw3auIFIOivt4m9dEnDDIUntRN9HtnOGSnh+wrxD1yjltms7pakevT?=
 =?Windows-1252?Q?Ysea7qpImNmlUF/KT+jOHnuntq2ZiKOwjBWi6oB3mFTPIKS4Vsqhivyc?=
 =?Windows-1252?Q?8K/qCF2BPYfP8G/SQOfL72j6kgGwLa3UQzdSfA7KvObeUzSci0eq/AGn?=
 =?Windows-1252?Q?uFVvX6SlnuhscYn6DPgQS///PCilr53DIFhw+09fDa1YJL5agi1fZ4sP?=
 =?Windows-1252?Q?ugkIkH3MWlu949lqbohcS1BKoDoX7N1XQTfa04xDoR9MSFdUkC0Pc/K2?=
 =?Windows-1252?Q?6zSWcpTuPb0X8eXfZphyKgzlDQtUiHTJyhGBKqg6KZmOpnqZKO2aA0xu?=
 =?Windows-1252?Q?NC6MlfV66rBAWlgAmY9LNTM0rdHoUafRZijIlwjommAAquV/JAhQSCtu?=
 =?Windows-1252?Q?h2yaxE+84dYJNIhyKuNOr9mPbbd8vpDbK5oFnqk8VaaLweoRnDtOk/BA?=
 =?Windows-1252?Q?5piUsjD72ucsmks3nPyMFkVL24rjL6/LXtdyYkyL4hpinink9tCS/pIM?=
 =?Windows-1252?Q?wx/MaM0XMO9NDmzmX8lJQr/kg/LLkpqO1TjiUpVAq8ZpugOyoJQ8wUvW?=
 =?Windows-1252?Q?m62dsu53mWLAJ+gGgH4FCpxRwUly3a/csDjWihPEV88ANps51JINhyx2?=
 =?Windows-1252?Q?gbcF72dyKULsz1k3R2L7TcisyMKTEymaxfBpPnjJPJMdltkOsSvJY6hr?=
 =?Windows-1252?Q?Q0zCsywdatgHOYLoyKjk74pyZAaILkXRnNpAQfqkcfbftDleQnwPRZrC?=
 =?Windows-1252?Q?8KKAKr7yyPuzHHpLiqJZyWFSkfCqQ/kV5Qukzho5Hcy7FEl4nn3KnQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb8b333-a939-43a0-3d75-08dc445fb40a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 19:48:21.2458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cc2txBMS03pURxZ9tmEDNnw9adv/R13LKV975KJj3tQldvld23NbUEBlBJtvshVAERNlGQyZdH1kSqFm+tkhaPkxly4NUxnf0y/fTDyic60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8304
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Mar 2024 19:48:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15318



Kind regards, Chris

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Lad Prabhakar via lists.cip-project.org
> Sent: Thursday, March 14, 2024 7:30 PM
> To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [cip-dev] [PATCH 4.19.y-cip 0/9] Add RPC-IF support for
> RZ/G2{EHMN}
>=20
> Hi All,
>=20
> This patch series adds RPC-IF support for RZ/G2{EHMN} SoCs. Note by
> default the RPC-IF is not enabled on the boards as the hyperflash is
> locked by TF-A. To unlock the hyperflash one must build TF-A with
> "RCAR_RPC_HYPERFLASH_LOCKED=3D0" flag and enable it in the board
> DTS.

I hope that Pavel doesn't reject this series because of this! :P

Chris

>=20
> Note: All the patches have been cherry picked from upstream kernel.
>=20
> Cheers,
> Prabhakar
>=20
> Adam Ford (1):
>   arm64: dts: renesas: rzg2: Add RPC-IF Support
>=20
> Cong Dang (1):
>   memory: renesas-rpc-if: Remove redundant division of dummy
>=20
> Geert Uytterhoeven (2):
>   memory: renesas-rpc-if: Fix HF/OSPI data transfer in Manual Mode
>   memory: renesas-rpc-if: Simplify single/double data register access
>=20
> Krzysztof Kozlowski (1):
>   memory: renesas-rpc-if: fix possible NULL pointer dereference of
>     resource
>=20
> Lad Prabhakar (3):
>   memory: renesas-rpc-if: Return error in case devm_ioremap_resource()
>     fails
>   memory: renesas-rpc-if: Drop usage of RPCIF_DIRMAP_SIZE macro
>   spi: spi-rpc-if: Check return value of rpcif_sw_init()
>=20
> Wolfram Sang (1):
>   memory: renesas-rpc-if: Correct QSPI data transfer in Manual mode
>=20
>  arch/arm64/boot/dts/renesas/r8a774a1.dtsi |  17 +++
>  arch/arm64/boot/dts/renesas/r8a774b1.dtsi |  17 +++
>  arch/arm64/boot/dts/renesas/r8a774c0.dtsi |  17 +++
>  arch/arm64/boot/dts/renesas/r8a774e1.dtsi |  17 +++
>  drivers/memory/renesas-rpc-if.c           | 174 +++++++++++++++-------
>  drivers/spi/spi-rpc-if.c                  |   4 +-
>  include/memory/renesas-rpc-if.h           |   2 +
>  7 files changed, 190 insertions(+), 58 deletions(-)
>=20
> --
> 2.34.1


