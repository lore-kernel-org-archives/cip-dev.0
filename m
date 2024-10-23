Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED1ACDDE69
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 10:54:00 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.27])
 by mx.groups.io with SMTP id smtpd.web11.6068.1729680832978527420
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Oct 2024 03:53:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=jYEwTwr8;
 spf=pass (domain: renesas.com, ip: 52.101.229.27, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaVkIu63OnZpRXcXAhXFPV6JMEp5G9uHWAcVxRULpDesp91RTc+kppO72cnuBOaa0RrsXpB/Zu9inFS45amZzjfvZfUorngA+HBeNNfFOpGDnYm8giq9pSwa21QqGOW8WHj0XQ4n9BIIoAAO/U0DvMSREm8XRV9izWTP52zn/S6L8vHMXCL1oD7JDdoGydNx9MyEtMK5N9XNb9Uhk6I91WqrxDAkA7YEcHK9QqsKr7S66bhamc1rvOghXuIJe6G0MfCq3T5buOaXTFTOuOY8LKKmXAJdfzsG5Nu+pvy89O2XTsk8PYmE48Vb0aibgi5WeUhwsx/EoKVmD2VcKEm5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTPQ29CmWfuqopx3lwhKxWBvCJMq1nzfJc+ZYcxuuJs=;
 b=ttbwqocf+/f2WLLBLpLHh/IzFba9qJCUuiHhzBjZo/S+ArpVEHjBbqfl6rVrEp9oR+ToGqIQCJW/D0XQJpXwMSDCbJt4KKrYuxZMNqBdka5S4VrWYguYdE7UFdCmEjUHoKhHqLqU03U04ENw5GDXQG03MgQxtehHrrTVau7jCFSJQPAQY5B74H7VLNJv6Ngu9TL+lZVxBoAUZ1/tE31+dEJmB+baelsuvg3nIa2Fx82pp5bJik0RVxd5EmP4lGo8VhQ46IasLj5cl9AaF/ruTtd3JNUriSnhvf5V3KleGhqEcrHTexaQe3R7m8SFVE2gcu2q6AKZsiggvKRjg26cjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTPQ29CmWfuqopx3lwhKxWBvCJMq1nzfJc+ZYcxuuJs=;
 b=jYEwTwr8GhsDK3jmWyZ736A0Gaafg9zAjCK5+Cxk5livt1TJuCPcpdxt6K5YtjWavEMzubvs9ueKHSjuxlM2f0odYnpbNHYcn2ETbzDlTF54oMSwuStAkhFb9osbWqpdpQNfOe+yoCRKtHR6VutQG9diQNc8uIm7z1a6T3W4au4=
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com (2603:1096:405:f7::12)
 by OS3PR01MB8414.jpnprd01.prod.outlook.com (2603:1096:604:192::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 10:53:48 +0000
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87]) by TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87%5]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 10:53:48 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Planned LAVA maintenance
Thread-Topic: [cip-dev] Planned LAVA maintenance
Thread-Index: AdskuXeAB2qSQwqCRu6Ppi1fWn2KlQAJx9sAABZNqDA=
Date: Wed, 23 Oct 2024 10:53:48 +0000
Message-ID: 
 <TYYPR01MB124027279632760ACDA87F5DFB74D2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
References: <1800DD750A00A2E6.11329@lists.cip-project.org>
 <1800ECC66674D92E.11329@lists.cip-project.org>
