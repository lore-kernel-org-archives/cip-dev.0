Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6712EC47DA9
	for <webhook@archiver.kernel.org>; Mon, 29 Jan 2024 12:22:26 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.70])
 by mx.groups.io with SMTP id smtpd.web10.13455.1706530940790108711
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jan 2024 04:22:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KHmOanhC;
 spf=pass (domain: siemens.com, ip: 40.107.8.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eykvAXSmXQPPQ8YSorJcpmGMDuNpVcPyyQQU4EgDQrfBas0QoAE5MF7bVjXOZ44iRWegWPo9hwJWLapYKzrtBJv7QxuANuVupziLQJhxvud/B4KZJlXFmQFqU5s1wmJa/ZttFoLfNwGhWnCGpoHW7ucog6O42EBlRrkXCa562yICap8iPiGk8UcHff8tdTTt1mRmVPz5bEsx9nT5usGUI9ycZMvoVWcKGEihNy4HOi48UFTGiJ7SJaZwsRRxviCWU+ayRk6RX/Er/5j6FujRkCeIHTHRJgzigg94QStMEOvOmxKkqSNwk61Ms8S6CEwCUrtHStdFNPX2/n6hBXvdtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAZm6PnefEVfhEUWIk0fF0cvcmhrgPiwHcs0e6qye9g=;
 b=AzMT6tOk6HwtGUvYUc1qSPJq9t3Eixz+pN+RTvYz38QOQ9tj96f6oBOYtGejxknsrf9WAL/pEvmXxnAF/iaHmuTDKQyLxDw1JKSDHc89GkXJlMJtHv4yCDa0UuCuVw7YKS316VuuVDLhSNUzVrT8+8aW2P1tuEPErsVCZRIfemmZfDVD08KzY9eBOxTEwyxpMH/1mY6yDH2fkUrSSrlXd9K8NtZ1lbIAlt+zs9CF2cEPBZCImjJongZ/fFX0WfckmNgWCC+BFiqryvUsnjNhqoO/nAmlB6B0ZQj0HXq+nW/eyCOuvE6jty8i3B2sO/aIHRfpuOhcS9EIaznMxSgZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAZm6PnefEVfhEUWIk0fF0cvcmhrgPiwHcs0e6qye9g=;
 b=KHmOanhCmSlIu+vuZxDY0Ni2L+nB3bDNfteef9thNXsO8Z02fnae2IMni+ekavAA/TCvCHExvy/zRSLUWbMhtA5f6/I7v/x5uqFP85MNcu79quOmJWN22hoMVPZh3cmccGic4TZ9hfomOKZCqb3Ln3vV8pKb/Ev1pCUDwkmNZrRCKg9O9XprfK7HKB1GWvr8Jqda5N+ymUC7qjMwdEST+V1iUJ2ZsXu7amZsMdBFZooWcv/NlNFWX4NEDPo//xza9b0K+ZGACbi1UrnW52uYjzBs5ucm//9yYrAqQppwq/w2Jk3Z09QuyJoP8cwYicC/5RotQn8w0GDzyE8lD4ppXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6170.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 12:22:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 12:22:18 +0000
Message-ID: <12d34b84-3d80-4c48-adb6-7d79a470faa1@siemens.com>
Date: Mon, 29 Jan 2024 13:22:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] start-qemu.sh: fix qemu with
 encrypted paritions
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240129104730.72927-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240129104730.72927-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: c81bd76c-193c-4baa-942c-08dc20c4ef81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ft5SvIyO6FWS9Lkzr4BYXlCQmwVMe9daGFHwQlcUeactjDI4m7wL2N0ERBpTb3TrXp4+Q/bml6oUbYrEm+kjhYunVlNRDGe6/uin+wxiNqjyRtwgUD2dC+KZwN0IuS+Dlo/aX4siyf2QFBugnPgIXNgEi/LApnk0DkZrEbf6vaWuDOQ0+J0iZ+wclcoc3QZMjlgvvrwZ6TJVV5qHZSwZlQixa+RTUCk5zNYY5z2yAIadK8OqKamN1LYxHXBFPoVA/16ysSEV3y9/0Wu4sx5vIZOSWRXCrr6CGc4Xln8XBuRHWb0SeGTYJLq4Fce96hjc6FipkrnpY7h6c7wMBUckDaT73HT8UhfCqWkcz1qhqOiCfOCIrSfNjMlnSgwYPpZGl2Iu93sDED67j+EnzWYVMOXPxkd1QBqzeWT3wUT6mlqh3/wa3R7alYqIn/KVQT5xjqMS7Dhy/7GaqdyrZyovGchP3yAaqt3dlYdNimo6VccQjk0z6PLn+meLWMm0PUH7XFgQUjS8/s+QueBvOAWurOukr6dCbpidLyI/LBzd35hxxIHkKcFX+feJNz2Rk8CGfhHd03/WO2QNyigWbdrhLfkVxI1gdjH1wMnu9iau40aMgYNYmXf0waTqqCknP0kWKcB/W1ZADKaccNl4OeBpYQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(41300700001)(2616005)(26005)(31686004)(66476007)(316002)(36756003)(6512007)(478600001)(53546011)(6506007)(83380400001)(6486002)(38100700002)(66556008)(82960400001)(66946007)(2906002)(31696002)(86362001)(5660300002)(8676002)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q2hvTlZpU3VqaGRiRjJ5aFNheldXYzgvVjNoRlJ3NjhlQzhUazJxY0pLVU1a?=
 =?utf-8?B?aUdwMGprWHNxRFhUaU9nRTBwTDVlK3pSTkdENzdzSWdsNTlaZ3NmZ2pGR3FS?=
 =?utf-8?B?Nmk3LzlYR2NaKzZ4NXMrUUFMMEhZcHc3ZlV5b2puNURnNHpBM3ZPOUZiaGcr?=
 =?utf-8?B?VmsxVHhvaWVRNnlzWGU4NkFyWG01TWRKemtNYkhTekRwNEhERkpNaWxXWUNV?=
 =?utf-8?B?Wk5WSzlkSWh1OGlkNmppanMyR2RWcTBOTXYxSzRhV2l0aStiVVdjZzg2WDRD?=
 =?utf-8?B?eFpNQ1c5NGkzYU5KK3JEY0lEcmh0cllmQXpkYStrR1VneXpvZXM1V2FUK01X?=
 =?utf-8?B?dUdGWVVmTmFVUGRZekJ5bnlmTEErZndtTG4rNHEwdm8vS1lQblo4SkhPeG9K?=
 =?utf-8?B?eVJWTWxqdTJGSWRIUGQ2QWwyN2wwMllKR2FSZ2hVSmp2QUxDUFM1S3dNVWxq?=
 =?utf-8?B?OWxtQUZZZE80VSttNUtKOTdqclhvOE1BcFVWWTNMbE5DV3ZpbU9IWDB2RSt4?=
 =?utf-8?B?cmVwWnIvN2pYK3RpMEowNWt0bmlvQzJ1c2xUdERpREZ5TThWMW44aXRudmZ1?=
 =?utf-8?B?SnptajlCY1VHeWRldUtsQm93WmVKUFE2b2lLUDJuTlc5VGxyOWF6RHNxYWI5?=
 =?utf-8?B?M1JhQlhQc3pINzhqRThkUTlwcjRYU25yUDdUUHFJN1NxT1BaNm5ac1ZOcWYy?=
 =?utf-8?B?RUJQRElhcGh0anNmMkdIbHd6NlBwUDIyUUUxNTNZczdIUVp6SXlQc2tYSW90?=
 =?utf-8?B?N3pKRHBCMGIvSEEwdldIL2dMR2wwK0QrNmU0UzNuVFBBbllEQXMzODNIdmNQ?=
 =?utf-8?B?VDg0MWRvODNUZWlOdVJuWWF6Q0pxUlhqVm14VVgxZEJCcDFLa3oyOEZuT2VN?=
 =?utf-8?B?ekRCOGhPVjg3dm1QaGcwREZjajY2VmFUNy82SC8vZkc3VjkrZXlsYzRkT2tQ?=
 =?utf-8?B?SUJsQncrelJNVUpBbTBFVXJTcnFUZVdrRXRVakZUd2E5M0RvWmlPNDVFRjc2?=
 =?utf-8?B?dXRUUXlOUlp2WmNsVkg4QzQzcjh1ZytCY2g4U29JN21uVTBlMExJQWlRbitE?=
 =?utf-8?B?d3BzSzZtL1lrYUVpQ3orZ2txYVJGczYveUFMdTVuQ0lWODhzTHhkemE2SXNQ?=
 =?utf-8?B?WDB0TFJXbEYyWlRxTkN3eDc3bXMrVFJiR1VNTGxKUFUwaE43WGtNZXpuVFZi?=
 =?utf-8?B?VFB1V05ZYUFEMmtubkY4L0RCNjZoTm1vNmZZOE1DT3k2RGZ5VWtBd1JsWWc2?=
 =?utf-8?B?Q3ROLy8vZ0FyVHpxdG8zUVpKUEttYmtKOStjT1BNUlhJYnJ3M2lDTU5vY1JN?=
 =?utf-8?B?dUgrcStYU3V5WHB6RTA2MUIwVVhOeTJqbmVnRERVNlNzTGVHMmlPNS9rV2Rh?=
 =?utf-8?B?dDhTeVovYjlnUWZOWEh2K3prYWd1Z0FhQ0UxWWVzeHI4UkpHZEVHZ3JqWk01?=
 =?utf-8?B?ZTcvck0vdDF1ZktEbUFZVlEzNUNsZlVqa1E2YXNaN09tUGZOZzg1bE55LzlN?=
 =?utf-8?B?V1RXYVpUekZQaEVsanN2ejl0RzF1TS9rbXFWTFU1b0JHY3B3SGFIREVvakdU?=
 =?utf-8?B?M0RRN1hZMFRaVlRRSGhzKzlPMlhpb2xGQml6UmpQbHU0SFdwYmw1RnF6Um1E?=
 =?utf-8?B?TWw2NjBTcWRwQnBUeU9VQnRqYi9wdFV4b0JFYU9KNjJPZW5aUFVHS3RoOFhN?=
 =?utf-8?B?bXhNMVBRM2tybnJkejJOc2lRUXFmVTNDRlo0OWhMYTJUU3pNdGJ5SjhxRDhU?=
 =?utf-8?B?VStHRktlRG0vbVpDT3ZtTWlGclZDNHczTzI0UTJUeDNsMHZNdVpSbHVKU1p3?=
 =?utf-8?B?dGxyeGNKT3E0dEswRmVXRGpTWVh1UGVQalFyZWo4NHpsdlhJeFVjTTdVZWlm?=
 =?utf-8?B?M1FLZjRyd0dsR1NwU0VnTjlVNS93Z1pwa1ZQbU1LWmU4Q1FjZ0R5WWxtZzJi?=
 =?utf-8?B?Z0xnbmo0d3dsaUh5OXZIdFowZDk5U3ZsdVZGNmxYblpXYnQySmRqNGFzYStt?=
 =?utf-8?B?aE43TDQ4TzJhQ1JCSGhpNm5sVGZTc1lDKzhQOUEwb3E0N08welJWUVRKTlFq?=
 =?utf-8?B?REZUVDRnWXVaSnVLWHhkRko4aS9KUDc5NW83Y2ZnVmRvc21KOEV6MVY1U1g1?=
 =?utf-8?B?VUIwb3ZBNWc4R1FSZWp1blBmdndHdjdiM3djVW5OV050ZFAvVFY3NmZhYkMx?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81bd76c-193c-4baa-942c-08dc20c4ef81
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 12:22:18.4518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjkyrG/qENW+0y+7ymM7gGy6V/ASGjgZJGUej2BxyCxTVsWKrAgNHSnzbLMLJKUMCScvBnwxEEbqagnOHru+oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6170
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jan 2024 12:22:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14478

