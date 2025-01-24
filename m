Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF03C0218B
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 08:32:41 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.88])
 by mx.groups.io with SMTP id smtpd.web11.7184.1737707553415502852
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 00:32:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QTyStfxI;
 spf=pass (domain: siemens.com, ip: 40.107.22.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fsqe3T8GDh56od1v9WtgbiqVgoSlpR9BxIIVEtSszIgSDig4wuZbILltRHeAGNiN7iU8JUv87Wa2R8Dy8RWlQzxiiPVD03dl2szp4CkTC1h94gaGgXW4sjM5/FwAz+0rkms0YBERzdREPDhdAf5uFl57WEEYnVHN5M4EDyqoCQxtg6bR3aAZvxblpe9Kvmvu8LSLGYeUNqq/DLfH4NyxIBB/whhxVrEF7wkBAz5tfWG0F5xuDZQy5MdNbItwz9wQUemI1udVoL0z2EUZsYrI00P3s3YMWzN/Y6RrGoH6+uTruS6HYRgH61fC1Qapi6VwTlEbX1xTIJzizgEF3sxBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkvugJhDz0n1KpyYvHSOId1iCZD1vrj5x7HzD2J3dIM=;
 b=t7AoKUFH2UTMpuVvglqkw6FWZgcCy4BQREM9+DNfkTLX9I6WRqg/tTBH8uVdEOqusdaY6tz5JwPbL409B7WtD3hGYU+FVhbhV3TOXC5gPQc7/z0s87WhCNzCSOKQwVokNC+sAB++MklRKTNOYA5whQj+lNJ35YfQlyYFMku7ku/jTdKQ2xQXbC2UEzaAkUexti4eusQwKbovGXBgP1MumDNDecy80BSwCZzUTA+8wI1Fb+t1nRb7c5khTCJzNxv5zE6P+SefnqgL3KZykDOriepdYh5ZTgQKpOeQqTZ/4F5l+zyf5fnjNR5chR6uFPYYbmnCUDBBDXUOQcUI9YxGLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkvugJhDz0n1KpyYvHSOId1iCZD1vrj5x7HzD2J3dIM=;
 b=QTyStfxIAHuu3yXK/+dBaUiesn7PRRdZnC4VyZOmfKAXXImA4Yq+omt9YhqVht5vnk7nhfONIA3KBmFMUDNYZK9KVJ4/DKz1lf4yBkJh+cKj8B6WTzqW4Vv9by/ntrQPQIns0Yjd1zuV3l2u2GOFNhRhIgky9AStZ+7rkUwK7S8kq1YAy5PZIQ/F2Yp+4C7vtPjuRACvL1wl1ubwpcrtraN3hLzUEggWDKt5/sT3XgYS2xIba3XoCxQfFQYqUML9GrsMVf6N8sVj+sWYagdk1WIJ6XBT15WlxQ8STXN0HApWYB/xK1a0bL9Plxf2uyeewyZB/Ox7TSMTenFmpFFxJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9165.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:569::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Fri, 24 Jan
 2025 08:32:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 08:32:30 +0000
Message-ID: <82be5e51-7cf6-4a89-bc81-e04ab86bbb8c@siemens.com>
Date: Fri, 24 Jan 2025 09:32:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 2/3] x86-uefi: disable watchdog
 for testing on mcom
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
References: <20250124080659.469424-1-Quirin.Gylstorff@siemens.com>
 <20250124080659.469424-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250124080659.469424-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0096.eurprd02.prod.outlook.com
 (2603:10a6:208:154::37) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: 89dc119c-0818-4674-dd86-08dd3c51a456
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dHlsd0V4S3Fza0k1OUs1bkZzdlBEU00wc3dnSFpQYzJWWTRBQnljaFJCUmp0?=
 =?utf-8?B?N0M1ZFBKNHdtYzQ5T1hkUUQrcmxoTTc2a0hodUpXNjBFWU10TUhjUHU5bEZa?=
 =?utf-8?B?UFlOOHNNUU5RbFovTWIyMU1vL3hacXBGb2NQc3ZwRHlQZCtkNUNBQWZHeVQ4?=
 =?utf-8?B?VFN1bm5MYjJwdjVqVUJ5bkpHaWxKMHF2bUFaeVZzeDlSZjExd1dOMDl3TzVP?=
 =?utf-8?B?OHBLUjJveXNyZ3dkQWM3M2hhNXdYNmc4aHppU1FlVHF3NkRjTGhtQktwUHBH?=
 =?utf-8?B?N0F2d0I3QzhuUlZlcG9VWWtRbVhKa3NSTXk1TDZIeElubkNEOURJRlZwa3RW?=
 =?utf-8?B?dUhEWVBYYUk0alY0bzR4TDNoWEl1K0ZqUmo5Kzc3bWh1Q1hBQlduOVpLVEhU?=
 =?utf-8?B?YzhCKzJZcTRyd3M3VElYRG04MWI4bEVOdkV2ck5vQUR1OGhvbVNwd3J1Y21D?=
 =?utf-8?B?RnRJMHFtN3Q2V1NXaGtzbnhybXlaaW4xd1REenpWZ2czMFFBUkNRYk9IZ3JH?=
 =?utf-8?B?Z1htNWxIYStDSHQ0d0JGMjl6YWQ2b1RCeDV4MEl2R0x1VWwxT3NBa1pXVGJI?=
 =?utf-8?B?OGVCS3AxSWZiSTVCRWZaQzdiSDFBcXk3Y0lnaTIyWFIzTlphZDFpNTBjczNY?=
 =?utf-8?B?SjdDKzRNYmlsZ1pWZlc2RFc3UVAxWE5rZTB3RnY3dkxDN0tjcmNwOURxcFo5?=
 =?utf-8?B?SEUvaFV3bjgwdXY1Z1Y2WHZONGU4Uk1jOGVvQTd1K1RaS0hVeTIya0RKNDlU?=
 =?utf-8?B?d0g3YU5XZFo0aXpibUJ4Y2taZVN6RU9idGVFai9IVE54RzZoaVZXL3ZFRUhp?=
 =?utf-8?B?ZU1Eenh4YmtML2RXZ28xUUI2N0NEK2xzNjV1TlIzZm1vcnpCWVpLNE82N1B0?=
 =?utf-8?B?TW52Smk4dnl4Qlh3cjUrTEFqZ0xxU2d3T1NRYWtzVWNNY3lWcW1Mdi9JMTg2?=
 =?utf-8?B?M1VGaUQxblZLR1JENkh5YWhmVE9tOGJjR1NwN1E2YytJQlh5aVlPOU5MTlkr?=
 =?utf-8?B?cFpDMjl2RXVDSGVlUStrenc4dzNmWXFWT2ludkVtSlV4dGNKbVlOQTNTZzVX?=
 =?utf-8?B?ak9oVEpBTG5qOWMyc3ZuZTBwbHZDa1VraC9JeFZ5S21HVklRSjV2TURGWGlU?=
 =?utf-8?B?Tkpwc1JLVThFMDkzc3ZXMHZrN2hwNlBKNW1udktjQXZkTGs1MmhVVFdnbTRh?=
 =?utf-8?B?UVQ4NURzcHlCR1lORGN0a2NFNmxmUkFaeTB3SzF1R1hkRmxoazR4VTFuTStp?=
 =?utf-8?B?MXRsY1BtQUJEcmdwUjBNblNUWE1XVDh0VmNqN29GL3R3NXhXTUt3ZjdXSFJD?=
 =?utf-8?B?S0RxenhPVDg2QUY0ZTVpcTZIUmtaNFEvNUswUFczaDlLYTdFekcyZC90SVVJ?=
 =?utf-8?B?bS9CK2FIQVlzWjNVek1zeWVyVldiallpc2hBMU1DNzQxTHp3VnJLR3JqLzhU?=
 =?utf-8?B?WDlqbjlnWlY1T2dqandSTVhDR0RCQmZPY3A4c2tGQXUrVXI5aWswN2M5cXRU?=
 =?utf-8?B?RTBnU0F4Wm5JYksyMVN2UGExTDV0cVFodjFwOExjNWxrSU8zYW1lZTBoYzdu?=
 =?utf-8?B?OXREUG5UUUhXeklFazA2Z21VcHQrc0dYYnh5ekxLVDB6S2x3dG5BODBMSExO?=
 =?utf-8?B?Sm5lUVhLQU5qNkVwSGZIVnM3cnVpV2NSekRmcjRXcW02Y1dJa1FqajR6bzUw?=
 =?utf-8?B?Q3BmNmlOQkRRR3lXcFdjZWQvZlRPV2s5YnZubnlha0dzcFE5M1d5YzZycFM4?=
 =?utf-8?B?QU0wUUlFd1F0SXd1dS95N0pzYXJoMitVSHFIOVFKQUlZNzNRRWNqWEhSdE5p?=
 =?utf-8?B?bkF0Y0dYSXR1dm9nNC9MdHZxd1Q3VXRBWWRuUFBVVy9xMDFUd0VrYVJTM1ky?=
 =?utf-8?Q?DUdoX6c37OVCg?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q0UxNklsTVVIaFhkSy9LVjh6SVJFM0o3bVZXcmVNOGRWaktsMEdyNStHSDhE?=
 =?utf-8?B?ZHpCYlJMRUFDTGZYbG8wZ3I3SFN1ZThtMjYxZmI3MW43RE5BZERlNnlBU0p3?=
 =?utf-8?B?dzJvbWRZZFloVEFEYUdDQXJsQjBVNDQvT0UreGZxMk5ZdW1xaDFJSkxOU0tx?=
 =?utf-8?B?UzdTT0NaVE10WDV0MmtaNTlTUTN2RTU1L3pHSFd3VE5XWkIxbnZSdW9EbXJJ?=
 =?utf-8?B?R0xqaE9yc0gram1YOTJjNGFEbTZnZ2pXNmlYK09ockF3KytZSlR1RGpLa3Vw?=
 =?utf-8?B?Z3JCUXQ1bXFEYlR1Q0JXMWtOdTVBaDBUQnJmeXdDcTdpQnp6N3VDL3VDS0hy?=
 =?utf-8?B?VnM4clhRN2NiS3BneHpXR0s2VlVWTUF3OE9JUCtQVW14Mlo3a2dZV0oxbVR3?=
 =?utf-8?B?TTNqMkJRNDA0eXREaHlhZ1Jtak9iQjh4NWw1ejd0a1BKak9hUldLZHZ6NURM?=
 =?utf-8?B?N3VLWGN5Z1I4ZmZWNWtEUlBDLzEzZGRidkx4NEtxVEdYY0JLWk15WmR5MFVl?=
 =?utf-8?B?ZGZtbTM3S2ptY2w4SFc3RHJWWGs4YllUOFNldVRIQTVYZlRFcnc0UVAzbzRu?=
 =?utf-8?B?ZHVVUlpsVTg0ZDdRWWlXaTNyc0gyTUJQMXk1ODNhb0wzaU0zUmxlSHEzSUFX?=
 =?utf-8?B?UVVzTlRxQjZSd1IweXdoeGxGYnRxcFYzQVZLK1V0OXpWZWJlUmpNcDVwbjN2?=
 =?utf-8?B?N2srQ1FWSnNBTnlYaHlLVVhHSGJtdW82T01jL0JMTnQvUXRXdGZTRVkwTU8z?=
 =?utf-8?B?MDVTM1g2NE94UzNWT0w2NUJnc3RmQlVjVmE4dXlrOWEyNms3Q0cwaUNOVE12?=
 =?utf-8?B?ODUwVGpQcW9JSWdlWk80MjZMWnZJMFpTWjFyK1FNQlk4MEh4MnlzMXc2eC9r?=
 =?utf-8?B?cGZCeVlFYjdNVkVuekVzYndtVlVVMldlMWoyRmZ2UUg3dG1EaUZZMXdPVUhi?=
 =?utf-8?B?eTRmK2Y0UDd5RmUySzhzUlk5YXFvb3pDNXRFd1dBYmVXYU9iWmNQUlhUa1hl?=
 =?utf-8?B?K2VsRGNQMjVhYVpRY0dWcmtKVlQ5aE5xWjFKdWZhZzVqSFhFdHdoelZoM3d2?=
 =?utf-8?B?M3YvQ3BkZDdIV253QmhBNCtqMFNBQk44TnM4VWtaQ0VLMXJNTWlQQUFoUWdx?=
 =?utf-8?B?SC80WjFvZTNSYVVCT3VLQkpKbTNGTVgvQlNLSldhSTRqcGg2WDRZTi82N0ln?=
 =?utf-8?B?bUNKTmxNSm8vTk40b2twaGtJMlVJSkhvaGloQmJGb0VzQ1oxaCswbmt1bWVH?=
 =?utf-8?B?RUphUGpTR0hQeGFWVGN0ZGhrU2ZoSEN6THpiYTRyeS9kOUJXRnhiRHcwandp?=
 =?utf-8?B?NmFTemFEUGVRRTNuU3ErLzF3NHRwaEEwekdWZ1dmUmpzcWtydVM5aFVMMHhT?=
 =?utf-8?B?NHpKdTE0S2EvVjNIM2ljMGFYWjNPM05FTDNiT3QwUGxXT0JleDlkYkhXZGk3?=
 =?utf-8?B?OFZOZ00wLzVMbzEzTXpBWFNXc1hpdWVha29rWWt0ZnNhUEUwdTRSbW5mZG9S?=
 =?utf-8?B?RVc5NFR4UHBqbi83eWs2c04wbVJhYm9RZHNRRkZhc1kxRWkvL1gzL3pvSTYx?=
 =?utf-8?B?UlBwc2FvekozYVVoeURuUFd1aTRCclJQZllaZmJ3c0VtNFJBcEgrN2UySzZm?=
 =?utf-8?B?L2NGRVd3QjZNSzdvQU1JM25IdVFDTksybnZOY3gzVXYrZmtwUHVNZUhORENq?=
 =?utf-8?B?RDN6bDNzSGJYZ3VpSDh4cmpNQWIvTTdtbXNPMEtLU1AwN1JaZlBhc0RSTUNE?=
 =?utf-8?B?Ni9iS3M5Z1JiekIrY0d3S1p6S1VjWjV0ZDdvSlJaRGpiYm9sQTN0L05VZEQw?=
 =?utf-8?B?bWZWRjRDOURSbktBd0NWZmJWWXlzTnN6Uzh2b3JoLzRydDhpZmhHQTNIclR1?=
 =?utf-8?B?RVBwTHV1RTAyQXliVElzUFI4Zk1OaHkrMVE0emlJNDlDV1hjU1c4UHFKQnpS?=
 =?utf-8?B?VmNyNXIwQ2lyLzNaaCtpcG1pNW5xRDFjREFPYWpkWlYvbUNqZDAzY2drOU9K?=
 =?utf-8?B?VHdINTZnVldGTlVmMUxwZ21sc2F6V3k1RkQ1cy9CVTVFUWVmc09jc2RQWXJQ?=
 =?utf-8?B?N1RrNVViYWgrZnBVNkNqV1haU1hGL2R3Nld4RFhoNFAvemkza0tVOUlPVUJx?=
 =?utf-8?B?ZGJFV0l4SjgzT1p1eVhCL245N0tNaVcrWitvL0xOOUVCQ3hIRFppZWRTQmVD?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89dc119c-0818-4674-dd86-08dd3c51a456
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 08:32:30.4842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N06Vu6MebrxpZsOemk5HIVH6lk9M7b/PNPHziZEdV6LlSNnjDD0ebM8ZbmWJqq0dZSENsIP0OiCOhz9AFJdPDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9165
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 08:32:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17620

