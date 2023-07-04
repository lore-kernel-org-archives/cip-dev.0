Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9986CEB64D9
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 04:43:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.51746.1688445782861423227
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jul 2023 21:43:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 3644gtR12221425; Tue, 4 Jul 2023 13:42:55 +0900
X-Iguazu-Qid: 2rWhJyZQY6F0i3OjWU
X-Iguazu-QSIG: v=2; s=0; t=1688445775; q=2rWhJyZQY6F0i3OjWU; m=Zn4jFFnkZxuBJ/mfxVbDT3jYzFN0VofELP+RdUN9RUE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 3644gs0o3104741
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 4 Jul 2023 13:42:54 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOJQ9xJlHvaq2bO5c4T5uvaXRXbXzudHv8R0kuhKsJYuYG6Qxmuwa69asL4NKAxPQ7engkQv0JaBkRp2M65+4I3NfPBYzb2fOPVk0V+r8sj47va5PF4UkizX+fO11iLkx0HX/6Rvzk4GdL0E9pU2KBSqE23k1d1Kp9xvpjsfyXJ1V6XVGopjNZzSCcONix8H1kkKJ6P/rzAs2us5Vfj7uDB2inZ56FfaHuXANOSZrV24M+mCi5sz/FXYSXHHiWFG4cO6fIJePNVPTzy4jQwkKI5tx0EWBgdcltcp46LptDpurtEPi2FH+7qyIc+JQPtMiz1yjMe1L61p7Bl+IA5p8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KknKuoJBx8qY+6q1ArxiwEpNEiMjXNwXv05C7v+TyU=;
 b=ixbTdYuIF7smWAJFWBEuYEFcOeYlYcDxGUSxJUSn/505P7eAtr+iFVFIlyd6eYsqg7W/uzJwxaVoXBICoTsy6+v5aoifE5KFjHDL2fdXJ2xS00vQKDRMFC2Dzvdo2d0ynyARI1oCGYTvIT/rzMe0wLfZRT2rpFl971vw795hOZGZ2hEnZT6D8Cz9FTOWyVlPpgjvO2m3ePzJ1cAwOhzBkx8DGp5x3ELIP52oQ0xgB0RoLmV5+MJ/Qxloo+W+j3ttDtdfJyEWCjRvs7ETvgscmnUfQmKtazMa7tLIPfGHSBfB8KzUofmgTSXyeUxCvn98tIMoHnRnOFOichpXubfISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <fabrizio.castro.jz@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
Subject: RE: [PATCH 5.10.y-cip 2/4] soc: renesas: Add PWC support for RZ/V2M
Thread-Topic: [PATCH 5.10.y-cip 2/4] soc: renesas: Add PWC support for RZ/V2M
Thread-Index: AQHZrdAmhEORTh9a+0me1+EhbGI3Ma+pBj0A
Date: Tue, 4 Jul 2023 04:42:50 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420F2EADFD20272DE1E5588922EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230703170211.15484-1-fabrizio.castro.jz@renesas.com>
 <20230703170211.15484-3-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230703170211.15484-3-fabrizio.castro.jz@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OS7PR01MB12044:EE_
