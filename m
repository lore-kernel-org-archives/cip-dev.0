Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B756C433EF
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 08:50:02 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web08.4396.1658825392225805380
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Jul 2022 01:49:53 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 26Q8ngA8011921;
 Tue, 26 Jul 2022 17:49:42 +0900
X-Iguazu-Qid: 2wHHJgaTydESYCg1qv
X-Iguazu-QSIG: v=2; s=0; t=1658825381; q=2wHHJgaTydESYCg1qv;
 m=QVe5/mqhb6yhRY+lfRq8Hv+R4uGOiJe7pfsgLptSIxo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1110) id 26Q8neD3009928
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Jul 2022 17:49:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFS9o+KFU+L353yM+eoPewTko1vx0+gFsXHQdBd+lx+Pw+bpQExbeO7rOi+bcvcmlA3BWC4Tt+FWVsyXys5jxzv0fmeatGwBWogZDiwY0m2TvAGligcxnTIqQA6kdjdkf4zpqWzpwLGohfRNBIiZ3nvnX1I55Kgx4hYvv/1vd/2+VA/PQK+sfiBmBWBxHFNQWc/EgyQUq/BQ9yR0q/uqZ+yXTpg4sHWQE8VcQ3WSZ4gx3/s97giQm5aoHGMEKeXm+/gHtWSMMpxfNbWui0UwRkh1wh9AQYbYuh75a+G69ULa2EK70k2r7zGjBXhCon9BGM0AHxexUCtDuBUW1wGVqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfiG4PExQNbody6FD0U500AftyfXCRcXVD5GQ4LYork=;
 b=G/LPaFG8BCfOUBiHt6WS6lfqmwviStsOqhugczG98WiHB2iMEjd9qAPF9Td43VIxZYeQp5QqinglDUXiz2T8O7JndwK4bZQemt0Wxhsf+e4Vm1ySZqparBJOVuiK7bQrqg50TQcMnz1BjRxdE2vWx7G++HOgJ1srDFHsQMXHSRkJq+MHLUMPfHIw6bSYcw8iVnhGbzsNk6aVcpmtjsNyUp+xnmcBD5SX7PwOKx0eqPzmixdCheHbeKOjzfFaJ5ZS1mKz4bl7OgqMvuMQFFmDMzA5usSkzWD9tZ0oYfplmDfPpiTVnEh2Bl4Wg5KglSC8S6vNGrggYuNdOH2uwx2Epg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/24] RZ/G2L Fixes from mainline
