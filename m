Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8864DEB64D9
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 04:34:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.51717.1688445287911078657
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jul 2023 21:34:48 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 3644YeuM3337232; Tue, 4 Jul 2023 13:34:40 +0900
X-Iguazu-Qid: 2yAbqIXzGGL5pSHaSU
X-Iguazu-QSIG: v=2; s=0; t=1688445280; q=2yAbqIXzGGL5pSHaSU; m=qniFNOupnnGnCpAmbrb09p9jmctyfVnoBL+IJaR5D5o=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 3644Yd9g3052468
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 4 Jul 2023 13:34:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOJxnXAr0hxz1fq0vkZDZI86x6nhgomJYko9y4nb34RrQufxraRA9ZTjWcRJlgErEXV32eddQIEhE+2HSwckNd8rFwHWgPSSbCxu0gFrho2P99FZ/AaURoyqf9pSgKcYkJlvw1yePX8Dzkcq25xVFO13aKwrHnVnzRQ4w+1KE7CJ78H9W+wuiXgz8MyYqSG3/OXzh/rzCGqwNgKH9hdgYrmF3WGD9IOMoAJ95bRU5JQ1TBg6aDawg/+IsbQQ7VUdhSIIY4cdQZDDSkzu2VkijcDBCH1p8TchXepfHYRQhxyi6flkH2V8lmBzusOXpb3k/a7Qd2/cDMSy2ZpL5OvwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZd5FZausq1Kk4yqgNyzjxwP87zsGMG7pXU0GuKM9Po=;
 b=mVyS0ZoLk1iW6H/klEBxgcdLRPrN4Z+XbeV/HI+H0c5er6U8JWdqtIOTUwENv994eLa4L4Kx0nNRYNqBOLDA87v5tvzUcCr5FbwlPHalVrBWNQq5RSxRUnPgljPqsZ0OZOrXkMnR4SCxsODhL8buladPrGyhLvzzRdkwtI6NLELBMxRwhvhpsqV1c5MjmkKqhHUXKdqXV/+ZwQA+aN0N1ITX6d/3BIj21t6j9n+G2L0aHcaa1NV9fW9ALnwctCEa9FY5BAwTOvaZFCD5YkJ98GESoqmxnDLydtRyCgFZ0IsUQfUSSfYE48KkSYjQu78HrqHKNH62Q3D0jKx2I4oqOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 5.10.y-cip] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
