Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B3FC4707B
	for <webhook@archiver.kernel.org>; Thu, 11 Jan 2024 21:15:47 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.101])
 by mx.groups.io with SMTP id smtpd.web10.4349.1705007741810686308
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jan 2024 13:15:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=ABkI8XlW;
 spf=pass (domain: renesas.com, ip: 40.107.114.101, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeX9zobaLEQEdP/FH5HrDdXweHbMo6dVHCnck9QlKQ48aC3dABiEwEZCBIl9jSicPNH8T626Q13OGlYhQOn8lG/uZE5uLfSdHB10gWn2Py2T0pZ8rhMBugzPEIJnM6MkJ+7G7BUqSTDlLioTOTFaGbabYkmErJBz2AREcnC1yEhhH/p10+mp/jUJG5ZelijqmSgNWWIEU8G7AOxpYgBsim0NHiAk/zz5NwtRwnjuqQ7QwiFoAZ5u5q5IZvw5ZBUwGqcETROainpcxB3YJzMy38esMldR1m/vAMbvJoMqgIj+tJvA2lOJ/mnjSElJy3KaQQBUVw/I35aRuVyrZqJF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kyVSId+IEQCD7tbalzFauTyQT0sJDjjOXCF+pMjgO4=;
 b=bAQO5zX+uIkk/v7WbRAoaY9TJTVzQrxB6aN0hLw94aoRTbLFJ1zkNS8aH4nIMmfnJAW2WbbromeAighRXrsZugmHDR43uwbwCQxeH3gUum/v77+LGIDGlSH10JVZCirp50X+tIwKjjpQqq9NSxydbYksG0cjGWaVPT6feW/lzODny+iIuylf7hQ2t0nD+zo+cg03Psepn4uW+ZfU34bQe1DtMrXjU7tpRbbNz3Jd19xiwuTQIt9EeOR0NE7RmuCYOkvkALzFVz1vXUw+9QO8vOc1XH73BWumOMEPAkQ2Bo+0Gs67X6OagNrFhERO+FM9u9BgDl0F9Z9PGuFjCr1o1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kyVSId+IEQCD7tbalzFauTyQT0sJDjjOXCF+pMjgO4=;
 b=ABkI8XlW9ODaDsZDamcX8H/rf3MUU8aBFA5FHoaw/PSWWbuHcP7ZI1Fza+vWjCgVeT9PA6XLFjlDfy8p5n4Af2ychBB3oM7cgUvAEIKFRcrwtgkiAYuEWyy9v95kFGWS65vumfy/bdMYTFd/tl8nJkxmycwuUMBcuej2MkHQSMQ=
Received: from OSZPR01MB6816.jpnprd01.prod.outlook.com (2603:1096:604:13b::10)
 by TY3PR01MB10110.jpnprd01.prod.outlook.com (2603:1096:400:1d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.14; Thu, 11 Jan
 2024 21:15:37 +0000
Received: from OSZPR01MB6816.jpnprd01.prod.outlook.com
 ([fe80::f865:6ae1:6d7e:f899]) by OSZPR01MB6816.jpnprd01.prod.outlook.com
 ([fe80::f865:6ae1:6d7e:f899%2]) with mapi id 15.20.7202.014; Thu, 11 Jan 2024
 21:15:33 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek
	<pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 00/30] Add support for Renesas RZ/Five
 RISC-V SoC
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 00/30] Add support for Renesas
 RZ/Five RISC-V SoC
Thread-Index: AQHaQl7KzaCr6SZL006IrgPr6YzfgbDR5ZyAgAM4jfA=
Date: Thu, 11 Jan 2024 21:15:33 +0000
Message-ID: 
 <OSZPR01MB681614CFF5148B78383DAF66B7682@OSZPR01MB6816.jpnprd01.prod.outlook.com>
