Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F63C433F5
	for <webhook@archiver.kernel.org>; Tue,  1 Feb 2022 03:08:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.43834.1643684924536371492
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Jan 2022 19:08:46 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 21138WRd015170;
 Tue, 1 Feb 2022 12:08:33 +0900
X-Iguazu-Qid: 2wGrVsu7KnKyC42cRn
X-Iguazu-QSIG: v=2; s=0; t=1643684912; q=2wGrVsu7KnKyC42cRn;
 m=3gWU6MWXH88/+N4HyIeOjlge4HgiBeXDAMHa7zuYZGo=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1110) id 21138VSd015343
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 1 Feb 2022 12:08:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bc736Ydtwdfi18R2YCv98UBryW/S/69dCATyNd/g+s+tF+jWBEUOaY9bzjq9B8I6re9afuwkmv1z1GGm6aCGVPoRO2wMsL+FSI98XLf0swrroM8cUddwcsmszp0w4BwpzxMyc7VYt71WXcTockM4Dzrx3EESIvqOqZ4cdJhq/EO0baa1owCATeBhJ9ae99cp3rpuFEDicLUpDfvZtkRmGZYXIHTom3EOE+npiD/yd8I3mbtwaaT41w8pAGkLm7ZoPk9hZ8ZkcYPpX3gopBkbX1drE4xDBFjyXLBx/GZ9UdulapZEN+gAOEOj3adeg+fhYB8nEbOIf64KDnsFs0gAPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1jBd62Pxe084yC9SIUbNw7utTItC1ItRsvDyPbbm80=;
 b=oXqOBjEFgqY5R9AiRY/SgH6t+YHSzMH/5UO+eULSZn8wNV8T3pSiG/K6NFklbChloRExNOUqFRvXMolASTCQ3hLvjYBfbpBoWbr0H3ULxNK7bBhaSWDCT3wFx7UJdxb8HHAGqAGgq9TMwoWznWwFFVKwnduP6p/xTDNceS1hYD6e1InnQceIS8FkUXL70Dv/Crl62m9K4of7GZqafv7sjw+GOl7WLfBtOWAgA67VjWYJz67rsMASsTfDWK4+74Mmzu/U/skfGO3+UTwgvZG26E6hMBEY+gI+M5PW5RVHXiskxMw2urEYDiAlgy+lWOqneUkJW7YnYfgqrpaIavlKyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 12/27] mtd: hyperbus: rpc-if: Check return
 value of rpcif_sw_init()
Thread-Topic: [PATCH 5.10.y-cip 12/27] mtd: hyperbus: rpc-if: Check return
 value of rpcif_sw_init()
