Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE534C6FD1F
	for <webhook@archiver.kernel.org>; Fri, 10 Mar 2023 11:10:08 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.135])
 by mx.groups.io with SMTP id smtpd.web11.16604.1678446605401272201
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Mar 2023 03:10:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=hzh56mGr;
 spf=pass (domain: renesas.com, ip: 40.107.113.135, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ae5pQOHTJWGXuLedOJL+tNSDlptf0JTSo78UYGdO630o1dWwpZQdOpG60rHDrHDQC/OVdEOIEKHXa2XYolNmMZlv+309iEFSNybXdotWvNoSOelcBK9JbKMAqDSPgMYYrM5r49viIbRp4kKE3FveXDva0EUcLYJglB/omkGZGhNP0niJtBVJLWSQOCuar841aRCgGW4CYEsG57NsAkONQK68TJ9oXfL03nU+zt++aYSuN/S1x8rAFJkbuAiyue4qtTVSkkqdhdMoWVfwuPGXGogaBPVv4PGHT8GHp7V1+hWPbCs+TFoDr0NBLCB50K9Qc3iU6g+P+iVS4KzBtxKh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmOowI0Cd1ywHHr7Q0eDYH8ITcq/x/R0wPyB5JZBxPQ=;
 b=gjt++5qKoKaeH8uv7jQS7sNTDACw7fEWmEsGA3qE1SCoxV/Ql/ITzad0ijVxaRapUjvkad9px//7M35/gdX1961tT59dUHapEllSNSZ98kWDf+bnOPGxo3JHPN2KUWiQNuQ5Vx1v5dE2b5C0uc4P8eQU5E96bzclnIe4gZw72vL46Fq/+ACB7z2RZkqi2crskv3U5zq+qLfrgo/fCnyM4s1qmuvWCM3R+b7arQpqwmwjeZco3TAfjcFkAaX3mwzsDQG77BkX6xZm8B4xXYzKmloLLO733G3C2tUkZpJE+2YMqAunX+c32v2GKdVFadhwjPYTH+o1KKAdCd36GrPwnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmOowI0Cd1ywHHr7Q0eDYH8ITcq/x/R0wPyB5JZBxPQ=;
 b=hzh56mGrE/FsmTl0L7RCZKhAcY0joVD300635c9FUCDrJv6XGaJyVXgiX122AnLD0uOumN3C9lhjr5tQ3JWfiOviPJlM/4DOuO9uybO3m7q6ldi0n3eIm7BlVIIIG1wqIvUrXSPC9JFxWG7ktapINJvTlyYbOmjmGZNgmQMl+vQ=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by TY3PR01MB11790.jpnprd01.prod.outlook.com (2603:1096:400:404::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 11:10:02 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::dc49:e307:b424:4a53]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::dc49:e307:b424:4a53%4]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 11:10:01 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "jan.kiszka@siemens.com"
	<jan.kiszka@siemens.com>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>, Ulrich Hecht <uli@fpond.eu>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"alice.ferrazzi@cybertrust.co.jp" <alice.ferrazzi@cybertrust.co.jp>
Subject: RE: [cip-dev] Tests of 6.1-stable and others
Thread-Topic: [cip-dev] Tests of 6.1-stable and others
Thread-Index: AQHZUTsFntlHQmiumkOidsV6NvPLwa7xl75AgAJGd+A=
Date: Fri, 10 Mar 2023 11:10:01 +0000
Message-ID: 
 <TYCPR01MB10588CDB3D5B84D7778F88366B7BA9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <ZAerOFASj+Fgqe1o@duo.ucw.cz>
 <174A98C707158FE6.24021@lists.cip-project.org>
