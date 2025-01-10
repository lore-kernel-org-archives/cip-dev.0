Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33CBE77188
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 16:44:00 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.49])
 by mx.groups.io with SMTP id smtpd.web11.23642.1736527433076548291
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Jan 2025 08:43:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UerwumIY;
 spf=pass (domain: siemens.com, ip: 40.107.20.49, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHquAk9A9EProVX+YaB71Q1AcrmsscoC+6jjQj8BFY5tcal17CV8T8U/t0ZCphH8ISeHsddebzlWWEIJEwB5VYqgxJD3Wk4Js2w78BvCgWzB5PFbh/j8OjBmhQAfiMTgwzuaJtUB67uOrfEGtCWPs4XOqnevLdWDU3tfvABzcqagjXXwf2A21RtwZNsfyjJYt9mnODBEMPMU9WcoUeJzRoG9z8lwUnRHsoYJpYmakNk3ZoHYwCjpIvsAzOgu/xDzc7F715IIJpSugsPadTOxANRRQi+Sk5jB7ZDXRyek0hdXP8HBp2iUcgYQ+Nzte3jy3aDHi+DWjp5MGJJZUXpd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgaFBt2PQVfCG8FS/ij7JGbbYJunbjul/dgZd5yfvfA=;
 b=sPd/BzF7c72HEMneTdavglTd1t4Psg0CdK1nh3BLnxmzQbBCjpYzoEGa4eGBk0ITqe9dpf48qYIBbDThHLFH5ZZUotquiut6rCHDiq3OthhGqcabk7e6LLcIKEAKAgMMi+vAPI9OEJCnfMgwCNxMdEjfQNBrI7ILWaV/sCJoYYiF/XYubD/6+7Jyz61/ycPoteJ6U+0zB0qr97V4bkvz4Es5Kqh6lmz49cvcMEQo6I/01EQAIGF/9NtRyMBXdz8wMphIel9uit0UPyjWsXSGbSxUpIx3RtswqYsjWzrzAe5qadXXvN3GSY96wMFZKYEVv7yD+qtOXsCAyktOXm81WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgaFBt2PQVfCG8FS/ij7JGbbYJunbjul/dgZd5yfvfA=;
 b=UerwumIY9t7ZbKXzqqCGJAIcV1wkn9zw7B0YNkwC3a6WLCFXRrBmHskBm7wgvfDWImtCY5s4DsWp+H8KAiKcJVTMv02onM+j4UXLC2hb6gVfOmKvpJT8RCA7SNXECCEEjkSFDdgWgJWJNDCUb9/7d3faVesNb/od4TLHdzFL4fkFf6T4ouevKjj/K88Mc9jTuDsHT50r/lBTJVUD8YleUznczOeI9m+i/YPZDdJd18t6gmGxAj3kmXs0rkR91GBmSoCKqBw/3gPdR1dE8QJ6fbyBfBaAWZc3cLe1VbR9w2XqVXKK11CPjhJzTkYBWW4AcNM96qtUd9AKwx4WFlLejA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DBAPR10MB4012.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.6; Fri, 10 Jan
 2025 16:43:49 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%6]) with mapi id 15.20.8356.003; Fri, 10 Jan 2025
 16:43:49 +0000
Message-ID: <9bbfc7b7-2fec-424d-a516-8f36a48409d7@siemens.com>
Date: Fri, 10 Jan 2025 17:43:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] initramfs-crypt-hook: clarify
 resize error
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20250110160051.91196-1-Quirin.Gylstorff@siemens.com>
 <bc14959c-9f12-4e68-ab21-7b7f3a07f726@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <bc14959c-9f12-4e68-ab21-7b7f3a07f726@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::14) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DBAPR10MB4012:EE_
