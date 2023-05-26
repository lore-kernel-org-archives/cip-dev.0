Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C42C77B7C
	for <webhook@archiver.kernel.org>; Fri, 26 May 2023 05:48:12 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.2221.1685080083231633636
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 May 2023 22:48:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.155, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 34Q5lr2D016733; Fri, 26 May 2023 14:47:53 +0900
X-Iguazu-Qid: 34trvWc6zYw5vJBFFl
X-Iguazu-QSIG: v=2; s=0; t=1685080072; q=34trvWc6zYw5vJBFFl; m=OHv6wA2y3KbTAe9uEhYH065KkU3Me5x3poKpUpRqFY0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1513) id 34Q5lpTC035854
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 26 May 2023 14:47:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2g8X3JRh9DiU31SQdzbekNFjgcN5XaiKELSUeosu0nP8t2R5kw/OGQ9Eek1DJzri/HC1sELSayAjSwQtO+tgyWmjDFpiLqg0FUiw3sdB5At5IJquxkPGMalXV8YBBtrG0Am5LNH06Vinam+1Do7IpegIZc7IlryRYwVwk6944rIuzIjkOh+eqO/ClWnaq3BVsndVPAxZtw742rqD8QpPucc+HzzrTGoa2BCqOFbB6ejbYVXIyjEIjRHhfNoEfyXD90SMIC96XMGPvy+owa6fpKcL8GlUzDZbuFpYR33VikL65Qyc0pXpdWtWrhbJRAKvKg3nDQFf2eqbL2hbYczCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbvy1NYyAt/FvmPYiuqP6MdrKAvc9mKD+e8vOe7RrX4=;
 b=BGXnpw+6XvgsDMsTJk/SsExCiKpmmn1gLw0/ToJ84irbeUHgE5KS8Mly1ktfh/3tERvTm+lfVtOk7euKYqEzI+1B+dVuib5AkvCgrZqEGLc1M9p+98hpiOYsYWJ3PJXrTaTdTZQgHwbPxjnOb1Caql/Kgy1fuZtqUn2abmmtaypMU3GVUG9G1ijfI51Ri8jpKbvSuIc9/o+UovbMzGOPVct98IRIeOgD/OdAAeseYLzlvP9lIbZ5SdG/zuxMU5JrtxFJ/Ze+79wwY6rfnpPfJU4Hs2Y6rbgklsZ4M+XFq38Uo2n0IKB9cJOkEhzDi++l0nZI7t5cdX+iJ38KJcatRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 5.10.y-cip v2 00/10] Add RZ/V2M I2C support
