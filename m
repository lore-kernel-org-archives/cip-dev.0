Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495C3ECAAA1
	for <webhook@archiver.kernel.org>; Thu, 27 Oct 2022 17:17:59 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.43])
 by mx.groups.io with SMTP id smtpd.web11.190.1666891071751701924
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Oct 2022 10:17:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=SGse7hQ/;
 spf=pass (domain: siemens.com, ip: 40.107.21.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrIV1+Tq6Jy+mrE3OmLnCdfSg3a2UTKG8vC6U3PMEak7de1/DpK3mCEyYI5rap9F1qyv7bgJHeeg5p9bbiZ0CMVBKx2hWANcxc15z0kfiByJceqXH+VaMowqdULIoxvrHii+Mc9NbZJf9UcPvUFJF407nIMan63esRXLIykSISZQ3hylWrdiWsmT+41EVWnIKMYP9LCkpeXdqcZ4B7fDT1IKNrH4P3vZSYH3sSYKiGsfLZE7N+5WPhwRIAJMjhoBBMEVyQ58PKDOIP6Y/GgbXNQm6a0OuEzFG8HF59KxGkKepgMX51DJSjD/D7ZehDSZItP1IofzCunpKnRGJEhdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lChBDCHYoPU72L+DoxNXwfepudO37xdnQ7N4P1Bx1MI=;
 b=SkaJoTyLW2OW6N8WvrzWTRFwSJJhqTJLihffeFtRSF4/NfNFjFvViMvftqMyuiwURaQmLT02RT+/rqIF3hrScJ7Qnzv2rpvfIYqrNlDC90Y7GjMjiA82mVAyuG5SAGGDo2sNthKe6e1F8v/2/6JJgJGCqw+oqOA+44UHmOXb1DeZHvzPdbnTtl1l+T0KtfQQyAnLa1va6phQXa43399/w+ptAHDjsUoLL4Gbuj/HXOJL0lGOJ9GI8tB7TuxMjVuxLBq3GQwQWY8DhuPpQjmJAGm7alYr90yLtgYfSE9oCUIO+DHkq74DihzOwhrEaE7KuWlPPuh/2UbrTce7LqFKCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lChBDCHYoPU72L+DoxNXwfepudO37xdnQ7N4P1Bx1MI=;
 b=SGse7hQ/sltasAE9A47Ym5Uk330x3/VCUr1sj1s8EUI4v3ppmBQfPqfNMIne8UfskZTzWkQGS9DVGb00YzWNUszhG+6eUT3JGb0Gn9AZ3XFizdh9xxluatmPqiKmBR5O1tCTf6QuWxZmr+cI8aV5kPlae7l1TwNy1Uy5uE7a9DqXSHcOETC2sMnfQvBPUnsa7P4YJfB07R2V7bZS7+F1sqlulH4iWFZTn2TmMFCgiXFAGorIHt21+UvRYhoh256eRozCnd6xhjmmQjGIpDsmyfURPFcuiAA4QCPNoEAlE3G3uqpKnfOzsALESC5Cz3Tm5AqhRE242ESZcjkzreitYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5708.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Thu, 27 Oct
 2022 17:17:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b72:e60b:1f2a:b2fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8b72:e60b:1f2a:b2fe%6]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 17:17:48 +0000
Message-ID: <1da1e517-4604-3eb9-a43b-01705ca434a0@siemens.com>
Date: Thu, 27 Oct 2022 19:17:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [isar-cip-core][PATCH 6/8] add kas files for building qemu secure
 boot images
