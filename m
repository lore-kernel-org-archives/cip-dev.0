Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D309CE7717F
	for <webhook@archiver.kernel.org>; Sun,  8 Dec 2024 09:16:13 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.63])
 by mx.groups.io with SMTP id smtpd.web11.75954.1733649372149204574
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Dec 2024 01:16:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=b+zMQR1s;
 spf=pass (domain: siemens.com, ip: 52.101.66.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tius4nQdsdCto4SG832NRAbVjRpND9Ywb/QC0bQ0KvJssuFYZ8dhbHOTrvPcAFW866WDo4yPw2E3Wo8cgMxowxDbyYuc9+AkFxx0yAB9SUQRXaP/u/lj5uz/WK6u8UDG4yq6fVd+wqy1KTbtBT0MXDawG82xcIaqGpRpetzu3fV03hZpChn68B4SpzB/OFvJXQg2jWIaqcCJQ/RDTzHx4yUlGZzjKP+PNAXsMsLmiFvT3FjTiyFZNHz/yJPzLZ9CYb4AO3PUTtx41le6yQiP4HvWfMaRysjwaTwaKbx7rJyB5dMPqF4NrV42cLB4F6WTZWfExD95c7RfXvxLhfuwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59nxOYiE1evS4FOHOiA1mvAMgGG93HLnt7SG9kg4tDA=;
 b=pIBzP72h9jTJ1B8Ju+jRdF7oSQQGm6QSZO0yw0TTPr/kRhcY24Q3qePpT8VGjxX+U6bVlVm+CuX8kVKuTpThD+//yiXWizQ2cxfqduFjMj2QChAyZrfC7XaTaRRBGMGRMOx15GuIzAVujDs3R3sYnyEnCERTLCgcqiWldIO8wjJDNZIEJMBhnLKBUtj0dU81dCHhRDu2x2G8qxFcTe5YrBN5e/gbcqIQODUzDbqqsumAv6XiY6oNm0rPaMKJSRsyhtvjdn6PkQZ5PNzxoIagDBtlBgehA0TL2+6LmoRGJrjVKIPU5q70lx08K60TzSN4T2AfHYzx4Sp98a29eVhAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59nxOYiE1evS4FOHOiA1mvAMgGG93HLnt7SG9kg4tDA=;
 b=b+zMQR1sMbGukA0FHkukwEl8Z0ftALjq3BVH+k+EQEd8FTFyICEBiqanEatKflabZ25Nlfof7hnh8jPRw7CsvIN94FFSedXUkXMHszwxJrn9YAjoDhh6zepHShGfsyBVMylOPt/gWYtF5qn/mSpvkfrweiAX450GjbYpfcYSq+sYF45vwZcEMcBf3Jx8afNX9vZd+od5WVmceXtr0dg3DblkkEokVrsHaymP2VpIbmnd2oWVEsnauzYeE7RUmgCvTJQ/ehqRrKUt7nnmUyyUF21y8LrfoUQptqHouRS6gJllB34nDz2WW44uD2JVp3xg2A4SprVD7Vbn0Ct9fImDSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8718.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.11; Sun, 8 Dec
 2024 09:16:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8251.011; Sun, 8 Dec 2024
 09:16:08 +0000
Message-ID: <0ba236ef-a9dc-4e2d-bdf8-18cded81f0f6@siemens.com>
Date: Sun, 8 Dec 2024 10:16:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Seal tpm key for disk encryption using
 PCR11.
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org,
 quirin.gylstorff@siemens.com
Cc: fabian.blaese@siemens-healthineers.com
References: <20241206114443.64042-1-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241206114443.64042-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0142.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d637c77-7a72-4fff-70b6-08dd1768f352
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
 =?utf-8?B?MHIxZlFKWElIMmM4NWxSYnBFdFd3WnIzWWZYNGgxeWltaU9qaElTYzZFVzJ1?=
 =?utf-8?B?VFVyNkJqbzg3K0k5cFF5ZWl5WGFBY0NweHhTK0NyV0FPOGF1TlJqWWZobEFs?=
 =?utf-8?B?c0FjTklISmQ4YWtnVmJkRTdzRE0zeWNUYmlKQlE5VjRTR1p0RUpLWDhqYXV1?=
 =?utf-8?B?QWNwM2M0MEdIYjNxZzFBUE43Ynh3TmtTbVdXRmNLZGNMbXJjaHRMM0VLbWti?=
 =?utf-8?B?YXkycDhDNVRreER1RHFmYUpBb0NTRnBmYUNwUU5kVTM0Q1dTczNvQ2Rudjdj?=
 =?utf-8?B?ZC8yblZYZFVyQ1NDQU1vUlF5M3EzdHNGNVhCWTQ0UGxyLzBRd1N1UXQ3dG5Q?=
 =?utf-8?B?QXF6Wlg1QWxodmJPM3JndHZSSitSZzd5ZTNoRjVJSlN5b25HMDZOcXRUV21p?=
 =?utf-8?B?anZ6U2gzU0thTkdTd2I4VDZZVmhVZ0dXQ1V2RmRGRWtUbTdDZE8vQUNPajBP?=
 =?utf-8?B?aWRGb3ZpbG1Tc2RJM3ZLeVZDNkNnWDJKYUttaWhBdk41TFFEczUxTWFzWUhU?=
 =?utf-8?B?V0wwUmpuTGFzalc1cERaaW8zZVV3ekNwTGNOVzVyVVBKdU1pQjVUQ3lMY0ZK?=
 =?utf-8?B?L3VQeXNKQ1VtMXlocDByRUFPVEFvcStnd2xmaEhTaWhSeEU5UmREcDNpZEl3?=
 =?utf-8?B?UW1Na2NmaTZVSWVQTjV0YWtSSVFXRFpZOU1BZVQ3bWZVL1J1RWYzTnpKWjJX?=
 =?utf-8?B?d2g3WmZlNjViUGZldW1vcXJ3a1VUWG5EQ28zbkU4UFVBMnpycG9QbktyYml3?=
 =?utf-8?B?bFZ2VWNyMjlmUWlJSDl1R1RnMkluZzRDUUQvV2FRMDMxblpxYlVNYzdhUlEr?=
 =?utf-8?B?RkEybTlxUE9OZFNmRUQ4OVpxZUFxLzNReTlqcnRjaC92clppbWd6UVpWeGIw?=
 =?utf-8?B?Q3Q2NWNmQWI3MVMwbGhPd2J3czVuK0h4YzQyNlNUb3orb1BCQXU1Tk1oeUtZ?=
 =?utf-8?B?VW9nT3JTcnNxNnV0cFhEb1AzNDFtMnRXcWI3U0tGUVFDSUp1YVp1VURCVDlZ?=
 =?utf-8?B?WVh6T2lMKzl5WldCL0hVTTA5TFZKaW80TGdNV203a3FSMWNLY2wvd3NZWVJj?=
 =?utf-8?B?ZmxvYW9tTEkwVi95RFlrTDZzME9Fbzg2RVRIOGVyQzNTSWtRK0FIZVVrMHJ2?=
 =?utf-8?B?cWdMaFJxbUZZenZUa0ttbThtQ21FaXhCUjdGeVlsbmZ3NGZnMjJ1cWNITis5?=
 =?utf-8?B?YXZtdGVxa3lNc0UwZ05ZY0V1WC9vTmJLaERtbmMyZ1lyOU9wRG1TQlFVYTZS?=
 =?utf-8?B?WENBNXhBTG1tbUFnNk1tWU5vbWt0TjFzeTQ2ZnU1YTVSem1LbW4vUENEa0ZS?=
 =?utf-8?B?T2JFdmtrc2RQbVBOdk9SMEZRWTVDeGpkbnJ3YXVOc21mQ3hjR2dSb2p5SjNJ?=
 =?utf-8?B?cnBsejJRNEJSMDdHSVJqVEJXanMwSEZIOHNONkM3ZThhUmJYR0RwZWdqQy85?=
 =?utf-8?B?eDVibFRJUDh2TkVyUDVEODNBNlRLdnJ4dGZ5UEtwMnZFREx5SVJ0emkzdHRC?=
 =?utf-8?B?QWQ2YXJwSS80VEZlWWx4TGN0NE5hNC9UMnk3Q0V0M1JyZUNqQ3BxaFg0Y2Iv?=
 =?utf-8?B?aDRkL0hMLzlGTG5QTmUyQ2E5Z25YNURSNU9UWHNDSlduME4vcnc4VGJBdzBk?=
 =?utf-8?B?bDhsS2k0c1JxUytuOC9kY3ZlMWJUWW01N2tIUlZ6UktiWlN4TkdySDk3SmVi?=
 =?utf-8?B?Y3doRXdhcnM2VjVyN01WcFBBR1FYZE5rOXc4b1ZXSThuc05ISE1SMEM0WVRk?=
 =?utf-8?B?WUZVR2VReDNDRStnckpST1RacFVEVmxpWmdyd3gydzhOc3FaN1pPRnJJd05Q?=
 =?utf-8?B?d2ZjNS9BSEdQMGtrQ2hxQT09?=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?utf-8?B?SXpaN05SSFR1ek5WcVhvTFFWdmVBU1YrTkRpM0JDdlRoNDhBTTZRSkxXdlkv?=
 =?utf-8?B?aXZBcmhSdjZXampBUGh1S3d0MWJsczFOTDM1VXR0NWUrS2l2QzM5b01hcXNl?=
 =?utf-8?B?emR6NGFCRTdMSE9jYjVlNW45NFcrUzh2WGI1M0NUNEtwVmRMTkJ5TnJDaThN?=
 =?utf-8?B?NlVRMTM1VmlsaXNabW9jZ2FVZ01nNG1mbC82OTFrTWd5V2c0ZUI5MXpNRDNY?=
 =?utf-8?B?ckNuOTlJS3JDallVanhUS1R6dm52S052WlBMUzZmTlJXKzlKTmFRc0s2c3Yz?=
 =?utf-8?B?OWJOcnlJdmZYQ0JaM0xtcjVQUzI0cm9hbTJMdHh4TE84Ty8xd0lDY3RLcmNk?=
 =?utf-8?B?dmFBR2UrMVJ2N08yUzEzeFhmcGUzZUFpM3BWUjcwR1pYOXJNSWF5WnN2ZlFS?=
 =?utf-8?B?SUVINit4VDlWUWxIRmR4UUpzaGx2d3Y3NjlIZXZTVVN2ejlDMDUxOW95Q3ov?=
 =?utf-8?B?NUxLTjNxMk9UaWNPSjB1cC9jL2dJSUcvMkRodVlYVlh4NEIvUzFObnpKYmtw?=
 =?utf-8?B?Q3hTRW1Ldk9IMW10eXQzdFp6YUtGbm4xT1FDc1NGZWZYVFdQS0R6dmFjeFQw?=
 =?utf-8?B?VHBwWTlUK2VueTE2ZG5sMGtiMW5Od0pWTUJGc2hjY2tjbk13cnpDNlN4bWxt?=
 =?utf-8?B?NGNSa01vT3Q5b3lJT2Z6V3lKc0c4UVIxYlJaYkJDT0praVFqQUNXeEQwRXJo?=
 =?utf-8?B?RzhSNjFJM0l4NnVvU21kK3ErcnU3S2RSeWtKbTEyTHlBazJ3Sm9lUTUycXB1?=
 =?utf-8?B?RGNla1RSMTE0bDlrY0RtVyt2bUVRVkFmWXA4aVkxbzQvNS9EUzVXQlNLV1o0?=
 =?utf-8?B?RWFsV21kQ1ZiWHRza1NPYjBQTzhrSFpnSmdsdm9NNVU1T2l2VHRib0dFTlZU?=
 =?utf-8?B?UGhPKzNRSWhzY2JHYS9ESVB4TG9keGhoRS9xbXNRYSt5WC9OSGdKMkZORDFK?=
 =?utf-8?B?a2N0MldjdUJzTjVVT0RQMjltS0c1dFJDL2ZnOVVEbmxrOU4rd1hxQ1MvV25G?=
 =?utf-8?B?dGdGbDhQLzlTUHdOUXJTZzc3dGVvME81dnpKSU9UVThWcVNxdlFZTFVLejhR?=
 =?utf-8?B?bDI5Wm5MVTZ5T1MrNmxIRUxnd1hSZ0RkbTd4UEhRd240TklHMXdQTkt3MmNN?=
 =?utf-8?B?NnFrQ2dXM2lFak5YUHJqeFNMZ2RsMG02LzFZUHJWemRoY0QyMzkzaU1PcS9o?=
 =?utf-8?B?MWlsa2VPa3UxcTIvUGNKU1dtdG03bitZeG8rbDFMZXEyZkYzWUUraGlEdUtJ?=
 =?utf-8?B?TXZieEgrMnlTZXF4VTRXWUFpTnZsSmVyTWdOMlFhWS94dHBKMitZVGJlclVI?=
 =?utf-8?B?d3B2MHdPMjRGMlBIOWhTZk1FdGlUU1FjTG9wRVNSRjB1VUIzY2pMVE9CU0pI?=
 =?utf-8?B?STlzRzNrdk5XS25iRldFeXhwdnFSeXpXYU5yUmRyczJ6eXN3K0FmZUpaNFlt?=
 =?utf-8?B?RWpTL2xoR3NYQWU4M1kybHVCZjhCT3hZMWxVR2tNcVJDMzBvV2lZRld6K3R4?=
 =?utf-8?B?RDlpbDRWcXhnRHVQQVhKNnY2NDlnNUhGSDFDaVh1R25BS0FwQ3FTeW1GOVA4?=
 =?utf-8?B?c2lWdFZ3SjFCSFpTUHAvdktKUEtZMjZJUFNUZUlnREN0NzhsUElJN0JpOE5O?=
 =?utf-8?B?QzZtSDNJV2doR1JQRk96NHdDemZURXV5alFnZllYRHRPSFJpSUIzbXE3cFhy?=
 =?utf-8?B?bjBDS1dJZ1RvQ0ozTXBlUEFrUjR3cXB4R2MwUFAzQjFTSFIzRUtQZnVRT1Rm?=
 =?utf-8?B?Rk9VMkVRQnBEY3J3dGdsdDhMUzlRekl1ZSsrb0d1QWVjdjRKSDBaR3hrbFdB?=
 =?utf-8?B?Z1lQK0g4anFkOWFpem9BSWpoNzh6c0dnSDlhRE9PQmdiUmRDcERlbGVNYS9p?=
 =?utf-8?B?WVE4RG1mTzZweXAzdWRldytRZTQ1RkVycmpKT0lmWDlQZGhnQ0tkbzZmdG9h?=
 =?utf-8?B?bTBTbGVwQ3pKNlE4VVdieW1HUGRPOGc2bGF3cVVuMUhpYnI4Y0VOdEJrdFNr?=
 =?utf-8?B?SDJWcDdpY1lzQ2l2ZGRWNlY3MXN0RnZuWVdQSlZ2ald4aWJPbklMVGZwRHNL?=
 =?utf-8?B?eGg0UnhySXhyRlhVeXdvRlViWUZTTlR2NFAzL1ZDQWFEQitYaWFQQU9Ed0sr?=
 =?utf-8?Q?xQCAujp7HUV9XGBBN382x+p7X?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d637c77-7a72-4fff-70b6-08dd1768f352
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 09:16:08.4231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wCruo3tRLxfLJ5VoFC8AQNGuLa11ph2+/UBa6Yf5g5KfMoaeo5GM9f32SzjZ3MRY7YxEWgHXu8lotOOC7zDeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8718
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 08 Dec 2024 09:16:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17371

On 06.12.24 12:44, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> The recently introduced sealing of the tpm key for disk encryption
> was bound to PCR7 only. Since PCR[0-7] are exclusively for use in
> platform firmware I switched to seal the key after cryptsetup by
> modifying PCR11. PCR11 was chosen because of a similar approach
> in systemd where the actual state of the initramfs is reflected.
> 

As expected, it's not that simple: PCR11 is extended with the kernel
image and more, at least when using system-stub. So, before basing the
disk keys on that, we would have to implement proper measured boot,
including measurement updates for A/B so that we do not "lose" the key
when installing a new UKI.

What would not be a problem are preexisting systems that linked the keys
only to PCR7 on enrollment. Those would indeed still work with the new
crypt hook.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

