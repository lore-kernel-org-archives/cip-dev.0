Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87612C77B75
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 11:18:21 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.115])
 by mx.groups.io with SMTP id smtpd.web10.8912.1682075897879166653
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 04:18:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=l+EjS95V;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.115, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tho9APkaiSKHbp6vtGvZWHH4vbyDjNsTLa6Q86SBV8ZZ0zUNe4Cp66MKwevNw6k54JGcibehK+a7fc5r8RXIt3Da9grdbxPYW+w7/LoxTbd+sL37FmDMLx1Egnll1OES0c+kNt5NvMZHEtnVpGTuumAZsuA1M3+WSajSPGyr4Ftt9q3HvTfy2MN2b2xw0CgB3EFRk59vHlsdskRzTU27PgbqQSp32VWUc2nqzVRNdAVsq3azQhKpIURcW4vn1WRD6HHX4HMe8kLV4+EPai7Zm/Xbq7Jn/8HTnDtOFJcLxXcxv90OqJeBrR6o66QQnE6gFruJcPsTLfxBvmPf1WFDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UG8Hb/qUwHJTg+lBvuWAxwELj8rj3SVSwgH5lPhxb0=;
 b=kCEQJ7HuQNyxENg8aqzOwvduOq8IAhfSzIVWDgoBoD3rc8QDiOt369drLHXDA+qXa5Ag3Y/pwpR4yIog95E66ECbbkNWNz1NN86RZLDgg4pe1mLmpO0zlDR3KYPIH6h1SAsTDiiLn4laNW8gl7evxAsk/FpS5g0jOd37yZUINiMJdnisV4nA8PiE42MiRoUmpCU+BgZV+darGoDafqdHf/LFw8pXamD2W1ItjH3bFRBdPjZU9TrTrsGtNhzL6VFD5eTXrbIxN9ZtNRZnSgJIQYwI1NfPqYPb6bucq10nOaDh3lBr7RgW881UfIo6+re4IysVqtNKfP/VVf6idnJ8dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UG8Hb/qUwHJTg+lBvuWAxwELj8rj3SVSwgH5lPhxb0=;
 b=l+EjS95Vf3Xl8q4xvroSLwpx7Hp8RRBqg/1QUNP5+0BRglLOxKJ0t6bM0GOD7LzWYIMPZQ8XO9YbLGAW6ubJs8KLR/wmWpqS2vjfiK0ar3guxUDBEjNpngFhjdmrB4ANue6auIJRLBsRx0q3uzUbRI72XakMdNj+jqPLsecOP9Y=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB6220.jpnprd01.prod.outlook.com (2603:1096:400:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 11:18:13 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 11:18:13 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/33] Add RZ/V2M support
Thread-Topic: [PATCH 5.10.y-cip 00/33] Add RZ/V2M support
Thread-Index: AQHZdD+5+LE7OEibuECj76Oa1j+G0q81nReg
Date: Fri, 21 Apr 2023 11:18:13 +0000
Message-ID: 
 <OS0PR01MB5922F02A188EA782155E706386609@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
 <ZEJrgRY3NwUu3j7D@duo.ucw.cz>