Thread-Topic: [PATCH 5.10.y-cip v2 00/10] Add RZ/V2M I2C support
Thread-Index: AQHZjj450go/Xfex5UOIXwKa9dCQBK9sC/nQ
Date: Fri, 26 May 2023 05:47:49 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420A2C36904A2A95575D48892479@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230524124937.160355-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230524124937.160355-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS3PR01MB9560:EE_
x-ms-office365-filtering-correlation-id: b3a8d9d6-7e3d-4ee3-04fd-08db5dacbd1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 oxN8IfVTj99G28nlMMWnjbr8pHoN7QdH12hmjWf2VibllpCP9vHssok4en1uuMmxB3vAJdJlF2PMYW8ffpv8eOiw+BYEQm8CdMl1wyWls+oXJtj0AQRhQ5XjQpEXuyxoo3sd6udTH1ZZYRwQvLIZnLotXOjlcXiVBM02+SdBEZDRFXjEKT6HzWvNM8fgVdlhGd0WDiAUAQjUmGdgEwjCDe92dkTOXYc7PlO8gM/Pwk2zOLFkFmOlzAzQOuGkjTEcA3hhf1XgvmrLerXxdbVsFWZqtmJ0GWLhNlpl0AoN5r56diC2O3syA5JoWQlyE7V7Qm97DeeEnmOOu3X1MXwNV35iQEQksE/g8OWLrfEoMe0FiJbbLKXZjDLp1zsW718EhRpVRBXNwcZaOQ9MQ9bHsl48ZPJOzQ18Y/WiW+IwdtIPcuPvtCwhMuo3IQVM8j0TfAQ/xOyT2nawjhu1ihvL+oSiwqTQq51WDx55+9ZLIhTURmXgt4VyLlhEEf+AZUOmycMdqbJ8ziJ83FNvqVYlghnKxWHQaR8SrZ/+L/+U51ZKlauQpUppoCA9GIyAi87Dvc3NendlXyLMoTGTso+NHZeJ3HYtmxKMfnyoQNqPsTt/fKP2ihiKksnVWMON7qoAxnV7vaf6jsiSVnrZAdbvmg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199021)(64756008)(4326008)(66446008)(66476007)(66556008)(76116006)(54906003)(110136005)(316002)(478600001)(66946007)(7696005)(41300700001)(71200400001)(55016003)(33656002)(86362001)(966005)(122000001)(186003)(6506007)(38100700002)(8676002)(26005)(53546011)(8936002)(2906002)(38070700005)(52536014)(5660300002)(9686003)(83380400001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dWRnUFlpYzRMWTBIaFZWQzVXb0xNSGF1dFlMSEkvMXhFK3dkdEVuRVRo?=
 =?iso-2022-jp?B?dTgyNDBENFVnSnBJQWJhSE5QR3hSTkdMNVNsNndCaWo2bWNoMjVLcmdF?=
 =?iso-2022-jp?B?eU5GVFdnSm1LaTFkN2ZKajlsQVR5QmJqajMwcGMvNGVDb041ck14dmxq?=
 =?iso-2022-jp?B?enBHMUdjcjBmMkJuRkdsZVpwL2h3NkVoajQ5TnBMSU9TUlV3REYxNVBk?=
 =?iso-2022-jp?B?NHFzVStKekhBZFQyMnZWTk1vaHlWU25sTCs3a09FQ1VGUlU0UWNqYml6?=
 =?iso-2022-jp?B?YUV6bnFrTmRZaWhTRUpaeFZVU1laTDRNalZHS2RTbmFSbjYrNmxUYkZG?=
 =?iso-2022-jp?B?VjAxRmtrT3hCeFo5ZE1lSEozL2tlWkNIUHhIM3RiVURHMFVhMkc5djJl?=
 =?iso-2022-jp?B?ZzFoOGg2K3NjYnBpWkVuanNITnZyamJFWGRsQ2pTTVBha0p2aXIzM1Jv?=
 =?iso-2022-jp?B?R0taZ2tPVTI5ZlU0M2phMmVaL0hBZ0s0NEpFVGx3aGZtUzZDR1dzeE5N?=
 =?iso-2022-jp?B?d2ovbU40WGJTdXZyWXVtaHlybFNOUkh3UXRFcXZ6bTJBZi9uZTFwZytK?=
 =?iso-2022-jp?B?dlE4cm9ZdklmNkFXWG5tY0VEdnNTL0txWVN5Zm4zVS8rM0tSS2Z2ajdI?=
 =?iso-2022-jp?B?dkoyRTJnc20xb20vTlpzdkpPamx4L3FRRExyaDIvTHdWZzkxbVBPb1gy?=
 =?iso-2022-jp?B?NXBrYktkczBaQ2Z3Zkw1SE10bXc0WDJ1UnQzVUFMUW5BeGtLMG9lTlhY?=
 =?iso-2022-jp?B?Q3hOVFp5UmRlRUtEbDIzVjhISEJ3SkRsRzIxVHVTaFBpKzNGQzVIMWZp?=
 =?iso-2022-jp?B?OHoxWjd5MENxR0thNWkvRG14YnBRSUg1YzZqeFZxNWlhZkN2d3ZHZUJ3?=
 =?iso-2022-jp?B?cSs0bnFlTU9CUTZhS2NkWWMyejQrbnc5SWZBbnFEdUFFRjl5TlNzMGZm?=
 =?iso-2022-jp?B?cWhvUklUbTFLbjltaUtJZGpuWUw1NVlkQVpScnJRdmI2TzdXNnhBU2lP?=
 =?iso-2022-jp?B?TXVhM3g3YWJrWVNDSlBGSDhHdXIvNHp1anpKbHFvcGpiSzR5RHE3Ym5w?=
 =?iso-2022-jp?B?cmxyL0RPVXNkVFZ4aWs5NnFVUFd5TlI2ZHoweWZLZkJVNGQ3WnVCM1Rj?=
 =?iso-2022-jp?B?L2s3MGtyWkZTTjhoVlpmZzFTRktOSFIwR2IyQnFXTkVUbkJFcDc2VzRS?=
 =?iso-2022-jp?B?cTVvU3pQdmFNK25Wa01JcVVhdWxVRUtSenkxdFl2bmJ3NFlJMjVVTmcy?=
 =?iso-2022-jp?B?bG92aDRJSVJPZi9DUmc3dnhDRDBZaUhYcUpEYnVYSWdDeGdVYWJEZFVJ?=
 =?iso-2022-jp?B?RU1YL3RsYklsMVN2RXJsN2U3RTdUT2UrVkJTN0dFQittZERwWC9MMThJ?=
 =?iso-2022-jp?B?OEM0REovcEphRWgzejNMSUtBWTN6THk2aDQ0MHRUTFRLaGlPaEFLdFhY?=
 =?iso-2022-jp?B?YWJuQjJCOFA3ckNoaWJyYmVWYUFLWThOUGp4bDRDUjZUNFpXeTBLWWdT?=
 =?iso-2022-jp?B?dHk0aFU0eHBLNk5pS1FoQnlIWmFhenNtMkU4ckRMTENEVGRIbE9KclJB?=
 =?iso-2022-jp?B?azRET1kzKzlXWWIrNk1MbGs1VUdvUnBseE9UZEpFekhDS00yRklFVkZY?=
 =?iso-2022-jp?B?eXhYdU1vcm9McFFPOHczWnJtcU9VUVJrclNxWngyNktmbUsxc2tjYXVa?=
 =?iso-2022-jp?B?U2FadzBWUytzTzh1VytNOGM4UE16UkJnZ1ExNmFoWlROZE52YW4zREFC?=
 =?iso-2022-jp?B?WXNkdHFmYlh3WFlTbmprOEljQkhkY1BlZWM5VDNlWFNLNGE4UHZIMGxY?=
 =?iso-2022-jp?B?b205MnN4RzQ0c2dFMXdYWkFqbFZ3L29xL2plMDBTYjR2RGZybXBjaFg4?=
 =?iso-2022-jp?B?SnlTOTNCTVhzdUNweVB0dUp4cFJaR09oNGlOa0hNYmRHRWorVStCWDNz?=
 =?iso-2022-jp?B?Q0RZNnNKREFTWnYyTTVpekdETjVsMGhLTWNBU3A1VEtlOEVWTkoyTHc5?=
 =?iso-2022-jp?B?ZzFueHpTZUJURHlBanZVMFZYZzJyQWxvMnBKOEVqSHFYZXlLUXZFTEky?=
 =?iso-2022-jp?B?clhxQWh5eThZbTB0S25PQjBOYzFmSGYyQUZvWHdvUVE5ZGdRZ3hHQ3Va?=
 =?iso-2022-jp?B?dHVWTmFjbGJ1OFhqWHNReDJCMDVFb2UrQXRsZmN5VlBucEdESDlnczk3?=
 =?iso-2022-jp?B?OWFONElrcEo0SFQ3cHhYQklWUGduN0JOV0d5Y05LT09uZGFyMTdMQWRx?=
 =?iso-2022-jp?B?a3h0cHFGeGV1d1AyUUJqRndYa1FoVXdObDU3VC82cG1lYU54V2h6ZGxt?=
 =?iso-2022-jp?B?Q2UrTFVZV3hTaW51Z0pFTVRGSlEyNEJxUHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2Lgy0OcpxdnvC1ittOtwetnU3nuJPZz8+i/SDBz78HqJJJdYz6+GKy47FA3WNgScfEReIY48YupQC+L4PbSZP3HHG5PfzxSUeKsH0AqWfdxslKOsVpzNZeh6N4Z5ZVC6byKO6Uk/dCIiZGv51cgd62qSuKrbGdbr4JplQaub1AzZ9pAqfEWy8u8QbvL5cf051iBX59TwVFkhRkxylV4EGxDfGpVYhCRPSrTkatkGlBV0EO6gJFb7gb7vJVzXPrmFinaYkfTbFyzScvCMsqa0p86W4iIKjyZYGDHw/9p2aGy7sL/RpovWduSAG1szpAxPDiErfcvNEgqQ3xSLmZVROv0F1p6bMFc1NXEHWa72uK6ReKNUtCs5mQ/UtOZ+bRNtQpo8wE42GaiW04MePszbx0kpyhua9NyFtDzhuySU2pk6vI9+Y2z34sDSCco05GzFfD6w37VWLzqGDnOA9Vo+u+bzmVlxpk5ROHYSLdbHMS72m3AtGp7sAXnfj/tt7KTuQCF+Me/M8aTdgz6SjtfJx/q4dQ3bSm1FNIm0YLzxkNp0c8+iTtjGsso4izBMjXGIWLUxxZsp1UilCd96f9uGssPh+BVlkCkmecmEEMU+yk6V3o9KqPMzXvW3d5hnbTFDaSkQ7PNukpExJgABaPymnSv6MAM7e8R/nZPIXl3jebaWLseeDWxCSBdBjg1ETE9X99XhCNXrh6T3YMeQu9WfsiN7b7oU0dwZuGOZJnx5nNC1k+rsKnYy4STCZjIsDO4MkhYFIQpePciPKk9VrCXLcJ13XrE/BqTvMJOi0yTWs9YZ5qOGkqX8a5oSUeoZVoCTheBGwI3Lwpxe4/quY7wnZ77KAz+BA7Vw8DRJWs4i3KFlcAPH758hnwWCJ1xcrov2Ojr0CQDEjueVBLjvIZIr6A==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a8d9d6-7e3d-4ee3-04fd-08db5dacbd1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 05:47:49.1011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZlBVlMyK5gFebiwr8g9r7ttNcXkqCnAAcWsf5n5hAvxZJOqbuv2kj+ZwRd8M27y6j0Ro1fKoGIqCi2Rygi/Tx0qUX7jK13zBSTvIggUjQP+zisiTNy9qVfyog0uP4GkD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9560
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 May 2023 05:48:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11647

Hi,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Wednesday, May 24, 2023 9:49 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Chris Paterson <chris.paterson2@renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>
> Subject: [PATCH 5.10.y-cip v2 00/10] Add RZ/V2M I2C support
>=20
> This patch series aims to add I2C support for RZ/V2M EVK platform
>=20
> All these patches are cherry-picked from the mainline.
>=20
> v1->v2:
>  * Dropped patch#2 and patch#3 and replaced
>    SYSTEM_SLEEP_PM_OPS->SET_NOIRQ_SYSTEM_SLEEP_PM_OPS
>    and pm_sleep_ptr->DEV_PM_OPS.
>=20
> Chris Paterson (1):
>   dt-bindings: i2c: renesas,rzv2m: Change maintainer to Fabrizio Castro
>=20
> Fabrizio Castro (2):
>   dt-bindings: i2c: renesas,rzv2m: Fix SoC specific string
>   arm64: dts: renesas: r9a09g011: Fix I2C SoC specific strings
>=20
> Geert Uytterhoeven (1):
>   arm64: defconfig: Enable additional support for Renesas platforms
>=20
> Ioana Ciornei (1):
>   driver core: add a helper to setup both the of_node and fwnode of a
>     device
>=20
> Phil Edworthy (5):
>   clk: renesas: r9a09g011: Add IIC clock and reset entries
>   dt-bindings: i2c: Document RZ/V2M I2C controller
>   i2c: Add Renesas RZ/V2M controller
>   arm64: dts: renesas: r9a09g011: Add i2c nodes
>   arm64: dts: renesas: rzv2m evk: Enable i2c
>=20
>  .../bindings/i2c/renesas,rzv2m.yaml           |  80 +++
>  .../boot/dts/renesas/r9a09g011-v2mevk2.dts    |  27 +
>  arch/arm64/boot/dts/renesas/r9a09g011.dtsi    |  28 +
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/base/core.c                           |   7 +
>  drivers/clk/renesas/r9a09g011-cpg.c           |   4 +
>  drivers/i2c/busses/Kconfig                    |  10 +
>  drivers/i2c/busses/Makefile                   |   1 +
>  drivers/i2c/busses/i2c-rzv2m.c                | 538
> ++++++++++++++++++
>  include/linux/device.h                        |   1 +
>  10 files changed, 697 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml
>  create mode 100644 drivers/i2c/busses/i2c-rzv2m.c
>=20

I reviewed this series, LGTM.
I can apply, if we do not get any issue.
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/commit/090289427e8b=
2be9dac126c4d1b760b100f2c6b8

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