X-MS-Office365-Filtering-Correlation-Id: 1613b7f6-78a4-4cdf-a0ed-08dd3195f5a3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UVdQYXV1YklwU2hKa3FBMFRVWTd3V3prbU9pZ2NUT3pmWWozWVV1T2NMc3hT?=
 =?utf-8?B?OUpIZEE3aTVBV3ZvbmFmenEyVWpZZzVkMHh3Mm9SZS8yYkVJVmpMWXcza2Rv?=
 =?utf-8?B?SnRLS1N0ZzBWdG8xSkxjQ3hNaTBUK0ZLbEZnNEtnQWVtNmJ1Qi9EQWgvdGpw?=
 =?utf-8?B?VmdtRHJvSzdtdkdCalhPdzE0cUlzazNWZ1dCU3Z2Y2h4d0tsT2pxQzRkY1Bx?=
 =?utf-8?B?dno4V3lhOHZKeDUzZmVmWHB5R1dMbGhVSGd1Yy96QmJOb2puVzFqSFRVZVIx?=
 =?utf-8?B?bmZpSVVQNWtla2ZVNnU2Q2Q4M0FxVlpYM2tPbHYyc2FKVkJ3M1lwcFJ4NmVo?=
 =?utf-8?B?RlNqdnU0OGlRSlBwY3JLTFJ4SkRlNlRJWmNFYjgyWXhSbmRaSkZNSmk5U1Bo?=
 =?utf-8?B?UTExM0taVjQ1aGVZbHNRQ3RNRFp6d0JUSldRajdvcy9xdGpCaVVYQ2x3eG9v?=
 =?utf-8?B?cVlEdjFKOGI3T1dOL1pMdmZVS3E0cUM5VGNXQ3VvVEg5VTVrdnB5M2MrUEJV?=
 =?utf-8?B?S0doK2tWakl5WEg0UkFPQkhXRHNmSjdYclpuWGNZYmpkTjZXYXpEV09EWjBL?=
 =?utf-8?B?bGdmUE9hcno1WlUzdEtJNHZzY3hFeWo1ZitsRS9Pb1REVDVRTmtlQVg1VnNR?=
 =?utf-8?B?L3BEdDg3VEcvYVFqcGc1bkdFY2dlVmhrSE5hU0pYNGRVN050Y2c4YzY4b2ZU?=
 =?utf-8?B?ZG5nSTU5WVJHQ25VNjU2VWpadkZLUnRyMUlWVHZ5VG0vbm5PQnZDUWdLU1pK?=
 =?utf-8?B?VUx4bitpUndrT1Y2SWRITllLc1U0bHgxbUpuamhlWlgrQkFFbXlIMlVMc0xB?=
 =?utf-8?B?NWNkZUlyYmJBdzVJTmM3c2tTSjJQUitwS2tSYnQrdnphY0xwaENkTk1vR1FQ?=
 =?utf-8?B?Nk42Y2hSZWVlTUxObGo4T2tqc0RGSkxLdXBWcFJGQW14NVovSjRLOGwrS3pu?=
 =?utf-8?B?NGd1cW85K0hzZFZlaldvRnZXRXhFak9KN2RWc29YTG5WWFNMbjdnVEdaTkxi?=
 =?utf-8?B?NWJtQUpDSTRSY2EwMTNNRnV6T3c2Ukdma0d6MnBCd3REcjZTM1JMYi9YNTFN?=
 =?utf-8?B?NnFwbHVzdk41NFpyQlV0TGMrYkFXVy81RmZWcVJXZ1VJcVhWbko0ZlVoWHhm?=
 =?utf-8?B?aUVRaWNQQzZXcDFJVGticVY4U0trd1g3RDFUakNGTlZrTmx3d1YwMFYrZVp6?=
 =?utf-8?B?dUVPNzVDOUpmRDc4SDF5aUNLVGIwcE5lbnZ6UHF5WG9YQmVjaUhBT3owVktk?=
 =?utf-8?B?RXdYS0RoZFM5dDllUXUzZXNMdENoa1lYTmpadGlzSFhDbEs3T0Y1M0lDNkpr?=
 =?utf-8?B?NkxSRC9uM2QvOXlPeithTDVWUnFUTnBqT2tXQXMxdVFvVDcrenBGRXhKT1ZG?=
 =?utf-8?B?SVVyS1ZaT0daaHF0Mk04NEhtdmFDWWpmbFBWTmQ0S2cxWjQvWlpqcXlzK0d4?=
 =?utf-8?B?MUFwbHBaeGtwS1NzdnpqUi81eVFLa3lMVnJJWUZQSDdxZElLQnNmNnY1VDBR?=
 =?utf-8?B?cW1SZC80WjVWTVFHbDhpRytYTjNqQTRYWHM3ZFBsdWYxVll0TnlJbG02bEMx?=
 =?utf-8?B?QkRQUDdKVkRZL0QrWmQvcmRwZDl2eFk3ZW90dE1tV2JkajF5ZElkdTdHbDBz?=
 =?utf-8?B?WjErVDcySkdzSmhSY0RJVVFHSnVtbE93a3hnQ01DUnZXOVNJM1I1cUVrNnh0?=
 =?utf-8?B?ZDdxNzl2eWt6ZFFnOWJxOHJUeDBBdnNBVSt2M2VRQXBwa0tBVUwwbGE5SVh4?=
 =?utf-8?B?VmZtU0tsWVNMR2xrbWRRYWI0cVRQVFFjT3dqWUFjNks2bk1EWHNqaXpOeFRz?=
 =?utf-8?B?d1A4aVBNUWlaWEJwc0dsNFozL3ByZ3JtS2dYVEZjRVRLYjRCTUFWWUZBL0ZP?=
 =?utf-8?Q?3UNvFVOc4NxHf?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NytqZEJDREIzUjZIWGVyeE03ZkR4QTRtNGpMV1I0SGtCSjEzVkhRUW8raUhT?=
 =?utf-8?B?bVByRDNGM0ozaTVneE11V1lBQ3VPeDhqTlFJbEdnSmVBVTdvVXNKYTIwRjlU?=
 =?utf-8?B?MXBTNGJFdlh3NUZGc1lSQ2ZBc3NGWDIyZGJQSVo2UlZpR0xha3o0b3VKN0FF?=
 =?utf-8?B?U0pZMXhDN2dFaC9jUDRQTDVCV08rY3NxN05RK1VsRU1hd2htT2Zzd1hleERM?=
 =?utf-8?B?RXVQQmVTUEtRWHF4MkhxZGtRcmpQOXlneTNyWlNsTkkra0tRcmMyQkw5aUhK?=
 =?utf-8?B?MlUzeGl6K2ZMNnY4RnQvQ2NseW1wMzJ1U25TQnlnYzdvOEhMNjRLNTVFb3hq?=
 =?utf-8?B?UDVJMXcyNnB0Qjh1TUVjV252dU1FUHlsM0x5OXZuVmhKbzVwNmNwKzBGd25P?=
 =?utf-8?B?Z0tRbnhJRXR5VHBSaThTSkRjRXUwSEhYMWh1M0puOCtiblBlUkpZTDJRbW1q?=
 =?utf-8?B?UE42Q29ubFV6ZFcxd29sK2YrZFQxRE9SMjlxQXNvdlVDMkFuZmFJa21ZRGgx?=
 =?utf-8?B?dXM4YlpLVlQvWTBvS2lzMXk2STBFTVd5QjYrQ0tyWmpKdlpVckxhbTJyME91?=
 =?utf-8?B?SUpkcWFFYzdHODdTM2lWb2xqL0VLOEVUUU1JVFZiSmtDdzkrVXNvUC9vQTFv?=
 =?utf-8?B?Y2ZwNFMxNDlyTUV0dW4zU01Ta1NYZ2RyOE01QnpNKzRxREJKNWZhdEI1Qnlk?=
 =?utf-8?B?MGZLazVmVlBTc0E2djhMT2ZtYUpZMExDa2NIbTZ2TFNpTGd5aFNBWEtFbk9B?=
 =?utf-8?B?bSt1eEMzWXM5VnIzWUFpWERQR2V6Rm1pb2lKU0VGMExOY2ZOVzdGbFROZTdZ?=
 =?utf-8?B?YlgvNzVtbFR1OHlCMXZuWjcyWXF1N0c1bkhQTzZTMjBTL0hDYnRIOUdkbzNM?=
 =?utf-8?B?eEIvQVA3OTA3SCtCa1Q3SjB5UnluOExRNjlpNFRXWk03VjVLQmVNMEE1eHBK?=
 =?utf-8?B?ckJ6cXNiOGlLcGRCR1BmUDZDendvT2lVbEM1Q2JZci9sbnFuczdLZm93ZUww?=
 =?utf-8?B?VGZyRkQwMXEySFFwRjUrbllXK1ZDOVQ1RjZ1QlNrTTZYRm1BQXE5bHBBYlZt?=
 =?utf-8?B?TU8zTzdZZkZWZkYraFdIVEVCTFE1R1ppNWQ3TFMxUVFCVDBvc3U4ZGVlS0tW?=
 =?utf-8?B?MjJWb252YWhrWGU4b0VEQjVkbFB0emdiZmJuV1QrVVVjdUpOWFNXWmo5TWU5?=
 =?utf-8?B?RDZnKzdDbGpDMnZHZzROc2M1ZjRaWDBxZVBWWGREL21mbEFaS3F2Zk10cEgx?=
 =?utf-8?B?QkZBOFpSUHRseFJKTnZFRGZyVEtyeUgrQy9aOVhuWkpWdUVZYUI2OUxhYXBt?=
 =?utf-8?B?VTNHWFYvOVRkc09DeVlsRnIvUzJpZEhrclp0NUZKd21KdUJ0Y3ZrWG44dVN5?=
 =?utf-8?B?ekh2dDlXK0crZEJiOHFDUThoRmhyTk51YW5RT0hkVmRUQUxrR282Zkc5bFg3?=
 =?utf-8?B?ajg0NStPU3Q4bm1rMGh6L0ZndmMyYk1iQ2JoRjhKT3NNQVdxWU5nY1dVRDVh?=
 =?utf-8?B?U0NXdjVkUnhwNEI3SzNmZFc0OUFZY003S1Z6cm4rYjEyRDA5a2VNVnNyb0ZE?=
 =?utf-8?B?K0MrUjJuaDZZT0ZwTWV6NXpueWtRTlU0alh2a0ZodzF6enVLNzRKbmdXSHkw?=
 =?utf-8?B?cm9vQXRwSGlscnprM0VnYXA2QVptMU5QNjltLzVRWEZiSEdCblhMeVBzdFFO?=
 =?utf-8?B?K1BGKzgvU08xMnZLdWlzajQyU0pFbGZpcDZHOTh4TnZVWUlCTnNzZnVPM2d3?=
 =?utf-8?B?NTdTTm80L1hxMTBKVDdvSGx4WS9Ea1dqcnRxc2xVTkhwNEZqVkQ2Nk1IV1BU?=
 =?utf-8?B?UUNQM2ljYzMrU1lsdnk5c2NtdnI5NmJvZVRsYUhlb05oNTM3OC9zYUp1L256?=
 =?utf-8?B?QS9RTVRIYVV0VDFRQnhCZ2pmUmtuMjlMY3VBMTlybjJkbHR0cUdwK0RFcHFx?=
 =?utf-8?B?Z1VQR2dvNmZsK2ZUZXFDOVlaL01sTjBqSTlNMy9mbFd1UlJpdzUrelNmREQ2?=
 =?utf-8?B?cUl1Yk1iSWl3ZGYwV2tQWnFtRktQUDBsckVmd0ZHL3N1MmZWaTAyK1AyQ2th?=
 =?utf-8?B?bmYzYlpoV0lxbEVVVDZJUUVCNCtkM3JEc0U4clZXSG1IRzczckZWc1ZNMEdw?=
 =?utf-8?B?QU95dHE2QU1LOHpSYzhJazVQWEwreVhnM0s2K2tHbnkyeVNSWTdDQ3o4TFpK?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1613b7f6-78a4-4cdf-a0ed-08dd3195f5a3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 16:43:49.8408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUest/AUwTx+KQVrFqam75kJ5D8y9G1Ni3UslIxpgaDgV4uOFzFCHqqAOqM7MheF759ZQQ9AYOvATTWI43BMNRnTBDmfIAlEgY6pYZxFUhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4012
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jan 2025 16:44:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17529



