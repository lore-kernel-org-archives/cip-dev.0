Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405C8CE8D65
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 17:37:36 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4070.1763141849831913666
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 09:37:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pEdLqiee;
 spf=pass (domain: siemens.com, ip: 52.101.65.13, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apzLM2u2D7r5T4gWLc6TjHu+UUxV4znieKi5sZVnPGaZvA/G2UpfLeuNt+TAyHNZFzbAqyi5S6J8g3JLNx3uMGteL7xzS6fHMm4cfbA0XDofpDbuVDUt58zOSF0c3ky+aHSd3K1cGUvT8FMLo9+z0kzeIgbwzhTRwwXH94JZU+TptYeNzXhE/0DlcPhBtj2bkf19AR9TN5xyCrCmQMZu3mSqiDUv278sC8qmXVlzUY2jHjMThRtTQmlGH36U4HtP9ezzKj50lCkUA2DqTOaNuBVX7osI95xfrw1YXRUZEAM3mNY0nVa0fVYOdAnO67FBA6PcCTXHaQNJvKbHalxcow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVWoC6IIVSUVMh/hk3uRZr3O1MuPh3fbEdRdnbeve7w=;
 b=ftmI5hqb14KI9gkQuiN6PjgBdS/zmuir+746D65nEzO0YFjvAgVWPVM4OQsdYk/QlEdMiX7Go7dURawLrUghkFqqVJlFQ/ftjCvi7ZJozi/BUAbiKXrskO5ML1DfbP0NLplQhcUj0Wg722Sx+NHULjq0l9fhaKRxjAncZShIzICUd8Eyys15Lj0resVYvh4VHR2Hg3Gd74z5+f2rydRUN2G5SNmhHLPp1GxQE1vIU/29yV10fA2QSIdxvLgkejChChRfi/ySaEHKatZ7kZv9Lxvx8fOnfg0soByV7h7CNETCnfJ7GaYuSziT7NMpOEVL3Ly+mpZUqe+BzjolzueykA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVWoC6IIVSUVMh/hk3uRZr3O1MuPh3fbEdRdnbeve7w=;
 b=pEdLqiee+Yg7LTbNqOzXTr/5FE0d5/Ja2exKBN1d1axqtpNes4I46DstDRHhbgYB4MSrlGJU96KTtahyx60HvC51MV6O+3WVBkmNmAKasMQqmCq1KuMN7+0PSY9QCN8UnU5EeQIlszwqksl9qpRgQNsNtenjMAhrchCeb3HJhBF9M8aLa8pJe8q2LXSCxhmhNaLSN6DHhnK2H+TC/vD5x+ufCnWEFxDBIu8CG4XLSlN6faxalvhEe2b+7NhKK6JMgu5lnVYEDDfNXxpjWGHPDZPFmoM4zYlAusGhpnrRoGKGKhzBZQO1ZF29xnqxk4cUtjEsWxJhEDw5NQmNQGEwgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6680.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:400::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 17:37:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 17:37:27 +0000
Message-ID: <73341d62-89cf-4d96-97f7-256af2616065@siemens.com>
Date: Fri, 14 Nov 2025 18:37:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 0/4] Add support for TI AM62Px
 SK platform
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 vigneshr@ti.com
References: <20251114090509.2935933-1-s-adivi@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251114090509.2935933-1-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: fe07a4b4-3895-4c50-b201-08de23a47ad1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MlBLK1lWbE8rcHAzQ2w4bXNmTE90clNLZ2psdDQyUWdFZGdMN2dvRDM2N2RM?=
 =?utf-8?B?cDlDZldGcjdTejY4b1BhNms2ZUxkNzdib2h5NVJjUkpxOVNQY0N1TTFjZWk3?=
 =?utf-8?B?REpNOUxrcFozQWcybU5Nb0VRMHJub2w5ZU1hckpRR3ExRVF2WU50d3l0UVZ6?=
 =?utf-8?B?TU1TY0VBd3poSHBpTkhXZlZUcXh5YmxIaG1uYW50dzNFcVIvK3NOQmdQNDFP?=
 =?utf-8?B?MnV4K1RsNVYwVHlEZmNOMWV5MDhwR2ljZG1UbTZDNnZlS1V0MHpaU2dDOXRY?=
 =?utf-8?B?TXNmZ1NXdkd1SFlQVGpSTVVCWWxSR09ia2R6dGlPMVRRVlplZitzMks3QldF?=
 =?utf-8?B?d0VXN1FLODZ5b0U0amp6TUlzdjlHaGlNMTBsNVdlbHY3dHpRd1czT0RtZ2Zv?=
 =?utf-8?B?eU1GWHhkR0VETjQ0THUzT2M4blNFWjl6MzUxTm82Q0NtM0l1QUVUZzV4OE9U?=
 =?utf-8?B?VzNoRHZGcEo3dUloVU9tNHdrQjJzRzc1NHN3dHRNRnVycnc4S2IrbXZMcjd0?=
 =?utf-8?B?SnlmUVFBYlcwQzZqOEd3RzFGcDFnckpHWEN6anNlalc4MUZ3Z2taakRSelky?=
 =?utf-8?B?eEFndHFEdHdIK2ZjM0VRazlJU0FwZ0MvdWd4MkhtNkJkRlJROFFnQVhLSHpn?=
 =?utf-8?B?dmovclBEMk03SCtRcGVSK29jSzNzejlJSno0ZUZ5YWN1SWhCZzJWQXZGUjdi?=
 =?utf-8?B?YTF1bytUNWdLV1Jhbk1pL1NqQXFRK0xMVThKSU5PUVZ6TU5pUmFkTnVzd0NG?=
 =?utf-8?B?YzIwaGg5L1U3enUxV2dIblVxUlhMekJkR242NTFDdUhUZ0xMYWthaFE5anVj?=
 =?utf-8?B?bUgxY3JxVXBFUE1HL0I3clFQaHRrYm0wUlMwS1grRXB4b0I3cTB5eHIyU0hP?=
 =?utf-8?B?U3l6cXcwbDVEZC9WelFKcEVzNWlOTER1SmsvT0p3UmRKeWljYWFmZGhMd05X?=
 =?utf-8?B?UXd5cnFhMjVOM3JVNU5xUGZJcnhxREtzUUEwVThJcGVGcW55cjY5VnFhVUtX?=
 =?utf-8?B?aE0xcm43RzVCdkYydlNzSklCSmdhb0JrRmIwME5SKzN5cHVtMWNvN2FFcVU0?=
 =?utf-8?B?di8yK20va0ExR0d1NklTZHRlTmIyRTlzMFovU21Wb0NQWllSRDJ5bTlOaE00?=
 =?utf-8?B?VWdtajBISG41WEk2Zkk4bjBycmN2NU10R2EzVk53VVVUMHhMU2VqYWFSZE5I?=
 =?utf-8?B?RFFpTENHdFRJM0VLUHpJNm1XQytQTS9FMzFidFZUUFhaQVg5RUR5M0hWNDhW?=
 =?utf-8?B?NE4xdEZDbFFwakRQSmpGSjQxYlZoMzZZWGMyb1pyalo0d1llUVd0THUxUHFu?=
 =?utf-8?B?VThBMGFtcVNjclpDVURBUEFtK0tUckZHc29TWEhqR2N1L0VPR3NVNkpibHBY?=
 =?utf-8?B?M1ZIbittNWl5Y09DT0p4WUlPSWFjSVdFSGR2anZ6eExraHJldWkza3d4SjAx?=
 =?utf-8?B?SjFCSThzUDVmWjRyYXVLeS82WHJvdEJNeHJ6dWQ4cmNNTDRIVHFZU1E2dGtZ?=
 =?utf-8?B?K0RZdXV2RkZwUDQ0dy9hNFBSYi9CeGdDdS84eitPWXU4UVMrMmlTbkg2RlhO?=
 =?utf-8?B?TU9aVUZJTWtTQ2V0cnkvOWRyaElZMjM4Wm1CWVpDblhQSmQzcElYV1E4S3JO?=
 =?utf-8?B?Q2pzYVhZbUNiUXlxSitoZlV2eDJnNHRBMXhKY3MyRTc1MEdFa0hUcHNwd0pn?=
 =?utf-8?B?ZW5MR1JJWEJ4SnJPd21pa3UyT1E3ZXJ1NUxSNTlyckdveUJvKzk5dGlabDZi?=
 =?utf-8?B?R0lWWkt6SHVRanRFZ0FPUDIwTUNIUGV2TVF3MkxWTGNwWjBVS0xud0tFL3pJ?=
 =?utf-8?B?KzhGUlJVMU9id3NmQndvcFVlVm56ejB3dGV4Zkl6KzlYNVB0MnhVdi9sVWpi?=
 =?utf-8?B?WGZaS0FtQUpobzU1WVlqQitRNjlCTzhHTjU1YWhmejdlZWRxNmI3T3FObFAx?=
 =?utf-8?Q?NWUKEUIlnMNOzQ4xs4Wd/VkqyN8YATOa?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Ti9SWWpWQVFySTNkNVdLQmZiTi9ucjRWS20rTGE4VXI0VVZId2RZMStMZFM4?=
 =?utf-8?B?ZGZNbkJLQ1FJM21kNGQwK3JsVHMvMHJ5N0FqelhxTlhGa3ZzQ2dCOEpQUjdk?=
 =?utf-8?B?V2hDSGFWaGxmMzNvTUZjdDdyRHFucmc1bWFwKzZ3aW9zK29IMzZxdDFaQ09L?=
 =?utf-8?B?TzB4STZxdVdMRUtHamRQSWl5ZGQ1MDd4c3dKdFh3dUhoYTVuY3VFWnMrbksy?=
 =?utf-8?B?ZlpaUG9hbmp6R1hXMU5FRkJZMC9MM0Jpck5SdG11aHA4RTJwVStRWW95MVZC?=
 =?utf-8?B?aHBMZ2NDb3U0VUhPandGYjFlaGtuMERUTGcwdHhHN2lDdCtud1paanBydGVn?=
 =?utf-8?B?eklrQ2JVQ3JmcjYydytkWWJWbStJMGNxZGE3S2QrU2ZxRzkzbFJNQ3p0eTVF?=
 =?utf-8?B?U0srZG16TTJxTG43akd2SU4yUlpHNTB3bUVKT2hnTjJnZnN1akxqUGI4U3F6?=
 =?utf-8?B?OW8wbW1JTnFNTG93Uk5GWmpJRTZnMTRXaC96MGxEM3BTZEhuSDJmODNsV0xO?=
 =?utf-8?B?T2tRdjF1OGVZL0M0MGx3YXBqYjJIYWVINnVGbXUzdExzblp6M2tsU0RwT29o?=
 =?utf-8?B?YXFMMWliTUQrakFHMnNYZkQ4dFJnWGtzQWNwTGRPbHJxU1BaaU16YTBWNmUz?=
 =?utf-8?B?eEZLYUkrN1RGY013WER3WStoZGIwakY0S0cwdFhLb0hSVjRvRzhoOWVPU0Iy?=
 =?utf-8?B?emE0akhkS254OERxWmdEUzVhY25Ua0ZLU25uZjhIRVZhZ3ZlazhDQXVWL2Mr?=
 =?utf-8?B?cGJTa0hRL0J1dDNFRG5mQnhqQ2RTUnJOckxoSmQ4dTRiRUJXWGpYc2hiMEJa?=
 =?utf-8?B?L20vOEMxR09EemFrSU56dk9TcHFXaFRCbnJ6QURFWXpaaStLWkZjMmUyVDF3?=
 =?utf-8?B?T2lNdWVzTkFLa2paSzA0TEZmK3liUXdkWSsvcjIyRFBFRVQrdHZsbEpkM29H?=
 =?utf-8?B?Zk9wOGFwVldRczVSOTlaMGRLWHdNaGF6Sno2VXBvV0EzZ1BZVlZFWGZFdlUr?=
 =?utf-8?B?dnUrVHZscjFTaTVFb1NGbVo1R0dCRU9meUZhckhFUTcxaWkrQlBpd2M3UUph?=
 =?utf-8?B?RmgwajdxaGY0ZjBzTThNZjgzRU03OTJlNWlsemNQL1BWb2VVcTR1ck8wbkJo?=
 =?utf-8?B?cm1paVV5SEc1bGpkd0hXZ1lSSEJvU1REOERXSUdGMjhQZ1h5REdLU2djZTkw?=
 =?utf-8?B?NXo0ZWxrV2ttV0JkZk1lc1poVnBVK1BIMzUybDFTdXRDT2g1aVdOTGpxSW9S?=
 =?utf-8?B?dnJxSFY3VkVkRWF6bVlFbDVFaU10NWZ5cWxLY0Y0ajMxQ0xNWHBEdkdDYUVh?=
 =?utf-8?B?K3JqTnVkQXBvc0J4czRHc3BHMjN2b1IvcEhpZzZWUFFFdmk4QlZ2bmxta3Ur?=
 =?utf-8?B?ZG9odFE3b0pZdER3cDY5WUZEQWVTTlpKVkswaTB5N013SjJydStKcXhrak1J?=
 =?utf-8?B?VWNheTZKWG8zd25JQmIraFZOeGtGMHF3Q2gwVytGeE5OR3FOdFpWaWpPNVdO?=
 =?utf-8?B?MzJ5L0VlRGhGMUtCZlNSN29mRXhGK3dKcmVzZ2dKL2F2TXFqSlBNa1dSQnNX?=
 =?utf-8?B?NDFwK01tRWFtS3U2Y3oyZlZML2tidUZZS0hSamthMXA5cVMzRDErVm5GS1Jq?=
 =?utf-8?B?YUxOZGNJeFd3V2s4OEJtcU5IN2h0cXlIbGluclZ2QlR5QWc5cmZCS29rM2pC?=
 =?utf-8?B?NTNsbCtkWThNckh6dy9lblJLbnpraUJIcUR4SHRJUmd0aExKbVNTNFU2dE95?=
 =?utf-8?B?dzNreGU5Y21JVUE2U0gvRXNzaGNEMStLTXdQQm1tQTJJQWpiL3FFY2c5UkNT?=
 =?utf-8?B?dXNQaEhaM2pnc2RvNXlwczVpVUpDbnlFeWxPZi9veEtMcStOcDJnZGk0RHBY?=
 =?utf-8?B?aVdvTnZqSExRQ2VSckh5VFh5TTZNNnBVY3pxS0pJVENoeVFLZVY5RGw5TWtF?=
 =?utf-8?B?Y0ZvOE16U2ZnS0FxK1hJZTRhSTBlNEhIZ05zMnpLRjlmY2pOTnh5NHpIdExh?=
 =?utf-8?B?UzltWERWeEJRVklRNXFpak5rY0xIWDQxN0tmd3FkQ2dzRnpUNWRRWDk0ZG85?=
 =?utf-8?B?c1M2S1MwY29JM1B2N3RNVS8rTEJVMzVYS1ZzeFhKUTZ5VHRXT2F4WForVTYy?=
 =?utf-8?B?dWtJZzNrbGRkYVpFcVRVd1pqUXpyNDh2ZDVaaEc5Y1pMV0M4RGVQdzJKNzgv?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe07a4b4-3895-4c50-b201-08de23a47ad1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 17:37:27.6920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVoRWDM3M7owNTA0kCgVxRgb5sPXcyw7OPBX9TBdBfvBgUwJXdXT7QlzpsTQh/sb+3k8/7T2tlfzhVKgc1E2Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 17:37:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20564

