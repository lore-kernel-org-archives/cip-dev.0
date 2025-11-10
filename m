Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DF0CCFA1A
	for <webhook@archiver.kernel.org>; Mon, 10 Nov 2025 06:53:22 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42616.1762757597729787074
 for <cip-dev@lists.cip-project.org>;
 Sun, 09 Nov 2025 22:53:18 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=c57JlZNI;
 spf=pass (domain: siemens.com, ip: 52.101.84.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHcDTl0xJIRVbgtnrZ9crmz/Zz4evwxGTG7Hsff+E2L8cKJk+baTIsVUt4XyFjZ9EamsPyjbcOexr3RChb6rFULM+gUEstK9gml182loaw/eatM7zDz8DiewZejY0ZANv7++42zZLVloD5r0PTDZvcXKpdY0oLvoOqliPdtw7iBgzdrJaCE7wKQSNkC57OkMc7BINkPCz3M2c4UI/w5BTXA+mRT0p1yil3oqkrOzc2p/4F2iiuhmXdotjyrZN85uXP8/v+45+kDJz+znGIIPqLW0ymOhIB5EL5jxUUkrUVs30Cmpc0GKPS77V9AM4XN597ws01DSqiiv1XvAeTrGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCn4/vaKJ0xUH72lSdJ1OnkggKCWMgzLNkeKmr+Xdv4=;
 b=d2jbgs6iEqLRYTfdYikIs3J1bW3yYhewx+KolcN5xZxPDT9VzvS+eLDtQfqGuIp+m52YKQCg3up3G8xCAr6xVU9S2aA+1vkjztMl4+2JlP9LPiJKwsnu1CBemT9By6+8DSgXXvNc57+Hf8/A+dQPwvv/r8AvCPxeF2vFMdlQ207dFWx1hUXBwOt9K0j4PPKUHfm4PXi7wjymUwNO3O4mzbdidcXDmm3NI7ElbcHjiX+OEfbdRmv3iGpFVN8gQctGKzVHJZ6bJ+J3FcAhuDXaln2P2rvFOJ8Yqh4NR9pLn9ypRsharcdaBLbYMrZLYClcQzsWqvtYkF4zCARdkKh5fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCn4/vaKJ0xUH72lSdJ1OnkggKCWMgzLNkeKmr+Xdv4=;
 b=c57JlZNIrqS5dfp3l0GJL5IoGXpWGLdobCoIBlTccY81bSmPv4KcBavV2dkmHkKB5K9VMAcF7fA9RMBW+1tGAumovjJln2PVhSEpjbNzHv/U/ssmSb2/xxcP6w8uNaDU7xV+OTZaKw8Pu4q5jQjXlqA6PMj+7J1CFcPWnX4ihPSAIpVkk1h+Msem8MFD8QJrlhvSa2ox0ahrrTzoeAFiumc9Bz0wEmFRncFs7tXflu56umOj5Pea9HVL4IIcGPR3a3jiMJ1FseaK60sOe/xoYKTUYNQgsaMNYegea/tRGvw8yEsTeQYRbKQKKpOvcrAqwgOj6NbAufeq3c5Rgd5VZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB5839.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 06:53:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 06:53:13 +0000
Message-ID: <c9f2a067-7e3a-4391-9cea-380564026732@siemens.com>
Date: Mon, 10 Nov 2025 07:53:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1 1/3] scripts/deploy-cip-core.sh: Support
 deploying artifacts for RB tests
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: Shivanand.Kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro.hayashi.f74@mail.toshiba, akunuri.sahithi@toshiba-tsip.com
References: <20251108111517.752691-1-Adithya.Balakumar@toshiba-tsip.com>
 <20251108111517.752691-2-Adithya.Balakumar@toshiba-tsip.com>
 <25d8c857-fb9c-47b9-88dd-7450cf4490c3@siemens.com>
 <e3eac383-21d2-4cd7-ab73-e08ad53e42f4@siemens.com>
 <TYCPR01MB966967DE34491663DEE575E0C4CEA@TYCPR01MB9669.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TYCPR01MB966967DE34491663DEE575E0C4CEA@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0397.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a08750-da2a-4241-c437-08de2025d1a9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LW4ed1Dc1WqJKln0s27bhC6nddJ2V4UcNXjPAAe/FRi+77I41f4imE7Aw3n9?=
 =?us-ascii?Q?WyJL1rarBfAVLC9qImRDPaLip5umG0y8zS5PzRIkRDcumXm0QssR8hcnRbGg?=
 =?us-ascii?Q?yesvwP2hpexA9fM+oGSK4IpPWTC57RXYP+uga10z4I0yJ48DrmNsCW8vGpVs?=
 =?us-ascii?Q?ztO7/IEwavy7C+3CaoEBKT4GcocCufckMnpT12vm6xx9S+pqdjYQ/UahkFDF?=
 =?us-ascii?Q?k3vqe4IO3VGYkIfPi9H3qFZWR4muCo+GEk0DypbE3DJtPAnVnIdk8AmUDyWe?=
 =?us-ascii?Q?3KQ4WaS5os5jJTKeFkVsDWcPrU/WLOeln5mm6t5ZqUMTKdlGGwfBjHD7mNxP?=
 =?us-ascii?Q?vrFoLmnsId4V5Nf6W/iu3z5UyzOo21VknIgd+53igyQpbYbJXr01/ObiDyBy?=
 =?us-ascii?Q?4CbpN3n/07nfxZWrgawOPkUncnCSzcOkAh3NHAXv1TUEvoBjJZONIx558o7v?=
 =?us-ascii?Q?WXrgFx0+XbXO4xrXRRDTE/bSrlwOODuebbCopNaHQf67g+eFTg39MTZdjwju?=
 =?us-ascii?Q?bczOJCvDQUWY35vYSii2ubYm0SzNLmYk4YPIFO4w7ESpaQtt83+I1yv/Lrrn?=
 =?us-ascii?Q?GNKKHA07i9lgIpvXAgaUW/4zYxUxqBtsl/fkPyVjpgG/cdklzEDGAMuwrvLo?=
 =?us-ascii?Q?kDlpdduJIJVzkuwAgl3yTRoO9bi6mO+Juewkzkggo+jmNBe6SGdy+a6fZv6a?=
 =?us-ascii?Q?9PfPd5fSYPebk7sH3hksJQHFIGtA8RjYsbP2A4iTVeZnDPWGyEVKzIfdJbJs?=
 =?us-ascii?Q?UuhD9J2XfKRgel8cmFjsc6B3ZSwebc3dAxTEXnZLF7QWhKdQBMP9EtbbDaig?=
 =?us-ascii?Q?ms5WWyZoOa20IotFUkSpUtABLJzqWjmAJH1nttGQmET0AyUIaLqyhSDq+ilw?=
 =?us-ascii?Q?gCV/qP7amFKOn+8U3jO0lp1bc51p+QwHQf8fPr4198evGSGd80qU5OaLDC/T?=
 =?us-ascii?Q?JWkkIt6w/+SeDcRiKuZpI1qB2TXCtXRPgcbgYtI4lZ1Yi9wyIA88W0Iu5UU6?=
 =?us-ascii?Q?+wgyckfltfr8uhqiZ+ivmYu+lc5NSlRVVDsaOv8mJi/wGG+wKJXomeTqIFoN?=
 =?us-ascii?Q?If3EnJNuwPfS4SS4aojF11f2MPLcFvKLj+8/+h04pWMAB1M6r3sFLFf2OgaJ?=
 =?us-ascii?Q?e3vaKbRxvG+z8eoV+sPlyrsfpRiV1oLVvBVuXoeDKJO/v817qjqw3AvGa0sa?=
 =?us-ascii?Q?TnY9hVgEB+Zr5hiwNgPGdnaWAriW/xZl6uo8F7ziJ+yOyIcUgFAIAu5Q9tqw?=
 =?us-ascii?Q?En9pIDE0zfkQec89ZgERqz6dx2F0udWGR2WWb5TgGMQg8sEv7FqKGCehzMrs?=
 =?us-ascii?Q?llNA2izIPMy8eCg54g91/najWL0SW099WwRepLc8sKM2heom7+8LORpYohEW?=
 =?us-ascii?Q?RzDm/ukoSWOMID0kgUodYQootPfVKV+stzJYLzXE9selXYh8aLzNOCnXxSu0?=
 =?us-ascii?Q?yvmPXBVK7mAopNarwR1r6K2TIK541rjY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RQXfjRXK94XmhxwKsb782Ntanxz9A/a+un5M8/SMFtxkPS+siOumecOLRqi0?=
 =?us-ascii?Q?pl3/0TmBXO5noqzPYULhFz/14+ZueVq//SBnTjqLto8tq+TlxsTLIj2loxER?=
 =?us-ascii?Q?fdjAOG5eTEM0sgDBdp1SeVYUfBHOSp0AAXAa1cIyW5ihm3IKqVX1Q1Ot98wj?=
 =?us-ascii?Q?wj9T4x+XaoVNLBrh9nnhbgkXRy6QjkvT5PrqmXggRtmCtaz47FDGJctEwxQ9?=
 =?us-ascii?Q?SkKrm/WbVOcN428njmdwhWzWahvLE9clVsb9bOJwDJVnTtN4HEV+ChEMA1+L?=
 =?us-ascii?Q?x5ftHxcthfEio6C7Q52WYzEm0QWNjqqy8CC1UYdQ0ciI4UueIdmoF0Mv+V+h?=
 =?us-ascii?Q?wd4suY0YgCHg/TXEjjzMK7P8VLqHDpADRmD/Tk6pb6t/dJ9bk8Rdl5XsigPv?=
 =?us-ascii?Q?7pmOycEa30ZIGhjTaL7v4b7umMVH7//rgbZ6TNt52dQOQk252ndkB08mtMO9?=
 =?us-ascii?Q?+MUFus8jE5xyL9R/hA9koUD2Brv+fzXNY9EyDkN51KPrlD7htRlTITWrfBSq?=
 =?us-ascii?Q?kWov60PHlQXAl5NPC46nDIV1nrAqsV4EDsIL7cdHYvwv7DGSb7oLDFRNFAAr?=
 =?us-ascii?Q?vtgkbWq+qAOJq66NqDDHrCdQJIaA06jcfD1Mzd6CGnYkxQQrqvlU8C0ls/CU?=
 =?us-ascii?Q?nIshNderDsIl/XG4keQuWZAGLtOInj3MFKLTMKeaCyQZcxEd6WzKyDjrLNIT?=
 =?us-ascii?Q?CyYoFIaPEVrOuA3i28tS6+xqshWRtfcrFw7cHTqLNLvGCYcQDKepmQyzQkJD?=
 =?us-ascii?Q?4MRN7fvsNLc7JqpbDuuRx2H5M/f3m2NryZNQz49OYQJUfoqGFV9+VxeBo6JF?=
 =?us-ascii?Q?G149WpEuhzl/LRGkzVPaeR1LhwCeP2wZD4cJ1L+IQuf5zu7gT5EkfyKgkY1f?=
 =?us-ascii?Q?QRj9JPo59f5mxGla3drMYABJ/OmSpUuVHtvfBP3VQijWSR8TXJCJ9zKVmGUD?=
 =?us-ascii?Q?p1JpP6TTh37r/GEAzHB0W6SwcV0k9yEpStMj2g2hiWWwb7drHbL3IHKwZzRG?=
 =?us-ascii?Q?JmQlD+EJk2upzThlFNHUaeE5GViMmVhCmrcgEopjlwyUjMAyNaSYQscJcDxq?=
 =?us-ascii?Q?s1iZsKSu3TZcGUXZGJqsl7FOlpwIPtfNY3SPz2/m5Pr9t24JaqnS4gomGXz3?=
 =?us-ascii?Q?CWwsRPvu65vQcnNZggLs/bBm8mXsK/VARJBDHGXST5qtxECz7UPz+lGM0tYr?=
 =?us-ascii?Q?188yZT1ZPYX3nXz9y1zlRPjmfro3UA/TA49PgJJpzJvPG323YvcmQ7F2Uuyh?=
 =?us-ascii?Q?Ta2yw4EBUp+jzPyjGiuM+3XN1JYhM5+EF0s/ch1ER39eP83iQpawQBcl3npL?=
 =?us-ascii?Q?Oc62PPGcWWHCP6vAhSjQwc297FdeCLBGujagq6hrbUpolxYF8D0Xo7UrB5jy?=
 =?us-ascii?Q?HS/+rXxIcMibqze7RWN57yr0ZzERNneHFGN8fiC4RKHqCLp/Vw+u7XXIIISh?=
 =?us-ascii?Q?wJGSMEc34zmMQtJOg1qjIXBbDOakk2BqHvesMRNXd8OZ4BJfbg7fbudmu946?=
 =?us-ascii?Q?4hfkEagZOJJq0wL71t84ks6NvUw+m52pas2hboyjt6hywM/OC1gKrpl71rQ6?=
 =?us-ascii?Q?uHE1O6CbEXFlXh5xfhfuw9P4YbOPRiMoJy5o7MO7?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a08750-da2a-4241-c437-08de2025d1a9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 06:53:13.7503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDOkCnSlRfg09Ra5XO3zgq1aPGP+y99GlIVxkQDPPARxPY9BedM07wnjBPOBEF0nS1UJg1IHW17sbOfAKHWlYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5839
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Nov 2025 06:53:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20486

