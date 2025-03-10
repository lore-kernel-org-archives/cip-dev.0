Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE73C28B2E
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 07:41:25 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.51])
 by mx.groups.io with SMTP id smtpd.web10.32121.1741592478131881820
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Mar 2025 00:41:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=T/9CF9M3;
 spf=pass (domain: siemens.com, ip: 40.107.241.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcBwJTLggdaJNvwPNPJ7L1ZxKgyFIKs3mcnVh/5Cxo48rr9rfdByhlgPWQ9A7M0dwbgJJi2lQruXMgNVfqRFusqm06zYsG38I3Qx9+Mmg/aeYuP4hdBYymPawDbDi5zYVHED6cjTKO+FaZbkgfKbp1rI9xAorHCTpla2hHI//tEWPiYmNuXmgUkJUw+KPWy7hSjww/lK1ZTf9r88v/J2S2ppKSKrIj5u8e2HBV1z0BstiA4/e3wU8h6seaQJ1Q1w1NIUqux1tJy779o80GnMsyiKwXVZ1MBAEMkbcbFit486oK68d04WPW8orVOTDlSW6Xxn+QXXz6OmYfZNRPDrjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUy/HCnO90cp7aeiYgZpXPgqY74XNu9iS34n3ROAEZo=;
 b=WZe7N+BuWqGhJO4mtAf4iGsQCJSU+g6HiUdofs+pJPHRjHocUlRZomUpCG95s++Wl3W9el5BNgf2ycBHjqFHK6slK8TVW5rYfj8SG8Ig6j/xIHS3xSKj3JW/wvmsvHycP9LWnfWc45ruT4ZUU0GibnvACv52nru+mdcesFkCDdICYUcxm1BEVx/l+QSU5VFvWWV6CNayZevsHfNzcfWpcvgD84tc6W12Pxtsl1e3altb884NSADh+pB+XY/4mEw7pNzMbceu9gwBm8d/gaBGmvXPcNZxJmm3HtUewZI+QRcPmXtwYe1nUKbFTkSTMhiJBjHtU/ZX8KRCBUSNz0cdnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUy/HCnO90cp7aeiYgZpXPgqY74XNu9iS34n3ROAEZo=;
 b=T/9CF9M3eWhGA+j+adg60L9F/gGyjZU1sWZOtmb+c2tcubWa/mMhEUL6KpIcvEzyMzyUMKkfq+Z+LnRRdXa4vSBI6NlDq0MPtlW0e/zIgBIQBXOvKHXaRXYDSTfDWr54fyQv2NtklxYQoI+DtZZhPjkdNeHxYUeWfVbudDbO2lemUYS9lmpAqvjF1uXIpwwAGj8BgUIvjMEbE4AZJMaXQJQQHpW34DfRUIb9jonaHa1/+ZpBGF5R+n3vOfxo9FFKcVzKybklMJ0SnatD0LwvSbDK/MrI4yYn5tn23RnDnzmS4H58YENGqoLbZJuMQYWAGCRIiDTQyHAkEX+J5j7HWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AS8PR10MB6604.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:565::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 07:41:14 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 07:41:14 +0000
Message-ID: <116fdac8-58bf-4424-9d97-aea0088f953b@siemens.com>
Date: Mon, 10 Mar 2025 08:41:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 0/6] Make /home partition
 optiona l
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20250305102807.2614514-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250305102807.2614514-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::13) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AS8PR10MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e4355a8-eacf-4b17-4971-08dd5fa6ef74
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QnVyRTJmUUVuRWVFMERlTjY4SEFlVkN4ejY0LzdsRy9GbkUrcThSdmJkdHd5?=
 =?utf-8?B?ak9TK2Zpd2JJWjBuVStDcVhRUUt5YlZPNjI2bVlkb0RyRGprQ2NkaVdCWW9i?=
 =?utf-8?B?ZHcybDdkVmozVVhhWlNySEtTM1ZXOEs1Y0owR25KWjUwNGN0S0dQcU9PcUpM?=
 =?utf-8?B?TXRnT1RhaTAyWWJ5Wm9CQ0o1TmJCTHlyem9tVmZ0M0NpMjdsNXBxUk02YUgy?=
 =?utf-8?B?SzdGazZYNGplL3FoLzh2elpVN0cvNSsvZm9YQ1dSSUJpdzlyYVV5Y3EvMkxK?=
 =?utf-8?B?ejM0ZXNWMjVNTHN3VUZPQVlUV0FicW52TnZQZXB6V204d0RjcGNKQ3FoU2s3?=
 =?utf-8?B?TUlheGhMR1ZQN1NlVHFUb25Nd0NIS2doc2hKWFBkQ0cxTHVvZDZuY0I4V3RJ?=
 =?utf-8?B?UHczbE5SQ1kwRGh2VENrdk50YklpVlk4anhoeS8wRUt5WnhHOUQyc1FDeEtn?=
 =?utf-8?B?QzFGZk4wSEpqbGVqc0tpYmd1bUlweitHOFlDQktYRFFvTXhYbmc3N2JvUDZy?=
 =?utf-8?B?WTlkUDNnVHpodm0yRG5rOHlRNmtCdlNHTW1kRWpTWVdvdkhTcmVIQWNoUmVp?=
 =?utf-8?B?RWNTWEpDNDBXNlk1YlVCM25Cb3hkSnF3WTY2UUp3clMzVG9zUGpiT3ZhL09Y?=
 =?utf-8?B?b2tNQ2NvcTZ4cjBNVVBQWUJ5UG96RVZJcUd6WVFVaGRZaW8vb2hIcDRjbjcy?=
 =?utf-8?B?d3dXZ0ExTzdPK3RZd29KSXN3eDIvNndjcElrNitzaVorOExRaGU4ZGlUdmxv?=
 =?utf-8?B?RnZoOWpTcUk5SWRQSmxrNmpvTG5hcG5MSXNzQXM1U0d2Rmd6d0dDb1U2Mms5?=
 =?utf-8?B?aXJPRENxU3llaG05cFZiK0lPaG9oSlFFVGlleHZPcnlCd1lJSHRxWVNlaC9l?=
 =?utf-8?B?V1VuTTdqeW9Xdkw2aTZNMFBEWXdBVXJ6NFBuL0x0RndzNVB5M29xVEVRcFRQ?=
 =?utf-8?B?THU4a2dSMHo3ZzZxTjVxU0Rla0gxZGk0TVFuWFVHY3NQOS9jTElaZFg3Y3p4?=
 =?utf-8?B?aDRkU0VLK2FLcHlXMXdYalhLcXRLTUN1cUVycndMaWlmSVQxTFZxMlNSWEgr?=
 =?utf-8?B?a2dVV3cweDJKdEtMMnhrcG1pdE15eVNBaEoyN3Zxa0JFN3lFQXBXdzNIM1Bz?=
 =?utf-8?B?OFF0NlozYVB2OVY4S2JjeTFienhzT3NuWlFadTJPcUl4dko0OFBITmRaMjN2?=
 =?utf-8?B?cmtNRUpKVksvRElWMUw2YWp5YkdZRUxnVEVxQUJKYTdmTWtXSjJubDMvZngv?=
 =?utf-8?B?TEJIVnJSMVlxOE5SSnlyQkR5dE0rUDZzS1pFS21uS1pWTWJzZkh2MWZQRE5y?=
 =?utf-8?B?SWRQMVV4K0FITm9HbjcrMUVKbFZFeWtCNDNhdFEyTWJObGphbHFQZkF2Qmtk?=
 =?utf-8?B?c0FBUldXd2MxaUNzMWdVQkJaUFhXQlZ2VkRldTh2S1VFYWlOcjBQZGJHZ2Zo?=
 =?utf-8?B?QmplQUxaRFkwdVpRUk8rNVBDZWJlU29uMitpMGR3bnJqVnh5aFpRZFVVeExZ?=
 =?utf-8?B?SGYrZUxPSE4xcktuOTRPSlpvYmpGVk1ITmIvdXhTanoyOXRybmVCd3BrN2hk?=
 =?utf-8?B?aW0zZithS3REUjdHUFFHQ1VJTTFMNWw2Z1FSbFIxQTFUV1VqVW41aUhtSm40?=
 =?utf-8?B?VkRnU1U5UHJvT3d6S1lZYjhpTktMelA5Z2l6b2czK0tmSUd6MktCZXFYNXFQ?=
 =?utf-8?B?dHJUMGVDdklIN3NFSnBwTEgrdThSbXIyd2pQbEZOQ0hWN00wYWl4TVVnbHRr?=
 =?utf-8?B?UHB0Y2IvVjBBWjI4bHJ2TEVPZW15NVExNm5OaVppd2t6WkxqcTc2L2QzNkIz?=
 =?utf-8?B?WGRZRHNnVnJURDg3WGUxaVFyV2ptNmw4SjFTbk1lSlNuVU1sQTlEYjBrek8w?=
 =?utf-8?Q?r28jlXldVrSml?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bmwwV2EzSFhkQnIzV2VQVnNtUEUxaTkwTmpOOWt6ajBRSklEUUV2TjZvVG9O?=
 =?utf-8?B?TS9QbkNVWGhna3o1UDR2VzR2d2VyanVuUGhQbXdvNEpBcDZwYU1sVGZSUVRT?=
 =?utf-8?B?OFA1enVmbHBYTG90QTBTb2V3aXR1N1AzTkRXdjkycE9jWGMvLzhBMGJUQWZm?=
 =?utf-8?B?VmVwbFhOT2RVbDAwNE1NNG12WVMyMTE0OXFBSVBpaERCR0FRanc4eTVZb1lr?=
 =?utf-8?B?a2EwYkJ6b0Y0NkdramlsOCtSVVhEM1BGTk9IVDUxMnVwT1ZBZVlNanRnZ0hu?=
 =?utf-8?B?RG4xbEYrdC9odUZsU3JURFg3Y2Q0MWRkdlJLR3lQTDN1RnF5ZFBoS3QzK2N2?=
 =?utf-8?B?NmVVVWlTdi80VnBUMjhPcnJvSmxBQ2VwNXdhTjNmYWQvM2R6WS94MnNjbkdi?=
 =?utf-8?B?dHhGWUNwczJMdkRmU2tXNWZ3a2sybTh3SW9iTlJzYlMxaTY3TEpPbzZVV0tr?=
 =?utf-8?B?T1ExSXZheHhtQUVKNkN1WmFZalZDd1Nub2JBKzFySllZRGtlK2lXVDB4WEZs?=
 =?utf-8?B?VU0zdnEvTS83UFNmK1hLT1JSUE43MXU4Q3JHWUNHL3I2dzlMQ1h1dWplVzZu?=
 =?utf-8?B?ZHhlcmNxSFBKTndaaUVaU1AxSUpCNWhlUW4xRm8zWFZON1YrRTkwQ3NBdGYz?=
 =?utf-8?B?eEFQNGIxRGg3VW5hOEErWVBGSTdmdEx2b2E2K2hqbERiVGtPUVVFbVh4bjJV?=
 =?utf-8?B?c1RHcjgwdXFEbzJjdXlKWEJKT25GTFJ4S2VPbkN3M0NYWnJyNGJGMlYvT2pv?=
 =?utf-8?B?NkM3bVNUR0RkOGM5c3NtUFBKWUZyQ0V1NjI4QVNUaDJkWUdKMWtQMGZKcWsx?=
 =?utf-8?B?NThzL3Y2L1dFL0NhdE10QnpzaVY2dDNnWTJqTDZLYUFIMTR3aGJBak1FQWln?=
 =?utf-8?B?WHdOekpTYXRxcGVGTXV2QXZIMFl3dnRIWkQ1RW9MQkxRMnArbDZnRXlFZzBa?=
 =?utf-8?B?Y05kSXpmOHRLU1hQZkFOZjVKRkpLbFBIMWZZOURPZy9FZTEzNTdoRENKTkpF?=
 =?utf-8?B?UlYybkNHUE56YzBPUWpRNmhvazBtTnNIaitiK3huRDEyaTNIdmg1YWVFVkdI?=
 =?utf-8?B?L2lDQVo1SzZBNWJhWUJ5ODhBSnl1SGNvWDQ2dWJpSzdhVksydDJsSVEzVkdT?=
 =?utf-8?B?OFUyVzBLOUhHUHRWWlZkUGxPRXlsbXo4RjBWbVhwT3pETzZ2b3U1SDZjYTdH?=
 =?utf-8?B?eDZDZ3V5WkZ3bnpNOHJ5R3BMdXlmZGVjKzQxYTdtUnVLTVFEQnBLVThTdHo3?=
 =?utf-8?B?OTc2dnNzMkJVa08yUnZGVnBQay9ITVQvT3dYQXdpR3QrRGNyQmJtU3VDNUUx?=
 =?utf-8?B?aHhGQXNJb3RORkF1RkVDV1RpeHZsTEt3UWl3R3UwV0lFKzlyaHhHRi8rQSto?=
 =?utf-8?B?TUczM1pNUmFkbTNCODJGcURXZzdwNUMyaGEwS096d09wazU2VFhiZVNEbmMy?=
 =?utf-8?B?UjI5UTN1Qml5TElEU0o4S0pTNHFQdHQ0RGV4TUZyTk9NdWZjQnhvRUdmTGJB?=
 =?utf-8?B?Y2xOeVZXazJMT1FsSGxwM3NSeEtVMis1T285VDZVUmEva1RucTZaRFhoSGMv?=
 =?utf-8?B?dk1VWjNjOHBCSXMrdUI0UDJ5c0YrVjYvZ3RFdm1HTnkwd2tkRDdSOHNkOXJL?=
 =?utf-8?B?YzVsNEtCUjhRMmljVmZ0OXlGSmtEQmpTSnY4RFF5cU43YXlFRDdnTktIR1Iv?=
 =?utf-8?B?dFQyOXhTeUtzRDNIVkpsdlNQMCs1UURFS2pYSXlYRkcxSXVuUDk1aTF6OVVB?=
 =?utf-8?B?S2RiNFJ0aEFaRUxzeXdnLzZzOWtyN1VrOHhRRHF2YXByRHhZRGV2Q0pleDM3?=
 =?utf-8?B?MkExVEZiUnBRNlovdjNXeDBEUnplRTE5eDd0ZDVCMEJaODNtcGtLZWN4bXJ3?=
 =?utf-8?B?a2pmVytoU0lQaFVyZWpkK0RTRHM0MXlINUY1ekNmNXhjaXcwYVFwRlJyNi9B?=
 =?utf-8?B?elhldmxHczNFbkdBRys0U2hMRElNbzRZNlFMQUY1Y3ZWNnpzUzU2NHYxQlNk?=
 =?utf-8?B?dkxic3M3VytPYmZCZHc2NUZraklxY1dUTjFMYmhoUXlxbnZQaHUyVzM0bTkv?=
 =?utf-8?B?NisrcDljalpPQ3BDZE1CMjN5ZmY2ZzYyUGJraEFhaWp0QTkxSFV5Z2lEbnk1?=
 =?utf-8?Q?jqDI5tJ8hB61oswOyQB82PaT8?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4355a8-eacf-4b17-4971-08dd5fa6ef74
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 07:41:14.5758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LaNn+RdJKIq2ujC5CQTYmA4lOfqPryQEn10QzNIEhzTSchcf5bqOpL6neRrCJHJ+VMg+Qj/5B8F2wm3GsCgk9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6604
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Mar 2025 07:41:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18072