On 1/10/25 17:12, Jan Kiszka wrote:
> On 10.01.25 17:00, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Add context to the resizing error as it is was unclear why the
>> encryption can not continue.
>>
>> Also fix typo.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>> Changes v2:
>>   - do not skip the check in case of optional encryption
>>   - add indication what failed to panic message
>>   - fix typo
>>
>>   .../initramfs-crypt-hook/files/local-top-complete             | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> index 95d0a5d..b8a2f18 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> @@ -82,14 +82,14 @@ reencrypt_existing_partition() {
>>   EOF
>>   		e2fsck -p -f "$1"
>>   		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
>> -			panic "reencryption of filesystem $1 cannot continue!"
>> +			panic "encryption of partition $1 cannot continue - resizing of the partition failed!"
> 
> reencrypt, encrypt - naming is a bit inconsistent, I suppose.
> Technically, we are reencrypting, aren't we? Also, the partition flag is
> called "reencrypt" as well.
> 

I will sent a v3 to use re-encrypt again.
Quirin

> Jan
> 
>>   		fi
>>   		;;
>>   	squashfs|swap|erofs|"")
>>   		[ "$debug" = "y" ] && echo "skip disk resize as it is not supported or unnecessary for fstype: '$partition_fstype'"
>>   		;;
>>   	*)
>> -		panic "cannot resize parition. unsupport fstype: $partition_fstype"
>> +		panic "cannot resize partition. unsupport fstype: $partition_fstype"
>>   		;;
>>   	esac
>>   	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
> 
> 


