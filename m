Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27216C3ABA9
	for <webhook@archiver.kernel.org>; Fri,  2 May 2025 07:48:47 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.74])
 by mx.groups.io with SMTP id smtpd.web10.14166.1746172120331816681
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 May 2025 00:48:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=srUYQtz0;
 spf=pass (domain: siemens.com, ip: 40.107.22.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Un5BWGfI7z8dCBx+J+T01Z0HzsjS0ZgGOoAIPzHolVJy6vADtQm+CZ++pGN30Wj1S1D2aqKRCjNxF1MzepXsvaeEUrGqwXskreO8bii9LoegxxwfRnhi687Pm1EJ3FBK5KnAiw+lgGewN4d5aELon0mcnzHPhtGP9loZyG8sOSQlUxH8uQ7O/Tqq2ReLrobOQjUdLb5Ksb7aX1o1dZLT10Zoar9NLYaL/6wZNTm/aj2xgbmQL5Wq1wv68+yl4wlRgouQsQ5JO8IWiTl++17B4Nu8Gr3lI6/2zXOXPXra25qjA1Lu0x7SZFhInaEJosWQJ6AZliVPPpWz+y/7faTSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjrKpwgsr5ttH9AAJhiv2lgCYO5EikNg4/d7GVbTUCk=;
 b=HOx8Dvft601zbbpxakt+gS4YTR3vNyTs+T7VMnrQ4aAamQYgOoYYsKfe9MC2uk7KnFTRTcd/AJafjABc4IoMHyn3MeqLfsgVdztra6Xua2l6v6gYK9ThHNNkXKnOR+LNN1EtFmP2F9EWZzBHcmIUARpGjcmJKgLY7rmF9VqPkihioFjw794m2n/leZmWL8tLlFcCHEFuccay9pHNueo+9m6Bid6MRwPnDD8+4Ui4jf34EQ3EgF5fgQhnzKWE9CWqQ3D9/4IdtIcKBDc+1Mrp5hkJtnY9AqOTxezlWmesLBErEUNss0bETz/+29LmwlH63JJdsNMMEf+6uJxOh7mjkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjrKpwgsr5ttH9AAJhiv2lgCYO5EikNg4/d7GVbTUCk=;
 b=srUYQtz0y71bABduitCguAyK+YQ19do3dlbxWMx9m+ZgQDs8Fl6PZBdRdbj4L/qiOg91v4JGqqOxD0KV1/VI1C1DRYW7V69fo0WU4cxTj0+kBBJYq6WJri8ydies7WnsP+p/cRw5rMKTtzRnllFiYUaETm0RUK+ppcSjYPTB+yN3xFqtd8CJpFwWUBECY5Rbi1eDnGM6+STsHrF1AptkVD6ev9/Y249vFQdWvHNUHFem46kVEZb5FSRTr68qndEe15K6g/t7TQ+xqSxB9d2VuwriBl1dqrAT2OKuM8JGvHLmqKluwoCh5K52XZH3uk+MlMlnPq5qKq6bOqjQaOdOnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Fri, 2 May
 2025 07:48:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8699.019; Fri, 2 May 2025
 07:48:35 +0000
Message-ID: <b1f28d2e-831d-4db9-a6ae-92dd9f9dcae9@siemens.com>
Date: Fri, 2 May 2025 09:48:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] wic: Add the variable
 `UKI_FILENAME` to change the UKI name.
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250428124127.3228991-1-Quirin.Gylstorff@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250428124127.3228991-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: f62fe55e-b307-40ab-5857-08dd894dbe19
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?K09KbU9VY2ZqbnM1WjIrc2ZWeEpUUWtsRHU3NXRoK0dDTHJlMEhiODZZK1NI?=
 =?utf-8?B?YUl6eGZ3bkZDcHlZVkdZM1BOQzNRa1cyOFNEeXFrTEpVeCsvYzhIOC9WM0pI?=
 =?utf-8?B?Z2IzcjUzVFVyamYyaWZKUGs3QXowYmJWQkVPRnFyRzNnY0Y2eks3Y1Y5aVdI?=
 =?utf-8?B?bUNhbkxLQ29vMEZGRUNOeFFhWHE1MUlrdUl6SGRGN3VEY24yZmJQZk1xYmhZ?=
 =?utf-8?B?eWgyNjdjMU5LR3FjdjlEd2tPL1N3cU1sSnp5bzIwZEhKR0FaSmdFVldVSzZv?=
 =?utf-8?B?ZHh6bks3OWovWmVXc1N0U2EyMHhPZUkvMkFoeVhMTnE3YUc5aHQyR3FoTlF5?=
 =?utf-8?B?cGlDLy9yQVYyTHhUK0E5TU1HV1J0YjVmcEI2cmRMSmlOcHQzb2pnblk0M2dx?=
 =?utf-8?B?SWZGYk5VSDFpU3lnZDZSWlpzcjZRWlBYUXBSZWdrU01WeHlGWk5way9kR3Ns?=
 =?utf-8?B?bHMrbDYrb0tYNkowci9Qa2txTFJ2NERpWmplSFowUWxLelduSEgxK3R0R3Zv?=
 =?utf-8?B?ckZHRmhnUFc0TFJ3bWtTTW95bWpiZm1zZGlNajlRUlArcUxjbXp4dENvNUdK?=
 =?utf-8?B?c1RPTW9xeThnUnpXdWJzQUFERm1VUnF2Y3FlUjNtbHNibnV4R1RyeDJvOGVH?=
 =?utf-8?B?YzRIS1UrVEI0M1BFYUEveTU1Uk1DT0grOEZjMzVGUS9SeXhHcFJVRVV3R1Vy?=
 =?utf-8?B?c3ExYTFBTnZlU0lwUGpkOXB3eWltcllmRWFoWitQZUtQSncyMGFGbWpqMVJK?=
 =?utf-8?B?VDBoZm16YlR3blhjaUJzQXdHNzZyZjUycXN4cXZBcHBuS3lKSVcrTGwyWmpx?=
 =?utf-8?B?eWsrZ2ZFaWZBTzFzKzlsYW5PZVZGMEVLMUowUURwOTVyVXQwSHdBNWVSRmNu?=
 =?utf-8?B?b3FSQldaVXB4SDIxWS9VK3pKYkNqWnY1WnF1TkJKazFFK09uQXV3RzNEeCs0?=
 =?utf-8?B?L1gwZndhYVZWU2RNbGg5ZWVqRi9ZT3d6QllHYjV0TjNUSDVIajliS0YwdytN?=
 =?utf-8?B?eXpuV0M0YWRINVRITkkzMVlXdFU4S0l5L0Z6Sm80cVloUHpqYzRGNXUwcm5j?=
 =?utf-8?B?QnZJVEtrTDIrenlsNEl5cFBxRXRacStpcHVua0F0dmEzbGNXT0E3S255d3kz?=
 =?utf-8?B?OUcyK3JTYmhSQ29wcUxrNnUzaGtiRmJGQzF0eHFrWHh2WGZGS2Mwa09ERnQ1?=
 =?utf-8?B?UXdJV0paRUJPUzZlUmJsQTU3QmMwRG81ODNod3BHdi9hU3Z2TTVLajZNbE9h?=
 =?utf-8?B?KzBuZmFBODYyMGxsek5MelNNTjAvY0lBOE1kdGk0eWh1dmg3SEx6bUlsM3h4?=
 =?utf-8?B?ZkVtN0ptWk5Qbi80UFozNVVEc2g4VndsVFc0UmFtQ2VSamVuUE9FODB2M2c1?=
 =?utf-8?B?K3NGUDdOOWpQZE9vc1lwbXdXYkJ4SzhMZVo0Q1o3aE9EQkF2Q2EzRDN3L2x4?=
 =?utf-8?B?Y0pvdU55blY3SHF6ekxuOTVRSXZueTkyNjRUclY3TUIxRllwWnlTMFZFWTJj?=
 =?utf-8?B?aWs3TEFQOHdlelNXYy9CN1cwU0U1bXRRUCs0VzJURFRMRGlnR2p2NmNmOExY?=
 =?utf-8?B?dXJTbFd6Z292N2hnLzlkM29kSEtBd0l6dDhycHg0d2FZNVc4YmUxeFdpWlFj?=
 =?utf-8?B?anAyb2xRZzhrQ0lseHgrc0lFdHFZTVZmd00yT08yL2Q1UkJndlF5TWZVOE8v?=
 =?utf-8?B?ZStvb2NSVjN1TEEzQkF5L292dWdmblNQL1VqOE5sNlF1bUQ3V1hFRjVvVHBJ?=
 =?utf-8?B?WlRuY2F6d1RwN1g1Z1lsMGVNV1d0enNyVVZUdnlyV0VzOCtXUTNVQW93Vjlt?=
 =?utf-8?B?MmFzK2cyU2Y0NXV2R1R0a3EwMWkvMytxUkhFNjlCVm95ZFc0d21udnJPYkV5?=
 =?utf-8?B?K1I0RGxlRWxSdXF6dmtXeFV1MFhuYnFEZ3JHam5oelhmWktWUjZTbEZLVFdL?=
 =?utf-8?Q?1x+Nr6Dog+w=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZFFmSUpYZkViOStSL01SUTI1OTVQWEFhYVhkdTZSRXJvQmo0bndxVklCUU1Z?=
 =?utf-8?B?K0M5SDZLZlNNU0ZESHpyWVNMbld1U1RWM1RZOVREWkNFMEtoV29lMUluSlF3?=
 =?utf-8?B?RVB3cDgzQzRoZVRucE5tWHh4SG8vS2hMdVZHUStHajJBaWY4dTE0aUQzSitH?=
 =?utf-8?B?bXM1a0dlczJuaU16bHhLaFl2ZWZPNDliM0N5ZjY3U0dGSjA0ZkYvSUV1QXVC?=
 =?utf-8?B?OXhhWi9HVTE4dUhxRTVXMnNDdGVmWllqZFN1Q3lKd2NUNVRpcXZVVVZqeU82?=
 =?utf-8?B?YlFtVTBPWjhPcEFwcUZQVUs4RXhFZzA0LzFQVUNJbjZBaHVwOVlQMUJvQXBl?=
 =?utf-8?B?VDA1dGhFWngxQmFLTVpRcWh1TFJWd0hLS3RtOVZUbVc1eWxnNFUyZnAxMGlS?=
 =?utf-8?B?SXBabWxKTmt1OHVEL1dtRUhRWkNwdjJYUXZ2MUxVUFRJNEFnTURPb05zS3M4?=
 =?utf-8?B?T3BTSnpKVDRSd3c0LytFYTVncTA3NExXVWNsZmFuN3hFVW5Qakdkd3orUnYw?=
 =?utf-8?B?UEY4OGY1T2xvUmN0Tm9mM21OMlFIbnZyOW1JbU5uVTg5TEVrUFVQZlF0ckJY?=
 =?utf-8?B?dlJSN1NuT1ZDU1QrRWJ4TzRueU5XL1VxUVVGeFVqSitPSWNsK1dsME13NTlk?=
 =?utf-8?B?WTlTTlB3VVVPNnk0UjY0YUNoWEZHcGxta2hhZ3lybVNQalJVNEx4ODhFamhQ?=
 =?utf-8?B?QW9EQnhoMlE1eTVPTnRsK2lSR0lNcTl6TEsydXlYaDlMOW12amNJUm04UkFS?=
 =?utf-8?B?OTNaNWVOYVhiSG9vNHFvRmYvWEU3K29zbms2a1ZVWnc1UjVLbWdzcjZwN2VX?=
 =?utf-8?B?SmUxbmlabmVZdVE0SkdvbXdweDdWK0YwTUZGaXp4aUVvZi9MWHczMS9Pbmxl?=
 =?utf-8?B?eU1LODBhRUpaYlBTUlFXQ0xMVlFKRjB3VzZhS3RCa3VJaFh2UUxtZ3pOWDho?=
 =?utf-8?B?YUVCZEJyajVVSERjMHI0RytoVHRsOXg5QVVqbGQ4aGp1Y0NzczVoMjNhRi9G?=
 =?utf-8?B?WXhGZGE5RXpHU0FnOS94Y3ZRdU5kb2lKSFhRWnhLNG5keVRJZVlwMVV3aVc1?=
 =?utf-8?B?RDJFOGwvV1F5dUp2Z3NNNldPTVk2ZGZJVk5acmdlYXJCUVFDWmorandHUlJD?=
 =?utf-8?B?OEhBRU00bDdVdW9HcTZNMzY1VGM1RW94TmErZ09MdlRDVURYZURnSEJNblFP?=
 =?utf-8?B?TytwSHJCMEw0Z1RtV21jWXJONlN1SU0wb1ZHMkI2US9yT29oSkdWUHRFMFJl?=
 =?utf-8?B?dHE0L0dPSUZUUkdLdlE1MDdDZDdYRzkxemNmaTJDbnU3M1MvSVV1U29FVm1M?=
 =?utf-8?B?YmkvM0k5UVRLVEdISThGNm9LMzJXVlF0RmZQaExJRUFBN0JCUXh1S3ZjNmdF?=
 =?utf-8?B?YTZmTzdnWW4wMkRBSHVWSU5Jak5iOXZ5d1Z4ZmtRenVEb3ptZko4VVplcngx?=
 =?utf-8?B?M3l5ZEpCTUYvWUx2bjU5Z1ZYSmJwaHZtSmVIbVFJZVlaVXk2cERETkpHSkdp?=
 =?utf-8?B?MkYvRkZOQmNydFdYUkVtcWRNaXVRME5xcjc4QnUrRlF3WHNTTUhvTkJqWkVG?=
 =?utf-8?B?REZUTk1OSkhnSEZBbDcvZHJmQlg0ellKbjNraDViSWlQcllHNkpGczY3L2dC?=
 =?utf-8?B?cko5aXY4Sm1PanAzeFZ4dHA2VkxPdDJRVFBQUFc3Y2RDMDRWTmd0cnBjN3d6?=
 =?utf-8?B?NGd5YlduTkw2c1FMeGZUd2VBN251dktJVEd4ZnRlc1VYek5CZU9aOW5rS3Vs?=
 =?utf-8?B?bHIxQitMV0hFY21ISnNoYVBxaFh5eit4MVBDbmRZZE9pdlNoQUhSSWk2K243?=
 =?utf-8?B?Mk1OUUEyWU55eXVoNGl2Sk5UYUhOK3RWY3ZFYVNieWpQaG1NRVpKQXV1OVBv?=
 =?utf-8?B?VkFxOHI2Rk1IM2huZ2JRN1NPbXRPWVBBL2Jsb08wdkRoQnQyeVc2aXJDNUlt?=
 =?utf-8?B?OUR5c2FtZTlFRmRJOW9qRXhYQ2lYdzZkTjJwZ3g5eHJQOUpVclhVd2Jzblg2?=
 =?utf-8?B?S2V0ZGtwZFZia3h2SUQxTVlpd085bVdYdnZmR2VEd0F0THo1SFNWRHppblJW?=
 =?utf-8?B?WVp0bHpaVUF5dU5XdUhqaWd3UFp2UVJSc1JVeVNRSi9TdnBZVE9tVklMNTJh?=
 =?utf-8?Q?EEinbldqlPoRxeyz7tO6WVXWV?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f62fe55e-b307-40ab-5857-08dd894dbe19
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 07:48:35.3029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDMdPYE7kSpsNwj69pR9RAqCa0oiEAKRZZU6yUZh55t05D0x2krTq6SXSs8Y2f4Hg0dHvEPdmaD9U3ZGdxlJ9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5908
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 May 2025 07:48:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18751