On 05.03.25 11:27, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This series would move /home to the /var/home and provided an symbolic
> link to /home. All home directories created during user generation are
> stored in /usr/share and are copied via systemd.tmpfiles to the correct
> partition.
> 
> This allows to delete all content of the /home directory if necessary.
> 
> This move could interfere with existing installation and is therefore
> optional in isar-cip-core.
> 
> Changes v3:
>  - add Kconfig entry
>  - Add ci variable
>  - fix description in kas file
>  - reworded commit message
> 
> Changes v2:
>  - make move of /home to /var opt-out
>  - fix recipes versions
>  - fix comments and typos
>  - use WIC_HOME_PARTITION instead of HOME_PARTITION_CMD
>  - remove postinst from move-homedir-var
> 
> 
> Quirin Gylstorff (6):
>   read-only-rootfs: Make IMMUTABLE_DATA_DIR configurable
>   read-only-rootfs: add home partition with a variable
>   add move-homedir-var package
>   Move content of home to IMMUTABLE_DATA_DIR
>   Add Kconfig option for separate home partition
>   add ci variable for separate home partition
> 
>  .gitlab-ci.yml                                |  3 +++
>  Kconfig                                       | 10 ++++++++
>  classes/read-only-rootfs.bbclass              | 22 ++++++++++++++++--
>  kas/opt/encrypt-all.yml                       |  2 +-
>  kas/opt/separate-home-partition.yml           | 21 +++++++++++++++++
>  .../files/immutable-rootfs.tmpfiles           |  2 --
>  .../files/immutable-rootfs.tmpfiles.tmpl      |  2 ++
>  ...-rootfs_0.1.bb => immutable-rootfs_0.2.bb} |  6 ++++-
>  .../files/move-homedir-var.tmpfiles.tmpl      |  3 +++
>  .../move-homedir-var/move-homedir-var_0.1.bb  | 23 +++++++++++++++++++
>  ...ook_0.6.bb => initramfs-crypt-hook_0.7.bb} |  2 +-
>  wic/bbb-efibootguard.wks.in                   |  4 ++--
>  wic/hihope-rzg2m-efibootguard.wks.in          |  5 ++--
>  wic/qemu-arm64-efibootguard-secureboot.wks.in |  4 ++--
>  wic/qemu-arm64-efibootguard.wks.in            |  4 ++--
>  wic/qemu-riscv64-efibootguard.wks.in          |  4 ++--
>  wic/x86-uefi-efibootguard-secureboot.wks.in   |  4 ++--
>  wic/x86-uefi-efibootguard.wks.in              |  4 ++--
>  18 files changed, 103 insertions(+), 22 deletions(-)
>  create mode 100644 kas/opt/separate-home-partition.yml
>  delete mode 100644 recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
>  create mode 100644 recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
>  rename recipes-core/immutable-rootfs/{immutable-rootfs_0.1.bb => immutable-rootfs_0.2.bb} (73%)
>  create mode 100644 recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
>  create mode 100644 recipes-core/move-homedir-var/move-homedir-var_0.1.bb
>  rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.6.bb => initramfs-crypt-hook_0.7.bb} (98%)
> 

Thanks, applied (with minor cleanups).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

