Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E2DCCD194
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 11:22:52 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.50])
 by mx.groups.io with SMTP id smtpd.web10.5675.1760613761584883023
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Oct 2025 04:22:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=YR9feDsJ;
 spf=pass (domain: siemens.com, ip: 40.107.162.50, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiioguzplGjZ38d0O4EzJLuLykIPGfdsIoxto6CWFYku+YJzgKfZnI6UNvC95fdGFllrbQ0A9vRtlKUL7oP/NhQua7ACmQxY7Rdum+fokP4BexFqTq7l3LY2Ss6RZZ8CzKy4i6L7ZmJxLhDpzB/6/BqwPtmYIdwhvTLgXAs7zIC0M/uHfLOPo+jP7gqfjBqH4h8ZbKrmBAH4hJN23HoiYp2UXiiDw9chbkGYCWBltiaueIVlLL78H+hIVILFgsvhp8oCV/3vaU5WtnVBrpvk1t0VPSpmONFWhIKBzEkkjFQYDL6wjXilOV9fse0EsKAxDCJD/Xpym0jNTn+h/hKR5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9MDvY1jDumudYct1EVVnLivn+VVWI0RIVyW8DN7shQ=;
 b=PH4wg44jG4D5le/9V8BMr7dlAqhjJQq1DKEGi+OE+74esqxMNOqHsWelgi7KPtSU12jTtCY0z+Ujy8mZGmFTVEZTix2+fvYPCpWVUYZrRiH5ajqlkkvnd9VEcx2cSszCsJ+fSv7XRq0uwaYrxgptAE4aXX9xVyUWL8lY4LTkK+3TTTgDpfDjRtKNgeA1/VZu3Jj9gHVUPNw0BozKS24V20/zfmFh/c2Zw394Hgey4vlIzuXc+bM1lhYqd3o7SL3q+IVSCwLcGj0EvCwypdJztQdpkPCR1venkNjlJhdr6U9vnrgxm/MMsk7niLH7kUzEVT20tDqiti+jzUohir9u4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9MDvY1jDumudYct1EVVnLivn+VVWI0RIVyW8DN7shQ=;
 b=YR9feDsJoVhEKNbwH9TJeMnyCykQjZmGG320+KhfzojMvF05XjL/dl51BHaoDljIv7NlQEiRHU7CcQNYwUqclVV8jFEA2YUbE2iN4z4nBiOe4o2zkpTKwdyG4H8QtfUKYdqnwEWqsq3l9QD2PoeIpy9ZzhID4EjGBdGUthA6eVP2BF84fjQMnsHpijYykERnC044j3N+wc2te0fZJ+FYzqIFCjfWm2ou8urPDrqXQ5Q4btD9BoqqXYz33saTvOjQuvlgIuiikv7N80OlbZ61sMjh0N5ZHFlluf/rBXYk/Od8QQvvwD7GksclcLYTguFvPtnWUfk+Tbwf1xNOiBFzcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::6)
 by AS4PR10MB6135.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:586::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 11:22:37 +0000
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a]) by AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a%7]) with mapi id 15.20.9228.009; Thu, 16 Oct 2025
 11:22:37 +0000
