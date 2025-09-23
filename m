Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1646CAC5A5
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 05:48:58 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.65])
 by mx.groups.io with SMTP id smtpd.web10.10103.1758606532785824660
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Sep 2025 22:48:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=T/iN12/6;
 spf=pass (domain: siemens.com, ip: 40.107.159.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pywelqS1xw8Grk7+mklFUE0v9BKamBYjzIqAC9kgrapbrAtFI0Ee+Tv8RLqCmdnEVtmaududD7mcRrz+icYHJxxEmm0dJiPP74phDzQg0jZyEnvgOa0xViIs0PdOWKQz4YKJQ7OxIPNEJYRmK8a/G+ekS7ji3eeXZ0KZq6mDdxCcG9UbsrWKubpIfGZ2ZI1iZ14OYsFiCMnR8IxuwnzM5A2xM3Sl94IdP92R8IQf/z5RhqeHIPDp62S+HNHiNp/f+7lGfzGrOW4/F4Ahmky5SSUdxc1fhOVX0tglsruDNq7YD01O7xpdfGRHuVE4NfJkSSkZI2sbNreWcskDgroeyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kZBQ6v58MEjVh7qWC2qnOVt2iZ2ksfXz64k9DhwxlQ=;
 b=IvEk6vr5EY5ovvDxFizyeItET5KgzGuZWuXXPqQs+zOXWeejuRAnhO7U0i18sCeiNNUKJNYjphp7vyCKqoGe26vv7YssoTAsCfeRsGuH9zPNkBFKZwu5Lk1kGkDlvBIdpQj/AQf9z4LFXq6CzhTJRpHwaVwtB5QnihooJ5pZb4pBnJ6sxd90PTg7SgHb8tMGSJMq8aqmshGArl2OJMvIQfcuLZawtkbeby4Tae/F+RE7APXf9N2lncZphbON/jDwYGkOZOEpYoAYHFYCdz7mLWchxUiYa9HExyQ34VkEJ7GRpJLnXzY3rTYBFCEr5FP8P28UIH6zGYlq6aYoFWlUTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kZBQ6v58MEjVh7qWC2qnOVt2iZ2ksfXz64k9DhwxlQ=;
 b=T/iN12/6peWrMA4G0rUQ5UlIiy5VQ7A9enparBIynMDQ/COP4wcq3AV2jJRW4PVkgyaM0ZJineAZNPB24bHeM96T7kfbSrH2jsCairzG4aIso9pzfy0cZIZFAocviaCHGvXINjkl16UL0R0Et1jvo3dcYFP9KpzfIHVwgPx4sUccE2RA3bG1blBVVxPJmwMJCLuAvU7VRWfKT8lQxPibfNCLUum8BDAqM9NRhhk3NbpbE4o8+85j+cs3N2Eak+9/Jw4qH0zzYWRscdriiJLgLI186UloFETwgBh6m5Gl5RYubaia2YSX0Ah7NR63dNmzTQS7RhrpcTttsG0WqPn14w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6654.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:402::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 05:48:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 05:48:48 +0000
Message-ID: <34d91e2e-3224-482e-8f6b-f50a41bb4170@siemens.com>
Date: Tue, 23 Sep 2025 07:48:42 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: isar-cip-core feature freeze ahead
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 25aa2a60-12aa-4beb-68ff-08ddfa64ddcd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cFhyOGJsSGFoSWtzT2dUOTBlMW83MkhUTlk0YkRiWDBvNEpDVEt2K2pJV1VZ?=
 =?utf-8?B?WkV0MUJaUm0vTzEzSndreWNQdTdwaDg0eUZ1TjQ0L0ZEOVJ6WEtwSkdMRkZo?=
 =?utf-8?B?c3ozbnJja2F1RGttdmxZNUxZcmoyampDL2JyTW5MNEtGSlVGVkt1bjhpekZj?=
 =?utf-8?B?TjgxTUcvWm8wUytYbERQaHovbzZ3L3dzNUlhNHFlYzRiTkt6SGdGTld3RTBj?=
 =?utf-8?B?eXM0THhlZTgwZTYwZ0o3T0JJYlBDRGNjT2hWSEZWclNyZWZvZU9hSzZZTURm?=
 =?utf-8?B?MU9ZK25nTUM4dHprdDVuc0xqa0l4ejlXZWxHcnFMQk5TRlptbjVTK1ZPQzVL?=
 =?utf-8?B?d1lNQTBEbmRXd2phZEFVK0lYYk5HWjBBM0Y5bDlpSThsNWlRanhYL3puN3Vk?=
 =?utf-8?B?ZGEyYXZXaGFObk1yUEFkZUowOGFxQzlnN3pwSWZoSldWQmt1TDFMVFBxY0p6?=
 =?utf-8?B?QmJ2c0FSQ1ZFczFVU0Foa2hQTHlkUHNRdDBQL09WM0VsWS8zMVJvY0N3YnJX?=
 =?utf-8?B?QkFYbk5EVXNYNFNtenMrU21RUEZVMy9YOEQwN1VPMDR0d2sveHJCNUJmTStM?=
 =?utf-8?B?R3BqdW03aHF4WVBndWlFTnM3USsrRll4OUJEZFZhcWRWanBMWDBraUVEaG15?=
 =?utf-8?B?OU1mQ0ROUHNsOEU5c1VvQlYzQWFzNmw0TUxXaUlrOUFEalpUanlQV2lJMEhE?=
 =?utf-8?B?dFdqVU1QQjAxSXpsakprY0xsZnA2UU1Wb0hMRWQyaEZUM2JxbGp0Wi8ycHAy?=
 =?utf-8?B?WlZ5b3RldEE5eHZRVWNoc3F2VUkyTUcrYlNmUXhsSDZRUjVjNFM0bXdpSTE3?=
 =?utf-8?B?aVJYYVNMWkRYOGpLcUtRaUdRclNnVkZVWVZNazVVaTBQRTRra3hZVDd3c1pO?=
 =?utf-8?B?MUsvaHdGV3RTL0dFeTRzeDJmdzZIcFVmZ0t2WlJYMmM1MHNIKzU3S3hzbDdT?=
 =?utf-8?B?R2tpOHFnajIrUStaV1loMlhzUjYxOXRxSjZmK05hMkQ1d3BLbVBFVGlLRDNV?=
 =?utf-8?B?ZWo5K29CQXVwaE80NGVYNktGT2hYTmpMaGtDS0hQMVhrTzN1azNOVXduaG9w?=
 =?utf-8?B?RE9IN2tTRU03ZTJScUQ1NFI4UDN6Mjl0M2ZocXpIM1grVG1PUXFVeEV4Uy9Q?=
 =?utf-8?B?OTgzVzVWWGk4TU1kbE1kQ2JsZURFcWlXdXd2L0k5SnRCVjZQdFI0TVl5d0hR?=
 =?utf-8?B?SGxhREFXWGJvWVhpdDhrSDd4UXpyUklITWpxbXlPeXVpdTRienRoamU2TGg2?=
 =?utf-8?B?b1VVazE5dFlGR3dXSWNvQ3pnRDhTMStZMUR6VExKdGNVaWFMQVQ1NjYyNURF?=
 =?utf-8?B?OXZmeTNhUGxFWmdrdWg4b1plRWhhSFZjdnRqdGF1eWlSeGJTTmZBQkNndDRI?=
 =?utf-8?B?d3FDaGdKbHA1SjJWSUsraG5iaE9CeU11WU5QRXExTjQ5OForSW5NZUs4Q0Jl?=
 =?utf-8?B?WWhIV2NZL1lUQU9KWmsyV3NkL2ZmNDB5RWVSbG1LYy9SeE5HejFYUjI1MUZW?=
 =?utf-8?B?ZUExdXhLbUNpK2dsYTVLdm5kNTkyNWxvc2lDcnplTzJzRHIrUDk3cER5NSt1?=
 =?utf-8?B?Y2lYSEtDamZuR0g0VTUwcFpLSWRnWXdacjZRYzF1dEx0MlFnbmczMXM2SGND?=
 =?utf-8?B?SG5STU5jNHBVemltNmtGWmFLS0g2RkFKVkhHbUdEV3hhM1UrbVFwU0o2RmVH?=
 =?utf-8?B?MzZJdm82UzhrWkZDQVJHcThHNmZSWkRQNk5ic2VpV29UWktNMlhVWUwxRVlS?=
 =?utf-8?B?MU9TOGd1cEVJUDBrTHdmNnpaVStoYXJtSStmUC9qT09yOU5kLzdJVUtxSVp4?=
 =?utf-8?B?SDg5OWx1eHdEWmRrMjNxQnlpbWx0SnpPSVA1VzBIeHZCdDRYa1ZVSHRLcS9L?=
 =?utf-8?B?bTlWZ2x1cHlzRkoyN0pIandkK3JDaEpIWWlJZ1o1SEhneVQvSlgySjJzQU1s?=
 =?utf-8?Q?rh82CVNDXXQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cVZtTG1RaXNNcEVYdWxDek5SL2ZuN2dBOXZBU05lWWFUY3RyNHNVbW5SWE56?=
 =?utf-8?B?UmhEMjBqUWg0WTQ0Ymx5MUowL053akpRMU5MTCtvdjZPZG5WQysvcVNoRksw?=
 =?utf-8?B?b1VLUnJYK3k0Tlo5aUxQUmZjZTdUTTN3OW93eXE4UWlIVHpCanY2dkc3djB1?=
 =?utf-8?B?cWswR1oxNFQrL0l4NUhwQThDOGIrU3RmZmxUK3kxVUdkQXVvRHNpc3FicFE4?=
 =?utf-8?B?U1pmRVUzeUZYbVNGcE5mL3o2cXdFN3kzWTI2Um81SEpDZktpYjhzVTU3ZzJp?=
 =?utf-8?B?bXhCL2htaGhldzgyb0Fqbzk3Z0hhSWlBZXg2QW8zNzV2NklPWC9DUng5NFkw?=
 =?utf-8?B?K3VySkZmUTdQVVAvT3FZUThmelRGMktQT214QTgyRkpMN2FBeGhsVlpuU0pz?=
 =?utf-8?B?MzJNMTByRmNJRURpREo5Ukx3UE9raW9vSHZkUUI2RkZ6S0lyQjQzaFVNenV2?=
 =?utf-8?B?UHZLNjMrbFBYVjVOaVdzaWxBYTFoLy9QUXZKN2tvS0Vqa2ZiNnN4aXRVYkNG?=
 =?utf-8?B?MG1mN3BGYVA0dWhUWHlXNDNGc2kzT3g3ejFIOXN4TDlSc0RDdW1TRU9wWUx1?=
 =?utf-8?B?eFVyZDc5Y0x5ZWVPYWlRRzR0TmhhRDVWTWRUblBnVzM3WjVZVG5mZXMzSExS?=
 =?utf-8?B?SG5QV3dqOE9ZcGdGMTluamt6c0Q1ME52T0F6eE45dThKdGVuNWJhclRUdHUz?=
 =?utf-8?B?d2w0eWJmd1V5TjMrRUxNRXMvakIwUUFadklEblorc1Yyeklobk5VZyt5dGdv?=
 =?utf-8?B?cUFYVHpIZlFQMExyZmp2NGgxQkM3V3duUytxWStqeGU3aUs0aUVtSWhGdVps?=
 =?utf-8?B?c0N5NFZkT0g4NklVZnFOYUo3WlhIYWpFc05mNXh5UEtYTE9NUERJSmJJWnMz?=
 =?utf-8?B?czBMWVU2VnZPWjh5MFl0czJRY24vb2V1TTMvbGVFTlpCRDloL0ZxdlVaNGxl?=
 =?utf-8?B?Qlo4WG9BeG1CRWtzbzByQmlsUFJXSjZpNHVjSXplVzFPY0xPdk1IQjh1SnZT?=
 =?utf-8?B?NEdobTlGYXRhVFZUL3Fvcmp1eEE4ZEdtZjdkZTBsRnhBTE1pcUhocENSL0Mr?=
 =?utf-8?B?Y0VDRGJocWJqOVhHSTFMRVBwUnoraXQzSGRCM3lFdElIVWVGVjBLdVJTTFRU?=
 =?utf-8?B?VGtQaG1GSXlLWG1pdElaTDRZMmtYZXJPdTdUV1IwY3Rxd0NaSXJvcDlkemVU?=
 =?utf-8?B?bnRDWm1rNjNqNEUwNzVVc2J3eGpoZTRkZTBrZjVqVWJvT00xSDFZL1lQUnZL?=
 =?utf-8?B?YWhkcHBKMlp6MXpVak5taXE0TEJITDAvazNRUU1QWkdxUVZqUVRxK2RzTVZM?=
 =?utf-8?B?aHE5UmVXeGVJWVJuVEkzK09seHMwZ0NnbUErLzE5N3FNY0JzbENYNUZRL3dY?=
 =?utf-8?B?ZDFEZElPWks3NGUwbEFCZXJZZ0ZrRGhZU1c5T1k5UkNDcEZGYlJ2aStNa2Rj?=
 =?utf-8?B?bDhiUG5yb0MzNFpxUmR6cFhJL3NHOWcxZlNTZU8wZVJQZ2FnRGxwL2p1ZFBF?=
 =?utf-8?B?NDZVUUw2Q0w2OFRqUmpwK3Z1U3RqWXk1K1pQS2UrQkV2RGRtMWhreFBmUzlv?=
 =?utf-8?B?REo1STIyanVHUTdOWVFoZVhkeXl3WjFLMFNCRGd4Zmc1bzU4QTMxc3NEVm83?=
 =?utf-8?B?UjBoZXJiQ1JuSTZheWhoNWhtZUVTM1IzQ1oweU9xSDA5bGQ5OXcveC96dFBq?=
 =?utf-8?B?YTloeWM3Smt5QkNWTndvcldnQ2VnNXBPTEl5blNzRjU2ZHVTL3RQdFpvMktq?=
 =?utf-8?B?V2V6TndpNFRJYWRFUkdqMHhNUE9VM2c5ekdRaFd0Um9FaUdibkpPZnpBYzZp?=
 =?utf-8?B?TFB1YkVHMHB1Y0FGRWVnSXNZWDEwS0d0OVM1RDBERGFEWHRWTi9BVERuNkRt?=
 =?utf-8?B?MGpUaTJ4TDI5UE56djZEUHZMZmJYL1Q5LytSY2oyRTlUcm5xV0hMcUtDWVhD?=
 =?utf-8?B?WjJYU1dSTUZKU0psdHozbVJIQUJERTZlSVhxYi80a0l0VmJrc2JhR2hVbjhW?=
 =?utf-8?B?M2h6R0xRNXIwSlpMaXFqVmlGOEN6ekdZRHZVRExHRXFkZFVuVDYrenhnaXRB?=
 =?utf-8?B?VmRYQXU4T3BTYjVGTFM1T1UzMEo1cStQOUtoMXFvQlh4NGU4aUUzSUoxOXpl?=
 =?utf-8?Q?r4WhXJFLmNWMrcbl3DSotREjh?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25aa2a60-12aa-4beb-68ff-08ddfa64ddcd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 05:48:48.3673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LXZarH3cMnD1luSqpvpmiVwdUCxls21AlH5Qwo5v+Aut2ocYIIgv6RPNSAvEfAWbKjmfqF4/LKJNrACus8x1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6654
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Sep 2025 05:48:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20091

Hi all,

in order to get a 1.9 release done in early October, I planning the
freeze features via an rc1 end of this week. If anything was missed for
this so far, please speak up now / sent your patches soon.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


