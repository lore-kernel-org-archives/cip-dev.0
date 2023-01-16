Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CCDC46467
	for <webhook@archiver.kernel.org>; Mon, 16 Jan 2023 10:46:37 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.115])
 by mx.groups.io with SMTP id smtpd.web10.163639.1673865988475765395
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jan 2023 02:46:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=bUuiH+od;
 spf=pass (domain: renesas.com, ip: 40.107.113.115, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxR5VM+KfXd/aJKghoFcSlQvpYrwl0riB+Jj1Mt7McbborttTvHNtpH08oMwnRDs52CL1DjcgQB/imAzUjppk0OGa+4bEHvfZpJfduMzJi8juGYCTxx4KrbGelsvL3iBjQT7L8Y9N9ZOANgJDEfRXeP2Ljhl4Cd+uedE5JmE6C3OOCoQKVr2rX7uXQeOKcAKgDZYWQeFsDGEYFiygcSidq9JGLZoQxPwn/ZFVGXPaZis4axUstosYZbFwErLcLmuKhPP1QDqPWoJWn4b9uG1I1bDkkQRhXKW8GMQ3C+vA+zw5ZPkFRSQ5ywFL8dvUNsYoBVgXiU0aNuZLql7IA6NUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbDu8wHwyxE3ARiF50xcnVmmUlw5DaZ4R0+CFtwEztk=;
 b=b+iE93heB0V7N0e4ZEzO29RMSlelRY/wHICtw2feH+jyVKGwBe5HPYKjycBhb0Iqzigko772g9of4eSvSyKqXdGVJvIqMI9L/Ql25JeRBDKtj9YcJFSkO9PRx0wu4z3iOHrLWXFD8vmiUNGnnPQ/Et6SLP9BxfV+1XK1VtZaDExwwye2EUVJzeGqj64fJsq8bOEcRJ0KlPVX9pnkNe1CasHGvKfI5+jX+DZ1hBTAluM5Nz9NH/uoQfaXyuDz1OOdQdcoe3/ATxSP58qCNCCRSI6ABRLG5TXlcKrO3o97foAnlKLXmyp4cJ4HVH3gv87mQHEipDS1d2d2/5quTkX9XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbDu8wHwyxE3ARiF50xcnVmmUlw5DaZ4R0+CFtwEztk=;
 b=bUuiH+odc2QOUBQUZ4NwxikN4WoRgyojXq6hKOVA7Z25lPw4xoKomGFZ7oi2CPk74XKMGSirBYFf+S5lJQNjY/ns2JFj4fsvXTZCWNmN0+6i1yqmS0uBSqR2fbAr9qCWwWYo7f9doszZhI9X64D3eg2aii4XnyC49BvQRcky5fY=
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com (2603:1096:400:309::8)
 by TYCPR01MB8278.jpnprd01.prod.outlook.com (2603:1096:400:15a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 10:46:24 +0000
Received: from TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::943b:564b:b02d:f78b]) by TYCPR01MB10588.jpnprd01.prod.outlook.com
 ([fe80::943b:564b:b02d:f78b%7]) with mapi id 15.20.5986.019; Mon, 16 Jan 2023
 10:46:24 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] 6.1 LTS
Thread-Topic: [cip-dev] 6.1 LTS
Thread-Index: AQHZKAKmIR1C9DY8uUGBbViY/USWrq6fs3EAgAEqk1A=
Date: Mon, 16 Jan 2023 10:46:24 +0000
Message-ID: 
 <TYCPR01MB105886142D52E992A8E3AC6A6B7C19@TYCPR01MB10588.jpnprd01.prod.outlook.com>
References: <c4648640-e690-5afb-85fc-85bb81889737@siemens.com>
 <Y8QvRNxsp0N3Sa2D@duo.ucw.cz>