References: <20240108181612.5651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZZ2jpzco/6c5h/UP@duo.ucw.cz>
In-Reply-To: <ZZ2jpzco/6c5h/UP@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6816:EE_|TY3PR01MB10110:EE_
x-ms-office365-filtering-correlation-id: f10e636d-cc6a-497a-9ac5-08dc12ea7283
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 YMnHgukAn8/uzi5iXaEitDdImkmA2U9AFOP/c+1vbGUqCtf3USTb51PvHO7wb+3y6xwcD/l1n07yMo6EKz2am2OvsbBiGSayVL+kbT10sg/V00+NvZ43xySB8bGMUIjmevN//wnuyveq0P4x+oKipAMHseHilwpNWcosb8WbqMZT2Z190jx9YsxmWIwjPwerCIBxbRImQNvenCcnPllIklIjaePbxT+m9dScoAAegBCkw1e3Rrx3g339LIGJ8oWBVh/Ya8DbIb7CxgUjVsZTvskKNoTQi3PZvKHiSl/g4D4my4j4keTOzFGZXB0/MlzNFgyopxrp9Anw9PhffgDvRaDFCKEdeXjtwagBD1wR3gSmc/0+geTRepvd74syry7hQrOoJYR/6a4fRK3iMc31DRexWJ+Elq5CAiZIgPsOmgz3B4oWaiPLuj61FE8Ub14GoxKaD8chq8RV7WP4vjCQn7mYseyVZKI+xh7SCavsPNbcB2ffv0c7Ke14XynriUglPoZ1YL8okB1qHvrxReRimcHypzozuQ8i+G9rpnaKM3gh+Z2sont/6vxGPalj+gI3sG5ik9ErKOFUEXqWNO7x/eoaF4czv/h+8V5CZRWcSSI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6816.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38070700009)(55016003)(66899024)(107886003)(9686003)(71200400001)(5660300002)(478600001)(7696005)(8676002)(8936002)(316002)(52536014)(54906003)(110136005)(966005)(76116006)(66946007)(66556008)(66476007)(66446008)(2906002)(64756008)(83380400001)(6506007)(122000001)(38100700002)(4326008)(41300700001)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?dsl7brucU6BbHCR5LRortc/uBrtDyp5+rJ+XPOR5c+4saGolPbsztdDd?=
 =?Windows-1252?Q?QR7sdPge0iS3DeWhlwYvydNLeYksqibaOhxeluJ6hKD0wlupNcKYO4dv?=
 =?Windows-1252?Q?3X1qXTWkVLBDeom75bgrCM6J0P+ca6DGE0BgBD3LMz+RsgG5vqzB0uhx?=
 =?Windows-1252?Q?LuzOhKKkz30DEpUXE1w8ELFgtCGied4aDx2QmK5lBJVbVv5DuOqhb4Pz?=
 =?Windows-1252?Q?QcgvH+u0PBiRNQJB8uaxmsA752ewhJK357nQWgELHwW2GYO5zAA2zfGG?=
 =?Windows-1252?Q?Cd6FRiXNSeiWopWcq7UljNW8JcXrp2H4AinuodbQ3hBrCpMZZyopqNnn?=
 =?Windows-1252?Q?x2oZIVKtT1+zeVnAd7yiNJOrwLJA9P26EVIwamxatRNAk3sGDKFRiPPi?=
 =?Windows-1252?Q?VXgWx5EqKvvygbveldwNUHbXlRQGqZujnHw1w4ASOvRz1PseMGVCDi21?=
 =?Windows-1252?Q?zXTLjxQ//3CPmLoCfUH7L7+Xg/aWBXasJCAfr+XHOHs030Ba/Zm5PFTN?=
 =?Windows-1252?Q?nl8CeOyobK+mtrwBUx7fDLaPS39mgaS+wo6wkQuHTo/h3svZsVYViEhv?=
 =?Windows-1252?Q?N5dRPyqEFjsAlYAcrMQyvm0cobiD3ngfzfGmDpxuAsp+uWszHQt/TnWg?=
 =?Windows-1252?Q?iRIur6QtsNpi5VcPgtBcEmaMeeTEI/s4M9t6dzcjLlxxXgaaIzYbw7bQ?=
 =?Windows-1252?Q?O+vSoxJcisO6G/MYx0S0mCAcT1tSpxVDsZ2wqmW8+x/8dWmfUsss/ez1?=
 =?Windows-1252?Q?3T3okQS0iNL79PQl/q5dq5lMHgzmFFtFaUW3s4u2rTdP4p6iRuT0/vpk?=
 =?Windows-1252?Q?0NNr5WnhHWl57Mpn6ibZyur/FPAz4mJxl/1yp0ca8a5ZBcJJDn/NcUiI?=
 =?Windows-1252?Q?GIb228tBFt5kmLRzjs+BfGrgR5nQ51d3YbWLVA0F52kVhYYn88t9B/CX?=
 =?Windows-1252?Q?eq//0od8Gra2icrbNoT3Dln3lgP0naOOM54A0dajBzlRA8F3/lJOXa5B?=
 =?Windows-1252?Q?N01n7S4lWylqmM4ANWF/m3RzM+OFOoVqnIQp+95JUGC5ko9bOSv/RgLg?=
 =?Windows-1252?Q?E0aurOmmiMAEXEgevGQTJmQHAW6QUZSCLrkxqMnSyDeriFpG0BaGSKbN?=
 =?Windows-1252?Q?kAtfIKxuh38Mch3L27bUo32mD68R8o5cU+WMj9Ak2bVFbS7m8iGDFAOn?=
 =?Windows-1252?Q?fGQs29dnH21+DQ3zX0sF0LE2YvTJN6imGVS+czWxmt14ht+oQm7nWqZ/?=
 =?Windows-1252?Q?FiplMs19ZDc/JvkObdDeFaXTmaXiUPzlmzSCyXc31tJft3g/LbYXEnpq?=
 =?Windows-1252?Q?7pwshLwCK41JYofegWLoMh2IWVnzz4KUIFRAUjWN6Qeoi9vCq8j56SI8?=
 =?Windows-1252?Q?B90GlXPJFTzpoQhRHu7bYDbMemrh1+Ib+Mt2nOMeCGFaAh2xBJipPQKA?=
 =?Windows-1252?Q?Tnfnn3PyCF+ErjuB+5NN/xusqJ5wzhEq8MnTR3BtmSp1fB6/NLB75/0e?=
 =?Windows-1252?Q?+Nj2TyjM2H6kMftjFA+1xR3uElyZgEYEv2XMynQWXGhQrhg598+DnlXK?=
 =?Windows-1252?Q?bSPrB1PpCBYpKtGVlCcb5OmFRcb0TRqNy4/2F4QaeAjZkRZAgOLbAtPl?=
 =?Windows-1252?Q?eyNElIyA0NVzmfOSqRuqAH3iOx+t1ilQvMKSM12v2t5Dn1vt7RUP1EWA?=
 =?Windows-1252?Q?sNFjub5BHH0=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6816.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10e636d-cc6a-497a-9ac5-08dc12ea7283
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 21:15:33.2265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0d99f2XwRApObdJCxcXwOPo64EZ0wc804kwXlxzhXsBs9tvHTtC+9sXT50mIXy0lQa6JOWQ1Z5kjqwmkpis+vGb+aJXNVqs5lyELiWoLO7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10110
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 21:15:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14347

