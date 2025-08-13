Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB251C87FCF
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 10:54:40 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.23])
 by mx.groups.io with SMTP id smtpd.web11.97940.1755082472514339199
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Aug 2025 03:54:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=krJ45YiV;
 spf=pass (domain: siemens.com, ip: 52.101.72.23, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m59QZirM2UuIPw2lv1LTSHaEZ+MI5hc8Gl+PMW8BEUF22qAfp//VoQdOFTmfM9QQukEPX+wyGEYG5qVJskhgJL+rDX9BfNd/Kvnz07z6fQQMvlSqaWbDNYj8mVz+wICrTays2lRtlexGmRcQF5DYSYC2CtKI/zIeetVQOdedQ7YlWZ8ouED38Z8CdtTp0Oj+7UevpU801HRtN3BmaczGkyzwBlg0hhFdRU1dNM+ufHIMwSLQQtmrpyK2eksK13U0C1FxFb9nZkDJe7w8u1ovcnXOVWk7EMMN/uUO+ZizZDCIBNGoP8bKt5m8jiAW84XjTirAYPHznhI+pP5k+xEPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiSWxKJXK0MaWGsMs5xwv+E4vau8eQFPkCsoLBdzLnk=;
 b=caR3eIUcOeib0Xuz32pp+EP2addcBjtut4j+6y4PilLS4Zsg3cNFbLph/CXFqL1qccEggKmE7cEJbeVaNHRbG6QGy/LORTAhlKJqhhin8qdK24aCm3d+kfv8jys/ZXut1wR4E0BFhR4VPjgJh7nYZkSZZOLuUgquSAQv0Jbqsg8HleohNix3gCsfI3ANkkFyOi3bWXFhNwpqWrLbF8vRfd1yibAde+9NS2TaB/uAJpSKsVpNjfroOJKDux8uIkmWTpCaWRyXYJMcPqev+H/SPDZaG7UXC4tQgkl0Y3qbHVO0BL6M/SVtTJtmb5pofJTcVTX6rjg82sCJc5hh/9xJFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiSWxKJXK0MaWGsMs5xwv+E4vau8eQFPkCsoLBdzLnk=;
 b=krJ45YiVU2CFtY/eYuJMSSqMbjH8sa662OHIlcPuC1K/zh1HqUTHzjdBw9Rz8+Jhdl2ci+cArmE2rhxX1AaC5HcC4LavkfNUWQRqUDDA2zd9eoL232mJWjTpxYr2c5JBvdOJ9qUGVuCu+2+1uaLpQBHjZDi4NbmbFXW/It/7FEaifes3haHabDRa2C3or6IC9/Pff30bn9FZRu9KJUujlNsJT+1/NF1vAd1b4lzJ9tBs85zlZF7WimgsD9nbbZY30MfTh43UKqUe0zxK/a3gqJu8AOovKqCerWZKdQTt4q2jxdRD/+KVsbfRxlnRkPXiXKCJJO3ySI0mVvSy3BvJkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7239.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:449::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.25; Wed, 13 Aug
 2025 10:54:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 10:54:28 +0000
Message-ID: <dbe83bc9-5490-4160-b2bd-1883d63436d5@siemens.com>
Date: Wed, 13 Aug 2025 12:54:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] doc/README: Add section for self signed certificates
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250813101406.1372766-1-Quirin.Gylstorff@siemens.com>
 <20250813101406.1372766-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250813101406.1372766-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da2383f-f251-4740-10c0-08ddda57c6b7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VldWdjhVTTR2MUF1RUFBQm16N2pTeUhCc1dKS3pWWkU2OHJJNUJ1SUNYM3Fr?=
 =?utf-8?B?eFg5ZW5TMkM5SWl0ZzNBeE84elo0bHpIRjdOTjVORk1ZMGo0M2loVVhmVEFm?=
 =?utf-8?B?MGZMT0hicXgzQmJnRzBNbDdnVDBxaUR0OUx4bmRQQnZ0ekhLb1BWQ0tadmsv?=
 =?utf-8?B?aEhrbG1yWmlJay9VOFkvcENQRnpaQktGUyt6anZwQmsrNmdTTFp0RWZYeTZh?=
 =?utf-8?B?TklyUE1pRVlYZlE5TzJ0KzJIQU4rNVdlSWcvQ1JBTGZVRlBoTXRHQ00zRGFa?=
 =?utf-8?B?TWVpbXNKV0d4K1JCRG1NYTQwdmxiaHNOeS9QM1lMZXpkU0YwdVQ0a0Rsb0lE?=
 =?utf-8?B?S011c05zajI0QklSWU8xczBVeG94WFN2M2xPT3h4WENzbU00OTdOa1BMblFF?=
 =?utf-8?B?dVVIdGZ0ZldnU1dKdGFOV1hjVGdvS0JYRE1DeDI2R1lPYS91cGdzVHlwODlO?=
 =?utf-8?B?S1hXTmxyU2VBUGxSMlVmaXl5anZZeHpzVXBYTnNzcUFqT2VKejZYNE9mN3BC?=
 =?utf-8?B?Z0JRY044SU1SUGRmd0x0clVyNnF3eHpDeURYVXVMQmwwU3pQT1RJbFVQMVIy?=
 =?utf-8?B?bTU3cDZlb1ZJWlJrL2g3aEdtS0dWbmg2L1IyWTIyNWhDdkNiaW1yeE54aENO?=
 =?utf-8?B?U05RMHRESHJsQ2N4a212U1JwSjllQ1l5eFN4MzBLL2VyQnJOc1BCVzF6NVRj?=
 =?utf-8?B?UVAvTDZISG9qU2hHcW5rWmZ3UTVnZkk0Wjl2MzNQTnZEYnFoM0RTYWNocmJs?=
 =?utf-8?B?aUdpSUQwTkEra0E3Kzd1U2VsdnUrQ29VT3htUmwyV0lvaDBtUWRDM1BjVmU0?=
 =?utf-8?B?emo4clN0Y1g4dWNhcGxZWFIxT2ZFZ3psMExTNjNkZWo3SElJYnQ0MGx4bEsr?=
 =?utf-8?B?bTNPVUlBdUhJSE0zd05aYmo0aVhRTGptNTJXelhxWWdWWTBpaFd5TDVWaWVm?=
 =?utf-8?B?Vk1IeWIrRS9aU0w4NlJWb0x5cTFQeVBRZjlVUVRsNS9JaVgrZDBsTDNKMmQv?=
 =?utf-8?B?bmNRUzNoM0xrMjlxOWNYUE1oOVNKZnppQXk5YzZvYXljbFFjTjNlKzh1NmJp?=
 =?utf-8?B?V0h1dEFxbmRIdzV4bXZtbi9lbHhqK2xNNVdSWkVNY0h1a2RNejA5Yko5cjhB?=
 =?utf-8?B?UmtZblNZQXN5N0p5Vk10OStWbzlkVlczUE90MUVpbi8zK2gzamRXeGRHVHJ4?=
 =?utf-8?B?UUh4MlVVWlNIbnRkRUxFRVpJWFo1dWtYbUlDREdMUGNJdFJMTkMwdHpsMlds?=
 =?utf-8?B?TGRSWmE1cVRsQzlzY1BCRk9ybXJFTlFWSWJLSEhwd2l4M3psbGljUHVDU1Bj?=
 =?utf-8?B?dEZ6OTl5ZjhBUGVIaHJRRG5EUnpQZzlHNU13Y1l3WVBZV1NWY3Yyci9qZ2tU?=
 =?utf-8?B?ek9xTmVmcXpxZDBCK3VVU0RNOSt3TUZEU2ZOd01qWWdjUFhwNjdxY3hRc0Rp?=
 =?utf-8?B?QTVTYTF3bTZNU3R1SlZ6czB0OVBoVno4TmZ5N0Z0cWE1Qlo1OFhMQ0lreDBZ?=
 =?utf-8?B?OFc1RUVnUE16WjJveWFBdmw3bmVtSEM0cmZFdHlPRzVxa0NTZXdHSCsyelUy?=
 =?utf-8?B?OTVwYlVMWTVpL2N0SWh3SUVqTDA1cFBKTWJ5RGxjMUx6UlFDWXdoa25ZQVcx?=
 =?utf-8?B?dDJxa2ovdGNZZ0cyN29wY3o2bFdYcWVvem5vVVUyb056dURBakRqVmdDTE54?=
 =?utf-8?B?U282cnZDSGR5YnBrbjU5eW1UUVViS2tuWGt6T1BuR2ZPbnByTHlHL0dhS1RD?=
 =?utf-8?B?YUpDK2hnNWNEalBmVUdXMEJIZTZ4SU9MS2tPajhOcnZtZUl0aDdzMzh2ejBh?=
 =?utf-8?B?WVVDeitNSEVxeGt2LzJhVGs2SHdhNXJ0aWlvcWFCQlY3MTZSQ21abElEM0Vz?=
 =?utf-8?B?UlFuMlNSbW1sUUVYTlpqc25XNnd6c1JJY0x6eE5sZEFVcnpOV2Y2YlBVRUdW?=
 =?utf-8?Q?0vXHa3n047w=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V25UUVI0ZTZZR3Q4U2tsbDZzZWZOTHdmbkVpS1NvNFVyeFNtbVlDQ0wybFB0?=
 =?utf-8?B?bElvZjJRVlRGSGI1c1VnL0FIOCtXUVZoeEpuckcrc1NNRWFVYk9ZcmJMY3Yz?=
 =?utf-8?B?WjZkeElnV1A1QzF4Rk9xT2E0cFRISmxITldtWGhlYXdMZ25kclphQmk0OVd6?=
 =?utf-8?B?RVIyWW5EeUROb0lCQVBMVXc2WjZUT01YbTdIaDhkVXJsY3pRbUlVWXF0Znds?=
 =?utf-8?B?cHF2WlhIU2Ywak5seW5DazFnU0UrVGpSOUI2SEdmREZ4NFkwYlQ2bE01UnZr?=
 =?utf-8?B?ajFoUjlSQnR1bU1yOHJQNjd5aE9hMzBvYlpaZzVWSE9pSCtUOVA5ZkhDQ2Fm?=
 =?utf-8?B?SGdnTGZWYldQRDRreFZqOUhRL0swNFNUK3dNZmQ3eXFWMFF6aWpEM3hzVy9h?=
 =?utf-8?B?SkJWWkhld3VXbC9VcUxXczZERW1ha0xza0hiWXJyTUUxeEJRbitXYVo3WDgy?=
 =?utf-8?B?SkNrSGRLRlhZai9vSEZQKzRSc1lidmxWME9rRjU3Uys1cXBKcVB3ZCt0My9z?=
 =?utf-8?B?TDdhcmN6d0lPTHV5c3VwVUJhY296eU1LMnhGcHBxU0MxbWpMRGZUZUFqZmVN?=
 =?utf-8?B?czlkanEwOW02N1VZVmdrQVcyMlhqaWZVQ0xIZWtFQmxEY29oTEJHdFd2ZzBx?=
 =?utf-8?B?aVpxanBEeUNGQU9FdWhhQmhxcWdwSGM3K2pUS1NiZ0VTNXZjNk1rYVV6aDJ2?=
 =?utf-8?B?RlZTdzJNaHd1d3VML0IxRm0wY243d2prMXZpeldKaWxIRE13d2t4Wk9Vcjdn?=
 =?utf-8?B?czFDTis5ZGtYVXcrZXBVbGtiN3hHYnJWOXpVVENaNi8wUnhQek5OR01lT0U1?=
 =?utf-8?B?enV5Vi8wYXptRHNqRGozNVlKQkJUWmhyWGxGU3FpWGRtWGduK0ZSY0FzemdC?=
 =?utf-8?B?ZXlHS2VjcnhEbTBpcjV1dHh2bU9za0pmRzlveHpLaVMrQ0srTjJsaDhsYTkx?=
 =?utf-8?B?M1RMOGNEK0pRV2tSRHk3WE9yb0VVQ3ExSzhCSy9ibHdHVE80c0pVTzk3VG4y?=
 =?utf-8?B?VTJPMjVYNXV4c2VjMHBPR1RocGpvR3RUQ0Rqa3N4Q2phZVZ5KzBwWUpITVFV?=
 =?utf-8?B?WDBGbGR0QXZNMm9vSHZwcjIzSFg4ZUNaUDJTZkF6RGdsYXhaRlRrSUdreHVz?=
 =?utf-8?B?eStuNEpnWTF1SGs3VmJyZFRpSUF5UEJ0SE44MElvVzQ0MC9jbDI2VVZUR2Ft?=
 =?utf-8?B?bUI0ZmRaUktXT3NzSHI5U25PZkNBME1oNHZvWTlZa0JLL2VTcDJ3eS8xV0V5?=
 =?utf-8?B?blFQTUlBQVY1YU9ieEVvd3pQZFpZYSt2aDRhMElUUUZjWTdNRHpIbHVERC9G?=
 =?utf-8?B?VDNEbm9lVWNjZDM1ajlEdkx3SzNUL3JIYnBWSWdkd1hSN0xkUW1SU2dvNGtX?=
 =?utf-8?B?YnNiVlVPTWxRM1hkOE9adnZhL2Rkd2hFR1AwNDBxdWtTRWwzdEVBcWdSeFB4?=
 =?utf-8?B?NVlZNzFyUEJ6azlaQU5iMGw5TDRnY09QNjhacGI2QkFBV1d3N3QzTFl6UWtJ?=
 =?utf-8?B?ZFROdW10T3ZMU0syU3lReE9TRlVCMXBZZk9aYkszclBwRGFiVC93NjByZkU5?=
 =?utf-8?B?aHVsVW1zQ3J4d3VaY29LbWVoRDlBdGY5WE5FM05VREgxVHVualI0WlhsemJ3?=
 =?utf-8?B?RzZ0ajYwRHdLa3pmazE0RWYvOEN0elpydWZESlRaZUhjcjdlNmY4eHZZZjcy?=
 =?utf-8?B?c2hsWWtNSisrdlJDYWlUVSsyZFE1ZW9OVzcrOFVxVWZFSnR3clA1N0FIMWVB?=
 =?utf-8?B?anQ3SUJPSkJ1eFpQQ0FDcFNJaFFwODZuRkFwUmF3LzQ3TUdycksyK1BqVndt?=
 =?utf-8?B?cm5acHNpOUwwMzBxTnRSeFh2QlV2SExmK3dlNHZ2UnhoVW1KVytSSy85Zjd3?=
 =?utf-8?B?bzdBdHk2WmFhSEY5cU9UdnJjcjlYS3BEYVVZdjBrRVlEZXZOY1dEU3pCemEx?=
 =?utf-8?B?YU1IR0F4d2h4aFJLWnlqMTduYlprbjV6UWxaOVNnOTZ5aDZFVlVJZVlTSFJj?=
 =?utf-8?B?Wm1MUDQ4eldvSFVMM3F5a0w4MFNScVpLK1NQQ3V4UWErVXFEVkVUWGJjQ0xt?=
 =?utf-8?B?MmxCMlZxT0orWGlJWTJ2WC9pRkg4aCswNkJ3Wmx2aGJ6OGIyeUt2d2VTU2NL?=
 =?utf-8?B?NUFEQTloTWxzUEFoL3JQaHRYVU55RnIzNTJxTWpQeFRlT3h0ZGwzeTdzNkU0?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da2383f-f251-4740-10c0-08ddda57c6b7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 10:54:28.9015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bzAOd7s/h1ZGBWF4nFNc+/4s6PMiUnZMuPEjq1/PtBriFRhdD9Ljd9Z8vlYNz2JSB3Hx72SwVcCtGBYfjS4Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7239
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Aug 2025 10:54:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19727