On 28.04.25 14:41, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows in case of a unified kernel(UKI) image based installer
> to differ between the installer UKI and the target UKI.
> 
> It also allows the build of multiple images for the same target
> architecture or update file.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> Changes v2:
>  - Change subject
>  - Rename variable to `UKI_FILENAME` same as used in poky uki.bbclass
>    https://git.yoctoproject.org/poky/tree/meta/classes-recipe/uki.bbclass
>  - Add missing WICVARS
> 
>  classes/efibootguard.bbclass                        | 2 +-
>  scripts/lib/wic/plugins/source/efibootguard-boot.py | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/classes/efibootguard.bbclass b/classes/efibootguard.bbclass
> index b130968..422d427 100644
> --- a/classes/efibootguard.bbclass
> +++ b/classes/efibootguard.bbclass
> @@ -12,7 +12,7 @@
>  IMAGE_INSTALL:append = " efibootguard libebgenv0"
>  IMAGER_INSTALL:wic:append = " efibootguard:${DISTRO_ARCH}"
>  WDOG_TIMEOUT ?= "60"
> -WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES EFI_ARCH EFI_LIB_ARCH"
> +WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_DEPLOY_FILE DTB_FILES EFI_ARCH EFI_LIB_ARCH UKI_FILENAME"
>  IMAGE_TYPEDEP:swu:append = " wic"
>  
>  def distro_to_efi_arch(d):
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index 8b1097f..aeb9328 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -178,7 +178,7 @@ class EfibootguardBootPlugin(SourcePlugin):
>              .format(rootfs_path=rootfs_path,
>                      libpath=libarch,
>                      efiarch=efiarch)
> -        uefi_kernel_name = "linux.efi"
> +        uefi_kernel_name = get_bitbake_var('UKI_FILENAME') or 'linux.efi'
>          uefi_kernel_file = "{deploy_dir}/{uefi_kernel_name}"\
>              .format(deploy_dir=deploy_dir, uefi_kernel_name=uefi_kernel_name)
>          kernel = "{deploy_dir}/{kernel_image}"\

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