Hello Pavel,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Tuesday, January 9, 2024 7:51 PM
>=20
> Hi!
> >
> > The RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP
> Single)
> > 1.0 GHz, 16-bit DDR3L/DDR4 interface. And it also has many interfaces
> such
> > as Gbit-Ether, CAN, and USB 2.0, making it ideal for applications such =
as
> > entry-class social infrastructure gateway control and industrial gatewa=
y
> > control.
>=20
> I don't dare to apply it without testing. So... can we get qemu-riscv
> and this board tested for 6.1 (and probably 6.8)?

Currently we're building using CIP's risc-v qemu config.
We'll get test support sorted soon once we have a suitable rootfs.

I've done the initial work to build for RZ/Five, see pipeline [0], job [1].=
=20
This is using a Renesas specific defconfig [2] that I've created a MR [3] f=
or.

[0] https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1135494=
600
[1] https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/5914246689
[2] https://gitlab.com/patersonc/cip-kernel-config/-/blob/patersonc/add-rzf=
ive-config/6.1.y-cip/riscv/renesas_rzfive_defconfig
[3] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_req=
uests/87

I've also done the preparation for boot testing RZ/Five, however before we =
can use it I need to put an RZ/Five board
into the CIP LAVA infrastructure. I've got a board on order for this, so ho=
pefully we can get this sorted next week.
I'll keep you updated.

Kind regards, Chris

>=20
> I'll also ask anyone for comments here. The series looked good to me
> the last time (I may take second look), but I'm likely to apply it if
> it gets tested and if there are no other comments.
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

