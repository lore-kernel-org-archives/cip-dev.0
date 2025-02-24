Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB741C021B3
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 06:12:04 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.55])
 by mx.groups.io with SMTP id smtpd.web10.83026.1740377515603821652
 for <cip-dev@lists.cip-project.org>;
 Sun, 23 Feb 2025 22:11:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FBPL7PZ9;
 spf=pass (domain: siemens.com, ip: 40.107.249.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sOv3dbV+fzPtRmdWn9akXw913/M6ayGdFgKplYYHrRZYxJ7DwylAmE4BmHl1l+1mQE/AmjnJHufpLJv+IBrGpdROiNn2N/ezAQwYe6+VegFIAm7XzQhw7uN/gUpxrTxbMZ1sWZDoR+L+g4N2VoQFmMX273nJPWb5EpBu2DvnsuQZQJraXIQ4IZX/aVNnu/5jtgBLFXoSDbcm/eY0SnreAjp8jYJGy/G0yxFATsMKOG459KgdR7emka+PI2iZgdxhfsxSSf1QYyfOOPHc8Q7zLRHHb3A4JNt/XTUvCg7o06OrE1XRmrEmWK4ugEGx+XQzBowXa8bcuxgBEm1ZJVJoKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6iToZHuU+sb7vNK1FOLknyr686Q0Ukqd3UNRKo34tA=;
 b=CbSbB6p79zRefLPtZ0lXQT9tAC5As2L4eFR5axrNhThfGVIWogxYQTM3bHVjawBlDZ7WCO3ve9uIzY6fh4lJTZDJfVFnfS2AWBhefYHR5qcQ+WCOaLjuvWtgbjxclK9s/DpEn4qfNoosYwXczv0r709qLD1WwnnMyD0YhNLMnsHn35B8tY23/iMeY+cckVr6lmAMiOOQ0FSIcTjk6pBEHDZOB4y5Gh49cq8mna9+UEBtDVh5yNlWDvUlAEE3RjvJT33Zhzkz6ehyNd5QNhv99NXUDwcx+C7RL0m81bubmrVejG6Zh8Us+iLYrOEm0PvBqD78ZoRB/ityWfCHdZRMfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6iToZHuU+sb7vNK1FOLknyr686Q0Ukqd3UNRKo34tA=;
 b=FBPL7PZ9EN9Knrs0WT4CXnNIoxDVsAbfLZsGTMFvx8/u4kbiKL7px4bfsMIDXOOuKbx6eqRK/sv8xGzsAXEI2lFZUFd9JF4r5LneykIy4AryW5Km5rYAtMz/8S2xZkfokp0zId+RVpIYuoQYSQZ1mFKRZklMpdg7xEZVl2sAHiqLIn1EOw6836oid416AZxg05fBZRHVkQA0O9x/IUklxynP3TUDgJ335YCc14of0qAZwkM4oWxPwB8ynWcKSwdY6OaIiCJiaMr6q3Q/wWZWKY4Hq+GOYDh0tO/8fZjVfoWSYmOmFJf1SyjVvvDo/xDejefJIdj4oayGbxtcdroqPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7560.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.10; Mon, 24 Feb
 2025 06:11:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 06:11:52 +0000
Message-ID: <3a73fd27-09a2-4cf2-b4bb-3897807de76d@siemens.com>
Date: Mon, 24 Feb 2025 07:11:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1] wic: Set partition UUID for
 reproducibility
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
 Felix Moessbauer <felix.moessbauer@siemens.com>
