Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BF4C4828E
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 12:08:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.21184.1706875728195386449
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 04:08:48 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 412C8giT256235; Fri, 2 Feb 2024 21:08:42 +0900
X-Iguazu-Qid: 2yAbno87TWggX4ZQfZ
X-Iguazu-QSIG: v=2; s=0; t=1706875722; q=2yAbno87TWggX4ZQfZ; m=FhOLnZGFyJqgPxpZT4ZPBofnXmXavL5460AGkC9rx/s=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 412C8fpJ2719770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 2 Feb 2024 21:08:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPci0H372dVYPedwKd5vQl6QxHbtcbS1s/0P8NAMBF1DGGWRKjmGwbTMle9jrnb77Xx0eA81NMmA3SLducX45Rks0J+zpQP4i46yzRgImCcaI9q9zy2vDzWEWOe7nUeg99tbkY3LirSBLuekSDRJtj56QzGNnD7AhCb4+WXc6xNOo8XrgRokz8QQlMbwUiaZp+GpwgJ3Woj6Fb2v0Ns5hfwAnc/kc4CmYx5xZAUU99XKikWQKNfQz1awpO9xn+iQQ1vA2A7D5ycyi2Oc3mgIa+u6iiDZ5b9+KWo+XlkDBGqz5PtnT+ioWawoH5xzoJx5M3esJuh16IcKlP251TxxGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZblskijOg33OzzIeGyqL4sW+qGUuPLgU3QQJKxKDTY=;
 b=K6dJsY8TMQtW9DcMEHU3hFFgd5lPegdkdou9Pv3JvhQruE13C2H1dQP7bPVekWL0pptTqA5MCy8aMYRmkX1XBNC70ESDsUUlVAgxUO5F9KqRQ6m6S/Gr9t6oXigfZ2rjiGwSd5t0yvWpBCkfEeAGwGhk8K48XdqRWAhm/y2IIKaYYwbFLl4uvYIZ0Y+BmXm6g2bC2CHmcTGkZ2lmrigy+Qg2oXAiXYNThf93RNtvmvrsKBxEwlLPz4N/o9bh81hCjOKsH5OACrKkA/iEePIGlPdywUvHiASpgsdiW91I/4N9yH8l5RtiHD7jK0yf2jun6JpFbLCCUBGl8QrXRFaIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/6] Versa3 clk driver improvements