On 24.01.25 09:06, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Due to the multiple watchdogs available on the mcom
> device efibootguard select the iTCO watchdog and the
> Linux kernel selects the WDAT watchdog which leads to
> an system reboot during booting as the Linux kernel no
> longer drives the iTCO watchdog.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .gitlab-ci.yml               |  2 ++
>  kas/opt/disable-watchdog.yml | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)
>  create mode 100644 kas/opt/disable-watchdog.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 42e247d..97ef031 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -64,6 +64,7 @@ default:
>      - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
>      - if [ "${release}" = "trixie" ]; then base_yaml="${base_yaml}:kas/opt/trixie.yml"; fi
>      - if [ "${encrypt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/encrypt-data.yml"; fi
> +    - if [ "${disable_watchdog}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/disable-watchdog.yml"; fi

"watchdog = disable" would be nicer to read. Just make "enable" the
default and turn it off when needed.

Jan

>      - if [ "${swupdate_version}" = "2022.12" ]; then base_yaml="${base_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
> @@ -250,6 +251,7 @@ build:x86-uefi-secure-boot:
>      use_rt: disable
>      targz: disable
>      encrypt: disable
> +    disable_watchdog: enable
>  
>  build:qemu-amd64-swupdate:
>    extends:
> diff --git a/kas/opt/disable-watchdog.yml b/kas/opt/disable-watchdog.yml
> new file mode 100644
> index 0000000..88ece6b
> --- /dev/null
> +++ b/kas/opt/disable-watchdog.yml
> @@ -0,0 +1,15 @@
> +#
> +# Copyright (c) Siemens AG, 2025
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  no-watchdog: |
> +    WDOG_TIMEOUT = "0"


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

