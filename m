Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ADCE7719F
	for <webhook@archiver.kernel.org>; Mon, 13 Jan 2025 12:09:56 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.28])
 by mx.groups.io with SMTP id smtpd.web11.15607.1736770188360550600
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jan 2025 04:09:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dQsVgHF+;
 spf=pass (domain: siemens.com, ip: 40.107.162.28, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDEj/jnF9cDPe6wFiRn6XLAWKzbWxzk4nWNEw5vK/aVteHw0V1VzK7pZgUscLioRFaBi/eYJmaA2c0DieoqwVUeJ0tyjojgAhw17T1BY3iC9oS1srPpSB1tnc8hSxT0hsJgGrgz9d0K+p+xBzLAUE18f0BhRULqFNqeytpFiR2aKuEHxDglonMRD4iCW9gwP3NttiWU2JYwNnsEiTfmTjqDGhsYBeknhOE1w0caRH0MY/Pe9/lVrKhaq4MxrN85VrkU9kgL8OKVnWsCpfEtCvqgeB+5YG/2cGFC8OrNYHF5T4jmG2laoKD6PqZhoTDOPtzwHydGsA5j9pOFAaYyJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IY2g42S/F4l/IR4SPG/BJaUSLdKohnV27p87V3OaZoM=;
 b=vaeCkjAsmVWICLIqFjOEdDY0sXhgYcY6j44cPFCtWqhm/tScZ1g5oJ5csw4COxQb9YIPYyez67cYUp15DOQIoYuJ+iVJWJ6mldjTlksMnZlAvQZxv0nOE0zldBZ4ZjadO/xciD2E6njPScMlrexfGXVD1AzzaLBJJu0cC1SrWtcDD/wWqmLGC3NWrG7kZpOdSXNDOwsycQWC6B7TMcH6PKVLX1vEoP7DdBeu4t93nXr3vwqE+mBVIW9uGbegcsyxa148549e/RGQ5Wz9+iq/Yh0XfAi7KjBTTUTztZ+tUvgffWHlWwwWYHDuGK95p9JmItWjdpx5RTjhrnnF7U4NsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IY2g42S/F4l/IR4SPG/BJaUSLdKohnV27p87V3OaZoM=;
 b=dQsVgHF+AWof6oqiA/amG0t8j1As1L+312yFf6UCpDqmF0jgTMvlxYjhRMq3BAht1f+ZUNoZRHyRQOD0+IOMNmVBzLvu/SrpM+X0iOyuLQ+G/ovrAaIo6g7gEiJopqJ5iyMnxr4PI0Idgj7JXcvZiimYHgaIku9jeYRTcnDNYoFXK0BdGM6lUMGYU1xGxscIN3jvCDtTocQxKa1tG2Lx6AxAUXDuxXhvLWKN0pDEimgAfFD8WHZ3fUqP6R4FnFPwmw85FO3qpuxbKu5cmQBbofx+I46YCgi6+PP+5nmotfq2dikspBVOxRgNTI0s1ZjC46nkVlhIVCGeFgY/5XWY8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3582.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.11; Mon, 13 Jan
 2025 12:09:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8356.009; Mon, 13 Jan 2025
 12:09:44 +0000
Message-ID: <7aa9976e-f325-4b24-b739-c92dbd0b6765@siemens.com>
Date: Mon, 13 Jan 2025 13:09:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] initramfs-overlay: fix missing
 scriptpreq
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250110165103.77249-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250110165103.77249-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0142.eurprd04.prod.outlook.com
 (2603:10a6:208:55::47) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3582:EE_
