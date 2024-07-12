Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30874C2BD09
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 09:33:01 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.70])
 by mx.groups.io with SMTP id smtpd.web11.3967.1720776773980696929
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 02:32:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XYDYUbLJ;
 spf=pass (domain: siemens.com, ip: 40.107.247.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxcbaWSkbelJ4A5CO+2sc9HfWz9PNHCQrwmj6WXP2AJp7mVzmdeTt3+pT6ba6MflGtUEls8w2PI/u/97DGgF/QAgQXP5WQ0C0YDrb+ARYaTMG9nA94IB+uGopm9Qeg8G1Rp4MwLBHZL0imJ6XFmVfnnYAZRz1mp7JHQlP3GkUoYGlyojaxfZjf5pgbDiYlZ136Nty/KoJeBfaUHjBSj+4Zoi7Y3uPDc3o+tp6IsEVsmaSvkCpK/Dk2Ln2NJ9s097hfuiqRli8QjjRx6tLRfqqhHXtG+lAntl9aQgck3iE0IPBhYDfr5sIVVapGpIVkwL+JsowpfuRDPcXXrlSTTYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5KbR23Tel9XlJAXhhGm3BC7tjzTQxoxYWbrscMD0kg=;
 b=iFM9Mbfy8W/czxmOVSBueYW0eh4K+7L5xYNZYbK8eNQS6ZbwFeowxEF35JPIRQ6Kaj3kxHk8m/jc3qCJPkGIEdWhIvix980eeMxzFhT6Yom6Cm2RIswhQsyH2JcSpGgbEef2m9TqUy8NKJ3a4lgs82fmuD9rNDLLxLZKjawZPtZ9VSaMfFsUc9xO2NotSQ0fySLNJuHmmJN3s9SpCyMfxe0FHJuJuivMP83iWnD37g4HKISPrtUFGp7dvm3gcQoFETsFyI7uqW+R996evK7C/NTepULGvOEe1FCtI2YGQLcl+qWg7H4u2qGZQA3VfYZZc3Fc1ztYVEKR1xrQJKvmyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5KbR23Tel9XlJAXhhGm3BC7tjzTQxoxYWbrscMD0kg=;
 b=XYDYUbLJiufBC6FIYcuwli+wyJn3L76TpnruIVRT+ar3xa4F7gd2GaLB4Ql/ww0LVL2UNDNCcVtpMak/i0NCC7pGOrS6BRjEeOXY1mPh/ph5Q4Uqw/P9VlcDKOsyJj9GddjHD1lgyBC8SmmveSn0iZij8Nw0UgEoscTgSeczlUHZU8X5Ii56eXAI7J3nRHpcdR6vKbzuUgIuwPw1+F4HBCf9H0+2RmWPVpLr2yNXNoaRR67aDRjMEkUIHoW6gSux+dGjrVkwvz4YvB6wfJK2RsZUtPoWEGYkWAC7mN0jp/VQaCQlrCZbX3f72KyuJDx6wacYMAHgBNyCUDPaE9tNpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GV1PR10MB6561.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:81::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Fri, 12 Jul
 2024 09:32:49 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 09:32:49 +0000
Message-ID: <79534275-072e-4209-be09-89160c566151@siemens.com>
Date: Fri, 12 Jul 2024 11:32:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] initramfs-crypt-hook: Do not attempt to repair a
 partially encrypted filesystem
To: Stefan Koch <stefan-koch@siemens.com>, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com, christian.storm@siemens.com,
 michael.adler@siemens.com, simon.sudler@siemens.com
