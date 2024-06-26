Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F47C27C4F
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 13:55:01 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.40])
 by mx.groups.io with SMTP id smtpd.web11.27370.1719410096706044308
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jun 2024 06:54:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=q6R88Gwj;
 spf=pass (domain: siemens.com, ip: 40.107.105.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJhOxZp3ebOjvUwlJac6lN1T/LG6/8y5JiP4rHeAdMrj4sottq9WdKWdhwgjkQG6O58DbfUbNSo4S9pIAO0WjZ4573cuKprYXadoFCta0MsC3Ch1cHPqmDQCsCLj3JF1sibRPIB6G9vTgRK7tYD2zrMxTlqKTbvr+UK+plhOkCccJ35nlWsxzPWw7IpErDJxfgAZTHZg5Jmd6oAaDK2h9bQTdYpSTcJbuOcrKMIZgkaTeO4ch8q0kI/Qq4DVJMaY2sBECd2WeIWCKSBcIIU/bx7TZS8l9EAz9nk+ejhvWGKtK/a/XZH7xVFBJqEj7sh230edA1kK8QC8S08MgdnPvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z24Uwb4W/FUiS+YbNU8XmzV5i0yaVh4bdOSHU+2t9io=;
 b=lD912G/4gvnrX3uEszWSTVmMc8kFLa4hhKY51OTmO6aPzqWN38/+urlEGxVNSql6ZIJNWrkIFiFnW8YoXycUfLyynnCR9UYr+558MzxhdgwPhZFXmyLBYpyBOr1PCyMasvvjmZLy6DLfXBbZNWAJ1NkJABE3vzLYX5CViDQalXkigdN7+C9lMNAzFKcGezAE3RAEMH6Mm8u9uHJMT0L3oFdcro0fIp2kAcj75SYQF/SbRydiDh5/fxh+QXjzSOoNHEvM+U5ZJS2pheR+FJ667vWMHsbaYYiB1hwlXoWD7RZ2MrWvEvjx6bIQLFBUdZLQQ+Peob8MYR5Ovra3zRPv0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z24Uwb4W/FUiS+YbNU8XmzV5i0yaVh4bdOSHU+2t9io=;
 b=q6R88GwjeR0400Bw4OCmzX/Zo2y1jYmMLBtQ6tHBwLsk+JKyYTsLEEsra/xl9ZzQHP56AIDkFJTJ5b9KcCJdPqcN2UB6uVTHARryYeTUarhvWFAx9qJQWkkL2hBFyJkZaQz9Ybkhv6CcNrsEIFS8xcA3CHtldWJOW4aPbtPOLIwO1iPKaJEjVSNxwGQpP67Aj0PHKF4x29pyzXSWXSqqo8qkK69R1KIc7VB+Obwg+z3tqFJ78HOhIJLpJl6erM0QrYQUHmdBKsCSU2z49quW50D85z64KdT6xF6BvW9NPbvvqTfdOvfRcLcdxLE5AYMexOhua4SoeOABQrYvxGnJKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8393.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:417::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 13:54:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 13:54:52 +0000
Message-ID: <65659859-d9e0-488f-983b-7cfbb776d256@siemens.com>
Date: Wed, 26 Jun 2024 15:54:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/2] initramfs-overlay-hook:
 Add INITRAMFS_OVERLAY_MOUNT_OPTION
