Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19690C6FD18
	for <webhook@archiver.kernel.org>; Wed, 19 Apr 2023 20:04:52 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.67])
 by mx.groups.io with SMTP id smtpd.web10.48690.1681934688850937797
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Apr 2023 13:04:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=wSdtXd3/;
 spf=pass (domain: siemens.com, ip: 40.107.6.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dw6cGcjdzmRdCG0asWm4a0Ki6Z1EHlkOtsLlv0bUm+94mZtN9AaTc8iU6ZoKeLxM3Mm+auXkPVP7fMsXRxN6RFoUAYqoUOdYCyRHuqoOMoxFsqEoVeeF3at+kr3jOboWv3iZ99IrkFBfadP5ZpmysgU/4yqq2fuoziA2Ygv6txrbOXnW4CGPBJchgsTBPbB+JwYrAJgxNNA865MgacLU+zWx/uOXqoonw906n4gdzJnzoEFujyeuaXHAiy/PaqL/UPTcGHFIze+e47Dsp3ORUizcU6jZSpo4PrNSLaObubn7xoSHOHYKqfOFtjeODAzAnyTa1R2zIv1SZ0XdbBB/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkdVZl1t+rGP+tVEfjpCx0Fu0GeGxkmhu8M2ydc/rxU=;
 b=BFkW3uM2wuqfec6AfX50oAayOy44mXlEcPAZK3Jg3reORD01YMIxMFXCRAYkUMGJG70H6D/ddDaNkGy4cpoMEuzVFN5cf5tZtZdDiQPUCnWOF/fPUJrrxxijGv9s0oO7FwyOOtHne5+DMS5Vk5dogkTX08rJW4zqQFtqd0NdqT4BeIVzW1vIiuDi4t3Ge/Ok4Dsh9j+R1GktoMHSRUbrcHEq/Gxiijv9vCPnIwzXQiCkLH040LRjpD2d0swvyJyf7AhVGWmOMLgCnrR2C8+znT/3k2ztBcYAZZ41n6GdlOIX5x/xATnh9wJMs4eU1+/63SVuBKeQfuqZ0FD/lSbRKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkdVZl1t+rGP+tVEfjpCx0Fu0GeGxkmhu8M2ydc/rxU=;
 b=wSdtXd3//w3yBJc3sLzJNK4PGINN2rsoWB5+MhnI0o6K8luez5hlB/Wcf/xfRubaK8b4SAtzD8wuVlXpl8+ISDt9lsqzMhrvJrcr/Sucb3RQtnI6wQF9Dn27Ph7PZl3BRrdTuNnPr7gYz+RUv2mcOp5TSfqtUoJAv9GNC1M7zLEDKPNiDV4zmMFCwuaoosEU7395G84skWa87MUo8dzMKxZXpqLKA6fu7qLFnRYdl+viXzbHNnPyZsfWdvHA+AiRAZn6pwNkGiafkayMmaTSFB784HiepHU3rkLS/m2W0R/UisVCFf+3OPD23c3vzf9xDvyPRxB38bGUyfLGH6YpZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6150.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:548::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 19 Apr
 2023 20:04:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 20:04:45 +0000
Message-ID: <921be756-1865-46d5-47fb-25e8d2c05847@siemens.com>
Date: Wed, 19 Apr 2023 22:04:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [cip-dev][isar-cip-core][PATCH] wic: Use INITRD_DEPLOY_FILE
 instead IMAGE_INITRD
Content-Language: en-US
To: "Moessbauer, Felix" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
References: <20230419102926.1331225-1-Quirin.Gylstorff@siemens.com>
 <a8b641c2-c664-9230-ac9d-dcf64a7f936d@siemens.com>
 <6b056f444843732dcc53ffaae028491009cb6411.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <6b056f444843732dcc53ffaae028491009cb6411.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM3PR07CA0106.eurprd07.prod.outlook.com
 (2603:10a6:207:7::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc9778d-36d9-4f83-ec5d-08db41115102
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	z5m4n8b1L9hd+imll527rhehtnsP3HDWt7pLzF4eUzDgUk/P0K8PpSGLvks06jGFPSIDO647PgfYNM43RFPeg608fV9UWrFl+CDZRg9uAgZVogvTYfjYZ2aAZQv1mTZOa6pDznfRoUn8uuQbPQx1CaWv9FZtjKZdNyQEiutonnUd9r6Sj+6scrXE014rRG7aBpmpjh9EiqYJE0O8BIKeuQ/mGZnUGweHZv1uUfuvGbvTVFzffQJAwaV0u1aGnCfJRoTqHsksJ2NE7zcTVm/FKZEpbeMp2s+SxjN6KyM1hpragNehSMaXE8VIFFqIr5G+lKiE/s9gYJxeGAsjjwWZZXVyuFOr39kkvetZ8pVmluAL9osAeZ5A0jKQKuOPe9t+2AzlXzNBgIi4n5cUm6tNefzEpbw1s9oJVcz8v5576riq4Wg9yX6SPGIdp3CupkGWIlNsuzl/LBtXt4oWa9tNy0pey+kUiH5sAOXuv8MfWfcoDPjozRXFNrHTTJTinQyf2XJY6otOURHK6l4YRdTVeMv3ZD/VBv0g+DKDzpELBrxLdCd0xxRYFFZNeXmcxJ3qibiy8Bybt1HDjB34iH7tyg59yaE4QcnfDpshsd/M0PCrEDTBjku+AxjpTG1PtRk//ixIFYVA3DR7A8Xs2MohDDiOorjc1IJKJBVXgWm6GBnhFVFft2SscmWwzwM8Vbkl
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(36756003)(110136005)(6636002)(316002)(66946007)(66556008)(66476007)(966005)(186003)(478600001)(6666004)(6486002)(8936002)(8676002)(5660300002)(41300700001)(44832011)(2906002)(86362001)(31696002)(82960400001)(38100700002)(2616005)(6512007)(6506007)(26005)(53546011)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?89H2OZZzxYDyO95yAvqv5bDHIDPgYnr+e3DWIsXn3v63e4UYdcTZN4SwfKyp?=
 =?us-ascii?Q?Zt1X4XYUue6K79dcNrIZe3EGOlCkMvr065A9P0MbZ2Jm/BRNuVyyBRvFX5At?=
 =?us-ascii?Q?3O9g+20iofiZ+vnutbwCqniHIss2foaAXXwUmtCNIrr/wFOUsI5U04iYhZoA?=
 =?us-ascii?Q?iDRsWxk6bIE1EUe1ay2wu6zVbnFIQzLvGmeVb8EhdsC/wejJFtHahHLHJMPQ?=
 =?us-ascii?Q?7HpeT8zM1lIoypljT+HixDHUhXKqjSk2Pn+3esclzu7j+mI8RInWQBPJjB95?=
 =?us-ascii?Q?ButnFpd9+3YQI6od8saDOKG+nLU7mZa97W7LTc+rVz8QZf7DyRrn6m7fbqJo?=
 =?us-ascii?Q?60ZhyV1BB7m47Sp1yKkzbmey7Qbi/BunqIBjhaTwD6dUwwGhf2AEsIP14m1J?=
 =?us-ascii?Q?DRhP5XfBlQzSP1utnkjGMst6UdNUDsYHLbLTAgZgTXiFb9kfOPFSVRa7BCLm?=
 =?us-ascii?Q?dLVANerkckGA2pUJaRT8/bwAuq85YUGYTQeUchLbaJWCw/LW0JTgSMbl7m0/?=
 =?us-ascii?Q?Q3bcioJEfj5yFODYya3MBvcz/m4PK0jZzc4MalPDCp87NDc5PhzsaclCSgBK?=
 =?us-ascii?Q?PbfPvBjwXF/RZIGC6xlHzPgLpdxgsJkTTxa0Lx8PvJLHUV4xTFbWCq3jAVr5?=
 =?us-ascii?Q?Q9qvLQ1Rr0+zh61Z4WqEk5YMPF19OJEyGPvOstknUWY5ca9JbwTwIfEgGbHc?=
 =?us-ascii?Q?BXlRlpzvlMRgYvbjDsgHfY/JRajVV8qDASTvQn1WDtYOdesKjtGoYz6O5saT?=
 =?us-ascii?Q?U1Ovhdud2/TAB2caZyd/QPZznTl97163clDaTZYJUB05H8qHQ5QtA62hWltE?=
 =?us-ascii?Q?WfBt6FeRBVctztDRjjqdAlVQSlpDEw8W69wuovKRfocYHsJXMZJRtSAp6xGa?=
 =?us-ascii?Q?uuyntfZSveFPb+QK8gCNGRf6YHQgQt7JZru6ktPc6dYt+pWMbewk4K51tiWd?=
 =?us-ascii?Q?Owk+KOiQcItPWONEbw9Wmf/Ev1UWPcBg++3avWGdoK2tzORtRb1j4twrBP2A?=
 =?us-ascii?Q?chBnQggyYfiEPPtCxyCKzhM9FOTWOdloCt1UDUTU9RD9AyaOoHAZXtEYS/cy?=
 =?us-ascii?Q?uxF81IeEBkPTvnfoeNOzOFjrjqzUEnSKVL7C5kDtdmHy7Bm6UI6Bl3CERZOy?=
 =?us-ascii?Q?OCyjTGHY0lmMr4/5GAIJNURcOz/249mcJScBc7XyWIvoN+tp4Em1JvDR7kmY?=
 =?us-ascii?Q?ct7i/Yk77j+3Zs0mU7kj0aIliKpf2ZMajfi84uk5UEdr0s0rQiFX8wI405dH?=
 =?us-ascii?Q?QLEOXoMYPt0uqQaW6P9FAF5IConLZlRLNnDxke2r2HYSKAduUsi441aHfW3R?=
 =?us-ascii?Q?fVHKjTsGMRsfoPCudTamoVbQ1g8vShVQIMOsOL6TAfMdCCr/kDjBAJ6hx+l2?=
 =?us-ascii?Q?lpwJp3MOlZJ7cVDi1fpxwd3hw22E3uHhML4Qs4qFM/Fy9dWb6HncAQAcYf2A?=
 =?us-ascii?Q?r4GrhPLe1EzK9XPdBesZi393d3+wplxtQHZvNIfUsNkNIJL0aQQcoCAYXXfN?=
 =?us-ascii?Q?I6GSeP/Kt9+tP717LgqKNC+YECe80nl06CMSuIs6m7dURSOZkhbsZncvAhg2?=
 =?us-ascii?Q?TuPWi+rwZO9xmVPer12du2fNA5fAOC1C4QGYGs8K?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc9778d-36d9-4f83-ec5d-08db41115102
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 20:04:43.5395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfPSihckJcrpKa7c1KMeY00fNQ5IqvpMjyjypKXW26IFtEUzd3DIqeFEICqKUWE2jiAX37gEvg7dkc2+ixPClw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6150
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Apr 2023 20:04:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11236

On 19.04.23 15:52, Moessbauer, Felix wrote:
> On Wed, 2023-04-19 at 14:20 +0200, Jan Kiszka wrote:
>> On 19.04.23 12:29, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> With commit
>>> https://github.com/ilbers/isar/commit/f0608683fd18f96319332f2ea3827536b=
d2fd761
>>> =C2=A0the variable
>>> INITRD_DEPLOY_FILE should be used for creating the wic image,=C2=A0 see
>>> [1].
>>>
>>> [1]:
>>> https://github.com/ilbers/isar/blob/master/RECIPE-API-CHANGELOG.md#work=
ing-with-a-custom-initramfs
>>>
>>
>> What's the impact of not doing this so far?
>=20
> It breaks the build (wic) when using ebg in combination with the stock
> initrd from the image. In this case, the INITRD_IMAGE variable is
> empty, hence wic with ebg plugin cannot find the initrd and fails.
>=20
> In cip-core, we always use a custom initrd (by that INITRD_IMAGE is
> correctly defined), which hides the problem. However, in some
> downstream layers we had ebg + stock initrd and there it broke.
>=20
> IMHO this should be fixed in the 1.x release as well.
>=20

Thanks, folded that in to the commit message and rebased it. Result in next=
.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


