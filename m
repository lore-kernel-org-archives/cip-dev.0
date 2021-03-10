Return-Path: <SRS0=OeyG=II=lists.cip-project.org=bounce+64572+6270+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EBDC433DB
	for <cip-dev@archiver.kernel.org>; Wed, 10 Mar 2021 10:24:17 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D7D64F74
	for <cip-dev@archiver.kernel.org>; Wed, 10 Mar 2021 10:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D7D64F74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6270+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id D2BsYY4521723xsaeQNG5mX2; Wed, 10 Mar 2021 02:24:15 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.104])
 by mx.groups.io with SMTP id smtpd.web09.6844.1615371854081706183
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Mar 2021 02:24:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUQNhPsV7Sd4iyGxYm9u5qCZgs6bXoTYzdvNWdJkTcImx3bsUAzzDCnJHOLgfzfaMPhRWTUQ0CUH2n+9ASjnD+zAQlKK+H+zR0Tb7D8i7gbRI3/eZDyMYlfWYdzaM8AmOTVFFopk8Q++fWMt+y3fQoj8nf0Xk8F/AflMCBgWFuQk1M3lqBeMtAjRyD0xPfDEVa2mJ5l104og9zfuAHBbflAs9jUtjRunuIdUjGmcYJ7AUKlDUAKWiA7w3fK1FrucHUy1bd3Qia9J2Lcl1LEa47+WKxOC1C0WYIQkxQNyy6ngdNP3ATwkHQ2DMIQfmwy3yu9hrhp/P17Htt6C2KEeXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yhjYFgZucqzS7kdAflM+UCqOZi5CqwbcJ/7zrc1yu4=;
 b=RcCQ7Pguew9UHhUKbL6mzyU3l7o8B3PfdNaAVzkXvon2xnuw0tVpKgcCQPY+uSNDDG7zmCb2kk4I7rkecT6vVQu5+Ldb9fjCjibidg8aejSNzDLn8rxEwnS4T9ZY30mCbOSQD33FK8TvoQs0PWy8skNsULgkBc+z5/QrWhGue3XMTkU/9KOCQ9hcbTwjd0rffXj5eGmRXHyJ371b3/XAlDAweR+bBBg11Y6NZlRpqOcePWntkE+b30mpkQP/RYP/oM3JopRiUpdL+PMBw0M3hEQ5cT3rCItH6hc52GRkMHQJ2bV+te10a6YHqpY1ZF+6zmcPlgPdYQdL+2kPeRWOaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
X-Received: from OSAPR01MB4867.jpnprd01.prod.outlook.com (2603:1096:604:6f::14)
 by OSZPR01MB6309.jpnprd01.prod.outlook.com (2603:1096:604:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 10:24:11 +0000
X-Received: from OSAPR01MB4867.jpnprd01.prod.outlook.com
 ([fe80::24cf:baf6:7ab1:2ede]) by OSAPR01MB4867.jpnprd01.prod.outlook.com
 ([fe80::24cf:baf6:7ab1:2ede%4]) with mapi id 15.20.3890.038; Wed, 10 Mar 2021
 10:24:11 +0000
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 12/40] media: dt-bindings: media: i2c: Add IMX219 CMOS sensor binding
Thread-Topic: [PATCH 4.19.y-cip 12/40] media: dt-bindings: media: i2c: Add
 IMX219 CMOS sensor binding
Thread-Index: AQHXFRVdL9TTz5u5JkOARr0fZfbIrqp86MrggAAPTQCAAApoAA==
Date: Wed, 10 Mar 2021 10:24:11 +0000
Message-ID: 
 <OSAPR01MB48672E85576AC983FA90F831AA919@OSAPR01MB4867.jpnprd01.prod.outlook.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210309163656.20944-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20210309185226.GA7023@duo.ucw.cz>
 <OSAPR01MB486786ED928CA022458782FBAA919@OSAPR01MB4867.jpnprd01.prod.outlook.com>
 <20210310093830.GA24989@duo.ucw.cz>
