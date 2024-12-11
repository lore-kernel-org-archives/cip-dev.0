Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEBCE7717D
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 14:08:55 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.73])
 by mx.groups.io with SMTP id smtpd.web11.11685.1733926124907503345
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Dec 2024 06:08:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yStTGtTu;
 spf=pass (domain: siemens.com, ip: 40.107.22.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQKvZG1ZHK8USlH5ABE2jTHnHZ+YSuRX0kU3xlhEvigh/gJnVBh9Qf4pjXojddKtfICai6UqS6nza0d/E1qALvXe5OkoJtvEb74OGDYbfyM7BbOLXcrvKZAEN98HUAnUK7BlwcP8lhIGHFOlkMuYQ1Tv3dbMhIHJ5tdqA4HtfMl7xhjopJqFzLIgpRqD0/j+hFvuYLDmttc5U4DCqIrfloZwlB0Mjp9yPk+LHxQ635EQFK0FnPTpfrnhWNwzEUFuBTdyYU7ZwtA0bgglFaV2tsU07l3K4y4gXYVCJtYwUEl2AScoFJa9HLlLpyHYo3ZSlDXC6QiTdnUUbD/a/axa2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksRj+JwMFrl6hadtSzfUSvbIMF62f7Bbgv/8zaFKOVk=;
 b=FQsrCbL+gWkRfxLVYEkBkItbKrxpoR3mj/by5EFDBSkAeWDe/3qh11neIxMZwfHu1EYrdXKVOPk7n/vXTTcPkXDW1QtIcrjWEclRfcWNN+e3vXbIYC8T698Km8/REugG3Ra/vWZS80g2xmBwlbfLhrYMKm8T8w4MCngKTsFJQwrZBVwSLC2zR/X+ue2MQSIUF6jW2FtDcLt4Y41Lq6iIcUHjFTp8klC8Q/JPmxDo0ZLqRvGS3tpynutrYE2HtjrcM7S5NXbVDbjRiyjA/4afWhF+YyH/taGNzbesbGLR5pfDTMEa6wR/+I/j0wTe2o1Fzq1NnyfCUUC3gGehUaXb1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksRj+JwMFrl6hadtSzfUSvbIMF62f7Bbgv/8zaFKOVk=;
 b=yStTGtTuEAT7ToBkPLBNz5DIu2xn8SDqh0nD2aeshhLG4af9EmlTbSD3NTaIKAU6aPy9xxlIC9ciPLGr5U8dbHJFAs6iPvB0rZx2EmBMzGevFGe2+JsqUmKs7vLCTzWjxsJNHpklC3tXYzkbSxgN6lfTnLjg24X03rex0YiA8m2mpXntGEewc1gAiM4gMb/f4s6lV0LZYvzi3tD+sb3Hi3HXGotBGfcgFXLrhkhVWeTbq8qjPLLnHiVI8+yE4LcAq/FCdoTXkyn3YBAsvJnUmGkV1hyMIGcLG/TqDlyzz+ZdKm0NNYhlhJ6gHWkiqX8xw23eiVZFRMuuRFbZCkiQYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8617.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:425::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 14:08:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8251.011; Wed, 11 Dec 2024
 14:08:41 +0000
Message-ID: <4235e1ce-d6a6-4c82-b40c-f6dddb5ef7ae@siemens.com>
Date: Wed, 11 Dec 2024 15:08:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3 1/1] define RO_ROOTFS_TYPE before using
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20241211113213.2743931-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241211113213.2743931-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: b44f2730-ba77-4099-b080-08dd19ed5144
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Rm1RYUpIdERXa0Y2MnNvRG1aYXJxQmNvbHplSVp5dG1Jay9IOGZjb01zaWJ3?=
 =?utf-8?B?bjBJbUdqNmJ3RUhUV25SUmNkRzlqNm4wdGtEWCtDZWFFeVhvbXR5SFdwYWxo?=
 =?utf-8?B?L2YwcEFxSHhRSXBkeFQ0M1hGSzNSeWIrVnhFU1dkS0l4ZDJsdWtGZnFncTZx?=
 =?utf-8?B?Nzh6ckpOekFITTFEczFPWmt6NzEvSkh3UmNoeFhubGRwSG5LdU1nODlINHhn?=
 =?utf-8?B?SmtXZFNYMHpPNmRHWUk4djR1TFUvSHorWEtheVhhRWNWOVVZQzdlTERHcXRo?=
 =?utf-8?B?V1NaVGVzbUVPTmJPTFNXK2hTb09XRFgwaXlXZUh6RTJRWEwxR0RDR0pEVFNB?=
 =?utf-8?B?ZDhyaWxnVVhReHYzczIrd3NrT2FTZithN0tCaldIdkxPMFN0OVVMZDVkeHZu?=
 =?utf-8?B?Ym1VTlZtVW85b215U0kzTVA4VWpySDRXekNzVmxDNWgwUmZvOHdBTWRoY2pv?=
 =?utf-8?B?dWE1WXZaYmlFemZCckw1b0M1ZkplbjAzeVBlWXFiN3d3YXRXU0U2MU9oNUxE?=
 =?utf-8?B?ZW13a2R2SnJqMEkySDBOREk1cnErbk8wcnd1SXVXcTFGR3Zoak0rY2lQWUFw?=
 =?utf-8?B?MDVReHJqaERRanNjOS9tN3lqeXBGSTFZYTVKTUlDbWJ1NjFVVzdYNlV3dS9t?=
 =?utf-8?B?RW55UHpER3IrcXQ2U3A5RkFOaTdmMUdFeUpTb2syNmZWM2hNUTJyWXYvYzl4?=
 =?utf-8?B?MHFBc1NXWk54LzZrRWhIWm16UEp4TUU0SWZuT2QxYnlMZkdOTkRzQXkvMFlI?=
 =?utf-8?B?ZWJLY2F5KzM0TGxnZkJMVHR0VEZacEoyTm52K1RUYkNDcUNqaVNzWE5wbzgz?=
 =?utf-8?B?NStZT016Rld3aUlrUGNiL056ZDJCQUcxemFRN1hNTGRqTWFJVHBQN0xwZ3hk?=
 =?utf-8?B?SWZVZFg4WTVTZnBmbCtkbTVINHduZEl0WExueUxVMUgvZzVTNUlDUmRIeGpX?=
 =?utf-8?B?R1ByemJJQ2xwVTlmdkZUUVg2M1BtU0QrWjZHbEk3Qk1sZzlYaVREbjlaNUFs?=
 =?utf-8?B?Y291QjBjTUhoL2lmUU8zc3VldkhDcFFSam5FeDJlZ0Juck9JZ2pNd0I3Tk1a?=
 =?utf-8?B?bmFvdjVKSjNxZ1ZhMFRNSXVUVFZkRDBKVCtuQVlnWTlUWi9BZkNSVVp0RUJB?=
 =?utf-8?B?UldkYkxUSWN2bGtCdWFGdVIzdkw3WkI2M0tiUE1iaHdBOG9JcUtERTlNOTg2?=
 =?utf-8?B?dTRLaTRZbHI3OHQ0anMxRjZreVJJdE04NmlpZGxvbUQ4TXNtZFVpWXdmdzNO?=
 =?utf-8?B?M2xIUlJIcHFsSEtCWDQrcDlhYm1Fcml1NWZOQWxEZ09ZNm9SYm5LcjZDVDBa?=
 =?utf-8?B?VmhRNWY0MjQ0T01OTWRGSjNENEZwWXR2TGpIOHZoMTBrTDd5SHVlOGhkZERM?=
 =?utf-8?B?RTI3VytzYkNoVHIrOVFwcXREMmZnTndnRlZhNnZHZ1FqY1YrQjBpVmYrcXk5?=
 =?utf-8?B?QmQyME95QjhCSHlHR3pyeTFxenRMcWNDYk1UditvY0NYd1ZkK2wvbnI0bFNr?=
 =?utf-8?B?TkNtS21WaklNeEhKSzhTQVFsV1IzN0krcnpaSm9kMmYzYkk0bDdabEdsSFZC?=
 =?utf-8?B?MU9ZZVRUSFNGMzFSWHdSMlVhUmQvMVdmTkRxaU1JOVpzY001L05GVG9NMGw0?=
 =?utf-8?B?SUlxL0N2Z1dtTjBnbVZtTGZ6MHRWbUhRZFBCTXNXOWlndXJrK0xubHR3SmRm?=
 =?utf-8?B?TjloS2tEdEtObzcrOVNDcGc3MFBiSlBMN1p5N3dXYy9NUDlSQnRGNTJ1ZDlI?=
 =?utf-8?B?aENUWkR1UTZaUDF6WHRvSDZ5cW9GNkpTakEwSlNGdVhiVmZqNnFXRG9NQWNS?=
 =?utf-8?B?QzVtdDVnTnlWS09nTkVDQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cUFIRTRLMkNBcU5WRW52clV3NC9iaFdremtiU1E5akFzTW9OSk1hcTdBb3Fz?=
 =?utf-8?B?OXRJT2NIbDd5M1pud3hqKzFpazYxa1NVU1dMV0NTOHg5b0tobi9OWFo5ZnFO?=
 =?utf-8?B?SEg2RGtYTkpCRGFFZ0xIZjFmajkwZyt6Y0Z2S0tkM1U1b1ZKMFlPc2g5MVhQ?=
 =?utf-8?B?R1U0QXNwNUM2WVNyMGQ5dlFqV2gydlQxSkcvak05S2cxcEV2T2xjSkdvS1R5?=
 =?utf-8?B?TmpwaFRGdzBsTFU1ZE9ERVJSdGNRZEgyemVaVTV0V3ZjNE5zMTRENkw0WVE0?=
 =?utf-8?B?ZXdtUGNoT3ZHd2dlZFlpMUNqMTcwTGFyWVpraVFDUVArMFpJVStQdVRxRU5W?=
 =?utf-8?B?QjNZWnllVmRMVVNmenlXUjgraGEwRVdLdUtlUzdIenp1QUtGOVIwMVlLa0Y2?=
 =?utf-8?B?WGVEWWo0Z3JrblhHTnlGS3NjRzNQTEl4MFBRdDNVWk9YUGk3YStpWEZiUjRZ?=
 =?utf-8?B?a3NQNTFLZW5mb1Jib3kyekZGTS9HdjFnaHdWL1I5eCsrcmRiWUpGeDNKU0Nn?=
 =?utf-8?B?OHZDVW01TnZ2YkxDTkFqM05veG9ZK2NTZjB2ZkpMT0huMktWMDZ0QUlicDZY?=
 =?utf-8?B?eUxKUXYvTFp0S2NISVhYYk1jOFArcjFwQmpLYnFEUWdOSU1wY3lFRTVkeFZz?=
 =?utf-8?B?L0xiRkJsWER1azVpQkF4N1JuYmRLZVFENEF5cXNWNW4wSVU4TGxhaE5haDdr?=
 =?utf-8?B?WWVDVE1WYldzUkV0V0FVdVhPSzNUUlhaOVdKKzFHY015QnRiMGVLblk0bUgr?=
 =?utf-8?B?VjNhQWJmaVUyRW9EdGNveWxoNFhrWFI5YjRNQjB0TEtVenlOck9sYjlVcStp?=
 =?utf-8?B?YlFySWtuck1ZUTBlaG9EaWU3M2hFclJqbS9ZVVA4TTJSaVlZRzgvZkZ1b2pV?=
 =?utf-8?B?RnE4ZkVOOTN6ejNWWUVOdXhac2k3T1o0dFpBbDRISFRLK2E5cEI2bVEvMmxv?=
 =?utf-8?B?aUdOQkhZWXd0MjRjN1pSalpjTUNrRUZ0QjVVWTVkM3JoUmg3bXdrT01mWGpv?=
 =?utf-8?B?TFdwbTFCdEE4TTYvQTVtY3JVNXdjZUtpcmQ1UkVwK3NOS0VYc0R1V1B3VXNx?=
 =?utf-8?B?cnRwcGJ0Z1ovZlBuMlhuVmVHeFQxc2p6K3ZER2EzQkR2MmltbkZOYm5QWGx2?=
 =?utf-8?B?aTJXODZTeVFjN0NEVHBNcVNXMWdGNzl6ejg3S2dRY09scVF0NG8xcGpwY0o0?=
 =?utf-8?B?WGtHNlRGdEl1emNQYnkxbEE3R2ZIRU1WYThONEwxbjJGdFQwUWVDMUZ3dHZB?=
 =?utf-8?B?RjY1WHJRVGxMc1hzZUNFekF5NWVqelJsYTFMSEtIaHNlR3l3NllKRXY3bE1H?=
 =?utf-8?B?UEJvdEQ4b05aaFZXYVNXUHN1VG5PZnBIMEpSSjlTQ3NxMlMxeEpnRUhuZ0ZZ?=
 =?utf-8?B?b1ZYc2ovTWRpWm9FWlFUaTNLLzR6bHBqL3FhdmtjSUhQQzYwOVlzQ1RxRzZn?=
 =?utf-8?B?RVFCdnpBUjhPWU0wNEJhQ1JqODBYQnV0NkNiL0ppbXkzLzY1NGlHQjgwaTJ3?=
 =?utf-8?B?WGFod1hROUpXMGxLTFpPVm9xZE5NLzZGRXhiUmJhdWRlTjRxSDJmUFlFanJq?=
 =?utf-8?B?cC9ZVzhBQmhOd21iOWNDRXVDWEpwK2ZYUkRJRlJpY29jWjhFeE1SL1BSY2s3?=
 =?utf-8?B?SjRwZ2c0aytUR0d0V1dnbFAybFo3RXQzZXVDMFZHZkxzc0tLaDd4SmVyUzZ3?=
 =?utf-8?B?eWNRNnlBb0JvODF1TEZFSmVCOS83VGd2Y2FrcXhtVGN2Wm5WVnF1OGFwTko4?=
 =?utf-8?B?SzBZb04vUVlYU2pwZEtLUkwvQUM0TTZEd3BQQ1pNblRQbjJiVEdFSWQ5ZzU5?=
 =?utf-8?B?OVU0WVdLaDJXTGIyZjlYVmF1cWMvY0xhTHh4K0ZjQzE2TEs5RUtjZUhRSWwy?=
 =?utf-8?B?WjExTTRRMGUrditqOE5SZWdzYmdzS0RNSzZqYUtlVVlxQ0ZOZFRNOU1ncGND?=
 =?utf-8?B?dElQdWNFVWp4SE5QRFYrald0VnhWOHNPdnlhNWVuYkF3b05obzBaeXJSTVpZ?=
 =?utf-8?B?ZDBEOXhpMEJHQVBVZzRJeCtDNXUzM211ZDRFcVEzeTlObkZlUFhCRjFtT0pJ?=
 =?utf-8?B?UC9RcDlnaU0vVUEyNlc3bGhrK0g0Zit4TUQrSEdyOFdxMDJMRllUTXNBMXhF?=
 =?utf-8?B?K0dLbjNnY0luMG5CM3NxN3IxcjRKRGkycFQ2ME4xbjUwM29vR25hRUdkN1dw?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44f2730-ba77-4099-b080-08dd19ed5144
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:08:41.8986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i9c1msnMp/5PDIPGMpVqVR6hcTUg+Frgf3vJ5ZNrK/UG0SQ4uEuzzs5NfyRDUEE0++0wZlcNlpAW0e7YzTkn8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8617
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Dec 2024 14:08:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17405