In-Reply-To: <174A98C707158FE6.24021@lists.cip-project.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|TY3PR01MB11790:EE_
x-ms-office365-filtering-correlation-id: 281833ab-1829-472c-c41a-08db2157fe87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 AOFgR+lItqXZy+xlBhztpHs5hQZ8ukYRSiqbBnm4u7zG0Uc6ttJEHl9M2sRX/ZmKK6ooreJDn4a4SfcSQLx9SZP4cq0mPIrPFC03AEreq/mEWRMkgCenmIQ6grKndrC9hCQ43AfszbNemvwKilCX4zoNaCWc0dPueYufAmca/ipoH4ZVyrm/7cwGJC12UPtAhRh87n8SCMywMNoOvMme5BM8oyMTywb4q0MPKPIv1g1sht7iqbNWI80WBt8DKRPTtebZS/fKnhZmEWsq6Jpu7t1oWbHefbdDIkTZNdJTDWUKhUE8Z1BmU4jwHWvb56dPzpD7btuQ7Nf2KeG/TVKB6z7HiR061aq1KpYAJXkmeUAH3czpR3TgvWTkiykqy+VXBcQpo6+pmXq0pUchYJ2SZwpgjXbAeDorYPjUbt+lw8jdKXvHdHEJJjmdKPL9G0WhRaRZSFHYDMUizALy3pMjV3D7CpTmMpjsCP5osC4Xy/u0AKeOoVjGmudBqQFrg9fPfJ/NlcsFx02uIHH5JUMX5X2TyOyXAG0rlkC1Q3XlWXvAEzz0nmphztT6Y2ghEpsiS091BDbXr410dE6/VHb2wrPuMh1Ongq9FpZQmaXbqHWMvlAs/i6YeSlhPYpPbeyeBIaNE0a62H5FPadRYmTKi5ANrqdNy8DLFl+l4u2dY21qeyKxWzIKNvXzOzJtlcRtGToe/Re2gdI6FwuATyG755Tssbta0Grq4j/k4PgxCyo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199018)(8936002)(52536014)(5660300002)(26005)(6506007)(9686003)(38100700002)(122000001)(83380400001)(186003)(86362001)(55016003)(316002)(54906003)(8676002)(66476007)(4326008)(66946007)(41300700001)(66446008)(76116006)(64756008)(66556008)(110136005)(33656002)(966005)(45080400002)(7696005)(71200400001)(478600001)(38070700005)(66899018)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?6K9nkL4XoJvK8SdBV+SVgjsYf0s+HhZXhPbgvcn8a/g1bSZzWM/CUoi4?=
 =?Windows-1252?Q?jWw6UgqcBLAqyo1wzWxbW3RN+8BsCd2YPax/Agaz5kuPz2/6GGB+M5MX?=
 =?Windows-1252?Q?jN9ogbFnn4J/BR6VPa8D1FnfFArGkPcFh/emRK2U6m7VhWDchpTE/YvT?=
 =?Windows-1252?Q?TCTe+/0jo1y9o8WBAQ2wPia//WRLtQPyxWgIt3kBbxchfF//yjUeyJPx?=
 =?Windows-1252?Q?Bc/GD87ZQirkxXsYJfXLFVO5WnCUNzRJ5CuArWbPNU6CtQq4b2dHM1MF?=
 =?Windows-1252?Q?y3AgLmodK2huw0/MZf3Q1QI9gQT4lSRBVOXj+/2hdXaw5mlePG5UUyg8?=
 =?Windows-1252?Q?UjzxPPhgiO6Jh8w5y+NPY7JkdlnbCsYbYYSPdl2pClhY6zGc1BQ/6jnd?=
 =?Windows-1252?Q?1ln3zGteNkDzfLpEtaL61pYKnDiURf85V1VJJITvdSTKn77ry152AbEr?=
 =?Windows-1252?Q?cvg2FV4DYwID6VrNEadpNk41U2KhZZ/gdiKJLt7Ehqqod8aGSMg5S0QN?=
 =?Windows-1252?Q?IsJ1sdy+2cG6N5gEEQ5EKi/i7lCNLP6CBiNKtIE6PRxPBOWnwzsskjXM?=
 =?Windows-1252?Q?MGswyEtmYLPN4eO5E0OAuuN5thHEnRuJ4FLV/CRoineBOmhPjb+rYEap?=
 =?Windows-1252?Q?CH7LFEvEb/sj8iM6GcLgjj5BJ/NfSMe9tgAkBbQEqLXtk3Mi6W3Jg6j8?=
 =?Windows-1252?Q?/EQsVd+QM2fyuCxIb9fHVut6y0RwUwe4LvP4SY/LGAwIGVvpSsOsV+GJ?=
 =?Windows-1252?Q?kIdFBoStgIxbenwIN7u0SDoqmmRR758QhxQ6XdwNfgLZJZ285jCPXEw/?=
 =?Windows-1252?Q?54qn6bpgN8tuxpSHcTVBAh+UaidO3H/G9ZK2bktBYEWaKRik4CSz7FNk?=
 =?Windows-1252?Q?ZoDWRL1WYL4h3I1upO+nr4R42LEP80SPVZ9Xtcam2q2E0YQN8X9AXxJR?=
 =?Windows-1252?Q?5tWY7wTi4UxWhHhVN8LkdmXWr+TfD+NYXryBrr0c8OLZKcv5RfaB94Zo?=
 =?Windows-1252?Q?uDMpFD+qQRb7+uY67ohmG49g3Xeu24gnYAEKFMT1KqCiJy133AUzewAg?=
 =?Windows-1252?Q?zmTseVjpzpnh3yE33xss4MZg0SD4mOUQ/xDkS+1Ir4RynWGm69HYruDq?=
 =?Windows-1252?Q?jmPMtx7uZPbOQFfIxDVYMSjlFedEhpA5SWJVAClvT/sDWhL/ea5iAsXP?=
 =?Windows-1252?Q?lZoUst06pmUC4cy9obwCtIfZe/Cy9e+jotugnKlHRV6bOer+fPqe1ZyU?=
 =?Windows-1252?Q?m/0dYIYxCrG2C/nSt8mba1dKrpUE/mdaLBVAUYCWZC7hDRIz6eWm7jra?=
 =?Windows-1252?Q?Xu3YP8e9LgyuMoFdTudUF4s+w7GHrjtaFMA/uLIlnUla47mp4DRqr6bF?=
 =?Windows-1252?Q?U67V2KJplmb8xew9WpLQ2CyegkCjgSlsvzOCdIIeb7pcEllXksxdylt8?=
 =?Windows-1252?Q?ILKwtDeytP+A7fDXJJBUln5kyfIiw8I6/2w2ZPja76P0VMR0wAQkMN9v?=
 =?Windows-1252?Q?tIKS3jvXoNicePrd7Uu8zLbrluzYR3MiZQhdU8RiQibWQjstdIv9hhR7?=
 =?Windows-1252?Q?M3lpuQlRBxTjdHkzkwfz9XHPQHxalCgO10xm7QZi96Wq8FLdwtwYaqWP?=
 =?Windows-1252?Q?RtEfx39JI/tSx3kW32v1OvyHT3FGRDz7WlFulmJ1PRZDS2aPPOppugaU?=
 =?Windows-1252?Q?q72sBvHT51Ai1Amef9LXo9ACNXMO6kaBUZBfQs81MUKOe7ZoAm6GJA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281833ab-1829-472c-c41a-08db2157fe87
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 11:10:01.8926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2siDHUBpSBuRz+5fXp+GG78lm0FyoekJMwfuCT1MwFEscUP28Mz7d8COcMf5ou+2TRfSGU1g1SLuRqX6vxboAYesURlhYQCDIFIVxFjips=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11790
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Mar 2023 11:10:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10973

