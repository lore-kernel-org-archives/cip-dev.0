Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA25AC001DE
	for <webhook@archiver.kernel.org>; Wed,  2 Aug 2023 09:41:27 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.96])
 by mx.groups.io with SMTP id smtpd.web11.10342.1690969279261563616
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Aug 2023 02:41:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=MJWHEAvW;
 spf=pass (domain: renesas.com, ip: 40.107.113.96, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mbk5JCyTW/dlZgwu6zga5u5OVEwQcfYunq+7SkS8ot0lM6GWQhuadn55IoFX4vCof87LUxucBW8lWQp4S94WpsmZoX2u71XKXbFyMKnTqI3lPGxF2QB3pGQxHkju6winpXkyFjo/nQCtd8ziRv+w5NXpXHRX0o21ocZ5zJKOoVxuR4jVSofvWIWj5BCxRs6xi/IniBE0PzXcIYP3yNDq3qs44cobkJD1HSoic5g0+jbSgNz2sBKUbdyDnEXcgwdiHlZrfJCQF5pTusZSVvosmemADQ6RP/ItE5jzC/wPf62GA9u2p88zipJIfO3IY3aTrSZbUqJad2vb+BTOhUdSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTl0BwnT+uOUb2iY0KQn6Txi/aR8Qk78Yf7ISAch16U=;
 b=TQi7giINOXK0ZDjeXUKx8l+9Igl2tG4fDLGRy16aXz2KHrtqV+hNcgr5rKRfwE8CBp73ESOSRHqJZnAYCzkh0Fk3mZbQVWMdskC+RRfC2GEsSiV5W/NkKgA06kL4nDVtQeshrgVcXq62x7MLX58Pw7d9Tf56vThtPxlyDvVtFzj4cJ4kQaMGqnvkBDNWUezji2FJ7068OcYvxFULqf/+c7by83n8jhWBxFzqB4HCOaujjl0MFgQjXix/CgKmIUfFKRtBAgGWGM5tF14rw+N/2apcWw9HVTDPKnxuHZbxFlquKbs99ijw9WajoNoqTwm+P0ufLwYSHsl/hoEq7P2WFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTl0BwnT+uOUb2iY0KQn6Txi/aR8Qk78Yf7ISAch16U=;
 b=MJWHEAvWejQ4qXq9PgPb07HwX9u2MvUK0TNTK0zKeK8VY0oamyZ6QPJpBsmNw9pgIWoXuPrT9C6fhGnx8RAJi35LR4g8jhsiKwWdJPscVeEIN4Vg0N4p6FSIPpAyC2FVsy9+TwkmyGD6xbRnQZTOia8MgFBE7UOlHXn056berOs=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYCPR01MB11886.jpnprd01.prod.outlook.com (2603:1096:400:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 09:41:14 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 09:41:14 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "Adler, Michael" <michael.adler@siemens.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] stable-rc-ci tests failing
Thread-Topic: [cip-dev] stable-rc-ci tests failing
Thread-Index: AQHZxR9ONsUbi57YE06aGQY191NQb6/Wtr8ggAAJXbA=
Date: Wed, 2 Aug 2023 09:41:14 +0000
Message-ID: 
 <TY2PR01MB37881707081B7D70710B10BAB70BA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <ZMoaWmwWiLQz+vNU@duo.ucw.cz>
 <17778648DB0D91E2.2497@lists.cip-project.org>
In-Reply-To: <17778648DB0D91E2.2497@lists.cip-project.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-Mentions: michael.adler@siemens.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYCPR01MB11886:EE_
x-ms-office365-filtering-correlation-id: 3bac3f8b-97ba-467d-66d1-08db933c9d0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 qgJ8kljScU69Mabu0HP6HAPze29oL5eMnoG70kzDuTDfA39JDTF6ZJWZuTL7tyXJ6oVuiabH7rPUSmWS1qt9UHf+yUdtiRUKfWfiRBsfPI38Kyk3UHUElQBNWdDjQPiPl/daLOZ/665bqVegjgXGsF6hgRSV1WbNf5glC2lajQiFpLy+mn5CgONs5RqxiycWgS3ID2BNrJayLg49rez1Hxc1xgLYEfcMjYHr0CueyhlvJOX21+Yoh58XcQPIqWlg4cc4Drg3L5YczInWz5ea837IE3/iVHZP3cR3cEFbBYpgYUkkz7N/Dq0oJ5aC7NN8VIrc7XjG387U5W4zbyvZ9PPn/S59m8Nj0EQrPpzBSiv5S0A7Fu4RwqE9rah0cEhAMl5GJQKwvBitrRVqjJb4VWCPkvPhZW8T1cFSeAwvV75s/EvCH7A6xJJxC+LV2IDTHZZ1sxDWGd7Z+ZNGA1/ZpGliHoRqorOduMQMJIPiYboIQPNyThr53TElQWfKGyNoAMZVdk8muZAew+hRDgwR8eCZoYkaUSXc51yUu8WE02TTz60a3ABxHL8bAXkVd7XhEI5OCnV4Z911MuBx8cW+TTj5mD0NbcHZwxVcXGzr5kgdyUBQDJ2/1SHzPVpniqVI
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(186003)(8936002)(83380400001)(8676002)(41300700001)(2906002)(5660300002)(38070700005)(52536014)(55016003)(86362001)(478600001)(122000001)(110136005)(316002)(38100700002)(45080400002)(6506007)(33656002)(66446008)(7696005)(76116006)(66946007)(71200400001)(66476007)(66556008)(64756008)(4326008)(9686003)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?DgDhz1hicD6o85p1yuKzggusl6FKtuhgKPJYJOqvE9a3DQ+PmhqmRbBY?=
 =?Windows-1252?Q?N+IJ0I1br0gt9lnVk+HQuRPa6h2/cgvFu1+11Cf/cpYgFS9lsGtpsmCF?=
 =?Windows-1252?Q?0qJRUQevDQtxXX33Ali4eMkwantWQhmjEvxN9iQVgskp6OwxOg7Atzwn?=
 =?Windows-1252?Q?qz2ZNBPCYeOKsjN7XP+cCkroQwuZFoIvF0v5KOunMvl9+6VP3HU/g0iJ?=
 =?Windows-1252?Q?3P21TUoIPHDjwX3K1B8I2o/LnewQY9rZ1zYlgY1g3B3q+VTPYfJqzimu?=
 =?Windows-1252?Q?1mVCuUHNCWhQCnD+PJ6HKkgbw/9DIWK71eCx7MHnUqWs4/F8jy4aiJd+?=
 =?Windows-1252?Q?lREDbvqHQGs3JbpHrdDbqO1nsu1REb3utntswZkGtCevNHQu4Q8MZGZt?=
 =?Windows-1252?Q?kVPN/8PQvfqog24ASIRoWeCEgxBRzurH7BKwENuMPCHH/HoqVtMAyDAy?=
 =?Windows-1252?Q?j4wS442OGGmbs8JeBT6li3D7QtgPVk70hrVelg6cWwiIePS2+hDpRaEY?=
 =?Windows-1252?Q?Cz682ZdU40Aei0D1xZnNehN6lnUozS5z7Cvg4NJBW3c4F06VsiDQBO6F?=
 =?Windows-1252?Q?2dZ8xYjfom9ZgES1bHdaCW5IcVWOGOSl6zWh+JgvG1riARhcadhiBztr?=
 =?Windows-1252?Q?fglPBZpDSWEIgyAASjvS3VGNFiftITa42ZbD9C35kt0uQlQWV3FYQk/v?=
 =?Windows-1252?Q?Xmw3JtTdM/T+5X/8oPF7PJ8pUgmcH/4OZ473Wvqh5br08u+zg4qwhaJO?=
 =?Windows-1252?Q?BdKfXNciQK7jGlDFc2nzFho93CR/tMbP24UoO/iW23Ob4ohb53GTxy9K?=
 =?Windows-1252?Q?Wai3BU8R4STbt2lI/Hu5vN9y0XSZoLr00V0u4hhGAh8yKqKxbdSK9ZYm?=
 =?Windows-1252?Q?F44r7MgLNmnM6cBAd4s4AhyutCQCRhlXYC8/p2hb3dk/rYP1rX21APZq?=
 =?Windows-1252?Q?DK8pKa0g1ivGPhSSS6Pgk/JoWGr/DHwjTDEkm4ONLIfheWYTWVYlWkmi?=
 =?Windows-1252?Q?Mpr+ZDgrhTG7XfmzO0rSJcZG466Nqx0kV66g2DUi4Q0jBTvdFSHthjz2?=
 =?Windows-1252?Q?WCQ6xz68QhK6MNt2wAkF3gsIT0vp9EGBko2OfaRKyoggxlTN8J79K1VC?=
 =?Windows-1252?Q?8U/lOim+9tAWgGo8/Jb9F7O/rwrvaWCK99bZDStZt6tD2wR4CXjF/NdH?=
 =?Windows-1252?Q?dsS+A0jSC+uPO1ZIpwciw2LHiEKGVEfl99tDYSWDcgD9G5HPLVhKtbdD?=
 =?Windows-1252?Q?iDHRlDmpxglLeBOCD7bud3HBYEUSRc3jX77VAFvTp93fOXQgQ5JQaRqR?=
 =?Windows-1252?Q?yfZjf+sNHCj4bpjZgZqXCu1iIi0fX47jNOSmLg39nQwoQuZaAUPWjVEL?=
 =?Windows-1252?Q?J0b5n3wY1h1BtdL4kN+hEdjaninRQwxqr0misGD6FXiEWXSJxC0MBtpH?=
 =?Windows-1252?Q?aUaAfpHXFBnPCd/YGN57agi2s4+IXM3UXx1Reomdtq7DGw+Gwd1lcR+4?=
 =?Windows-1252?Q?GdIwVKLdGcq2Vo3FxUrUW2X4BY3l0e1YaUAVVDxlTJ204wmrGD+5wKBY?=
 =?Windows-1252?Q?51p/EoCCpgEqvaHiZgn8enpbhsCBKNIEeVqAgyuZbhwr6Yv6SBhNmHGK?=
 =?Windows-1252?Q?Cl5ZuO46YqOfbfvte2q3puynlfSkUdY8iRDmq3Th3FH5MyOAVFqj4tSQ?=
 =?Windows-1252?Q?M61ncXe7VGY=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bac3f8b-97ba-467d-66d1-08db933c9d0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 09:41:14.4945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zrcrMIcwn57zAu//F7HcmrTeZatc7BmwAUv61p3PuVXg/TfIsE+TOPLt91PSWzqr4i2E2dfjxpaJUgomB5dbhuvO9l7uxJObtB054ZsHKuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11886
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Aug 2023 09:41:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12534

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: Wednesday, August 2, 2023 10:17 AM
>=20
> Hello Pavel,
>=20
> > From: Pavel Machek <pavel@denx.de>
> > Sent: Wednesday, August 2, 2023 9:57 AM
> >
> > Hi!
> >
> > There seems to be something wrong with testing at the moment:
>=20
> Thank you for reporting.
>=20
> The build container tag we're using got deleted by an automatic cleanup t=
ool.
> (Same issue as last week).
> I've modified the regex being used, so hopefully this won't happen again.
>=20
> >
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-testing%2Flinux-stable-rc-ci%2F-
> &data=3D05%7C01%7Cchris.paterson2%40renesas.com%7C412cf68cfe8b427e0c
> a908db93394891%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638
> 265646826474582%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
> LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&s
> data=3D8dn6HNThUS31l8iHrbVWKqXvcPKfggN7Z944u4M0eEk%3D&reserved=3D0
> > /pipelines/952990993
>=20
> I've kicked this pipeline off again and it looks to be working again now.

I spoke too soon.
Our "build" jobs are working fine.
Our "test" jobs are not. For some reason the "small" EC2 instances we spool=
 up to run our testing jobs aren't being started, so our test jobs aren't b=
eing run. Grrr.
@Adler, Michael, please could you investigate?

Kind regards, Chris=20

