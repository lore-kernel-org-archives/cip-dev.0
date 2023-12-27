Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CBDC46CD4
	for <webhook@archiver.kernel.org>; Wed, 27 Dec 2023 15:51:02 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.119])
 by mx.groups.io with SMTP id smtpd.web10.104177.1703692256723176945
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Dec 2023 07:50:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=WyPhGKEd;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.119, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ef5l7jY+xB4vQ95kbiEtB7SBmSb37l8RLv9xDkQXaxghx2v6LKEMoMmV/zyRGTA66C4+uQDE0GTyux/h/bL7OJEG/TIGtWMbhCiiAch09OWn7N7kCLs3vJc+ziVdGTGnWyvi+FVAMRodIm4nyS4FiZwjMqyg8VJlvtVXTt5XlmnxLxLXItnpdurADnD0tcdk9DuQheCKQehOgZ2wjYdiNxnKGYQFdpjcBPZOf8lj0xQLDi1VaeqYTawFY2xOncsZ+mXj/G6gfKMZ7cPg5W/5T0EKIcIbUaWz8WI4vthkhBfsym8A7qjgAWj55v5ncxEnj6YQTEv8k6Q2vnwPfGCYoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9ghooNdZfXjDbDHf/H3e7Fgn6QS5fUbspxo1+yLYx0=;
 b=hgonxPokDJOKcn91eGG1exgcpB0ys8Ep7OiJDxaPtc4Tf89MqeWZAlJwTm/TmEHMZglSKr2fITJ2bSiR4HJtJJQpQfVPVceGAOehJDisGLdd7FPALaHPrWWIJGST7T3qaag4mq2xT7Ibl9kQ5itZu3ZmHZgGxFbbBXEuPWiXV53Mha0zhAbHRhVglNnod4xrjWRvjScSPZ8uI/XfGSHwbS7yCmG5ux+kdVZdGi7Jj3aojJUh1GpqJ8yP/Gu6/SnrmN+IW73VFtFLQtJZ/Vr54PVoUz8Io2yT8ke85J6YB3hhLi161IN4NVxeHyIph/zooIHX2hZwd5PNOwAtRCfsTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9ghooNdZfXjDbDHf/H3e7Fgn6QS5fUbspxo1+yLYx0=;
 b=WyPhGKEdy7Yq2WNRSpRZg/uuXtU45WSg8/mksO4hbFJecQV5hwOQH3LJcGehrmLxC+4p8M7r8ahFwKDswl1ZhhRNDvPMPoOJr4eykIZNcei2KN6lY1lxNF8sRcRaTh/eKpFj2hAiUPnxwKu3cjsGcHa+hsx/559cH7AyLGcA740=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSZPR01MB8401.jpnprd01.prod.outlook.com (2603:1096:604:16f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.10; Wed, 27 Dec
 2023 15:50:52 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::39b3:aad0:4e87:9926]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::39b3:aad0:4e87:9926%5]) with mapi id 15.20.7135.019; Wed, 27 Dec 2023
 15:50:52 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH RFC 17/30] cache: Add L2 cache management for Andes AX45MP
 RISC-V core
Thread-Topic: [PATCH RFC 17/30] cache: Add L2 cache management for Andes
 AX45MP RISC-V core
Thread-Index: AQHaM5lOl8dz4pPUMk2pbFdX8sPofLC77IuAgAFjd7A=
Date: Wed, 27 Dec 2023 15:50:52 +0000
Message-ID: 
 <OSZPR01MB701960DF91DC9B54BB1081D3AA9FA@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20231220230646.219816-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZYscOXYQG2r5DUgK@duo.ucw.cz>
