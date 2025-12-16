Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22293D5C0F2
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 08:38:44 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.37])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17855.1765874320846960690
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 00:38:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ehvAmNhE;
 spf=pass (domain: siemens.com, ip: 40.107.162.37, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTVxZ07nsJ4jR2c8689QvNGOmVFzPFdQRai6LCu+L/XJuLhbNPgLT7tmoSM5m4SB5CQMclvB3fBmaCKPtmEw7YB9G8An0N1TxzXwqqSSThLlgw1Lx48aVEpVzNiB3uaI6myQbND7FF+KtiF4sWDrDWLZ1GzsgW1R8gk7mY7rnPFU2tk6ZItqxQjUWWwbwz5L/QKd8Com1QPRbm22sdCvUVaVZR2+/vRjnKf3LSOxc1GstHJEUpIty66RTQZmNXystQYSVY6wfbXycXx75MwmAzIYJz6+N+aiVKB3oWKMnClZAi5BvyVdAZkbCJnfK72b+gddWHwvoNeEKEkKA36RCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJ/u0qiRivBRo6wLjX/DZIpy8mbewKaGYCiU82OMipE=;
 b=brgBp6h4Wiwefxh9z/iAE2A9yevvPC82ObKWpPOMOP2Y4jA4ySb2j42gdySG9PACsYHSB1nyCLZWKxEubKoTQ96sGarzVek44Jcl2pgNmM/N9BivxU/e9LebZUvPR9l/hgPxPjeTxipxLZrtG26aZmQwnq/Rs1EU2T4LZ78AZCoA9xc/H8PooGx896TIoC7zSsEX+HrprGfxHHNbHaSzFxxVnU3H1MZLn47xf9TcbgtLFmvelSewUppcMQjnbrVwSd3m5ngeoI12OJvQtOyPT1HmCulvUDg3fD+wanEW+Nm5An7wVcisKBEQ5L1zDZ2lAPL/lVCviqGliRBySV80yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ/u0qiRivBRo6wLjX/DZIpy8mbewKaGYCiU82OMipE=;
 b=ehvAmNhE9A2OmpMJJghpxuqmn/49RYXx7LYuP5G0VMjX8saEmyLxrEhmGcD5SyGWF45yi9DZp8AXWuRpLReHoD+LET3DGzIiD/yChYE76nBKW1PfZNNhtEGxsJL6AderBVukUfXJapOWmxz4RTuiwnMS+UWMs1ZVFThbADfjJGwvt3c+KI432ks2W4EscFBfpsog6MonGs6antEsoLKFkVlyuJLjIsqkFq0oW5BM08IxHOg7NLHRDV7LSdJQJ71m8tAUMr2GwtCsalVHBC5Q+IMtZ1Xxs/on9DcYh4132mbAd9cPHkRwA5sfen1gX+zF9h1TzxzJrOXbN/uKNxaUhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
 by PR3PR10MB3865.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:42::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 08:38:36 +0000
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314]) by VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314%4]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 08:38:36 +0000
Message-ID: <8a603e03-75f4-40a5-805d-5df1f8b84c19@siemens.com>
Date: Tue, 16 Dec 2025 09:38:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 4/4] fix: ensure separate root
 home dir is recreated after factory-reset
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20251216082559.327416-1-Quirin.Gylstorff@siemens.com>
 <20251216082559.327416-5-Quirin.Gylstorff@siemens.com>
 <d4aace53-d48e-4ee6-84ac-7083ccb580d2@siemens.com>
 <e556f13e-5cfc-4ca2-8afa-1aab6057ab7d@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <e556f13e-5cfc-4ca2-8afa-1aab6057ab7d@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P195CA0029.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::34) To VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:89::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2319:EE_|PR3PR10MB3865:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3be8ff-6ba0-483a-4663-08de3c7e80b6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y2NhOXo0SUlMb3VEeG1PeUVOZDN6ak1VbVdJdS9GS3BaRkhJMmczYzVXcmtC?=
 =?utf-8?B?YmFjSzl5R09EVFBCcWJkVE8vV3F5SEQvcjRVWk5OSW8rZ2tBZ0pGd0YwWmdC?=
 =?utf-8?B?TXMwemNnTzV6TmlMYzJsdUhRNHVyZ2NjMzVHZmJpbHdMZU1HNXEwWXdGVlZT?=
 =?utf-8?B?aHNxQVp6Wm5lUHdvRW93UEtoUFhFRlprdXRCdm1pZUVpWVRGcVVtRUx1SFFx?=
 =?utf-8?B?aW9uRU8xZHRZRGlNVDJzaGhTc1pWYUwwejQvZ2xxOVN1V0N2cXYxdDFQNUdz?=
 =?utf-8?B?bkE2VkVzUTdtMEZUMWFLem1Pd0hvRzhJUUdjS05kck53Q0pMZE5jZGUySXQ3?=
 =?utf-8?B?UXFiZi9WeFc2Y1NBNGZmYVVwaXIrNDVCdGFlU25rR0hwWW1MZkVSWU1xSnI1?=
 =?utf-8?B?MkIrTmN4Nmhudk01bTdxUzczcGwvMXpYam9TOFN6aUVhYXVDcS9YeG4yYXRD?=
 =?utf-8?B?QStjOFB5bHo4ajBhVENCdjFJMFRqejg5TmpaRVJXQ1VEaVl4VTFyNkxiSVU0?=
 =?utf-8?B?UnVxNERjUjhCT0J2SDcrRUVFcVJZVXFJZXZPRDNXRk9qWXlLR21ESjN0ZmNZ?=
 =?utf-8?B?cDJMZ2RWVGVoNmVKY2FxWEdqMk8rWGVDVDBJV3djY1c4NVYyZXRTM3NhSmtI?=
 =?utf-8?B?eUVrSUVCbGpheXN2M2hUS2o0RkRXc2lQdmtlVzBTSVRBUllaRTZxbGlaYWQy?=
 =?utf-8?B?elBJL2xXMnZkZjVZaExsbFc4L1NqeEdSZ0Mvd1ZkcElFZmR2ekFIekMzaFRT?=
 =?utf-8?B?czZ6Mm5md21sOEJUSk4wMGRrZGxLUTZVVTZrOU5rQXNMRGFHdE8zU2JucEFB?=
 =?utf-8?B?OFFCQ3VxTzF0bE0vVlNqbzZ1WmlUaUpHRVkyQ1VtWlFjWVBnb1hxTnVDK0dp?=
 =?utf-8?B?M2c3OGdzOE9KbHp3b0dINE82MEhjQjRjR2ZXN0VDRTBrVVZsYlZmMWFEdUpV?=
 =?utf-8?B?bmswdGMvcnJhVWJldUVMYWVyV2ZPRTgvanMyMWFvYzRxVlJFNk1uMzM5aFBo?=
 =?utf-8?B?OEVhOTF4NTlmdlRMUGR1WWRkZlBNczdrc01Ya3lCUFhqMXZIUjlkL0ZpYmJl?=
 =?utf-8?B?ZlZSZmhWeVZnMzcreUJoRnJkaVRsL3pmK1VLTEZOQ0RNMWpJOHpYZ050elM2?=
 =?utf-8?B?MTRETFZCS3puVXlwR2VwdFRZMG94dW1UUEpsMEx6OFRWQW9NRUZNdkhpVlVi?=
 =?utf-8?B?Ni9BNnovZy8wM2Z5ZWNUT1h3T2ppZU1vWUtBbUJGV1dnY3gzTGJjNlM0VUUz?=
 =?utf-8?B?b2ZDRmdRRk9McnNWUE1WbDRvazBpN0xoTmF5Z2VJR3ltQmQ0T0psbFdSVGNL?=
 =?utf-8?B?ejI5RWo3L0NkVzFQUlptMXNqOG5nT0hYZmdXSG5LZ2JOcC9wMzNieFZMYnV1?=
 =?utf-8?B?Z3dGMkthMDk1S3ppUGt4TWM5cXJXRGx3djJDTFFZSVNORjVRWFZPMHp1L1pu?=
 =?utf-8?B?SUlpZ1ZHM2xEdTBaMzd4UUpGeWs1cm10MFZjKzBsSDVGd3BZL3ZyTEs1Y3JG?=
 =?utf-8?B?bXFqNG04bEFoS01BRFU4dzQ3c0lFdStzbml4clJjRjlEMGVGclU2Q3dZdnNp?=
 =?utf-8?B?Z00xbE5rd0lSeTZLd2pwR0hrWno2c2gzWHJQdVlGczM0UXhLMWJwdmc0TFRF?=
 =?utf-8?B?SUJpTjdqbXdMSlg2bENKMmJqRWtRVmdxcGxLZURqZFZ3TmN3SXpYUk12NVA5?=
 =?utf-8?B?L0ozQnJUaDM1NlJTa2tZM2lOZmF2dHBnb0pXbDJKaUZodng3Tm55Zmg2Ym10?=
 =?utf-8?B?V0l0K2wweEtEb0FiRXpTODVJM0Ftd0Q0RGN0cExiaGVOaWdEQXo4OU5tVUpU?=
 =?utf-8?B?OEhGNGVkaElPaEU2U0xkNzZ1dU9sM2lGeWR4M1N5d0VqQ2dSVjJGT2RUQTNx?=
 =?utf-8?B?QnNMbWd4YkczRHVhK2JrbjQ3ZlRyVVZtTTlEaHgxaFZ6Y05lM3loS0Zwb3k5?=
 =?utf-8?Q?lWt+RrFt3mXnOPUCUQVyqskn1DQI6Qnn?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NjR0dHpBdjVjV3R3MDU4emxXbk0rVnkvMWR3MXJFenBlYmNydDJaNmRYRm1w?=
 =?utf-8?B?Y1NrWTdDVWJmR2wxZitESFNsdUVtR1J4dGxTNUxmdmVaR3k0YmZuOGQ1K3RK?=
 =?utf-8?B?UU1YNnNaTm1PRUU0Y0w5Z3lDSCtjLzFTNzBmSG1ERTZ4MUx6OGIvVk5xMXJn?=
 =?utf-8?B?cnZuVjNWODBHUzZubGcvaGpReUp0MHRNTEhUVWdCQlFpeGtLQWt2QnhmQy9q?=
 =?utf-8?B?azFqbUs0TlQwNDFWSWQ1N1JMMnd5aDRjS3p3TFh5RndjbityTEdVMHh4Y25N?=
 =?utf-8?B?cmZGOGVFdTY2RzhqSDdxNHBFOWlqcERaU0l5MnljblQ1VDlUK1NOWCtWUzB1?=
 =?utf-8?B?Tm45Wnp4TUVUWVZLQXZLaTIzc2RpYTRlSkVrZmxHaXVzb05KazZ4c1hXL0tv?=
 =?utf-8?B?eHFUTm5yYzJuSWdyZFB5aFdVR3BBaFBnanVwblBWSkpjNHg4NTFlUTB6MG9L?=
 =?utf-8?B?eER3MUppbEM0b1dlQzkxOGJaV25tcUJXMHpkVXFYRXVoeVNSL2tPcVNieW1O?=
 =?utf-8?B?cjZPRFNXVm1lME5qZngwV1p5TXJDcHpqbEUvTzB1Qi9KZGRLb2t0ZUxEc0tN?=
 =?utf-8?B?NHZxYmM4cmRFanp1Q1VaSm1YK1ZTYTlDZHdtOTFjMkQ3UHZFdWwyYldKaXNm?=
 =?utf-8?B?SFMrUEJDRTNMNWN5bnVwbzlPd0F4dHh6M3ZMbGx1bTNRUVBWMGlZV0x6MEdB?=
 =?utf-8?B?Y1cyS201VG1wMzhFaUtjalhOOWY4ZjNDd2ZTVk96SzNBeEpGcVRrcS8vY1Fo?=
 =?utf-8?B?Q0VHcTU3d3hkVHVHQjZkSnZzK0pDZlhEb2k3Y0pzR3VkRSthN2NhV1ZtVEYy?=
 =?utf-8?B?OEQ4Qm5nczRFazNNeHZHaXQvWFNvdDFmRFJ0ay9hbGRKLzh3WGlTL3dFN0la?=
 =?utf-8?B?OUFFRisvbUtUWHV5MFdha3ZpVDRFeHI5MHN3MElQNjdVVG9pM25wOUpEVGQ2?=
 =?utf-8?B?b0JxL2FWaVZEWWZMb01lbjBSRThMbzEzQ2J1UGhBUzNWR1YzNmdFZllTQ2xV?=
 =?utf-8?B?a05kNCtuTjFtVGdpWFNraVZ4T3BaY21yUEZ6b3B1ZUVoY0tBcjUvWC9MSmNw?=
 =?utf-8?B?REZ6MnJqNWF0RHN5eThwcGgxbG5keG5hNVN3Wi9Kd2tMcUtGRkJ2Z25WM21R?=
 =?utf-8?B?QmhJK0JEalY4QWNtZFZzV1ZRbHQ3T3hIY3VLbEQybVZOTEdqLzBRNll2akpJ?=
 =?utf-8?B?Z3VBUzJMYzBLTnNka1NWM3VmNzAyUXpvN1YxOGVBV25oS2l5VjFMc0laa2F5?=
 =?utf-8?B?REYvdlJ6eWJWVjdYbjY0amhneUd2clZlVVdCZ2VmTDZ1NkJaNjNKaXUrenhU?=
 =?utf-8?B?TVRsMFpBaUYwc2hpdE9iRHlKc1A4SWpJbUg3T1RXdit5Rk9ramRhcTcwYWda?=
 =?utf-8?B?N0Z5elpyUXBGS2VxM3l5WHlFUlBVanFNaG5ieEFQdEZDT1NpQjRNY0Zwc1lN?=
 =?utf-8?B?SzEzRDM3MzBlWW5MSHZPckhNNkNHNjlpdlVYNFhlZHE5WDVkNVpETnlzMlE1?=
 =?utf-8?B?SWFKRjhZV3BxZGpSN0V2eWJ4alVPa2NKRytubkJEbDNIWGlRRFJ3b0kwWXlw?=
 =?utf-8?B?d3lYVTZkTU5meVFqakRLS2QyTE1DUm1pVWY0dHlHdHV1c3VpZHY5Zk9CNHVt?=
 =?utf-8?B?ZnQvNVl4ejUyVllpNVg5OW1OZFdKOGhwV0pNbzNIcVo2R1Q1SWNpbWRvUWRF?=
 =?utf-8?B?VG9jTTFHV2VuUjVvVnNuVFBLQTQ1eGdkUGNzYXRhZm5ZajZ0TUdWamtzLzZh?=
 =?utf-8?B?YllXUTlONWtVMWtaRHhUWWk0cFY4S3A4YzQxSE52Yit0WlI1dkZacVRWRmg1?=
 =?utf-8?B?WFZDQUZMK2FNS1hOVWNWbHJUakNVUGFickdKZitZVXg4TzJrM0dRZjRXY1VW?=
 =?utf-8?B?cFJzM3k1WGV3Yk56Nlk2WmJrbXJIL2h4cUhUWG02VEE4UVdnNDA4SDMvaU1B?=
 =?utf-8?B?VHAxQTBqNnNIcEV5NUtwVDR3S3BrelpQM2dCdTFTSFZkSjhaK0tXSW44dks2?=
 =?utf-8?B?c08wV3pGM3RpRlM5UDZ0bU1IWXNQY01LaGIxb042bmk3SjFUY0ptSlZzM3Fh?=
 =?utf-8?B?aGZWaDNjWWJKUFVUUUw4NnhLQ2hHNytMd21FWDVDeVhkMEZFN2QwdGphMzVX?=
 =?utf-8?B?VlJVYXFleW9tbHJqS3hEVkFBbGhNcE5RbmNvZnNqUDBEVndWSGhkWUt6YnRj?=
 =?utf-8?B?bGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3be8ff-6ba0-483a-4663-08de3c7e80b6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 08:38:35.9819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUWZSIcuI//phv7ttDE6ySAbvm7Dr81fzrZZXTzOu/m0eOMD0x1ggWcCLzIDijU9u3JHfXdRglDFS4Da89xEHYZ3FoaoCvDPUaJA3gWYLLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3865
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 08:38:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21080



