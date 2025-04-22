Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916D5C369CB
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 09:09:54 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.63])
 by mx.groups.io with SMTP id smtpd.web10.35667.1745312984434192878
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Apr 2025 02:09:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dVrPPoO0;
 spf=pass (domain: siemens.com, ip: 52.101.66.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LatVSW4379E5oOHf86d39uGse0JnQgJHIOZnAbQXf+Q/yJDExr0Xl3JVNyrDxmcfOwhsmFti4W3ivSfcijYD5fj5NdPLjg1d6DcVJ3dt8ww/fFKkN9nMHPdjqiHwWMqzqiLV6td++Nt5pD8rX5TinILuO+CqoO4vcbaIJnNa0Cid022v0JeOE2wLZ8q2ARKx32IQp4RvvzAa7T7iPDPKqT1pF5SRUuSG9XLVSWnbj7KNQwkXUzOyW475aebpoTvwJosnCFWrkKNuaopqPKnDUHqmJAuXK/kF8CzVlvbdoIB+Tw428PsbeBahJStPpYIoLU+vt2Bzx8kr5hQWMQeFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xG30VO40kWHLhc3rDoSc7CubOCqcJlfodUNLothRuOY=;
 b=XAESSUSg2BaCSVR4C95bFowwd6edhezt0r9SW5H4+QS8PfsdABaROSRJoy8S1MqRqZUzpfPm05S2sQ1H8Q61DEDuZ0tj6yTWf+VS2SP1fLTBY0QoJe6xbp6i+utzuZEECACPCQBHVOMEyBVFS+RaDQFwqM3f1jGYF9rQbWxA8EQUhfMApnLvFrHEe4VP4yHwp4B2FZ5fa2IIeVgndnHbHyojO4w5CAJEgo9RMjmI/fxu/29Bi66TcQaa+Mj22Hlpo4oH/lQ1cf2GQWBP+hdrzlX2F5T4thO8WjiSKZl2YyV3hVhOOp4Bkdw7/0KfSk+jFNKL2LoTYMnWQ9AQuLwIhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG30VO40kWHLhc3rDoSc7CubOCqcJlfodUNLothRuOY=;
 b=dVrPPoO0AlTFvBzRgsyihsWD7T6j3uPpwb021/iU3lMAOalAztEzjLHtiiHUVU/GOSQOSCm5Maf2eoS6tS6eXmJRTtsLy8jlFgakbrEcfuHB61uS130DMTAdX9Pq0xiwvxxR9jKvurcj0SnXPCbk/4Dm7V8CQNyRQifiPGkcEA2HOKJt+IGsdMfLPh1aGEVcb/A0KCryw6UJZD7YDsOzYj5Z2L/5xpp7rdOYj91pYibwJIOb4MqRC/p9njMQBoE+BtvY6ziEv9WB9QVCJnl9r77ifFiWVZP8Jf36v2aYUK/C3mGxeM++MO3H8VQszNCcoSXYYRPV56VIAmh3uNPXeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS2PR10MB7022.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:59a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 09:09:41 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 09:09:41 +0000
Message-ID: <93fade38-1791-40e1-a759-46a969f1c28e@siemens.com>
Date: Tue, 22 Apr 2025 11:09:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC] Handling UIDs/GIDs on Updates
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>,
 "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>
