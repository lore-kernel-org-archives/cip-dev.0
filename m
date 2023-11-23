Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1F1C61D85
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 07:25:35 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.129])
 by mx.groups.io with SMTP id smtpd.web11.86457.1700724327713596776
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Nov 2023 23:25:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=Uobl8FuG;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.129, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpRh0pM1qzmH3MaMNepBtAwgO4G7vfsOTWQoVtN5UY7ax8tu1WJD/3EqZ8An7Xo62HNvfKpN1Eg8B5CaY4GRqM96mvtGYkH6lhlOhSKNPuB/RJ2W1JmfLdZDq4vFCR9BNmERo/UB+YTLpzo5fM0vgTKXEESNcglQzrlLILFmul14ccG2/FiN5K1ePsL1O19wZnGxaTTGGnsxXyvB+IAb00eczqFPuPKEvsESh2iex2B2exUIHlXqW7nOWesIZ49ApJ6F1Gf0w0rg+s9voAtFgbny84YgbrEbqX45f/M3L+bX1RJ26a0mof+iG0Uz9RSlMwILx+WbhA17ZuDoma0Ynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yG+LCOPjGhq3SxagetlirPsD6x1fodr0QiRoC5hVNdU=;
 b=mxIBKtisnMgV0Zz2Q+asrGFV19fJfMTk8hErAtIwb5rLK23Hsf0Zg3uVUkhqOiBAd0XvnApKuLqDwq+BAc3msU+ubhnBonU1doqwW+ude62eeUK6Vg2FPa2D6d4pcFVW0sEFGCg+GXi/cPmf/Tx9LevxSfUFy9W0hITRZs5l396YEvpXtw8D+yHK7GT+nwdChEP63iKYeynQVu4VHdYicyeJvLBEQJ66Bvve4NIVERXLeb4E+csC5NnS9qJXqZjhUq1czEuJ6lnSqyhWIy8BI89LcFoUfSAI4TfQDnE7aQfY72KUzufwqx1QZnsfKtOduAT1ImGns0fgdPQbqsNDNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yG+LCOPjGhq3SxagetlirPsD6x1fodr0QiRoC5hVNdU=;
 b=Uobl8FuGpSmYkhAr6Q/ZzIPetG5ohXmA/gdAoZ5b1aufQVwmCUtwRfjaQQHGNpPJPcfX16DhtxHy/v1p6TQweA09pztRXeJEv5Mm+igNU6qxX/DrDHTlx2OPELQnoti/E1ELbw1EMvjDsUzccl2iUYZCQprdzvQF9TmOG/QhYTs=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYCPR01MB8423.jpnprd01.prod.outlook.com
 (2603:1096:400:13b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 07:25:22 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6069:90c7:909:c89b]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::6069:90c7:909:c89b%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 07:25:18 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/11] Add versa3 clk generator support
Thread-Topic: [PATCH 5.10.y-cip 00/11] Add versa3 clk generator support
Thread-Index: AQHaHVAnjqFvWUAqOk2bZVEfGUtd5LCG1ACAgACtLhA=
Date: Thu, 23 Nov 2023 07:25:18 +0000
Message-ID: 
 <TYCPR01MB112694C642D6423AAD7C7AAD486B9A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
 <ZV5slWlS0Qv5yN3n@duo.ucw.cz>