References: <20250224044549.2233331-1-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250224044549.2233331-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1f5b2f-9ecb-44df-fb4d-08dd549a21a5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eGd5YlJHZGtYT1UyUi9iMEU2d0Zua3lSajU1RXZEdXhEamlwVVFINllNRDBZ?=
 =?utf-8?B?bTEzdkxjZVRhcEthenlLMHRXc2lmRlA1eFB1Zkt0c2NlaDlhK1RUc1hidm5y?=
 =?utf-8?B?RThBNDJtMytWNy8wa0VRVWFCMW93U1FtSlg0bWVDeFlqbVQwTkR2QjhtZFhI?=
 =?utf-8?B?Zms4eEN3WUVIcENVaVkzaDFWcmlMeUY0ZVM1eGQ1UlhiTHVHSW41K1gyUjh3?=
 =?utf-8?B?SmZ3NUxuVVkvaTkxZDFUY3ZodEgxOWlLUDU3RmltLzd2Z1IyNVdHS0tkSE15?=
 =?utf-8?B?OHNQNXQ3cDFqS0M0NXVEQ2RKdStBa0EraTVPdkg5T1VqS2VyZVZGVDFqWjVq?=
 =?utf-8?B?VWkrOUhja29vdXI1MUtYaGJPTm5FNGhKNDVySUV3QWxBdzdXVUJtM0lyT3Jh?=
 =?utf-8?B?REFKeG1EVFZBS3JIQnR5aWV1WFpWZUVoajhGWnExZVNXTDllb1d1SzU5L1Vj?=
 =?utf-8?B?ZmVwblFuOTd6M1J3dHFzeTdMeUZRaVZhUGRVWEtWWWhWcVAyUmM2a0haTU5p?=
 =?utf-8?B?QW5oOVE5bjQyZGlmT3FDYVJtMVJHRVYybnkrM0EzS1JuT3ZzbnNVeEh3aUpq?=
 =?utf-8?B?emQwYVp3bGR1UnMzNzV1eWwyT094a2czQ25pcm1HMDJBaEZvVGZleTg1K3Rs?=
 =?utf-8?B?TytVSDVCRjFWMlhPWlZFdjVlZHNkOFVpZGFzNTRmKzltZmhPeWQxT1pnSFpx?=
 =?utf-8?B?TWlQVW90YmRBYTdIMDhSemh2eGdQTkx4L3EvSzU3OTBmeEtwdis5OWQ5ME91?=
 =?utf-8?B?QTBwcHpnRy9qNldHY2oxQ0s5VDBpUGthVGZNUkE2Zi9mMVF2bjlnOURzcVNy?=
 =?utf-8?B?bDNaUlBGNkdOay9NbnR1KzRweEljdFBHT0tFMnpCd1E2b2ZwNlhFTGpaTjl5?=
 =?utf-8?B?b0Q0cVJ4SGQ3WFlQZ2ZkdkFodythZW9rdWtEOXMxdDZVLy9nZXRGQVFiZlhW?=
 =?utf-8?B?UzI1eGlwVkZrUXlNNE13bFc1eFl4SElJTzRjcXFid3ljZjMzQ0xWanZqcnl1?=
 =?utf-8?B?ZU5xWURBQzBGd2ExOVh0dzRES0FZRldhY24wOHYwdmlmRVBweTZ5OTZwZW1w?=
 =?utf-8?B?eHVmMk16SXlRTUZyUGZYbWVvanhqRmFnWkVzcjNPbElOZDN5MXpKaHZzczRr?=
 =?utf-8?B?OXdicEZpVCttMVZNRTRIajZjMHM2bE50R3dwK3ZnWkl1Q28xeEprZGROVWhW?=
 =?utf-8?B?RVE3WmFORFhpSSt0N1EwUnN6blBBN0JUVWUzOTRIcjVDRUFHdDVpWjZpeGVL?=
 =?utf-8?B?bE5NS2hoUy9ETHgrbzJmNklwS1c5YzFtVDJaOEhiOFFSbXlkVUJLL3AzREhq?=
 =?utf-8?B?aGNkZHNJb0tqVTFlTGw1ZUVjU0ZxWHAraSs1ZUdRVEFBY1UySmduTTRNNWVP?=
 =?utf-8?B?MFVNTzJFeUVodzFtL2ppZVpnL0EzeGtJd0IzQ3ZQdTEwcURDdnVCSEI3TTZ6?=
 =?utf-8?B?ZmVmYnh4eFNKZzQxbFBzUnZIN0hQcEx6cUdvelREbUFzUWtiTXIzV0kyNktZ?=
 =?utf-8?B?WVd1eVExQ3dBNnpXcnNybU9yaTJ5cjUrV3pTMUVPYmFOOUcrdFFiVU5ING1R?=
 =?utf-8?B?WUNqNWIzM1J0NVJnUjYrZGdiYmRXdGR1dGpkMmpaZFM2U0k2dWxzNmw3NklN?=
 =?utf-8?B?eTE5bUtnd0RxSU1GMVVCTkhleTNsRGVqMnFlVHFFZXhOSGN2VWlGYmxRWVFk?=
 =?utf-8?B?NE5QcEpNMjZRTUhMYlNMd3k3Q1pydUp6d0VTK0o4R3RpTUlsZWVMQnd5dHZ5?=
 =?utf-8?B?R3JaRlJHUkJLN3F3bDFIUmErRTdHYVc5ZWNlNU9tZjhneDU1MzRXN3hzU09j?=
 =?utf-8?B?U291WGxYZkZLeFltZFJOanN6aHNXSXFzMzlOWTVrWDRndjc4VmR4OUxrOTAy?=
 =?utf-8?Q?5uynJv4PyueWm?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VkdEbnZiNUVnVUR4emZzZ2NZb1ZCSEdNRUlsM0NqMlE3WExlcCt1YnQxUHhy?=
 =?utf-8?B?aDN5b1E4cmNTMDZNY1VTL1NZZkRCeXlEV0pVZVg3dlRJV2FkNnY1MzB0WjJT?=
 =?utf-8?B?V1JoeU94aW9ZU09wbWtSK1daelM0dGd2a3oyNSsvM3BhWWVCQ3AvRmpCd3NQ?=
 =?utf-8?B?L29la05IVlpENXN2c0NNc1dvb0NabGo3NEFuRjF6S3JtOXVGeis3dHA2T0xq?=
 =?utf-8?B?UUxDUjZxRG5pdlVZRlNBSG81Y2ZocGlRY3JrMHp2UnlYMllDd2Jtb3FwOW5E?=
 =?utf-8?B?UHNDNUt5bTRBTnFlTkJqejZHVDRWTEJSLzdMQXBHckJ6R2VaUXBjUzhjT25v?=
 =?utf-8?B?NXppeFZqYURiYjZuS08yQU1vckxqajcwQ2tZNEdaZ0MxRXJaM0tYS1pxWUtL?=
 =?utf-8?B?NlBGUTlSTktzdWt0eXlXNTZBUjg0SksyOCs0dmlLYUpLZlpwVHFQUlQwYjJE?=
 =?utf-8?B?a0Y3d1ZrZWI5aFU4RitSS0lHVlh0c3lJUG45YUVnSjdvQlBYK29RWHlDemx4?=
 =?utf-8?B?NU40MHlyWFdDYmg0UXpFODArNHVjcVB3cktaSEl5cExlSTI5WkNjd20vVGda?=
 =?utf-8?B?WG9ZWmtDYTNzUTY4aWk5eHNRMTNwc3NZNlFyMWY3aFV3b24rczBsSDRic2d6?=
 =?utf-8?B?NVFnRzc1WExlblB4K09iZE8zZUp1ZWN4S2t1VU5HS3RTdC9rNEZkL2licFVz?=
 =?utf-8?B?R01MMVdCS25lWDYwV3Z1bEZpdDFrcCtTV2t6bDFsRlVTbUwyaTdYWnBuY0Y2?=
 =?utf-8?B?UkE0V0UxTlk0M3lwanVsUUpqUm9JaElFSEcveGYwbDc2U0hqckVlWkI3NFhY?=
 =?utf-8?B?TE0wbjE2RHI1VXh1bnhST0lyTStiVzlCMnFXSkYwN0dLWmlmTVUxUzYzMUpL?=
 =?utf-8?B?RWdwQ1Q3UzI0OEJGckdmWWZZZmhOa0J3NSt3a1JIdGVPb1pJd3lvY3VuVkIw?=
 =?utf-8?B?akh1QzdaM2FjMnpsWjlxU1p0anpXaThtSDRzTWg0S01yem02V2VmRXlFUVAv?=
 =?utf-8?B?RDVXdHV2UnB0WTZ4dzZhNW52TjN2aWx0UHpsZTBNcEp2TTJaYVdZVG04SEpj?=
 =?utf-8?B?K3NUU3QwN1FjNFQ1VXR6bTdMay9oMmR6SWtPMEorMHU2bnoxeUxnZDBCZisz?=
 =?utf-8?B?eWVHRlUrUjlNTmdVb245M2lVbVFMR2VaOVg5bFhURm9Xb0hNUWhIWU5PQS9w?=
 =?utf-8?B?MExyMy95eUFBOFlhbzA3b29yUm15SnpsZHl1bTFkSEVINGoyYjk3d2pHVlgv?=
 =?utf-8?B?VXhBdFpaenNmOHZnWHlQQThsSTE2WUF5N0pHU0lFY3JRbjdVZTR1Wk5Hc050?=
 =?utf-8?B?R1J6bjZUZEpkN2lVbGZjek4ySmRRZWJ0dm14VlpPTk1oTTZTRDZRYm5lWEVt?=
 =?utf-8?B?L3owZk81OVE1TEkvMCtIOEdSMTRwOTRZK1RHMWpjNlZZVjc1b09ySld6NExp?=
 =?utf-8?B?YTUyNFg4aWI1aysvUVpOMkdQRmQ0a21sU2FZdjRVVGg5TUJrMlNnL3dHb3Zn?=
 =?utf-8?B?WDlKVEJ2cG1ZV1ptd1c2enJ3TndnczVxWitHNklHQ2FWWEloRlRkSFVTVWFj?=
 =?utf-8?B?eGJicEg1OHJVS1BoZHFCbVpYV1c3VlFsZzhaYWpIU1pQVGZnelVsL3JSK0Fx?=
 =?utf-8?B?Uk1oZk5ubHJjaVNJMFJEWDVJZE5DRHg2djMzTVUrYzRjU1lKOHp3VDFUcDBr?=
 =?utf-8?B?cFdRY3poYmE5U3Q5YjJPZlNIUzhSWmtFdkhqSVRJUzVxM2xUZmVWbFphRURD?=
 =?utf-8?B?NDZUSTcwdHVHMENHTitBaUxGZWEwbmJ1OVFEaHQ4WnZIU05sSmtJS0cwY1M3?=
 =?utf-8?B?WlBmWmNHaGxWcUFGU2V4aEplSjJseHpuNWdrNWc0dnZ3NEwwQ3Q0Zk1QYUhn?=
 =?utf-8?B?RHRUTGpRZEpMaUdBRDRVRFcwL3JMd0d4NWlaYkplNEFNV1ZqYStOWCtVSHg4?=
 =?utf-8?B?ZGFSYVNIdCtUVzQxQ3lKSVAzMVlJU2NWeXdIUjdZeFRIMG04WVhCRWE2RmNw?=
 =?utf-8?B?cmw3Mmp1aldwUlI4cDljSjZ2dUI4eXpWcWV1bjRJZTdSOVRFNlFQR3VmMlRI?=
 =?utf-8?B?SkR5NjlCSjNPczUwNlZtUDBGN0IwaWZQc0l0YzNReXJkOVpmbWlOY3ovRkZS?=
 =?utf-8?Q?mOT/61TEPkxkv+ImnsYXInilp?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1f5b2f-9ecb-44df-fb4d-08dd549a21a5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:11:52.4718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpPBAo4f65PUVExslVXc9aM1vCEQTHVRtUJDGz80jX1VQgLqx+5/NCPb5JF3WSy80UuY/brnnAzRii/AXW2sGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7560
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Feb 2025 06:12:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17886

