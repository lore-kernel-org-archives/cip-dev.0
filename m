Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3071AC71136
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 07:15:12 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.42])
 by mx.groups.io with SMTP id smtpd.web11.24802.1750058105762266542
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jun 2025 00:15:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=piEck50h;
 spf=pass (domain: siemens.com, ip: 52.101.84.42, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGLJcLt3kaXME/4mCgjGTKUkUr72SJwQxyt4+HOWkUMIyQFyeUYTL7nbZLmqTALymejK1AyNptcoB8zm3xo+y1K7hFhmxjaVrVepQJH2pEaimVxlWbrovVGK5wVWWnkO84uYmcX2uTt+B5g5mwDoKy9ezfKA5b7EbTN/UnwZkHPcTe4AttwC64S3eUSvCaOJKRY3VKXlk8ztTiU+ydkuh/o9UkQ3LlP4efnWUwOlt94Dpp9+ilPIZQeTFi5Rhm/BlqGodMFchQAUYrldHP76zkUR5lQK7fI0SrxugZElx4fRBXIGcX4LpCgrNAdaatzX5h4+RzS3Zx77M9s7zHv0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v58GBuVDPdNxvKVrL8diZesOnij+PZjq756wH7+VjAw=;
 b=ipsPAUdw6H7JP0ACqOnysH/CuVREr6L17hsE0snYNri5NKOebZ0zJ6b2u7pH+eyWtJoHQ5D+7LBK5RGTPnjHPsnT4ljQZIib3uw8kE7+eqpgPy1uBZOv+dcxVy7yzuzNLZiPvqPPZ2bn2DvZg8SzH1MXfPVZfy7UnB3H/Z5/x+Gorrq2Ylsk3fomMFOt7fI+hg5nv9bJnA2+EjppRUX820B6A1SFYo7Et9/XZ7hKfWaqenmtXhsHa75ssUb7iuidhe67rwGK42C45b3wbll5klEyab264DZDSc32nz6d5mPB/qDmqG96gpo5xvxnhjOzU8RDoPf2b/aBOvtAXPUbQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v58GBuVDPdNxvKVrL8diZesOnij+PZjq756wH7+VjAw=;
 b=piEck50hNe1Bau3vpumDpfyT9weXeJuoH+8W7WU7rQwp2x/2Xj+H5yijqD6iULka7bgZTW56zH/pkcnUgc8ZbDAvcEHTtiz8gDFqAGV2iYGVkDSsVLTJZB02KXfx53Vb0IUiI8T975JrYDfXQwGhw3clg/KqrLPCSxxz3nXZLR7ggdgGcMFgbFgj28lyuq57Ez/nNHr9N4xLEf5Byg47ZCLrGjriktWMLfILKumOetxVSluRIgVMuexvEwzlodI8XRLCChd3lYEDN3N6r4pP/2dK5soIDcXmdiSWWInuYzm+7VEND1sALJTZmsTlDgC+J8UBbUgleAn4uVB8r4Pw8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GV2PR10MB6357.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.25; Mon, 16 Jun
 2025 07:15:02 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 07:15:02 +0000
Message-ID: <bde05ce9-d639-4905-b7ff-1f53f96b4241@siemens.com>
Date: Mon, 16 Jun 2025 09:14:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] fix: Shutdown the TPM after disk
 are decrypted
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20250613135155.1440058-1-Quirin.Gylstorff@siemens.com>
 <bbb5595b-029f-489d-85d1-42b51df3bb70@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <bbb5595b-029f-489d-85d1-42b51df3bb70@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::7) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GV2PR10MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: e56041bb-6841-49c8-1d68-08ddaca582cb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?V3ZkWVY4SitpaU9SN2xYUndwT2ZUNk8vVmYxdVdBT0RpVDV0V1F5d2wvU1du?=
 =?utf-8?B?MHBmOXFpUWZDcENQR080NENnaStLOHlTUzB4RXpnbmF0N3VLT3ZQaUQyR3Ax?=
 =?utf-8?B?Z09Xb2I5TU1UdS9aSkRrUXNGYzB2VVJjK1BjUkFqTXJ2Qmpxb3ZxTUN5SGZl?=
 =?utf-8?B?NFdDVnQ1YXd3N21XRUdHTjkycXNVQkpzcjFzd3NHODE1QzRRaU81WnU5SXdS?=
 =?utf-8?B?bUREVmY4MERidUZxSFk3U1c0U2tPMWhHdnNRblIrYmI1NG5GZkNPL2EyaUl3?=
 =?utf-8?B?TFNoZ0JQUHZmZXBhVmRmSWJsRTZzVmptdXNodmJSU3htaFhwQm92T0w2MjFW?=
 =?utf-8?B?SGlmb2tCZk5NbHNHZDFFc2NUSGwvZ2dudlN2K3RTTmhMS2hkdWJPRS8xZnBa?=
 =?utf-8?B?YWtDbkl2YkhHTUJBbmxsbXBGc0hKQ1FhSlhpMTlnNXBlbHNtTWlYY0pyMGpP?=
 =?utf-8?B?bHE5Qk9aUFdKcEtxYzdwc0craDVIQWErbisyRFdKcWtvK1JqR0pxSG90RE42?=
 =?utf-8?B?VWJnbkxrQzNPWTNuS0c0OGxydEFiMVN0YlBMOUlLY09JcWwrcGxCZTFscFVh?=
 =?utf-8?B?cWZ0NnJHd2R0bDMvc2NkVytxQnRxeDl1enAvS3h1VXpNa29Fdi9pdmZxSzcx?=
 =?utf-8?B?WGN0K1NHQ2FkaC9NNTFCRmRtQkRDTmp3YlY5aU9veGFneWtYUlFBNm9hNUV0?=
 =?utf-8?B?dUVOanZCMk9rL3lpS0RURlpQeEgxSEEybWw1aTZKeVB5UDd4b1VDbDdiUVdi?=
 =?utf-8?B?cWo2NkJVYzZzckUzT1E4VHhFN2IrdFVraFU0TS9qMEpwK0ZmcUZkbG9Jb204?=
 =?utf-8?B?bEF0ZEVoQmsxTmt2NWRQZTcvZ1FHZWNWWU5uUlBUdkE0d093a214RzhKYytW?=
 =?utf-8?B?OGw1QUd4MHI2b0s3U25WK1lBc296ZFMwcmVvSjdOQVZERGozQktqbWJ2YlZQ?=
 =?utf-8?B?VXo2bThWelBRT1RFbi9rcDhUQTk0SnYyYmt2T21vbjFKdjdITmViRTNBMXdM?=
 =?utf-8?B?T1RZVGFnN251NVdhN1NKc2hlT2ZNVmpKaVY1NExqc2NtQVZvZUJKdytCN2Np?=
 =?utf-8?B?QktNYnVkVlBwZlNhekJXZHJoWWJLbzlUZW04WGxHYy81T3cxeWVBZWNKN2J0?=
 =?utf-8?B?VjVSaTdVcE4wTU9XOGl4dDBEQWxCSUN0VTZXbFdCZFhiREgwc29NdU9UN2Nx?=
 =?utf-8?B?ZnNDUWdWUlc5NUx2TDltTU1BN1RZVW9JanlLdVk1SHNjQjJTeWFibkVYU1lF?=
 =?utf-8?B?Tmd5Rk5zdEpDSjQ0d0RaOU4xNlJqNVV3Nis2cE5zVTNxUmRidTF1TmUxc3k4?=
 =?utf-8?B?NnpyT1Z2TW50STFZRXk3cVBqOGJoa2J5ai94eld1NTl1OE9jODlMVEhPYk5a?=
 =?utf-8?B?NG1SSExYNFlBRDZNNUtpZFAzYWhQQ3ZHaGovVXd5SmpLT0M1emx0cXZVRzRG?=
 =?utf-8?B?a3FIdXl2dVVkYWc1VE5xRFNHS3dGbFZWRzdjeXV1RjNianRZR3F5ZHI4MkFP?=
 =?utf-8?B?bktEdTY2eExReWs5aHZ2NzFUQXVlUG51S3J4WkFpWkJJQVpWZk1NbU5FbWQw?=
 =?utf-8?B?UUNTZEVhZmI3bEVoeGlidkJCYk1kRTgvMlNUSzBWcGtWbkRmeFlqRG5QbUNP?=
 =?utf-8?B?ZXpFOVk3UGE0VWJ5YkFJUFpBSCtRSTY5dVNmc3A2LzBINm5ZQ1FXdGVZYUFY?=
 =?utf-8?B?VVhyQ2NpOWUzaGw0bVl4OHBxbjlQMVVHWlJRU3gwdERkWnVIaDJMek1JOTdZ?=
 =?utf-8?B?QkhhTVllRTZXNG9LZTJmVDhXVFRnck0vclBiWVcwVDFXVnBFdmszeFhqU1R4?=
 =?utf-8?B?RnFKOVhqcFljRXpzSkJ5VUNsMTJha1BVblAxbWtVWjdyUGxoTnZwK24xc0Js?=
 =?utf-8?B?WU9NcnYrM25wSHJuNVkyM0hzallpZmhUQXUyckJWZnhneDJEWkhrQjF2L0hB?=
 =?utf-8?Q?Y0zwffw1jNE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QTh5ZGY0eVZSS203RmJlWW85d0NiNEY3RmZQRDZ4RDMxWEtHVmVTUi9BTGNX?=
 =?utf-8?B?YWRPSTBURUNwcHV4K1ZoSjkzdXhoK093UFdoODBPMEpaOG52eitqMkZwblRv?=
 =?utf-8?B?dVRDeTlaNTBKbUs5WjVLaU5JT0ZBSEg0akpJQ3hzM3orQ3ZXMy9XSlhPVjV2?=
 =?utf-8?B?YmRWcFJFVFJScmhMUytlN1UyUzZVLzVIRHpzQzYzR3pHN1JiMFpWNG9Da3FU?=
 =?utf-8?B?WENCU1FSdTBCVDNRSWV3Mk5sUDVuakZ0RndUV0NaVURqeHhyNFZvd01vdmtq?=
 =?utf-8?B?a3htZDFLRnhDSVlGWE8rcnA1MFdzWnFzOVhxd3o3Tkh5UG9mVE5YbmZ0Zk1O?=
 =?utf-8?B?amtIVGd2TUtNT1BHSzcxOHk3UnU4a1I5b0hENEFleFpEMU9XL3pVSFBWN1lW?=
 =?utf-8?B?WjQ5Y3NhUCtGTzM2ajBjY0Nra0d5OWg0SyticjRwdm5VVjJ3Y2J3eHd4amdk?=
 =?utf-8?B?eG1SajljcE43RHR4bmxWYXBWZmZXSFRxL1lFOTJabUorQjdQOEJXb3M2ZG0w?=
 =?utf-8?B?N2ZTQWxPWHJqY01RVVRoY1piaVRtbEQvb3dlM0xRd2ZyNEZML3BlRWxDOHpa?=
 =?utf-8?B?QmdTcWRqdzRJTDNQOFpxdVlxazdRVWdOdDJDcHN4TzdRb0plajRxRjFmZmdI?=
 =?utf-8?B?R3Y3T2VsR0wyRUZHUTFmcllhcnBYUE9QOU96aXY5NkVMVE5uY0ltN04xd1VP?=
 =?utf-8?B?ZlNHWlEvTlFnbkJmNFV2aElOYTB5VjdaaitsZXdkR25ySTU2eHhXby92enQ4?=
 =?utf-8?B?NHZkWEJ4eWNUNXRSNnNXSzNpY2VYSEk1Wms4ZUozb2s4TDByUk5qK1puK0JE?=
 =?utf-8?B?eGVhNzlvNDlhanpWNlE3ZHlVbnNlWkZUL2FNOXhIQ0Q0VXh2MjdKTE80bWhw?=
 =?utf-8?B?VmthM1AvVlZ1TnIxMFZtZ0NlUjFYSWRrKzZzcHFGK2IvbHRGVTluQnpHdHhj?=
 =?utf-8?B?c3pQdENQREdvVm9TTWdlUlRRSExaUjM1bmd3anBySnc4cDkvU0ErN29QL2hX?=
 =?utf-8?B?eUhWVW82b25HWEM2MTRYdjdYZEMyTFBWWUpFRzF4OE9QekpST0x5MURobWh0?=
 =?utf-8?B?Y1h4NGp4aHJlUFh2d1NXTmlKOEVYSUhNTlppa3p3cC9sU2N4cEVBcTByQW9F?=
 =?utf-8?B?QWlwYTJ2aU1zRWdzN2RQOCthbHg1MXdzWlgvWVJrQlN4Mnd3bG9nQ1JzTkhD?=
 =?utf-8?B?b3NFc0phWWhrNDBTMjIxZzNjcEdTWStrd2VYcVBkQ2FvSE9WU0tBQ3JEc1VW?=
 =?utf-8?B?cHRERW45OHdMcEZJUUY4THphWmRVWUFva1VFTHhuSEM0R09wWVJianV6NCtZ?=
 =?utf-8?B?MVdwdW0rdS9zMytXUzYyME45M2VBZng5NVZSVnZOSVAzRXNmVUJLc2Uvczdm?=
 =?utf-8?B?cGhhMlpESVhQUWZocTZTWHpDdGs5TVdtSUdLYXUybThsZXZvYnZmT3NzUkdH?=
 =?utf-8?B?Zm5qU2FOSFpMZFpwN2pPMWxaNVY2OU9SZXp1N05FRCs3VUdFajM1MlpNR1I1?=
 =?utf-8?B?d3Q3UDdrRWZ1SXdNdFl1UzJPWTVwdmZzbmpsdk9DV2s5Z2ZHVmhHdTdaL2FM?=
 =?utf-8?B?NnQ2R3h1dzFua0hIbjRUMXdueTQ0NitoSE5hdWtSemd5WmlKdzBzUHBwV00y?=
 =?utf-8?B?RDRFMXBuYVFqdFlhZVc0dytzMDg0Y3M1VlZ0d09oV3FOSUdqMzJhbnVlU0ZB?=
 =?utf-8?B?bnBGaEZIdDRiTWUxMTRNR3E2Z2hXcFhMSFdEVVNyYUZVSEhFVm0wQ3ZLTFRI?=
 =?utf-8?B?bnlEdytkbno5Z3BPV2R3b0dYMzNXRVVBZ0VUSnpIOUJKckduRldOQWZqU1NI?=
 =?utf-8?B?aDUrOUFqNVkyQXE0MHByaWJWNGNzN0hzaTdHb202VHZHV3hxYXZ1Und4VmNM?=
 =?utf-8?B?ZUtqVnhwaEFKN28xNTNHR1pTNHozT0p5b3hXaEpsWUhBWlN4QkVRTnB0L24z?=
 =?utf-8?B?aWsvTDdYc3NnN3ZuU0RKTlg0eXFrOC9hRUx2L2g3NWZIL05rbjFmNFRBSWNm?=
 =?utf-8?B?L0ZyQ3RSd1h4WmwweHNValN3Ti9uUkNKeCtDWDZrOHcwc213MkFOZ2hDcjZM?=
 =?utf-8?B?anN4b3o3bEI0V0p2LzdnUnhnVlJqRWpnRXZNRUk5V2twZlhNRGFBdFhFUmUv?=
 =?utf-8?B?WWZNQWhvakFzc0tJSm9BVTNsL0Z6dXR6dFhjbkFQQTVRRnhDZmF2dTk2Sm1x?=
 =?utf-8?B?SkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56041bb-6841-49c8-1d68-08ddaca582cb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 07:15:02.3120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cF52B45IuULttzUJd9YhfhdW2lIg8lp84M1ARjTOgG/Yt7EYi2btgvV/VqOCQN1ZCU7WSNGVF9xIHw+Q+tk85uLqauN7AbZ7Vsg9HJRBIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6357
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 07:15:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19094