References: <20240712081143.1376952-1-stefan-koch@siemens.com>
 <20240712081143.1376952-2-stefan-koch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240712081143.1376952-2-stefan-koch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GV1PR10MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c144046-0699-41a7-1251-08dca255987c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WllKSFBhcmRUQ1poZjczdStyNUxwVFAvM0pMenA2emk2SG9FaHM2ZXBKWWZw?=
 =?utf-8?B?Rkp2MXFBdWJsL0FCL3FwSVFtM0w5S0xKako4MHhrTHU4akFZcjYrYmlFMlV5?=
 =?utf-8?B?KzFJVkcxZzIvTVY5enpDU3pzV1BDK3ZQbGpqV0laQnhmaC9YWC84emtDK2NO?=
 =?utf-8?B?c05JVFhHd0ppVFNoTEZGVGx6NkF5SkZ4NS96RWxuc0U5ZVFnMFEzUU0zOXZk?=
 =?utf-8?B?Tmh3a1RBcnlQQUpUQjhwdUdJODJuSnp5c0dvYklWcVZPdE5vMTlxSGcrS3Mw?=
 =?utf-8?B?ellCRE01SnNzRHQ0MHZ2dVN6VFZsejA0WStuTlVtTldPZVZFZ20vVldOUU1O?=
 =?utf-8?B?djVFdlMvYnUybWwzSXQ4M0JKTmI0REhKM2VuRm5xT1dXT0JHOUpLYU9yaitI?=
 =?utf-8?B?NUowL2E2QTJ2MTlyMWpOd0R5cjc5S2FiTWxObmd5SytJWDZPZExBSmJzNUdn?=
 =?utf-8?B?TzZSaDI0N2ZKNW44S0RGSlZyVGZjeVpQbUFnVFZKcEQxa1FzR2prRllUNUJ4?=
 =?utf-8?B?d2pJcE9zUHJhRWVNbTlFWWYxazJHK1ZoT0VKMEZOOVR0MjNEeXlEaHJYeC9W?=
 =?utf-8?B?TUV3bDdBOU5Oa1lYYkFqZWJxelJVVUpWVDJJd2ZpK1UxZVloNm8wUEYyeDJX?=
 =?utf-8?B?VS9Ib2xDMVI2c2tOVmRhaFlKZlRlZ2dHVGRzSDZ1bkhtZ3JQWU9qYjZzRkls?=
 =?utf-8?B?RUlHb1I0NXRFUWxOYmF0d1JYN2VlOVRDOXFvb096MkpDdnpzdlpyZ2gySUFE?=
 =?utf-8?B?QXhiRThwU1lSRnNiSytpRW9mQWpvNnpCS2tYY01oelpValhKTnRYL0wrNU1B?=
 =?utf-8?B?Y1FueVBSaU5oL3RadnJlWTRERmtHUDNTSm1NUzR2Y2dLWFl1S3JNallia3Zx?=
 =?utf-8?B?S0oxSzNhQjU4WGRnVlF5Rms0K1MyYUVlanpjTmNETElYMlRzWVdDMmVoaCtK?=
 =?utf-8?B?WUZHOHpxMkswK0xXOUhzOHBMWjFxRG1yYkJaVzNMZWF6cTA5VTEwWlEyNUZY?=
 =?utf-8?B?NTd6MUNwSEROekdha29PaG41MlRsSWxMeEFPUE1YaXR3aTFGSE5ySFc5Z2Fp?=
 =?utf-8?B?a1RXWHM3enJrSnREbHE2RG1uU1ZGYk5NaWFMbGswRTc0Nk0veWd5UUtYbGlh?=
 =?utf-8?B?TUdGdE4wYjZFNEN0WHJRZUtJdFJxVjduS1l3VkY4SHFKWStFSjQxZkNsZ3V0?=
 =?utf-8?B?R1NrQUdPc0tDTkMyRmRRUjEyNXVHckxxaE9oejhsRjh3enhyVSttTDFGNE5j?=
 =?utf-8?B?RHVzTHpNUHM3ZDRHQ3R1c2VSalpBSmltUjlkWUk3TGFoUXJibm1FaWhtVTdW?=
 =?utf-8?B?TzJIR0xIY0ZsQW1QV3d0aFBvdWpSSEtQajhZU25oMFVic2NrZVE2enBTajRu?=
 =?utf-8?B?OEpLUkcyWVdscGdNaEExaFJPS0YwczFVclZNMklTMnJUSCtMSDJDbHRXZG9q?=
 =?utf-8?B?YXVQY1hJNVUvL3ZkZ0MwMVlVdzdIZHhxNW5EMHJVU212d0VvUEF2RmtQdG50?=
 =?utf-8?B?VStOYmhWRTN0U0pZM21DYnhGMlBZdGttNUpSSTg0NFJpTmRrNUN1Ymc5Tklo?=
 =?utf-8?B?N0V1OFJGQ0pyVFo3dXZZTWJ0emJBN3EwcVpLeDA4T3JZYzdzUnh6cVNSeW9Y?=
 =?utf-8?B?MkQ3NlhLV2JrNms0dVJKd1RtT2daam4vMW1EUW5EeXV3WlVnSk9Ga2xGazFZ?=
 =?utf-8?B?RHEveUV6WGlXSDNiRG5hSVBZS0ZuOUVnUlQwRm5jbStlbFJYRlVXNURyVUhZ?=
 =?utf-8?B?VDBPMXN6aXBvdXVoZWQzbm41U2J0MlBoQWNPU2NuRVpwTEVzQXFJMDdnM003?=
 =?utf-8?B?c3VFTllqc3NRUzB2RmQwdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a3JUN2FWOWNEbEFsbW1hQU9jQUVKTVZWQTgvZ1QzeDRuRVI5c0tPWUJldHd3?=
 =?utf-8?B?dllBT1hCR2NIVGZaNElBamRVSENPbkI4YWkvd1dwSjBES253RWMrTFhNemt5?=
 =?utf-8?B?MnprK1lxS0xYdGhYdG43bEJLOU5RMU51RXVRSC9rN21ib3ZWUmJMbW1FcTBX?=
 =?utf-8?B?bGdNVGx4Mnp3ZDIxbzBoNGFaUDdHQ0RjM3M3eS9yalJ1d1pLUlhPV2wzVHk3?=
 =?utf-8?B?N0gwcTMwTFY4ZnVFRTVCazRML2g5czY0VGVldW5NdCtGTmZ0c3p5ZFVtaFhl?=
 =?utf-8?B?cUtzOXVHMlJaMkkxcStMRE9OKzl2QVp2R0U1bXRhNEpjU21kL2xZS3JSS0tP?=
 =?utf-8?B?dHJNS1Z3enYrRnd1VytKTmxIUUxGWHhlWC9UU3ErQ2VlNGF1WTNSUXdxNXd0?=
 =?utf-8?B?anV3Y1NOc1B0T2pnNFFhektxWTVxQnBJdkFKS2g0bElZU3hRcSs3VDNtMHUv?=
 =?utf-8?B?OC9NMEphL2tycTRjZHQyZE0rT05pRy9DOXc2b0d4U25KTzhZUC81cFp2a0pY?=
 =?utf-8?B?dXBKd1BRL3orMGNPbEZFVUI2cGczektha3FKM1JmTUhrQnJJcEd1S0Yzd2tO?=
 =?utf-8?B?SHRnMHNYREFpNVRrc1RFSWkzZW9KaVk0ejN6QmV6ZWRuOU5iMkVpdThhd21n?=
 =?utf-8?B?R2t5angzN2k2YmZNOG5vcHRsbzdGeGJKaVc3STB4TVd6MEhRL0Vjb2Jka2xI?=
 =?utf-8?B?UUx4ZXY1cStsYXhPZEJIdkJ1ZGlpeGpneEtpdGFIdVBPV0VCNU9PNlJDbjha?=
 =?utf-8?B?YU9GeDVLUHIvSG5PV0hmMDA1cU9vNjR1bW9VV3N5eEVHOUUzMDdxS1FDcFVR?=
 =?utf-8?B?M3BHTG1jVXYrOHp4cnhKdUpUOVp3TnFLS2lHeUFqV3g5eEpTK0MwSnRoQXR3?=
 =?utf-8?B?NndMQXoyVWxuWXpXZTFCSGkrTm8zTGhkbmtmUkRKemdvLzYyZllDbXY3TWoy?=
 =?utf-8?B?M1JBMzB1UmdIK05xbVljNlNMY3JSYWo5bzVnQjRmWkNoZTA3QitNL0JiT2V0?=
 =?utf-8?B?MjBnVXZ0SXF1ais3K0FOMXppbi81Z3pCOGFXNTdGajhWaHRWZGFjMGo5NW82?=
 =?utf-8?B?Ti85SkhVeFdORWFxa01GQVNDRVBLcmpPaFFwZmxib25SYS9IcXpiejhyeGpl?=
 =?utf-8?B?cXVpSmtYOEZYeWJSWlcyUlora3JnQTVTZThiVitTeWRMQW9jZ09SeFZpdHRG?=
 =?utf-8?B?a2IvY2Q3TS9hZnNwS1lpcmtlUjdWL3l3SGd5Tlh6eU1uUHNxMFh5NVlFd0to?=
 =?utf-8?B?ampyQTBsTnhZZVE0ZVMwVGhYbHkvTS9ESEx1RDd2N2VuSXMrVU1qMlFQM01V?=
 =?utf-8?B?Vml6MXFFZ1YyVTFmOUNvbjFaeVFoSUpkZDNQamhEOUJDdXdseVRNUGloS0s1?=
 =?utf-8?B?bzUxazR4c3JUY3JjTHZmL1dpSXROWHdNMDlzK3U2T3B5bTg4QkFsUC90Z3Rx?=
 =?utf-8?B?NTJvbEZHTGRIWkFUNWx5djFBRW5nY0tzSFB4azhxTVdYVk8yRFI3c2V3YWUw?=
 =?utf-8?B?dTBoYXNVMXdiTVdNK2NhRkFENnhCMGRFajE1dnVlSDlZQ3lBa2Qxek8xYXlv?=
 =?utf-8?B?QlQ2SzU4SFF1dlJpZ1NtSVdQZWxPbTVncnY4eklnKzZMRmdHcEF5U1pEQlcw?=
 =?utf-8?B?VWJ3aTMxMkhRSncxcWw1elI5eU1SeFFpbTFseWhGSWRSNGp4eTYrbGxoaEkx?=
 =?utf-8?B?NTRBdzBZMVEremZZMXFnRWtBbGt1amU0QnpxNUs2a1FWZ1RzeDJUR2Raa3hG?=
 =?utf-8?B?MHZrTVZNSGI0ekpvZUJyQi9ySkZxd1NUUVFyeGxpVlZOekdRQit4aGFWSjNS?=
 =?utf-8?B?OWNERE9KUXNWZDNuM25XL3N0Y2FaUkc5SGZRcmJ3L09pSFY2RjlOeDBTRnA5?=
 =?utf-8?B?QVVackF6U0FiblJ0ZDdKd1pvd0NlZmVKQWdsY1U2bzRUOXJYQlNGSzZDa1Jk?=
 =?utf-8?B?MU51UjdXUHFtbHZFL3ZlRzkwNEQ2SmYwZkdGRVlxL0dXd3FZSlZZZUNVMWdM?=
 =?utf-8?B?OUxIeld2R0RJemZKTnV2SytJNlFJNVJEcDNTbEVXanRnR1V3OVlZeWdvWTNj?=
 =?utf-8?B?Z0xkNi9ZdWRqY2J6OHE5Q1JhQk9MYktuTEM3bG84dDZ1YlZQekc4dlQ3MlRr?=
 =?utf-8?B?SnA2T0I4U3hFbDlXOXRLU3BwR01GRit5dFphcHFmNHZKSzRkN1JCTU10cThk?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c144046-0699-41a7-1251-08dca255987c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 09:32:49.5168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUs82ktCFY9NGdx9eO7JGmiS0f0yKXHvEAVVY8OJAizHFWDYJvDBK/JzsHJflVbfoCKh5C4ZdanAQ3Vnqug+3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6561
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 09:33:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16468

What is a partially encrypted FS in this context? Please describe the
error scenario to enable a proper assessment of the approach to resolve it.

On 12.07.24 10:11, Stefan Koch wrote:
> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/encrypt_partition.script   | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> index ff4c135..f943aea 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> @@ -77,7 +77,13 @@ reencrypt_existing_partition() {
>  [options]
>  	broken_system_clock=true
>  EOF
> -		e2fsck -p -f "$1"
> +		# ensure that filesystem is clean otherwise resize2fs will fail
> +		# do not attempt to repair a partially encrypted filesystem
> +		# ensure that there is no attempt to
> +		# repair a partially encrypted filesystem
> +		if ! cryptsetup luksUUID "$1" &> /dev/null; then
> +			e2fsck -p -f "$1"
> +		fi
>  		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
>  			panic "reencryption of filesystem $1 cannot continue!"
>  		fi

Jan

-- 
Siemens AG, Technology
Linux Expert Center


