Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FDCC46467
	for <webhook@archiver.kernel.org>; Tue,  3 Jan 2023 16:54:42 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.70])
 by mx.groups.io with SMTP id smtpd.web10.69140.1672764874846072369
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jan 2023 08:54:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=PDbH9P82;
 spf=pass (domain: siemens.com, ip: 40.107.6.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+n2Ww7PXl75Fmt9lDXoVe+mfKs1n8EQtXb8d5SVLXymd1LYNd0StjECTuBYWZNRppK8xGcFuUxZX0rMcLupWaWSyqEHfr8lK37lknDICoTHRGy2cCcOjQyuXxg8sfHCU1bzTxpEtuqddBW17FR2iQmb/Wnq9OV7XrsmW5bQj8z7iQRXnq8WG2iJcrxpM2PIM9vg6eyC3etaEzuje/pX87YqZQAri9nvB0aIkMPByoZHRk4OqpukkXV64vdo1xHrDy+N+BabkjSQNI5ZY3JpkNO3SJ5DSH3LsPHzw6YJkWawTg/J/4+1TTLutt6fJ5pHIftZ+ZvxlpOaxzA9KrINTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoHXJfrvUeuDc846sskelUjoR2Zyt4BwVqd4vm7Rre8=;
 b=jgS6gb3cldDdfGpq00Pb+5i82Py8QrsjEfwYqmhzlLGLybXKyXZyaBS6vFYAoNLHehsES6lZor/0vnFvS3ffuzD0TeibpwqMpc0A7W6rnsU+N3Ss+oxbWQbO7FRSXhkITi4gJzq1k7ida97n3RB1A7eh1pW6YoUAGcUkBcIRHjGb56j6GoG+KYLVkG3N90vKFs4r8To/6LTC3Spiyv9B/lDkwWKEpsLtJg1RPI9jabMcC1khK70eLKdDyiUXSgWfULLujlsOlnZSKqqUCbPM/0UIl3soFl7vXlqH+P/iwmOqXRMpPLyFwxYX0Tq5NCq9U/2JmduVsBflOtF9rcrlAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoHXJfrvUeuDc846sskelUjoR2Zyt4BwVqd4vm7Rre8=;
 b=PDbH9P82Ksne2KQi0+bhLI1kOxI/yFeBmoR62MfeJm1NUwcd1IWcSFzm/bFM5epF2T02PY024WqfYy2L7A0LOnlsqYsEygrmnaUOT9jdVO+40ES9I1FV1DTZ7pWRFGTSseZcDpCn78khAzJTT48c+hH+O4Tb8SPEeuS01iSMWTGze+gKh0WNTpRS4Cipq2uGHtATijGVTehG8ZIeNqsHXbhrgtof9/HnfQU81yfCuBxVzfU95/dlzfju9k4RLQrjSf8ccBdMR/xVON0osR/DePR9XpxNlCevrCw+guMkX/d0pWfS4jA+e0caf3TX4e1YpPQezw+r7Iz3N9E2eqeXjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7133.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 16:54:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 16:54:31 +0000
Message-ID: <9ab8ffb5-cab6-3fe0-ae2a-df9c2e5f772d@siemens.com>
Date: Tue, 3 Jan 2023 17:54:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [isar-cip-core][PATCH 6/6] change-root-homedir: split root home
 move into own package
Content-Language: en-US
To: Henning Schild <henning.schild@siemens.com>, cip-dev@lists.cip-project.org
Cc: Wang Jing <wangjing@siemens.com>
References: <20230102170818.17689-1-henning.schild@siemens.com>
 <20230102170818.17689-7-henning.schild@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230102170818.17689-7-henning.schild@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:610:b2::30) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc25fc9-1652-44aa-7ce4-08daedab2f1e
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Hh7BG/Q27+8rq5K/P6Ml8q90J8yA9cZMr5RY05U2jYeccBSusyrL3n9rmpJIDcRb0RDDjo+tfigZn6y1i7zf1kCBRxtgKtUlw0KYhr7y68U6d7ldEnu2ayKALp2ZbCJSSPZHJejOpk4lmIvTTlBG2GXRNygrotDccQl98kVlgi7NeoUHCwnEmjTGdIv0KfpVaxjgZLc2NI7dIw1Is8HHoRlqK8nttk7kxxagQGoMNx/Gq25vrtlsxGFErQ4y8mz4RUJvIwSxMChOnNn+5NcJAq57Ce/Z9pNwZugFa4M4rcqw+6dfjRKzkzPNC6JNWs+Lw2CB8hEY+Ovb6+kPQzw6Wx8k7GS6A2dfQFhphiqFPkerGp1bgWHzY7zLt42DhWMlmfkD7cEOebHwmGPoTM7HM1olELKOu0Yp5L3btLxqoXGBq6Elovge1scrZXngH5Vw9qIEC2Z26CTYHbfMhe3CRLET/AEbZ6QwH/jUFqBZ8k6ebYUBt194I9pg6A9Wzuim04shtNcFdzFXALYgz0/TZf7h3k0epigUVzHFMSO/UrpO0uK5Oa9tYi0rzZ9PY3SyKQ+UA8ij1Cb2L0CsGCw2o7TNRmKJzOV4y7f4OSTBtyKUl//YByGrzwR9KdZt4UZcNV/jfNQYYHXRF0WcAndrMHhodCmFdudyv0uANJYU/XhORv7QtQ4VbRJ8ms/Gkb0DRFQ0Bzk6MAxBfCmPoxVEvfW6OW6ewRGwADXM9HU2jbgg1CyazU/CDgAIB8+mkErZ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(186003)(26005)(2616005)(6512007)(53546011)(38100700002)(82960400001)(31696002)(83380400001)(44832011)(36756003)(31686004)(86362001)(316002)(41300700001)(8936002)(5660300002)(4326008)(8676002)(66556008)(66946007)(107886003)(66476007)(6666004)(6486002)(478600001)(6506007)(2906002)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eE56OWNzVkdUaHVNMUszb2I3TGtqVWpjcXowMlU1V0hWcFlFSlNlc2tGS1NL?=
 =?utf-8?B?dnlaU3ozMW04WDl2dXUzYU5ScXNJWEpBM2oyL1BRNWtTTGRQZC93S1pqcUxL?=
 =?utf-8?B?M2RGckx1UHJRUzNKM0hacm1TK0hsck5rNW9ZZkUrdkMyQUROemF0a3dnV2JE?=
 =?utf-8?B?U2plN1d5QjVDTEhuY2tuWlJGQnQ4d2hzdFozblRlK3R2VEo3d1Fxcm9FemVH?=
 =?utf-8?B?aFFCRlhUYnozU0czUm0xUnVubTVWYmVObld1RFprRG9YSFNra1JWWm1vTjF2?=
 =?utf-8?B?VUpHb2FRNXRTT3FuRGJOMFc5Rm5Fell0d0lnT3crL1dldkhhOXNoWm5FNldG?=
 =?utf-8?B?SDlnRjZlWHdJbm95NytBVERkUnVScXAvR0M1K094OGtMaVZjQWYyZnpyWDZS?=
 =?utf-8?B?Tk5acG5zUWVYMWR0bENJTE1VNGUzM3pNcnIrQXlMMVZGSzVDdWd4c0NyeE9i?=
 =?utf-8?B?dTE1V0twV09VOE1JSTVVTFZLcVVDZUpqTWN2a21KQ2pjd3JYOGNkbkVpTG1j?=
 =?utf-8?B?aEc2VnlSQlVtUEtxaUpOTlo2ZXIzZkMza01UblpQQjQ5RG9oSlpJZGNFeGN3?=
 =?utf-8?B?NXZnVEp5YWpPbWpFNFZNeFpPcGRzVDNBTXFHOFpFWXd5MWlYUC9FK1FzRkQ5?=
 =?utf-8?B?ZHc3TCsvOTBMbk94ek5lMnB4VytKTXVkQ2VQRFdtWG9UT0JjNFgvSVl4SHdU?=
 =?utf-8?B?VGduZnNqQWxCdUIvdzVDdDdFMHJTa2QvZVRhY09KZEthLzdacDdrZ3B1OFAv?=
 =?utf-8?B?bEVUdXYrdkF3Tk5RY3NDdWF5UU1BZnpoWjZRejdpNWVjaW43MWFUWlBxdW5K?=
 =?utf-8?B?MmlDbXZGQjNhRDdRL2RXRWJ0bXBpZTByQnB3SEljcjNENmV1MENrZlNLcU9w?=
 =?utf-8?B?Q0lua1ZGMzJUNnRxbXBmOTZ5b0ltVFZGZHJwem0wMWJWQTh2MXlhQlJNSVBZ?=
 =?utf-8?B?THorUk1yelBYOHVPTGhHeWg4UW9QeURyNytKTUgxMFZxUmMrVmdmL3JoSWdB?=
 =?utf-8?B?MkpXK1FNNTVucDI4b3gvS3VVdnpJSmZMaXdKSFVSc3UxdjNwblI1OVZtVDQ0?=
 =?utf-8?B?Q2pHYmpZZGxPT0tzSldkbjc3VjVxWGhKdFU5Wi9oeFJlM3RwTDZKa2ZrNFVl?=
 =?utf-8?B?MWQ3aE10Y0NhMXdiMHlXS3pjOEdZWHAxSTMwZmw3Nm5SeGdoNjd6NkZlNjZa?=
 =?utf-8?B?d2phclFHZ2hWNmxIRzJxRUduQ2h6YWVtZGs3VEdlMUVseC9aeVErSVpkMyti?=
 =?utf-8?B?SXM2TFRTdk84ZGpGenpTUzhDd01qQ2F0aUh3VnlYQVlSV3dGQnpjckxsKzhj?=
 =?utf-8?B?TzY5VE1LQ1dodXRuS3pEOVpLak5DMnQ2ckx4dDc0eFV5ZXd0cDBlbEVTQW1E?=
 =?utf-8?B?NmdaVW1HMTRuWWN4Zmh0UGFBTjdYU1JmU1p3UEVQdnl1bnR4azVSK2ZDM010?=
 =?utf-8?B?RWxoRU9rQTQ4TVgrMTBMdkxhNzFiSG9ERHdiU2pQcnlYUVUxdStqVzdlYWp5?=
 =?utf-8?B?RzZoVHdhbGYwOWlnY3QwZ0E5QVIyeXdROCtGS25xTDFvRnZFT09aUCs3Ryti?=
 =?utf-8?B?TTBsbGt1T3B6RkZqekl0cmlhSE0za0VRRnVPR2xucGVzZjZMWG1ETjRCMWZL?=
 =?utf-8?B?eXh5eUNSMzlNcW5JYWo1ckxlQnVLLzV5dXV2TGJoYWZOa2hWWlRDQmxndkpD?=
 =?utf-8?B?cSs5MEJ1MTgwMXJBMVgwdFJUVDhrZ0dobDJFYndvcVFkSWFvZ2NDZXpCcFZP?=
 =?utf-8?B?cWNjUGZNbWJRdlVnMGVHSmpIRzlYT2lJL0FRRE9PV1BQWE0wVVBxYXcwRGty?=
 =?utf-8?B?bDFxUXJ4MGZURUpkUEpQT1o5S3I4TmFkNzdEVE1CTHJ4YVcrNTFTMC9jNUJV?=
 =?utf-8?B?bi9VT0NpQWtrQ2loa0VLYkJONnhLc05NMytpVVFFamcyVFJrU05xYnNsTDNG?=
 =?utf-8?B?T3BPVldLZTFUTmxTMmlIRFZjYzhrNWxPeDVaQU1kK0QwSHpjYVp3enlUZGtZ?=
 =?utf-8?B?dWxwemxyYU5rZmhrSTQ5ZWh6SDZnZlBiS1NPZjVEZFpFWHFESXdkQjErUVBM?=
 =?utf-8?B?UW9NUHgrWGNrdUpYV1grS0ZGS1g2T1dNUFp0alROM2N1NHpFZEx4ZUd2Z0dB?=
 =?utf-8?B?Ti9weDFhWVF0bUc1b00rMGxacnZhMDVsd3pjMStDM3ZYQXU0bmxGSklSeVhn?=
 =?utf-8?B?VGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc25fc9-1652-44aa-7ce4-08daedab2f1e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 16:54:31.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcqvFwst6YKnNdIj8idECOXZGuczorv8bTF0xxLI5qLeCe6v+3m3dCmgozO+CUC3298N3WFzcE3x1mmS35+EJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7133
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jan 2023 16:54:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10288

