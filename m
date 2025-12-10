Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB787D3C539
	for <webhook@archiver.kernel.org>; Wed, 10 Dec 2025 12:36:32 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14436.1765370182799124804
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Dec 2025 04:36:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ClL+wQfg;
 spf=pass (domain: siemens.com, ip: 40.107.162.54, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fViG1VGSpT9uulRpkSyPzfQLn4m5ikklJ301NQ7/UiWTW/6MFHDiHjwAKmO+3hG8gjJw5/Z2ILM+/bj+qNZu5y34pEcBX7RRGEeEKWUlQQG56wRkFqPpo2q12sfIG8OAiwXZrktiNblzqItIAYD9Di8aoItzKGdml+nWkCQVu9nnGGPxmqGrfHjbJl2PqGiRyaBg6eBBrjlUFYgYyYl5ZsRRzS7Ox7akuA0t6WUHkL40q2CWA4RcP3jMzwf+mCBrkVU2wwwCauQVAdE0W27xYvSKAs32mryz9d4gXp6bXLq/qr93+S55UsUOH8+V2yBCsrQ6rdmUjMKALpTuoF0a/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HG/sdBabgBiNJRY/aOu2uvU3FI6g/Sll40ItvzFQBNk=;
 b=k+P4QTRwMyUlFGqS9P3nVuZmkrHN+94tFad1URx9m3GH7a76zHRkPEigTFrpEepjTuITQVBiFZrSYAJ/uwcbGxKbaYfI0oQQlo+NZRTjtQjhAhzWmWYGR26SPMyEvHc+wI95lFxWEbe5FSzhwtxx0CHZXl6ovYft5XeyF32adBu5xyU6bSQOkHQ7ZbBnoAhTUqpgRpDLT1nD9hOUXFYdTsyX83/FnCyLO8Kouo9YufalfuOOYfCzweoEFspekNIx1XNrYr7hGkDK8l6XPydnnUcdNX3yZ1rg8YY5kUBpuHHXQ92cAtNH3ZHuIAZ7WYk4/YpCS8oDrtkRKFU5N5osLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HG/sdBabgBiNJRY/aOu2uvU3FI6g/Sll40ItvzFQBNk=;
 b=ClL+wQfgZMOyeibtPJfq5VHrk4TshTgM36ZGF5uKnGkigjk+F/24UWHO+Zko0QsgQDNCwvCxwfB3w/Tpo0DDtz/fAtpdgTwYnTp1jzT+UJxcCQCJ7bSKbaCOW9PSR0eHGRSHOGX23Dyepdcfg8uq6VXl0hNpeq8WvQsl5rgFYH/D/eOUzf5eYds7BCI/TFjfrYwbmSgZ3LY/k8K3LZAkIX/T3UZtPvygFz61f8rYXSghBqCIQdFZPLdHeeHkKMA+b2VmLsdwkdFHmognZi1X+O0ylFDHRJFrPOuqr4Ca54u5MtV6ygvfqoJOIBg8LBL+TXUrqll2LkeEtPw0PNNvMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
 by DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 12:36:19 +0000
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314]) by VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 12:36:18 +0000
Message-ID: <d78430a4-2d63-46aa-bf67-9f342a9bc068@siemens.com>
Date: Wed, 10 Dec 2025 13:36:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core v1 2/5] tests/templates: Add template
 files required to generate M-COM job defintions
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: sai.sathujoda@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro.hayashi.f74@mail.toshiba
References: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
 <20250207150439.392479-3-Sai.Sathujoda@toshiba-tsip.com>
 <0ff460aa-35ad-46f4-b7f6-f643a89d7b78@siemens.com>
 <TY3PR01MB11075341DA1CE1C0E9A379919C7A0A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <b7adc39a-67b5-4189-a36d-cade887a6a02@siemens.com>
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
In-Reply-To: <b7adc39a-67b5-4189-a36d-cade887a6a02@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0286.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::13) To VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:89::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2319:EE_|DB9PR10MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: c7474ebc-d008-4979-8dde-08de37e8b794
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?RulcpcRa+ZugcBRXM+Gn6R2rIwKF0XziViHWbRF+tRX++1CJUR245xTYNQE6?=
 =?us-ascii?Q?Y6wpMNScjS2CclaIXZS3Y+uSaVDHXjm1f5DyvZCipDDnE+rkBOSKO4qo05Y+?=
 =?us-ascii?Q?4wLi1mlqPwL0VXApPCKwvUOgQhmF6O1LRa0DllI2pynCgOeeckYAdpLf1soQ?=
 =?us-ascii?Q?/2nWsKc6fReVaFw1wUis03ZdCF5d10JgTsnk1cf8feuS/M4Fy2ekyRM9XHKa?=
 =?us-ascii?Q?sGqf3kttxYZHHJO7rGKCF2iDPXPLnyLfW3q3fiI7phcFHxo5TuVecI1JQ2JE?=
 =?us-ascii?Q?bV63NuEI1xB4z4t9tW9y3i9/YELXvuSH82X8BRAFS7VdTc1iBp+D0a5LMwxB?=
 =?us-ascii?Q?Ofx4zs76ujQzDL02K75tbFrhj4e6GXw9S7TzmFWsspgsqI9PLJ/BxsPAdiik?=
 =?us-ascii?Q?q0ARZqhtBWv380ZrYdXmD1KPkLEWj7FujDcTQxifJZv/xVmHlIeJbIx+N2yx?=
 =?us-ascii?Q?lky0yXCN+jamWFZKwvdimyFKdsuVeFy/bQFz1ff0YRpVzvm2m9shvegIo+Oo?=
 =?us-ascii?Q?zRcM7lki2lW98sYFuTVorIMIcXpJjs+8VFzG96DeQdSy8hiiBQEAVCtRfXzx?=
 =?us-ascii?Q?/8U27VsvV1HyxwjOPyo3AseKX7xK92xX1MXhAV3VIS/NhqEDP7cyxsVAuD7s?=
 =?us-ascii?Q?9J148cbbyZQYD8SuPyeKRkM2Q6rg8JKSU0cFnyC5s+6HSq24Tx769vcwBkU/?=
 =?us-ascii?Q?/JqGIQ6/KnIeJuum5BhEl37HhMsVaEfAzP/Z09IC/PTQXuqgp3tPhxviLHd5?=
 =?us-ascii?Q?m4jDVOBrPZ6QrVTMwiolA/YUZ3iYZKMHXYAyfU3SgaKRF4FYfWhjNPt8E8id?=
 =?us-ascii?Q?TVqm5St7UnnvvgCk51prnuro8oE30sl74YuW46HOqUPmYN41U03f1vRtP4B/?=
 =?us-ascii?Q?QvkQ7UEuoU0ZfTSWjffzqlABT85szZ6aOXsX96QXv0IYsPmKJ3X/INa6S8mv?=
 =?us-ascii?Q?/8NkZmACVcgK+RvNkmVAb52h9XY6UfP0jFexIqP6yboz3QOdLUYciro3lMnB?=
 =?us-ascii?Q?Hj5X3L5uZk0Zlobowxj9LiXTxnELmEVPoPxEMjMSDXMvJRU6nm5opD5GhjPA?=
 =?us-ascii?Q?2k0PTz53CIYyfjbB2lEyZSwzjEYchcbPb/ylTkaQ2iRUFuvBJVPxkePRyJKq?=
 =?us-ascii?Q?eNAUlax4XjLftxk0MHQGIMDutf+rsm9HC6tzXDkl4tpVFa9Ny6QHwPFyHOyr?=
 =?us-ascii?Q?60yNdYthwWOpmYmSjpNsXZTQhfTgJj1/t1getyCrD9VnQ5ZdiOaYuG0TCUtj?=
 =?us-ascii?Q?W6ostMtyIaApN+4Joj1o4zkfioeQS1KPkOdqj7OAmFtXM9VKSkXgHP5oSCY1?=
 =?us-ascii?Q?1STc9hd5+boBlMLEoU/2O9BLtpsPvuJxTbYbTELA6LtZWKm9xHJQVWGc0FFk?=
 =?us-ascii?Q?O0OKLd76YWONnloOtYqDXvtMDgzVPGGebOgGX0odkONXXKdjmLUsEQF8qC/D?=
 =?us-ascii?Q?qEYKlXfVNFX6ssL45sqmHSqaDrbelEwb?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?G8b8pFd3wBCyl8B7xX/tyATZ09mRyNRrdfcrgnjAr54xiiN8MOH36RcUWgYR?=
 =?us-ascii?Q?R4nTJEwD0gZN1F+GNOmyzQ/FfHyVa64m/ErHaBLsb3/x4Xq9hMJrft1vXQJL?=
 =?us-ascii?Q?02xgGNzc9YBZn9U7CG4hbFQaq6gIAuaxuTERpFSV/BItHyDlx92n5qNBqDew?=
 =?us-ascii?Q?0oVD/aYMbQOTdewz1k+WG4VCE72HHA4twyEYE2m6Db5/1ZbYcB9eVKtWfqc9?=
 =?us-ascii?Q?k/qK/P5XQvUxAe7PPVqwdAT+fZQoEUZ3dyX9mubjWjh2Y1ze1cN6UJGbU6va?=
 =?us-ascii?Q?dxodWKZHySHYgAhz2BtW6tUUkjvXpAtRxAi54ed5uQK03WpvjtzEp/2ynLa6?=
 =?us-ascii?Q?q6nlm9BonEKmw3O5fmXm96gdZccxbIOo70dlw/qoVlNJGQyasxGpT8Hr4gs3?=
 =?us-ascii?Q?HzPx6n5rD/2o/YKaKaaEOWQGRem8iYtLiXnoz9d/f2Nxgx2k7NZMVdH/wuNq?=
 =?us-ascii?Q?KNsGikRJ0rRZVoJMM5ulqTmTQ13Z3exjHdQUinSCBnS9WUiPkFYrSul3XRHx?=
 =?us-ascii?Q?yJzC0f/Q7cp9PGECbcz8A5+rJUn3IKZiN7d8Ba4unPjoOlvnB4aIKAGKn6nO?=
 =?us-ascii?Q?ZUesb/IQloXQS8M+oSwFHIhS5UNxd6YgLGM9/H/7l5i4ySwa74oC+YXAx7BU?=
 =?us-ascii?Q?nUzFZQezIJHeewxLfGT7N8xWcbeZtY1ApGQDd0lhgQMb21ceEHCawixfx4UY?=
 =?us-ascii?Q?ajAvGR0fliif+qcUWA/CVy9vR53e+8wHezTwf1iMSNqEwSHR6tBE3pVV+Bfo?=
 =?us-ascii?Q?DGFxoEkWm8TFW43/Ls7qfR221P7cKWa7IIZU4XBDdw68lsJdnZzdS79ffy2u?=
 =?us-ascii?Q?zYgn3y+naI6i0vQycqphoR8Ny+QjKJhW2DJPlBkCrbYQqqGZEoJB9O/L5mIi?=
 =?us-ascii?Q?iR+VokfBJwjx4Lb0Zds+nZR8jRc2WUvhZcqNYwJgtnxF3kboQJ8nzPFD7TAi?=
 =?us-ascii?Q?Gu9A5MSh6ywwKI7yFVfo+wU9TVWDj+g6iXA6VSA7+7X1zJSbmIS9+yw89E9B?=
 =?us-ascii?Q?VBz+EOLknWcucejsKJzTHPrkRPCldctmgsmNHlnvBrRksiwZ8ibZL5SQuUFG?=
 =?us-ascii?Q?dj20cNcg9HPbhnh/0f4CyPhCOu83RYIG7dMhATTkIiprTSLXksx/mYAOsnAe?=
 =?us-ascii?Q?ob3UwWTw9RUjo0CmjTE+2agYjtsOa6w5Tr7XfmZoBlGv7Q2Hl6Nj7Sw6iFjw?=
 =?us-ascii?Q?P0G7rYcIMkU00fvKbLrxz13bWiPTxzZJWkYt0/Z0rMfLPzrVtaVC4/anpkXC?=
 =?us-ascii?Q?M13uQKJWTCAig0m35nsORcgTt7+d720S2gHc0hII4hgsiRwk2ddMfMtQSGy3?=
 =?us-ascii?Q?Og3lwwWOfFWtBpI62d66zMzcrJia/DgaWgSqu5xxsDtnJjtI3GRdMcjCOkep?=
 =?us-ascii?Q?btyrmuUmaGlG7FqnF7MFzXHVXH5OLGVhMPEY6TZVO/ToY9tRBP4FV/3inbhM?=
 =?us-ascii?Q?2Xp75tLzS/ytaOjtBcJDAA5ILUKjSPdxTbCv9ujeR89nP5uH0eHuD9t+G15i?=
 =?us-ascii?Q?cuwOMvTb8RBXJuxSIYmhe6U3keR/ggxYHB20Trf941fKSNzm0orLaoivCfzE?=
 =?us-ascii?Q?EfVVOK3evE4s5QwUX2sh4GeQ4F6HDjs6yoUWvAm2ryDa6U4xyZypS7x39Ky2?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7474ebc-d008-4979-8dde-08de37e8b794
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 12:36:18.6809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qChdW2viIBXPCvdBMAErf0wUjoyGLWVFM/ZkOe++wCK3aGXUuY5aT4oI44Gg+rFf+rE7TWAamOpe9nEUn124r7Jg7xtfgbsx9YyUe3MZ9dM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8248
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Dec 2025 12:36:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20961