In-Reply-To: <ZYscOXYQG2r5DUgK@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OSZPR01MB8401:EE_
x-ms-office365-filtering-correlation-id: cd5a55e8-77aa-4cb0-eb97-08dc06f39ab0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 gFBDM8OpUzz9pAhxSRMzRsnb0ciJThu3A4Oji1Gw3da2tjdMKDMpe6WaqdFWa6PQCH2KSVxqaxyFPHaZAkrJann5y9rdzQZyX+Jzx6/o61iOydC8HmaEoHXLLyMlGM9n5od/FNJ+/TnhHfg6aScSy5lwnxHOOlu5/wMTlS0gu1H5HPL8R6fwTdPQFIx8QFVpVsci/AZr/GHgYMJG8Bx+x7PYW6lOWgOnwEcm+cXSfzLPXbejqyEEbChXdXvCWPlYnj0CrggfKyEyzuk1Eou3Bl2eFjkG2NL8gFdSbKMErAny9aapSBGV4V6Cs463HqozieTOmGG+dXkFtder2hZUYarSi90fYFq75nqI5YR/ZXUhvCoyVqC7Slw7w9iJ1ifj1XiRVH+AdlxQRfaCzY+tYbZ6b2AjF5cZ0yjAyHSlzE0ZCbLKuPbchQhlADxJu7KBMZ7pfOJEOtb6324v4nU0ESGeAIqVMf+pPKrRNGxyai+RpKKsbLibT8KQi7y53TeaeAswjLWlTV0pQZ4yeXWR/Md6QX2czbgl01QPU4adMKb87BkwKnkkiNF2RqtJZWLCalQh6O9q/cymI6sZy5/Sc/NgBZYCKPGpd/j55EMomXtjmTdVL3Di55zZFybpLM1M8++10TvVLcx0FqPg+59YoFQJcIIIPZ/ytHD714H1mf4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(33656002)(55016003)(38100700002)(122000001)(38070700009)(86362001)(83380400001)(107886003)(71200400001)(316002)(26005)(7696005)(478600001)(8936002)(966005)(66556008)(66446008)(76116006)(66476007)(54906003)(6916009)(64756008)(8676002)(66946007)(2906002)(5660300002)(4326008)(53546011)(9686003)(52536014)(41300700001)(6506007)(43620500001)(15398625002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Pa5DNi8NCH9i2qByZuTGgb9AlUHpOnd6r84oPBF8Qio9P/TB3zlq8m5iojAb?=
 =?us-ascii?Q?QuGdGcIu7IEvSWQIaZXEza6wsJl5/u2UpI34fy+eBTy25VBMXXPH0hKFG8QP?=
 =?us-ascii?Q?2MxRgcZ2XH4X2FvOPFhUMNNo6HIzEm1uT5NgxTUFz9RN0JYVwvcWaVZ86/l7?=
 =?us-ascii?Q?PEq1uSbM5waUM+P0qeDYrtigqmOCazMVzrINtxu7IqleFfl+DEzDWMDlLHsD?=
 =?us-ascii?Q?ljdfGeRNcdafzDiyBv6xps/Voit2nvN/QsmbOTE8/q7tfN0Ww/zWwoPDwTtz?=
 =?us-ascii?Q?wINPDQm+mVhq+PSa7oNRXwPOgFdf+IGi1esFO5a2UNhhrRkJ/B86BSwTv+ls?=
 =?us-ascii?Q?TcJppoSi6p8ETZeh+fYouLuz2JC2li+csQT1qkmqo+dsAdUhCKRnnPpujqW1?=
 =?us-ascii?Q?DdIIgGd+JN9FJP9IpW1p0a4yu0aV0FUfdRAbt+fV0pD+hJlBhsrndKtJqqVx?=
 =?us-ascii?Q?zg7B4vu7GCukqxoW4t03DmwHTKLpvELrIKz5jPxnvRpC/6kvfGU5dLDVodUr?=
 =?us-ascii?Q?yqt3HuUQ237Ed6eeSXVlqLQA2sxpMwxiSdAK3hXLuCtBBQlVfpA+Ofz72BeA?=
 =?us-ascii?Q?H488yekPs+/HEDNWZeAOu9MvJ8HDBuNMhdk6axppNo4IDRC254ZNh31t1ILk?=
 =?us-ascii?Q?cPUWBlOF2+hSujLxUfWIvjyO8B2KWaBJU5F7QTeMa9JAdbGU29pK7nTej0aJ?=
 =?us-ascii?Q?MdQ6N9ZPb7xIeSewIuI6ppcQZNyXH6z23QBWsUHlYSGVOd+4AoRFwg+qPUgI?=
 =?us-ascii?Q?RMa4QTMTBdKqxfCNt2eP8AXNdpT3cdh8Kxs+Ui7XT8rvhGleZ0VktSHAGu5Y?=
 =?us-ascii?Q?ye1H2PoF6oYwvtqg+K9zTOdzapWjzcHGM6iQUAZKaDQf8Pae/L0ksqUa7Ip4?=
 =?us-ascii?Q?604giwKqmpOxFZI/Wzq/MKiGoY7TaArlEktmoBUtDgJphfZwdScq992adF2O?=
 =?us-ascii?Q?627Cv1MmSaqlQ+a+0n1VUM0sRic1cWweh85OlwGJKNvkjVCxXQoDUSMSmtSO?=
 =?us-ascii?Q?aQI+zQnKEKiGvBKrpbHBq1304/Bbb6fUiT23SxSizt3VDxeJkIxlhMw2ghxy?=
 =?us-ascii?Q?vdWzZWnSefFwG65uUe2G0D8iiu2hYIPDJvJKjNntl/LHcNjZieYnYsp0ltPf?=
 =?us-ascii?Q?Uyfh7frqAj5xjGQrniMo+d4Yhj8oYIsvIuy69KmAancA61drkGjnIAyOdsDJ?=
 =?us-ascii?Q?xFI8GU4mr3a++/y+N9nPZl98191Ksbymzlk7OkciihoL9OTq777jMV/ytGHC?=
 =?us-ascii?Q?WOhVU0b3cXEPq3Ws6mujdJG33v0yf20oLwmdNNyNF1GGUn2TnjuMRBhFOhaZ?=
 =?us-ascii?Q?2V647bXsKp4e3mPu04n1NzJsV+Q9J+xvqPwyzBdHeCVAqqoSt90ypWNPPClF?=
 =?us-ascii?Q?yx9ggIhNq73j2ZNwSZCHe7/fotWooJGSdE6Y8J6CQlphiTUH+q4d/1WmoJS8?=
 =?us-ascii?Q?hziXFxGspV8Sqf5c8Nlosz6KcHjJxKGWGqO4ZSx/0gZvTViX7qnsb8mPMVFT?=
 =?us-ascii?Q?1XCrnWqLcgFwcda21/eWo2d3GbMxEgohTLO1RkVrZYQ40cZ/CQmOVzeW/TvB?=
 =?us-ascii?Q?4k6nbyF2x7niRlvZh0nivnUaucQVquZkOEld3kDtrUzTiqQCclKMnozX6Hj0?=
 =?us-ascii?Q?Av6FvStUGqJ9yS1Yzl56C6s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5a55e8-77aa-4cb0-eb97-08dc06f39ab0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 15:50:52.1811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mw5PgkmloI3r2fAZLoR1t9Q/Eu+ftsUaixEm+dOnhSJ78hsxseAC0tZWUWNJH0m8uc+VTBc61GgBbq1jwYSctIUHWD1LOecm9TCmDv6h9V53YVWdFBBFPP8XfgUxoZHp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8401
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Dec 2023 15:51:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14201

Hi,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, December 26, 2023 6:32 PM
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@=
toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>; Biju Das <biju.das.jz@bp.renesas.com>
> Subject: Re: [PATCH RFC 17/30] cache: Add L2 cache management for Andes A=
X45MP RISC-V core
>=20
> Hi!
>=20
> > IOCP is a specification option and is disabled on the Renesas RZ/Five
> > SoC due to this reason IP blocks using DMA will fail.
> >
> ...
> >
> > As a workaround for SoCs with IOCP disabled CMO needs to be handled by
> > software. Firstly OpenSBI configures the memory region as
>=20
> There are too many acronyms here. What is CMO, in particular? And putting=
 this forward near the IOCP
> definition might be more helpful.
>=20
CMO (cache management operation), in RISC-V [0].

IOCP (I/O coherence port), The IOCP is implemented as an AXI slave interfac=
e for communicate between I/O devices and L2 memory subsystem [1]

[0] https://github.com/riscv/riscv-CMOs
[1] https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datas=
heet.pdf

Cheers,
Prabhakar

