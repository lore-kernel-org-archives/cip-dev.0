Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0B9C282D2
	for <webhook@archiver.kernel.org>; Tue,  4 Mar 2025 05:12:41 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.1])
 by mx.groups.io with SMTP id smtpd.web10.15571.1741065154835466927
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Mar 2025 21:12:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lDWNQerR;
 spf=pass (domain: siemens.com, ip: 40.107.159.1, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhbtfMM2tLdoN7oTIM3tyfO0xNjn1FUoS90eU6en7VwhOKpJYHOH5sX2eHq3k6geUscuAdmGa4NrkfC85fHs0t9LMrXaaz4sxJ8X/jYXG6AORmcKjcA+rRfpC1EXVnZOZ3NSCyrsg9SRUNSGkLzVNDC2dbj46D36O7J+OpDqAg9CD/5qFjb9kKUE3VsLG1nprppO5lDboVRj16Kz8V6zDXQYxevN0vmCmH+4lUtmwc146B4v2AEvXpmsblXdspckeGCAFRSkgNxtaJuGwGnCi7DLZElx9YqPM66wFTXmW7U+RBL5ced0l99rHCMkO9lD6veqRI25MkzkKaze4ON57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WNuoTE5M2k4F1TntFxAuVIh7QYwfgMazULEWDY5vEw=;
 b=ZC5OnWZpovLY4uzpflwzt7RzsW2IKdwS7HQpAmHe9We0+TPEcjwfS+YBLP9tIpoP8MD7RK1ziHqGQlVo+ZCxYq5PU0Psh3Ea+5K4Z0qKSY6wnxvw2fvB2v1vY0vdQv0vMr7q8y/S+/Pw3HsAyM8KkgzNKRZFG7HFcwc3Ghb5lgV5fS0frF9Z4TmPyHXMdKvHSIpN9a9Sqq4M0BI3mdq45MOClhPoM1muS7I7n6VYC1+em2+XzEVNixSqvwtnTgQUE9yPRH/hWnyHIEyQIc4T77YvVoF4TfTJ/6NgTbQnqw+Kn6+DB3KBx88qPECQshIRt84dTwNRSi2Ku0hYM8UGDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WNuoTE5M2k4F1TntFxAuVIh7QYwfgMazULEWDY5vEw=;
 b=lDWNQerRGaMPbScQ/KlPxZ2GsVmFNBcz6GgJP6N5nU5vuW9jTbRzht3x6JFCm6O6Eeog04UiMUU8qqs3pxbcScz4+VEl0l0lVKVG60hQaIsRv9COTp9AU/CK/e+CgnPN5zxW8FXoxMVN/rhDJdwCEV2pSSRFIziHZMBDmYuf+/BF3EXbjB+MVgyyxX4w6I5TVoWZqa5w7R6y+eeOGrrNGiEpGApIKo0WZvYMgV28bsgZ/KFimSYuz6nPnH3zuNzO/TyC4z5SlbftawJ4KvxZf0RwnAllmqjzc2HURWRHVixiB2V0sQ3okA+7DbNKSgrY2NBmmhmsbS9dFD0FSKsp3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8560.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:560::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 05:12:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 05:12:31 +0000
Message-ID: <72477b31-8168-414d-8e2c-509cb1bec49b@siemens.com>
Date: Tue, 4 Mar 2025 06:12:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 0/2] Test reproducibility of wic images
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250226083239.601295-1-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250226083239.601295-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f00bd6-af1f-4138-615d-08dd5adb2a3c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VXNWY1hReVpHZ3VmZWU0UkpPL1B4K0VXd2tlbWtmcXYyYzcrYzY4b2kyY2N6?=
 =?utf-8?B?ZjB6U0MxSlg2Y2RDaElGTmpnY2pBUm9KV0ErbVpuMS9EdVJpdm5PMUZZd0hh?=
 =?utf-8?B?OEYyVVgxT01nUE04ajFIMlh3dDRrZjRxcHJrVHlZeGNlZlJyOVVVajJmMitQ?=
 =?utf-8?B?a254YTVNY0hOQlFYZzd3K0JKajc3OEVvREtWN1pOWDNYQWdtQXVkNnFnNEFh?=
 =?utf-8?B?QU5sTUhCVlNBZkdiSUZaMUhkT2hncVZWSVhiOTQ4aGYvL0NsS3grOW1IYWlT?=
 =?utf-8?B?S056OWtuMVVGWTk0d09HeVB4UGhNU3dLWnpDN2Uwdk1qeGNnS1ZmVXhkc1RG?=
 =?utf-8?B?Q3ZiN0tmelhnK3Y3MnZsZ29ocXVOaWIrRDFiRkR4a2RPSVI4aEpXbzBsY3hZ?=
 =?utf-8?B?OFhmVmFMMUhFT0U3NTNoQU0xYWJXWXRUOVp2Ums2R0VjejczeEUrOWMrZml6?=
 =?utf-8?B?dDYvcklPNEdZb2dqcmxGV2kraC9pR3FyYk1iQXpDYndRZEEyMkhIOTUvOFNy?=
 =?utf-8?B?RzJyVDBvRllTbVgzNFZmUUwxbHN2YTl5RkIrWEMzYXdMU2wySC9xRXVFN3pn?=
 =?utf-8?B?U0hZSThZNlZzcTB3bUUvc05nY2RTNDV5aEJQK3I5L1B1a0MrempDK0VpWWp4?=
 =?utf-8?B?V3F1c2tra3ViZHJKbjlUMW9NZUhjQW52ZG1UTVBrSWErRWlVQ1FHeWNtRE1Z?=
 =?utf-8?B?YkJielMzRW1Gekx6anM3UjRVVzVrMmJNZG1zRUhKNitOL1h4U05hMEdEMmVB?=
 =?utf-8?B?aU1LbHpSNTdGWTRuZjhSOHcvdS9MTUZaK3p3Wlg2QkhBYmo0OXArbXpJTThH?=
 =?utf-8?B?d2FYbW5LUjF2ZmpUclNnRGVINmhoL216cHFoR2t0YmJyK2NXS0VNQ2E4QW9x?=
 =?utf-8?B?SzVEMVJSSHlHc3lqMTU2ZTJaMU40TTdaYlVsbnRIK3Z2c09oMjUwVEVLdSs2?=
 =?utf-8?B?QUtUZzJNcmdMUUFNSmZ1R3d0TDg2c2V2TGJtQWJSV1B3alRKNWRoV3dRQm1q?=
 =?utf-8?B?MjNUcCtiV2xHMk9WenJCZHZyejVXTkVsVllENzV1MUNsNHR3VURMeWNoTVYw?=
 =?utf-8?B?cTk2OXdVcEJ4VStGK1JseGNtMk0zYTBOTzk2ZVNPK25PWEZDQmZBYzZJQ0Nx?=
 =?utf-8?B?UkltRkd0ZDV3RDVENTloMjZ5S09PY0Qrc25oVmhQRWRLeWdsY2dLUjJNYWVE?=
 =?utf-8?B?dWZNOWNOWkJzeXNuTE9rWXhWOXUzNWdQdjUwYjYzMFpqNmpIVlFRVjNvSmVy?=
 =?utf-8?B?VmVaU3BxWDZVMWxpek0xQ2dpWWNyUDF3N3pwY1VWR3ZsU2VvVnZIUWgyblNF?=
 =?utf-8?B?U1RPbHRWb2tRUUlNcTdJQXFmYzdJT3UxZHY5SzQyODlDSlJKK2wzZlg2RnJz?=
 =?utf-8?B?dll3OXFEcVhTY3JzTktLSkNhVm1sSTZaa2U4dmtPUUZ4anRLUnpOMTEwVWY2?=
 =?utf-8?B?U3RFY25YcVFTRm4wMHZSb09jbHVSQ2IybzQ3eEdnMS9EZzgrWUpSQXZHaWxD?=
 =?utf-8?B?bVY1aVlNQ1FVTzZGUWtQY3dCY0JNNC9BZUdzZmdiM2p2UGFLT3Rqa2ZpaWND?=
 =?utf-8?B?VkVURkZNRkdzVHVSTDJuOGdiVXQwR25xbmRraDdTdW04czNPQTBqS1UyZUF0?=
 =?utf-8?B?bkVhaU1mOS9iRUdmNlJRWUU2YnN0emhWbEt0VjZtZ3c0MURXSnpweS9TZmtN?=
 =?utf-8?B?ZXVaZnpxM3ExNlJmQkJwY2pEZ3VqYXdObCtnUEkrVG8xWVNCNUZHMVF5T0Rj?=
 =?utf-8?B?TWZETCtNZWowNDBaRWhGL0hKK0ZzOERvMlZGcUVQdysyVlo5Y0J4ZTFHNjF0?=
 =?utf-8?B?cXcwOS9Bd0pwVDVUTmt1dWYrampMdGgxMzIzT0Q3bUl0dHhtV2ZGclh6UmVF?=
 =?utf-8?Q?eUUYDmStRIQrH?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c01YeXRXNlB0cW5IbHArUWk1bTdvZ2N3UGhLRDhhN3NuanBwZk5hdHJIM0dm?=
 =?utf-8?B?L1drZ0xiOWxUSGFKcXZUbUNtQWtVQVdTSFdjVndoZWI1REhBL1hMRm4wR3FP?=
 =?utf-8?B?ZmxXUE9vUk9kU0VNR0htSXdjSWh0N3NsYlFzdk1IQnhoL3kyK1l2V3VNcWsy?=
 =?utf-8?B?TUtHcis5MDU1K3NvNGRQTno5SVdZSjNCZGM1OU5mTHZtR0hndlRKTUFaMG52?=
 =?utf-8?B?OHBiWHN4Z1BOZlFLRXF5c3oycHRCUk5wbG9XVnZtR2VnSDYwd0JYRXdxSFp2?=
 =?utf-8?B?SUttcEsycWpmcGZtZ3VHVk9kSlNmWktHSzVRNVpZZEVtWjRoMnlWWnJXVUdQ?=
 =?utf-8?B?WTFjY3dvbkhPS3VxdngycmQxTzB4Q2dJWjhBRnFKekxFR1N2S1Q3N3A0N3dP?=
 =?utf-8?B?UXhWMXB2eFYrTXhvM09PU00wNGVvYS9LT2F5NjFpby9oN1FPMWM4Y2tOTU9u?=
 =?utf-8?B?QnB3ZjdUczJPWnVuZHFkMlZEZjZsVlpNY3p2Yk9xR2MxWTZ2eXlHTVNVanlu?=
 =?utf-8?B?amNzTnU1ZjkrNDhoeG9YT2JxN0NacEJJSC9yMTVVaWZ4THNsZmVheENhcGVZ?=
 =?utf-8?B?Zk5tZDg1Y1pIZzRQMlZkWERaVVlmR2lYWGxnMFlSUmoyWG9HM3d1cEpYYVM3?=
 =?utf-8?B?YXkzYTVjbHNEbU9JM3BNRVRtSEs1ZHpYV3Y1dFhxektpOVRDMEpyMWtQRHNG?=
 =?utf-8?B?YlNvUnd4cWlXWkxjdS95Z3hWVXVtSGRqSmRkTGFNeEZ3empPYjRIa3RaZXlp?=
 =?utf-8?B?SjZNRjRzd1VFc1FhTVpqdXhMQ1NDUW8vSG1PQVVJU000bGQvVWVZekR5NVp5?=
 =?utf-8?B?QXdub0hyUGFQRWhIVE1ISS9Hc2NPb2pqb05QUXE0NzVMb2VKREF0VDNZc2pS?=
 =?utf-8?B?Zk9zUnIzeWlNOVloelQxbDNTcVhEbzlvWUZGM2ZmcWppSng5OU15UnB4TDVM?=
 =?utf-8?B?MXM3Nk5xV3NmRUFNaHgrVGdiSVFqajNHcVR2ampzWlZNVFltdFh3aFR1Z0Rv?=
 =?utf-8?B?bE1UOGhua0Z3Z0xyYVpmdG4wQVFzZlNFTDZkSm8rTDJlRUErRlIweWJhN25O?=
 =?utf-8?B?R2t6eERPN0pJT1k2MG1zc3lnSytYOTJFeDM1MFhXSXFiYWcwSUQ5NnMvZWpY?=
 =?utf-8?B?aTVKMHNrblo2SzRpWlpCN090TGphdGIrMnV0YlVvTjVDNlBnQWxZTEwwcjJK?=
 =?utf-8?B?NUFKT3BuVDFPb0xYeUYvaHZHODZNczBzREZ4V1hkenFpT1drQ3FmbGNDVVRs?=
 =?utf-8?B?dFMxSnQ5S2k1WHdXYjFPN2VpRGwyOUtiMlRFMzZvVzNTT2poOTZEbmVGb3M4?=
 =?utf-8?B?Zy9EbXVFd0ZlYVFmOHVDbjlZUUNWWVA4MVoyc0QySVdaOVgzQVlwSVRVWlc2?=
 =?utf-8?B?S21TU2NpRzdYY1VzNjVuYVJDdUplVXNwd1ErZVQxR0VSck1rODhWRmp1Wng0?=
 =?utf-8?B?U3FEd1I2a0h5WHZtSkFvTkYyaEhFUVA2c09xN0MxVTZzMDkzTUo5V3V4a2dQ?=
 =?utf-8?B?Y3ZleDNrdGFkOUtWd0V1WFR6aXRuY2FSYWwwQ2ozZ2gyY2NDM3F4dlhVR01X?=
 =?utf-8?B?RldTM2dPeTY2elF0bEJYSmZGSDhocmFMTitsZHVRVXB2YWhQWkp5OGNpbWky?=
 =?utf-8?B?N082NVRSai8yczFmMG91NnFCYWNYTTJqYWR5UHVUN2RMT1k2Qmx2R3RxSDYy?=
 =?utf-8?B?eDBHMTFpRVUzMjVPb1hrYXRVUmxqUGxjaVZBWjBIakZWaTVaMTRoNFJEQ1l1?=
 =?utf-8?B?M3ZyNHhpUmdDU0ZvTmtwN2dwUWNvRzFiSW1YRkVVMkMwdkJyOTlWaGoyMi8v?=
 =?utf-8?B?TG01bHNNZG5ITTRXWjJ4dWlOaGpsU3R4OGc1ZTdxVWhtS1RsV1R6VXdReFdE?=
 =?utf-8?B?VFN6SWxLK0NIcEI2OTZVSzhacnN3L0UwbW1Ha1RCV3RsRmx0c3JUQ2RLdWM4?=
 =?utf-8?B?VExJMDArZUtIRXVMK0IvcmVkODg0Mzg4d2JRNHVxdlZ3TGE5SW1kT3JHOGd1?=
 =?utf-8?B?UjdSaWxUUUZpR29uNDhTLytoNytueGhscXZlSzF0eU1MYUJ6TVFwTFVMSEVG?=
 =?utf-8?B?alJTWnE4Z05CUnE3dmVoeVZsU0RoODhQM3NMSE4vVkN1ckNuc3pOMVBBSFFS?=
 =?utf-8?Q?+24XHoSea3P8KHbuYJuJiURQp?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f00bd6-af1f-4138-615d-08dd5adb2a3c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 05:12:31.0787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwTOoy7k96PvVuT0tmdnLfZ6HpnjNRA5j7X8+A30PFiMy8F8aAJhYJKnfkM+1FiqUkfNchvLWTFFuxbbi84MNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8560
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Mar 2025 05:12:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18005

On 26.02.25 09:32, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> Currently only the individual partition images are checked in the
> reproducibility test. This patch set tests reproducibility of entire
> disk image too.
> 
> Changes since v1:
> - Addressed shellcheck warnings apart from the one mentioned below
> 
> In scripts/repro-tests.sh line 63:
> set -- $remaining_vars
>        ^-------------^ SC2086 (info): Double quote to prevent globbing and word splitting.
> 
> Since word splitting is what I want in the scenario, I suppressed the
> warning in the script
> 
> Adithya Balakumar (2):
>   .reproducible-check-ci.yml: Upload wic files for reproducibility test
>   scripts/repro-tests.sh: Update script to check wic file
>     reproducibility
> 
>  .reproducible-check-ci.yml | 10 ++++-
>  scripts/repro-tests.sh     | 92 +++++++++++++++++++++++++-------------
>  2 files changed, 69 insertions(+), 33 deletions(-)
> 

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

