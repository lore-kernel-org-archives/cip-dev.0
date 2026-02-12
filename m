Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533DFEB491B
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 12:33:34 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44353.1770899610211646234
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Feb 2026 04:33:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xd+amX5u;
 spf=pass (domain: siemens.com, ip: 52.101.69.14, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d6jrgLZltcPWuCtiUzYtrP21+IiwFdje1hjXGbEpolMNLJlTCki5g8ribbaNVHssmyWDRQkQLCxJaPMf1jt9+YfxJQ6mSQPMMfHKlLU6+8FzJV/YiQOBgUVMJd7wdTU8niNfEC0WeltLH9MSk34JwvxhsSdaX2/IJLDUuEVyP1Zq3rpBpUSp34aPJoNMOw+Hr1e1yE5v3Q2a/v9dJMKglMeu6MVhIWA82yb2pd6VxPqdAW011IhPU8PZfytZnXVi5xaOM76o2egrzUyjLUkI3PT+WxQIvGPm3x6j7yy6PCnwZGAPQfkBVf6eeN8LJqtX392tr0t7ZYU1urADdj1K3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDRzsRZj/MqT/l2oWoI0UTLZY44cNdEJ93bZygY6IUk=;
 b=eN+qM0SNQ6NMz3b/0QgZ5AbPcNB/nkIxlQg9IvfXKzJVrFsTPVHxXaheQC+HOLbKpTMjgkry5eoWLIKVwCZiRyPYWvbYfcpQcsH6dtdCHnpDEMXuwe8TgDkszD5xLO7u+VcQNHT96NjNan4DvfmxTLN8yZ3/K4gmi1DMOiGkydnZCiGPqnEGpu2tFtOi6B+AhkjiU3RLouqFdaiTCytJGv62h4aONISH57Y9dVQOPekMTWciXsGfvYBri6GcYoP1A+vMXOHyJnxX2DRxsekn8vrFZ/Z7JYlKbBmBFVWseD+YX7lOd9mrP2elIl5e6mpbCvu3NoAF4P9mgbBHKWCQhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDRzsRZj/MqT/l2oWoI0UTLZY44cNdEJ93bZygY6IUk=;
 b=xd+amX5updW3ZYB8KIIlzh43FbEpX3zpEh5dyuQmEfBoielbo2Lwk3nHWhb3mylGtvEtrQrCQSPPUnbvDaD+3SPfZWqgM5gnWsHyCksEOuYgtkBVIxjSEuthRHHtBjnbxz3CnrcWsM5d+M8ZRRXdVP5yp1+wpyL4KG6coUC0co2DplPGQQaoro6QH/0ccXRdSRZJ1JCYEfizLso6CH90pO6fIeHOWYpiZYYFTCvwYpC4rFMblTkH3xpHSl/0wVv0xVuHksw2so5XaHo9zrO3nydjTYAhwwDaAGtjqGiaD9LVfbKCPcQxGuBRmd8YZ+4Vxm3dPgUv7X7B7tcT/nzCQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA3PR10MB9257.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Thu, 12 Feb
 2026 12:33:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9587.013; Thu, 12 Feb 2026
 12:33:26 +0000
Message-ID: <678993d5-c5bc-4e45-994d-6d0418d432c2@siemens.com>
Date: Thu, 12 Feb 2026 13:33:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 0/9] Add support for BeagleV-Fire
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org, Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
References: <cover.1770037068.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <cover.1770037068.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0291.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA3PR10MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 68cc172a-4805-4491-cccb-08de6a32eb0f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OGxyVGM3aE1jOUg5SUU0dWhYNHQ5YzZkNG1iOGN6YlIwUG0ydks4SmVDaXBP?=
 =?utf-8?B?ZTJqZHQ1QmhMQU9ManlSRTdoV3BGYVh6QnVKLzVSNzVBbUYrbFZ6bktYK1dE?=
 =?utf-8?B?bVZMbWN1QW9TenVKSnF2eWJvaXAreHdtNVNGbXBqREFnZDNtZDV0a3FiaDBJ?=
 =?utf-8?B?QngzZmduVmpFZm0zcWRVeWdrK0dtamFXK1NBRTErZmpuMlVFem8za0VRK0RS?=
 =?utf-8?B?UjJmZTMvZ29Nd1drbGhGLzNrZTZOdEhNTG9EUkFDMDNoZEJWNno4UEpSUUVu?=
 =?utf-8?B?dVpLc1cyWndUaTVsTmVDZS82cUtJN0VrRU5xZk9ZMEpKTjEyWC95UW54UmVo?=
 =?utf-8?B?ek1mdmVwcjQ3a25wSzQyK2w2cVBGRDFvN3lhVXhrR3pPKy9aZkY4cTZJaHJP?=
 =?utf-8?B?S214UmRxYXRjZ1YrbzY4RXFXdHFMTk90UXV1U1dUZ2sySGdMTDBuc2FlcHFK?=
 =?utf-8?B?ZytpdlgvSW5nZzdyS0M1b2RrZEtKR1h1dVIwUFk4Tk5jVjEyS0h0cVEwa0h6?=
 =?utf-8?B?RDlYbHdiRWM1QWZ4MTlLVVc1UTl0YUFpOFRkTTlrZWx6VWVmK25HN1ZuN2Fv?=
 =?utf-8?B?YVRvTGZmSFM3aUZ6aDgrelh3MG5zVXRvUDl4ZWkydXVNZG9FL1pCOEJHQmF4?=
 =?utf-8?B?UENkMEl3dlRiRUNnaEo2aWtOT2g5bytSVUN6TEdEd0hOYktOd0JHTHc4Y2pt?=
 =?utf-8?B?UzhrbzNHQXVyUllTeVdtVGZ1a040LzZ4V3dDYksrSVZIeElCZmZIS2RkRDdQ?=
 =?utf-8?B?bFMwUzk1NURGNXJEMFZ6T1RpOGs3WWo1QXlhdlVMZDZSY2ZqbWwyYlZDZ2Zu?=
 =?utf-8?B?bkZwdyswRXlEc2VaZ2ZVTGtjVmxqNG5hS29TbnNZcWt0S0lRc2w2NS9OS3Bt?=
 =?utf-8?B?NW1mUVYxTzF4V21iNlNNbXlpOG1XMi84UEs3V0YrZ21wZHlhZmxGOGVHMDRI?=
 =?utf-8?B?dTg1L05CK2F0SEZpUk5wbzEzb0hUTEdqWkZyNk9OZlEreFp3RjBtYkNpZ0tJ?=
 =?utf-8?B?eDY3ZWE4TG5OT05NdjM4QUM4bjQwaDg4RjlWcWhiS2ZoczNUSzlSRW54WmFj?=
 =?utf-8?B?TEJId3JQQkdJZ213cGtrRDdoY0FoelY4UXJ0SUp2dmtwNk9IbG1WOS9mTUN3?=
 =?utf-8?B?MUpHeVBoemc1UUNkYUNRZzAzL0R4Q2NXSnM1MjFLb1VnanpvMWJsa1lqRzdX?=
 =?utf-8?B?K0VaTTE3WmljSUE1QnUzeUdrNnpva2dKN1dsd21YUkdPbi9YMWFkS1Vab09t?=
 =?utf-8?B?bUdxaUlReXNqTlZVRUJabk5VZTQrdGxzWkY1YlMvN214dG5WTWlwS1RKS1FF?=
 =?utf-8?B?azVMQjVlQWd4VjRFRXVkai9hWEFyTE5aUlRFUFBBSi8zcjIyWUxmZ09EL0Rs?=
 =?utf-8?B?ckVNZ2xPYk42TVpyY0daRnNybU5nN2NmMXhOMEFTMUdpaG14ZWpWbnZGSjJS?=
 =?utf-8?B?UlM1QS81d3lSMTVnMnE0VXlsa0RQaEx2MmV2Y0svVWZ6TDYyY2JwNUx0MjZv?=
 =?utf-8?B?VllaT1FyYjBYQVVTaWJ4U2tIcTkzbTJWNGQ0NHRHWFNKN2YxYjlTcnNtbUYz?=
 =?utf-8?B?RlJxcWNGY0YyNTRlREF1eGhWbGt5d3l0V0pEb0hKZDczaUlPcjFFOE1NVkc0?=
 =?utf-8?B?NFIyeC80Y2hMamRlVVZKQjdNR3dlWDJ3MDhHYTNXSEtQeXoxZ2ZidU5NRUYw?=
 =?utf-8?B?bnE2UE9nWndrdEZSTTdsV0xhSUJBdG5Nc0JBZzloQ0lIaDRDbVhVbXhPYlI1?=
 =?utf-8?B?bjk0Rjl0endZOXRjQW4wQWhEZStNazJPWjMrK0NnenBwTm5GSDZDYWpZdFJn?=
 =?utf-8?B?a3l6QUExalRUNGtRbGxSWkFrMGJ3OVl3b3VDQ1pOS2JjYmtjQVNsNWdCUnAv?=
 =?utf-8?B?c1BVZnN1SC9MZnZOWlkxVGNuNktVakowMTBiN3dyVWtnUUlsd3RvMGMvNkdI?=
 =?utf-8?B?OEJqYmZMSDZEbGtkeWdCYzJqMysvb2tqaXQzdm1EL3BWdGpvNlFuUmFQREc2?=
 =?utf-8?B?THp4dkZzc0d1VzJHY3NsTnpyZHdFU2VjZWxUcDFmZlFReFVRa1drMkVyMjRn?=
 =?utf-8?B?R1B0dU5uZ0YxdlZKWjNhakcvL01MNTdQTWRRSFdVc0lJcGlOeG1acjNVYmI2?=
 =?utf-8?Q?2Ntw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WlFkVEkyNWRFS2VVTzY2djNDa21SSno4N0l2eDU1WDNrOGFpZlQvdGxVb3lV?=
 =?utf-8?B?S20xYVRLV2VVNzIrZTRCRStxNzJHcUR4NU1zTS80RDhrZ0FUNWhHRDlUWjQz?=
 =?utf-8?B?UFpsMk1QMzMydzM3Qk9vanhod2hVQ1hpTjkyak04VlZlb0JPRk1sa2xQbTVB?=
 =?utf-8?B?cDR1ck0zVlZ2NXpoaThHMHo1NkZCaFAzUEJJMlZ5TXNlcnRGT0lNWGN3UDIr?=
 =?utf-8?B?cHYvWTRSYkkvalU5TU5rVFVOTUZhQ0xOQ2I3dncxTzcyREtFSzYweTBBbHBH?=
 =?utf-8?B?aVZGdUdHYnk1TUNmdkUwMUpwMG9Gdnc1VVdGbkd4em5FeU9uUXgrbWJ0cTRO?=
 =?utf-8?B?ME9vK2Z4RlJRdWprT3lWdis4MXV4Sjd4bVpDRzBSWEV2NUhpZXFXRy9TL1A3?=
 =?utf-8?B?WjVkc21mZVRPa28zM01kcFo2LzVPTmptS2VSZzJzR25MQUY0MzZBaXcxVzF6?=
 =?utf-8?B?VkpBc0l0eUk4L0VZcVRtQnUwTGVOYnVLWEhHaUg5eElwdUNPeTB0Q0phTzdv?=
 =?utf-8?B?Q1hWdklvZU5TcjBhY3hQa3NRbmdCUTN6MmRRaXZKd2k5Z1VYUlR5RkY3ODJt?=
 =?utf-8?B?ZFd4emtmQjZTbnIrbHpzb0x4cUw4L3FCMmhjd2Rmd0srbzd2d2g0S2Y2Smtk?=
 =?utf-8?B?Z0lnV2VWeDFGU0o1N0thOFk0MzdPczlFeHFqaVNnelNJSUdrK3NCSzJ0SS9n?=
 =?utf-8?B?d1UvRWJSOXpoaFpORXJMSktkbkFVeG8rMzBJOWVTVjUxaS9ERFRxOGgyVDNv?=
 =?utf-8?B?REp3RERxdjdzZmtVK2NZZU40aW9PR0VQcm45ZU1IM0dkK0lTSG9WQk4wM3VX?=
 =?utf-8?B?R3JHc1UvcXBLRkxxMHBHSTNJeWFxdkNpNWtGbUVUOW5FZUhoWHlOQ0JjMzZ0?=
 =?utf-8?B?TTRlT0t2aUlBK0hqY3FjaEhEN29HTHVTbG9OMmk5U3FjUGZlVnFkTy9ZOURt?=
 =?utf-8?B?Sm8zTzJLb1U4RjE4TWJ0SjJERDRINXFaWjl5ZkNpRU1jbHUrVFVpajFhK2pD?=
 =?utf-8?B?QTZRQkNvcHcwMWlsWWFkK011T05Sc3hwdVRnMnk4anNma2QyNW9uekJIWDJl?=
 =?utf-8?B?TFNRNkRDbjJBdzk2cTIyVUpwVTVFclkxdHUvSGloK1V1N3VBcnNwWFErQW9W?=
 =?utf-8?B?Ky9zR0Rvdm5CQ0JvUHV2RkNnQzhibk05K3dlT2tmRGZ0dkVuUWRrdlNQY2xn?=
 =?utf-8?B?Q0w4YVBJN0NSUWxHTVpyUFdaSG1jODBPQnN5MjRncjUwdExDMVZTaC9QbDBC?=
 =?utf-8?B?ZklsOWE2eGdPRFZHYnBpMFNCL3dXeGdHZFFmS2M2QUJyczNYUUZXT2dIMnQv?=
 =?utf-8?B?aW9lSk5ycXAyMmRKcVhmZVBPbEc0emlnb2JjOWxzYXVRb01XSjJPNUdXOFAv?=
 =?utf-8?B?dkpsOCtXRWhmVStkNytNS0JWMWcrbzlTb0pMaFlXMk1FUVZrMFJjcHdRYXRF?=
 =?utf-8?B?NDgrMG4zKzVSTXlmMGRNUTU3THFuRXlLQis5MStkQzNQcW1UMGtjMlVxQlNH?=
 =?utf-8?B?VEVpOFJUMmovRlRTMXJabzdVVFkwbjJBTUNGQjdEeU53OFdVOFVqZk54cjVK?=
 =?utf-8?B?SENjTGdLekVYa2xrN1VpU0lrZnN1Tk5qMEQvcGx1TEUreTl4KytjL280YUVW?=
 =?utf-8?B?OCswYS9rbHZndkVyb3dvcGZnT3hONkxoYjZiMy9ZV0dUWDVQSnRwOWRQU1dR?=
 =?utf-8?B?THBPcmRueHRPd2VFWFFnQU5nS1RSaEtScnI5a09NNlhBakJ0dmZuME9kTGt0?=
 =?utf-8?B?eHA4dDRKQ054TVJ5MGtVa3V2K040WFJPeDc5b3N3Q0JDM3RmOFAxOUUzV040?=
 =?utf-8?B?MG5DSk5EWEgxVWxvZWZSOGcxaCtia2tBcDJybjd3RXdReWFOK1liU2ZpRmd0?=
 =?utf-8?B?TnVwMVBhMXhNU1lXSjVvNm8zL2Z0dDZMTHoxdDBNTSs0N0pUbVRhbDNaeTU5?=
 =?utf-8?B?N3IwZDRrSzRxYnRObTJaaHJuZkx1WkM4UG81S3dRRTUyREdBeWF5TFdHckVi?=
 =?utf-8?B?T0pvZjN6NXc4SlVwVkJSYjdvMnNKQkFUTnhkZi9keDJvQjJsQ0hiRDZWSFI5?=
 =?utf-8?B?K3g1RFArVXNYTGtkRUFYbHNVb0hBTUxrNDJTbU8vdVRoZE5qaFd6NmlFNG1Y?=
 =?utf-8?B?dklHbWxWTW5tYjI5RUNHMWhLVy8xNlNEajI1SDR5Rk95TjBwTmMyYTNXdkps?=
 =?utf-8?B?aTZSSXN1dGJXTkI1d3BzMFkwODJjU21nWnhyd2hFQ0VCbHRrd1BaVUcrYS93?=
 =?utf-8?B?TFR5SDF6VTBBT2FqYnEwV2hjRFlEMGJEcXFLNEZxVy9jRDdvMVc4RWp1c20z?=
 =?utf-8?B?M0ZaNTlOYzBjOTN2cWxZaEFIa3g4VzVlSjdrL2RjSTNRWks1RjRJdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cc172a-4805-4491-cccb-08de6a32eb0f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 12:33:26.2937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05uPcgu74vKxVQENOBVIKDvsgumSTl9c5YsURby8aeyKcQURwDQwCd0iyUvHPMp4KjcOwe9Eezuizb1n/Y4p9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9257
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Feb 2026 12:33:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21861

