Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5964BCCF9F8
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 18:38:25 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.755.1762195096240683309
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Nov 2025 10:38:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=OcziTedy;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.13, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIfkh0Bjkr7Yz5smtq77gEFUCU9emHAeIcn5A0uLJ8FM2nOZqeadxFBBsrb9pSFJdOCkIqKJ07Ezpb7fnJVnW8igKM/gikXDj4zkjsbKWal0LwJynFQv+8u6LP5jv7uBte8XzBKuJNjAR77mSgq6zejjM5yj5wehtivt95fwKI3IE4xDz7JUFxvkPfAT5gZM8mlB5K8eoxryIPDzuhdoACuL0V84QxY+4imbu3jVP0v/YoJLNs8GnaTsCLixsG4QjzHnV3FFuP5nBCmafpb80kGA/0LHzbvWo1XYRBZCGYu3Ly6NUb9VRWxsyoN3hMAWkOHKoOmsM3xtzuYiLBBUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HP/NC4Rw7rl6c1jZ7mC8KUuDluThMnH0ZrXL1YCNDHw=;
 b=k+iVZDGwIvwad2zwT90rQ0PF4TQU/yryLmhyaXaLiaeL5wTEj1kRkwj8O852T/A5pyeyR6Z+etbNOBZ+u42W/xVxFrzyxo8WfazMbklNTHcI5Pa0VHjIMUFCtAcQzdKl1y+g+d0RBKfrDPlOkxkteZcK1o9VcG9M/ObVrnS5+dA51l5QyPB7sLITXqMV+PAXtL6SLiTyDWQtcD64NVvDy0pQu9LTsO3dzOZ7Ty5a/LFqUrJ5dQNp/7+McGF10EPpMxcN+HQyUq0kVtqV1UEbT/4uJ7v8ee1NVv42ll3V6il5/nIbeiqRIorkFNHSWfoH4B5YuOIPdVGS2fTiOSitVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HP/NC4Rw7rl6c1jZ7mC8KUuDluThMnH0ZrXL1YCNDHw=;
 b=OcziTedyh3IkraQahT+dAJonvt488CXkzEUar83UKRamgabD0Wx7ng/ocnrAVhVy3HkaEDWbiERnJyjdxfSEU9q4D/E4vfTWKvbI8I7iyX/e3Ym5/7naCZex8E1GFG0IUsI3U23NlYB2+WKFnGHj2rtgbKd1lKo0SqLqRHpzGpE=