In-Reply-To: <ZEJrgRY3NwUu3j7D@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB6220:EE_
x-ms-office365-filtering-correlation-id: 36650aae-1461-4eaa-540d-08db425a18f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 tvMBCkqAWbpeqoj3T5a7XwNYLYoJ7CK1j0PDZZHNXuYxTJGIqXBCIuwb+WP3D1pSKw30K4/tE0KHibEcnHdf5Q2YgYqp6th1y+8eLTsA4DkKZTE34iieQixCuyZIDrIz1OnqLOGc8MfjpT4MvU4LL0LDZRBnAQycsD8AoyguN3CYGI/7keIqvdruPjarDbb+61kGFKDeWArapAjlRIAcJrXNHu1EI19S7bJeHdlT+Xb7RjnU16cWnb5OuNjTjMb51ahL5yTs9HVayM6s077MMhAZXDYL93RyjvgtHDKCP2EVWlfKzRLs7D6WSvZTIwcy2UcryHUpb3BmUsVXz8GcYaOFKbW2e/rmZ68q7MdiDifMHXkVp/NAN51zW35erVQG8/ka8Ukc3TSbfPMRAXaPZbjDmRTKGAHfgzNX3XWNqw60h9XQJUxGG/Otpe5T8ZYQXuLfOhZdkus7gRLqoQ4aKn5vRH9yEWcsDRPA5gkztqoxGBWQaJkamG3zUXJsAx6uJMP5+5Yapkw0/JYQ0Itp3k0o+Q+S6oKr57vIdMmn1YqbaKPzsiKQ0938XLZBys50Rc8u1GUaM7ufemPnVKRz3Cr+2SucN8bw2X74qt6zfibTJSPhJx7yI10ECne/KS9z
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199021)(54906003)(71200400001)(9686003)(478600001)(7696005)(33656002)(26005)(6506007)(107886003)(316002)(66446008)(41300700001)(66556008)(66946007)(76116006)(64756008)(4326008)(6916009)(122000001)(66476007)(186003)(8676002)(38100700002)(8936002)(52536014)(5660300002)(38070700005)(2906002)(4744005)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?o4bECEt2Dx/nZ1aZCbn7Cmwq4/wKNFVxTJAjazTiTV8L0jSeKNhNvWkr08c+?=
 =?us-ascii?Q?7NJ6UUN/+qp6f0XGmeI7v3a4CmE/+quWRylY1ne8C9OfaPGSdpQTeF90mJz9?=
 =?us-ascii?Q?aadrMKSNVeELWBLWqUrr064rhhltZtZZTNYllamA2Vg/3EZZkBRmqxcKDw9y?=
 =?us-ascii?Q?WraAKMpJwpawcDDmlmKq80zKXqtjF+zlamEBHWDDwJuW4aMD+fTX3Rp7QSmn?=
 =?us-ascii?Q?ycscfKZq0EUanAsHbsn2pVNtHCqPbgCsOrCWsIdVmA2BBZ6vupxlvFhODWA2?=
 =?us-ascii?Q?cIuXFCWGqNiW1p1jcLfIle4tb1POJAr60STZ43GKi8exexhcn2b9YbHSErnD?=
 =?us-ascii?Q?VuxHJ1SfPiElU6OQTgmd7yjNuXz0vjPrFBnmlYt1oaWDJNX8zt6nkQgMqq/+?=
 =?us-ascii?Q?mDlcmJ5kJQVuM6RdqdDqoE6BLJBLQw3E29zBloBrKay/GgdNWQYglAVEaDsd?=
 =?us-ascii?Q?oILjSII1vm8aZ583XyMqnycHZC4Y2LycNVSUazBy7h66d6psoAmAsrGoamev?=
 =?us-ascii?Q?ckIly+u8ibBu60JFrTSBm3p7z/CgY7ae0TLyVITHyEF3Y3eg1oaLA9kBGZf1?=
 =?us-ascii?Q?Wy6fIQTu3NSx6QSPdbWS+PFZGEkK23slRxahWD2DaX9KNQMwgfMdGJlysFDk?=
 =?us-ascii?Q?V+iZk47tK6uiV8hkh7eplif4biZCfQclRrBmpRMm/OWxzA84kr53ZlD5VKYI?=
 =?us-ascii?Q?QGFklVKD+4MFqrzLG4LrIpaskXf2bP0vQpib2jllKyiIlexn1bktmhYSLKmB?=
 =?us-ascii?Q?MpvNKphelejlTF+5/G0rdle5yRBZN5QdLVcJ+fbuLgGPMyMchXwW/kzJq+QI?=
 =?us-ascii?Q?/7NwLexqjGQMThdJPQesC4vtUqRDVBBq8yqXhcEyA7wOGAqgrgj2GY2BGI3K?=
 =?us-ascii?Q?sDdWW1XlbEkqyRmmhf0ULZAtmZb6Nu4uuObnWnaddYE8UE/w64lupAPHm8dg?=
 =?us-ascii?Q?ulNWo1fGjwBgxzyxlLt88X9QjfyBwmLfHtlRqCmYqG3+WZgwtaVU/qYgN89a?=
 =?us-ascii?Q?EdqigV5pI5daHH0IaevCvBLco2Wf2SyGtB2zqgRVubxmolTvIxJKj7HlvIe1?=
 =?us-ascii?Q?+OKn3medHMlp4+HNB3q7uRq2A9recwNd4LLJIu4Bdf95bpq3DqytWrlmFkRb?=
 =?us-ascii?Q?Co7n/4OEMm71DrOOpYDlInpt1tYE0HHvD08jEA2jm9ZT8jTSL7un4dQSeNmV?=
 =?us-ascii?Q?lAoiyMgV0/LvEWyp09pFDMPBnbgDrRw4RlH4epYhv5jKH62cJ+BBJsWW1+U2?=
 =?us-ascii?Q?V2DgKmOUWMSp0Gpf6H0Pg30nbZiMZMoRtmvxjzfHFp+PA6TGuBRGhKs+XvGD?=
 =?us-ascii?Q?I/7N9TPbfZMMBmxJ/m2ct4cRxO10jZp/B4cf1Oyt4syFDhgpAJEPLglHvq/a?=
 =?us-ascii?Q?PyVluN+AWRHy/9dYR2FaJEEMdqZoLolJAmT8r9K9JgnDwlxnXSQcv699a9Xv?=
 =?us-ascii?Q?YuLWFLDKaFST74gRvHcvIf5FSX4mO4rKD9FbvcXqk7Jf6CYLwxrRV1CRUgPQ?=
 =?us-ascii?Q?NUfrSxk8KcuwdJ5l0piVVGZ9wBVkxDg55wjzA0mhorILbow+Z3hhxxuruAOw?=
 =?us-ascii?Q?muQfReKMwpKtphCaHq79hBG0FHgQdNUCkfcOesx2aq7b8Q0TcQm+YCJz2W/h?=
 =?us-ascii?Q?2A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36650aae-1461-4eaa-540d-08db425a18f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 11:18:13.5413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P2aaICtmLbsLgOCUFVIGY6f0zTAwhei7JjdUsntd5DYfIrQuUv1Or4PlP44CkbZc+GbLbLNK4kw/S1+ljmG6U7iuBiQLv6PIlaKSynNS2co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6220
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 11:18:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11309

Hi Pavel,

> Subject: Re: [PATCH 5.10.y-cip 00/33] Add RZ/V2M support
>=20
> Hi!
>=20
> > All these patches are cherry-picked from the mainline.
>=20
> Ok. Well likely need to backport these to 6.1.X, too, but I suppose that
> will not be hard.

OK, we will look into it when CIP publishes a 6.1 branch.

Cheers,
Biju