References: <AM7PR10MB3320024DB860319B2C1E8D9786BB2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <AM7PR10MB3320024DB860319B2C1E8D9786BB2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:208:239::13) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS2PR10MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: d9fbe839-1c42-46f2-f56a-08dd817d6a0c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?T2E4Lzl5SmV0WVBhTWZtQUJ6MWFqMUdtSDJ1UzZlSndIWFBzT29nQy9mVDBy?=
 =?utf-8?B?cVF3OEY3TmRWN09CTnZKMk1sV1hqakdmNzVqSHFGQVAwMGU2c2N2VzlwVGxu?=
 =?utf-8?B?ZnhQU3BIeHQvVWF5RVJacFFKZjJSMkZkZUtRZENBcGJUbUVsMk1UNTVEOG5S?=
 =?utf-8?B?VmxacnprMUtWNFd4UW9FeHB2MTZBajk3WkhBV2FDOEFmZTVmdHVHU0NyaWcy?=
 =?utf-8?B?d2thZ0xNU1NkUDdQL1BXTEhSUGJOOHB5ZStRQ2x6NExkOCtyajg0a0NlaHlW?=
 =?utf-8?B?ODlJL1pkQnowMXI5SGdsRCtEN0N4eDVuTUgrVFBPYkx2NHRSOGN2bHNwOWRW?=
 =?utf-8?B?T1pkVyswaEdDZFdBZ3Q0Y3VZSWNzTis3L3IwK2drb0pMQUxYMWh0QmJaR0hn?=
 =?utf-8?B?TlpRZ1dYUUdOUktFOEl1eUNueTJMUTE1cHRGQ3Q5a3Rrd3V1VTBZWVVJYXVu?=
 =?utf-8?B?NlRDdjJxR1NGUWdtRnI1MEhyRzV2a2F4S25UR093NFhxVjlWZ2hzTlM0d1hm?=
 =?utf-8?B?NXVMM3p5MHIzL3RCdElubHh1L2Vka0prMC9kSEpiUHVkUVNFN1pCN2R2RGUr?=
 =?utf-8?B?Y2VEcnFrSFl5V1FsR2djTk01anpLQjZLbTJqK2JpZHZWNUZueDdxaUR2dThM?=
 =?utf-8?B?aDJTc0pTMThqcmtWbTlIZ1kySkxDd3hHM0hway9DakZCQjEydll5MGFKNkpK?=
 =?utf-8?B?OGQ5angwY2VETnpveHoybUZKZjJRWTFvZU5kWnhleUtHc1dYcjRFNk1nSlFL?=
 =?utf-8?B?UTV3UnhtcmZING41a21OZkl2Z2tlNzY5a1QwQUxZVzd5N1djdnNYQk0yNkJa?=
 =?utf-8?B?cXZ4MlF5cnlHOGM0clEyamErNVI5NTU3aXBRQlNuclRHK3FkSmRiVUowQmU2?=
 =?utf-8?B?WlR2Y3RKeE1NOUtDaU01c0FOYi9qRkFWZWJWbFVxZU0rRFlCREdBSXhBcVZP?=
 =?utf-8?B?dEl5Q0IrMXV1cUlZRnRiRGo4WFMrbWt5eUtaK0lxK1dzVk44MVA2c3FqZlJ6?=
 =?utf-8?B?NnFyZmxJVVFrcXRGWG5YbFhnRjRKdHNOWGpXeWszdDMvREhIN09pd2t5L25v?=
 =?utf-8?B?QlJ2SGNWM1JwOW5tOXhDd0tEdHlZaXlOWDBocndnN1VjVXNNQXpTdFR3eHlK?=
 =?utf-8?B?T3VaaHc1b2FsYmQ4VkhIMUFQRjk2M1R2KzNGTGxvTXJQRGVIOXNPRWhiZGlz?=
 =?utf-8?B?S09ua1F3QTJnRG1ENlZZTUpnVTZ0dW8zaE1QZnIwakpkL2cyMkVsTmU2VSsr?=
 =?utf-8?B?OTJLZExTRnFpaCtVVTUzZE9KdmttU3dpd2F4OGo2aDlsMThDaVJrOWEwNm1F?=
 =?utf-8?B?STAwelZvNi8wMGJTeUhLaTNtWXVBaE9QNVl5eVRtZHpjWjdXa0NEZ1grT0pr?=
 =?utf-8?B?SkJ0cmxIS3BUSlQyR25lbnpmb1pVOHd3MnkzTWltQnFKeFE2UkdNLzhxM0o4?=
 =?utf-8?B?cUowcTNyYjNHVlg3aldFeVFOVURtTlZQS3VoU3puVmFPMEVVc1BsVm5zblhz?=
 =?utf-8?B?TVVPQUVqS2RGSWEzV0g1N3RCTWNETndpWHVJUWsxOE5maHIyUllzcjJtUUtF?=
 =?utf-8?B?TXUxam5xcUUxSVdXWkVWa0p2SkFYQzZrNlk4eXI0WW9RMzRjR1Vxc2NJandv?=
 =?utf-8?B?cVEvU05xK1RvMVkzck5jOHRGN3oyWGs1QjcwbkF5cHpnK1lYeGh2MnBiaUpL?=
 =?utf-8?B?QlV1bDhsenhmL0h5L2pTUXo3V1hyczFVeUM1SUJpVUtSdmxWZW43OU84Z2pP?=
 =?utf-8?B?UldDQTF1aUpBaVdOcnZhVVNWajdlN29oSzNzdkxkeEpDalpEWk5IYysxcHZ3?=
 =?utf-8?B?c2kyaHFlQXIwaGx3WGpXR0hZMGF2NTNGTEpqME5YVGpZWHJlSzgzaFQyUnpO?=
 =?utf-8?B?WWpseHZ4WTRXdkJvUnlrcXlQQ1ArTitKUnREdWwxVzV1R0dkanZRdW0rQmRn?=
 =?utf-8?Q?LdA2T3Mq710=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZGFabHJEazZyZDNiR1NzMFRVMzY5RVFHYkxCSUt3UE5VK0lKUW1uVTFVWmlQ?=
 =?utf-8?B?U0xUZUFDeVJ3T2FzaUYyc1dJdkh4bW5pM0J1L1JBbVM5U3kycTVkejVsUFQ0?=
 =?utf-8?B?dkd1bUo3ejQwNFFDOWN0VG83MWFPY3JHSURnSC8rUGl0TnZCcGc0UmNFS3Ro?=
 =?utf-8?B?L3FRVElXbTI1T2NZc2N6bTEzcEh5TUpsL0tUQkF1dmlyempGZFBwekJuNHJh?=
 =?utf-8?B?UXRjUHllRERWTDkwb1RWZHExZEhiSkFtZEFzYXNsTW1QRE51QzQxZ0ZUMWVs?=
 =?utf-8?B?b3NTanc5dmp2Y3pBVkJZS0t2bHAvRDh0RnpnZG5rTHZXam9oZmtOQjMvTHlP?=
 =?utf-8?B?d2lQVlIyWDQyQ2NuRy9lY21ySHYweVpPb3c5amNnTklaME51T3RWR3kxSlRo?=
 =?utf-8?B?eGx0R0E2akoxRlVzamJUYnhudTRWU1ZvZHU2SHhSaWtLZmExZzBBaEI5c0sz?=
 =?utf-8?B?c0dydWJaNk04K2dvMWZFckJtWWNCeTVzL1BjSWJudm1mOU1TbGdBTWh5akV6?=
 =?utf-8?B?OFRHNUFLUFlqQXpOdTFxZjZ5bU13NU5TR2xTRVJ5TG92TXNVN05NOWRjK3o5?=
 =?utf-8?B?bDU5d1ppNitDRDN3WXlxTTFRRHBjcTFna2FRYjJIZlcybWhiMGtWQXBoMEdi?=
 =?utf-8?B?bTBGY3lIbFdoSGhsNXRHNC9uREJYV1dvMXRwb0RPRlJQYmd1S0g5OURGeXlG?=
 =?utf-8?B?amI1NUhlYkQ5YThKUEwwcFluYzAxMXh1VW9kVXVFeVY5a0trRzBiSU5DOThq?=
 =?utf-8?B?RXRyempYZDFyYjlwZW9XVWF1TDRWUEpTUGQyTFVQZm83WHkvemd6aVd1YmU5?=
 =?utf-8?B?akhsRzFJa2ZVOEVydWkvS25yTGdBeFhlS1didkdyZGc5YjM5cno3WE9WaUFU?=
 =?utf-8?B?MWV2VFhPb2RSUXhxRWpITzZYQzNLZUFrUS85WFR3THJXdXdCb0tLYndRYnBB?=
 =?utf-8?B?ZmhmMjhwME0zWG5KTEhuVDQ2SUVlMUdqeTVES1ZQUjlDRS9BbU1iSU1nK0Vk?=
 =?utf-8?B?QUIvRERIY3VVekIvczZOS09iVm1adkNDdWgwd0lnMFhZTWxELy96QnFoNzlF?=
 =?utf-8?B?NGRtcFB3ZERuRkRsMHA1NXlrYUNOaVlDaWRrV0xqYTh0M1ZpY0RudDZaeDJh?=
 =?utf-8?B?MjhyTjAzZ1JJYy9UVHdzRWhaM1hRNnRwNXdqdmxXM2NJenV6OUlNTDJCUmtj?=
 =?utf-8?B?T3pRS2IzY1ZwdG1HZVVtdDVxQzM5cUxzUGU5clpCS016VGVDcnBZQVhMYWl0?=
 =?utf-8?B?d2hPaFB4aEZDOUxyYXRiWVBmbUg1ejg5QzB1MkU0Tmt0LzBRSk1XOXFDUGNQ?=
 =?utf-8?B?TTZlbFhhZjEwMTJNQVArY2VqN0laTXpWTjBucXl3VDdKYWlwU2pBTGF4VGdy?=
 =?utf-8?B?V1JKb0g2cTd1alZWSFBrZlJ6dFVsMWFPTTRTQzBrd2d2ejBGVEROSGpZZGNs?=
 =?utf-8?B?TVBoQ3FEZy9ienRidE00Y0J3bGJaK0tjQ3BZczdaNTRCUTMzOWhlUGo4Uis0?=
 =?utf-8?B?ZFRwcE1xemlqcXV4amJoVERnTUk3MWF1VEtEWlorKzAva3E1MFluWmIwWHhC?=
 =?utf-8?B?Qk5sbVNKZjduRG45QjBaY1Z1Sm15OHVLbFAxOE1jL2RGWGgxNEdCaVBZTmFF?=
 =?utf-8?B?azFqd2NrVHVjOWNQblAyRElORkxETUdOZzRRS2FnZ2FESXlyL2FxVm54dW11?=
 =?utf-8?B?R052SXZ4Qk5nK3FGY1hRbVJMcWVXVzVwUVpSM1VmRisxT1VOTHlWN0RIZUpq?=
 =?utf-8?B?akZZNHJ2TXlyZjZPakdZL2xWTmNRWmZqVXg4d2NIQ0VyR3FDd0VFV0hNU2VX?=
 =?utf-8?B?WjdFcWc3ZkJ6WkwyeWp5S2ZWbTJvNkk3enRTWGJ2SG1NbnFCbHVsRzBVWWc0?=
 =?utf-8?B?ZEZLZjJRUkgvRDc3bklOaG9hVUtrSmxQNytKT2JVUklvTHdGUDUzc2t3bzA4?=
 =?utf-8?B?ajdMYkVOOVZQcSt0M29wZTl5S0hUZnFNVk03ZWFuL3JkYXdzRG03a2c2WExQ?=
 =?utf-8?B?TUZ4a3lDNzNWbFZIZVBrYXd4YVVsWmJGVzlaY3BpdGQzV1ZNd1M0Z2t6QXVz?=
 =?utf-8?B?NmhsL2dZODZOV2xpWEZPYWU2c3EyZGZxMEpwMnZUTW9VQ2laWnpjMEVtOEdE?=
 =?utf-8?Q?dFMhfrKvHr3CqTKmuNLnxnB7I?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fbe839-1c42-46f2-f56a-08dd817d6a0c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 09:09:40.9672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y82rjPNtHUvMNZup/oSP7N76vyhd+vBDM6g378YzL26GKpyZX+ERb3n/Udgpwe/BzGponym4RMzVli5/2D2y1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7022
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Apr 2025 09:09:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18543