On 24.02.25 05:45, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
> 
> This was previously handled with a patch[1], but the uuid assignment
> for some of the wic targets were removed by a subsequent patch[2] (probably by mistake)
> 
> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/38703cb8e44f0dcdb3a1d7adccd765b861cf1273
> [2] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/1eb0748ac1c7290775a6235f1ff7498d8397c03f
> 
> Signed-off-by: Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
> ---
>  wic/bbb-efibootguard.wks.in                   | 4 ++--
>  wic/hihope-rzg2m-efibootguard.wks.in          | 4 ++--
>  wic/qemu-arm64-efibootguard-secureboot.wks.in | 4 ++--
>  wic/qemu-arm64-efibootguard.wks.in            | 4 ++--
>  wic/qemu-riscv64-efibootguard.wks.in          | 4 ++--
>  wic/x86-uefi-efibootguard-secureboot.wks.in   | 4 ++--
>  wic/x86-uefi-efibootguard.wks.in              | 4 ++--
>  7 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/wic/bbb-efibootguard.wks.in b/wic/bbb-efibootguard.wks.in
> index e6c3e15..6c30a8a 100644
> --- a/wic/bbb-efibootguard.wks.in
> +++ b/wic/bbb-efibootguard.wks.in
> @@ -15,7 +15,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}"
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
>  # home and var are extra partitions
> -part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0f-58904f369524
> +part /var --fstype=ext4 --label var --align 1024  --size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5cacaf153
>  
>  bootloader --ptable gpt --append="rootwait console=ttyO0,115200 omap_wdt.early_enable=1 omap_wdt.nowayout=1 watchdog.handle_boot_enabled=0"
> diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
> index fb3f090..311fbd0 100644
> --- a/wic/hihope-rzg2m-efibootguard.wks.in
> +++ b/wic/hihope-rzg2m-efibootguard.wks.in
> @@ -8,7 +8,7 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
>  
>  # home and var are extra partitions
>  
> -part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 43a29d19-005f-49d9-9108-51ad0861d724
> +part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 7e20a7d5-5578-4ced-a7f1-5ee494dbaf72
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttySC0,115200 rootwait earlyprintk"
> diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> index 00d627d..955a6b6 100644
> --- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
> +++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
> @@ -4,7 +4,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 102
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
>  # home and var are extra partitions
> -part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid e869413d-dc84-4822-b50d-00c5aab7d6fc
> +part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 815406da-387f-4e89-a0fb-6e617605c8c3
>  
>  bootloader --ptable gpt --append="panic=5"
> diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
> index 17434d1..ce6253e 100644
> --- a/wic/qemu-arm64-efibootguard.wks.in
> +++ b/wic/qemu-arm64-efibootguard.wks.in
> @@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}"
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
>  # home and var are extra partitions
> -part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 7346faa7-d6d4-49fa-a03e-82ee469cb1e5
> +part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
>  
>  bootloader --ptable gpt
> diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
> index 1a2291e..1166ea1 100644
> --- a/wic/qemu-riscv64-efibootguard.wks.in
> +++ b/wic/qemu-riscv64-efibootguard.wks.in
> @@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${RO_ROOTFS_TYPE}"
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
>  # home and var are extra partitions
> -part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var --fstype=ext4 --label var --align 1024  --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid e578254c-bd99-4442-bc51-4935cd0ef522
> +part /var --fstype=ext4 --label var --align 1024  --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 0209689d-672f-4254-8b92-566d6d9fd1ae
>  
>  bootloader --ptable gpt
> diff --git a/wic/x86-uefi-efibootguard-secureboot.wks.in b/wic/x86-uefi-efibootguard-secureboot.wks.in
> index 0f4d637..71b0103 100644
> --- a/wic/x86-uefi-efibootguard-secureboot.wks.in
> +++ b/wic/x86-uefi-efibootguard-secureboot.wks.in
> @@ -4,7 +4,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 102
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
>  
>  # home and var are extra partitions
> -part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024 --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid 94593121-6f5f-4b04-98db-39aace692682
> +part /var  --fstype=ext4 --label var  --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 686a2e06-7f96-495b-beac-1731cb98eb0e
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 panic=5"
> diff --git a/wic/x86-uefi-efibootguard.wks.in b/wic/x86-uefi-efibootguard.wks.in
> index 9d344f8..962eaac 100644
> --- a/wic/x86-uefi-efibootguard.wks.in
> +++ b/wic/x86-uefi-efibootguard.wks.in
> @@ -8,7 +8,7 @@ part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}
>  
>  # home and var are extra partitions
>  
> -part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
> -part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002
> +part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid f12faa7c-a9ef-4b3f-b63d-1c74bd5c2b1c
> +part /var --fstype=ext4 --label var --align 1024 --fixed-size 2G --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid be5ae5e0-91d3-46ec-a7f7-c1ebfc0a7c28
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk watchdog.handle_boot_enabled=0 iTCO_wdt.nowayout=1 "

No idea why we all missed that regression. Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