In-Reply-To: <Y8QvRNxsp0N3Sa2D@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10588:EE_|TYCPR01MB8278:EE_
x-ms-office365-filtering-correlation-id: c738b658-d68b-4805-273f-08daf7aee9e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 375o7PuUXVhU0Zgt/0Pb0HaZ9ckDHnxT5MvoIPBZcz6tYXW3S8amWo4VOjTP6pifSFl+a0iKApc8G/UC+rPaWQGyWahXa+61FF6dIrVa8RzuCKA2a2oD7F+NcvzgMzr6H2iugnCWrfELnwjb54S74sbCj/LDXOURly64b3mo36bHDbxe6CuxHlBegGggjai6sLTfNTIyK5PXhIASJb7o5sPv+J4xllR0AsdPZW4QPs0mhYbxarhCt+xafeEIaM+YkjLHgMLDp8YPr9L1RvYlWsydF+e1zTuUOPQLDUoQNe7XSJ/O4cOIpCB2RZMvXW78B3hAMYpwYdScbWeHAYTKr7xMXlWkstcE6DjguiDnQRp/0CD288FLzLG+GlAcU1idBD9jBX9n1T3Cx69Yv3rCEcYIiKvqqPN5WoIV8CEEPHEWWHJF9Kqz2Xs5Yu04lrwJo9fKX2KxGwsVUNbTgRIBRAHHVPyYp1kDK49OvLs846m+HpCs/48Au/2Uwp0qv5y1PlVYhRM2UhGFayTZb9cuo7Z72A8wPXe1GWsEVq1igRS9+eQavikHMXhPFKLEy3Cs4k7uGCCDBH013dlRX8BjKO5VTQgqG1xNuSEtdkkG5mpm9yPeiLTOsS/b9Be73hHCKLNfpq6CNrEDFD6UtqkGBUDsKm28xIyx5pqB3kVrxCmBiHqRWAZDx2P38H1yZIFTZzebvmU0F55O2cjoE4aUttH/zUIoXl6P+c7rxVqjdkg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199015)(38070700005)(86362001)(8936002)(6916009)(8676002)(52536014)(66446008)(76116006)(66946007)(66556008)(64756008)(66476007)(2906002)(55016003)(5660300002)(38100700002)(122000001)(33656002)(478600001)(966005)(7696005)(71200400001)(316002)(45080400002)(41300700001)(9686003)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?r4NBj4kP7uO/DTw4BS+CyHdw83zaxXbwgLmpMkhiaz70OF4nQLdGOOa4?=
 =?Windows-1252?Q?j4IABUKfbP30yavmwGImWB3ohDH/XChhCpWMylOllpjS/L1T2bKx66Db?=
 =?Windows-1252?Q?sIafFgAg1cHAMyT//vqr1HnuBgVZjDU5Q9TtKkjuCU410/IMn2bWpHZQ?=
 =?Windows-1252?Q?SV93UXALp1MnqA/dJZrpAhIVtAZx+hbz1XIDHqC43YNb6aI+g+fhudqr?=
 =?Windows-1252?Q?omFfFf23nfX2QPSFal9VWkatdHzqtxYvFfh8r28589/8g1F9Yz/q4Zs5?=
 =?Windows-1252?Q?rvLSiwza0O6/J5YKiOI+9Rl3vPHMnlhu4iU+Ebf0ku6VaIMenAQF9zbt?=
 =?Windows-1252?Q?Vd8i5iKxfOT94nVbwfpQae/Pm6sdMFo1bn8cfhPsEJU8JYcpyYw6GZiD?=
 =?Windows-1252?Q?7ZtqEz3OAnUpo9lk9ByPP2AIiEzIAUTdUaTn/Rf9CbRTmKgzZJKa7w6F?=
 =?Windows-1252?Q?yELXPWpPz1/7pxhuI74ZoUnRHbcijKnpBa0ddLwOcQ0BnZPfjEEwSfGa?=
 =?Windows-1252?Q?0tMLipWhHsrCjqXRr2b/CefoNdFrywGE9Wamae3qIDqcvJi1XRkqOA3Z?=
 =?Windows-1252?Q?v28zij2RDuvaKuKeV06L76n4gz3PwGmxz2U3pxvTADCkHza8yUBO9qoW?=
 =?Windows-1252?Q?yb8CU95MmsoxNw0dPJSEOyHjjA+C2MFVG/hI+cdbGrGMFwJOcLwQT6af?=
 =?Windows-1252?Q?xHHTM/3Pz4xs/EoxRZUXheqOC/ZxbWpUVyJ5NLHoiylTSWp9x4d/yL5Z?=
 =?Windows-1252?Q?n2Ph0zA1cqg9CWjkBYx5Ta3nbw391UDi1G33C9oYhjLH6dSB26zqfPJD?=
 =?Windows-1252?Q?k76fqN0vdTXbO1KvZTFAx7soW3ArYZ8IrUcBNB6zNxZrNPtyO6hIcUbO?=
 =?Windows-1252?Q?JP9Mz5pvKdHXXVcyffTUlk1M3YaDkeqgZfUyPSvuE5+1FGPrMO0OW5Zj?=
 =?Windows-1252?Q?R4eyWLQwkbjVAMVZzzHwRBFDP5nYrPnnM+6exRnfGd2v+bwsUf3cnmhs?=
 =?Windows-1252?Q?z3JoozOiJ1JSJP7dvAA/xhY/KHwCsD0Q85xNErwh040mlUhfuDSWUPOA?=
 =?Windows-1252?Q?uNPJvqRsWXvAP/OJB1cH/xLOC6eb/IXOTYCsvK7NAwiZw1ZFTjiBw5wd?=
 =?Windows-1252?Q?B8astBKOEnX3tb8niB2r30EitSwqgdWyXiCVyr0ObXFCZGpfKDHQ5Eqx?=
 =?Windows-1252?Q?8VS/kaO4rTzsLctr5OxcEGd/sZ+Ew7BsGYeRspp/OkYAy3rKW0T9NIPC?=
 =?Windows-1252?Q?ATwpna7URRoRK5nL97PTGupAR5nr3sBz16owPy4denx9Yl9ukH0vNUm0?=
 =?Windows-1252?Q?RQ6WkBCvhGpQe7s9SvNEAuMZGKjcDKFfg1hTVdoEoffRzmjbANU3Ico8?=
 =?Windows-1252?Q?cfs87GrqY8knmF7MCGvN/4OjWNc88uVWjBQD9robtcvT4H/VlPyEZePV?=
 =?Windows-1252?Q?3GEyyIzqO4OgUJ3ZINBgAdU7zcRDdo0AfsBoRs57kvdsk4cBPXqfKQ8E?=
 =?Windows-1252?Q?dxoCNu6GM3+4WVic/DBKmfG25LhoVg/Ep90ixU7JjeETq/u+fSsw3QCU?=
 =?Windows-1252?Q?poW8R/zMSpJtJjSpuh4RLE3BBKvYMIbOMHOA6GpevSzD1O8WQIVLNcWw?=
 =?Windows-1252?Q?V4Pahmro2P1NgvCrwRrA3tIyCldbsL3eJzC1oZHa1FdPN5zskbzbyWRt?=
 =?Windows-1252?Q?PbNQSj3H7p6H8FobtrliJAgaoeVuSw3zlZzl9A1kXK+RjprlLfxCQg?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c738b658-d68b-4805-273f-08daf7aee9e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 10:46:24.6579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dE/lzqTQ5A+t494kl9vlMH5/cLqxaqtIBtsc5Ryqk2Nq7yf3rGRVUh5iD81gLO4h5zjvuZqVXzSCqt38Ptwn6TXy9/5cV1GYUXSCFnl24yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8278
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jan 2023 10:46:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10370

