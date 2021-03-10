Return-Path: <SRS0=WBp0=II=lists.cip-project.org=bounce+64572+6264+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A079C433DB
	for <cip-dev@archiver.kernel.org>; Wed, 10 Mar 2021 08:48:45 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D4C664FCB
	for <cip-dev@archiver.kernel.org>; Wed, 10 Mar 2021 08:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4C664FCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6264+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Ji5eYY4521723xEkiHRtKzDI; Wed, 10 Mar 2021 00:48:43 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.100])
 by mx.groups.io with SMTP id smtpd.web09.6098.1615366121664375608
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Mar 2021 00:48:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJoKfnRmZpG/Ca3t+4TngZ7OE6jQrtelx3Of2BrWeeANNieXVE6dKR3yhIdJTDCRbZm3beEter9U1kLE2lUj55CgueJPGXQtik6jCElugmX8jvvPrbexJSfNI/j+8PxXw8PLYE0FnqfpY1ENdMo6zgiB+wNEoLBzxSN8JO9DXSLJDZShik1/pGFifBm2xdHd6Ott9CxPV+sQJzNHjI2ugfVu5i8tOhG5xU3vrbTZi3iuAGqwQegSDlVHRVoR4t3Qb3a6r8hMDChqW8+jRdAn29e3yHXLwcJoE0mgOdazR8RHUjfXEE60yqVsQLfhsDKnaws4LbkKMPjMdO0IPosTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9Fmr+BYy0iZsLs69FwhlPAlenPyJFaPifnd0+ZPOAU=;
 b=Ys2KIstnYzla8+wHx4fFGLci0M5bouneI30ZRXRSxvbvvaTyGy9067qq91SIcRVJXC+SKvqikKlg2ZTycdYfnvM1+jmSuqcU5H/93SBIhAW8XIeBvlohnhwTQc58Ihuc98uPOSD8i/qLg5ZGFe3kSSUGl/oVhyTjXgAQvw6CxolQwpektPwrJtK4vyhohaqCtXOFwRGELFYa1n3fhZooDsY7KJslCVY6XjTv7eGdl38/7dhpRsjUUGb+UCgAt/xiqxfkh2YdnDy5130F5eYaZ/HJz2+cDVFrB+gGU4pUGGLsoEjJdpp+niZI6XN+lFd5b5RRDwxIscLAs5QcXjLjvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSAPR01MB4867.jpnprd01.prod.outlook.com (2603:1096:604:6f::14)
 by OSAPR01MB4867.jpnprd01.prod.outlook.com (2603:1096:604:6f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25; Wed, 10 Mar
 2021 08:48:25 +0000
X-Received: from OSAPR01MB4867.jpnprd01.prod.outlook.com
 ([fe80::24cf:baf6:7ab1:2ede]) by OSAPR01MB4867.jpnprd01.prod.outlook.com
 ([fe80::24cf:baf6:7ab1:2ede%4]) with mapi id 15.20.3890.038; Wed, 10 Mar 2021
 08:48:24 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 12/40] media: dt-bindings: media: i2c: Add IMX219 CMOS sensor binding
Thread-Topic: [PATCH 4.19.y-cip 12/40] media: dt-bindings: media: i2c: Add
 IMX219 CMOS sensor binding
Thread-Index: AQHXFRVdL9TTz5u5JkOARr0fZfbIrqp86Mrg
Date: Wed, 10 Mar 2021 08:48:24 +0000
Message-ID: 
 <OSAPR01MB486786ED928CA022458782FBAA919@OSAPR01MB4867.jpnprd01.prod.outlook.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210309163656.20944-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210309185226.GA7023@duo.ucw.cz>