X-MS-Office365-Filtering-Correlation-Id: 284283bf-8cee-47dd-6ae9-08dd33cb2aac
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZmlYWHVISXJ5Z0l5VVNIdCtKYnRVU0t2RUd0cFprQ3RlNXcyZ0NzdWd5Z3RH?=
 =?utf-8?B?U0ZPalZHTDNjUXgvVFBkeXFXYWEvUWJDRCtlMUpaWThuMHp3WWErVE1uWnVl?=
 =?utf-8?B?K0xDUDYrcHpKblJDV0NOYUJpbVI0V1E0Ylk4SnRNTWpOb0U4VjR5NnVoU1FS?=
 =?utf-8?B?Sk9seUhJSGgzcWlxYnkwUmZIbXI3SXNqSmZJc0RkNE45QVJlay9BVkYzREdN?=
 =?utf-8?B?SHBBaXdhSFJxaTlYNkFnZmE2UTl4MEVjdEZNRFFUV0NIQ3FMWmVEbjNDYlBr?=
 =?utf-8?B?MGt4amwzbVE0bG80Z2pkc0hjakJCVmVBbVIzZjhXREtKZ3VKSmF3eFY5S0dY?=
 =?utf-8?B?YitSSmY4cGs0d3RYa1pPQy85TXQzbExXYlZtVDJNMGdWZnd0MkhoVlRuR0Yv?=
 =?utf-8?B?akNFOUpFaGhNdkhNdUo0bXBOSU1Idis1TUtGM2tTZ3dJaXk0OW4yTzMzK0kr?=
 =?utf-8?B?a1JPMW0zVnBNSXJYdGF5S3JYd2ZTcmxUaDNOMklEOTFuZkZUSXJWRmtzNHBM?=
 =?utf-8?B?RFlpSWpPa3E1Y0ZxQ1pqeDhpcWVWQlg5bTduN0x4SW5kVDFmMnV4c3BBZWlr?=
 =?utf-8?B?SVRtcWNrdVJZWjRPdGxBRkxzM3Rscm5MWXIvU2VwbGIyM0sxdHhldjNIdGhE?=
 =?utf-8?B?SnhZSHNLYXpINitHVDQxTnpMcmhxcHJROVZNcGVpdVFMU2lrMUFUSjF3NVV6?=
 =?utf-8?B?cWZlN2k5R1pDbW1ZMWN6Q2RlbUZjZWI4djBOT3NmUk4zUWdUU1VFT3ZhVHJY?=
 =?utf-8?B?RDROQi9VNi9OS0RYMWtzeUVTUlhiTFJ4dTVZVEUwUG5EUytFcEozRmJVTFF0?=
 =?utf-8?B?bU1Ea2VSWjF6MHpFdnlXN2d3SlF3VFJLd0xSRGl0ZUJsSFR2cVdwU0cvVHBq?=
 =?utf-8?B?dW0rWjFvTVAybzZ1SXl2QzVZTHNUVEU0Ukc0Ri9FTkdBSUVhcmU3VG1CVE0y?=
 =?utf-8?B?aXJpcFhsUTdWdlBoWlhKcWlGV1RXd1kyTThLTm5iUHVZT3pvdk1VdmdWamlE?=
 =?utf-8?B?UEhFaEg5dTVVUmRzWktOMW4zVS9CUGlqaHNTSlpWemhHQkpnNFF0eFYwTTJD?=
 =?utf-8?B?aUxtYTVURk51d2d4bXA2aFhKM1NFdDhGNCtndkE3UXhieWM5a3RhUkRDVFBT?=
 =?utf-8?B?Rm93cTYwOXBpdTV3b1JiRVBuYlNJU2s4UDh5NGpkQ2RUcW41ZkNQZGNBVlNC?=
 =?utf-8?B?ZHhudkw3WkRLZUpkSWFvK3h6b3VMMUlyMGMxaHNEaXlZRzF4VE5Db1VCSkda?=
 =?utf-8?B?U2ZHbXBsSjdyQ2hqTEJpTzVsM2VRWGdPUUZlcytnMkY3U1BjUE5OVU1sdHdW?=
 =?utf-8?B?RW4wZkRGckgybWI4TGErVEFFdStxSWNuREI3TFlZdWZ4SnBsRC81NThJV2pB?=
 =?utf-8?B?MmpXYUwyU2hBbjhPZHBIZzROSUU3WnI0RUJQSDdnajdEdXFCL1ovQ0pZV29W?=
 =?utf-8?B?TmI3Y2h0QmRDOFloTDFvQ1hOQmlQQ1NVZ2x6MTB6OURoNnJHaUNUN2lsMmNZ?=
 =?utf-8?B?b0M3ME9aT0JLZFJQN1BjbGRScGhjY21UWG1oR1BSUWp1TE1FR1F2a0psQ0Zo?=
 =?utf-8?B?b0xPYUNzRzFDOFhTMUFwaU5UVjhqRTVIS3NmTmh5aExyM2g0WURDbFFJaS91?=
 =?utf-8?B?eFRGL1BCY3lQaGtoV1NBOHRwZ2gwTUpwbW92NE0zSGExb2NqRjRoSE5xVHFy?=
 =?utf-8?B?azdZRHFQQmNTTHlRSS9CSlRLQm14THZhRnpCVWJEaEhjdGM4bmY3OGJwU3U5?=
 =?utf-8?B?Z2IvTHRRWjBZWWhId3BDQTEwRFYyTlJEUG0zS2tZcHFCZUNUZEJlVG03QUht?=
 =?utf-8?B?dTljQkRIbzF6cVlycVBRWGtYREVsRXJ6ZDNDWm9NNlRlempIU3dRd2V5Y1Bt?=
 =?utf-8?Q?mfsu759yb2SfL?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y0xKRTlPZjdWUnd3K2Zoa1BtWmh5a3VST1hWRVVmU04rS2dOOTV2bkw2Qi9M?=
 =?utf-8?B?NDdEcGorSmtSUitpNjV0K1Boc3dSalVublRHL1VJT0NKWlRObE1uM0x5SE43?=
 =?utf-8?B?UGZ0UWY5SmtpTHZBU2lodUxUMDRoTWNnMnY4ajlEUUdyM0JDVnMxc3Q3OFBs?=
 =?utf-8?B?NHdONGIyZnF0ZWZLSGdrckZGek1HMDFNWHRRL3Rwb1BWSXZnaXdyREt4WVBt?=
 =?utf-8?B?NERlUEFFVjVhcFZjRE5vcXB1QjRDMnRGZDlmTlJRWW12NWlKUDlqMkxEN0Ni?=
 =?utf-8?B?UlhRZ3M5TUd6dXhpbXVuM3AwbHpOZ3QzaWtKZDFQaWE0YXhVY2w1cnJUbkVi?=
 =?utf-8?B?a3RXY1Q2Y2Q0Y0ZVSmZxTWpVaGUwM2FpZFFlandHYm8wZGVRbFR5cnQxSkpN?=
 =?utf-8?B?VFBETEF3V0pXYVdYblFCNFFPdVpZenJxWWhWcHR3Q0NVWVV1RW4vK1lwNjNU?=
 =?utf-8?B?R3h1MmpsT2VuYUV1dmNtc3VkdkxrRzd2UEpCTFVLVExacXVveW14SWtxU1pO?=
 =?utf-8?B?WUVXdnUvY0M1NmxTVnhzOG9NY05VTkR1WEZmT2p2dXRWYWQrSlVkcXJKaFhZ?=
 =?utf-8?B?V1Ayeno4d2pESHpMa2tHVTFUYnpSVG5pY1Zhd1J0NUoyU3lmS3dUMHBVWDF1?=
 =?utf-8?B?UnE3SnJKV285TFhDNUlCTlJ0YStabmF1RWM5MGJHUERXTVJLUkF0ZlZqaDB0?=
 =?utf-8?B?TGJhdFBnRVkyYjJuSkZvN0pLc1JHdXBSTjlQS3pOK1ZZcnRPZWpIc3ZGL2RC?=
 =?utf-8?B?VEJrSzUrU1d1YWNQcWF6ejMxR0lUeWF2TjJudGtQUXlkVDJsRGdXNlZMcmZ3?=
 =?utf-8?B?cGlpNnBHWHpLOWZTMElhTm5wb0l0RHIyYWcxM3V0cW1EK1RZVHhReDFkTzFO?=
 =?utf-8?B?Nk9KRVdseXBJMktEZFVua1NRcnF3TVBqc1E2ZS9MTTdmZG5lZFVDa3VzWDZq?=
 =?utf-8?B?UTh3bUxQY3RTT0dOMnM2UkxZUXlvTGhHZTV2VzNYaGVweTh2M0djLzMrQXNR?=
 =?utf-8?B?Tk0vWU91WUIvU0JCQ3czYzBlVHF3YUNQNkNXMWgvdFdkVm5SaENKSmdJazd2?=
 =?utf-8?B?cXBKV0NVYkdZYUFBdzhUSmZKa0kydlBkVjJKanI0MWZnZUtHa3crN1ZuVUxp?=
 =?utf-8?B?c3o3ZUxqbGc2Tnd3Q3JZaFM2SStocC9oQlU1aGhaSjkyVHRQNCtuNjZreGYx?=
 =?utf-8?B?NHozTTVpZ3FvWVJBV05WVjRQTmtSc0w1RE9FSnE4b3p3SVA5QnhTWktKRkxU?=
 =?utf-8?B?bWtWdkxDaFJmSmJTY0krM1hweUtWa3FJRzJhZGdkY2x2QXZVNUlpWjdlQ3Zy?=
 =?utf-8?B?YUdTV2I5emU1VERVQUlTQUFmemdjempKN2swOG1CUVVPaTduVVk3emI0S2JR?=
 =?utf-8?B?cGErcG5KcjFPL0N5ZktiSStlc2JCMGdVRFpMZnZxd2EvYUpObUpDT0lFZGp5?=
 =?utf-8?B?UG4xbjZwU0w5SlZ6K1FQbzY1aDNJdlZKc2NlazZEUEpqbFVFMFNzaXR2Ym5T?=
 =?utf-8?B?ZmRzZmJaSTE0aTlBV3hvWncwK3cwcnJhTzRiRVRxTlhNK21VdEhTWG16UmRm?=
 =?utf-8?B?TitHNnowR0pYcWVlRWZDS0NHVFRxbjgwNUF0Zy96Sllma0pXNWF0WmhCbGxP?=
 =?utf-8?B?anY1dFlLME1vbVdWR3VQRkI3TVB4UmJtL3FtaXBySGJQTjVmNitCWUZFU2FY?=
 =?utf-8?B?WXJSSG1uQk1HSFU1VWc3VkkvNzRWUnBaVXMvbjhaSm43TnFHak1WVVY5T3F3?=
 =?utf-8?B?TUJvWmdLbld3N3lHd0M5ZVRsMnVnNi84RHFxeEhWYVA1T2hZb3ZkcDB3Z2h0?=
 =?utf-8?B?MU1uV1NDZURUVHpuQ2k5cS8wSVYyTjhTY00wNytUZm1MQTk3YXVjSmNCNVNI?=
 =?utf-8?B?Nm5OQ2pSY3doYm5ENCtTdmRhTXZzeXNNWGpFQWJyaWU5WnJkU0tlZldhc0NQ?=
 =?utf-8?B?N2RZZVN6d1VnV00vOHFkYmlSYmpaaWJmVjFIVlBGalJ0dUJINGx2M0g0azZW?=
 =?utf-8?B?eDRpUmJwZHBVcVVSUE85TUJQM2lRVkRGcGxEa091alRLWXV1K3lDWVlBUW50?=
 =?utf-8?B?S2tCaGVxUVo2Y2x5L1hwRS9JSWNYVGtxTW9JR0NrUHY1dHlnUHhCTUxMeGlE?=
 =?utf-8?B?dzZlM2cwN3hXMHNXcDVDRGU1ZlhqbDF5T0xwZFpEallJR3UrOS9oVWYvdmhv?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284283bf-8cee-47dd-6ae9-08dd33cb2aac
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 12:09:44.4843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6aUaN5IUW4wHxefddj4ZgKDLyOdShWIK057RI4HEaF9eTz0Z/NpxVt3RqSds6xADGY8dsjYOkEwCh6qzfkuBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3582
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jan 2025 12:09:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17533

On 10.01.25 17:50, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> During testing with LAVA it was detect that the overlays are not
> mounted on real hardware if the image is booted a second time.
> 
> SCRIPT_PREREQ adds a weak prerequisite to the script so it still
> works if the crypt hook is not installed.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> Changes v2:
>  - fixed typo in commit
>  - added clarification that SCRIPT_PREREQ adds a weak prerequisite
> 
>  .../initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb        | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
> index 56ae8d2..4e2e292 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
> @@ -45,6 +45,8 @@ DEBIAN_DEPENDS .= ", awk, coreutils, util-linux"
>  HOOK_ADD_MODULES = "overlay"
>  HOOK_COPY_EXECS = "mountpoint awk e2fsck mke2fs"
>  
> +SCRIPT_PREREQ="crypt"
> +
>  do_install:append() {
>      install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
>          "${D}/usr/share/initramfs-tools/scripts"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