On 12/16/25 09:36, Jan Kiszka wrote:
> On 16.12.25 09:29, Jan Kiszka wrote:
>> On 16.12.25 09:25, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> If the option `separate-home-part` is used the home partition is deleted
>>> during a factory-reset. To ensure that the root home directory is
>>> available recreate the directory via tmpfiles.
>>>
>>> Additional user directories need to be addressed the same.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>>   .../change-root-homedir_0.1.bb                | 15 -----------
>>>   .../change-root-homedir_0.2.bb                | 27 +++++++++++++++++++
>>>   2 files changed, 27 insertions(+), 15 deletions(-)
>>>   delete mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.1.bb
>>>   create mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.2.bb
>>>
>>> diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.1.bb b/recipes-core/change-root-homedir/change-root-homedir_0.1.bb
>>> deleted file mode 100644
>>> index 79c7e67..0000000
>>> --- a/recipes-core/change-root-homedir/change-root-homedir_0.1.bb
>>> +++ /dev/null
>>> @@ -1,15 +0,0 @@
>>> -#
>>> -# CIP Core, generic profile
>>> -#
>>> -# Copyright (c) Siemens AG, 2021-2023
>>> -#
>>> -# Authors:
>>> -#  Henning Schild <henning.schild@siemens.com>
>>> -#
>>> -# SPDX-License-Identifier: MIT
>>> -
>>> -inherit dpkg-raw
>>> -
>>> -DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
>>> -
>>> -SRC_URI = "file://postinst"
>>> diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.2.bb b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
>>> new file mode 100644
>>> index 0000000..3cd415c
>>> --- /dev/null
>>> +++ b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
>>> @@ -0,0 +1,27 @@
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Siemens AG, 2021-2023
>>
>> 2025 - updated.
>>
>>> +#
>>> +# Authors:
>>> +#  Henning Schild <henning.schild@siemens.com>
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +
>>> +inherit dpkg-raw
>>> +
>>> +DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
>>> +
>>> +SRC_URI = "file://postinst"
>>> +
>>> +do_prepare_build:append:separate-home-part() {
>>> +    if ! grep -q /home/root ${WORKDIR}/${BPN}.tmpfiles; then
>>> +        echo "d /home/root 0700 root root -" >> ${WORKDIR}/${BPN}.tmpfiles
>>> +    fi
>>> +}
>>> +
>>> +do_prepare_build:append() {
>>> +    if [ -f ${WORKDIR}/${BPN}.tmpfiles ]; then
>>> +        cp ${WORKDIR}/${BPN}.tmpfiles ${S}/debian/
>>
>> I'm folding this line into the block above on merge.
>>
> 
> OK, I'm getting the point of these complications: Account for the case
> that the change-root-homedir generates/provides a ${BPN}.tmpfiles
> already. But that this not the case. Let's not overcomplicate things
> without a user, rather do that once there is one:
> 
> diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.1.bb b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
> similarity index 59%
> rename from recipes-core/change-root-homedir/change-root-homedir_0.1.bb
> rename to recipes-core/change-root-homedir/change-root-homedir_0.2.bb
> index 79c7e67d..a0725c15 100644
> --- a/recipes-core/change-root-homedir/change-root-homedir_0.1.bb
> +++ b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
> @@ -1,7 +1,7 @@
>   #
>   # CIP Core, generic profile
>   #
> -# Copyright (c) Siemens AG, 2021-2023
> +# Copyright (c) Siemens AG, 2021-2025
>   #
>   # Authors:
>   #  Henning Schild <henning.schild@siemens.com>
> @@ -13,3 +13,7 @@ inherit dpkg-raw
>   DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
>   
>   SRC_URI = "file://postinst"
> +
> +do_prepare_build:append:separate-home-part() {
> +    echo "d /home/root 0700 root root -" > ${S}/debian/${BPN}.tmpfiles
> +}
> 
> 
> Jan
> 
Looks good to me.

Quirin


