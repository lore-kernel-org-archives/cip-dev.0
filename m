Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9AEEB64DA
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 00:19:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.10564.1688602792216550106
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jul 2023 17:19:53 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 3660JisD601166; Thu, 6 Jul 2023 09:19:44 +0900
X-Iguazu-Qid: 2yAbYAYqDSG9dX9mTK
X-Iguazu-QSIG: v=2; s=0; t=1688602784; q=2yAbYAYqDSG9dX9mTK; m=CQivzQOGYa9hDIpQ5EQ0DMzQwrfmCk8H/JCLV3q8CQY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 3660Jhn42903205
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 6 Jul 2023 09:19:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmJ+3fjJX9e9fkSBkukianDMqTHNgl7TdThUBN3DoE2PjBNyGODO5BPN7sUJe+WOGq1bz4zqililvG89VCGlcMTYCG7vlkZggyA/25SYvsGa/GO48GIGVtnv+2/1NT6HmYCjMIeai4MghQMhLc9b/E8SHGAUssJ31+Qf4++z1RINqrZv5n3ZyFgXYEBubzhI4/IclJ0jGXKUtwynDjxSunLPmZxWAAT/2LC+Hd2XjJ+CfOc0Lp4L4+NC8iBm24rX5r4qua6Dx6MIqoHI897owAW4XzvYzdi3lbQfH+2k6IoK9VTfci4EQgz5xtGTI3gXLAhdjRvBnixLJmcj7dY4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pouB5wjHlxEvvI7KyUWxDpyqdg+qrlyEmWBKJL+y58=;
 b=kuLSyxsFcbGakyf+RgPKTBbeUy7Iyb4OOSs8zbRYolWXTTyAXy+eBOQumIzBnFOAjUJMYc+qjFJr4sccXsusjHiF2wZcC6kHaJmXvAaTjPxHgVumncVWsbTuIznyjGiV03UrwldI6/yLVkyEQZiFBNV7JQYZVyebmIQ5pTeKjhBGW5OqUGQCSYPq0lYhmiSyRf2EnccVWUyNgz7dD3n2OUNF4NN9rsa1zH9Zvf8LA0NVVOGlZ84c5CaTQxGmKB0tP0KpQ3LE668uYv1i9sF9QNONnF9kHCAlom9Zk7+sZM+1Ploac5PLtP2BWEslwj6+2/Mjws3/cBLJVtuxutvwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <biju.das.jz@bp.renesas.com>,
        <pavel@denx.de>
CC: <fabrizio.castro.jz@renesas.com>
Subject: RE: [cip-dev] [PATCH 5.10.y-cip] usb: gadget: udc: renesas_usb3: Fix
 RZ/V2M {modprobe,bind} error
Thread-Topic: [cip-dev] [PATCH 5.10.y-cip] usb: gadget: udc: renesas_usb3: Fix
 RZ/V2M {modprobe,bind} error
Thread-Index: AQHZrbFF+m2QbdxmAkWLIT306ZCjZK+pBfdQgALdm0A=
Date: Thu, 6 Jul 2023 00:19:41 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94208D921A8950BC0A3CD6FD922CA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230703132113.353419-1-biju.das.jz@bp.renesas.com>
 <176E900B4C685A01.1228@lists.cip-project.org>
