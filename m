Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD978CAC5B0
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 07:01:54 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.57])
 by mx.groups.io with SMTP id smtpd.web11.3165.1759388505653732103
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Oct 2025 00:01:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=ZxutT+aG;
 spf=pass (domain: renesas.com, ip: 52.101.229.57, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTs9R2yw+3Zha1mkRuNOhSZr3cITe0jL7B1eHNOJRaxPmxrVNo1waPB20Vri4qmgyE7E8NAPxhPdrlEByoR2ecNPpqgioM+evpT+ZU+1SqxtGm37IIvSGX7N5Gqs4W2mmB3ZmHDvxEW9qZb61pjhtnylKynhnuszupYLvmY/qldN8a7Wz+LjiMVnPEw/GI9PHbgwSakJyKFu42FZs4HGY3yEwL5cRz9ijBPucJw9nvsEXaDL3DGlweWZVZa8EpBcGoyngGRP5ZpE90/pm60qRxdyUq8ZSQfSnTwLUgfz52jK2HNnQr8Mr4cHNHyBEUK9NiDD7s2Eh0JAWyunumBxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnv4qp3Kmi55sqQF7qbu6DEh2FisfMD7Yo6DBFrSUgM=;
 b=R7foLMcXZ9tYL3HF58MjI6a5KTVQ6NwvjpBadAn5K2iMlnkOOe6LLAQmz0Aa5cXJqy+0bgwsmq9eiXYr2NLAy0lPYIAGStA6iSjkfizBvhvW2honII9rTgad250lLxZt4B97PQ8cC9C2O3L+qxlTYglH8cQsMzprAU346yS5cyk8Qot9SkBi5ULU5tNd2UNSbhgZyp9esUNxeXUqElwZIR1E0Vx9jxcVgySZDNr+9Vz3a0TOo8PmnmQ/A8RiKjqyHczZHjDIaQOFL4gBTa0WuBU9g2P6mA8om6kDJ3OQKa1KHn3iX7Rq344Ar9bX632u9/u5phgJl9MMYF0h7xuvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnv4qp3Kmi55sqQF7qbu6DEh2FisfMD7Yo6DBFrSUgM=;
 b=ZxutT+aGJA2Ownis0qGxoYCGk6/+D5Z+ur2hyIFu4HhnvHmlwEQceMAoRXB7CwnwTL9BEBWvFuUqDLbHbMqVRYKjA9/aaGPvw/yVk33CwDPBpFulU1osFqH6b608vJzF4kt+Sb/oENsT8w91FeQjfU2X17fAWpMTrSPmVSpisBI=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by OSZPR01MB6694.jpnprd01.prod.outlook.com
 (2603:1096:604:110::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 07:01:41 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%2]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 07:01:35 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: cip-dev <cip-dev@lists.cip-project.org>
CC: "Nieddu, Pasquale" <pasquale.nieddu@siemens.com>, Hiraku Toyooka
	<hiraku.toyooka@cybertrust.co.jp>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>, Gylstorff Quirin
	<quirin.gylstorff@siemens.com>
Subject: LAVA server downtime for maintenance
Thread-Topic: LAVA server downtime for maintenance
Thread-Index: AdwzacbopE60FdCIQySfni/uDU6DQw==
Date: Thu, 2 Oct 2025 07:01:35 +0000
Message-ID: 
 <TYYPR01MB151326444710FE1D5826ED215B7E7A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|OSZPR01MB6694:EE_
x-ms-office365-filtering-correlation-id: 5c5e0486-676a-435c-38ef-08de018186e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?IpIfq3ZYX5yTIJXy/p022KbXSR5c9uaEEnYOXW9lRi4yX9s5RPvz8x9h6b?=
 =?iso-8859-1?Q?Lkyt+y1LLxDuUS6erlkdyq5ZErSmXteJd04PcOmXfB38HkAhZicXni/4BQ?=
 =?iso-8859-1?Q?YOkhbvAKp48FhX7VqobIuP1p95RcSlY9+ZWrxRPTue3JJWY1EE0XYXP5kj?=
 =?iso-8859-1?Q?qF5DdEbeZQLEgw9Qy2GuCMgLrs+/BmJ5Zo1cNNf+lkj9r34cfDy2HbfPLH?=
 =?iso-8859-1?Q?yxcOUuf9RbdOfTI60uczlSLR1QYYmNSdTaBEMUJ97/TFILYH719nUYztMV?=
 =?iso-8859-1?Q?dJ1qODLES4bZp+u28w0xNNxsiDFeLZDmkejfVMUDuGqDUooU5ETUMcIYyt?=
 =?iso-8859-1?Q?gFKfhAi+AXlkXMZfMcASGtl3wcijJSJTmlB10hwj+GN1qqir5kmWjcbv1e?=
 =?iso-8859-1?Q?zXOU4+Rhgc3DFmYrR0hD4jQU30XhIKIDyTXiBiI+xb9UBOwKpNoF5aJ6E9?=
 =?iso-8859-1?Q?fJMNr7kgpnNbGEJZ+992xqmL+TeQV5Q909cc5c46FM41myPrs4Bd+ipsqE?=
 =?iso-8859-1?Q?+QW3+0z6H5h29fIxGLIoiAQQaw04Kt2IMdqcupEQek5T0+a+t4O3sAnyGD?=
 =?iso-8859-1?Q?7Y3mc8Af4qIcQl0GSRp+RDLcQp73zrCIYRn0YFccT2yJnz5HIJvBxpJwpQ?=
 =?iso-8859-1?Q?G/XvNDQ2pEuH0T3+aV5qP0CNbGY6HvLICtBSwB+rDGnKzCGOTjnuH/boXz?=
 =?iso-8859-1?Q?0D/Bg85hv85NcBM5wOsbOgIOhsl80TkpG5Pr3PAcTMMcB0cHs0TNmo+dsE?=
 =?iso-8859-1?Q?6CudDAeGZoB66i+AI1MJPv39+MjOqCbxMnf7gp4CiBN9ORgE/ljjp9o0E+?=
 =?iso-8859-1?Q?8Bd5HScHFJlxR6aKsVmP5oRwMDgdWda8HtgV+nc+Nr8GUfH1rpV+CaISPU?=
 =?iso-8859-1?Q?WajEs0D6KWr5yI2lH1rn01YZrd1rSiiZfkQy2M7jdz/Cwvd6peoyk78BEk?=
 =?iso-8859-1?Q?lrNN6qh9Zz9i5j1GYn5i2IEBy8a/5LGSLYbB8rLNPuBM86Cwi2DX9YNygB?=
 =?iso-8859-1?Q?4IWJkA/bfLIuMF/5vn2gdzdMy3ysl3mQeTF0obIPYzh3F6bu1gMyW+d/j+?=
 =?iso-8859-1?Q?X+/w+BpqTf7Ptp8K0oeb5dWEzrq25/fEe/EVFuKhnSZKmDM6ccLuNDuI2P?=
 =?iso-8859-1?Q?XxytGX6xpEkVlRozj9NuAs8NhK2gkF5dhZqloYlyoJCAHT/+BeB0iPMjFD?=
 =?iso-8859-1?Q?tocCS2dERRWHO0xECtdszAwvQhMDcFj7Jsi2x5k5Bd3xgU1yd77QjhIP6y?=
 =?iso-8859-1?Q?kFdHEsnd/WVmw4+QRjwSw3LujBRGNPl78qrTK5anLoDMzvMUoM2AiKsKLw?=
 =?iso-8859-1?Q?wTATjbFj8qZH2yUe1vNawxMhK6XOhWVvBzNPhL7sxLxGpspjUmuM+uYSf4?=
 =?iso-8859-1?Q?8GL8P4OOOwvNtSv5sy3jW1w31zZATkDVjvaxECfhehqY8oBpQp1QDMnrFu?=
 =?iso-8859-1?Q?QMqfGUwSqWmWhC//R/wPfFUwUAoHTcM72XNemuOMvrvM8pgffYw6wz5dor?=
 =?iso-8859-1?Q?HNZf63cdsAiCEmIZsIAlfVoBbGaNZOrp1A1K9c9f20aAeiQ5kR+h/VGxgX?=
 =?iso-8859-1?Q?fiHqRs8J7hVedxr1BYStaSMUqCog?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?2h8yg4E0i+Cc062UgRG/rtLglaB3bMMl/NowBrD1dyCcTKHSm1ohqihR0V?=
 =?iso-8859-1?Q?lQFb0NEOvCfJ/fq79x/mGJj5Bf97X92yeN41keSamaWWuYTsvTItdkgs6t?=
 =?iso-8859-1?Q?mDela16B/ysOUCS64WekKzQ6Fq5oEmDQ/5eL9Ff+6KjfjHVU5IgpZ7vUpR?=
 =?iso-8859-1?Q?M0EGtFLXW2a7FjDGUUKtckVIb94YLjIjOBhEJJA8q/FCJsmTyifSrYds4I?=
 =?iso-8859-1?Q?emZtdRVlWgxaOtL4E83Udaxm9Ru1U1d2jUNAZcc7+kYfwDxXuF4jzGkMPo?=
 =?iso-8859-1?Q?o7h+b3hqDyBnpcjauX9SkgRVGfYIjqTPV8EzCweWQVW85m4nsZxzuwkPNc?=
 =?iso-8859-1?Q?UiG6EGmIVgLP+NsD2x872oA9IEPoBWtJF2Pd1MNC0y0YPZxGA5b2Q/3uwM?=
 =?iso-8859-1?Q?XmWSczr+MK/TZZyPfReOfZOJUmsAFrfDs3kMyh00j2NhiIii2FbpIZHMti?=
 =?iso-8859-1?Q?EJdLYT4cGGpNvZUak6zFWzFtJl8GfrgpxW4wDcRD7WkaV8KaJddkYJba+9?=
 =?iso-8859-1?Q?5BvQsrq/nCdiAXv8d0fD4JgbzrBEXPmgWjzI4jH9NFdFJdBWIpSeBBYh6+?=
 =?iso-8859-1?Q?8fNt7vBYI030llwdYTXTOalPKPmNsW7bGDZyWyeBCoo6pCOrqzV7y0oprj?=
 =?iso-8859-1?Q?r/h0tImovhYPSh78DZ8FauLMfeSZ5IEaQ1ultDqUv5qnxW6SvtRFpW1WiW?=
 =?iso-8859-1?Q?Xrb+ZRebchlHaWcdNB1M/szkJnFEaZLLFGvIN87qESBV0vp0U+wekS16/Z?=
 =?iso-8859-1?Q?YLvouPJwGPLZllGXq4edWsI+VEdnpIG0hS7M0tjRZ4p9uQzgSKj21Z8bDk?=
 =?iso-8859-1?Q?VZp47XKzRjBeQx/yD7yvtiNYEY29W6TuRWRYyFcHWubXSrtynKKnvByMIu?=
 =?iso-8859-1?Q?njHtbmcmn2ne/wDJY+YM+rCunjbppbUdpGuebIJEhoDr1AufNCkEjAys7t?=
 =?iso-8859-1?Q?US5WtKPpdGAVdfXprKJy/QwjVnHWiwCmROt/aJnj6IIRWBw2xVXyoq7Hln?=
 =?iso-8859-1?Q?12LLynoBFnZjqZQjl9g94bTebn5kq8bAFICIliNQTIlvlLPBFssTATar3L?=
 =?iso-8859-1?Q?U9i9YRG4JLXVxli+IadyZ40DUs4EyXmgyhCiYt0RIW/ebeI5zhs90OHr9A?=
 =?iso-8859-1?Q?LjXqstA1AkRwi+X2Zbwkd38D6pGipyAG0otbiPwjw7B6YH/Aq5SnsYRbkQ?=
 =?iso-8859-1?Q?RI5v6RAuTDrs8ZPXg6grUaIfDQwUur/XseenbtS0tdCIP9GLG2sHhIX7Yp?=
 =?iso-8859-1?Q?T6EsOHMs0gbCyXlRSU15uMHs/ES6sCytZAEpDPMV2CevN35SvML9Cx8Wnk?=
 =?iso-8859-1?Q?robaTL7rwZfhFih6AjLrihH//XNXdF/g7RtseGL99oGMDxiT8AV3MWp+nL?=
 =?iso-8859-1?Q?MD4gcNGZgBR+5B2Y/BN1P12YCQjjOLFlUpQQLlrVy0EEodx9v9LZhLDeY8?=
 =?iso-8859-1?Q?xp6Rk0fvrzN7UEdjfHlf4wPZr1waF1v/U5AriGwpUZrMuuO9aNOtOgnOsJ?=
 =?iso-8859-1?Q?MM8HenZlCamUpNAmpnpeh07WPh6YVpy6ENz/UaTlynYkSjlZ6eoz3P+sjd?=
 =?iso-8859-1?Q?ismXBE4CT55KuzXVddMFjVel7/Qm5sBy2jxik0BBUoIQhB6qNQBzK8bnfJ?=
 =?iso-8859-1?Q?TKBr9to14PE6qOaDFpekFBQAYhCI0IrOSAgyd/5Sae618xrHxeHKJexA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5e0486-676a-435c-38ef-08de018186e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 07:01:35.8804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Po9HrWWjQDH7X3qDcBxmHJPGIvD1wkQRemCZv2K4n2/ji6zlU+/N/ctatJ5zGDERSYLZcwDSh5XQ4oUJsmpsYRpf0JANQhsxKruZbgPkDCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6694
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Oct 2025 07:01:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20155

Hello all,

The CIP LAVA server will go offline later today for some scheduled maintena=
nce.
It will go offline approximately 2000 - 2200 UTC.

Once the LAVA server is back online the LAVA labs may need to be manually r=
econnected.
This may take a bit longer due to timezone differences etc.

Apologies for the inconvenience.

Kind regards, Chris


