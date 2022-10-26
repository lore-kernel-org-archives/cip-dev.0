Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462C1C38A2D
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 08:55:12 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web09.5419.1666774509306837108
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Oct 2022 01:55:10 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 29Q8sx2c003579; Wed, 26 Oct 2022 17:54:59 +0900
X-Iguazu-Qid: 2wGrBkTN5gb4Tp2RRB
X-Iguazu-QSIG: v=2; s=0; t=1666774499; q=2wGrBkTN5gb4Tp2RRB; m=wPvrkVFnQmrYPVsBSVWkRbdvXrAU3cN752mLWw0xUbw=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1110) id 29Q8svDa030752
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 26 Oct 2022 17:54:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToxhQJRSwOPpPhNNIKOppuR2CCPYm5GPj4vzoEqB1ya4vav5Av8grwfEbJmCbSrMU41MxwQ86kDk63JEyXMRl8WIvtlgeX4BwOOHBG4Y+jJJVsF8RLhUl44udXFGtyJjwTZosiLZPVAK3F9jeKEjUvUWUG/mn5bCHnE+hDn5r+boNoDR2wyzKURPKgDbGpQl2voq5AIjHULLmMx2Zd2vTkZ227Umcs1MYcm8YklP6L2dAs4saQ2mz/3y1PljiHT1/GzvWWJ/aPhjMdTwADKeljvQy6dYW5GxUniIn1oLTAmOuibTjGiOoDEYaO5hde6dUuU8FGiaFJhErugL47jwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvVBvNhLuzs1p2x/v1b/rd7nYwf2hbnBsBGia7cv/hg=;
 b=fO2e8i+Y+j1ecuNo0IhtRQ9OO5yJSREHyCFTll67hz8fHZu9kJ3mv+OJ98xkIKnLJg+xIBti59T7A8du275zALS861b8QaNGDcXfQXuwAOjLpGU/Y9RVczuVgi7Zxqse5COQwfLG8/5jaecx2ucHVLI0n6oj75tLZPuNDqp0ZqOUp+e61FSczt83Dofch4vVPN15Pi9TU6IKyWZ9dT0pqKMe+1cnDiF1JCwBftNUTfXsq9b9mfOqfway0sZwUAqkyRvUT58RpLmhOzCArt7F4obAU2mG7G5CdOWCbodpWQXZ4BKoMPzH1Uq7FHS1yixBb4BbPKlmCk7CBN080N9+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <biju.das@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 12/12] ravb: Add RZ/G2L MII interface support
Thread-Topic: [PATCH 5.10.y-cip 12/12] ravb: Add RZ/G2L MII interface support
Thread-Index: AQHY6H/2vC16E8yKCU+FOCnGG15fqq4gX1hA
Date: Wed, 26 Oct 2022 08:54:55 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB94206965A39B29C0CA0F5DBA92309@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20221025144131.1309463-1-biju.das.jz@bp.renesas.com>
 <20221025144131.1309463-13-biju.das.jz@bp.renesas.com>
