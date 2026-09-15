Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBEEC88E75
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 17:47:01 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.61])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2888.1789494416206611286
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Sep 2026 10:46:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=lKRLXbZA;
 spf=pass (domain: renesas.com, ip: 52.101.125.61, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpWVyapz7EmfP3uTDm0YQL/5Op+qn6vppyxIBYaUtNpyCvJ2Ck31lCGz3+sibzmvdt+X0y6B01uvv9RmIeqMLQXcex/kmpHF2SZjj7KWEO25l3p+/ENaj0mcuW7d0smmI3PAFuoFpsnNCM/rOxiis+mpw+TpGars99MguB3Xx/KVibGEEqGlx/HX9aIGFL5d2pNq9peI4MRys5vSDs+PyNVLUYrbhe5P/J27e23BelPPdL7sUSf17AJtxvLp4koXYPbAu6SHNWHFVehLgEaTI0IgTXSZ5gogI8N7VezAUCTcIh0U2IKrKlXYh6ZICRLDfv1fa1F1I7VKJIClkzi0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IQ8JYLaWk4TqfjevKd0zGy/pwaDrf6a6cWhc9DXo98=;
 b=LOvvhnbPCkC5J8HsChgzieViBiqaJ08mTTUp27cb5QEU5RWzu22hUgPbXgZRytRQaiLRH1vUfl73LV3LrRRLPKODJz3rmgSRq1LZV7vNK6AgmtW/zqvxnFnI534XmUSK9DcNstxZvb2xCI0w+HbvUUIAnxF5gpX/aFqXciVWkfWUz0x6gHnQnLAS9rDIOv3FOnwUlt6gE6p7hq5OYe+MO36GtGttHy7O8xwGsEVSa2AUTbsN2xEaFN9c/ppitbF21gFnhre+4o+CKx22ZNz3jzTqZoyBjV5kIFeFd3VWHPKRv/c0yN3t6pjdiwaczTjMrUt42KLtqkUM02ae3RacIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IQ8JYLaWk4TqfjevKd0zGy/pwaDrf6a6cWhc9DXo98=;
 b=lKRLXbZA4EXPTbR49YKww45LLFBRDPC2f7Bb3zA/L4JuXYdqHsZIbXVsof+aUetz3sOmVJqo+iq+9jxRAsaLlIFGs6mJ0Yo8w5cpEmhDWD3LzJA7ePOkvQp12mUSSEamTrRMhFgCCk0jP4TYukuJxydkLCQyutVcFIpxJorHPqU=
Received: from OSZPR01MB8123.jpnprd01.prod.outlook.com (2603:1096:604:165::7)
 by TY5PR01MB18623.jpnprd01.prod.outlook.com (2603:1096:405:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 17:46:50 +0000
Received: from OSZPR01MB8123.jpnprd01.prod.outlook.com
 ([fe80::f2ff:7635:979f:c31a]) by OSZPR01MB8123.jpnprd01.prod.outlook.com
 ([fe80::f2ff:7635:979f:c31a%6]) with mapi id 15.21.0428.009; Tue, 15 Sep 2026
 17:46:44 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>, Pavel Machek
	<pavel@nabladev.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] 7.2.6-rc1, 5.15.221-rc1 testing fails
Thread-Topic: [cip-dev] 7.2.6-rc1, 5.15.221-rc1 testing fails
Thread-Index: AQHdRRczE16GrDmZ/0qNuQ4l29Tee7bPqEywgABBpHA=
Date: Tue, 15 Sep 2026 17:46:44 +0000
Message-ID: 
 <OSZPR01MB8123B71013F99EC5C0009206B7BA2@OSZPR01MB8123.jpnprd01.prod.outlook.com>
References: <aqlJxhduleYsXGO1@duo.ucw.cz>
 <18D5876AF3E5020F.582625@lists.cip-project.org>
In-Reply-To: <18D5876AF3E5020F.582625@lists.cip-project.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8123:EE_|TY5PR01MB18623:EE_
x-ms-office365-filtering-correlation-id: 5b41afc3-5125-48b3-bc42-08df13514e9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|11063799006|6133799003|56012099006|10067099003|18002099003|22082099003|13003099007|38070700021;
x-microsoft-antispam-message-info: 
 1Krxnf1LJVGF7laRiiX3RXmhdx4e8sJXDRmcNWtZngDpIgajWPZBpmBbMG6/3Fr6lBQRkFJHHx8AOhW9HKFZ8AC2aEcizEKlKS7wkyXbPB8jb65EkxtKGFfkM9AGSNAubifk++jY//j+7/Axp9HrwEv7DDxDbTSKlYlX+3Vt/pxJbpCWfLbjG8xXrl6fU3Cn2Q3xhEgOgZWMm2hrr2om0XPdxQlT5IUeUhrILaTgMpix6YJDeH+5cLO/a1QQCwDVNFob5/cyWj/WYinv91LMK/UaYAWRat5WgHsuEJhpCjEH1x4eAtQ57eDKcHbnap/3l1R4gh4HPeka1J22vIm0xSIyElWAZsfd52RaDHwLaXagHYLgIy+mpH7myvPAFW9cfMFQeSlqkL1NSdCYmT6QuXIdADeGal0X2pCGUTWqXr1UD+L/Q9Em16qgT6CZQxUa5Cltvis95NlWv0Kjw0LisvsWsSH11OiykFFPYxRjcHMeGCwwEcuULER8UQtBtI7Eqtu5q9/lVVY3oQy8BqjYmx543LUYO9qqXT1GnBN91vpg6Yv+JYuNrx4V0CwDgBe8eQKFs2g9kRKD99ixq021SG3mw0372HRXTiy+CPPllPEdtmsFDi/MgJ4i7eStkAorgBCAOlMroqDBYDHJNfbOVBEjAheTzluc9TksjWbvV7Y=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8123.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003)(13003099007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?dbnjiNxQqqnIeEftUvOPPY5UfPFgclkWPWF3LPwAOd3oydWJIj5qyYPQ?=
 =?Windows-1252?Q?CmyLRPWAja2QBac6wr70yTppfRPlHqa3M6LMOioLS/PqI7NQ2HWqsbS/?=
 =?Windows-1252?Q?l0gnwKgFTIXJ4cyMpo5W3rtRcHvBOwV06mL3OWHajH0hP6REGKhSPKpD?=
 =?Windows-1252?Q?Dw4FYgYcuvsTaDMtnySAFIddZdFl6mxScaYhu6wirpcOiPuuK5/Gio2I?=
 =?Windows-1252?Q?aguInVSp+dFsjBs3IDjLdRCW7b2Xl2ALPOVxoyOtb7Tvv7EUaJpiOceP?=
 =?Windows-1252?Q?sQnwM62tzCZLeXvSB4RtCwJK5N7Mu378FMZdbZUoGsP8EL1Rcb5zDBdb?=
 =?Windows-1252?Q?/kxXi4ZFabDazvV1o7jOXqAbg7t2iv2rinjsdJAm+1DXDY5P3wPmgTDg?=
 =?Windows-1252?Q?AXp4YxzVDwNK7TVNKpOdf/EeeZG9w5Jg3d6vw1GovJhY5kh1xAmN2M6z?=
 =?Windows-1252?Q?3CTCzfMq5/gYxCbu6REyGSLY3TAXp9iUioKxzPAYsJHFefGjKQBetCET?=
 =?Windows-1252?Q?ZE9btK/4cs/HB8BzbeT4i33g/d2JbU/7hNznubQI3Lbq+faW+vtsOb8O?=
 =?Windows-1252?Q?i8Cv61tS6gk9lFrMVUQyCVLwR5Ix6mUxozmRvlnz4mTZw2JUwh29tMCh?=
 =?Windows-1252?Q?xLTB5haOFs46A9NzYTU/H58Saoluob1gDPLX01fQaVXlHdHFxyioyRlI?=
 =?Windows-1252?Q?bnD8J7zEko85i9WrYIl2y6akepMaw0OE8Zs/XwO2YutJ6C5rAassnphI?=
 =?Windows-1252?Q?GnNgPFCZJJS1M3K5JoeEQ7pHxCWfTTr9JBwp/tIV1EyO3cQB9rVDHOVB?=
 =?Windows-1252?Q?HSyzT37mXVNJp8ls0cY65jv51Rb7e+kppfDpmXZA65YhFr8s//tLp23p?=
 =?Windows-1252?Q?kJPIJTXzdtFRtNh2yU6iM3ER0JhEuMHhtwZCP5inof9AxxLl37Ip+J/z?=
 =?Windows-1252?Q?EOy2CjULFWs6T/OPd5muPFC2em85hEUSd1PpwFfXE0gW0AyzA1cfJLQM?=
 =?Windows-1252?Q?TOtOPNuXh8Ol+fYXJDoiSC2Z7+ZKaWmmQAowTqBXGBPe98sXUxL/epuj?=
 =?Windows-1252?Q?/KG5ucTZmw6maziJCEP87pWId8sB2MJDu0YHyrzVQA07Z0jRwpu1896e?=
 =?Windows-1252?Q?jimfPPwSZzfR9uhba0t0Pwf9VHG5BzZy2gDr/yMXEzzXquZvWleGAVST?=
 =?Windows-1252?Q?qYdfLtecxRFqFZtEmPqoIPoutobdjoYh7kHO0B8NgyzzeGaYUinHVzk/?=
 =?Windows-1252?Q?cdS189N9meWQm6e6E05O2NLpkL4YhiZsPDt7ttUbRDS0fDFSKwCajo6P?=
 =?Windows-1252?Q?nNwt/hUTVQZ6FHgge3Qy+vDzaQFl4fFdDb3tPNwZRagjol9n+iI1kk4l?=
 =?Windows-1252?Q?noxcPuUscPnhuepaMxd5CbW5FMw0jayQ7bYLsRr4n9mwjpykrRPVd+g9?=
 =?Windows-1252?Q?obkKz/GSiNgWiDcOQpzjx3fWQP0/GNnU7KeuAk3Bd04b/YKJkQNG2hts?=
 =?Windows-1252?Q?ACSW48cbSyxVA5xG+Nf80dzsBon+8kPE96KtSPOIiQaW1OVN76Z2KVLh?=
 =?Windows-1252?Q?eLeHZRVFJqYTnUEjM1ux+AMbn0lHbNcm1wSanp1UXGNcus6QemgmbLut?=
 =?Windows-1252?Q?gkhCQ8WaiFiRKdzgZyqoR8QTMD+Pi2ZTE9woc+xVfQCrdU1zPhe0Cuhj?=
 =?Windows-1252?Q?RiDLyijHz7Yeeaxvl2T58Cexb5Ps8ENF8VU5tB+EsWnqRBr/UaNKyv45?=
 =?Windows-1252?Q?3tRDn9PzwcXWRfUdoHtnTs9PmZZvI5WqPY8bHizc8HmjEH8qXnSPNPC/?=
 =?Windows-1252?Q?HlzTQlO9lPyapuOrla/VBONRbTvHKiQX0iaYE+I9GX/SRiaSdkAKSlN4?=
 =?Windows-1252?Q?18lzROZ17SSMMGybdU8Zz0aPA4BBnu0D7ts=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8123.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b41afc3-5125-48b3-bc42-08df13514e9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 17:46:44.1951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IiMyVY5MZOIn2ktdmxMfjOVvYgvhDviYstqnpoDnLiWhm/QQzrgwXhXOa5N2kmW6oQwPihazLk+ATHiqRlyVkxfzvJVznQ/zGO20lnCkdhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB18623
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Sep 2026 17:47:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24192

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 15 September 2026 16:15
>=20
> Hello Pavel,
>=20
> > From: Pavel Machek <pavel@nabladev.com>
> > Sent: 15 September 2026 14:36
> >
> > Hi!
> >
> > I'm seeing testing failures:
> >
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> > /pipelines/2842909542
>=20
> The history of the failing test job can be viewed here:
> https://lava.ciplatform.org/scheduler/alljobs?search=3Dlinux-
> 5.15.y_cip_qemu_defconfig_5.15
>=20
> All tests after 5.15.221-rc1_270d4b1b8 have failed.
> (The pass at the top was me resubmitting the latest pass - 5.15.221-
> rc1_deded5764)
>=20
> So, to me it hints at a kernel issue, introduced in once of the 5.15.221-
> rc1 force-pushes.
> Hard to track the exact changes as it looks like rc1 got force-pushed
> three times.

That said, the timing is very close to the qemu version upgrade in the labs=
, so could be related...

Chris

>=20
>=20
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> > /pipelines/2842913623
>=20
> The arm qemu jobs all seem to be failing since the qemu upgrade on the
> lava workers, e.g.
> https://lava.ciplatform.org/scheduler/job/1508639#L146
> qemu-system-arm: unsupported machine type: "virt-2.11"
>=20
> I'll work to fix this.
>=20
>=20
> The r8a774a1-hihope-rzg2m tests are failing because Linux v7.2 dropped
> built-in support for the Ethernet driver that the SoC needs, so it can't
> mount the NFS anymore.
> I've now dropped this test configuration.
>=20
> Kind regards, Chris
>=20
> >
> > I suspect it is gitlab problem (and not kernel problem), but those
> > usually clear with retries and this one does not. Could someone take a
> > look?
> >
> > Best regards,
> > 									Pavel