In-Reply-To: <20210309185226.GA7023@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f4ee0ba-5f87-4610-f476-08d8e3a14454
x-ms-traffictypediagnostic: OSAPR01MB4867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSAPR01MB4867431F2ECF3414C548861AAA919@OSAPR01MB4867.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 nmTzdOXTiMWhGtp++tj8tzrZUqCA7Zmy2k/4fPcLBM5pSm/Zu0R4yM9xQ/iGK4oAS12UtmOvkQbrm7hBTE14YVa4c6ZDhoOKlw79PTgqSV67o94kuXuIZUjgeivztv0Jad4bTz9b0SxwX0eXj/p422YWpEE4jn4E5lNG3byUJOgPZbJ542f3tuTX8dXzOY3rfVIIH7aJsBef+7JPNG9/uwRPRCIXyYT2m+7wQYSJGb0RdClXhkG9AX7L0k3p8lTYc7BvD1v/s7EcqAPLpF37Ee6mWamm/5L9R/tE0WRgRsZD7uxNeNpG2uiKez5wtw+rOpHsb+n+6DiROQzgsmWsuMUkNh9kQw6GeqEfPoRjjjTJwdT5vySdjA/yzTIcltvxnjog4Bb0M5oppn3ymguSiqMiP/B0CD3GzUb4kCiJSbcQHu3l8RFjVDkYddYbieG2TBI2UkpBsMp644O8wgdSny1TftPlJQkA3MFnXqLfZwmrXiKl0okBfpqWU/v7NBrkeBGOtHrpQCKe8fulYh/u61gA9CVG6SG0D2biHsHRQgjA9xqq8iIg5MlpjE+CF2XZu06QBnT0U0tSTGhLuSfI2qj8CPQaLYJfo51TZCsSY2Y=
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?sEP2PjDpPGDhTOv9qKYgG8CHYiUXx6ixEqwymHBph7v+7mmDSyokV+oAu+28?=
 =?us-ascii?Q?ufnEvoqfht8Ze1RIeO75ZhX1d2V4sIknYNHiUzZGd0DhytgEoNDV2bDYKABs?=
 =?us-ascii?Q?5voebJl5mIEbOYhJnCMO/wpkDY2U5k/v9i8R9gbwormLAQqwf7jv5g3dlVL5?=
 =?us-ascii?Q?CHuzKnWt++xH0kV/0KL/KkbU1eYimhFWp12aa2VjiogOIYYWsNwz3K+1TFSB?=
 =?us-ascii?Q?AwOVmMlCTkBqDWCZIrM13KnWZvmBr4GP2brXVEnw2cdmtlFqT8TAPAIIkKnB?=
 =?us-ascii?Q?drYHeMq9/BzMQdeB+mMJc9zanTIGdLzAZd08Tg9CdrX5S1B6/eV34UlhGQm/?=
 =?us-ascii?Q?A7SMDZBiqO9j+eZsFhYqcwtr3qiPKNsc8fSyvtYn2QJxToobO9fj+aZS4EMj?=
 =?us-ascii?Q?ZGd/M6OxAXM/LDypjuXy1MtbTK0RTg2u7z5F5Vf/iR6NA+PqNhLXC8nellx3?=
 =?us-ascii?Q?U4U+zwzOT2muUu90duvIQNibny96+/EKa9Aed4O3eNTiSXzdFFu6ta0lYQ6v?=
 =?us-ascii?Q?fTO9vxzc5CXnEZsDxCvwFc5JwtunM8rCP4/1JIs8qDSPF9nRcb7teGgBLBYr?=
 =?us-ascii?Q?zXebyRg4lDHmiQlRfzn8tuPs9J1pm9yDML90pxyaQ316UGb6MYWOFHjl7/cC?=
 =?us-ascii?Q?TXmZCt6fXowQMbCbF8lDclvUtv8i72bIptyU9qWdVGVtKAoThc6wtdcQsEh9?=
 =?us-ascii?Q?vbmK18m+m78a45iG/9hHK5qmljb6a0I8JyjEDQZW99QXNXAiQqgOWRwL2fz6?=
 =?us-ascii?Q?S6eN4zcUZmnFGKenxOWxSOg69Cd1qnlkPkTwUWrg6Y+AiUw6wpvR10ZlWUte?=
 =?us-ascii?Q?8kdgqaS2aCsx2AzvtUkdy/9gn2tvCp1JQoz21qbL564kLtK9ZOTfo3iQuve6?=
 =?us-ascii?Q?EpTxCHX99Mi7/Ql49acAd/oDsPzzUK4tPkGNkilxXvt7GRmgI893kBaeVHkv?=
 =?us-ascii?Q?J4pYKs1FHtH2sKWgqCmIAwgSE9nkHYuIqTFcNN/IJ7d9pm/SlZOj5P51b4NE?=
 =?us-ascii?Q?RTEqiCehKIUmuudmqG9WYMHtkmuCgGRkuOingQEeYiu7f40NvrrqYXwrsZdE?=
 =?us-ascii?Q?miYsGWd+K+oRLgrZxjUinaPeP8beNE62kHTWpr+ECoHG6NogB0qIUaeSamro?=
 =?us-ascii?Q?QrGC3CS+FZpUyqcy3jHG5gUDULo70KnLGil7ZFBC/Alk/WBSX5f30tp1rZ2G?=
 =?us-ascii?Q?3zNzdVnYl+5aqRdi7QLbXMrRoYD9/a2DgkWtLTsEwuHk4lKAaFJPUmUojbSv?=
 =?us-ascii?Q?eIE0dRIxRkH0DEy03D1aFgLCvfXk/bbcbJO4ecuyDuUpNG9eUxsHUNh9olmG?=
 =?us-ascii?Q?uxs=3D?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4867.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4ee0ba-5f87-4610-f476-08d8e3a14454
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 08:48:24.7104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nkTF9SFD7RX3xRFUc7tkI2A4uTZCH3IwTsqrWYXv0eJCxtxaZS9wW5lY8gWVGG5RwUnUHxpMe/k3qQe6jvOOpSA9xZtWOO8k93Wj0UPFegPNHENf6DBMYQKhOasXbx+y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4867
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7JyRckHQkpAijWDrepy9d0gKx4520388AA=
Content-Type: multipart/mixed; boundary="UliwPd9Fo4ryqmEAUC3L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615366123;
 bh=V+Mky+cDwuGIgxkT+SQl/egfAqkZHUe6oj2DO2fUMrM=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=AbJovs6U8Xri2/C7Kje7E3UF6MBb8zlMqe5Evt5x3EVcQRAR7REkFmsykFeMmBr0fe6
 D+4smucfIQJXnTrTrjWE+fsNv05A9xSkoYNnJW80MPx0zAWjGny+b/EsGPmVnFkLykXIg
 zhrRfTkLlG+e5hfJSsbh9NvqgK7qsKYLUe0=

