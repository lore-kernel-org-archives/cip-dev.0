Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2B4EB64DD
	for <webhook@archiver.kernel.org>; Thu,  3 Aug 2023 04:45:46 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.7380.1691037936151959383
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Aug 2023 21:45:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 3734jQQD1485257; Thu, 3 Aug 2023 13:45:26 +0900
X-Iguazu-Qid: 2yAbM4uBQlb0dGrGNz
X-Iguazu-QSIG: v=2; s=0; t=1691037926; q=2yAbM4uBQlb0dGrGNz; m=ypGLJMhe4jdJqelPvBjBK2c7lKKXp8Mwqo40tUEOxlE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 3734jPue1944734
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 3 Aug 2023 13:45:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8g+29LXZWSgO4KhOLxYg7U0wQo8XIiC7XESKCe1drofWrO8eAdTalQH6yfFFcOnuFdBevC4oIz0HyQ21JngZMPeXV8ZnN0ow9OBUkYAX00MEvmQq6vAD11gWiKmVIw4fVqB4udP/Iro1FCRxjrgLUbipYtNmwYZovTTeijNHp5d9kQqE3p/M6PK/fi8Zf1fkeYxDBwHqdq8qU+sBFfa/+t2btfRsBFvb0oYhJIDlPAh1jHnVjlhMWGzYAqG7d/RQxuSNcPUV4uPUjqmxmbyl96tBAR6I++wGr1OXD4iCKFAGWpnX7gVGclc/mTOkcAnUVV/c4RbhTEL3p7o2FkNTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6mgc8OFDX3lfp8L/dHhhy3VxipQglj8EBA6YHiQTNU=;
 b=Cg6oYPglZ1eS1l4FN2EbX+JiT3HrNHY+otfZLJBa8oX1L5mKTPvB8490m6giBrz8U2H/DKHL9HTH7dujiaWy+HXZMoBqVChVZPjP3xst6VfkPP934mW8vkVUcQnvBOAco/qXGaOGnaCLfAiYroCGF0hzFEHLmi+FEfjHJjJmT/huKUv3S4VIjUufL9rRat31ZwnHCMEpcXkeZ4wE+Vj8zb4Ol13AXX1yBFySYlWoGsg0pmA0GUJQyg74ZSzQznvkGQgzNB5JH6FT5EjeyHB9Jp9idBdimrAr9QCG1cnR84+o4a70BnIbRWleuCSeHdpuo5AOQxnT06nqbkEhDmAj+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip] tty: serial: sh-sci: Fix sleeping in atomic
 context
Thread-Topic: [PATCH 6.1.y-cip] tty: serial: sh-sci: Fix sleeping in atomic
 context
