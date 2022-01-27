Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281FAC4332F
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 11:17:06 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.93])
 by mx.groups.io with SMTP id smtpd.web08.26841.1643282223870327347
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 03:17:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Qxy+9rDh;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.93,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReUCPP+PKJf7PnbQxCG3x3Ug7S0v8/FZc084o6/uLUn11rf/Szb8ulTukhyajV4jWvGE7OQL7IRRKu3IFfodV9zTBh//HbXemIqg75ucdyUZ5UoonNdKfMbhnOxabwYv3zF4xm5aDR2dg1Emisgndaqad0uSklHfl+vrlhBC5arwfEvtAwzFIqwUkdnZi51dAlTJOKIwsD+Ylwd9oRaE9GqkG4W+BmgWz3IzIVEiE2j5vKBzHJ0eWJpMeJwSmjeYQjSa+5OdST3JV0RyR9ZTAEENeGWEFaeoTjFs9NjvLIv4dQGVfDzwFbyTlUX/fWFXWRsyYdeEjDJVmeDIniqy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtU57s0ulRGOnybqdSftzrOuBSo5InAvIC8cHVhaukU=;
 b=JG+Szp+u2cETBjTIS2VhlpxuKBz4ywU7i7bXbsoRK+rGxzo6ocG+fJ7rpmFVU2h+G/S2Bi/WzcWfBdUg3jGIufw8b9pVw9IfGxdQgSez5qy9+yRNc0p8L/9GjNqbwhMEI55bCxQAZEp5G3fm1+yGz8iAq8LevTFNCnJBWrzB+G5IzHrrQSF4PT95KJ1aKgwDY1gWZdDJjqhhB/h89AOD2r42F9owCrFBxbFuQ6rp3CNNkjHXwW1g8JhG4smdMd0OpCs5TGLVOaCCL/iu/3PJzrX1yFPw36GnAwPPv6br1hweZdZblLnUTW4m5k6DbpV+z9RM7bif8o0OrBuMtJ3E8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtU57s0ulRGOnybqdSftzrOuBSo5InAvIC8cHVhaukU=;
 b=Qxy+9rDhkqTn39yKOIB8yEnGsUAvjS6QiJtnV7MaUobJii1t1sCjoY80/ro9GIxakLB8c5Rj/UAIDgKOXIjf46DShkwbhmx97uDaJVWr8KDbaqPy/YmxAVIyLPKs5wEM08Cd0y2qOdisQ1WwRz6QppSZp3C+OniKJDkt3Euh3c8=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSAPR01MB2737.jpnprd01.prod.outlook.com (2603:1096:603:38::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 11:17:00 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::a5a8:3660:7f57:43f7]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::a5a8:3660:7f57:43f7%9]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 11:17:00 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"pavel@denx.de" <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] can: rcar_canfd: rcar_canfd_channel_probe():
 make sure we free CAN network device
Thread-Topic: [PATCH 5.10.y-cip] can: rcar_canfd: rcar_canfd_channel_probe():
 make sure we free CAN network device
Thread-Index: AQHYEvJ202eby2TASUy4nztI+sVchqx11GWQgAAHWACAAMGyQIAAGy9A
Date: Thu, 27 Jan 2022 11:16:59 +0000
Message-ID: 
 <OSZPR01MB7019B08D49FF5F6BE9660266AA219@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20220126202213.31975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYAPR01MB625274BC4EFFA92D99EF211792209@TYAPR01MB6252.jpnprd01.prod.outlook.com>
 <20220126220524.GA26019@duo.ucw.cz>
 <TYAPR01MB6252F0114D31EC9C5D051D0F92219@TYAPR01MB6252.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYAPR01MB6252F0114D31EC9C5D051D0F92219@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8c651fa-aafd-4f8c-7fab-08d9e18689a8
