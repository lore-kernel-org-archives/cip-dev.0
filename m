Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BF5D5B16E
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 13:36:25 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.59])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48713.1765805779049887209
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 05:36:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dmIPXslF;
 spf=pass (domain: siemens.com, ip: 52.101.69.59, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYRSbkQacDW64qKpi7UjmgS4BkjKGGiG8VrXo+46MZR/u1xTEXcfjiqFJdjkX5bzv4TvpTU4ai4b5qNvyCpANZiETMqJinJ013En3jpIfD4NZWjMQBJ9ZCVHgf/0sIc5GcRbGcUVaziXkKlv8UrAVzG+B9UwOuUsrLPCjaErnJOjzPjqqqMklLbZRYxTGjFoDfwSSj427j2fGrEtts1rkW56YZ83Dn/XYK+sQpE6lRIUoQtXKQI3vwLKNZjIWJbzWJU3UL+GgdxLVG5lg7d54sN9xwI0Yh0VnOlscVbeaQ6j/WRlyTxo7DdhrHd96vKA0WAGM/Fnm0p6aVvsgIIEUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yDKeHDH+ROUzs6Aw7cStcRJJkWZaknR8NEfCMnwyEg=;
 b=MRWfsi4hI+CmPVnN6t6tnp5Go/Q2eJk0j6UFFe4aj47i1LJkeLdOQLt936oQswyMR6+wrXMaazxPJLVcOejjyW647KCxIewYiiEsFRVPGug0g31kNXHEEJGAvVEwHEsOH0gQydP6E5aBstDXjcuMxgCysD1lab3b43PndQC8aoxd+ni82rkjrL8AUaO10pZznw/bi9wXbWtjlEVcsGhYIzSM3fcplybiDuhjk8oLu8XN/P1rEnSMzm2Vt2qWxbhEklHSFu85yVnUke2juGQ/HiBwRXMf+JXF5/IPr7XwrZDIjK14OBPaZZIVjSpxt442lu8mopivYV9X2+LeO3DsEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yDKeHDH+ROUzs6Aw7cStcRJJkWZaknR8NEfCMnwyEg=;
 b=dmIPXslFv3ItCHnZ8lZMqiBcCwLoFpIf4C/sxqcHlPk0oNK/gvNmv6aipOkQA86gICi1rXtYuJ+RIM+bpoc99hYV8Jtvkmc/lHoTvTQqH0JzRWjsBQk9Y2Fzizy+ZdJX/JCxOwHHcVkaqmO3ynWXmLtnlG8IekdNoIMxQ3mePO8+MA9/WXKlZ85F6/QsnWHNlN3WyoM8HkqcPcM68FrpoJUwPo15wMe//L3bQDw6Xnf/vWZzRBjU1HEEQscRx8sFcEC359Xo4DVWxZEzRgsWdSjx3D37b4nBcO296nzc+FqKp6uLNxelVOyMIW8QUGhjiLGPqk3lctZHBnVZM39vwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
 by GV1PR10MB6172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:94::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Mon, 15 Dec
 2025 13:36:14 +0000
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314]) by VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 13:36:14 +0000
Message-ID: <5bc8c2bc-9dec-43a3-87f5-feb862d516b5@siemens.com>
Date: Mon, 15 Dec 2025 14:36:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 3/3] fix: ensure separate root
 home dir is recreated after factory-reset
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20251215093719.323668-1-Quirin.Gylstorff@siemens.com>
 <20251215093719.323668-4-Quirin.Gylstorff@siemens.com>
 <04433088-58a1-4b85-a72c-d4aad7538920@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
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
In-Reply-To: <04433088-58a1-4b85-a72c-d4aad7538920@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::6) To VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:89::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2319:EE_|GV1PR10MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c4c4c63-bfaa-4483-e9fe-08de3bdeea99
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NUJGTG9QNUlUT2VjMHcrTFRnd1ZJeTg5WDBJSXJtZFdRY0U4SUNTV3ovSTht?=
 =?utf-8?B?MkgyV0phNElWVW1SeDRLWkk4VVdza1R1N1c4SStSYVBXNVFwUmpLdEkwMFdP?=
 =?utf-8?B?SklQTVNzM0VFQzFWY3pkTDhMMjA3c3h3ZnN3d2ltUWYwUmUrdnZSSVUwRHIw?=
 =?utf-8?B?c0VVSWk4d2F6ZlJaVDZwdklBRDJpUithanlOTFlQV256dnppY3ptYTdpUFFX?=
 =?utf-8?B?b0ZyaERkc0pKK0NLMm9yQk1ueXdlVVoxbGR0aUxwVXNKRERuM0RjeEtrK2R1?=
 =?utf-8?B?QzRCejVaTTlCRVg5UzEzY0hMNWFhMFMwMG5OekcxeFBzVklCTXJlNm5qdDhV?=
 =?utf-8?B?QS9URGlFcHdWUGdTY0JlcnBKL0xON2pjWjVheG9zYVNMVWxTSkVUN2xFenhJ?=
 =?utf-8?B?eTVOY1BwY1dSSFJtTHl5V1JNV2V0S1JPQTdhZDRCZUxxMHJmYVVzazFOK1dK?=
 =?utf-8?B?UlN5enNoSXFXYldqRDhkUGd1cGNEdlhWRktJU0hKODRrTGNFYlJ3Ump2eHho?=
 =?utf-8?B?eDVVaGVOM1JhbTdvNG54QUdMRzg3MkFtN1pJR1ZrbHl5Mit0MXVUTzdUR085?=
 =?utf-8?B?bE5sSzZkcXloRytQRmF2TDZPMmVsUHllWHpLWHFYWEhFWUpBSGZXMGpQRWUv?=
 =?utf-8?B?aDAxZWM0cFFEY0VXTE5jUDFacXArRXE0TDU3WU1kUEEyQWxWRzFuVzRlWmRq?=
 =?utf-8?B?cGprZENDc0U2aEFNSGl1Z2p6dkZtTThXMy81UWRZY2tKVzhnbW15UTllN3V6?=
 =?utf-8?B?WXoxOU1oKys4KytQQThGNUxlRVVMZ1ZTOVhoVng4TzUyRUZoZ3RiQkwxRnRY?=
 =?utf-8?B?aFNqd0VobUtKVGFNTjVNRnBpUi9uZWROUks1cHRmRDhBK25vc0NwcHZ5S2JB?=
 =?utf-8?B?TTI0R2wzRWFnNDgzdHVEUytHWm5rcGlXdkhMUTVvTHd4YTlLWVJXNkxTTGNT?=
 =?utf-8?B?WHlPZ3YrSFd5OWJSa2J2L2FzM1NPRzArWlJwTWxaVUhHeDR3c1ZHUmdmcTg5?=
 =?utf-8?B?cGFyWlJaMHc2dTlOR3FNaWVhY3hhZXoxaUJXbUZITDArZXBQM0Q0UmtkcTk3?=
 =?utf-8?B?VXlxUWFWQmJaaTFFQUlEbmVwdmNVZUZhUW9sSXIxV0JIODR5MVp6TFdQNExP?=
 =?utf-8?B?Ky9pZnVKTjFPamdEQ2tPN21QOEtnb2VaK2lxZ241c3ByRG5qSUZwZlFJbGQr?=
 =?utf-8?B?SndpSE90ZENpNGRsbFR2a2JQbEo5djdBRHFIUkRiSE5iMkxjWThSc2VueUhX?=
 =?utf-8?B?OVBvNW93cEg5Y2x4QVZQK00vMDFmRXFRY2owQXRiYm4zWThSdVpyNHAyUkNq?=
 =?utf-8?B?b3pIWWdpUjVvbmR4SEMxQ25CMUVEakkzWWNHQ05URUxZTnkzVVdJWHU1TElH?=
 =?utf-8?B?bWY5MFlnRjlTTFV3by9nUTk4VG9kZURTZklFemxCRjAxanhQUXpSUVB5Sjhq?=
 =?utf-8?B?Z2o3SHB2NHo0M1lTZXg3TTdET2FsVHZieHEvQ283NmY4bVNOelBka3FkY0Fv?=
 =?utf-8?B?ZGpRdVE0UzBLSmtjSWNhaXRIUlh5RnNKeS9JblNHY0ZxYlA3Wk96MkJlWUxU?=
 =?utf-8?B?NXdTRmZ5dEhXMzNxVWYxMWJHOFh2T0duK3FSanN5T2FZT1ZqWVpsREJLN3JT?=
 =?utf-8?B?aE5URGlBR1pKTHBsSldPYjlvU2pSOU45Y2ZERllBUVBQdnB0R2NldEdJZ2dJ?=
 =?utf-8?B?K09CNlh5RnJpVlBJMFgzTTZSdGxpRjR5WVJXWGgwbUd4cWFhWVhQODA0MHFo?=
 =?utf-8?B?TEVMb3kyWHl5Y3VMa1pPL1NvTjBzRnBmNTFwS2I3YTBqckdBRDR2a04vTVdu?=
 =?utf-8?B?bTJYTTFLeVNPZW96ZXRSMUV5aXFxcU1IcXkwOThXdURTSUlhb0lhV3FlRmdL?=
 =?utf-8?B?ckN1QVdkQWEyeGdEUGRjbUpOeDhnUGJja1h2SEpjRE04b3gvVWdvRDJjS2hZ?=
 =?utf-8?B?b1pJTDN0dDJDeExtOVRNVGwrMmZySTRIMmtZU0Z6L3V1dFZHdFFFZ3pyU0Ra?=
 =?utf-8?B?bFNMMHB6N0VnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eFVjcGxldmVZUURQV2Q2K2RPcjRpNHA2QnNTNXRuSWpENCtnbDN0Qk5iMGJm?=
 =?utf-8?B?Q2JZand6ZkVYMkVCcEdSMWt3S0tiY1FKdDgvUW1LSW5oNlQxUDVxbFRLSXR3?=
 =?utf-8?B?U2huZHhONkZPaldiWUhHNG1ST2JrWWNTcTF6VWptNTg5RWVOcndMYlZwT2dW?=
 =?utf-8?B?ay9Xam1KMk95SSsvNDRNRENpSmpGQ2RsWVFlMGx4SGd2SXRmcmRKb05ucUE1?=
 =?utf-8?B?UHZrdzBKbmhpRnZ5K0ZUOFZPTGxGYzBRaFJESDYycUs5UUlDM3ZNRTFFUDJI?=
 =?utf-8?B?SmFoMlE5S2NLTjBKamUrMktSaVZMQUtGN25aV2ZRa2RuNlQyU1pwL3ZoZGZq?=
 =?utf-8?B?Z3ViUEwvS2xGb1RNYXU4NnBGUXdQRHJxekU1R3h4THQwU2FhNnJXZUszcXB4?=
 =?utf-8?B?ZVdGMS8wcTY0aStQRzJZeC9hV0IySlZqTFdLSTRXaGdQZGJvMmZITEJCbnZL?=
 =?utf-8?B?b0h4bklUcDV6cVpSSjFFZ0pmMFFNQTUzZng2VXIvMll5OS9EdjViU0NqS2pt?=
 =?utf-8?B?WXEvYW5NenJybWwwWEVPblFYTTZsYVhMM0tnclRPRVhnelh6Q21BWEd0Ui9N?=
 =?utf-8?B?U1F1ak04Mk9LUUNNSnZwVEZCY2FocXIyU01zODdneW9LQi84OG5LTkFMUGNW?=
 =?utf-8?B?SEYrTldDcUd0ZDZsOG9rOHE2ZGpmajdwYUhIUGRrMUNqbDFpTlltOHV4N3cr?=
 =?utf-8?B?RXh0bmJzc3BqNm9ud0EzOGFyWWlkUlFQeXpiQ2tHZm0rR2ZCZ2kwUWhoam5v?=
 =?utf-8?B?UTNoSXJ5elpHNVhtSFM5cDBYTUliSTd2UHNmVHYyQnk3eG40cmVuTElUalJj?=
 =?utf-8?B?TUgvRkxtTm5GT3BUajRUWEZzV0p4eXgzQ0RPd1J4cTg1eFdmSjRnWnJFWjlK?=
 =?utf-8?B?LzFmTzY3YWhsdjlsVkJzaXZLUFFRclJzc0pya3AwcFM1bExPOFRGQ0o1bGlj?=
 =?utf-8?B?NlpiaUJ3Wk1mTVhTYkhUWENJc3RvVDR3dkpQV3luMm05OUc0cDN6TlpoODRN?=
 =?utf-8?B?UExuOG0yOWVxWk94MUMxbTZBaXlmbDFsYWlnQlpJVUdQR1BxWW1JdUxtOVNq?=
 =?utf-8?B?RjA5WWViTHBVTU9LNGZLSU5jWEJmamlQNmVYRDlKSVB2L3lpUFdIcFVsZHNB?=
 =?utf-8?B?OUZ3bUt6TWhhQUxkUlRsdGZuakZRQmJtbVhqeHEramh2NFl3bTRaRlNlVE1C?=
 =?utf-8?B?MGtwVDIrMkgwaXZpR0VOQU5BQTZienltTGhWcWp3akt5WmpkaEd3VFRETy9s?=
 =?utf-8?B?dlJnenJlZHZsQXJqY3FibVZvRTQzS0dDZ3NqRHFFTTRRZFBpQThXelg0WkU1?=
 =?utf-8?B?ak4wbU5oV0VRZndrbExlZWRJTmZnWTJrWWJsVm9TVGJDSVNUVzhwSzVnZkpm?=
 =?utf-8?B?YU8yL2FtMFQ2SDRweklYNVFpSFVQb3NIa3lBM3lMYzJOQkFjQjg5cHlld1FB?=
 =?utf-8?B?bkJjL3RtaUJnRW5IRktYTzh2QnpPcmJIbFk1MHBKTFFNck85NlpYN0xod3U0?=
 =?utf-8?B?LzlvVnFRUnVzZ2x6RnRIOGZ3U1BzYkRMRDF5cit1ZExLcHNhV2NWOHhQTkpm?=
 =?utf-8?B?dzlkS3hmbTRyS1d6SndUMGhKNFdpVUovMU9KdGw2bFFselVsbTA2MzcvMGtN?=
 =?utf-8?B?OG8yVXYyRjc0THd1bWNuZENxaEUxSWZoMnlEcW03ditlZVlNNWQ0Tkp4REF2?=
 =?utf-8?B?K0Z2WnlCTGZqdCtCUUdRNXRqQUNBYmc5bmdVT0JHNlRsYkNmMkgrWFZxWWNh?=
 =?utf-8?B?aHVuSEtQVkQwOGlWRVNrOTA1eEdiVkw5SHVOOVNtR1dWWXNSWm9UbWZqYzI0?=
 =?utf-8?B?QUhnTXdSM3dwQ1NidW5WeSt4T05FUUtaV2RCanByUHBsRlRZdVJrWWJsWXpC?=
 =?utf-8?B?dDI5a1dsNHFYQnhzUEt6Vk5SUEo4MmxlM0RPa1NWSW4xaFhsVFJFRHU3aVJw?=
 =?utf-8?B?UWFBdllOQkZlalZhNmRWMlo0eXc2UlZVTzFTcVEveEVCaWc4b0dVNU1NZ3Rj?=
 =?utf-8?B?cDRwUGNqbnkzRjRjMERWK0Vvc3gvTUplUXNhSUxRNGI4eDVabjBQcGpmVUYy?=
 =?utf-8?B?NDZHTFFrMzJ5SDVmZkJ0K09MRWtZNlhzam0rK3VGTGhTR24wcFlabmlMU052?=
 =?utf-8?B?TTg3eXZnb0trL01RMFU2aEh2YmFPbUVSL1BHdDhQeXVoelZEbkhyUGdPenhm?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4c4c63-bfaa-4483-e9fe-08de3bdeea99
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 13:36:13.9160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BJte9aovlDym+vDXmL2qXKlP2C1FKtN8+oVNJ8QccJehO3zwuvnGoXsD44rjtsZH+5JcQoMh1jLkFYodpGOcAEC8vHvZ+P0WWWfEFS8a5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6172
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 13:36:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21062



