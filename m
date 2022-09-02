Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE00C38145
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 11:05:09 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.134])
 by mx.groups.io with SMTP id smtpd.web09.5124.1662116700987332832
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 04:05:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=CXn0hP+M;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.134,
 mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8+PtvfEIEKkRlbZmhuvSrUtujCeqyHnP5n+1WBCgfEdOSs5y91xhlIhhODUF234QROm4//LFlcws7OxTW2JguHD5EvdkxRgXt16vqpOrZckGtLebD/XPAeUI/gKDDUhpmvgzzTJ9Tsh1AbEhxTDD7e9z/bnvHucs7ldJjApAK2rsIM3/+oD8D4jrrUqOKuVud71gr+F4diMU6rxKvIwXG1kQBnN7BnBRx5T1DlPYyzLVLuPLNFQsUjSHxiapT97m5tMbaSaNw0C3DGK/jAtcZPv/trU24km+X+NLabEocqSnD6AHptrMrPqRRAM7hvFatUfDNYFKoWgW7r3uFmztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yQXt+98C5NxhNYc+uuA3MI6JHnPoSiCGcjYV4CrNt8=;
 b=ds0m89mePxpFmWxJvohqtTfEZxZEBKYxhRuNwlaYKxCcssOMbwQuw6FQ8z/LafI1WqPpSNY9rSGmAvExe3vls+om8wCKYkryD+4lCgE4NcduuzRhPkmDfTXE9qNGEzl1DDCj0rMGZok/hGCD6IruWeiF7IAEANRp5Gcn/EkudViJEW4gMq4VtLrf+VwGpiMrKHEGR6VE07J97w4JohrcaqSLAvCT/LUiFov2FTzuTh15qFEaLGK+wakCyFRy0O82OKR8DMVKDDdaKDxeOlAvtqXbWobseRw6eVUQmvZDxgm1RNb+ZN2C82cDwyeXGo93hvdWtTDlNQzTMQ6QJX06ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yQXt+98C5NxhNYc+uuA3MI6JHnPoSiCGcjYV4CrNt8=;
 b=CXn0hP+ModSNMrHhpB3zPFDzcaczZiKk3edb8D+R04SNbt1NSVN3t5pxpBOgvmR1UrKgj0sK0dPuRLVB6868oNo2iDL5uaNJFI67kyYaIJwR+x42JYGgqsIBgWfn4RmjLOI1pHmw+5Xm35n959oRX1Czb6MXhQi6uJmLdSHELAk=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB9497.jpnprd01.prod.outlook.com (2603:1096:604:1ca::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 11:04:56 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::14d3:5079:9de1:ceaf]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::14d3:5079:9de1:ceaf%4]) with mapi id 15.20.5588.015; Fri, 2 Sep 2022
 11:04:55 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, Nobuhiro
 Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Chris Paterson
	<Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/26] Add RZ/G2UL support
Thread-Topic: [PATCH 5.10.y-cip 00/26] Add RZ/G2UL support
Thread-Index: AQHYvVlFSI59kwD6TkWyQ/oS9MMtlq3L9COAgAAGWzA=
Date: Fri, 2 Sep 2022 11:04:55 +0000
Message-ID: 
 <OS0PR01MB5922FE580A24E836B256616B867A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
 <20220902103319.GC16210@duo.ucw.cz>
