Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87179C3DA4B
	for <webhook@archiver.kernel.org>; Wed, 17 Jul 2024 13:06:24 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.69])
 by mx.groups.io with SMTP id smtpd.web10.14705.1721221582343259178
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jul 2024 06:06:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kieWDrv1;
 spf=pass (domain: siemens.com, ip: 40.107.104.69, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3gM+OqwIbo2DslrYa8bDTwSyBGpNGhy0sQa63jQP901zu+wUTIY70SOBM3u+IhefPCi1leI01J/+/MxyfSF8FKIeT0SC71mThmrknQoywEjPDjYx8DyiYn7B2mFl9mwKbsTW69TNRt5IjSoBaBIA9+N75xWQqAp819qTEvuOZVcvxYHnCPixhfRlrqO2BgnrwBGvfnE/nmprHY2QkFBZmsbxCq/uKTGSRoCOU3p+3jEEHUP31mt79wpEJjMInhEWkhdEi2YXg9jRD4o0EcH0YjM4AyPAHlOt+/6LvLGQmW0ypXDfHrwkulm1owAnONWsWv3UKvindzSyxn5pDHjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVad5keSSCXr9aBXLU8mb2WNLvIYoDqdfNyWl3e+I28=;
 b=gCE5Y6XeYec6z8zPJxKokziAZhc1lTObgjc6xzr7C+vEp4eGTXDNvLEzl2OnxqyieKDnNLmc8HkKLBZGOJknr+ZqWkMFYIKNtgM+Vq76Alp6n8KSnT1I6JWqPkIchbWQ5Ow6u1Yu5zIZqUdrykcUlkFXiEK9tArMyo4ZtjkVHwrhWSFyP8F8wUprx4fgC6926f0lOBlmPXdYHOQLLKF+NHo0rZ8H1T5uT+b7jYEFsWcIaxXoRhfDGWJPMSx76cCz26J/M1dOH/m5B+pe9oOhp+yeVbjiGmU80wYSk/yKQonXB0lh8BR/mJ/i68JvRnUSfNMndLDZRTc803u/Nkwy2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVad5keSSCXr9aBXLU8mb2WNLvIYoDqdfNyWl3e+I28=;
 b=kieWDrv1FhJHAWhGT3go6MPxDzMHG7D86OCsiIQTQwO6Nt4fbG5ZiOVK+qjN5bWxe3SKHSAlUEC6VNnGTdVozAr+cFlJC6cMTXUvCM7fj8zBnJs5YZFoWSH5K1TkjBI8/8ze3Pw6ZHejtzt6dgrashNSqUQweTnx9u+LRSykkf8c7AouiH3J4rwDVdJg9HLc10sPkhz4hlGyJ76UGolm91r1Te3vq97vELLuazrGJUaXzhNGX+uNni+VZ57iQpcPcgkVRfArYlOfiXXy7YJXbtoWGgRBZb1LFfW1XPqTS3LFoulfT/e8pYX4b7fWNJZq6xv1eG/hcaVAt86HTE3hUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB8PR10MB3912.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:169::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Wed, 17 Jul
 2024 13:06:19 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.7784.013; Wed, 17 Jul 2024
 13:06:19 +0000
Message-ID: <6316fcb9-ed8f-4ae9-bcb6-0e88a0d3bfa8@siemens.com>
Date: Wed, 17 Jul 2024 15:06:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] initramfs-crypt-hook: Allow speed-up of
 disk-reencryption
To: Stefan Koch <stefan-koch@siemens.com>, cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, christian.storm@siemens.com,
 michael.adler@siemens.com, simon.sudler@siemens.com
References: <20240715134630.1640160-1-stefan-koch@siemens.com>
 <20240715134630.1640160-3-stefan-koch@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <20240715134630.1640160-3-stefan-koch@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::9) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB8PR10MB3912:EE_
