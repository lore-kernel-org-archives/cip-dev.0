Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43047CDC192
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:41:20 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.40])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88986.1767703275658636776
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 04:41:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=OO8u/lmH;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.40, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSwpnGoLR/oWKFb4x3qJLI3Vm88/lBvA0FCyqEukkj8AGLfAm9H6MP/LBvl48Q1WANFXU+LBNzU2LE/3UOFA7Sp28kkNwIXA4MqhdnCH+e7Tx5/tP0r9zn2IcO5ZIGXxXWsjt4AuRpGzkI6r8LUjyXQ5jntTgg7hG9lBN6lX8sQu7Ogj6NUOvEyc/1nXOQ41nhw/2MgmtnI+bdlKr2zAzf8P3+Vj36cjY36306GH4zvGxDyvfYbwXLXAEr+fHTS8Fr2+Gz5uQvaB3FldTZucVKf60TQePCEF0D6ZF3rWp0NRQHUZ6dZSSqfjzVtbAgnTLgvN5yBrEVEzI2f1MXjD+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHRN+XYGvz6HVXkJsFfauXtzAhwWZ2DZ6elOidSU5vE=;
 b=xWEVziog4uCZKoPhUvaQ7iAHnpW9nHZUOzyIKidid22QAITczaBSEPl7oqkCMSPPV4BsLRw9+AkER2Ou0cobQTqYmY3Gi/YFU83BoLEszC8rNkktSRrBzG6WSfNDuDnaYcSOfbALowfOQv1yq+bpVo6FKxL2iQ92oE8t5PH/kwC2JzpV9z2mrHtzKVpjwZk+HGlMeXeqfSqMLXSEnOZ6xGiFsMqBnE+wgowg7Wg62ibq7epN/3liXfwE9paSaWpVrBefO1/IYVxTLu00iteCDF7UN9xC7OGxADwfZST2+oBAikXCPYDOOTViX2P7Zv0diwCdugPTmHvTExEpER+24g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHRN+XYGvz6HVXkJsFfauXtzAhwWZ2DZ6elOidSU5vE=;
 b=OO8u/lmH79wAvl/LtmMYe71htVs7/ZJJXVGC0Wsg+1cwYrsvi3oCsJ9uERURLfFXOAyqttqScCgsd3PgDi1njBZ3sdiloz+KlMuHPbboQ8ssdB/pCdMVpWpW41Of2ig9SIh+PxBH0c40UwAaWpgOcP+URKZKOF6BNzGuvl3KIHU=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB8520.jpnprd01.prod.outlook.com (2603:1096:400:13b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 12:41:11 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9499.001; Tue, 6 Jan 2026
 12:41:11 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@nabladev.com>, biju.das.au <biju.das.au@gmail.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip v2 00/24] Add suspend/resume support
 for RZ/G3E CANFD
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip v2 00/24] Add suspend/resume support
 for RZ/G3E CANFD
Thread-Index: AQHcfwHl4ueeOrY4Zk2BcR926h6VZbVFDguAgAAGdtA=
Date: Tue, 6 Jan 2026 12:41:11 +0000
Message-ID: 
 <TY3PR01MB113464D7A30824C60A8CE1FA58687A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
 <aVz8r/qCX/dzdtmE@duo.ucw.cz>
