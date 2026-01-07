Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E4FCF6C11
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 08:58:03 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2003.1767776277721507578
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 00:57:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=b1jZ9ky0;
 spf=pass (domain: siemens.com, ip: 52.101.70.42, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCqs3ypvLbE7k0m3RrJX0s4wNPSQWO475fP24tFres1jea32Pzt7J5GY8FVzpnjAKjVqFbbRXz4heFDyAltTkQ5IfIBmiIENDTZSWpbQwSfxa5SFJBiNKHbIfPFp3xq+F5QXqvyVa6ocxScXjJVBS7YHlHPLZ8GhA+TwuSne+I/DiRc9TQi+hZ+G7aa7y4ZJAX5+7MxY3NbOSqBGkN2D3pr8NIzLGdjqDR8kgcZgCncu8jBvQvdGOpgpKNetcOv3wj9grUd/85fW8/nVg8PNVLD4QX1CaagOjjTwJ0IHa51lN6SRo/0qRj0TlZgThu2zzmwENEHHZ8RUgYTkO2EgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sa+KJm9kDKm1BEIpP2HBwQxlx2z43zCuvwOCozN7Gag=;
 b=K4Y8fwMX9mHKK0wWjjGhxzrwMWd9sFEw7c/qPkoVzyi5/PkQw46IjYbP78m+uOO3krffqEmTMt+8uhdChiZAx+zMwtUQUR5M7zutovbegAeNduyFxoTNM7duXo0lKhHnGkwzJu68CX9EDGMb++S1WPQB5wfkpImKjwAu5pUP0hO9d0L8666Xdr8X6YSjZO17otD/O6EoguzEeZ6gV2iqVtbE2QWO8pduwGpz9MWhzjor+Tea1SYjjRF0WInvfUKjKA6tsjAv5NAQCz4D/hQfBv9C8xTr4qQlpcBX9R4Um1ZkHKDJX4KOO3EP6D0joM+W7s4Pdiz4zKMxW7PE/ZnxXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sa+KJm9kDKm1BEIpP2HBwQxlx2z43zCuvwOCozN7Gag=;
 b=b1jZ9ky0k5rnd+4XrOv2xy60O4qWm4goZc8jRsK/SCZdt3fOU1sDb4xX3QH6AybeAgDKQhM0/0jrBoaqU+/x0agk9uFYYAOQnfIBUiUzHcMn9gSlitaKTMbIn9CweIz/rh9LvSmagLhMNAc4UhnVzCJhhQjoahMmB3Ic4axzleoLxgy9xs/qxqnYbY6oGXBXNIA8lKc5bf4DtnkiDg65uTyLU77QrDYky0uCX6H0x0wd/nloSYG6bzli/YnWyNgxjPgaHRkCtYwNdtOGtZnUsYR5HKxvC9sz83Jt4+s0sMlcLjm4FbX9u89EhL1eqH6zQyrx3RGJvT8NEg8p+9ssig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
 by GVXPR10MB8897.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 08:57:53 +0000
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314]) by VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314%4]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 08:57:53 +0000
Message-ID: <856abe79-7284-4b71-b7a8-6249bd02abc1@siemens.com>
Date: Wed, 7 Jan 2026 09:57:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 6/6] Add documentation how to
 integrate isar-cip-core
To: Jan Kiszka <jan.kiszka@siemens.com>, clara.kowalsky@siemens.com,
 cip-dev@lists.cip-project.org, benedikt.niedermayr@siemens.com
