Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EED8C433F5
	for <webhook@archiver.kernel.org>; Tue,  1 Feb 2022 03:10:37 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web12.43313.1643685034608679525
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Jan 2022 19:10:36 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 2113AQmM031343;
 Tue, 1 Feb 2022 12:10:26 +0900
X-Iguazu-Qid: 2wGrYolv9cvMn6mKva
X-Iguazu-QSIG: v=2; s=0; t=1643685025; q=2wGrYolv9cvMn6mKva;
 m=KP2CGSA3h8+1FDGzO6JmsrL9NM86gjafSRGFQDwNP78=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1110) id 2113AOwl019088
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 1 Feb 2022 12:10:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tci6DkY0V1vKOUZCsXLhCs6yi94aKavVoXqMA6o+ehcIWmQ9Lswcpm34aP1xX1+RDBiObyjna1GJS8ZwHud5tcOX3F0fiZ3yN99QCPdWk2ycnAJaQCqgCss0jzzqYKqmSuR2Y8oveB3YrsBG1sldTZveHKMIxgY8wOQN/ZT7wZHv1lEB1DZ2JThYAL8bChP3ZrO8bhu5N00hK4FjpFKVIBA/oMEOblf1cIQQf1E+lyniXaRbxtZVC5NGrQ8qZ2FawF8WiwjrrYLYSdDnLqS+3eUYzy9zaPe/fgPNw62GhsTl+HqIA4HFJsjEYFwEpyHihbpIfO/TNH6qRdJKtk1CVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKk/oWnFV2fpelQLKyU4rW40ApIHZHTesdNy5fHkyPI=;
 b=P27M/4wNNLUji14gXv3Pjtc/gc2JtKWiNriLqM7EW0kuQP84IeN/F0uPl00RK/Uv2zHftWV913xSBYhMW78p7MCGoM8/ORaiSEL+1Q51oUPlXDAS5CZSTkurG/WITej/+tCEMzyKwMX5qdPQD9JmbmyfLb23qGAEKuKrobF9Rc74Tn5TUu2+CNCGHEbEA1ir+/Zds385T7Nad7SCO83FOzJ0IGYITJd0F/hNFPBcLwalTc6/SmagYRQ84h0aOZw8YdMLTPivZ2leRtMJwZGp2rOjEh0WnDx5UpRnqxVvV0Pl1mU2UcuViT33AvvYHzgnfcbzrTktRoqh2Uz5rPlBbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 13/27] memory: renesas-rpc-if: Return error in
 case devm_ioremap_resource() fails
Thread-Topic: [PATCH 5.10.y-cip 13/27] memory: renesas-rpc-if: Return error in
 case devm_ioremap_resource() fails