--UliwPd9Fo4ryqmEAUC3L
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 09 March 2021 18:52
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 12/40] media: dt-bindings: media: i2c: Add=
 IMX219 CMOS sensor binding
>=20
> Hi!
>=20
> > From: Andrey Konovalov <andrey.konovalov@linaro.org>
> >
> > commit 9d730f2cf4c0391785855dd231577d2de2594df9 upstream.
> >
> > Add YAML device tree binding for IMX219 CMOS image sensor, and
> > the relevant MAINTAINERS entries.
>=20
> > +title: Sony 1/4.0-Inch 8Mpixel CMOS Digital Image Sensor
> > +
> > +maintainers:
> > +  - Dave Stevenson <dave.stevenson@raspberrypi.com>
> > +
> > +description: |-
> > +  The Sony imx219 is a 1/4.0-inch CMOS active pixel digital image sens=
or
>=20
> I assume it is 0.25 inch sensor? 1/4 inch or 0.25 inch would be
> understandable, but 1/4.0 is kind of strange.
>=20
Agree with you here, but looking at the document [1] its referred the same =
way "1/4.0".

[1] http://www.opensourceinstruments.com/Electronics/Data/IMX219PQ.pdf

Cheers,
Prabhakar
>=20
> > +        imx219: sensor@10 {
> > +            compatible =3D "sony,imx219";
> > +            reg =3D <0x10>;
> > +            clocks =3D <&imx219_clk>;
> > +            VANA-supply =3D <&imx219_vana>;   /* 2.8v */
> > +            VDIG-supply =3D <&imx219_vdig>;   /* 1.8v */
> > +            VDDL-supply =3D <&imx219_vddl>;   /* 1.2v */
>=20
> "V" should be uppercase in voltages.
>=20
> Best regards,
> 								Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--UliwPd9Fo4ryqmEAUC3L
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6264): https://lists.cip-project.org/g/cip-dev/message=
/6264
Mute This Topic: https://lists.cip-project.org/mt/81205355/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--UliwPd9Fo4ryqmEAUC3L--