References: <20251219103349.1227710-1-Quirin.Gylstorff@siemens.com>
 <20251219103349.1227710-7-Quirin.Gylstorff@siemens.com>
 <25dc0f6c-e450-45cf-b1d5-f7b9c3c09a62@siemens.com>
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
In-Reply-To: <25dc0f6c-e450-45cf-b1d5-f7b9c3c09a62@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::7) To VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:89::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2319:EE_|GVXPR10MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: b144d58e-eea7-4ba4-e81e-08de4dcad7b6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RGtRTTFDSEZWY3hyMi9BWUx2YVIzVFJQemMyUkFwa1ZmZC9LRXBDdXRNeHhS?=
 =?utf-8?B?em1zYnJnT25WSS90em9Ydlg5Mk1YcWlLTGNnUExGcXFtWUYvV1hkb083eDI0?=
 =?utf-8?B?eEhQK0FsczdrQXErWXI3QzlNalppSnNUTWtheG0yVStzUTlVS1ZTL01NMzd1?=
 =?utf-8?B?N3dCTHJXM2NOcFNnUWh0MWFNNklvajZTVEVNSklWQU5qS0hJLytFRC8yam42?=
 =?utf-8?B?SVFhUEVQUUpqRVh2VklHbTNnck5QbGtHQUVmSk1VTEZzb1VWcWQ3ZGhjREps?=
 =?utf-8?B?Qml5VkJLRFhJdHJkUWtLM0tUdC9GTFJkK0JlOENhZFpjZjZYdjhwcVpoYTU4?=
 =?utf-8?B?dzB1NlFieU5EWTgrZ09qNW9LSFZtbmR6MVM3VWlNK0RFTDN2eUhpZjBkUHlQ?=
 =?utf-8?B?czVqeWN0YmZhV2RHV2lkRWlFcFFCSjlZUHNoOTVsdVlQU3lGazZBQTNxRHl0?=
 =?utf-8?B?WVB4dEhNK29jR242TVNsVVZER2xudlFMc3E2K0hCcHZlV2FRNUY4U1NEQ3B2?=
 =?utf-8?B?M0RmN2JmTDFDTzRFU3hsaGJwYUlwOUVWMTJOMEVaUDFtb3hvWHI3N0Vramxw?=
 =?utf-8?B?WHpZMlRoMTBwbFdPZVN1bGZXVnF3NDlQTDlTY1hLalBvU2E3d1M3QUVWNnpa?=
 =?utf-8?B?Z0VIWUN0M0Q2aDRtWkxqejdXWkhPV2wrQ0w4R0t1OWZEdGNkQ2N6ZFB4KzdU?=
 =?utf-8?B?SndIekpIRGd4ZG85MEhONjR6Q1JqVkJmWStYc3NlUnlucGNldkRNQVdRYlZv?=
 =?utf-8?B?OXlNa1R2Uk5pbkR2d2theEEreEppc1E1TTBvMnZoY3lYZkVHL0l6bkNDRE93?=
 =?utf-8?B?MzQrMklzeGtJZzVzbEZJSjhrT2RSdTRzdTkxbnp1c0dlL09VZU9FSlFaYWww?=
 =?utf-8?B?Uy9oZWdWS1lYankzekRIRXYvN0lzOXV6Z1JLQTl6TlZYRnVxalg5emFYYUd4?=
 =?utf-8?B?UHIrTHYzNE1mQXZwTTM1ZXRvSGpXM0h2S1F4bi9waDlCclJhTjFCR2Y1Wlho?=
 =?utf-8?B?bW9IR09mcHg4cVJRSCtOQlZIWXQvK2JHNGJMV1hEQU1YQWZSbDJCUmxKOGR0?=
 =?utf-8?B?ZXdOZXhhN0MybWVtZFdKSGErTzFnZldWOWx4S0tDRkU0eTRDSDB0N3BTY2Zo?=
 =?utf-8?B?RjJ5Y0hTZXg5cXRlUTNSdlhBeFZ1RUxick9jUHhTL05CTStZeGo2ekRDQVUy?=
 =?utf-8?B?dGZEUWVmVHlwbzRkQWVpY3EvQWljYXBNSFAwbXQ2UGtLeEt5alN3SjFDZ2wr?=
 =?utf-8?B?TW0vWWIwQlhMbW9OaE1mbnJtNHdEcHZwNW94ZUpQY2NJbXJ5R09BZzgzd29h?=
 =?utf-8?B?UjVieHEyYkFab3l1WXg2M3ZwNlg2YmhKMEJ3Nnpsa2tocUV4bGV2eHRwUExR?=
 =?utf-8?B?UFEvV1RTOC9RQTlGSGZ3ZkZqRkNLSTBGYkV0SkRMUWR6YURHY3FHT1hjclFh?=
 =?utf-8?B?cVpZWlBKTkJKdlVVNW9aUzBrdjBhN1cvdWlOQUc5TEFDQUFqSDZVQW9zczE5?=
 =?utf-8?B?U2pFMGdRZzdJRDU2VkQrN1Z5NU56R0h4WXQ5VzNFcTBVSkpUSkllcmdjVUJz?=
 =?utf-8?B?a3FLZ2hMQ0dBUEMyNlNWOXpTTG5ySHR4bkxEVlUzVjlIMyszU0NYYnhsdDB2?=
 =?utf-8?B?a2xWekNTY2xDcmFGenVlYjFwemhoODFoeEY3WFd6a3pLaVJSbEJQUWVNSzhQ?=
 =?utf-8?B?dzBWa2NDUUk3WWIwQ1lBdmxIR0liR0lZSDNScWFVdlJNZ2I3RVhkMGJMUW9o?=
 =?utf-8?B?YlR6ZkMveStDMjZQMy9oNko3UHpiay94a3NWUTN0NUxjWlRPT1M0QWMvNy9K?=
 =?utf-8?B?dmx5a2puTmxvQjhxb2VGTEFOT2xUY0xNYTM5ZTI4NjRZT0RLN0dSZXF2R0h4?=
 =?utf-8?B?dmNwZnNYY2pteitVVmFxbnBxYXBJTnYvbDRLWFU4dFZuYlQ3QkxPdGNWekcr?=
 =?utf-8?B?ckR6ZlczaTV6VDIvWEtYQkF4eUI4WHQ3K0wyOVVGU2k2QlZmTG1ibmxMQmI2?=
 =?utf-8?B?Y3ZKTkVkYkl3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?enZWempLUjloSFdleVJXL1Y2OC9yM3QxcDlUejB5K011enBNclY5Z296VVlt?=
 =?utf-8?B?eWt5bXUwNE9UNXVYVHBRd1pLdHhQUmovTTVTVm52Q2o4TExoaEQyaTZFWFV1?=
 =?utf-8?B?dTdNU1ozSVZMUHAzSHJBenk3c01HczRQeWQ0a3pROUxaWThBRGJ2djJLV1pV?=
 =?utf-8?B?Z0duVCtXTzF0anhEVUQ0K01HMmJiQXY2RENUNDdNazVUNzhFM21uQ3JQRytm?=
 =?utf-8?B?S0ZnQ2RDeldoUXl5bHBIV2lvSThFYlJzdzhOZFZacTR4MFUwN2ErTDlFOUJi?=
 =?utf-8?B?S1FpREhFKzlvWFBSQVQ3aHZZUHJaV2tJbGdrUm5YWCtsL2hOV1lPc1c1OUl0?=
 =?utf-8?B?VU1jalg1OW5wS012dURlUjh3VzdFTWhuRWVSK25TVGcrazR1NzhoNzVvTW1M?=
 =?utf-8?B?aGs0dnNORGU5WmdFT1FSTGtQaVdaTFlWaXZsb1BGSTNoZ1k4QTduOFRxNUFW?=
 =?utf-8?B?ck9sZ0pEenVOOHhvUnZseDErdVZ5UWVzbkJDdDRENnd2Q1JhRS9jeGR3bFhw?=
 =?utf-8?B?d2tBU1RWT1prQStYVG1qdkl4WmVJVWo3NFd0ZEhoa2MzaTFsL1ZPdVczTFhM?=
 =?utf-8?B?MHR5ZGd6YVdkd2tldWtrS0ZwdVE3TDFFSzQ3cjZPK1VYZ1FZeHU1ZUEyc3lN?=
 =?utf-8?B?Z2MzSk1td2tYTUVsWUdWUUE0cFMzbmMvemtNUWZ2MTJ2bGFVc1ZXSXhwNTd3?=
 =?utf-8?B?SUdTRlU2OGZteW43ZVVzNXF2bVJhVkdmUi9SNTZScG44QWtSZEZocXBYTWJr?=
 =?utf-8?B?cmZrNnQ3RUlPbEtJd0NNZ0JSL09oZDNIUnJyUkRVZjRsVElRaEgzNUxqSkNU?=
 =?utf-8?B?eHJWVlBvQUdkSmxZV2NpMHpGeFZtY3ROVkpaNm5WajBBbjcxUXg4MU5qYi9k?=
 =?utf-8?B?eS9nSGloSlVUU1VGYWVvR1pWK3RqWk1MaHFVN2hXUHBBTnB2clJwUC9hYm9I?=
 =?utf-8?B?eEluQ3d2eXcyclFxeEl5RHppaXlTTDJlbTByeXljc3dRMDFhb3lrZ1VQbmUy?=
 =?utf-8?B?S3lkdVA3di9yU3d2QVhsMm43WkR2NjZiN1ZSS3JSdmFHZTNQMm1hTEJmQ0pY?=
 =?utf-8?B?cXYvTVV4SC9UL1NjczRnUG1WK21EcmlPTlFIUkFBZFIvMUdTUXowYzR1MU5W?=
 =?utf-8?B?a3dIRUJKSXltVjlqUkljb3kyS1FwUklEQjlFRUZ6R3piQlI2SWJBMDFtQnpq?=
 =?utf-8?B?eWcyakpRbEliZWhtbDlIczk4VnFVaDJ1Q0ZQdWxVYXNvZWZiRkVpbjFuc1pK?=
 =?utf-8?B?SlhFTjExOVl2ZnczZ25LQW9qNW9qeGhteVNvaDFWSytrSy9EWUx2N21OYWcy?=
 =?utf-8?B?cm5KRUMrUDdoSTBzSmdheHVMSldnWHl4WTdINk1qeU4xcWN4ZFErSFR6L0E3?=
 =?utf-8?B?MGkzajJHREYwcXRqNmhIMVhKbjZzeEdLWFBOckhFcktRbEszWjhzcmtMdy92?=
 =?utf-8?B?aHJzZzV6dU53ZTRLaUlvZUkzTXB0NjJxT3VRd1NteFhZa0xUWkYrbTN5TGNM?=
 =?utf-8?B?N0F6ZHlGaDJha0pxbW9RSnN0dmxxZ1dPVjhXcTM4K0ppTE1oRU90K1lvTXdi?=
 =?utf-8?B?aXZRcFFORWJwRzkxN1JRWGE2cWdTSVR6ME1URlUydTRxNWF5Vlg3blBqMUpk?=
 =?utf-8?B?cXora0JlczFUYUF2anQ4VTFyNmdKSytUc0tXMlJ4L0tIcTZaV2dQMFIrNElh?=
 =?utf-8?B?N3BWaWZxV0g1K3NBTGZSd001SVNqc3Q4NGF5bnFJTGlVeUY2RmZjZlgvUVk0?=
 =?utf-8?B?UjNGekRteGhjdjY5LzdqYVA2RmRhcnVVOURRaFVhZjJSMHlsMUUwUlN3UFlp?=
 =?utf-8?B?dit4Qk50Tnlzbm9uRGZiT2l4MDd6TDNJa0o2STBLZHZaTHZwdHhxeTNyc3JE?=
 =?utf-8?B?eDloVGQ0dTB0VFFFUlIvbmRXbSt4UUIxbXhaU1JzVGlFVlY3QkZmbEVWNEpO?=
 =?utf-8?B?Y0dNN1hveGoyVGwyV3d3eHZFbE9PZUIveWZvaXMvT0g3RnREWlZLV1hROGw4?=
 =?utf-8?B?UzY4Q3crT3ZzdmxtNjcyLzYzdnJ6TXVhek9SYTZDWjZEMzV6RUlGeGRZdFFB?=
 =?utf-8?B?QnplNWd1NEgwamZWNU9VcFJJMkpQRklsUnBSUm5vZ0J6YVNvVklTa3lkdVNs?=
 =?utf-8?B?cno5Tzc0c2t3ejdxRENWYnlYSGpmTmtBL1gvYXFDTVBJY24rdlpqQkFQbkdz?=
 =?utf-8?B?RTVxc2Jnb2dRZ3dvTGh5UW9obUdFL2FNMXNxVFZJS3VVZ1J2WE1neFlwTjJT?=
 =?utf-8?B?RlNwd3BBdSttSEhMK0grQ0JNczNpR0oxNW5oUUpoVENrYVhOT3FJUEp3bTRo?=
 =?utf-8?B?aWdJRGZqWnUzMm5mSGhySE9yVlRaT2ZlVlpvSHJGUzg3NW1KaWxkMndrUHdw?=
 =?utf-8?Q?FNpST+0mZFXqWsUM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b144d58e-eea7-4ba4-e81e-08de4dcad7b6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 08:57:53.4339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72UAR/JRBQ70mYcwzwRqFOeHHDXgCw0rqdhs1uW6DJBFE7CMBpvCN7fpv/6lA6Ucvofz+avNPA9DJA1zujt1ErD+ct4zjQ9OWRtVFw7nfUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8897
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 08:58:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21400



