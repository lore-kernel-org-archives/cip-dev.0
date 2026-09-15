Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F335AC88E7F
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 15:15:27 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.16])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.25492.1789485319649752326
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Sep 2026 08:15:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=iX/glvSH;
 spf=pass (domain: renesas.com, ip: 40.107.74.16, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jr3lO94pkaG4aII0/d/njXH23BvFCUdQc7K1JtvrKghaVLpSwucQ2qiaoQK3Ig/4Idd0jtjswlHSxEqbfsHBnkNlpzlkIom1eq21+TCHYhpuxKLUkeStep4fy/fGMRSxwkRbpDifhVf2axEdDz1J3N898ZG63uf1ENMBkJHo+wm3P70Yt/v4yjrPoNKiEvU8s2WhGEA60qfKliY7dd9bl292oRKcuZkAzMExd+6At7SWzaQxhU5s4sULSzxP1Hkcwb3vSCR8RAPSLk4zzW+QsNoom5QvIocw4TZQ0DJgoiD7xaejRICb1TCD5e3SDcj8wt7P4h3BKYX2HqaqXwzccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xok2cy47NPALFO4BcqaLb5hgfj49QXZyoK4RgB5sdFk=;
 b=f1GVIWvJVL8csD36/PJ49SfNV62B0g2564e2U6XfpPyDcRNFbG1dLvSrT6UviKtg/SB+jogJsTzv7Z4ngnB08jLiXavUVq5aPgFgyG1e6+TfjEo9kfrJuMZY0pxJnYUlmu/AS4gE8pmJMmT1euprVACRfL0z02zBJAQQAnq6ygm4a6MzVHpDdTiRL/AObMffEyWB9f0nebIYGS8WcAusKm5KFzn17XNUnSC0+9tIzpJDZc1unOdPuxl2s7+U56ESsrWTaM2nJtcCHpeEAzIIycXikgCivcke57B4YzAG+2p3j8YKMcWE6ogRsBWX2DHxM9yMSPrR9wb9vZU7oHHezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xok2cy47NPALFO4BcqaLb5hgfj49QXZyoK4RgB5sdFk=;
 b=iX/glvSHBxmv/c942Myl4QBFJgZjO/xQ+Pdzto2tbrIqAt4pll+8HUh+sSbu7T+0zOoKechoc+2R2nO7IMkpWsz4hmdCemoKdy5YhMVgs+ji1k2rNLj42ec6phpJYfNXJOauDnO2MiH1uSp4HdJTgIdMb5TI6X5rtvJ2gubRymQ=
Received: from OSZPR01MB8123.jpnprd01.prod.outlook.com (2603:1096:604:165::7)
 by OS3PR01MB7189.jpnprd01.prod.outlook.com (2603:1096:604:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Tue, 15 Sep
 2026 15:15:07 +0000
Received: from OSZPR01MB8123.jpnprd01.prod.outlook.com
 ([fe80::f2ff:7635:979f:c31a]) by OSZPR01MB8123.jpnprd01.prod.outlook.com
 ([fe80::f2ff:7635:979f:c31a%6]) with mapi id 15.21.0406.012; Tue, 15 Sep 2026
 15:15:07 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@nabladev.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: 7.2.6-rc1, 5.15.221-rc1 testing fails
Thread-Topic: 7.2.6-rc1, 5.15.221-rc1 testing fails
Thread-Index: AQHdRRczE16GrDmZ/0qNuQ4l29Tee7bPqEyw
Date: Tue, 15 Sep 2026 15:15:07 +0000
Message-ID: 
 <OSZPR01MB812339A59B91C3C70E2595F4B7BA2@OSZPR01MB8123.jpnprd01.prod.outlook.com>
References: <aqlJxhduleYsXGO1@duo.ucw.cz>
In-Reply-To: <aqlJxhduleYsXGO1@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8123:EE_|OS3PR01MB7189:EE_
x-ms-office365-filtering-correlation-id: 65cd38b1-5a53-40de-a1e5-08df133c205a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|13003099007|38070700021|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 rCP5dgIY0kozDSi6kx1ZncHz+lSU2vziYerihKmn/e2f4SLJ0kyx1REc6pDG6P2USPQD0JCQN3yoUNToq4mkKbOdBft39HWKQWJnrdaL4ZpOqelm53MovxQfcF0Q132bUFjpsOgQMCVnfOd44VwKSQCRPo86vvgaASU3sCSgtMAMQiywN9JCfW+TIwhGzZe6+wIisDEj3boWzIp5SAYuBG9j8af/QT1CbGnNk09TgYhlf86gnsTbZ6SNSnKgp5X1wU7PMVa2dxsc5MpQQ7GrLA6AILJ1Nlnd21BqidTgmzLL84GNuGz/QbYRt16nj/WbSe3MqDN0+sYMUmCEHRYAJetPKM5b9vgJM2arT2Z5qg5YpwcBoC7D6e/6zRCq491fDLDNEb0B3YpHdZgPG2D4lWwou0tXtw84o/OKUS6oAVxE+HpKDF0Dr1yCQ6rJZ0dEnU9kikq8LMFXLX6uKHzcqY3iBqbIfTTEib1+W8F/J5TzHR4fk0+6qdiIc/CdwSQm1uqnW9RCvalTM0N0u+KLWgWyrmrheD+1+EB7+WuTMYStbgJzts9qlqTs4jJmIcWrfh9RZiPubo+CrHq9/29twLUU+r5cjZQcdEpH39pR1cH9SbtWU8+v2ohPa68hmQciAdqHd4NFFU4NGUde8YyjblQybbyEiVdfiEHTNABeM1M=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8123.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(13003099007)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?1Q502immcTtGusTLQcs6hKMx3MKJ34efsf3SkOPIDzCIGBmiAcUp1Qd5?=
 =?Windows-1252?Q?evPhp4JzwMHD4SeChI3Zh9+OxNmkfJvp7QAgfgwvrxSr0P2s6Lzo5Cs1?=
 =?Windows-1252?Q?O+RBhzckGSKxWfxgW0ju1W87DNDKbbAwE/rvV4TADHdIu0V45yraXEe0?=
 =?Windows-1252?Q?LUEIXry5PLHYg1payHajCVtpq4hnIPBeweMrExFhF1UOI3kt4LutfQdz?=
 =?Windows-1252?Q?xYNr+T0Ifll++fc/N3wIkUub90clRoHFYvy96auo2z1v6POebF0a9OhI?=
 =?Windows-1252?Q?xQ+QzP1TXpGfGkIZx0bGi7NegVjcmSN9AuYLAsYtTFz9ewMav8r42nb7?=
 =?Windows-1252?Q?AdEFIqsJAalj5siNPyjVbzzB8nnpCqwGvNDSkFquJFmv8LL716kofO9v?=
 =?Windows-1252?Q?ZiWifvpe7w5D6illxOko62vd7g0vOvHc21uFaQDIsHnp9bybuBRJNj+o?=
 =?Windows-1252?Q?gZVU5S0m7ZpExjLelykdUqNWQYw/912pF3y4ktJo9Df5Lw3FtH0Tr9Pt?=
 =?Windows-1252?Q?CaxR17FzP6o6P4Pa/QiyVPV2DJmNP2vJO7+BxnJD7bPKcEtChGXw/K1z?=
 =?Windows-1252?Q?65S0yYBR/eCSFjZLvAEoJkacMuDpP4x+LlGZo0EAtcJp2K9e9Oxa9V5T?=
 =?Windows-1252?Q?efX6RQZJqlwbpLzgCn4tXyOX7ZoEXhDVRslN8+trbetpKK4M+4vetpKG?=
 =?Windows-1252?Q?yRma0NWLhg4P/GYTdPQOGTGKTPXmE/mHH3Sf4JIUloS++1bjFjKNgxmS?=
 =?Windows-1252?Q?fdOP0BVvaE6AXK97bnQ9jKtZUI07k2+A7C/Ki+Sel/ewBL40q1MBAS6+?=
 =?Windows-1252?Q?3uXYjs2MC52DHnwQFJCLPHwEmVK1JOFj5lGb5iW458kLMGN5r0KTaZZP?=
 =?Windows-1252?Q?zKwAtdGj+KmPKdSGfDkQBc01oZPku3hafGNq1l6w81yqK9zkoY0jit85?=
 =?Windows-1252?Q?Oo9D7yg1XLTSVYctLFpDofLO4tawsscyGNL7QOHDdd5mxwIw7GCqL6Iy?=
 =?Windows-1252?Q?xhLU8C1Q3DkyVSypmA/MGRE32vUD+bZZUjWI1jpA8bLowc781vFVBfw+?=
 =?Windows-1252?Q?13hq/a7saDD/8C9MZ+ASrae9U2ZfU8VYXCF9q4r10RT7KjF+9C6pDAFB?=
 =?Windows-1252?Q?rjcBaXx9z5uYP10/d3rdoKElQC3V9R1vAbDg500NzB5ekebPQlrTp8Kj?=
 =?Windows-1252?Q?97eXeYzAv3+ckdGL6DVSjSJzY0F6eN6iqkNZJPjlFLqICsddwAgETpeM?=
 =?Windows-1252?Q?LiXvK1zIVDGqHaz96/PfDY8pu+dUGzDmOBPt4QbQIU305fqla5O2i219?=
 =?Windows-1252?Q?/knjhoMvU7nYAS4deAhTr+jECCa6Sq2vYlC6guXpTbtPLQGR62FiTVWD?=
 =?Windows-1252?Q?fZXhpgPMC8wUVgg9bw73q175YOHRZyTo0csuCWB1obS+K85J4KDk8MZQ?=
 =?Windows-1252?Q?6IL7z1iyVr5SJtrWNKdjeDs6kYpdUfgMVGPJsat09XFwddyQXRuUfIqH?=
 =?Windows-1252?Q?Vaf4XDMMxbV0LImil23fWgAZ+i05dVRFC8FUqFr/nQRHlfWk9gNrjZEK?=
 =?Windows-1252?Q?9gYSSwHgo60lEe2cbsr8tE+sclvU0Z6fGWdKticp9yiI2aREgW+gEQcN?=
 =?Windows-1252?Q?EllYFaayTEhB9mjJCkDNxrfGW5j+VoQCn2YuX4pCo8nwlLS6kU5D95Mi?=
 =?Windows-1252?Q?Zu/v/vFPJkg5vFVqaQMNd/H4YsOPSnDiqNU0vOMM20tnd6PQ1vec3xek?=
 =?Windows-1252?Q?SXMtgs0luPoO5btHPWiuzRvI4pbCi+PgR3MVQwiOBkrkiQUv/Y0ULQ4e?=
 =?Windows-1252?Q?e1PfifRGmjhlgfdRr8IVB0OqkSTbbBrj/MrOqo3h9tst68U/5BQtHYzZ?=
 =?Windows-1252?Q?aH9Oz4zrST5JSA=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8123.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65cd38b1-5a53-40de-a1e5-08df133c205a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 15:15:07.1651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WgSnHjURNHWBQbkuhymkuzljACyTFPYTo2U4oKyyB4HzBCErD41ZtKkpU8UB/cw9lOnSjolyj6SNn5717SffejAcBoXJp9LJVlqL3nTd3oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7189
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Sep 2026 15:15:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24191

Hello Pavel,

> From: Pavel Machek <pavel@nabladev.com>
> Sent: 15 September 2026 14:36
>=20
> Hi!
>=20
> I'm seeing testing failures:
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> /pipelines/2842909542

The history of the failing test job can be viewed here:
https://lava.ciplatform.org/scheduler/alljobs?search=3Dlinux-5.15.y_cip_qem=
u_defconfig_5.15

All tests after 5.15.221-rc1_270d4b1b8 have failed.
(The pass at the top was me resubmitting the latest pass - 5.15.221-rc1_ded=
ed5764)

So, to me it hints at a kernel issue, introduced in once of the 5.15.221-rc=
1 force-pushes.
Hard to track the exact changes as it looks like rc1 got force-pushed three=
 times.


> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> /pipelines/2842913623

The arm qemu jobs all seem to be failing since the qemu upgrade on the lava=
 workers, e.g.
https://lava.ciplatform.org/scheduler/job/1508639#L146
qemu-system-arm: unsupported machine type: "virt-2.11"

I'll work to fix this.


The r8a774a1-hihope-rzg2m tests are failing because Linux v7.2 dropped buil=
t-in support for the Ethernet driver that the SoC needs, so it can't mount =
the NFS anymore.
I've now dropped this test configuration.

Kind regards, Chris

>=20
> I suspect it is gitlab problem (and not kernel problem), but those
> usually clear with retries and this one does not. Could someone take a
> look?
>=20
> Best regards,
> 									Pavel

