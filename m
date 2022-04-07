Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F28C35296
	for <webhook@archiver.kernel.org>; Thu,  7 Apr 2022 15:41:14 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.123])
 by mx.groups.io with SMTP id smtpd.web10.4973.1649327796495292234
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Apr 2022 03:36:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=ly/l1LCs;
 spf=pass (domain: renesas.com, ip: 40.107.113.123,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUrnf8ufLDs4gPCVT51a43E18BH9K2dJ0G58SWqohS0ggzlTOBJi9f+kio3hkS5Xy4g1C79RlqpajBK8uVzMEk37c9LG9SuEhEKaiwY7nGxWV6V1dsgODfQEOyP32Gjb8yXiSkkv0hkzcTfhs1CXo8lb0nYva9ORH2i7kSukENjW1qNoTLSfOJAkvOXShSFkbcVBrI3oj3sdWd2GtxExVGpS6lLSBrnkOp8LfMbu1ai9S4fdzG4xMHHY3ju4V5hGCe7SymZbTRBdl2zcySWwG+4B2MieZNIptJ7n5kZSX9IjTNVyJA39kmb34bIQboEUY8oHr5llSTq/v2E5X7ZcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlseIo6lTikaO6kQmM18xahRPcPf8ml+jLZ1P0O+ew0=;
 b=dQDReHhS8B1rZcQrgXt2A7zK2D6iffDXz/kOBQ2pyApxdWtleidy/0yRHg76NIQVJAg7o0XFkdCDf8F0n/JOSCRydaclbdyijXShFaQdYy6q8fY42dz1PG19D6IvUhNLHCNcSET4sGrXU+Z10wnu3owQ4IFaNgCuiDzw6NuX9AElRei5TnCSboFVv44B+4xtyeM/fTRF83Fownvi+p7BuqoDLJFHbxNBsSpc0GVzZUtaGadN/8SbFtkunXHjPpuhbMoW3rpd+nsUiEX8gCh7whpn3IKakwFgrcI0k1sJZXggd1H8fgyyuOSsGOPvFfF7cnyifizc8DKmoUzIOWvNxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlseIo6lTikaO6kQmM18xahRPcPf8ml+jLZ1P0O+ew0=;
 b=ly/l1LCsxD52gxDU8JhYz92u010aZNdQZ7rlbdPbQt4BdRCLE9wtkcAuZF7eIahzQZqzPRKXYqyNH4yDNLGXCB11eHn3CWhLwM4u2xKJ9AGkI6TKInH4qG4xQlA1vypf+ZDjj2Wymqqd8B4jlVCafyhxESnFy1Mt9VZqqss6bas=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:130::9)
 by OSAPR01MB3955.jpnprd01.prod.outlook.com (2603:1096:604:5c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 10:36:31 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::440e:cec6:b2f2:be1e]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::440e:cec6:b2f2:be1e%6]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 10:36:31 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: 5.10.110-rc2 mirroring/testing
Thread-Topic: 5.10.110-rc2 mirroring/testing
Thread-Index: AQHYSgKL1Kwgzb8SWkS6QXkHofo8c6zkAZGAgAATeWCAAC0VwA==
Date: Thu, 7 Apr 2022 10:36:31 +0000
Message-ID: 
 <OSZPR01MB68776065BEEA1120B49C46B5B7E69@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20220406220612.GB4213@duo.ucw.cz>
 <b0523b80-b7ed-7ec8-2bc8-4a230b31f13b@siemens.com>
 <OSZPR01MB687707F1F7114CA3DEC73FF8B7E69@OSZPR01MB6877.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSZPR01MB687707F1F7114CA3DEC73FF8B7E69@OSZPR01MB6877.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9742239-e0e2-43bd-8e9c-08da18827b0a
x-ms-traffictypediagnostic: OSAPR01MB3955:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB395511F41BC1613065772551B7E69@OSAPR01MB3955.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 e5SEI9B1ANzb46mZO4+UcWiYph8diWDoqsScv8NMb1Ni17KEWyWoXSVneyFeNSC9PANjvb4kbOZnIYqdtP0rHwfIFdwgdtwrSMW4UFUw/eKhXSNCl8CVYlnhpiDi2Hrglyo9CY2E2h6sw3q2JSXK3RsmSaqwmT9mKZSnTBpi9Bs2vL6ZLsbAvv3cROezYMAfBnEktYjs+cMq6N5F8jdYz/5SmdfGWVqsbzLA6+twaVo+P4plzqqfr39AfHlW3NZth5aH30iSdDlHf57nR/lJJZKN5d9EG+LUAZq9ISv+Uw3m7qdNdYBGtoCrDSzFvfPZLhDlotfWxk+b/6NwjXTAqyx6PbhcYVPLRRoB445kBmwXvU6FIQ/j717cghE9p1Pr0gtZh0L9F6qQ0/1wM8vB+JmFP0VkQBCIggViDBYwb6cbpKUv8bj8ASwMM8OdGNAda4zyqpTNxF1TVvGJ1f4u/kSsQDXMPxRzK7Y8HmRrX/9ViSlYlUpzNJf4DB1HV6lNURjdM/5sgKqayRO+qw538v/7jG4W64xUK3QZYq6bqlmZEMG6CIlYlUlp+TsBokoHb5+WogQjQxsLRj7Paxey+kSx5AEpoGZ+Jhmcp5ilfxFccbKY12vYg1OuE50z+pEXZfchL0o0mypQPGqEOUdu5wHOdyihvxmtR7DfaUkaNbb1dCue31jLo5dBd3BNs4Sz3nOfawRR3GbqcgEf58yvrHU6ONA76tsX2K1Qe44IdGOtrT7Q3i71FLuDfoUBOmxZrbRgf7VuTCGRU/+rBCbE4eYbhLMVkfEa3AYqWnS//AY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(2906002)(83380400001)(86362001)(966005)(55016003)(38070700005)(7696005)(9686003)(6506007)(76116006)(122000001)(5660300002)(2940100002)(45080400002)(71200400001)(38100700002)(33656002)(8936002)(186003)(26005)(508600001)(52536014)(8676002)(66446008)(64756008)(66556008)(316002)(66946007)(66476007)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?e9s4aGESBRzByRbtx0cgp5aKkjPliCST7rZpCmaCaSG+i/sFgNxlumdh?=
 =?Windows-1252?Q?38gG1xeaSWkWuRkKcBH/EyjVopo+hAEoLhuco64tcTVddsWkavu3bzQ7?=
 =?Windows-1252?Q?LGlPms3h0ermQDOnaA+cKRiDwPh/7h+k9+9JuCoztxx7+Oa3erFbT9/j?=
 =?Windows-1252?Q?k9hzyzE1vwcqJoaQOrV2+zfvt4+lOKzQaPMryU4NewGVDCu/FIdmVRwQ?=
 =?Windows-1252?Q?YBM4jMmAdxueqyO5aNswuqc7CsS/7hBS7fL9w0jhI3S0fx31Y/9w/ZDH?=
 =?Windows-1252?Q?IpsIA2M5IkYznvhZKuNSoPNdGiqhlTl9XPB6REJne2yeT/aeyPmacPlN?=
 =?Windows-1252?Q?sb+wrDseG3Krwy1QHP13QDapIU2wBUYnbtXFGKG1JlKF5iHq8+w/rUwd?=
 =?Windows-1252?Q?y7wyU4ngC2iTrce5geBVxy76uakMKsPtHP13zLbdRm3f2sFXr049klwS?=
 =?Windows-1252?Q?wjWZZra8f6GXF+g4qA34JbbXAwTpOmKNb2gclsoTNDag5sr3/6c7oCDD?=
 =?Windows-1252?Q?JLVImJ3qZbT4W3Nq6byH3/uru2REjl7GRBt9CPjj6drrfF2n4f1sv0vS?=
 =?Windows-1252?Q?Fz208/4ayQbUIFgOaqIi6ZA2fqRuTNeHBj0me1BvOJ6C5tgai4toor3+?=
 =?Windows-1252?Q?KsRavTlcV/HrB7LVA5AWde5MtjClCS+/qc7cOjw8c9YEmmwc6LuBS12g?=
 =?Windows-1252?Q?MERXaAiWZUGgc6O2BzLY/U+NIUc+vN4mT7oLfhlbl4McB6HY21LeCD90?=
 =?Windows-1252?Q?ZZR/WnH5eoXhMyyCp4McsMwbyuB3EROPhntwdLHI9I0BXOImU3Os+EhH?=
 =?Windows-1252?Q?64qyvmjN35/Hs6XIY+00uII/cSA9ZVgtUbfdWtQrfw6BwZRm6Bmpouo1?=
 =?Windows-1252?Q?fLBMqcOKS3hkwW7ptcBcDrswusPUTsQCfxCx4ce0tqGeVHdZvoUF5XHa?=
 =?Windows-1252?Q?HUgfqLbSxSZNKFq6+s65KaFp8TzwmnL8hF4tfvhbryVTbhcVCz/NXO70?=
 =?Windows-1252?Q?p4+O8Dza2LcLw6oYpBPqOSpFbEDeLtgqbtideYeGnZ2k4eHnv0v3KnNY?=
 =?Windows-1252?Q?k8+oZpNjUoyuRuhtqc9yxAF8VzqwPz1kunbecDK+2CBJk/286u/rfD4s?=
 =?Windows-1252?Q?qhylXiGa6Hb6N9YUnY+KLyki0RJ7SXQNOlPlxB7Dm5xarjXDBzIJdCQv?=
 =?Windows-1252?Q?hZYsshy2/w1aRHIwnXtrRJwJC3QjF8cUiIPLkR9VM3XI5jFy32F094ZM?=
 =?Windows-1252?Q?dOXpDcwHPZmyFYSEJ9uG7u6SQKqBcy+UKv12x05X8thv7E4eNkjPoV/R?=
 =?Windows-1252?Q?LuBP9c6BW3110TaNhjKwASp8P3iO35AxOyO/SjQ/mXScZ9VHGjD5ZbGU?=
 =?Windows-1252?Q?G54LAt95ZFDSMFsBKoxyoYoqyvyHJtFAnZEczy3rsHyC4QHFlPAX0qKp?=
 =?Windows-1252?Q?1CAmsXwPW78rJKQH3xPuN+RApm9fmDABBKGPkNTd70bdBR73riDLJJPd?=
 =?Windows-1252?Q?Sl4OpauctP8WtBWxz36BOChwKr0VZ6iq7DcorkwozcWTo+C1dH+o8L0J?=
 =?Windows-1252?Q?NNvE+x4MGHS0G8IZgF3X0ii1V48Uk1Ie4GnjValr2FnvyC0kevANSZg2?=
 =?Windows-1252?Q?xIcr1CmjluOu8jnPAk6IKDOqcZwroMuZ6s8sRTnQtEVItRHHqHOc0YAy?=
 =?Windows-1252?Q?EylVA7xC+qPmOSV0V3Gb9FwpYkWV1t1rpchSGTjqwko4faNAaoKoeNZ1?=
 =?Windows-1252?Q?ipQx2PqSakgT9MJYtAhD98735O9ey8MVoayOREMr6G+LsdRrv+cl3dY8?=
 =?Windows-1252?Q?Cb9lKAK4WK+fOUDZBt+x7hJEc7yH7O+bkpbBt22i5R6hXx0mnWi2A3AS?=
 =?Windows-1252?Q?41GS/ikp0NLPabakswcBaWKDJ5XMU1HwcUY=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f9742239-e0e2-43bd-8e9c-08da18827b0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 10:36:31.4513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 N5qGdQrr2CwCjwzkwqrKett3Ld59rHBsjzMYBDt7sABs1T/NJMpq/kaHikt9hm93sj4lEz0UoI6xt+m66K9Oc6JAeJ7wy/hSAGjBv/X3yKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3955
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Apr 2022 15:41:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8021

