Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF29C001DF
	for <webhook@archiver.kernel.org>; Wed,  2 Aug 2023 09:17:17 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.114])
 by mx.groups.io with SMTP id smtpd.web10.10252.1690967831179800770
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Aug 2023 02:17:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Akz6Z4Si;
 spf=pass (domain: renesas.com, ip: 40.107.114.114, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfrGSQjpw0kWq6NshZnHrRh9040yMLKZjsxCt/DgOPR9miyceoOLth2nn2m7USj8Hp/EetMKCPeS923WLp2lEYBuv30X+wS+PIPdtEQ/n6LZtdhhwvijDZOKEfp6bz3PaluNwC5H/tNi142wBHCm0r/eNWjHkeCVnd4H0pzwpN0ORB5ukjkS1B4ABuMo3XLs3+rogZEGNJHPjimSMSa1kXsYUKWfmkyHztXzo7Yfb/lmKAlFATqGbJ43zkG2sJc9q7eSunmmlnFgiau2cK5TTfBTv5J7mlMNyGGfIjkQMJOXcjmxR//u96+jZBELng1eKeunnHMZiioIMW3Ykcn37Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9UwEDsqqGExFfSSef3SJu7tM0W9DkQtmdL82b2qe6c=;
 b=TuFcdFR4XRi4ESS9r5hAOPfa4jP1hQou9nUu3kFjRegZogHsH65GEnLti1MM0U1te3hOaa6H9U12pqSPeUaYApO3bwwB58wu8IOEga62TLxy+areNWO4Msn+VhHPGeng/x4vFeZN98/HEO7vlzUBDn0o9W5HPdrzkbMVMQhS6RgjnodGBtZBkD1dvN0m1P+CjPdnG/HdCeevLOuoNk9Xdz3llp/xe680fSZK4o66iiXrSOG+6mx6IiWoHQPtxCplZys/h1r2MfPEMJaHuP/yo6O/yIsPSfOTLwreuFkgzwHlnTFymJ45z4p3uiORwU45wyzoBnLusIvGED/iyxwpoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9UwEDsqqGExFfSSef3SJu7tM0W9DkQtmdL82b2qe6c=;
 b=Akz6Z4SifPBorkVyDJHvkGySlYezFLiZIUFwVq29pEcZK//SLpdqVdAN98Wchzybb2UrG7OjzFS0/sIeCwN4hx/pgIQKJr5DXghQPl0jzMJZTM7RW7SN5Q6xXpxh62n+FefS3V+4yUxVYexr9uX7qfWD645yBG5jWocibHhLn9g=
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com (2603:1096:604:43::11)
 by TYWPR01MB11029.jpnprd01.prod.outlook.com (2603:1096:400:392::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 09:17:07 +0000
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::38f2:53e5:4f23:e7f9]) by OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::38f2:53e5:4f23:e7f9%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 09:17:07 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: stable-rc-ci tests failing
Thread-Topic: stable-rc-ci tests failing
Thread-Index: AQHZxR9ONsUbi57YE06aGQY191NQb6/Wtr8g
Date: Wed, 2 Aug 2023 09:17:07 +0000
Message-ID: 
 <OSBPR01MB3783ECDBB125E900E248F7CBB70BA@OSBPR01MB3783.jpnprd01.prod.outlook.com>
