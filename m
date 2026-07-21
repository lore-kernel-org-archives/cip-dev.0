Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C708FC4451C
	for <webhook@archiver.kernel.org>; Tue, 21 Jul 2026 12:33:40 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.28])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21573.1784637211543283734
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2026 05:33:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=nFOZ02Sy;
 spf=pass (domain: siemens.com, ip: 52.101.84.28, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCFz+abaps2eA75r03mMbXwEL5usx/Fmrhb9BGaFZG6Nvv/dU8NKPF9Yco6fDhvGeM82tUTUyS7GQ3hGZ+tCC1wzg9vpa95rFyRfvQbvGreHbD9xznnGysK4gCPI062bceUNTKSkEzM2ut98rC8BaUxtXrPp6mqHZQtC4I+HcgU6mFqFNzzZp7UKYo/YHVn5rrxkEfkJRoDdBgsM14v6jNGabqBRcIG4BuziXfTwjRaTC38YrU0fOwALgGtfNNGmxOQ6xgiGZAZjniA0yIHAOsf3zAEsX0Fdi+H+bpwXtGJFAQ5uRkkaWjBClmhxUZGrOsuRREDYRWcQBBkiPdT0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQygGGAJJfVsiNjUDwFndaFR7tdFnqfkL/U7BVhy42M=;
 b=cHuiMvbI1y5SP1np2KjiLOB6xfJu4iv1TlDOh35nbGXNr/65pTvP1ZEVofs0VWKiUC3jU1OpjcjIHhTVlot6c0ruT3+++z8ZPKaaWIFg3Y1KcNF1kaB3FQ7a5vMtLvnitE2+BmkVjHgpatwblczK11H1lFrROg4ARhqEy4xhwSmwHcAI/9zd5AKg1SMNkuKLTZKMho2wWSrfApG/kctZ+daZOuDAtB65GXvLaQJE3qERn4mdNh7TRFrBomZkpJOoP/mKH5M1CwAzusNG87bhRJ4GVM2cdRCgbBMC85ISjpTluXGxWAp7GC69q5m4VRIrrEHhBsdtWTt/l/zKivdoyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQygGGAJJfVsiNjUDwFndaFR7tdFnqfkL/U7BVhy42M=;
 b=nFOZ02Sypr78lgoc3YIHa3YJqBSd008DCnkvGKJf+iTOHZmAKfFIs/7wnsQfYl43EjgLHJOfg0wKDyyb0kTYf4QLj2qdiY3FRz494r4eqqCs8V3MY/gFvBo2UGbwRrSRMfHokt2NbQ47QPON9Bb8EsBbf0wQcUAffbgH/9IUN+V7YJ2JgWfOEiYEz2vIn8C4jE50B/6C9zY1BL5rqzmObrUVHW5sIbmhCMt4ChZBxGDUywdrXvQSbZFN0Haqlli7fN6ARxQc3E1YXKVtg91WEGUXdPb2Rgtv7Rv8VZeQr08oa4I26qZ5SlW7ZllVbHJuN6ha6cndCsQ3gKOzI1luyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PAWPR10MB8185.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 12:33:27 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 12:33:27 +0000
Message-ID: <4db6bf49-db59-46c2-a627-2567ae26058a@siemens.com>
Date: Tue, 21 Jul 2026 14:33:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v3 1/2] Add support for Renesas
 rzt2h-evk platform
