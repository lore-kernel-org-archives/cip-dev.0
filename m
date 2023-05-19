Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0484DC77B75
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 07:11:17 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.105])
 by mx.groups.io with SMTP id smtpd.web10.20240.1684480272978391179
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 May 2023 00:11:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=O8Ik+d1k;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.105, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBhBsHkfDf/1+RLGJOqa4SlolxEocPHFgndDdi7w0/7adyZbtJ8Ccn0OlpKfjVJvO1Iqvc/w7eOCMMBnqePvrgAm2lpQXwGeB3Fh+BKlTwdEhypPQd+/go9Ze9MI5VHoNtjvUJlMc2M9BOy3YT09ZYigH9XZkM3PQ25qXgZniDNcTu2BW3h3Y9zjaqTIGZqASNN6kjklJP2tq7ZnQCMJtJtNTrG/J637MdBoOVqMyz7B9zUebE3r/SjBmHq2FY3zTMCPlwmwn4feATW7u6g4Z1eTKhQeqeR/49ZlnO5G4pCOwe5MO8c2upe549sANWl+pDeoYhuCAKTA0USAYu2JUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IejUUTz2LA8Mustd4i9F7x5QkiGfz8dAF2osBXRS49E=;
 b=OtT5FZ5emONtR4wkmJOb0jCrE76PcJ24RYkqZzGhA60kMXM/HB1KDDSoAML7pzyXAfhp0ww1JO9NtQ0xFGyAbXXrpmVyXIbJjZmNOlOzF+CJ6QL1pmnWWLa26KLGo6lOjl83RuKuwxnHAoKhzpKCq5a5/7KDBrI198No1udEiTUgyS/OkFEAk1o+sKmq3lLxkkLoNEvk6c/3F2zaCW1PzXfmydt4DdQnPyUQnNhXpej/UUxJHCK1miVZHgvVlU/tlDT75t40Bo5XaX3O//AdO8yC+Jpm6JvJT2N2kNH++Lco01EoNOh0z+6cwFemww1qigcP1bjOOxxSSiQyKcHJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IejUUTz2LA8Mustd4i9F7x5QkiGfz8dAF2osBXRS49E=;
 b=O8Ik+d1kQykTxEZY2WKB18XVtVeLVkmwsueFYHF+Y0F5zeSe29A2cxQAwVZt3aLfM10SqAmxuSnI/JN4w5S66Gx1u2rMwpPx9uByI65Vagkss6KIah7uAlSuQ0u00ZQxP+xAZcYLA0SlAPTVEcPVRAVplp2V28HucsPItzfmKYw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10321.jpnprd01.prod.outlook.com (2603:1096:400:1e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 07:11:08 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 07:11:08 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Backporting MTU3a counter driver to linux-5.10.y-cip
Thread-Topic: [cip-dev] Backporting MTU3a counter driver to linux-5.10.y-cip
Thread-Index: AdmG/WaLeUipv7+wQD+BoBNa122sUwABuRRwALMJJQAAFAohAA==
Date: Fri, 19 May 2023 07:11:08 +0000
Message-ID: 
 <OS0PR01MB59227670A61E6EBAB81A1D33867C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: 
 <OS0PR01MB5922AA46B8F8C695943085FB86789@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922D244175CCCF76490BFB086789@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZGaZvnCWMW+cOXl1@duo.ucw.cz>
In-Reply-To: <ZGaZvnCWMW+cOXl1@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10321:EE_
x-ms-office365-filtering-correlation-id: c427633d-ec6f-4eee-0341-08db5838380d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Up35dFPk8M7DkgAY97J+P9xwVwaobRNY7Y0EbCHq2HgUwErj4/vGs55BNqbG9pcc4Z5bXwe56CnjH6vu25jEl2yaGu55Ge2++7IGDuzMAgfTPXjz4O/ZdChYfaq6iqtnA9YI3XEF0d5DMQfZcxBh4PtTbqA07Fg4v/pHbgQInppntS207+tPabe/dWdFlj778zlE09sKEzZeH8JB2oO9099OXpZqmF8IehMSYfhxrimLWzPw6bOEtP4yx5gQq8Y9/5tqaw4DqKlPzmf/emZp+0fHASNILTm06pwvwXbZQ6d0jBaArpLyQ5JWH++iVluVaLLRFgDzQf8bC0csrReX64KhHFF7mSP9E3t026J2MLrFrY8X03t3tfFKvP1/3VNSyl7fOXqLXQnaH1cptCPxqtYE2nKvUZrf+wZjOcwX6cTxR1nnX7xHAthrHc9Ad1c+qdfZ8OBHbV8ICK4Nr44SJrDOXI0yHPHnuUpBK7o9EivvWloXkX3Ttv/8guQnQpgnXiCki3PuYH8XGc6cHxqa0ASV8WdJhS/kK+AebJkwbysqKdmKRqlNzlJjVpRQtFArpuhgjmIBpkofCUzK7fN8xvNS5BYKdNJgwaEPQ4Ss7W5bXkWYFoa0LG9oyc+XWPMdEzXLi9IHFAk2CCPEKC4GWg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199021)(6916009)(66446008)(66946007)(66476007)(478600001)(66556008)(76116006)(64756008)(7696005)(316002)(33656002)(83380400001)(26005)(6506007)(9686003)(71200400001)(186003)(41300700001)(5660300002)(8676002)(52536014)(8936002)(2906002)(55016003)(38070700005)(122000001)(38100700002)(86362001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?+746deDxjQzdk+9zRAxRRUdudEvmFCUDFgJ3OzHkAKpGAQf7ddx4kxUDv0aj?=
 =?us-ascii?Q?PG1ppTA6fF0XIKJCNbbswyD2FQVituvZWrQvqY6/Wr3UAwX1D41RWLmC3sxm?=
 =?us-ascii?Q?WaApJlHyxNm+Op+2irfgp/JBDpUVqe3/uE0Q8X3CPaxGHkQ6T8B1l6VjNczk?=
 =?us-ascii?Q?UdspZAvh9xU9vdHCogdHSgP3Rf3S6oqa9F0MyripuA+RobcWLHkHlXCKTtjU?=
 =?us-ascii?Q?St9inDYzXBrVkOR1jwDR9ntnsessgd6R3GuDwULFtlv7nq2ErQtDFYQ3CsNn?=
 =?us-ascii?Q?Gzo2XONnEFm4plQvR6VjwNbKkjMWx2TiY94KIrZHvcwTZJziAmJArxhXoNC7?=
 =?us-ascii?Q?QkyheVLbbnz2LBpoQ/AYRmkFfEORKshffNYbAcmjYBn1UGhzGey9EDMDqise?=
 =?us-ascii?Q?lKyWrZQH1PTw+w0wIQ6FRZISfYg4gHF90lhh0TKIC/USRXJbZ5qUITdvsnMY?=
 =?us-ascii?Q?K/pMFfYK+L5ZdDX6X3Y5RhkNnJ3hfw5y8CQAZNGaCcMGYj9g3HZAgdaobhzJ?=
 =?us-ascii?Q?bXdXv9WN4+PJFbq1lt88lkADm3g+ysS8U7VWc+2MnqTAU1tC1zJaq6m3DPx7?=
 =?us-ascii?Q?kuC/b4reZ6PekJK3jL033rbAzr4hRprDllLDQYuxwVRKbFyuOR/0xAAYEAtT?=
 =?us-ascii?Q?x2TMZv5FcXQ9Ff0ysD2kI8ttCJHdGtBuwgl7znB6ihkUEOYbrwkmsW6VAegC?=
 =?us-ascii?Q?s4dToEXWcnoRTwn1N7A4uCBykcN49qUnlpIrSJeyjcGzxKZ0craIvefvoLRg?=
 =?us-ascii?Q?3MyhnNJ7DwwtSSeeh/3Zd2ZhRCOb+RMpF3gfh/Z0SpFQIm1g5pzbi9uss98Q?=
 =?us-ascii?Q?/GsZ6biMQ0eDVoziKySEZRoMFuTyqNBLe8i0HHbVbDGHhyf+EEpv71ZMRcZ0?=
 =?us-ascii?Q?XpjVcD7TJ0IHEv44Pl69SyhlR5nP9WaDQ2yAgdBEQ8QlZS1XGw38aoLV5+j0?=
 =?us-ascii?Q?eBn7OuPylPVU5tw1g98RSM98JkpdCVHO2nc1OdkUGw8EIhHU3+rDQjKnf0h5?=
 =?us-ascii?Q?EYSYtiEMQ4kQHsgAEv7mfhZ/iXwkLLHOTEne3uLJWRbyzA5hBJ/Ied94nM8h?=
 =?us-ascii?Q?jXpzHC0o0T7ix5JpUoo70CHlqlgs4p/U4aGpgrnhOtj7ONohIthak6C0VvZW?=
 =?us-ascii?Q?OksBqROA7xypWZFA5jiLWcl/6MuzGm4J30xMNN/uHJGdOjo0grAbK0ng3w5I?=
 =?us-ascii?Q?7514dQJsMKoaYKN3qLOYo12+Hi9joUMrZdB9pfUcF1dnhE3iyMJ+t3wBxB5S?=
 =?us-ascii?Q?yfIsZ224MMo2GJ/OYrtuyZyFQsxwDm/RDjacn0e6r1WG3Hfy+cQ5bhIFEK0q?=
 =?us-ascii?Q?pKEvcS16pSczvMZnwjUPlp5CYPPO+b0I1AdoV4T32YSsCZrNB180zi40VOWn?=
 =?us-ascii?Q?dqg/2Id+5/F/O4x0En7ZmYLzYtptP8RX50UHIu+utVSoM1iLoFRRbUxLpouj?=
 =?us-ascii?Q?liABJOUGhOTXyCR9+cP+Y1ovptln8OzWsgJRmOiebjl7FCWAC+QO1Amsj1li?=
 =?us-ascii?Q?pLJsgtqSG/DI8WOEHandwheu5TTAYlsCdH2LVJblDXjMAr1bOAsSPaTokZBM?=
 =?us-ascii?Q?AQlHhz7nkoMcgWHVZfVDFxn5EE/cE8bYq4ooHveu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c427633d-ec6f-4eee-0341-08db5838380d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 07:11:08.4568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJQcVl0DMihNsMSSb/WbqHoLaLH1Hsxot8kDunHviQiuuezZ9sZnn8PCs2R6kJSZ3qFFc5d5LcVUAP6K7BaEZhtceE1/Y+YkjPM/xYmGPiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10321
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 07:11:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11531

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [cip-dev] Backporting MTU3a counter driver to linux-5.10.y-
> cip
>=20
> Hi!
>=20
> > > Hi All,
> > >
> > > RZ/G2L MTU3a counter driver support is added to 6.4 mainline kernel
> [1].
> > >
> > > Counter framework restructure happened from 5.15 along with that all
> > > vendor specific driver code is also updated[2] and [3]
> > >
> > > Other than that lot of sysfs entries added after 5.10 see [4]
> > >
> > > Q1) Do you have any suggestion how to support counter driver in
> > > 5.10.y- cip?
>=20
> Fun... Let me take a look. It would have been good to bring it up on the
> IRC meeting, but I forgot.
>=20
> > MTU3a Counter driver based on IIO framework is available in BSP[1].
> >
> > Is it acceptable to add MTU3a Counter driver support using IIO
> > framework for 5.10.y cip kernel?
>=20
> So AFAICT there are three possibilities:
>=20
> 1) Say we can't / don't want to merge the counter driver to 5.10-cip as
> it is too intrusive. Would it be enough for you/your users to have in
> 6.1-cip?

Yes, We have a plan to backport this driver to 6.1-cip.

>=20
> 2) Update counter subsystem in 5.10-cip with patches from 5.15, then
> merge the driver from 6.4.
>=20
> 3) Merge iio driver from rz-5.10-cip22 as is.
>=20
> Are there other people using counter subsystem in 5.10-cip?=20

Yes, other vendors are using counter subsystem.

If so, 2)
> may interfere with their usage.=20

Yes, it will interfere their usage as SYSFS entries going to change.

3) is a bit sad, as it presents non-
> mainline interface to userland, and the userland code will need to be
> updated. Plus 3) also violates our rules, as it is not mainline
> backport.

So basically 2 and 3 ruled out. The only option left out is 1??

Cheers,
Biju

