Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E27C001B0
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 12:34:09 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.117])
 by mx.groups.io with SMTP id smtpd.web11.159279.1692189244287933331
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 05:34:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=QybaW4i0;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.117, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1Cn+CaK86gVf20VQowRANjCN2RNomMoxlmqA5NXYWXaQjiF9YPskKD65BOSf3nOtzWjQdLc18/uDGW2zGIn6fLBsXtAjjHTF/QJ4cB9P4sZdJGNd2t6TIrO0Jsdyd6XqWdNWnaKtPXK7cmyYtXQupUFeb36leZEqdW5LBP5zl+7FQVapKK8V2DX9HQ059waNhuRqAtaydVpQF6zVieSIhfs8mo3td7oWgvRu+UNqbJufNdR0Z/DTIWsRmGFyCiUKN9CsLl3l6LLuaxUSWeSQ2BRHixGt7rTPIj0lnjWc2jhGxbkXurk8AEz6H1AF8dsqfRK4qSS+P3JKoCpckPDWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyhhqJ3gEpjmrkEBurrThlLH9DkVvD0qwLG0uLbhVqE=;
 b=NvPQa1tuK7olycJGPAusuXLA5Mh7cJhVRgEYXs7I3tD1fwwpsZ+0v4nwghnfQc2ib/3d5tf/f02Fw8m+ZudlGe+/0NIm7X3DmLrSkfSAoJdxJX4lTts1tVrbLe000F8DKWTgFYyZfuwtVmSlJyuGpj0SOhm3ROM+IVK6N3SEXFd3x8ckgWAtglIOalOMN/6RfUFKpUiiKOGcJ2WItnL2qjOF34uQnshzi7vma4GCJB0M5nmd/F1Yf0j7NbFMZotR2FcCnbdXcaKrou7/JICdfaZjjyA6K/4i4ERceQ7THqJjVstOdKm2qlrgty4trGqmkdTbJZCONMsuwfX2AWJQ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyhhqJ3gEpjmrkEBurrThlLH9DkVvD0qwLG0uLbhVqE=;
 b=QybaW4i0/GOjq8LcEC9mpcn3Z6YqimeORjAQ7CzBYZ/7qEhqAE0XklJtKEuUcf6auZ4rM5v6X5Fs+VgpP8ABHueQoWSvVB/Q8uPq3JcWRtjvOXS6R+PAxzISIUwy+8ecQnPzuNISozNjFQoXaqvsJpC1HELVXwN+n42FWZ6SYNQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10709.jpnprd01.prod.outlook.com (2603:1096:400:2a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 12:34:00 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%6]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 12:33:58 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 6.1.y-cip 0/2] Enable PMU support for RZ/{G2L,G2LC,V2L}
 SoCs
Thread-Topic: [PATCH 6.1.y-cip 0/2] Enable PMU support for RZ/{G2L,G2LC,V2L}
 SoCs
Thread-Index: AQHZ0BEMsgovoFgZ7k+GcYNZ65IWWa/stKAAgAAm9PA=
Date: Wed, 16 Aug 2023 12:33:57 +0000
Message-ID: 
 <OS0PR01MB5922F41AB4AD16AA614B5A268615A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230816071239.3310-1-biju.das.jz@bp.renesas.com>
 <ZNyhaqoh6F7UKe4n@duo.ucw.cz>