X-MS-Office365-Filtering-Correlation-Id: 5458fc15-8ac4-467b-a0ed-08dca6613f96
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VXQwS3lYY1A2RkpNaGVvWTQ1YjFBOXpCWi9UWW45SnozM3dBNkN5b3ZjWnAr?=
 =?utf-8?B?T3ZPYmJqUmZxQWtaOHptaVQzcUdqbUh3S1lkVFpaY0pPR0ZtU3FPV0RldjJt?=
 =?utf-8?B?V0hoWGpLeE5RWW1Wd2xiajNycHBRTGx2bjREM1MxYW4wZjJFWjFkY3E1Uldo?=
 =?utf-8?B?UHhycGhGY1k4VzhaWW1yeEkvSEs3VjBlUVExbHdTeWZNSjlVbmxsSkRDRFZ2?=
 =?utf-8?B?ODRSekx4ckR5bTdDSEp2L0E2L2xZOThNdWs1bFo5cGlqY2pBdTRRc1B2TERM?=
 =?utf-8?B?QlFHbStPaUZoMjhNZlcxbmNINnkyeS8wRjJqbVhIU3lyT2wyWWp3QTFzMVB6?=
 =?utf-8?B?VGlqY0RQQys2VVBKWjRjZWZ2SUZSc3E1aFNIWlVMSVp2cURZUFo2VEgxU1hZ?=
 =?utf-8?B?aElUazN6M05PcVV2N0ZVUW1MUzh3a1cxckJTVGZKRVdHamJIWGQ3N0tlSDNo?=
 =?utf-8?B?azF0WW5LRUhITXNDYnVpbW43R3llWmc1ZFlpcEpzazUwUzJ4bUtoTEVnWFcw?=
 =?utf-8?B?MnpsUXYvanh5TnBsNTlmajNBd3lncERZUk5LbnRGY2JEd1FvU3RIS2tMcmlO?=
 =?utf-8?B?U05yZ1hRYjJtQy84OVFLSVNGT3l4RE01b1RBVXdVemFzYm9qOVhka0FZbmE0?=
 =?utf-8?B?NkgycGZnbDQwQWx4d0QxUE13ald2MWhyNmVUWXltdHZLRlJFK3dYMUpuZkkx?=
 =?utf-8?B?WEdmMmF1WFhCWmJJa2NFRWFRay9XUmVEMU1Xbmdtc3d5QTRZakZYQ3NsYk83?=
 =?utf-8?B?NklEdHdSaWxHbWdtYXJVazIwWXNxMk9LVjZNK2tLY2NVQ3FMbmFnTmFOZWdG?=
 =?utf-8?B?UTZ3cXVEZktKTHpLVVdDVGJ4KzJuWnpmTUdvLzBDdmJRL2xlWWxJdkMrcmR5?=
 =?utf-8?B?MW9WNzFFSWlIZ2g4MXdhZmJBdStrTnhkTjRsODh4YlltY2N6WEFRanBpT0Q1?=
 =?utf-8?B?RTJtMjVHdlU1U1kyai9kQk9ONW1LK1MvNTJDYjllQ0JPdUQyVG0vMEJ1VG1T?=
 =?utf-8?B?Y1ZnMVZzTVBNOUFaMWdKRUxnTEV6czRFWUVuWC9hT1VabjFxWmVPakpiMXNa?=
 =?utf-8?B?WFNMYmNFUmkrdUtOWGcxVzBHQlZXUzBRRUdlWkJUU1EzMEVuV0NxakZiYy9C?=
 =?utf-8?B?dmFrak5wRFNidWRvMGdSZGdlRlRCT3Q0Tko5YjlTMFRKTHd0aU1LaXgxaE0x?=
 =?utf-8?B?S0R1UGV5U0R5WUNDTDQrZ0szc2VyZjNLK2E4QU9TQWdkN2pVUGRQMms2TnJs?=
 =?utf-8?B?Wlhjb0xQR0N5K0VHVlZ6TWJmNk9jY1ViTDV3NzNHTy9MRWhSeWR2Z2U5S09G?=
 =?utf-8?B?SVhtSWhiSEJzSVRCRXVUVGxjYnpQSjJFVDNjOGxIbGtHL1ZndWNYUjRCS0FI?=
 =?utf-8?B?Y3piMC9nM0VUcWhOUkJKWm5RT2VrMGRMMmFMKzlPbUttMWtZc3FCRjk5cDlG?=
 =?utf-8?B?cEFuM3pBaGR1VlYwM05Gb1VicnpYcGFIeERncVBiNkNVb092YVhNb0NjbmVD?=
 =?utf-8?B?NnhBeDVRTzJVTkYyazBMeUhKS2JmWS9pYmh0b0N4SEVjdU1XakFMc3lJVUtW?=
 =?utf-8?B?SnU2TlBGS2FiVEVxR0lSKzZUQlpuMThUaythSTFHaDZWLzMwRjMzL0JHOXlD?=
 =?utf-8?B?Vlc3RDBrb0Y1NklhZGdGMG1XN2ZCMkZYd1pMeWRyR1B6d2s5a3ZyWFl4UkVz?=
 =?utf-8?B?djdUT0w0NENUSUNybnFIMXUrUUI3bW5KLzBVblp3VFkrTjlUVWlpQ2MwanlZ?=
 =?utf-8?B?Sk45OTM2K2ZZdHk4cWx5elkzKzhpYlFOTjJqZWFveUZ3QXJZTkdoYmRkRFYy?=
 =?utf-8?B?Vi9KdnZaQ1RpMFVqRzR2UT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ekMzTldTbnI2c0w1SlRVSVRuNG1OWTBkdkpoZGJ4VHN4VERMaWIzMTRkVVFr?=
 =?utf-8?B?K2FqUnlyNE5FSzlIZ3AydGNlYnp2YzZRNVVnY3hYdjhyZmQwOVVmVEN4clE1?=
 =?utf-8?B?bmpGMkRCT2xtVVcvOW93QWlwRUZrSmtJWEZ5WXV6c3IzVTJycnBoSEZ5SG9F?=
 =?utf-8?B?Umo5bmR5Z0NrV0tnZ3BiWDlxWEQzT3dLSWRTY1VKQnpaTWZuV0E4eTJnaVZt?=
 =?utf-8?B?Lzl1YkROallKYzgvbEN2eFhvelRrNzdrOVJtbzZuYi93YXdPOGVkR3NmMWRP?=
 =?utf-8?B?TUMvMlBxRXFWaXVKR2c1WEF6RUJUWTFXeGJUdVp4SURsMVhuRTYweEViclRK?=
 =?utf-8?B?L3hudmFKdEFEZFI0K2pkcGJOMXBTWWxMS2FwRk5tMElwTWdhOUloS1pLQzBt?=
 =?utf-8?B?cldPUGU3c3F6N2FJRit2cG84VXZ3bnpoaEhaS3ZpWkVWbWFEcXFhVDVqb1kx?=
 =?utf-8?B?eXloOGFFZmRUam4ycHQrZEIralRCdHhrS1B2WXJzOFloMGdpU3VnWEtVbDI2?=
 =?utf-8?B?UU5zcWdaZUFiT0g1UlFOR0lvZXIzOVN4RjFVckdCaHg2RjFGWE5wcmJpUWVx?=
 =?utf-8?B?K00xZWJ3LzlxYmpUTjNDUSt5MkNiOURJQW1ub1NuY3IydHAydGRJNHVaYXM1?=
 =?utf-8?B?d0c3dUFsQkYyK1FSQ3J3VEhGWHZzU3RvekRGUHRWRGRxOStDekJxSkVBQ05w?=
 =?utf-8?B?OGViMnM2bXBaU0MzVGh5ZEpoUThmOEVlWEdqQWZYRm01WlNSTFVTcjBRcjBP?=
 =?utf-8?B?NzArWmxHZTMzaXl4bDJUVWJVVnZGU2FVQjJJcXlyS2I1R0p5R3ZzMTlqVmVt?=
 =?utf-8?B?N0w3cmFnU1k0cUJTNHZ4eGQwUktIb2xPeEtFcG1xUmFMNTNGOThRVHYyQWh6?=
 =?utf-8?B?MFcyYk9tVGhseUZKcjRoeHp2VW5TYUN5UVRvZytESXhlZWhzTGRLZkpWT3Zn?=
 =?utf-8?B?MzRRZ1dGaXEybVhCODRlRko2MEZSRExYSG1EaklaZ1B6NnVFZ2Z4cDB3N1ow?=
 =?utf-8?B?cjZWQThxYW1od2t6OTU5ZnVzVk1BNVFHbkZBYWJCbE1vbm51MTBObEpGNGhL?=
 =?utf-8?B?RkdaS0hRTitsR2h1U0ROVVFRRmhxRjFMTlZKUUlvbFFoWkZub0MwVSs4UXRQ?=
 =?utf-8?B?ZlZoS3FOZE1DR1ltdkNWSmlFLzc4QmM1YXJKQWJXTG9rcW1GQmJyUGdnanFl?=
 =?utf-8?B?cys4Tmp4clhSYlNhMzV1MnRMYjZUL2FJczlhbDVBK1Qya2lPeDBaYkJsbm1m?=
 =?utf-8?B?b2N6NWpwaEZySVFVZktscEpKaHJ5SXI3LzFTZThHWW16M0ZhQjNNU2dhVWZF?=
 =?utf-8?B?NHEyZDEreFhKWlBKak56TmxEcEZoYjg3MGtLMUlDOFJndTZXUXZNUWU2bjIz?=
 =?utf-8?B?Ui9WRVFrRmlmWHRvOEdET2tmVDFqUkw1bWRGVTRBT0RzMEUrdDgvdW1zQUVX?=
 =?utf-8?B?eTlCVzNjSkhYRFpQNksxWXd6TDFjUVNlUStvSXNOK1VGK0VSQnh4ZmRmVXZw?=
 =?utf-8?B?REt2REMvWU9NUVdqVnRGSW1IUEswdlVGR2lZVWhKajNzcCtIamgyY1NCbkIr?=
 =?utf-8?B?WEtaZUY4ampVUWt2V01jb2xya2dURnc5aUhpVkx0Nit1OWF1SGFPRHFxZmlX?=
 =?utf-8?B?aHBidlJndkNyMU5ydm5LUFF6cnJ6Z0k3c1lBNU9tMEx4djN6UU9SNFZIVUlz?=
 =?utf-8?B?dCtsd1k5aG5ERklLLzVqd2QrMFM1Y2w5eDd4UGp3b2ZVMmMwVWhaZnpOMFhQ?=
 =?utf-8?B?aFRudFZJc2FkcXNuajB1UmxwV0FQcFRDWTdOZ2FoM2hPK0VMVW9hVUo5bU9R?=
 =?utf-8?B?d2ZpaDVkL2NaaFhXaHAzcWlzeFNNUFFYdTlIUFQybitnUHNGbWhPZTNUbjQy?=
 =?utf-8?B?QkxwMC9ZWStwS2lsNmtvc3FWbUhXMUpXRGg1L0NEbTRFSysxQzFBQVhYdjl4?=
 =?utf-8?B?bFZ0T1BHSERuandaeU5jSUxDSG1ld0dTSTJVTmJwNXkrbkJzSmtzN0lkbEZY?=
 =?utf-8?B?T0FsZThjRk42ZUlWd2FGaVRpL2Z4TUc5c2QwcmNNZ0k5VFhCNVM5aThCSjRM?=
 =?utf-8?B?U2RCbmwzYnFrK0I4QlhHL2lYOUd3eENrOWs5eEdOVTFNMWcrNmlTaVBsWHR0?=
 =?utf-8?B?SUcxUGtlMjhqS3FuN29YNDhXenpIK3JKTCs5a0lUQWhiUXhOUml3SXpsY0lR?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5458fc15-8ac4-467b-a0ed-08dca6613f96
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 13:06:19.0051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiOuIE2eE/3c+7vgJIxlKYda7ScAjHQFhzDLFJCRBOJQb49Vs0lgffOE1DpzK13PKjpsvdS2U+r5uZkWy4sOipoV0dEPd506UhKsjJsd9Pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3912
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jul 2024 13:06:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16567



