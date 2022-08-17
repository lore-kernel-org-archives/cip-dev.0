Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85343C25B08
	for <webhook@archiver.kernel.org>; Wed, 17 Aug 2022 07:29:33 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.25919.1660721365431964745
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Aug 2022 00:29:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 27H7THKc016779;
 Wed, 17 Aug 2022 16:29:17 +0900
X-Iguazu-Qid: 2wGqygYKK6CaMW092X
X-Iguazu-QSIG: v=2; s=0; t=1660721357; q=2wGqygYKK6CaMW092X;
 m=8DWC3D0kDHBuxINW2/apebpF+4+D97EyK1oeevuPOQ8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1113) id 27H7TG2o039642
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 17 Aug 2022 16:29:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koKgPbN1+NY0J/QBE/95+8oNSOycFsWx1McH7z5ALx3Rjy7ZmUsUbpjHADJJ5l0a+ZcCSMu9nR5mVfTShRRFBhuvIvinFaSJ/Sqfbk+Sy2l2qvpDjVhTk6oFKqg8hWCW83VnUeFBRODk2pC1kIm0FMSNE734uc564wn5UJAXSmDdc4dBXEoVp1Phv88WMSrbebr+Rg8xkDUaSgEq3vZB2/Jp0e0bJD/NsMIQaC9NM4DRTtb7rUCgRJzNkRqRGjlM/cwNyLQsC6JFHwAaiMCoRSTe4xMromS1fGBb9/fFZ/K4V5n9PZYuOJPG0bC9iJG8qC+6aRv0S9+/CunpfCTpQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMs61SNGrpbQB+S0ankZjH3Psh58YXWqsyTE9PT1at0=;
 b=bmz4at1P1nmMqQX4k6C9i+ephSqFOxvH52ixOCsviFlfSIPTTrQZeF299YTgvlX6rz3m9hgMmloTz5JIAiRpPWCpspae/YFHaqwry/ypypfvAy5yO7kqKW3qyG4rIP1nPkQZOpTRzUQveB9lOSAPWv94aJUIumVLnnoB0QzeEZjc/8nJpXsPPRk6wQN1yq8QJJiOKgypinh1Asgg1r1xhhJVzUbDhSqZIt19QXEbrj8MKENq5mf304FUzGITS+NO6L951eLRIqjcpCT17w3EUScNpgHwYh0j2XKYeuE5nYfAPdxKFf47YeA3wTqA8/J1CWqctqntMapxi8ZbKpYvWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/31] Renesas RZ/V2L extend peripheral support
Thread-Topic: [PATCH 5.10.y-cip 00/31] Renesas RZ/V2L extend peripheral
 support
