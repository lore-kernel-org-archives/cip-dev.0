Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895FFC197A0
	for <webhook@archiver.kernel.org>; Thu, 16 Nov 2023 08:09:56 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.101])
 by mx.groups.io with SMTP id smtpd.web11.2534.1700122188777448388
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Nov 2023 00:09:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=l1KF/MYp;
 spf=pass (domain: renesas.com, ip: 40.107.113.101, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGkXuVylLiujxp2arsQjCJZ3jdC/oNUpboB9igZ91zZvN4HX1eSd53bwhilgGrL7pz8BSDwm8mLLJEApV1aoi7pi0Gz7pRvQ7LKpxowHsvxOYhxDWi61hQXH90DXqyxizFFi6N9kECfv4XlMvnE8msJqV1zp+1M10qjPZA6BHr/SEwFdiBhsF6pEeybpPS1xIH1pLwrdmKCGhQ5QyYkvDbHPgbketziSNa+4Jk+OElTIlUizZN36qAblmgHtPpIuB0LH/GH8BkO9mkey8wZZ5nZR9j1eDBftW1JsfDS072F8J07WtwGatljyXF0gTuZDNl21x+AZK/sZkexUNMMw9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiiQ44gxgKF/w2Nmpak4bFH6dKfEp8UqxoFFztkQSyE=;
 b=eb895h5aIrwJ56MnRVxuW6L21C5E41VxZnMMCdQtucuP6w29foCbrTXA/uSWmxEy67su2+uAbNXcmzjLXvo94pIfDVOufbXTN7jYz70Mq7rGRbPMe3Z0gPO7b9wQyuShoycvvBBFf4p3ytSX2osc4vWzLFxf+nni55UhIaauz3EHOh+NtjzMc5kLd3X7KReJRecUmtOugNvxru/+fwjk4JSD1mUnV9u2477R454HuyxU8lz6CBqKlTnDGO/71d8B4eCo5CKjleeuXzZ54/yI7twkOF5cZOIgNmDxZLm/VQBAw7IXxp/rAvBflO/WtX7nsbEAAcEt7wnnMY54CrH9HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiiQ44gxgKF/w2Nmpak4bFH6dKfEp8UqxoFFztkQSyE=;
 b=l1KF/MYpHp8NLqFs9bCRDxMcpWfi7mCeX70xV003skifY7CtHtANF5hwu0C2tHNV/sv2z16Aej+4G3ZWmD5KhlX5Wl9C7wBN1++B95NqZTwIUXOh4RoB0dxzWr+z1hIltRu4neem5T9V8x4YYk7ypfbVfZkKsKJzHU3o/L3Q3Oo=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS0PR01MB5331.jpnprd01.prod.outlook.com (2603:1096:604:a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 08:09:43 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::6779:9c53:db73:8052]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::6779:9c53:db73:8052%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 08:09:43 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHaGGIIQDa4GTSr9E6QbUJAtILCFrB8l4gQ
Date: Thu, 16 Nov 2023 08:09:43 +0000
Message-ID: 
 <TY2PR01MB37888FB34900B0189EC87DC5B7B0A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <81d07fdb-2771-48a6-9543-c724f3a62fa9@siemens.com>
In-Reply-To: <81d07fdb-2771-48a6-9543-c724f3a62fa9@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS0PR01MB5331:EE_
x-ms-office365-filtering-correlation-id: 036e610c-0731-4b43-8758-08dbe67b6427
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 hDA3oNE15AGg1cw1qIpNqg2OEk80r3Obd0OEcS/4JM31gKdiGngFk06CL7hV9uT8qMApjp5TnTYKT4TmAWDt9pX77zjQJqRQ58ruMA45tN/JKquNlvQAMmJWggKgqpwapWWSgr4GksoaWnSmin4hxSqIhl2EQa61+Wpb1OlZQXESiLg4esWhazaq5KaMXVoCkxYtmkwsv6YWH4inmJOM/RcijS32LVXpGgTZxQgC5/37l/+SDUiWVy7QVYW25k4VhF7PVMBgQIeUJGrM8V9MugaZogcpSRfSQmxpZrHLu3Nq49U/ULnoj6zpUX2A1/KkE71qrLzdmSxE9Qm78JQz6RR6renpFPAIz5Ei9FlvxE5tmRSOt20nZko6LxdjLzf+QBuEsRXwDPcIQaouGUJcQRk3yVPJ2pzhl3oE+qnEnjJPFU6CpZdxnX4lVaXlMA3UsHxst5BSEn62ZMhR97lV9Tab0RvACCII9sZRPFdeLEi3LEDSwTt3raUqjFPH2pw83mUl5nSEReSttq1T+CTqTdBhW22fntImUZ7JOkoxfkrNS7cR6DNd+8KemlL+/rdXDez3iF4cFKu0W6wwnoszT9Nvy0nPcK/6m0/uB7qyY5Wut+W6duwGge9SMptHb+Dq
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(122000001)(71200400001)(45080400002)(83380400001)(55016003)(38100700002)(6506007)(7696005)(9686003)(5660300002)(41300700001)(2906002)(8676002)(8936002)(86362001)(52536014)(66556008)(76116006)(64756008)(66476007)(38070700009)(316002)(6916009)(66446008)(66946007)(33656002)(26005)(478600001)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?aSwJh1Euy5WnhYhCWNnMD7ocJeAIycGf8zEArMO9sLEj8Q/woM1+4X1U?=
 =?Windows-1252?Q?p0a9pREufJeccQXqVp5InnmGbEoLrCQvyj7COYzFtZq/kKhToUu6Nf3F?=
 =?Windows-1252?Q?wVkIPw6ug15mwrSWgP4c2UKhyiV4x3tYuUI90PUa2XUnvaZZePTrPxNq?=
 =?Windows-1252?Q?0L947BYlzNGww9FcXOzdyrE3j9oMJh32geu31sknO+VSvr0CrNM/gJQN?=
 =?Windows-1252?Q?BBxWF5kAK7V8utbdxaC0ddcSP7Evt34XDzvpWqQw+zDPjude2Ny796nT?=
 =?Windows-1252?Q?nZMzkYbb+pgMwUfZugL7MU6jPEbea9b7ChwfCDi2LbSArW1ihLwYR7zR?=
 =?Windows-1252?Q?F+qLJv8Zw3nDqNbbbYSX1CahhgcTBg7LHMEgrYdrbVJoMEWkdZahAo/c?=
 =?Windows-1252?Q?eXHDxmBlCxWj3wIQsEaweW7oe5lzcFKCUjWNGUMw6RsCngrQqIb1KYmG?=
 =?Windows-1252?Q?BTXUP2Rrhoz2oAfURTzshhmN6xrJG3kxaNK3Nd6dqK4gZYpcgtl7jvwI?=
 =?Windows-1252?Q?Ig+MMwy4+vJ4t0MUYeMpcOg2gtvzdHri4IMKdfeqdZx2SeDszU8kqqxo?=
 =?Windows-1252?Q?MugB+vCats+m5hqvhjcGJpyZbr2QcoxO+hxctvVOvlbot/xGE6DdPKic?=
 =?Windows-1252?Q?XishHqGsLzcaa32Ww3w8z73XmxEWJa26c1T64g6jqeAGMHYCpSpL7Jf8?=
 =?Windows-1252?Q?YloYNDvMJ5lrpLiPOxEaNVGsmzCyGPfAonwUk8VV2ZHaPZdm3R/AuTgb?=
 =?Windows-1252?Q?oViFWZ0viv0C8x33gOKR/KHxpaj+UOM7FqKupiJr7HoaF05kafNYWW5D?=
 =?Windows-1252?Q?3jU6eV+7nBOzQwwvcH0ohbmrydSUkwpVXcoiMT8neI/k4Th6ItfsVhb+?=
 =?Windows-1252?Q?OBu2e5thxMeQslbz0OwMsALMwayVXc+nQ1qFszDcrvVGzF4+i9+81CVa?=
 =?Windows-1252?Q?NyAnIwJVWN64mGx3hpqvJ2bgQEXX+clTa/uGWVehG3X5pXe/Wwj+NMqS?=
 =?Windows-1252?Q?ee35sAVDkRa8ApuJmHUp/Xhicv/HA5qQpGgoOGqHSm0vEbNB94rTHWBD?=
 =?Windows-1252?Q?VBIFcl4nErIcepkGFnwo7mw7DMPTVy5D/O1KLy6+4C5Ja6wWRrCjPV45?=
 =?Windows-1252?Q?MYNRDtT63ruMQi9lCc0zjcqYprYXqHEu1+8FTI8siOJsc3mBLOMr6ZsY?=
 =?Windows-1252?Q?gdqSx/Jwi2FiME3/TKiyCYQ2WXs9NOPL6hVCxeyCYlGEcGHYlAtQb4CE?=
 =?Windows-1252?Q?qXELfsEJGJmj4hl3wQ7Exp8I4yv3XicVPsPuyogu+R8HS7noII2R1sYN?=
 =?Windows-1252?Q?ULQuc36YHETr6KoPC2yYgOy+i7bPnRwLnZPez90/bdSTrbfKeG4iGkrh?=
 =?Windows-1252?Q?7oDrSf5SqlstdmpIDjDy4rAfULyGARgMWL41Ococb3HHRO14geenKWjI?=
 =?Windows-1252?Q?3InMMOHZ4FtI3/NzYq0sQzkHbLQ7miudL/QVyhqv43KVQsRRWiqYfS5p?=
 =?Windows-1252?Q?X2q1ohc5UjVWZtlQg2XDpZ3+KCoJ8MtNy3RLNNPQdjTHWPh25JG7bZAT?=
 =?Windows-1252?Q?1aBNThGkgBLBbmyPS3nPNlI48ayd8yBs+VIYNXnRBMe4fHwlrz4/QQSl?=
 =?Windows-1252?Q?5nl+7DRbjTF4OTJEUJMBrePv/0wziK8yjQSCEq3t4f9xbhdC3SVu5cTR?=
 =?Windows-1252?Q?oeYz2vti8Kd33iPH/RH49AHCHbA3K6fYs4paPVIdJ40ico/7ju30wQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036e610c-0731-4b43-8758-08dbe67b6427
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 08:09:43.8192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G2UVtcq4q7mrbvMQB+FKvDo5ORh8W/OPUJPILdMhSZqHdLSTqeUJ3OfRFMuIMXmaHWbogeVPjgWAew0QdhxTntzPLwhGkqZiIgI9csIplqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5331
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Nov 2023 08:09:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13592

Hello,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Jan Kiszka via lists.cip-project.org
> Sent: Thursday, November 16, 2023 7:54 AM
>=20
> Hi all,
>=20
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
>=20
>     irc:irc.libera.chat:6667/cip
>=20
> The IRC meeting is scheduled to UTC (GMT) 13:00:

Please accept my apologies; I won't be able to make the meeting today.

Kind regards, Chris

>=20
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww
> .timeanddate.com%2Fworldclock%2Fmeetingdetails.html%3Fyear%3D2023%
> 26month%3D11%26day%3D16%26hour%3D13%26min%3D0%26sec%3D0%26
> p1%3D224%26p2%3D179%26p3%3D136%26p4%3D37%26p5%3D241%26p6%3
> D248&data=3D05%7C01%7Cchris.paterson2%40renesas.com%7C3b38ad70d44f4
> ce4f92908dbe679298c%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7
> C638357180288956410%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%
> 7C&sdata=3DxY8Jbx7o51ufKvHifD4tIyKOZ17iOOJA21ukSfjAcVM%3D&reserved
> =3D0
>=20
> USWest    USEast    UK        DE        TW        JP
> 05:00     08:00     13:00     14:00     21:00     22:00
>=20
> Last meeting minutes:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fircbo=
t
> .wl.linuxfoundation.org%2Fmeetings%2Fcip%2F2023%2F11%2Fcip.2023-11-
> 09-
> 13.02.log.html&data=3D05%7C01%7Cchris.paterson2%40renesas.com%7C3b38a
> d70d44f4ce4f92908dbe679298c%7C53d82571da1947e49cb4625a166a4a2a%7C
> 0%7C0%7C638357180288956410%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000
> %7C%7C%7C&sdata=3DIIMftwyj23QrBXy%2FQnfOZ4P%2FffVCXrYW%2Fs0%2Fz
> S0b3bY%3D&reserved=3D0
>=20
> * Action items
> * Kernel maintenance updates
> * Kernel release status
>   - 4.4
>   - 4.19
>   - 5.10
>   - 6.1
> * Kernel testing
> * AOB
>   - substitutions for the next weeks
>=20
> Jan