On 7/15/24 3:46 PM, Stefan Koch wrote:
> As the reencrypt mechanism doesn't work at file system level
> so it wouldn't detect used and free blocks.
> This means that the block-wise reencryption process could
> take a very long time depending on the partition size.
> 
> Using the format mechanism instead of the reencrypt one
> would delete all existing data (without wiping). This would be very fast,
> because it doesn't matter whether a block is used or free.
> 
> Set CRYPT_FAST_REENCRYPTION to "1" to speed-up the reencrypt process.
> So, this would be done:
> - Obtain used space of the unencrypted userdata partition
> - Shrink the partition and resize it to the size of used space (minimum size)
> - reencrypt the userdata partition now with smaller size
> - Expand the encrypted userdata partition back to the maximum possible size
> 
> Some disk encryption implementations like within the Debian installer
> will overwrite the entire partition with random data for security reasons
> (e.g. wiping old already deleted data, hiding metadata, etc.).
> 
> However, this speed-up lacks the described security benefit of implicit data overwrite.
> So for security reasons, it behaves identical to the format option
> (there is no support for explicit random overwrite within initramfs-crypt-hook).
> 
> Keep in mind that a power loss while reencryption will cause data loss
> (with or without fast reencryption).
> The key is only enrolled after fully succeeded reencryption, yet.
> So, no recovery from already encrypted data would be possible.


