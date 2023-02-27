Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D1AC64ED8
	for <webhook@archiver.kernel.org>; Mon, 27 Feb 2023 07:20:01 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.74])
 by mx.groups.io with SMTP id smtpd.web10.84990.1677482397230695760
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Feb 2023 23:19:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xe4PF3ht;
 spf=pass (domain: siemens.com, ip: 40.107.6.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AccKGadDWLjF/kX1stSOYfzHFn3P8oDynaVhiPLp03qH22k6fFk3mSa15kxAxz4QBGG5TJT2/QFiDBTPd/ghnB3XnhbKCY/jywv9j72WJkHUNvekOOBzw5d5ElLqdl6Y/6MTWFfILFvjKVtNIV3XzCdk3XTBBjLue8T5FtG19NiFoUqT2xoyt2qLFRhRxO22pZyUWf8PSFQ05Fgbv0boQzx5fLc+vFXMx2SjF3tjEmkkHO7rJ36Q/66ZBULkgvZd+U8SF90AIaxx5P0myc0M9Xcik++l6AJZSE5G/5DMO1pg7Bq+xg/tr7N0D+bSsvCYJv4ASwNhTbwDmdaemAy1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gnEMCXJx9r3QjbZUjMl7JPVAvt3S0DRMXfQzcVZfKQ=;
 b=NsiU0FvGs5N2Wl4aAs7s1k8v/PVt/cSu2QfsfraBI6pudL7NN9MLO0POm+jDNVR2PISUE80QxDDLbxQuoWu6UsgjkiGilKD+C/m43wqVYd7t3WUbyGqVeYnF7h7UdFmwXBUQeDZiJ1JT3e8Zx5n6ZsTykRyn9MnGq9uY+vAzxOgR/eMxc/TAuAdzUSMxT/pVrd6JaVJsVYp2dNMnzoYRwU6OFJRzyApfm4hvnU3jkshAY5ObNaMZN/ZkRdpZaUb6lsdGQsEwtDFRv4Q7FD+M1Z+pi7hpxVGSSwj/F/B63RoH0ZzWOh4myRLZxw2+rcWv15C/mk9FKY0YkWyZ2AGN3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gnEMCXJx9r3QjbZUjMl7JPVAvt3S0DRMXfQzcVZfKQ=;
 b=xe4PF3hta9iAoHHEox8neK9qHt/bCzRR6kH71RwnMxXiwsYZciaRSAde5j/jLFYO+u+/xsza0FxjkuxpRsKFB+hGuTfoqlhVtJfWJC2vPw1J0FtCzi5pfoQLQ0fPMOF+uGV9iXENkjV+qOeDNr8kBfL3mrr1JFd1LpFG5oQ2De+RPUsBTqgaxuVE9KurxqsMsbI1C3MeW7XOTL5CdCJGwgqCEvGNi6ynUNSxpx4D7KcNZoxgKFDw8hzObrBDINVBi3OP9bDecsX5un3GZmJZQ37nOZG6vaYaInOVcy7UHch1pHfNjl6atdVjsGuGTf6iecpRDduiEll6Cbp5r2kKWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6900.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:467::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Mon, 27 Feb
 2023 07:19:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 07:19:54 +0000
Message-ID: <d8902508-b1d0-06fb-3633-47a84ce0464a@siemens.com>
Date: Mon, 27 Feb 2023 08:19:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 5/8] Add initramfs hook to
 encrypt a partition
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230224162832.327030-1-Quirin.Gylstorff@siemens.com>
 <20230224162832.327030-6-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230224162832.327030-6-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: f83fae45-90df-4d87-be8d-08db189305c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DJVUdbSWpasTHDfs7xq8Kuyktl4goqSo6LQJ5abTUsbLDNARBr4h2E0r+y4C+08wX20BYDfxgFKVqTa1DT/g3uqee2a3tQtvRs7nBQaqxda5NhnHm+Pex3QDecpUbGzhro1Zbg+ioug9Fbmao3Qza1r01QeL+m0nrJCb4BBWXrj9R+zaABDYnsvZ7DQis1f4meoGeIjn7wtOBrSmLWh8Nj1GK5BVhMAtvBypxymtJ/0UJ6FAHcgit4omp04VGLn/NDisarbKG8DgPGXoIhCzx3fpBT3FNaT/sbLHjtYYJH6diBXI2JYTgholzhwZG60Xu+1R0TP1rVknsBxLkvb0vEKnVtl1DQmuSSiIaNYxOe8nTnbEBUUD5RMErCYvA3Ze42fwBnVLdvUWRYewzyBuWus/vye95/VlDVY9IiPKluN2+EMV6Ji0+hPoizfnaj9hhjfGh88oxv3TGA6MwUCqXbeSmhlkDVK09IZhu7AJ6Ct0JfmsGFKqZR4lkonFp7v90gHdDrd7VL8zXUt3NQk12tJjnCNe9TqvSS6wdZt0L4Rgu9K54hZUtxcvDwLEVBz/9GsFZAYpdYTAhMveUfHzlANHCyrNCBXjPjRzUIPCjrTYw9Ztp9Rb5G/o2jj4C9bcafeSp606sBMRpC83JXrbPr+6i+Txqc/Qgw/illb04aIyaoJgq/q0AlBgMS7xRJ3bYIzu9MSWIyYcpYaneTUt/9kOyeMP+YyfZx8U38nD4OWqk6XrInvzmOAfzFKrnclFi42NPmMwC14K6yAfSCbQjw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199018)(186003)(82960400001)(38100700002)(2906002)(83380400001)(66946007)(8936002)(41300700001)(8676002)(6512007)(66556008)(44832011)(66476007)(478600001)(26005)(53546011)(2616005)(6506007)(6666004)(5660300002)(6486002)(316002)(36756003)(6636002)(86362001)(31696002)(31686004)(30864003)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dDh3a3luRklGYmlZalIrZVFoRG55V1Q0bzNkaTFVL3RzNjZ0TDc4Wk1NV2pv?=
 =?utf-8?B?K2NodVBHQitKbDJqamp4UHJXS1VDTHdscUdiRXRianAxMW5Wcll2LzNJOVBi?=
 =?utf-8?B?U0Q3NWRYSE1HN01iSy8xYW8rZHRuZ1Rqb3FiS25OeUZ5N0ZYeVZyU05yWDRP?=
 =?utf-8?B?d3I3VjZOK2lWN0JVMXloUmEyQVcxS2hGU2VhWVY5MytpN1RiYm5qVGh1Z2ZI?=
 =?utf-8?B?UGNMR0YrUUdxOFZPRitqSUlkMk56eW1CQnBjODJlaFl0QVBBOWREZGVPcXIz?=
 =?utf-8?B?S3RTLzlZNm9mTmdrUFRNbWRwYklUZExLbUllbDhJVzlkLzQ4Y0N2cUkwMGtJ?=
 =?utf-8?B?aGdaTXFGamFza09yN2hpWHN3RE1hUTNjQWFFRjNWdy9DNXBvSTBtdkswT3dV?=
 =?utf-8?B?WXpUZ2EyeTNlSzMzZ3pRWWU0QVhSWlRhdkcza0ZaQ2ZpSmN3MFh2L1RmZ0VO?=
 =?utf-8?B?WFhxSko5RHZrUXFmWVlJTEhZTTVaVUQ2U0lUdnVOb0xESVpQckdwTmtmQjJS?=
 =?utf-8?B?V2w2QnJTOXhyMVI5alpSTDltZFc2SDhlZys3a214Qi9pMW1Ja3p2QWtRK1Zt?=
 =?utf-8?B?cFRHVUJGaE9NOEdwV1hKeWdnbTdHRmdXMzRDTk93VkNDdCtxU2IxbGs3bGg1?=
 =?utf-8?B?czlmQ0Q2MjlQaCtSc2FLOXdyZjA2aDJDYzIvUzJvYnhjemRvM0VqU3BrR0Zp?=
 =?utf-8?B?RWdZbm10SHlMZ2JIMVI5NUtraGZoYmg3QlJjSW52Tlg1ZENWbWtyUU44YmJP?=
 =?utf-8?B?WXM3c2E0Y0VQRjQ3czVsR0lqbDZCSG5oL3VOOEt0OUVyK3dXQVJ1alduNHly?=
 =?utf-8?B?N2I1c1dsWWFyM3VjenB0dmVBTVdWMUdNZW9Vb1V5TmsyUGhVdzhDbkNLc3V3?=
 =?utf-8?B?M3NTVm04MWhkZmpLRGI0MVNIZGVtTmRrUktxQWl5WmE0SVY4UFY2YWJvdXN5?=
 =?utf-8?B?YWN1Q0tBSDZPOGwvM0g5VHA5bzBYZ3dmTWVEUFIzb2V1djF5ZmFWNUU2ckVt?=
 =?utf-8?B?RjFBOXdjb3k1dlc4OWZOTE5nZW5RaDdrNFUvSHhaNnFkZ0g1UGhKOFFrVG5F?=
 =?utf-8?B?bkxhU2Mwc3dLWUR0MHdXdzgxd2JFeHF5TnFVaFpTdXFDTng2ekI5cFNJL2FN?=
 =?utf-8?B?djZ3ZkpiaXNKRUczZzBQclFaN3U2ZUR6eDRlVE9HQTE3NE1JSkwwWmh4TXBZ?=
 =?utf-8?B?bjBxTEhOWmxFTk4rcExoMDJMdUVWWVZvbVpJS0FBWnhlV3RxZFZJTmd1NndK?=
 =?utf-8?B?WFdmNGNXQUxRUHBTeU15dVpSdjZaeG1tdnJUd0xNMWVsaEtZMTcyRnRaUG1x?=
 =?utf-8?B?V0pmSEtGTUlIWGRkWkk4aFFjZVRTRDFMelMrdnRKanZXVHd5Q3kyR0I0VFNC?=
 =?utf-8?B?bU9xMlBZTnQ1U2ZyeEplYW9KZmFNQkFteXZjbVZ4YVJaeUhOWGNJUzV5Q3Ny?=
 =?utf-8?B?aDJseThlMkUwR2QrUzRmSnF5Z3RheG14L3pVS2s1U1BHTkdLWGJMeVM3N2Rv?=
 =?utf-8?B?WG12TzJNMXpFUTVESmxUL3V4UklmczQ2NGo2WjhMeWx5akE1MTlIUFhaci9R?=
 =?utf-8?B?U2VLS1pvVytXMkNQcVRqcUhYVWtpblJlYTk5L254NjhnYlFqQ09pNnlsR241?=
 =?utf-8?B?SzFuUVU4aUlKVTRkVHc1ZWFkU0lyYU1oYjVCL293d2lIejFWVGtvSW9TQTdi?=
 =?utf-8?B?YnREYXg2QjNJNjJoMnVJcGZLSGFGR3ZIcXF5b0QxTVZJYXdWNjlhQURHT0kr?=
 =?utf-8?B?cmRDT0libCsxWHJGL0NFSHE0Q0txWlpvTVBNUzVSU0JLYlBoSW56L0hrSjlQ?=
 =?utf-8?B?Qm9WSTZEZDdISjBmWHFTR3hjdE1oVkQ3dk1PcHlmb01tT3RGSmk5d3JsOEVs?=
 =?utf-8?B?cUg1UkthOG1lTXFBMWp2ZGNCVk9aZHBCRDhZaCtpNlNYdmxPLzhmeW02L2VN?=
 =?utf-8?B?TTlyZGxJUGt3UFRsMEloYWN4V2ZRWFpyU0NQMTVjdnkwL1F4TGIvbDNvaEVJ?=
 =?utf-8?B?OHNaNEYvRVBTRCs1YThyL1ZvZ1J6R3A0cHdpa2FlWWs0RVFmNWljV0FGMDBm?=
 =?utf-8?B?Q3poYkp5Z2tUaTRaczd4Q0hmaWdEYnora1JiWTdwUThqQUJXRlZyVDhCdW9P?=
 =?utf-8?B?cTFZMElWOHdLTHdkOFdVbXhiM3ZGM2djcGVJeHNDUnNDa2VCN2w2Qnhra3dp?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f83fae45-90df-4d87-be8d-08db189305c2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 07:19:54.0214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRxgD/JSfW4m56hPI/u87tIT7hkRihhGBIb7LwfE7FytsGjovCmHUvYGV5uEMnTNCx7grgCwu2NbrA50RBoeWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6900
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Feb 2023 07:20:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10860

