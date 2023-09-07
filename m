Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3B3EE14D0
	for <webhook@archiver.kernel.org>; Thu,  7 Sep 2023 07:54:07 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.98])
 by mx.groups.io with SMTP id smtpd.web10.8043.1694073236523154176
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Sep 2023 00:53:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=G+OoLfKe;
 spf=pass (domain: renesas.com, ip: 40.107.113.98, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vo7wqZbLoz+iQddjatVWXY4oJv5NGq91Ci6vDwH5Jhi3MtdmImYtmJhEP5uGjzIjvdPC2Ojks/xg0ivSdBiFfIIwdSDzoHQNMgOFHRBW9tWe/NzLGU81+KCdgeDmfa7ztB4kGXk3yOPlu1slrcYX1Kkubt3qrBdrc6KSmshfaCiBWpBMLx93IyD3VFyvaCrLuK3OalP3LqzXlenjqTFrqUOXAWX+THxNXk3k0X23Q9LAOaPJRxG8amja3CuY9Y+DsjZv/9uOm+jtMq1xcyeuHLEW0Axpv9Kslpg03TOEuRYPlz/02ZbdHTngLh2VDsqKWlnfyMOqdqIGTqRYGI64Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+NwSi5CeAsuP/5AKS2jsydrNRs/CIZMVlJ3BMvOEGE=;
 b=g18qOvPgV3LMicCxiwDDMV/CabROtfOJ4Ld+T8+UU0qidIeJfbjdv+Dpx6GoNhTe+m/Cv+b4KawTa595anPllXBmtS9qh7p9t9hj7btH/2CchOZrAKpVMRpb+hNoErMCf6WpjoNPaRt52TOFcNrFW28sSceCUz7rdmyiksuT8GFLtZgl8ORZSpJhxRn36OEJiOBqlrwN2j61j8qp54X2jH10hwG6uVDoEODHyDTanMTJo5QyJo3C75C7R/FMsmulFa3Wcv4EwbUPyUnFY1CV0ckUArsreGWrthzv5MbhwNvM+k4H8G6bSR5Qw/WgNXzC0MrFeXtpQCTJBsX38bYepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+NwSi5CeAsuP/5AKS2jsydrNRs/CIZMVlJ3BMvOEGE=;
 b=G+OoLfKeY1bhszZQHwEn38HTdaX45V8FFeElHdesDz07RHnntM/7sRZmriKuEJzLV9dgwH9Ta+v08unf6pZZiNkmdgdNwpwG0gE7GNr5laM7m1a4+Za067+Fd/sCziZ/g56E//kq66cuplFPt+yBxrQPgvydwQLSc4fOlFYNfBk=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYWPR01MB9421.jpnprd01.prod.outlook.com (2603:1096:400:1a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 07:53:50 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::5cff:5d90:9b08:6a7d%4]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 07:53:50 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "van
 Buuren Sietze (XC-CT/EMT2)" <Sietze.vanBuuren@de.bosch.com>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHZ4U6rQJ50P09wsUO9eWGqAzwao7AO/cjw
Date: Thu, 7 Sep 2023 07:53:50 +0000
Message-ID: 
 <TY2PR01MB3788FA9DA3B22348C55FA2A0B7EEA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <261b35bd-3e2e-4841-a6ce-b6e95479c131@siemens.com>
In-Reply-To: <261b35bd-3e2e-4841-a6ce-b6e95479c131@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYWPR01MB9421:EE_
x-ms-office365-filtering-correlation-id: cde27bb4-5d3d-450c-a2bb-08dbaf77932e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ctVR9wW/LB2GpEWsaPugHxmi3r2uj5lSDnY9ClsspxhXU6pr2sK+0jJW+Grs8GyrQz9jqNF0I9IyqnnJpP5N+GhKVu0O67kITPL44JGSc2YY1+gqsImqCCeeAHUOyBv5DXB0YL0R12FU/Ini2+hkXwnmc9dGRSVWbRJ7+xYajO7F2fUzvo7h/fHEschLYbRYpg5PVAL4/rxYArAeS8uTdBlvZAzlUcihsUG1PgOB7kqkGP4MQ0Gnh74yuCOt9xG+zGzo2ZqvIrbSfLN4LSto2rCOWH8A8rEiJeLyVa49UHYCTtN/uaLEI2ZMl5JdHMANxiwp1xFyw1G36jU1qPj74kNwRuK/kkDQdsanuGejGIBsgXqALSyeEtSy6wHWUgjNrJ603dXD9AwV7jG8CcvV+Kf/wqeKHzzNqOc+uBt4WEjsAe6sGQYS11FTH16KhMzj4aI4w6Cf2XHv7YJZnJ0vH5u439lOdG6NeSIeHuGtG1ELIPQPMF+s7dynbVXXY2nRLgNnG3+3kM+Ww9BUq7u1khmCyRb8mwGrQAelfjZ3vH+Q7UJ8P4lSDyW8i1LBPUe9i3k9lrHvbSKRbeq8gFDuVNc2nrd9FY9fbcV3yd8htQxaOiliXpdxW8QcG4+s8UPm
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(186009)(451199024)(1800799009)(122000001)(71200400001)(6506007)(7696005)(9686003)(110136005)(83380400001)(2906002)(26005)(4744005)(478600001)(66556008)(66476007)(64756008)(41300700001)(66446008)(8676002)(66946007)(316002)(5660300002)(8936002)(76116006)(38070700005)(55016003)(38100700002)(33656002)(86362001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?Ow4mMaZLl8Esrm3WuoPfCOcgEM3DU5X/q0+BnmTOPX/ndCxVI2pS/Fp5?=
 =?Windows-1252?Q?I6dvv1J6l9RD3VHlq28rg/wkLVtxb3pjWokqxwpnRL8lI2edQ/NXotoG?=
 =?Windows-1252?Q?bL1Q32J5ZuRLlKrnm06ja6rYk1WKkmMCwKxf5u+b0RzXxnLJx8PaxlS9?=
 =?Windows-1252?Q?LWRgggMesdoaUFR+0vlu2HaVmNKwMcPI6I46C5+MqEC+RV+EJVcuk8dS?=
 =?Windows-1252?Q?TP+pYjpGDLb4aEK+0wKoZSlMC466gh/5Ok/Ol7CiYC8BX7S2ZBWu6jAB?=
 =?Windows-1252?Q?HmIvuQC4HIRvBCZ9m5WpXGeiGLLUrllZ8CYNC+nQTynDD6sSKnSmbYE5?=
 =?Windows-1252?Q?99pvN2kwKZ0h6ow1bsHVyy8rErrXwXYA3ggNcCRDwVCdEjZW6+4FMRUD?=
 =?Windows-1252?Q?soZMq3ly1cIz/V2Ek4bBhkenwfSj+dPYDhCtxzXYbyujp5GeDjP9pzVp?=
 =?Windows-1252?Q?BGJu8CHOZJZqaq+A4CBUI9EJEBjqMrOj5xcpPzIcA67/iFb1+Kjaw8Wl?=
 =?Windows-1252?Q?ZCpTQ8QSdVci7qqyeQxotvFLDBlJbU9ubG42h4H53/cSslolaJB+PWOk?=
 =?Windows-1252?Q?q4U6utTr2quG5CsklZI2QvhYZl+Rel7rgnOrIbN+jmsM1ALKvctyB4Hx?=
 =?Windows-1252?Q?k3DPiSLfIwadk3syQAgDGrLKLlkiypzew2ZRRz0ZZXsxc0FNaq0zYpoc?=
 =?Windows-1252?Q?3ruiQJfsKdLcQVURP00oUGKKAPvgfaSgyAy3oEsSBO+9XfBQhg8nCR74?=
 =?Windows-1252?Q?Y7pN+5z6dJxzeWzHlbpRwTXMeCscpQBfiAhlowLMjoEIhshMoNjFL4CN?=
 =?Windows-1252?Q?fGogAumOPHpzetZ+OEEUdsTZLZiTbFFjEQP73VbQ/+bMBkYrn1rzhSiM?=
 =?Windows-1252?Q?6JldbQ5yjMXb4d379/jCELHuhsvHOZGJT98fCs3IzuQb7aYKS++nT0wc?=
 =?Windows-1252?Q?uqAbBvA0H5oL4VLCeHDIit4j7XNwNkI7aP63Qu1PajOuhXC9sIA3mvjY?=
 =?Windows-1252?Q?TNyI2Li8UhfCpLkSb7IroBg0qdSeeLGBJUD7WkBfXSkZmdiSKAx+z9ne?=
 =?Windows-1252?Q?Ph5A1SBTwPgGRj8/Gq9pFxgzBKmjGIgmoeXwNyj5DtkxOedFf6YSuCa9?=
 =?Windows-1252?Q?hLNawuqRVlnoKj+SMOGBqkxNfO91heglsNjK/rNtvPKaaN65EiOkQcDf?=
 =?Windows-1252?Q?p/y7xzPO9UBeK5KaIMsDAlTZG3SeiIM/bTafHQSVw1hTz4RagYcnqQzT?=
 =?Windows-1252?Q?CC5S6rUEgxKEOdeEK/YUbtadLVf3gu/Ia1uz1L1sTu93906sM/n5ROeL?=
 =?Windows-1252?Q?9bPLNKMjUj6VRNfgxq58tuM0cGGSDZHXg548jnfAq9jmtQTJyKgCjqIY?=
 =?Windows-1252?Q?wtY4zgNQvqPXdA2xyrRxcoig5SY5GXuNtlvBIwww5wyKf3a1eoQf5PzL?=
 =?Windows-1252?Q?5EwQMQcujIj2fJNM/AP0MnzDw4540bFEzsI1jzKjQVev5JJUziDorFw0?=
 =?Windows-1252?Q?ko8y4IpfsZO9OoLYpYbubIx497bVBaP0b2ykYu1xowbG/L1w8DmhVeoi?=
 =?Windows-1252?Q?d+vX0V1FQ3peprGe2tn8oz7s5TsvswiBka44nHgso85X2IWGHI9QMaQG?=
 =?Windows-1252?Q?rZ75xCPkG4CnbpFrLD1DV+7X8I+l/6p3E0cvmoWSZ4yv8ta/fGLDLdAt?=
 =?Windows-1252?Q?xapMBCRnLzXjJWbEI4AIZp+g8ynIhwE7Db3g+lu29Yw3vYHp7yKqUQ?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde27bb4-5d3d-450c-a2bb-08dbaf77932e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 07:53:50.8114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r0XGpsSjGGDURbCMibUsP1gahsbU0y+gPA4Pe5N8BUosrKVyAVNMaFqublCwjN5CSwnwGc5EI/MjPTNDaom52wzbyELOeVrJyDBHphpP4/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9421
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Sep 2023 07:54:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13001

Hello everyone,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Jan Kiszka via lists.cip-project.org
> Sent: Thursday, September 7, 2023 6:46 AM
>=20
> Hi all,
>=20
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today. Our channel is the following:
>=20
>     irc:irc.libera.chat:6667/cip
>=20
> The IRC meeting is scheduled to UTC (GMT) 12:00:

I'm sorry but I won't be able to make it this week.

Sietze has made some progress with the SQUAD prototyping.
Maybe he'll be able to share something briefly.
There's no other testing news. Please let me know if there are any requests=
.

Thanks, Chris

