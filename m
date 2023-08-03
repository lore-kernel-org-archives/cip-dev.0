Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24C4EB64DD
	for <webhook@archiver.kernel.org>; Thu,  3 Aug 2023 04:46:05 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.7556.1691037962629757218
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Aug 2023 21:46:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 3734jtEV2542117; Thu, 3 Aug 2023 13:45:55 +0900
X-Iguazu-Qid: 2yAb3wvkLGzAntZVDe
X-Iguazu-QSIG: v=2; s=0; t=1691037954; q=2yAb3wvkLGzAntZVDe; m=fo4pVPhSei6J5Oj7CUQWDc7/UZRtFSYr0XUO4rBTqCw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 3734jrlB1946011
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 3 Aug 2023 13:45:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvUqUmqG9WvhpPXa15zHQAiYefewKhGEAQdaqwen8fxrRjwRLy3bkgm5rG9k6HIrtPU1ZlQ0gnNANjCvvS255NbxKHscjjIlsuxWhyGjmqY8eBHzv/C+bjaaLcv+KNk7JPa8HTC5bjaxcwH8j70OR1p6h436d6XdAOE2ibft9ajAdp0WRtH9e7x18Uu/bD+05VavIAyQmQ5QOYQP8FtdBK8ObnHJXwz2yztLKU4l7nCspf4Nh8XiSqzZMqeDxZvQErSZAuqHkth8mjiLu0Kun3L5sIL33oN44Jf8avh6a5xf9yZ/URPvAEt3Yam1mpSmnu3YHJCqJyioLCxZqPtswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRFErL12UEAdHUIjPBvAIIoMqt/MzKWseOwbw0Uf/Gw=;
 b=a1owF+yYvAfrEhQRy2aGpVuB+aRuS6vEXHPGul9UA8TbAQ4KXZdyq1F4CPE8Ne2JbhUzKS8XSFPBZ05UlNyO5pN0ab+loqLbeUuQXTRb7VMjtAXwexdR5UHPjKpUsYCwzRGxlLOiojzvFyymNu480p2+6DQntU6pNCaAsyrGG+POzyPm3qg9KHI2rChMfR8IMHH+TBeqoRAo6/AtoNGjLFjrGSPALvHubMH6h+QeiFN/5Yyov0eW5zHwX2jfG7uM6Y8vofIWa/nioT73EQyKF71zLqkb2ouvYoLo5A3yZ0/p2wewJsIK/TSe2kJbjiNSBM3JG4f/TPb/9iS/uCVY9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] tty: serial: sh-sci: Fix sleeping in atomic
 context
Thread-Topic: [PATCH 5.10.y-cip] tty: serial: sh-sci: Fix sleeping in atomic
 context