On 12/10/25 13:30, Jan Kiszka wrote:
> On 10.12.25 11:25, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>> Hi Quirin,
>>
>> if I remember correctly, the same license information was being used in =
the m-com health check jobs and even now also it is used[1].
>> The m-com job template is derived from health check job definition, so t=
he license information is inherited here.

The health checks are mostly copied from lava it self and contain the=20
AGPL information [qemu],[ipc227e].

[qemu]: https://lava.ciplatform.org/scheduler/job/1345735/definition
[ipc227e]: https://lava.ciplatform.org/scheduler/job/1344710/definition

Quirin>
> What is the exact external (non-CIP) template file we inherited from
> here? Maybe we can resolve this differently.
>=20
> While this is just a test file which will never (under normal
> circumstances) end in a production device image, we should still try to
> avoid license inflation unless really needed. It will make life of our
> users simpler.
>=20
> Jan
>=20
>>
>> [1] https://lava.ciplatform.org/scheduler/job/1238088/definition
>>
>> Thanks & Regards
>> Shivanand K
>>
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On B=
ehalf Of Quirin Gylstorff via lists.cip-project.org
>> Sent: 10 December 2025 15:05
>> To: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
>> Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>; dinesh kumar=
(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST) <dinesh.kumar@toshiba-t=
sip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =E2=96=A1=EF=BC=A4=
=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=97=8B=EF=BC=A3=EF=BC=B0=EF=BC=B4) <kazuhiro.=
hayashi.f74@mail.toshiba>
>> Subject: Re: [cip-dev] [isar-cip-core v1 2/5] tests/templates: Add templ=
ate files required to generate M-COM job defintions
>>
>> Hi,
>>
>> On 2/7/25 16:04, sai.sathujoda via lists.cip-project.org wrote:
>>> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>>>
>>> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>>> ---
>>>    tests/templates/M-COM-x86.yml                 | 52 +++++++++++++++++=
++
>>>    .../templates/swupdate-test-action-M-COM.yml  | 18 +++++++
>>>    2 files changed, 70 insertions(+)
>>>    create mode 100644 tests/templates/M-COM-x86.yml
>>>    create mode 100644 tests/templates/swupdate-test-action-M-COM.yml
>>>
>>> diff --git a/tests/templates/M-COM-x86.yml
>>> b/tests/templates/M-COM-x86.yml new file mode 100644 index
>>> 0000000..4716225
>>> --- /dev/null
>>> +++ b/tests/templates/M-COM-x86.yml
>>> @@ -0,0 +1,52 @@
>>> +# Copyright (c) 2025, Siemens AG, Quirin Gylstorff <quirin.gylstorff@s=
iemens.com>
>>> +# SPDX-License-Identifier:      AGPL-3.0
>> I had some request about the license of this file as it is the only one =
in CIP with an AGPL.
>>
>> Was this license intentionally?
>>
>> Quirin
>>
>>> +# This program is free software: you can redistribute it and/or modify=
 it under the terms of the GNU Affero General Public License as published b=