On 14.11.25 10:05, Sai Sree Kartheek Adivi wrote:
> This patch series enables support for TI AM62Px SK Platform.
> 
> Changes from v4 to v5:
> - squash PATCH 4/5 and 5/5 which add support for secureboot and data
>   encryption as 4/5 is incomplete without 5/5.
> - do do_prepare_build:append instead of :prepend to copy custom rules
>   file in u-boot recipe.
> 
> Changes from v3 to v4:
> - remove redundant lines from ti-am62px-sk.conf
> - replace u-boot rules-ti.tmpl with already transformed rules-ti-am62px-sk
> - remove setup of static UEFI keys in u-boot rules as StMM support is always
>   available
> - merge HAS_DATA_ENCRYPTION & HAS_FULL_ENCRYPTION into single
>   HAS_DISK_ENCRYPTION option
> - fix shas for ti-linux-firmware binaries in u-boot recipe
> 
> Changes from v2 to v3:
> - switch to optee-ftpm
> - use github mirror for ti-linux-firmware instead of git.ti.com
> - rebase to next (8b7ce66a)
> - enable fTPM + StMM mode
> - Improve modeling of security features in Kconfig
> 
> Changes from v1 to v2:
> - Remove initramfs-ti-k3-kernel-modules-hook. All the necessary modules
>   are already built-in.
> - Update u-boot patch to enable KASLR with upstream version.
> - Add custom rules-ti.tmpl for both optee-os and u-boot.
> - Update u-boot recipe to add additional TEMPLATE_VARS used in
>   rules-ti.tmpl
> - Remove u-boot patch to add microsoft-ftpm node to devicetree.
> - The series no longer depends on kernel patch to add microsoft-ftpm
>   node.
> 
> Sai Sree Kartheek Adivi (4):
>   Add support for TI AM62Px SK platform
>   ti-am62px-sk: Enable SWUpdate support
>   Kconfig: Improve modeling of Security features availability
>   ti-am62px-sk: Add support for secureboot & data encryption
> 
>  Kconfig                                       | 36 +++++++++--
>  conf/machine/ti-am62px-sk.conf                | 28 +++++++++
>  kas/board/ti-am62px-sk.yml                    | 13 ++++
>  ...ptee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb | 28 +++++++++
>  .../optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb | 13 ++++
>  recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb  | 27 ++++++++
>  recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc | 33 ++++++++++
>  .../trusted-firmware-a-ti-k3_2.13.bb          | 22 +++++++
>  ...KASLR-OPTEE-RNG-support-for-K3-devic.patch | 38 +++++++++++
>  recipes-bsp/u-boot/files/rules-ti-am62px-sk   | 33 ++++++++++
>  recipes-bsp/u-boot/files/ti-extra.cfg         | 19 ++++++
>  .../u-boot/u-boot-ti-am62px-sk_2025.07.bb     | 63 +++++++++++++++++++
>  ...i-am62px-sk-efibootguard-secureboot.wks.in | 23 +++++++
>  wic/ti-am62px-sk-efibootguard.wks.in          | 23 +++++++
>  wic/ti-am62px-sk.wks                          | 15 +++++
>  15 files changed, 410 insertions(+), 4 deletions(-)
>  create mode 100644 conf/machine/ti-am62px-sk.conf
>  create mode 100644 kas/board/ti-am62px-sk.yml
>  create mode 100644 recipes-bsp/optee-ftpm/optee-ftpm-ti-k3_4.8+v1.62r1-48-ge9fc7b8.bb
>  create mode 100644 recipes-bsp/optee-os/optee-os-tadevkit-ti-k3_4.8.0.bb
>  create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
>  create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
>  create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
>  create mode 100644 recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
>  create mode 100755 recipes-bsp/u-boot/files/rules-ti-am62px-sk
>  create mode 100644 recipes-bsp/u-boot/files/ti-extra.cfg
>  create mode 100644 recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
>  create mode 100644 wic/ti-am62px-sk-efibootguard-secureboot.wks.in
>  create mode 100644 wic/ti-am62px-sk-efibootguard.wks.in
>  create mode 100644 wic/ti-am62px-sk.wks
> 

Thanks, all applied, just please have a look at my comments on patch 4.

Furthermore, we should link up the board with CI. Given that this is
would be the first real ARM board with fTPM & Co., I would suggest to
enable a build with SWUpdate + secure boot for it.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