Hello kernel team,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 09 March 2023 00:30
>=20
> Hello Pavel,
>=20
> > From: Pavel Machek <pavel@denx.de>
> > Sent: 07 March 2023 21:23
> >
> > Hi!
> >
> > 6.1.16-rc1 review was announced, and I guess this would be great time t=
o
> > announce that we are now testing it.
> >
> > I see tree at:
> >
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-kernel%2Flinux-cip%2F-
> &data=3D05%7C01%7Cchris.paterson2%40renesas.com%7C46e6166cbae948ba
> bfe208db203569ff%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C63
> 8139186004876256%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
> &sdata=3DpteLIHqxGffWyIjkCrBdhPChoMNqd8a2Pw0RrOFZpsY%3D&reserved
> =3D0
> > /commits/ci/patersonc/linux-6.1.y
> >
> > ...but that one is does not contain recent commits from 6.1.16-rc1.
>=20
> Nope; it was just a dev branch using whatever version of 6.1 was around a
> week or so ago.
>=20
> >
> > I see it updates from linux-cip. I believe it should update from
> > stable@kernel.org.
> >
> > Ideally, I'd like to see same setup we have at
> >
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-testing%2Flinux-stable-rc-ci%2F-
> %2Ftree%2Flinux-
> &data=3D05%7C01%7Cchris.paterson2%40renesas.com%7C46e6166cbae948ba
> bfe208db203569ff%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C63
> 8139186004876256%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
> &sdata=3DXm%2FLmFoOAcMGQQia7kDJSE4WhTgB4BtD0%2BDQyEnuL24%3D&
> reserved=3D0
> > 5.10.y
>=20
> This was the original plan. I was just using linux-cip for testing.
>=20
> I've now added everything needed to run all the testing in the linux-stab=
le-
> rc-ci repository.
> You can see all the latest pipelines for each branch here:
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-testing%2Flinux-stable-rc-ci%2F-
> %2Fpipelines%3Fscope%3Dbranches%26page%3D1&data=3D05%7C01%7Cchris.
> paterson2%40renesas.com%7C46e6166cbae948babfe208db203569ff%7C53d
> 82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638139186004876256%7CUn
> known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6
> Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DbHf0G5VFdL50j3G
> uxkyE7YJp8STsFjmtQ8pV98%2BeUdE%3D&reserved=3D0
>=20
> As part of this work I've also improved the way the version gets
> logged/added to a commit.
> So now it's easier to work out which version of stable-rc is being built.
> e.g.
> old approach: Upstream SHA: a1a87af47a80
> new approach: Linux 5.10.173-rc1 (a1a87af47a80)
>=20
> At the moment it's using dev branches for the linux-cip-ci, linux-cip-pip=
elines
> and cip-kernel-config repos.
> I'll create MRs for these tomorrow, as I'd like some reviews on these to =
check
> that the correct compiler is being used, and the correct kernel configs a=
re
> being used etc.

These MRs are now up.
I'd appreciate it if the below MRs can be reviewed before they are merged:
https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_request=
s/74
https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/merge_requ=
ests/36

Thanks in advance!

Kind regards, Chris

>=20
> Kind regards, Chris
>=20
> >
> > ... (And prefferably do it at the same address).
> >
> > Thanks and best regards,
> > 								Pavel
> > --
> > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

