Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21877E7717D
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 10:21:04 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.43])
 by mx.groups.io with SMTP id smtpd.web11.7712.1733912456110244367
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Dec 2024 02:20:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ry3awglo;
 spf=pass (domain: siemens.com, ip: 40.107.21.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N40gzTR0QPDTTYAFD22Va4e0r+TuxLiOGG5w2GlFN/IICJQre92HpUvXRFugL1fNk0QFXWwtm+WVXErDyqyD4bZrnH9ZktYYkPfMq6oE4nAxQ9tDCOEdvW1JLKN/ovgXNmnq3x13L9VHH7QGOxF+8FGNbReMZhyIFhoY2uUiFsN/dlUa1PyfcEZ+xG/gcPpcoQQAofUD89iJdbwajW2P3WHCs0EWhJh3ObfzSDFVevZUqWde5TO2NI2GeX1mBgCX3x0VlM4sPSqVyJASbSOJBLs7MCZV2g+JBQMijiGmJxL8NVcGBr/oExntSDDn+AoAbbiE11DKcRMvlYHpGmASKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnlUHkoNfeV9tpK9qCuhbKAbM7QAER7wQEGSGOejflM=;
 b=q/K/MFu/L3U+3S+0mB928UluWj/y2+9t28a7w6AuurjC8Us8SQbn4u/Z5hZ3sZ78wFs0I3byWoCeX6kvKEoVWq/v0Hlun15f4l7nKs5p4hj182O+q3ys1nQFLfpxAigX6FVO71FP7uVZD0h3/hQRT8rd467xi3ZC2C71h9xH4ds4eqaYbVRcUXoKY8zMeDjiqB/35yVYN8hu644mn5zRXrYPWuT0YJIb6OxqWOA5eTwnutRMP6JgK2vMabG9GxprsyzzarIRPgX5qcNMwGv+5kOkPrdmMGoU6fkIc0nQKM/9c0MHRvizKyDczvzMcO2NhurtRoI9dBdza/X6uwsVwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnlUHkoNfeV9tpK9qCuhbKAbM7QAER7wQEGSGOejflM=;
 b=Ry3awgloV8cYCEHmyRiLLJrckdZB4d1DTHYAX5ob18Dn3jTGgFxGRJM+NHec09I8keESP3vNOQeVULpZ+AMtM9LyjZEdUNLqSSoVH5/EVVrYmGVr/hj8+n5hpy4jbvAWnm7IAIqYC+JK5xwRmBnUaF279cEzo2F8XGDoATUPHNMkNU2oLWYq+FdQWs4Vpwm3DaSx04kNdkWT/I66gMkEtZbIgOrnLYG4HKj/AiNIPv5XyleVV1ZT24igBWvPv7Wsbj5PX4vyWj3vvxukwIckpb4AsyuaP02Fg15JUBTooRUPfCMiFPNwS2eEQdDaXskm3VVpLYle3pcq0uv/rIVAAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5395.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 10:20:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8251.011; Wed, 11 Dec 2024
 10:20:52 +0000
Message-ID: <3d4b96a8-62f9-47cf-950a-d0127260c9a8@siemens.com>
Date: Wed, 11 Dec 2024 11:20:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/1] define RO_ROOTFS_TYPE before using
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20241211095628.2735849-1-felix.moessbauer@siemens.com>
 <9c43e89d-64f0-4248-a155-7ea1ee0ca5a2@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <9c43e89d-64f0-4248-a155-7ea1ee0ca5a2@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5395:EE_
