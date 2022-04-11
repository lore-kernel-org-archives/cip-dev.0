Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FAEC3527E
	for <webhook@archiver.kernel.org>; Tue, 12 Apr 2022 16:46:38 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.91])
 by mx.groups.io with SMTP id smtpd.web08.668.1649700255096660621
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Apr 2022 11:04:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=b38ATJLM;
 spf=pass (domain: renesas.com, ip: 40.107.114.91,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3N1Wr+suF6D97pvfu1owjzoa/zzvgTiXFDK6o4t//tLTSATznLFvUvyr4XF8tnxfTaT2UXMDJHYtXyrQMlvnDax+iw9IXkCbWA+v4LdIfum2bOyOAkkyFG4APFnEs44jeDoC9ic8p2y960rxnZ9NTJb6AD6QYlLHcEM7RAewHr0+afr5ZmvzM2/4MGpWnYSCojEVCBjV7z87u7IcVHwD0n6M1+BJqOc8uRNE16dt6q5hTSwcY5k1ghxWdPjLo8Oor9urM2wsxzLGGEuNPOPFMkvOTLdH0CNhcux6RgKQDdFqcF5SwYWnDcplYPvFitI+OOta1Fc+Air6OrMJy/FFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDh9/nhsxD14mpLjV5E4Brh8eoScKxsMh56dhq6LT58=;
 b=WsILnAQllaJ0b9sBFPQNRe4mvk5FBnR8XmBJpYkd4mu9Wjed8Pgf03lpFG1pQzLK1MYijRxd2KVnk34hJ1iA5vu1WPUFfTRESJYy0EX4iwE2gSotp1C8drMO/lsY1QmGS9idipKLD/FMsICbesv7VBHbI7jcUZJrKqhCrDlkknoQ0YtzYR876esomjPuv22jvY3y/gID78bzzMONAE0DhFAtix0VmRayucLkrXYwJ5zcLBH2di+9m5mFJJLpUCiTnTIOsQQk6uCuYa/+UdiBebAf8xzH/90hZgL8dtE6f9gINEZuvIhbYCt6Gf+dN0oq+E6TNU/IMI5kQUiMQ2qLwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDh9/nhsxD14mpLjV5E4Brh8eoScKxsMh56dhq6LT58=;
 b=b38ATJLMTfjXPAsjoKVFvLOKe+yxmNQKv4E9eAYMxmoCoJ5BgRjKCfpaONfO5Kz83tJYhbJZ10snHaFuoma8tQXx0cA/GXSe2dHM4ZN2SC6+nLMGPLVi6v75Nlz9x4g3lbDxzhnQ6KINSva9fvrV9281jODO6idNrJXFU76UPPA=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:130::9)
 by TYAPR01MB5436.jpnprd01.prod.outlook.com (2603:1096:404:8031::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 18:04:11 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::f9cb:d1c1:fe92:1d1c]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::f9cb:d1c1:fe92:1d1c%4]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 18:04:11 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "Adler, Michael (CT RDA IOT SES-DE)"
	<michael.adler@siemens.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
Subject: RE: cip runner offline?
Thread-Topic: cip runner offline?
Thread-Index: AQHYTc4H4eQETULaK0KYwIW0pFuCPazrAPmA
Date: Mon, 11 Apr 2022 18:04:11 +0000
Message-ID: 
 <OSZPR01MB687760863E6FD8E921C9B80CB7EA9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <29265285-2084-12a6-4cb9-1b7a31d14a47@siemens.com>