Content-Language: en-US
To: sven.schultschik@siemens.com, cip-dev@lists.cip-project.org
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
 <20221024122725.383791-7-sven.schultschik@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221024122725.383791-7-sven.schultschik@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd2ee4c-7ead-4841-8e69-08dab83f2bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hJcGZFMrmMpfzfpT8juS7FBVGeMXQwJBmce/mhB4SvAkkkGjbcHdaRcctfPIAi/FWZMYmbFLtKpeFBfamTibtEOtOG5BJv9/3NEijsmDVyeO7GlW+PlQSBQZ4bqbC7OHI6RjfW812Irl+hltaajtVNeJMCJDUgOJHCiSkoVejUa7I4pcelwI+dIjorbj5lTGIAQCQA1JVIF9NTBDGiUM3Ror8r8Fea14XghlkD+5Tjskyy+XqPs08RDgDlaAiZZH67T9MHv41MdNPxOqAOsX6RhO8vI4NboSIT5Bz3cCBrMjJMszGKCNpBR6wQIL7jMRFVJG4XYAFcgnSikLBZ2Lp7X1ZyKXlqB67mKOjf+BAgBt+jSnvFGN5viGIz44mWBjD3BUhUssYg+OnxPr5DIRp95HJzfNnMVCqvQ/JI1YpM/5B6pS0mKD9SzJU9E4wLwp7GOsl9s+ONAORGi88/Bqsp6ixYxI8LFM8l/EpvqmbNjEx38QQ0RkCFoFIJQwXxY/VoHc0sGcJApm4k0GUngGx2pzN9YIIVF1roe1I+c4fHUXJtbioruj2IXz51Z5HS6i44w2ElNZfG8NZ6ReK0+sEJc2rxIMovZM5VWKX8iaGUwo7+QL9EAQkTIHE1Q9knH8x7H4ZVZ6eujDl+RbIUcAjNsIv+ZcTTbU9NAQEoYL+YgYU8uXh7DWdXV+L44bQOWe+crwI7l/ynMicpx9xPj4mR3h1m7QdID0ITR65lvQ0KkJmdt1dgaryfT5oitT/wIOEkkdcoTNa+YiM2NotZOUuzctcLgwc5rr0SvRJpQuvY8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199015)(316002)(86362001)(31696002)(6666004)(41300700001)(5660300002)(8936002)(36756003)(186003)(2616005)(44832011)(38100700002)(82960400001)(2906002)(6512007)(26005)(31686004)(6486002)(66476007)(66946007)(66556008)(53546011)(6506007)(478600001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VnBSQm93c0R3ZE50dDJJYmUzSkc1MFRsV25CR2hMR003ZzJYLzRXRC9oV1Fz?=
 =?utf-8?B?VjBidjJHSkNRMzNuZGNoYVdONDlTcHVKeG5QRjg4UUEwOFFPbFNqMWFQTkFy?=
 =?utf-8?B?cTBub24rQlFvS0RYUEI0R1ZqR1Bwbk9nTFA4b2pDNGw3Y2ZHaDRFSzJxVjJq?=
 =?utf-8?B?dTYwQjJDY3hLTWNnVzJScUpvbUZPV1RwVmtYRlBjZGxzWVNyWno1TWIxTGZh?=
 =?utf-8?B?VWdZRHVlbFBKMS91bHo0d1ZGakpOYXJOdTBkMWl3NzdONzEvVjlKWGpLbUVR?=
 =?utf-8?B?bysvTjhuL0lDN1JpK3I3SWpZejJSbzJmNnR3ZVNFWk1zTGd1K2w2RmJYQXMv?=
 =?utf-8?B?RmdFdGtxcFJtNCs4T1F5OGEyU01wREwwZ1BtYmg5SXJRbzZ5WjRjei81NGRo?=
 =?utf-8?B?Mk04aDY2dUVuM0xBam02TU5JSGZ4UkJRZE5jeTVBeklOY3NHb2RmZXZ1bVZ0?=
 =?utf-8?B?WmZxcU5wREVRdGZ0VFVlNk9PbUVDRHJOODBUQURmSnNoN1JJeGpScVAvS1hX?=
 =?utf-8?B?clpDdUQ5ZDdSZnFtVDhCNWt4MFhFcDdFVXFqTXA5RjVtRmF3ZExiU2JtVktl?=
 =?utf-8?B?Y2dTY1dqaTUrWHY0blFodFk2UXpMWit1OGVOc0hEcXhrVkRpSWwzKzZnUkxh?=
 =?utf-8?B?YUR1U0V4SjFGUERGNGE4aDJBcWQ3aTNwRGZNSjFDaVpyTUpGSm4rUmk0QUZh?=
 =?utf-8?B?RnphelJRL05XM2drYTlGYmc3MXJScVc5Y1BCV0hPRk04UHRhQWpRZVozWVZt?=
 =?utf-8?B?WXJLY0RwOWREY1d3UENvdUxSckdOdW10TGdldHh4T1dMTXI3QVBxTWZJZGNP?=
 =?utf-8?B?S2YycWpheitrTE9Lb3FORUxQTDlKd1J2MTZnK0crSjlyVTRLQXhGQjFadUtP?=
 =?utf-8?B?ZEx4d05nYjlXYS9BSHRRSDc4ZzVMcDhjK3pKR2wrcFM3Y3p5ZlFQN1hYbjA0?=
 =?utf-8?B?YnVkbVpFelBldWZ1WHRXbU1IS04xWnNRd0dySkFFQ2t1a1dwTlR1eElaNkxG?=
 =?utf-8?B?ZlBha09VcjRCWVM1VEhNdVlXYWJLNkU1V3djN2gwUlZZTzNIdGdtaS85S0cw?=
 =?utf-8?B?RGYxajl0UG05dHpxdGhiZjVGVGRyTk1RTUtjUDUvb3hGMlRSUjJyR0RpYzdq?=
 =?utf-8?B?bWpUN0RLbk9BbXRkcTl1RVN0MlRISXREYTFGMzdSSWNTTytOZ2hNZWZtdis2?=
 =?utf-8?B?N0dUMDV2bkhkOE5UcExSd2xtamFmS1BMMkgzQWpGU0c4dllIL2tZRHpRU0JT?=
 =?utf-8?B?UDA1UWRVeWZDZm16RXVINUVkbW80cWtHenRMKzZDN2kvaHIyb3Niby9ZV1Uz?=
 =?utf-8?B?Y2FLTzhwOUZIZm9Ea1FZSjJ0bjBGR2ltbGVCZlMvZkUxQVBHNHpDdXh3a1ZC?=
 =?utf-8?B?TjYzaGVzaXB6VlBjVllUWFJzN3dwdkFJTXRpYlFYbkdMbEdCWi85R0VyWnBo?=
 =?utf-8?B?MFdDNGF5eGFWdStzb2lMd0RNL2V5di9Fdlg5bHRqdXBYNjh2WnNKSjM4UDlC?=
 =?utf-8?B?c2xpWkRlNXdBdDJTZWtEOHB3VWJqYnpYSlJWYTBROHF3c2g3UXgxMjkxSTdk?=
 =?utf-8?B?ZUVrekQvejEyU1FhNmJtQzFyUjNua3l0ajlNT3NKMU5FZjBNOExiUWlPUU9p?=
 =?utf-8?B?eFhkUWFuV0N2eWdzY2Z6KzhtWkhwVWFleU4wTE9qeG93QXh6Rm5NWUZhT0FJ?=
 =?utf-8?B?WmkwQnZUQzQ3ZURnSHBDeWUrOHo5VmtpQkZIQ1FscG40YVNFUFZoc3I3aEFO?=
 =?utf-8?B?SjVXQzVpcEJnd1RaWjlSL01Eb1hWaXpOYThKajkvT1AwTUtqZzN6Mi9DWDFZ?=
 =?utf-8?B?QjhOMTcyeG5ZbFBSVHlCYkk0R3NrMWhMcExEMGZSNFFMUXJnQmZQWVJkblVY?=
 =?utf-8?B?a05lNlJWeWlFb1doSEo3dDY0SGJUMVFWZzNPbWV1VnUwMTlJKzkwaTRUNmFR?=
 =?utf-8?B?T1RpZVBGcUVTTW5WOGJpRW9oaXlHYkNTbVB0SHhmWTlPbWtkcW9MM1VRcDFr?=
 =?utf-8?B?T3ZkaitMOWZ4VUdBMU16cVlZbWVhV1hqa21MYWJSaXZKVjg1WEFCRVBqdG9U?=
 =?utf-8?B?N2lEcXJSUG0rNCtxRmFRYzREeitFajdZeXRLUWlveWg3QUV4a0VtcUlpbmI0?=
 =?utf-8?B?SnFVYTZGQkYzQmRWVk9oVFZkRktqTWNUd0NyNE9PZkFNcUo0YlJrZ1ZLemFM?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd2ee4c-7ead-4841-8e69-08dab83f2bdb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 17:17:48.6480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGjX+6uVuwNTr9CWl5+L799iV1Mrdm121wy5cigdgSi/zioMPRqWLwHUzcNGoX9J/wEx0vSl3NrEVmP7YU10jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5708
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Oct 2022 17:17:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9880

On 24.10.22 14:27, sven.schultschik@siemens.com wrote:
> From: Sven Schultschik <sven.schultschik@siemens.com>
> 
> The u-boot-efi-ebg-op-tee-qemu kas file combines the different recipes to create an image which can be booted with qemu and provides secure boot with EBG, TFA, u-boot, UEFI, EDK2, OPTEE and RPMB
> 
> Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
> ---
>  kas/opt/u-boot-efi-ebg-op-tee-qemu.yml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 kas/opt/u-boot-efi-ebg-op-tee-qemu.yml
> 
> diff --git a/kas/opt/u-boot-efi-ebg-op-tee-qemu.yml b/kas/opt/u-boot-efi-ebg-op-tee-qemu.yml
> new file mode 100644
> index 000000000..0558c8e79
> --- /dev/null
> +++ b/kas/opt/u-boot-efi-ebg-op-tee-qemu.yml
> @@ -0,0 +1,11 @@
> +header:
> +  version: 10
> +  includes:
> +    - kas/board/qemu-arm64.yml
> +    - kas/opt/5.10.yml
> +    - kas/opt/bullseye.yml
> +    - kas/opt/ebg-secure-boot-snakeoil.yml
> +
> +local_conf_header:  
> +  trusted-firmware-a-qemu-arm64: |
> +    IMAGE_INSTALL_append = " trusted-firmware-a-qemu-arm64"
> \ No newline at end of file

Why is this still needed? As discussed, we want to have (QEMU) u-boot
with TFA and OPTEE when secure boot is selected.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