On 12/15/25 14:03, Jan Kiszka wrote:
> On 15.12.25 10:35, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> If the option `separate-home-part` is used the home partition is deleted
>> during a factory-reset. To ensure that the root home directory is
>> available recreate it with tmpfiles.
> 
> "via systemd tmpfiles" would be clearer - I first read it as it would be
> recreated from some tmpfiles, but only the folder is created.
>
I will fix it in a v2.
> What happens to the root home in case of single partition?
In case a single partition we move root home to /var/home/ which 
recreated by 
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl?ref_type=heads

Quirn>
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .../change-root-homedir_0.1.bb                | 15 -----------
>>   .../change-root-homedir_0.2.bb                | 25 +++++++++++++++++++
>>   .../files/change-root-homedir.tmpfiles        |  0
>>   3 files changed, 25 insertions(+), 15 deletions(-)
>>   delete mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.1.bb
>>   create mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.2.bb
>>   create mode 100644 recipes-core/change-root-homedir/files/change-root-homedir.tmpfiles
>>
>> diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.1.bb b/recipes-core/change-root-homedir/change-root-homedir_0.1.bb
>> deleted file mode 100644
>> index 79c7e67..0000000
>> --- a/recipes-core/change-root-homedir/change-root-homedir_0.1.bb
>> +++ /dev/null
>> @@ -1,15 +0,0 @@
>> -#
>> -# CIP Core, generic profile
>> -#
>> -# Copyright (c) Siemens AG, 2021-2023
>> -#
>> -# Authors:
>> -#  Henning Schild <henning.schild@siemens.com>
>> -#
>> -# SPDX-License-Identifier: MIT
>> -
>> -inherit dpkg-raw
>> -
>> -DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
>> -
>> -SRC_URI = "file://postinst"
>> diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.2.bb b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
>> new file mode 100644
>> index 0000000..0e356cb
>> --- /dev/null
>> +++ b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
>> @@ -0,0 +1,25 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2021-2023
> 
> Can be updated at this chance.
> 
>> +#
>> +# Authors:
>> +#  Henning Schild <henning.schild@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +inherit dpkg-raw
>> +
>> +DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
>> +
>> +SRC_URI = "file://postinst \
>> +           file://${BPN}.tmpfiles"
>> +
>> +do_prepare_build:append:separate-home-part() {
>> +    if ! grep -q /home/root ${WORKDIR}/${BPN}.tmpfiles; then
>> +        echo "d /home/root 0700 root root -" >> ${WORKDIR}/${BPN}.tmpfiles
>> +    fi
>> +}
> 
> Newline here.
> 
>> +do_prepare_build:append() {
>> +    cp ${WORKDIR}/${BPN}.tmpfiles ${S}/debian/
>> +}
>> diff --git a/recipes-core/change-root-homedir/files/change-root-homedir.tmpfiles b/recipes-core/change-root-homedir/files/change-root-homedir.tmpfiles
>> new file mode 100644
>> index 0000000..e69de29
> 
> What's the purpose of this empty file? Why not only create it when it is
> non-empty?
> 
> Jan
> 