In-Reply-To: <29265285-2084-12a6-4cb9-1b7a31d14a47@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e13336d9-0e12-458a-b85f-08da1be5ae6b
x-ms-traffictypediagnostic: TYAPR01MB5436:EE_
x-microsoft-antispam-prvs: 
 <TYAPR01MB5436611A36AE7A50BFD6A1C8B7EA9@TYAPR01MB5436.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 fHL9SHhzzRoCzL+w4AtrLpfqr8rmJx9OUzEV5rcJ1q5nn70s0z80Wsh+i8JDGTIN0KC+3Mg6+iPZRsVv7QQqpZwRdCetw9LX9xu8+FLz1gjzXJnimwWuYzOrATGg/Y1gdyndVCabV0Rb0wilEZLjFAB//35/OlmCykTLOS8aKNP+JNbXIL1mtrqVjpO7D8mcmMlLNGty1LzbX82J5omLgeOldefRpJPM/6VRwkKyP/YNqdO9G8yZ5hnPYPunajwf93unZVyax6rVW+B21GCf2ItaAQaGIFdhGnKdeHwB9B5xZR94R4Bmf9dMyoREhHp3dGjFK7B4VrL1gu6dX+i9So9buuZlIc1LNhWSJDG89rzUYn4JNpT8enyFc6612qmGu/9UM8xrCLOUm3f/t7kIkoEBWxP+bl2QROrm94UzNV/PM7VV3z2atI9/0GqEpjQdKVHEbUBdLK9pmKl3idOs3BVYnSGpLlZlNxWuYbHUuA19ZxYVkrE5ts238WlnZ1hXng/pI3f+/tjdL62v/QlyXu2AJWHA1i32Gsd+/4BaGlw1UiVPw2eGB2ir2wWwQxOUEejMqWXlKGqGUXCdjqbFBdNkZtU+LTP4Gd1BPHihAC3QjqoDshrGixsC5c6FUTm+Fz6KcP2I3h1kueDJgQoVu1TykEgrZ29kNaj4ShmKo5kBZBWA2nwAYot0mD1vR42xcVxlcff/MPlj816vsSvKsm5jOYeLllk09Ya8WJkuHsKAw1jJ1++3pf8mOMWl8r8k8+wiRHNhGz/AktlR93Q9tBVYKBdmPfO5zwMoR/OxFFs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(45080400002)(83380400001)(55016003)(38070700005)(122000001)(38100700002)(3480700007)(316002)(6506007)(7696005)(9686003)(71200400001)(186003)(26005)(110136005)(966005)(52536014)(5660300002)(508600001)(8936002)(7116003)(2906002)(4744005)(66476007)(66556008)(86362001)(64756008)(4326008)(8676002)(76116006)(66946007)(33656002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?GbXoaoGi78u3335GS3+QfQg4o6bIT979yjtV/pD2tPa8yLPpg5jxIqtY?=
 =?Windows-1252?Q?zEqfCyBe219LUBwdjttzpBR8O+R1q1DVUMduM8Sz2qYQ7CbSNgxWznXc?=
 =?Windows-1252?Q?OhgcI7mzfod2sb5ntSC5LMfJUBxc7rGR9YDf4EnLXlEgfTJgIq/2KGLl?=
 =?Windows-1252?Q?md5uxTO8GJwdfetfIkHDtLOEcEJiGE7CODZf2Xm5vadoXL+lugIDjvDy?=
 =?Windows-1252?Q?+ArdUp1A4sy+FayimASMWG0n8m4O8bL7IXmROMv7oDumqoSR5vr6ObdQ?=
 =?Windows-1252?Q?aNVSRDWacoy+/JqSdcaZQnForUSpTYpjOn6YYe2GMSG+XLV4AVlWvhcI?=
 =?Windows-1252?Q?gvstx5aIPpdyDK40P8tRhU1NyfvJy73J8SMjKjcfaZhiN45W/3Tu15+4?=
 =?Windows-1252?Q?rvlqVXPzmCiVidI2XEs6IUm1mw/s9g63jRyHhNWwZdNT3G5oar0IS+9P?=
 =?Windows-1252?Q?jfL7XvmgR+3oM/iLDYvnJdLsJfTTXkPgzjewuugqbl9g3IBph6F+SN+s?=
 =?Windows-1252?Q?kFtbTsl5Mv7A7CCTKXDw+7ef+5FpLiCEZ3Uo+ZNk/8vsoPpL0Z+ljYmm?=
 =?Windows-1252?Q?UARGUiahtCN4/lhrSDnsSEj7VqTOms+KpAHmI79qlYwO/aFk0T/fqyjl?=
 =?Windows-1252?Q?KbfWKC7iuOEKAPc3BcyyvWals2q8mt2tx0uBZyYa4RZoqRKS8po6zCRQ?=
 =?Windows-1252?Q?K89q30Vm2Gn0lZAOK9QqOmTV+nGNICkHVefH7xF6jvjsPAlihclXVBgv?=
 =?Windows-1252?Q?iXJDhPjiGjmxPcWEsmFHkebagA0x3Obfjq5+5rUeqb/y3P3Tc0xT3yxR?=
 =?Windows-1252?Q?yyiWz03R/DDeC0SikHEQO5hotJLIPTvhLUltVrNNTLmWn530B9SYl2lR?=
 =?Windows-1252?Q?wxFq5oPO18zMrDRU+7X6fjjwjnK8Kygc8jsX9ESJVGrGFAQi8Qc2QHFa?=
 =?Windows-1252?Q?6pHkfZuV+AnGs5z/cgk98KxkdsNZxUlgVlokSwowDS5MTWiQeGcegGYT?=
 =?Windows-1252?Q?m4bCuA/5uCOTFu/xMoQKV/EY12ysR0UzfwgD3yxsc28aE/VRbgfwYKD7?=
 =?Windows-1252?Q?C2/h2PL4GXKVZKZD2x7q/8CHpC0xWDwpY2FSlgmTNxVE0EW+7crQl6vI?=
 =?Windows-1252?Q?DNbweZQLRyIeKD6th2+8+khXif4tsRZjCJidGaC/iORM6ehPXhSZyfMK?=
 =?Windows-1252?Q?Gh2e7fNsNobiwKVfAw0qT9Jav2wojRYTu1YZaU9LoxWaOy/JhdXhH+Wp?=
 =?Windows-1252?Q?BRaGrJaABQexFgjrmAXTEcr207IXEjONVukNWNNdihY6K3Owzpy74Aaz?=
 =?Windows-1252?Q?GtgjPz47RhrEajlbSjGzlLQa0GXkN6Hyh9Mb1AfN0IzpMVlRI/1HDdol?=
 =?Windows-1252?Q?S0H4wy9/Waa02d2Mpn+p7i1tjYg0v8BKR2Gypz5cmARRvVxgIri/CTTO?=
 =?Windows-1252?Q?jznLa1//16+OFrPEU5aamwL5+J6lXerodiRzGW7zX5H1QcWbcfU4M0J3?=
 =?Windows-1252?Q?2Cohd5uE79HslK72IDYtkYOotMW5DzBLTSJdmjN1sYYMWgYvViFBU4hy?=
 =?Windows-1252?Q?fESqZAEdVdJ8xyPjMW7JlMBXcyCTd1nhTTKpdJlfD+DS4ruEOYjFqBu/?=
 =?Windows-1252?Q?PV5xGppiNdNk4p0ylob6GcQe3r49wVdmWEpNiOmGkzS0tDjaJzPNcL3d?=
 =?Windows-1252?Q?Wp8Yy5B154hHHiXqiWzUViamYfr+REIxbuLkywHLYPs9O57aukvAdZYQ?=
 =?Windows-1252?Q?bh6oNibAXR+itst7gWr6skfyQSWRIcv+deIH0zagD+zKyHz8R1c9ODD4?=
 =?Windows-1252?Q?YrqQelmdID++CmLl5NrUEykj+aa7NhuzG7ggr1sbiGotPm2CFhG22+oT?=
 =?Windows-1252?Q?njOtcZnONFblXSm1AZG1DJmIjXShEzXCXY4=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e13336d9-0e12-458a-b85f-08da1be5ae6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 18:04:11.3477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 bAgtRwMHLEMYRpZbD5o1Xj4b3zXIjF3YMJdE6RvK+Yzly4o9ymjAqJytfhadc6fiAklgiFQELyyJ9MQCKzCvSb3O42xLaqu58Kn1V4YMnq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5436
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Apr 2022 16:46:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8029

Hello Jan,

> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: 11 April 2022 19:00
>=20
> Hi all,
>=20
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fgroups%2Fcip-project%2F-
> %2Frunners%2F12564521&amp;data=3D04%7C01%7CChris.Paterson2%40renes
> as.com%7C70144a163c384b25cda608da1be52901%7C53d82571da1947e49cb4
> 625a166a4a2a%7C0%7C0%7C637852968294620917%7CUnknown%7CTWFpbG
> Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C3000&amp;sdata=3Dh9ly7L3ROKy8AmavVS%2FqczZkna1TGoU%2B
> WkF7gHqc3SI%3D&amp;reserved=3D0
>=20
> Any planned maintenance I missed?

Not planned, but user (me) error when trying to get the LAVA master back on=
line this morning.
Michael is already working to bring the runner back online.

I meant to email the ML but forgot, apologies for the inconvenience.
Hopefully we'll be up and running again tomorrow.

Chris

>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Competence Center Embedded Linux