In-Reply-To: <176E900B4C685A01.1228@lists.cip-project.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYTPR01MB11001:EE_
x-ms-office365-filtering-correlation-id: 32e58f57-4b9b-4404-042a-08db7db6b126
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /zbRLIl8yGcfXXiEeMb90KUkArmUbkpqPljCD/AcKahavvfm58CkxggKhWKMbjPu+i9cEElBGyPxH2nAZX3JZUPmy2PEnqjRmr7yKv3lwDMYlYl/7n6ryGvDb4TVSBGvHdtfKy7INH4yI0RPuNmAYomwpMG4AwGwkohx+akrMPcFrt3DhUW3zWdp2QOAQOs+eLa/0i4AshwIQVMYZTOdC02O6g8n6iodDz6ZQ/47cnV0cFoqPx9ipcjRi3CK/qN9CX/WDFftGnDUj8zxS8/PkINj4R5uCdaFejgcHW0RstS3qUIkzrsu/dlDAeuivkXDJ3K9BO0E6O3u1fNUODcw7ERntJc2uhxAswcPxY0DEjgtcivgncNUXmxQIPMiSC+AZTo+0lGDzDfzpdGLK76vNFYnTdy5u/yI4Eod/nrn8XBMnKJbcFKby0oRUpUcSjBSrVfJVFKrTzhIOqTy6QHa1hl/pDHjFkTwxejFn1ZhrStWq0sNJ0SWVVKV1yCNdWm6hSM9fz3WmQNbix/+0+NhfzeGgfVKUItRmqMV2wJ6aNhFUTmacTYx79ZjQTbfEX28TxZ05L5VJB3DMKZo/2ZL+6SphdoQcPBYzUzd7etz6OO6aEB22U9jvpbIHpkY5J222+JntOYOVg5MjK1k3jPQxQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199021)(52536014)(2906002)(8676002)(86362001)(55016003)(66556008)(64756008)(8936002)(5660300002)(7696005)(110136005)(71200400001)(478600001)(33656002)(9686003)(966005)(186003)(26005)(122000001)(38070700005)(38100700002)(6506007)(83380400001)(4326008)(76116006)(66476007)(66946007)(53546011)(316002)(66446008)(41300700001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?d0Q3QzlPNzMvRUlsdzQ0V1U3eGZZS0pTQlpKMXF1VnFyd3o5T2Vha1BN?=
 =?iso-2022-jp?B?aEtBODRlcllGT1BKazRsVnJFVjdwNVF4aWxGanVFVXVsYTlCbkpLdjlY?=
 =?iso-2022-jp?B?NGMzNGIxY0tTWDNLQUhYR0hTYmZKMGE0TGkydHlndHIxTldqa2pIZ2Z4?=
 =?iso-2022-jp?B?Q2p4NCtmdXh5eUI0TUwxREE4M0oyMk5uWVRVajNEZDcybTN5aVdTNGhx?=
 =?iso-2022-jp?B?aUtzbDdISS9jcXF2Y1BkdXZ2MFR0cEtRdjdCb2tiKzdvdjhuVGg2MlRL?=
 =?iso-2022-jp?B?ZGlLWXZSdzNXUVIyVU03cGE4ejhaeXZ0d2lRWFJhbEhoUXFzTUh6Uzdw?=
 =?iso-2022-jp?B?OGs3ZkMzRXBIY0RkbHpnbjdJK2M0bWdZMFJsdjN0Nzh6NmpZQTRITTRo?=
 =?iso-2022-jp?B?dHREZGFjZXltMmJQUXJ1K2FVVFJyOSs0UGFmZ0ZzdVEvT0NXRUVkSEFm?=
 =?iso-2022-jp?B?VWVLdlErclFzb3MvaXk3NGxFWjFBbGRyWlFpV3hkeHI0R0h1dFFtbTJI?=
 =?iso-2022-jp?B?N0JjTTMxM3BxUkpOTDFNL05Sc1ZCWXRSeDRzSHNZUGZSK0NHVkl4UWFj?=
 =?iso-2022-jp?B?UW10TjdTeGpxZTZNeStLMjR5NnBxSCtJaCtVSzNBN3VGOGp5OTN4Z2Js?=
 =?iso-2022-jp?B?Y0xjV2t4bnVOZW1nbEpZRURhZWVkZWZaMXhhOWtnN1RtaVhpWE9tUTFB?=
 =?iso-2022-jp?B?NmpCNTI0OUVPY3UxS20vMUpWS1pRdFVhWWZYR25PQW8rUUw1TFZiL0xO?=
 =?iso-2022-jp?B?aS8vaFBTYk55QnF5SGFoNmg3dGhFeVVSMHNkS2xZTmhEMGJsOWJNelZm?=
 =?iso-2022-jp?B?V0dISXJSRmVjdkY0VHNqMXU3Z1pqSFNQUy9yNDZhOXl4SlJ4Njd6NkFY?=
 =?iso-2022-jp?B?OGFWTkVkYUpkTXNFL1FTQzJBeW91cGZvRmlOS3lDWkRXbGZZME1xN2Vi?=
 =?iso-2022-jp?B?YzJyVWN5RXV0YVZMbHZrY0wrYzNYZUN4aG9MTGF1VzBHSzdUUkNTVGVj?=
 =?iso-2022-jp?B?aFR2b0lxWEt3emREVkxTcjdiZDFZdTZqcW9peUVjdnN1dWVkRCtFRjRP?=
 =?iso-2022-jp?B?ZWZoaFU0dzdoclkrTHJNYmVnR210aTVIak5uYU43dm5ZYWtpUTl4bGVZ?=
 =?iso-2022-jp?B?UVk1N0VyNHVSOEFac3VQMk5mSzhxa2t4anZId3huaGRlbzlXeTM2Qk9F?=
 =?iso-2022-jp?B?cnBmSjgyT3NsMGh2N2Q2WGVYekxkbEFENjM1NkxXcTZnSDljcEZiVlly?=
 =?iso-2022-jp?B?aWRGb0pwTHlxWDZ3VzhtQTUrS0lSbFgwdXMwcnhJY2l3VW9WZG5pQnhM?=
 =?iso-2022-jp?B?akZKUEhrYW8yTDR5LzJFU2U3NmJFTmMyUmdpMDk4OXVKcEk4WnpNK21m?=
 =?iso-2022-jp?B?alNrMEs3bTJFcTF4V0pGa1dhU2ltd0paLzVHTnZkWGw2MUc5dDRJU2tF?=
 =?iso-2022-jp?B?N05NTmNLL0FMMzhNUFNPZkhYZGNtcnY1VjY4ajRFRGplcmRGS0w5ZVI5?=
 =?iso-2022-jp?B?OHlNWlREd1RDV256L2Y0bVZmZHpOUHN4NFNlNFpoT1JwY1huMnRqVkRR?=
 =?iso-2022-jp?B?QjZSNnlBdld4UjhlWFFjVXZjTHN2ZmpPU2pteHFvTzh2S0tTTXVsVnhJ?=
 =?iso-2022-jp?B?dFlUbnp4c3VpVjZmU21hS1A4dWxSVkNzNWdSR252b0o5ZmRzYy8vbVQ1?=
 =?iso-2022-jp?B?UGM4eWxLTzZZYmlqRXI2dXlsNkxONHZVdDcxQkQwbDFscVRpb0xHS1pi?=
 =?iso-2022-jp?B?VURXWHVUejdLNVFyOEJXcDVDNnV6bWdxbHhZTWxob1p2NTFub3Qxdm0w?=
 =?iso-2022-jp?B?czBzVjBQRHFnMWJYSGs3Q09SdmM2TU9HWEs2akNNa21hUmZ2WmpkOXdR?=
 =?iso-2022-jp?B?ZjNvdnd5azhWb2cxajZXSnBrWTBzNThoYnZJa3hlSW9DcUpQYlhnMWow?=
 =?iso-2022-jp?B?WTB5OVJaNkY1bmNpcnVXZSs2ZUVKRTVSTUR6S2V2Y21jUm5HcHVvcEZz?=
 =?iso-2022-jp?B?QVB3dk95MllDRko5UlU5aW12Q3ZLNzh3K0QwWmZkOW03aTJlZ1k0blVY?=
 =?iso-2022-jp?B?K2dsZ1FLTHlrUTM5a1FCQzBlRDh5M2FLUFRtS2FXc1g5SmlZQUdXTm9V?=
 =?iso-2022-jp?B?MHZ4SElPZEozK0VGK3k5Ti9mYVBNQWRvWGRpK1puWDNDbjlud2tPbUE3?=
 =?iso-2022-jp?B?NThpL0JGZ1RMTDNRanltKzBSL3Qxc3ZsWC9nMXJwL3IxVkczWFMvZVhK?=
 =?iso-2022-jp?B?WjZFYWJaMEdyeVRwL0RSN0IzVzBlRkgwUjFZZzdZRDNXV2UxRVpQWW5R?=
 =?iso-2022-jp?B?V3MxT24xalpXNGs3R2tQVC93OFNOQ0Q2UXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HVxqhm8MdS+0vQLabohRvZ76FFmqRWvcWo9OuFJuGlJcc85iRSzsppSBbRSFzWjSx9fbx8c7rRAYqZ0CacGpSwJCvfrrjrs0Ut3qQiAdhFk1tz21+NgKQTD4Ll2+yPpcptoVW3hLK50zwFIvz4+ampM42fDV9E3jQVsz1hWRhphYlGqgLwaMbBpDJe1/ydy0NUcQCfiNSiyOAM3+su9sxoFzGzkcZYK5uJ3bfj/1WPZF3lq8LlGB8T4IjtoAE0uUsNAxAlIrpA14zWOPOsEuPz6U62xij2pwWG9vFxakNclvZob8ch4xUaZt6fbN7SEwrHyMKEp+/6DsxP9lNprxl3dxiU49TOcCISqHdHEjttN6RDQPxzcRVbJcJ0chCJStzrMmIPQzvtd1ajsLSqHhRUL8CdR/bLmWQ3cMB83sc+TOY17ZfhyW0cAj/nvUxbLbHGH6Fa2kUueSO3b4wykNdsB2/6TI4h3Kd/BE+sOKyWB4jHSI2f3s16wa0uO+ZpdfduPhurhAzyYq1SIts/apcuFCIr/bMkBTIbKBfzdpdf/HnCyEr6pE/t4wZCR2M+3JafVTKXPnkoAK78NyXWKoTmKu7w8zIPjsl/K7KTSeHN28mnuwqmVM3zfAsZSXa6Zjo0vCPRtVmzKP9aJIj1IUlR8+UqQRbYR19oxjcYyIGix9vwN9kr9AqQV8amvSCweIdnsZPr9sdt2HCELZj0ZDTb6aS6ZywEMB3GeeQ4zdP7Zf5FHc99JnxhTXqjm8mIJpAA47ntsRzMuvgl8hj/+QtN6xlteNt7R8uh+mrktoKx+T8wMknMzG0CTQFit6Xp650GxeJFN9+vrGwbCwGOXHAX0g6ikCilQkPOr1G7rN/9WTFHkQqUi42GPY4e/bXHWQcO8VRTjdRaEcSDmC04uwJA==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e58f57-4b9b-4404-042a-08db7db6b126
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 00:19:41.2079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gbKsVUgSFfVjJnk3NuGA1n6jLxvX8CZ1F4dXspHD0N9aN5m9wQ9bN8uGn2H1e3wbY/0Dm2xX1vIBnwYGU+42/E8NJqWXFysPIPbHCtxzS480BmglqHKNneYhY0itlVIi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB11001
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 00:19:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12238

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Nobuhiro Iwamatsu
> Sent: Tuesday, July 4, 2023 1:35 PM
> To: biju.das.jz@bp.renesas.com; cip-dev@lists.cip-project.org; pavel@denx=
.de
> Cc: fabrizio.castro.jz@renesas.com
> Subject: Re: [cip-dev] [PATCH 5.10.y-cip] usb: gadget: udc: renesas_usb3:=
 Fix
> RZ/V2M {modprobe,bind} error
>=20
> Hi Biju,
>=20
> > -----Original Message-----
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > Sent: Monday, July 3, 2023 10:21 PM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> > =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mac=
hek
> > <pavel@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>; Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com>
> > Subject: [PATCH 5.10.y-cip] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
> > {modprobe,bind} error
> >
> > commit 3e6ac852fbc71a234de24b5455086f6b98d3d958 upstream.
> >
> > Currently {modprobe, bind} after {rmmod, unbind} results in probe failu=
re.
> >
> > genirq: Flags mismatch irq 22. 00000004 (85070400.usb3drd) vs.
> > 00000004
> > (85070400.usb3drd)
> > renesas_usb3: probe of 85070000.usb3peri failed with error -16
> >
> > The reason is, it is trying to register an interrupt handler for the sa=
me IRQ
> twice.
> > The devm_request_irq() was called with the parent device.
> > So the interrupt handler won't be unregistered when the usb3-peri
> > device is unbound.
> >
> > Fix this issue by replacing "parent dev"->"dev" as the irq resource is
> > managed by this driver.
> >
> > Fixes: 9cad72dfc556 ("usb: gadget: Add support for RZ/V2M USB3DRD
> > driver")
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Message-ID: <20230530161720.179927-1-biju.das.jz@bp.renesas.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> >  drivers/usb/gadget/udc/renesas_usb3.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/udc/renesas_usb3.c
> > b/drivers/usb/gadget/udc/renesas_usb3.c
> > index a1e8669536d8..bcbdb6b2a8d4 100644
> > --- a/drivers/usb/gadget/udc/renesas_usb3.c
> > +++ b/drivers/usb/gadget/udc/renesas_usb3.c
> > @@ -2898,9 +2898,9 @@ static int renesas_usb3_probe(struct
> > platform_device *pdev)
> >  		struct rzv2m_usb3drd *ddata =3D
> > dev_get_drvdata(pdev->dev.parent);
> >
> >  		usb3->drd_reg =3D ddata->reg;
> > -		ret =3D devm_request_irq(ddata->dev, ddata->drd_irq,
> > +		ret =3D devm_request_irq(&pdev->dev, ddata->drd_irq,
> >  				       renesas_usb3_otg_irq, 0,
> > -				       dev_name(ddata->dev), usb3);
> > +				       dev_name(&pdev->dev), usb3);
> >  		if (ret < 0)
> >  			return ret;
> >  	}
> > --
> > 2.25.1
>=20
> I reviewed this series. Looks fine to me.
> I can apply, if there are no comments and issues.
>=20
> Test:
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/919946031
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
Applied, thanks.

Best regards,
  Nobuhiro=20


