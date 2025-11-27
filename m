Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB85D10375
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 06:46:14 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.15])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12898.1764225965859856576
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Nov 2025 22:46:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UKFyIr4Y;
 spf=pass (domain: siemens.com, ip: 40.107.130.15, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqE8QI2XkJpDJT4uyy8FAiTqBkfBrAfRUKkVTYOgS8RPCrgAs4JecNsQvfeRwq2VE1ydn0mbq26G/xYbDYGOuNoXYolK2OaRibIjxOIzvXjG+0RVwA5t3K6rc4a8NZHH5iCNiF/i+pq4OhLlUzZcOihap1+XvtGXN2LULbROlzM52ETJHDsVvOEC1XnJiXtiFDb4Sf2xHC/ebLojX7MTZXJtSJR+a4Tz3jLeFZ9wKl+nF7ozMFJrRS0lcUDczWazy1TUTQmxWmHBHGVB1FdZEGXucYPJd3o1W2fSC1uLilEjBg8w4c7wITUBe1wCoHkaBbaST1SPhM7t1K7jcozHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBSec0uxiajnqzr8sqXHKpibmlToC9IwvB69WfMJwig=;
 b=ZooO83ZxuBU2cwXGH6Cy7i2CLSBZUP8S5Sal0SHu3/Sc4rr1ILZhLkWXBeqsCtBtK5iOUJ/TUq3pue3mwsjJtkA6KNQB/GWfOWZeh18modT7jXnNUpc3J5h/HKizqdGnAJhN2QrzAply3rRO+lGDHbEMI7LE9C2vHWKBTQQO2u930IGE22/1kXYSDAQ702tepNx4zaPh/AUmwaJdVS8xeyVM6g5+9AsFcBiY7cvZ08RMGeLEuYbipVWAkedeC6Xp12wnamSko93TXFntotFQY3caeHMFAaZEMcxA0pTOtqXCAIJ5nHDAPAQy1ZdzqHwTR8yFIFd1m5/SdCBgXoT4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBSec0uxiajnqzr8sqXHKpibmlToC9IwvB69WfMJwig=;
 b=UKFyIr4YMBXVtfUEILN1F7cHd75t96yhHMJ2BpSsRQ+YJOCCnxadkCweiJQAKIZGqMJtd9AAxB8xWVfErXteBy2XBF6y+HmcuisihMtB92Rd61xMRwkwbYtgu2xlWRPL+7lBRUXY/2sA4lnLRAye1kMaBgsTiz06pAvF6aP3t6DsB5DE4GmcCfnsOex8fNuyRxcHLjomi+H2HTfW0apNtPMMXaKTKseS6JmSOFlUf1q06+4d97vKdGmWNv5AsTi4TWn7WgVK1qVrlNnguN1Eny3VBu8nr3a6gEuAxkbmXDUxURTJucji+KcQ8z/t0pzcuPgby8WZtDiQyP/6Cwjy4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB5952.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 06:46:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 06:46:02 +0000
Message-ID: <278261b4-4c85-4960-8659-dbd594e7c449@siemens.com>
Date: Thu, 27 Nov 2025 07:46:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/2] ti-am62px-sk: Enable
 TEE_SUPPLICANT_IN_USERLAND
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 vigneshr@ti.com
References: <20251127063738.435868-1-s-adivi@ti.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251127063738.435868-1-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB5952:EE_
X-MS-Office365-Filtering-Correlation-Id: fccf8348-356f-4d5e-97f9-08de2d80a15d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eWRxQmlrUUFwQzNrdlJlb1BKbEZVWmFRY2dVQTNadWlZdjNYd3MxN0k0OVRa?=
 =?utf-8?B?aEQyYVVVT09uU0dUWUR0Zy9XTHFwa3BFN0c2QTZhRzYvVkZQQm45T2lsblht?=
 =?utf-8?B?cDJHaWJHaHhGSjRiS3I0Nzg5UW02MUVHNFZWTzFPY2JDaVZUUlhaV20zZE95?=
 =?utf-8?B?MjFTUHlGSXJpbVFZSndwZ21vb00wRHhsL1VBOXRPWkNIanVmblB1NnlOZmtj?=
 =?utf-8?B?eE9iOTVwTk1yU0k2UDNQODRDKzFwVFAwQllYaER3K1JQUzBDVXZ2cGo5WmVL?=
 =?utf-8?B?MnF5cWkrYlRBNFhZZitYcmh0KzhHRnBQV1Z2OE1mRUJTV2syb1lxektFejc3?=
 =?utf-8?B?cSswSFhwS2VZL2dmdEtLT0c5cXJuLzNXdG1iM1M3eFNGd0N3WE9rNzRmRkFH?=
 =?utf-8?B?NGFkTVRtdWVPSHkxSTMxc1Y2LzdQS3o4M0tGZXcwTkJ4blYyMmNVUkVRL2Qr?=
 =?utf-8?B?Y2pQQkwwdTBQd0ZWQ2lJRnQ5VEt4aDZpclRvVFFqM3l0c0krbHNHaFQ2QU1J?=
 =?utf-8?B?R2FDbFZQUzNGdzNTZGgybm91RVBmQTdSZmY2TUVkZUFyWkpGUWlXMGk4Ukhl?=
 =?utf-8?B?L2ttdVVzdm1RRS9VTnZSVlVKaHl5WmE0T0IzeUtTWWU0V3VHc3ROaU5mZGhh?=
 =?utf-8?B?NWRlOFJwYUhlQXdqUTZ5cFJ4NXYzU1FRL3MwdXFNeEpDTW43K3VDVGN5Mndz?=
 =?utf-8?B?Q3lxMXZWTEdnazdTRGd5SVZoWEdOcCtVZjNqUUE2WWZxNTVweHdqY0p5UXdk?=
 =?utf-8?B?bmc4MmJMRUZiYUNxaktLUXVvYm9IRlEyVUhFKzcyWkhpVDh3NksydGVlNjY1?=
 =?utf-8?B?UTNxS3dlWS9EY0trWjhUTStDRkRleW1IREcvYk14Y1RVZ3l0VnNsY1NxR2pY?=
 =?utf-8?B?N3dONHdYQXdsYWxPVTJyb2JNd0tYOUtwVi9BT0NwSXBDT0Y0L05tM25XbE11?=
 =?utf-8?B?Z2FrYUUzQmlZNDVXT3M3WWJIajlJUVIrUTI2d2FGQytEZFhKejRGZkhuTlVy?=
 =?utf-8?B?VzVwR2dENTRtUFJTN0hVMTFmUHRqMGl1NktJMjN3dW56MldHTElGOUh5eXQ5?=
 =?utf-8?B?RFUwSExQdk9xdzM0em9rdG5WWmhkK0NGVUVvUHVrK2xQR3RXb3RmVXBBVU41?=
 =?utf-8?B?dUJtcTNRSWhaRkVmb0c1dGFmZ25SWTZkdHVjaEduNC9xWDlTeWhyQU9yNnVP?=
 =?utf-8?B?U2dGZkhPRG8wQVRrR1NIZ0ZCaFZQSCtaZm9kUXBBN1ZXa3RrcVJYekxCckZN?=
 =?utf-8?B?ZDk3MmlZT2dkTXZNN00yR2IzNzBXNXFweENxaHFIUmREMFN2R1pWMDVmb0FE?=
 =?utf-8?B?SmF3bzVNOUZBWWZsWE5rYk9SM01xdi9jQW5sSmhLMXhGZytZR0NodTFIVVA4?=
 =?utf-8?B?bTBpZkE0NzdaSjNYc01ZRHhoRGZHdFhwNWM1eFhYYjlBdU8xV3VqSndMbTZo?=
 =?utf-8?B?aTVnb1dHL2J2THVRZlRpaTMrRmJHLzZ3MDhSbjJWU0MzcWJPbzkzN0NKL1gw?=
 =?utf-8?B?bnFIYzVOM0NLRDAydCttUVM3RVl0TTB2Rzc4am9MRXpvYjJxQlJNbmNLMHE5?=
 =?utf-8?B?NCszem9lYkJSSlJtKzFFQnR4QzJTcHRGR3FPbkp1aDhaSUN1RTF2RnVNV1N0?=
 =?utf-8?B?a1c4WUNxZmlxdWtjR0tMNm12UFNubGRXOFJLZ3FkNjY3OUlGdlVPVXBDSUxa?=
 =?utf-8?B?amhVWDJVdjMxY3RmNjgzZkw3LzdlZUtUcis2V1FGZ0luTkxpZldITGU3MUdX?=
 =?utf-8?B?WExEVjhPdjZCK1JYeWpmQWx1STVmNEFiWnU5UzA2Q1p6VmNsTUdPTU0zUzRk?=
 =?utf-8?B?eXlBbWkzWjFTYVJGVENUR2lQdnMzSlBDWUlzMFhoNXdHQVU3YVdjWFJwRXRW?=
 =?utf-8?B?THQyTG9YNGMyME1Pc3V5LzNZQlQyQWpySlBxckNsV3krUDBSbUlqR2Y0K2tz?=
 =?utf-8?Q?jbMy210xk2nkDpfLz1iTR86cHDmYp1to?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TFVnYlM1cVYxNUhnZ1Nkdzc5ZWlQay9WTW40bEI3ZHFvbTh6OCtwYS9XV01E?=
 =?utf-8?B?alJXTWM2VHJ2U2JGUkVSd2pwdVQycGhQb2Z2VGdITnZLeVNidXdNMjRkY20x?=
 =?utf-8?B?L3BLaVIySGJuWmhxTEc5RkdsZ0dTVkRGeElDQy91RG1sUTdnUVpJUE90TU5y?=
 =?utf-8?B?WVNlSmExTjUwdkFLRElnZ0dXVFFFK010SEg0aUtxUmlub1B1MGljL2EyR0xn?=
 =?utf-8?B?K3phTVZiN1lLYVE3VkpnZXN3NTJLQmh2SFlNRWg3aHR1S2hjN2tQVEVhN0d2?=
 =?utf-8?B?czRYOTQvRGVXZGNXZ0xxajUxQW5yVVE4a2pIUk5TNEJKZjZQTlNmVWI5aE9z?=
 =?utf-8?B?NFhxeVp6SHZzSitXQy9SR2Y0Ulp6N0tBamR2TVNWZmJqUFlVU0NLQUdWZ01n?=
 =?utf-8?B?K0Y3S2dwUENKVURhQ09QQzFxd2NlYTVBOHlCWXZXUUtNWTlXUC9FektEMTlZ?=
 =?utf-8?B?eTk1dnZiZU1WNmhMaDYydWtWRUxxTUNodFpDT0ZRVnNqcXQ5aGxqdkFoM25R?=
 =?utf-8?B?UCttOGxVOTUxaE11bFVCOFhnWU55dUZoL2Focmt0UjB1blNPUVY3TE1CR1pa?=
 =?utf-8?B?dk54TVh3YUtIQURvVUF6Q1VUdFZqNGhTVk5hY2kyUmQxSWpJcVY3V2dnZ0JP?=
 =?utf-8?B?L3dReWIwQ2hicjVPRlpDUVloSVYrUHloWHp3bWF4dXVlYTdpU3V1a25rME9j?=
 =?utf-8?B?T29vU1lDNkNWRTdwSUZaRHpoZjFJNURRdS8wOEJzSnI3WFRxQ1YvU3BrVm5X?=
 =?utf-8?B?TDB3eS9EdURFR09PUjVjK0poM1hOeG9ESytQNEVpUVlUOGorODh3bWlVMDBF?=
 =?utf-8?B?a1FXa011NDNEMFJYS2FBQzlxTlEyUnRZUndtZUVQeUZHeXBVZWJaNURIVmFY?=
 =?utf-8?B?ZTI5Z2tKZ1BCK21ZalU2WGxGV1liUUhHUWxnTEsxRW1lZEtldGljWEtCWEt4?=
 =?utf-8?B?WXVRNVhuM3Y4YmVMRmJWVDNIR01wK2RIanhKVDVkOEVoWWFBNmgyWmN3Vm52?=
 =?utf-8?B?TjVoT24vNVBWWXdMNU9JTk5yMWNKSllwTkNYekdxcjRnZFgwV2s3VTdPaG5i?=
 =?utf-8?B?ZEdsV216OEF0anArNDB6SytZeVFFa2wrNG92Y2JNeXh1NmJIYjQrZVRsNWRx?=
 =?utf-8?B?MkRBM09VT0ZHODRFUEw1cnN4NHQvLzJERk5Qak1qM2hJb2VOdEpaTm9KSFQ5?=
 =?utf-8?B?WjBpSkExQjVkYmVhVWJxYm03Q1huMDZWL1p4MGwzVG1PNnpoYk95Y1d0Ukg1?=
 =?utf-8?B?bU41dW12MXpjTXRpWEpFU0twSEc4L2g4cnlDNGoySTFuNXFtcTFxYmNSSXFX?=
 =?utf-8?B?NGNtSWFiakdCOHBxemh6ME81V1FoOXFCL0VsRUlFdlZSUHh0YW5IS1I1c1ZX?=
 =?utf-8?B?R3BMR2NFZDE2enl1cWVLd2ZieEtsK285ODVSZ3hxaGtqUk9vQWpGNjFZTVdu?=
 =?utf-8?B?VVhOZDRac3JqWFNCdW9RVmlOalJucWlPeTluNGErSGNRSkNFUXJxNXJ0R1Ba?=
 =?utf-8?B?K09sQW9TdFRGWHlQQ0grcmhzY04ydjJUYkUzTGw4Q0F0N1FMdTRYdHV6SkxU?=
 =?utf-8?B?RE1mNm81d2RoTFp5NmdsZ3phRlVlaUJkbDhOQ0wwRGNLbkRubmtiZUF0d0VF?=
 =?utf-8?B?YktaVHl2c0d0UDloU2xyN0prbkJGN3MxQlBjMTdtSlJ5MGtGRTZMYUNuV2JU?=
 =?utf-8?B?VEd3c2NsNkZSNHRGczRpQ0xiaTNuNVNHdVk1M21oc0FBKytsZk9CNHpXNkJx?=
 =?utf-8?B?eGVSa29wVHB2YURYd3VUSTZKOEhjcUEwcEZxUXdsWmYyQTQrKzJ1RTZjVVVM?=
 =?utf-8?B?ZWhVamx0cG8vazNQSUZMRDJVS0dSam5QajkrSmh5d3ZuSkFGWVI3czU0V3Nl?=
 =?utf-8?B?UFlvNTh4aTRSSjBPUnhpU2Q3b0xIbVNSbE83S0t2SUkvbk1BMzRBaUJLdDE1?=
 =?utf-8?B?cnNCUmFxSGcyWVQyWTQrdmhzZ0Ztb0cxQWJzakVvTDFUd0ZUQU5Uc3ZqUUVn?=
 =?utf-8?B?YmJFQUo4UURJZU9Za1JPMU5IbE5MbzJocWhpL3BLWDZMQ2tLVnVBL05FMng2?=
 =?utf-8?B?Zjh4Qyt1UzNHRFFWRnlXMG9xMW9wbHhIdERxS29OekFLa29WSDJnV2FmbS81?=
 =?utf-8?Q?KLVijb5muBkJFzWbEySGYaTH7?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fccf8348-356f-4d5e-97f9-08de2d80a15d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 06:46:02.0489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8goy+i6W1/CphOAROluE4eeKxUKq85rgjI/XV4Q/33YtbNDqxA56nINIRkzmWsfHUZEYKfUO/YIfH3vcalu8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5952
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Nov 2025 06:46:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20737

On 27.11.25 07:37, Sai Sree Kartheek Adivi wrote:
> TI AM62Px SK platform only supports 6.12 kernel and it does support
> fTPM. For initramfs-tee-ftpm-hook to actually install local-top scripts
> into the initramfs, need to set TEE_SUPPLICANT_IN_USERLAND.
> 

This is not correct. When all requires switches are on, the supplicant
for RPMB access is supposed to be provided by the kernel. This is also
how we run the qemu target. If the physical one has a problem here, we
need to debug the reason first. Userland supplicant is in phase-out.

Jan

> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  conf/machine/ti-am62px-sk.conf | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62px-sk.conf
> index beabac9..31fa93b 100644
> --- a/conf/machine/ti-am62px-sk.conf
> +++ b/conf/machine/ti-am62px-sk.conf
> @@ -24,4 +24,5 @@ IMAGE_BOOT_FILES = " \
>  
>  USE_CIP_KERNEL_CONFIG = "1"
>  
> +TEE_SUPPLICANT_IN_USERLAND = "1"
>  WDOG_TIMEOUT = "0"


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