Thread-Index: AQHZxUxcs8Njbamm1EOSlSYqo7XSrK/X/2yQ
Date: Thu, 3 Aug 2023 04:45:23 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942035A7B11C466B09ADF4C99208A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230802141919.474558-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230802141919.474558-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB7943:EE_
x-ms-office365-filtering-correlation-id: 0d57e4cf-8259-48a6-b299-08db93dc72d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vyU+v43pwj0eVskZ1TXPrLGZEJzl1/1IbNQoD+tW8NRatNJ/AqU8Hw+vSrjVkHbytI7pC4iifIjzC2mJ4GIlAvVirmxUES8KMcatqELk58W6Q7/JZ9FhkF/sbsgZMuAPDGMEZOYqaEu0tDhfVY9sYzzbGBDMPEaIpudBjWb+N2DV7hd53qFhxUqqoJCO1nrveH9b+6wS9EjW2jJsaKvkAfhm9kXN5e2QXTTwAeO3apGi+/L8SVoofMJmIp2pgZoL+1Jqk4LXBRBwsatVLe/ML5KPS10O00PUDqQ8PxtZOEnkB+aVJ5z+5pFYKX+sYkJFkwHcw0ymCXkEkBT0BWPwePuVjLE/kjPCXi3is5aAOi3uoX4Lb36eVt+rhbwxJY0ES7YA5B05vxZeN1m6r1qDNswrPxth1Xy5jsW1jorRyAcjHnz1ygUP38utdg2YwEwL1uySro6AFbLBZofGgPUK2eiwmZv5sFFLIgWsRNtiP1gKJuhZ9u+w0SHYmfXChJ6Rcacmvohrsayy6+hnS0qqEzr7CvYOwEWYQKYN51pi265OLsyDW9/M9LqIqg3L8bYV/uixI3/USr5IUtROcj5RIZMgBLypctSadrlhtZaJsW/hL3R/aXJtSB20UGIMxnBt
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199021)(38070700005)(86362001)(33656002)(478600001)(110136005)(38100700002)(122000001)(55016003)(186003)(26005)(83380400001)(6506007)(53546011)(41300700001)(8676002)(8936002)(52536014)(966005)(9686003)(71200400001)(7696005)(316002)(64756008)(66446008)(66476007)(66556008)(5660300002)(4326008)(76116006)(66946007)(2906002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?S2Z3SFovdDU0TTJXMWhZRXpkemQzVVpoZEpBcDBPcm1iUnQwYndsa2VH?=
 =?iso-2022-jp?B?Unh5b2ViTVZ3ODFxbldvK1h3bHQ4SDI3WnJOblRCbjYyQXkxWW1TYWVr?=
 =?iso-2022-jp?B?WjlCYll2MjlaM3VKTStHRWNoOVp4ZFNiQ2hUSmRzamJGWnVHMkt1NnZG?=
 =?iso-2022-jp?B?aERWYks2eFk3a1duY3VtZ1NLei9tQXF3Rlc1di8rME1NZ3RYRDZPWEw2?=
 =?iso-2022-jp?B?V0hLZWh0SytzRXFFaEpNeVdtZHJyZjNRUmcyVDluTlZBUExJNjBtSTBj?=
 =?iso-2022-jp?B?K1IwanNsVTJMSktvQ3RXTmpSRk4xVnlnYmoyRVlLRU1KWFA0TFJBVlBj?=
 =?iso-2022-jp?B?YzlIbGVCSUtDOGhGd1pBWUJUQXJic256K3EwTWxpSVN5YmhzcTVqYlVz?=
 =?iso-2022-jp?B?M3V1VG5vTStvQnlYaGMySE5kTGdXOUp3ZElHMWhRdE9CdUlnWnZWd2JL?=
 =?iso-2022-jp?B?ZzlGOFNNcTl2M2NEbTVtVjg5aDR2OGpPa0FaMk44anVMUkNTdHZscDlJ?=
 =?iso-2022-jp?B?RTdxNUNWTTRtSDNnODUvSUVMRzRqQ0RSMnc5cFQ1WVRWdDl2czFNM2Z1?=
 =?iso-2022-jp?B?TW11NTZubnNuUXY2MjVEMktXY1l2Z1p1WWQzYXdkcG9YWjBUci9MNXRh?=
 =?iso-2022-jp?B?Wnh4ZlE4QlRldUVDb0JhMkdhQVIvTnVqWHZmNSttNEQzc2JCakdWNVJ1?=
 =?iso-2022-jp?B?MkdhU3VraTBYSUFsNDViWitoZ05paWtHNUxVS2RMRHpzMGJreHpKL0RC?=
 =?iso-2022-jp?B?M0RWUlJJKzgwdDZpbmg5YUhUbHlUaXJScXl3K3FHeEJ2MHpEVzFVYWZE?=
 =?iso-2022-jp?B?elR2aFdHQlZHbktNcVhGSTA3UWxpaFdmQnltSHIzbHFSWE1uQWJWajF0?=
 =?iso-2022-jp?B?UmxSRjZIeStFQlZwRWVxdmtHUUU3VUw1RWR5ckdFbkxQMURXeHBmc2Y4?=
 =?iso-2022-jp?B?NWdhOXhXSDFtQ0pTdENQcnlLWk9xb0h2aFd2aGlUWXRGblVlTlI1SXZO?=
 =?iso-2022-jp?B?UENJMjlvVTRPV1lrUjJmR3orUHRRdHBBVThkbVlLZHQ0YmxZWTJSUk4x?=
 =?iso-2022-jp?B?Z284Q0xyOGFDV21YZ0Qzb1IrZGZhaGFENEpLelcrd3p2eFR3em8rSCt4?=
 =?iso-2022-jp?B?OXN1dFI5anFvdUxITWhkQk83cEp6bHhKVnBBSHpabDQ2RmN3aDQzVFVM?=
 =?iso-2022-jp?B?R2dXYytXd1NjcjlGSXg1K01USGUzTGV5U0prWVAwZTZqaXl4N0dmZ0l5?=
 =?iso-2022-jp?B?NUVoeHU2YnBiRzdLT3dhaUdQYnp3bFhVNlYwT1VESjdoallkK2NieTZI?=
 =?iso-2022-jp?B?Umt3ME53cVl5bm5IQU85QmdWZHRXTDhmQ0dEM3IvTktVT0krRDJEbFVO?=
 =?iso-2022-jp?B?Q094RU16NmFtdm9IcnhoTW5yTXFvbWhvL0tZNkVoOEtac0ZBUGZFZ2FB?=
 =?iso-2022-jp?B?UForMFVwVnphWlJhZTdKWkFLLzcxWHU5ZW0rdFNaM2JnODdoQWU3VTlw?=
 =?iso-2022-jp?B?TmJtN0wvamZaSUw5NXB4Y2ZzQVR6ejQ1RUU5cTJKd2NmVEtQRlBkZzk3?=
 =?iso-2022-jp?B?NnlWcS81ZVRZOXN3Q09HaGlrNFo1YTRkVEg1WFJsYk5MNWtZL2NzanR6?=
 =?iso-2022-jp?B?M2wvKy9kc0xTbkFJQWNZb3c2Y1BabVlvRlVGWHBDU1A4SEF5WDMzVGlI?=
 =?iso-2022-jp?B?WHVWTlo4UUcxTlRBNWFQbERwL0xaQXlrbzZUL20zQm5BZG8zRkUvNWNY?=
 =?iso-2022-jp?B?ZDk5WjJNZjVJYmhtR084eVNDazc0aEtZVTg4MEJSYzEwZlJBVVNFbVhq?=
 =?iso-2022-jp?B?a0lpUWRvNk1oWXgrVy9SNW0rVTNOZ3NSaFpSVU1leGNIaEE2SDJZM1Mz?=
 =?iso-2022-jp?B?QjZFT2d2OG9MOExPU1BiWTJsa1FOZjJxaFlaeWJ1akVEcUxsbmNxR1hM?=
 =?iso-2022-jp?B?WVlpYm1rOFVEUjJSa294c0ZYQUhrM084cVpEcHZUQ3lrRGxOWHJEcEpU?=
 =?iso-2022-jp?B?R2prWGVpdFk0M01tY1dYKzVIYytFOS9OWkk1R1plV3IrTHlBL2kwYnRv?=
 =?iso-2022-jp?B?U0NLZ21rczhqZkxtZ0ZVbjFxaVEzYUtiOW9KQVdNSEoyOVBKNWxJMjNk?=
 =?iso-2022-jp?B?VnRYeTE3clpnaGZpUDZkSEg3QzlSQThucTQvRW82QUgyZ2tXM1ZLcjBj?=
 =?iso-2022-jp?B?ankzK0g1TDJWaUk0RzcwemtDMUp1Q0s0Y1VncEQvWWJ4c2VyQ21mWXBF?=
 =?iso-2022-jp?B?RnI2OWx5d3ZTZXdUN3dYTm9LWFhxWjAxRGpxSkFURHQ5dGxJY25mR2tZ?=
 =?iso-2022-jp?B?aWw2b0E2YXRTYTNPb3FJYXE2Z3NKV0tkeFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	encd2pSdjRccKdj2TtJtoygY0SaWtMZYGc/cLDHvPxr9pWOBzE19EWQ9M45TR7Xl7sVGA5gqwAs+LhJOB9gTgW9DYIQ7zjEqThFizCKUtToFgkD2jkITmLbrh7EMfXwP5+mf5tljs1gjJP2z3xnO4aZ7xEyQzJVCwEWCEuxJh/aviG+A06febB54YTNJobHbUbHISydOkyUzQ0EVjhd6tZYRXqj5qHliwPV8RdW7r/UHQaULgmZC8XjPDgJtNXpIh3QvlC0p9sxNFr2Ipxme+oa0Ev/SjNIQOnqNX6dNmhkWf8jnSUBdiv5FYGsZUq3B0HH30anesgiImox/PS16WxkPEjhkVz4AU0uFpUKe+LHMo1SGQ23EGcfAXmde+q1X0dSpi7DkKCfY9G3gFpZ8dkyVocTYLoC6qKezICjrq0WKSOWEn5j4wIu0jNtWl7jkfSGt4cHmI8pxa+cBuf7QNN8vlWa2u42bk9lYUHjQZiyF1ZF5i1XLnJMnhuFms6lwRbka/7J5HZF602sZyEDgUbLASXkwQ2jd4APKric7zAfQ1R0YEw9mKhkt3iMuqUPW2/7ZzkSzAK9qbCWHdsL6p+bTqGNPBMPalghXsEROlTQYySZ/hFuEL+qWm4aVk/+NiSw0p30ow+DTsHCrUykG37L5u4nDTgLBxzW2TgMnLPxydojugpp74knqEvNi06rJLxJbEV3Mg75k8xo720Hjae6F7JYPEH4DiVwbC76Pg9DLwKT+OCzCoq+gezfd2pKbmxzV+82AKlQh3pOBi/YmmfAe9YaQaJRx53CcwqzPJOsf8UlA144YRQ3O6FliISyvqF71kjbJbBiQtn3zE9c12Dy+wFDc29HeZ6KC5QM7jPqsXjMg0gngXGA8/2YY0Jdf
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d57e4cf-8259-48a6-b299-08db93dc72d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 04:45:23.1383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1cO1N2I3tu3jmwirsiyniEBMAHHz7VL0Yla2FCAHq0jYI6bsXRGwQKQMFfRQFm1XPlXHtsOYmQex27nnUsQr+kKGocXyO6jeMM3TG/hX5HGZx7y6YOZ2XMAltNNGgycT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7943
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Aug 2023 04:45:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12542

Hi Biju,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Wednesday, August 2, 2023 11:19 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 6.1.y-cip] tty: serial: sh-sci: Fix sleeping in atomic co=
ntext
>=20
> commit 57c984f6fe20ebb9306d6e8c09b4f67fe63298c6 upstream.
>=20
> Fix sleeping in atomic context warning as reported by the Smatch static
> checker tool by replacing disable_irq->disable_irq_nosync.
>=20
> Reported by: Dan Carpenter <dan.carpenter@linaro.org>
>=20
> Fixes: 8749061be196 ("tty: serial: sh-sci: Add RZ/G2L SCIFA DMA tx suppor=
t")
> Cc: stable@kernel.org
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link:
> https://lore.kernel.org/r/20230704154818.406913-1-biju.das.jz@bp.renesas.=
c
> om
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  drivers/tty/serial/sh-sci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c in=
dex
> 226b1d989314..9df182ec15e1 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -590,7 +590,7 @@ static void sci_start_tx(struct uart_port *port)
>  	    dma_submit_error(s->cookie_tx)) {
>  		if (s->cfg->regtype =3D=3D SCIx_RZ_SCIFA_REGTYPE)
>  			/* Switch irq from SCIF to DMA */
> -			disable_irq(s->irqs[SCIx_TXI_IRQ]);
> +			disable_irq_nosync(s->irqs[SCIx_TXI_IRQ]);
>=20
>  		s->cookie_tx =3D 0;
>  		schedule_work(&s->work_tx);

LGTM. I can apply if there are no comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro



