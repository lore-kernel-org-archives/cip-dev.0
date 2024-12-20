Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1911E77188
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 18:07:11 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.21])
 by mx.groups.io with SMTP id smtpd.web11.1360.1734718021560898655
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Dec 2024 10:07:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=IIbsrYfB;
 spf=pass (domain: renesas.com, ip: 52.101.229.21, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWjUhDR+MhvQMmzbLzCcUnloZKn1LnK+6XQ6OawtpB6gPXuAJ54XTyoTP9Wwhox4AIhbEDOKLk2xlNQFOXNtZNVDS5Y0YJSNuMR8JXtXjtvlPBwZlv1mV8AHu3k2ElKhl6QjM81yeprVMn+5qN5UfSvYIAl/WJyS5/2dgfWzHoyU+Ft1xL6TtFSmDNGVXcbkpYZTUUjXBNfIbTiZGN4+ly4EhEUN3PAbTQS/Y2Vln8S1sghefWgrZczuCYFWnRTpQAnhn+d6t0GJDn6CAPbzGRdb7ydYwUP7QVJBtf8XPLEI+9FxCVBJB6uekwtDfGQ6oQ5r6csltpyKRA0a+yN39Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZSTL1t9GH6heYf1NgyZikJV/Ni8RCFust8W/JB4RBg=;
 b=yeXgFnqwkSUnyj1ZBCE3vU0bU1dAJW4Y8IY3NpuKrOEx3a+w7zbpEmeBudqWryQuZtmr/2HiVUSk4gBi4eLNPiPypcr89jpbmP6JTG4q8IWIKkzmCYuS8w1fcEL92VmZgXmRupi69PmUKwlNvqjBtEOhRuTmcoz+fS/qpw1oMTU0I6CkqCVZfKIeZsXGPumADpv8h3OMhaQxa0YcF26INo86SsehTos7Eep8Ra/r8L3E7f+/sEhGeuvD6CK253ke6mGzlo+EKTXy5Oth5PJ3/reFb+snbf9wbhS+rt+OCjIdhS9evuVybAyp//iAtXLBjzSooD46+r1GgeBebLZR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZSTL1t9GH6heYf1NgyZikJV/Ni8RCFust8W/JB4RBg=;
 b=IIbsrYfBdRRDPGGkSDifXLmw/2o+FiSaejRe4W4LRUNBTJtFnh5weGIA+JpxTJpkdxPsuuhzlgf6dlNh1DD8ecs2zG3uW2zq08FAL5xxpt9eXlt5JLr7NJ1JFm/XdBEzh0yaC9nAOhA4novoFOhBC+BXdDWJpAARzx0DaO+0LOk=
Received: from OSZPR01MB8401.jpnprd01.prod.outlook.com (2603:1096:604:16f::7)
 by TYCPR01MB5696.jpnprd01.prod.outlook.com (2603:1096:400:44::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 18:06:56 +0000
Received: from OSZPR01MB8401.jpnprd01.prod.outlook.com
 ([fe80::c9a:aa8b:f8ea:998b]) by OSZPR01MB8401.jpnprd01.prod.outlook.com
 ([fe80::c9a:aa8b:f8ea:998b%5]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 18:06:56 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: lab-cip-renesas planned maintenance this Friday
Thread-Topic: lab-cip-renesas planned maintenance this Friday
Thread-Index: AdtRSwqPcaYpZoAjTv6ENBovlM7z/wBvq++A
Date: Fri, 20 Dec 2024 18:06:56 +0000
Message-ID: 
 <OSZPR01MB840119ED307670AA71BCC1FAB7072@OSZPR01MB8401.jpnprd01.prod.outlook.com>
References: <18124646D13AE908.23577@lists.cip-project.org>
In-Reply-To: <18124646D13AE908.23577@lists.cip-project.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8401:EE_|TYCPR01MB5696:EE_
x-ms-office365-filtering-correlation-id: d841ea09-3e3c-43ba-f0b0-08dd21211765
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?Lg5gDho+5vcvRBX3ajTpGow9uDV1K7dDL7bl/VGletKyxhLcfPjGueo2?=
 =?Windows-1252?Q?Aildu5S/UlqsaNBI9X3yZxFkABo3l8gIGM6x5wSk8ZcLofesXVFyU1/v?=
 =?Windows-1252?Q?p/H3P/+EAMq+jXCoEIbs1vFerxsogZaZ7rgxGSR1P6cwkZgvpOAbn11Q?=
 =?Windows-1252?Q?hOW9lR2bhGW/jv8cBO0fdvd/HIOCMcYF9m1GEYjKJWaVAAROhzgfjHdw?=
 =?Windows-1252?Q?j1t+PZqlrv2e5xY4Kgaoi3qfmpCxh4qQ8pFgUwS9roxQYum3xhs6mGss?=
 =?Windows-1252?Q?gAP2XnXAmFUQHZp7yoL6agn2kCn0zAFiT9FBWzbk2bHEvJvovnB8mBdF?=
 =?Windows-1252?Q?fijBIJYlkZte47LwRz4LhbIN/vHs+7kNOxfo/c2xzzjglQbTdBycjSHb?=
 =?Windows-1252?Q?lUPB/bz5z358zvfOmZaUPS7EFBn3LpBJsZwDlO0u+AaVpy5vtH7D8aVS?=
 =?Windows-1252?Q?b9LmZBY2fRqHwSA5TTVmcTHsJyW6WYY9/MKfWnzXSXaWiDjHZL5ce2PS?=
 =?Windows-1252?Q?TVIAn4k0+EFZeF8Q8VHNpaM/nBGdwAAcIItLFYFUVSHOjrFhNdxMuejk?=
 =?Windows-1252?Q?geGBl6HqsNm630A9M6XH4fTqmgy1eqKMqReYf7o3hVfieILvDNwmWg35?=
 =?Windows-1252?Q?byPrR0ZoVik9liGvHZbs50/IQjhhXgOQMfAbcfR5E5x8/2TIotXUzu5N?=
 =?Windows-1252?Q?16KaKl1zF8X5qkxU9Ax9eJq+5k1qV+uDXh3dplAAnbmCugpszp5EELUk?=
 =?Windows-1252?Q?ERTaskNhUaV9SLVllZLF6njJQr+vuyg9ISkk48jVoq/ky1f9TBoLikf1?=
 =?Windows-1252?Q?98/8CeknUm7v25WyBY19ZbFNfEbfrnvbBpGkRizLdnAi7/16mOHL7VGn?=
 =?Windows-1252?Q?H+r2OXxTqwfjjjEvW9LtyBAWnoEuXIsiepYE8h6GLzJUdPdUqyKjPe8C?=
 =?Windows-1252?Q?jw0Lj3HNk+X6g19z/RZTLXodcYpZ0EauMXvpkyjsrddKCGrKpznoyYxV?=
 =?Windows-1252?Q?qBcEMUmIU5G7QJx8ZyW0tD3hPm6o9d86Kys3D8JefTdDE+MAgvdobIPm?=
 =?Windows-1252?Q?a0oy9H1O1BYOuYb327RiyuxjmYxeHFYmfio5bRTQGPUz4iHaxc7WR6jl?=
 =?Windows-1252?Q?UlEUmANKwnGUWuUsKM9aA/AD/B8CnEIRwnw8UzAjaMmYIImdF3rYSc5d?=
 =?Windows-1252?Q?wHmOfM7SJV0HFYEK1DtNZu4wTLG/E0S0U/8FIS32t8KAFODHARsGjplj?=
 =?Windows-1252?Q?jgWvFgCx+1GSNzPDms4I8O7nvV8x/4s+zeaZv212E7upqRKOg5SOcgDm?=
 =?Windows-1252?Q?6fTHMim43ohq51uJgl+IFYW/mOfFLZpAKFdBdHBTmRf343vAjU5BoWVk?=
 =?Windows-1252?Q?oeKde4jv33wRyNRiCMbLmRQYqYwOqqTiw1o4UbNovtTXX4jQDuB0wqJU?=
 =?Windows-1252?Q?PAcLI3fW6Off+vEQC5289OSJQxEbui7304vxeZGzb6AjhSbs97WKpCIa?=
 =?Windows-1252?Q?upx37YigqnV3UsucccvuekAM1Op4tn6C+cfZxmWN2Oclxjxf/kj6jj8z?=
 =?Windows-1252?Q?KT7D0pYcmwGp7aI0?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8401.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?87qITg/MhdFM3oEGxnylqXTKkPPYQsAplfBkCs9qNzYDF4VHJLhXojE7?=
 =?Windows-1252?Q?C3NNTeoUxcVTfOgC5E7FWncLszuRD1BOV4zLtVg39KZSi+9aS5VcOSRh?=
 =?Windows-1252?Q?sYlMqdKi894cEOIL5X1PoJPTif+eLFy2L31snNbjtT79lriAlzd1TxUX?=
 =?Windows-1252?Q?Vw8KM+tiaXNbWedfbKxA0QZZQTiayjUipXSPrcp4sbGh4dbUQ1RrqHJu?=
 =?Windows-1252?Q?nP3g9G0M3nO22ZD5iRUvyxDOUWbSzCw1EjGifzv4gBSsv5TjtDQoAp8m?=
 =?Windows-1252?Q?eB6kwYfHYEvgW6aeiNovXaeRoqI5VpcK37qyh6xDYbjYf6lRsiuUeMoA?=
 =?Windows-1252?Q?DxY7JT40LqIB9zmqMwN6FBZtHK2sZoGJXUbD4bx1FehS1n6mBCCRtQZh?=
 =?Windows-1252?Q?Uq4jtKWIpNW8Y7yYpRN3O6ebcjLd6lsFw6HHQuHbFonNt9gVVaan5c/5?=
 =?Windows-1252?Q?YLs1GDV0sJkH87Gly/ERMxDDuCOzSCGKDOIv1DWFMweX4jPx+l7E0oIe?=
 =?Windows-1252?Q?tCUHDw8HOb4fsggMnC4Bo780qbJWyQ9hIsx/X0p0p3FcMOjntvI150N4?=
 =?Windows-1252?Q?4TFL/nD801X1l5E9ZXb2JWNcfrEGumK4fG4qqXoLURwp7kh2lOu7Kn41?=
 =?Windows-1252?Q?7uq6kAC8QClpA3yMRNK6JOh7kndpaU9l12mbO3OfgQa7oPtE0luc7ij5?=
 =?Windows-1252?Q?pJjPIJY/LmAyV+UAY3U1MSHtBN562Xlx38zTwRrkp0CKN05R+VSl8A59?=
 =?Windows-1252?Q?pLDv8dTktumcQFjkIHUwXfBzpM0e276AgiV4+ey/ZYWy/bSH9KcIsk03?=
 =?Windows-1252?Q?wYhnsc4rbz0uCr46psZzM8EaPxXCRT2TmJCf8hhfz4DBeeAp8t+oUXdn?=
 =?Windows-1252?Q?XiyL5s1fN7EZoXI8kVIcGBw1l3emcZ27/f6mJNnhLdp6/doEg4meHbH9?=
 =?Windows-1252?Q?dn5TCyTpheNatalyTQFATGtvAOrBoDOuIdWFfe7SSaVO0F6QcjRl2QLh?=
 =?Windows-1252?Q?bj+BgNY8gBr6Vb1Kq4/KH3lPDsdQWPgm9ZuHrLkDMe9dI+cCggR7QkSs?=
 =?Windows-1252?Q?92sCKBPpCZCLY9E/yzXPYeXWvHqlgkGwDOouYX0+DkzessDyfKcaEWp4?=
 =?Windows-1252?Q?MIDZ/MIbbmRzOtDlrF4ljMbg7nlXiDwjoKtk8KYgfNcLkNHREROl1UgP?=
 =?Windows-1252?Q?csxxjXdqN122bsvJXYM6L7WEtg+YzlpKn6qZTCoVPCS9UA8eCvkbeRG+?=
 =?Windows-1252?Q?xV0/9nb4JN6+j3anMJ2faNuNykp1B/oc8jHmac6OzIcD48UvNaC4Ilt9?=
 =?Windows-1252?Q?MU/7QsWcc8yVHTKYfwWb70z7Ola9aqY4N4yfkHkDPlYKwNOhHKY3K0Dw?=
 =?Windows-1252?Q?O9COUiiynoVfmIrgYmp6pOXo+i8YPOCiLxlaLHO1qUb0OQkZIjTLKdZE?=
 =?Windows-1252?Q?0gn++kB5+f51yhwQhNPhN13LICTjebytVSL7LzovPtNyIJuLBA03MzFz?=
 =?Windows-1252?Q?BFnuhaeFhzCvyp8A/NoVqZ3rsrk3IYN8mrk+yk9SzhJXNphUK2pnfqMt?=
 =?Windows-1252?Q?ghhhy1xHCyxaJOM8XUJm9ER6xH9wYpL+baA9O2iB283rdQXpr/feE2K+?=
 =?Windows-1252?Q?QBKiXaI1V0xPt1vc2Y4Sq4sFNVLNSsPyZbuaNU8M+PHeO7/l/9KrXzz2?=
 =?Windows-1252?Q?SLFeroeUDLLAscautc+9haBzrWE3S4+OBbSxw+A0rsosF+5o5GA2/A?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8401.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d841ea09-3e3c-43ba-f0b0-08dd21211765
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2024 18:06:56.6129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KYGu4besvYxaTEnbupezMFXTymLx4hGpndDw+j9dWvPGKDLwjSG8fahsXIgsQ1+OUERN/JYX9/L8hDS8B/xAAmSfMTkigz/T8uf70EPmR5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5696
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Dec 2024 18:07:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17488

Hi all,

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 18 December 2024 12:48
>=20
> Hi all,
>=20
> Just a heads up that lab-cip-renesas will be offline for most of the day
> on the 20th Dec as it's being moved to a new home.
> Hopefully this won't cause any major issues.

I've finished moving the lab and it's all back online again \o/

Kind regards, Chris

>=20
> Kind regards, Chris


