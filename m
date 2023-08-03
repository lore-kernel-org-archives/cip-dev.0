Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62D8EB64DD
	for <webhook@archiver.kernel.org>; Thu,  3 Aug 2023 13:39:08 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.102])
 by mx.groups.io with SMTP id smtpd.web10.14890.1691069943173379667
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Aug 2023 06:39:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Y84atBh0;
 spf=pass (domain: renesas.com, ip: 40.107.114.102, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAwKNyX0PtAKsBYExuhvb21sLHoq9LMVDwu16YXUddmki6IBELzLnvS6BmbvWUR/+ShVi6xs3s4SOgZ3nKOsxDpk4kTANWR/M42brcIUIAlFWpqGQMVH/kppdfQ2R2VNd5FUd7ewS4RX/JELbD0oPOaBM/O67ybtPbQ0mHu6HQfRsYPhg+WFuc1EzRe7uO9QFcMv+yHOPgssD9eSLJ+RfShI3Yiq2PSeNdg8e2NyLXtjuCyZBKEXb2XdyvXLULhbC6h0ZP+Ht4HCZVBlAE+Qj+V1sqoeNJl2E+KwNo2Spw13YBG8fA/DmB1Mv712bcYU7Q0iT21Z5YJGKBlrMyWYlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAJummJKq5h0PharYwIyw+wIKuccgt923WjH9AkGnHw=;
 b=a7v9hcZTiekuweMwJW1UIaYWiEffVoMCvuKpjFefvtDZqT/lPUoqxgjkSnTLX/KmaKVA8QluEaFEdld2gpM9Fy34yOaTtIzVngt7FxeHE2o+yU9MMN7FVFDydzRwFV+F2u6YQJEyDxNk+5etQblfYHWNDi+gco/7o/CX36h4pXnSXhV26qT0bzB5PNjvaQcCD8gNwjXI2rdT42zdKSw/XtMI+sXAV7j7QcHHFESE5nfORdP8Mns1eJwm4OHURacVOaPuohsXXT52SQAP0wKOTPBp3cUIvMmRCHuKLEPn1lMX2+Fblggk00ofBO9lCVYQ7HPn1LXrkIBp7m3BfLotPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAJummJKq5h0PharYwIyw+wIKuccgt923WjH9AkGnHw=;
 b=Y84atBh0X2H50nTsET8NIE4qUD9msr3nW/8FnOneMqWmKmwOqWpAajQDJqTmA1V1su+2EbU+VKP7gxnekwVeu1Q6fBam9kLzFmibJ6nkFSASF8UN2Ra3YO5EemsvFFs/fHSj2LfNyHwHxRykRoAl7uW/qDeXXoAamIzj+OhHYkI=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS3PR01MB9496.jpnprd01.prod.outlook.com (2603:1096:604:1cb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 13:38:46 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 13:38:46 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Michael Adler <michael.adler@siemens.com>
CC: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] stable-rc-ci tests failing
Thread-Topic: [cip-dev] stable-rc-ci tests failing
Thread-Index: 
 AQHZxR9ONsUbi57YE06aGQY191NQb6/Wtr8ggAAJXbCAABYEgIAAF5jwgAGjPACAAAJr8A==
Date: Thu, 3 Aug 2023 13:38:46 +0000
Message-ID: 
 <TY2PR01MB37883202516D8EC3512F1FBFB708A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <ZMoaWmwWiLQz+vNU@duo.ucw.cz>
 <17778648DB0D91E2.2497@lists.cip-project.org>
 <TY2PR01MB37881707081B7D70710B10BAB70BA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
 <20230802125753.4d2e6225@backstein>
 <TY2PR01MB3788D79592068F488400767EB70BA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
 <x6gtttscicyj2tuy4jbrdjk7s4c5idx52gjmf2ussf7bey4kcm@rqhxeuxkfk4j>
In-Reply-To: <x6gtttscicyj2tuy4jbrdjk7s4c5idx52gjmf2ussf7bey4kcm@rqhxeuxkfk4j>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS3PR01MB9496:EE_
x-ms-office365-filtering-correlation-id: deca9de7-f2c5-4675-5af5-08db9426f641
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 taLYx/UvlxuW+FtKtDiNwHi7f0zergUbM8tJRc/mWmVdmzL/w4Ial38I2YzQcgz1Sy6w3P42sbhpvIEqtH+3C48yeOJq5GzAvBbxYbRfkh8a+CVuyixfTCPKl/taglQ9+XWTMnVgvHZWrTaiUdNCOVpRVPze3w3He0ImPHm5tNc91q265YcYa5tXAbV3AY8mVqIe3MubEZBvRp8B/1CJ7GQvC2uoBvghXZ6TfORnZWlYkLIBtQwgapZJ1jdlRAEkAkYbHpK9aws+i6jlxfHCLd8RwSd1LMt+ZQQmiOgezuGzfa10BNLZuZwy5tNMgXR6Gt6t1XndI8x9i0Hda45ZnZTtJWrPdckXXGm2y9DZkN45yhuv3YdqDTN0McOE2GhnjyLXOqFhnxc49oLyMTkDO2tsoRoLv5luv5b3DZ16qbsnYnabu+7j6TEuX/66LJMNmlfsgfUr8643oJvmUF9RHqUGQ0JEDvV1nWHXrtmqd2ew0FTiYAVqSMh9YZ0j3G+rpg9FO/W6irITB9mDzkHq68tH1pEjNjOpcY2+GdBYDzpkes3HAP9JeeBiA9CT4P1vHsk26mpIBLxeCOd4aOMZKlATC5+Xfunvms0rB7fdDa2P1y+AQp7HaNPyvAaPXU8a
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(41300700001)(8936002)(8676002)(83380400001)(6506007)(186003)(26005)(86362001)(122000001)(38100700002)(38070700005)(316002)(71200400001)(54906003)(478600001)(9686003)(7696005)(33656002)(55016003)(6916009)(4326008)(64756008)(66446008)(76116006)(66946007)(66556008)(66476007)(2906002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?QzjrvRuiuju3xeJJVNoas1vbT+Nmfwho4Atp0KIbo9+7pkDJWjHmPY2X?=
 =?Windows-1252?Q?LUeBkc8NeGGCpb9pYii6veT5zNs7wex6h4uGO4AsZD4IYRHo5EOY8oDV?=
 =?Windows-1252?Q?aOrgmFPEengeUrMZsHaV/l42161dlwLNNV0BFeRNbqbDmn+Y25HtMWHv?=
 =?Windows-1252?Q?QOI9u6CEM7dOZyUwKU6koV+ez5ltphe86+Yc16TDeGKA8/NEAqyFH4p4?=
 =?Windows-1252?Q?3JjbrosFW+iloH2Bxg6ypNk7no67+yb2x3TpFxI/3ALktbRxCsTA6S3X?=
 =?Windows-1252?Q?FouJsxSxRd5ntzzeVtLs02gqzch6fDV0m03Dp5FcIiCGIUpsrdA4yneH?=
 =?Windows-1252?Q?64qUUwKKJa4PrGof1bH88AS6zdISO+q7RSC0hprzXOwjJVvp5hFduZZN?=
 =?Windows-1252?Q?xc2qUkJucIG6Iadi5g/w0hZq7iHvIlWgfhj1X1yJOk82YaU6ystjI61V?=
 =?Windows-1252?Q?GzYuWfM8kl45jWxhdI+0mHY/UDYgC9YhuErwpJv9SeZG1UIrWXVZqEsg?=
 =?Windows-1252?Q?88FbIeFx62LvC0qA+KYQbHQ8iC41HRtkrp2Y9RPwrjV/UXJIdlzmkuq5?=
 =?Windows-1252?Q?L9V/AHJg/SpP0x0Fr1O4QDdpJyOb8NKGeoEGlplgC423rmI1IKGtr1K5?=
 =?Windows-1252?Q?DUJX3zzs8SODo0v/8mniFUwWEBTigBI9WdwrsDDS3E6y8cAWITg+Cdby?=
 =?Windows-1252?Q?d6Ypi4IXr8LoaOAYdBYJNqFdAKx5MpuBSeQshIqJP7iysgBO0zNNzR+S?=
 =?Windows-1252?Q?lZOdjKm/y3UZoq4o2cs293YaEznplyA/uF6vxzZ9ZdS7R8SgfKqTrDar?=
 =?Windows-1252?Q?/PZjex8s/GJzdKunK8ViyDtCi395+tnAdXm2tx+49xVS1Cy5Pe3C7Y7/?=
 =?Windows-1252?Q?Ls6nCByKP4sny5aEjYAIXF6WfSZ6wGoigf6rAqGBnVA/QtZ+qgNIQYPp?=
 =?Windows-1252?Q?V6rqbEasMitEVux9dqj7qfrWjE+SAvk/bFM7vCUcWRdhzvTP3M/Xx1BJ?=
 =?Windows-1252?Q?Mqj8j2no1J/7YX/smBB+xQsZLw13MqiFxAovq8smCiO2mFWULQ2/GXJw?=
 =?Windows-1252?Q?Oh0a9OF4xnB6Pxpt4gEaot+6QM3ymwdgFMl2xXOWijCcwmCQzusLAUZG?=
 =?Windows-1252?Q?W8I2BP2FlWZ9IIQBQLrRKTEBAJYhDynImmhfYTYkArrFljcFo0gRF1g1?=
 =?Windows-1252?Q?oQ4ZPTv5V0P+XhgKaiBjKyELzA4ZhJx0TrSnHeF4ipKmwOtEx/oIbpUh?=
 =?Windows-1252?Q?H+f4QVsJFWnpRlmQqEhJ+akZS4IBjXd6hQ/J7mKVbb8DiwjLMYgQndBi?=
 =?Windows-1252?Q?GzcAa1X26u7xgTTxX9SBLSSbuYG2Jl1tXKK324YK0uhcPj+Ar/nF6q4y?=
 =?Windows-1252?Q?/SHJRAKpFmzGJqA3A+sR3OGU8uTbEUmRyJ+8oxh4V9wDbaG6X1pevAnE?=
 =?Windows-1252?Q?FWJ5j0XGVPZZ41q3+Bb0Mg6GsMxRgB9yncWX26Em/m6xRFaP49cy4QCe?=
 =?Windows-1252?Q?E4afQCPMcxI5izPhS2ZVBr0aSvBE8j0Y9fCeE5YjRChbwIqu4zf4juvu?=
 =?Windows-1252?Q?HF6LSnIRXTXSSQNT1y8RHuYG5H75fyzIi20HV4JYVSDQyUJW4MgWfRsD?=
 =?Windows-1252?Q?YP+HwuCEYZ3cmSNizRvuv9TeucC2zvUoMrKzaqwYCJDQNuSLGjuXRRgu?=
 =?Windows-1252?Q?zoe00XOzAHE08e3sdh4QuFPgDCj9/298OuYQc/iAPUEvHU6BTxR4gw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deca9de7-f2c5-4675-5af5-08db9426f641
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 13:38:46.4129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0WE8Jnbq1VSED2NYMk8zNGW/rHglVVBhg5NjdwXUesBPKNT4jFlfORexQoothMTkObTHezTvzfa74v523ZxYXobwlku0zPiF/vRLoYl5ccI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9496
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Aug 2023 13:39:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12548

Hello Michael,

> From: Michael Adler <michael.adler@siemens.com>
> Sent: Thursday, August 3, 2023 2:23 PM
>=20
> Hi Chris,
>=20
> > Do we need to consider adding some sort of fallback support to
> > gitlab-cloud-ci so it'll try a different region if we get this kind of
> > failure?
>=20
> yes, I've just implemented this. The small cluster will now (hopefully) t=
ry to
> auto-scale across 3 different zones, thereby improving availability and
> robustness. Previously we had a max node count of 5, now it's 6 (3
> zones each having at most 2 nodes). Let's see how that works out in pract=
ice.

Thank you.

> In particular I'm curious if the auto-scaler will choose a different zone=
 if
> it sees that a zone has reached its max count.

Is there any relevant text we'll see in the GitLab CI job log to indicate w=
hich region is being used?
Or can this only be seen from AWS?

> If we don't face any issues with that new strategy, then I will upgrade t=
he
> large cluster at some point in the future as well.

Sounds like a plan.

Kind regards, Chris

>=20
> Kind Regards,
>   Michael
>=20
> --
> Michael Adler
>=20
> Siemens AG
> Technology
> Connectivity & Edge
> Smart Embedded Systems
> T CED SES-DE
> Otto-Hahn-Ring 6
> 81739 Munich, Germany
>=20
> Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim
> Hagemann
> Snabe; Managing Board: Roland Busch, Chairman, President and Chief
> Executive
> Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Thomas, Judith Wiese;
> Registered offices: Berlin and Munich, Germany; Commercial registries:
> Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE
> 23691322

