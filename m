Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62A4C36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 11:28:10 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.11])
 by mx.groups.io with SMTP id smtpd.web10.44908.1744025290033529950
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Apr 2025 04:28:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=t01Hxh6J;
 spf=pass (domain: siemens.com, ip: 40.107.162.11, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqygHihEmQNj41ygkqHirFW0WxVRFvDtT9c+4XceMK0LeLiylesF5zV67Zxa5fULE9awPTpIUJcxx/NPffbq7PgFl+rbn574MF/VeXq9Fkv4e4vVJtrFzm2WxCuVsChCMhW3EuD520nfku7kT1V+bIlhzaoP/95SMhPt2qnygDfm9tHq0kmnE6GNC8La1YUUdI2QLOSiCm0L/qevWouEEcQDMPpQ8oBHPfO/udXNNQ28hcqPLeaawIRvNUNEIsPDNd/EaMA+Rdwfagt0qixeNtDEI1/JLnrGAtxDedXcZfh6KyA6sQaXh4ujAK1vkhJuEFEN1G+E5is2F5WOH5G9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wI++0u+6AABeEzfBoy+c2G/ULXt0nG+L5CfILKS7xG0=;
 b=jjsDMkeuJsW/Od96eF0ttEaPKwFcYv9ykABBSCQr1lTPxpt8KTDJakQfEMAzY6u3zwhNIP6Pe9JWDhoeDg33c3XNixWq6HXW9hDyEtnj0dFdPeVex5lHUSD7lBdgLAoLYVDOlT88n2wciElKfxboubPFeXWjFQDtX/fVo2MDGceo2kLpkbDqSfIvvQPoNP5TZcADVS/idwtcbCEiXhJ/E3BzwShGMJkUygz3Yx4er1AbEeutBy8bvYtApPSPbEdesuLjgEAdUOWcZH/BVQmFCTNRzvfyYIcZpAbSB9/XhAmF2dzZLcN+OCRxevn6yfXSyYEx1nmmWnUPtn9U8ZAswA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI++0u+6AABeEzfBoy+c2G/ULXt0nG+L5CfILKS7xG0=;
 b=t01Hxh6JmIAVNfrk3D0e6pgaGvvAwt0Eh6NWJOu2Sd0/AuODzFLjQCTkIQVv/MHNHi6xah0WOM73Xqmy6/YN0TfR4nfWiItewQTW4oRuuHsu85ifmFOEI93+vaPmoko5Slm256O1F4tewcJuGIqX9WGdEjVR8/MkXEH9pLvs2S3wHdb0w0sNdPwZn1FdKCIzCptiultK4VjSYA5vKXKIHF9G6AT19PavimOUfeySCXMrNSJ58W1jrM0F4LGAZ9/9TttxFubYegRmuQnYL5SghqFHXjLzAGAQLU6e3ZMuTw4GcZf/BDmv7hvFhddizgAlHVf2T0jhmM7KZJdksPhVFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5695.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 11:28:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 11:28:06 +0000
Message-ID: <767a6356-b234-45cb-b2ae-9aa88acd5c2c@siemens.com>
Date: Mon, 7 Apr 2025 13:28:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] ebg-efi: add support to deploy
 additional files on boot partition
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: cedric.hombourger@siemens.com, quirin.gylstorff@siemens.com
References: <20250324125942.3548370-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250324125942.3548370-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5695:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e4d802-473f-4cd8-845d-08dd75c74420
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M0tXVGsvaXFWdGs1RXpHejJpbjBJVWpMK0VzOXZJTk9OZFB5aTJ6b3lBNkJi?=
 =?utf-8?B?QWxrQ3ZZNE5YMkxWK1BzbllydjMyMTN3bFhlTlJlV3J2TUg2ZlhXZTluYWMz?=
 =?utf-8?B?SWs0eE90R1ZZQitmWkRnbFRCR2NUYVR2VURoYnNUWWhXUFNRckRDUzN3QTRC?=
 =?utf-8?B?bm5UT0hzdjE4MVZZVkxPSzI3N0JBYklZSkk1eU45MGZJU1JXYWxOd0RUS0Y0?=
 =?utf-8?B?WHNLOCs0YThNeTM3VndlYXBJR1lmcmltYnd1VXRBZWVvaTlUK1ZJV3VlZGN0?=
 =?utf-8?B?czlXaytTdVVXZ2FRV1ZRYkYzWUJLYW0vcjJvOFRsUzM3OGFuTGNRYUtJRGtz?=
 =?utf-8?B?OG82d0dia3I3cDcvcFkwc2V0VlRra1Y3ck5rLzNDaTZYOUR0RzhtOHJEcjlS?=
 =?utf-8?B?NmhqZUJqcnNpVlJGVE95cXIxeEoxQVBYdFEvWkVmZ21RQWJFOGJMZ2x3M1No?=
 =?utf-8?B?czlGVFYzaGlJUjRDRXBiVkcwMlhkSUVNQ1dOMzR5b0lmYWpsQkN3VU1XQVNu?=
 =?utf-8?B?MUFuK3NzVVFrSy9xWnNmVzBRUXFHRlBHZHhYdExGRnRqQ2lLK1FIRDhHV3ZB?=
 =?utf-8?B?NkNlR1VYQ0VFY3haQjJjZU5mUEpUVGJobmVhMExQT0E3RlZveTIxb3doRzEw?=
 =?utf-8?B?ZnZxZ0dGcXBjY1paQW9KbkdSMERmczFFVmY1U3Vtd2lxUC9jMGFJNGx1a2lD?=
 =?utf-8?B?czBnOWdqMUk4SithM3h3TThKTjJ2MEh1QnpyN2VydUxna2xuMFBOMkxaRFFD?=
 =?utf-8?B?OXJJa0wxQ0s0aEYrRUUwQ1RMMUd1TWpRNHpZNmtJb0k4Wlk1bEY1ZTEwV3pr?=
 =?utf-8?B?cXB6aFZmSXhXSDJLY3ZFYlhoSFBLODcrU3pFaWNzbUZ5ck8wV1RMOWltQmRo?=
 =?utf-8?B?blRwMlloN09ldE03b0wzSkZPd1JYVjg2a0RjMVhicm1WQ1BDNkZCWnVqU3Mv?=
 =?utf-8?B?cmEzNWJ2NExlblZHQmVuRkNHUCtvSnFGaDNBUUlYT1lVbkV5bDJiSzZxRXNH?=
 =?utf-8?B?VUx4N3NWVXhiUkNqM3BucnloaFpVSllWc1cxeDNyZEI4RG9uclFwV1ZOMTJE?=
 =?utf-8?B?Rm1GamM3RVQ4RzRSdk4zdHVlU1hZQ3MxWlJXbThmc1VoVlk5akdvQXh2VWRx?=
 =?utf-8?B?R0NpbGQxNmVBNTloOVR5TWY4c014YVY5cERBcjlYTHM3dzhYbmJSamdoSkk4?=
 =?utf-8?B?YVJXOUJvY0EzR0dBelI5ejhFR3dPaVlHQkJuUnhjaVRGWjRqMXozZ2RURVlh?=
 =?utf-8?B?bENxSFlRNTBtVnNRVS9GcnlKc1N4NzBsY3M3Yk5rWE92L1REMEVUNTlUbjJI?=
 =?utf-8?B?NExIRlJuMXJSUDJYWEw1OWQyMEpobHhrZVZybzVCOGZZOTkvZzNOM2ZjTUZH?=
 =?utf-8?B?NHh0WGE5cXMzQkIzZHR2Rkc3bVdrT0d2ZjVwVm9zSmNqTi9qd2ZBOGIvbHdt?=
 =?utf-8?B?aDVEdjhpbXlCb2cwNFIyazF0RUFZQldwazMxUlR2RkR2UE92aGJCYVZXVmNs?=
 =?utf-8?B?MGNFSGpJUUMxM3B0NWI3VG5jTVhFTDVQL0FERWM3Q2JyS0FSWmFqMy83eXF4?=
 =?utf-8?B?VDNmWi9zbnE5RmxQL3p0d2ROUUd2OG9mRVdBUHNtenJYU3NVaEJSZzQybGVK?=
 =?utf-8?B?S05ZdnlaQlArZFB5WXYrZ0NEamZZMzJ3ejliTXpxdDBaT2JtYWNsRFBmTkdD?=
 =?utf-8?B?WXUwakxwcW11Nld3S2pRRi9uYng4T2ViZ2RVNzZLVFVBZkpMWkRPczB5M0la?=
 =?utf-8?B?RlJDeWllSkh3KzU4NDJKK2JDUmRrRWZLdm41ekNvUXR6NGNWUEtmNGtuOHBM?=
 =?utf-8?B?WWFyYTlBamtsMmo0c2h1TXl5d2pTN2tJV1lIR0pDTlN3dmtxVGl2a3BwRHZx?=
 =?utf-8?Q?TtupWFymIxwTn?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?LzJEZDFQMFVKNEhQNGJaYTRoZDkxVTRqNXhwVEhFWHdLTnNhVjlBVXNwN1dN?=
 =?utf-8?B?SmEraTgyVHdadjF4NG1pV2hGSmFKYmxNSW8zNkNqV1Z6b1hIM1owc0Y4VkpX?=
 =?utf-8?B?MWlMb0kvYVJqMkRRb083aEtoeXFZVkhQQm9YVkxaSXJTMmI1R0VFVE5LdGh1?=
 =?utf-8?B?anFPUEp5NDh4cUI1clFQdFByMkpqdzBjT3BHaHJjemNKcjUvVW5GRzFTaHhM?=
 =?utf-8?B?TmcwVWFQc0dEYkFtU1ppYzNXbkduRUUwZDMvdUhRaUZnQ3FOM2tweWNyMGpB?=
 =?utf-8?B?Vko1dXMyZ2pHTmcrRkxJZWVhY25zNlVxUzZzejVuVW54L0ZRanB3d05UcTJB?=
 =?utf-8?B?MHVhWWJadTFDaHUvWENCT3g3N0oxSVZWSzN0SGtvTGtaWk9TU3dGanNTNnk3?=
 =?utf-8?B?RDkzajVOZXNJN1ZacFZoVG8xYUhoRjcwV0UvaVJUQTEyK281RysxZjZEUkdD?=
 =?utf-8?B?aWNIdlBVeXI5cWppVERyUDNiR0RPVU0rWEcrRms4eVg2NWpWb2pPUHExMzA1?=
 =?utf-8?B?ZGVhb3NpT1Z0dVVyVkVMb1ZyRmx4d0dCQ041OENwVmRDREJIUytiNXRLdXd3?=
 =?utf-8?B?ZllhV3IxQjVOZ3pKMEwrRnd2UkM0RjY2enMzRElWUVlGR1NIdHZWRWJ2U1F6?=
 =?utf-8?B?VTJaMUdPR0RZSGVpai83aVZkc1dmYU5jMExyRDFnNWNVcHlaV1h4VHQweUdC?=
 =?utf-8?B?SjlNMHFhOGMxU29VQTI2UWFpdllzNGVWbktQZUNCZ3QrRVhRVnUxUXpvV0Rx?=
 =?utf-8?B?eU5zVnpsSURycTFNNXJXUXZwNTViai9nUCtQczBRaU1OaWhzRkdNWWhKVE02?=
 =?utf-8?B?K1QrcThYTlM5VnR6TEFZM3BFOW1aUWVTbXlya2ZxQ05vVmNpVHFMbmhuNnVV?=
 =?utf-8?B?WkZ2S3NmZ2dheTE1YnloU2tnQVBGTGV2UjlPNHJBUjZ3cjZNSFM4VWhzTCtQ?=
 =?utf-8?B?QlF3S1BSbzRIRU1VS0cybTB1Z2NFclE4Wm5nWEd1Tk9rRDJXVmFIQVZralRy?=
 =?utf-8?B?MW51dS92eFB5aGRYaExJdjhtV0JFajUvRFhpaEk4NGpxdi9ZcVpqNTRyTXJD?=
 =?utf-8?B?MVpkSmRUQjltRUFHQnBSTVVTNGxSQnNXK290T2QxWTFYcnlBR0pEQkhhYUZS?=
 =?utf-8?B?QWdsZ2ZaRXBJdm5LSHB4elhNdjM2aFozdFg1b0V5UkxFV2JsMmhkRUZJcGla?=
 =?utf-8?B?Q2diQjVNb0pIWEE3SjVhTmlrRVNaK2plN1FlMk5kL1NZWGVEb1hvOEg5OTJQ?=
 =?utf-8?B?U2ZKcVNjcllkc1RKb0k3dS80a3hCaVJESkp6K0RFT3h3Wk96MEhTSTJJRng4?=
 =?utf-8?B?eE9CRGJrcVFkbkM4d29OdGJPZ0J0TC90Ynd0TmtRRTZMV05EeHYxWkQrNjFz?=
 =?utf-8?B?T213dnh0dmNDMDVBNTBHZ3Zsall3bXMvNDlmbmthWW5xNmF0VlhRTGIzNlFs?=
 =?utf-8?B?WVhycmFQams1aHFLb1g2NnVCaGFtVmtsMS9QbVR4UmxzS0xJOGVGcFVneUt6?=
 =?utf-8?B?OVpOVFpWZ1c2Vk5BeE94YktXb2QvdTZ6bW15bllUYXRTQ3Y1VG1vSUtBMWFL?=
 =?utf-8?B?N3BySkUxV0RwUGEzRVM2ODhrdmsrQWZ1OXoyeWF0dWNhaFBSNFo2ckpVclpT?=
 =?utf-8?B?Vzh6MkRYYkZTSTNtQnp4ZllJdEpscUJCNTdHTFZQZU5xL092MmJtUjMvQlZZ?=
 =?utf-8?B?MnB2MENDai9IbzRjcnROdFBrdTl1R0l0eUFyNzNDOFhIRmNkUnRHbkw1b29z?=
 =?utf-8?B?Q0pKSFgyR1VRaDZNZ2RseTdQTkFIMnRaYnFRbG01b21HNkprTStCdW50TXNG?=
 =?utf-8?B?ZlZrVW96VXNJRWxlUyt1SkwydnMrdmVWWlBNcGVMN2VVSHpUcHZuaElGUkw4?=
 =?utf-8?B?UzRHbE5ac3V1YjN6YityakM3NlNQSll6bW9VbkJFaE1nTUZpNExIMjVGTHJv?=
 =?utf-8?B?MVJQL0RqUERNNWdHT3ZxQUNkcjJxaVNFOWEzeHZZTy80YWdpWjJmVDJjb2dO?=
 =?utf-8?B?QmUwakE0c2hub0dEUTRVWSs1cURTQkwxem1RNUVuZzRCTXYvSEhQZ0dHalZ2?=
 =?utf-8?B?NFM1cDBpTEViVmhMeXlhT0dGYmw5WFlhaExrczFrM3FFN1BUM292bEdYNHdj?=
 =?utf-8?B?T1UwZGNtN2N3YnlmNDBOdTc4eUtiamN1MWx2UmtLSlBsRlloVVFTSWNBU3V0?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e4d802-473f-4cd8-845d-08dd75c74420
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 11:28:06.4553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxWVVwNuICSSCzrljKP7E6cxXlozu2fb1nV0hTfTTRpL9uOIxW+q58GFDbsuID4T9cVs4Ym6nBsuG5isW0ynRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5695
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Apr 2025 11:28:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18484

