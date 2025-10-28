Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93021CCF9E0
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 15:11:49 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.44])
 by mx.groups.io with SMTP id smtpd.web11.11478.1761664301620719670
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Oct 2025 08:11:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Pecgmb0u;
 spf=pass (domain: siemens.com, ip: 52.101.70.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iLiiPyvs2dVcafRxarVdKq1bHNSsAFD7OS9Ecjv/15Jg8ho6IwwoKxfnRJ8Z+fFVkXxnNSLGIWvawjA/gT4Ve6T/DxgZo/nLfhGyVUU99UwEvLOjyTnCjwSwYWRe56xy1CUN88t3BKqnxKkQU2IpkNv1iawg6Oz3usvgSmvvNOzzSyepDX4yqBN2E7p598x/4SwYNZ0jXjXuLPfTb4iuzefepuS9hhI+xVk2rrCtFNDTgSgNsSSn0/m+9eORJcEYj7F93uP/plOHv6b0PNmI9YqtY0ZRGgFZDWX8qtV2uY2GSm0/bVlWGsTU9usmOEnnECLDhjZ+vbmBCaodDoICjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrjkMnWx7FqUkf2WOiVS1GtcPws0X9o+kRlJajePbWA=;
 b=obzLX7w8TwkZ+AD6O6aUUjkC22J3bV4S3VViQKjqwMvtFoZzoXkb3oFq332V5LgEiJli0cChGHN+Zf9Leysp3VPQXIOGIIR96vnDh7NjhKvGh1LgFueE4znU/Z8HbhX56R+GzfXUw33SH9v4n6d/m2k8ADwwDutpAFro5qIt6o+7ES12z6BpNU3aAS3neE8oW/NejBDnsubmhbf4jGQmN3b9MDVxNmzxvqjbUQ8KPVKMrAKt7mV3dk41fo1+xlR2cOMr1nMuXn3OtMkb3yLsaBvJv4CabcIGX/PuKXZKl5oXTbxKdPAtgSUj0hnb3IwlYBSLZ0CDIkNFapOzJNRi1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrjkMnWx7FqUkf2WOiVS1GtcPws0X9o+kRlJajePbWA=;
 b=Pecgmb0u/IMlGXdLS4JDRV0LxREISU/+5CJ9OivIN6f2a5FOAdPqladNUyj96u8j543jc/KevMrBrI+ht7DqtRwOeUCwzGqwnjNBvCeAYaUDNPigcLWnwC1iHGOJByDRal8URwLCVD9mu6GiYCceHEQfTGMNekVFW2KzFjV1K1Jal/tA8kFxdP446y0VAsur0a05CnxoV1mYUyPsruN4kjaX7Oxn9j1mlPCp6HqhxJ7gO6Az9CSOq69rbx5E1DTIKEryRaHpdan4FL/szyKnCctcZJhCocGjq6kQH7podnU5vbcP6dTDo/S0kxiyzQk3DlJWgYpstSIi2yMvmuJ47g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3214.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 15:11:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 15:11:38 +0000
Message-ID: <fd2e7753-be26-4202-8e8f-ce206a359188@siemens.com>
Date: Tue, 28 Oct 2025 16:11:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC v3 1/5] SWUpdate: Use self-built SWUpdate
 2025.05+dfsg-3 for trixie
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
References: <20251028122042.2355451-1-Adithya.Balakumar@toshiba-tsip.com>
 <20251028122042.2355451-2-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251028122042.2355451-2-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3214:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc2afca-44a7-4517-00f5-08de16344a8c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NlkyeGRUaGZGcEMyc0IrRkZPQktQbTE3UVJ3R3lVSHdmbS95NDZIWDJrdm5Q?=
 =?utf-8?B?UjlocG1GbC9PMUFBVDVOU3hJQXdTdTN5T3hYU0tycy92RHd1eThtYkpyWTYw?=
 =?utf-8?B?U1V2MXdjR04yc2YySnE0WVJ3Y3FoQ2tZcmxmT2hwcnNISFFxTXBWeTUyYnJh?=
 =?utf-8?B?ZVU1bVdyaTN2WkVPMlNvUVQrUWQ1T0ZvUkVidTFoOXFzOTVtRmFaUzhNRlVN?=
 =?utf-8?B?QVJlbmlVbmxveEtJOUs5UXptVWkxaFBKejRxV3pBOVhHUThVelBkRXdxakd6?=
 =?utf-8?B?eXNCdEFveEoyelgzbnVnbUxmZGVBREIyeHFyM3JpUmFBaDFGSXhnQVhxT0xT?=
 =?utf-8?B?L1pFdTZnbFBnV1ZmTFRiSTVzcU9SSVZtd2FjejFUSGlEdnNCLzFFdDlmNnln?=
 =?utf-8?B?VkhUeE5WNXZsL1FqZmNEUW9KTHoxVzR6VXVzVjN6UzdPTEZqbnZLa0UyUFp3?=
 =?utf-8?B?NzRqOCtSNWN1Z0QzdGZTMmphcXU3eWVOSWJRY1FHamUwNUlRaDJLVnRIajFj?=
 =?utf-8?B?bVpxMlhsalh1dFl0Q2pHeFRIamVKNVNaK0JhNW1yTWlMU1B2LytsZldEZHRj?=
 =?utf-8?B?cDNmT2ZWOTgrTUZSVldWSSs0SGNjKzlJNzJPZTA1d1VFR2RBenJMcHhuOEhX?=
 =?utf-8?B?NFgveWJGd3hKRTYrbGJueHZ4K1J1UHB5bTQ0aEFpNUNkMXdTdDJOQVdKRnZN?=
 =?utf-8?B?eE1GK0VaeTN5aENVMmFJM2hNSXdGTll4NTgza2lXUEdNMzQxNFFVMGUra1Uv?=
 =?utf-8?B?Z01yRG1GM1JERWhsVnVUS29NbVU1cHRmMXB0eFE2Rk8xdUE5VVp6OFpWZWZW?=
 =?utf-8?B?cnNvZUViT1pSUFlWcmtXOWRnWGUwNlRWZXFWOEcvWGJrbjJibFhVUklDUHd1?=
 =?utf-8?B?blhyT09xRmVDeFZPdnNyRDFnRDY1SkVJeGIzNUs1RWRTS09YbW40SVJZUml0?=
 =?utf-8?B?QldPQm1mOUlEb1pYaEt0MjY3dGVuQWZnL1NTc0VLZ2VJQW9IVnBZK1F2dlg2?=
 =?utf-8?B?UWdNSkV4SmprNFRWUVp1cE9iKyswOHdYc0NPYkt0eWFVbE00WDVublFvMEl3?=
 =?utf-8?B?enpoRHlqMC8rUzdHQlJGODJNdDBjRmEyeEs3QXNBS0JxaGJVa0pXZmc5T1Fa?=
 =?utf-8?B?cDFSZGQzZDRNN09xcnpUcUxIcDZGZTBZOW9YYWg5TElXS1Jyb3oxcGZrZkQr?=
 =?utf-8?B?MjlxbzNncDgyQ0JGV01UK3B3RkJNSlFaNFBsSzNYN0hwRnFMWDZZeXZXdE90?=
 =?utf-8?B?VGkxVlFZdUxTbzhuQ2hLVmdZSVRvOHJzR3NCUHRTOEg2U05tSFgxMDVsUGRR?=
 =?utf-8?B?MG44M3NRRS9BcS9WdFRxYS90OE01NmN5K1luZVFQRGg0WXc0NEQ1WThOYmNv?=
 =?utf-8?B?N3dDYnRiZlRWZVJKWnMxdC9iWG11eFFWNE1SVmZITFlHcm1JR1oxR281aVJr?=
 =?utf-8?B?aFRncnhZMTlOUk1LMHlrOG41ZUlyVEpsR1VFdVBUY3drekNaSkMrYmtYbk1M?=
 =?utf-8?B?cWh1Vi9lZWkxc2dMaUUyc2NMU2hrbzRMcHVINW1MZ1RuOXFRS1hCaXpGa1ls?=
 =?utf-8?B?Q0pMZWZBWVVpQzlxeU4rSGFidlg0MllpL25uV2VsbytBTUVROVFHbWNNc21Q?=
 =?utf-8?B?NHZobjc3VVRjd1p0RlZYS053RjAraElZZmZsVm5LM0kyU296OERLQ1VYREtj?=
 =?utf-8?B?TnZ1TmJRR0VjNTNRUkI0akpBR1piVWZjaVlCR1pzZTA2WnhMYXRYQ0JNMjVx?=
 =?utf-8?B?S1Jtc3Y1ek43eUlZeTFHTnozZmhidlhhcXFOenVtdGY2dFk0SUNsOUg2R0N2?=
 =?utf-8?B?NU9MN1BSemd0VlEyNktxZnJaeElSUys3a3FZWkh2TGZRajRzc3FIWW1yWWd0?=
 =?utf-8?B?QkI4VmFlUEVzVit2bkIyU0tLVEkvblR4NmtYejVrT2MrNklzY05ycVIxNjdY?=
 =?utf-8?B?T2dTMXdOYmsrUkFCSFdXZ25kOHFXem9iSzk5cHViN3hEbXI5MUhOVkphYXVa?=
 =?utf-8?B?WXZjYmVqVmNRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ekNKUFJGUHc3Y2JNWXpIdDJrT2x2TUJHZXZlZEM2Mjc2RnVCcnVESzMvYng2?=
 =?utf-8?B?Ukp1eDlZTnJWYk9BazFTdHlRNGplOFAvTUV5T1d2Zy9CVFNjRXAxbEJ3OEFw?=
 =?utf-8?B?bmVtMU1RNUVRVk5ieVRvNElIVkI5ZmlLWEFGbGhOWC9qdmFLbEJjeHRFK1lo?=
 =?utf-8?B?N1F6YkZnc2psSWQrUlZNYkZsVEx1ZitlZW9WOXpzTDFoRGVGZ0d5bmhLdWZL?=
 =?utf-8?B?cGp5YmhjTUI1bU4rR3ppa0krY2JUMDhBWGEyODc2dGFPN01FVHV3QU0wYjFy?=
 =?utf-8?B?MURtQmZnQWxDWEl6SlRjUmg4N0tja2xjbUpXNkJNSVFoZUpYMWpHQVNEWnF1?=
 =?utf-8?B?dC9uRGxCY2UxUEpXYzVXQkEwWE80Y3BLMzFyS1dSTDNOMEJLNDhHdUJaVFpR?=
 =?utf-8?B?cVFEN0w0VnNDMGV3ZVFPMGxRYWhwRUZlMDd6TWlsNHQ2N1F1NFhLRzRXNks3?=
 =?utf-8?B?V0ExQkdDdFBMQkc5YW1JWWNMSk1GVWJpRDZzUGo4aHJKVzZrNkZjNjNVSVRO?=
 =?utf-8?B?WWU0MTZ5clVTRkpyRjZHMXdiaG5POHMrR3FIMWswL0dTSlExT2dLNDJCT1pH?=
 =?utf-8?B?QWg1eXJheDZINHYxUG5iL2FjQUJMOGFTTElBWFpGVDhqZVdWSUxOa3B1RHZj?=
 =?utf-8?B?dmdFSGQ3U1BZTFFOWDhyaHVHaGl2VFJmR0hIWG0vVnlxcjJ6VDJhYTVuSXZ4?=
 =?utf-8?B?TWRKbXdKUEhmeHBhanFrbEFCMytHTzZuODJ5WUlXekVKZENXYUxSaVhWbDNi?=
 =?utf-8?B?NjErMFdVV1ozNXVxZUNtbmdhTkhldExOeXd4dGpuNFdWL1RqNjJvUW1rUXF4?=
 =?utf-8?B?am50QkNNYkg0OXZHUVd4QmZTNHUxZ2JVUE1TZFZFdWozYzVLem5OTncvL2t5?=
 =?utf-8?B?N3R1MjZOeVVFYnFMRkU3MUZsV3plY0RqNlN6U29oQ1RsM2hRUHlwZHlWRy9V?=
 =?utf-8?B?ZXVvT1VqejdvOG85U0p1d3BDbTkvRDZZWG54cXo1QTNFeU82am1rSFVJcnVX?=
 =?utf-8?B?SjdpSHFWbEFLbmdTNFRQa0ZMdlhIRlMwWlJMd2RqSGlnRWEyZS9mU3h2YU0v?=
 =?utf-8?B?a2RrcDJxVFVyN2hYVGx0N0d3dlJ6UGNNWnRmajVnUjhuUjFxUXkxSVZUMzBQ?=
 =?utf-8?B?NjJ5N3htSnhRSkptaEF0WXhsbE8zSFBZV2wyb2FqNlVCMENpTlpGZlRQOG0z?=
 =?utf-8?B?UWdnUWRua1hSRUJWNXkyV05SZmRUL0VaRU1FeVEzMkpiU3VXN0o2RDRFaWpY?=
 =?utf-8?B?T1hOWUFEMlhRckp2ZWdwdzgwVG5qQjh4dnZPYTU2R0lZMCt6ekNnQjdYM1pI?=
 =?utf-8?B?OE9uaWVxZXNLMUVjRFRpekJBRU8vcFVZbEZJdGlmNitNdHF4eTgzZnM2Mk5D?=
 =?utf-8?B?ck5sbWVrVkN5WFBWTnd0cnFGd0V3amJDMDJNVVpjV2xQakxqZnBBdjUvYmlB?=
 =?utf-8?B?UC9Db21RbUwxejZXL0RsenM3UkVac2pDNGhTTDlObTFQeHRZS1dWcTBMcTg1?=
 =?utf-8?B?Z0JqQ2VseTR1NlcwMGJqSnQwVUNtbjlONVlCMU5tYzlBd2NNcDNFclVWRkc4?=
 =?utf-8?B?VlhWV1J1UEYwTzR4K1pJQVJNOXFvMUxqc1lHa2RQU1NlWHJYRU02ekp6NWR0?=
 =?utf-8?B?cGJ1UDlydGtYVUcweFpKYjZuVHUvWG9YbnJaQTdWRWZnRzZXNFhydG9McFBy?=
 =?utf-8?B?TVlpS0ZoSjRKaEtUM05uTE9maEJWNERLOWs4TSttWXZ4WjN0bkxzbXFhS0M0?=
 =?utf-8?B?empjcWtoTlRhYU8rV3hDVlNMdHBvQ3AzRDdMb0RkL0Q1aE9nZUFkNlJDcXBB?=
 =?utf-8?B?azMvc0cyUlF5c1BxNUozRnNoZEtvbnZEMVE5OEY4VDA3VzR5UDdPOEVnYUdM?=
 =?utf-8?B?eUl1RWgwS0NFT21Td2JOOWkxQzdUQ0VaMXhDQzVUTEhKbVYzeTJBdTlaNllE?=
 =?utf-8?B?dnBpUGVNdE9UdmQwUktFSXdRWEJnMVhjUDU1RzViWnRWby9kSlZyOUJUbXJj?=
 =?utf-8?B?OC9UOXNYYmgrUW9sRm1leUNBYVQvZURFdzRpSUJwRDlEeDh5WkxySC95R2dI?=
 =?utf-8?B?dWQ5L2kvMytJU245Mi94V0pSNWJjY3ZtcXJXZEZXaDkvUmFNTllVOEV0bkQr?=
 =?utf-8?B?WURUbUJpYlhkL1FoR0NCbytiL05yc1dSK0pXaVJSUWpuSXNVam4rZ3RzQkww?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc2afca-44a7-4517-00f5-08de16344a8c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:11:38.1045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcXluDuHxCgxrDS4a+eUs+VDRnf1qW0NXaUhF54leTpa6rQVDuDLH+zVbZCGDY1iiOZMJRdQ8quK9OmLdZtIkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3214
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Oct 2025 15:11:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20262