On 22.04.25 10:51, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
> Hi cip-dev community,
> 
> Following RFC is not specific to isar-cip-core, but to the upgrade method we are using. So, maybe some of you are facing similar issues...
> 
> The default update strategy updates the immutable partitions in an A/B scheme. Typically, the persistent data is kept as is (at least in the majority of use cases).
> Some exceptions exist where minor changes (of small parts of /var) are supported by packages linking data from /var to the immutable partitions using tempfile.d aso.
> 
> That leads to the following problem:
> 
> Once we added users to the image with data on the persistent partition /var the UIDs/GIDs must remain consistent forever.
> In case package order changes, or new user accounts get created in between, this could potentially results in a shift of those ids.
> Since we only upgrade the immutable parts of the system data on /var remains with privileges for owners and groups as they were before the update.
> Thus, resulting in a privilege mixup on /var after upgrades.
> 
> To (partially) fix that problem multiple options exist:
> 
> 1. Define fixed UID/GID sets for our users.
> While this helps with our own packages, it keeps the problem when using unmodified upstream packages not using static ids for uid and gid (e.g. wfx)
> 
> 2. Use tmpfile.d to modify ownerships on /var accordingly.
> While this also fixes issues with upstream packages, it requires additional tooling / automation to keep it consistent with the ongoing image development. 
> e.g. ROOTFS_POSTPROCESS_COMMAND or similar.
> 
> 3. Use a static predefined /etc/passwd file like in base-passwd.
> Unfortunately, this does not scale very well, so we need to know all possible user accounts in advance.
> And further, we have to ensure, that we never change UIDs GIDs (unintentionally) in that file as well.
> 
> Any recommendations how to mitigate that issue?
> 

First quick thought: Can't we automate this, at least partly? After
version 0 build of an image, extract the user&group lists with IDs and
use that at base (like in option 3) for succeeding builds? If version 1
adds another user, that would update the base list for version 2, and so on.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