y the Free Software Foundation, version 3.
>>> +# This program is distributed in the hope that it will be useful, but =
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or FITNESS FOR A PARTICULAR PURPOSE.
>>> +job_name: mtda-mcom-#test_function#
>>> +device_type: mcom-mtda
>>> +timeouts:
>>> +  job:
>>> +    minutes: 180
>>> +  action:
>>> +    minutes: 95
>>> +  connection:
>>> +    minutes: 25
>>> +priority: medium
>>> +visibility: public
>>> +context:
>>> +  lava_test_results_dir: /home/lava/%s
>>> +notify:
>>> +  criteria:
>>> +    status: finished
>>> +  recipients:
>>> +  - to:
>>> +     method: email
>>> +     email: cip-testing-results@lists.cip-project.org
>>> +
>>> +# ACTION_BLOCK
>>> +actions:
>>> +- deploy:
>>> +    timeout:
>>> +      minutes: 60
>>> +    to: flasher
>>> +    images:
>>> +      image:
>>> +        url:
>>> +#project_url#/#branch#/x86-uefi/cip-core-image-security-cip-core-#dis
>>> +tribution#-x86-uefi.wic.xz
>>> +
>>> +# BOOT BLOCK
>>> +- boot:
>>> +    method: minimal
>>> +    timeout:
>>> +      minutes: 30
>>> +    reset: true
>>> +    failure_retry: 1
>>> +    prompts: ["root@demo:~#"]
>>> +    auto_login:
>>> +      login_prompt: "demo login:"
>>> +      username: "root"
>>> +      password_prompt: "Password:"
>>> +      password: "CIPsecurity@123"
>>> +    transfer_overlay:
>>> +      transfer_method: http
>>> +      download_command: "curl -H 'Connection: close' -v --trace-time -=
-output overlay-1.1.1.4.tar.gz"
>>> +      unpack_command: rm -rf /home/lava; mkdir /home/lava; tar -C
>>> +/home/lava/ -xf
>>> diff --git a/tests/templates/swupdate-test-action-M-COM.yml
>>> b/tests/templates/swupdate-test-action-M-COM.yml
>>> new file mode 100644
>>> index 0000000..02b0b03
>>> --- /dev/null
>>> +++ b/tests/templates/swupdate-test-action-M-COM.yml
>>> @@ -0,0 +1,18 @@
>>> +# TEST BLOCK 1
>>> +# Fail the job if software update application failed
>>> +- test:
>>> +    timeout:
>>> +      minutes: 15
>>> +    definitions:
>>> +    - repository:
>>> +        metadata:
>>> +          format: Lava-Test Test Definition 1.0
>>> +          name: sample-test
>>> +          description: "Test software update"
>>> +        run:
>>> +          steps:
>>> +            - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAV=
A_JOB_ID/downloads/common/cip-core-image-security-cip-core-bookworm-x86-uef=
i.swu --output test.swu
>>> +            - if swupdate -i test.swu; then echo software update is su=
ccessful!!; else lava-test-raise "Fail job"; fi
>>> +      from: inline
>>> +      name: sample-test-1
>>> +      path: inline/sample-test.yaml
>>>
>>>
>>>
>>>
>>>
>>
>=20