Received: from OS9PR01MB16368.jpnprd01.prod.outlook.com (2603:1096:604:2b8::6)
 by TY7PR01MB17178.jpnprd01.prod.outlook.com (2603:1096:405:32b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Mon, 3 Nov
 2025 18:38:11 +0000
Received: from OS9PR01MB16368.jpnprd01.prod.outlook.com
 ([fe80::69fe:a6bb:3371:3f0c]) by OS9PR01MB16368.jpnprd01.prod.outlook.com
 ([fe80::69fe:a6bb:3371:3f0c%7]) with mapi id 15.20.9298.006; Mon, 3 Nov 2025
 18:38:11 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: RE: [PATCH 6.1.y-cip 00/25] Add RZ/G3E GBETH support
Thread-Topic: [PATCH 6.1.y-cip 00/25] Add RZ/G3E GBETH support
Thread-Index: AQHcTO/zEsIpdOf8tkmzGCV+iWOZmbThRnOw
Date: Mon, 3 Nov 2025 18:38:11 +0000
Message-ID: 
 <OS9PR01MB16368DD10F2F87A3BAC54F320FFC7A@OS9PR01MB16368.jpnprd01.prod.outlook.com>
References: <20251103113608.36240-1-john.madieu.xa@bp.renesas.com>
 <aQj0zqPbRZSpUZVL@duo.ucw.cz>
In-Reply-To: <aQj0zqPbRZSpUZVL@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB16368:EE_|TY7PR01MB17178:EE_
x-ms-office365-filtering-correlation-id: f45ad998-9b39-4d51-faf8-08de1b082448
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?6BFJlemr+uBuI+/BGjvVpdNi+/m7T5QrpBbFM/eUvdLkXkXVEw6vFD1DqO71?=
 =?us-ascii?Q?1YiRIIhLrT3SLQbFWfaErC/HNKUGslO0KjlXBHNYK4A+SUfu5oMH552mup9h?=
 =?us-ascii?Q?I14axU+/2efz63bCuhJ1l2MwFv0vzHoxcPJ7JWEIb22ixE6oPZFR9fz5PLmK?=
 =?us-ascii?Q?bot5sIMnGN1lKK8giqgXi8aq1/WtDzzhX711oCUsgUs3EIWIbQEyK4InmQCn?=
 =?us-ascii?Q?qGtC3g2u0I3WSS8R2pvcRMNC7vPJTdvuL5GQA/ocuZrwXagsVagh38o+X3aA?=
 =?us-ascii?Q?Iq/x0m6rXRmuPKb3DwS8X7K6XTMlXhaAS83PV605vqzy+2t922/UXB4vFtpA?=
 =?us-ascii?Q?A3fNUqq0sw6LTPqmk33fFwepBtyf1LwkbN1Y552yNi81ticLxv7kRKWaVn0f?=
 =?us-ascii?Q?mQgNgTwq9TkeVsxSKX3+5Bkczk+ZfAiTY+bAx6R+qqhGKYk6kRMa5VfEdcSV?=
 =?us-ascii?Q?5wGoFlDbnMmuSxa1TnFS/YN4xAFTW5qCgn6WZxcCFaME974GP4CMST6hn7DZ?=
 =?us-ascii?Q?nZwUA6iPHKlO7aSOaPEjAo/V0W9rck8VxO2qFHK5Qkd/d49SLWLI9zjYdl1D?=
 =?us-ascii?Q?6cm1X7cyRmKHUqMcQtX0D87YWzjYs+KxvzvadsSHdzZPcFjcdflVVysJuQdc?=
 =?us-ascii?Q?4OyMBMCVOgB7ta0WXs7eygtMOOOX16qDyLPfbtKR6HrzVfFOIPYt3M5Dh/zK?=
 =?us-ascii?Q?2ghHGC9NmG0fc2KtZeQSAYdeq2KKRwH5JzzMy+19X7fUCyCSrKy7nkE04cFE?=
 =?us-ascii?Q?90CT6sm+fdLKsFVnA/Zkgo7g5AxpdmUXMRkTGMfsRd/6/NUp9yi5bg9RgoYV?=
 =?us-ascii?Q?N8T1mL1YjhqOqlLlhOxvakuiZdEZBY1CDhY7yD4yJIwzYPEdF1djKjU1d8Mj?=
 =?us-ascii?Q?0N8PfBa8dU4Kh6U+gmyQzmeHGIUg4AlJmfZNvQCpsde22xvguO+8hTbAwQUM?=
 =?us-ascii?Q?mIp9cew0+0RHbcrZsrIM5hyOd4BLmFe1VGm7fj24x+i46wc+O42ZBCSSKBTG?=
 =?us-ascii?Q?Yzm0uMUxtlR5G4auA6I6Dw0efCARTx48jw24FWr5xtp/uDFUt9AfdWSV738t?=
 =?us-ascii?Q?IHmIkUJBlieB5g0Y4ZoOyg7TVYOotkQ/4lDYT00StPoM8w0kfIVpGcloM6gs?=
 =?us-ascii?Q?ySvowfhMK5hvK2YSEklluCQU73DQuTiIfN4Yj2ZdxXgOC1nnoV/YXhYVnutL?=
 =?us-ascii?Q?H1o5Ce3TS1Dw1vT0w9ot6r6PggC6rkuT1pQ+2PhT9ka3SEGPFpbxBra+UXSD?=
 =?us-ascii?Q?vQUtZiToCd15SglD0XyZ6P0H3fS5IivEC+FCgUq3pyiVetOuT8wRRc3GMOLS?=
 =?us-ascii?Q?6/6ATT5gW0DymbyX/HvT5J5QUsr8fO1awDfX9xC+9clkWoL/RtHBlISaDfim?=
 =?us-ascii?Q?C3x9zjLoeg0etnVuQpYtGES13nSY6LO8G2pm/nxWwIUCGtwOjnTi2uTJR9Jy?=
 =?us-ascii?Q?eM8Ha4nlRsWomP6s2ERrtfFbaJfciwVA0jwQioU8yBI+xnuZ9NCp8/2PFKJ+?=
 =?us-ascii?Q?JGR1K5jkGlBk1jJMZjjUDbNVq7q078Qs/NPO?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB16368.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?cDOrpeVlXAau11diyZO0HzyfZyX+xZOCa/v9wR/S7JDkUHfj1MQeICKKOcep?=
 =?us-ascii?Q?zL6KbuD5cNiasLWt9IYzvGAadLcCpNguKY7yj/3J5S6v7myNnscuhVBLtDL6?=
 =?us-ascii?Q?ZbdBKqUuojavw9fnnPuIfUgIY4jLKCUJMD6yS/9TNdfdJ+Skc+xCL0RwWR54?=
 =?us-ascii?Q?ulslpkmEtLj4cw8nLC+xEfgazIWXvWOa1OXfbX7QcFoGq3etiUJW4bThLyw8?=
 =?us-ascii?Q?jPNYsk8XCR2PfKhiYU9jLB/ykv5ZM/T7agh66GR07h6IdeiPdYay2C1kP8Do?=
 =?us-ascii?Q?CXYXHNKyySwLz1T7Gw61QaL9085SNA1vSgM/4/u1Fg/KOUH3c/sNontIFaYJ?=
 =?us-ascii?Q?jJBRYDLN7BgFvPAokgIGlSZkKkg5CbV7mnTkXXPaUwPpycqnt1s8nvwKXniA?=
 =?us-ascii?Q?kYBM56AgjszdrELzj0rgiiCfyzkCgPDpCUoO8FY7Ena0ed9xX1lbC/jvg2Qg?=
 =?us-ascii?Q?U1+7ElxvNyQriETXn7opGnlKMHl8GhOuJr1/wLa1UXPsxsCX7cybIQ/j6QWU?=
 =?us-ascii?Q?h69o39hMbWzn0HM4CrVth/WusDkNkLi7TOYm/PhFNZiD9vLcxFCE6OeaMLE+?=
 =?us-ascii?Q?uGyaK5sKaqODU/RSqOO8h0ZC5y3ZYZVrLLwx+SDi+rIbyug+lgwsB9Lgs7ze?=
 =?us-ascii?Q?mJvkn5VY8m8PwnoKiMK3fPvzfflgyp0NcElm6V56+Xbl2LsoXuy6Irr3Nxjj?=
 =?us-ascii?Q?Cs2nJZ+2hptUI07FAAy7lwuVIEh36OIBTfq1pANW4/vEMBzP6W39CU7pxbiU?=
 =?us-ascii?Q?fp5lz7Khjss2PHU3hvUeJTErZrtBkSPAZAFxjCg/+Vz6+7PKrRLKQAGzHJZU?=
 =?us-ascii?Q?st9qnwjKZ/kq0PKZTkiNgTSAocq1pH4eHnS3XuxcLDPee/fdh2L6TIkgQGLY?=
 =?us-ascii?Q?soUeiSQtG46HMCx2k78X71LbGvgZvOyeIhrFtmFyBT7g/YylrGjOm/9JGcTq?=
 =?us-ascii?Q?xNSnEBAwLEtnDStrlhpFCFxiCSoxvnye8NivywRldwdDCb5KwS1MFjE5Coqz?=
 =?us-ascii?Q?TjseVkY3T+3Jd8MpNLTeXyHODe987zJt5+crkhcFsxrwnhUDiqomdTOoQ5km?=
 =?us-ascii?Q?7vmVPMVWDhTRLUevDUkyvAJfU9COicKq5ZYfsOUEPlZzGaNM4IHctKHwf2n0?=
 =?us-ascii?Q?wqodujosH5BRVqkDjSOXNHp65yJgqxUqHfwtVg9ymJq/tz+DBKciXU36iZxG?=
 =?us-ascii?Q?r5sUSjuElXEnKB3LjktCKt082Yhyz5SkjRhMnSKByc//705ZDRLWdf33rGL2?=
 =?us-ascii?Q?R64k8Uywq1gHWiasvv9fvA1KTfXUHmULwlZlRUR7a1uznjpiPNXJHeABqGGc?=
 =?us-ascii?Q?fKKx2wjhI636+KbDxJ/RRwG2i30Krj9ST/R1wuaHw0JK823VSOEGTa0YZ+BL?=
 =?us-ascii?Q?rZj29JQeX+x1MiS5CC4cyq7kFdvHM3Njs+T0qBjhBoQNZrqK6/K4vSYavMo4?=
 =?us-ascii?Q?2HSG/Yc8N6ryaTv1hvpd/yP1M+vu9XRirTKSWWkWPj4lc2t0+LYVHxqv0+R+?=
 =?us-ascii?Q?FNgxGCCDBcNJe3ReFIkk+uPBrTCnRCvht+4h+HfzD+QmGd7ckSlD1O4gtaPd?=
 =?us-ascii?Q?S+3dTLDJTYO8oexIHfbiuv6OpIJUuFPTgaiErqBIBqr+yDOG8zklQiSnC0ln?=
 =?us-ascii?Q?sA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB16368.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45ad998-9b39-4d51-faf8-08de1b082448
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 18:38:11.5609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EfSY2TlfrdxKor522/iQVM/4MDYURqw9GrU2wGPev6evUhB5Xg0UrTQ/jJbPLECnYDTxw5YIsLGbu8sW8StZhmv75CTmhNYuaLWFA0NWg8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB17178
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Nov 2025 18:38:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20346

Hi Pavel,
Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Monday, November 3, 2025 7:31 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: Re: [PATCH 6.1.y-cip 00/25] Add RZ/G3E GBETH support
>=20
> Hi!
>=20
> I've got this one twice:
>=20
> Date: Mon,  3 Nov 2025 12:25:19 +0100
> From: John Madieu <john.madieu.xa@bp.renesas.com>
> To: cip-dev@lists.cip-project.org, Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel
>         Machek <pavel@denx.de>
> Subject: [PATCH 6.1.y-cip 00/25] Add RZ/G3E GBETH support
> X-Mailer: git-send-email 2.43.0
>=20
> I assume series are same and I can just ignore one of them...?
I've normally sent two series, the first one being 6.1.y-cip and the
other one being 6.12.y-cip.

Sorry if you've received twice one of the series. My bad. You can just
ignore one of them.

>=20
> Best regards,
Regards,
John.
> 								Pavel
> --
> In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
> Office: Kirchenstr.5, D-82194 Groebenzell, Germany