On 24.02.23 17:28, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This creates a new luks encrypted ext4 partition with a the
> key stored in the tpm2.
> 
> The initial key is randomly generated and removed from the
> LUKS partition. Therefore a new key cannot be added by the user
> and if the LUKS header is corrupted the data is no longer readable.
> 

You should also leave a comment about the extra space, why it is needed
and how larget it should be.

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../files/encrypt_partition.env.tmpl          |   2 +
>  .../files/encrypt_partition.hook              |  53 +++++++
>  .../files/encrypt_partition.script            | 145 ++++++++++++++++++
>  .../initramfs-crypt-hook_0.1.bb               |  40 +++++
>  wic/x86-efibootguard.wks.in                   |   5 +-
>  5 files changed, 243 insertions(+), 2 deletions(-)
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> new file mode 100644
> index 0000000..d04be56
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> @@ -0,0 +1,2 @@
> +PARTITIONS="${CRYPT_PARTITIONS}"
> +CREATE_FILE_SYSTEM_CMD="${CRYPT_CREATE_FILE_SYSTEM_CMD}"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
> new file mode 100644
> index 0000000..2deee80
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
> @@ -0,0 +1,53 @@
> +#!/bin/sh
> +# Copyright (C) Siemens AG, 2020-2022
> +#
> +# SPDX-License-Identifier: MIT
> +
> +PREREQ=""
> +
> +prereqs()
> +{
> +     echo "$PREREQ"
> +}
> +
> +case $1 in
> +prereqs)
> +     prereqs
> +     exit 0
> +     ;;
> +esac
> +
> +. /usr/share/initramfs-tools/hook-functions
> +
> +hook_error() {
> +    echo "(ERROR): $2" >&2
> +    exit 1
> +}
> +
> +manual_add_modules tpm
> +manual_add_modules tpm_tis_core
> +manual_add_modules tpm_tis
> +manual_add_modules tpm_crb
> +manual_add_modules dm_mod
> +manual_add_modules dm_crypt
> +
> +copy_exec /usr/bin/openssl || hook_error "/usr/bin/openssl not found"
> +copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
> +copy_exec /usr/bin/grep || hook_error "/usr/bin/grep not found"
> +copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
> +copy_exec /usr/bin/expr || hook_error "/usr/bin/expr not found"
> +copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
> +copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2fs not found"
> +copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not found"
> +copy_exec /usr/bin/systemd-cryptenroll || hook_error "/usr/bin/systemd-cryptenroll not found"
> +copy_exec /usr/lib/systemd/systemd-cryptsetup || hook_error "/usr/lib/systemd/systemd-cryptsetup not found"
> +
> +if [ -x cryptsetup-reencrypt ]; then
> +    copy_exec /usr/sbin/cryptsetup-reencrypt
> +fi
> +
> +for _LIBRARY in /usr/lib/*/libtss2*; do
> +    copy_exec "$_LIBRARY"
> +done
> +
> +copy_file library /usr/share/encrypt_partition/encrypt_partition.env /usr/share/encrypt_partition/encrypt_partition.env
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> new file mode 100644
> index 0000000..a53e517
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> @@ -0,0 +1,145 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +prereqs()
> +{
> +	# Make sure that this script is run last in local-top
> +	local req
> +	for req in "${0%/*}"/*; do
> +		script="${req##*/}"
> +		if [ "$script" != "${0##*/}" ]; then
> +			printf '%s\n' "$script"
> +		fi
> +	done
> +}
> +case $1 in
> +prereqs)
> +	prereqs
> +	exit 0
> +	;;
> +esac
> +
> +. /scripts/functions
> +
> +# get configuration variables
> +. /usr/share/encrypt_partition/encrypt_partition.env
> +
> +# load necessary kernel modules:
> +modprobe tpm_tis
> +modprobe tpm_crb
> +
> +# fixed tpm device or do we need to find it
> +tpm_device=/dev/tpmrm0
> +partition_sets="$PARTITIONS"
> +create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
> +
> +if [ -z "${create_file_system_cmd}" ];then

