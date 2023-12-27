Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F153C46CD2
	for <webhook@archiver.kernel.org>; Wed, 27 Dec 2023 16:18:42 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.108])
 by mx.groups.io with SMTP id smtpd.web10.104776.1703693915749597426
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Dec 2023 08:18:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=PMSBnHvw;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.108, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaJtaPfChOlw3IH03fOw1VylQGXYEFRH3usDTqztnk8Ncd8sCkYRmqlOKg08G5yDxSVPVAGbkjlkq1Tgp0SIBMWbI5zHTit6ialZPS6BHZ+tKREehT9J0G696iy7YV6qFJ0X3qb25aRvdotGD2FFpQ0g0/OXNFvvbVqu7AtG7oKVCQQgf3x+OojtczCCJAML610e05dBQSX7Yx/m2z+LJggz/ZqmcscqGKRDcxLYm7uhruF88OmvSBZwf2nEVdQhEJeSgXcvxVgEJiKG/1sdK5NtDhs5dlelmv6QV0XpcawdMBC8lW7yBHd1/JlcOBG5J6E1dvpIkhaZIhq6frmLIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMCyQX/LOLexFCSTv0jzMnjUrRylaBLpNIZEx4gJ7fQ=;
 b=ayVu5NMftC6urmZlno+EqIhfuUP5frFn5mrw0BwQnvUmQxHe3Arvs/fgI/9cFMEukXJqhkIPL81K7OJThP2cptb6Besb5M8tHD5Hp/wlFqGqGdnj8WPn1U5LBGnRaMVGwAbP0n/onptl6W+/FPYOi3wqknhXvEHyR5MsTMR6VUoIASE85QejnZcyBHf30/f6p/Ws1ph1a6ayIMDe+zPk7PyV25CbMwK5QHinnZf5xL8UCe3pkkcf0Qzeu06W+8eSV9Tm8eUDK3x6TMu30c57fB5mTmivPHjmyLZT4wyy6BJk4G4m005CdrzBLhMc+sNEGvTmYtSaNo/ofqzakWmf/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMCyQX/LOLexFCSTv0jzMnjUrRylaBLpNIZEx4gJ7fQ=;
 b=PMSBnHvwh22p6ZRU8MN+pexC0ehG5gGNeL8aQhJ8JhWScGo2gp68ygpoMivuFuV/uitNfv6ONfDrCPL7/rxhnCjKim5irf1xdqpRMjLwAeiNPUiYg6pvgftbDW1fZ4kIiSvwrOFFhm4Ib0xx240Oyn/0geKMfp/nFjCni20ZRBY=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYCPR01MB11355.jpnprd01.prod.outlook.com (2603:1096:400:362::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.7; Wed, 27 Dec
 2023 16:18:30 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::39b3:aad0:4e87:9926]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::39b3:aad0:4e87:9926%5]) with mapi id 15.20.7135.019; Wed, 27 Dec 2023
 16:18:30 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Biju Das
	<biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH RFC 00/30] Add support for Renesas RZ/Five RISC-V SoC
Thread-Topic: [PATCH RFC 00/30] Add support for Renesas RZ/Five RISC-V SoC
Thread-Index: AQHaM5k3+GkHfSn/K02qVWBhyLszJbC77lCAgAFpypA=
Date: Wed, 27 Dec 2023 16:18:30 +0000
Message-ID: 
 <OSZPR01MB70190DB7501F1983008CD843AA9FA@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20231220230646.219816-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZYsdtS4UkTS/TUsH@duo.ucw.cz>