x-ms-office365-filtering-correlation-id: 8febda87-1253-4890-8dac-08db7c491f8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 RIbndpaKH7cw1XG0cREAVCXrN9NqJX5jA/cYzNRFEL/XHAzVsJqTaY/Gzbl4gxHLL0vszj72ZXArBDKOw4tvTFuYRwnCyN/ci+xhuZtNY/WD6F/ygwkam9K8qna20A+yrosAbJJLLCVRDEbR2jHCZgrq6QFcT2/7MRGqD1Bcp+xEwdEvCqkNdUltJQ1tuJBDb9AD5bYzMw0zucAmlqPlL4xOoLIJth/9UaUgSmjadAwgcAyu0SrKzjNTq0dNc9n5++0w7AyvHD5IoOtiloz4/01g1N3SXH33/TAd99m4wrk17B+Z/noMv/MRuZ48YokngaICAzuq2TKD4Op7ZmePR9wd7YxCxtOd5mDhlNL5ihwHMxS6RmagmwbOp4aAUMu70aUgu7vi4Lz7hiDXpQb+Pa0oHH5oGMVO3Fp+0zED60R3ptCjhxICpNGpputhFT4YMnNS7Oru5KRtc8l+vlA3QkM7NtOLG4d0BIFh/P9Wv7qrZSalH/y0YxTKxACrzd7M9Fi0u2hAWtjqcjzVMygOPnoYeIVYwDwO86ED9c29kk1ydExzi1uFWoMlDlRbeY2TERZr6qxxbv3qMZNiSpC7Wi95Ojdc8j3GFIpaj+xgU+bcM9BPyjIJYbeZ+BfS4e/c
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(26005)(478600001)(966005)(9686003)(71200400001)(6506007)(86362001)(186003)(38100700002)(66476007)(64756008)(66556008)(66946007)(66446008)(83380400001)(110136005)(7696005)(53546011)(76116006)(316002)(122000001)(5660300002)(8676002)(8936002)(52536014)(38070700005)(41300700001)(2906002)(55016003)(33656002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NDVTNHh2eDYzRVg0ejRBNmd0cG1PUjRYV0gzL3BwT0g2Uk1YN2VyeWlv?=
 =?iso-2022-jp?B?M1pmZnJ5bWdyTzRpdHF6akdGUXE0d0lwK3RZRkFqMzVhQm1FdGh5UTFq?=
 =?iso-2022-jp?B?cTYwSFBZc2FxY2Y1eFZBWHNzditmV3JTNW5xYVdvOGxjRExYS2lJZmdr?=
 =?iso-2022-jp?B?NXVNYkl0a3Y2UWRHaXBXVTVpczdDb2dMZWR2RFRic2M0ZlYzUjFoclNO?=
 =?iso-2022-jp?B?TlJPQmtDYm9ET1BNWWVpQkVuOUQ1emFxWTMzZWNyL0k3cWlKbVpCb1Nk?=
 =?iso-2022-jp?B?UXp2cjg2eDhXOWNlZlRhNHF4TXI0RjlNL0lwMTh3aDBoL0cweGRLVVc2?=
 =?iso-2022-jp?B?SkxwaEpMV09yNnhLQndSZ09ZT1FOVy8rMEthMjdxQTFNVWpYaVBSdU9L?=
 =?iso-2022-jp?B?ZTUvYmpSVHFPbFlhUlJqUWxQc3diSUZwNk9DM05xYklQWXdXYk8wbGNu?=
 =?iso-2022-jp?B?OWVDYUNDOTcxT2R3NEk4K0wrRG11QnRZb2l6cFpGTW82ekkyRmJJZzN0?=
 =?iso-2022-jp?B?aVNYK0JWSWNjaXkzclBESXZvRnNvTnY3Z1NxTWoxRzU5MXpTSnpKejFZ?=
 =?iso-2022-jp?B?TDdTamk0eTAzRE43RVc2SFdYNFgzcjIydC93bldkdVB2YnExc3V1Sm1s?=
 =?iso-2022-jp?B?aHZaZDllODRKSmd1ekVJaFFlY0o4cWhVZ3c1SjNZdjhjN0hROEpZVVNx?=
 =?iso-2022-jp?B?Vlk2b0sycVI5WG1mdlFEa1QwSTNjT3NoQ1l2Q0xKb0JpZlh2T0RLY1FF?=
 =?iso-2022-jp?B?NDRLVVpYQ1k1UUZVSFU0V0czaVJReG9WOHg3dk4yQWVRbVJXOGlBVHR0?=
 =?iso-2022-jp?B?TFFXOTNvaDBNNHdobHNUcnFUbTVLR1VGRWlzTW1lSGdKY2xCakxzZDhB?=
 =?iso-2022-jp?B?dzhpYUFsNFY3Vk1uWkp2VUlrdG9yeWpEbHNsMldkVEoxMFBrS2prK1Ni?=
 =?iso-2022-jp?B?YStlakNyV3NZUy9RWDgwVzBkMmZBYS81cktkTXE4OXkxRmQ2QXJYdlNE?=
 =?iso-2022-jp?B?NHEyVytyVDhGaUJBeU5QRWU3RlNGekpLaE1uU254SUo1UEpoODNPd1Y4?=
 =?iso-2022-jp?B?TkZ5VjNLN0Q1SEFiR0lESXJuTWRCNUxTT0RWUnpDa2NGbjE3WS83Z2VQ?=
 =?iso-2022-jp?B?cWY4aGRPZ2trVjdjNU1wRFF3c3UxSi9WVUVQaVdKOEZ2a08xamJzdzR5?=
 =?iso-2022-jp?B?TW9odWdvYXo0QlVSN2hNaFZodVp0WWdXS09qS3hHWlliYjdCOG1UMXpL?=
 =?iso-2022-jp?B?UkVpT2NuSDBZR1VpU0tKLzRwZDEyMG9pZFl1R0NRQ0piY0dVbG1DdktJ?=
 =?iso-2022-jp?B?WXlQcFl5QXliRkk5MmtMYXdvdHRjVnVrRmtrek54a0VXNTlGQlNXeW9q?=
 =?iso-2022-jp?B?YnFObzJlNzNnT2NjbVdrRTBDUEVsRXhZZFV3enJrU0NjSlR3YlJvdXVy?=
 =?iso-2022-jp?B?QUVHRHdUaXlyNW81Z044SDE3UlY1N3NJdmdHbWpZcHNvT3BoWWViSkU0?=
 =?iso-2022-jp?B?V21FSktiWFpzbFQ3dDBvcWhlcHZnK3BFT2Y5bXJJaXNhZWxLWkI1Znhq?=
 =?iso-2022-jp?B?dHJVZkpEc1FSSk9VR1RLSnZONkh4RkxQbEwrdFZXa25iK29HbEVodkQ0?=
 =?iso-2022-jp?B?SHZCdk5FWDJBSnhUYnVMQXc5cnhKSGhaakNlSHhpTCtRNEpNZUlwcWtC?=
 =?iso-2022-jp?B?Y1ZPRjk5RlBpemVuR3ErSnFNQ2FGYWJJQXpWWlBRQnBhQWI0a1d3bkFw?=
 =?iso-2022-jp?B?Yytra3V6cldXeTh4U3hQQ0VxRXJIWnNJUzF5WWJpbXhjOEJtakJkWmtN?=
 =?iso-2022-jp?B?eFZBYjllaUVmVnplSDZKbjdkd1F1Q3FQMkdaQUJybzF5SjNIa1RhM2dO?=
 =?iso-2022-jp?B?dU04MkZzdEJDNjllcjhJWlcxc2Jkdm4xRkRhR1QzaDVORzVienBxY1NC?=
 =?iso-2022-jp?B?VDNHN0NtQ0pwbnFPSElRd1diNHhqb3lpdWFuZmc5bUhEL0VhaUFxOWdm?=
 =?iso-2022-jp?B?SUVrb1RPeGk4SmJBNW5lNndlNFVHSFh2OHo2NHFDT3JWL0RZRXBCUllT?=
 =?iso-2022-jp?B?MlNnR1dQUmdNOSt1VG1zREZlNXhTdGVteEVhcXROR1k0UkUxQ2puZU9V?=
 =?iso-2022-jp?B?eFkxdDZ3Qjlkbjc1SGVTdlgzZE5vQXF3STJDdHBPcGp4WWxyVHZHa0pP?=
 =?iso-2022-jp?B?RnRpcEdqLzN5TWRYY2piMGVjNlNmNlhCWXRsN05USHF6M2Z0dzVHOUZZ?=
 =?iso-2022-jp?B?N2U4enZGa1YxUlZkOGNHTW1ONjZpRWtkWUtzMlpnUHNvLy80dlQ5aDlh?=
 =?iso-2022-jp?B?Ly9kcG9jYUNRWldVdU5RYW9mU3ZWZXM5T2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AKJ68/pfr4bXfHKwiFcaK6YTUHJrT/3uhtP8+HWh+NWOlOlDlu/X4LW1AlnERi5Iysnsm3oY+q4g+dVNENp+Gx+SpgyVChn+z5B4cWWAPS7EouQrCVVuFDMfceMf+t6w5bi1qUMqFwJ/x/EBkMN/kzLXFbOtSJRBbJ8FX0DRUPlz9O5+2xcqTX6iJyzJngCL2RhpsFJM5HeFNxXFPJ/r1LCNEnANBLx8c/FVVByofpsrydjD3meip7/5+f2pk5rCUbVC79yLhOiCv8RX6Cbfuv5KmRek7PJpL1nyV5fBnH9nn8tzpKAkkeCb7VWCwbhnpSsuwklFMWD0XarKeJwIFC8j86cRGZ/fgblQbWOP/cHHdxgeQeTNZ6ziMVsTk10KasedM83maRJCcAkpp6cJ3aMs2RGLly460YqqtZoE1R2SatOoGtriyY9278W38dK/AVzUQUDWpOvMaAvfMnH4EiHYiZzm6d5CYjpJ2TsYtifMwj8FQLvF6GHOf+Xr93c7c8nBYcsb3yQTjkqNXF83y0J9wUcNqpriDbfOtJMF5vBxSAe7gbl2lTc6KdpRWYjYq6jeykf1koIuU8QDd6nisEDVnsqRkqNHhXEZYqZt8Jmw1ITBH5QLsE+rvdrOwUlLylp8Id8g7X/XS6ygFf7sBPvzWKjC0fwCi4Cpc8+00eE4E/VQX/nJH/AcEPRYNPYtZ9l1XNTEv390xQdD0ajQB+Omye6HSYn7t63Bdb/YFNUeY8DBfJVX1aiAQk65vaBh1ydMC8J85YaaAnpiPRv/QVURZbMjcoO1Bt6YiUOn8QacZwmNd7BaKVdikAh33bv630z7g8tumMGZ8Xv4tGkrknX8iXKdV3zt0SlNjtNbB6o=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8febda87-1253-4890-8dac-08db7c491f8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 04:42:50.6741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DaNKE2mhweCc4BZEE51NITTkhDjGnOvOUMJbEGqFu09X/dLWlf5/Kq6eTjjgbUx4tBObjxiXFRrrWDKiXrxc+t0AFC3eWSDXtj/EYMdIPJI3qfvSDvEEEPB7E+X+vNff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB12044
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 04:43:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12199

Hi Fabrizio,

> -----Original Message-----
> From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Sent: Tuesday, July 4, 2023 2:02 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Subject: [PATCH 5.10.y-cip 2/4] soc: renesas: Add PWC support for RZ/V2M
>=20
> Commit 0c56f949f626e59ef7c5b18e2706fed2a6afc4a2 upstream.
>=20
> The Renesas RZ/V2M External Power Sequence Controller (PWC) IP is capable
> of:
> * external power supply on/off sequence generation
> * on/off signal generation for the LPDDR4 core power supply (LPVDD)
> * key input signals processing
> * general-purpose output pins
>=20
> Add the corresponding device driver.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link:
> https://lore.kernel.org/r/20230106125816.10600-3-fabrizio.castro.jz@renes=
as.
> com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> [Fabrizio: - Switched to using pm_power_off as devm_register
> 	     power_off_handler is not availble in v5.10.y-cip
> 	   - priv_pwc is now static to pwc-rzv2m.c as the
> 	     pm_power_off callback cannot access private data ]
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>  drivers/soc/renesas/Kconfig     |   4 +
>  drivers/soc/renesas/Makefile    |   1 +
>  drivers/soc/renesas/pwc-rzv2m.c | 150
> ++++++++++++++++++++++++++++++++
>  3 files changed, 155 insertions(+)
>  create mode 100644 drivers/soc/renesas/pwc-rzv2m.c
>=20
> diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig in=
dex
> a2d37a682dfc..dcc0d2ae1b2c 100644
> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -306,11 +306,15 @@ config ARCH_R9A09G011
>  	bool "ARM64 Platform support for RZ/V2M"
>  	select PM
>  	select PM_GENERIC_DOMAINS
> +	select PWC_RZV2M
>  	help
>  	  This enables support for the Renesas RZ/V2M SoC.
>=20
>  endif # ARM64
>=20
> +config PWC_RZV2M
> +	bool "Renesas RZ/V2M PWC support" if COMPILE_TEST
> +
>  config RST_RCAR
>  	bool "Reset Controller support for R-Car" if COMPILE_TEST
>=20
> diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
> index 9b29bed2a597..c571e8ef9192 100644
> --- a/drivers/soc/renesas/Makefile
> +++ b/drivers/soc/renesas/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_ARCH_R9A06G032)	+=3D
> r9a06g032-smp.o
>  endif
>=20
>  # Family
> +obj-$(CONFIG_PWC_RZV2M)		+=3D pwc-rzv2m.o
>  obj-$(CONFIG_RST_RCAR)		+=3D rcar-rst.o
>  obj-$(CONFIG_SYSC_RCAR)		+=3D rcar-sysc.o
>  obj-$(CONFIG_SYSC_RMOBILE)	+=3D rmobile-sysc.o
> diff --git a/drivers/soc/renesas/pwc-rzv2m.c
> b/drivers/soc/renesas/pwc-rzv2m.c new file mode 100644 index
> 000000000000..5bbfc6fe7a57
> --- /dev/null
> +++ b/drivers/soc/renesas/pwc-rzv2m.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Renesas Electronics Corporation  */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/kallsyms.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +
> +#define PWC_PWCRST			0x00
> +#define PWC_PWCCKEN			0x04
> +#define PWC_PWCCTL			0x50
> +#define PWC_GPIO			0x80
> +
> +#define PWC_PWCRST_RSTSOFTAX		0x1
> +#define PWC_PWCCKEN_ENGCKMAIN		0x1
> +#define PWC_PWCCTL_PWOFF		0x1
> +
> +struct rzv2m_pwc_priv {
> +	void __iomem *base;
> +	struct device *dev;
> +	struct gpio_chip gp;
> +	DECLARE_BITMAP(ch_en_bits, 2);
> +};
> +
> +static struct rzv2m_pwc_priv *priv_pwc;
> +
> +static void rzv2m_pwc_gpio_set(struct gpio_chip *chip, unsigned int offs=
et,
> +			       int value)
> +{
> +	struct rzv2m_pwc_priv *priv =3D gpiochip_get_data(chip);
> +	u32 reg;
> +
> +	/* BIT 16 enables write to BIT 0, and BIT 17 enables write to BIT 1 */
> +	reg =3D BIT(offset + 16);
> +	if (value)
> +		reg |=3D BIT(offset);
> +
> +	writel(reg, priv->base + PWC_GPIO);
> +
> +	assign_bit(offset, priv->ch_en_bits, value); }
> +
> +static int rzv2m_pwc_gpio_get(struct gpio_chip *chip, unsigned int
> +offset) {
> +	struct rzv2m_pwc_priv *priv =3D gpiochip_get_data(chip);
> +
> +	return test_bit(offset, priv->ch_en_bits); }
> +
> +static int rzv2m_pwc_gpio_direction_output(struct gpio_chip *gc,
> +					   unsigned int nr, int value)
> +{
> +	if (nr > 1)
> +		return -EINVAL;
> +
> +	rzv2m_pwc_gpio_set(gc, nr, value);
> +
> +	return 0;
> +}
> +
> +static const struct gpio_chip rzv2m_pwc_gc =3D {
> +	.label =3D "gpio_rzv2m_pwc",
> +	.owner =3D THIS_MODULE,
> +	.get =3D rzv2m_pwc_gpio_get,
> +	.set =3D rzv2m_pwc_gpio_set,
> +	.direction_output =3D rzv2m_pwc_gpio_direction_output,
> +	.can_sleep =3D false,
> +	.ngpio =3D 2,
> +	.base =3D -1,
> +};
> +
> +static void rzv2m_pwc_poweroff(void)
> +{
> +	writel(PWC_PWCRST_RSTSOFTAX, priv_pwc->base +
> PWC_PWCRST);
> +	writel(PWC_PWCCKEN_ENGCKMAIN, priv_pwc->base +
> PWC_PWCCKEN);
> +	writel(PWC_PWCCTL_PWOFF, priv_pwc->base + PWC_PWCCTL);
> +
> +	mdelay(150);
> +
> +	dev_err(priv_pwc->dev, "Failed to power off the system"); }
> +
> +static int rzv2m_pwc_probe(struct platform_device *pdev) {
> +	struct rzv2m_pwc_priv *priv;
> +	char symname[KSYM_NAME_LEN];

It=1B$B!G=1B(Bs not a big, but we can declare symname in ' if (pm_power_off=
) {'.

> +	int ret;
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	/*
> +	 * The register used by this driver cannot be read, therefore set the
> +	 * outputs to their default values and initialize priv->ch_en_bits
> +	 * accordingly. BIT 16 enables write to BIT 0, BIT 17 enables write to
> +	 * BIT 1, and the default value of both BIT 0 and BIT 1 is 0.
> +	 */
> +	writel(BIT(17) | BIT(16), priv->base + PWC_GPIO);
> +	bitmap_zero(priv->ch_en_bits, 2);
> +
> +	priv->gp =3D rzv2m_pwc_gc;
> +	priv->gp.parent =3D pdev->dev.parent;
> +	priv->gp.of_node =3D pdev->dev.of_node;
> +
> +	ret =3D devm_gpiochip_add_data(&pdev->dev, &priv->gp, priv);
> +	if (ret)
> +		return ret;
> +
> +	if (device_property_read_bool(&pdev->dev,
> "renesas,rzv2m-pwc-power")) {
> +		if (pm_power_off) {
> +			lookup_symbol_name((ulong)pm_power_off,
> symname);
> +			dev_err(&pdev->dev, "pm_power_off already
> claimed %p %s",
> +				pm_power_off, symname);
> +			return -EBUSY;
> +
> +		}
> +		priv_pwc =3D priv;
> +		pm_power_off =3D rzv2m_pwc_poweroff;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id rzv2m_pwc_of_match[] =3D {
> +	{ .compatible =3D "renesas,rzv2m-pwc" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rzv2m_pwc_of_match);
> +
> +static struct platform_driver rzv2m_pwc_driver =3D {
> +	.probe =3D rzv2m_pwc_probe,
> +	.driver =3D {
> +		.name =3D "rzv2m_pwc",
> +		.of_match_table =3D of_match_ptr(rzv2m_pwc_of_match),
> +	},
> +};
> +module_platform_driver(rzv2m_pwc_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Fabrizio Castro <castro.fabrizio.jz@renesas.com>");
> +MODULE_DESCRIPTION("Renesas RZ/V2M PWC driver");
> --
> 2.25.1

Best regards,
  Nobuhiro