"; then"

> +   create_file_system_cmd = "mke2fs -t ext4"

Inconsistent indention. You use tabs otherwise.

> +fi
> +
> +open_tpm2_partition() {
> +	if ! /usr/lib/systemd/systemd-cryptsetup attach "$crypt_mount_name" \
> +		 "$1" - tpm2-device="$tpm_device"; then
> +		panic "Can't decrypt '$1' !"
> +	fi
> +}
> +
> +enroll_tpm2_token() {
> +	#check systemd version and export password if necessary
> +	if [ -x /usr/bin/systemd-cryptenroll ]; then
> +		systemd_version=$(systemd-cryptenroll --version | \
> +							  awk -F " " 'NR==1{print $2 }')

Over-indented.

> +		#check systemd version and export password if necessary
> +		if [ "$systemd_version" -ge "251" ]; then
> +			PASSWORD=$(cat "$2" )
> +			export PASSWORD
> +			/usr/bin/systemd-cryptenroll --tpm2-device="$tpm_device" \
> +										 --tpm2-pcrs=7 "$1"

Also here.

> +			PASSWORD=
> +		else
> +			panic "Unknown systemd version: '$systemd_version'!"
> +		fi
> +	else
> +		panic "systemd-cryptenroll not available cannot enroll tpm2 key!"
> +	fi
> +}
> +
> +reencrypt_existing_partition() {
> +	part_device=$(readlink -f "$partition")
> +	part_size_blocks=$(cat /sys/class/block/"$(awk -v dev=$part_device 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)
> +	# reduce the filesystem and partition by 32M to fit the LUKS header
> +	reduce_device_size=32768
> +	reduced_size=$(expr $part_size_blocks - 65536 )
> +	reduced_size_in_byte=$(expr $reduced_size \* 512)
> +	reduced_size_in_kb=$(expr $reduced_size_in_byte / 1024)K
> +	resize2fs "$1" "${reduced_size_in_kb}"
> +	if [ -x cryptsetup-reencrypt ]; then
> +		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k $1 < $2
> +	else
> +		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "$reduce_device_size"k $1 < $2
> +	fi
> +
> +}
> +
> +if [ ! -e "$tpm_device" ]; then
> +	panic "tpm device '$tpm_device' does not exists - cannot create a encrypted device!"
> +fi
> +
> +for partition_set in $partition_sets; do
> +	partition_label=$(awk -v var=$partition_set 'BEGIN{split(var,a,":"); print a[1]}')
> +	partition_mountpoint=$(awk -v var=$partition_set 'BEGIN{split(var,a,":"); print a[2]}')
> +	partition_format=$(awk -v var=$partition_set 'BEGIN{split(var,a,":"); print a[3]}')
> +	partition=/dev/disk/by-partlabel/$partition_label
> +	crypt_mount_name="encrypted_$partition_label"
> +	decrypted_part=/dev/mapper/"$crypt_mount_name"
> +
> +	# check if partition is already encrypted with systemd-tpm2
> +	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
> +			| grep -q "systemd-tpm2"; then
> +		open_tpm2_partition "$partition"
> +		if ! mount -t $(get_fstype "${decrypted_part}") "${decrypted_part}" \
> +			 "${rootmnt}${partition_mountpoint}"; then
> +			panic "Can't mount encrypted partition '${decrypted_part}'!"
> +		fi
> +		continue
> +	fi
> +
> +	# create random password for initial encryption
> +	# this will be dropped after reboot
> +	tmp_key=/tmp/"$partition_label-lukskey"
> +	openssl rand -base64 32 > "$tmp_key"
> +
> +	case "${partition_format}" in
> +		"reencrypt")
> +			reencrypt_existing_partition "$partition" "$tmp_key"
> +			enroll_tpm2_token "$partition" "$tmp_key"
> +			open_tpm2_partition "$partition"
> +		;;
> +		"format")
> +			/usr/sbin/cryptsetup luksFormat --batch-mode \
> +								 --type luks2 "$partition" < "$tmp_key"