Thread-Topic: [PATCH 6.1.y-cip 0/6] Versa3 clk driver improvements
Thread-Index: AQHaVcxKixUIH6qFQEiW/WeSBMrH3bD29Ucg
Date: Fri, 2 Feb 2024 12:08:39 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63885D88BCDFCDA0E70DE5EE92422@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240202113754.202827-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20240202113754.202827-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYYPR01MB8262:EE_
x-ms-office365-filtering-correlation-id: 67b9f919-c505-42b3-e928-08dc23e7b15c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7LJWMd4t3DlCN3ft5uLiH55dK3C8lnqEqrZi9alXZiZ/jLnZU1uLkfyhIDvqb6X39xO18Hqqgg50o3Gf9/BVUHdnFjppuGZpBdWc9+8RCvZBAt+PkTpZdXXeCPyEhOg1iIvjnZujU5O7DHZUutgqXmMMlhGvRVY/LgJDLQmLb3EtKb+4t7KqbXDGIFKGi9IJEqCFGBmFNIE4eXhSudASHo4WcpRcnQsU4LtQNWaqux1dzJgAXeq+b/Vn51VpvxkIUmejpMZpCGLp2OgpgIKMHC2LkqXNCs6DUPnPBBvToZIGgmtW8TUN0EcNOlx6Rr5ji4lIFiYDE+qd8SoctEuzjULiKRYAjBBnmtnw5wL8Lg96+KjQBnn6LK7iNdFNwJnvnpfxrwmgShS2VJm8oDkqTwHeuh9rJS2/nvQWbgk8lZEbWXbG0+jB+tz9fRFDJSvw90HJnVObH58pgMJ3CBei+w+24CZeIQEOMOYa3BKnTzkoA2T5u43Lh211Ncup997TReGNgjX4OazzApJ6xYHCz86taNkeOAK8CkHRnc2m85eURAIiAQUKqKPejm9AxxktQwCi33jZNSwC3jxKJ0m6rBMQ3FQA7FaaQ0wC+4FLKcELVCJ/JQqnHivFSUAtkpGlHijD8t/58h/Z7Y1xPWXBEA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66556008)(64756008)(66446008)(26005)(83380400001)(122000001)(86362001)(41300700001)(38100700002)(33656002)(8936002)(66946007)(76116006)(110136005)(52536014)(6506007)(2906002)(5660300002)(71200400001)(53546011)(316002)(478600001)(66476007)(8676002)(4326008)(7696005)(9686003)(38070700009)(55016003)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?dndseWhWU3lBTWdaQ0F6OFZvUXh2OGl3aU1waVpQUS92a0tMVmdPWWRl?=
 =?iso-2022-jp?B?TlJFaXJnMEVaNVZydm96dkZrNFV4VXdydFd4V3FUYlZ0K25QTC9UZE0w?=
 =?iso-2022-jp?B?UHUxa29Tak9QN1VzcERCU0hld2hVWjV2dGh4MEw5VFJLc2NyZlZzaDlC?=
 =?iso-2022-jp?B?UmVYRlVqUW9PL0ZjMzlHUldNZk9ubWJTUjV2enFMUExkRy9PRlp3WHBQ?=
 =?iso-2022-jp?B?aHArMTV6ektpUjhQT0R4elVCdG1PcnhIMU93V3RtZ0JwUGlyenIyTWdU?=
 =?iso-2022-jp?B?MUFjUnpoaXNucFpwWVg1a3Erd2g2Z3pBYnVleCttWWpWMWpPOFV2TXlR?=
 =?iso-2022-jp?B?b3p0MnJQMmxRWFNCNFNYOVEwUEM3WWJUMFVaK01GUTFCUTdJV2QyZjFB?=
 =?iso-2022-jp?B?ZWFsRGh0VUNUYVJoMVV4cmdhQlVObFI5N2ZxdDBJVmZvNG1LOEREKzJQ?=
 =?iso-2022-jp?B?QmJVL1dBTlR1bW82ZGErTVhuTFQ5Ri90WHFTZmNOV3ljY0hPeEtvMlB5?=
 =?iso-2022-jp?B?WTQrS2NtV3FSWnJ0bzF2ZHk2S09RTjVjT0d3WmswSmRhY2ZKS3lZTi80?=
 =?iso-2022-jp?B?TTQyTFY4eFcvYnJtbkFtS251U25ENFJVN3FuN3laU1ZSdk95M3BXTnc3?=
 =?iso-2022-jp?B?N0h3S1RHTHlTaXZSNG1DejZyRHNxWU84empIY3VGS3lDYmxZZ0tyRElW?=
 =?iso-2022-jp?B?V1Q4QmM3ZCtuSFlpanRMSVQ1NURFcHgxejhqeVZwYmJuSzVHcEVVVzA0?=
 =?iso-2022-jp?B?RXd6QkxjSkY4MzF2Wm9FRmJIcnhLNDg4cTI0R2N2NXY2QVVwRzI2Y0pw?=
 =?iso-2022-jp?B?Ry9RRGNpTXlzVWprWXBQbEdUMzlYMlBJNU01OU5wRlREdDZXMmJMQzhP?=
 =?iso-2022-jp?B?STJmZ1pRU0JxWm5KTnIyRnNTL29hRmJnZGJCTmFlMG5jRDh5bkY4eXhF?=
 =?iso-2022-jp?B?OVR5LzdjeFBMYTVhMXFyeFUwSzFWci84SnpISm5Bd3Ayd1pLTE9UeGZF?=
 =?iso-2022-jp?B?SDJPdVdDUlVUNmg1TXYrM1JEbEo4TjJqZWFhR1NtZ1pIeWw0VU5JUDF6?=
 =?iso-2022-jp?B?dXVjdVczMEsvNHJiRE9YZThxVVp6SDN2Q1FSSE9uVFZ0Z3VoU1NORzht?=
 =?iso-2022-jp?B?a2lsdTFyQkpYek1US0tBWmxGU3RZN2pTUzVtS0tEN3o1aXc1RC9RUlk1?=
 =?iso-2022-jp?B?akNTeWFPNlVoZ3RQczJHTElZZWhHUkdQRnMvZ1lENVREQmRHUG0xTWYy?=
 =?iso-2022-jp?B?d09wNEVBMlZBbHhodEdteTBtTlpCRnZXcXR5Qm0vM1dNYzBCME5aNmh2?=
 =?iso-2022-jp?B?aU5FTUV3ZWJpQ2hERnFkUDBicU5JWnB4ZXdJTDJJYyttVndYQlVRWTBa?=
 =?iso-2022-jp?B?MHVscDRqcVQvakhhMFJ4cm1JWldLeG81ZkwvVWNpbE1hUnVBRWd5WHZL?=
 =?iso-2022-jp?B?ZFZTaEF6SUthRTMxa1ExWTIzQk1laEZhTS9MSUJibGVrOWFITHZIZXdi?=
 =?iso-2022-jp?B?VmhHdm44SFl5WnBvaWVkUVhUbzIxV2VlSlhETXpkUXdsb1RmUTBLaDQ5?=
 =?iso-2022-jp?B?V3ZibHh4K2ltVzNhc0phU1VEaVZVSENnWjJZdWoxTGRla0VqYkh4V2NF?=
 =?iso-2022-jp?B?YmdsV05URXJwbEUxOUw3d3dzeFdyM2tTSjNSNTJUbXh3cG1ENWpybG1E?=
 =?iso-2022-jp?B?MXRKR0U3bUlRYW9VZ2NJMDNTOXl6ZUpkaG1kRUQwak5GOFcrSWVtNmd2?=
 =?iso-2022-jp?B?WWx0Y1JmZWdia0tBK2ZLQ1F6M05LbmhOV0RhMUd0R3hyaEtjQVdyc3Q0?=
 =?iso-2022-jp?B?SjZQbzY2bHByaGNPZlJIMnpjZmNSWHUxajhndmlndFVqUCtKVlh2amha?=
 =?iso-2022-jp?B?UlJONXdUVWRCTURnbUdoeS9zeUJXSmF5cXdicHd0NEZYSmNkaGYzUkdU?=
 =?iso-2022-jp?B?cVJ5cDRPNmt3MHZqSzZweUp1SFl3MWM2akR0bkN3KzBCck53NUpVenRC?=
 =?iso-2022-jp?B?N3g0Sk5UMk9aTXpXd2NZUThVbUdCSTZXUUlNNVgySmdsRzRvTlBVVWJO?=
 =?iso-2022-jp?B?ZXJqdU9taWx3RDBHNnQ1b09IbVltcG0ycWFzMzVDTmZIMnZoVDRhdWFh?=
 =?iso-2022-jp?B?S29QV0JXajVXT3crWmpUY1FmbzJTRDY4NlZzM1EwUXRuOE1wSmhyU2Z6?=
 =?iso-2022-jp?B?K2F5T1M2blFLenovWjJ6ZE9KRnFRTnVFUk1UcW5tUjAxbVJhQ3pNRVFp?=
 =?iso-2022-jp?B?M3FOSXB5QWx1bXA1MmNPTEZiRUtvREhyLzhPK0d4cDJjd2VsaDNOZWhP?=
 =?iso-2022-jp?B?M244cDZWYzhDaTJoK0FBY1FSNUtzVXZRQkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b9f919-c505-42b3-e928-08dc23e7b15c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 12:08:39.9783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5rnopMciG7l6Nw94ykZ5RV603sGd1BTtyBULlg5lL1Wz+V+nCZAambiGIyb8DBu9mTW9QUUMt1z06PhtZXThv+JwzP68JGxe4xzHMFRYTRG+lWxgkkNyb9x/qiiX93KG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8262
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 12:08:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14626

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Friday, February 2, 2024 8:38 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip 0/6] Versa3 clk driver improvements
>=20
> This patch series aims to improve versa3 clock driver.
>=20
> All the patches are cherry-picked from the mainline.
>=20
> Biju Das (6):
>   arm64: defconfig: Enable Renesas VersaClock 3 clock generator config
>   clk: versaclock3: Update vc3_get_div() to avoid divide by zero
>   clk: versaclock3: Avoid unnecessary padding
>   clk: versaclock3: Use u8 return type for get_parent() callback
>   clk: versaclock3: Add missing space between ')' and '{'
>   clk: versaclock3: Drop ret variable
>=20
>  arch/arm64/configs/defconfig  |  1 +
>  drivers/clk/clk-versaclock3.c | 88
> ++++++++++++++++-------------------
>  2 files changed, 41 insertions(+), 48 deletions(-)

I reviewed this series, so LGTM.
I will apply this series, if we have no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