X-MS-Office365-Filtering-Correlation-Id: 777125fc-cf2d-44d1-96b8-08dd19cd7d71
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dnVvVkprYXdvWGtNcnRxWHBVZDFUNVY4SG9VV2dDcFN3UVFJcXZrT3lZRnNt?=
 =?utf-8?B?aTlPS0svTVNOUU9xd2kyVDN6MjlzKzRaYW5JTElDM2tMV0pQcVppQkRtR28v?=
 =?utf-8?B?dDNaeTA2RnRqUmg2WFEyM0pHaDJHUEthUWdSc1pXRHdlZ3FuZkl6YzVGY0pk?=
 =?utf-8?B?c21aOU5BbDRNWTVTNHlPclZGT1NNMHpDeVpJVkJ1SEpKRzE4TVdRR1c0RWw5?=
 =?utf-8?B?UHJ6bXdFZGczR0FWMUxEUjZCdXh4anpLV1g5Q3Q5MUxiek1SZXFVN0UvTi9V?=
 =?utf-8?B?SW1EY1NZSnBtb2tjM0h3b0grYUJJWU52VUZDOHhsbmFQcmx1Y3FQc3Z0K0Ir?=
 =?utf-8?B?V25LbmdTc083cWt1VWI2aWkxZHdyRTNaSEdIZ3RwK1FiRTRBekNxRVV0L0w0?=
 =?utf-8?B?Y0tvOHl4K29kc05qREtTdHVQRmhMcVpJTldHNWhQOHRrcVc3VHhGSTladHZt?=
 =?utf-8?B?SndFWE9uSFprbkUrbmYvL3ZUdUFDN0txM25KZkRSVEhoRnVJQjJXV3lnZTJN?=
 =?utf-8?B?MW5kSFNSbmRKTm9WVDhRNUpuZS9GYlJGcllyTE1MdkV0Ykt6aGsyRkZyZnoz?=
 =?utf-8?B?YkFuMU1WV1BldVhFNjZOdFJraGo4NVhHWXY0VE1TNjhRN2JvOC96K2oybE1T?=
 =?utf-8?B?R3RJSEp2OE5RTk1kc2tvNlEzZzlpY282dWJaWnl5YThibmVlVlBWVzZtYWJp?=
 =?utf-8?B?ZVFNZEQrd01UNHVFMUF6dEVvUTdkWjJjQkdNS3J0Mm0vYkhkZWJhbEJSalo5?=
 =?utf-8?B?elRzdC9NTFgwaE8xazVSOHJEeWx1ZVBzVkxnS1ZtKzJFVFNXbUJyYlZucHJo?=
 =?utf-8?B?b2F0eFA1LzNYeEk2UWVmUHFnbjZoeTZCTHg1L3VTZFNwQTk5TTRQRDIzUmNl?=
 =?utf-8?B?WGNUT0ZDWHpNTHBVL1BBVmlwRW91blRmOGFkdGlvZStqOUg1eWJwYlpNR3Vh?=
 =?utf-8?B?a01pbURkZThkV0V1OEYxZXdCakVMc21hMEQyYUE5UGtrMndOTFQ0WFlwUjlw?=
 =?utf-8?B?MjNmMmk4N29XdC9lTHlZVkd1YlpQMHd6eHVXNkFJYnFWaVJEdG1BUitHZGs3?=
 =?utf-8?B?RUhsM0tKN0RwZ1ZqUDU2VlhKcjRUelJ6aCt6SG5HbisyMWZ0SStmV1RRT25z?=
 =?utf-8?B?cFY2YlhMT0hpWW5qd3hjZjBVOWl6TjJiNmVWS2ZiN1FGTVpqMkZ0bEZLa1Bn?=
 =?utf-8?B?ZXpwNmpHNHBLTXllc0RCVHhidFAvY3ZTVmpRTERvcHZKb0FTakZjWE5pZlJK?=
 =?utf-8?B?TkFSZHBCOUhrS1VEbGdZOE1UZTRxM3hSUTJhOEFMbWcwcDVGOXF3UlBxSWNY?=
 =?utf-8?B?UGNVbElMME9MTUFSVWlGbUJ3Nmd0aDl0K2gzalpZL2t3T3pYaUFGdGF4VlNi?=
 =?utf-8?B?c2tmUXpDL2lFWmpDOHVhNFlpWXowWmlIMHYwYzdwTEtUU2tGaDhoUUN1cWk3?=
 =?utf-8?B?b2gwd29hUUhNa1ZVY1hvQkdrWU03VjkweXRPdjkzYk9ZeWwzNEUxcEM3aXBv?=
 =?utf-8?B?VkhEYmtyU3JMTUg0VjFXTVVjUzViaWl3N0MvTXVvREtVelVsQVR3dnhRbFl5?=
 =?utf-8?B?a1o5NFFaSm1NVmw2cjI2OHFpdEhGN2pZMWZ3MGxKa1ovWjZISDYvSENMK0JE?=
 =?utf-8?B?MmVNZWdiQW9CNSs5SytLbnk3NXM5ZXpQMjM1UFJpb2NTaWt2SVRyS0FIbFYx?=
 =?utf-8?B?ZEpLRDZCcnVxc05PVTNFbXhkeTg1K0lBMHNhRGN0ZnVtVWt5dnFKbGwwOWVy?=
 =?utf-8?B?SFFvK1hHVmNHbUJFSDk1bElUOUJJVlVsbXREbXFTWEFnaGZUZ2hOMSttRFlK?=
 =?utf-8?B?a1BDMlkvTFBOcDIyQ2xmUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NitqVTFyRUNUNXdyRzV5aDlGSmp2dzZMVU83T25zRWhHdnpLVmx5L2hxaVli?=
 =?utf-8?B?K2RwOFFjb1BTWWxmZDFjZ3lPVnFSTk50blQzUVFuYWhwSXNPNXhNbHMvdWoy?=
 =?utf-8?B?NndyNTQzVjgwWEJFNGNWeVVDSEFpZmU2SjZNcWpRMVpubTAyQUtYYTlYY0lQ?=
 =?utf-8?B?TEk2MGZWS1pHVm53a29hcUxSUWp3Q1lDeHB1T0h4NnhyTUZUei8xSi91YW9h?=
 =?utf-8?B?cmgwOG13MzM4bkRMTHhmMU4vVnVaM0pZaGlQcStjZEcxdXZjSDNBRkJUb2dC?=
 =?utf-8?B?MDMzTWRHUkx5Wi83Z1p3SHNQT1cwNE9jRm9ZWFJZaGswZ0t1anNMWW5GVWkv?=
 =?utf-8?B?TWtsMXZIQzdyVEFvelpmdkFtRElSRWkrZWJ3WGsyQWRHelFBM2ZQcWFCQVRm?=
 =?utf-8?B?WlNnQVJvSHFiVGZuNllxUWs1S0p3ekswbmlsOXI5bmp2b2UzSlhUT1RaSi9m?=
 =?utf-8?B?ajkvNVRZV2Y2WGt4SGJXaWQ5MHlXZkoxcE1KOURlRytGLytueXRXdzBVUGRV?=
 =?utf-8?B?SFpHdnhDUzFzOW1xNDJhYm4vYXd0cXhqNVlyZ3ZtUXRXbjYybUV0NWdsVTBD?=
 =?utf-8?B?eEV0djFIZ0dBSzdiOFdjMjByaERQUFd4MjdxUlZaQ2pJVkIwU0tGTjFBVW82?=
 =?utf-8?B?am0yaUlNQU1jazZtMHFTUk1OS09pckc2Zzh0bEoyNUZuYlVYQVFMOUJjMG13?=
 =?utf-8?B?ZVh6TXJHU2lRZmJNY1VYNkdCNFFUTlJ4RkVYU0JFRUdiWjBtQmxsOGFTQjc0?=
 =?utf-8?B?eWVRRDhCRnNvTzhRV1ZWYnBuNExnOEo5MGtWN2pYTzBDVDVyWHhZc1BJVjZX?=
 =?utf-8?B?clRuV1JUWWR0OW9vRndyeExWdnVHaHVlSlN5V1YzbHJuT0d2ZlNqaE1GQldu?=
 =?utf-8?B?VDJVRTVQK0VGbnRzbmU1YWZzUEhvRUp0bGhzN1dkbUxGZEp0SDRWS0pnUDBp?=
 =?utf-8?B?MmdZZi8vbWVpbHM5RVJjK1l2TjRFRDFBbzdsUGhxT3I1U2RQVjVTdkZVY3Uy?=
 =?utf-8?B?VXE2aVhhNk95YTNhbHB4eUVSU04rdkpoZEN4bzNiaWc3QjdQLzdhcXpwUmtp?=
 =?utf-8?B?VGdOeXFueGlBcURWVXBwb2JjVTc1aUhNeXVFTEZYcmdHa0VZWWZ1M25ETXFx?=
 =?utf-8?B?TVFTWUdoVEJXd2sxamhEdGoyaTNDSlZ2QldUUXY5WVVydWRydFlPMHZ1Tkw3?=
 =?utf-8?B?SUZoQzh5c1NkMGpqT01ncU5tOEV5ZWNKTlplTHJVNUQxRzlhanJTK2tPdEhL?=
 =?utf-8?B?NDM0QjZYTWVCTWtPNGdVWktzRDBXVDlCNjBDdkJUbE1Ec1AvTGZTaFZLYzRC?=
 =?utf-8?B?LzFaYmlXWUxGcnhBd1k3NmUwSzh6a2FvZ0l2bndCQUNFUFBlcnJabHJYcnpl?=
 =?utf-8?B?ekRQMU5DMFZKYjZzN285bHA5NHRUenpqcldYb3V2c0UwSElZakVvUm9FbWhk?=
 =?utf-8?B?ZGdvRjdQU2lvNkV6S09EK3E3dHlmazd6UzBCNHBoc0tCSmhibDRucVVzNlJL?=
 =?utf-8?B?Z2tVQzVLbk16V01GS0FXSG43Lzc2Q0NCdkhRbm9TbWdLZGk2QXIrZkFGTnVq?=
 =?utf-8?B?T0lHUUlCNHFQZlhHSW1jSFZ3ekNGNDVFaUluTm9FZjB0T2lXcWpqQU9xbS9h?=
 =?utf-8?B?UXF1NFh0c1FEczJNZWM4ZjRFK0VDdHF6cFhMT3pISHdlVXlOb3R0RXd6UFhZ?=
 =?utf-8?B?Ull6SU55a2J1M1JEcVdvNFE0a3doQU9IcGZRTTlLMFNqOTRNMG5JNmNVNjZY?=
 =?utf-8?B?Z3kzQStGUkZubVJrMWxtN2RRWEx4cTVBV2FkOUxTandWZUlDRkl3NWZmQW5S?=
 =?utf-8?B?YW93ZGY5b2JyV29GLzlCd3BnN0l2WlloY3U2SGhUeGMrRjN0WXZVSWhybURU?=
 =?utf-8?B?cUErRG9QQXcxcmhaYys3eTUzejA3T2FqblpOU3cyVnRMUEQrYjV4L0RabWtK?=
 =?utf-8?B?dEVLWGNraG9vUUx0aWVMTjF0VVRjVDZITzZBZUhqSjVMWmt1T09lWTZDQjNm?=
 =?utf-8?B?NGxCR21PMUVBWVNHM25NKzNkN2J4aXZDVldKVEEyYmsxSStkaUI1NnZqYXpG?=
 =?utf-8?B?S3VNZmxNU2NGbWc0bnovMXN3WWd3djhRSUtoTXV6bmtEdGdleTBIWks1bXE4?=
 =?utf-8?B?MCtLdW9FZkVlbnZxTnJ5TGJRNlkzejU2eDVYWlVFU29XL0xrMDFOSksyQ0hY?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777125fc-cf2d-44d1-96b8-08dd19cd7d71
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 10:20:52.1219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlV0gDq7AyS6PmgIuzAOJlAmppEzlJY1WBzd5MbNTwnwh8qpGORFSmNVb4TJvn2AKsQajuPmPgWz7dG2ubPqWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5395
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Dec 2024 10:21:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17402