Thread-Topic: [PATCH 5.10.y-cip 00/24] RZ/G2L Fixes from mainline
Thread-Index: AQHYmBu6A7Qs7IK0E0+sSjOC/AQmuq2QaHRQ
Date: Tue, 26 Jul 2022 08:49:32 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420641E3E74AABE6703758792949@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49641e4e-fd51-46af-be4a-08da6ee3c2bc
x-ms-traffictypediagnostic: TY2PR01MB4347:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 9nPpcJwMMzXyYbRbgcewAfoLWnZLGnfc+ZbAuwsC/L/m2vULEYHFb7yJqT0YwREn3DvQCgNsSmhDlQXx2PcyohlRp11FtIMHZxXpCi/2ZTzDqx0302Klhnu6BXTTZP+ERtYrtI6NVg+qbMEQlCDBM7ivtstpfn7mNpOI9siJKjWC6/3eCqdYyvoMRFt/9DQKzV09hw9Vb8c7eaN6csneEnBqbnZpsBNSD8WZDosqAO9O1A4Vrc69GuZGRNaUORjvbctrm4OJbElAJEB3TIGuwE3VukRTzcUUbGW1keBMUpE3P5kSiuctyEG+T1tMUMhcMZ3I7XZZjZhEYuhdk9g5N3Bq03Ba5BYO4kltNFxmlB/mRii8f8Shj/thGzI5D2/cugBeKJXI7kPQJgN1fg6WMPaUojr3TxQTknHYFpUsVHNKfYmdRnkIyftG+8GdNcJcMcIu8za9OzaDUw64ZV2Lez8oaNAhjs+XZywrPPeIfwL7Xe4WG2jBJKaG98iVPMEvu0ZitkOJXP3IeM8673CToy1euYt1cxanuRsccN1j2ifJ5rQlbc9Yv2D9EVjtixAQEAyDOnE2urcmuw6HGkNZxz7YCSIfzzXBASMDhLTLwAE4ME/uqg6ad3/MY8FT6x7GxADb0QJEI9plTpla4wQUX6V8rXJ0k1iM4Um7cFM1bnDYfcTpmEyJMrm/8M8HB/LYtdlnizlf4XvYNhgXuShyF+PBqOyjR2w62koVMTyXXDvXBMS4Gg4krI1J/xtlyZ8erNWFMr/bmc8liGGWJJMpFIhPVscgfEO9u/zt+UU8afvdMXSwnvLwP6EirzMxRTkC
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(54906003)(38100700002)(41300700001)(186003)(122000001)(2906002)(110136005)(316002)(66446008)(8676002)(66476007)(76116006)(66946007)(64756008)(4326008)(66556008)(38070700005)(478600001)(5660300002)(53546011)(71200400001)(8936002)(55016003)(9686003)(33656002)(83380400001)(26005)(52536014)(86362001)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZSsxRXJsTDE0SzExKy9paVJNSGE1VzZYYzh5T2VOWnhxeEs2ZlNacVQv?=
 =?iso-2022-jp?B?K1FhcHcvMkpIcWVEdXVIOFBKK1NZc09jd255ajV5QnU1UDRYdnNVZ0Qw?=
 =?iso-2022-jp?B?RitxNTlGTDZOVE1FbFJ6Y015OEc3SXpBaUZITXpRSmppd0IxZUdYV290?=
 =?iso-2022-jp?B?alFyQ212ancxbkIzNGNERHpsdElJcUV1bU9aQUovUDBjN0IyM1lkNFJn?=
 =?iso-2022-jp?B?b1oyK25xaWhCbHFKalIvQ3NjZG02ejd6UHFPODlaV0hISGZEbzZjanBt?=
 =?iso-2022-jp?B?YUd0dXJyWkdub0N5RkhHNDljSHg5ek8xYWpSUlpwUTZleGdJVlZmc1VN?=
 =?iso-2022-jp?B?R2o4anJWTUVTSSs5OW82ZC92YTNkSDJtNXNLcVN3YWJLRVZqV2h4WWZ4?=
 =?iso-2022-jp?B?Z0hqRGlTcGxaNlJNSDkvV3hoQzMyWlByU0p5OXlOdm42dldRcjJxZnBG?=
 =?iso-2022-jp?B?WGZVdDBaY1pXSCtTdzZ3MGUrakZuVWJnNU95bUtBbkorOWZRVC9QOFlz?=
 =?iso-2022-jp?B?TXFDYVhZMHpEblhXS1oyY3c4VnR2NUlQYTRtRGJVUlc3RC85VTFkQXBG?=
 =?iso-2022-jp?B?NWswK25OTWtmalRWdmp1WnB2cE9WakhWc0EvNVZodXArSUVKMit0dmtM?=
 =?iso-2022-jp?B?QUtaMUU4aDk0ZW1JdTJzbjNLWEo5dDVZQlhzUTlWYTBmVElBQ0ZBSFhw?=
 =?iso-2022-jp?B?ZUJ6ZFdROFBQOXJjZzZMY3hHVEhScmJnWjB3bEtvS2sxYkpQRlQyVmp5?=
 =?iso-2022-jp?B?UXlzV0I3K1RCODhYY0ZZWGtGSWZaRmkxb0NET0dIZzA2Zzh6R0k5SHp2?=
 =?iso-2022-jp?B?NnYwMnlNbm9ZeERYNHR5b2llZ1J2UXh4eUhQbUIxS2lzQlZJZ254bXdl?=
 =?iso-2022-jp?B?QzI4RTBqTHB0aUVkRUhNR1F2Zk8xVVlaUUhlWWZjQTJVVjkyenlobEpa?=
 =?iso-2022-jp?B?NXBEVjVUYko4N3VyT0g5OXQxYWVGSWtlZXJ6R09yQ3g0VHJKamsyR1B1?=
 =?iso-2022-jp?B?anZ4eHFYUjBmWHJCaEZ6U3Bra2VjS2Z0aFZENDZwcUtCZTZzT05pM3hm?=
 =?iso-2022-jp?B?ZHMvRVhzVzdPUWNvbERRUzJ1S2pLRzFiR05TUm1IcWplaFIvWklKSzBv?=
 =?iso-2022-jp?B?ZWE3bmhrbjB4OFZuOG9lSmJiQ1JMZlVMcHE1SEp6elYwYVpJVmlBME10?=
 =?iso-2022-jp?B?RmFIbnhQckptV2lVbk81eXJHcWNNRUcxVllwczlpcU9BSk9wQ3BXYlFO?=
 =?iso-2022-jp?B?WGdhZk1rSXFRZGl0UkE4Y0ptQm9ncVhqREw0UjNvbWRjQ2RQbGs0MXRD?=
 =?iso-2022-jp?B?dTRHVktMODdNTjJTMUpaQ1lDNng3TGdjZ2hzNmttY2xQcldmdzFtR1Jr?=
 =?iso-2022-jp?B?K2ZhMUVwNEw3RWhud3Btdy80bDlWc04yWEk5SEhES3JSVHNrU0xsTWFi?=
 =?iso-2022-jp?B?ckFNQ1JXc0JHYW1kZmFXUktEbEFmUXhyU3FKK1pWSEVRc2JONWdvR0lH?=
 =?iso-2022-jp?B?R3k0VWpzdE00d3ZDYWFOclRSNmZNWTlsRk5YNzJweVBGdWhiYmtsRk1w?=
 =?iso-2022-jp?B?clkxZE5PNmpveTlia0orZXQrbmtDTWxQTmlXa3hWR2l4VHFmaWUvQmZo?=
 =?iso-2022-jp?B?eHcrcDByd3VldEw0YU5JNFpaZDZRSXg2OGozTDJSUFhZWmc5aGk3ck5F?=
 =?iso-2022-jp?B?b0JUZ3dMTnBKemdkZG5mT3JzV3NzY1F3MGU2bFZicVJja2RqZk91cHJL?=
 =?iso-2022-jp?B?bXZ2UisvRmE0Z2VJTE51d3A1dittMXFjOTZZckpzeU4wUG44MVpqOUQ3?=
 =?iso-2022-jp?B?a3lsaEdNUXIzQXEveHR5bTdMVXU1eldicXl0c1V2TFg4V0lBNHVSMXgx?=
 =?iso-2022-jp?B?V1B5bnllQzRtbzQzTGxNQm9pbE11anpwV2JJdWdpUDE1c1ozMWdySExE?=
 =?iso-2022-jp?B?dEoxZ2lWRVptbU9tSkNmZVRLQjQvc2xzNmlObEhJVnBwaDNZMWJqSjRl?=
 =?iso-2022-jp?B?dzF3YVg1Nm9pWHorM0FBVkQrMUdkL1Rmb3I3NGdZaUU4ZnVwazRBRFc1?=
 =?iso-2022-jp?B?cEhmSHlGOTVLVkcyZmVITVMyQzJSd29DV0VwUm9aNVk5aHUzdkJnM0Nm?=
 =?iso-2022-jp?B?THEyV2dtSnl2OXZ3ZjdQZHh4cnJSMUlrdStFSWg1MkJOM2RvaEtXZ2JB?=
 =?iso-2022-jp?B?WGZqL3cyOVVxWDJuUUlxdWdvRmthdWp6NHFjaXI1NGtRbnZ1bEFUMkhp?=
 =?iso-2022-jp?B?eGw0a3Jvbi9sMFB3cnRWeTJDdnZQVGNraUdZTDZnMEU3Tm9jM2wwK040?=
 =?iso-2022-jp?B?bHBSV0pqMkVvNkxlNHZpbXRQWTRKWVJmaXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 49641e4e-fd51-46af-be4a-08da6ee3c2bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 08:49:32.9814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Mh87+5/cPQ/Jdtp51SJ41oGJfetbXf8iHXVatG4qP6sHCigoNmpZGyj++b0CkhKfDOzwfwYwyN7vmSiG2ePbeqoxmZC24+HRN02jTipMRCG5bdhvCS4PtBpO4t2yYeVV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4347
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 08:50:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8924

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Friday, July 15, 2022 4:22 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#S#W#C"~#A=1B(B
> =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Chris Paterson <chris.paterson2@renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 00/24] RZ/G2L Fixes from mainline
>=20
> This patch series are backported from Mainline for supporting future SoCs=
 as