In-Reply-To: <20220902103319.GC16210@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e3c1240-61ea-4865-10a2-08da8cd2f7fe
x-ms-traffictypediagnostic: OS3PR01MB9497:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 dxhypAA/sNQBNp+3U7Qnx66zkatiPaqHPhvl5fww4ImefNBLTAf4Ok+eH1Gbbn7e+SWQgp3TQYntnlJmMefZngHxi2c3R2LLD2igA+WkuH3/lcCY6pu9Cti9vvVPzdiobR/PAlCbkUxiOxsqPFMMlNxhircPDwnszpe267AazoycQR2Fvk69QZAuTZxjhTAYi9Z8DSM2Rx7DFi6NRBiCGqnf8cMPqitD1OLe1W9ov+fpMXWiTaXHyOuidn/P6/fz83q8O2/tf1uWMcrr71z0fe3ErYPNqFmu1qtCIC8KLxyJ4xc1mmECLcgecfIOOd9XNdAHeyaSfRUjNTaR3loa/73FmMfvj9e68ovTtijQPcl5zX3IMr9FUTXIQphKCLL9Ak/58/nQyTF0f/kJYI8knWNUkNBixV8Lsl1maWRGxb1EYwoBqdoUfD9zyQhk/fl0xo2kgOlSsnHnTGseSe1BnSfYxhVYFyCz4TABPniB8ID606+RCdMV45yxUdibawyGDBVCzkpuPDNmQgPN0vi30ZxLiS/k9XNj/KwouX5NzUM2u64SsPLJgxZWx1BOq2c3SErKkrMRynN72uRrbTBJeRXT/RFr3RUur4piYAPG7I/P6fyYD4r/J9B41oFOLw6lMhdvpIJVthwPSCZOqmWeojanaYt0OoOzR4LBT8nuJlfFePPqdkPNNINwfrF/NzNboATqYCsP83yMtq8gIKy/UbLXNpoW2gHNvOvAFOXivP6A5s4urIvGLYDw0aYi/c/R
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(6506007)(107886003)(38100700002)(71200400001)(41300700001)(122000001)(7696005)(186003)(478600001)(2906002)(4744005)(5660300002)(33656002)(4326008)(52536014)(64756008)(66476007)(8676002)(66446008)(54906003)(86362001)(8936002)(9686003)(26005)(38070700005)(76116006)(66556008)(6916009)(316002)(66946007)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?GDofCJ318rji3NdqG4sK0kADUAciVo4Q2IQ1KR80x8zF9EmA9eTL8e3KXhjN?=
 =?us-ascii?Q?L+ag/lJlVTbPnWsS18fTZuizyzWG1AUwcxmVHXfDvAi1AbnzIejllDhNM6ab?=
 =?us-ascii?Q?8nRhZQXFg1LsHN+VV2+T72/lhdGF31j7O2x3w72wZwUdaJOXgjezbk6YU9Tl?=
 =?us-ascii?Q?7bwXsrf4Vr8/6w3g6hMIABZ8OGRaWQ03X/cmSK56m00wCjIIz92D6Z8QIGbI?=
 =?us-ascii?Q?+ZtDnkHLMCujXprUp4kGXrWhWXYS4+0Dy/9Y8LUho5Iyazb7EhTLK5+q/Mh/?=
 =?us-ascii?Q?Gkrj6l7gltazk1Zv1xygRSgQ8EFqtiITk1NAwfoIQCL4w9aYDViGvIAwsTp+?=
 =?us-ascii?Q?UfIkqSLRMubDUp+1opVJebhEtk01nmEWGVH/1nH6UtLGp+O0kclxrI8OcX6H?=
 =?us-ascii?Q?e16kwk0mjOF5pIVEg+n1B/pGgFUexb5nABuypT/v+TTLfKRV5+FkzGAf4cTC?=
 =?us-ascii?Q?MsDfGZF/GGSygyxPk9d7KLN6MGv8/XStVPT7sNP08+o5PWjcJU6dTU82S0H5?=
 =?us-ascii?Q?SkYGDPhXfc6jaYBXhH1VZgeelAj6pzhNhRzwsbLpvrJChb+StktFnh4HvjS9?=
 =?us-ascii?Q?5pMt2b1LLb7c4MQjbl8L47TU245KNWBo0HUPCpwFixqLQB2xWg8fRznh18Be?=
 =?us-ascii?Q?FZwMtWVTPSPrfOxphRMTJaI1oO53YKogAEByyg4MLrFCdlpVPX4Fmqbnnlme?=
 =?us-ascii?Q?/VW/ONpBDLwzckIdaVkiPLCVypKPkdK7PlA3+X95FHwsZOqQrfQjm8pv0MW3?=
 =?us-ascii?Q?TrQLYY+Ips7HMVx7KiRmLse5S8tz+9mUZ33aXtkgoIpKeQXDpTZda6T8G/0D?=
 =?us-ascii?Q?fKOl83RhtWWlOYqL5vs5wmksFLfBP0Ci86yh8nUtg69MQ7G2n32KP9n7MbOe?=
 =?us-ascii?Q?95XbxmYdFP0qPQ807NA4ZkJyjLfcN/H9M/KnUhblVs5NRSlonYdE79xlVN/S?=
 =?us-ascii?Q?QRC42/aCA/pWyPywnQwCabcWLzK4h8uB1LgB4ZlwlVn0mNBCzuVZNsaLaNj9?=
 =?us-ascii?Q?qtNppK/6QOUwqUImCc38g4fP70Yk5VAb91odjqk9myN1J5A8rRuwRYhSqUsR?=
 =?us-ascii?Q?r8ACPaWK7ZjBeoI+QRqOHMhmSzc+LOeYnlhIu/l0Fce4Yv40gr1w26Mlg3Wu?=
 =?us-ascii?Q?XU2HsB5z8rOamDZMDwb50HIvU0MpYLmce11mQeSEhiQ3F3AFGtBlmQ4tLXvX?=
 =?us-ascii?Q?AlFQvxQzgHHIPFv9m4DrfWLlZXIMZf9vGhbHxrezBABGCnK+d64KWVcOuNF9?=
 =?us-ascii?Q?JrAW7kuisRh6Z4TcwtH994CsKgYFmbE72EpaKePZvfmNWO7qeJuDrAdHYfKh?=
 =?us-ascii?Q?0MLekv60LS8bk9XH2l6reckLMLL0IKbbdh63Un3JK1vemPwKJsVRxbKrAN52?=
 =?us-ascii?Q?CVCypnMSfo7bjDPhW8H0V8dQ+9pxlkNwyW6RHP3kohRCsmJFkXlBBMac7a/f?=
 =?us-ascii?Q?5CyL4qZbCV/xGC8eZUcZdEPsjVgI7Y4q8c3V1R7XR4RQrBO7kXjDimoLjhAf?=
 =?us-ascii?Q?2QQnnuYU0XHX4/npbVSrTexbCndm2PX5rQAcsVZbbCJPzoiYzDMoM/0c+z3f?=
 =?us-ascii?Q?GXzPTiFRwV5ycclhEMvtlJd/WUW2pPugXg64a9RK7z/z3T+rFPx4YCJh90AM?=
 =?us-ascii?Q?Yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2e3c1240-61ea-4865-10a2-08da8cd2f7fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 11:04:55.7521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 KgHpZnWZMBiji5abN6Eiwjc9HIz0aq71boXywVzr2R+//nTif9YU/oNF1hWi5/bu6AJjczxNKbGflnvWsjxxsq7WeY9w80nMWvYc3bjT9Og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9497
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 11:05:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9455


Hi Pavel,

Thanks for feedback.

> Subject: Re: [PATCH 5.10.y-cip 00/26] Add RZ/G2UL support
>=20
> Hi!
>=20
> > This patch series aims to add Basic board support for SMARC EVK based
> > on RZ/G2UL SoC.
> >
> > All these patches are cherry-picked from the mainline.
> >
> > Subsequent patch series will add more functionality to this platform.
>=20
> This series looks okay for me.
>=20
> The only weird thing is 26/, where we enable nfsroot in the dts. I guess
> that's convenient for your configuration, but booting from eMMC is going
> to be more common, and I guess it may confusing to some.

Yes, I agree for production boards, booting from eMMC is going to be common=
.
eMMC boot from bootROM, loading kernel/dtb from eMMC and mounting rootFS on=
 eMMC.

On all Renesas development boards, we are using default bootargs option as =
NFS.
As it more convenient for testing on development boards.

Cheers,
Biju

