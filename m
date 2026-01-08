Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AA7D1488B
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 14:19:32 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.3])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7309.1767881963671096456
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 06:19:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JGhOBGZT;
 spf=pass (domain: siemens.com, ip: 40.107.159.3, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCPWIFZYAlsBxU+7EFhtoY3TaOYuAR7NSjlkwVIVgAeb1/xuOTCR1dUfCC+qhZ776gdlQSlgWEQYMn3Ilxdauu3H0iYpNgOlOv8gvOjawRPDQqG22yT/Afk5IlemtZyihrhNfQeg+PPWwYvX5YV841vAzml7bGFdddVvydQPSP/pr0/kasvFZFZHJhzFkwtipUJkzVH+X6Zd53W/qj5bWdeEdmQfp02zBXvIPnq4I5OQZhUK5SVZ/Xm4I1IIuH214dKtEtDkMXZbkVR/NjUHnZ+O8OtL2O1HmO1gtiHpwXFO3o0CS1RDhbLyHPIc2zM7vRUrl5onTsjc+XK2rFby+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GT2poKAQGHHPImcxOrWKxSyHsd0+n4aNlvqGp6mzvY=;
 b=LcbaEFiLEJpbr1zfwvCtBQOgbR07IwCS4HYVjzAhg3vIVdCsiwBky+toxgdnrO4kvTU7Qyq28Kks/ZMCqBP5MhR2+wEYodVjicYBcH9GwH4iMZfXwux2FCih/12fHRQzD1sHFRk2DujHJlLnkyEeFHU1dQSBFsPfqMYIVmmfEvfQvvKwqf/IxwGLabttWEUbO3kaORHYZCZ25OoYWtc/T65wLZDh/CcGBU+yITtQPKHl8uSRZJ5UqiQyCq7L0dn5JH8oBlvKh4g9Az1Eps0yHDMvdSa9vMQ4fRk4hoiTK8+6YzwIVJuqjH3qRmBmktafgUZftqeAsSnByvij74AmZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GT2poKAQGHHPImcxOrWKxSyHsd0+n4aNlvqGp6mzvY=;
 b=JGhOBGZTTEOGGh8V3Y+oAL0jz0B/sjEfOpbH2Oa9xsqpMM3ASX8d5DRhU1vjWDknc79XSDxwex4FLwA1H927A+MC/aZjM1yssTvwoFU2e3iI3k6t0pLyqqAPK1gwlazT0Ssrn6IZu5zrcu4A2p90ijY3qCKzndRfm+XQTQy+QLEJShlGfe22sHSc9p7XwhzeuY0Y7tsptVhgJnbv3jy6WHzf3lS9i+fjTkzyPS8jdVOSMzesxW7lYFx6iu3y9s6G62dKazGEAWSP0IIwk2iqXMRhjLhZ0yD1oS6yy+2rOhoInQClpuQRjWS/UEXYl6AqAnxWuMu1pLdMfXmsdTdOWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7885.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:64e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 14:19:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 14:19:18 +0000
Message-ID: <ba08992d-17f5-4689-b05c-93af612e4539@siemens.com>
Date: Thu, 8 Jan 2026 15:19:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] u-boot arm: Disable problematic GRUB
 workaround
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
References: <bebb47e0-230f-4ef0-8439-a576cda865d2@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <bebb47e0-230f-4ef0-8439-a576cda865d2@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7885:EE_
X-MS-Office365-Filtering-Correlation-Id: e22a1802-ecf5-4378-abe6-08de4ec0e8c0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R3JMbFJkV29NdnltRlI1d0UwNnVpN2V3NEFSak9nNnpITlJTSExWNWRhVlVT?=
 =?utf-8?B?RzBpZDJqUUNrOS96bDE0ZXkveU5BTTAxeDJNQ2ZUZkdYMWtYWEVqYTJqS2Np?=
 =?utf-8?B?ZnkyMjQ1dFB2TW9QYUtGOHVYcHN4VE5JNlNOR0RXQTJoQU01MitIRXVtaVor?=
 =?utf-8?B?YnYwNXdqYVJhMHcyb0luSmx6RzBlSnozWXdyTmI2UGtETjNuaDJwaGE0SUF6?=
 =?utf-8?B?VHRZS3ZodGxIZzdNbThMakpKUERRSVJhbWdRYjVmcEZ0eTJYWFZuMGZtOFQy?=
 =?utf-8?B?cXp3c2pPa3FzNWpJU3ROK3RVV3VVSWlQcmhoS2tFdXJIVTg4N2k0d1FzT3Bt?=
 =?utf-8?B?TURVdGxaQjFjUVhZNWp1OUdXb1ZVckxiL051UndRdkxHbDVyeE1WeHBSdnRU?=
 =?utf-8?B?SXlQazRVZjJpVkdFVTNsdUxPb3Y0Wk9ObEZsMnNEUWt4ZHZVRlJXZUxoOHNB?=
 =?utf-8?B?eVlZenRLNTFHZzVTMk1sZWFEQmpFNGEySTVhK3NvL1lHcTJpRjVjMUp6OGwr?=
 =?utf-8?B?Q2pFbkdrcmNvcWVVemREalFLQWxLelJQTnF4ZmcremRyZmJ0dS8rSXh4UVB2?=
 =?utf-8?B?bjFBZDIvUE1jVStIYTNycUdnQ05GV0FhQ0toQzB4RXo2aUgycEx2Zmw5SndW?=
 =?utf-8?B?OG0zaE9YUDUxYjl0S3NiNktFSkxGYzQyOWs4TjIwdGlSdGZsdnJ6V3ovR3hD?=
 =?utf-8?B?ZCtqSjhaZ2RQV2czMGlnekNINUREQUlyOU0xYjlMV2x2NnpxUFlCakpEUmkv?=
 =?utf-8?B?eEVWQUkydWJNRGxWbHcwZnVOWmdIeGxZMExaY0hDcHhxTloyYklnYyttM2ph?=
 =?utf-8?B?S0FoYzBMOVdSdWNhaW81NkV1NXdVMmRsd3NXTmhMMktZbWtsL2dHTnBPTGhJ?=
 =?utf-8?B?NTRhL1FKOFhuU0VSdEdMZnd4WEY0Q1RxUHlkQU1jZDc5aGY3czBYcFlCOTF0?=
 =?utf-8?B?djBjL05ER1ZXZVpzTlJxeTNCNmNJdG8zYjdrSHJEVzVZaTFDaWxBeHJqRUw0?=
 =?utf-8?B?WkZtTUVxekdUN2FtV0RrRGU3K2pjQkd3UDdtWVI2TUVqMFhiUk9QcUhQOGQr?=
 =?utf-8?B?SFY3cTV3aUsyUzlORGRJeFFDVUtuTVdGYkV2eGtlekI2b0l1OVVEazdKYjEz?=
 =?utf-8?B?ZHluUWtwYkFaNEVDQmFrRHY1cHpla3U5UzNUbExYWU5xQVJ0NFVrYmNYOGxq?=
 =?utf-8?B?cklWa3dRREg3SlQvL1JHbjB0OHVQb1ZiODhOd0NoU0I3Z0dCdnAwSFNYZnA5?=
 =?utf-8?B?cjV3NUVBblNnYm9vOWhMU3c4a0N2akJOQjdvSFZkbWR3ajVLdEFURXo2ajFK?=
 =?utf-8?B?NFRLRVZUdDh5SkRiTk13dUJUZmpLcGtoZEZud1c3THRocDF2aGMxU1ZkT083?=
 =?utf-8?B?NllrOGZ6cXBjRG5hYTRkZFZHY2syT01XOXlXMHhGNVdBMlBKUEFHNk1sY1pQ?=
 =?utf-8?B?QXVPenVmT3k1SmFTcldza09vRGQ3M1ZzSGFQdGNNdGRGaDJDa0RsY2xwSXF6?=
 =?utf-8?B?WFFEWmIvNXREM2VJSWV4K21Eb21mRHlsdjdJZ0dVUmIvOGJwTGpHTlZrNjcz?=
 =?utf-8?B?cUZIT2dlUHI1WmwzVHI4bWF0cGhvTmIrZGRPVlVxU1BncURpUU9ENmtDb2tI?=
 =?utf-8?B?aWp2SlB6WE11ME1WcjlRNFQ1aEkxZkpEbzlrYnFjVW5JUXhrVW5uMVA5VTNE?=
 =?utf-8?B?TVV1MHc4aXI1RGVLR1paMzJxUzhsSndXU09kUytEYlhGZUJIZ0dmQm9jbUJN?=
 =?utf-8?B?Uk0rakdIUjkrRzFlVy84K1JFOXlEd0R3ZWV2UnhFSG1jRUFqNnhjbnBiMHYz?=
 =?utf-8?B?eDN4TEVjcmF0elVlUUgwZUJ1Y1lpZUMyZUx1Wnpzakg5VU5aMDlkWG1DcndR?=
 =?utf-8?B?WlZMMkg5RWhpOEdwbUc3NXlFQTBYTkRRdEZVWDYweUdVRkl2ZnJyRWlXTXRh?=
 =?utf-8?Q?gDJIQu8MIFvaWtlQLe7ArMx9QtmtnfwR?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SmluaHJ5NDMwaDNtY211TUw3dWRhcGhqakJzcElraG04TWl6V2xjaGQ4MVVl?=
 =?utf-8?B?WmY0dVN5MWp1YWRNRmVrcmtYbkN1UGQ3V1hEYm9wTVZad2hIOFIyZXlidWFl?=
 =?utf-8?B?bHZSMFdtaDY0UmtWa1QwdlZnNzg1amM5T2hGdnkwWW1EQjM5NXNHbG1wTVF0?=
 =?utf-8?B?aEVSTzM2bFAzd05NdndFdzl6WlZBRGVTWWlPZ1FzdE9UcXZxZDY1Y1g2RVQ5?=
 =?utf-8?B?TGt1UU5lRDczNkVmYlh0Vm9rRzBJOXBzb3hjY1VsWlhrZDhnYVF0a2F2MEoy?=
 =?utf-8?B?SjBLTGs2UXhyNU5MdFBZMmV5VWd0diszVEpoN1JLSlJYODlyZndDY0JWK2Fh?=
 =?utf-8?B?UVdzU3BmWGN2b05NWnAzQVZ4Mkdwd2NBYUJWTGJZT0o5Qll6U3ZDS0RQek5N?=
 =?utf-8?B?UTd1elo2dEJJSkJ0UnZsOE1HcFE4bldqVFppWlBwZXBEQmE2bHRkZTZVRFZZ?=
 =?utf-8?B?SlQzZCtYQit6TzBsSTlFQldGUy9OdHpWbWZNQTVjQWd2N05yUE1xaFlVRmVN?=
 =?utf-8?B?R0ZqVmZpc0hXc3dlOHpvK1NMMkQyYlFIY29SaDJsMTYzeU9raTNEc3F5eGhp?=
 =?utf-8?B?dGFWWS9JYVVxd3JZQkNUZ3dxeENHVVVGRUpvK3UzOWFKQ3B0TExLT0NBMGsr?=
 =?utf-8?B?REhSRi9YTWtYc3lIam1KSFl5M2ZSenF2L0dXR0ZRZzR3YVZRWDI2WjdPdmMz?=
 =?utf-8?B?aTkwY3FPZHdxd2JaK2tDUklIcFM2bFQrVDlxYTU1SmZxY29YZmpYd200UTg1?=
 =?utf-8?B?eWozSU9zaGNrTXAyc1k1aHlEVVZFTCtjYkhFL2o3UWtiMEpnNTBzMlRYTy9s?=
 =?utf-8?B?cEgwZWtsUkYxTTgzQitxSmRqUDY1OUIyQUxyR1hmaDRYQkNzd2s5dFc5b2xN?=
 =?utf-8?B?WThqSHJwQSsrc2h6Nm92RUNQMXhSSlVUQnZWM0JFWWdDdDF1ZVFDWmd2WUho?=
 =?utf-8?B?S2pwMVVYTEFaTXMxemRvTmNncWhoQ2JCMHJpOG1DOE5aOW1LM096WGtoaVA4?=
 =?utf-8?B?dVpqWWZXNy9wS0tFNXltNE9yRHYxWVdGNmZHd00wME1QNmg0KzJZeWlSWnNk?=
 =?utf-8?B?UmYrS3hIQUpSbzhndUpnS2tUZGc1WGREaDRxK0x3TjZsOHpiWmVBQU1lSXZY?=
 =?utf-8?B?Y0NTSHdMKzFhWVlDSUpIUGNtaUNVVU9jS0QxQTdQVUl0MDFwSFZXZXAwNDhW?=
 =?utf-8?B?RzZaeGEvVU1EZHlKaUlZWnFFbEdTaW5oa2lEVkVzLzAvUXZrdVpmU2p6N0lL?=
 =?utf-8?B?d1VUMkhGYnkrODg0RGIzODNlNlRLd09TaHdpaWNxMHRHZFM3bnIzNnUrOGsy?=
 =?utf-8?B?UE5NbEVmTzN0LzFGTUdtbm82TkJxTVlmRUF2VWplZWdhNDdMcUFTZTNQTzZa?=
 =?utf-8?B?bnNJUFpLYktWbngxQUtWajN1TG55RUQyMGE3V1dYd0lFMytBYjBmWTZqb1B6?=
 =?utf-8?B?MGZnRXNTckN4VFNLWE45WGZHSmQ4VnVaYm5kV01jRUMrdDhOdGhpL21NRys4?=
 =?utf-8?B?VmtHRS9FT2p3VGdVdHlFc1lvdzlhNnkxc29EMHBhcFlIL3lNa0drQks0b1BS?=
 =?utf-8?B?c2RlZjU5Zk9pb0V3dFR2b25DUnVVNzNwVFRwSXBlYTliQmZOM3NpY3JKY1Nn?=
 =?utf-8?B?TTBSbUliaE5qdUxsbFFDcTJsWU1ONHVVczdjZStPMlJEMXN6R013eTZsSDZP?=
 =?utf-8?B?am8rNjBaaGIyQXhKV0V1YmsrelRFaGZVTU5rNWgyMTg2UlBpQ1g2U2RBYVRS?=
 =?utf-8?B?TXhBYVl0TkNaT3g0R2FmaUNDRGo0S2x0cWFiZU9hSHU3d1FuN2kxczFnRDhk?=
 =?utf-8?B?UzJ5aUcxUnE3TUlUNEFLSnVlbUZpUzByNmRiK1NRSUMydzFGbUFPNzBZWi9a?=
 =?utf-8?B?ZEZacXozeE5oNW5NRW1TdWNEWjkvYXBXSnJJS2pXd2pXVXgrZXlOVnphNHpZ?=
 =?utf-8?B?S3U0dGpOaHJEL3MzVjdwQU8ydmZuRlZsSnY1ckp5b3lrUDhaUGdmMnFlNzU2?=
 =?utf-8?B?WEJpNnJ0Yk9oN0YrVVFzN2k0Zmh3K0dGUWVaYWxzWVRWSEpUMTd0MjZ3eEVR?=
 =?utf-8?B?Ykdpd0lQeUpmcW1KS1lqdmpmZTN1b1BpTTE4WVFFNURxRlc1dmIrU0QrSTlQ?=
 =?utf-8?B?UDdrNGlRcnNnRm4yOWovV2d6TWtudG9qN1VUMndhNHAzc0xCYWJOYldKSUtJ?=
 =?utf-8?B?L3EyUVVIQ3U5dFlLUVZDTUphRVZySVh4WndWVFdDVGpsMEJrb0lXLy9YUUhD?=
 =?utf-8?B?VXNWRkhFaG9OSE9DM3FXWFJJZjRZMnRYcFpUb3MrR1NxRUFaMlVsdllrMkho?=
 =?utf-8?B?MU82YkpmU2QyM1RaaGptREhLWmh4cndtaHVUcnJHSWxqRHg4bi90NHJZbVFU?=
 =?utf-8?Q?pMx+jBpuw5bhbUV0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22a1802-ecf5-4378-abe6-08de4ec0e8c0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:19:18.0288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnvBkVYi3xBvvC5MjB4S53DAExNW20fniTMKOeU/owrwywVqnvzI0ZMjFLqOdbixNP4ry+CHW4pAi338KLlthg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7885
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 14:19:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21480

