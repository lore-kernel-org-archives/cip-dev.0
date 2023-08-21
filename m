Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5F5EE4996
	for <webhook@archiver.kernel.org>; Mon, 21 Aug 2023 08:53:28 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.107])
 by mx.groups.io with SMTP id smtpd.web10.6807.1692608002731723106
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Aug 2023 01:53:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Sy5HINd1;
 spf=pass (domain: renesas.com, ip: 40.107.114.107, mailfrom: fabrizio.castro.jz@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwTRJ5MXUFQ6qG3ynJVYAmCy/lPej5VDfzFXakVntEmOIn5CEGgRp3/8fzTCIUlcpru5MBfCGeqQdwhbesevXk6ydbljKsc26PBs61zJ7oGxOOGBqQC2+g9oFM/u7M2uu/JbI278VbVExLB8wbmAPXNU3gonFIgrdJwXwVY54imIGBpjGaiws/Uvio0l8UO06rUliyJmlKwZ81oihFOjo2gAZv2nWHweKuFsyLVSidv0q2sMFoMmeHpS882FgloozssTM1Wd+sG8eiCtlV44lWI00j+YapF54A5FmFEYYE0laxCRaBRp8Q1v+W1GGyFlCxl7zcYnSjjMVHkjF4ao1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrBrPSeTucgddC8JXH5IoLF5X15GVpjvBR2ItCQ7mPM=;
 b=VkNZ0URxPdZMg8+qbiWHzc6wAHsEzITABSGLjcS45dc9wyN7rsucPm3F4dQVfEmoc+6KqzJYM4jsDHh8QcAxvtIc/YqbgI5LaI50nOfeMjG1NvYqNnKS7MNBZoAkP+VdUAg9Vd8/osEmeMmjqVasXcMouIg0nAJMqJmFg39zu0j38vJh/2DAhkPnFVFKbFUlVhBAc1BKCLgUvI+MnWz8AFOQExjqY41iWvRWxP8qV9yurLxGcGUJiOsX/Tb6bv0frVDc6ZZ51HuFCmaC8Gdv5cG/S/sWTs2n1QZX3Bh8rVWFy1CVk7lzu7zBjvGI2Mshrz9fOw4A9VzhZkoHyziDBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrBrPSeTucgddC8JXH5IoLF5X15GVpjvBR2ItCQ7mPM=;
 b=Sy5HINd137Ja72NIwwxYZkyJLN6ta8d6JZWIl1ringne62NO0KAsdTbwk/By+Fc/m8fyMvnNzSzkFMbjvfxIxbJzrGifwgIGLqcdnDPgiMZLPO6kNaZ+6fRcsb7WWCHJX76N0EYBE8MSiJ68eQgekIKDervK6hFDIBqZKEZhgrg=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYCPR01MB6301.jpnprd01.prod.outlook.com (2603:1096:400:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 08:53:18 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::20b:248d:188d:a7ec]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::20b:248d:188d:a7ec%3]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 08:53:18 +0000
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Pavel Machek <pavel@denx.de>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"biju.das@bp.renesas.com" <biju.das@bp.renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Chris Paterson
	<Chris.Paterson2@renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/6] Add eMMC/SDHI support
Thread-Topic: [PATCH 6.1.y-cip 0/6] Add eMMC/SDHI support
Thread-Index: AQHZuY0J+7CeCYEopkmf+IJ+KNnWna/CbewAgAADHYCAMjSlQA==
Date: Mon, 21 Aug 2023 08:53:18 +0000
Message-ID: 
 <TYWPR01MB87755C152C51606BBB7FC52FC21EA@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230718153212.327448-1-fabrizio.castro.jz@renesas.com>
 <TYWPR01MB94206BB60C37FC05D49F8641923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <ZLkHg75tYMjt6rhq@duo.ucw.cz>