On 12/19/25 15:30, Jan Kiszka wrote:
> On 19.12.25 11:31, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   doc/README.usage.md | 55 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>   create mode 100644 doc/README.usage.md
>>
>> diff --git a/doc/README.usage.md b/doc/README.usage.md
>> new file mode 100644
>> index 0000000..b11152a
>> --- /dev/null
>> +++ b/doc/README.usage.md
>> @@ -0,0 +1,55 @@
>> +# Integrate isar-cip-core in an Isar layer
>> +
>> +This document describes how to integrate isar-cip-core into a existing isar layer and build a
>> +A/B root file system which can be updated with SWUpdate.
>> +
>> +## Add cip-core to a kas.yaml
>> +
>> +Add the isar-cip-core layer to a kas-file:
>> +```yaml
>> +  cip-core:
>> +    url: https://gitlab.com/cip-project/cip-core/isar-cip-core.git
>> +    branch: master
>> +```
>> +
>> +## Configure the root filesystem for A/B Updates
>> +
>> +Add this line switches the root file system to a read-only file system
>> +with /etc as overlay. It also installs and configures efibootguard and SWUpdate.
>> +An additional image type is generated with contains the update artifacts.
>> +
>> +```bitbake
>> +require recipes-core/images/swupdate.inc
>> +```
>> +
>> +## Create a image description
>> +
>> +Create a new wks file to describe the image. It is recommended to use
>> + [wic/qemu-amd64-efibootguard.wks.in](../wic/qemu-amd64-efibootguard.wks.in) as
>> + the base for this image. As all necessary variables are set.
>> +
>> +## Set variables
>> +
>> +Generate the uuid for the root file system partitions. These variables are used
>> +by SWUpdate to select the update partition.
>> +```
>> +ABROOTFS_PART_UUID_A = "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
>> +ABROOTFS_PART_UUID_B = "YYYYYYYY-YYYY-YYYY-YYYY-YYYYYYYYYYYY"
>> +```
>> +
>> +Set the certificate source and mechanism to sign the update artifact.
>> +
>> +```
>> +PREFERRED_PROVIDER_swupdate-certificates-key = "swupdate-certificates-key-snakeoil"
>> +PREFERRED_PROVIDER_swupdate-certificates = "swupdate-certificates-snakeoil"
>> +PREFERRED_PROVIDER_swupdate-signer = "swupdate-signer-cms"
>> +```
>> +
>> +Set  the variable `OVERRIDES` to `:swupdate` to customize the initramfs:
>> +```
>> +OVERRIDES .= ":swupdate"
>> +```
>> +Set the boot-loader to efibootguard which provides a mechanism to switch between the root partitions:
>> +```
>> +SWUPDATE_BOOTLOADER = "efibootguard"
>> +```
> 
> But this is already the default - why setting it then again?
Oops, I wrote the document based on master. This is no longer necessary 
I will delete it in v2.

Quirin>
> Jan
> 