Message-ID: <0116457c-5409-49cd-a077-e5bc696a5e21@siemens.com>
Date: Thu, 16 Oct 2025 13:22:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
To: Shivanand.Kunijadar@toshiba-tsip.com, jan.kiszka@siemens.com,
 Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com, dinesh.kumar@toshiba-tsip.com,
 nobuhiro.iwamatsu.x90@mail.toshiba
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <c8e57ef0-6f4f-481a-9e36-214f44fffb5f@siemens.com>
 <d196dbf9-7c3f-421b-a80c-2d39cfb6e27c@siemens.com>
 <TY3PR01MB110754E7268909F7468881081C71BA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <638abd24-8fc6-4fee-9bf4-679b51c936a3@siemens.com>
 <dcc32fbe-2b53-40de-aca3-0bb0e9bdf481@siemens.com>
 <232ddcae-a297-4e7d-9898-f34edd3671f1@siemens.com>
 <TYWPR01MB110639A5228DE9FB8CAC93E4EC7EBA@TYWPR01MB11063.jpnprd01.prod.outlook.com>
 <0f2a5909-4746-452a-8f39-187eaa9e3cd1@siemens.com>
 <6fc52da1-ce17-412a-85b0-8e36187ed56e@siemens.com>
 <8bf58a7b-cea2-480f-bec6-bcba41d450dd@siemens.com>
 <TYCPR01MB96696580C7FDEB7E0CDC3782C4E8A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <ce936062-26d5-4bee-8eb4-e2eadd1a37d0@siemens.com>
 <160719b2-7915-48e3-9e63-eb08fa9d5c6b@siemens.com>
 <TY3PR01MB11075F1040D50FD87E26D929FC7E9A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <TY3PR01MB11075F1040D50FD87E26D929FC7E9A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4PR09CA0023.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::13) To AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:525::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB6023:EE_|AS4PR10MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8733a4-9c2d-452a-81af-08de0ca64fa1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?RNePw2vK4UoNjHpFCm1vJMSLCaDSH08MBpZFNeMur8Dj5aD+Zuu5YhwT8c7p?=
 =?us-ascii?Q?Gta1YRSn2wy31hoJOulX336uu2QCJX7LGlpm4cIc53V1Mf8bRrU3aAqs2hlF?=
 =?us-ascii?Q?XfQV/7mp6y9wXpetfUYYTXab7BQ8apBuR6GObllSJW+NejI9NatkVmTDDjNa?=
 =?us-ascii?Q?rl2lg4LATH+EjoqCtFjXWKsqK/ze2DwShfL067AUOeUkNh5zan5zgey4iPxo?=
 =?us-ascii?Q?S36GQJjKcVuxzIGxCZsthfQMHEpNyoYPDJjZqDhD6P+Z5hV81K1t+FFQYb2j?=
 =?us-ascii?Q?ZCPTyrYr9whTvFXiluEZo7IcE7gFPOmFfUxfNnAxfYJ2hSRhJB47Gxw0w3IA?=
 =?us-ascii?Q?144T5bU//Ri5ZD1HLvqlwx80/ScxZH8Tpt/i9DmNXO6lYMdpt9ZnuWsjmn0G?=
 =?us-ascii?Q?/sKOdKYuzNev9sbvA/1c8uinL5lC4jx0jQF/sB8abrGI2iRz3Ptt2BRC3OAP?=
 =?us-ascii?Q?AkYyWslfM4O3Hg7XMudRcHggPh7DyxsgZo39i+7Vqc2sOZ61J52y62DPY93P?=
 =?us-ascii?Q?YqjMZ/VdCTuAfGVJE9weZ8bLerv75Pjm2cy1HIabaZxPvQYrHGIYjUDtTuz3?=
 =?us-ascii?Q?uE5+nJgEqxgzFGih9XNIUt0BmpaKN5WAbZjNzAvBHQiL4uDPX7kOxgo7qxzC?=
 =?us-ascii?Q?JgHAOcBPcEtTWRdsHhQe9L+gL18umRGDm+hc1ToRoIbwQJzBP/iodppnl3et?=
 =?us-ascii?Q?0ZZr1WfNxc+sYbg04812KvOO1VVidKXMLvpz3uf3RLBKm2/NtHWL85/VUMks?=
 =?us-ascii?Q?vdj16Zfu17Id5eYaA7sy6NMy6SfMGagTw7JWfnbMLyaNM49oZ3PNfdg8ePRQ?=
 =?us-ascii?Q?cOcX+b29nVWq4M3h9DOTHOVSnPdtO2NSZLIskaVfB/AFDp8HFs7aIrnW/hHb?=
 =?us-ascii?Q?sZGuoGfIzNavL7qu/zAMduOXFmwKMci2noRjVUY+Hn6vethCUFuFZFrDF7Ua?=
 =?us-ascii?Q?MuhcS5ZZFXPjoNR2JN0XvXHzxF9H7zoirfW+RLKF4lJDYgSGSNjn+XM1hAr/?=
 =?us-ascii?Q?6HydAxaN2V1z5Llpzis/1Nb+GLK7tLdhBbE6y51H+ff1wr05KXtkVRHminq6?=
 =?us-ascii?Q?X8kjMDe+QK4QvCELVqXTZ0pQQXxTbhTsxZBpNNJ2xUha7ulLg0aP2ESjyGVt?=
 =?us-ascii?Q?3h3wId3Z+IzQJRXf2HSEePMQ03ui56kHNUMaR3NnyZdC3+UQnV5pHuHOe+kU?=
 =?us-ascii?Q?HH0Yru0CvnWqkkTjC0J2qkI45w2etSZ5JzXjpLsL5vlFhgVi0gS3ORwH/aP8?=
 =?us-ascii?Q?p9wggRGoupZuLmXmqtQ7DBhDGFkMnMSVlPQmfPiDgAzOyw9wAb2ekwILHMM3?=
 =?us-ascii?Q?HrsirPVwxt9x+vdnnUPIY1cECVvxfxN2Drs3ICBiVWG85JQQBn/0J2s4chzd?=
 =?us-ascii?Q?O71VGvJ01NBkZUEJiMvprimjF3Mh7gWowSzW1Q6tlD1NyUcLzg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uI0IYNYuqSc29K3hm6DVlmQHjQ8MXu/KpIZizdomPWa0CqwqWYUJ20BY/v28?=
 =?us-ascii?Q?09DjMZ/evcCiEJqbe9K3oPMT+UgRXU9PUXRfbnrPgF5oRDC1rYIrqR04w1yt?=
 =?us-ascii?Q?JugQ/hTRj0++UcbgDZpvVfGrLbq4lLpwC6UOGOer8K9ElzeU1MoQqCyOERAy?=
 =?us-ascii?Q?VPxHBuMfkC3JhkDPLD2Xs9IUnW/Whb1rkWgX/zNWXG1GdXIicIQgE5yKgGq+?=
 =?us-ascii?Q?puE16JZP8sfMktkSEeF2BrW+5YrEEjmvX/98NduuPC3XEqgUsF6ljnMpBlWi?=
 =?us-ascii?Q?aPkwkpL0LBTE0+elUNlHdrlQKbem7wpbWBbw5FCwhjsYXBKDkHTZRM2LYDOM?=
 =?us-ascii?Q?ls9VX3jTOuD9sGmJ2ZboPQk4BFzu02MyF8sY0UkgPKJy+3a/he2IUVRgdNn3?=
 =?us-ascii?Q?STqjdKT1tdQodAMTSpXwidmWEUhbTbRBWSHwHRUy1f33jDAfToYfCfYxcCbJ?=
 =?us-ascii?Q?+xaCbD4TejSGTrV1dvAD8EKBH3Kh6eiuxpWqZs2OGYHTEOPVb+cMZ8NkAbv9?=
 =?us-ascii?Q?Y8L8tQW2xcuLNGrv+50V6zzdqei05Fq2VJwxXQCl0DylVQ0DDUF/817/X/xn?=
 =?us-ascii?Q?wVpakfU18rcQnOnih8bmC2LTWBgWy9CeziKt259EMU0z2Vnt6PTQnw67s3V0?=
 =?us-ascii?Q?qA/wdAQXGKlFEUivDdKl7BvXfsRy8gb9+F9JPGCZK4adKzNaBkUyEUq5m08o?=
 =?us-ascii?Q?/n9+e16NzXpkXLOS1RodwyH3KkbJJcPc+XL1TgKW3phcVWGJhEUWJy1m8gk+?=
 =?us-ascii?Q?ZwWdI2xSRp8cfIMKAvqeu1NTrBkD8qeCpSsSXXjleteF3TEwOn09NBf8iOLW?=
 =?us-ascii?Q?izBJ+Gp3Kv2EfTMESLqtmEVJNBJtEverbX/CUHZ7EDrCLQXFgkm/C6DMwLD+?=
 =?us-ascii?Q?iqzA7EK+cgHXJT4Cbvj7AiUk5PKblt50mhGvoOz+YXn/JC2H52FBzf49zAkI?=
 =?us-ascii?Q?UoKN0ANCw5tMFYXkmdaFv7vc464zd6TmyUbINqYzfTK+EGrIpSb0kRJHNsNu?=
 =?us-ascii?Q?xMosQViWE5ifRGZ+uB0480lTf6ohxicjiDY6SCsvcbeJpz/0kTtHcuFx6XKN?=
 =?us-ascii?Q?TZPDYePwi3kjRrjs67H/hu37RDD3Mc3Kn8sLXQCD8crs45lU/q8WrPVdoI2b?=
 =?us-ascii?Q?e6XIiOKoYgh8vsKnCouVC2PXgCRr2nQzq2TCpXuXekAF2rzvY0nB9CkTmKsf?=
 =?us-ascii?Q?mG5qt6FI/7xwKL4Ra8usVzc5J+F+f9Vryvf6IBwCfbb07og04B+IGX9wNi5j?=
 =?us-ascii?Q?f5tqzMc5JsBoT4fggHJhulCWNioOOqIL+Ir9XbiANOOgpCNOYIzvhRYUKzNB?=
 =?us-ascii?Q?2wrugYp6n6VMc33c3dwHPl9c+wKaMxqLw7g6ukHncitf1PLJCsCo7YkQvZ0P?=
 =?us-ascii?Q?ov5bG1aaXVziuhlmnFg8hyqjSCyPA27TQnqJBJi2CkeRYM+Cl/dM22M+CT6S?=
 =?us-ascii?Q?7FYrSua8aQ7PYKbXSIZE8cnYigM1QW8TogSv5dBHEWZQ3tm/IDtdDBlDeoPB?=
 =?us-ascii?Q?qrxodIRU+NNKXuHkSv5UUQTUjy+XCQmqP4OIKybTkGUnORGpdV5MjgjLgQOc?=
 =?us-ascii?Q?woeR7n6Is1Qj6MD8C2DJX9zfrBkjEFcOS5cCkivHo5KG7Ca0A8NEzcn7EIe6?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8733a4-9c2d-452a-81af-08de0ca64fa1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 11:22:37.5180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+0XR6O0RutKU2Om6xS3oQOKS712Th2GwBfXAv0l/ezYvxYC2YG2ysRhPkIdPniG/jEf2syrK5lR/WR15xNxBDHednH7ck5MOKCrpAhXQgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6135
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Oct 2025 11:22:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20186