In-Reply-To: <20210310093830.GA24989@duo.ucw.cz>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af57237a-ec93-455c-2fdf-08d8e3aea5b6
x-ms-traffictypediagnostic: OSZPR01MB6309:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: 
 <OSZPR01MB63091E6AC8159CF5617DAC43AA919@OSZPR01MB6309.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 6d0jnOFPof7CYPxwFjDid3Yl+drwpYbcEZu7TifQs2ecAYs7Ka0H1O+9b8d4Y6OHdttZITb841C3/DKta44Pt4Dwcg9Aq4CAZ171ERbjBANnjJgb6jEZLFFu8wJOE3iKd3uZiyPhDirZ4x6k5bgdXEEd0uCXVYZ9KV7xiiEBMy8EfjG6nZGWkLSlktuc5AIAP9P606sB72Sbzc0tIgThCvT2szQK5x8XWO7RWtJr5tzeAufi3RSEWgXocs7YgkKsZ0mHUWCsahXv4XXbEfviai2YYrBPjtruZRwrGJIC6ICdLmRnG14weha4kVFGsynYgA9H7zAXDsQJ5xCXqCtsIEd1LjAWX7ahVK9R68wga/qMh4mMYyGNvepgWXFSKPN+t7teAqVnBYXVpmm20igD/D2TqR/xklpXCLDniCcYlpiqPXlA/Ex51gbz1bkdlLJpmSUSmZx9/FoUh4o7U+MhOm/CfwlPSdoyLX67HtCNxe5v4L9LomGQn0StJufBQqThT0VZBbqaIE5eAOopfNte5v2qkVOflaCi5YsxTDmX/n9BK29jGOmw6KSvmfSjRe04u6Nmz/o4JPy6XBFp/tjVeuNYLZYkO+yaCPUn9LwhqR0=
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?lscD9Ao0pVkLTv4hHMvskJ8lx2+TUSTsV2FO0xYKNm1F/LzvEPHsNye0XQ3u?=
 =?us-ascii?Q?1xNm/UmBhsKLQmFy+dImL7I2yPsG0wEEUDSL6equr8xdcnaiE9a+o6S5gcQA?=
 =?us-ascii?Q?r7CHtytDEIwrDwv+dXnzrkICo9fg+uwpKxBsxBKn4rwei5RotO/VUpO3vlmn?=
 =?us-ascii?Q?oNPuBWuS1NQK2t5dEnQqAzHX6OM6wfqPUhBKcS/mDd/2fTw/tvVL7EeQsa5S?=
 =?us-ascii?Q?/qidMiETqz1uTrRlP1jPZr9+S6lcY3X8a2DUhmlJws2vENDQwGrlRsCoeKBL?=
 =?us-ascii?Q?vg9ik6113okjhIJqrL3JLNkubWJZMl5FHlXDhY3cxnc44k1VmvkLLdz9yRqU?=
 =?us-ascii?Q?K1aRGp/hs42C/BqFuDP79HHc+/GAgFA2WrvlbBiq0RvPSYxv0zyvw1tGEugI?=
 =?us-ascii?Q?q6CajUNzzq4mcsL5eYLK2cF2jDT4CUg8SpmhdZqcQpOPzYu4J3n2F8q+Pnzk?=
 =?us-ascii?Q?bWbpoX7k8QHuVJVg01TCbJFfc1Z8MmfvmGojl+PvUrlFZ4mAmfYwseeF1YnW?=
 =?us-ascii?Q?2q6Iiw7HbIFEQuoiQW7S+5RfSjj/2T+cAy11BXJu4+I6blsXkcr0ivUq3z4l?=
 =?us-ascii?Q?2Z9xWPfzkfJrVPRg71nGnxltHtjIyaDsle9gosQc6hX2aZaxnBa7egkz5uGZ?=
 =?us-ascii?Q?+yDxQiMy64XvpSREkwDMk0xWmO+A9OkyFo+rPH6z8U6/i2KQ8kwkZ0lDEGNm?=
 =?us-ascii?Q?aQfLQ0lX3fGh7PTOjGivI7uQgW2MErwqz+1NXYR2N1gwAtK2P/VeueLouSC2?=
 =?us-ascii?Q?98ScC89Mofld1lUh9D4SAFNFYIrPFn85adeneFJh7B7b85zSMdAOK5EygfH6?=
 =?us-ascii?Q?bUBMDHO9WxbYxlmt5TKUZQLcpFnnnfFVZnTvna06vujJI0CK+LOyXbqX3szC?=
 =?us-ascii?Q?YRY2a7YYsbXvwk6KchJ4ObFfTaiwEHEreqVmac+2PMDeFcrcMMkQecV1mwGZ?=
 =?us-ascii?Q?jJytW6u9Wp/UvD7+SYMuEypf2if9LP//anFvUNmctGEoRYpRjdV8GhaP8cPG?=
 =?us-ascii?Q?0n3Iifubk/T+FEaMVzxIxAV9tN7vP0ytaIxq0F1E3livSi+zJO368+NC0DTb?=
 =?us-ascii?Q?P4/hEzLi5DLA7K1RLnod+3HjSIc8hNPdNGouN0Iy8Tg+qymj+wCptB3UKMam?=
 =?us-ascii?Q?d0lT2s3SEwVOL42G35z0zIjeL2tcyCSl0A+fDrUTE4R4vwNcbSB6XEw0jS4S?=
 =?us-ascii?Q?RDzOtV4irKnswA14yWpUUJJhP56FZRqoInwjsItqv5Jl1CGAdHASQg0AubX0?=
 =?us-ascii?Q?P8Ct6/YVtUpuPHrOm+zZXT+axL9iZV3McQrop9Lry3CBhY1QwkFcI/7NLDnK?=
 =?us-ascii?Q?v5V2coyDozNa/fhmrIm3HXzZ?=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4867.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af57237a-ec93-455c-2fdf-08d8e3aea5b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 10:24:11.6290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u7BWKVNCelad1FzdZLpI7x114HrmluvZ/Fl4xSLnj9dlFnBecB9z1SaDemd7VfTiNOZ7IpYAMWvPxXMRZVg8vFRwXS57r6Iz2v02SaussPYuI3vLMdorKjzOYgsyKgfS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6309
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: lHAhczk8SBmAlueW4NB6Lcpex4520388AA=
Content-Type: multipart/mixed; boundary="1d4BY8vPpxzIQICLCCMN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615371855;
 bh=l8Z7o3LCao4RdMXFQ/iDKSTLDN9WGuK5ag9JyXe6Goc=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=XQlX/KbiCSZwCjGWen0mOiN894xls0n9J0LQF+ojgT10E+xduo1dfK51HQY0n7NFC2N
 E0t9v0POXCHE1UHjW8Pjwt84atZc90UA5HaWQCM8JJzdiw2QPOebo5SBTWL6FA437OK2r
 /Y6T2rp9Kctfv7jiAvcsPV6KOimeze/yEiA=