On 6/13/25 18:30, Jan Kiszka wrote:
> On 13.06.25 15:51, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> If an power failure occurs and the TPM was open/in-use the DA lockout
>> counter will be increased. If enough shutdowns occur the device will go
>> into lock down mode.
>>
>> This error occurs on real hardware and in QEMU.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   recipes-initramfs/initramfs-crypt-hook/files/local-top-complete | 2 ++
>>   .../initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb            | 2 +-
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> index ae0dcef..113f44c 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> @@ -293,6 +293,8 @@ for partition_set in $partition_sets; do
>>   	finalize_tpm2_encryption "$part_device"
>>   done
>>   
>> +# shutdown the TPM to avoid DA lockout due to powerfailure
>> +tpm2 shutdown
> 
> tpm2_shutdown - or is there also a wrapper installed that translate that
> call?

Ups, tpm2 is an wrapper for the different commands I will change it i a v2.
> 
>>   if [ -n "$watchdog_pid" ]; then
>>   	kill "$watchdog_pid"
>>   fi
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
>> index 80a4755..41a3c83 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
>> @@ -42,7 +42,7 @@ HOOK_ADD_MODULES = " \
>>   HOOK_COPY_EXECS = " \
>>       openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
>>       e2fsck resize2fs cryptsetup \
>> -    tpm2_pcrread tpm2_testparms tpm2_flushcontext \
>> +    tpm2_pcrread tpm2_testparms tpm2_flushcontext  tpm2_shutdown \
>>       /usr/lib/*/libgcc_s.so.1"
>>   
>>   HOOK_COPY_EXECS:append:clevis = " \
> 
> So this should also resolve the issues we saw with testing on the MCOM
> in our CIP lab, right?
Yes it should fix that issue.

Quirin
> 
> Jan
> 


