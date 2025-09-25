Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4361ACAC5A5
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 12:59:00 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.21])
 by mx.groups.io with SMTP id smtpd.web11.11023.1758805136644954304
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Sep 2025 05:58:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=St1oUjLr;
 spf=pass (domain: siemens.com, ip: 52.101.66.21, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJGjfPes8SCBSTrVP8H/4Baw23Ag+sH1cHa2AOJVQFV4Vq0k/iQJH0xA0DKByPlSOf1lW97dkoD8It9CimeOwrW41RUS7eppsCv+1t/SecqQHtgZnz9PQtiTRH1Dv2VlerTZ2z3gkiefkMUXlle7V0MxCL0KnC8nnXcnbbzEvRBS61swGtlURAgp+bJjpMcgg9piE2TsonCUgUrYAZ0CaTyEW3lZrT3HRQZ3k3p+yTwu/cyWq5bu3bxhAnFBKPdD42XDjSUeo4iizFh78mg/S0pUnxGqrhKFbqTnswhsBQEVk0827hGw672VuBxugljxcTrp3u8u6dOMVFtcwbYuQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BC2QmYVsQlym0n+YGDlhctI8EYsIl55CtrZjR6I0pr8=;
 b=L53sSX+GOkcl1BR0TaBgVdedODVjoQle6blGXdnS4slRLM7qLkVuoPD/EW01yh/8dptMh4+iCGIz8143oqoR428lU7o1OXyUszawq3GtBZgN8qxGPDpn8Q/t4RADXyODXcw+DInEvjaJbfy/4N42OokaSLRBm7bX7r3Gfxn4syCJt8pmXspiw7rgxM64oJtCWE8LRWP9JIkbICgAM3GY/nuNbibh2NmPQGk1GVroR5qe89BXmOpU4Xc+NhLsp7DS+zHtYqBCRiioz/wQikOI1fTM81hq+6T0UzQPUHMcSdnvo6pS4UgQj4HI1GsojqQD8C97V/D0gTtrgMiOu486gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BC2QmYVsQlym0n+YGDlhctI8EYsIl55CtrZjR6I0pr8=;
 b=St1oUjLrnsCAAoeazKvUN5yMV132DKfI7c4EmNPwj460EHp7EGtvIC6mGWUihGiK5Zuc8abroHnUOchUkZTY3id7xIg43yvZhjPpYju2D2QRQY4dRVoE0BrngDsCX0jGs15UUdvyyxwOIxXUq9FgcU3mFVHu8dDCVulHw/w0ShGjm1WpJVM7uTT/5eBGt5jw/WMCFM7B8ftDN6BsoB34/gg7Q+yTcJl3VDy0bUJujOu4fQ7kQoda36tBHHoMJ+Ek8hn+1FTs/JL893lpa1TdvE5m0NKBs5/KZzP0/FHEeATjt8lKCbWlmzbYbcmymHlc6ju7bovStCdrMtot/SXWww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7696.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 12:58:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 12:58:53 +0000
Message-ID: <3a2cead3-c3ba-4426-a4f0-0f29f609a38d@siemens.com>
Date: Thu, 25 Sep 2025 14:58:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com, dinesh.kumar@toshiba-tsip.com
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <3643259b-7e4d-4e38-9d53-b0e2227f9931@siemens.com>
 <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:610:77::29) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 41208354-3491-4a01-43e1-08ddfc334799
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?V0F1c2U2dmtkQXBqWlJqUXVJclRKdExweUlpZGZybG8rUWVha2FOcWkwYzdE?=
 =?utf-8?B?WHFxR2lpYTNCd05wczQrVnRMSDBKNVpWNVNQRGI3NTRRcVBlcy9URXk4SkVG?=
 =?utf-8?B?b3FOZXI0Si9YSjVDZWtjU0JtZGVpSnJtQzR6ZzBVN3lsWEJOT3QvNkkrTlNK?=
 =?utf-8?B?a2dRSzFKdHFpZmFuaGUxN2ZlOFhFeExHZmxwR1YzTzhnUjVpME1jV0Y0RlZn?=
 =?utf-8?B?TzN0b1NMNm9CeWJlcVVMOVl2TVdGTnY5SlNkRmRCQzZ2eGxyUjBNMHZuaGxl?=
 =?utf-8?B?UHI3aW1kemhZcUtDaG05SnF3K0NEUW5paWk4T2QzZGE2OW9QeG1hTXl3UXli?=
 =?utf-8?B?dnRiVmFmWmsyYkEzazl4SGdqZlUyaFlDNEpUeXdNajAwcmZjZ3dwdlFsWVhs?=
 =?utf-8?B?VTJaRkg5T2xZMVZzVGFhOTlMSmhxSGwvTUdab0N5SkF3TWxoOGZ6eDZoQzZE?=
 =?utf-8?B?ZThkaG5RMEM5TEpXcWQwTUV6VXY1WUgzeUtvODNmOW9uTDN4a3gzN0JUdmZN?=
 =?utf-8?B?aHhVQ3JGb0dGQ283MVY1Vm9NWndYeHNzbkRocEc4d0lodk52WG5uN2NoMVp5?=
 =?utf-8?B?UFpxTUNBaExaandBbUtwckRhaThPRkV0ZkhHcnJBZ0Vud28wZ2ZuRWw2Z2lC?=
 =?utf-8?B?RTBkMkRzTUJUWnNxdElCMlgrSFJKQzdWbWtSYUZHcUx1RHVjTmNPOUpma25L?=
 =?utf-8?B?UXVVY3NpbEJibS9Xd3BLKzd4bG4rN2pnS291Unc4WmhFV3ZiNG10YjNUTnd5?=
 =?utf-8?B?ZDVuZTRMTUt2ZVA4dXA3Y3NtT1Bnci9MN2N6VXVzbjlzNjFDL2lpYUQ2Wk5M?=
 =?utf-8?B?UWx5SFlGZXpOUUI1SzV6ZTg1NWxmOWF6QVFtUkZKUjNEek5QUFNCRGlEMVBV?=
 =?utf-8?B?emFSWmEyVkpNY3gwdHpjVDVpSUZYKzNOOTE4R3MyOEdWd3RUWGpiVTNEVEtx?=
 =?utf-8?B?bXVBakxxS2xpMWtVOHIvbTRWRzdJRG51clNZNnIvZXZEMUpEMTlJKzN5Qmtk?=
 =?utf-8?B?QmF4d0ZFblY1UkJoVFBrbmEvREJYOUpKYXpJbVdoSmdqQVA1RXcvSEVPeVNv?=
 =?utf-8?B?WW5Ia2dSaEdFbHJLTFJNZDRDRjFPUEJuMjkzaHlqRDI1Z2xYTEpOVkZPMGVS?=
 =?utf-8?B?RWFXbUU5U0YwZi8yd1ZyODh5MUhWMkZwNjRoMjhnSHVqcjZFODFrbENDemov?=
 =?utf-8?B?VTRUY1l4RFVuR3c2QkRlMDBTanp4SkdBaVVUS1RTbjFoN05OZzZJTE9BQjVk?=
 =?utf-8?B?a2YvWUhSN0U0eTZlL2dRZ1Q1SGxyY2FjNy80dXd3UjRXNkdwU0FHRGUyTHpl?=
 =?utf-8?B?VktUalhqTkM4a1JpRnp0TXRJN2lNdm1jeGI2aVowOWNHaVVOQmFzVmNnaGRs?=
 =?utf-8?B?WlNLTGVMS3FMTEtNZkFjMkhSNzBpM3NuMkJDQ1ZZUVN5M0hLU1o0RmIxSSty?=
 =?utf-8?B?WU5QZTF0M1FFMHJDcERwOUZzVFFNTW5yZlZSRythajVrOG50cURQQ2Z4bmVN?=
 =?utf-8?B?UnBQbkMxblRQUnNwWkFLQmR0THErdkRPaTZHdmloUFpzdEh5M0tUdHR5QTc1?=
 =?utf-8?B?N2o4YjVBeVpKM2laMUNwaDh2M3ZOZjVPcTdXU3l5M29XRE13SWhqT0pCcXRD?=
 =?utf-8?B?eE9GLzBIeEZwWitkVWhRODN2eEhNUjZYTDJHMFdvMzJVR1RnTllZNTUra3k1?=
 =?utf-8?B?UEtKMlBheTdsZ2RQTmt4cWg3eDVJcEhLTWg4SnRIZGYxR0JCUkRaTWYzZ3No?=
 =?utf-8?B?YU1Jck5JQXUxdHhxbDhNYVd5N0J6TTJmUWEyOURkUWRHQTU3L21EOUN2Ymh4?=
 =?utf-8?Q?yM2r4ZUGm+oO9MlePYF/Hb78DDsNbs7Ov7lEE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cEFQVWJPNE5TWVltQnlsODBiUUFyVCtGUkVETGxqQTJSM2lpeGZpdXBBdm54?=
 =?utf-8?B?eWRpdTVzQmkrV2t3OWZLekVKL1IwUHBkeFAxTmpxWUlIZjg5Zm5qV2laVmpD?=
 =?utf-8?B?RERteFdhR28vM0ZlZGVYVTJKNVBlYWRzV3lOL0VvY2lVR0NOeFlCeUVJYktq?=
 =?utf-8?B?ZWNoNGFTTXJ0R0RTRythd1Aydnk1bnVuM2F1MFZjYUtEb1FFV0MyRmVPbDEw?=
 =?utf-8?B?Slk4UzhLV2RTZXR0Ui9oZVQ4UGdlb2l3TzFIS2R5aFhuSGNPbEZiL04yWW03?=
 =?utf-8?B?VFN4YUlPWHhtM3JnRTBGcitjVzlBTnhmS1FXNXJ2Zm9JR2lDU3hIK1lqOUdG?=
 =?utf-8?B?TzNIZGsxVHJZbWlyakpyVVZXZlErQTBoKzdsTzAwU2hiTy95cU1lYnlUZFdI?=
 =?utf-8?B?L0tqLzdCMW9ZMHFNK0hwSFVPem5Lb1pRUUNnOHlnY1NHVCtPUkFtbGprRG1p?=
 =?utf-8?B?WVZvUkgwcGZhQnZmWi8rSStVSFBrN0FBS3prYkREOGpTajdGSDh3bndDa2hs?=
 =?utf-8?B?TzFiSzRML3dKaXRBWWJkWVAwMThhemJlazdxNy9Tbitpd21kb1JWNVpKcFAv?=
 =?utf-8?B?bmJwbDlYdUxWSlR6UHMvY3FOUllCODBkb2FwdUhQamJIVWJIeHEwYjFPS3FG?=
 =?utf-8?B?S3NFSWN5RDZKbG5TWVJjWW9saDZjQ3RYc0gwQ096RklEb3NGaUI0eXlDdWFv?=
 =?utf-8?B?T0RFdXNLZHhwNVUzaElnVXQrZzhoUG9DYWxKU2VORE1acDd5SktiQitKUDlu?=
 =?utf-8?B?aVJ3RTU2UUdOMXd5MnVWMm00c1F0QzhENG5rUmd6a3dYZDBnYUgzK3M0QzQ4?=
 =?utf-8?B?aWhlcnBieGUrRFFna0NaQUVHU0VaZEtFdkNnTi84bHFpbHduczJJeG1kcVY2?=
 =?utf-8?B?aFkybU5mdjJGWFRqZHV6WTdJQXhSd3Q5b0NCbDVrbHlTcGMxZEhzd2Rnb3I0?=
 =?utf-8?B?aURpTmxPWUgxekpLd015UER3Qjh2TytoM0NQcVk5MEh5NVhmN1JpaVVqNEND?=
 =?utf-8?B?MFc0enVGS05WUnZOek5scGF1T3ZkZytjNE5jZm51dUwveDVGa0ZqRm9kUDRh?=
 =?utf-8?B?NTdzUVdhcE4vK2tqYXhIUXdFUi9SeTFRZ1dib1ltUnhKYkc3YTlBV3AwUW5S?=
 =?utf-8?B?Q1FSdEdYK0d1YmsxcnFLays4dTZEejRWQURaTWE3cllFR01PbkM1L0U1RXFZ?=
 =?utf-8?B?OEZ0YVp3Mjk1eDRzOHFUWDR4eGMxTGxTYlBudWVBWG51RXovMXhGMktLQm5I?=
 =?utf-8?B?SERkU0lDTUl3M1NUMnJZNzBMUllFbTB3OE04TDlXWEdGVWpSM2g5TXJ4d3N0?=
 =?utf-8?B?WmJyQVFaQzhReG14WEQ2b1dVZC80VWFPRk5vUkZFam54cExVbjh2VWRLbnI4?=
 =?utf-8?B?MEpsdjhsZEFHNS9JLzNrOW9Db2lXTWd4eWp2aGdjVDhLdTZwbVJ3aVpwVUo2?=
 =?utf-8?B?K0YrQy9ScEUydk1uL1krYXJndEtIdHdvNXVvZjgzcElkUWt6VXlBeUVSbXBi?=
 =?utf-8?B?MmM3MWxOUWZrSzdjZmRuOWp6VFhpc3VKN1Jmcml3WUowM0ZwNG52VVRLQ2hl?=
 =?utf-8?B?RGhFb1dhbUVKZ0RlQ1l1Mm1sZkZ3NTlmbUthZUNZaEtUVWdDSWM2NktvTlFB?=
 =?utf-8?B?K043cFZ3K2hTdmk3MzVVNFNHL2J4Q3ZVa2NydVhON1lGdm84eDRVTmp0S01N?=
 =?utf-8?B?cThYTS8xaWg4VjQ4OWlOQk9XU01DZGRydS9CemFkTjJsS0tIL2pYV3Y4anlL?=
 =?utf-8?B?OHNHZ3Y4cXArTUxvQmU3ZytwU2V1bFJ3cTZLZ2pCUGRyRFBOWURjZkFjNmdJ?=
 =?utf-8?B?MFBhODQvbHBWL1ZFYmY1azBVdHdjZWNYaW5nb2l4NXFoN2t1QVJhZ1lyNWVQ?=
 =?utf-8?B?dGhmZVhOcDBEWlNYdHhZUGp5akNMYXZTdTdETHNoV3lzZzhNR1VRZ0pHWEF2?=
 =?utf-8?B?R3VoNGRac1BVaUZtTU5tdDJ3SndaNTFib3dMRUg0bHd1UFdQdURnUkRyUFFY?=
 =?utf-8?B?ZytGaHd6bjBCa0xYdE5rcmZHeGdvSFV3YWU2YWRxRjQ5d2hYZ0NpMkcrMGd5?=
 =?utf-8?B?NDFBQjlJV3lhczVGNEtOQkdMK1hSdXBZd3pkTkRsZ3YzKzYySlY0eFZUOEFm?=
 =?utf-8?B?SmJLR2FDVkxYdVp6c1czeGZmeUpTRDJJeGIweUVzOXlyUkF3UlpGSjJmaU9Q?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41208354-3491-4a01-43e1-08ddfc334799
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 12:58:53.3224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHWsmhUHUFHTqr9fGxx8nw+9op70sqi0AcYYOFSq7ph+C+5RAQzn6zArKPdQvmf96JIUnAUSDJFqYjrs0VPGWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7696
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Sep 2025 12:59:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20138

On 25.09.25 13:34, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan, 
> 
>> I'm already running a test with
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/e4cf71701983e3cb12f19efe9c217f500b9b0868
> 
> Ah, ok. Thanks. Hope it solves the current timeout issue.
> 
>> In the current image /home partition is deployed as separate partition, so during the boot process the partitions /home and /var are   >encrypted which will usually take more time (even in QEMU) to complete so, we can consider to remove deploying /home partition >separately for CI images and it saves some time. Data encryption can still be verified with /var partition
> 
> IMO, we should also consider this, basically revert the patch " https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/2ff73188f261196da4e4cb60b8eacef7d6565b3e" + targets with "separate_home_partition: enable". 
> I believe it saves lot of time in CI considering multiple test targets.  
> 

Is the underlying reason for that resolved now?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