References: <ZMoaWmwWiLQz+vNU@duo.ucw.cz>
In-Reply-To: <ZMoaWmwWiLQz+vNU@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB3783:EE_|TYWPR01MB11029:EE_
x-ms-office365-filtering-correlation-id: a970518a-8077-4587-5b74-08db93393e4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 jooQ4odUu+URwHkvDkMQdEuPSOEMrzZTpOFAw5kF5CFKZY91zfYWS0isQmTJuakfwsk/ZsC0E5m8Nyu1LNuRuJ82l0pu+4kOtiq3poayiqlsIBCR9SMBrqpwNRzOVN15+BCflzAMSwXVYamJGaSkFvPFo4eomEIMcVy6aq5XygBeHyFYwGYde9vPyxo4QsaLxXdWCbLx2+pTSfncnpA7FRwWHPtQU3YBd8IyVGOlUS5Ss5FXWzYKRTXOpdwN3mwToiGRiA5jpf5+2Bw+x4VuPzXksVI57nJkZzuF79V4KVBQSr/JVkgCsUPYBWvr6UI0vyxSj2lNb8bnRm7yxGKblYtVCLSO2cqTcrJ3Bv/AvOZZkFhJDUbuIBTY1R08yegTsEjPBOiZTkq9xc/71TxcXfF6W8Tn/FQdANaC7WdDN1DordstADCCP4W5h1amAYVCMSIzAQz+VHS8uJqa1P4fC+ZIJEqHIo7u6aKAGfL9EoWosH6SzZ8WQ3oGwRNHt3hl8Rr2BLl+1ugJqwECxrKLh6WxTHqe8zdC8GL0su67h4+2Xoey8sPqBHkpL13PTZ5tJzZFIwEtq7qlCpU//TSx8dg0NUWlhoeR61xPCjPLyaM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB3783.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8676002)(4744005)(8936002)(5660300002)(52536014)(26005)(41300700001)(2906002)(38070700005)(3480700007)(83380400001)(186003)(55016003)(122000001)(478600001)(110136005)(38100700002)(316002)(86362001)(6506007)(33656002)(7696005)(64756008)(71200400001)(66946007)(76116006)(66556008)(66446008)(66476007)(9686003)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?sAtvQRSG+nkWydkv85GIjWPbqBIelHsrnStIfxR0h84j0HnyPw8hgcKa?=
 =?Windows-1252?Q?pEvqeEILrEDTrkh638DWvO6kCCFXYzvIxeJyIBCVY6gNxgwAepOdZ8dF?=
 =?Windows-1252?Q?bb/A/WpaQEHXLfz/r8JR1Js2JnlikL9tQEg7rkNrp878bYWDDR+5Y0nz?=
 =?Windows-1252?Q?9CPepf3IINggkZZQMDtGnsYP5ypBbUGOd6jM818otlB93tpkvfZYIU7p?=
 =?Windows-1252?Q?+fKB83ydAyxuxHaf0QoxuCG+pvNBmQUHEvDtzFlf5U57O/LttwNRXW0U?=
 =?Windows-1252?Q?nG2uTiOvxoZCutujbkpfswiNtl8GrJpaK2ATZJ0DbRRYCi2kE/PxjVNV?=
 =?Windows-1252?Q?uDW2f/lfTK0mhaSVwURz55tKaJEtd3vnuvD7yxYvySAvkWUngRfii/qx?=
 =?Windows-1252?Q?xiqZo/K8xWDeVjySysTa19YVWhIl+IuiWCobbr7vKCG3BbX79jwiOtCu?=
 =?Windows-1252?Q?qEgQIApZtS1N+DeodYqED3Gh9+Dj/jsVBpkIVzAq+8kGxgqn2lq4RhU8?=
 =?Windows-1252?Q?kda+vVzOizjbU6ZZ2SCGYLSwFuioHaGCVR9LdTLyzCY0nohZOsonv10B?=
 =?Windows-1252?Q?u5/9dzSAklRbnMSj8qpToTuFx4zzAS+qC6MHyouwlU4h6OxbyKyso48g?=
 =?Windows-1252?Q?gfYQOrdf/eJ1SG2862Z6DWJnRApKXfggk38glExRiGnqMXztKPSfJKmv?=
 =?Windows-1252?Q?y6Jnb77OMzJYDS5CmTQeQBgMsT8GwxF+GwUOACcXdPkQ4l9fyVMmUb30?=
 =?Windows-1252?Q?FGEZst7K6u1PQLyqi6vYzLUyGgtdmNozv4hhKUGNAZ980417i273JLcy?=
 =?Windows-1252?Q?hTjNQwCiyQMPrPMcJYKbMjvjd5DyC6XMDRLaWXt45h41mmgsTrpP4khr?=
 =?Windows-1252?Q?aJ0hoJ333/AqdSkyk9GCNAqkrQYXfiKAAtzzj3o6ELGd6IJUwaWMIO6z?=
 =?Windows-1252?Q?mKkaLV54yroIz5pLLBFFDbIj1ZYNCYLPh+qBP1mioPzs7SGwcyv9H66/?=
 =?Windows-1252?Q?Jd6e9dZ1nlCWa8v7puT9BzrOKrs1icZzDq+h9QLdBd/IPBrUhLp6BBUN?=
 =?Windows-1252?Q?bRKlU9g3Yutlni2qhUOnGpnC3KoeNtnoUkbfS1eKU9+ynOERd3GroOfr?=
 =?Windows-1252?Q?y8BorluAu3fS1lMCyl6O9W5O6KdKvoQbHw+fNkKT1vECMNmysbFTuYgG?=
 =?Windows-1252?Q?E9zXpHQilTDF1KZU/NX9u05iGSQLCFbF4wjZqh89U0uC6r2K2s7M5UMa?=
 =?Windows-1252?Q?HlPDaoiFO4otP8Ut1p6P1yRwASbhBMEeonW0P1GqaAkYsTVVa2wo89SH?=
 =?Windows-1252?Q?3z08U11xxJyiR43fYi/NhRjHEvvDH8GynatF1V4c5h/6uiXGGVcA/jjP?=
 =?Windows-1252?Q?yxNLdA2YUElXPDhqxQdHGc0NgfzNOVE+wIXeUg3iuFHO5xKdAgUdwHzM?=
 =?Windows-1252?Q?sCejUE5/M/dtfJJ0Y8ULbJRYtFD7ZyJUdELUKgqwgoJ1hg+6/ewg8dwe?=
 =?Windows-1252?Q?DniYlHvUII0xw/2hvwSgkjiNki3e2ZLIdF+UaHovclJcNo8dctrxIj6X?=
 =?Windows-1252?Q?T1aapaUT9Tu8+H7TDo+dELFMn/tCfs8jBjyYGXscadfPQqSog/BiwRgm?=
 =?Windows-1252?Q?WERnms7jrvo/2H/KbbH1N+L9HZWhyF04UiF6u8Io+NQOKhtz35zF68qH?=
 =?Windows-1252?Q?ARy3wmkeOkz5frIRK/08ncLhlcjXEzCvt3NRN9eJJ729GRUnrO3DIQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB3783.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a970518a-8077-4587-5b74-08db93393e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 09:17:07.0408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vvZmOPUicfeAonItb6voFmSqB/RW6fI1sZX1TXjgC97IlnZ+algLNZ12aGgP9Ud0yhRF2tYPF0KCuqL05nTa6Mgm50mozHRhuoY8+Ox4At4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11029
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Aug 2023 09:17:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12533

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, August 2, 2023 9:57 AM
>=20
> Hi!
>=20
> There seems to be something wrong with testing at the moment:

Thank you for reporting.

The build container tag we're using got deleted by an automatic cleanup too=
l. (Same issue as last week).
I've modified the regex being used, so hopefully this won't happen again.

>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-
> /pipelines/952990993

I've kicked this pipeline off again and it looks to be working again now.

Kind regards, Chris


>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

