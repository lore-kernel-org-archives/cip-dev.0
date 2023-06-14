Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D45EB64D8
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 13:41:36 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.137])
 by mx.groups.io with SMTP id smtpd.web11.12202.1686750091439313493
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jun 2023 06:41:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=AocQzSe5;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.137, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTyW1fjzeU7+AUpQxzS2iaMX27C9AJjXP9pdgmS3WinrQGOijo2TMz+NsUDzHyvlSgR6ZZ2FWx/+GohIMltADuXC1EVEwsKL+WIIG+HrKWYy06VMKpY2VirabwYJQ0yP/LxtxB8PYAyY+7T+fOpuXVvoP7MnGdutSoHU9JVrW5XjMHwcdCWmxaWBJpMv0zilk48B8JN/oXUrOZ3THNXk5d+B71qjVBvRWksw7xk7OtzdxGADb3gF2cTK2P6sz4fxf7EyqbX0FKJKIUrogKkZEpSKtJPBxJ7KNPyDrVhdAEneHBSDww43KxlVFFHzf+9mIfznVPLHfq7Pp/Lk31rDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9bSPEqHCG05hluz89bwce+K5X/xAX6PH5DxrCE6Cg0=;
 b=ZPTfvMIVlxN0EhH1J7AVO0ALjaHRDYPkMrkAKuADwwoEvOFmoW15S3wIKKJqnKyGsMP3rK7f5qxKbGZQW+NfYSZCWRKNaL0FciO2T9od1DuaPMOQVBFbcv9IbPBVO9rvAwkiSdZob9GjT3Rd3fROr5vK/vJepE+axrCyUPAGZEKjpyf2b1WrsmhKH0KcpWFj9HlueHUqq9i3l3qEpZziuyce7/NyFJwL/v0Twq7yIvAL7sSrWs2Ni3fQfg0ug6K1q6ublRof3ctkNTJ3xqgGv2R1VhkdrPJqg3AfiuhagkDaQ0S8wJ4AJq7ZVn8urJa6IQ4IMROPoz49G6zwWhFRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9bSPEqHCG05hluz89bwce+K5X/xAX6PH5DxrCE6Cg0=;
 b=AocQzSe5LXzcSEtjl96Tp8Tkqf0hZ2nFYlIM8z0b1fNVBtx9Ajnl4NakMCHzeeNKbZ7mdTrnbyBld0Eh5l3m7LJABwraTyU090B72AHMfbgZM65Xfr0+wnuKmQnL87PDFNrzhaH/j7Ey4td+lE+okHfyHG4rHCjvbLQRNfCZTkA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYBPR01MB5357.jpnprd01.prod.outlook.com (2603:1096:404:801f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 13:41:27 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.047; Wed, 14 Jun 2023
 13:41:27 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 5.10.y-cip 5/7] serial: 8250_em: Use pseudo offset for
 UART_FCR
Thread-Topic: [PATCH 5.10.y-cip 5/7] serial: 8250_em: Use pseudo offset for
 UART_FCR
Thread-Index: AQHZnqkWdO1rvRcfYE+FCdSJKpzP7K+KTFuQ
Date: Wed, 14 Jun 2023 13:41:27 +0000
Message-ID: 
 <OS0PR01MB59225C000B638ED14D74E10F865AA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230613132339.150671-1-biju.das.jz@bp.renesas.com>
 <20230613132339.150671-6-biju.das.jz@bp.renesas.com>
 <ZImTIqG11bqfsvCp@duo.ucw.cz>