Thread-Index: AQHYFpzNSBUpNjrOs0+rKvxfCkdA36x+A/7A
Date: Tue, 1 Feb 2022 03:08:23 +0000
X-TSB-HOP: ON
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB62522A67FF931B1C52E1836392269@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220131121903.8620-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220131121903.8620-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b263803f-a642-41e0-791e-08d9e5301baa
x-ms-traffictypediagnostic: OSAPR01MB1714:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB17142AD5DA64E9C31C4FF68F92269@OSAPR01MB1714.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:227;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 SozvZPv7X2xLJeF6nfqT3wwwj38txp5uc2k8eaH9n66O+A7X9V4n94pY0eW5/eDWQE537/TioxlOrxNsc5m5+zu+h7bTerRztIXNX8PKSSxOppX0X5XesH1yKvXXP0UdpWHmGwbILNuWQYJy5w1qhuJkCioIN2SU1mBc4bzqByHCslA+DxaReX7V+e1VV7zfwU4NY22+qOCydqr78KmLK9RpLzATpsiWITsHgN0/B2Bxuetn/yLerWYF9HDgwc7N9aLnzIWM6GBIIDbAtP6mvv7j21YakQZEJfC0s9OB9f7bpdjVGqCpUsXX83WymZ5DRoroWMRuMQsYS0ydnEF8Sr5ptqUub6JTUf19YBBgPMX6rTsj7/E451HRmN1C0i+iKe/xn+EzzzxkZEtbR8HpoaH1RjhcQs7DGZMPiIpDyFFkt5hfZscqhGEibD5FGztynr2mVF5evIknlXnv2XbxQqSvX4EyjWF2TmykST4WLarXPFkzE3T3iH4bUxSAtXUdCCYTLFmJ/ghTp8G+qiQaeTiLeGfKwWy2dz/MyKIVga9xoqWYhpGxrg9gEeBSYDGckpgLiikuRyVA+wYf0nkD5WHx/zisRtsNV9yIouhQIqOCyyToMaU9q+9ON1Zr8TTJPbcipoER98VvIPWket7pw1FrctoR2PeqqGCg/bDQahxQqJHh4kAftQqi4F2TFX14sqsCElHH77C/xiwC0/182vmjJY9R4ZUsUxukQ6O1Md86x43KRUlGyHWhH9d4IJh62Czo/ZwYm+sRE+Rh7WBzNNV4qMzLazDMSV/bqpWqRgE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(38100700002)(186003)(26005)(66446008)(66476007)(64756008)(66556008)(110136005)(76116006)(83380400001)(66946007)(71200400001)(6506007)(9686003)(8936002)(508600001)(86362001)(2906002)(4326008)(53546011)(33656002)(38070700005)(8676002)(122000001)(966005)(52536014)(5660300002)(55016003)(7696005)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bkw0Vkl6RlFNV1hhbCtzL3VHczI2cFM0TjRpdnNTTEN3VWVQMEhaM0JD?=
 =?iso-2022-jp?B?Smg0SEZKanByWHl0UWkyMDFSOE9uYTIvdXZabkpQV0tQa2RXbVB0L0tr?=
 =?iso-2022-jp?B?RERjT201UWh6NVM4YUVLTGx4akJiUXpOTWpOSnZjM0RQNVk1N0UxNmRx?=
 =?iso-2022-jp?B?MnFzWTVRcldjcXp6cWUxeFZObVB0TTN4VXFFdFk1QkZJNFlVVzhqNVRL?=
 =?iso-2022-jp?B?djh5bmhwNUdSWG9oL2VON2RFRFlGVy9Sd0pvUFhjQ0ZycnN3K1F5Y2lX?=
 =?iso-2022-jp?B?VWE5VEV5N1ExR1lGRWMvQ3E1cmNkRWd1YkdzMzZOYWVVOEp4dVJPSi9K?=
 =?iso-2022-jp?B?Y3pYbG5OTGpsTVZkUDI0KzJtZ2doeW1HdXhrSnBaQ0NsVEZvOHRvWmRu?=
 =?iso-2022-jp?B?dkRwWlZENkliN2ZjKy9RcXp5Z3ZjWEQrNnJZMjVUU2ZZeEdHZ3hiektV?=
 =?iso-2022-jp?B?Z3dabm00aUh5Y3BCN0k4Zm54cURmSmJPTUpjNEhIUENpR1BGZHJ6S3hV?=
 =?iso-2022-jp?B?RXpWVTFITDhMK0k3SWUrY3Q3elFDZlJFTlFIN3paeGxSVTRMUnZVUEk5?=
 =?iso-2022-jp?B?Y01wY29EdGlNajBsUEtFeCsrN2NoRVRSWWtsdWV2KzYzbk91QUdPRGN2?=
 =?iso-2022-jp?B?UDFSdk4zdE5UbVJkUlRaaG40SitieVFDOGxlTUlwRk1qWGJISUNZU2w5?=
 =?iso-2022-jp?B?ZDZwdW9rT0ZkUlkzaHcyeXU1THdwUUNQUTlXNHhGOEdPa215REhFZjd3?=
 =?iso-2022-jp?B?TkgzdE50RjF5Q2o0OWlxRDZ4ek5GWCtLaUtMYzNWRXZoWW1VOFFIWjRy?=
 =?iso-2022-jp?B?TUR1VzY0ZWpYeEc2a1ZmRkJiQk0wMFpIcVZUNU80L2oyVXZ6VnYzSnVC?=
 =?iso-2022-jp?B?RHpxM3A4V05OVWR4ZTdwVHR3a25rZUFuQmswRVM0djBSMkY4UUtyaHJI?=
 =?iso-2022-jp?B?clVFdXQzOWEzWTlqUkwxdGR1ZmJ5NmNTalB5bm9TUmM2RldoRWZ2OG5n?=
 =?iso-2022-jp?B?a0xIQm8zeitQck45QXl5ZmY0ZFVNU2dpSi9EVWx1RER0RzlVanBnaytG?=
 =?iso-2022-jp?B?R2NQaDZBWVNFbDVtamhjOE56dm1sTGx0NWRYN1h4WldnZno0V3NOMGJz?=
 =?iso-2022-jp?B?bVBTVTR2dDZZcEk0WkVONFgycS9XcHlGRGlhaUJEQTA1Z1UwaXcyNGZz?=
 =?iso-2022-jp?B?RzJBWEtDNVJUTlRSNktBSmh2ZmNlejVER0lHVjlBWDVjd0lnYUpKenBJ?=
 =?iso-2022-jp?B?Y1d1MForMnZPcVZ5L1JGN1JySnlEVWFLSEpSNzlVQ1Rxbk4yUHBKRld2?=
 =?iso-2022-jp?B?U21pd2wwVWpsZGtON0UrTnhyUmhTR2dMMm1YbjdUQ29MQ0N6K1A2NFZD?=
 =?iso-2022-jp?B?V2hXM3N3UXdjQnlQQmRuMWJuMXUrMHRTSy9Ocy80ZXR2bkR2d2M2TEJo?=
 =?iso-2022-jp?B?Q3FNU0pqNVV1d25IdFd0N2ZTaTMzNmlsWUxDOU9YUFNZZGUxWjEvREgw?=
 =?iso-2022-jp?B?UnB4YUdmait1c1pSbENaWEFTblA5a3ZEMVRSdDVXbTAra1pDeStUeldu?=
 =?iso-2022-jp?B?ZzNIMDVUNWtmZlB3MWRjU2YvMVVhQm0vaEtuZXcxWFUyMkN6dldBcExu?=
 =?iso-2022-jp?B?R3prR2xNckFFb1hNazc3NTFDVVc2ZXgzKzQ2K0YzaE42VS9IMjRabEpn?=
 =?iso-2022-jp?B?clRuY09lY2Noa2N1NlhnZzJ3NXl5dFBvVUtxaGUyZ2xaY1VZUUUyWXVp?=
 =?iso-2022-jp?B?R3JCZnlsNVZIRjh0NHc0NHFYV0VOcklId3VXNFhhMmR2bWZJOGJld2l4?=
 =?iso-2022-jp?B?ZVQ1WjBia1dHYUVFcW56bnZiKzlLTjM2OENXWUZzV1pqU2xtTG1IVnpa?=
 =?iso-2022-jp?B?SDlxaEphY2o1ZGhDMFN3SlhRNGQySWE1eENGeWhicHNRSDNrSGFNTGNo?=
 =?iso-2022-jp?B?dVRJQUVqNmpJck5VRkNZZHlzZXJvM3pzSmd4OHROTjBjRUpZVDBERk8r?=
 =?iso-2022-jp?B?VnJlWWxkTTdlbUxzaHRjWXNvNm1NblkwUWJaL0RzSUJENkVqd2RUNmxk?=
 =?iso-2022-jp?B?Vkd3VzA3UTNqZ3pXWWRaWTdRVVMzL3BFOXluUXkyOVpYTk5hR2MxbzQr?=
 =?iso-2022-jp?B?dnA1VVJrd1h4SktubTVOZitmZVIrdGU1YVc0YkVXdTNNSnhvczBPUmJY?=
 =?iso-2022-jp?B?ajdMOTZVWWpBanJVWExZNkdLTXpMMTEyZG83UEF3NEFJMG1uSU02Y0gw?=
 =?iso-2022-jp?B?SU80dHhkbE9YQTlOdVFVekhUN3M4SW5tT0o2YXRLQ0Z5a21zcjBHcC9j?=
 =?iso-2022-jp?B?U1p6ODA4ZlJJN2NQVWtaaVlFTnJpU3VoTHR6L3dJMXRkQjVVVHdaVFJ4?=
 =?iso-2022-jp?B?MHBoMi9vSXpVMmpnaDBjL1IvRHJscUFncFJDZUYrcTNLUGFHU1dWejV4?=
 =?iso-2022-jp?B?RVJPbi9tam5ZQmcrN2xVemw3Yk1wVVhmcXlwQ2tRNVVjelVMSUk5aFQ2?=
 =?iso-2022-jp?B?ZHhWL0d3dGhjUUx0ZU5raW1aUnRiWGlHMmZsQT09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b263803f-a642-41e0-791e-08d9e5301baa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 03:08:23.4515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 qW8TIa3TM+GGESHK2vJoQtL8PTlteLNtc4RGK2cn05icFnhU/U30zgOaSplYZYnCsOqXvGRgPf44l23UW5yyRZyByDxzTnUg1INMck1HbkydpKn1fZKytb6C3FJPNyUw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1714
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Feb 2022 03:08:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7549

