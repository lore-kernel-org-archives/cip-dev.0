Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86484E91285
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 07:04:29 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15355.1770275065069597059
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Feb 2026 23:04:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ny4ypt51;
 spf=pass (domain: siemens.com, ip: 52.101.84.12, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbNZMuiRhkxtBSPPjFJZBvq66MQl2+lzJ8+r2YiVHZEtROJgOArV38Uk7ttwgSznESJI+7kpNbmNsurIKruUjHHEC/iy4c1MwxJwSV7/gBZ+Wa0bD6iS5Dkce83ZJXfrXEFKWoBBLydTk91u9xPbeuZUevUYVQx/vQFIrv3hu5qeRXc4VsTKzAT9iLx62gb/FPJcj/h5PdH7tExwM1cVAVcieOYexg4ckI1Z4t3p0enSUU1UxhhM6Na6LSCZNxTTf2bBO9hGhpDtHvz2fc2f2LMvtY/NhCLCs58KNNGBt06kxXXw+mItYgIgXN+HXA/aEYcgL6PKNQxRjElhbhNnoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WnNNHK+wWJNS4PNkJ0piRaGdwYLORuDcXTYWZrDSSA=;
 b=O3ApN2OUOP1zDGacaJybM8h9dcyP70yhtMi/xCnktw8YGYzBMjuNodF4DVlYbFe8da47f4Ipik1v6jLa2bTb/PbrOkbvh9RZ9znO3u/W4l9FEHf5Z7RAKurre1ZJLzlHs/wF2+TO2rHF3cQIRRxON2GG4YZ+ipqysDzVUAP6LpuuxS/bk9o50h/aK4NtA/Kn9yRlkjk2HTtCzgXXg1pn/PsmrceCoKq0uiD1G8DEUKUahxN017yQXsQT3aVVN+G62/VJXm6kzmLb1fC4z8MazCiUk1CQhNkHnLDItERQ751ut2QD9QpQoJkRELUvKbdiolRxqn2rfpEhX3x1qevj8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WnNNHK+wWJNS4PNkJ0piRaGdwYLORuDcXTYWZrDSSA=;
 b=Ny4ypt51uFaXEetmSVsg9bfxIEYytIp3XO2gBI4qwVQ/uYUQQ2hez2sqNS7NqQH1ySChEGS27IhGGT3m6qZZ1bgCiGavaOzakyUp8a82Br0v18pFSuFk+fRNAl4KXmVhIdrcxkSrx8YCLJl+/IdcJMBKXJYClIjjX7xZ3mplVAgJMoTp17LDjPNNHdfRMasGMlGuVaW8b3LbivKI5vQQy/ka+EcV9Q4ImrmXmyYLCsPPD6V7tzVIJnppHZI30uPqjpE9nvoWS151GGkdmijlwNq0EdAs8wmsmRVnGj2TUSiKW3QLLYhP4YjhmRReZKNxBxwybAoNzBtWhPSbzYQ97Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AM4PR10MB9422.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 07:04:21 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Thu, 5 Feb 2026
 07:04:21 +0000
Message-ID: <173c6605-0042-445c-b9b9-3e4a82be5b1e@siemens.com>
Date: Thu, 5 Feb 2026 08:04:19 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip107 and
 4.19.325-cip128[-rt46]
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::10) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AM4PR10MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: c43e3d3f-3674-4aea-c00f-08de6484c944
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b0NGV2F0Z29IUGVJeExCZ29DS1FOYWQ1ZXl0cjAxc1NvMzNOUFcrUUpZQXdG?=
 =?utf-8?B?UjNvT2lyNmhEOTlZNk91eUNHcjREZ2J0alF1U0JSbUFJSWkwTFl2UFpYc1lF?=
 =?utf-8?B?bWdDWEZLNjZrQW1oVXNZVjlHcnBOd1QrZGlNS0hXSTFqaVgzVjVaRVc4TlU0?=
 =?utf-8?B?NjY2elVmWHRxd2pmQlE1ckhkZ3ZDMW53YWh6L1dkOHIwSTlZUFN4b21WWmhX?=
 =?utf-8?B?b2dPY3dnYWxaR0RXUWhjN2dIWHlzU3oyd2Fid0Jjc3VmTFBGTVFrcUFpUDlR?=
 =?utf-8?B?ZWUxckFsU09pdDkzcmxTYlBqYWFNQ01aVWZHZXA0WXZhRUdPdW91V1FkUUsx?=
 =?utf-8?B?UzdieVVzMXNKZFprZ2JCZ1FoVGFuSTZvZk42bDVmYVM0YVNRS2JyVFk1dzM5?=
 =?utf-8?B?T2c0QkpxSFl0Z0JtNzFncXRESEFtRWNaazBXNTZlWUpqd0xQNDRvdFVXaVpY?=
 =?utf-8?B?eEd3Y3FHMUx4YmU4K3czRG0xM1g2K0tWdXBWUGRvRDF1cUdielNzdWJjNzA1?=
 =?utf-8?B?RGpkMzBQd250OXpOV1RYazA1RzdZcWpPS1NBaFBFeHJEZmpHRU8vK21BbGgy?=
 =?utf-8?B?UlpydmVWUWs2eTBoNDl4Wk5OeFRuT1JWbFBkZVVKTGdPTC9UZnlDMXh1SjR3?=
 =?utf-8?B?VkFic2QvUFc4UmtsTEc0Zi83UktTTE5aQVcyZFBjTCtrQVBBTkt3UmNWd1J6?=
 =?utf-8?B?eUZ6NHRMWE5YSEZlNjhLeEw4VlZXYk9HMmFEd1FnZFp6NnNxcjQ0Qk45UjFn?=
 =?utf-8?B?N1BFaExHYXlyT0FVa0U1bU1JQ09sZHA4OC92U296NHBEYXRVWGpPcUlIQndG?=
 =?utf-8?B?VW9UQk9HVGtVRUk0MEpDWmIyNWFLdzVMWnpBUWlCeWJKeUd4NURIcUFTSmFs?=
 =?utf-8?B?MlZHb05UZG80Nk1sRkJDc2VSR09mTnNFdUJjQTQyRjRZSWhxUTV3dk9IS2pv?=
 =?utf-8?B?dUVjN0NGZ00zaHdXSXo3bnlFL1FFVGxqWlVYdTgrNkJPS0hsbHVOVVNLOHZ3?=
 =?utf-8?B?MEpoTXcvdTFmZUtVZlpkZ3crQXM5SE01Qk5zOFBBbnRjNkZyYkRsT0pkMUt5?=
 =?utf-8?B?QkhYdUhJdDllVTQ2bS9kb3R5NEtXSkRnV1ZvMVRiT2NHL2c0YmJBT1ZtV1Vl?=
 =?utf-8?B?bHhDZHpraGRyMFBwRCtlNzdKRDFtTmtXaHNSSjcvVHBORHNQdG5jSVc4Q28w?=
 =?utf-8?B?T056cEduMHB6MWNTOFpSdEMySmd0ZklMUkVWcy9TSEw4MVlTdWZzWDNiRTVX?=
 =?utf-8?B?QjlLSElQaS9FcDhhbGlXNlpKQmE0dkZjaXVPUDNMbTNBSlM0RHRsNEcycGdo?=
 =?utf-8?B?TlM2T29SclVjVDJNNDMzTGMrMDM5ZHpoS2Q0NVdCYVpLRE5IL2ZoYSt6cmxm?=
 =?utf-8?B?TmZpZGdMS2gybWNDMm9hMnNaaUtaYTFMb3BMNzYyU09lVWJSVDBEbFU0U3Ba?=
 =?utf-8?B?cmdIVExHWk5XVUx6WGJiUnFTTWcwZkVRa05xemJWSk84Q1puSnRRUkc3a0xU?=
 =?utf-8?B?ZU1vRmZ0czl3WFQxVmpSeE1SZ1J5QUlTRGl0VVhucERVNm9CNFE2YUR4eVRv?=
 =?utf-8?B?cTloamVITUE5VXVXVEE1WmtGQTdzU1M0TlNHQ2lwU1BaOXZSdXFoR25JVzlJ?=
 =?utf-8?B?emFCaVg2Nml2MWZlRmtIWjlESTlFclMxeHlMQXlwNUlyaTJIRUwrMEgyaEdT?=
 =?utf-8?B?dm1lN2VGWUY0SnZEWFdLcFU1emNzVU5mb1kxckFhWXlqZDRRdGU2ZGt2R3pM?=
 =?utf-8?B?R29NbTNWazlqZ3pnZHFnUW5lb3hxcHNMZThCM01NUUlvQWFCK2xxN01zM0JQ?=
 =?utf-8?B?TXlIS3lTVzA0b01hR3FMeDRLazdkZXpHYWpYbnNXY1czcEM5Mk1WSWliQThW?=
 =?utf-8?B?Y2J6cXdjQU1PQlFDUWJ5Z3JkZ2Q4cHJrVVY5ZHA5ZDd0SjRYVlVlZkZ2endT?=
 =?utf-8?B?MnJIKytKUm0rRDFtYncvc1pYTHlMaStmYlVZV1RCNDROK3Jva3NHNm9RaFRQ?=
 =?utf-8?B?TE1ScC9Id3QrMGxsckVIRHBvbzhSbDE5Q2VQdHphWFZpaHhhNEJiL091UmhL?=
 =?utf-8?B?MGYxOGc5VUZJMlBGV2RBSFdUVDhzY1lTUXIvZExNbG85R3ZmNFRXamJtSER3?=
 =?utf-8?Q?tzuI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cDMydkxMOS82ZXNXWFh2U3ZaNWp4TytWeCtzblhXRjRZbzBxZ09ZSVMxd1A4?=
 =?utf-8?B?cjJSR1NFazNEdi9jTkN0bjdXS1hNd0RpaTduMEp4Uk01YkFxV0U5d01udTJU?=
 =?utf-8?B?YWcyZzFJN2hHaWZJalZHcklBekFOaVp6SFcxR3p5ejVWTk9zZjN2NXNTREEx?=
 =?utf-8?B?UU9KYWxzci9RUHVnVTJHcWRFa0R6MHZseWpYdXpPOU42MVgrS1M1cVNDRnVk?=
 =?utf-8?B?Uysrd01mWTNURzAyQ0pzV3RnRDk4eXMycUhPQlhRTnVMbUk3RWcxMTRxc0lE?=
 =?utf-8?B?UHU4Y2VFVk90bU1DSjdCajN0dy9ianptSGxRejN6WHRkbGxOR0krajNRVnU1?=
 =?utf-8?B?blNIbU5sOGN5aUNxWGUzQjU5ODc2SzliRFM2eUpGbW9HTzI0M3hGRmVwSGhq?=
 =?utf-8?B?dDBPcTVsWnB0dEVBNTQrYUJPcC9XZkcxdjl2RFViRklFb3pYR0tUTmp6S2xU?=
 =?utf-8?B?RHFka0YxZlp5eWo5Uy84N2hDM2RLVEZzOTh3UVlkL0o4dkFLZEJGRW5sT1hZ?=
 =?utf-8?B?QTNFSjdBVXhjSDFoY3YvZWszeVRNMjRkc1diUm9uTnNGOG5FWGppSytnWFg4?=
 =?utf-8?B?WUxKR21FU3JLMUlUM0x0d2M4dVU4eEdTRDVsRTBiMWpuWGtDMGxyZU56TGl2?=
 =?utf-8?B?OG8rKzh3MEIxbjhiblZQOVBxNTRaampucnVIemY2aGhzWFFLRFA2STNtbFlG?=
 =?utf-8?B?VW9SL0FyMTE4SEE3RmNBSkxodWViZDl6eHpCdTRsQ2t2eVhkUU45L0ZlbDMx?=
 =?utf-8?B?ZGp0SVh6cGpDelh2ZFZlWDM2UGFxZ3B0TnRyVWIySkZsL2RaQVJKMmpNQmpm?=
 =?utf-8?B?cERNYnZjRGlZVGtydFYrRVMveG5ubjNZOThKWlpabFVSN3l3SEFtVXg1RDU3?=
 =?utf-8?B?dW1JRStVZVl5V2oyTEJMSnhUdHcwMmdiVWY0V2UzckFNdkFneldTWXRNYVRM?=
 =?utf-8?B?NGNKcDlZSUFnQ245U2MzcVVnbGpvSGtMMUVxR2Vja2VwYnIrVmdETUJub201?=
 =?utf-8?B?bmp1UGpQemFGclVrbE5pNTdBblJ6RUFhUEt3a1lrTE1lRWpCSUF1K0tteklz?=
 =?utf-8?B?bmRuZEc4QzB5YlQzeW1COW5nT1lYWndpWkZ6NVVWSDVJR1lLZ0VsV2FSdHhh?=
 =?utf-8?B?dWd0Tzd4MDNmQmZVQTVMaFJ3bC9ncGdtUm81MDRoMTVWd3FrVThDallwY2hN?=
 =?utf-8?B?Tlc4eGREVi9VR0FuY1FIWG1teVoxWnBvUFF1Q0JML2loc2NYTStGYUVjWUsz?=
 =?utf-8?B?Z0lnbEwweHU2TFBrR1hGZGhGNGxudG15eFNhdWNQU1FrUVFZeHJoWlNNeWJm?=
 =?utf-8?B?MnVmdERoWVNIaUxmV2ROVHRZZTRXbndwYnFwTzJLVTFRQk0xQjM1WnJDR0p0?=
 =?utf-8?B?MUl2YXMySDdnRXREQTk2RnR4UGIyYTlrdFhDaGs1dlJZY3I1K3k4QUZ2TmZu?=
 =?utf-8?B?aHNGOVVxSFN5Uno0eHJhVW9xb0JUd3ZFaWdHMDcxOGVqVld1bVpFenJ5WjB2?=
 =?utf-8?B?d0xXNHI3ZVZkZEp6bjZKRU1Sd3hrK3dsbXY3S25qekNPSUF1TXBCYmhxMjVh?=
 =?utf-8?B?RjF4dXo0TGJhNUtBaHFMdHJTdWgwcDJWWjlIUXNvSElYbVREd2RMc0k1VXlv?=
 =?utf-8?B?RkZFaFNNQ3RoSjNqQUdUeVlMWnZMNjh0akNDRXVDR0RORjlobmhwVWlqV1NN?=
 =?utf-8?B?ajdsZWhLNXV5Zit0czlkdTBZdlpVekJNcXdqOHR1dkpuMjlOeng4K01PVkI5?=
 =?utf-8?B?b2J6UWFCaEZ5TFRsZFVJbENRUTlOdzluOWcwdFd1NUdhMFNhdG1MbEpFSUE0?=
 =?utf-8?B?QVFLdlFqK09mU2RXcFNKNGRJUmkyMzMxcFZ4b2RJU0g5TnpTKzJoeXFUSW5F?=
 =?utf-8?B?QmN0YmtYa09xVXVCdytIRE1kUXB6RkttZjhwRitsQWl0dmQyTVd1TnErRlJ1?=
 =?utf-8?B?WGxoL3h5enRDMGY1WmtsYmdWV2lNYVVLc21SNU43SGl5ODAreTJkOGJ6dXhZ?=
 =?utf-8?B?VkZ5UkdqdENlZ05xZUlEaVFvUzN2akE3UExsMG1pMUt1QkRkbG1la3FOVWps?=
 =?utf-8?B?OEJ1SzM0SjlLeGYxZGp1eVF3dXViODg0bG5wUHFBOStITHcyMGxDM0E1MDBN?=
 =?utf-8?B?YmNsSmJqWVRPV3Iva0htTmtJUm54Zkc1bkNwb2ZrenNiNFZxNmFXQVF4QUhP?=
 =?utf-8?B?R2dZRDJaSjVmWG5wRWxydDJEOU5ja2JkcEI0T0ZrS09yUFIvMjI5ZmFLQTZj?=
 =?utf-8?B?MnUzZStxR0RWbG1VMzgrc3ZrUjVtbUM4OTdIZlZrMGxwc3ZDeGlSYmN6eHBG?=
 =?utf-8?B?bDA4eXNMRkFQNk14M2VIeGRvK0REZFJrUkIxYllrM0czRU5YUk1Ldz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43e3d3f-3674-4aea-c00f-08de6484c944
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 07:04:21.0509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8r6XM+kvmn3SACYdMjgsNM0i96EEE4oh3Br9L6bXSX1Lg9rApINtBv00PE7XK55XF3A4Oo5KnZy9tCzI0g/fAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9422
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Feb 2026 07:04:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21834

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ....325-cip126-rt45.bb => linux-cip-rt_4.19.325-cip128-rt46.bb} | 2 +-
 ...inux-cip_4.19.325-cip127.bb => linux-cip_4.19.325-cip128.bb} | 2 +-
 ...{linux-cip_4.4.302-cip106.bb => linux-cip_4.4.302-cip107.bb} | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.325-cip126-rt45.bb => linux-cip-rt_4.19.325-cip128-rt46.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip127.bb => linux-cip_4.19.325-cip128.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip106.bb => linux-cip_4.4.302-cip107.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip126-rt45.bb b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip128-rt46.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.325-cip126-rt45.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.325-cip128-rt46.bb
index 34a83b3a..797fb2fd 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip126-rt45.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip128-rt46.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "b4be712efee191bc40c20927455d33d4b97e3f8ec5c504deb26bdd29f94801c1"
+SRC_URI[sha256sum] = "0539a3a10ae010acb15803832986bc4a6cf403b75a6a289f9e045679add7f216"
diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip127.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip128.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip127.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip128.bb
index 9913a122..f16d35e6 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip127.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip128.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "e1729063636977feb5d570009b4affab04206ad7d8a111a9a7f574e71d6d611a"
+SRC_URI[sha256sum] = "5b2a2f4b702a458732d91cc549995cf6ebb374fae20f5192915be635eeaf3080"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip106.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip107.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip106.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip107.bb
index b543d1bb..6dca756d 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip106.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip107.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "4d41ccaf4ed1fc0f599289d83a4687c26aebff2a107c8d3e061fe21308e12792"
+SRC_URI[sha256sum] = "24abafde968a6978fce5963cabae040825f891f463aef3d23c74d7263a6dd34b"
-- 
2.51.0


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