--1d4BY8vPpxzIQICLCCMN
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 10 March 2021 09:39
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Pavel Machek <pavel@denx.de>; cip-dev@lists.cip-project.org; Nobuhiro=
 Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 12/40] media: dt-bindings: media: i2c: Add=
 IMX219 CMOS sensor binding
>=20
> Hi!
>=20
> > > > +description: |-
> > > > +  The Sony imx219 is a 1/4.0-inch CMOS active pixel digital image =
sensor
> > >
> > > I assume it is 0.25 inch sensor? 1/4 inch or 0.25 inch would be
> > > understandable, but 1/4.0 is kind of strange.
> > >
> > Agree with you here, but looking at the document [1] its referred the s=
ame way "1/4.0".
> >
> > [1] http://www.opensourceinstruments.com/Electronics/Data/IMX219PQ.pdf
>=20
> It is refered as "Type 1/4.0" and I'm not really sure what it means.
>=20
> 1/4 inch is 6.35mm, but document states it is 4.6mm.
>=20
> https://www.photoreview.com.au/tips/buying/unravelling-sensor-sizes/
>
Thanks for the pointer.

> explains this system, but they use 1/4", not 1/4.0, and it translates
> that to 4.5mm.
>=20
> I guess easiest way is to say it is "4.8mm CMOS active pixel digital
> image sensor" and forget about confusing inch values.
>=20
Totally agree with you (^^4.5mm).

Cheers,
Prabhakar

> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--1d4BY8vPpxzIQICLCCMN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6270): https://lists.cip-project.org/g/cip-dev/message=
/6270
Mute This Topic: https://lists.cip-project.org/mt/81205355/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--1d4BY8vPpxzIQICLCCMN--