On 11.12.24 11:11, Jan Kiszka wrote:
> On 11.12.24 10:56, Felix Moessbauer wrote:
>> When including isar-cip-core in another layer and not using the cip-core
>> distribution, the RO_ROOTFS_TYPE is undefined. This results in parsing
>> errors.
>>
>> We now provide a weak default in the verity and squashfs recipes to not
>> break the parsing in downstream layers. As we no longer need the
>> definition in the distro file, we remove it there.
>>
>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>> ---
>> Changes since v1:
>>
>> - remove RO_ROOTFS_TYPE from distro file
>>
>>  classes/swupdate.bbclass        | 1 +
>>  classes/verity.bbclass          | 1 +
>>  conf/distro/cip-core-common.inc | 2 --
>>  3 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>> index 5bf021a..3243f67 100644
>> --- a/classes/swupdate.bbclass
>> +++ b/classes/swupdate.bbclass
>> @@ -12,6 +12,7 @@
>>  
>>  inherit template
>>  
>> +RO_ROOTFS_TYPE ??= "squashfs"
>>  SWU_ROOTFS_TYPE ?= "${RO_ROOTFS_TYPE}"
>>  SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
>>  # compression type as defined by swupdate (zlib or zstd). Set to empty string to disable compression
>> diff --git a/classes/verity.bbclass b/classes/verity.bbclass
>> index 231d172..c3b89ec 100644
>> --- a/classes/verity.bbclass
>> +++ b/classes/verity.bbclass
>> @@ -12,6 +12,7 @@
>>  IMAGE_TYPEDEP:verity = "${VERITY_IMAGE_TYPE}"
>>  IMAGER_INSTALL:verity += "cryptsetup"
>>  
>> +RO_ROOTFS_TYPE ??= "squashfs"
>>  VERITY_IMAGE_TYPE ?= "${RO_ROOTFS_TYPE}"
>>  VERITY_INPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}"
>>  VERITY_OUTPUT_IMAGE ?= "${IMAGE_FULLNAME}.verity"
>> diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
>> index 3323dd0..d06eef0 100644
>> --- a/conf/distro/cip-core-common.inc
>> +++ b/conf/distro/cip-core-common.inc
>> @@ -15,8 +15,6 @@ WKS_FILE ?= "${MACHINE}.wks"
>>  
>>  CIP_IMAGE_OPTIONS ?= ""
>>  
>> -RO_ROOTFS_TYPE ?= "squashfs"
>> -
>>  IMAGER_BUILD_DEPS:append = " dosfstools-native"
>>  IMAGER_BUILD_DEPS:remove:buster = "dosfstools-native"
>>  
> 
> Thanks, applied.
> 
> Jan
> 

Dropped again, Felix will send a v3 to address one more place where we
need the default.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