Hello,

> From: Chris Paterson
> Sent: 07 April 2022 09:51
>=20
> Hello Pavel,
>=20
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> > Sent: 07 April 2022 07:44
> >
> > On 07.04.22 00:06, Pavel Machek wrote:
> > > Hi!
> > >
> > > 5.10.110-rc2 is out, and it would be good to test it, but somehow we
> > > are still at -rc1...?
> > >
> > >
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> > .com%2Fcip-project%2Fcip-testing%2Flinux-stable-rc-ci%2F-
> > %2Ftree%2Flinux-
> >
> 5.10.y&amp;data=3D04%7C01%7CChris.Paterson2%40renesas.com%7Ccda7f53
> >
> 12d69483e751208da1861f34f%7C53d82571da1947e49cb4625a166a4a2a%7C0
> >
> %7C0%7C637849106225416510%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> >
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&
> >
> amp;sdata=3Dp0tXQDyIDY1SqRyIOHrtFzygGDqTbRphnrVzn34XVy0%3D&amp;r
> > eserved=3D0
> > >
> > > Does mirroring need to be kicked again?
>=20
> As Jan hinted, the mirroring has stopped because the linux-stable-rc
> repository has now gone over the 10GB size limit.
>=20
> I guess we could  remove all the branches/tags we don't care about, then
> protect the branches we do care about (LTS) and configure GitLab to only
> mirror protected branches?
> Hopefully that'll reduce the size a lot and mirroring will work again.

I've gone through and deleted all the tags/branches we don't care about but=
 GitLab hasn=92t updated their storage calculations yet.
For now we'll have to wait until they recalculate. Hopefully the repo size =
will drop enough.

The alternative is that CIP buys extra storage, but I'm not sure if that's =
done at the top-level for all of cip-project and the individual project lim=
it of 10GB still applies.

Kind regards, Chris

>=20
> Chris
>=20
> > >
> >
> > Maybe the problem is rather this:
> >
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> > .com%2Fgroups%2Fcip-project%2F-%2Fusage_quotas%23storage-quota-
> >
> tab&amp;data=3D04%7C01%7CChris.Paterson2%40renesas.com%7Ccda7f5312d
> >
> 69483e751208da1861f34f%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C
> >
> 0%7C637849106225416510%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> >
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;
> >
> sdata=3Dpzhx2y7WhVSd97cJak6p%2BTfM41%2BoYbRLe1gQwoX%2BxuI%3D&a
> > mp;reserved=3D0
> >
> > Already linux-stable-rc uses 11G by now.
> >
> > Jan
> >
> > --
> > Siemens AG, Technology
> > Competence Center Embedded Linux