Thread-Index: AQHYFpzPiitoTSpyTUmHfSN5++olVqx+BQXQ
Date: Tue, 1 Feb 2022 03:10:22 +0000
X-TSB-HOP: ON
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB6252A882B352A6ADED5B527A92269@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20220131121903.8620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220131121903.8620-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220131121903.8620-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed2843f3-4136-4938-7311-08d9e53062a9
x-ms-traffictypediagnostic: OSAPR01MB1714:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB171494E438BECDA662B8AC0292269@OSAPR01MB1714.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:121;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 1mXbkmC6AZox83zJLoY732UNH38gBYF0Ed9xVQJD6oqUk/+nH6CWvcR6YfAwUfebRGykkPj+YF2jz+Kioi+EUortM1igWKF2RwzDCmsAr/lfKHtgMjUUHf6y6WpN7czJNc7meUooW5LCocfTSYXERXPuGBh+5gGzcDwteCwfEderiK5ekANgSH8wo4RoSK+FmIbOzBfZMRKziYbQs0N8Lx7EMeRgYx2/Kg6jjw8Eppptohqrl+CxJ8sul5xkJMQtnG6e51GJOnMiaweK2qHIM24UtAgyHxSRfMCf29Np7/rfJ4jeYNjQxOSkjyqGuE9B4wde02aogtCu/DRNmsN30giff4trVHyFqK32EvwASVzG/HZcfsOkkBYCpSUHJh5M1jnv5TuRgpxYMeLsz0VujTGGj9d0n2vYjQ0thkJiduAYtzex9Ly/rhDgOc2ythu/GYnzqCo3vboL36FvPASxJbhDCCa/cbZwkxiYKL3RF10AVA686LEHcSjTzn1gGM4rz6vGNy5NQ0YjAqHoh777QMowAaP2+5kYjaPhvUaQYUfkgiA8T8jr6Y0xkiK/g2ehapNphLLQbCXPCEUEIK/QNy6GdceZtt8psJn1//nw/kiHFvtoESNRXJ1oRqVVrKav3vpuun/li6ma5ZeE/cjaNfDWCOOdaPYP2MPf4Ta2DRTpkrca/nrFtrNH6viWqJPGO1K++y1CyCXWTTOahFzIOXt3jxBPyS4k2ESVk2OaMsJg832g0HYeQa4R1UagAbzknf64PtGXqna9vgWI3bjpzFUvxzTzuAbk4qL9aaP6FJg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(38100700002)(186003)(26005)(66446008)(66476007)(64756008)(66556008)(110136005)(76116006)(83380400001)(66946007)(71200400001)(6506007)(9686003)(8936002)(508600001)(86362001)(2906002)(4326008)(53546011)(33656002)(38070700005)(8676002)(122000001)(966005)(52536014)(5660300002)(55016003)(7696005)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QnVqYTQ1dGtnc3FpNXg5eG43OXRPUFJ3WFp2blVXL2ZWd3Z0WGFlS3Vo?=
 =?iso-2022-jp?B?Vi9Sc1F0VmV0dklIYTJsVjQ5ZEJGZld4QVZGM2YwVVpNVUpjY1B6RXU4?=
 =?iso-2022-jp?B?Uk1DbEpQSURKMkJ0RzFyMWN6NnlwcTJLbzRxeEZxaHRoNC9YLzJ1QmRB?=
 =?iso-2022-jp?B?N09QMGpGU1lQZlQrTHJiVHFnbFFJYU4rZlpjdWVxWnVKb0cyWjhKVjRp?=
 =?iso-2022-jp?B?MFQ4ZzQxYnZhbzNBcy9qT05yZEVXMHY0cHR2S3BjRFJ0WDZkNW85YXpO?=
 =?iso-2022-jp?B?N01wRkhoZFRMZFI3WGFUUXdBTzQrWUY1eElFdGp3OVFaQWFDVU9rdzRC?=
 =?iso-2022-jp?B?bGJlS3lmL1JnR0IzaHBSR1liZXVsZHQ1ZFA4aWx1cmI1RXVhSDJwdEx6?=
 =?iso-2022-jp?B?UHZqWmhEekhKeWwyZXk0QkxsNU9UMlpVVmRvaldCK3c2WCtCckhFaTVP?=
 =?iso-2022-jp?B?UlVEd25zdHdoWHZkL3QyR3RraG5uY2ZaQzZaMnJkWnM5MEZpMVU3RzVN?=
 =?iso-2022-jp?B?MlRqcHhSd0lyRUVOaFNMYnRYcGJzb0hVTmRhUWphYXhRdW5CaWN2MHBo?=
 =?iso-2022-jp?B?ZnRqU3VCdVVvYVFhbE9tNmNGM3ZFeEk5a3I5Q2FZMGcwNVdoU3hYVHlT?=
 =?iso-2022-jp?B?ZFZNY3FKbUZ3OHpFcW5pM0FrbFV2ckJFSEptVVFnVENBeG9CUHhvTmRo?=
 =?iso-2022-jp?B?a3AvNzFFNm8wK0hGeVVabDMzQ2Vua3ZURThFQlU3bHFsQUlYQUFNTEh6?=
 =?iso-2022-jp?B?aHpuM2U5VWcya0dyVlBxQldacGZZRmtCYklWUzk3MHNxN2orN1JOS1lR?=
 =?iso-2022-jp?B?RTJ3QXVhNy8vMmdrWmdrdVZaU0dZVjBHQlFHY3JkTWFkOC9ZdFpFVjdT?=
 =?iso-2022-jp?B?M2JPeEx6VFNsL2xpalNOeUQvS0dUVnZ3cHQxT1psMURsU09KN2RTMXg5?=
 =?iso-2022-jp?B?ZTNFUDVLYlVleTl5VkxFKzJvU1NXd2s0SitHS2xBVDRJTlR0eDd2dnhu?=
 =?iso-2022-jp?B?aUtTZFRDMjFZME9IZkNUWTF3VEFsOUZyZVlsd21aNXJvRis4QUtBWFdm?=
 =?iso-2022-jp?B?cDNjWmdEajF4U1dCSkY1SzRHenhXTDU3Zmp4UDR3VEc1Mit0MXR6dDg5?=
 =?iso-2022-jp?B?YVl5V0Z3UWpBQkRjUVdDZDVrL1luKytQRTFUbDNIdHMwalJLNlZyNjMv?=
 =?iso-2022-jp?B?R0RweTNBVVVMSVZwdVVhdjJwdjNucXMxNTY0QzYySlUvM2VyZk5BNkhh?=
 =?iso-2022-jp?B?clFoMHFaU2Rob05PZHRELzNqcEFnREtheTF4NTRjb2lxQi9xQjZUdlJw?=
 =?iso-2022-jp?B?ZjBoRy84SzZxbmYyTWJZUWtXeVdYa0lUa2p2Y0IvNGpIN0c2cGNCYmNP?=
 =?iso-2022-jp?B?R0tDcDRMNWRvQVpKajdYTmRRRVJXVnVpZWVydTZ0UklweTU1Mlp6dU9v?=
 =?iso-2022-jp?B?aGdQN3JFZUdmeFAyUGxLQjBSUTlLOWlaVW5rK1g1MlYzYzNUM2xpcU14?=
 =?iso-2022-jp?B?RUxkMlZ0YUtrMGhtNzVyMnBjdHI4Q3NwUk1ZME9oSHFtelVqa0Fad3RE?=
 =?iso-2022-jp?B?c2RFQ09jMmxudG8xdHp3a1RkaG9oVTdhSVpNRE42SGxYdHl5RHR5ZHI1?=
 =?iso-2022-jp?B?RlFHcTVLQndtNFpKcjdzZ2FDRUs2NlJiMDJjdjdPVXJqL2crQXJjSmJ2?=
 =?iso-2022-jp?B?eDZXclVBdkRraGV3Uk5xUUFWbGdramFFeXNqTlQzNGtqb1VVaUVNbytG?=
 =?iso-2022-jp?B?WmpjaEU3bXBYYWEvYStzd2pUL01aRnZwY0RESWU5eTlkRTAzeFBNRG9n?=
 =?iso-2022-jp?B?cllpVXc3WTNrbVZNOVQ2VUJDcFpGdmUxeXFreXpNR0lDRlQvdG5uWFNp?=
 =?iso-2022-jp?B?SkxWOVFyV3dad2h3bWplS3dqeU5tTmJlVDgvUmlpZ2U2OUthZUN1RmJP?=
 =?iso-2022-jp?B?L3FzdlprenlZb2hlU2JzdGh3ZUY0V0ZwVkdYTDJReVIxdjdrTlVhdnF2?=
 =?iso-2022-jp?B?NG9wa2ZiZi83WFVpUHVTY2FXL3E3MzdLY3dDVmhlMm9qQm4rWE1rY3M4?=
 =?iso-2022-jp?B?aTNUV2l1UzluTlhzTndMd1pSVFJ1dGRtMW9SdVVXKzluM0JBWFZGR0Nq?=
 =?iso-2022-jp?B?dTJQQk1pOVphaE43cnhYVXovKzlYY01sZmk3Q3FvSnNTVTc1bGdmV2Rh?=
 =?iso-2022-jp?B?ajRQQXNXTzRPS0VUVU9XcGFPMXhwTGJzaEF1aUVwWUFSSmV4c2JtVHN6?=
 =?iso-2022-jp?B?UmlLRjlFOGVTUVpJckI3MXQ2S0xjaDBxZm1IUGNMZDFMQ0RKeklMMXh1?=
 =?iso-2022-jp?B?KzhadzQ0d0tPbUhIcTJJMWoxWWdKWUFhMncvaXZSLythdFdXaDlZTmY3?=
 =?iso-2022-jp?B?RTNyQmRscDdlNHF1Um5oYUV1VEEwWGZLVXo0WGRKNWVXOXpUWm05ODJm?=
 =?iso-2022-jp?B?c1lDS2FYVVplMTZ5RGxtZE5OQ3A5WjhWcURYeHEyNG1OMnRQcWlJUDBW?=
 =?iso-2022-jp?B?SEsxNXk5WXpHc0k1WkhMRkdnajdxRVFzdVI2UT09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ed2843f3-4136-4938-7311-08d9e53062a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 03:10:22.5630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 41fO68DvdhCIKq1d5RAn3QMPUHqunB75R1GwwPcTSLgM4COE6U9ofhq7hDxITwHC1FNx1r8VHHCcu0a6HHcFxM409G5KyLp/Sd08L9JtMh0qMPw3Z7NpryOOK4Pq3v+N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1714
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Feb 2022 03:10:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7550