On 13.08.25 12:13, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  doc/README.signing.md | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/doc/README.signing.md b/doc/README.signing.md
> index 327d981..1d0de11 100644
> --- a/doc/README.signing.md
> +++ b/doc/README.signing.md
> @@ -27,6 +27,40 @@ The default implementation of isar-cip-core is `recipes-devtools/swupdate-signer
>  To validate a signed *.swu the image needs to contain the public part of the certificate which
>  is stored in the recipe `recipes-devtools/swupdate-certificates/swupdate-certificates_0.2.bb`
>  
> +### Use self signed certificates
> +
> +#### Generate a certificate
> +It is possible to add own self signed certificates to the swu-signing process. The certificates
> +can be generated with [openssl]():
> +
> +``` bash
> +openssl req -x509 -newkey rsa:4096 -noenc -keyout mycert.key.pem \
> +    -out mycert.cert.pem  \
> +    -addext extendedKeyUsage=1.3.6.1.5.5.7.3.4 -addext keyUsage=digitalSignature
> +```
> +For use in isar-cip-core you can copy the key and cert into `./recipes-devtools/swupdate-certificates/files/`
> +and used them with the recipes [swupdate-certificates-key](./recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.2.bb)

"use"

> +and [recipes-swupdate-certificates]((./recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.2.bb).

What is the use case for dropping your own, self-signed cert in cip-core
directly? Testing of the usage steps below?

> +Downstream layer should use separate recipes for key and certificate.

Shouldn't we rather focus on describing it along these lines?

> +
> +#### Use the certificates
> +
> +To use the self signed certificate with the provided recipes the following bitbake variables must be set:
> + - SWU_SIGNED must be 1
> + - SWU_SIGN_CERT must by set to the file name of the public certificate
> + - SWU_SIGN_KEY must by set to the file name of the private key
> + - PREFERRED_PROVIDER_swupdate-certificates-key to "swupdate-certificates-key"
> + - PREFERRED_PROVIDER_swupdate-certificates to "swupdate-certificates-snakeoil"
> +
> +In case of the above generate key the variables are:
> +```
> +SWU_SIGNED = "1"
> +SWU_SIGN_CERT = "mycert.cert.pem"
> +SWU_SIGN_KEY = "mycert.key.pem"
> +PREFERRED_PROVIDER_swupdate-certificates-key = "swupdate-certificates-key"
> +PREFERRED_PROVIDER_swupdate-certificates = "swupdate-certificates"
> +```
> +
>  ## Signing an EFI binary
>  
>  EFI binaries are signed with the script `/usr/bin/sign_secure_image.sh`.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

