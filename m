Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92CCC0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 06:04:27 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.58])
 by mx.groups.io with SMTP id smtpd.web11.9972.1738217061213301431
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jan 2025 22:04:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=h1oMNpBP;
 spf=pass (domain: siemens.com, ip: 52.101.70.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRINYFTDo2vH9Rv+/lbSgP3isgVz6VgzLI3CZIA6X3Q3FmqQu77QEyS83P9aQHK0rIfgkdLRIHv4bHqtnRcW4FPhqWx++0TIUEfZ63NcB7zZ9xdQ1G4x8+D83VSdgQl8Odoj801QBkI88mFFKrYaDsBfsaqPbpQHRrs6QmdwOyPRvHJPaG+9RPU8bWFpLlxgdAwQYTRA6wz5JKsEN/4cePBtM/HJ86R3uxFY355axYpdeOhukF260OX7YvW/9q+dJ6KBDZAYJuyPe1JNQ7dKKYxLZaKWCC2igUjxWEOUiNuNxob2aTOVm143kqrQ3isd2UKjHfcf2juApX3rI2j0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCOxDi8sOYCAMAdKL9/LBOCsae/lcUPkLudlRCS6WMs=;
 b=ViwNORkdSiqhZldXFKHac/02J6pJsBulQO8SiCrPQc2UAtkAuXm17s3Jd05sIva912llV1XsDjg99mt6Ctp95KJMHernCyokEj/OuSHFMNNqN7Xc+7KpNHiMpxkduXx+nALHfFXgAe7BWBPeDzNrlk56/OtVYv4bNozkes/+gD8Pk3b7whA0y+g+DrVQNoBHl5gVd80JATfJ1U9+88JwN/496Vy+SGRmbkx6f0b07Y4AIvPEMkbw2X9g71jdiyZDS7/zKKBuGydZt7imUkVyO5SJcPgeVKCdfpP6EZV86CkrutBe+SbZgmI4m4SQjEGtz0q5l2isTuodEWNkkJ46ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCOxDi8sOYCAMAdKL9/LBOCsae/lcUPkLudlRCS6WMs=;
 b=h1oMNpBPGBUV2G6aRj42nKVDBcgrvJIY7ubAh0tzYVewCQ4DveigKhBVcEwM1Px1swdx9YdYgJAzCUbK1oMje2IWS0EliTo5gytSz609LEtXrIJJFh0d+sWXwi6sYO4+ZZOSJPBaaD5MJ8B5zhedRvlxvFdmC7ZfV39/ubLVpIf0rajH09lO0wpy/u3WYYePwIaBx/jrf8XGLeJ4QtcViFyHAw8RRVvjzvteS/aOZdsmH17JMrKNKsfe6LlqIiiii/kOSQy/zRNRE5xwQaiPiGtHnrxJFpvkqLGdGbvlF+MUreTSAvJHQZOyt+BcioY4LXUJ41dLo23+Hh0k+tKKcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS5PR10MB8294.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:653::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.5; Thu, 30 Jan
 2025 06:04:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.005; Thu, 30 Jan 2025
 06:04:17 +0000
Message-ID: <e4e2170d-da07-4784-b492-c1182ef9bd98@siemens.com>
Date: Thu, 30 Jan 2025 07:04:15 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip95,
 4.19.325-cip116[-rt40]
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS5PR10MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d7dd2a-5920-480c-46c6-08dd40f3ee2f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N3hrOGRCdkF6N3hHT0tERm8veTNUZVpITHUwcTV4aGplWHZlM1JoT3FsQlJC?=
 =?utf-8?B?NTBJcS9SOXQ3MXVKSkVZbXFJdThheDhVYkRyNzBYQ2pEU1kxQWg1TFVKMkVi?=
 =?utf-8?B?K1FZV2pvbzlpOHFlVEJMK1V2ZTJiZmdlOEw3dWQ4eDhxOUIrZ2hQdkI4L1Qv?=
 =?utf-8?B?SkFGVmQ4K1ZmN0JjeTYybGlZWmpUS25WdThJUGRIYTkrSGlHSXJNWE81SXND?=
 =?utf-8?B?ZHZJV29CMFBnUDIwT0o5TGFaREtWNWhFeHRhWnIwVnZrTVhvUjRtQ3Vya1lv?=
 =?utf-8?B?OXAydFlMVFJJUSt0Y09aeXdmODdsNmQ0Nm1aV2gwQmVndnVnQUxabXVyR3Vi?=
 =?utf-8?B?SGVzSGVEeTBxK3pCb29ISFdaUjFkUXBXaloxb3NIQ2hxa3htak0zS2dQdjV3?=
 =?utf-8?B?TGc5TWV6aXZocmdlYldyU0MxNzV5eDNXUGtyTnFCd1hYR1BBejE3a3JFR01G?=
 =?utf-8?B?NHJaRFB0RE1RR1RvMWVtZURJZlBZUlJOS2xpa2lCVU9UWGJqeDQzWXBDaEFj?=
 =?utf-8?B?eFRoZERhT1NxL0hoS0xFeU91RzFUMEhRY3FhWFNacFZsN2g2RDNEK2lKVjZM?=
 =?utf-8?B?ZnVCTmI1MFVHRDdidXp0bkNHTWdLMS9NV3B6SmJrcjB3WFcwMUQybEQwR0VX?=
 =?utf-8?B?WWQvWEhMOUpmWGNwdHZBaGR5b0dGVGhZN1AyR0k1MTBNcHNyZHNPSkUya1FV?=
 =?utf-8?B?Q29XTXZzOElqVmlsSkR0eXFDcEdnNUNsYllGRWtIb3lyRGhVc1BGUWU5U1hR?=
 =?utf-8?B?RjQzcnhNWWFsak8vdXUydkwrcUVhbElnUGVoSk9lUnVXQ1E4a0xPRVVFUnlC?=
 =?utf-8?B?YkV3RVU4RVhWZE9OcmNoNlJTOGdwWmdmdUtaazFZTVBEaHpldzZpektKMGgr?=
 =?utf-8?B?VFFyU0k0TlVkbU9Zc2tEQ3Z2cncvV3NXOEVBS0ZOUUxZNVZ2Q1MzS01WUDBM?=
 =?utf-8?B?bi9JY2owNWNoemVPa28vdkdTSU1NdERvVkc0aHRudjI1OTQwMUQ1RmJXU3RD?=
 =?utf-8?B?MFYyWWdkSU5DTW8xYmY4R0xGMHZmdDIzcjRPTUN5eW5BbThncUtVK0JqcjJK?=
 =?utf-8?B?dUdGS2Jxbmc2ZVJWbnV5UzBxc2RnaG1IVDJWZStjUmFFakQ0SnJBOVlOVVBh?=
 =?utf-8?B?TEpJbTE2dmF5ZlBRc1ZGd09OTHQ1SG5FRjhhYmM1dHVsQkh6ak9sUitPTmFW?=
 =?utf-8?B?cE4xcGFRdDZHN1FrekNJN2RPVGVoVm9WVWkrcUpHUVIvNmNFQ0VVbUh1blhQ?=
 =?utf-8?B?WGw1YWtIaitKV3YvS2ZMbTQ4VzhWaEoyUXlRWlJmblI2aTZ2ZzB6ejQvYUhH?=
 =?utf-8?B?a3VOanFNeG1oODkyK1JDWGMvbnNZT3d5VStyOVh4SDZXOHB2RHhIM0xZME8w?=
 =?utf-8?B?QkEvUzJJaGFIS2xjY1RhTmtrTFdLYW1MOHFRYk55TENabGppNkxUTEJYejMw?=
 =?utf-8?B?K3g3SnR2Rll6cXFEOFQ4ZDVvdDEzS1kxQ25mdnNQSGwwa3JoM0ppUi8rY3Fw?=
 =?utf-8?B?ZisrN2NLa2x1eUtXSys5ZjA4RWRDQ3B6SVZ1K1FGK0o3dFZpWHBLYlFqQWlD?=
 =?utf-8?B?dlkyZkpQNWxSemQvMno4Z3RSWWttKzkxYUcydXRlYi9jRVU5WjdQTE1jOUdK?=
 =?utf-8?B?UWtLbVlHVGtMRTdWOFFkY05nKzJiQXBVSFZzWG9kOUh5WnV4OWVMaVFTSUt1?=
 =?utf-8?B?Nk40SkRKNU9HVVViWWd4RG1ic1lsN1BIbWNrOFdtcE9xS2E1SUdFeE5ncmVT?=
 =?utf-8?B?NTBZcWNENDFySktxaTdRZkJNUDk5cTdMTlhmODBrUk1mdFBVcjhXSXhnMVU4?=
 =?utf-8?B?clV2ampMb21XaFJpbXVMQThuOHVvY29Za3EyUXhDczVjVmNwQnhHQ0tDMzB1?=
 =?utf-8?Q?h+8gUGUf6JKQv?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:hu;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WEF6K2ljNHh5dGlOL0o3b0pVL1E4S3pHZHVraWo4T3ZoR01WckJyZkc1ZWc0?=
 =?utf-8?B?R0pBTDF2YUlWOEhkeVVqOEVaT2Z6c2d0Y2RZUzhaaE4wWWdDTEdOOW4ySmZu?=
 =?utf-8?B?WHVsc3dlSVBVZE50ejBJMDlMQitkaWJ3cE1PWmd0a3F1ckZrNER1V1JGaVNG?=
 =?utf-8?B?amdGR0pzY3E0UGZBbVZiQU5qbTNtVWhoeDRZSFFXd2ppUFg0bC9TT1J3QVJx?=
 =?utf-8?B?SmJjSTJHaWtsVzNudEIzWGFObkRjNWdMRGxmaVlwV1NtLzRIbmRBMWM1cUE0?=
 =?utf-8?B?Tm1UWnR6VzgyeTJmbTFiMnJxUWY5MHg5Y2dETmlYMlVFOEsyMTV2SitZbStX?=
 =?utf-8?B?clRFN0pSRS9yd1ltQldqWTI0OVdKRTltc2xhWDk1NHU0dElaclpaWS92QUlD?=
 =?utf-8?B?UFNMWHJtRm1STktYUDdLaUdidndSbkZYUHJMR3hUaXNaQU5TL1Z0RG95MXcy?=
 =?utf-8?B?QUJwSG42aVJxNXlTQThUYjBhTTdjV3BmM3Y2RnJrd01oczFxVXF0TjJSWDFI?=
 =?utf-8?B?YzJwVnF1d0ljcWNnMCtxQmY0NGZtRnQ4eEtuMnE2enRLZUcxUVRJREV3dUhI?=
 =?utf-8?B?WlhzTmoydGtVNzRwWE9yNWFTTGQ4WXJBcEttMVoxWGp0SmxzdHdhZXN5Zkpv?=
 =?utf-8?B?ZCtSQXZXVGZ3NDc2SEFJVlJncEplVlJVR3l2WFYrYXE2YnNxd1NOdFhvSmFQ?=
 =?utf-8?B?MkJKNUlOYUN4ZmVhV0xJODF0d3hKTy9DcThiYlY2R1h4UWVWM2R2REx3Wkpj?=
 =?utf-8?B?M3B2cFJ5cTZKNXJxUnA5RGNpd0NNV2NIKzJrci9CYVVpTFJTb1BXaSttYlcz?=
 =?utf-8?B?c05wZHNzSFFmN0hTSjJINXFVMXJpUDVhL2dNL0IwSE5tQldrS1lFOFB2Nisv?=
 =?utf-8?B?QkdJazNncmUrL001MjlRVVd1VUhXMUZRblJKM2J0d2hNV0c5ZmpRNXNnTkM3?=
 =?utf-8?B?VkN3RnZoTnkrVFZnZUlTeHlEaHF2anpIN0ZFU09kVFhjdjVvQ3BjbmVsYXlM?=
 =?utf-8?B?UGtjZnp5S0E1eERKVUZKcnU5N2QyUlVMQ3FMZ1pmOU1mdHhnM1RWaWxZWUJC?=
 =?utf-8?B?VlhrelRSM1ZjTWFiVVRydzFYbmtyNUFmWEhpVFNHd3M4eFpDY2NpUVhRd0ZY?=
 =?utf-8?B?TlRiWFFJbkh3UStCV0gyK2xwdFNYdy83RnhVeTY3VW9yL2hXemR5YmkzWVpS?=
 =?utf-8?B?cFhuY3VSUGJpNWJmWFkwaklJVnpGN2RERFhjY3BjUCsxN2VYMy9Va3ltdHN3?=
 =?utf-8?B?YjBLZ0NDUXRGNkU2YWpkVjZLd3ZtVkZ2M2Y3d3QzbnFJNXg0WG5XUVQwZVd6?=
 =?utf-8?B?Ry9tbktiNkkyOHR2Y1FlUU1qL3BLL3h5Ky94QmV3MDlxQTd1c2RtL2M2eFV1?=
 =?utf-8?B?YnRkZmN0djFLRmZhYXNaWkx6WXVFaHZ5MUlPanFSUERJVkN6cS81aVVNTHk4?=
 =?utf-8?B?ODVwWkE4Z1JxR0l1ekhhUlFHSW9CS3A0QnA2Q25rMDBFSHFqTTNtdVZlUzVG?=
 =?utf-8?B?YnhQdWpPK3F2SERNcGk1OEJhb3Q3YUkwdkhpc1p0cEFJc1dnR2JjRWZOVFlE?=
 =?utf-8?B?Snd0Wit1dlplaUIrYU5uNFM3VGJQWXZraW1UWjBudUFnakg5RzZ5QXB2UVNy?=
 =?utf-8?B?azJOTVdZWENJV1QxalJ1eVJVeXdEMzdSK3kwcTdscElBWFpCREx4Q2Z2Z2dC?=
 =?utf-8?B?RHlnQkNtRXJsWkVRenNLaUl6MnRSOHpFZ1h3dUU2RjBZQXZhYkpPaXZxZXVv?=
 =?utf-8?B?WVdpeFNidVZrbnBhUVlVZzFNcVJlMUtEZ28wZXZwT3J0Y3ZFWEZJY3AvenVO?=
 =?utf-8?B?MnVNQ2pXcG1MbFpHTFJmZDB0Q21QSTVRQ2VVbkNOYWtsSkVUdXVaeVgwNnhC?=
 =?utf-8?B?YnV2QVVVNFZyMWUwcVhmNWIwUFM3TTdsRkpwRzd5SnhSSmVaYW5kSUtTQ2dE?=
 =?utf-8?B?eFhaalArWUdDSFZieEFVK21rL3FaSVpxbmpCQ01hVDlBQ3JVc25TUTJJZXF4?=
 =?utf-8?B?V2llNnNkTWhSZHg3TzFXYkhjbDJuaFFqU29KRnlqNFIyTmsrSUtLUHNJVjN0?=
 =?utf-8?B?Y0pUSkpvaWE4SVo0SERXRnR6UGZtWVkzeGtDbUhlN0gzcTRWdVYrZXA4WTlq?=
 =?utf-8?Q?AqSkLgPc/QmWfohbWiz8dqUw4?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d7dd2a-5920-480c-46c6-08dd40f3ee2f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 06:04:17.4671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXXMAU5XV9hmh9M28Q11qhLVrXAO7CJbWPtDe1ZtpeT1Hx7l0f9SSRszoK3AVlUMP3EsrBCq8pc6Gr9JhVv8QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8294
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 06:04:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17684

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ....324-cip115-rt39.bb => linux-cip-rt_4.19.325-cip116-rt40.bb} | 2 +-
 ...10.229-cip54-rt23.bb => linux-cip-rt_5.10.233-cip56-rt24.bb} | 2 +-
 ...-cip_6.1.119-cip33.bb => linux-cip-rt_6.1.127-cip36-rt19.bb} | 2 +-
 ...inux-cip_4.19.324-cip115.bb => linux-cip_4.19.325-cip116.bb} | 2 +-
 .../{linux-cip_4.4.302-cip94.bb => linux-cip_4.4.302-cip95.bb}  | 2 +-
 ...{linux-cip_5.10.230-cip55.bb => linux-cip_5.10.233-cip56.bb} | 2 +-
 ...-cip-rt_6.1.119-cip33-rt18.bb => linux-cip_6.1.127-cip36.bb} | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.324-cip115-rt39.bb => linux-cip-rt_4.19.325-cip116-rt40.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.229-cip54-rt23.bb => linux-cip-rt_5.10.233-cip56-rt24.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.119-cip33.bb => linux-cip-rt_6.1.127-cip36-rt19.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_4.19.324-cip115.bb => linux-cip_4.19.325-cip116.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip94.bb => linux-cip_4.4.302-cip95.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.230-cip55.bb => linux-cip_5.10.233-cip56.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.119-cip33-rt18.bb => linux-cip_6.1.127-cip36.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.324-cip115-rt39.bb b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip116-rt40.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.324-cip115-rt39.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.325-cip116-rt40.bb