On 24.03.25 13:59, Felix Moessbauer wrote:
> Some embedded systems (like the RPi 4b) cannot directly boot EFI.
> Instead, they use a staged approach where a first stage loader then
> loads the EFI provider, which then boots the efi target. For that, both
> the first-stage loader, as well as additional config files need to be
> added to the initial boot partition.
> 
> The bootimg-efi-isar already supports this for both grub and
> systemd-boot by adding files to the IMAGE_EFI_BOOT_FILES bitbake
> variable. We now add the same support to the EBG wic plugin, by copying
> the code 1:1 to efibootguard-efi.py.
> 
> Note, that by design these files are only copied to the ebg boot
> partition, but not to the A/B kernel partitions. While we are not yet
> EFI bootet, only a single partition is scanned by the firmware loader.
> Once we bootet EFI, there is no need for the additional files anymore.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
> Hi, this only adds the infrastructure, but unfortunately we don't have
> any in-tree user yet. I'm hesitant to add one, as these targets are not
> official CIP targets. The code has been tested locally and is
> really just a 1:1 copy. If you have ideas how to test it in CIP, please
> let me know.
> 
> Best regards,
> Felix Moessbauer
> Siemens AG
> 
>  .../wic/plugins/source/efibootguard-efi.py    | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> index 48f7523..cce948e 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> @@ -29,9 +29,12 @@
>  
>  import logging
>  import os
> +import re
> +from glob import glob
>  
>  msger = logging.getLogger('wic')
>  
> +from wic import WicError
>  from wic.pluginbase import SourcePlugin
>  from wic.misc import exec_cmd, get_bitbake_var, BOOTDD_EXTRA_SPACE
>  
> @@ -42,6 +45,51 @@ class EfibootguardEFIPlugin(SourcePlugin):
>  
>      name = 'efibootguard-efi'
>  
> +    @classmethod
> +    def _deploy_additional_boot_files(cls, boot_files, kernel_dir, part_rootfs_dir):
> +        # based on bootimg-efi-isar.py to get consistent behavior
> +        # list of tuples (src_name, dst_name)
> +        deploy_files = []
> +        for src_entry in re.findall(r'[\w;\-\./\*]+', boot_files):
> +            if ';' in src_entry:
> +                dst_entry = tuple(src_entry.split(';'))
> +                if not dst_entry[0] or not dst_entry[1]:
> +                    raise WicError('Malformed boot file entry: %s' % src_entry)
> +            else:
> +                dst_entry = (src_entry, src_entry)
> +
> +            msger.debug('Destination entry: %r', dst_entry)
> +            deploy_files.append(dst_entry)
> +
> +            install_task = []
> +            for deploy_entry in deploy_files:
> +                src, dst = deploy_entry
> +                if '*' in src:
> +                    # by default install files under their basename
> +                    entry_name_fn = os.path.basename
> +                    if dst != src:
> +                        # unless a target name was given, then treat name
> +                        # as a directory and append a basename
> +                        entry_name_fn = lambda name: \
> +                                        os.path.join(dst,
> +                                                     os.path.basename(name))
> +
> +                    srcs = glob(os.path.join(kernel_dir, src))
> +
> +                    msger.debug('Globbed sources: %s', ', '.join(srcs))
> +                    for entry in srcs:
> +                        src = os.path.relpath(entry, kernel_dir)
> +                        entry_dst_name = entry_name_fn(entry)
> +                        install_task.append((src, entry_dst_name))
> +                else:
> +                    install_task.append((src, dst))
> +
> +            for src_path, dst_path in install_task:
> +                install_cmd = "install -m 0644 -D %s %s" \
> +                              % (os.path.join(kernel_dir, src_path),
> +                                 os.path.join(part_rootfs_dir, dst_path))
> +                exec_cmd(install_cmd)
> +
>      @classmethod
>      def do_prepare_partition(cls, part, source_params, creator, cr_workdir,
>                               oe_builddir, deploy_dir, kernel_dir,
> @@ -100,6 +148,10 @@ class EfibootguardEFIPlugin(SourcePlugin):
>                                                 name)
>          exec_cmd(cp_to_deploy_cmd, True)
>  
> +        boot_files = get_bitbake_var("IMAGE_EFI_BOOT_FILES")
> +        if boot_files:
> +            cls._deploy_additional_boot_files(boot_files, kernel_dir, part_rootfs_dir)
> +
>          efi_part_image = "%s/%s.%s.img" % (cr_workdir, part.label, part.lineno)
>          part.prepare_rootfs_msdos(efi_part_image, cr_workdir, oe_builddir,
>                                    part_rootfs_dir, native_sysroot, None)

The upstream plugin also has support for IMAGE_EFI_BOOT_FILES_uuid-XXX
and IMAGE_EFI_BOOT_FILES_label-YYY, apparently to target specific
partitions. Left out intentionally here?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