On 11.12.24 12:32, Felix Moessbauer wrote:
> When including isar-cip-core in another layer and not using the cip-core
> distribution, the RO_ROOTFS_TYPE is undefined. This results in parsing
> errors.
> 
> We now provide a weak default in the verity and squashfs recipes to not
> break the parsing in downstream layers. As we no longer need the
> definition in the distro file, we remove it there.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
> Changes since v2:
> - add missing definition in swupdate.yml (used to control which
>   initrd is build).
> 
> Changes since v1:
> - remove RO_ROOTFS_TYPE from distro file
> 
>  classes/swupdate.bbclass        | 1 +
>  classes/verity.bbclass          | 1 +
>  conf/distro/cip-core-common.inc | 2 --
>  kas/opt/swupdate.yml            | 1 +
>  4 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index 5bf021a..3243f67 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -12,6 +12,7 @@
>  
>  inherit template
>  
> +RO_ROOTFS_TYPE ??= "squashfs"
>  SWU_ROOTFS_TYPE ?= "${RO_ROOTFS_TYPE}"
>  SWU_ROOTFS_NAME ?= "${IMAGE_FULLNAME}"
>  # compression type as defined by swupdate (zlib or zstd). Set to empty string to disable compression
> diff --git a/classes/verity.bbclass b/classes/verity.bbclass
> index 231d172..c3b89ec 100644
> --- a/classes/verity.bbclass
> +++ b/classes/verity.bbclass
> @@ -12,6 +12,7 @@
>  IMAGE_TYPEDEP:verity = "${VERITY_IMAGE_TYPE}"
>  IMAGER_INSTALL:verity += "cryptsetup"
>  
> +RO_ROOTFS_TYPE ??= "squashfs"
>  VERITY_IMAGE_TYPE ?= "${RO_ROOTFS_TYPE}"
>  VERITY_INPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}"
>  VERITY_OUTPUT_IMAGE ?= "${IMAGE_FULLNAME}.verity"
> diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
> index 3323dd0..d06eef0 100644
> --- a/conf/distro/cip-core-common.inc
> +++ b/conf/distro/cip-core-common.inc
> @@ -15,8 +15,6 @@ WKS_FILE ?= "${MACHINE}.wks"
>  
>  CIP_IMAGE_OPTIONS ?= ""
>  
> -RO_ROOTFS_TYPE ?= "squashfs"
> -
>  IMAGER_BUILD_DEPS:append = " dosfstools-native"
>  IMAGER_BUILD_DEPS:remove:buster = "dosfstools-native"
>  
> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
> index 837efa7..38dc390 100644
> --- a/kas/opt/swupdate.yml
> +++ b/kas/opt/swupdate.yml
> @@ -20,6 +20,7 @@ local_conf_header:
>      OVERRIDES .= ":swupdate"
>  
>    wic-swu: |
> +    RO_ROOTFS_TYPE ??= "squashfs"
>      IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
>      IMAGE_FSTYPES:append = " swu"
>      # input is already compressed

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