On 10.11.25 07:41, Adithya.Balakumar@toshiba-tsip.com wrote:
> Hi Jan,
>=20
>>BTW, why are we still pushing the individual partitions? I though
>>diffoscope can now handle also partition tables, thus complete images?
>=20
> Yes, that's technically true. But there are issues with high memory
> consumption of diffoscope when run on large disk images. I had mentioned
> this briefly in one of my earlier patches [1].=C2=A0
>=20
> And the reason we are also uploading the individual partitions is purely
> for some additional information from the tests on which partition is
> problematic (not reproducible). This was also introduced by [1].
>=20
> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/
> commit/0a690f769eee198bae94f3bd8f696f84f3841cea <https://gitlab.com/cip-
> project/cip-core/isar-cip-core/-/
> commit/0a690f769eee198bae94f3bd8f696f84f3841cea>
>=20
>=20
>>If that is true, we should push the wic images instead, and then use the
>>presence of an 8th argument to control if they are deploying into a
>>subfolder to allow build 1 / 2 differentiation. If that 8th argument is
>>missing, the artifact is to deploy flat (and only once).
>=20
> The current patches (patch 2) deploys all 3 artifacts (wic, wic-
> partitions and swu)=C2=A0for RB tests. And using the 8th argument to cont=
rol
> deploying to a sub-directory (build1/build2) is a good idea.

Ack. Then let's keep the partitions-upload mode separately, just change
the rb parameter.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