In-Reply-To: <aVz8r/qCX/dzdtmE@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB8520:EE_
x-ms-office365-filtering-correlation-id: 91de4c55-3ad0-439e-4f09-08de4d20df7f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?6PdVRtxDB7V2g5U0AJV8q9fM3axsXXWsN4/KGhA9qkQBUZpdxFoJ9biwWHKJ?=
 =?us-ascii?Q?YxrmaQDGu8eauXCEqX6y+T5QN30G6qXa0tNhWno2A7VI7/7m+qb4YRmKQLj1?=
 =?us-ascii?Q?PCiDsqTXtv+JLEgV36MZ3420h+LbQ4DWfjGI/c43gVYdWiTuAiECl9VfY/OQ?=
 =?us-ascii?Q?TDIoY52luNTHQhv9W8KFRtAbSiLgC9AbX0Bt8JnrYP/LQDMFWxNFCfggHsE9?=
 =?us-ascii?Q?0UPCKp2xAdwZR+8bwzQOZ1HwsSGJdQreu6yU13Bf605TZsOmrZBR+rWRhrOw?=
 =?us-ascii?Q?QVOV0UIutda42IfmG6PXey9OTiuUKvg66Vrs107DvM1J7vweqI6+ddbY5mcn?=
 =?us-ascii?Q?7Y0SkIMGl88MVTE57lcFrZ2dh1XaZHjImYVV5DIauTuygaBigdL6+cGtyPv0?=
 =?us-ascii?Q?d0WLCl7NeOlO/aIB0H2L8KHtR4YGgdAvmrkKWEf64v/ibNznxTb7y+cE3olw?=
 =?us-ascii?Q?uhwehqnekqQpeRRfBxvMnc0lWub6Elzn6LpJzzfHFWAjbjCpguvbpCgpPIpl?=
 =?us-ascii?Q?73/88JmFMdU/0+jIfAYgbwPPXRmXt64MFpVdLlhb0DcVFpw+iqNvW7ZhSEq3?=
 =?us-ascii?Q?VoHTQNBka7mZBYAGfOwpWrwa7CcJEq1zKzcvtj0nqUSQwzbZLH1aE/xJfxsd?=
 =?us-ascii?Q?ZlBikiqRjL0j2Z9ypgSTYuwtPLeGSWoKFyvD1F4Kp/Ap6CZ8xI7MWeKkoCp+?=
 =?us-ascii?Q?fLdrhDWSIT6oy+NkSk8Whlp2C8wBqh6wNww32oYpKioRg6Na3hy7+C+v9EBa?=
 =?us-ascii?Q?d4Rs8mdOtsUWpEAMfnJMDNTWSfWmEwBDz/aP8dWQM4fizzlYUula5rRIODUV?=
 =?us-ascii?Q?FU6O2mhOKpSPzNQaZ83EAKiH6oPVR8wJnZOjuvHrj0BHv7aymk7zB1DECn7h?=
 =?us-ascii?Q?OzSkvgIZGPh9APDHfvfRukz8o2Rw3oSzv97kNvz7umIgnjL9PrD2K4kYxakI?=
 =?us-ascii?Q?ACgDP66hwGzKoC3fKU7n/1a7jkcJTOwd6xUkun0axAQTVpr6yA3S0z2g/bbD?=
 =?us-ascii?Q?C2GJA4K6N7xliTfbd+MqiPTtHy76fA5ZDJ0sTiOvsMhSiLq4wg/qAp06WMg/?=
 =?us-ascii?Q?1XGux0bICCPELvmguQFI8pdIs71Fbk9jsVOmAEiFEWuutCpIF9rHJ0t3XvWR?=
 =?us-ascii?Q?4tA8/M8DPPLTy46fanOQq3+nmVdGYyoA/2sGS6wbg77bmFYfZqxbwFa4rGS/?=
 =?us-ascii?Q?igsqhbsEnDG0uKZwIXAs/Kq0Hix9ayh6CrOEs+nlgSAQl8lwPHX9cpIYdaMu?=
 =?us-ascii?Q?P3kKS9C0gM+UDjKKCV/JfmU3Pzvrp377HXjNw5QNw1vDWOqILjplW43gDx/W?=
 =?us-ascii?Q?7Wo1clPKGN66WRhoCZfGCa4a/5gy+p2h3wDddihpLF9bMejanQpQHeS6hHTX?=
 =?us-ascii?Q?bIK2bZs4xh2s+ILhtkqX5GtzBsBQdJ3GiHIt+MbqZW+U6eRb2ipLpizr/hr6?=
 =?us-ascii?Q?i8UN6dAe4JQWmamN6RVQ9xi5lXP5A5KeRbj81fCJIokCOf5GxXL4wDv/GgUk?=
 =?us-ascii?Q?Y47/wjh99fPbFtr1uxVF1wRQAj3bw/hWetFD?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?5a2h7qjCfZWmqNnvS1ZBI+JdR5WHk9zpKQvHky1yOJxGyFAr0YhEJQR9BppC?=
 =?us-ascii?Q?nMEt1gqagIvidy+Fzd4ofTBF1IW2dccay8tnlRZy9qSe4mcf3rP6c/PnaxMK?=
 =?us-ascii?Q?0akkXC0RHep4bpyGqRPxUATbPDgtS9fsisqtRh3K0x4132psy2rC7OWhLzZI?=
 =?us-ascii?Q?6B5x/Tj7dxFP2IqTXrZlVnlNRsXMuMZZZyen56SQ5PsFAU51877CgRNsXxye?=
 =?us-ascii?Q?wfnpYPb+kDfg8ej4HW4qwF98MoZqGxYKw5DX59bJogekXDiogt+zizHX61ou?=
 =?us-ascii?Q?nFxPiWbOBHMXPjwOLRKft6n/3Ag4xDi4Ha0NSiJRMwIIi8UJwpkoUtxbP86R?=
 =?us-ascii?Q?drEMni3NlwTu5TuNqSWq13iFVHY0LmW1NviDXj6+39XrEo6oEYc9aJV3F1Ce?=
 =?us-ascii?Q?xivvJsbffQvDcI4hcavJPHcdzwa5F2giWBu+8A3eOghOMvumfuqdSYaO15D1?=
 =?us-ascii?Q?19hWeRmAKHgnHBTQr4sM/g88oP64/hgv7MpkmP/bc02vZuvGPu/nu3a60ta5?=
 =?us-ascii?Q?Eabz4QNKpcjqY0f/Z6LXO3Rd/dIUxj2qetxEOTs1eR2q/pcf1Me6+KzI2iGM?=
 =?us-ascii?Q?qCV3Jh9gZ7qk3Ldkp5zx5Y3PGOh0i+pxzsovXb6/QFU8OOA2ZJN1BWW1H5hl?=
 =?us-ascii?Q?3EMqMYiuhXMlg7B4or55i0LSYzkbZ+rS9AiaPvP0WsO0RKIX1z6Se+cXIwgv?=
 =?us-ascii?Q?7ojrrjzmu3IRYLNlYH3W2arECBQnx+ou19oGrqyV9Wo2C87RjuX1OJvp1jhn?=
 =?us-ascii?Q?fzqYoj8D9+MbD/IISxvATHklDzQq2HuaWc/jeenW2AL+268FjglzQWbOex0o?=
 =?us-ascii?Q?uoc8KJgB/nyEZl3pfxNH+vmqKARGgLDKHq1/p4DUzuK1Pn2g4QeYG9cn8OEf?=
 =?us-ascii?Q?RVGGVLEbBhIhzJSPPjJBHXedtnfs+XVMrsD/hE9+2W/TRU/tXgDU5PPPhjId?=
 =?us-ascii?Q?k7cCB+0iX0hF+dBB9s/lgl+P9xg1t2/b2vi1UibyZmDESl86HpkVHSwdy3+r?=
 =?us-ascii?Q?9Bkrgg4gewkAxCqtu8MhspK98An22YpjSBXrE/PXB7QoWuNT5yHBBTflJHew?=
 =?us-ascii?Q?9hveRU78Oubpwhz5k2AaEU82n4Vu85paKyuAE8eoHfanpxB/BDou4xVHXfn/?=
 =?us-ascii?Q?uh7tgbXbTaSeUfs+/ssI8iMDThFENuADFd26bmo9Fu0pOB89SIRn68iCPr/9?=
 =?us-ascii?Q?P3MqU+xEPbUkFUhGy8YKpg/q+G8wuPNxD713Lx7aIXx7773Z2XzzgSJxorKL?=
 =?us-ascii?Q?+0tjbaM7H1Jd+grdzZZ6C9O6hpNhqSJ2NX/Cy4zNKRuBC81qnbHu0lNrK5cw?=
 =?us-ascii?Q?U5sNDzgLQ1vt3eMURgrKCmXkT0Cp4q3LCNN89AQuHSS6o/GzmH7Ns9oRSQwZ?=
 =?us-ascii?Q?GD5xCH2cPs1GeoZ27aq32899Sjp1qrwo9rzW1/0P88RR80L8ZU72B/9oytIc?=
 =?us-ascii?Q?x5rUV0IN7MpRZkohYh1eJbog1nI/DgJFPR8qQjT+A4/u3qj7mcGcSS7RrtBb?=
 =?us-ascii?Q?+doJ7uwzW4TYyeQhg1D1fEhzb2kVmX4xqX5CpYm2iovb91kvA/A0nNVFxk4N?=
 =?us-ascii?Q?m1hdeQ7nC+bwOZ2BaOmP/y9FDolqbhMEBIcn88BJpMYchefs3sfoPBkPKFDd?=
 =?us-ascii?Q?78x/+gpdjlhbx3qS64LTeEhony+cETYyS1GKKJyxqak3mujNk6utXkw5g5nL?=
 =?us-ascii?Q?1oFaheLtVwizMpjf0v3hrGoALOvlafJJfYGrb/0qeJ/RZYRElOL9xMGJdjI8?=
 =?us-ascii?Q?mbkbRGl/iQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91de4c55-3ad0-439e-4f09-08de4d20df7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 12:41:11.6588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DhjVBUg+1d6KgNRZn7FtS71aJ3lTldgj9ZSMmnLt4QqQ0NA8X94pblpYhi1ZkSwE9mv4gYCGIt5RA3LOev2B/0//AXRX1BiD+TaJwTGsd/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8520
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 12:41:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21375

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@nabladev.com>
> Sent: 06 January 2026 12:15
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip v2 00/24] Add suspend/resume sup=
port for RZ/G3E CANFD
>=20
> Hi!
>=20
> > Add suspend/resume support for RZ/G3E CANFD. On RZ/G3E using PSCI,
> > s2ram powers down the SoC. After resume, reinitialize the hardware for
> > CANFD operations. All the patches in this series are cherry picked
> > from mainline.
>=20
> I'm not sure what your plans are; I assume you'll send v2 of this for 6.1=
. That's ok.

6.1 is OK, there is no patch conflict. I have send v2 for 6.12 mainly due t=
o patch conflict
after cip rebase to 6.12 stable.

>=20
> But if you have plans for any more submissions, please consider giving us=
 a bit of timeout. There are
> currently 6 series in flight from 3 different people and it starts being =
confusing.

OK, Agreed. I don't have any more plans to send patches.
For the patches send as v2 has the change log that
details what is changed in v2.

Cheers,
Biju