Hello,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: 15 January 2023 16:52
>=20
> Hi!
>=20
> > in case you didn't see this yet (thanks to Florian for pointing it out)=
:
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
k
> ernel.org%2Fall%2FY53BputYK%2B3djDME%40kroah.com%2F&data=3D05%7C0
> 1%7Cchris.paterson2%40renesas.com%7C3107d6089d4c46d7ad4408daf718e5
> bb%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638093983549460
> 193%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DMf2BG
> 64zLwKGm6Etz%2FdQGZjcrZEDOCVtB8brOGZ5h5U%3D&reserved=3D0
> >
> > How could we contribute to this as CIP?
>=20
> Well, I believe we should start testing 6.1.X.

Agreed.

>=20
> Greg does not (and can not) know how well 6.1.X works, and it is hard
> for him to call if it LTS if he's not confident with it, and that's a
> place where we can help.
>=20
> If we wanted to push it a bit more, at some point we may want to write
> "hey this seems to work okay for our uses, and we'd like to see it as
> LTS" or something like that.
>=20
> On a related note, 4.9.X was discontinued; I believe we should create
> configs for 4.14 and start testing that, to help with 4.4-st
> maintainance.

Is there a reason not to test the release candidates for all stable kernel =
versions?
(Currently we only test LTS)

Our CI will be fine with the extra workload.
It would just be a case of someone checking the results and feeding it back=
 to the stable mailing list.

Chris

>=20
> Best regards,
> 								Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