On 06.01.26 15:08, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This is on by default in U-Boot when building for arm32. We are not
> using GRUB, we should never use it, the workaround delays the boot by
> several seconds, and it even started to break the boot of the BBB with
> kernel 6.1 and older since we switched to the merged defconfig. So, get
> rid of it.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> This still needs validation on the DE0-Nano-SoC.
> 

...and it looks like we need to keep it enabled on that target, if not
more. Only targets with architected cache like the AM33xx should keep it
on. The socfpga has a custom one, and that should be turned off - what
the workaround does. I'm now seeing sporadic crashed in the UEFI chain
on the DE0-Nano-SoC.

Jan

>  recipes-bsp/u-boot/files/no-grub-workaround.cfg | 2 ++
>  recipes-bsp/u-boot/u-boot-common-2025.07.inc    | 8 ++++++++
>  2 files changed, 10 insertions(+)
>  create mode 100644 recipes-bsp/u-boot/files/no-grub-workaround.cfg
> 
> diff --git a/recipes-bsp/u-boot/files/no-grub-workaround.cfg b/recipes-bsp/u-boot/files/no-grub-workaround.cfg
> new file mode 100644
> index 00000000..dc09edd6
> --- /dev/null
> +++ b/recipes-bsp/u-boot/files/no-grub-workaround.cfg
> @@ -0,0 +1,2 @@
> +### Disable grub workaround
> +# CONFIG_EFI_GRUB_ARM32_WORKAROUND is not set
> diff --git a/recipes-bsp/u-boot/u-boot-common-2025.07.inc b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
> index ed44bad0..2318e033 100644
> --- a/recipes-bsp/u-boot/u-boot-common-2025.07.inc
> +++ b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
> @@ -28,6 +28,9 @@ SRC_URI += " \
>      file://rules.tmpl;subdir=debian"
>  SRC_URI[sha256sum] = "0f933f6c5a426895bf306e93e6ac53c60870e4b54cda56d95211bec99e63bec7"
>  
> +SRC_URI:append:armhf = " \
> +    file://no-grub-workaround.cfg"
> +
>  SRC_URI:append:ftpm-stmm = " \
>      file://ftpm-stmm.cfg"
>  
> @@ -54,6 +57,11 @@ SECURE_BOOT_DEPENDS:ftpm-stmm = ""
>  DEBIAN_BUILD_DEPENDS:append:secureboot = "${SECURE_BOOT_BUILD_DEPENDS}"
>  DEPENDS:append:secureboot = "${SECURE_BOOT_DEPENDS}"
>  
> +do_prepare_build:append:armhf() {
> +    sed -ni '/### Disable grub workaround/q;p' ${S}/configs/${U_BOOT_CONFIG}
> +    cat ${WORKDIR}/no-grub-workaround.cfg >> ${S}/configs/${U_BOOT_CONFIG}
> +}
> +
>  do_prepare_build:append:ftpm-stmm() {
>      sed -ni '/### Enable OPTEE, fTPM and StMM/q;p' ${S}/configs/${U_BOOT_CONFIG}
>      cat ${WORKDIR}/ftpm-stmm.cfg >> ${S}/configs/${U_BOOT_CONFIG}

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