Hi,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Monday, January 31, 2022 9:19 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#S#W#C"~#A=1B(B
> =1B$B#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 13/27] memory: renesas-rpc-if: Return error in
> case devm_ioremap_resource() fails
>=20
> commit 818fdfa89baac77a8df5a2c30f4fb798cc937aa0 upstream.
>=20
> Make sure we return error in case devm_ioremap_resource() fails for dirma=
p
> resource.
>=20
> Fixes: ca7d8b980b67 ("memory: add Renesas RPC-IF driver")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link:
> https://lore.kernel.org/r/20211025205631.21151-6-prabhakar.mahadev-lad.rj
> @bp.renesas.com
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/memory/renesas-rpc-if.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/memory/renesas-rpc-if.c
> b/drivers/memory/renesas-rpc-if.c index 77a011d5ff8c..861870223300 100644
> --- a/drivers/memory/renesas-rpc-if.c
> +++ b/drivers/memory/renesas-rpc-if.c
> @@ -244,7 +244,7 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *d=
ev)
>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "dirmap");
>  	rpc->dirmap =3D devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(rpc->dirmap))
> -		rpc->dirmap =3D NULL;
> +		return PTR_ERR(rpc->dirmap);
>  	rpc->size =3D resource_size(res);
>=20
>  	rpc->rstc =3D devm_reset_control_get_exclusive(&pdev->dev, NULL);
> --
> 2.17.1

I think we can fix this with stable tree.

Best regards,
  Nobuhiro