Thread-Index: AQHYsWyETGIjT9M0a02aohdRDfa4kK2x+WMAgAC5hxA=
Date: Wed, 17 Aug 2022 07:29:11 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942097E1E4036D075DC470DA926A9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220816202400.GA31726@duo.ucw.cz>
In-Reply-To: <20220816202400.GA31726@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af5d787a-b156-48f5-0952-08da80222dc6
x-ms-traffictypediagnostic: TYAPR01MB3967:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 qeF3rHObRdLlPPbWnDU4rT9ExxBMTwkCXrfYT6W/+cnzwqJQfMD17TQge16jqYvy6BVD/FWSZS8q4ca+BEsZN/rUhVTsuT+9QuP7M8AxKmu+YRwFSX1h3fyKceV9uWOEssTQ4YcjVGgwY0jbhIuK4mn/Vwxe0lSeVnkSvTSLRiRrMoVtOpdsLQoR1q+l+s90xh2JCCouy5UdSVjm5v0RHSg8sF0A17lrTRFvnAzKEoxJg2fHdhUnqCexKTBzntge9ghGLped9mxcEaD+SxhGLNxoO4cLmA6UPWm+vg89jA8DNvWySVEPfd2ib1n/DgBrJc1N8LHVEEe2xDbHiMKZgGHFxPcEU9kxrDGWi/OvPjj6zehwj1/4+GezX9WN6R59Xf/7hrYXid9ds1kv0WuZ+xRb2JDyN7PrFg0F+rYkyimvoIptEufl1Rqguw0+VsW9DvbsbDVHWCLimQTLpchp1HCLLvryWBVoiNea0WE9+gM6weTmEKUdDqHgS8PhxZmHgul8dXbquFzAHQ1IwFM8xUOkojYlFsDp1bZxBUZgfxLc6y3dWGmmtGAArhFf8Z1iNTQxXn5Pa/+faiQQj1aFQkT7tKjOj45JlUkEihhnaCHUV+qDRfxOVvgS4gs/ZDSoxfGgy/2egj67EcI9whkMHHcLGFlmNKOzYVjZEvRkba02+YIOZNJSXWTgNDfgbLBY+jZSkx8SUqlqLJU1FqpAmc5cW/RTN2BlApfmAi1v4wZ4ot/MHMm2fGYjbCLhkfIHNNaFG1ZawRHPN+C03MEN2oXuyPT482jO1z2vuR6ohNE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(110136005)(66946007)(2906002)(8676002)(66556008)(64756008)(66446008)(66476007)(76116006)(55016003)(6506007)(71200400001)(7696005)(33656002)(4326008)(54906003)(316002)(41300700001)(52536014)(478600001)(26005)(122000001)(38070700005)(53546011)(9686003)(86362001)(38100700002)(5660300002)(8936002)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VWYwR0p4ejByVm12aUlHTW04UG0remFWZnNFQmR3Z3RUUitGR3E2d1Mx?=
 =?iso-2022-jp?B?eTh3WDE5ZjZnUXZzeS9BcGsvUjJ2aW41Z0NNWmxrUUx4REN0WnFkejZv?=
 =?iso-2022-jp?B?UWFGaktsME4vWjNhWllRK21LRUdpUE1sWUozcXlWZ1Eva0o5YnJrMGlW?=
 =?iso-2022-jp?B?RGsxVGNWMGJvakk2bENrT3RUMFYwNzBFeU54Q2s2SFFKdE1pT3lVS0RB?=
 =?iso-2022-jp?B?am1RQ0ExNXllR3JJR0YzRW5FcnB3TlkrcEZ3b2hUek5oY0N1T2pEZGh6?=
 =?iso-2022-jp?B?U0NFcXB3VmVRNDNUQkZGRjJEcW9CODNkVEFZeDZmL2dUN1F5cEhPcFgv?=
 =?iso-2022-jp?B?S2RyTUFMRGxHa2hoQS9pVnpra1MrQ2VrTkk3YzZ1bGYyb1dybkJVSHNM?=
 =?iso-2022-jp?B?bEVhNXdxem9Mc29mNnRkWDNmcytPeWJCYXRlKy9PTEY3bXpSdVRpdUkx?=
 =?iso-2022-jp?B?cGkyajErbGFWd09FbUE3T0x4ZW9ZbWIxRzN6ZGdtT3g0TU90S2JsQ1pU?=
 =?iso-2022-jp?B?VE9HY0w1UG10WjhZb2Z1QnhjblI3VXlyMGdGUzhFQUwrNWtZaWpWbmtB?=
 =?iso-2022-jp?B?UWZYdnVQRzF3Y0tDMzdkT1B6eU9RbFgzWXQ4UXdTb3N4aG9kbGJwc29E?=
 =?iso-2022-jp?B?c0NvQ3ltQnJIK1Nmek1WNkJFeENUcnFvNVl5emluQzRnZ0JOUnJtY2tJ?=
 =?iso-2022-jp?B?K29OcHFIeVN2MmovekpWTTI5TE9FQXFpNkU0VW5qTEQwVkxWcFNENTJX?=
 =?iso-2022-jp?B?Y3hWd1ZUb3RCVXZ5ZHFxVlpObDVTUXNJeWJMQk5Hc2pjdFRtYm1PN3lY?=
 =?iso-2022-jp?B?UjJHekZPMmNrR3phNjVpNjZkNHNWa3FkQTVETXdaYWlTRHQ3Zm43RjBq?=
 =?iso-2022-jp?B?YTNZamJhdVNYbCtDbUtMVzUya1JvaGQzd1BqbFRHaXYrN3R3MVZ3dmRk?=
 =?iso-2022-jp?B?ZjhzbTlXdURITWxUWE9QOHM1TTArRlVnYUlpRWdyODZseEdqLzFWeXg0?=
 =?iso-2022-jp?B?cEpXa1ZEUWN0aW1kOXlxNkg4V2ZpZHc0aDdwajRXaENuSHM1VnlRVTlO?=
 =?iso-2022-jp?B?Q0VJOHl2WGRJWTg3YkM3dmU0NmZ1OGVVQTJCTGJZZ24yaGU3TERDL3BI?=
 =?iso-2022-jp?B?WThpbnlxRG85c0NKLzN3UTRrY3lHdzlQRWN6ZjJJdjRraWs5UTUxYlcw?=
 =?iso-2022-jp?B?OWdMQ2oxSWlpcVl5NjN2YmRIbC9SbDdSejdTcHdqRnF2VHBmNDQ2cVhZ?=
 =?iso-2022-jp?B?THJOOEQxeUZ4Z2J3blRZcWJ2YU5FQnQwMFE3dHZoN1lDd2VNRXdITkli?=
 =?iso-2022-jp?B?RVo4VmdCWVlzRHE5dTF4cmRXZ3A3KzdtVnpFcUdyRWVHZ3ViUVUxMHF0?=
 =?iso-2022-jp?B?SFhiQ0c4OVRWUldneG94ZVpXT00zZk1hdm1VenFDZUZHOVVGUFFMMWlt?=
 =?iso-2022-jp?B?T0EvWEtiNm1VNjl5UW9yZUhzMDFYWFBuZmlkWVMrRTN5a3JZczA0Nnc2?=
 =?iso-2022-jp?B?aXZWM1lsZkRyS3MrRjJoMGJNOXdmR2kvVGR6K1g5S3A1N0tncUdWRTFo?=
 =?iso-2022-jp?B?V3JMc0txYU0wcGEzMnp6N0FlUDdNdDZZMzhoclR6OE96Q3VXdGNnNmFk?=
 =?iso-2022-jp?B?dlNZV0JUK1JtQW8weE5zM2RZUklaS1M3allteDZDQkFqQVBQOG5ibHp2?=
 =?iso-2022-jp?B?UWx4UFZoUmQ4ZDhaZWRZWVI3VnZkSjQ1d0RuLys3R1NscGhVbnBMYmVt?=
 =?iso-2022-jp?B?UDF2cFp3VWZEdncrSFB0SjdxL0FhSm9pQUtPYjRNL24zTmJxYkpOVHJD?=
 =?iso-2022-jp?B?cCtXcS9OUExjeG5TeXJNWW9HdU82c3VMNUpabkpZL2VOQld5eDUwRUFa?=
 =?iso-2022-jp?B?cG1tUC8wcit6T1llZVFycndUZ29DQzVxUngraXdUYjZQcmcwMm04NXpw?=
 =?iso-2022-jp?B?Z2lTNzkvdGVaOTVYM1NEaExmZkhabzgwVlF2MGx3U0NhNDJidlcyNGgv?=
 =?iso-2022-jp?B?MjZEL0ZpQ1Z3ZVloT1pQK2oraVB2cHhPS0x2bVJJMnAwZ1dwekVSSjFU?=
 =?iso-2022-jp?B?NUZEaHhadVo4TGNTVmozN0gwclY5SVIyaDg2ZkllZ2ZuZVFsZ1A0OUJS?=
 =?iso-2022-jp?B?M054VU1zTzV4Qm1md3BiQ1pTemdDaHo3R1pJa3Rxclo0bWhEYVJ2Qkd2?=
 =?iso-2022-jp?B?SWpNRzFObzR2OHBEM0w1dTNKT0F0RkM3SDFNRi93NUhZengwaUY1WXNZ?=
 =?iso-2022-jp?B?Lzg0SXpxRTZ1RitDanlHYWxpb3JMSUdkMm95WHo4QUNzbXpTdURFV1VK?=
 =?iso-2022-jp?B?b2l2Z2NtbU8vUUllOTBLYWthcHZ2R2JPa1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 af5d787a-b156-48f5-0952-08da80222dc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 07:29:11.1386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 NOBf6Jn4ncEJZWwH0+C3dn4GbxB1IJ2xZwk+EEWYKfVrx04bR+mXGs5kkgBO7ch5cQycDli0zPB1YKJlKwjnyE/dWXu44y6Y99Pxr4Wnir6KqGpVozZw8aVDayZtEQfJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3967
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Aug 2022 07:29:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9271

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, August 17, 2022 5:24 AM
> To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#S#W#C"~#A=1B(B
> =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 5.10.y-cip 00/31] Renesas RZ/V2L extend peripheral
> support
>=20
> Hi!
>=20
> > Hi All,
> >
> > This patches series backports support for below IP blocks on the
> > Renesas RZ/V2L SoC and also enables on SMARC EVK:
> > * USB2.0
> > * TSU/OPP
> > * SPI/SBC
> > * CANFD
> > * ADC
> > * WDT
> > * I2C
> > * Audio
> > * SDHI/eMMC
> > * Timer (OSTM)
> >
> > Note:
> > * All the patches have been cherry picked from 6.0-rc1 kernel.
> > * Patch 13/31 is required for future addition of SoC's (RZ/G2UL)
> > * Patch 04/31 adds CANFD binding patch for RZ/G2L, device tree is
> >   already merged into CIP
> > * Patch 16/31 is a cosmetic change which affects both RZ/G2L and
> > RZ/V2L
>=20
> Thanks for patches. They look okay to me; I can apply them if there are n=
o other
> comments and it passes testing.
>=20

I reviewed this series, Looks good to me too.
I applied to Linux-5.10.y-cip tree.

Best regards,
  Nobuhiro


