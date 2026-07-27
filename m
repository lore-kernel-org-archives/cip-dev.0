Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBACC531FC
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 14:41:13 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32834.1785163265686417624
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 07:41:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mmoxX/GK;
 spf=pass (domain: siemens.com, ip: 52.101.84.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhFdLu0rtgCCCTR2ZZRowzDo1I2m9YwlZdYjQNxje22A5d3kJGQEtUBBzo2oYzN7snuPqxGgtt+9SnSGr86P/yTUizZkhj5E/uckuQbk5cXivPn8oXdSTxUo9roZ+KTnHDBjztWJn5fxxg9BR7g0G4IQTwTWx6oOHIV8Mn+b6Iti3DoP1FgYzqTls08ZeRSF5PpnI9WdqIqijOn8G/DWom0H3NrMpfWkQ3PCKpZCiztzGUeMTYF2YYCOXNaqRPwjeU8tHM20A1reb0gFOiqeeZqpmzaUNtjvPKQ3dfegVYREFarNJQExK+UU5/QDJGJpDgZ7w8YT7dwichj57Wg0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqpLYCX7AMAMEJBmsFvtg2fSiQJkW32EYxEjss+8PVM=;
 b=KvM2JVwC1hEohsAs+mdV/3ZQMqXsW9sreeb4lScJNO00GPuvNr+QwmDTwlhqkYhReP7FRH/OZvNOReXz1GgLHwG5dPBqp/7OLUuXc6QyPTQsGmop1zXcMvhEZEZgK2/Tl1QrHYrrMrp63T0Ac8xnoqftcNQnj/gBPBJ3utrHRlGV6Bs99SwU3oc1Pb/0IcwYYR4lkc7hOB/98zrVzRul4bkPO2h1Sgw0sZpv0ocHZFWwk8OIfTOp0iWmKDYAdQcF387B0ftT4kR6Td5Zar1edBDLzbGQzZ0b1a723QNjPo1C3veMTH50DR0I6NwIeGB9Ep9khj8P1Eye+s9Px8YeQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqpLYCX7AMAMEJBmsFvtg2fSiQJkW32EYxEjss+8PVM=;
 b=mmoxX/GK53OWoU6QVxQaYgixtlwp6rOFYrBM8baCBn38EvzqQAWAcEQWP7c/IDZ6KX6hiwYGNwLOU/jg/3HVlfils8gxRujqkwnYiTdmXRU002ZbzDsxUagZOlVjCjeb3irv0cjhcVC5E/1UGD8WMzGr75uP26gWvvqiRfNF95SAt+2a4bNi+lD6vmJH9KUi55HTK8clpqaEg5azccRdWtLreqWk13EbE+9Y0WOhl8FhxFasf6pvTksb6yxVie6VBq4BQLg+kjiMY3Cg1u5nKkdePgm1tSD2dIyTJtywnhQoPNDXgUFZYYZ8Uu+7khbTCA+XqkQ8XD+ccpOFwAfbnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9144.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:40:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:40:59 +0000
Message-ID: <d46f6deb-c909-4d3d-b132-351c63274082@siemens.com>
Date: Mon, 27 Jul 2026 16:40:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 09/14] Add class cis-hardening
 for post rootfs generation fixups
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 christoph.steiger@siemens.com, clara.kowalsky@siemens.com
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
 <20260724124038.3633611-10-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260724124038.3633611-10-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0020.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: a56d7ddf-1f37-4199-a111-08deebed133d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|4143699003|10067099003|11063799006|6133799003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	RkIxnYSZ1RDYRh5T5AB9LYbFbPTaByyM/KYTPiq2zDdl0AHsrqD+7fJzwzVN5orhr8kirW8EKW72s9gXd48kjJ9te2P2Oinu0JkyGkiqCJKeJzKvZ45A63xkQGXuVIXM1NWNtFgH34qlnXBWyq8wQ2fdj0BUsPihWM43jtnyJS/RIT4oP84imSTi48Hee7nedBOeJGk84w1Y85RPN5Ii7ITXHsL281AR6A6McQJaYVO276MduzGFs7yrvqWXFeT+WUxy4tyZQ8j8J2sNv1bCBeePpkcIy3eolebtrMNNWIe5ugZbHShGeE6UiwgTZq6SHSWeNLjT63QslWTUgT54rpU/Zcw2QlqU0N+paoPEy4fCAmIycLOIJELmMxl9sdJ5YR/vUU7Isy8Nx/FWNAxB1XM/gwM6AHBryBUdwX4i+/ZByY7pq19eYKuKeLqIgWc5uSQC487cL1JjiME7YF3+l8GP2WIzOzOnqeoS4UdmDZoeDSjIuIhh73qxY/U+hALJdyipkbZ+cg5dKtGLrc3zYrYM3h57yfN66dzN4Uq1/Arq8n6CiNnVm/JfsEcu2MdqSi4q20oGjPpvemap5ICTY9I+gI2KNADBGOWUc6y3TNhMjPni93NEif6xWXAVRf0+LZu2f98fRwLf1DkBlo4NOaIwiBmDC81DO5/8jkDPuWI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(10067099003)(11063799006)(6133799003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?emNORnd3VkdYSGREMXdkbWx4ZXZoWmJLTDFSVXU5a0dBM2R6aU5hWG5CS01D?=
 =?utf-8?B?V3VGNERTWkpFT0FHNXVTVU9YV3FwNnR5ai9iVTFralNsZzFkbTNJenRaUVg3?=
 =?utf-8?B?RVZZSFVQT1F4ZXk0RExaWUpMV1lvUUI0K1Jla0JSYkYvL0J4Nnl3ejl5N3FW?=
 =?utf-8?B?ZFU0VGltYWtuRmx4eE9xL1JZYzNoL2lCTGRuRTN0V0dVSlhNRXREWGVrV1F0?=
 =?utf-8?B?Y1phZWpDdVNBSnl3UndwVkRrdCsyRHRXVGtCa2MwTjd0bm45N1Vzb2pVU1Jv?=
 =?utf-8?B?TzVVS1RGVzFhVjRqd3Y5VkdCajJiNDMyMFhBbXl5RmpuN3EzdldrZE5UL2Nn?=
 =?utf-8?B?emxwck5nQUYxNVVCQ0dsWENVRFliZ1RHUHdCY0JpYmpoZ01zaDV1eHJLcnVZ?=
 =?utf-8?B?dmxORThEU1g3bUs2SXR2cFcwM0pCa2ZyVDlBQlNSdWdOQmM0bXdMQ0lqby9Q?=
 =?utf-8?B?R2d0c1VYdC9PQnNzQlRVelNzVEdJSm0zR0VoK3NrMDhwNzdJemJ4eTBGajUx?=
 =?utf-8?B?KzUyUjFOcjAwS3JqMWlTbkhmQ0RIN2MxZmRQU3UyUUgxYk9oSkZhS04wQWx2?=
 =?utf-8?B?RGNvbGlIMmZyWTI4VXB6czFMMlMwcHpoTGQrT0xxTi9LU2JyZUFVWExxS3Fj?=
 =?utf-8?B?dU5PclJPMG9pb0Z4WTRndlM2N1NrU0pFR1ZDdjZsaHppWEhWL2M0UFpQcnh0?=
 =?utf-8?B?OGhWeER3aHJsSjA3ZXJrL1B5YlN3NW9vczlqQjA2b0dHK2FMc1lqZGY5azVa?=
 =?utf-8?B?aTFUZWNXbGt3bEx6bmpHbzdHZytWcis3VjhQOCtXcEE2YWZoRDRYWTBESExz?=
 =?utf-8?B?RjcraFM1dWRaaEoxbko1VWlqZ09jbi9jcFdTaEJ6SytZNDdmTWJrTFpFdUUr?=
 =?utf-8?B?UktuWWgvUTJpTldkMlc0clBXeWRJWXZzRjArTzdPOVBmNHlFd001TjNYVFd3?=
 =?utf-8?B?Wnk0cWF5eTRhTFhDMHE5RDI3c1ErM2lLQlpZSFNVNWtpRDFmVjJ0OUNrTjF2?=
 =?utf-8?B?OGc3WXc0VTJ5ejhLVXJXd1o2S1ZPajJHUm05RS9lZUNscXZYa2NHV3M3Yjlt?=
 =?utf-8?B?aThIc2RobDFYaXhCYk5zdUlOMXpPbFpUbzhhY0ZJQ0RsajBMTUMzSUovdk9o?=
 =?utf-8?B?Qk42SXRZNUVWQ283SVcrRDZ3eGZYNlMvQVhXbEtpSTlScFR4ZmZFNmUwemM1?=
 =?utf-8?B?Y0VKZGVZRld2K0FBVXJ5TWRvQXhodVFkNlpob1c3dk9iRkFJb0lGUURVK2R5?=
 =?utf-8?B?dHpMd1o3cmIvYVcrUFRPaUdRaGE5ZERyVUxYUlR3bXdhSi9nS05IeTFHb2Jx?=
 =?utf-8?B?dEN2S0kya3o3WUl1YnMvbnVwK09KTFNJS2dGaXorZUpwZUxtcDU4anl4ZmVn?=
 =?utf-8?B?U1RRUFFZajJ1eDkvbXBUN2QxclFVa2t1RlBWU2E0T2RYWUJSRzlLZDNSSndE?=
 =?utf-8?B?eC9Ed1lLYUdnVGRIMlZEQW5lVjhsaFJ2RmpEUXBmd3g0aUFOYWZ6aUROZ254?=
 =?utf-8?B?dlNOQjJucTE3cnpORk5OM2N4MkNFU05uUWpiWjU0dWJRd0MvYmcvOXZMT1Z1?=
 =?utf-8?B?OUpOeklkTzNTZk1sQWMrZStaRzFyRkloZmcxamVScXk3RnhoOVJxZi9Eb2pJ?=
 =?utf-8?B?cEZRZTdBR2xmUUZpVzgyVFV4REVlREpEdmFuaDA4dzU0MUJqUjM2dndCOURv?=
 =?utf-8?B?b2wxVGo3MTh1cXhUZGRFSC9qWVRBaWJiand6Z1phdmFTakVSYzkwYTlFNDJi?=
 =?utf-8?B?QjVJUEo1MkVtREo4OTExWXJJK1Z0QkhOK29Yc3JPRGRlWHhTNVFXZEdrZXhs?=
 =?utf-8?B?VFJyaEM4cTZvSklpcVl5bW50MHpvd3FRZTFkS0pUV3F6bnNDeWl3YVBVZy93?=
 =?utf-8?B?Zk02SC9PUW5NclpMUVFmaGRxWjhkUGJ0YXNxT3U0NHU4dHNQY1U5emlSV0d6?=
 =?utf-8?B?bnVHNm9WV25qZFlUcERGWXN1S2s5L2xXS0U4Nkp3dlBmbHdwc1JocU90cDFz?=
 =?utf-8?B?RkN5a0lDWXE5dDJGM3JNa1MzaHR4dGNVMzRtVEk0RmxtRzJoNytScjI3RlFX?=
 =?utf-8?B?SkZUdENINXpYbXIxWC9WcUlHb01TQWVucDhHejZpMlVRVlBEM1ppT0VwNVNa?=
 =?utf-8?B?cUFmV1pIekgxSGF6ZHk1Tm5WWHY0WHA1NkVhTG9zT2pzTnFxVTBSS2JPd1gr?=
 =?utf-8?B?Y1VhQVkvOG5DN01ENWNnZDFCUGlJbTQwVUozMSs5N1haRjRQTzdhKzY4UlIr?=
 =?utf-8?B?MEZQUFl4RW9GbjlzL3F5VWgwN2I3czI0NXZ5OFgyU0NxSXkwc2lIb05hT21v?=
 =?utf-8?B?KzVyZE1RRFdsVGhoRUxaRUNmWHlJUEovZXFNangrTE1uQis5cEcvZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56d7ddf-1f37-4199-a111-08deebed133d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:40:59.7440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNEFPtdK2fjM60CaauW9WlDbZEKPaxoh4ixHdsa6fMp3kGSByUurDtY+olFFUdUNUUlc/OE9c08KvllXxnqTfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9144
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 14:41:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23777

On 24.07.26 14:39, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The kernel hardening can disable squashfs even when we build images that
> use it. Add a conflict detection that is conditionally prepended to the
> do_image_squashfs function. This makes sure we always catch the fact
> that a squashfs image is built and can provide a clear error during
> build, instead of not booting later on.

This sounds like whac a mole to me. Squashfs is just one recent example,
but there could be more. The underlying rule of CIS is (to my
understanding) "disable unused filesystems". Can't we manage that list
more effectively? See also below.

> 
> Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes-recipe/cis-hardening.bbclass | 31 ++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 classes-recipe/cis-hardening.bbclass
> 
> diff --git a/classes-recipe/cis-hardening.bbclass b/classes-recipe/cis-hardening.bbclass
> new file mode 100644
> index 0000000..baf3e82
> --- /dev/null
> +++ b/classes-recipe/cis-hardening.bbclass
> @@ -0,0 +1,31 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2026
> +#
> +# Authors:
> +#  Felix Moessbauer <felix.moessbauer@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +# The config file is generated during install, hence
> +# change permissions after all installs are settled
> +apply_sshd_hardening[weight] = "1"
> +apply_sshd_hardening() {
> +    CIS_SSHD=/usr/share/cip-cis-rules/configuration/cis-5.2.1.sh
> +    if [ -f "${ROOTFSDIR}/${CIS_SSHD}" ] && [ -f "${ROOTFSDIR}/usr/share/openssh/sshd_config" ]; then
> +        sudo chroot "${ROOTFSDIR}" ${CIS_SSHD}
> +    fi
> +}
> +ROOTFS_POSTPROCESS_COMMAND += "apply_sshd_hardening"

Above, you only talked about squashfs. What is this hunk about?

> +
> +python detect_squashfs_conflict() {
> +    hardening_cfg = "{}/{}-hardening.kernel.cfg".format(d.getVar("DEPLOY_DIR_IMAGE"), d.getVar("DISTRO"))
> +    with open(hardening_cfg) as f:
> +        lines = list(map(lambda l: l.strip(), set(f.readlines())))
> +
> +    if "# CONFIG_SQUASHFS is not set" in lines:
> +        bb.fatal("CIS kernel hardening disables squashfs, but squashfs is selected as image fs. Consider disabling the hardening option for squashfs or using an alternative fs.")
> +}
> +
> +do_image_squashfs[prefuncs] += "detect_squashfs_conflict"

If this needs to be extended to "CONFIG_ANOTHER_FS", it would be nicer
to just have a generic conflict checker function so that a single-line
statement can be added for it. Maybe there are even further kernel
config options than filesystems that want such cross-checking?

Even better would be if we also had a visualization of the conflict in
the hardening Kconfig menu...

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

