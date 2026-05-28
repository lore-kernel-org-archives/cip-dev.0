Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC797CD5BD1
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 06:44:50 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5194.1779950688586135433
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 23:44:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yNzk5/Sp;
 spf=pass (domain: siemens.com, ip: 52.101.72.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pd1yWP05l6MltV+5NTnMRg5/euyfPri4dpPttOv1dCP+QTUre7UnR2Iz5LJSSsLwfXOp4y5XnSm4tXG9Bz4MOLTmX1UDVIe83zTF5/PY3IajxIUs26j7Sx5iQwliALoKv3xz8gInIXlRhlLdbr4NiGPAYbPQ2jcWwMnPXEGEMwS8BnUpCBn5iNsH2b72rCzZLU9IUyR9wkaTX5Zwbzw90NVXdKRxjRU+imvw1f/uL6v51xxp2+1upePF9Arnnm76xY/CePp54nSlyN3sqEufFK6QGniujEK01oTpHwvK5RHRsn20GQbbUpvnOYBG9lWnjrGWvJmJ0IrZyPcIr9xhTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/upPvapbZ9RoOJWtn+zlHX7LlGJi5+E02makClvT9Q8=;
 b=ODpstCkIynji2A3eClWrExFZgzEX32G0AOvr/MEoM/MHwPc5VEfmorj5ufDCVRr8C6kiTnnwI20IPUTJDp+g89B15rF899Zy8bG7Ti2/RjD4teIAcwWmGEuEMypjCtToE1dzLl54dd2Fqmx2y/wXrxXu+ezf7ph+4eaBhJ5TfFKHQIkI9b6gm+tiJ7EdA1r1F5Z0W5rZilH39PmIvjxqsaJVSx++CXYD0xtm3YIofm3tQl7gJUyI2DE+sQMT1qwOQlH9FVDbuo2xfm7Q9kBKMWYgCWvdaIjmGx2OTFqZJmrpVYJz1ZPzrc/JN34LcEDEsEGSHTtEsM22QAj+6CcblA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/upPvapbZ9RoOJWtn+zlHX7LlGJi5+E02makClvT9Q8=;
 b=yNzk5/SpFblQysZS+4rfvsxE5rg87Wyg8ovhKbaQku5X5EBltl+Q838I/B6jFaWJUaN6yl6QO0anunzCSXEdig7it9vkOjcxOC6roLWMu9zoRDghDa4EwOxW8fhbUajdQ40HmU/G9qR39h/MQVKlKLq9zyYq0k4fI2L/7uJCGgSJtsN4KFax7aOBDIRr7TBbEueXEPwbapO2m1zJQ2s0rSrJiLMMwI/u5JjmEye2+6j9WmYHGGFTsrLMPBhzWpJHy1bJVNq5omD2NpNVCmFUcFbUsc4+IfxjURj560VCxJeTPZqsb1zpOciP0jnJFGxf7i1bex+EIBgCD8nbn7yh6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8999.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 06:44:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 06:44:41 +0000
Message-ID: <f836dfa4-7eaf-4b3b-be00-755b7bbcae0e@siemens.com>
Date: Thu, 28 May 2026 08:44:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/1] chore(factory-reset): make btrfs
 support optional
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260527091648.764283-1-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260527091648.764283-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eafb278-ca0d-4cb4-6f28-08debc849818
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|55112099003|11063799006|6133799003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	hR6+mqmm58knkPHbq9oOB44ADmC5JTk2bXjHe++J79qYQkTc1nht90ZrhwvAtQT+d0F79Rxpd6f2g0ql3Vh3SYeBo/DXNshT6EenepZ2P/yidfo/FJyydsk2BJ97OeAhefjTOYIZf+o01mVz9Lk3KvCgIgpWlThRl1WDEPQMDSGIujAJbqOsTQbU1moMomQphWJR/A9HJsRLMuDo3Yz2HGNXXpfrMY6vsfDaRe22ZuCdqrTsXBA6MdTn86E68Qh3yO6WnQ+fzgfbxbNGvYFSiIg0DBNhowaeZa0T9KefKxW10AN6n+PtOOE2ZVAOHwAm9Y9wQqv6bJB+fm+09xQfUM6Tp4+9emOB7lMdXNKkq7WyVdsxCzoMc7fpe61WNZWbdDedhDLYqcNvmpjAMuCQf6pbjSKj+uIBc7gBus8uhxi8G3uDDTtGlZzKsf+S1SmDP/UhDCPBIf9Kb+wVgP9u6nYS6jBVxFSShQFosGHq5P7vvkk8iQY7dnarBIPP9O+dTBKt8E5uNIgRTAN7U+QpVUPnBvu4zNaRPsB96lrA1UMzaMjinNskKPGjlzm6T6WvS6rSzQSRoKEDTSLz0UWZz90lxooS4LEcvoiDO7MCRAx6K9GwTq7+fWItnvDFnQTUEXFYZoyg5//feUKSLxQjplvM90FOA8AUB6OsRn1KDQvZdPvoQdDE9oheaFFHvW8k
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(11063799006)(6133799003)(56012099006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dHVTOUNNZ3lsbVZVdWNVa1Jrek9TRStMaUI5Q0xNZW5Xam91MlJvdis0bXht?=
 =?utf-8?B?SHViL0ZOWmQ2b1EyMVNWL3FRMVdIbGNxVHV6RmdiM01yS0xOL0ZoQ1g3dCtM?=
 =?utf-8?B?OEVIZ1dRVHZMd2FGSHpTQUp5Sk1raDk2eUFiZFFFZU1CaXFXYmdkR3JnMElu?=
 =?utf-8?B?dHJOYVpXdXRPbThRT012S3RDMDZrVjRTd2dBaHpYRVdDajJ4SVEySU52Nll5?=
 =?utf-8?B?d3kyWU8rWCtQSTdIc2FLU2VPRHJrZGlzWG5ITWtza1lTb1QwcFY1ZU1Rakcz?=
 =?utf-8?B?R2JWRUhlbGFsZHF3MU1ET1JJQk5jeTRtRjhJZHhXS0tiNDdKbGdTelFSQU9v?=
 =?utf-8?B?VTdxRlFTWkZqeFFUTDd2U2tYV01oS3RaRlpVN1hmbGw5eTdjY3llcytlQ1Mr?=
 =?utf-8?B?cXgwVGhqZ24xLzFTTFNweEtYMHdEWHhVNGNaOTBuS2VjNHFiQkZIbVBGeHB5?=
 =?utf-8?B?ZGE4bkIzWU5wbWI2NHZ0bm50UHlpV2RpT0ZBOE9UNzNVK01GSEFYdnNjUjhY?=
 =?utf-8?B?RWZlR2VCeWtaYVJpbngrS1Z4QmIzblJ2THl3dnNOdjk4aFk5N1FHVUFyN2RS?=
 =?utf-8?B?TXhJaCtQb25BVFpEMDJJMURMeUdzSGdOQ1AwK2pwcWlwN0tLcTN3aVkzU2ZD?=
 =?utf-8?B?Z1VOWk5mTUI5Z2xpQURWbFpvUEhUbUhZRFhadzRwUlZQc3ZkSzlmNWlWbVF1?=
 =?utf-8?B?djNqWTg3VUdaRUxUcEw3YjEvd055LzQ4TmNKdDlIOVZxNy9TNXRWUWo1cGpT?=
 =?utf-8?B?dHdxNVJvZVp6bE5oT1ZQc0hndUYyUmxWVkczdkpadXJ6VUp1VkxlekxJZlcw?=
 =?utf-8?B?K0ZGZHhlV0FRVVdzM2piN005eitwTVZ5QUxHWkVlQWVuajRqZ3ZlM0dweFdj?=
 =?utf-8?B?aHI1Q0ZkcjdQTkJ5dGdLdDRWcmRKOXd1T3h3cG5ZajJJbEg2MnhzM2xyaUNr?=
 =?utf-8?B?bnFDMkpzczRzSE04ZnAzZFUxcDhIaEJZRHphVG53WVV4QlQzMEVMZWVNditB?=
 =?utf-8?B?cFlzcFB4TExCZjRpOEJLSzlOdldsaCtpS29DWXprRWJzUUY4N1dPam81L3dU?=
 =?utf-8?B?QTB1RXVnR0U4eWJZUVFhWnFLYlliRExiQUhIdmRKd2krNEtzN2ZDVHJ2bmFW?=
 =?utf-8?B?dnBRUUtLa2QwS1p1RTMvWlZoYTdma1BCZk4rbElnTVJuWTIyOUlrUTRoUnA3?=
 =?utf-8?B?aU1ycnpyOGE4SWs1WTVyM1I2R051UnQyY1JkMkk2VDJ1ekRqcHBwemhGanNj?=
 =?utf-8?B?V2poNDNBdVdsdHdYdDh6SnNlTlpxSHJtUlJSK2tJOGdlK3I5bWhBL1pKdWtZ?=
 =?utf-8?B?OHJTWEE1KzgzdHBBb09BYW1oQVdhbXVkMnA2RkJ3Zlp3SzFzcWthWGkzay82?=
 =?utf-8?B?b1dhRjN2NVlVeDBOdkV0UkRzTmw2dy9BQnoyOFFmVVpWQnNJZ0p3L0NIcWF3?=
 =?utf-8?B?NUZSNFlQOW1CVzBBSHRra3lZSlFGK2tmMEVwMUdhU0lrR1BYMWRLMjQ4WmxS?=
 =?utf-8?B?cXNKMUxoaWRuenhrOFVlWTFDUCtyVTk5QWczRVdKMXZ0dXJ0MDB1TlY3NXow?=
 =?utf-8?B?NmhsM1pYeTdURGhCbCtIZStHOW9DZGNQMEVsTkhQZkY0aXJBekJxWjR0NjJE?=
 =?utf-8?B?OUJlTmZWUU5wZUNjTmhWVVhQNktRdWtMTFdtRmh3SkRWaXE2RHBwTVVFblBl?=
 =?utf-8?B?ajVPeXFSTXRjNjJjQjNpKy9Xb3M3ZVA3YkRCK0xYb3hvTmpualRFdXVSMWRn?=
 =?utf-8?B?RDBERHhKbmh5QTRHUmlNaTJvOTlpUE9GRE1YamdGS3hHSkN6SjNpUHNGSWs3?=
 =?utf-8?B?WEVtblQ2a1U1cEJlUndyaDBQVHArZWVvek82T0hlWlpNNzZlTXJFMUk0QkRV?=
 =?utf-8?B?WDExT1c5c2xSaW4vYVFJY3J1cHI1TTMvdXRqYmpDTVptSVhhQnlFS2YxOHpa?=
 =?utf-8?B?bzFZUGpMa1ZwelpNaWREaDM3WE4ybFBLY3pMWStMQ05CclZtSkJXSGRtcUhY?=
 =?utf-8?B?SExmWTNwNW04TGdZNHlwaWVnc2t5Tlo0QURlVEtyKzdQNGxqWWJMVlFpc1JQ?=
 =?utf-8?B?UGZHVGE1V2ZScjZmMmNtRDRGMVgwbkUvb2pnclZ5TG85YWxTTGpMbSs4U1Fo?=
 =?utf-8?B?NytucDBvaUMveCsxcm9CT3RwbjQzUXBuQmpEL2x2eEk5cDFKbDh6cDl0RFR0?=
 =?utf-8?B?ZlJFUWdSWGNEVW1NMlQyOU5hR1hITDl5TWQzd3d5Nk1CMTYvb0Y5ZDllQkZB?=
 =?utf-8?B?VWZSL004YjM1SnNZTHBPU2RURW9UYzVvdHhyZGFlTnBiUFRiRnpYTUhTdlp4?=
 =?utf-8?B?Y2o1VzVxL1NGdTFKalpjYkFNTUFKcEJwdkI4Q3ppVUllUjhSdmRGZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eafb278-ca0d-4cb4-6f28-08debc849818
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 06:44:40.9235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfS3Yxn/G8FtHplP9Fm8xMnL8f43BuhN4a6Hhx9NWUj4uHCaO6dvyEDPJ/FiQ6QVmViL9cE111fNVbQasmHQGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8999
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 May 2026 06:44:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23032

On 27.05.26 11:16, Felix Moessbauer wrote:
> To reduce the footprint and attack surface of our images, we make the
> support of btrfs in the factory-reset initramfs hook optional. By that,
> we extend the interface to also allow support for further file system
> types.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
> Changes since v1:
> 
> Rename control variable to INITRAMFS_FACTORY_RESET_FSTYPES, make it a
> list for further extension.
> 
>  .../initramfs-factory-reset-hook_0.3.bb             | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
> index e962a51..670725b 100644
> --- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
> @@ -20,6 +20,9 @@ INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??= "ext4"
>  INITRAMFS_FACTORY_RESET_CLEAR_TPM ??= '0'
>  INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?= '1'
>  
> +# to support factory reset on btrfs, add 'btrfs'
> +INITRAMFS_FACTORY_RESET_FSTYPES = "${INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE}"
> +
>  SRC_URI += " \
>      file://factory-reset-script.tmpl \
>      file://reset-env.tmpl \
> @@ -35,14 +38,18 @@ TEMPLATE_VARS += " INITRAMFS_FACTORY_RESET_DEVICES \
>  RDEPENDS = "factory-reset-helper \
>              initramfs-cip-functions"
>  
> -DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, btrfs-progs, awk, \
> +DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, awk, \
>                      factory-reset-helper, findutils, initramfs-cip-functions"
>  DEBIAN_DEPENDS:append:encrypt-partitions = ", tpm2-tools"
> -HOOK_COPY_EXECS = "mountpoint findmnt mktemp rmdir basename \
> -                   mke2fs mkfs.btrfs awk blkid rm get-factory-reset.sh \
> +HOOK_COPY_EXECS = "mountpoint findmnt mktemp basename \
> +                   mke2fs awk blkid rm get-factory-reset.sh \
>                     chattr grep find"
>  HOOK_COPY_EXECS:append:encrypt-partitions = " tpm2_clear"
>  
> +OVERRIDES .= "${@':btrfs-support' if 'btrfs' in d.getVar('INITRAMFS_FACTORY_RESET_FSTYPES') else ''}"
> +DEBIAN_DEPENDS:append:btrfs-support = ", btrfs-progs"
> +HOOK_COPY_EXECS:append:btrfs-support = " mkdir rmdir mkfs.btrfs"
> +
>  HOOK_ADD_MODULES = "efivarfs"
>  
>  do_install[cleandirs] += "${D}/usr/share/factory-reset/"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