On 02.02.26 13:57, Jan Kiszka wrote:
> This enables support for the BeagleV-Fire in isar-cip-core, including
> SWUpdate, only excluding secure boot so far.
> 
> Note that this comes with an update of our U-Boot version. I've tested
> that on all but the TI AM62px (no hardware access) and would like ask
> for support on that part.
> 
> Jan
> 
> 
> CC: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> 
> Jan Kiszka (9):
>   Kconfig: Sort boards by architecture
>   u-boot: Add U_BOOT_EXTRA_BUILDCMD to common rules.tmpl
>   u-boot: Update to v2026.01
>   Add hss-payload-generator recipe
>   u-boot: Add recipe for BeagleV-Fire
>   linux-cip: Update cip-kernel-config revision
>   Add BeagleV-Fire board
>   kas: Add BeagleV-Fire target
>   ci: Add BeagleV-Fire build target
> 
>  .gitlab-ci.yml                                |   7 +
>  Kconfig                                       |  26 +-
>  conf/machine/beaglev-fire.conf                |  22 ++
>  kas/board/beaglev-fire.yml                    |  12 +
>  recipes-bsp/hss-payload-generator/files/rules |  22 ++
>  .../hss-payload-generator_2025.07.bb          |  27 ++
>  ...onvert-SYS_EARLY_PCI_INIT-to-Kconfig.patch |  37 --
>  ...-mach-socfpga-Fix-non-Agilex-targets.patch |  97 -----
>  ...KASLR-OPTEE-RNG-support-for-K3-devic.patch |  38 --
>  ...ustom-CPU-implementation-for-PolarFi.patch | 153 ++++++++
>  ...missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch |  30 ++
>  ...ot-generate-logo-when-cross-building.patch |  33 --
>  ...arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch |  28 --
>  ...SoC-level-options-to-the-CPU-Kconfig.patch |  83 +++++
>  ...or-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch} |  38 +-
>  ...3-riscv-Add-support-for-BeagleV-Fire.patch | 346 ++++++++++++++++++
>  ...ector-value-passed-to-mmc_load_imag.patch} |   6 +-
>  .../files/0003-test-Fix-optee-unit-test.patch | 134 -------
>  ...cfpga-Adjust-a-raw-sectors-for-MMC-l.patch |  16 +-
>  ...onfigs-socfpga-Fix-de0_nano_soc-boot.patch |   4 +-
>  ...6-configs-socfpga-Permit-EFI-booting.patch | 161 ++++----
>  .../u-boot/files/beaglev-fire-config.yaml     |  17 +
>  recipes-bsp/u-boot/files/rules.tmpl           |   1 +
>  ...t-bbb_2025.07.bb => u-boot-bbb_2026.01.bb} |   0
>  .../u-boot/u-boot-beaglev-fire_2026.01.bb     |  28 ++
>  ...-2025.07.inc => u-boot-common-2026.01.inc} |  19 +-
>  ...5.07.bb => u-boot-de0-nano-soc_2026.01.bb} |   0
>  ...025.07.bb => u-boot-qemu-arm64_2026.01.bb} |   0
>  ..._2025.07.bb => u-boot-qemu-arm_2026.01.bb} |   0
>  ...5.07.bb => u-boot-qemu-riscv64_2026.01.bb} |   0
>  ...5.07.bb => u-boot-ti-am62px-sk_2026.01.bb} |   1 -
>  recipes-kernel/linux/cip-kernel-config.inc    |   2 +-
>  wic/beaglev-fire-efibootguard.wks.in          |  20 +
>  wic/beaglev-fire.wks                          |  14 +
>  34 files changed, 924 insertions(+), 498 deletions(-)
>  create mode 100644 conf/machine/beaglev-fire.conf
>  create mode 100644 kas/board/beaglev-fire.yml
>  create mode 100644 recipes-bsp/hss-payload-generator/files/rules
>  create mode 100644 recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb
>  delete mode 100644 recipes-bsp/u-boot/files/0001-Kconfig-Convert-SYS_EARLY_PCI_INIT-to-Kconfig.patch
>  delete mode 100644 recipes-bsp/u-boot/files/0001-arch-arm-mach-socfpga-Fix-non-Agilex-targets.patch
>  delete mode 100644 recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
>  create mode 100644 recipes-bsp/u-boot/files/0001-riscv-create-a-custom-CPU-implementation-for-PolarFi.patch
>  create mode 100644 recipes-bsp/u-boot/files/0001-spl-Kconfig-Add-missing-SPL_LOAD_BLOCK-for-SYS_MMCSD.patch
>  delete mode 100644 recipes-bsp/u-boot/files/0001-tools-Do-not-generate-logo-when-cross-building.patch
>  delete mode 100644 recipes-bsp/u-boot/files/0002-qemu_arm-Select-CONFIG_SYS_EARLY_PCI_INIT.patch
>  create mode 100644 recipes-bsp/u-boot/files/0002-riscv-mpfs-move-SoC-level-options-to-the-CPU-Kconfig.patch
>  rename recipes-bsp/u-boot/files/{0003-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch => 0002-spl-mmc-Account-for-SYS_MMCSD_RAW_MODE_U_BOOT_USE_PA.patch} (67%)
>  create mode 100644 recipes-bsp/u-boot/files/0003-riscv-Add-support-for-BeagleV-Fire.patch
>  rename recipes-bsp/u-boot/files/{0002-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch => 0003-spl-mmc-Respect-sector-value-passed-to-mmc_load_imag.patch} (87%)
>  delete mode 100644 recipes-bsp/u-boot/files/0003-test-Fix-optee-unit-test.patch
>  create mode 100644 recipes-bsp/u-boot/files/beaglev-fire-config.yaml
>  rename recipes-bsp/u-boot/{u-boot-bbb_2025.07.bb => u-boot-bbb_2026.01.bb} (100%)
>  create mode 100644 recipes-bsp/u-boot/u-boot-beaglev-fire_2026.01.bb
>  rename recipes-bsp/u-boot/{u-boot-common-2025.07.inc => u-boot-common-2026.01.inc} (76%)
>  rename recipes-bsp/u-boot/{u-boot-de0-nano-soc_2025.07.bb => u-boot-de0-nano-soc_2026.01.bb} (100%)
>  rename recipes-bsp/u-boot/{u-boot-qemu-arm64_2025.07.bb => u-boot-qemu-arm64_2026.01.bb} (100%)
>  rename recipes-bsp/u-boot/{u-boot-qemu-arm_2025.07.bb => u-boot-qemu-arm_2026.01.bb} (100%)
>  rename recipes-bsp/u-boot/{u-boot-qemu-riscv64_2025.07.bb => u-boot-qemu-riscv64_2026.01.bb} (100%)
>  rename recipes-bsp/u-boot/{u-boot-ti-am62px-sk_2025.07.bb => u-boot-ti-am62px-sk_2026.01.bb} (98%)
>  create mode 100644 wic/beaglev-fire-efibootguard.wks.in
>  create mode 100644 wic/beaglev-fire.wks
> 

Any further comments or test reports on this? I would like to move it
into master soon.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