On 02.01.23 18:08, Henning Schild wrote:
> Changing the homedir of root that way is required by any layer that
> takes ro rootfs pieces from here. Making it its own package allows
> reuse without having to take some other customizations.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  .../change-root-homedir.bb                    |  5 +++++
>  .../change-root-homedir/files/postinst        | 21 +++++++++++++++++++
>  recipes-core/customizations/common.inc        |  5 +++--
>  recipes-core/customizations/files/postinst    |  8 -------
>  4 files changed, 29 insertions(+), 10 deletions(-)
>  create mode 100644 recipes-core/change-root-homedir/change-root-homedir.bb
>  create mode 100644 recipes-core/change-root-homedir/files/postinst
> 
> diff --git a/recipes-core/change-root-homedir/change-root-homedir.bb b/recipes-core/change-root-homedir/change-root-homedir.bb
> new file mode 100644
> index 000000000000..dc4631bd6b16
> --- /dev/null
> +++ b/recipes-core/change-root-homedir/change-root-homedir.bb
> @@ -0,0 +1,5 @@

Missing copyright header.

> +inherit dpkg-raw
> +
> +DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
> +
> +SRC_URI = "file://postinst"
> diff --git a/recipes-core/change-root-homedir/files/postinst b/recipes-core/change-root-homedir/files/postinst
> new file mode 100644
> index 000000000000..205ee4839e82
> --- /dev/null
> +++ b/recipes-core/change-root-homedir/files/postinst
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2019