> well as various bugs and improvements related to RZ/g2L SMARC EVK
> Platform.
>=20
> All these patches are cherry-picked from mainline.
>=20
> Biju Das (6):
>   dt-bindings: power: renesas,rzg2l-sysc: Document RZ/V2L SoC
>   soc: renesas: Identify RZ/V2L SoC
>   soc: renesas: Add support for reading product revision for RZ/G2L
>     family
>   ASoC: sh: Make SND_SOC_RZ depend on ARCH_RZG2L
>   dt-bindings: dma: rz-dmac: Document RZ/V2L SoC
>   arm64: dts: renesas: rzg2l-smarc: Move pinctrl definitions
>=20
> Geert Uytterhoeven (2):
>   soc: renesas: Consolidate product register handling
>   arm64: dts: renesas: Fix pin controller node names
>=20
> Heiner Kallweit (2):
>   reset: renesas: Fix Runtime PM usage
>   reset: renesas: Check return value of reset_control_deassert()
>=20
> Jialin Zhang (1):
>   iio: adc: rzg2l_adc: add missing fwnode_handle_put() in
>     rzg2l_adc_parse_properties()
>=20
> Lad Prabhakar (12):
>   soc: renesas: Kconfig: Explicitly select PM and PM_GENERIC_DOMAINS
>     configs
>   soc: renesas: Kconfig: Introduce ARCH_RZG2L config option
>   iio: adc: Kconfig: Make RZG2L_ADC depend on ARCH_RZG2L
>   dmaengine: sh: Kconfig: Add ARCH_R9A07G054 dependency for RZ_DMAC
>     config option
>   dmaengine: sh: Kconfig: Make RZ_DMAC depend on ARCH_RZG2L
>   reset: Kconfig: Make RESET_RZG2L_USBPHY_CTRL depend on
> ARCH_RZG2L
>   dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Add description for
>     power-source property
>   ASoC: sh: rz-ssi: Drop SSIFSR_TDC and SSIFSR_RDC macros
>   ASoC: sh: rz-ssi: Propagate error codes returned from
>     platform_get_irq_byname()
>   ASoC: sh: rz-ssi: Release the DMA channels in rz_ssi_probe() error
>     path
>   iio: adc: rzg2l_adc: Fix typo
>   i2c: riic: Simplify reset handling
>=20
> Xu Wang (1):
>   iio: adc: rzg2l_adc: Remove unnecessary print function dev_err()
>=20