Hi,

On 10/16/25 11:16, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi,
>=20
>> the test case completed (without timeout issue) successfully on Sept 22n=
d, after that all IEC tests which are submitted on M-COM are incomplete (ti=
meout issue).
>=20
> In a test branch, I reset the commit to the Sep 22nd version, which was t=
he last point where the test case passed successfully, triggered the pipeli=
ne[1] and completed the test execution.
> It look 54mins[2] and 1hr 6mins [3] to complete overall IEC LAVA test job=
. Please note the kernel version is 6.1.148-cip45.
>=20
>> We updated the kernel afterwards (Sept 22nd) e.g. Also some Debian packa=
ge update
>> could have brought a relevant change.
Thanks for testing the old version. I have set the device into=20
maintenance to test some stuff.

 From my initial look, the execution of ssh-keygen is the main blocking=20
task.

Quirin >
> Need to check more details on above.
>=20
> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/210=
0642715
> [2] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/11734979=
045
> [3] https://lava.ciplatform.org/scheduler/job/1317014 -> Re-submitted man=
ually.
>=20
> Thanks & Regards
> Shivanand K
>=20
> -----Original Message-----
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> Sent: 15 October 2025 15:46
> To: Jan Kiszka <jan.kiszka@siemens.com>; balakumar adithya(=EF=BC=B4=EF=
=BC=B3=EF=BC=A9=EF=BC=B0 =EF=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=EF=BC=BF=EF=
=BC=A4=EF=BC=A9=EF=BC=B4-=EF=BC=AF=EF=BC=B3=EF=BC=B4) <Adithya.Balakumar@to=
shiba-tsip.com>; kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 D=
ITC_DIT-OST) <Shivanand.Kunijadar@toshiba-tsip.com>; cip-dev@lists.cip-proj=
ect.org; Chris.Paterson2@renesas.com; dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=
=A9=EF=BC=B0 DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com>; iwamatsu nobuhi=
ro(=E5=B2=A9=E6=9D=BE =E4=BF=A1=E6=B4=8B =E2=96=A1=EF=BC=A4=EF=BC=A9=EF=BC=
=B4=EF=BC=A3=E2=97=8B=EF=BC=A3=EF=BC=B0=EF=BC=B4) <nobuhiro.iwamatsu.x90@ma=
il.toshiba>
> Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
>=20
> Hi,
>=20
> On 10/15/25 12:08, Jan Kiszka wrote:
>> On 15.10.25 10:53, Adithya.Balakumar@toshiba-tsip.com wrote:
>>> Hi Jan,
>>>
>>> Sorry to jump in here.
>>>
>>>> We may have a kernel configuration issue here - or a real CIP kernel
>>>> regression. Going back a month to a passing test, we got this back the=
n:
>>>
>=20
> these are the modules the debian kernel has loaded initially:
> crc64                  20480  1 crc64_rocksoft
> crc_t10dif             20480  1 t10_pi
> crct10dif_generic      16384  0
> mmc_block              57344  0
> ahci                   49152  0
> libahci                49152  1 ahci
> sdhci_pci              81920  0
> xhci_pci               24576  0
> crct10dif_pclmul       16384  1
> crct10dif_common       16384  3
> crct10dif_generic,crc_t10dif,crct10dif_pclmul
> cqhci                  32768  1 sdhci_pci
> i2c_kempld             16384  0
> xhci_hcd              315392  1 xhci_pci
> gpio_kempld            16384  0
> libata                401408  2 libahci,ahci
> crc32_pclmul           16384  0
> igb                   270336  0
> sdhci                  81920  1 sdhci_pci
> usbcore               348160  4 xhci_hcd,usb_storage,xhci_pci,uas
> i2c_i801               36864  0
> kempld_core            16384  2 gpio_kempld,i2c_kempld
> i2c_algo_bit           16384  1 igb
> scsi_mod              286720  5 sd_mod,usb_storage,uas,libata,sg
> crc32c_intel           24576  5
> lpc_ich                28672  0
> mmc_core              217088  4 sdhci,cqhci,mmc_block,sdhci_pci
> i2c_smbus              20480  1 i2c_i801
> usb_common             16384  2 xhci_hcd,usbcore
> dca                    16384  1 igb
> video                  65536  0
> scsi_common            16384  5 scsi_mod,usb_storage,uas,libata,sg
> fan                    20480  0
> wmi                    36864  1 video
> i2c_scmi               20480  0
>=20
> See also https://lava.ciplatform.org/scheduler/job/1316606#L1301.
>=20
> Quirin
>=20
>=20
>>>> "The time taken to execute TC_CR1.9_1 is 28 seconds" [3]
>>>
>>>> [3] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/
>>> jobs/11344068159#L1724 <https://gitlab.com/cip-project/cip-core/isar-
>>> cip-core/-/jobs/11344068159#L1724>
>>>
>>> What you are referring to in [3] is a qemu-amd64-IEC job (not M-COM).
>>> QEMU IEC test jobs have always been quicker and are even now.
>>>
>>>> "The time taken to execute TC_CR1.9_1 is 28 seconds" [3]
>>>
>>> As far as I recall, I don't remember the IEC tests run this quick on
>>> the LAVA M-COM. Apologies if I am mistaken.
>>>
>>
>> Right, I looked at the wrong log:
>>
>> "The time taken to execute TC_CR1.9_1 is 304 seconds"
>> (https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/11344068
>> 162)
>>
>> Still a bit faster than it is now (448 s).
>>
>> Jan
>>
>=20
>=20


