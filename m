Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A50D0D783
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 12:28:40 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.1])
 by mx.groups.io with SMTP id smtpd.web11.10176.1728649711066901252
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Oct 2024 05:28:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=MlV16GCm;
 spf=pass (domain: renesas.com, ip: 52.101.229.1, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlVw6O7YRQArSfkVGEnjz9jX7Fa4vSrxtb8HvKmV8fzhcITcmIgEGR3d+aZ8uJauGt3NDrbrd+Iz2ti8NwSejNZfMgpj4tvkwSh6uJiwKooggpveIXhs86Ogr484Hw5RCbwJY0EDq8BnhHiHyxw+m4c2KgKSt4hyT5QBbxZ5WncRetZB4mZ7plZqke0/nj+ntJaZkaJG8B+/5OHWgnwpiY7ESY4zXpsaakXrIKh5SHkje7xjvoqwkSlmRth1ziK/rbllHsFSdqAgtfE/1sD4gRGH9fpzhEkIsbZHrZ0dQ5/PtM0gbcjJo8Nk+pmMJyHFXv58DptyilK+FYwQ4qEzjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjP/5g6Mw7Ut+T2qRKlgGQbODcuvwyYkroPfaPIOZbU=;
 b=fNuXdzyqNcn0OWdHhMyTWgxsvSxDWjvIy0BcYbgmABleuDHaPej0NOxWyfbcGXnxT+pBrUbOblKJ8AaO1kHbu/yxeUO84WL9UZAL9X8mxI8ePxF6eG3K9LstUNAhsufmTXhSUAIu3Q7iS0dsK9KTKGfzlJ9vrC0y7G5yKMpJnmTNsUdMe5JCRujBjtftrRUHoU3N/UC3/0HhaP5j4JuTS2Hw1HV56fYnNUd1DwnlWtvQh1JYQLOwpAY37XtJ9akjTYsvY5e7+7MzJI8t1p2xommAxUhaNqHYURAfH+xkUDze1+v+hLDN1ioCNjgZsRpxVqK1wueGTSWeNG9vIalHuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjP/5g6Mw7Ut+T2qRKlgGQbODcuvwyYkroPfaPIOZbU=;
 b=MlV16GCmUVG7u9HfoFKcWPkzcuZoPIUBZ5U9fMMiAQLswZ5frvi5F/hGqD9YSewE85oC7hjjzic46S1ZRnd8BkTf7nyeInDUmREszD0H1HgetLxmS0eWe/Vr+iii/+2Ok5w2LleJ9X8Z9LLrmba/riFaXY29X/HY7U9zhtX3RQU=
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 (2603:1096:604:2e2::10) by OS7PR01MB11427.jpnprd01.prod.outlook.com
 (2603:1096:604:241::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 12:28:26 +0000
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f]) by OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f%4]) with mapi id 15.20.8026.019; Fri, 11 Oct 2024
 12:28:26 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: CIP LAVA server in maintenance
Thread-Topic: CIP LAVA server in maintenance
Thread-Index: AdsbvaofWXTrh3nDT/GQbMaMBC5HlwAG0xmQ
Date: Fri, 11 Oct 2024 12:28:26 +0000
Message-ID: 
 <OS9PR01MB1238956D16899B843B30A7466B7792@OS9PR01MB12389.jpnprd01.prod.outlook.com>