I reviewed this series, so I don't have any pointing out.
I can push to CIP tree.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro

>  .../bindings/dma/renesas,rz-dmac.yaml         |   3 +-
>  .../pinctrl/renesas,rzg2l-pinctrl.yaml        |   1 +
>  .../bindings/power/renesas,rzg2l-sysc.yaml    |   7 +-
>  arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |   2 +-
>  .../boot/dts/renesas/r9a07g044l2-smarc.dts    |   1 +
>  .../dts/renesas/rzg2l-smarc-pinfunction.dtsi  | 137 ++++++++++++++
> arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  | 127 -------------
>  drivers/dma/sh/Kconfig                        |   6 +-
>  drivers/i2c/busses/i2c-riic.c                 |  34 ++--
>  drivers/iio/adc/Kconfig                       |   2 +-
>  drivers/iio/adc/rzg2l_adc.c                   |  16 +-
>  drivers/reset/Kconfig                         |   2 +-
>  drivers/reset/reset-rzg2l-usbphy-ctrl.c       |  11 +-
>  drivers/soc/renesas/Kconfig                   |  12 ++
>  drivers/soc/renesas/renesas-soc.c             | 173
> ++++++++++--------
>  sound/soc/sh/Kconfig                          |   2 +-
>  sound/soc/sh/rz-ssi.c                         |  24 +--
>  17 files changed, 309 insertions(+), 251 deletions(-)  create mode 10064=
4
> arch/arm64/boot/dts/renesas/rzg2l-smarc-pinfunction.dtsi
>=20
> --
> 2.25.1


