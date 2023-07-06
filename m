Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEE7EB64DA
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 00:07:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.10341.1688602074234978889
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jul 2023 17:07:55 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 36607hMa550848; Thu, 6 Jul 2023 09:07:43 +0900
X-Iguazu-Qid: 2yAbwL1gxRPOWeXH7I
X-Iguazu-QSIG: v=2; s=0; t=1688602063; q=2yAbwL1gxRPOWeXH7I; m=OvKb10E/3ngOotSHFLTYrDmnurOAyECIHBabEaTUf2c=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 36607foI2864735
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 6 Jul 2023 09:07:42 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Njli+/vxSgRKYaGTli4btE7F349eUSKA0lcRbyp7E6DWEXAgXBSrmo/1h9SCXjVPTL7jzippRx1I9isdQKtE4fL5B5+X/o0e1sheZNQqbQY/J494JeTpO1PzbYL5cmuvE8xcZb9A+tJ84JtkkUXahCgy5FIXf5vyAn4zGxnUBslD7qjwU741CCTKfQnXAvfUKHoIIUekHhd+88eYvd1xEl5OCv6Z1gn3jfPPqB+EQE32KY/TDL8gvQRnjAtYmlPeZPWEOVgrYtxeehwODNilPK3o5h56r2tHUwG0KJ4qHNwa6LcDfwvl9hrczN+cETj0zHuM7c0dxrXDfs0PsdPoRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzhoK7ZcgfnvJfrPQNujasQ9ZvebvvGaCmFbRCM4c44=;
 b=JRxmrqHHM/yJffKT7Fg3lX5+7pxwF8S+ym3fDqmT2to0SHFHFV7w5AgImBQ5O3Xaffibi5ygqJtPE5MpmWr9aT7PjN12WUsnm3wktcjznHaap9/EKI5BE0NW43iZ+kV1uXSC931d8Uj7vJU9yL9fduIQIGNEIySZSfAalqO0vCA7t0Vy86KnbWV3wDqPlxa0ZPfE2SfYiGj4WvqjyYi5mjr30Vah+rREEmcg6036miFDbsHAIjO6LjF/DbUvdZqlaPmXC0Nj6GvMC5FHP1nezV7Nmhxf3Z4NHVKj6ivDmS41R53MaW3KmTSrm7RHaR5788xAYokTRfeAA6nkFbyUXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/3] RZ/V2M I2C driver improvements