In-Reply-To: <1800ECC66674D92E.11329@lists.cip-project.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB12402:EE_|OS3PR01MB8414:EE_
x-ms-office365-filtering-correlation-id: 81f76074-9bb0-43a1-a006-08dcf350f905
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?kZhErxm5Oysh/ZEJy09k/7Axj2qPZw9agG5pG21gL+PfLtRjmJXgQQzC?=
 =?Windows-1252?Q?15RmGfWp1af3qE7JMOJr3zRGufyIIotEpPDGOUZfl4z9Rs/xzdpve1dO?=
 =?Windows-1252?Q?+g5sVrdHqrciFyqIGw4ivJywdGgbtAnxKTvpDjholtkXzxpWQvg5+qrM?=
 =?Windows-1252?Q?n+2zZithzbhOQiq1sf8mCTJjEIqL9Gw8CzxxWe545na4Z0l7Glsu4iUw?=
 =?Windows-1252?Q?TjAx47NVo08ubbr46cfLUmVeUFF/WwKtRvAaO1kZD86Tcd7qk7EwMmcQ?=
 =?Windows-1252?Q?RoAUJSTRc3Ro+ungjPli59H/55L+ae9xZjwXqqrw6BAOORPnfcW4E+U0?=
 =?Windows-1252?Q?0MIesBJJRve/P/4mA16Gs+4A/h/GaUgVKkZ8qeEJYt6dl2fa96+TJCmm?=
 =?Windows-1252?Q?ceQMWfG8Z9KCOurAPHHN5TGZFs2kOQSZ56FpTeb7zBqphJFojC/f6UMn?=
 =?Windows-1252?Q?jveLtbR9LweQO38iQ1k3+O1gRK0wPOSneJsAzE93z8UiDvU6n8jGQDvi?=
 =?Windows-1252?Q?4zjAM/LDze4QwJ3mx7t7q1lvdNUFCR0YDC/NuS1hzU9XYnZoSTvQVXR9?=
 =?Windows-1252?Q?U3iIy3fiN55//+gSDMItA0Xvikf2IKEkeduZatCPp1FliRO/KJDS2k+4?=
 =?Windows-1252?Q?+Xg2VVpmm5u9PX+7HpUZcClec2pzqC8M8q3TXBZMpa3pH9l+qwsCylY+?=
 =?Windows-1252?Q?pl2E6/seiEm8Pu97IFrmzaXjkq/oCAZdwf4rQ74fCUl0ksBxcyxj86wd?=
 =?Windows-1252?Q?wbbwEiqttehFXcP2GA9zatTIhkQDPANAL+Gk9rib+mBvkuLowWYxQ0w3?=
 =?Windows-1252?Q?nLvQKtW1PDNMUI/anIjU8rz1LeUPJACNeUIw64T3+hjEqZGveQlQ3Z/f?=
 =?Windows-1252?Q?VnIt6mE+M4vRkcLgky8cpd15M+zDLVQP7icfSA0inQREXviE8wGeLylL?=
 =?Windows-1252?Q?ouFhiWhPGfNrKf6EF77EPs6i6vLVszZaQBoAJO6M/LwLE8IHD4AZZzSC?=
 =?Windows-1252?Q?mdP03MlRAnGTyHo6AkalqaRWg54PDfGwV4GpXcCMSYYyJPLGLYE7VzWh?=
 =?Windows-1252?Q?K7xhLDzLdOe+oateX1rj2W+OOQzw4ICks7FSxVlU/m91kmeiiXKS4MYo?=
 =?Windows-1252?Q?3ZDC07TJCMofMLcS0p9Ln+hbNPftueK4KLFbBYSYw3itD83fJD/luKKn?=
 =?Windows-1252?Q?iUmmA+4oAS4WDUXcKEPXYMojNSQ8aWtdRpDCGikW+Wc5oh4JiLq3UCnE?=
 =?Windows-1252?Q?DtTtDArPAyL8tN0KkZcObTM83D7B+s/Y4WFw5t3S1UL84AohqRVkhxq5?=
 =?Windows-1252?Q?Q1KmdricxVAaqDQxCh98lJfa+uK4C1fabFeRWpj1K/is4/j1xG6NLPW0?=
 =?Windows-1252?Q?YBFYrXpK0gmgHGGny4XRqNMu9wH0sTal8xyBUyYX5dEvfOtPdKd35ZB/?=
 =?Windows-1252?Q?VZHu4kjN4Lh+17luN7vnqdIWYgdNbMDPiwYuwiVJgXE=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB12402.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?7ZEU3asS/rzEUwlk2PkDr+wMmcCCtwKARN/W7oGxDI7Vy/X/J6sUImzW?=
 =?Windows-1252?Q?dlMEhd3kX9WwsmsQKCFntO/PeqrcnaZPe9hoA+DworCBUxQ4MnTY/y7+?=
 =?Windows-1252?Q?V7wmtRIZBHrZmoSoxcvCocaSG8rl57XDFvPT83ZsQnXk6EtIm016IE81?=
 =?Windows-1252?Q?xsKbxDfwYtwfuahdHpPzF9/3QUmI+Ll7FwrbBshsGux1LIJeG4sgQpKn?=
 =?Windows-1252?Q?90gWvtd6MhPmV3/sHmHPsj6RSvcbrSjuzI5T+Y8n5YtAP7RYXLCcfq0D?=
 =?Windows-1252?Q?uKO5bt222NqW7KRlbHZRGKQQyyJwBuPjJXNaZ0sa+IjL6o62TJEm8Km8?=
 =?Windows-1252?Q?JmiHAjfoRdk8diFLZBdU737mWpBROHrZ6jDIvqjR9xE61/6jE89GhGSV?=
 =?Windows-1252?Q?8kR9lnu09tAy0RBXiILp32m/DfvLtp/xTQxgvM8FNQeqUjrae1Qzqz8E?=
 =?Windows-1252?Q?iKhOxrwUsYOe0ThG4plQ9aMJLFwdUQJAcszV1o/cMEBcTEam2rZiIAcs?=
 =?Windows-1252?Q?e5L1Jc4h2Es4Aj03HeTKylirQsKvadVUEH7kBzf4SZsDk+jLc7LFlIx7?=
 =?Windows-1252?Q?E7POmJuOwYGPckyrZtrcx4g4pNDkhdtGDTankjtPibhv+0d5s957hO5Q?=
 =?Windows-1252?Q?hpPpIZDq7s/2I4uCLhhCnedfMGrGK9h/aGEOfTJYxcZxpRm/1xjalrGa?=
 =?Windows-1252?Q?476CCTvdA23j22VomIsoKkSgcT9nuMpuHpOLUlqMdT0kDIPSxHqsLrJp?=
 =?Windows-1252?Q?opoU1SA6XdnqmenG/9tdJcYJ8jwQ8uXah1/GriFhpkrv+c0gTPHFLMUp?=
 =?Windows-1252?Q?ig4ywm0Bkds+XJdsU4tfOxE0JmXp6H8wAfPjkAYv8tvIM5c4uQZQ3UAn?=
 =?Windows-1252?Q?6U7AxEPTGx+I8KlAXfm/EhTynA4wE7FG1UlXD5d6Mis4tqqAlGL6TEr5?=
 =?Windows-1252?Q?XRjTh5gYvq4SUfXFBZjxkCmiHcqpgeydn8wMH58FBw1tVbPLOtl/zbak?=
 =?Windows-1252?Q?ho+eah/Jw8hHV9r3Sp9I29OJ+NwUPTzmL24dtUBmeAhotGNZeXLUedBH?=
 =?Windows-1252?Q?ldYlHaW6z7xqSpt6gu9R/eiEuR2NwlmviBU+5Y40mI9lbVVo5UXMvlsP?=
 =?Windows-1252?Q?rhuBieGGurzXoMhBhMu4iTXMVZql1Tdd/ErJAE+3b/LI9aDmgVZzt9qy?=
 =?Windows-1252?Q?6Gr7HLN2EWa5fThFjZd4KRJyzF1YhZtSSK1Il+udztB2I7FXpFXgUm/U?=
 =?Windows-1252?Q?wcc9EU+C+iyiKKqcPfFpKBioebqIBon496wZm8gMNmqCdzUbrPb9z9uW?=
 =?Windows-1252?Q?AK9Oojh0RSlWG8Z884Oixz0iX90THGsx2h20FWPNiXR2FOY3/xAVowua?=
 =?Windows-1252?Q?q1bLs/UsTNW4rK8XZhSK7zLlf8f7ADHTOucym/jnf366ZAmEcjqCHCRF?=
 =?Windows-1252?Q?wQgdaK+nAklg0FfzaU8WRXrH29DF1pRgvOnE0cxE+8Yn/sBQGcVZUqkw?=
 =?Windows-1252?Q?Bx31+lWe2gZkOj2moGwptPFZwaG192Kc5/N7eqzAKs9yh5z2gkIFMNVz?=
 =?Windows-1252?Q?a/KgFEPjGb3O5Ett61on3X6MxgOoVurP0glLhoGQ1Gel+47l03wF9T9W?=
 =?Windows-1252?Q?pa+rUtJBanE02kxoupoYmaqRWZyLpvkT5WcgU6NftC4ljM1MtwPOAure?=
 =?Windows-1252?Q?mQ80vpOfx1Xt79TSEVPohO/fcauFa0GBI4z9f/ZXE4UeI1r4d8mTlw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB12402.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f76074-9bb0-43a1-a006-08dcf350f905
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 10:53:48.0462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cuQkmouMBeMusiKNrAhBBKfOjefNk3HtbbUe35DXLySZULIfbR49WyGckEBRHOmi+1GAUxfyGiTPBYxU5S5Fyj4Exq5UaCikpDd1rt7R2Kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8414
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Oct 2024 10:54:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17073

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 23 October 2024 01:16
>=20
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Chris Paterson via lists.cip-project.org
> > Sent: 22 October 2024 20:36
> >
> > Hi all,
> >
> > The CIP LAVA instance will be going offline for some planned maintenanc=
e
> > within the next couple of hours, for 30 minutes or so.
>=20
> Upgrade is complete, although it wasn't as smooth as I would have liked.
>=20
> On a side note, lab-cip-renesas is currently offline due to a local
> network upgrade that also hasn't been flawless.
> Hopefully, it will be restored tomorrow.

Fixed


