Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.30])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22637.1794813517364441600
 for <cip-dev@lists.cip-project.org>;
 Sun, 15 Nov 2026 23:18:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uUoOy3Kx;
 spf=pass (domain: siemens.com, ip: 52.101.72.30, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfIl5NHK2aCzPoIx6NLCP/Bus94iPer0USXldMbaS3OZyndQ4Yn/AW3YYIfbQhR+XwG4SN3KJ3JQO1Jzmd4QrP8T6ggQsj7hmhXHoQIgaz24mniZs+zXuIfqbe/CZu/BH5I+Bi2962sWPLOn30tTSEtKt4WYu9ZP34VQz/aiHJF0zGEHwcIOzpYgWVfeZvNxoZfeMk73eLO5IPCXujmydd7NZxtl/0e+1DNbioBrrVsg3w4qZJqrchYI0/IUgZWj+ZwViX1c3Hfhx8piyQgTCtfJzUh0m1bG9WZTvUHAKD4q+bPtnEy6/3ll9qqo3cyOI53RKdMyhrf1kGP14njKCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJ/pwFiGEJJzE8gVNonJwnbJxe4lykQGqjo/wFrd0Dk=;
 b=T7LekZrLDG/39JXfeicQ/l6rWh5K6Z1UugKK1lg2mSzGnUR2CM6wrXBUkNC4kfR3SCtjSrKRpTclyp/IpJdvWRDkP4kYuOMUojL5e2xV28PYqcfj1T4JDPAIsRvUuV0iyPwYsRfzOs+9cZZD4zoPRKjTSxjXlPU9KPXS4xzBbEzs95nLRDiBBQJwTzY15t+e0Wj16JMn3hGEk2MxQw+WmMzE/czXqFLph03/SXBP/kQMBLOSL6gcLNKU2oqPVL+/u/yF21s9tlnB9qAdSmKwIMokCu07/MOfSyHuAH8CbINmo6fBQVmVf+5uIQbEeWb4UdGcPN+oL+7T2k6mmmKTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJ/pwFiGEJJzE8gVNonJwnbJxe4lykQGqjo/wFrd0Dk=;
 b=uUoOy3KxP0SgGJVVpXt2ATVgOsUdpfvg0pd79LC/MztS8toQJ8aWfv7b9kE35D9PImUexNfKhuQU97y0+1OHQN7zP7UerJXr4mSSe0oKYnn2jH+katSVeg5KHUjj+X24SAjaOMPipPa9yLq8nutGjdSLfcRbgfuPnSsrv4L3i9dsBx3EvsYWR4GiTdLXDlj84IY4Idkjnm7SyqhLUMzeuDQ6eaUNAOz7JgergxmMLkxr0zCb9VwePNbU0bSDjJwiHJ3N7SXfeNuUcRSHy3bWn0Bxkg1yT0IVf5MOj4b0gA1+SjsMCIjxYFoGEI5DlwRWWWFwfJYGz179/FAi4DUV8w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by VE1PR10MB281807.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:1f6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.6; Mon, 16 Nov
 2026 07:18:30 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0639.006; Mon, 16 Nov 2026
 07:18:30 +0000
Message-ID: <689782aa-7d61-4d86-b91e-6c08075f5540@siemens.com>
Date: Mon, 16 Nov 2026 08:18:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Release v4.19.325-cip137
To: Ulrich Hecht <uli@fpond.eu>, "pavel@nabladev.com" <pavel@nabladev.com>
References: <2007396892.899088.1794587636972@webmail.strato.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Cc: "nobuhiro.iwamatsu.x90@mail.toshiba"
 <nobuhiro.iwamatsu.x90@mail.toshiba>,
 "masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "chris.paterson2@renesas.com" <chris.paterson2@renesas.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <2007396892.899088.1794587636972@webmail.strato.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::17) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|VE1PR10MB281807:EE_
X-MS-Office365-Filtering-Correlation-Id: 346ea12b-9b9c-4776-0581-08df43b1d0f4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|11063799006|56012099006|261021121427099003|261102123227099003|261022075727099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: /j1TClV2j770giUScohi9VTHF+mJSajDybMJbRxhzu/Gtm8KBFTT1fIFNXX++MGzfqyDmBt+oLuOExlXzIHKtLlCc4jkV7TBSFyw1Z0l5QFPeueLnU+hTlpv5MZCazRX6kIwHrntCZ6kLUuNMR7YrQu1XgUZnXAMmc+YGwnqOOCvz9r7LBiU1ZSrfQJWkBfS+BXGQGU9Sob8i2tqjybkVxdhz8Ch85JDvN7muf9b/asyyCBMiwV7R2BnqW7f1o+P6S3oBW/H/QfDx3z+s8t0BsfTcYjCcb4lB+EkJ5PQZzgvYtJHmiaONLQUlsIY4YIYlRM/4xg7ymNFRjt9Ipsp7WTS8Lz7sXFHSQm3v04LtkQtSuLS8VvnN6UEeorCbK0/A1/cTyW9Lnu8ORjNy8ETLCAa1xvBYnfuXG+4boO61B1lK+xj5Hi4bXYiT9BIBZrTmgqGDxk0u+TAv/NsMmmcGsv/MX5thbhGqiaySpn3cjAyxad8FQ+YSCDEG9yyNHO2++IoSVcPdkcY3umVJKcKVK5lF6PG4yw1bxJnUBA5q1auioeRrUQUz9g4J7TC0NY39bFAvdPTDg9xexB7yHdhAkHv6S41Q0c7ZNXt9N60QD1MrbLBfym7JKtvUm5QDQRG1OrJkin6AxZwlaqgr4S5P6i6WmNRdTFaD/q8MZjdom4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(261022075727099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGNmOThKSEJFT1Q5WUtDQ0dXOGU4VzFvUHpwNEJZLzVLQmVDRDIvTGRvcE5T?=
 =?utf-8?B?b2tuOHN0U3N5cVZHZ0N5V3hRd0NZZ0NPOEQ0WHZURWprdEVEMm1ndlZEOG9W?=
 =?utf-8?B?enQxMC9FbTkydG0zYngyK0tGNDdDc3JCUVF3UHFmZ09Fc0tLRkZQK09meWZE?=
 =?utf-8?B?amhHd2pENTVQbHBvbEZQM1RxeVFGV0U1c0I0ZW0wcVJNaytRV2pRcnJPWmhn?=
 =?utf-8?B?ek8xYXhMV1AzRDRDT2IxRFk1VkswMkxKa3Z0SmNpRnJ2L0pwWTBUU09OR1Nn?=
 =?utf-8?B?eW9nRFo3TGFWTmVxbFE3REZuZmhoaVNXTDUvU1VYZEJMV1Zoay9nYXN2bVJ2?=
 =?utf-8?B?TkZPYzZqMFJPOGFpbTdDc0orMzErQmgxdlExYlhoUXB1UWRiZ04vNVhpV3NJ?=
 =?utf-8?B?NGkrVFN1UGlacURBMzlESHhsaExBOWZTNWNjUkhaNmFLYldSZjUvb0tRclVn?=
 =?utf-8?B?ZnpFcW5aZ3F3RFo4MGxyQzZ2UThhZUthaHZxd3ZFYUxHR0VIeFVpQzV4bitG?=
 =?utf-8?B?TWQ4MUw5TFRoSWRQRUFTWmlrR24vVnBsanc1REdaUGJLNFdvcWRZTjJvbFli?=
 =?utf-8?B?OEp4eFNwK3Z6KzluY2hjRWhubk9RSVJ1VjRxZjVtVDdhK1grTEF1blhkTkxv?=
 =?utf-8?B?ZHJsN0htd0tQN3RkSWVwdm1TWENUZzY5Q0xEaHp3SWNYSWFtb01YVjJSbWZ3?=
 =?utf-8?B?cXcxQ2s1Rzl3V2FQcjdjVFlkUEd4clJyN2JscFRjUVhkMHZXd2poTXQzd25m?=
 =?utf-8?B?bU04dS9GaE90VFR0VFVxUG10WDd1VHZmb1hHT3FQZkMybWZSSmcwalZVNnlK?=
 =?utf-8?B?T2t5WHUzV24veFR6OWowTE0rL3poZ2F0ek5ST3FHdmZvbVVtU1dyMnBOR25J?=
 =?utf-8?B?OFpGbDRQaW9HbDd0SG51YmVGdGxvaXZHV1BvVnNRdHVRL0RPWjVnRW9NQnIx?=
 =?utf-8?B?TFcra2NLQzQrRm1mWGFyaGZxSnRIYklzOG0vcXppZHRNeTB1V0tZK1ZmYU4x?=
 =?utf-8?B?RTNPZ0VDWDFOWG9xOC84SmVaZlBrSEU3QTJpSmRIZjQxbTIyb0ZBQ3NValdF?=
 =?utf-8?B?RnRYNHJKUXVtU2dlVHJ4N3lVY2o4T2NmOFdoa0dra0haempPTDk3UnV2R2pR?=
 =?utf-8?B?THlKNmFtWEg2ajAraFI0T0lUTWRYcnF3b0dlcnRVRzR5OFFtN3RJWEVLaVUy?=
 =?utf-8?B?bGFnY3UvMTNnZ0kyOWV6STdWOWY4b1BQUkFtM3lFZWFOMEZKSmVvT2V4Z3BN?=
 =?utf-8?B?S213Z1pFQitSQlVqaWR0R3ZoTDVHNUdidG1Fa3RvQ2J1eXNFYmhDSnp0eU9Y?=
 =?utf-8?B?ZUxJd250T29lOTVqc2JmRnNXNDB5Unp3UVgzSXlHK3N3NS9aRzBnc0VoWnhw?=
 =?utf-8?B?ZVc4WEhYeVpoaU1xMmh1M2Y3Skl5OVdna1lWNi9GMXVXNEQ4TldCSkZOd2Zt?=
 =?utf-8?B?NlFzUkNSRnpjSXZSQ3ppWlFTck9rZnB0US93eVMyaDBjY3d5Y3ZOVm9hTjQ4?=
 =?utf-8?B?REE2MWVpUk9iS0pKdG05clM2UldJcE01UGpRNmtaUWlleHMxZVdJelcwcVFq?=
 =?utf-8?B?ZmhrZmVWV0V6S2pCNlRWeWxpT3Rjc0JJeE5mekpWSDdZT3NseFJwU2F4N0hQ?=
 =?utf-8?B?MXg1NkFLbGd3MFh5d3RqLy93c2lDN0p3QjI3cnFmQzJscmgvT1dsaXlNbG1s?=
 =?utf-8?B?WlRjTlFYUzhmSjduNHRQMi9zRnk1ckF4Z3FGdC9EYitIOE9obU55NDFTdFJp?=
 =?utf-8?B?dW5VbytkeWV1SUNVVDNUWC8vd3JPSjQyVlJzNUpMVkp2K2kxRmtWUFZ2SEI4?=
 =?utf-8?B?MzRGYVZhc2p3UGRiNS8zZTBPdWgvWnhVMTdsQUtnaFh1aHpQekxIYzdPanlP?=
 =?utf-8?B?eGlVYkxpTU9PVGZpQXhSdXZXTUlucDZqMW9DcGtic0pWTmxKa0ViY3YweGxo?=
 =?utf-8?B?ZDdsZXpEWFo2aWRJem00V29kc0VYLzVPdS8rdDgrV1NlL2NNQzVEUHhoNUI4?=
 =?utf-8?B?TWNqWDZlbXFRSFViZXQ3d2xGaWhJN0tYSGZqcFpVT0FPT0dTWkJhQW1mNis3?=
 =?utf-8?B?d0ZoNUFhdmN0aTF1MHhVSVQvVXppTzRLMDB2a1VHdG5xbGtFbXFMUG5TMjVV?=
 =?utf-8?B?RHF4NUZPaENBUjNtbVFKaXZZaWVlbHJlbHFRMUhwcEZwTXFYaUdmNUxvdHhm?=
 =?utf-8?B?eUMzMU1TSlM2eENlcE5zQ0tVdWcwZ3RRQ2h5dHQ3bi95WnJjS1dMT3dRcUVR?=
 =?utf-8?B?NFV4WnRxWHlubThUYVZLSHdhVlVsOUpNc3hMZ2pBNERxTGZDcGlyN0xZT3RS?=
 =?utf-8?B?dHhlZ09oalZXUXJ1Z3hhUWd4dFNHMHZaclUzUnVnVGkycTJ3OEY3Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346ea12b-9b9c-4776-0581-08df43b1d0f4
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 07:18:30.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sH6QRtGZE0RLz1qb9nLG2ms2Ffq4gJ44z7Yco0BnQPSFltqp85C6TFWgw6wGINh1sBt8mAceMqzBtucWkYYD3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB281807
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 16 Nov 2026 07:18:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24807

On 13.11.26 17:33, Ulrich Hecht wrote:
> Hi,
> 
> the CIP kernel team has released Linux kernel v4.19.325-cip137. The linux-4.19.y-cip tree's base version has been updated to v4.19-st21. The trees are up-to-date with kernel 5.10.271.
> 

Thanks a lot, Uli and everyone else supporting this non-trivial release.

Pavel, -rt is due now as well. Please follow up with it soon.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