References: <17FD5B142F98A62B.8140@lists.cip-project.org>
In-Reply-To: <17FD5B142F98A62B.8140@lists.cip-project.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12389:EE_|OS7PR01MB11427:EE_
x-ms-office365-filtering-correlation-id: d81176dc-2923-45e5-2087-08dce9f034ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?ENfcmUTCdjXVtmczV8nOPhPN38j2VqnQmDN4Ncpn3bRjtWgGHuBY2xV/?=
 =?Windows-1252?Q?DVo2c6uA4/MwGq3IvmjLUfuv/bqI8zDT+Wf/nOoNmf7TfCnGqUg28GO2?=
 =?Windows-1252?Q?NpYWASS8U0OjdQzIP3k/xnhNnCuJdEBg/6/8NuQ4zCQCMviCUVCm5vXQ?=
 =?Windows-1252?Q?/w4a0r6uPOwg6LtnT0tsy2Z1SH7agnAG+985Ln6Lh//CpvAo0QQT68ip?=
 =?Windows-1252?Q?fIcUR4GbFIaDgSyC+qqrI8+6xmTbCeBASnPJqsgItuMag6eh8xM1tv9F?=
 =?Windows-1252?Q?8eS9OfwRi/ogRGwngkmCNsOxTny8qXwLKcsSZNq0YsT+S2szBbwEwEef?=
 =?Windows-1252?Q?sQCtjUWqAgRyxIRgPnDeXu2MkG6NaCDs1lZZD220hN4wKxOIvm9QgbLk?=
 =?Windows-1252?Q?ZvTL1jFM2ZbyBQ/bWavm6KJkhikKFb4fubUalXG2TFLNyrGu9ZjcSZH7?=
 =?Windows-1252?Q?ro5tLdeZ3RGvARBhWJEPfZEPcAbamPH3m0xcUcOqE8SM41DLSjZFIIy1?=
 =?Windows-1252?Q?okm1XnyCX/RrnsXaI7iBRNF3/YrksWsbLusMsSLEolslk3Bqcehfx5Ma?=
 =?Windows-1252?Q?bvKkxKeZrXCm09RIP6Awva+zakHKcCE+CPkXCIQf9oo5xthadPR9jcgG?=
 =?Windows-1252?Q?zKp+eJGUL6/xYGI2pozhBzPwUCGwfpQQcv/acXYq0BrNALeJScalMwZr?=
 =?Windows-1252?Q?pCSbHhU1Uy8SM6JRdf+U/+ZNCS3FIETA7TmdYdsL7N/hn6PywtO23GGc?=
 =?Windows-1252?Q?Rig9vREFeGf86IVsVhJRcaaX3f0cPg2XY4ZfVnBcoyZA0rPHuR23S78n?=
 =?Windows-1252?Q?hWluBlkJ4+EFbdXRk8XQaj2GXE/Vl7KNE5tNN9Z5nmdcZwl56zQ6L/B8?=
 =?Windows-1252?Q?ZiME/su3LY7FyzDG6yo2vUGjGKxUBM/e3mgpUs6Zlp/OUKlj4XRwIUj+?=
 =?Windows-1252?Q?xgzmESMh0JPZNwjBUdYUxg6SIO7fCe5riMbv1XX6pMOPZnvSVjqrTge0?=
 =?Windows-1252?Q?2H0WZgXmaO3xKC0xrZZCFIyQO5yDYLgTNKY80ZixrptiCVAAdVFTeHAi?=
 =?Windows-1252?Q?edprj/2XOKdg54sg0Ke3Tbm67q1fwCS8yPbvrqsrwZrgs3YyhNTLfZt1?=
 =?Windows-1252?Q?HoJ3sgZ6YAmJ+drW2y0yL3w+t+T6tdhbo1YpdtQUdQ0J/fmDDrt5y4oF?=
 =?Windows-1252?Q?D7/Y8GFHd2xiUEaL57RvIz5J/JnhwnX0Zt2x9w2owRppeFzIcQNt/qnk?=
 =?Windows-1252?Q?/ndZdpcNeZhFQ/IFxl9VWpUbLGW6eIjLwZDL0okHbB2eP243JpOrRpf5?=
 =?Windows-1252?Q?1O1u/8UcK7OAxwtu/jZx5lMeiNWrq3Fpyafwl/6LxbOt6cZkX6AFoh1y?=
 =?Windows-1252?Q?sTM4ET/XsHrVdax1MIacj4beZ4Vmxtq/kZ7gcUBAgJ+lelF7ayU2B3La?=
 =?Windows-1252?Q?z/kzKJv5V5fmyJ++OmS5Lw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB12389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?elwj/9N8KgMQr/VAtQuBbMrd4JqU4FMFEl4Ema6byEV2K2zsFbR8QTeY?=
 =?Windows-1252?Q?uZ3ZbwkYH4qkvo1Bi5Vx8bZ0GHCaIklSD5O2jDPLIP0enXzML2nmigjD?=
 =?Windows-1252?Q?PlEfaDdAtRidgx6s2xn4YyH/W13yeIQb4VS52GrC35i7PJIkNEUUbrbE?=
 =?Windows-1252?Q?a0rqh4wQZ28NMb744t2kpN9bL6wQdQh9z85gXGzQzx73EARO9jtNSxfh?=
 =?Windows-1252?Q?uwZHFu1ddZNKZy43SH7Mt55MN2nuLXsKxaBoTbVYx8tDOmP715Ct0S6U?=
 =?Windows-1252?Q?yaUoZhW0KocDIkWpAH7I5uldvk8uP7IKiJEo00v0zFhOgSo74UWZD22t?=
 =?Windows-1252?Q?vEiy7EJ+KC2R0tpCdnMId9GJl17CZSX1L1Jo/iSDG1aXXOoqcQzFv4BG?=
 =?Windows-1252?Q?HZ0SeYGLpxxl/jaffy3CZEtOxwQLYbJklHetDw9CxmO/Hr79NiT6JL59?=
 =?Windows-1252?Q?1z/oHiBIDcWkLmixObxRESg8Ghp8ol6NUSgTj5l5GwwO3XubWR9Y6fLM?=
 =?Windows-1252?Q?LkSQeqjDsj7l+ArFTZx+gmGoq19gYpPqrzloIgMiAoP0SfqZ3lrJfzCt?=
 =?Windows-1252?Q?ttY20Ot5oS/oDxnByWzm48/vB9rrcylANec53NUoovHiVhiiud16gdvq?=
 =?Windows-1252?Q?UPSNx8rUYZeaRi0UBLaYggDXZOoxdtecNQkgooPyglHJXj5CowDBLavZ?=
 =?Windows-1252?Q?Vz6sgckRv7GLWwnQf4X9+oNKsyONZJpuh4E6flySJdaixtqd5HIiT7jr?=
 =?Windows-1252?Q?mQe04p0aLk9f/kXzlIkwO4LbL3OaCdR9iIAED2Pz91H+Puck4YfbkIeF?=
 =?Windows-1252?Q?a9jm2LAkSsvfoDv4m6gnVJvx00ZqbcYr0i7NosWMAsVQSZJDTnzAuxDp?=
 =?Windows-1252?Q?wkuxqdGzfGDlacd3MwpjHEXNdpj+TxJURi8WgP38rimukbg29UQ0Bllt?=
 =?Windows-1252?Q?gs98jnv0UJDiu+Nyddle8KcYRs6oYF+9/WRAYRCPdoJFSsbx8J1tnSG4?=
 =?Windows-1252?Q?da77i8Kt+MaHPhEHJysicBYaK4hddk11GmDnKQxNjfiQP954b0msuoMH?=
 =?Windows-1252?Q?I42SQJJGHlNd5jzjCU7YYnNrY9Wa5wxGHoJeFWuKgZxjkRIicnEAg9+4?=
 =?Windows-1252?Q?BEqYzEvwTXbC5A/QtG/kq/aAh4UMt4xk/qq+ASd4XGIFoC9s6ry3ZP+a?=
 =?Windows-1252?Q?Aoy7IE4Y99ifIKoL4/VeL69R6cuCcOyBXsXcPATKjORxrnqem/yiL5G1?=
 =?Windows-1252?Q?HIv12SXymcQLCDfnylaAshtcuRho+Jz0NP04Z+1eLdEcTDkdpXFTcWNx?=
 =?Windows-1252?Q?bJyx8HnLhMgXlErdGGfcxzqi1wsnx5GugEICJRzCBGUkrfY4wMELtSL1?=
 =?Windows-1252?Q?g+sROB35aZZiLxFygQP2CB1FF8aJrNd4UGs2FOEyWINgyLO9/aCo2AQt?=
 =?Windows-1252?Q?z1RdYm8/j2QpSsl0LxhlQbpTULEhWdobGwDa9TXC8dIG7tUzOm+boRpX?=
 =?Windows-1252?Q?mlXLk+3QxiQn9Fx9JdWCN3ENN0N0kzwb/fXnoNIPBHerpHaO5fyQ3Hku?=
 =?Windows-1252?Q?dQPYWjSl0tw/tI6mDYo4Gh1RLldS90bC/n4nw483DJUivL5MVMGXWv/h?=
 =?Windows-1252?Q?1etkqcYpyHFUKHYnZ/rdE42t1C9z2rsZkbdAtIG3BVvMDR0TEPvgBHln?=
 =?Windows-1252?Q?FlyHtSOi4gpTpjuXuthTxv/1GXZB0DTXGeyN1bzhfKN3xoGCc9bpUQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81176dc-2923-45e5-2087-08dce9f034ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 12:28:26.4577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WHhCFQZBP8xXJ0t8ffwCSj9UcV7sLviAspRx3pDMiT6sdiYrEQzXC6aULCuhYVZ48MbUYXmAjZlDFhY/HAtYYUtfFjFATz51g+38qB9lUn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11427
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Oct 2024 12:28:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17032

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 11 October 2024 10:13
>=20
> Hi all,
>=20
> Sorry for the late notice but the CIP LAVA server is in maintenance.
> It will be up later today.

The server is back up again now.
The devices will come back online once the corresponding labs have re-conne=
cted.

Kind regards, Chris


