Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AF7C4829E
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 20:14:44 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.86])
 by mx.groups.io with SMTP id smtpd.web11.809.1708028079045592003
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Feb 2024 12:14:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hqNDXqXt;
 spf=pass (domain: siemens.com, ip: 40.107.241.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3iomfPoerDJolBQBkX1kd0lgdhfS0Zh+Xd6jEhtrfZRlFBniurHHuwYzBk+vWWhXfGwXoSrY33rJG2KkJVnnijsmwjFq1PogogLu6fOtbYkUS2ieLIwJ1RBehCJy9FAn7NHqTB+Zws4IG9w4j5B6jrPb6lo8Z5NFpv80CETdDyX90+0kw5h+CEsW65D9Y/eueMdvFDNqm63J3ryV4r6k+IXC2AhjorkEZmo1TKA9ZgSHzuodfsj5kpbuqFkNWhMxC70FSOJyuJs8Nfy1/IH4VUCYpksIpVOLcDxH6oHWQo3UwcPYYM+Cmw8tctRouuqluEEke8uCyL0uxRuBbJggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+A51dSx824/pKOQt4wU95+ggMFkM1dyea8A9aGKWZc=;
 b=g3LNXLxfeG/AVzmB7ktVTvGct6VbIkbrTJkureCp1DZG8o2rKcakACc7DD1HZIQk4BVPdc7m3YcomJh1QgC1HPzlktQ5IrMnhoMNj0Yvc0nbfMhKTifko7u1uTy06wt/nMLoru0th+uTmtVudQza4+zspo/Cx0Qv8VAxHYCN/u7xMtRiGcH6LINtIZ8HBuswDyACko2Spa7MUNeXfiVOqOWxe9mOTxc2IzMDd0jW6MXq9DErUTCVCQYrNXsRpssaq5VRmuvrUxCv9rC0IrxHHztvPMs/QfaivUQXDGrcpXr4CbsjsEehGrf+iTYgKEJUlb1aJF8vhRPmZumnNexUEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+A51dSx824/pKOQt4wU95+ggMFkM1dyea8A9aGKWZc=;
 b=hqNDXqXtadTpX9CouQbAntaF33mESGMHbiCWe0NQOg7yv4V14nytrI5RffnoeE1DrspR5yfbvevBOk0lo6Yl/xi7G1yhpNvpQ/+6jMZzKgIL9ozkvIOhY5ciiIkadVAtn396ctGA1G8Kvnjl4ZXI/ILC7iRmEgi83+cjgJrJSMmLvCEtU6xJv6KdBDqUZBW8EckKkM2VRG6Pncp2eyIDYY/7g3KSa4tIFSquuvpyx/49WqOCX6xGSPerkvQZv7ut7pSo4qAO4G48qbB6Wsfu+48GHHciPKy5Tn4GftnrMwbPbOPnd/CiYGwS/zoFfMN0ThW3MAGcfOyx8efno3IBDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8180.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:119::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 15 Feb
 2024 20:14:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 20:14:34 +0000
Message-ID: <6148d08a-69ac-4b1d-aa87-0301786aab1a@siemens.com>
Date: Thu, 15 Feb 2024 21:14:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 2/3] add SWUpdate 2022.12
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20240215155350.434472-1-Quirin.Gylstorff@siemens.com>
 <20240215155350.434472-3-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240215155350.434472-3-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: a34607d9-df67-4972-aded-08dc2e62b9d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JGDqiIqScicbmWCoeAOynw8cGoAE/4lMujuwWzz9iQxP6oj41cSRLFCML/32fC9noX9nBgBXR2vl5pq3f67DgVulClQ6c+pQ2ASO2amGuBJ9VceNxZQd+1LzTUjMPzmzXC84z6rgK4/Erqit8d79Hl0cASELZ13OwBDX5J4rJuaVGIAPwUxUFj5WK260XJJoduPh2YzKSiPwt7rp2CMtPBhjswWcohpNurtcVioprdtFIReXFN4nTPaIeGUJFb2Ze02IyAW0r0Ay6rzLmogMkDiNw0SXwHRrNgPcTBIqQJAuAu6cDcHU0yB9j87tAC0usKxIAMPdC1r4GfmsC8YZrIV+fn0h6HUQwJvlqbbTxObmlozD5ZbJtYNJoqNdvoAA2aMZ1sr+78uOve8jRRzkEj/DQOiR5viZZCvd7ev8ShG5OsiFGvNj9TU8rTHns6W9fkaHI43E8zbV/9LhqVmyAHsafAUO1Ull9/Iyk4vhu1r759Aa0FOMe3UGLIkhZtcXkcFM9fry8TdClzMeSdAT73q4h1tk+o9cdMLUkihfU8E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(366004)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6486002)(478600001)(966005)(31686004)(41300700001)(6512007)(8936002)(44832011)(2906002)(8676002)(5660300002)(66946007)(53546011)(6506007)(66476007)(316002)(66556008)(83380400001)(2616005)(31696002)(82960400001)(86362001)(38100700002)(26005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R0I4bERZT2tDcDVNNHJOV3NkazZXaEEyUDY0ZEV6S0xoMDFMbG5ldmtLajhK?=
 =?utf-8?B?amQ2aHA2YTM3eXJtTXBwRGc4MXRvbnBZOXVtdWJQNmg4RjVRSjNqVWhRcGJM?=
 =?utf-8?B?eXBHUyttV0VhSVFPcW5mNzRUVDdhbzEvZWw3QVlsNlRXRkVLKzhtaHQwTlFv?=
 =?utf-8?B?bWpaOXZPVHNCK0haZFE4SktLV0VhRjNHT09kNGtIYi9SdWJhamt0QU9jQmEw?=
 =?utf-8?B?cWxxcmhZVU92TWxRYU5VQkZ6N2VZa2pqVGlVaWhqTjhqbXlIeHU1eWwzK2dk?=
 =?utf-8?B?eVR5elhpaDd0a29FYmpJYmFPU2l0TFJIcFRGaGYwai95N3hoaWJSOHJkM1BT?=
 =?utf-8?B?cGg5eXdmWEVFbDBwbVd5bEFsMEh2UTgrbm0rSzZVV1EweUlENTZ3bStlNldj?=
 =?utf-8?B?RUNoank5RzNQQXhSbnpldGw5L0tPVXU2WEQraTgrUVlMOHhXcTNITndlK0hE?=
 =?utf-8?B?RGN0TzBacnlNM0xKdTBBTzRQdGsyMDJWUW1JbnFLcU5CT3BxR2ZBWnU3cUtq?=
 =?utf-8?B?cmtjVTJ2K3RQcHkvK1NUNzh6bnJuNVRpWGNLQUZQV3hFUTZ2RElMK0tSdk9B?=
 =?utf-8?B?WTl6UnFLNlErTVo1ek9FODJHQUhyeHZxQi93VE1jRFYzcEZTZE1tdFp0NnVX?=
 =?utf-8?B?NDlRVUV0MWFhU1p3Y04vRE5xajFyU1htMkwrMlExcXR4NnBLRXdlenQ3Q3Iy?=
 =?utf-8?B?UW96clhBN0p6eEY5U1Z1VlpvOTg0NUM3ZmYxSjJrbSszOG1mdE5GSjljZ0FD?=
 =?utf-8?B?cHdoNUZyOFB4SGFzYlJMMWdER1Z3ZzBrblVWUG9jS1dSTzNsU0FoSGx1L3Nn?=
 =?utf-8?B?V0N3QWV5U0pSRVliUVZHaXM3UTZaYm5KMms1SFJvT1czaVE3aUNyWWFSYjZt?=
 =?utf-8?B?dm1zaitHb04yRDJuUVFBMWlqZnc0QkhnTHltYlR4aFhYNklTd2ZPLzhpMnJv?=
 =?utf-8?B?L1BOeCtuamdUVzRKR0xubG1DVEd4SGZ5Wlp3TEN0ZGRHUm1uRjdNZXBzSmsv?=
 =?utf-8?B?dUJyNElHeHJFOTZPdXRGdmNTeHZrWTNYcTJBOEtOVnVveU93YlBNMkZlNmVL?=
 =?utf-8?B?cS8wczJyTDhMZFo0dlEzbmNlaGx2d2FPaTBsTENlQS9EYkNCamdZeG1DQTQ1?=
 =?utf-8?B?T2dqN0xtdzZPS01qWkQybURvZS85bnNFSHdrNnpYZUZwZXZuc2pLT2krYWpD?=
 =?utf-8?B?U0UxNW5zZ3RnZ2lNN05PQmFtQy83azZsYnlESzBCUm9TMU9qek9TNjBNeXBO?=
 =?utf-8?B?YjNtVDdBbEx0dTNNdHV4RlEyR0VuZlZ6YmhsTE5DTTEvK1dLbEUrZ1FiSE1p?=
 =?utf-8?B?TWczWWRLRVRVRk5ibjRqcjZDaFMwZHg3Z2dmenJVNUJ1UXBySVZyUmxEdjNC?=
 =?utf-8?B?ZENoSzMyWGRteWZUck5Ddmp1aG44V1ZkbGg5TDVXNnVxMDh2VC9tR1ZHVXhI?=
 =?utf-8?B?YnZtbEVXSDFJY2I5YXVWWFNoWTNubjB4VTBsaU1qUms2STdkT1BIdTdCQkll?=
 =?utf-8?B?a0s2QnltQm52L0F4YXV0MDVHeVJDVC9vMUs3SmllNXR6L0ZwY3EwNWZCL3lh?=
 =?utf-8?B?aHhXOUlhU1ZGNmpTRHBQUXpFZk1BbUdqNis1NnpHRXpRSjRvcEJrdDA0dFo1?=
 =?utf-8?B?V3QrZnJ4alcrd2xrRXdaS0hDdVdVVE93TlhNSUdpSmdQRkNoYTZWeWtBK3Bo?=
 =?utf-8?B?RUdpeVFqclBwR2dHdnhDQTJwTEJtakJRRURkZ2F3bmJXZWtDanVoU0p6cVZz?=
 =?utf-8?B?M2JDbVJlM3QwR2s1YlRQYUFrODRkSHpXNTkzQkdsWTF0VTNOZEY5NzBPeUNj?=
 =?utf-8?B?KzQwTFZlVTBoYnFyZlNzMUk2L21PY0lodC9YdnZSdndRS2J4Wllwd3V0ZTl6?=
 =?utf-8?B?ZDFCTUhieDJQcWgxcEo1RFp1M1dwWk1mRTRxb1g3anNyVFVudS9BQTlCUE56?=
 =?utf-8?B?clRmZW5id3NHUVozcGpzTDgwZE0vYlc2TUZVUzA3eC90bktTN09zeDViZ01o?=
 =?utf-8?B?bzgxSDlURGJtdlErMEVCRFVLaGFmZ0VOQnY1M2R3U3g4Z0hmc0VZelhOTkY2?=
 =?utf-8?B?ZUNhbEh5MFA0WStJbUE3bm1uQm4yK1dMcTZwOGo0M2Q2U2hEc0xobjJ3UURY?=
 =?utf-8?B?RjBnU0p0RGxyYkQ2REZ5QkM1NThkNU5RRHJmR3lLemUraWhQcW9lMDZHenVM?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34607d9-df67-4972-aded-08dc2e62b9d4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:14:34.0195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYifShHbTxGRy80XrxG324JSdQya3UK8SdfP7IgX63OcSZzS1u/lmdWc14cOrXPrS+px2T+oRAUR695aj8C49g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8180
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Feb 2024 20:14:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15006

On 15.02.24 16:53, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> SWUpdate changed the Suricatta lua API in release 2023.05.
> To support released legacy applications add SWUpdate 2022.12
> which supports the old api.
> 
> We use the latest release from salsa[1].
> 
> [1]: https://salsa.debian.org/debian/swupdate/-/tree/debian/2022.12+dfsg-4?ref_type=tags
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/swupdate-2022.12.yaml                 | 22 +++++
>  ...-Add-option-to-enable-surricatta-lua.patch | 27 ++++++
>  ...tch-to-add-the-build-version-to-swup.patch | 94 +++++++++++++++++++
>  .../swupdate/swupdate_2022.12+dsfg-4-cip.bb   | 41 ++++++++
>  4 files changed, 184 insertions(+)
>  create mode 100644 kas/opt/swupdate-2022.12.yaml
>  create mode 100644 recipes-core/swupdate/files/2022.12/0001-Add-option-to-enable-surricatta-lua.patch
>  create mode 100644 recipes-core/swupdate/files/2022.12/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
>  create mode 100644 recipes-core/swupdate/swupdate_2022.12+dsfg-4-cip.bb
> 
> diff --git a/kas/opt/swupdate-2022.12.yaml b/kas/opt/swupdate-2022.12.yaml
> new file mode 100644
> index 0000000..5dfe97a
> --- /dev/null
> +++ b/kas/opt/swupdate-2022.12.yaml
> @@ -0,0 +1,22 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2020
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +# This kas file adds swupdate and generates a ${IMAGE_NAME}.swu
> +# from the first wic partition
> +
> +header:
> +  version: 14
> +  includes:
> +   - kas/opt/swupdate.yml
> +
> +local_conf_header:
> +  swupdate-2022.12: |
> +    PREFERRED_VERSION_swupdate = "2022.12%"
> +    IMAGE_PREINSTALL += "cowsay"

Still there - may I send this cow back to the barn while merging?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