In-Reply-To: <ZLkHg75tYMjt6rhq@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYCPR01MB6301:EE_
x-ms-office365-filtering-correlation-id: 8fb83b74-3b10-48ae-7cfe-08dba22410a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 nBK+r0GcHMHZ3ojh6IC3ZTDKmvj+ysXTWWUjGcqaw54/bZZfuq8ZhUCORBBhQAO1JlzwemSIfBVl5cQPrMLhszFXWUgMPbe4zrDpoFa0Hh807JerGHWXHXMLFpzIX+Fh+IArS6OBWatowoszQxpERKD+H7eYIZYezOz0wLABD+0C1QbQDjL6uYlUmtZrzRk6/m62oDT/Tnno7usmt4UO1GUQ6ycjguJjvP2eiibEAtt1GHDCc7BeKwRopY5gmzT40ipxIF0E3bKIDSKcP7lMfvbsRKuO3DGbyf4SBgJETOs7X9QHPnuSDoy9i/UdZZ5/F9q8Spol47GVzm7CVIqNcmt3kYUm7IN2hDeZKfXvzwiS3u/WJ24rI9Gz0XHhgU++MkoyFut6/22YKpolHp7KfEnhC/1MUn4XxP/sbBxy/p/tehjXwnIsBO0Av6336OyMH9uSIdrF1n5PuydwBlSeYZ1WREIWdZo0nGg7+fErl0Ho9WH+NJbCW3Oz1wSkuPe85sL5HiCnYPuYiLqTly2iLOVyHFQCL0IkIB2CoKtukgvwyaW/ONKxAmFzfAL8Jyfb7yrgifLczTuxMJsjnaurIi1+kuXOn6poH5WMQHV4k8U1BKLXjVDd4IFPhTIfSIyl
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(1800799009)(186009)(451199024)(71200400001)(38100700002)(6506007)(7696005)(122000001)(38070700005)(53546011)(9686003)(107886003)(55016003)(83380400001)(26005)(33656002)(41300700001)(66556008)(2906002)(66946007)(316002)(54906003)(66446008)(66476007)(110136005)(86362001)(76116006)(5660300002)(64756008)(8676002)(52536014)(478600001)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?YLueIkNvxGXTcCFwpuBiVGdnVsyad9pr4elAOijo9O38jDRt28T7W6OZcJZe?=
 =?us-ascii?Q?VCXI+8ErfB1+Vj5xiPunp9wdv2ykfrHRsJSyPSO+0go14w4pUj+1U/YZ5838?=
 =?us-ascii?Q?qvXO0aSjIzKLdiD4vOhj8ma7252ebN2flkk9ZKvcBGLIVvz4cu1dTxUEnaos?=
 =?us-ascii?Q?2GG/M4/eVWeosOgPwbv0F8LonR6bgMWJHgOmruImX14jG8BmDQjK7pECcJ/s?=
 =?us-ascii?Q?HhibZAuq+1Zsc87AvtJdAMAN4UwapTSYw7tgz5qpJyAEnX7p3pEiliEpCLF1?=
 =?us-ascii?Q?s/AbjPte36RFAriZ3BTuN05pJO5TEL+mYnTLdC5Ow6xSQjnR9rb7TTL0j9jp?=
 =?us-ascii?Q?j9hZC7Sy49RJTrAerrEmPbrR/etVvl949FViZ7bXShMMXChtvOUVgVfpIML3?=
 =?us-ascii?Q?p8HNETtvpQpEZ3yRPfveUxPhyV17Pvy0FJtjjnPmofG3zcPa/fvA6DtQRhdw?=
 =?us-ascii?Q?M1qmOCBTNE8VaY8JKFzYaZom8fL6i2zFP05XsmNwPZaBHb8FDcZEByxvZVvD?=
 =?us-ascii?Q?NQaLGHm1XIAjeBti7LSt7tz0+cHJHcF5mTtCe1hxFl/XkoBA3gps5b32/HE7?=
 =?us-ascii?Q?cYbRUjVlMGxA1Sd99B5ZFuYTcjLol69gGIl1zQJDOvG8UKbw53iIwLfNepxp?=
 =?us-ascii?Q?MvZ62n0FpX2Ts2BmnewMJOmtnflboY5DLKXRIdMWS5+UiV2MIDr5uoNMrzZ2?=
 =?us-ascii?Q?KEYdRbetyp3f+JI7YR84HwkTuQo+1WbYC8RqLt5HWvBPKpuX/mbm/xqMZebv?=
 =?us-ascii?Q?YWmzEdg2mFDpqdDJkBKpoD/OKIomnL2jvgVadjGxaZFw4wJWRRV+fSx8ItDj?=
 =?us-ascii?Q?BwYWmfXnhnZBpJyGeOdT8ubi5ugGvITpL36Ikep0w7SPwpKncEjgRZaD0yw0?=
 =?us-ascii?Q?QhwH99RjSOUOYKVwVuVsyLny5VLtdD3+Twf2TIMXj7phWcF0M6kzliekmMZE?=
 =?us-ascii?Q?M4GxAnScthHoRgDJHiDNhtxPn6d6vLzEBWF+iPPbrm3rTnL5+Y0gNUFH6OBJ?=
 =?us-ascii?Q?X7rDVSZif3laU753NnJYQMW/NrTgzVFZMJkd4j5/mYvkpj6Y4YIhfOh6Cdvj?=
 =?us-ascii?Q?bY0I8JLX6zfu8th5k2jQlsnKBHSj2Ot5Wsl5uu5gGK26pxbbdmJhLSf8mXgj?=
 =?us-ascii?Q?E2GVGa5r2zPSTwn+CDZQ9H+TOVg0FGNd/EQ0xtNjFzo+EhU1biyEGhad1tzy?=
 =?us-ascii?Q?IaKCh4E2TxpXbHVMn4z/Jy+K6lTO/fb18C1mqnHEkNTQbl4taQpDR6/hsZAq?=
 =?us-ascii?Q?uY/7a1aPvJARtH8h3e70CyFXgiwdph2LMTPfyjQlbbpFYWsnbPaTLMxlG1yo?=
 =?us-ascii?Q?eJoOf0V7bodMH/4iM7REV6fb9LJ6wbfEE7h9vNqzvJfmHKQSOU3NI9bLTyhz?=
 =?us-ascii?Q?ZLfRljooPo8oaYtKmCbt5oik4FPHih1uCRYrFNV8O/u1gp1qsklEyJqT1IPg?=
 =?us-ascii?Q?0dVk+akSpSvfMOZRnNif3UeGH5myhqYgu1Manl0/4jAvMPUv5dlJtsrQV8TP?=
 =?us-ascii?Q?cexknnvWSpDNwKsblInc92KpzdOYJMlao5HDc/gQvJzoz64hhVzg34Dq5Plu?=
 =?us-ascii?Q?KnTAFB02QRQunENgXoltpkiR7ysPFY12uSLN7Rk0XpRL7LMGqwsIL+y1rGHy?=
 =?us-ascii?Q?Vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb83b74-3b10-48ae-7cfe-08dba22410a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 08:53:18.4310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w/AYD8KoPyJx+VjKkRj1KZTlxVGObm5sQRWSVgoLfcu1PVszZ9eXJlnXTvZiDVcHPwYv00J9IGoxt2fmhXnaD9oAhxRbW1hVjerFHhz5+h8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6301
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Aug 2023 08:53:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12793

Hi Pavel,


Patches "mmc: renesas_sdhi: Add RZ/V2M compatible string"
and "arm64: dts: renesas: r9a09g011: Add eMMC and SDHI support"
are found in v6.3.

Patch "arm64: dts: renesas: rzv2mevk2: Add uSD card and eMMC support"
is found in v6.4.

Could you please apply them?

Thanks,
Fab

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Thursday, July 20, 2023 11:08 AM
> To: nobuhiro1.iwamatsu@toshiba.co.jp
> Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>; cip-
> dev@lists.cip-project.org; pavel@denx.de; biju.das@bp.renesas.com;
> Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; Chris
> Paterson <Chris.Paterson2@renesas.com>
> Subject: Re: [PATCH 6.1.y-cip 0/6] Add eMMC/SDHI support
>=20
> Hi!
>=20
> > > Phil Edworthy (1):
> > >   clk: renesas: r9a09g011: Add SDHI/eMMC clock and reset entries
> >
> > I reviewed this series, LGTM. I can apply if there are no comments.
> >
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
> Thanks for review. I applied and pushed first 3 patches, I believe
> last 3 need to be in mainline, first.
>=20
> Best regards,
> 								Pavel
>=20
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