To: Clara Kowalsky <clara.kowalsky@siemens.com>, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20240626134141.74487-1-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240626134141.74487-1-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8393:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ba5859-b8a3-4695-9e9a-08dc95e78d90
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|376012|366014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?c2tjUGMraXVGWjl2RHluMVIvWmVJZ2ZDYzVScFJNbEZJWGNmQ1VmU2pDUEdj?=
 =?utf-8?B?djVLUGwzbVlpd0N2N3M1UkJrMjlWREYyOGNXdEN2SytQK0FJdjZLQlVjWnV5?=
 =?utf-8?B?TDRzQzJjSG9zZkUwK0ZFMEhGRWp2bmFyMHJ2V084VUF5eHAwYUFENEZ3RkVO?=
 =?utf-8?B?OFlWcGY1aFVpb21YSTNwb21LQ29oZzBCZTlsQkJtZjUySW1ZVW9Db2lzeFhN?=
 =?utf-8?B?dk12NWw3Q09mK2xPb0hPTjF5U0NzOUp4aEEzK04xNElUaTlPK2JhZUZuSkND?=
 =?utf-8?B?UEtacHZWN2t1VitYZ2VHRDVucHZGUE8ybE5halYrOW1Hcm9QT21yRmZsK3A3?=
 =?utf-8?B?cHlwVlZDejVSbDVPUEFlUklLcTFqS1liWktyWGNYSkFnVk1SUFNFc0pkTTlR?=
 =?utf-8?B?V2xXNUlYODRXSWErdVZzOTNwY1JNRVJkWk1sK1dlRnM4dXpKTmQvem03QlA1?=
 =?utf-8?B?MFpJdC9SN1l2QWZDR2pRWFNPb29iR2gyQkQ2N0lQY2svOHZtQ0NSK2tzaU5u?=
 =?utf-8?B?R0V3OHBmNkRCNEpRcWxIczVaR04yWFRxTnVqK1V6bm81OXNRZGpQQWR4YnRl?=
 =?utf-8?B?RXVtRUtBVFJxeEJQMW5HcWY0Rml5N05xcDRNOTdrR0RUeGlnM0tXclJsMy9D?=
 =?utf-8?B?L3pVeDlwdFdqMXd2eFo1blAvMkpiYlY4OU01cXFsUDRqZ1d4eFBpWkJYa2NT?=
 =?utf-8?B?bThveCtsK1dDRkRNOWRkeHFXalR6ektaV290UDV4VnlSa3c5TTRTQzBoN2Fh?=
 =?utf-8?B?L2RxTENJQ0NqK09qSWpaOEtjWU5TOE9VbUtZZmloL0lvSmRhbCtIVHdJQjRN?=
 =?utf-8?B?UFM4VHNjbU1ZSUpvWkNMM29NZExrNjdybDFuZSsyeUdtblpCc2YxelR2ZWwx?=
 =?utf-8?B?Sm8wWDRveGNyRnRnZDhtSUxKa1E5UG84Z08xdnhMOEZQaGVoMFJoUTZoKzBr?=
 =?utf-8?B?Y0JKeEdwL0w3SnRVT2VCUlNDN1F6OWs1SHZqbGpxTHFENFpIUFVxSGFzQlBU?=
 =?utf-8?B?c3BVNkNNZUUwTHF3c2tlWU43VTY0dHNBSVVzSENDcEpDblJ5alVXejZEZ2lU?=
 =?utf-8?B?S2JGVnZZTVFIdGx5TE53a3lJZjdoMy84RmRoZ0Q0QXd0RU5FVndUMTBIZ3FO?=
 =?utf-8?B?aSt1Mk5QYnljZU1aYzJjZ3B5M3BTYVErZDViTTdwbWtkc0svRlZVSWl1TW9v?=
 =?utf-8?B?YW5QS0x4TjVVRU5zdWY2SDQ3WWRDSUc5WTZDckZ5blEzdVR0cldCVWZvdzdj?=
 =?utf-8?B?SlZ4VnhSSVpQSVM0MnhkazVsdGhqOWpiNDdYd2RnRVR4amRjY3NROUpBb3Rn?=
 =?utf-8?B?OS8xejU5eVMwUjNQaTB0VlJNSUxheENGTk1XSUdNNEljZnVKZmZaRTduZXMx?=
 =?utf-8?B?VlJ5cTlnTHhwVHlSYW5wRTF1TjJrWEdnS3d2THdJVGhzWkVJU0JranB2dXdK?=
 =?utf-8?B?RXpZaUtXRmJNd2QvZlFPeG1PZTZ0ZTBTejlMZUxvOVVFYUpGMGRJZnY4cnZv?=
 =?utf-8?B?VnBGZjBOVWo4UkdUMU1kWUtPZ3AycUdpUkRUYVZFMHcyTHUrOXFlMUl5NmJW?=
 =?utf-8?B?Z01ERDhSWEVLSGt3OUtHVHIzZGEyVytTWUl3Y2k2YXJLd1NPK1N5a2xUdzNT?=
 =?utf-8?B?eERqaXFYVlhCd0NKaXNsUlQzbnNBbHpXNjVtRlA2SGpkQ0gyV2VyS2k1R3Q1?=
 =?utf-8?B?Y0F2ZVFKdFh4Vytxb01mdElmUDFod0Y0UHNHb0xibjZac1RWTlF5eXVqdmFx?=
 =?utf-8?Q?07eTGmtb1BwYjZ/JDhUgSKn7I0cgWgTRn3px+lH?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(376012)(366014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YnNWRHhRYjhOSWRoSjdBWnZpaVNHUGNtZjFwcTJlcGpSY3JLUTMwRU1sRnk2?=
 =?utf-8?B?dXdDaGdtN1FhUWNUWFlZaTdwUVNHYjJTNzl2MDZobHh0eTBjQmV5ZkRCSUhS?=
 =?utf-8?B?eDJyTDNvUnBaNS96WjU4WVEyRmV3L2hHK3JmaTgvU0k0VFF1OTk1RWw5QjJI?=
 =?utf-8?B?dXBvZmNOSEs2MVpFQlZyemRkMDNRdENYTThlRzl2Y1llajlnYzlQSTNyZ2pO?=
 =?utf-8?B?c1RkQlgxZHJRZFI1cnIwZWNvTll2QkRvamIwTi96VGF2YWlYSk9sdzRWektK?=
 =?utf-8?B?L3dhYXJVQThwRVQ2T1kwaUVPczM3VTNpUlRjbkpGTWxWYkJSZ0VkS0lzSmVj?=
 =?utf-8?B?ZTRsMVFTWmF2YjdKa3psNHRSOVZKK3hob24rRzR4UGZUMmYzNW5ybUZsT0hT?=
 =?utf-8?B?NElFcThqVC9sclkwaEJZWGhCM2E3aGtxTFZLa2xOZlAvYU90eUQxVnFjMkRF?=
 =?utf-8?B?Tmcxak44bGdiaElVMXZxNEZCcElxK3RHVm9wWmRjNXZnZ09ONnhrb01iRnI1?=
 =?utf-8?B?ZXZnVjBEL3RIMmxselJ3MURtdWcyQUVxaURMbVNzMktQaTBXTDJjcGlOTms1?=
 =?utf-8?B?VitNb2ZOTnF0SmZENTFDQjVmTldBbmFaMVIzSEZlOWpOdm1VaDJacG5PSW9o?=
 =?utf-8?B?Q21BekxQRGwxa01relBuOVJTZ2ZEN0RiTGZtaWErMkFTYU9RcjZYdkVhVExq?=
 =?utf-8?B?M1JIa3g2QXVodC9wNmJpcEViVjMvMjFlN0s3dDBDdHdqWlNEVlUyVzV0czZE?=
 =?utf-8?B?YjVqdlI0dDdWUjI4b1ROK2JUVmY2SzRZT2FveE90dGxPeFVUdFVGamx6WlAx?=
 =?utf-8?B?YjJWb3hsamY5bHhkYnEvbFZNeFVZMUdmSkluc0ZKeGVkK0MxNDZtQWFjZG8r?=
 =?utf-8?B?N2pjS3BqVnVyZWtNZk9SeTlHUWpnLzFOTXRTa0prbUQrbzNhbDlpWDhXREVQ?=
 =?utf-8?B?S0lUdVErQ2ErVS85YzhNOXpGSUp1OFpkTDZXUitYbVUvSlBEYms0RWo1V25T?=
 =?utf-8?B?RlFHbk1WSm5pb0NxeTMxdzQzYTVZNWNmL1dkQW44ZFovOEpjd0xKYVlXdmtl?=
 =?utf-8?B?b3FDTE5YRjRjQjhKaE5sNHJkVDdPVU9YbWw0UTdHUzJBaUU4Vk92SUI5b1Za?=
 =?utf-8?B?ajNNY005aVdkRGRWS01SMEczcFpXT0dHYmw5bGdsVGtndHJaQ0g4NzVhWng4?=
 =?utf-8?B?Z3ByenhWaVdNOVY2Wi9QU1NrUFlzdDBMTHZSSG9ONlRXRWtucVczRHRQSmNn?=
 =?utf-8?B?OVozU3lsK0dOYmJzQTYwWTNReVRJZG1uRGZ3akFCVHc0amxNcmY0YzMrMzJo?=
 =?utf-8?B?c245K0VFSUsvWklDVnBvMkVieTZ6SlBGMkFSdXRId3hZczhJVjJMcjhFTVVG?=
 =?utf-8?B?R3F3UG55VUVmTXhIL3VjeHEvK3Nkd2xrTVlqNXRaVXBEZVUxZk5kUkNTWGlo?=
 =?utf-8?B?QnN1QXNYUWY1T0drZDNaNEJ4OGllSVJZQ2NMWkdUSmIrbGVsRVBrMGM5MHlC?=
 =?utf-8?B?TkVEckhTRmNmTGQ5TFBvUnczd0Z0Y05wSGhNNlBHQ0UyTjRJTWg1VzY4OW12?=
 =?utf-8?B?KzI1VTVLakwwY3gzWkNiTUpxc3RQZDcrU2N2R2hsVTdoVUhxRkxtOERuc3ZL?=
 =?utf-8?B?NkQ2cmZRc3Rtd0V1L0NaZ0ZraE1IdVNNamtlTWxFNFhxWnQ3N29wMXRJYWRu?=
 =?utf-8?B?cVlHOWFvOGo4aWpqQ2c3SUVCemNCTlJOSGlpY3o1cXJJeDlmWm0yUjcrTjN6?=
 =?utf-8?B?LzVQaS8zd0MzL1I0eEpmZk1TNzZUOGtnbEFOV01QSnUwTWFtWEplOEp2UmJk?=
 =?utf-8?B?N0s2RFhMYWJydCs2NXU0Q2FLeWFXZlNudjhWRU5qUElVTGR1WjFDMk93alNN?=
 =?utf-8?B?d3U3bUx0azJBb2hiVW52VlZHOXdXbkYzZVFId3RDTkVDelpacHlVUHBxdmo1?=
 =?utf-8?B?TitXdVU2YkdNKzVxdU15SDltVk82cHdEN0xRdGdpMmt5ajAyS0dGMmwxTXkw?=
 =?utf-8?B?bFJlbzd4ejNtVVAramNQNDA3YVNSV0trcXc1L0RlaGxyQU05RlNXUnc2eGZH?=
 =?utf-8?B?T3laaXVJUTdEQWRlMzJ4Qyt4UDhnOERvS2g2YTRLUER5TS9vTmtlZ2pGeVV5?=
 =?utf-8?B?ZDBkVGN4R0N3Yi9Rd0ljd01CUmVPSGt1NVFxNEFsbVJDelU0eHAyMkZWSGZD?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ba5859-b8a3-4695-9e9a-08dc95e78d90
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 13:54:52.6207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bt37HMngNNMTs+CB5KU6jLAKhlRzxzR2xJAEw78Zt0POqmZjur8RQwnEvCbwBajo+2EcWgQxrME/sSl7rLOkgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8393
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jun 2024 13:55:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16331

On 26.06.24 15:41, Clara Kowalsky wrote:
> This allows to set options for the mount of the overlay storage device.
> 

This should also explain why we need extra options.

Jan

> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  .../initramfs-overlay-hook/files/overlay.script.tmpl          | 2 ++
>  .../initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb      | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> index 2563dfd..42eb59c 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
> @@ -30,12 +30,14 @@ esac
>  ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
>  ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
>  ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
> +ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
>  
>  root_mount_storage=${rootmnt}${ovl_storage_path}
>  storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
>  
>  if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
>  	if ! mount -t $(get_fstype ${ovl_partition_device}) \
> +		 -o ${ovl_mount_option} \
>  		 ${ovl_partition_device} \
>  		 ${rootmnt}${storage_mount_point}; then
>  		panic "Can't mount ${storage_mount_point} partition - overlay will not work!"
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> index 2694766..955748f 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
> @@ -29,11 +29,13 @@ INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
>  
>  # override this to switch to UUID or PARTUUID based mounts
>  INITRAMFS_OVERLAY_STORAGE_DEVICE ??= "/dev/disk/by-label/var"
> +INITRAMFS_OVERLAY_MOUNT_OPTION ??= "defaults,nodev,nosuid,noexec"
>  
>  TEMPLATE_FILES = "overlay.script.tmpl"
>  TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
>      INITRAMFS_OVERLAY_PATHS \
> -    INITRAMFS_OVERLAY_STORAGE_DEVICE"
> +    INITRAMFS_OVERLAY_STORAGE_DEVICE \
> +    INITRAMFS_OVERLAY_MOUNT_OPTION"
>  
>  DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils, util-linux"
>  

-- 
Siemens AG, Technology
Linux Expert Center


