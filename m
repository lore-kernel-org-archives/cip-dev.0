Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190F5CAC5B0
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 10:56:01 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.71])
 by mx.groups.io with SMTP id smtpd.web10.13920.1758624955829498681
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Sep 2025 03:55:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GdjPzv9G;
 spf=pass (domain: siemens.com, ip: 52.101.72.71, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXObsFX4IR4E+rxkc3AIktNaQ7UT01/rRIWLN5/2pm31oDKozfWOuaRQPEYblG3WircRsiX9TrifRow1FiokKuk6waz++/fro9T726JnKCg8cLuuuK2veltZb3S069TQrZK8lnl4OomrrWlzYWRCXOErsOJ8U4C5C1ShoqlOef2JgWqD4kLEWXqdZ2K10f5rlmTr0iA+9vJSVut177BG2t5bS+EtFvjqAl4EvbsjeIJjPWbSSkTmuyz6BfJr/ICRJWxlMbk6jsO2xvMSu+7KznnOyMS0dNAjX9DXL799QH+DtqtKI8IHD0RMp9+4+plfKt+l3/NHCKDh/GjnVIn5Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ur25Q796wILfyWBytFoBWS1Vl3fSsVcSCRUgtPdWrs8=;
 b=zWQnr5l3y6VzRcoqccZ14oPRdcDSgeRbQMRPvde+3JHWCElcBUv4hvB6zbjlZJsLhfvwcQ0qhCkKVMht9zq4wi8ZXCUNHWHZIvBjGpcwXYI0rkddgA7WFpBjVWgwM5FL9nj/szdeyAbfa4hkPPb3lbPGA6P7Pns6Lx7WZuOPdFOOG1lVKFRziTKOK+xecU9McUPxM/6rCPQlUQrOrNpoQW8RCU9ILNG4o9IB1je/sWq/zH0UJ9l/gecJGBlInUKbsFgO0sCCjcs6uw93ejakKLbS278wKK7iXN8XMghd6YyEXuczTxNBKhlkYZjJAVWCKa0/Ti2Nr1eSRElKrBiJpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ur25Q796wILfyWBytFoBWS1Vl3fSsVcSCRUgtPdWrs8=;
 b=GdjPzv9G3I2Eh5atgvSPAX12kyNZIPqvzLNl9FoSEESOCpLJwaVQ2rHEnKycJc7QN5tthhtlRHCt06iAXHbQkobPiPhyjpxsJZi4WZNJBiL5t4fI8Uv9wCrl1+Ta050PiAavJTL/lupVFbyNobm9iVQb+9AnMvB1qH0y1jU3wB03/bSyqELtbHKRo6g+0gQ3KiAEIrn3zp2eNvCzIFUHL8JLwm9EyouoxUSvixnjsIKJYb5NbbHBrBUw7nKEqof2qc0NCq8d1MW5Lk+tMdqJaRgFpJMZ1/FzHyv3CNabK1W6T88vFOCzFlyFXhJ9hCLKbx8U+iJ4TriqVNaGxE0ehA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::6)
 by DU0PR10MB6511.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:405::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 10:55:51 +0000
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a]) by AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a%7]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 10:55:51 +0000
Message-ID: <e77657c6-e371-4ad6-a488-34c423f145d9@siemens.com>
Date: Tue, 23 Sep 2025 12:55:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v6 6/7] Factory-reset-helper file
 is incompatible with encrypt-partitions
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20250923100734.319688-1-Quirin.Gylstorff@siemens.com>
 <20250923100734.319688-7-Quirin.Gylstorff@siemens.com>
 <deccd90e-14fb-4129-84d4-c09cfd64c98d@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <deccd90e-14fb-4129-84d4-c09cfd64c98d@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::15) To AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:525::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB6023:EE_|DU0PR10MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a28760-b43c-40e8-8b20-08ddfa8fc2e3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y0NXaDVyeFhVVjkwbzVFRGNLemVtQldIVFBqTlRveGZmV3FPRzEzZjlBYlp6?=
 =?utf-8?B?cjRuTU1xcmxFWGNBeVcwcnpIM1ZhbHJRKy8wYWEvdzRTMkMwdWowTVRBSjMw?=
 =?utf-8?B?QWc2N2xiS3UwSTVlS0lIcnJNK2FhbGhIMXFKRkJGdzdzSmtoZDNsVmVKUEx3?=
 =?utf-8?B?ZFUvdFh1QjdGTTVheVc0L2IzZ2FVZExzdndSYlYyRFFPa0ROMXQ3anU1Ui9y?=
 =?utf-8?B?WTlkUGJKRmdSUjQ1VVBVbFJ1MWljK3VNN1BhbWNJcnhzK1FyY3AwcDUyclBN?=
 =?utf-8?B?WXJYTFJyVHVVc2Q3R0szbFRSWmVvS3JYYmRLQzNZckx4NVE0enpUUWlDY25T?=
 =?utf-8?B?MEdOYkhxb1VnbmxpQXV6Q3Q2L0I0QjlkRlRKaEJlRWErcVIwaHpSV2N5WFlU?=
 =?utf-8?B?cDFnYlZGOXRIQVNzclN2Q1JQcDJSbWs5TDlwRGxmVmpnYnhpeEsrR1FPVys1?=
 =?utf-8?B?UTFiQ1Uzd1h2Mng2UVFOTEs5MFA4VWFTUWllRHdUekFUQnhpbkJKaXJDaXhM?=
 =?utf-8?B?TEtvU3VBa3M0SVFOQmpndCsvVjFnSnpHMzdEcjlEZzltY0xpZ0RURnYzNDJX?=
 =?utf-8?B?ejJabml0cXFIWTY2cDJPeW15bUsrcDZ1aStLZUhTQXR1eUlZWU9yRjM2cFo2?=
 =?utf-8?B?dkZWR25jRUZUS0NMUkdZbUJQa3dPUXZuZWlsRWtxOVNTK3pqZFpYSDFCSVds?=
 =?utf-8?B?Zkl1SDdRWnlpT3l4aTJMT3hrN21WbmtzNm5xM3g4VUpqREZIUlk0U1FxS0Z5?=
 =?utf-8?B?amRzVnVUdC85a01oSlJoU0p6dnRaYVpKS2JLcW1rc0pIb1haZ21udEpmdUp4?=
 =?utf-8?B?Mk1VZXlwZ3NocWJKWEhDLzlTNUYrcnlsb0hFbmJQU2ZYeW5Sckc4VXBIVERt?=
 =?utf-8?B?dENSK0hsbGx5QzBWaTgyZ2xOWnFYcStFbEJuZHl0TDBYL3JZSXhPSGY4cHlv?=
 =?utf-8?B?cHN4a1F0L082N3ViOWk0NEZuV2RRWExjZVhPYXQydXFBOWtQUHBDNjI3YjdE?=
 =?utf-8?B?VnNBQW9mUzAvcEN6RzYybmgyQkRnaEMzKzhPclpmMDZVc3poRHlkQ0UyQ0pk?=
 =?utf-8?B?TUtaLzBGVVZqbEROc0Zjb0xFemF0UjhIM3RncUFHZUU4K21GYUJNU3R3dWY0?=
 =?utf-8?B?UngyNy9UMjErUFNFZ3U2NUI2Qk8zWnlkRW1XcDZ0Z2YzNGF1OEF6M1ZOYkM1?=
 =?utf-8?B?WTN5bnJJWmhBSWQ0RjZHYm0zY2IrSWZMT2hnNU14SGR5T2VkSldnR2tSM3ZL?=
 =?utf-8?B?a2lPUEIrZmQxeEZManc5aXZFNXRGY3h3d2p6TzhPN29OeVBOeWFRdm9MTUN6?=
 =?utf-8?B?TmYza0s4OVZ0dG9RT25qeW53WGVudS9LQ1dZUTNielpUREJpZmVMNTd0cUlx?=
 =?utf-8?B?L0RMQXdETE9LeHdsU0xLd2ZpQkxIYlZRMzZKRXBLOVlEMlR6S3c1TFQyajNs?=
 =?utf-8?B?VzFGMzRnb2crOTlURTNHY2JhVVZrUUU2S1owR1hzL3JtV3YwdVdNdWQrVGlK?=
 =?utf-8?B?MWJ0UTJQSWw2d0Y1aGNmdVVQRWg4Y3FOVnZEeS9VRUlGT3M0Tk1XOWhmUDd6?=
 =?utf-8?B?b01RdFhoZVN1WSszRi9TY3JMZTVKQ3A2eUh5RWl3bmhxUmp1dnh0QVpJZkZ0?=
 =?utf-8?B?bVF6M2Jvbm5TLzBRc1dYcnd1R0w0UFZxVit6ZmtlWGF2UVgrWDZmV1ZXSkpK?=
 =?utf-8?B?RVhVaTBOeElremNUNlc3emhqRmNYNVVNTVU0QlJRSmdBY1dVS2dzVXFEVmlN?=
 =?utf-8?B?aXBVQnd2UHFpcTVXNE9SVHIwbDhTVEF4UmcvRmhXQXIzdGZKdGhMVmhRNDNM?=
 =?utf-8?B?Vmx6Q0lZbjl2ZlptSlloLzV1L3NiQmFrMU5nZGJta2hTVGpQa3YzYUhJdnpJ?=
 =?utf-8?B?TEtFZmRBZUN2WnFIczRrZExzT1lmbjRsTjQ1RktHek5iRDg0K05zWFNOWUtx?=
 =?utf-8?Q?WQfgMlK+N1I=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z29kSGxNMFcwM29pT3FtcnN3OUp5b0hEUkZLR25NS05vNEk3UEMwQXpPcUNC?=
 =?utf-8?B?V2RzeVBPUjY2WEZOeE4vb1NNU0ZNd01RRy9qWW56STRWNHQ4R3BnRXRGSlY2?=
 =?utf-8?B?Y0dGL3hSS1pxTVg3c2dZYWJmUkU2cUJ6eXpLRnR4a3RtZ1N5SUlPK1FlSlJN?=
 =?utf-8?B?RDNlazNTM3JBRi8zUnJrWUIyR1FaU2hTakpQMlFiamxSa1pYbHJsaDllWWtt?=
 =?utf-8?B?QnpyM0RpWmVpKzJESnlYaUlNOXRia0lBK3dPQlVMY3BPbUlJbFk3Zy9LUWdN?=
 =?utf-8?B?RkFsMHdUS29JMGxtbjBzRmdLdmxjUWI1cUlWNXJOZUhwRDcyN1p6UkxnR25V?=
 =?utf-8?B?YmdQa3dxNnBCZjlVWHJPRUdScmJVcU1jZDIzeGVPSE9qaFdZRFJwNFdPL1dC?=
 =?utf-8?B?K085TWZlN3R1OWt4WWZaMWcxd08yeTZhYUtoRlpFMUFtUU9YcjJTaHZPVkV4?=
 =?utf-8?B?K3VKeEQ4ak94VlJCbUl4U2VKQ3hYTWV1MzljZmJQdXhzejBBaG8wTENGL2RE?=
 =?utf-8?B?SlowTGpkZjdPRkVKVFhYY0cwa2R5cHcvWmNzeGE4azQzNnlPNnVoWEowc253?=
 =?utf-8?B?dU5qazd1RHlSd09CZHdDYXh3UHVjL00ybXJscGx2Vm1hd2VjMnJNU2FSS1Ix?=
 =?utf-8?B?V25KYS80UUdBNWZVbm4wMnEzaUJrL3dIelNMbm8wVjE5ZDVEUVlQMmJWU3Va?=
 =?utf-8?B?Smx6aVgyalAwSlRDcFU0T1BDVHNxamEwaE1od1pOQWhDTkRYdk1BUGYyUFJ4?=
 =?utf-8?B?YkhkczVFcHJSTU9ML0E3VWkrS29JMHJkOTYwdUV5MjFPcWRRN0hqNE5YQlYy?=
 =?utf-8?B?UFIwNUM5ZEF3RW5YWjRXL2RiRXhQL09BclRmZGdmdlVYditvaWNaYlNWOGlO?=
 =?utf-8?B?VWVvR2JLRC9rRzlJRzdQaTBnUkgrNEtmeW9IYzBaSVRlL3pTeTh5aGllNXRR?=
 =?utf-8?B?d1pCdFI4b1FrdWxzZ3lsNkh4a0lxNmJvbThSQVJ4eDlqSjc1aC9GRldpNFBy?=
 =?utf-8?B?VHhoRTh5UXdIYkRQQzJEbWxmbU5WREltN0ZDZ3JFSGF4cG9GYlQvZS9CbXJh?=
 =?utf-8?B?dFBhZGtMMXdxKytEdEJXeTBTL3VQeC9uOEUvUzVjMXhrbkgyNWt6U2QyZmxK?=
 =?utf-8?B?eUN4cU9DMFNMY0Mrd0dHRGhtTHppMWlncVFFdjVtbzI0enk2ZXQwQUxVcGd6?=
 =?utf-8?B?RWg0Y0dJRG0zVVdlRy9yQWpkNFZRRXR4WlVLT0srUzYwNXZ1dFpDNit0bVNu?=
 =?utf-8?B?QjV5cHpEczBscVd5QnQvZkRBR0ZvMkhCU0paYVpnS0lINXYzMmVhTlZQWFFs?=
 =?utf-8?B?aUtkU3lhMUNlblEwa3ZLaHVCc0V2T2NlWjg1UzFQaEJQMjg1cGtDMXBqcDdk?=
 =?utf-8?B?bWRaYTBac0hmMVhPaFl1UEZOT01HSnFnSEZORkVHSGNscjk2ZlluUFJqaFZS?=
 =?utf-8?B?L1hGRmxzWXVtSW5nMG9lWUp5MkF2OGc3NXIxR0lPV1R6QkxXVlRTZ0NTbUxV?=
 =?utf-8?B?UlhnR3JzRnBUZmthSWhlU1kyYTVYQm1sVFJ4UmM2cE0xRXoyWTJTY01hWWZ2?=
 =?utf-8?B?czN4OTRnbCtmUnhVTjJmYXdYRitORDlLSjBrVTJFd25oQkFYaGNoRGxwbmNX?=
 =?utf-8?B?WHBmNy93RFBCcGV2RGlKaTRhUGIyRUgrK29qaHkyZjBRVHZhNy9xRFBzSnlw?=
 =?utf-8?B?eVlUM3hTakduM1FZSkhxYWo0bzJVbXN6VkVKcGU3ZXBLYmljd25GSU92dG5a?=
 =?utf-8?B?RWtUWTJYWHcwbkcrTVpZMVl1UFJZblpvY1FMK3Jkamd3L1lURnN0NXNFUTdp?=
 =?utf-8?B?NWMyUUdrRkk4QkUvYWF2alJSMXA5Nlh2b1dBMWo1WnV4SEdxQ3FuS2FwZm5Q?=
 =?utf-8?B?SlBSd1dnRytrcXljR1IzY2dEQnVjUktKUFh4cnZSRytVQkt3V0RnMDR1THBt?=
 =?utf-8?B?VVdLUzhTUkVGcEt3ekgrMVhIcFJBWGJEaXhSOFNiamZ2RTdYTXE5cWRqbFdS?=
 =?utf-8?B?bEVZcktYYmhEVVdxNUVtVFR1UmlDcFV6c1VqMVBWS09sSWNwR2tCc3VMdkIv?=
 =?utf-8?B?WFNObUJmbEJoNEtNUkdzUnFGZ1pCalRvOVVoNWZ5ODdpWUllTUFIOGJCRlg4?=
 =?utf-8?B?VThYWXk5eTMxNkI4U3B5clBSQTFCQWQ2elgrZ29pSFlDU1g1UnNaWUc1b0ZG?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a28760-b43c-40e8-8b20-08ddfa8fc2e3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 10:55:51.5750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUKcJH7XmXtA/iofaheRzWw9Mb5L8O+zjZuIPJwrm2bW7vNqS10L6MozGTEdTjJRlH21pRWZC+DV/TgU2mC9+8bSAnoILu/NIEYC+NM7Tss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6511
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Sep 2025 10:56:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20105



On 9/23/25 12:54, Jan Kiszka wrote:
> On 23.09.25 12:02, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> The partition which contains the reset-marker is encrypted and therefore
>> a factory reset cannot be detected. Print an error if this incompatible
>> combination is selected.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .../factory-reset-helper/factory-reset-helper-file_0.1.bb    | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb b/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
>> index 8d82663..14870ce 100644
>> --- a/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
>> +++ b/recipes-support/factory-reset-helper/factory-reset-helper-file_0.1.bb
>> @@ -17,3 +17,8 @@ FACTORY_RESET_MARKER_STORAGE_DEVICE ?= "/dev/disk/by-partlabel/var"
>>   FACTORY_RESET_TYPE = "file"
>>   
>>   DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, bsdextrautils"
>> +
>> +python __anonymous() {
>> +    if "encrypt-partitions" in d.getVar('OVERRIDES'):
>> +        bb.error("This recipe is incompatible with encrypt-partitions")
>> +}
> 
> Intentionally a separate patch? Or should we fold this into patch 1?
Intentionally as I want it visible.
Quirin
> 
> Jan
> 