index 73195c01..2acaaf71 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.324-cip115-rt39.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip116-rt40.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "54c5b8c4ee31c73794e31f3f44b85c85a1ea760e0783121da715dd14076e1c04"
+SRC_URI[sha256sum] = "7b05ec6f1e6d97420247e26ee8d2a94924e7c17b9863909c3139cfb9efd7bcf0"
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.229-cip54-rt23.bb b/recipes-kernel/linux/linux-cip-rt_5.10.233-cip56-rt24.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_5.10.229-cip54-rt23.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.233-cip56-rt24.bb
index b4ed09f6..80f8a31b 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.229-cip54-rt23.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.233-cip56-rt24.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "b2b1767a7c8fe41391bcdf508349c45bbb3b8fbdd4add031b0767d583d5c8738"
+SRC_URI[sha256sum] = "3878975f833e792a3a51dd08349c1317203c5e15658e33a28c8ec27f8c2a1633"
diff --git a/recipes-kernel/linux/linux-cip_6.1.119-cip33.bb b/recipes-kernel/linux/linux-cip-rt_6.1.127-cip36-rt19.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.119-cip33.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.127-cip36-rt19.bb
index 069b01bf..fbb7d409 100644
--- a/recipes-kernel/linux/linux-cip_6.1.119-cip33.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.127-cip36-rt19.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "95f5529a116d6b8172ff53e387509363f06aa19c60ee7e07ea2366ff31f7cb70"
+SRC_URI[sha256sum] = "93525a9cb4e9074e0b7d63cdd12acc4758b0bfeca994b5a6ca8ac3e283e1dd85"
diff --git a/recipes-kernel/linux/linux-cip_4.19.324-cip115.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip116.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.324-cip115.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip116.bb
index b0346b7c..db76ae0b 100644
--- a/recipes-kernel/linux/linux-cip_4.19.324-cip115.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip116.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "eee447439d3967bff4ba25130bf22a98deacbe90bc0dde7f75422578e6c167f6"
+SRC_URI[sha256sum] = "d6088d5a4dc3bdc7b35fb2bd068ab8dd787100cc7993f9cf4a2d753cb5156ef1"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip94.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip95.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip94.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip95.bb
index 3951814e..103e1a15 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip94.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip95.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "c8fc9015d6eb49164e45a504d86d00627dd5fabe0270e35a7d2b70be9f7aef98"
+SRC_URI[sha256sum] = "8df934b0880537edd458acf555f91632d972c00fa85075cc4e7a23a772646865"
diff --git a/recipes-kernel/linux/linux-cip_5.10.230-cip55.bb b/recipes-kernel/linux/linux-cip_5.10.233-cip56.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.230-cip55.bb
rename to recipes-kernel/linux/linux-cip_5.10.233-cip56.bb
index 8839d70a..fdcb2c2c 100644
--- a/recipes-kernel/linux/linux-cip_5.10.230-cip55.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.233-cip56.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "729d210ba8190859af616897bca6a845a070a483788bf1cf02b8dc0ec9b94ba1"
+SRC_URI[sha256sum] = "5eaa1219d388ecdf57c4aa929337e50643692501b22ab12e054aa005051edd4f"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.119-cip33-rt18.bb b/recipes-kernel/linux/linux-cip_6.1.127-cip36.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.119-cip33-rt18.bb
rename to recipes-kernel/linux/linux-cip_6.1.127-cip36.bb
index cb476223..a4f57e32 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.119-cip33-rt18.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.127-cip36.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "5f6aceb0a5828a2828f63cbe9763857ca3cd136100f11e392c847659c353773d"
+SRC_URI[sha256sum] = "38598076cb7cc5e5574ad2def352145bcbb1cf454b20ed0f11a9916c77d5fd43"
-- 
2.43.0