In-Reply-To: <ZYsdtS4UkTS/TUsH@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYCPR01MB11355:EE_
x-ms-office365-filtering-correlation-id: de3cebfa-f6ac-4887-883d-08dc06f77725
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 x1NbzkVQHzq6Cz68SYM3PTSCvYv/eUdYL5SHKplDRuphoWM1BIuPc/lBbgTQDlZwGmFvlOOyx9TryKDuYd72hbVhcezOIM5oxJYRm7xDbXPLSHqHNR1X87XmkXhMvt7iJWfCw5cPntfGqDDbsZxMnKu1q5D085K1ghSLBJPVNDUbp5JGHVRCwgfwrOb4KegzNTlsRkcooZwawUD8ieJq1sGrxL0UCbcvOiSKd9xVGSU2fbRMxt3A9t0RwL4ONZUDtqG1FKCyOjgL0wFtcskM2mllYU24/8KQx/EJauDiQ+89fwm2Jyh4LQgGrBoYmXb7L0+ov3/F4hclocJ29JmnxOrvIEffdfvOjPD4tKvfj66zpbN+bsWQgdE/0TnZCcANQQMETU8GLULsc/2ds6xz8TMr7iiE0vpBlW7UxLlN9XGiHS2JJZMbaY1JoStMpfv3fyyhIGB8+8ULAhBjqnlm7p/RFMtp8eYl2A0UNFHfW4LXh1atQNmf9DxgQmlZ3R9xnwa4AawApT+MzzV7qo9K+YKqd8M992RtuOJyye4+CO+W0ekFWa0dMLJnvyYPrFJEVMedgi6c03xR1lYbab2vCf92VptsU0xq7iVkhfkDoHI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(122000001)(38100700002)(6916009)(66476007)(64756008)(54906003)(66946007)(76116006)(8936002)(8676002)(316002)(66446008)(66556008)(52536014)(5660300002)(2906002)(4744005)(4326008)(6506007)(9686003)(107886003)(41300700001)(966005)(71200400001)(7696005)(478600001)(38070700009)(33656002)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?2kZ7svjWd04ft8q8sGbzj7fg+s3LAnR1gDUm1rar8qpuRxD+Nhf3hcN1s1EI?=
 =?us-ascii?Q?DbTK7gpn0tPom38R+VNPaReeLxa603nBqCaggEjVCYBRnmN568V08IjpCv5a?=
 =?us-ascii?Q?qRdGGu3plr5+e2O3sHP20a7ysbq951y7m8bFbItgy7i8wf6BHV7Ivtj8MokE?=
 =?us-ascii?Q?R5xNxJh6R+MCXjd54aXGVyTOJTcac4NrTMP4xkwgFZc9YwwK210iRVKY6Pd8?=
 =?us-ascii?Q?5UL999v4Dy9o7WOoqdsvJYU2J4/e9od8HhV/ezp3ayfGdIR6ai2YSJeTUeOt?=
 =?us-ascii?Q?lsvAz8NPny8HusY7mRsQsUKz4jpMWkZ2iLrFi3yPJ4HTBZMQRA0XjWM5koi0?=
 =?us-ascii?Q?xhcLaE90uS4fSx+cS5vyBsd84hpLSdDn3VqT/qTUi6FOUK7LXTS3SIG8gTUT?=
 =?us-ascii?Q?0jh2eyy9zP7UaSdE135e201IVR3z4ZTDGYnKdMCF4ajeIdAVUBT+ztQMlThz?=
 =?us-ascii?Q?SQT+dBFs6pXy+FPed9HycpPWGkQinXA60SPcRgUUy2Zevg/fz3ddfuQSnort?=
 =?us-ascii?Q?kjZP7HlBPH5uylGve1d/vSNgYC2mxheubxWfGBks/C/zhOXYAK6oqxTAa8CD?=
 =?us-ascii?Q?jGWNndAlxVxPSdT/Y5xs6sNWaWg0bSDr4Tc1+NEMygcm+ko18ZN2x4ndwQcf?=
 =?us-ascii?Q?IqYskSLkI2DvX3/bcleS76ZSrufOez0GLxii2FtC3eKUGFcSLh6x9zKeNRv2?=
 =?us-ascii?Q?vyv8V5EZj/vQ5eNSQbcKsqtJH+eQ3X7VoGmzEiFabn4x2dikXw1bFLkSKS9/?=
 =?us-ascii?Q?uJOl6r0KagtahpiWYc3Q2nn4AusGn0me0XHzXHEU9c8Tx2R2EtZHhu+lbyyY?=
 =?us-ascii?Q?h0mJC1/kjt3/9xIHCIKAzOB3DUAqx4yr9ulFJwqtdCIssoYG5XOl7qs4j69f?=
 =?us-ascii?Q?jxbJhKVXMlRtV8EFmasqqJZv9VtAIfjrpNjX+zy1XDQbJ0FqoJv4XVJzLuhr?=
 =?us-ascii?Q?clkmf4A87iU6ihdtghVJfS2G7d5DMeecRQn1saToPqhU4SIt85XR5DbV0qN2?=
 =?us-ascii?Q?nFwBObHNCnSSaoWD5OhEXzCPBenX83UP3n4pMAV6lGbqkz9tg73Kdjk9dpkf?=
 =?us-ascii?Q?MBM2PDX6Vyd6qMPO2rY13oerniIfsjLTHYfXIuxujfLxzb2G2dYhokn+VG82?=
 =?us-ascii?Q?z2CrWdn4Ip9h+Ik6YFqsyfvA9snq+2GkMp3nbZ4QfLg4xOgZGKTo35gc8G4b?=
 =?us-ascii?Q?7F7vMqxoZpQoQxVcS4N5olNvu/c0kA/AcARJninqTY3PvtYefUy4p64vnG0C?=
 =?us-ascii?Q?21c0v5JadAJq2ckbxcqUrzPXV/ZGtLBcHPt7fZFuuIxKATxQHhNojJmPxYbQ?=
 =?us-ascii?Q?BL4VvgPyxT2yyebbhplrMmFgoW/xGiOB9O3ydFXNVIXorILBakGaNl042TOD?=
 =?us-ascii?Q?EyIBNfFDZT0zCkmFVn7+8KcUAFaOSiM2N5tLjIA33CFCyGAmI1mZ9rwtjs9K?=
 =?us-ascii?Q?UJTGFLhiwT9Cves6AXwam/MsHsPnzanzNfyuTryCwGvQWSySp+MgSxOB/Hpm?=
 =?us-ascii?Q?zDnMk6+Vi0YIE4tzjxIsnB1ulRFgnPgrfAk4uCThNPU7wkKMURAS5qZdGO0I?=
 =?us-ascii?Q?HTo6/+O/ssZ0jm6E3duG5vn9vdw9IB0d/sJHGPjDc4rCObhj1TGAPIDV8G4Y?=
 =?us-ascii?Q?2OwEDUEnB8KYUIxZLRFTSZE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3cebfa-f6ac-4887-883d-08dc06f77725
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 16:18:30.5353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UAJLP+vYmFl/EszScvsVM6QYq3nMxiSCHCHYS+O2rlTIdxQOSUJL6edXStUjw2fWaGhmEdMNU1WYzYCUyfCNW39qiNqwp58vELVGAzAHpuqSeJc87dLqFTjH6/E8DPVu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11355
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Dec 2023 16:18:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14204

Hi,

> Hi!
>=20
> > Sending this series as an RFC mainly beacuse, as the kernel image is
> > not generic to all RISC-V platforms as the HW is noncoherent.
>=20
> Does the hardware also have the "low memory does not work in userspace" p=
roblem? How is that handled?
>
For the local memory issues (ILM/DLM (Instruction/Data local memory)) we wi=
ll need a similar patch [0] to cip-isar-core. Note the cip-isar-core image =
built with this change [0] can be used on other RISC-V platforms.

https://github.com/prabhakarlad/meta-riscv/commit/da749379155980d1f906d8632=
432f35a01a9c9a1

Cheers,
Prabhakar
=20