On 28.10.25 13:20, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> SWUpdate debian package for trixie (2024.12.1+dfsg-3) has an issue[1] when used with suricatta wfx.
> The issue is solved in upstream and the fix is also backported to debian but only to 2025.05+dfsg-3
> 
> For now build SWUpdate(2025.05+dfsg-3) from source.
> 
> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1118485
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  conf/distro/cip-core-trixie.conf              |  1 +
>  recipes-core/images/swupdate.inc              |  3 +-
>  .../swupdate/swupdate_2025.05+dfsg-3.bb       | 36 +++++++++++++++++++
>  3 files changed, 39 insertions(+), 1 deletion(-)
>  create mode 100644 recipes-core/swupdate/swupdate_2025.05+dfsg-3.bb
> 
> diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-trixie.conf
> index b133bbb..663f2b0 100644
> --- a/conf/distro/cip-core-trixie.conf
> +++ b/conf/distro/cip-core-trixie.conf
> @@ -12,5 +12,6 @@
>  require conf/distro/debian-trixie.conf
>  require cip-core-common.inc
>  
> +PREFERRED_VERSION_swupdate ?= "2025.05%"
>  PREFERRED_VERSION_linux-cip ?= "6.12.%"
>  PREFERRED_VERSION_linux-cip-rt ?= "6.12.%"
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 75be566..47f18c5 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -28,10 +28,11 @@ SWUPDATE_SELFBUILT ?= "0"
>  SWUPDATE_SELFBUILT:buster = "1"
>  SWUPDATE_SELFBUILT:bullseye = "1"
>  SWUPDATE_SELFBUILT:bookworm = "1"
> +SWUPDATE_SELFBUILT:trixie = "1"
>  
>  python() {
>      base_distro = d.getVar('BASE_DISTRO_CODENAME')
> -    if base_distro not in ['buster', 'bullseye', 'bookworm'] and \
> +    if base_distro not in ['buster', 'bullseye', 'bookworm', 'trixie'] and \
>         bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')):
>          bb.fatal(f'Self-built SWUpdate not supported for {base_distro}')
>  
> diff --git a/recipes-core/swupdate/swupdate_2025.05+dfsg-3.bb b/recipes-core/swupdate/swupdate_2025.05+dfsg-3.bb
> new file mode 100644
> index 0000000..5c47d68
> --- /dev/null
> +++ b/recipes-core/swupdate/swupdate_2025.05+dfsg-3.bb
> @@ -0,0 +1,36 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation, 2025
> +#
> +# Authors:
> +#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com> 
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit dpkg
> +
> +require swupdate.inc
> +
> +DEPENDS += "libebgenv-dev"
> +DEPENDS += "libubootenv-dev"
> +
> +DEB_BUILD_PROFILES += "nodoc"
> +DEB_BUILD_OPTIONS += "nodoc"
> +
> +FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/${PV}:"
> +
> +SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;destsuffix=${P}"
> +
> +SRCREV = "421a70d4449a9b036ed5a0598ae9b70a82dabfb8"
> +
> +DEB_BUILD_PROFILES += "cross nocheck"
> +ISAR_CROSS_COMPILE:trixie = "0"
> +
> +CHANGELOG_V ?= "${PV}+cip-${SRCREV}"
> +
> +do_prepare_build() {
> +    deb_add_changelog
> +    cd ${WORKDIR}
> +    tar cJf ${PN}_${PV}+cip.orig.tar.xz --exclude=.git --exclude=debian ${P}
> +}

You have read Quirin's email that this will likely come via a trixie
update? Let's give this path a chance first.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

