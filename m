Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798D4CE8E8F
	for <webhook@archiver.kernel.org>; Thu, 24 Oct 2024 15:49:18 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.42])
 by mx.groups.io with SMTP id smtpd.web11.17889.1729784950633969434
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Oct 2024 08:49:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CrtDnYC8;
 spf=pass (domain: siemens.com, ip: 40.107.103.42, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkzNtQza7x/pV1YhDeShKbU1iXUEhZwhReyAJ2wilM7rb6+5VB4oopxRAuLqrGCjZEjnSPg3vYz8msM/1BFKm9FyIXpFO8EjVhJHp6Y+ZlaUTulxsdGy0cRjOkyyIuLmasUudhkepVHxbqfeLqL4dCQKL74pOWH+1/cH9XYoU1Lm6aEZdVXr6Huj1vzzDql5r6tIRo0NfjfNOSFPjHILvWdeoReq9e8x3jx0cJeGFS/a/GjIEbaM6kR+XFXthjiot8KIA2gbi3o1Mop2dwTI1q6doW/Wj21qtxFX8lkw8303g2ur2VSpL55Tbk66Lgg6nrh9eIBTncrGGc+hPCCexQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8Yknr5WHzt0fe2a3WAM52S3XhELaeqc53ccOszPc5U=;
 b=LNHS6MBhsaHEwFGR+oGdBjo1868DsvwGagsQL3usz4Og8fX4tUVAEtP9dL6oDbtdqwAxXX3V/m6ZLc5PqEQ+tawoivWKk3Dl6EbCOqIuHGgjTMglV23MxIXDTfI3Bu6SJhymKgxhMhHAGOD5j6glb0o2d2UWApnt5AhI7aZmhOCcvMSQscVAxy6r7yEcVjYYHk/YLhW482P1PMEQ54v4beIe5lmq3e3QNaD2SOhdBGNx7UTcT9Aiu23pRfjJ2jBioQwP0iyIZbmnWt5m5xQsUcMZpWu+1L4F8g6A2Vo5twF11Nn/3zfvVVb4oxk9fMOpACSt9CExUsevNox8cRsneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8Yknr5WHzt0fe2a3WAM52S3XhELaeqc53ccOszPc5U=;
 b=CrtDnYC8sliil7c3ILm4bMkxihx6tUvkpncOOxWuiPX2ZgY4M78DHIRfKEFfT3Fpctd5wC1KQls6n64xBeS5XugxpeJOiL1nFO8qSXN/X5ktj9QrHHmDHTNbkAyZrOfGYPwCpMkwEZOVIO/t7hhI9DNrbje+4+wvEqYQAABTGAzMd8w1wmwaS6dwZVG4h1K25JicBR2yw0GnvXFbkXO2vzI/ey6BabBrV0yPPWrh5/pf1mYYiyMMq+wHc6dUmPozpP7BT9bIfULbNzcPH0iN8y8swTStjbyXsY8M4e+EaJ8w0V+Hk7Gv6RHA3LbZ7RNbpx9l0kmU2rNVm16anecZ0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS4PR10MB5648.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Thu, 24 Oct
 2024 15:49:06 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8114.006; Thu, 24 Oct 2024
 15:49:06 +0000
Message-ID: <d4932ec9-d4c3-4be4-acac-b3957b710627@siemens.com>
Date: Thu, 24 Oct 2024 17:49:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/2] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled. (for bookworm)
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com
References: <20241021185359.927395-1-alexander.heinisch@siemens.com>
 <20241021185359.927395-2-alexander.heinisch@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <20241021185359.927395-2-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::16) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS4PR10MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 180d9561-391a-485b-8daf-08dcf4436464
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZDVCejNYRFRUa2k3U05GMXVHTkRETy9TTUVwVU5leVMxK05ONitOdWcxdmVp?=
 =?utf-8?B?U0VpTHVpOFFnZlpjMW9tNmNBcENEMjljaHY5aVlQR1RFMEE4bU5RK3lyMytv?=
 =?utf-8?B?eFV2UnVVbUczMDdITWsrd0xWWWJ3TUpWK2FNNVlETm5ZY01WQ000cUxWRTkz?=
 =?utf-8?B?OVp5cUk4THV3QkFUMDdnNnkzM010LzRwdThSODhMWW1lOGpmQ3p4K25aV0Nm?=
 =?utf-8?B?TWc4QTNiRkp0TlA2YjRsUWpCakVaTytDcG45c2Y2S0N2WXIrRFdOQ0ZrTlA4?=
 =?utf-8?B?Ym1iNENGYVFSQ3lnbkVsWld5SDdWZXZyMC9UTnBBNzZCREd3VENkTkpQOS9P?=
 =?utf-8?B?RGduUFo4Z0JiVHl0enNudE1ITnBwZS9QZElmcVlSbm9wZERvS1hBVWVsSHVR?=
 =?utf-8?B?ZXpsQ0RJSmZ2UG1FSWpBektLdHgwdkloZHIxM1Q1TkpNcWlGZmRiSEVteWVt?=
 =?utf-8?B?eU1zT2hhV3JUR204M3Z1elJzL29KTzkycTcrQWJ1OXJMYVRFMzllZlVhUVZP?=
 =?utf-8?B?Tzg3N2VRS0pVaWhaalFocThQQ3E5MktibmtiTTZTMFhCazM1THJQUGZmOElX?=
 =?utf-8?B?b1FHQy9IWXZvd21ZNTZvNkZEVEFJUzF0amszR3RMVlVhUmpIaTJ4Ukt1WFBh?=
 =?utf-8?B?UDh6ZElVU2FNY3VVR1VPdWYzUGZUemxoL3VhTFNNd1BEd0M2b2RGRGgrdUNz?=
 =?utf-8?B?N1BLN280bVJxd21PTm1oU0srVVVGZ0lEbTJRdDdxQVNjQ0c3TllzdFAwb1A2?=
 =?utf-8?B?SUdRS0pQK3FLd3Qzdy9UNGJuUmI4UldlZ2UvRjlMcklxYlhpMGozVzZ1cTFJ?=
 =?utf-8?B?VElxVVZqZHdNYXVkUFRPaFNhQzBCd0FCVzYrb2EwcldFM0Q1RUlhTFViY1NS?=
 =?utf-8?B?K3VlRWs2eERKakNPNmFxN3ZVT0IrRThMcHUzYTMxVXFDSnJmYTZ4V1VHQmc2?=
 =?utf-8?B?VUh0VGIyNkxadU9NeTBORVJMRkVtMlpueUN2U2hmeTM0ZjVKb3M0SkdtTjZz?=
 =?utf-8?B?Tm05bWw1cXNEcVlwZ25BL0tZTDg3QlBMTExRa0c3bVM5bnFpY0V4QlJyQkNj?=
 =?utf-8?B?eXFEd0lmRkkybVNDV2xVaXZQUXpxU213NFlPNnk4ajJ1bTJSZWVwZEt2b05a?=
 =?utf-8?B?cldDaFZyZTk5SHJpMTFtT1pPS1ROdm5wTHhUYnNyTks3aGVYRC8ySklqZG9F?=
 =?utf-8?B?a3dvWTNmVnBFSDVpdkNxZnUwM3RrRmE3N2ZtUkljU1dVOEVhNXN3SUt3WnJ1?=
 =?utf-8?B?eHVJY2hsRHNJcHU0NXJsRHZ1eWo0VjluQnZSK0tRNGlDaGd3cWpvT05GM1N4?=
 =?utf-8?B?d3IwMXhkOGYzSHQzV2U1N0dFVTVFeXlNalQ3WVZISERhNFN2SmpOK2Vocmhu?=
 =?utf-8?B?anlsQXJEMytUOVJ0NUZkNUhIbUw4YzlvVUQ3VHhFZ1EwczFCZ002RFFmeGRV?=
 =?utf-8?B?bWJJRWpQUll2a2pCMFBrbTl0a2hHUjV0cXlXNm91WHkzVzRrUFcxa1BSYkdL?=
 =?utf-8?B?Uyt3SUVhZ0loK3hTcktFZEhSRHJqbDgrdHZ3K1l2Zk1vL0hESHBVVXdIQWNW?=
 =?utf-8?B?SU95WkZTNVpJaUM5N2sxQ3J3M1ZaQ3JVVFkzdmFPdGg2U2x4VnVNd084K3Av?=
 =?utf-8?B?QkkxamNYbCtzd1JvU0wzeDBxR2I4S1BuSmcxN3RCV25ZWm40VlRveTdnWG1z?=
 =?utf-8?B?UlV6MlNUaWlVVDRPSnVLSFZzazBzUlhnbExEWWZFamdYSHdTN1FZek9BPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d1hyMEtHSHZLS0FDbEp4TDhJMlZocEhGMVpBTmpiZ1ppSUVZV2FjY3gyNEJB?=
 =?utf-8?B?dmZZYVBLaDdjcVFKSEVjY3U3dERvdXdCeUZ4M3IwMlhlSk9WbHdmL1lTc1Qx?=
 =?utf-8?B?a0l5cGdwc3QyLy91MVR1eXlZc05IRUxONlh2ejE3S1QvZGZpcGVoaFdBVU5r?=
 =?utf-8?B?aWtWMk5lZUtFV0xWYUJnZDE3YXVTS3J2MGVhM2ZEZTV4ajJ0SHAyZDFDNG5J?=
 =?utf-8?B?L05YWUZtckVBNGxoQVl4V2pWWFNTNnRVNUg1Um5rNll6ekMxK3dHTWgzOWl3?=
 =?utf-8?B?U2xOMHhHUHRTV2dkUVN4YnFDb0pZN21EWkN0bmEvTEJTb3R1RS93SUNheXVz?=
 =?utf-8?B?a2FvV2xwcUFPTWpnMFNnaTNERFYrNGZvK1crZFJWbXFYTGdKanJadTJOK2Jw?=
 =?utf-8?B?c2tHTnQ1OTVOWUY0SGtTN2FpUnBzQzBleDBqRG1mcEZPNTdWY2JvVXlBdkZE?=
 =?utf-8?B?RllmYnVOT2RzODR5clJJSHRNbGtSeFBzQzZhUWRseFVrRDE5NFlGUmEzK29s?=
 =?utf-8?B?SC9WeERhV0pPWlhjaUp5ZzdsVTRFaEg5L3NoS3Avak1RSGRiZ2NYVjg1M09L?=
 =?utf-8?B?RllOM0NzMGJqRlNLQU9WejZmbXRjc2tFQkMxQUZuZlVTSzdCTFdNNm91WVZo?=
 =?utf-8?B?N2Qxd2hjNElLWi8wNFRHcTZmRVY0LzE4VVlmRDc1UWI3M0t2aVZaSWhXVjVx?=
 =?utf-8?B?S0p5dVdyM2JaKzJsaEl5aGhoVHZTcEJqQkhjS09Hb09oMjB2aUpZdXRPK200?=
 =?utf-8?B?RzUrMHZTcy96NlFSemxicFVtVW5IaFVzOGE1QXpHUmNwQUptTTUrWUhNZnB6?=
 =?utf-8?B?eUNhMmYyVFhZdm1hdTduMTExcitEcmhza2lYQmFaUExoNHBqRFBTSm5DS3lV?=
 =?utf-8?B?aTF5cXp5MFRmelhZKzFuN0hhVU5IUUtBUUlXUG9BVmFlMHljUG54WER1QUJm?=
 =?utf-8?B?aVozTG51YVAvMmR5eWVtbGNhRTF4ZzI0Ylc0NWxnSi96MUJ3Q3JEVUxsRDkw?=
 =?utf-8?B?NjE0WTJEY01Lc3VwUEp2ejhQTGRLL1RycnZPVW1yYmhISGFJVU5mZkpJTEJl?=
 =?utf-8?B?ejl4L3YyeU5hNGI0MWNyMklIajBsOXJoeHZkUlZ6eFZCUW9oaitnQUNJeEgv?=
 =?utf-8?B?MUxpYmZtcGc3OEs4cFJOZkZDQUNOcC9aVlNoT3lZN1pZNDUraUdoK1pFdmda?=
 =?utf-8?B?aUlVOERFZytZVmRWaVlIaVJaSGJtVnVpMVREc3ZTdTZMTVJsWElHS2tTditP?=
 =?utf-8?B?Yk40YVlFWktpZjhlZHhuWnR0ZFdKb0l0N0hEdndVTDJvNjE1RUhsQWxSSzNP?=
 =?utf-8?B?N3MzVGptbTBPd0hwNHU2MGxIMURaMm1PN3lWR01vRjk4QUYvWS94K0ZIZjYv?=
 =?utf-8?B?UzQwN0xZdTZJZ2pmMHhoZjZObWtva3VKdy9QVTBEWnpEampTMkdhK0tlclF3?=
 =?utf-8?B?aCtobnRGOTFWaVdSQk5GekZUR0hnb0JIYWVTN0VrSGxkcG5YdFRQTjI0ZDJ6?=
 =?utf-8?B?S2VmOWVtSFZDaGlKaXU2ODhzakFoeDA5T2ZmM3M2UXpzcVBQdkRPVDZPeldN?=
 =?utf-8?B?NWpreEh0Zzc2T25XakJPYVVsc1d0ZGsrNjZqT3BvZUNFRzhZUytpYnU3T0Fl?=
 =?utf-8?B?aG15ODFRTDlteHR0eUhBNnpYd0RjNDZPYW15WUxCVTBxc0lhQXVCTW52d3Zk?=
 =?utf-8?B?V1ovNk5nV1VCK2xCenViUS9iZzd2VGs1L3Z4WlNra3RtVmozaWNJTWo5L0Iy?=
 =?utf-8?B?T1lCbmJhWmRaMXozR2t6NXcyazg0dkRBb1hwQnpZV3duQVBhdUJkQzhrdGly?=
 =?utf-8?B?M0VzZ2Nvb2tIbVBvd3c4c0ZkZitHN3VxUmVqaURqRGRxK0I2bGN0MUdjL3gz?=
 =?utf-8?B?bEx1MmxXVkI5dWtmamxtRjlFd3pvY1djREExRlcxQXJ2WHU5MnVwQTJMVHFa?=
 =?utf-8?B?U3FRcVBJdHFoMVJxam45dFI5K21WOEFzRno5Q2l2S2hCb0RMLzR4UmdUbHhX?=
 =?utf-8?B?bTVOcFFMUHIyRVJSUGlzaFlqY2wrR1hqdzZna0RFZW1FZnZhSUc5S0E1NnMx?=
 =?utf-8?B?eitkTHE5ajFrUWxCVTZ3SE93L2VjUU1GWDNsMDg0NUFjRnlUVVhSWEY5U1hv?=
 =?utf-8?B?Qjl4ZE45MWJ2WTMzdkxpQ0JOa0dMVVl5WTIvSjRYRGFiM0NXcGhubDFVZDJ5?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180d9561-391a-485b-8daf-08dcf4436464
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 15:49:06.5751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzpmoRmL+RZB1/iS2qaNuQbyiTEE7a/HtVbbAT12I3B7r+I51H7x/Kbp7qOUdDD86j6gZBTqHceeEp8hx9TUWD5GvM6/BAsZTTsYZzJH6HQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5648
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Oct 2024 15:49:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17079