x-ms-traffictypediagnostic: OSAPR01MB2737:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB2737FE565D5A042DB4A09472AA219@OSAPR01MB2737.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 h/z67r2wApI2TRQpwv0/Hj+cY33wDVydHUF9XGBPT7NmyLHgm2/7KR0ecpbEO+Ve/xvmqeTU4AvDkHHT7ac1CZl1S4s+1YYRoVZUnv5VVlfwlFuKzk+5xQXRNGuoUcip7CKgXZEF+xss2XDm+6GD3Ata9vOYLQvjN/IdI8DhGhHpmyskNbjIgmrHOb+ejFv6ZLdvBhXhNIn69DJKkTXBG0YEjGYJBYaBUVbTJeyC9bpNFPT6QMV1OyxG1pPyedfdecBkJaiMe4GM6RqdZHQVMd5O7Kt4/a1mzijPOqlFJSY5+mP/XrBAmu54N8qxtb8qi2qbWYKMVy6hm8kXKzDgRJXU9BF+ttLuu8fNwwLLnFOV4eaeUkSMZm9AepTV0NBhGfUIXlbte+DSMsgEMmUtrNkElLhdKshMnwXCB9gQ1UB18hgfKbSUgU6k2jgw5cjZ2Pe10iS8u+GB4H5MIp4uhsJLSosOslTdvGiKQS505SlWq85sH863q5eE2jkiQG/TGYAKYlWWJcjsQt1fT5M/JNs8VXOYosLRSDCxl6Ji/GgKwguPq4PvKAAdejQDiXOP8ATD/bfB6ql1yiBdYfTZGlRq/5YO1wqYF8aFN4FsH5BbB7DNRRAdbwVdRVH61xJq+a3TyqjSVuDBYeAxhdT1ZQrS6eX+k4FiMPcYFot6gw6L5bM2d+iJTpw+imbFi/W1V4cEE1LodN+x7aMi89Yret9J9W90bz09sUXEE8X2XIn84WgU/LsiiBz7yAM7jkoRojW/PwzHWBVYcznWmqtIce2Zeod32IRIEf3NtPI8YAY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(5660300002)(76116006)(4326008)(38100700002)(66946007)(107886003)(26005)(186003)(66556008)(64756008)(66446008)(66476007)(71200400001)(8676002)(83380400001)(55016003)(122000001)(8936002)(110136005)(9686003)(38070700005)(33656002)(966005)(86362001)(508600001)(7696005)(45080400002)(316002)(6506007)(54906003)(2906002)(53546011)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?c3kweDN3ejJwUk53SzlOVEoxRkt4VlI0OS9LU3RFWFBFdEhaV2luT3lz?=
 =?iso-2022-jp?B?dlhMeFVXZnZuVnlkTmpCQ29xcWp4MGh6ZjlCTlFYOWlsdXRhWU9tK3U0?=
 =?iso-2022-jp?B?SWdpVmwwS1I0UDNUVWlRRTEzRXFCdG5EN3FrajJpSTMzQUJHSWVoaFdj?=
 =?iso-2022-jp?B?WCtWTGpKTnBvNHRpZG81eEQxbnpFaWRmblFkdE9QbWZFR3J6cmZLZ1Jt?=
 =?iso-2022-jp?B?OVVuSm5CcjFjM1U4ZlYyeEEyLzJMZTNzOSs2b3ZlSHJ5Zis3ZytLUk83?=
 =?iso-2022-jp?B?QUE5VDFwS0VndjAvQmQxU1dsV0hyRzVTU1JlZldlc0hqQmp5SnV4Z2hm?=
 =?iso-2022-jp?B?N2VqQjQ1TEc3bE1Rc3lXMGI2WTdQWmtUaXRpSmprc2hZV3ppRlNyTVBN?=
 =?iso-2022-jp?B?cEd6V1RVeGQyVFdSWlpqdDRYY1ZIWjVuWTdwNDRXQTRPVlVFNk8yTkM1?=
 =?iso-2022-jp?B?byswRnpuQjRrdWNHQmd4SGZlS3k1UXpHaWpMdDlmbVdHZy9YS0xwbjNp?=
 =?iso-2022-jp?B?TXo5SnIxUTB6OTUvemF1UjFHaGNzU2ovOFRjcjNpYndZbVpoTjNZajE4?=
 =?iso-2022-jp?B?R1Z2aU9VU0NQblVOVStVUm1lWlVqMVFmb2FPK2Fac251M0VmczhaQWlo?=
 =?iso-2022-jp?B?MFJib2ZvRTZiRGEvaXhaWE00MDBuYWZteGN2alBRNFIzd0taZUp3WjB3?=
 =?iso-2022-jp?B?bnpXQ3cyZEZiMEp5cmtkZzNkZ21aWHdqR3psaUorSUxmci9HejN4RUhF?=
 =?iso-2022-jp?B?Q3RZT2ZsTEJsQVFkcWFLaWRRcnR1RTdST3I5NEFhVWFDbEM0RzJSdDVT?=
 =?iso-2022-jp?B?RXo0ZVVQbnNpR0xNSHlDRUtzTHhqbzhtckp2YytNNEs4dUIxTVNTREh1?=
 =?iso-2022-jp?B?SFIyanVqT24vT1VQMFRaKzdrdE5ONzhkMzNVVy8wRVZTKzBkakRhWFBp?=
 =?iso-2022-jp?B?bFZjaFRNSVY5d0NJbCt3eitVbnNmL3owSFV4bXVsWXgwc3ZpK2xjMjQ0?=
 =?iso-2022-jp?B?MlQxZ3A3clBIYmhaWDIyN2tUdDRHQ1o5Rkh3b3U1Y2NEcU14RUordkxt?=
 =?iso-2022-jp?B?eHVvUVlDMkFES2NTb2o5dXVDZHhLM3dzZ0k3UEJlNmc1KzNnTWhaekZz?=
 =?iso-2022-jp?B?dWtEcHR2VzdiVXNrT3ZSTjVia0RGS3RzU1pCTi9DS0U2WlY5cjZQblRy?=
 =?iso-2022-jp?B?cXdIR3ZMa2w4TTZkcFZsTDh5L0lqaWlXWllDY2U5ZWhSVGNjVXd3VUpR?=
 =?iso-2022-jp?B?bEt1dTloQnppSU1pV3hpTEFuZjZESUhKbm1tYUNYTVlUNGZ0TFlCYWdZ?=
 =?iso-2022-jp?B?MEF0bWZKcHlnbXZWUU5JQVZGdE4xV0NubFRoZEV0K0duQmlnRk9uQTdE?=
 =?iso-2022-jp?B?TThVRVo2ZEphM2J5c2daRHRYNGpaL1dsNEdLR0Q5NHRFQjN3RnpWUGFn?=
 =?iso-2022-jp?B?bnd6eDZWVjFFZ3Z5STJnN1RCazgxcGRZS0ZCMUVSd3NtUkdKTlErZE1E?=
 =?iso-2022-jp?B?aElLcjJSUDhJVFIxYTRQMmRESUxiMVRya2l4dGJKVTQyMkxKRzJEU2JU?=
 =?iso-2022-jp?B?TkxpUmY0ODVmdEVVL2VsQi8rMk5GV25yTGxEclRzS1A2SzREc1ZKVDM1?=
 =?iso-2022-jp?B?RjBRcDhLUWY2Vll5QWhqd0Ixb2gwdmRRaU5QcGdKWm41QXB3QUhpZG9s?=
 =?iso-2022-jp?B?b1Jib2hlSWQ5TTM2Y2ZlTU5BdE5CQzY4V1h0OFViY1FmV25VTDMvUzIw?=
 =?iso-2022-jp?B?ZjBDNkZKRFpzYlJHbDJrNjNkMkJGRklGd0Q4Z05zbzhZNzMwL3QxYjJw?=
 =?iso-2022-jp?B?MmxZekRBV0VYVFgwVUdLQmVOZlArQndtdGRlRjhGbVQ3MW9wTlhybmZo?=
 =?iso-2022-jp?B?M1B5Rk1uK2xTdmh2bzdsaGJReUdTRFlqZk5hWld6SGhvTHdiTE1iNUo0?=
 =?iso-2022-jp?B?enNsVVNVZk10YjlySUsyK2VZdHJkNERETHZCNEVTeC9XRFBnQjVnYlV2?=
 =?iso-2022-jp?B?Q0dLMTkzQzBNZnpHQ01BVGRZRXo0cE45SDRBdnlidFdPNnVONkNsR0lo?=
 =?iso-2022-jp?B?NHpqZ2c0alJmaHdKWEM0RHpHZkloNGZrdmhsK2N6SjlKUStMaDhMaGVD?=
 =?iso-2022-jp?B?Y2pVeUR0Yk9LMi9GclBwVzM5R3lBem5lS3pEVllycWR0clQ3N3VpWXlR?=
 =?iso-2022-jp?B?dy92YW12WUx6WlpjRFR4SkYzV2hmUXVtQkZhaktCOHJiUkxlV01jdU1M?=
 =?iso-2022-jp?B?MElnUkhTNzJNMytHaTY4RE1NWThobzZ5U3hZMDlKZUdTdjJiL2pERGQw?=
 =?iso-2022-jp?B?L243MFYxU2ZUSGQrM01XMVEyanB3MngvWTJuTGZqMTBnMUZOZHdYZEdu?=
 =?iso-2022-jp?B?WVMzbEpaeWtaVXVHcjJrUVZaMHVPa0lGeUp3aEtIUVppMm1uQTY5eHhZ?=
 =?iso-2022-jp?B?aDBWdmJvZ3pWUEhTYTEySFNqdkNnMFlXV091Mk1YYzNWQnF0VHY0VUtl?=
 =?iso-2022-jp?B?OFA2TkZBUmNuRVBrUU1BS1R2QUdBUC9ROHp2UT09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a8c651fa-aafd-4f8c-7fab-08d9e18689a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 11:17:00.0399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 SYUBqRimdkUzKRO4O488DJlEx0EzrI8NetAqBX7kNjLKkCNUYUiZhzNcjR8f/Apq4fzZin3mBCOyNsng0bjeoFSEomoB5KTf5hluoSdxLkcDmFvez023VU1SsrgD3pDl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2737
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jan 2022 11:17:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7500