Maybe update to "2019-2023" at this chance.

> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +set -e
> +
> +# needed for read-only rootfs with writable /home
> +if [ ! -L /root ]; then
> +	# usermod --move-home can not be used while the target user
> +	# has running processes, also we keep a symlink here
> +	mv /root /home/
> +	ln -s /home/root /root
> +fi
> diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
> index 1124ff2d3590..24c862c32e3b 100644
> --- a/recipes-core/customizations/common.inc
> +++ b/recipes-core/customizations/common.inc
> @@ -22,10 +22,11 @@ SRC_URI = " \
>  WIRELESS_FIRMWARE_PACKAGE ?= ""
>  INSTALL_WIRELESS_TOOLS ??= "0"
>  
> -DEPENDS += "sshd-regen-keys"
> +DEPENDS += "sshd-regen-keys change-root-homedir"
>  
>  DEBIAN_DEPENDS = " \
> -    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys \
> +    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys, \
> +    change-root-homedir \
>      ${@(', iw, wireless-regdb, ' + d.getVar('WIRELESS_FIRMWARE_PACKAGE')) \
>  	if d.getVar('INSTALL_WIRELESS_TOOLS') == '1' else ''}"
>  
> diff --git a/recipes-core/customizations/files/postinst b/recipes-core/customizations/files/postinst
> index 7a0b00d98680..7e7ea3692325 100644
> --- a/recipes-core/customizations/files/postinst
> +++ b/recipes-core/customizations/files/postinst
> @@ -21,11 +21,3 @@ fi
>  HOSTNAME=demo
>  echo "$HOSTNAME" > /etc/hostname
>  echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
> -
> -# needed for read-only rootfs with writable /home
> -if [ ! -L /root ]; then
> -	# usermod --move-home can not be used while the target user
> -	# has running processes, also we keep a symlink here
> -	mv /root /home/
> -	ln -s /home/root /root
> -fi

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


