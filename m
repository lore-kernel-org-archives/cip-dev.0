Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17928C47074
	for <webhook@archiver.kernel.org>; Tue,  2 Jan 2024 14:14:48 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.130])
 by mx.groups.io with SMTP id smtpd.web11.29571.1704204879725663468
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jan 2024 06:14:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=XgWE8sFe;
 spf=pass (domain: renesas.com, ip: 40.107.113.130, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Il+2eEAvZPkeIXZl07nOGrIyAgkzKv4hKFMCZqe5Ei4s44K6ogmcqAWoqb60MtF2kzf1K9PQMu+9NOxQLC28l2r/7KMPDKLEc7Nu8+buQO2L7bVEo+B7BDLrdsD0F5Yr5b5U/0UpW2ZOhPnvfOqeF/9fC8EjnIBzDiFu0NFyuXLe02OgeWv9A5Ad5Ha5qMaq13Xe1v5PEHXDY87Kz1MqZS6FwQgNcbCzrTeF9zvS36D0rUywaHqn14Tb9ezDBggAdPLzJr9hMKCWCRTYEkTDcIYDK+APD62zsacJgdVhV8nE14Ijj6JstOP9SzwKtuCFsJyp+Q5kxV7egg6raGAhag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YMs7yIGdHZD7swBU+qo7IDDg00mkq1rTNVshSaSpro=;
 b=NNEPsmkm6JHVdUvU6YgZx9mVn+e3UEMPP0A3H7EEmjwUlRMTj6oOjpkQUNAoH50+OAb+aT7m3MYzXFT8z4E5nXC2bvTq6QUE33yyU9cIFmIBtI7/0LswSyUQNSCeEuyme7nfns31N83KpPLUgjIjo26sm+i6lkr0PudiUwgTR8THdWJItS6obnrrIqN7S9S4QJojHrDb1UD6WZOAtErhrB+C9jxnzKe3iMdHgMqTcSE2rY0IN/1zCsnLMQa99Bo9ke9MuvR524bkDy19m8JK55TWYcFzgqTDF0tRJae4FL2Gb90cJOLP2FdIyMq7eC/z8ezfh80qlCbzIqr66MntJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YMs7yIGdHZD7swBU+qo7IDDg00mkq1rTNVshSaSpro=;
 b=XgWE8sFeB8bZSEkgDS8zGWqy8Ba8qrs2ryZgQcCbRROsSjXTVaPRpft6VPYI9MdOsuQoQGH1LwwGj7lAmsXsj6c+ZrGrbfY7K5jegZVqsQosSg6JVLGVIYeMpnV04HkGsJEmwjUNURsXb7laBncLk5wnVueb65552aZ95ABsNzU=
Received: from OSZPR01MB6816.jpnprd01.prod.outlook.com (2603:1096:604:13b::10)
 by TYWPR01MB10695.jpnprd01.prod.outlook.com (2603:1096:400:2a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Tue, 2 Jan
 2024 14:14:34 +0000
Received: from OSZPR01MB6816.jpnprd01.prod.outlook.com
 ([fe80::4c94:675c:ce4c:7a49]) by OSZPR01MB6816.jpnprd01.prod.outlook.com
 ([fe80::4c94:675c:ce4c:7a49%5]) with mapi id 15.20.7159.013; Tue, 2 Jan 2024
 14:14:34 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Pavel Machek
	<pavel@denx.de>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH RFC 00/30] Add support for Renesas RZ/Five
 RISC-V SoC
Thread-Topic: [cip-dev] [PATCH RFC 00/30] Add support for Renesas RZ/Five
 RISC-V SoC
Thread-Index: AQHaM5k7JdyOQAEPd0KfaOxnME5fYLC77lCAgAFrJgCACOVAAIAAYM+w
Date: Tue, 2 Jan 2024 14:14:34 +0000
Message-ID: 
 <OSZPR01MB6816A87ADFCB148C8F45958FB761A@OSZPR01MB6816.jpnprd01.prod.outlook.com>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZYsdtS4UkTS/TUsH@duo.ucw.cz>
 <OSZPR01MB70190DB7501F1983008CD843AA9FA@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <61b3ccc2-84c6-40cf-b1ae-fe2966c04a93@siemens.com>
In-Reply-To: <61b3ccc2-84c6-40cf-b1ae-fe2966c04a93@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6816:EE_|TYWPR01MB10695:EE_
x-ms-office365-filtering-correlation-id: 80c147fc-3c40-4e8e-d16f-08dc0b9d2537
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 SNmTm0EaYjg+y8dZrSxy+UUECMqdVj7QdLMeVj2BlK/TDz9vk0L3YkFVnyULGGx+GfhtKSeN57PI3pEBkRlKP2sBTujbr5uHXbLHYWoBnoTJAtrPNd6sv9bDNDf20GhWtYQzHqSGGJLG7WN7kLGOfXE1VD7vWcNqBwgB1UEMjpdWvPw/9Pjv42ivuUyA4Un3DosiEwVXmMSFJWA8Y1v5bk8SHEv9wZLqXWEIcIYYJ5QEGLQ+ZQVWXfSnP2HH8VeQ6/s5Ecw6Q4LuNp/81lJHFO8WMVhbBlQ841lG3Sec9OezPHg6UMqbvNiM/cRfWBBTYAbB14XvP70YcoaKzyaMvMopBHTCOyJ1tolluxHAdbyNpNq5HdHkwH60kqmVCBbvDeDWc7beCc9aD+6l6Ou9hblJkOxnQBMFslnJpVr6CFcRxxm8W4qltN6xVBZNYK19XKLQhOfpK2vXFEUypb1Sk3KwREUyXmpzWmGbhr31iuzKQGKCsnIE9Zls53FjTIiET8nzOQK0n1SDG/NoSyEPDVWfeUx4TABEez12SM8P/T5qdJMzEgHSxToMo+Z+QjTP4JFI3DJZPDnn3+iLD1EbiAIGIU6XPUPKLvanXHLSuL3Ns4wfkk7BEfrWjE+TSSxH
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6816.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(39860400002)(366004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(478600001)(45080400002)(966005)(8676002)(316002)(8936002)(52536014)(54906003)(4326008)(64756008)(66556008)(66446008)(66476007)(110136005)(66946007)(76116006)(83380400001)(53546011)(7696005)(71200400001)(6506007)(9686003)(107886003)(5660300002)(2906002)(41300700001)(33656002)(38070700009)(122000001)(38100700002)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?49GxM96d/Mll7+75QSh5Uq/+FFxmd2DhmgdzizeQ8BJHUxm4XHcLnzxI?=
 =?Windows-1252?Q?UBdqyALfPPmUOsTboWktCixS5lqiqYjnbV4ft/x+L/EYT1CVZmkf5rk7?=
 =?Windows-1252?Q?MNbmBxA5940QdoFfd3fModu9zoM1lWa0J+REkMkyoqhiK8lAW3bqub/r?=
 =?Windows-1252?Q?UjOiy0Qkx9l4zyThHBWKlpk8w6tlAyp9+OpXhNBqYCu/G+V1AVg/tCGL?=
 =?Windows-1252?Q?mAXDVcNBBZalERNz2fguG6ZoRhO1TFqYs+LdyFo1XyX39kgGJAiz5Pxb?=
 =?Windows-1252?Q?Bt9LXp2IH0GDR01LnghRPTFyD0zf77iaVozdiYRblEWPKTfY6O5/1T4u?=
 =?Windows-1252?Q?fVdlHqbOTlTzUlg0rTS33J4iKP2NfoG1dVU3NdnCJFpunmqPpaHQO66i?=
 =?Windows-1252?Q?ML4PNzBSRwArzsqg+aqM3r11IEzJGOYrj/6FPjtBXxnsyx9VpHejx/N9?=
 =?Windows-1252?Q?3Bdnse8u935txpcMQTi8+L1m+EIDZ3Lngd7gjt9a0UUYukTuzkMZH9z5?=
 =?Windows-1252?Q?2hEPhiiA5Dhv+FrtPgTJYp4xH3xUpLMsyebb/F0ME2U1uyzKvAaZBmoo?=
 =?Windows-1252?Q?j6N0/Xv+rLqcecMRDzvpTT0BfA164ptIsd16vxvb51Pb2h2JvjkZ9HRy?=
 =?Windows-1252?Q?gTWKWwkaxqaJVt3DBxGElfYljPKBDd5pEIB7rS1D5XXwG7DSa886T19X?=
 =?Windows-1252?Q?Ax29x7JVdyNYf53BdIwy2GCk2+gUm4btKx2GwFoySxwyr4tg5aY8w94+?=
 =?Windows-1252?Q?d2IWRhASfCZwliDefD0Y/hZfcIoma2zijd4gAfPaRt5AFlgzKG2zvssv?=
 =?Windows-1252?Q?3SZv5fNT1x27Q7LuKyiHhRSvH1EOBki+G5q6BURZ9P9zgkMLoYIbgcX1?=
 =?Windows-1252?Q?chfwP0eelC4AmPkGavO2zfUW4nIlFiG5ZxoiX/0hA24xroAXy7fuexnH?=
 =?Windows-1252?Q?vZziZMIl6YGZRXqyKSK/c6LEN5H9bde1NtsWpR9d4jR3LYHOt5/0knmh?=
 =?Windows-1252?Q?Xye+m3yMYanUAz/SPwp7dRKWI6SfrGVXL0Q3erHP27Mj5Qj1WBBcBI52?=
 =?Windows-1252?Q?mJon9Y8lp690VKoXBYX4Fli0XwWhgAa+7IvsHog1KOiQaCuJ9XKg42J1?=
 =?Windows-1252?Q?0y+y1TSjGCiTPQ30xwfjqptrTiiyMpqmFyi3Ea0ymGZJaMgZauz46mKt?=
 =?Windows-1252?Q?zErVxbAmaRnCIgOqWON+dYrQkBu/hJVjB/E/pisRV2MyUSGP/DTul+cQ?=
 =?Windows-1252?Q?EMDrCVrFYw1h+U7hvCuw/7IrH0POWHdUhhfHgt4a3EmMpcCdNp80TGN4?=
 =?Windows-1252?Q?NLtLIBPHz62yKLC1ve5WPe1i09obHpJ8n0a/PCwnLmTHrbkZH+fP+KAW?=
 =?Windows-1252?Q?oqcwPO/TY7aPAHv31RVwKFvX1CDbkKXQFwCnxlisGShndGIZW1mgf4EJ?=
 =?Windows-1252?Q?zTfO6SE2y4nvKklvX9w3xnx8BoIX97sL0VzqQ3Qu0nvsL4PvHaPh/+k/?=
 =?Windows-1252?Q?k9bUROPSqMi3NN5aH/JuAuxN0RcbhcpJrOkdeJt1jc1EyossFurdzs5T?=
 =?Windows-1252?Q?8vzF6LM6DkklsDOOAuccN0QAd6kCkfguce3RYTXebgO628wi4f+twpVh?=
 =?Windows-1252?Q?6pjhpO8Gg4C5aJR1La8izuzT9rR+UqwxZ0L1e+FUxNzemzpDkKMIM2go?=
 =?Windows-1252?Q?9EO8pFijkpY=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6816.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c147fc-3c40-4e8e-d16f-08dc0b9d2537
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 14:14:34.1715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ftofyvDLnQOBKVs8fFdjS47g8ZMSueO7ipy7uRtOTpUlS7/6QI1ykLTWfisTYHwitD1wKzMRMbIkC5dPvREgj7CBq3F7YP4adonwstWkYOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10695
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jan 2024 14:14:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14230

Hello Jan,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Jan Kiszka via lists.cip-project.org
> Sent: Tuesday, January 2, 2024 8:09 AM
>=20
> On 27.12.23 17:18, Prabhakar Mahadev Lad wrote:
> > Hi,
> >
> >> Hi!
> >>
> >>> Sending this series as an RFC mainly beacuse, as the kernel image is
> >>> not generic to all RISC-V platforms as the HW is noncoherent.
> >>
> >> Does the hardware also have the "low memory does not work in
> userspace" problem? How is that handled?
> >>
> > For the local memory issues (ILM/DLM (Instruction/Data local memory)) w=
e
> will need a similar patch [0] to cip-isar-core. Note the cip-isar-core im=
age built
> with this change [0] can be used on other RISC-V platforms.
> >
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu
> b.com%2Fprabhakarlad%2Fmeta-
> riscv%2Fcommit%2Fda749379155980d1f906d8632432f35a01a9c9a1&data=3D05
> %7C02%7Cchris.paterson2%40renesas.com%7Ca5d360a701164419501808dc0
> b6a1e2b%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C6383977975
> 99811411%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DdY
> DnQGyt5JgcvbN2tCqYh7Ba6Tt8vEKooUjU0qBJ2do%3D&reserved=3D0
> >
>=20
> Just to emphasize this (again):
>=20
> Debian is not Yocto, buildroot or Gentoo, and we are not done by
> patching and rebuilding the toolchain. Unless you can also provide a
> reasonably short list of packages that require rebuilding after that
> patch is applied to binutils, it will not be practically feasible to
> address this hardware design issue via something like isar-cip-core.

Perhaps we can come up with a small list of packages, at least to get CIP c=
ore working.
If this is the case, would CIP want to compile these packages separately as=
 part of isar-cip-core builds?
Or would we (Renesas) need to compile them separately and pull them in duri=
ng a normal isar-cip-core build?

I seem to remember you saying that RISC-V cross-compilation for Debian is b=
roken. Do you know if this is still the case?=20

So perhaps some options for now, in order:
1) Add support for RZ/Five to linux-cip and don't test at all=20
2) Add support for RZ/Five to linux-cip and rely on Renesas' internal CI to=
 test (similar to other non-official CIP reference platforms from Renesas)
3) Add support for RZ/Five to linux-cip and run limited testing with Renesa=
s' Poky BSP
4a) Add support for RZ/Five to linux-cip, Renesas compiles binutils etc. sp=
ecifically for RZ/Five, isar-cip-core pulls in the Renesas packages specifi=
cally for RZ/Five, or
4b) Add support for RZ/Five to linux-cip, patch isar-cip-core to compile bi=
nutils etc. specifically for RZ/Five

Options 1-3 would mean RZ/Five would _not_ become an official CIP reference=
 platform.
Option 4 _may_ open up the possibility for RZ/Five to become an official re=
ference platform.

I'd at least like to get 1-2, perhaps 3 working in the short term based on =
this RFC series, if there are no objections from the CIP maintainers.

>=20
> It would be better - not only having Debian but also other distros in
> mind - to look for a kernel/firmware-based workaround, even if ugly and
> potentially slower.

It probably would be better, however sadly we haven't been able to come up =
with such a workaround.

Kind regards, Chris

>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Linux Expert Center