Thread-Index: AQHZxVB/apAwy3orvUq2H7K1Py4HG6/YAAdQ
Date: Thu, 3 Aug 2023 04:45:51 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420153CA8F61FAFB8310E949208A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230802144856.578404-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230802144856.578404-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB7943:EE_
x-ms-office365-filtering-correlation-id: 6ed550e5-d91b-4687-9619-08db93dc83e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ERk1jr367/ocNmlkn38ZMtuz6Gkp+T8U+xG/bIheUy0H2X9+Iz3EepLXlBDysqwLttGJIeqd56HMD4N9vTLE1+eqDrRio0P1OHrbRqy7dAe0asAo72N0pbsAD+F2bP0AEsUI9yAyFZLrsjoICepev/ip3BwuO6mGGb1zZqqeQ9C09ofq4Fd+A3ywPCpI5WGCv2rLvQMhCBZzBiKNDECCj8QNhq9aFV0PbqSQjt+UMadUbdKHbxH3D7yqc5vpsVadgMQFshInD6klpd8ulJ0d244YDa4RQgfMLC83m2x7BUK+9v/lb/p0EiRRhuYv0finW/7PxIaraBjAGOuO2S5ySr2zoROfPrvDtws756N1WCYP5qqoDdaCs550VDGIv6JBRA52kugucndx/CnPBZj8LsmfxttevrLcH3O53vVLfjjw6xx5Ch6f3H7XoGOHtZewmw0bSMGp1A2aO+296TwGFBgJVEmmpRhVwtcM7kcfNCwB7dwlzT+/pT6QKlQaaRiEibSEr/lLFPq3XSdTnICONURC/s5kozrprnUfBqVE7L744fr7WG2X0SIqHugh8QXzH4+ppJxgXxo2yFKEtjPk8DLoaw+19T51AB9v9IefKju4JTuhlWD4UIuUg3MeMmco
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199021)(38070700005)(86362001)(33656002)(478600001)(110136005)(38100700002)(122000001)(55016003)(186003)(26005)(83380400001)(6506007)(53546011)(41300700001)(8676002)(8936002)(52536014)(966005)(9686003)(71200400001)(7696005)(316002)(64756008)(66446008)(66476007)(66556008)(5660300002)(4326008)(76116006)(66946007)(2906002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NUZaQ2VNSDQ3NVFhaGtvQXQ4OFU3ckorenJFR2NHU09aNzUzSmprRlVN?=
 =?iso-2022-jp?B?YnZ6MFNmLzFCaXcycXVxeWNYbGJoR0hBYy9KNCtrQmEzR01rVURmWVV1?=
 =?iso-2022-jp?B?d29VWEV5eWZ3L3FBUFg4SjBXKzVKMzQzNzVyQVBKbWFPOGUyRGhsMmZZ?=
 =?iso-2022-jp?B?cEhEZFhoRzlCWXp2WG4vVkdkdUk5OEk1RTliN2Y2bDc4dkVZeXUxcDR5?=
 =?iso-2022-jp?B?SFpZckJ2RWQyc3hLTmlyMzEvSnprdytwL3R4WjArZGplcmVtd3FtMHoz?=
 =?iso-2022-jp?B?L2dBYWZZYjhIN2o5eTlkQjArclU1N1ZUcnhkMHA2cjhwQllkeDZxT1NP?=
 =?iso-2022-jp?B?UC84VmVSTDRIRFIwb2JSRjdXc2NSL20wcjdndm1sTG00a3g4WWhmMFRy?=
 =?iso-2022-jp?B?Q21rOUMyTW5tb2xJcmRBbUZ6TnpDaldneTk3NWROUmMzTWt0WlBiZUNy?=
 =?iso-2022-jp?B?WWduKzdJRE5XdVFxWUhhT0xWS0ZwTG5RMjFUb0ZpWnJSNnRlaHFEcVgw?=
 =?iso-2022-jp?B?cStGUkhZY0hqYnFCbVNqZDRvUGNpTXhmbUZoVFgzL1lETzg3UUVpc2k0?=
 =?iso-2022-jp?B?TS9qR0VkNkZ4SmV5b1Z2SVMvVTA2UjNlMkxwZnFlWjcva0tRVFp2Ny9y?=
 =?iso-2022-jp?B?bW9LTlpNQlk0MUJxdW05UFplb0NXczhycjh6eFVXdnFISjVrQVNRZGEy?=
 =?iso-2022-jp?B?L0FvckplM2pTeEhsQXlxeFVCemcwU2dSQjBOc3RXN2trcHNabTlmb3g2?=
 =?iso-2022-jp?B?aXBja3pVTUkydHFFdGZZakR5NVgvL1B0cUR1ejNEeWpwb2hVZjhrNldY?=
 =?iso-2022-jp?B?WUpVZ016ZCtsK0xTSHBiZC9GM1BsSEt2bnZ5RzZtT3hPTXQzTjBhV25I?=
 =?iso-2022-jp?B?dG5OcWR3K1NTOEpaRjI4MC9HUzZZMVVWeGxOcVA2ZkdnRnY0OU5GY0c5?=
 =?iso-2022-jp?B?SU1GejFUc2RDWFR2T1pUOW5heTRBYXhNT1ZMY0Y2RzNrcWVibllITFJV?=
 =?iso-2022-jp?B?Z2tOc0hlSldteG1jT3c3UGRpc2xvUGNHRThMellTRDlzSWlEV3ZXcHU4?=
 =?iso-2022-jp?B?OFR4bCtBU01MR1ExVkJNSXZTM1hxU2ZrSkxzVWpjWFZNQkJLWXRwUTR4?=
 =?iso-2022-jp?B?RUZ5Wjk5RmE1K2x1YlFkeWk5ZmEyc1Mrb3RpR1pnOTFGbitVem1rYVc2?=
 =?iso-2022-jp?B?QXFUdVg5dC9xdVd5YitIS3FIZElJeCsyK1BNdkp5TElNbWUrUUUyRysz?=
 =?iso-2022-jp?B?RWhGbmZ5ZVQyQ081TWlYUFNqcWorYTZ2VnZZTWZoREhQZlFEYXptTDNC?=
 =?iso-2022-jp?B?Nml4dkhvR2hEcG9NNkdCcXYrMzB5clBQM2ZtZHcxRFVjdDhOdXNaajJJ?=
 =?iso-2022-jp?B?dlhteTdDVlBrZ29mc1dVLzBHVXR5Mkd6amJEaWQ5OEhoWVpNRTV3ckpG?=
 =?iso-2022-jp?B?MUJnRHRwRFRveHlaazR3eFd2WlJRSFB2SjlUcTY3NjZmTkQwdVVPRk9T?=
 =?iso-2022-jp?B?SUtrWkNFSVZsYTEzYWU5TjBmd0c0eVZnQzY2YzVkTnJpSi9hbHp4OFUr?=
 =?iso-2022-jp?B?T3M3VGw0NHVLQ0VnR1ZGNCtGdG9MS0xiZmVtVDRUNVdPcjZxVllUYVps?=
 =?iso-2022-jp?B?eGlmczNMekNoTFpYQzd0MU9kMWI1NDQzcGUwekNpbER6azJvTmFMSWZy?=
 =?iso-2022-jp?B?ejd3U1k0WGhlbXdEUEhaMGlYK2xWamNGU25oaithWXVmRWY2b0hZblVE?=
 =?iso-2022-jp?B?UTZZY3BDYkRxb2tmTDR6WHdXYjBJSmY2Y1FXKzFIZ2J2M0NCKzlqQlZ5?=
 =?iso-2022-jp?B?OUJqalhIL2tCUnREKy9xaElvYnBWV0dzWDByMVYyT3VlRFdlZE1EVTAv?=
 =?iso-2022-jp?B?bXFVc0MyK3A1bmZSa2pJVEpHUEhQRk01bEpaQ3Y5VFM5ZThsMDJVRHM4?=
 =?iso-2022-jp?B?ejVESU5vdDJUekNJTFlhT3I4ZmxqL1pvWlY2UUkvQUxmSlFTbWIwOU9O?=
 =?iso-2022-jp?B?cldDS1B1NEMxMkE5RVc5enhCNlJCd044bkM4QmhOekFDa1VOYkVkRXBD?=
 =?iso-2022-jp?B?TXdXbGo4MjlDd3RSMzEvY29vVEkzTW42M0liRUYrejR4R1g4ei95YS9n?=
 =?iso-2022-jp?B?S0llVGZqUG9nN0VJaGlUaGt2L1hQUml6OVhxbjh2cDFsNlcvOTFDZUR2?=
 =?iso-2022-jp?B?aDhIMlZCNklUTE1NemE1TmJOWjgrRVI1dThTVm9Fam5yWTN5TUZsKzY0?=
 =?iso-2022-jp?B?SXp6S21vTHc3SXh0NkxSTEpOYm9TWjhjZWdIaG9uQ2JHUWZzLzFSbkdl?=
 =?iso-2022-jp?B?dE5xN1dzOHU5ek5xMDBGKzBCZ1FSQ2JldGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5ELzGxo2IDIVSRnS3t8qGmEvMhwNsxQ8mjWdv2Czq+o02YTtQnNCuG5Ri4LC2snrBqjTIJIjTwyyU0SyEaHyPa89a/UFr7JLqh+MWkmU2dATTlYRRxDxpKweYFuuz/7+Clxr9CKLvTbd6q2tLiQ6UV7FX1mYZ7EGAq83joL7ONuWyyw9Uf0ro+XMojbAd/ImSpcWwSpaRxQoOMH1XP4c91D65VNzYEMOD13AyQMhuJdocnhG0omgzjbdrCQLl8o7SP44G/6mKp9ph6vYIr5j9m0Uzam2tGrh+j6kQ7kucgAZcJ4pJxsMIPBda8P+QAHlNt5uEqAD3XEu5IE9Byb3cs9QW9j4xZDMW6PcDNweWWlRteL75FhBy9gGdm5x2MWiO18sKAPYGQnvRsBnH/kN2gl1RfNPcazfXw47Ntwc6eOmP5vHZkcxsRKDSw60aGNYlv9ZBB/LaWcMlZaMobHV+iGBITq02EL2zW041SKhuiTDzLdKt7vvwG/asugN3ZMzxT4JD8OWlrfGZQ9IH7febj6j5o/jgsstRJNNir7emM0Wm62C4UDKom6cW6E355TLSUWzEHFtvBNA2BAriUe5IZYZlEX2iG8qFM5FPMSfTAyjJTWVDUQZJPwIGdSDZjQhGGfEgfLYGYcPC+h5JX4XnlnQsnKBG8AOrx0srtTxCUXfU3H7nm4E0tv1HK5TNpzQUrt0xL8xRl0DmpWLe5x4KspWfm/WiriPibnas6uwKDxCsjLQrdw7L1STd/47bLDeyXOKbN5sdAo9z1XPjwP5kacMJ8thv6oMahc1p+R9Rfr0xy4ntuCZ43tUyvk4dJSeL9ewKPbgugRsv3En6ExJe5SlxgKj02/BQ5pW/1iosunvLd3ch74K7ih0jYEQr9it
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed550e5-d91b-4687-9619-08db93dc83e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 04:45:51.7598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dyTrlJrYTKYJJRFAsNRcFbecnMkQIOOmCEBwOYjt/no51+zIbd3X+9UQloOEhzCGD6MHMynIjQqNI33Uiku8GzUqub7o2o3ekCp+JqF7NxThajVvLDS9lktXqJc+XLkC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7943
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Aug 2023 04:46:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12543

Hi,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Wednesday, August 2, 2023 11:49 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip] tty: serial: sh-sci: Fix sleeping in atomic c=
ontext
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
> 774762143f4e..cde5f8bf4111 100644
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
> --
> 2.25.1

LGTM. I can apply if there are no comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