In-Reply-To: <ZImTIqG11bqfsvCp@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYBPR01MB5357:EE_
x-ms-office365-filtering-correlation-id: 33dc2f5e-3a1d-43c1-edec-08db6cdd0d86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 GPtZ7b8LpwJhJLuhTKOeDiuJvWYe9kFAqg+nYjC5kp9ehpcXCcfZCG69SssNs2olXQAjDz1IAR7gLpQQisnEt5+N3qxTNHLhXgOe62E3C2jIrppRle/gJc1gYhUiMZLHB3LFGtvof7tYOpK/p033h2S1+FNKbmBEEWasB0qCcDaVh/3/K/qJ7mWgV7yA50hHJkaIcAvKL9gAb6dts4/5emQ4hMaOgnQKT0xAXHJGNCJD85dcbH1HtDoU3QZU426cPWdiAQnFHsY+bDwUBo0sCjbkGe/p8aa0T6Paqv8cKB5t/aQMCIG66iXm+TZ4+l+hPaw/RjW6dPji0eu7ZnoG/D//Zj3OFczlwvfl7qc7ldcL4D/YY1LLcg4AzGjwbmh+xkhLr0woTfH2/6iSRehjnJs3BO32FaXoeHs53FPDSCU2XCUt7VGXVDoit965lAJE6zDU6JD9BFdlniGJjOiERyggmxLvbeDDXloNm01dvNDMYpYNkLtKPuFYrjam/hrVrh25g7QT8RKvFyjalUNfHByqmZbajGXGznv+7owHq2yYxJ9danLbIVTVgFtxWyAM2r3nnJCbOEYLwlJ3TVQ39o46OtpdURuMlNFZT9g2RT0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(966005)(7696005)(316002)(41300700001)(122000001)(2906002)(9686003)(6506007)(86362001)(186003)(38070700005)(26005)(33656002)(107886003)(55016003)(38100700002)(83380400001)(5660300002)(8936002)(52536014)(76116006)(66476007)(66946007)(8676002)(478600001)(54906003)(66556008)(4326008)(71200400001)(6916009)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?yYJH/1opAbfIKQhsbohRshJP4UF9RrV5tZYei1sntOsnnPrGYbpPkfpirjvG?=
 =?us-ascii?Q?wXJbifnZyFZpZqvQG0ZN6BLZllRRgNvtjYnz08qj03EN3g70N6mHESC/Gfyq?=
 =?us-ascii?Q?Gc/fbWoeerUAe4dsme2g9gwCy41AK13t6cfTcN5lliGNEOhhvGy20QrtExfF?=
 =?us-ascii?Q?xBqyv2OcGWNRlTAV9VsMpgRmpRC6CmrLlHSa2PduBHBf0BEMB1cvQmlMEIlL?=
 =?us-ascii?Q?q56Ydhj4sXkGYS45GsIAPH72spRbO774kemOzGD9AS3tt2oEmmW4onavtMJe?=
 =?us-ascii?Q?tTYlgFT/2MaKNRt53btfvNz9swYgDIMY4369pIpwheHBNkH0ud0LtsVd/smb?=
 =?us-ascii?Q?jqkxwD1h0UD1f8JNhcftLaj41jqTzLEBj6HBI7CDnyRm099QiMqT8bQ6+4UP?=
 =?us-ascii?Q?9LHA0tzwmsvlEfia7I/XJlMYb/D3aPf8yPaeyYHHH2ELQA3vl76AnzFWnxkO?=
 =?us-ascii?Q?WgPGLJYzjgE44jRi/PtwAKyJTJcAmM3rL7wpk/VqrbiJeKL6R5hHYwC2bfgK?=
 =?us-ascii?Q?LGOpaeYb9BQ17xfPUEgGpWnxfIKNwH7qjXsBksJ0UL1ACvkmkwzAZGc6ldA8?=
 =?us-ascii?Q?z1sERpZmv2ecUerhkYiee5IcYufr3+QtHC29rv4ErwSbEld1h11ehO9GHtQ/?=
 =?us-ascii?Q?OYYHfy0ZckhHn240PtpZhygzUUTznyVbTyniu5fN1WLvR6bfsRAVZNPOA7oN?=
 =?us-ascii?Q?bPdf9LivCL0RdaqZJlUeCG9yKgBvoTPIernO0DDpqlpJWxvxWAJW/W/TnS9N?=
 =?us-ascii?Q?NlzlHnk4m0Vokq1nyY0AV0ZfrknYnADla+uJ5/H2/YwjnuvAIna0DwmRU+/b?=
 =?us-ascii?Q?GxD/wp/huWvwlna89zALr3SroNS1qSHFCYAzzoNqYgOlWVhf/5nmHBoDWnhF?=
 =?us-ascii?Q?Pyd7W7JR3Xo7W30LUClD9oZn9i6wq61PaIkDt3m6XHHLL62iZ1/Dnz5X7CI4?=
 =?us-ascii?Q?l3ghvKxL2pu+InYbrrFGAFDqCNLc5prtQ01YZHOuNR5smFVPrQPi7cSM6Tm2?=
 =?us-ascii?Q?0SSDv22hMuyWCNBAAkitAeb/FFAgPrG0IPDiOtnUqR7kOcq4F7L7zJhSRq3Y?=
 =?us-ascii?Q?Nb4N0Q13/YL+CUdkjLhaJDNkldHMXMNke0AEjq8ZJbeX5vdbyV+OjXwfUXfX?=
 =?us-ascii?Q?rceyoCdOo4gKCvGL8R3ZGAmIkNkGRLEZ8eVXj9jfGns3s7zEorSsIPKJ2GJa?=
 =?us-ascii?Q?EY3y+mbhdCz5K+MK0k0/dWDeI2xPspJnpT+DD3v+4Jh3Cqi08TWmppxDy9Im?=
 =?us-ascii?Q?rC1u0R8eshBZRLaW702/cUDuu7nHZT/fjCeLwkE0lbC6NGNhqfVWTjlrBIyh?=
 =?us-ascii?Q?0OJroU5YHnNjesHWwqyk5gutQkNEwAlT84MPkYTVhjxkeL0HCgloPdiuZxdj?=
 =?us-ascii?Q?HyXHEFQda6Bd5qZtV54Hj3czAnWIdRKbdABW4YYLPB+8q34NBajUaOgtI2l4?=
 =?us-ascii?Q?gL26IjbbNWYQKH1gWcq3IZhB2gs9+gaS8yyaYqQNGY/kVsFJuAo9ZIdbiDmG?=
 =?us-ascii?Q?LIzyvWdlDVh7ne0UyHalxfouOgAzjnfk5vtSZHSE6vcXT44r7kQnMRDATXHt?=
 =?us-ascii?Q?gpT7KiL8gtVYdgYbsN7X84kgnPjKFYnQ5wc+fGVdL++bP6bbCbAE1C4ILB5m?=
 =?us-ascii?Q?Vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33dc2f5e-3a1d-43c1-edec-08db6cdd0d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 13:41:27.2994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMz12xRD5mg+qM/LlC8z2HtQKri7P9M8eZufcjQVSbM28H3FuLkDkqlfzdAjh7lCboEgTY7Fo88T2Ob4JsBgtqyDTmlp8YU9ITa/JSeTUd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5357
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 13:41:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12029

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 5.10.y-cip 5/7] serial: 8250_em: Use pseudo offset fo=
r
> UART_FCR
>=20
> Hi!
>=20
> > commit 59d6558fb5fd750777edfde028ea1f9e7eed8a46 upstream.
> >
> > UART_FCR shares the same offset with UART_IIR. We cannot use UART_FCR
> > in serial8250_em_serial_in() as it overlaps with UART_IIR.
>=20
> I don't follow the argument. AFAICT you could simply define UART_FCR to
> UART_IIR, same readl() is used to read both.

See https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/seria=
l_reg.h#L53

UART_FCR=3D2 and UART_IIR=3D2

On reality from IP point, it is @0xC and @0x08.

>=20
> Yes, you'd have to add an comment to explain that this is the same
> register...

it is not same register.=20

case UART_FCR: /* FCR @ 0x0c (+1) */
case UART_IIR: /* IIR @ 0x08 */

I already put comments and serial maintainer is OK with these.

+/*
+ * A high value for UART_FCR_EM avoids overlapping with existing UART_*
+ * register defines. UART_FCR_EM_HW is the real HW register offset.
+ */
+#define UART_FCR_EM 0x10003
+#define UART_FCR_EM_HW 3

Also commit message has details

UART_FCR shares the same offset with UART_IIR. We cannot use UART_FCR
in serial8250_em_serial_in() as it overlaps with UART_IIR.

Define UART_FCR_EM macro with a high value to avoid overlapping
with existing UART_* register defines and define another macro
UART_FCR_EM_HW for the real offset.

Use these macros in serial8250_em_serial{_in/_out} function to
read/write FCR register.

Cheers,
Biju