Thread-Topic: [PATCH 5.10.y-cip] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
Thread-Index: AQHZrbFF+m2QbdxmAkWLIT306ZCjZK+pBfdQ
Date: Tue, 4 Jul 2023 04:34:37 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942045A67F1CF79293A5396E922EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230703132113.353419-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230703132113.353419-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TY3PR01MB9980:EE_
x-ms-office365-filtering-correlation-id: 06c36efb-0f9e-4e3e-212b-08db7c47f96a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OjAdPvrXJ/nLrZ/JLVJIsrXdCD15ZTbHM2gP0PVUSIge3rZ0yaayErUfuRz27kw/cGf1byM5wyUKmjIss9R075aHojOyTh96AyPUg5pOmE/nSap/JX0r9TqwshQrv3Dh4uTT28bT28baNJUNFtHeQdu98+hVpgiJdbZOlRmtOARrE0IdwGZRgY8dlwx3WSpuRH+L9n61ioaVJBe054FLsX4z4LrkDC8eDWwYloiZIJ1hbnm8n8Uihpo0pxtxje8LNl7yNYxCsNwEG+uFjm6v4dBg/5DJ73OUFkNG2Vba4gbTqHTgW2Ff6clD3O5gmGnM7it0EYFJWoBI4TWQwl2wkzXlzm72vyhnwNL5PrNIoz6N4vOsntzjYR7vFVxdaa7IFJND/f/JUqis2xC0ZTDrhhsxQkrWF02oA4xoq4l3Heh9RQz8lyKVdbjWAt1n3xlM/szDD4VZ/p6Kng2JTiY4ugiEw9sVC1i8JfRThotxDt1jchfh1FfKwmSttw2m0tpKkGHPPIbZvHz2vtTp0xCZnf/8oXPTqBJXWVI0S2nCbAcXMfI81cUrdigoM99UbSu4kTQhLfbBMttZinq0qhBW+AFHScDdDfwC+rIz3t7mzo5+ju/7+JfULVaGhfE3FPcvocTMLAkvDB2YXM17K3HCrA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199021)(6506007)(53546011)(76116006)(66476007)(64756008)(316002)(38070700005)(66446008)(38100700002)(122000001)(55016003)(4326008)(66556008)(66946007)(83380400001)(186003)(26005)(9686003)(478600001)(110136005)(2906002)(8936002)(8676002)(52536014)(5660300002)(71200400001)(86362001)(7696005)(966005)(33656002)(41300700001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RkJQbGdRdHE4V3FEeDBOTUlud0NSYUwyRDBGNHJ2K3pDYSt5YkJYYUNG?=
 =?iso-2022-jp?B?ZUQ3S1FZS0xjYmNjalI0TVZPYVljeVdzczQwVzFvWCtRVEMydDFhSERY?=
 =?iso-2022-jp?B?QU1nQ1A4UEFIMDdQL1g1QjNJWFRKUE0vbkF2dGF5RThYVTQycjU3RmxN?=
 =?iso-2022-jp?B?RTdXaDEyMzBNSER6MmoxR2ZxRHZGcitTbmN2TnFxYWpOR08yUHVLclRN?=
 =?iso-2022-jp?B?QW84UUx5aThIRmlZTFBNR0thWW1Bc3NuN2hzQWNyTnNqYXJMaTVQWGhC?=
 =?iso-2022-jp?B?NmJMeHNXdDJvcGF2LzNCYkk1czNIL2tadHQyMW9TNnRYK1l0VW8vcnBk?=
 =?iso-2022-jp?B?WSt1QVJ1SmJRREVXaDU2NS9ZbFFRNEhmNTMzQ3R6bFQvSXczU3F4eUM1?=
 =?iso-2022-jp?B?SzFFa3AzaVZORDcvU1EwRGdXU0VSdHR5OVlreVZYSXU0SUE1ZWI5YmxY?=
 =?iso-2022-jp?B?S0NQMGs5WTVLOXhrVG5FcTYzZzNXRzlIRFQrc08rY0hPM0NGdHA0MjAw?=
 =?iso-2022-jp?B?eU1LeUlUV1dUdFA0a1lOTWN4RU9TS3VRclcwd3VEbE45UXdHeDZINVNH?=
 =?iso-2022-jp?B?ZVpaN1RGVW9sS1JxQ0krVFplOWFzZVVnYjBnS01xMkduRko2T0JOSVp1?=
 =?iso-2022-jp?B?K2M1aU9YaWRldnNJZzQwWDZlYktsTlNNYlFvS3QyYVYrR3g4NEJ3NjJ0?=
 =?iso-2022-jp?B?b3YwSGo0NUp1TTRBUENsaGxBSUNiMThnZ1U1bTl2eVk4ekt0QUIza2xC?=
 =?iso-2022-jp?B?SHB1aGNGdEdJeHFCSlV3R0h3UzM5bko5aDZoQnVDdE9kOHFPVUt3enU1?=
 =?iso-2022-jp?B?Z0VTeUg5Y25wSXJ6MEcvN1JaYkgvdmRKZEFIVFExQW53UXViSU54aDQ0?=
 =?iso-2022-jp?B?TXM1ejVhOGRESS85bGF3TjBFczA2QVBjSk1sZGc3TjhwdTUyUkltRkVO?=
 =?iso-2022-jp?B?MWwxeHYyckgwVksrbUJiVkJ2bXlZSDYrSWwvNVhDOEFjNlRES1JyT3ov?=
 =?iso-2022-jp?B?a1pFOEtFd1FQRlJBOC94UlRmTWtsZnFqUmI1dkllTTBzR2hQTXRxNzd2?=
 =?iso-2022-jp?B?WG1MZjZpc3NkYy9ycllNMlZYNitMRHplSTBVYjBPdjBNWitvWFpzSzRl?=
 =?iso-2022-jp?B?bnZFVlVaeVBQdmh4aFVQZUFOS21CREtqMENrRkw1NjZ3Mi82Zi9tZWZG?=
 =?iso-2022-jp?B?ZWg2OE9DMy8rYkc4VUtMVnlyazd6TzJKZk9sZkM0WmQ3Mzh4YXFEbm5k?=
 =?iso-2022-jp?B?dUwwUlEwdXNodnovYnF6MUNhQzVtUTBaSHc1SXhzd05JQlUrYTVZZjI3?=
 =?iso-2022-jp?B?WXNUcVJQOUlORDlXNWE2OGJMM2dhOVM4TDJ1ZzBpSXlBUDF5T3JoeXR1?=
 =?iso-2022-jp?B?T3Z2aUgwekJTcXQ3TFpFNVVqakltNVNqR0pYSHNZNjlHZHloNVlzck9j?=
 =?iso-2022-jp?B?Q2NZL3orcUxDSU8rMmZ6SEJtejJXNzVvZVhDM3FTMGFwTHFzVUgxbmhv?=
 =?iso-2022-jp?B?aDl3M21jNkFLL2RpOVNKY2lzbTJ3L2hlNEo0dmNpVVBPdzhxbW9GdFJ4?=
 =?iso-2022-jp?B?SmE3LytMaUlsWHJRanBudC80am15cUhodG9lMVg3VGdNM0g3OUVWMXNx?=
 =?iso-2022-jp?B?bWNhdHZZckk0Q3luU0JPNlhWY1U4dGtpTGk5TjBBUGptOUl3bGxlMndV?=
 =?iso-2022-jp?B?Ymg5dVgxZ2EwUmd2Y2JKMXdhNUpUbnVKN0xyUnJwYlRqeGltaXFvZXFT?=
 =?iso-2022-jp?B?bTRKak0vcnAxTnlVRlY2M05wL045RXhIcHIxZHJTZEs1S3RiZkhMbVgr?=
 =?iso-2022-jp?B?L0I4R3ZZZ2hRc1ZnQldNSjh0cE1nRjhBUzQyeVhTalRESzk3SEJnd05u?=
 =?iso-2022-jp?B?T2VUalpNY1psYURTTFZ5eDArNUxoN3FObFNxdXpVcTh3SE4rYTZWNmR0?=
 =?iso-2022-jp?B?MG9STSt1RWsrYzd5c3UxcktzUWkvTXRBc3d3NDV2Zkg2TTAvbTErUXd6?=
 =?iso-2022-jp?B?UHFxaTFLbTRWcExyN2JmSHRWUlJ2U2VFNTdEUWtrNDN1ZnZVYTlGVXNq?=
 =?iso-2022-jp?B?aHN4VC9qaGZCWVdIQnJWRXN1L2xOVUNlRTcveFNxTmoxeDc3UldnVTB6?=
 =?iso-2022-jp?B?NlVmUWVuNVNlaHN1RWRDVTlLQlZ0bUcrVGFiVU1ZcnlreTdiMzhweThN?=
 =?iso-2022-jp?B?R2wxamI4K29TejJSZ1ZLQlRKS2tKRXBSZ2I3NnlHMmlVRWFVbGJtbnp0?=
 =?iso-2022-jp?B?ampIaHk3WCs3dDhmaHJHT01aZnJFSDJCVUNMOE9ybm8za2xLUXlCRFVi?=
 =?iso-2022-jp?B?NEJXSG1HU0hOQWtOM1k5Qy9NR0NaMldBdGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	p9bke0ccGSPpxVtifU3JN34e5KXNouD/xLOtFP29HBPfWY+ZvfEaz+FE7VHnLJkn/fYnSgxaSQrZHQDHVUvqJRGkBeE/d9ZwqA/l77KwXbwDBxurD1S6aFxmsOOTWlPXdo+DXMQbvbtQ9lj2ZEsTWJmtsodzwK2HB0SllU++oY4G3fo+nqwRFZHAVrjrMOgZgUsqGfp0ahtGNvpT//9ZEBg9g0+SBmVBOc7XLBB2mrmZ+bJBmFllSaWTq/Fv7Qy/v9BWVefCnYNxtonzUFWGx2jM9xk0BAnNgrzOl39GpcxvSTbB7ksJgW35etaigrSHNGw/gvRf7+Kg5fzU2UzP7LmMnJzfX1uU4KFpJ9P84fH62jyiaYx2btCF5RNKRXCJm5oQJ4jpeim2EOXErYiMdLIVzTd2jDoT5ANAuMd/qE6T0UeMtErp3actsAtet/o0GJdyf26aeF0/At9nNkV00jzqFLX53v82GWjparXoGMS9AfJkqCRpH6PFgzgKUMxDji5cCHls9pcK9GqrrnfQV/x0turBhBXytM8l9Vn0RqeqnDVPj+6GVDJYAiHbHkQuPT7JfAYVDgBi2ne7aIjJqSVFCOQRdgA2PmlX8x3ed+j0ofE8UMBxhRVc1k73KSZpYU2yl/b1ZCV9M7E/fC4Bpt95V6nKSw91HnTxASoba3G5BGZSbvv1v41HhNtXa69v0JOG0xYN+b6wm5P3OR6seHCDrzbRYt+7gAwYshQJdNXed8jICVgprT/nq2LPoLbAskeNyvwFwFhbyl4zPrgm7ckx/EW63Jv7jnHFtJs3rAYSYRMjI71WFzZ1RYvca0NSAvCq+4QWkw14uvxPiQk1m+FPs6+mRSQS8q9F++8b+NQFkfyAlBHzriGsDo9IigcgE+CE5Q+jHMt/dePl3J3ktQ==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c36efb-0f9e-4e3e-212b-08db7c47f96a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 04:34:37.1815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKdJGLjQWOx46ssOuVa7h73YU8YZ1QezoREd4fJEWSrQ104TSHYP2gzY30Zu/3Tf2n1PeME0EmezxUNbC2pGGXNIHE4rvFXIMHPCcGm9sHvt6sqnSGoD+iR93sbgMoN0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9980
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 04:34:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12198

Hi Biju,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Monday, July 3, 2023 10:21 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>
> Subject: [PATCH 5.10.y-cip] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
> {modprobe,bind} error
>=20
> commit 3e6ac852fbc71a234de24b5455086f6b98d3d958 upstream.
>=20
> Currently {modprobe, bind} after {rmmod, unbind} results in probe failure=
.
>=20
> genirq: Flags mismatch irq 22. 00000004 (85070400.usb3drd) vs. 00000004
> (85070400.usb3drd)
> renesas_usb3: probe of 85070000.usb3peri failed with error -16
>=20
> The reason is, it is trying to register an interrupt handler for the same=
 IRQ twice.
> The devm_request_irq() was called with the parent device.
> So the interrupt handler won't be unregistered when the usb3-peri device =
is
> unbound.
>=20
> Fix this issue by replacing "parent dev"->"dev" as the irq resource is ma=
naged
> by this driver.
>=20
> Fixes: 9cad72dfc556 ("usb: gadget: Add support for RZ/V2M USB3DRD driver"=
)
> Cc: stable <stable@kernel.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Message-ID: <20230530161720.179927-1-biju.das.jz@bp.renesas.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/usb/gadget/udc/renesas_usb3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/udc/renesas_usb3.c
> b/drivers/usb/gadget/udc/renesas_usb3.c
> index a1e8669536d8..bcbdb6b2a8d4 100644
> --- a/drivers/usb/gadget/udc/renesas_usb3.c
> +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> @@ -2898,9 +2898,9 @@ static int renesas_usb3_probe(struct
> platform_device *pdev)
>  		struct rzv2m_usb3drd *ddata =3D
> dev_get_drvdata(pdev->dev.parent);
>=20
>  		usb3->drd_reg =3D ddata->reg;
> -		ret =3D devm_request_irq(ddata->dev, ddata->drd_irq,
> +		ret =3D devm_request_irq(&pdev->dev, ddata->drd_irq,
>  				       renesas_usb3_otg_irq, 0,
> -				       dev_name(ddata->dev), usb3);
> +				       dev_name(&pdev->dev), usb3);
>  		if (ret < 0)
>  			return ret;
>  	}
> --
> 2.25.1

I reviewed this series. Looks fine to me.
I can apply, if there are no comments and issues.

Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/91994=
6031
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


