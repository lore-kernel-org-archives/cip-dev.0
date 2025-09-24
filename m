Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89482CAC5A5
	for <webhook@archiver.kernel.org>; Wed, 24 Sep 2025 13:00:48 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.24])
 by mx.groups.io with SMTP id smtpd.web10.12274.1758718842964062471
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Sep 2025 06:00:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JMzWD1ZY;
 spf=pass (domain: siemens.com, ip: 52.101.83.24, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwXK4h9EufsxrjJsnveIxKlmMZB+RKoq7hNFxfPEcssQdjADVumrGP0GUsKJUw4iW5PLBvdoLCU30BDDgxcI/24b1OUIMyCBvrGpGuI47o48FCjenR3WtK/mrF5XzoRBFDiZslMjqL8ArzqFBvlT1QXwnAG20KGNSGyEquF+4/uxzyvNsbwqeihhqz+F6RjrnMtR7yIjRqhJ2bADaIArHVTxPp72gXEVy6t4ceZSr40c3DWq2q+PuauoK6RnrOwfVOElLuzzww0CfpEZx1wapARa9X/6zjyh6evUvswtWtQMhiveKdqNuIhwnzBXZ7LJUnmH+wrxynneQCfB+BTkvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHPi0RCaTHnVxp5X7eqnNCJ+QcMaVJg/I5qh9numwTM=;
 b=h+Zen9DiXRAIiJoX3shnfdHgvQA6JD+radyZbvdxwdkAh5/8GvX8wtKy0A0Oi6H3PPIYCtIMGOS+LaGGGbVJ65nP288J2rYj5VUx4IeP0rh8L6MPMi53qTgZ3rENZVslylP5a1ZTCZfXYcCPn4s9i7PNb4otkgNTrTWsaO7tpXmx+RNewkbq4rZ8DXs+9AMEeZZ1kaai92Wia2HxH/R/7vqypBZcazJbPQlWOmBgxM5p5zAvfoZH9CvcszNirQKi6T+4SWBGIKw+ajq67d2n7QsqS+2r6UnSFaS/qisx1JAvnC5ioOsjpszznNll/14WHBO12ONpU8sdpJRnPZz7Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHPi0RCaTHnVxp5X7eqnNCJ+QcMaVJg/I5qh9numwTM=;
 b=JMzWD1ZYFUHt+AWhOeIq6IghAVjhKHLtJ05CAnhkFnzaObTeajiSN1qQUXX9XXGcudTzKnuGjNuAyIbdaJx2O4qWB4pWGY6TnLfUIchzJxkgYG06oClNHC/9f94ZXahi6da79h3G+7dQocMhV1jOgmDRGpCQp00ScoIG/tNhlIIECx3baftGEeLUgcXFpJwVSh8b2mIvtZ+J5HfwRw5++2Qq/KKc93VM4rivENAqq7hRnubFE1cgLrpTq5tpDHYvPxJaKzcAwqcrkaYLCRLH8yWDBGbGkd3+Ha4Kl3dk2hNhGk56WTua4nDAH9TSV1d1k7ZqMl188yEQNgFBo+/M3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DUZPR10MB8189.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 13:00:38 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 13:00:38 +0000
Message-ID: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
Date: Wed, 24 Sep 2025 15:00:32 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 "shivanand.kunijadar@toshiba-tsip.com" <Shivanand.Kunijadar@toshiba-tsip.com>
Subject: isar-cip-core: on-device tests failing
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::10) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DUZPR10MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bacb46f-3fb3-4cad-b214-08ddfb6a5b4d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cGZCcS8rL3NYMmdnQTNqT0NpcTJRV3Q3MDZVUmZIU3cvaXhrRm1hVFUxd2gy?=
 =?utf-8?B?dCtMNTh2bHh5RVowMjYvZHZQdVpRYUNkeTZVcjV4NGk2QTg0RmZOTkp5Mm1m?=
 =?utf-8?B?SHlnUlIzS0lUUTJkT0lMczh1azhieHI0aGVRRVM5TmNPRDJZeHJRYk8rTmxp?=
 =?utf-8?B?TEowbzRCV0V1Q050eWVGRXBqcEFReHlZcTg4SjJXeXNPSXY5NE1zTzFwTXUx?=
 =?utf-8?B?bWprQU8zeXlYcHZDUGhaSVRWd2lCTldWZ1AwTUkwVk81bTdSY3BHSnZjR2JZ?=
 =?utf-8?B?OGRjaDJlKyt1MmYwRy9GUE1xU0ZNYys2WUNpZm11OVZuREJjKzRMd0M0YjV2?=
 =?utf-8?B?bHYvek1haGVIOXJaOGtZVTFpaUE1eWRRczE5STZScFlVWHhITTJkVStwVHRp?=
 =?utf-8?B?NlFPSnBzcEJQK0pVSGhYeE1QZEZDN2wrSDJjM0g5amVtQ280NU5BbE04QzVv?=
 =?utf-8?B?VVFwc0MvbndCRmN5bHlLcEJORWQxQlVSUFNobTJ2MU9vdVRYZ28rUUNpVysy?=
 =?utf-8?B?VEYzVFBjNGw0bTNzY2Y0MTB1dHlWZEsxb3Z6bFlkYk1Objg3bU5NR2tOWUov?=
 =?utf-8?B?MmlqaXgzVW13TVJSRlphbmhQblVMZDZxalBncWJLbm9BN2NxTWd1ZnJqQllt?=
 =?utf-8?B?VG9kN0hzL3FzWUFnNFdicEUxR2lGK3AySWdyZVhVbG5zaGI5L0tXVzhYcy9X?=
 =?utf-8?B?SWxBQjMrdEFTTElvUzRPYlk0bDdVUzRQNXVxTExUL056NXVaZloveUNYRlhP?=
 =?utf-8?B?TThRWGZ4dldFOEd2OWMzUzlTWGV6WFdkYUsxUUViSlNWRlhjU01YRlpPd2FX?=
 =?utf-8?B?bWVHU3pNV2ZSZ2lvNmJRWlZVczl2MTBidEZjUWNudS94bzZJemJ5bzJNSmJX?=
 =?utf-8?B?YlZpNzV5WlY2RElreVlyZlUycHR6Q2pHNXMxd2Y5ODNOT2w4T3hoNzJDQW8r?=
 =?utf-8?B?cm40MG16cFIvNTErRnJkTVlXQ2ZCRXAvNnpyVlJ0MXI4d2dGbi9VK3dGTURR?=
 =?utf-8?B?djZYd09TTWdJWGg1WHB2TmRzQTAvTTUveml3dmJMU0haU0I2NFFlYXFWM2NT?=
 =?utf-8?B?Z21ZMm9sWlFiYmZaNVU5S1l6VGNLdUZqSCtFZm5ZR0NyMURTT1NoSjVYdUhl?=
 =?utf-8?B?cW9ydW03QzBsTmhha2lTclprQy8rcVUwUEtpTjlIbWF0WVFOdS83YWlVTjc4?=
 =?utf-8?B?WXFqU0pyRVFiQUR3TXpNdUJZK2l0WGwwcUxYb21peEkyaExYbE9HZHdmNFVh?=
 =?utf-8?B?c0pudnNwKzYxNHhpemdYNWVNWlpPbEhkeXN5d0I0ZlA1RmJQUEVZcmc4T29q?=
 =?utf-8?B?VWxDMnlPcXVLamVubXdST2Mray9kME5MRUVWMFU0OCtLbTNQU3ZrZ2FLektB?=
 =?utf-8?B?WGVVQmVHaUhRWElvVEtyWU9BSy9tTjI4QVBRditQa052Rk5sbW0wQXZSa1NM?=
 =?utf-8?B?eUFoQnVaL240TnY2eU9sNjZKS3Z1bDJqbHV2UHhzWGhMVmViRzNPWFFBd0M3?=
 =?utf-8?B?WDR6Nk56emgvbHJxYTEzSmVrdGhJR2xYNVg5OVZLY3ozZUFKLzVXcEI0VDdt?=
 =?utf-8?B?czFxc0ZOY3ZBODJmQlZKTXkrOWY2a0Q4SFdSUTRvQ1lGNU9sMmJ2OFpha2Ez?=
 =?utf-8?B?bWR3YkZ1UnNkS08xWEZYdkFmS3JJRWVscnpFRDZzNVJ5QUdFdTh6eXZjS1Jl?=
 =?utf-8?B?MDFlK1labVZRVllKK2Q1SHZrZm5FdFFJTWZPcHNGcE5RaU1aRHc2cHBDbVZO?=
 =?utf-8?B?QjVoQW9TSlBpc3JkNXExOVN5U08wcFdrbFY3bVpkQkZtMVRWcXpka2pmS0FL?=
 =?utf-8?Q?XwcwBveY8yBcMZz+5X1mGTGbdXq3/bRXcy4Zk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dnVCWUtEaXFqRWEweGhlNmNjQi9ReE5MSVVwaUZoSGdTRkxtVUtmVm4wRWxr?=
 =?utf-8?B?QzhST2hIRTJ2N3c2RVNEeGpFT1BpSUNvTUF2NFJPYTJYKzI2VHE4YlNjcTFE?=
 =?utf-8?B?OUYvYVY4WFJzZEdBSy90MGVPVm96aUU0L3VWajBWai96VFFUWW5GOHE5ejlP?=
 =?utf-8?B?N3NsM00zN2w1alBHbHRBZ1hNK3dOMjM2Y2VZSytrMS84UDVBeVowbEdCWFZY?=
 =?utf-8?B?eU84THdtanZObUZmRGphWTlnOTZPc2Q4dTdjc3oveVg4eFc2akJZczdRamJr?=
 =?utf-8?B?Z2RRZGJKRXVHeDVNa2ZtZ0oyYkNQNDB6RC85S0JkWHZDemJNWWpyU0pXU2hH?=
 =?utf-8?B?Y3IyT2NUbFRpejViOGdBaWlQVUh3ZDVOYzMzTU00NmFoV0dML2ZzejlGc0ZE?=
 =?utf-8?B?R0ZDb2lnZ3F5andsNkpaK1FLc0hpYnc2WFFNTzlZNWFpaVVITm5ER0d0QVNu?=
 =?utf-8?B?SUQ1eGFSWUg1MUkvaDExUjJUZzNvcnR3ck1WMXA3TDdHZnQvbktLWDB2TGNt?=
 =?utf-8?B?TU0yb2ZiS3RJRmp5K09iakU4NDAzT3FYcXk2UXlTbk1xTTl5cHZja241cmNR?=
 =?utf-8?B?Vi9xRFdJbjZvWGVCWVhURjhzTGdJZm9LNXlZY2RaaVRiZW0za29pWDZ0Zm5P?=
 =?utf-8?B?aDllcGlwQ052OXZ3VERoK0toSlpRSmV1YS8zcW54RzJKekh4Y0FNbjUrSjYy?=
 =?utf-8?B?LzRlNEIzbFRTY1NQYWZobEMyS0NzMXNSNU9GcHM4cjN1c2ZDUXAwc3NCRnNm?=
 =?utf-8?B?M2FQTUxBNFkyLzJXdkREdGxOSkpLWlJqNjBQdG9hL202VWlyL083alVMQ1Np?=
 =?utf-8?B?clAybmNWTjdnTTNmZXhKRTdSbXhJRUtSeUEybnFLdHpkaHBxMDU5REkvdjEv?=
 =?utf-8?B?RG5jcWZJNk9qNVNoNXFZWlhpcGVHaVJvK3ZITm9DRHZSNGsyeEU0N2NqRVUv?=
 =?utf-8?B?VFFSWDV3ejB5RFRuNXh1TkNITWFhczFDUmlRZ3JEM1l1amNtQzd1cjZFeDFN?=
 =?utf-8?B?Q1gyaVBBdXFYZmhLdG1HclhhZURkT3BQRTBwNFZqdjVnNWFZWU80bkdtcWkr?=
 =?utf-8?B?MjFXNENEOWpub0orSlg1Ny9Sc01mZE9wV2NheEc1UHhzV3BZUldlQ3FKUkha?=
 =?utf-8?B?bEtkS2RXdkpLWFZraFN4K2ZVL2s1Q09ydU8ybCthWXJFaG5PUVhmeW1zMVp6?=
 =?utf-8?B?endBVlpncGZjdlNqUHQ4dXFTM2Z1azcvNHgvdW9oYXJSM1U0Y3dKSmJDNWlK?=
 =?utf-8?B?ZUZVUnZHbS8zZm1hOUd4RWgzWjcwRnZCdng5MUFJS3FqOHRqMW5JS3Y0OElz?=
 =?utf-8?B?Q3BETFhCbDlrWDZhMWJiaW9sTzZkd0VKTis3M1hyOW5Jd1VhZTNxZnNCZGtF?=
 =?utf-8?B?WUZxU3FHZzgwSzQyMDdCLzlIdkthR1JxaGh5bG51NHh2UlVLRG84MU5ZREtn?=
 =?utf-8?B?V1BGYXFIbldDYklYZVd0b2p2WFBkV0VXWWdtbzNIOUo2MlhpRnNteklFUGRM?=
 =?utf-8?B?OUxpMlY5NTBKeEVsdlp0b3puSGdBNmtiQ016d2ZBSE15RVB4ZW9vU1hrcGNm?=
 =?utf-8?B?V1g2TGlEc2VEWFJNOHVOdkk1SWk0SlRnOUpTd1NqckZsNjZNUGdkNUNsRTl5?=
 =?utf-8?B?TThPTHBmdGJ2MTBpZ1RBaFZZcXd4SEVjL3lNN084MHpFRnNxV3dON0haYUJi?=
 =?utf-8?B?K3ZWSFBuZ0hIWFVZMUFmYUt1M2IzMVVJYVpwS0c4UGp3bHlXNFhvc1VEMmFU?=
 =?utf-8?B?dTNOeG1PbThOeDlhaVU1RHBFRUQxVXV6QUVqczNYWGJhVFpTUExOVnlXay8r?=
 =?utf-8?B?eU9Mc3hhMkxhczU5K3MxYXMxUURDbDlRYkpiTHFTSVhrN0IzOVlScXVGaTZO?=
 =?utf-8?B?ZnlObHhFcVZ4dHdqWlE0ZXcycDhWc3VZbzR2SzRwajI4bHJpOXFJT29IOGQ2?=
 =?utf-8?B?dEIrQnZwNmY0UFJTb0lhQVFkRmlURThmaDAzVVpDOWJGdEp5TE9lSDQ4TXJa?=
 =?utf-8?B?R1lHS1Q2WGJ4Z0REeGZ0MENUZXFqa3E0ZnNYbXVKcTZpOVZ4WjU2Tld1ZkZT?=
 =?utf-8?B?SHlUcVBFaTRPN3RKT2txTHBrcHVtMG1RQngyQkQwSEVvT1RKL2w0aUxqMHBB?=
 =?utf-8?Q?cPUrZMYgObtI68O2tNxb9hfee?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bacb46f-3fb3-4cad-b214-08ddfb6a5b4d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 13:00:37.8603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPrp9hGl7nFAvTwKf5wLU3/q/5b/JlTHev9o9KPhZVdmjapPOTlZNVCEJCR3m0KdbQOGB3Z/Obw/WI1XtN4u3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8189
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Sep 2025 13:00:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20117

Hi all,

currently, I'm not getting these tests to completion:

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/2054264041
https://lava.ciplatform.org/scheduler/device_type/mcom-mtda

Maybe the current slowness of our lava master contributes to this, maybe 
it is some regression with the target device. Could someone have a look 
an propose a solution or at least workaround? It may otherwise affect 
our next isar-cip-core release schedule.

Thanks!
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


