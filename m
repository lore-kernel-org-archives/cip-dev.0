Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2769CCD199
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 15:59:11 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.29])
 by mx.groups.io with SMTP id smtpd.web11.19791.1760716742171735688
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Oct 2025 08:59:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UAA16+A6;
 spf=pass (domain: siemens.com, ip: 40.107.159.29, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eP7JRajzbupgRWg7uJT9sQeHxKcfodgQt3OmXI06wKIm2U2CN5zq3W0I8byF3vygpiJUTWtODGe79drG3gQUHqcOhHHj9tyTaIGO2rN1jFFPfCePhNnso66V6MdTVU7Gk0LXfIv2NnbduV4sNaTbqCPSZOj0Fc5GQfEyv4u75VuRSW6Pl4io/ypO35xNZ04kYwefQjcQOkJ8CqY5QK09AGwGDSS1K4ZdFtIdSI12l7Pye0JFYrKvj1eyBFgbpzqjQpdY1zrn62APdlGBHFE+NUYUME79bI5kcX7tj1T7rEVuU1Pzw+b49URYlyKq3g8G569/J6RzWhVVuZHPNeeIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ThmHijM6MUbBxB6uCTfRHwFuxEgJWcB28PfgHt7m5s=;
 b=ToOgT9Eqgf3VCFGmj9giJJcXEPU/FO0732lFQ2dT4pHcJ0tM2YBeQuzY/r3leSrYp4+4v4BEFA1xscL4c0p+ozSLyUUDXhwqdUCl+zQh5Hup44yin98c6kdsAic2CvRH639vheQpTG9ish4gHQ1+hKUUy8pErz5/F708l7z3JChUOtUWzP3NwkNjVzYQkNYw5PlqzRwc07qeca9bpa24Dzd1+Ngmq0jTnk+vS167CXgrfWOXjSTh/k+I+natMTFPXjRVSeFqZK+Vkmr1ppXBqly9RBsbJf/9aQR6nmf+yn8N2/T53P2EOKoQ+ca6/pEpd0X+WNqyxhogu4sd1oyBaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ThmHijM6MUbBxB6uCTfRHwFuxEgJWcB28PfgHt7m5s=;
 b=UAA16+A6+KZiFtj8+39OwWoq9QPQWD4USkSJfIN+Jq0D0c+h4l82mR6imOJsDb9ROB5zrsZK2QAp7CQwx3sBsN6oYAchWrDz9vSFW1KBqc2yJCVYzS+34JeUHDXisZKmHy0T1VUh9AKXMB5yz1MKOaL/xcb4GvUZ6+VuG0oDEapb2ACHR2hpvEMmgECwycU5w3jpNIUO11xJh0s3E5yFrZe4lDiZkXLlpOc+R9pYMQVfROiFVGGaBOqqxwn7ROtXY2j1ZuSqhIaOrT0ldgRrLnV678vI2FtVQJXhjrn/J348/Gtd51GdZyC5VABiCR5QB9OD8BFZp9rDB7NJED2h9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5978.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 15:58:58 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 15:58:58 +0000
Message-ID: <a26009ec-1ee9-454c-8e28-b173cb812fe6@siemens.com>
Date: Fri, 17 Oct 2025 17:58:57 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.9
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 189e0158-b5ac-46da-e400-08de0d9614c9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OWp3anFSM0xHTGlWaGFzZmx4c09ocHFEV0pESmpvNlpBMXo1TEJxNzNIN3FX?=
 =?utf-8?B?YURWOWVIMjRhU2d1NkdTT2JqbWdRWHRYd3FmOCtmbnQ3VExMaTZ6b2Y3REY0?=
 =?utf-8?B?dG4zanIySXd6RXptTzhUR3NEckhicThDOUU4SDIxZm03R21wdEJ4cUFVNGxR?=
 =?utf-8?B?UE4wbjh3ZmlNdWxmbFMrRDV1NmRqNE01bGpPMWhhRkp3STRQV2M5Z2NXQ0l4?=
 =?utf-8?B?N25DMldvMzVNQVJWbk5GZnJHd2oxYmtIbHBmM1p4aituUWt6QUhaa2xxVVB1?=
 =?utf-8?B?RlV3L3VXb3FRZXMvSWx6L0szelJaaTdEbUNQaWRFWHpCODV1bTcvV3pFb0ZC?=
 =?utf-8?B?N1ltbkt2emFLVDI1NUY2VWROcVpRbTF2M25KUjhlcmhRd3Q4MmloU1BPOXBQ?=
 =?utf-8?B?UVlDaWQxR3lZWHJYT3lyb0JQWlc1UDI3TmdmcnVjUWZOZS9lQkpKMEdVbEk3?=
 =?utf-8?B?c241NDFLZlFQeVNwZEJZN2pmaFlwK3V4TkFraWRzN1o0T3I5cGRwN3pVdHRy?=
 =?utf-8?B?MFh5RUpMaFFkS3NubWVpZ1lGOHBKR2oxQnE2eitHdWxLVnY4VHJhT0RGL0FF?=
 =?utf-8?B?c1k2RVR1RmJ1Nnloc3luZG5ITzJCUi9EalgrZERDRHdWanV5L3lvSlVrNjhW?=
 =?utf-8?B?Zkx0NU5OcnI3ZCtmeXZueEhvNUZPMVg1bEsxMVlLd0FQMmtFQkFCd1kzcitt?=
 =?utf-8?B?MHRlY1NRbm84cmFHTmVxWUFDREZFbnJsV3ljQWMzcXpCZDRaSFh4Q20xQ0Mx?=
 =?utf-8?B?bDFuTDQ1MTVPSmh5OWxxMGw0S1VlbFpXTU1LdU16M2huY1I1eVNxVHhyN1kr?=
 =?utf-8?B?UEFUalMyM3AzTjlkVGxwbVkxdVJwTUFtb2drTThDaVRRVHUxZzFIeGQvRzh5?=
 =?utf-8?B?R3FXSlVkYWNERFR3K3pHWVByc3EzVmt2d2FGOFJWc052V01GRllERE5NUDRG?=
 =?utf-8?B?aG1kajBHQ3RUNlhDdDA3YTNNNWl5TzJ4VEVHY3ovNGZjdkQ2a1NmYzc5bHZk?=
 =?utf-8?B?d2pPWlhUcHAxREFUZE16SVJZOWJvU0lCUHZuNWE4RlRyVVpZYWhBT2Rhc0ZH?=
 =?utf-8?B?UGM3UVFFU1Jxb0lOVCtreEhFK3VDaGhQNVgzeWFUZFg0ZWp2Z1EvRGxINmRN?=
 =?utf-8?B?UTNNVlNuLzVpeU4ydEJjZXlNbjRIYWVZWkZ6SmNtUlJnM2I1Ym1WRk1CeHNp?=
 =?utf-8?B?TFB4cmY4U0t2QzRCMmxIbU0xOXh6MjdZUTIza2kycmtUS0FqNmV5dWR0SWhC?=
 =?utf-8?B?ZS84THE4aFYwVjRXUUJJcVgvbStiNjNVcDJ4aGtWbldaQ0FMZHBpV09JT3Ex?=
 =?utf-8?B?UE1EQnpiUEx6R0lCa0draVE5Vldla2JpbXJTdXp4WlZIWmVIL2RuY2VwTkMy?=
 =?utf-8?B?MUp2ZGlHQ3hnUGI1c0VNSG5mRko2TFN0emNGZHpoQ0dEbFdLK3QwaVVtbEhW?=
 =?utf-8?B?RmlTdVVSZk8yU3p6aTZsY1A5L2c3N2pOeUxHZDVVbFlIdWg4ak4xOEdjN0My?=
 =?utf-8?B?MG1vNW5KN2p5dmczb0hKS2ZHYjFMd3MyQ2lkYTdjbGE5cS8yaTVqb1ZMRUxP?=
 =?utf-8?B?K2lRS3Jmb2hXUzcwZmFaL0pDc3JLT2c2eG1iTFJJZVQ1UHZKVFMxWnVyRjV5?=
 =?utf-8?B?Y3RVL3gxK09CRzRJdDM5Y0p3b0JIY3hLTkNNT2JoWkxZY0dOOEFRSUJBWktE?=
 =?utf-8?B?MjJxbml0eVdRNFVqS1FpU01DeVIyYmZjbk1GVm1weDFVVUZHR3dvNGJLajkr?=
 =?utf-8?B?NmszMmhuN3pPalUxRlhxM2hFTlB4cjUwU2tkYnZEMHhteXdKZjBCeEsvamtj?=
 =?utf-8?B?ZGZmQkFUcXJZbnZOazZTSHYxZEduN3g4OXZ6UUpmYWRybkxESm4wbXc5OXVw?=
 =?utf-8?B?citPTkE3Ry9ieWlMczRndG9ja3BpQ2I3YmplVlRpaklBazRMam8vbGhIbTBo?=
 =?utf-8?Q?2FFzvH9vaX8Ws49fHmXl+gbPBA7lWEjf?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SjZVQ3pSa3QvV3I1bXpYWG1vRm5CcWhkVGFvNzRxZzhzNG1KRW1KYjhtR3gx?=
 =?utf-8?B?TGRwTDZrZFFWVWRUY25CWDl1d3N3OU0rNnhPSHdxSnowbWVNSjQ4eTJGd2lL?=
 =?utf-8?B?TjgyN2hEZHY2NHJWb2xCWXNXTXNSSUZiTStjYWovbzZHUHE1Q1BPRXdvOGtZ?=
 =?utf-8?B?cUNmQmNRNGRUVU9TY1krN2FsM21DU2FwemJ4dlk3eU1LNGFwaW5RNFJqMS9i?=
 =?utf-8?B?aCtiQlFoVWEzV3E3Q3dHS2dqZTZxeFhjTmV2dnoxMXhkekN2VGJVSzRlRFpq?=
 =?utf-8?B?YjdmaHpIV1A3RnBYdkQvZVpUK3R0K3RPWVlpcFpUWnFITU90OENMeUlEMDlE?=
 =?utf-8?B?OXNoMjAzYXYzaTZheWdHNTVmdk1PLzJPMEJsOE1LUWtpTXpOaWppcWZqT3Vx?=
 =?utf-8?B?Y3gzSjAzMFRDT3BmOVYzQTZ1MDVhZHVLUXg2eG5QTHYvc1FGYlpOUlVJcHd2?=
 =?utf-8?B?ZnJIVkQxUlM2TXZxdGQyaDJ2bmVvclRUbzNkYVhLQXlrVHFOdlYwNEgxMHZh?=
 =?utf-8?B?ajIxeDg0Nk9Nc2NxaEhzeUZxRytYVFVSd2tHSit4Zi90T3VGSUozb0RJWmw2?=
 =?utf-8?B?SGM3WlM1WWc1WWE0cVZ4NkxhWXZIckIzZFZSRVlpTVhxZlFPOEpQcXJITWQz?=
 =?utf-8?B?U0U0ZHdaOWlwNVlvbHM4d0I1RnVaeVliL29CSUFjZExHYUgyZTNDd0tTL0xU?=
 =?utf-8?B?Q0R2eVg4dUZHby9MNFVBZHJiek5zSElFWEUzblFHMDZUM2E1QjRXZFNDejJ2?=
 =?utf-8?B?VGIxRnR3QUhUVFdUNnl3SW04QkVsWWNyRzl0QXBTY1hmTWh6bFA1R00xbldi?=
 =?utf-8?B?RlZSVkxZVDlhd2lOVlpjbG8vbkRnd0lDaXo2bWlwSkdJbFQ0bzc5NGJ2V0k1?=
 =?utf-8?B?N204cUpyZ3dQVmY0NUI5ZmhDRU5LdTZPS21sbjYxUU9QZmNzR0F1dUlmUHFi?=
 =?utf-8?B?dFBaak05ZE54K1FjOUFKV0FIb1dScnQyZFVNeHlzVzBtSEozQVFLZ2JISTZG?=
 =?utf-8?B?YWswVFFBaUNZUXB1aEVqemM1eWxVN0l5UytYS0F3MTZWbVFwN1MwQytGM3Jn?=
 =?utf-8?B?WW0zV0xxd1NOdGRzLzNocUxyTzZQeThRK2NxNEdVS01CeTFqWGtYczJRZ04v?=
 =?utf-8?B?ZUdxaDJ5Rm5QU3FoQjVja3RDKzNLSEhrM2JxMVpiVWJIa2k2UWYvM3ZoRkNL?=
 =?utf-8?B?TjF2aVNuQ2FYZ3RjWU0yTTlwRVVTWXRwN29VekMvOEhmc0N5RmhkeDJJMVJ3?=
 =?utf-8?B?dTUvWjlMdFo4R29qSjJpeGV3ZmdJMUxBSVVOK01LQS80R3NyY3Y4djdLNWJY?=
 =?utf-8?B?YWpOQ1EwT1FFTi83RFRZdGpVTEhoNmdKNW1DaEZGamhaN05IMGR4WGdSOVRi?=
 =?utf-8?B?UDByaHlmZHBiM280RGdjcGt3NC9UVkFaZTVvK1pOTzRwQjlnbTM4cExmd0hO?=
 =?utf-8?B?ZVNVWXRucWtLQ09IbXdLVWZpa1NJdW9zSExwQXczNDJOVm4vRTQ4MXFZbTMv?=
 =?utf-8?B?UlVsVnNGQjdkT2RWdVc0T3I3UkZ3NlU3UGt3T0RZcXRpQndjbGJmWTZjTVdw?=
 =?utf-8?B?RUVWRGFlOWxRY3pJL2Z4cHAyd1VNL0M5V29aNnFvZVRnT1hSbGRiVGxKcjAv?=
 =?utf-8?B?SEZLcUErYTBpamtNMDdCZXFZM1kwUTZLa2RNaGhnNXZyRGJjdWo1dmdFakFz?=
 =?utf-8?B?RitkZTFyRE9lS3ozc2t4UHV5K0hTaHVrN1VVcmtqY014SnFYQW1VNHJxbFZG?=
 =?utf-8?B?YkFFWCsrK01TQVRMUW5wU0FrS3B5Ty95L1d3K3ZuZGhqQ09Sb2pmcWx3dHp0?=
 =?utf-8?B?aHJDVGVmcnpkK1pXUGgzYmNsT2lsaHNIK3dBbTBtcnVMMXl6aG03cVF0MVM0?=
 =?utf-8?B?b2Jpa3Rld2x2MkJFeXhkQzdDUzJiMDBKS1JqVmE0QWlXL1M2Y1FQSUpEVjhO?=
 =?utf-8?B?c0pCRkQwVkZoRXVFclBaaCtaMm1MNmU3RzhiRXlPQnN4SUFSZklTbHlqOWN4?=
 =?utf-8?B?c2l4V2NOZnIrV2lYWDc5Zjl1Y2FBQWJlbVg4bkhkdmRaN1FvR3ppdzY0VmNz?=
 =?utf-8?B?eVY1Y3JGWFBkUmlTd21QUkVyd1I3cEsvY3RaUnBBSzliNHNBWHRSNGhLcHVU?=
 =?utf-8?Q?j8hsMKCndBNP0mhW3Vd5ao9t+?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 189e0158-b5ac-46da-e400-08de0d9614c9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 15:58:58.0304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0YXAS8LJoCmFMhqSTmUoNKlqX6SD/lBK945qNMfjcwaeUNutKhR3w/3NSkarBfKaLhieByD+YT55Dd7iEclRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5978
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Oct 2025 15:59:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20196

A new release of isar-cip-core is available. Slightly delayed due to 
oddities in on-device testing, but those turned out to be unrelated to 
this layer. 49 changesets, 8 contributors, 85 files changed, 957 
insertions(+), 141 deletions(-), the stats for v1.9.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.9?ref_type=tags

This release comes a factor reset framework which should unify the way 
this rather common feature can be modeled, check out doc/README.factory-
reset.md. Also new is delta update support for the unified kernel image. 
Then a reproducibility issue with erofs was fixed. With Debian trixie 
now finally released, a document was added to describe SWUpdate-related 
aspects when updating from bookworm. Finally, a lot of package updates 
were done, including a bump to the latest EFI Boot Guard 0.21 release.

Thanks a lot to all the contributors!

Jan


David Kauschke (1):
      initramfs-crypt-hook: add tpm_tis_spi module support

Felix Moessbauer (1):
      make apt cache world readable

Jan Kiszka (22):
      linux-cip: Update to 4.4.302-cip101 and 6.12.41-cip6
      Kconfig: trixie is released
      edk2-standalonemm-rpmb: Improve recipe internals
      u-boot: Use hush shell in secure boot mode
      u-boot: Update to v2025.07
      opensbi-qemu-riscv64: Update to 1.7
      linux-cip: Update to 4.19.325-cip123 and 6.1.148-cip45
      secure-boot-snakeoil: Use bullseye key for non-x86 buster targets
      linux-cip: Update to 5.10.240-cip63 and 6.12.43-cip7
      linux-cip: Update to 4.4.302-cip102[-rt57], 5.10.241-cip64, 6.12.46-cip8
      efibootguard: Update to 0.21-1
      ci: Do not attach cve-checks to scheduled pipelines
      ci: Add job to build own lavacli container for tests
      ci: Switch test jobs to self-built lavacli container
      ci: Fix reproducible build jobs
      cip-core-common: Refactor selection of self-built dosfstools-native
      linux-cip: Update to 4.19.325-cip124, 5.10.241-cip64-rt28, 6.1.151-cip46[-rt24]
      tests: Raise boot timeout for M-COM target
      linux-cip: Update to 4.19.325-cip124-rt44 and 6.12.48-cip9
      Reduce initial /var partition size to 512M
      linux-cip: Update to 4.4.302-cip103
      linux-cip: Update to 5.10.245-cip65 and 6.12.51-cip10

Li Hua Qian (1):
      edk2-standalonemm-rpmb: Bump to 202505 and refresh crypto dependencies

Nobuhiro Iwamatsu (4):
      kas/opt: Add option for not install kernel
      Kconfig: Add config NO_KERNEL for kernel selection
      .gitlab-ci.yml: Drop build:qemu-*-test
      recipes-core: ltp: Update to 20250530

Quirin Gylstorff (12):
      README: Add links to the additional documentation
      Add doc for update to trixie
      swupdate.bbclass: Ensure coreutils are installed
      erofs: Set UUID and SOURCE_DATE_EPOCH with empty exclude dir
      Add factory-reset-helper to set the Marker correctly
      Factory-reset-helper file is incompatible with encrypt-partitions
      Add factory-reset initramfs hook
      Set PREFERRED_PROVIDER_factory-reset-helper for all machines
      Add settings for factory-reset with a separate home partition
      Add README for factory-reset
      Kconfig: add option for factory-reset
      ci: Add factory-reset to qemu-amd64

Sari, Sercan (1):
      initramfs-crypt-hook: remove redundant logs from console

Shivanand Kunijadar (7):
      Add additional test for secure boot to test rootfs corruption
      Remove credentials from console & document them in security README
      swupdate-handler-roundrobin: Update revision for rdiff_file handler support
      delta-update.yml: Add previous image kernel file for rdiff delta update
      Add delta update support for kernel binary update using rdiff_file handler
      .gitlab-ci.yml: Add linux.efi to previous image folder
      README.swupdate.md: Modify readme for kernel binary delta update support.