On 10/21/24 8:53 PM, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> To fix dependencies of packages (in this specific case expand-on-first-boot in upstream isar)
> we specified additional package dependencies used for disk encryption.
> When building with disk encryption enabled (kas/opt/encrypt-*.yml) the initramfs encrypts
> the specified disks if it detects unencrypted disks.
> In case of a fresh installation this happens during first boot of the device.
> Unfortunately, expand-on-first-boot (kas/opt/expand-on-first-boot.yml) is executed
> after the initramfs already encrypted the data partition (in case of *-efibootguard-*.wks.in /var).
> 
> Checking if the disk to expand is encrypted got already handled by
> https://github.com/ilbers/isar/commit/c44c088cd224e44a401410c860bd625f28950ac3
> but dependencies are not automatically set for the package.
> Since expand-on-first-boot is hosted in isar and disk encryption features are enabled with
> encrypt-partitions override in isar-cip-core, we extended the recipe in isar
> (see: https://github.com/ilbers/isar/commit/8b30a4f86cb3ea3369bff3884141872c3a7d9979) to
> enable downstream to set additional dependencies accordingly.
> 
> While the dependency for cryptsetup is obvious, the other dependencies are not!
> Here is why:
> 
> - bookworm (systemd as cryptbackend):
> 
>    From cryptsetup 2.4.0 release notes:
>    "
>      Cryptsetup 2.4 adds the possibility to implement token handlers
>      in external libraries (possibly provided by other projects).
>      ...
>      As of cryptsetup 2.4.0 release systemd project already merged upstream
>      native cryptsetup token handler for its systemd-tpm2 LUKS2 token
>      released originally in systemd-v248. The token can be created using
>      systemd-cryptenroll utility and devices may be manipulated either by
>      systemd-cryptsetup cli or by cryptsetup for actions listed above.
>    "
>    ("actions above" include `resize` - see https://gitlab.com/cryptsetup/cryptsetup/-/blob/main/docs/v2.4.0-ReleaseNotes)
>    Proof: https://gitlab.com/cryptsetup/cryptsetup/-/blob/main/lib/luks2/luks2_token.c#L170
> 
>    For the disk encryption method we use a token `systemd-tpm2` is added to the luks header.
>    Thus, `cryptsetup resize` uses libcryptsetup-token-systemd-tpm2.so to handle this token
>    which comes with package `systemd`.
> 
>    Following source gives the dependencies on libs: https://github.com/systemd/systemd/blob/a3f17a8f88f7332d0bef67a2d523c41f23f164b6/src/shared/tpm2-util.c#L114
>    libtss2-esys.so.0 -> in package libtss2-esys-3.0.2-0
>    libtss2-rc.so.0 -> in package libtss2-rc0
>    libtss2-mu.so.0 -> in package libtss2-mu0
> 
> - bullseye, buster (clevis as cryptbackend)
>    Since we are using clevis as cryptbackend the luks header resolves to "clevis" instead of "systemd-tpm2"
>    Thus, cryptsetup resolves the library to be used to libcryptsetup-token-clevis.
> 
>    Unfortunately, I could not find such library anywhere! - Therefore, expand on first boot and similar,
>    still won't work for current disk encryption implementations for buster and bullseye.

There is no clevis library as clevis is more or less a bunch of shell 
scripts. If you want use expand-on-first boot with clevis a solution 
would be to extract the passphrase, see [1],  from the tpm2 partition 
enter it via a environment variable.

[1]: 
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/doc/README.tpm2.encryption.md?ref_type=heads#steps-to-convert-clevis-to-systemd

Quirin
> 
> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
> ---
>   conf/distro/cip-core-common.inc | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
> index 4bd4b84..7006713 100644
> --- a/conf/distro/cip-core-common.inc
> +++ b/conf/distro/cip-core-common.inc
> @@ -23,3 +23,16 @@ PREFERRED_VERSION_linux-cip-kbuildtarget ?= "${PREFERRED_VERSION_linux-cip}"
>   
>   PREFERRED_VERSION_linux-cip-rt-native ?= "${PREFERRED_VERSION_linux-cip-rt}"
>   PREFERRED_VERSION_linux-cip-rt-kbuildtarget ?= "${PREFERRED_VERSION_linux-cip-rt}"
> +
> +ADDITIONAL_DISK_ENCRYPTION_PACKAGES ?= ""
> +ADDITIONAL_DISK_ENCRYPTION_PACKAGES:encrypt-partitions ?= "\
> +    cryptsetup, \
> +    libtss2-esys-3.0.2-0, \
> +    libtss2-rc0, \
> +    libtss2-mu0 \
> +    "
> +
> +ADDITIONAL_DISK_ENCRYPTION_PACKAGES:encrypt-partitions:buster ?= "\
> +    cryptsetup, \
> +    libtss2-esys0 \
> +    "