In-Reply-To: <ZNyhaqoh6F7UKe4n@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10709:EE_
x-ms-office365-filtering-correlation-id: c16a4140-56f9-4e5b-d1af-08db9e550fee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8y+slzkiiweQZGqZVIf0sxDUxW/7FSh3P/BWuZIHsMlNYYbukB9UNy5d6q4BP+AG4FGWjDS8lwI3TOjKaC283wEIAeUjAd86XhmYlYvG8ZfFhRNYBQ96goHCCQlySufG0YAdTBBgQd4dmH2j3gLYfIfGLCnm0mYVB7oB6UppxxcQG3HdwuJ3w90bi1LLw0lfOGRf+Z0ZLcUEwPY9roqfH18L1XaKWy/fGKV0xPGflil755CXk/gvd5iouqgrrtK4Rm+2paKbZhhGCl9kX3Uq8LR1cDgJtnUY/nofxawKebhFBIZoiHRkHEqDYtjy8Lx3wkZN882mdhaZdz10q3D0tMENgfUkvOJJjfYdE98lUndea6aAJSvEurNmQd1zJDB6AJS5rnFk/YRwzT7p7Pn1NOfY5rmtfPL9kk9vQuXJN6474/mlk7HKscqr8ucQFaeI6QidFNS0Z4EGfwT6VL56pc78gPazP9UPLLJucQWLNV0wNmDhIOaCjmv0fy3+7lcHVm7TRAmZJV/peFjR2y5k3RTJ2OidyztCW/73QZ/7fcBM+9qLMHY8xq7u0KJ00a46KOi7oh8VuhGK42UcQg9ULqItvSeXV2HTiEGJoaAC47zrwnNowcMj6vvj3p/HbF9R
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199024)(1800799009)(186009)(2906002)(4744005)(86362001)(478600001)(6506007)(107886003)(7696005)(71200400001)(33656002)(9686003)(26005)(55016003)(5660300002)(41300700001)(52536014)(122000001)(54906003)(316002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(8676002)(8936002)(4326008)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?ifnDYZJFytrWwiprKfvljsmN93eOQGUQTCIHOiM7g6xoYhgghz8HD0vEwtqQ?=
 =?us-ascii?Q?bHJU5a109GaSkxFxvW8W2znAy+nArs36enKaEaMq0gPFqPYKyN/pPLf1KYxt?=
 =?us-ascii?Q?ztHf/GpU0SqcYFXEnc30vly7F4AO4XvUZfiGZb5mecB9X/PksXvHaViuDvFL?=
 =?us-ascii?Q?sBHsVEijyunnwMws2xHr9gHIDBFq6G7SgBBjT4CXDCOalHjyvR9augCqUsiU?=
 =?us-ascii?Q?0bdoYBNezByQEIu+LaqqT5u2pHiVfV2RZo/2MrRPPbc2qIuNmFTOu12cFb83?=
 =?us-ascii?Q?lbygU9OiQwhF6BuR8uAxmylxeji74iurULTh1FOisJpeBWlUq0oxHcsqvABw?=
 =?us-ascii?Q?Epf7O49BIHJSAJBHz4VDKzoY8tRcprPoEdi9CTXUrz58DAGHTgenZRvuRhi/?=
 =?us-ascii?Q?iR5LK1GJj3/GDb9Bu+hYXphSNYQQFwfSEWB2BQxjRQ2tpJCnUCWW3XmYejTs?=
 =?us-ascii?Q?kqD67JP/xumybM0Hfi5UW0863UmJOVxZEatSIchZCZ9PZMaWMabnMIMKLapY?=
 =?us-ascii?Q?GZn1qRzcdPzfteZlORSfv8Mc55dntjGYL9G+HehHLmdpImqTJ7s1Urt/tKkh?=
 =?us-ascii?Q?Sjw4ozNwpHaLMmxYPkSbHssfVin300rqyubHTdyy8uWf4L0eLRV2lAnIGelG?=
 =?us-ascii?Q?1YqnRWCbQT7rgO4DqPrrNXq68MCaGcYRwcPGKIY72gzqsfl5XnuNFmltL7b2?=
 =?us-ascii?Q?d6+iY1XLqvl35+hHI5ClS6Ik6LlatIINHBz1mbY4cx9vtp9gEeAL3iFjasiQ?=
 =?us-ascii?Q?WwmitizQY0vhkeqktvfK55XZK1kU85p8IXse+UOkV/g3PtHxV02SDUEeJX7e?=
 =?us-ascii?Q?z6afj4O/YJVpwqdJUAf68X05gMTRO+wwkfRvQ67GBlwwRmi5CjAGZyUEMt50?=
 =?us-ascii?Q?6p2l/1jgafove7P0nCGyVRn5Y14HJCBURv6OEME2nfDts1cBqDp8tL1EWKLp?=
 =?us-ascii?Q?L1CU6o1ealbc3Y9bxg9uTP/Hauo3/cW/MUK/+oCf3EqAsOmIgqt7BO1GiT2S?=
 =?us-ascii?Q?UjHzk91s+GJd2re+G65Ci9pLIUtV1SnmUu6WYvpVc4bgMgNbeU2BAAwcUQki?=
 =?us-ascii?Q?qSGPgENOrEH417G+bpg1IbcHzCtVK6aN5J5A9vNsA8m+EC/DYnLpu8ToVsG5?=
 =?us-ascii?Q?5c4HuMyNi1mwoQfuyXYFG3q/PbKSqd5e6MrSimt67/P3mxSuJqym0Qh0m2Tf?=
 =?us-ascii?Q?X49xKEINTYzoARzjffguwDTZfXifIyDVC6abD5l3YOKVkG7Vxgn9HdIgg8G/?=
 =?us-ascii?Q?TIn56RT9fZ+8aOQhK4YHzGiAhXBMmk5w9jOz8KUzUDDsowp4YIW/4p9vr5XV?=
 =?us-ascii?Q?GFp5we2gyYtFz3MhCE61pJbgVBnxr6KKhc1N6MYeGue3JWmTVQPnULMD21gN?=
 =?us-ascii?Q?H99/y3r5ebi4wmNNGfsH88NawCGfNUoQDdW7lKTK0KVuQzCcC+F/agrIWAFE?=
 =?us-ascii?Q?uMSU6snse49Ao3TTP6UGaD3DqqhSqgkP6bwEQexLJ6M3Abe/jj1C76QFll9/?=
 =?us-ascii?Q?93qXk7xRWUIarUs4u5u+4wUnGuY2HoZowU5gATyQ0E4IBnnliW0giAVrnFzw?=
 =?us-ascii?Q?e0XjPA27iHcE6D13ms3oSLu5jfGwrWPLSK+4K+VW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16a4140-56f9-4e5b-d1af-08db9e550fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 12:33:57.9540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YB/kuSCZFt6PCAOpXQb6o73JeTRqiTfe0KqebVCiSxACMQOfbPUrD87ysyHP8bKe2g/S9NfgqWKjBtaucOw7MPEIPsLq6RyDRARJPeCy5o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10709
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 12:34:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12673

Hi Pavel,

> Subject: Re: [PATCH 6.1.y-cip 0/2] Enable PMU support for RZ/{G2L,G2LC,V2=
L}
> SoCs
>=20
> Hi!
>=20
> > This patch series aims to enable PMU support for RZ/{G2L,G2LC,V2L}
> > SoCs.
> >
> > All the patches are cherry-picked from the mainline.
> >
> > Lad Prabhakar (2):
> >   arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
> >   arm64: dts: renesas: r9a07g054: Add Cortex-A55 PMU node
>=20
> This looks okay and passes testing, so I can apply it if there are no oth=
er
> comments. 5.10 version looks okay, too. Consider sending both
> 5.10 and 6.1 versions in one email in cases like this :-).

Sure.

Cheers,
Biju