To: cip-dev@lists.cip-project.org
References: <20260721114828.1390-1-hung.tran.jy@renesas.com>
 <20260721114828.1390-2-hung.tran.jy@renesas.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 xsFNBGhxJPIBEADH6a6idt3FEJo4DFxeRRX2ZUHJjOSPTpBN4vK2FbvDJjBVLs1/xzNpOE/N
 CxDcH0nd4BApJeGzxjJpsHW9gm9w80oIG2HAZl4es79JdRt6H5GTdFaux1J8tLVTCS3bzeuu
 ydAUTesliWxSiEb4vqpmcduI42edmJF9E43jjLXDyJcXJa0qYXA0qvChJr7gbkGmWc7iR8A5
 ZX1CrJJbwUBtzXGGThDPycgPYB1eR9OcFWJ2E6dBcLQiNxyOvxfpTKf09eZi2hBrZESpjMKo
 U/t9LX9SbyRwzpIeXQe8LQgyhppENmGSjc+Lm0YIreIU4ODbt1takxHTIpin1Po7lFiDMQmW
 aZrfNFKNQoffVyHq1gpV5BGIbnm8yJixpEueL2oygnN/evyNPQV7NzSoQaJy2lJRGjo4YrQy
 dfpJyaajNeO1njSttdWC30q28ZUorPzBPfLwt7B/BXyiMiY6/SZunfKQDAY+g835YTjEhBgl
 KtXEamOfypEvYfvzQUpLrFgK55yrDSndtNm71APD4oVNeV1I0KqbuBQk4o3TkR6ZYb4RLp9O
 dKGEnKCBaBaWJgf/1v4BLJ/ge8k135R1JLiyK/FylJbnsABE9k7/lELFKrwW22qgspkQAf13
 h2+T65+637hkxhGRYnrtmxjOUk4EbYbAA+rtj0mpBxnziWojQQARAQABzS9RdWlyaW4gR3ls
 c3RvcmZmIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPsLBkQQTAQoAOwIbAwULCQgH
 AgYVCgkICwIEFgIDAQIeAQIXgBYhBBvkezJSXuvL6yeVgtxQXbgz0zl1BQJocSb5AhkBAAoJ
 ENxQXbgz0zl1vv8QAMVze9Jevd0Qe9iYY64RX1rQfGv0xI094u9+4fOsIOXUjX70cbRgOZzk
 muPuEj96pBh77vGWb19dyWmzlRL0tTGg4ACcbHXgy93l6HaUTlVLUFpEKx1ufo2StSPPZ1i9
 4PBTfnyAhQqYH6dibaFpCHvhrNvLIidA/C3qBx2b5k7H9k/Hta/lhNPkJTSqLnUl2sU36ihb
 QFGvEOUnJjFVo7eUBDNjEDGXETfI2tfHuER7GxZZINFpzf1mnvgobaai0pt26XUrt0cdONGR
 slIv6hEQ4BcyuYEN5wZz68eMMQtaTXRoCGYPYpTEYu23BKYTPebIUAbM+CiEVHTkH2TSeDwM
 kc25z0ydFbA2D8I8J+atdBsmHlGCq1gMnSMZ/TtOrlL6OHFoVlaq95Z55a5cq72DF1BQBk1t
 jaPgiI3Frzn/ZLFfldakTbkd2vsZjBJEkcUtnc+Rm7x1Sn3X855zJmvYRzdLAPMsi/zVMsy6
 tvoIcJozan1CQE/vC1S5V8BXoE0PRointtfTxPDuX2//sSzlRgBVWIQJHuQ0asb+gzptVZT+
 naNdi+fexKfoSv6bxbsG2Bg7Pm3OZNASmaUodGNixZ3/y/VdzvvSaPPULYPuUCdZrTtX4wML
 ae1/UjUw7jUoEXOalGior+tSEUpvhfa9y8kzJswmtZW90lFYNuCtzsFNBGhxJPIBEACi38/X
 QWBviWYBLlk2czd15VQFpsfYFKzgO010e300DAL1D+CWatD7yiEK30m3vvHkOkyHaOz/DB18
 ksr1czcbQLYSpdC4JKlsUu75tf9EI32QBPRMms7mJ+qewti4xj1sjrBpuczzLC0CG+dkxTD2
 38AbgGW3m/o8zBsPGhVnJlRVGsYU/YiYxaE6MC/l5bzmb0ay58ySnSS32zALKBfXGpWmk1td
 KbcHNeEBuZu2W3ZYB5cTkDEE/3ycnWwqWh5u24SSLC/83rIeAjeyJ/wQ9+oSIHLlcl296sqM
 1wYKVCjwAXfA7vcEBsANUFL6NkdP+Y+HJPRT/EODKZsjqWjoi/5v5GKBLrScLxA9cpjTCYMj
 +1slg6T9FgUMQ+7GtbGI+/3WA/8ZE8emq4EweLzYT7I6hLB/dnoqRZFmRkLZ8q81r3Oc+xIc
 PJEnEpQIN/Ky0YelyPY4j+GH+NOlLvv9pH16I46O5PsTCkyhcfgfYUOJgP1BRQrnRmVn6586
 R86jfLLhtaagvg4Mb4NtR+ZAO8rF8xmrEv5q0YZBkRmMlRENwHWiCyvDzU7mTsyYvVweGgdL
 bak4VTz/Bm2kvnJyHAWOhWJk6BAgmQhM1c0eYG/vmyhS6O+omYIyDJFVp0ui71CazCFn7dDI
 +uzg6o6fHygmWDn43e4mu3WKEXCajwARAQABwsF8BBgBCgAmFiEEG+R7MlJe68vrJ5WC3FBd
 uDPTOXUFAmhxJPICGwwFCQPCZwAACgkQ3FBduDPTOXXrfw//Rc/CskZYHeM06zTK0NQKTt3+
 hgME6rUQh9y4iDF1KjEvmVDGyDma8AQ45WNP5EbWgMFWGtlTYwn3CbFuYlDLMtCYHkth1itN
 SoUdOttJkQ5ULq8DW+MFrP4xlG0zAx+CWeug6VhujVBro9xK57zgYs+LsCK3nlsYR91ZtZ8E
 73Bi58iGZL/DLRFws5ut9hGUE0HoxXAhUZ6de0QxXNmfApzK+rLUye+JYcEVWEfVCCofFy8X
 lk+r2OzCvMt43xu9OgV1Pg37ez4HVu+ZoPJ94NKteQr9QMR9PIOBXGlOuweKiR1IcYBjQHzL
 aptU47KTf+lJxZhy8H3l1ySuyQqxbFoPNUuAT9Fu2s7Mg7QzjLVkoIrkZ+YJ+CmgvZT4sPZe
 YAMMbi+ENwLUg7aYqCy1RHcit2jeoEMyJJ9PFcsbxcqIPaCG3xOurgMdwlGeGdaxSFvq1T4V
 Z50bOHQvqT4TbOxbxv8RLLtaNfIvudV3J+Xx3QyKY1sySFcCtCB/b4zoKqc73B5B0nXBw931
 qIxmFqiZiwfFB91OCCqRFtm2LcfwR1fLrUtSrhmENjdBhZljfJKjxAfFOWXngfT10Sin9h20
 4A7NrVMzatAJLl79L0PdJIVpGUDQHU9K7rIs2MoQKzmAvyUSJB4sAChft5wz7JbvFKqY2fW4
 Z2NBPBZUysw=