On 29.01.24 11:47, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> After commit 2586e10(start-qemu: Fix inclusion of QEMU_EXTRA_ARGS)
> the tpm was no longer added to the qemu command which lead to the
> following error if the option `IMAGE_DATA_ENCRYPTION` is enabled.
> ```
> tpm device '/dev/tpmrm0' does not exists - cannot create a encrypted device!
> ```
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  start-qemu.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/start-qemu.sh b/start-qemu.sh
> index 98af971..9ec0f1c 100755
> --- a/start-qemu.sh
> +++ b/start-qemu.sh
> @@ -161,13 +161,6 @@ if [ -z "${DISPLAY}" ]; then
>  	esac
>  fi
>  
> -QEMU_COMMON_OPTIONS=" \
> -	-m 1G \
> -	-serial mon:stdio \
> -	-netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 \
> -	${QEMU_EXTRA_ARGS} \
> -	"
> -
>  if [ "$TPM2_ENCRYPTION" = "true" ] && [ -x /usr/bin/swtpm ]; then
>  	SWTPM_DIR="${IMAGE_PREFIX}.swtpm"
>  	mkdir -p "${SWTPM_DIR}"
> @@ -187,6 +180,13 @@ if [ "$TPM2_ENCRYPTION" = "true" ] && [ -x /usr/bin/swtpm ]; then
>  	fi
>  fi
>  
> +QEMU_COMMON_OPTIONS=" \
> +	-m 1G \
> +	-serial mon:stdio \
> +	-netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 \
> +	${QEMU_EXTRA_ARGS} \
> +	"
> +
>  if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
>  	case "${arch}" in
>  		x86|x86_64|amd64)

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