Hi,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Monday, January 31, 2022 9:19 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#S#W#C"~#A=1B(B
> =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 12/27] mtd: hyperbus: rpc-if: Check return val=
ue of
> rpcif_sw_init()
>=20
> commit 981387ed06b96908223a607f5fba6efa42728fc2 upstream.
>=20
> rpcif_sw_init() can fail so make sure we check the return value of it and=
 on error
> exit rpcif_hb_probe() callback with error code.
>=20
> Fixes: 5de15b610f78 ("mtd: hyperbus: add Renesas RPC-IF driver")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link:
> https://lore.kernel.org/r/20211025205631.21151-5-prabhakar.mahadev-lad.rj
> @bp.renesas.com
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/mtd/hyperbus/rpc-if.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)


>=20
> diff --git a/drivers/mtd/hyperbus/rpc-if.c b/drivers/mtd/hyperbus/rpc-if.=
c
> index ecb050ba95cd..367b0d72bf62 100644
> --- a/drivers/mtd/hyperbus/rpc-if.c
> +++ b/drivers/mtd/hyperbus/rpc-if.c
> @@ -124,7 +124,9 @@ static int rpcif_hb_probe(struct platform_device *pde=
v)
>  	if (!hyperbus)
>  		return -ENOMEM;
>=20
> -	rpcif_sw_init(&hyperbus->rpc, pdev->dev.parent);
> +	error =3D rpcif_sw_init(&hyperbus->rpc, pdev->dev.parent);
> +	if (error)
> +		return error;
>=20
>  	platform_set_drvdata(pdev, hyperbus);
>=20
> --
> 2.17.1

I think we can fix this with stable tree.

Best regards,
  Nobuhiro