and here

> +			enroll_tpm2_token "$partition" "$tmp_key"
> +			open_tpm2_partition_tpm2_partition "$partition"
> +			eval "${create_file_system_cmd} ${decrypted_part}"
> +		;;
> +		*)
> +			panic "Unknown value ${partition_format}. Cannot create a encrypted partition !"
> +		 ;;
> +	esac
> +
> +	if ! mount -t $(get_fstype "${decrypted_part}") "${decrypted_part}" \
> +		 "${rootmnt}${partition_mountpoint}"; then
> +		panic "Can't mount encrypted partition '${decrypted_part}'!"
> +	fi
> +
> +	# delete initial key
> +	# afterwards no new keys can be enrolled
> +	/usr/bin/systemd-cryptenroll "$partition" --wipe-slot=0
> +done
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> new file mode 100644
> index 0000000..30c89a2
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> @@ -0,0 +1,40 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2020-2022
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +
> +inherit dpkg-raw
> +
> +DEBIAN_DEPENDS = "initramfs-tools, cryptsetup, systemd(>= 251), \
> +    awk, openssl, libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0, e2fsprogs"
> +
> +SRC_URI += "file://encrypt_partition.hook \
> +            file://encrypt_partition.script \
> +            file://encrypt_partition.env.tmpl"
> +
> +# CRYPT_PARTITIONS elements are <partition-label>:<mountpoint>:<reencrypt or format>
> +CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
> +# CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the filesystem
> +# in a newly formatted LUKS Partition
> +CRYPT_CREATE_FILE_SYSTEM_CMD ??= "mke2fs -t ext4"
> +
> +TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD"
> +TEMPLATE_FILES = "encrypt_partition.env.tmpl"
> +
> +do_install[cleandirs] += " \
> +    ${D}/usr/share/initramfs-tools/hooks \
> +    ${D}/usr/share/encrypt_partition \
> +    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
> +do_install() {
> +    install -m 0600 "${WORKDIR}/encrypt_partition.env" "${D}/usr/share/encrypt_partition/encrypt_partition.env"
> +    install -m 0755 "${WORKDIR}/encrypt_partition.script" \
> +        "${D}/usr/share/initramfs-tools/scripts/local-bottom/encrypt_partition"
> +    install -m 0755 "${WORKDIR}/encrypt_partition.hook" \
> +        "${D}/usr/share/initramfs-tools/hooks/encrypt_partition"
> +}
> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
> index b635a8b..24b4387 100644
> --- a/wic/x86-efibootguard.wks.in
> +++ b/wic/x86-efibootguard.wks.in
> @@ -7,7 +7,8 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>  
>  # home and var are extra partitions
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
> -part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G
> +
> +part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M 
> +part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk"

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