In-Reply-To: <20221025144131.1309463-13-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYBPR01MB5502:EE_
x-ms-office365-filtering-correlation-id: c0334cb7-89ee-4fa6-36b5-08dab72fc145
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CVPSHcs4fHFYBGuOASR2Z0LpoXthiLG3+TpjjGU4xSIPP2FOGnZGuB34Fm4QISv70xr4ECmNyGnY3/Bp9lVM3xqJXbH7aaGVkh3fs2Hw3WZjdrO230/YhnKGNOn9Za+4l5btiqaAUlFFi99OoDQUYSrz6H2ek2St7lWJIJq6odKMm9BqKgCIm0isPCHvyVvWfYDCHLWALyeMv8UuO+D0M0JntRXJOH6gFoNS9L3z+Zn8+3O7OaY3KGRWT3H7Cuk6FFWDNdow25+f34yPa8MBR2TSed5I9L6zawyXvc70gpPNcKX0oUR0xWXc/r/sR3mAhGRwCr29vnhgo09losIILY4iXRjCnO5GW9P5UEogKnMJ1Lu1ahG8SpUu+yqebpTMwXUuvr7b/GrOnHdUcVxj+luJ5ieH61djvPzEwVLDBKiysv4YuzC9eyZbbapTCcs2lIQZqOLQRYpp9BKM/ZCzVmd74qDTOdC37HkkNSDvNQYiq/AMI+3hGOkX4Nud81JG2y349RakApNbQAaFpSa2iON6y+7pXiqnUQPaY59PcmdoEToxKfczNXApyRaTrdO4ERLsh7v5x5CqNWDbHFaG9CTgOE6wzMSW6pUvtkxjzLl+YZ8j6DUhaP/BiySXCk+p0VYIPOxNNXmybG30pGkgb5wdGXJ+6owFJ5Yx7iEdFKd7wW2MsI8SZeI7yar+Uipmqm/CzizoQC56KSX2N6sAZBbH346TUAYduCcRl2dJoJ7/ZuZc6UAb2Zx9PV9F48KaHzUHMA3z5idILr2hriWYbnTifSlEF/YCqqRL/njqsG8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199015)(38100700002)(86362001)(316002)(83380400001)(54906003)(110136005)(66446008)(9686003)(41300700001)(55016003)(26005)(186003)(2906002)(52536014)(33656002)(5660300002)(8936002)(38070700005)(64756008)(8676002)(4326008)(66556008)(66946007)(122000001)(6506007)(53546011)(7696005)(76116006)(66476007)(55236004)(966005)(71200400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?aEl5UGJvSWc3REwybmp0emszc2xrR3BVS0FuQTRYdWppcWJlcXJUMGVV?=
 =?iso-2022-jp?B?dzk4MHFzQVNaYzFKYTBpbUVlYVZ6UmNXUGVrQWZqOFRONnFrdUpOWnZH?=
 =?iso-2022-jp?B?VzJvc2h2MXRzd1hHbnBsbGJQaFdkWjZHY25td0crVG9NZmhvUFVoNzJS?=
 =?iso-2022-jp?B?dHRKczA0NVpURHRSaFBsQ2d2MjQzMG5sRXhiZDhjN0VBQ0xjWi9hVS9v?=
 =?iso-2022-jp?B?c0dTelF6UXhiYU9UU2I2VEJ1MGdDdlpIVXRhamJPUlVQVXgybzFwWlN2?=
 =?iso-2022-jp?B?QVVRZU1ERTllMVYrUW0xVjdDSi9iZmNaSmdhY3ZCQThNODNKWUhKdkZY?=
 =?iso-2022-jp?B?RG1na0R2amt0dm8zOWwvV0xYZjFrMkRMeGRReUE0M1JPY3AwUEFrR1la?=
 =?iso-2022-jp?B?YzA0N3pmaks3ZktjRWo0WEpmV0VPWllpS3JodWRZcFQzTDR6OGZtVW43?=
 =?iso-2022-jp?B?dUF3eStBMFFmV3lMVnZuamF2bE5RNUs2cTVadm1VUVpUSS8rS1dGZHEw?=
 =?iso-2022-jp?B?U2dBVkRtdVpCTThaanVKRmgyL1pqUU4rLzZ1MllQeTAyMCtkR3NGbERC?=
 =?iso-2022-jp?B?QzZjV3RsWVlVZ0lwNXFoYzR2QWRWd1VFZXFmR1o5Ty9QYWpSMWpUcWFX?=
 =?iso-2022-jp?B?MTJsYVhobXVkMkpRdG1rQ1ZwL3RxUTVqM0w4TFIzSmNuR2lqK1d1bXJk?=
 =?iso-2022-jp?B?OG1HSDNvMi9lQXE1M0JkcmxDaTZCMmI4SVhpSlJna1QvMGdNRHZHV0NQ?=
 =?iso-2022-jp?B?M1VnbUhMYndrUTEzcE5yWVFPMWJyK0VyNDA3ai9rYms1eE9Sd09rckhl?=
 =?iso-2022-jp?B?OVVjRC9oRVI4Zk1nVHdDQTF6NExIY21SdE5xRXZqbVVraGw1WTYzK3k2?=
 =?iso-2022-jp?B?TzVCcUdqSHZodEszUjVWTEJtTC9UUkYzSlJVRit1UjArMGlZaUdWU3hG?=
 =?iso-2022-jp?B?a2Jrd3dteFl2cEh3Yk9vM1BnR080TG9WZUtJaTlZaFg3SWlqSjJZOEVj?=
 =?iso-2022-jp?B?VjA3L2h6MjNRSEVPcGdsbjRzUTBuUUwvYXgwZU9BS1FFbHBVa3hocTI1?=
 =?iso-2022-jp?B?Y1BUNVZuQ0RDNkUrYVNncklaQnBuQjk0ZXgrRmZHY0kzNFk0d05wR1JD?=
 =?iso-2022-jp?B?VmtsQUhEbTlVd0ttUkRKRTVHbXo5bXlzYlcrbEQ0em13MXVpcVlXYmhh?=
 =?iso-2022-jp?B?bUdPeW1rMmpCcWltNXd3SGRRL2lqZWh0V3ROa2hUUW9HRTcxSVFTUDZB?=
 =?iso-2022-jp?B?RlIwQzZlOFdTTW1CQWR1VmlFUXNKTGFkN0UzcytnS2FjeTkwbGpOTXhZ?=
 =?iso-2022-jp?B?S1BndHdkZi9HTWhJV29zcWIzanhHZWprYXVwZjA5WmZkYjJSZXpDaTdD?=
 =?iso-2022-jp?B?cEg5c2RWcFNWWTRZV1NQdG1OUWVaYktGeGFLRkJNV01sVE9FL0ltcXRr?=
 =?iso-2022-jp?B?bnBabCs0MFFjYTAzWlF5aldZdSs0T0c2WXhoc3VNUXpodjRReEZrdXF4?=
 =?iso-2022-jp?B?N3Zyem9vSkVTYlozQWJEclNMdDlaM1hjU0RBTVFGckNycGFhUzN6K3pm?=
 =?iso-2022-jp?B?cTArTTQreDhtM3J2VVUxMFRRenphUjFuUWt0ZU9ocjVCZEpUYld1aUZv?=
 =?iso-2022-jp?B?RXBudkZnNFF2WktZYS9uZ1N4QS84SEdtRnFVeTlvMTdkN0NqSHl3ajhX?=
 =?iso-2022-jp?B?anVGVGRENTlxNzJWd1crdE1iLzhkVmtWQTJqUllvNCtUNHhZYjN6WmhK?=
 =?iso-2022-jp?B?V2l2SFdZRm12SWFBL2ZmZGxFNHkrRzR2aDJUQnBBY2IwL3oySE1uYlBV?=
 =?iso-2022-jp?B?aXR3dnVKdlpNNCtIQjYvclVXSjZkb3pDUEFhVS9sMGtrNlk5ZlpoUDZ2?=
 =?iso-2022-jp?B?UWRMVXNDYzFrbVhXTVhNL05UQXoxcys4TkJpQlMrZFc3dFdBUXAxTlk1?=
 =?iso-2022-jp?B?YVdyLzYxbEZ1S1h0WC9vYTFCTEo4OHY2K2xNQVl4YThDQTR2U2J5MEdK?=
 =?iso-2022-jp?B?LzFPcTRWK3JXYU0wTDZkRHBpbHZhOXoxOTVvOTVCdG5Iek5iZVlDd25O?=
 =?iso-2022-jp?B?UzRTcDQrRGtPZThBdWxsaTV2ZHpPUmNidEFQc25KaTRYbXJOUHVjZlB2?=
 =?iso-2022-jp?B?N3R5UGtEMGFWNDNiRVY3d1dRMjdCZFlIZmtJQ2NQOWNXOGRKeFZReVVE?=
 =?iso-2022-jp?B?NzdxeThTSDNyRGozcStjUHNmbCtJdlFUQnp3dEdEMkNFa21FeGNuYzdL?=
 =?iso-2022-jp?B?dDZ6RW5tNlc0RVVxN0xXOEN2ckhGNWZwKzNiQUNPTlpoV0hmd3dQNHhx?=
 =?iso-2022-jp?B?MmJxVjB4YTJnVGEvdnNWcVJ2UDVoZkdxd0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0334cb7-89ee-4fa6-36b5-08dab72fc145
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 08:54:55.9762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jS+Hm+aeIKGW5Se6McOZO5j2t0FIpqVv7ldG5nVGFshBK5GTtidU3rtokgEB3Y3CfC5kEL9R6ohm5SWWUZ0OO9y7BH7Xcf2uzovZJW1GLqZLaRokATM6qAEdTZuxVdkS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5502
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 08:55:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9845

Hi Biju,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Tuesday, October 25, 2022 11:42 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#S#W#C"~#A=1B(B
> =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Chris Paterson <chris.paterson2@renesas.com>; Biju Das
> <biju.das@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 12/12] ravb: Add RZ/G2L MII interface support
>=20
> commit 1089877ada8d2da5f173922f1061ccfe721ebf56 upstream.
>=20
> EMAC IP found on RZ/G2L Gb ethernet supports MII interface.
> This patch adds support for selecting MII interface mode.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Link:
> https://lore.kernel.org/r/20220914192604.265859-1-biju.das.jz@bp.renesas.=
c
> om
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/net/ethernet/renesas/ravb.h      | 8 ++++++++
>  drivers/net/ethernet/renesas/ravb_main.c | 8 +++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/renesas/ravb.h
> b/drivers/net/ethernet/renesas/ravb.h
> index 0b5801f7e961..76ae3b5c568e 100644
> --- a/drivers/net/ethernet/renesas/ravb.h
> +++ b/drivers/net/ethernet/renesas/ravb.h
> @@ -189,6 +189,7 @@ enum ravb_reg {
>  	PSR	=3D 0x0528,
>  	PIPR	=3D 0x052c,
>  	CXR31	=3D 0x0530,	/* RZ/G2L only */
> +	CXR35	=3D 0x0540,	/* RZ/G2L only */
>  	MPR	=3D 0x0558,
>  	PFTCR	=3D 0x055c,
>  	PFRCR	=3D 0x0560,
> @@ -965,6 +966,13 @@ enum CXR31_BIT {
>  	CXR31_SEL_LINK1	=3D 0x00000008,
>  };
>=20
> +enum CXR35_BIT {
> +	CXR35_SEL_XMII		=3D 0x00000003,
> +	CXR35_SEL_XMII_RGMII	=3D 0x00000000,
> +	CXR35_SEL_XMII_MII	=3D 0x00000002,
> +	CXR35_HALFCYC_CLKSW	=3D 0xffff0000,
> +};
> +
>  enum CSR0_BIT {
>  	CSR0_TPE	=3D 0x00000010,
>  	CSR0_RPE	=3D 0x00000020,
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c
> b/drivers/net/ethernet/renesas/ravb_main.c
> index ea76fd98a767..bc259105a55b 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -537,7 +537,13 @@ static void ravb_emac_init_gbeth(struct net_device
> *ndev)
>  	/* E-MAC interrupt enable register */
>  	ravb_write(ndev, ECSIPR_ICDIP, ECSIPR);
>=20
> -	ravb_modify(ndev, CXR31, CXR31_SEL_LINK0 | CXR31_SEL_LINK1,
> CXR31_SEL_LINK0);
> +	if (priv->phy_interface =3D=3D PHY_INTERFACE_MODE_MII) {
> +		ravb_modify(ndev, CXR31, CXR31_SEL_LINK0 |
> CXR31_SEL_LINK1, 0);
> +		ravb_write(ndev, (1000 << 16) | CXR35_SEL_XMII_MII,
> CXR35);

"(1000 << 16)" is a magic number, so I suggest defining it or writing a com=
ment.

> +	} else {
> +		ravb_modify(ndev, CXR31, CXR31_SEL_LINK0 |
> CXR31_SEL_LINK1,
> +			    CXR31_SEL_LINK0);
> +	}
>  }
>=20
>  static void ravb_emac_init_rcar(struct net_device *ndev)
> --
> 2.25.1

Best regards,
  Nobuhiro