Hi Nobuhiro,

> -----Original Message-----
> From: nobuhiro1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: 27 January 2022 09:40
> To: pavel@denx.de
> Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; cip-=
dev@lists.cip-project.org;
> Biju Das <biju.das.jz@bp.renesas.com>
> Subject: RE: [PATCH 5.10.y-cip] can: rcar_canfd: rcar_canfd_channel_probe=
(): make sure we free CAN
> network device
>=20
> Hi,
>=20
> > -----Original Message-----
> > From: Pavel Machek <pavel@denx.de>
> > Sent: Thursday, January 27, 2022 7:05 AM
> > To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C=
#T=1B(B)
> > <nobuhiro1.iwamatsu@toshiba.co.jp>
> > Cc: prabhakar.mahadev-lad.rj@bp.renesas.com;
> > cip-dev@lists.cip-project.org; pavel@denx.de;
> > biju.das.jz@bp.renesas.com
> > Subject: Re: [PATCH 5.10.y-cip] can: rcar_canfd: rcar_canfd_channel_pro=
be():
> > make sure we free CAN network device
> >
> > Hi!
> >
> > > > make sure we free CAN network device
> > > >
> > > > commit 72b1e360572f9fa7d08ee554f1da29abce23f288 upstream.
> > > >
> > > > Make sure we free CAN network device in the error path. There are
> > > > several jumps to fail label after allocating the CAN network
> > > > device successfully. This patch places the free_candev() under
> > > > fail label so that in failure path a jump to fail label frees the C=
AN network device.
> > > >
> > > > Fixes: 76e9353a80e9 ("can: rcar_canfd: Add support for RZ/G2L
> > > > family")
> > > > Link:
> > > > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
F
> > > > lore.kernel.org%2Fall%2F20220106114801.20563-1-prabhakar.mahadev&a
> > > > mp;data=3D04%7C01%7Cprabhakar.mahadev-lad.rj%40bp.renesas.com%7C2a6=
a
> > > > f30f6f9344d87f0508d9e178f087%7C53d82571da1947e49cb4625a166a4a2a%7C
> > > > 0%7C0%7C637788731814018904%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> > > > wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sda
> > > > ta=3DirBP96Ho%2F7f4miUJe5UxR1%2BfbWJmTI8XsLXzT9DLid4%3D&amp;reserve=
d
> > > > =3D0
> > > > -lad.r
> > > > j@bp.renesas.com
> > > > Reported-by: Pavel Machek <pavel@denx.de>
> > > > Signed-off-by: Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > Reviewed-by: Kieran Bingham
> > > > <kieran.bingham+renesas@ideasonboard.com>
> > > > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > > > Signed-off-by: Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > >  drivers/net/can/rcar/rcar_canfd.c | 5 ++---
> > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > > LGTM.
> > > If there is no other opinion, I can apply this.
> > >   Test:
> > > > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
F
> > > > gitlab.com%2Fcip-project%2Fcip-kernel%2Flinux-cip%2F-%2Fpipelines%
> > > > 2F4571&amp;data=3D04%7C01%7Cprabhakar.mahadev-lad.rj%40bp.renesas.c=
o
> > > > m%7C2a6af30f6f9344d87f0508d9e178f087%7C53d82571da1947e49cb4625a166
> > > > a4a2a%7C0%7C0%7C637788731814018904%7CUnknown%7CTWFpbGZsb3d8eyJWIjo
> > > > iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000
> > > > &amp;sdata=3DQpo7dEOIdMguVEP%2Bu6Hxcd5SKJrdD%2BVSjBtsc2XVd6Y%3D&amp=
;
> > > > reserved=3D0
> > > > 23034
> >
> > Looks good to me, go ahead :-).
>=20
> Thanks, I pushed to git.kernel.org.
>=20
Thank you for the review and acceptance.

Cheers,
Prabhakar