You don't mention why the losetup is necessary  additional to the 
parameter `--reduce-device-size` of cryptsetup.

Quirin
> 
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
>   .../files/encrypt_partition.env.tmpl          |  1 +
>   .../files/encrypt_partition.script            | 53 ++++++++++++++++---
>   .../initramfs-crypt-hook_0.2.bb               |  8 +++
>   3 files changed, 55 insertions(+), 7 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> index bb93361..2b02f55 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> @@ -5,3 +5,4 @@ WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
>   HASH_TYPE="${CRYPT_HASH_TYPE}"
>   KEY_ALGORITHM="${CRYPT_KEY_ALGORITHM}"
>   ENCRYPTION_IS_OPTIONAL="${CRYPT_ENCRYPTION_OPTIONAL}"
> +FAST_REENCRYPTION="${CRYPT_FAST_REENCRYPTION}"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> index f943aea..7bb40c9 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> @@ -54,6 +54,9 @@ if [ -z "${create_file_system_cmd}" ]; then
>   	create_file_system_cmd="mke2fs -t ext4"
>   fi
>   
> +# Path to full (non-busybox) losetup binary
> +losetup_path="/usr/local/sbin/losetup"
> +
>   service_watchdog() {
>   	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
>   		printf '\0'
> @@ -62,13 +65,16 @@ service_watchdog() {
>   }
>   
>   reencrypt_existing_partition() {
> +	reencrypt_device="$1"
>   	part_size_blocks="$(cat /sys/class/block/"$(awk -v dev="$1" 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)"
> -	# reduce the filesystem and partition by 32M to fit the LUKS header
> +	part_size_in_kb="$(expr "$part_size_blocks" / 2)" # blocksize 512 byte
> +
>   	partition_fstype=$(get_fstype "${1}")
> +	# reduce the filesystem and partition by 32M to fit the LUKS header
>   	reduce_device_size=32768
> -	reduced_size="$(expr "$part_size_blocks" - 65536 )"
> -	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
> -	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
> +	reduce_device_size_blocks="$(expr "$reduce_device_size" \* 2)" # 512 byte blocks
> +	reduced_size="$(expr "$part_size_blocks" - "$reduce_device_size_blocks" )"
> +	reduced_size_in_kb="$(expr "$reduced_size" / 2)" # blocksize 512 byte
>   	case $partition_fstype in
>   	ext*)
>   		# reduce the filesystem and partition by 32M to fit the LUKS header
> @@ -84,9 +90,31 @@ EOF
>   		if ! cryptsetup luksUUID "$1" &> /dev/null; then
>   			e2fsck -p -f "$1"
>   		fi
> -		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
> +		# shrink partition temporarily to minimum
> +		min_size_fsblocks="$(resize2fs "$1" -P | awk -F ": " '{ print $2 }')"
> +		if [ "$FAST_REENCRYPTION" = "1" ] && loop_device="$("$losetup_path" -f)" && [ -n "$min_size_fsblocks" ]; then
> +			# set encrypted size for expanding step
> +			encrypted_size_in_kb="$reduced_size_in_kb"
> +			# minimum partition size
> +			min_size_in_kb="$(expr "$min_size_fsblocks" \* 4)" # blocksize 4096 byte
> +			# shrinked partition size (reduce_size + minimum partition size)
> +			reduced_size_in_kb="$(expr "$reduce_device_size" + "$min_size_in_kb")"
> +			# set loop device as reencrypt device
> +			reencrypt_device="$loop_device"
> +		else
> +			# continue with default reencryption in failure case
> +			FAST_REENCRYPTION="0"
> +		fi
> +
> +		if ! resize2fs "$1" "${reduced_size_in_kb}K"; then
>   			panic "reencryption of filesystem $1 cannot continue!"
>   		fi
> +
> +		if [ "$FAST_REENCRYPTION" = "1" ]; then
> +			# use temporarily loop device to simulate shrinked device
> +			# because cryptsetup uses device size at reducing
> +			"$losetup_path" --sizelimit "${reduced_size_in_kb}K" "$loop_device" "$1"
> +		fi
>   		;;
>   	squashfs|swap|"")
>   		[ "$debug" = "y" ] && echo "skip disk resize as it is not supported or unnecessary for fstype: '$partition_fstype'"
> @@ -96,9 +124,14 @@ EOF
>   		;;
>   	esac
>   	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
> -		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
> +		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$reencrypt_device" < "$2"
>   	else
> -		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$1" < "$2"
> +		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k "$reencrypt_device" < "$2"
> +	fi
> +
> +	if [ "$FAST_REENCRYPTION" = "1" ]; then
> +		# remove temporarily loop device
> +		"$losetup_path" -d "$loop_device"
>   	fi
>   }
>   for candidate in /dev/tpm*; do
> @@ -182,6 +215,12 @@ for partition_set in $partition_sets; do
>   			reencrypt_existing_partition "$part_device" "$tmp_key"
>   			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
>   			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
> +			if [ "$FAST_REENCRYPTION" = "1" ]; then
> +				# expand encrypted partition to maximum
> +				/usr/sbin/cryptsetup resize "$decrypted_part"
> +				# expand filesystem within encrypted layer to maximum
> +				resize2fs "$decrypted_part" "${encrypted_size_in_kb}K"
> +			fi
>   			log_end_msg
>   		;;
>   		"format")
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> index 3497d95..e3dd515 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
> @@ -57,6 +57,13 @@ CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
>   # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the filesystem
>   # in a newly formatted LUKS Partition
>   CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
> +# Fast reencryption state
> +# It uses temporary partition resize,
> +# consider security and data reliablity aspects when enabling
> +# (e.g. wiping old already deleted data, hiding metadata, etc.)
> +# Keep in mind that a power loss while reencryption will cause data loss
> +# (with or without fast reencryption).
> +CRYPT_FAST_REENCRYPTION ??= "0"
>   # Timeout for creating / re-encrypting partitions on first boot
>   CRYPT_SETUP_TIMEOUT ??= "600"
>   # Watchdog to service during the initial setup of the crypto partitions
> @@ -68,6 +75,7 @@ CRYPT_ENCRYPTION_OPTIONAL ??= "false"
>   
>   TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
>       CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
> +    CRYPT_FAST_REENCRYPTION \
>       CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
>   TEMPLATE_FILES = "encrypt_partition.env.tmpl"
>   