In-Reply-To: <20260721114828.1390-2-hung.tran.jy@renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0458.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::13) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PAWPR10MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 8066f2f9-ed5f-42d7-894e-08dee72443be
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|4022899009|376014|366016|23010399003|1800799024|55112099003|22082099003|18002099003|56012099006|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: 
	wTQrTBHCw4K4uGQebCpTnZ8+le8RvPc2hmzBKK/dJX+Vfo2jGCIWDF7LznVOrs4Ro7zdR7Gvf/qHHmXs05luLSvt3l2rCLJNdbzuLMvERMCt28UBorpPHMXzBzmKSjtMXi1V8Iy4iRN5we37uMrFvQyAE5DtoRQvoRuV8zacS9C157yabUoOohqjTEqpav7v1hm5zObDtgvJWf3CCIsvRSKZdxbUMXcaing6t7JyICHU5lmtEaI1KgZKKwcpV38hohmbonaqsQZ2Tj7Par10J2IuVcYcB6HeRJ4hr4LSrlEY4Wpgmynhyp98SH8/ge8HPlz8upXXQrGVev0WZ7uZCfHGbhEvzCgnphF9D6SXc6oFbttlVng6V64GWy94Yi4F5SUwILXrnjNZZptjjv7b6N41G7+ugKDY5YHaZGrBgegkQQJViuj79SOlirqko4spqKTF+mKcMBCJ1jlHZ72GLxiuH9fVpS6s+VujgMnGwi/YzIbS5293FO6/9B3DmqNNpj5VVjrn2IIckPeOHFFfQ3Yp3cjyF13nM3Y+cqMSove/ECHI8gcotr1hoK9pM5dk9OIDhE6qmUx2K16z0c1r1VVsf76CI+P95rEiW0/xn5jjpHnDjO8lvowTugo90OJY
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(366016)(23010399003)(1800799024)(55112099003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T21xbVFVRWpXTWplNmNYREFCVE8zUU4xZ3Q2WDI0NncwQ3g3emRaYkkyNTdP?=
 =?utf-8?B?Y3lKbnFOQmZOKzNDeld5enNKUVRObVVFOG5VUWVFdEJVUENlSC9NMGdFTzc0?=
 =?utf-8?B?ZmpkZ1dJQjV1dUQwaEhmY0FsaWQySDI2Nm9ML3dPK2s1Qjk5cXdtQ3NVVnda?=
 =?utf-8?B?Uy8wUjU3dlJWbFlJTWtlNUJlV0xrbWJyYlc5RE84S1VuQlVSbmRuUjVSRGx2?=
 =?utf-8?B?WGsvNFdxZGpNNm5YYnFBOGVqQnFVdy9MN0dDa3k2MTJnYUlpdFQ4eVJKQ2lH?=
 =?utf-8?B?R1ZlbFFsUzQwYjAwWVgrUmVCYjE1dmZGS05DdXhGWXJGbWttcUxIMnF0ekZz?=
 =?utf-8?B?UEdSUm1Bc3ROSXA5RnJXUG12b0hCMzA0cDZER2JFYjl1QmducTRGKzJsMDhR?=
 =?utf-8?B?b0ZlM01FWWVOc3V5MHJ3NzRVNDhHaDVuajlYVERxWDQ1T01QeDVYaDNmakJP?=
 =?utf-8?B?T3diam1PRzRxNWQ0Ly9GSmdoL0UvYVYrR3NOU2FiYzNwZ25NeDFndmxhZmxC?=
 =?utf-8?B?dGNnRUlLY3pxWm1ueDQwQTVac3F2czVJNElSUmE0bXVYbURKWFBUOGd4U05U?=
 =?utf-8?B?RUJOVW1kZXgrV25DbWJPdmNxVzJQaW5LZzNmcDhiZ1RISmIrMTNrRmtFMUpw?=
 =?utf-8?B?Lzh4b2FSN2dMNXFLR2pUcWJOMGlJank3OFBYTzZqRTZjQkp6VEdVTTZ4aUFB?=
 =?utf-8?B?c2txVDBPbTEwaUhZL3JzeEVvNFJ6NlM3Tk53ZXRwWUZMTkFRNkFXZkMxSjVp?=
 =?utf-8?B?c1d2bFZKVll2VEQ2aC93aTN0VEpoQ1pOd00xVVZTMGN6Y1hNY1ZNcTd0UXg1?=
 =?utf-8?B?S2xUZFFTby8rTlFXY1p0TGRicG9PcWVVMmduNUhzWXhTRWhudUNQMGJQTnRi?=
 =?utf-8?B?THgxRkRJSUNuZUlvM0drQXpleFB3cGtpZllsSmRvN1dZT09hL3VscEg2K21v?=
 =?utf-8?B?QjdRK2xwV0tYWFR3S3Y2bWg3VFpsejY2RDJ2aE1BeTFxVzBGd1FUbXNOcGlt?=
 =?utf-8?B?R2tkY2ZzVlhkZ3VZVzBLZGtrRUExQThDMnNVaERTSXhjclgrcEtleWx3ZW9W?=
 =?utf-8?B?MzZtUGE3SVpRQ1o4bTFSYlpYWWpINUIway9GeDdLSVEvamltUXBncFFVSFNx?=
 =?utf-8?B?djkrUm1maTRTTFU1MEhZWGNwOFp3a0xCT21Ld3Q0Um40QUlqUU5zRG1xZUs3?=
 =?utf-8?B?NGhJY0dQK0V6V3dlL0c2a1k1T2UrcnJpdUNCS0NBQVhwV2xOWVpxVkFaRjR5?=
 =?utf-8?B?U2w0MHhpQi9zV0x5aXF4OHFXbG1veGhDRitUeHJTY2ZQUEMwN2U4bDh2czNw?=
 =?utf-8?B?Z29jeXVJQ2txRzlSbjhQRnovbEN4dFBtTU5JZGFhckV6QWh2QlFUNVFiVHUz?=
 =?utf-8?B?YW5DUjlHSk8zaWhEZUFwcy9ma2xaM0cyK1pBUHdaTG42VkVQRW1BMjBWNldt?=
 =?utf-8?B?cXowbDdSRlJCbmFjeHlxTUoxNjhnaGFKMDVHL0hUQzZMSFFNMWpocTBseFpY?=
 =?utf-8?B?aGRhK2hvZHNTNU1jcWlnVk9sZWt5Z0Rzc09JZjRNZytBVFZwYUVyUWQwUmxo?=
 =?utf-8?B?MFlXVnVHQzMxTmh2MUZJb1JVRStLNzJ3K3RXbkJQV0hGZWwwcG5sUUd5YnlZ?=
 =?utf-8?B?UlgvUDhURjkwSU9IanJNTGprNW1nZ0lVOTJnZDAyUkQxRlhZNU5vOUhhY0tB?=
 =?utf-8?B?eFFJNUhWdzJiYXQzL00wMkJUZnkvNmo3VkxSTnNjTS96Ny9tQlg1SDdwMEd3?=
 =?utf-8?B?SzNDSnlkM2tBai9Oa1N1NVNsdFBzN0c1YlRvcDRYK1ZzTEwzeXV2bERQalJz?=
 =?utf-8?B?L3lrbVkrazB5OGhBVWNvdlU2RERsaFh2OWJVQmNBWFdHMGtEcmpJbjJzS2Nu?=
 =?utf-8?B?TDllWGZnVm5Zd1FuTjQ5Ykp5Z2pzY01BUktVT0Q4YnMyREFVamJ2ZWQrZE9r?=
 =?utf-8?B?RjBLcmFKNVlzbUdCRDBxUE1IcGdVR0tLM21EMXowSk90eloxOG9oK1NqeCty?=
 =?utf-8?B?VUQycXoyRVN0bnBGZ3BiWDNUN1FPczNyZjAwVktuR0FwN3JMTjEzMktkd0RZ?=
 =?utf-8?B?R3hSMmhMb2NZYzR1dTA0WWM1Y21YL1U0Q2huYXZOSGVOU0JhL2xzZnB6aktu?=
 =?utf-8?B?SzFscDltcWsrTG9NRFpTdUptSVhXcGRiSUxWSW05ZWhWSlBuc25UWmxURlR2?=
 =?utf-8?B?MnFXMXFEU3BoSHMyd0xqdnliWGpqak1xWUR4ZTZxTGF1c05VVHdJanJZdEJB?=
 =?utf-8?B?TmFocyt3Q2EyaXZzUHYwK3pZNTMxSFRGeEVEUVo5enBjSmorb2V6SmZ6L2ht?=
 =?utf-8?B?UTlsWDBGTUNyYmc3YmNrajhjNlVTSFN2MlY4N3JLTEJFcitQRDRjaUwwdVR4?=
 =?utf-8?Q?Q40LsKwOQDHWWhJ0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8066f2f9-ed5f-42d7-894e-08dee72443be
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 12:33:27.5555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nq1CQoKlThtykIHNK0dEzlpQ4H46W/WJmwU5n5ubdwOsm5TDAHQCD9Tm3m3ghgMlHLOe9t1P+20KABdh71kpw7tpmcujz5JXFdcaay2dgiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8185
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Jul 2026 12:33:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23701



On 7/21/26 1:48 PM, Hung Tran via lists.cip-project.org wrote:
> rzt2h-evk is the new reference platform for CIP project.
> It uses Renesas RZ/T2H SoC, based on armv8.2 architecture.
> This platform is only supported from CIP Linux 6.12.
> 
> Signed-off-by: Hung Tran <hung.tran.jy@renesas.com>
> ---
>   Kconfig                           | 12 +++++++++---
>   conf/machine/rzt2h-evk.conf       | 18 ++++++++++++++++++
>   kas/board/rzt2h-evk.yml           | 15 +++++++++++++++
>   wic/rzt2h-evk-efibootguard.wks.in | 14 ++++++++++++++
>   wic/rzt2h-evk.wks                 | 17 +++++++++++++++++
>   5 files changed, 73 insertions(+), 3 deletions(-)
>   create mode 100644 conf/machine/rzt2h-evk.conf
>   create mode 100644 kas/board/rzt2h-evk.yml
>   create mode 100644 wic/rzt2h-evk-efibootguard.wks.in
>   create mode 100644 wic/rzt2h-evk.wks
> 
> diff --git a/Kconfig b/Kconfig
> index 438234c..6894e87 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -119,6 +119,11 @@ config TARGET_BEAGLEV_FIRE
>   	select ARCH_RISCV64
>   	select HAS_SWUPDATE
>   
> +config TARGET_RZT2H
> +	bool "RZ/T2H EVK"
> +	select ARCH_ARM64
> +	select HAS_SWUPDATE
> +
>   endchoice
>   
>   config KAS_INCLUDE_BOARD
> @@ -134,6 +139,7 @@ config KAS_INCLUDE_BOARD
>   	default "kas/board/iwg20m.yml" if TARGET_IWG20D
>   	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
>   	default "kas/board/beaglev-fire.yml" if TARGET_BEAGLEV_FIRE
> +	default "kas/board/rzt2h-evk.yml" if TARGET_RZT2H
>   
>   comment "Kernel options"
>   
> @@ -149,15 +155,15 @@ config KERNEL_4_4
>   config KERNEL_4_19
>   	bool "Kernel 4.19.x-cip"
>   	depends on !ARCH_RISCV64
> -	depends on !TARGET_TI_AM62PX_SK
> +	depends on !TARGET_TI_AM62PX_SK && !TARGET_RZT2H
>   
>   config KERNEL_5_10
>   	bool "Kernel 5.10.x-cip"
> -	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE
> +	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE && !TARGET_RZT2H
>   
>   config KERNEL_6_1
>   	bool "Kernel 6.1.x-cip"
> -	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE
> +	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE && !TARGET_RZT2H
>   
>   config KERNEL_6_12
>   	bool "Kernel 6.12.x-cip"
> diff --git a/conf/machine/rzt2h-evk.conf b/conf/machine/rzt2h-evk.conf
> new file mode 100644
> index 0000000..5cfbfa5
> --- /dev/null
> +++ b/conf/machine/rzt2h-evk.conf
> @@ -0,0 +1,18 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) 2026 Renesas Electronics Corporation
> +#
> +# Authors:
> +#  Hung Tran <hung.tran.jy@renesas.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +DISTRO_ARCH = "arm64"
> +
> +IMAGE_FSTYPES ?= "wic"
> +
> +USE_CIP_KERNEL_CONFIG = "1"
> +DTB_FILES = "r9a09g077m44-rzt2h-evk.dtb"
> +IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
> diff --git a/kas/board/rzt2h-evk.yml b/kas/board/rzt2h-evk.yml
> new file mode 100644
> index 0000000..90261dc
> --- /dev/null
> +++ b/kas/board/rzt2h-evk.yml
> @@ -0,0 +1,15 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) 2026 Renesas Electronics Corporation
> +#
> +# Authors:
> +#  Hung Tran <hung.tran.jy@renesas.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +machine: rzt2h-evk
> diff --git a/wic/rzt2h-evk-efibootguard.wks.in b/wic/rzt2h-evk-efibootguard.wks.in
> new file mode 100644
> index 0000000..ca18bec
> --- /dev/null
> +++ b/wic/rzt2h-evk-efibootguard.wks.in
> @@ -0,0 +1,14 @@
> +# Copyright (c) 2026 Renesas Electronics Corporation
> +#
> +# SPDX-License-Identifier: MIT
> +
> +include ebg-sysparts.inc
> +
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
> +part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
> +
> +# var and optional home are extra partitions
> +${WIC_HOME_PARTITION}
> +${WIC_VAR_PARTITION}
> +
> +bootloader --ptable gpt

This looks like a generic ab-update wks file. Can we reuse some of the 
other wks files?

Quirin
> diff --git a/wic/rzt2h-evk.wks b/wic/rzt2h-evk.wks
> new file mode 100644
> index 0000000..4a4af6c
> --- /dev/null
> +++ b/wic/rzt2h-evk.wks
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) 2026 Renesas Electronics Corporation
> +#
> +# Authors:
> +#  Hung Tran <hung.tran.jy@renesas.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 32M --extra-space 0 --fsuuid 0x4321dcba --use-uuid
> +
> +# Rootfs partition
> +part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --use-uuid
> +
> +bootloader --ptable gpt
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#23699): https://lists.cip-project.org/g/cip-dev/message/23699
> Mute This Topic: https://lists.cip-project.org/mt/120374883/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