In-Reply-To: <ZV5slWlS0Qv5yN3n@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYCPR01MB8423:EE_
x-ms-office365-filtering-correlation-id: 9aa7eb32-8224-4576-035c-08dbebf5582f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 GsbqNl/8F74ThP3yjTN9maWnMXwZ46EPZXqZ1ps51E3LeXIx3MfbLyQ6a/uCOBXzYTdUJwGJOrc7xotQJC4rykWu1jCkh7fLJebcrLGQT2vytWgZOid5vusNgyvT25+9bRAXBBB/ovu/xu8aTF9Adi2PWyTz5iEMhm/7gFX5RaMTd7bTEdTQ48CHpDfIgcUkBSekEuAOILk3j6Y/0eyP7PInYMXetPA4IkJurCMTDOKTbnjJW4HeIEhC49kWpwWaDsCXEDadb+1KzTp6vDhWElA+B+cL9tncgmy/5o2iTIRC5YwZDcFl5lvtp5RI7yIRTZrGErkmYxMFn1WhKDSYy29JKhVkDR9GepgrWBIfhjN7V9UQxXunBRePjXxXb0nTpahuEM5jWuUacCT2WkAb8my8TTKFeYjAq8MiJnRF7Y+0SGJW103D3MBprARr0cAt8GWA4INOoVlTvkbOxygekrDFMjDNBhBhjwCRcy/q+g60ig6SjoJhw2JM1h2qznbhm9VcM6bHqXD0ZXQVCEzih/M4CLj++ISfZI8nN5mVb+CUtzZhl/y3WZHde4LIR27+o+lUFD16UYsjyMad/d2aW3Cw+GT243wskY9i5YleMU6xoT1PLUxxOL2zKoK/ZwNv
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(55016003)(38070700009)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(38100700002)(122000001)(33656002)(86362001)(71200400001)(26005)(107886003)(7696005)(9686003)(6506007)(4744005)(2906002)(6916009)(316002)(478600001)(5660300002)(8936002)(8676002)(52536014)(4326008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?QC+C0sUQ5Ph/5pGxqMyw4cHD8AOmdrZDWkfA4nbp4ieo+eumeX0Vj7Os7d4E?=
 =?us-ascii?Q?31sTCHrs6I/MitG5r+l3gOkZL9Vz5AeV9YJ00DGZ+xKljn0905SOwQUJ5GCg?=
 =?us-ascii?Q?u3bOJ+fhmIhTLmYtUwf/xBZyNlCqzO000ik6alfdSo67AtltHke7FC9XYP9J?=
 =?us-ascii?Q?SuUDB0VtfzYzwo/AyqH7r8xHdbEcOT9bRn6QWBtBCPTBQmJgOVCPcTPvf58+?=
 =?us-ascii?Q?RCif5OellU4H1+r+7CznTKb678iz2cRf4TD0zUsn2ZOXFTX/U8c/n7HIfkab?=
 =?us-ascii?Q?QwrqGsZtAkM6FJgznXc+sbwBJQPHdXkZIQXfQ/CTbD9sGHrROOb0MSrkeVVf?=
 =?us-ascii?Q?BKyvGTR4YX47WE+9pfO2+l2pFZZGFUwFd+Ilorqku41GCvj4BxDHGLkMT2BP?=
 =?us-ascii?Q?7TIfmavy3yj3yOI7ICzwxxZ5rAS+4mroqH7dekCNg43UDgC+hsoCEu9LuWpi?=
 =?us-ascii?Q?+Au5FO7i7evocwV/huLXExpiyELZDws8Y9/A/iDk88Tv6RmCe7amqGoL9l8h?=
 =?us-ascii?Q?qP6Lu0+SrBsK9tmltksunb8H6r24oSBACCJ1hYstHr2qhyD+qOoMzyMARnxq?=
 =?us-ascii?Q?zkOrC8v0AgTor+gHL1CMCQiR1EFnGQsSGqVOrKWtdkMpokntivKVEhHBqzqK?=
 =?us-ascii?Q?/pqKf0cq88j9ZfX3dicTgHb2ho9DHXYOykheKhoLegsINU8OpS6Rzxi8vtIX?=
 =?us-ascii?Q?8q81xEh6ALQWh1arg70q0cCvd5pBhKUcRVdDrGlr0I3e5KlIKsEZ6bgw+kZW?=
 =?us-ascii?Q?oehk7Kwlwrl87h/kvYzkkoJg4PpR4Upr1uTbgBMwHC1vmdJ1PtfOks1GOHb0?=
 =?us-ascii?Q?9QqQXv67LrwYeV2Pjc7NSRXbXeXEjVxEe/wKGCFp6zx4YVhCjBbLqD6YJH9W?=
 =?us-ascii?Q?gvqBHDlrMalSjzISNQU5rtU5VVp9V4MOk11EwKh9UQGWpKng8+qX7JJkA327?=
 =?us-ascii?Q?EHXpjBNo3CW6NiJopWv75pKDLw7vuXai4rjG1Ri/i7tVP55gd4PMrMZS92vy?=
 =?us-ascii?Q?qsD7A7BLeeN5GmhkhzoIFlgMJOPFPUbauJGRzNBx/sl9sDldn6pcOort2wmz?=
 =?us-ascii?Q?GGF4TpV5+pdAGXV0ipgrgb2C6kkEdjHvfYCcarYoZY56u7sgnjTFn44laVtI?=
 =?us-ascii?Q?E20JTNJbH/SUDiaXeq5zifnzCkQUQxCwupSR9q9WhVaXRfzw6a+7QFEDkX3p?=
 =?us-ascii?Q?oKa05yqDtNTvhIaY9vru9phYadwpidUxviTnN0eAnu64qFQYgKQKBOGoCaq7?=
 =?us-ascii?Q?Yv+BZ8ifdbSEILl5i/ylgdebdP7GdwQQnqG/keXUcxxECYtDpNCa+Y55Fu8H?=
 =?us-ascii?Q?qIJSPSPk3n4JbPAxna0gpqR+bnUDba3HZyBLAWALjqIreNdmFSzh2UQEFBiD?=
 =?us-ascii?Q?VhzweGGnTTB2p0zZ4ZJNA5IVRcB2WB+tjR7COhmuqHtaRGPgJPO5mBX2WeMY?=
 =?us-ascii?Q?KqeTwH+jgCUOxEHrbie4P1JmYGfopbHXy4ls7nMYcbbjplaOZBAqc3GRTp2Q?=
 =?us-ascii?Q?x9mB32dVgdNAN1OE7+a3QyZMc74zqazh0QOr2bUufxuiXU2zCdIoYfPEGQ8o?=
 =?us-ascii?Q?CZUgK2nc1WoiJAGqSBqmC0DaX2ZM4RRUnXTBJM115RfaA/OUgJIAgUofU6A7?=
 =?us-ascii?Q?Zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa7eb32-8224-4576-035c-08dbebf5582f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 07:25:18.1701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1NwqnhElGOFAlJWwb2ykcrZRL4x4WXZWkO3eeoamSOfViQMftreQkSCkjjlrYnTz/ddqNBjj+hH/Kkyd0B7KMMYN/apIEfZchhrOW5mVSS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8423
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 07:25:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13657

Hi Pavel,

> Subject: Re: [PATCH 5.10.y-cip 00/11] Add versa3 clk generator support
>=20
> Hi!
>=20
> > This patch series aims to add versa3 clk generator support on
> > RZ/G2{L,LC,UL}/RZ/Five SMARC EVKs.
> >
> > All the patches are cherry-picked from the mainline.
>=20
> Thanks for patches. Both this and 6.1 version looks okay to me, and I hav=
e
> only very minor comments. I can apply them if there are no other commens
> and if they pass testing. (But I'd preffer to have 5.10.101-cip release,
> first).

There is a plan to rebase upcoming VLP release with latest CIP kernel, so i=
t=20
would be nice to have this driver in 5.10 so that it will be part of upcomi=
ng
Renesas VLP release.

Cheers,
Biju