Thread-Topic: [PATCH 5.10.y-cip 0/3] RZ/V2M I2C driver improvements
Thread-Index: AQHZq2q9UwD+8KMI30qy9o9rfAeN0K+pBnUQgAEI5gCAAdU4IA==
Date: Thu, 6 Jul 2023 00:07:39 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420EC2AC771CC473BFBBEF1922CA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230630155118.584293-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB9420A3CB3F831F9DB6FE51CD922EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <ZKR75gaHVmf59H9/@duo.ucw.cz>
In-Reply-To: <ZKR75gaHVmf59H9/@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYYPR01MB10547:EE_
x-ms-office365-filtering-correlation-id: 93260967-088b-44b2-2f16-08db7db50324
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 luaXYBL281EGoOiYJVTZjuhTITuqV6bibXG7RqHEQjty0igiHmV3kQNyPi7Mse6XU3qgrRaKbQg1U2XDhTJnacEuRKS7yTYOqne9VrxsDjWIIefE4rq41ipyikI9IZ1f0Pkk3MeEdggu60N3vCMuVg6Q3cF4CBRCkQMGeAB3y4KeTjFbcBSUkc6Gf1bjkZDXZG8Z0hFYNUAvejOj8lWNgisGB77/bcAL+jAfJkPFtqXDJjCF+WvUw3YDnOHEuIsrrovgOEVpiQsU2C+6HkA2yPLZVmrQ/Pyedw8MGIT8hExrvP3GbbdMOk2Yz1pkpAqeP3vKFJ7ku924nAxnD86kD5DDYPAxqrh5FdY6h1MiHY5gESE7z1apFjincTUL/2SRymSy5vTVi6ipmQoHDMe+T+A57P8u2Osfz2k+T1AqLxU/pXkimGfoholzhVVjQ8fG9LKnxAeo+2y8eC3eiDtDx9pS6Kdtaf9iprISN9X46h+0ykJ83qCcu+EC6rC/n4wCyPIR3ZWf1ZnOYOadey+OTb3sTob+9xU+AZHk3TxjqOd0LMyY42CRF9J222Z38SBewdlrO47ITS6S+A4jQjDsKRHJ8HFuym5OStZox2+Vk4L7ZOFUHBp2ZuNntEuSm1E+A9dhg6s/2yFAZOPD2lz81A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(76116006)(64756008)(66446008)(66476007)(38100700002)(66556008)(66946007)(4326008)(6916009)(122000001)(55016003)(186003)(86362001)(478600001)(33656002)(7696005)(966005)(71200400001)(38070700005)(26005)(9686003)(54906003)(53546011)(6506007)(8936002)(8676002)(4744005)(5660300002)(52536014)(41300700001)(2906002)(316002)(83380400001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SEFVZCt0TEhrdFpSTTVDQ3NwbXJWRk90VlhwRlRFQjJUVHJVY3Fla0Jq?=
 =?iso-2022-jp?B?ZmlCaU1oQlA0MFBCVFVJMmVGd3dOZkdwZXdKUmNsbkdleDRmajU5MGdQ?=
 =?iso-2022-jp?B?NTdNZVk4dlprZE5MaWJSTWs3Z25wZWlWTmM0U1kwbC9ycjFvbThlSjRN?=
 =?iso-2022-jp?B?d1E1N3htZ2lqbnNWQUJkbW9IN2pZTk5EK1NlOHZ4NkN3T0ZLMDhHTXFx?=
 =?iso-2022-jp?B?UW1Sc3RndHE1eEtTQ2hKN0hnRCtvM2kwSmFGRWNHKzR2azFvaW4zR3ZF?=
 =?iso-2022-jp?B?ank0RGpSTTBMUlhQQmlUeXV3dld6STNObEJLSVNtZnlmenUwYWcwek0y?=
 =?iso-2022-jp?B?dGNpMHovVi9TNjdlbGpDRXFORExpaEZNQmpkbmEwRWtUUFMyb2M3U2g0?=
 =?iso-2022-jp?B?RGxsQjFkOWhYOThUeWxvRkJsTy9JaWRHZVdEM3QvcXFzb0ljd25sYTlU?=
 =?iso-2022-jp?B?a2htVXJkeEdJUXo2dnR5TkZxNnIxaEtMSVVlbXVDNXF4YTdEZld4RXFB?=
 =?iso-2022-jp?B?eWxxdDB2SnVZMy8rUVFVV1VGSXdUTXZEd0tVdlVzSDh4cmlJMWNmcE8r?=
 =?iso-2022-jp?B?TEI0SlF4VDE5MEVaczQ0Y0tWVjFmV2RXNDh3R3JyN1hocEs0d0JqeTV4?=
 =?iso-2022-jp?B?MXMySW1aejk4R3hLMmxORUZvNGZucVIvKzF2aUNhZDVOR3NKVjZWZEc0?=
 =?iso-2022-jp?B?MExkT1lETjlmNDVOUWFGV3NFY2pRSFBreWRraDRFZ3Y4dXJtZCt1SXFH?=
 =?iso-2022-jp?B?M2g0azAyejAva2hzaERncWN1amRQSG1uOE5aTkhJTHJpOHFQNGF3TkpV?=
 =?iso-2022-jp?B?cFVxTU5rUUdKZE0yZFV4Z3c3RDZRWXJNT1ZGcDBmOW5rMTUrRVJNTk5u?=
 =?iso-2022-jp?B?SGVvVWpkY1N0QTVjU08wTkJUK2R5WUw0bTF6eDQxRmlBMGZCQi83V1hu?=
 =?iso-2022-jp?B?eS8rUk9LOHR2RytsYUVPbytjOEwrMWR6am80VThJN21qL01teitkWlVv?=
 =?iso-2022-jp?B?YjYvZVBvZzdZSE1HcEtwZXJFWjNZMXhkY1crOG9aRituVC8xVm52Sm9v?=
 =?iso-2022-jp?B?cHVOTnJUQk1BbDFYbmo3ZUtMMHhpdVV1NmlJVllFUHROUVZSb2lzM2d3?=
 =?iso-2022-jp?B?M21jMlRRTDBtM2hGSU5FMisrRmFTZU9rSGhFUzFwMVQrOG8yQVBPalda?=
 =?iso-2022-jp?B?MkhjUWVhZHBGTUsyNDlSVWxZRWVTSWVraU9nZG1nYktIUXgvd0xtR1FX?=
 =?iso-2022-jp?B?Z0RJRmpzclZ4OE04NEQrZnF4ZG5HdCt2cGRpMjUrR2tEYXBrTHdNOXU5?=
 =?iso-2022-jp?B?bkQ1WEs3eEhraTFRTXFIa3VYQzZtdVdOTEtZakJWMzFQWDlRSGRDZXNW?=
 =?iso-2022-jp?B?VGEzeXJDK2IxYXBURGwvaFMyWS9QQ2tGMnovdEpUZlJoS3p5YkJDV3gz?=
 =?iso-2022-jp?B?bUVoZnYzckRHeDczY1ozbCtJMzF4dklmT1ZOQ2EzT1MvWUZkR3RrYi95?=
 =?iso-2022-jp?B?dEliV1Q3M1g5eFp0K3lqUXhRbmdPcllhdEhiTzdGdm9MakRydExqSnVn?=
 =?iso-2022-jp?B?Um5nYXZmRVpQaWtBaks2VXc0YnIwZU5UbEZFdm85UHc4eXNncmNGWG9n?=
 =?iso-2022-jp?B?akx5Z1BQM0d6TkE4dDdMaUxhSnVacllSbmNDd2NwYnFOTDNTUU5TbFVo?=
 =?iso-2022-jp?B?ZUVzQ0UvNXNYUmJLNGtFUUVFT3lvL1NSUWVGb2lHY2UvcEtBQmFVdHMw?=
 =?iso-2022-jp?B?RVZicXp2cUE2VytKcUFrNGF4ZCtJdnFFNmxuUzdEKy9URXl2TjRxY25Z?=
 =?iso-2022-jp?B?NWFtRXJzQmxXOVppWFdJdXhOaEk4OEVtMHdMclVGNnZSMXRtUTgrK0du?=
 =?iso-2022-jp?B?aTRGUUpJcWR0NE5jNGlkelJGck5ObFFmVWhTZnlwVFdndDQ1SzljS3dr?=
 =?iso-2022-jp?B?MEw3SDgzV3JYQmlENVYxZVNEL1BpRyswdGd1YVh3M0dlUllYVThpNUZ2?=
 =?iso-2022-jp?B?eVJlc0ZZeVltRHFkVHUyTVpUSzB4L1lMcWUrT292ZGU3YXhvalJ3Ti9n?=
 =?iso-2022-jp?B?THdTRS8zbzhWZU5RRVFCN1NzZk02NWtvS0cxc2xKaHVLbGhyNkc1WDMr?=
 =?iso-2022-jp?B?YUhUSmFNT3h0MS85dUppSlU1anRiYlkzdFUwY0V6d0ppd2VybXFqZDZI?=
 =?iso-2022-jp?B?VFVXM2lTYXE4cmtXUlFYUEZBM0JoVjV2b3NuOXhVWVhLOHF3L2J2SVA3?=
 =?iso-2022-jp?B?MTNnOGJhYjQ4b1ZXU0hBdTVLNXNNM1FDOHBHa1IzZkYrYUh5ZTJ3T3JK?=
 =?iso-2022-jp?B?Rkp1MFFNRkI3VlFVWENxcXFuVllJZ09tN2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7LMeFh49c1QkUqroqysJc3rPPZPbBYq9abNYJRQ81E3NXBUIjEs+9giM01xTrRRAGOFwRovHdTmixHALXIeNgNnZoKtQ+PbSKkbTXgmdahvdzbBYzNx5wVaHl8tHjwE4p8X2+5TNtnfcENyuB9MF3Qb1LL19Dn7jRiq8G1aij4XTC95AXtlaWHfbatI3AbGA3iVvhO5/z+LY7Ak8tvrYC4/XiH5kKmhP6SxlTGDZZy/VzUl6lrEf4uaR45chAfRyzUmeNlFsNsLIugQm/4jFrJJoVRyEcUyWO0g4VWlZ7JkDTEhT0sHuEX+utOkstUret9X4Lzoou8NUfgMxG8Ibjo6QvBDtyAkXtRnqeyERd5fDpsBpEso/ILqYvOGHDh2v3KhPIzSwNeqw0nxq3y1ZRGJl4CkVLlaOeAD8eV6hxy17wlgI5b7GBe1VNi1GwW2L+iK49uzd0hogYMuQX/anvQJwc7jfyAs+ewkI3uScAvi33KAI+ytAoWRvyXe7O74/QJNu5qHAOIXVrIUg/ZPcy4IaKMJ3ycfsSext5VzBJ79NvvvKrIeTh7Mo/wVR0BoppnPkHRIe5a+munsP4il3Xvk3MfL4Z4lzonTDcHLZihlfgBrgIZLxqbD0PO5Z6mp11Heti0LamLXE4cY1QPHDBi0PLV8Lus4ryhgKM1vJyMwIKxcC8bF05z7ZaJWljUWuDQza6lRuIdjbLv30hQUFITbdvY+DUPI/c/6Vca5MIGPny70F2jM935P/jBcGEUR4uItyu6IRd8XaIMkG7Vfh2BOJiVc49xqUvL1Sy7RcI3avhjryBshwoCLe3rr0fQCDTs167KaXW/064khXR7z12f5ff3p8G1bxqGZcM/iNrVQqqGCLkKRbiEuq6upgEMkPtlQw9pggwHSchPTOcpbqhA==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93260967-088b-44b2-2f16-08db7db50324
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 00:07:39.8283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rtIXeAoVKKzqWy5r0iAqGaGU6Jy+edI91ynYb2iinLXQdsyVju1DlQNL62ET3Uwl3+trjL3be8sFloRJD4GfCczcPp8IwPoYfSk4p9yo3cGy58SNxrK9XkIEF+54XJNU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10547
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 00:07:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12236

H all,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, July 5, 2023 5:07 AM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: biju.das.jz@bp.renesas.com; cip-dev@lists.cip-project.org;
> pavel@denx.de; fabrizio.castro.jz@renesas.com
> Subject: Re: [PATCH 5.10.y-cip 0/3] RZ/V2M I2C driver improvements
>=20
> Hi!
>=20
> > > This patch series aims to improve RZ/V2M I2C driver, based on the
> > > feedback from Pavel.
>=20
> > I reviewed this series. Looks fine to me.
> > I can apply, if there are no other comments and issues.
> >
> > Test:
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/919943
> > 145
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
> Looks good to me, too.
>=20
> Reviewed-by: Pavel Machek <pavel@denx.de>

Thanks, applied.

Best regards,
  Nobuhiro


