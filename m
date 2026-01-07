Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CABACF6C13
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 09:03:33 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.36])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2065.1767776610606705579
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 01:03:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iS5Ta8Kg;
 spf=pass (domain: siemens.com, ip: 40.107.159.36, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mw+8aW+q9KB8x3zsBmmmnuHzNMO2i6via9/RGEhSjfmktovQejZkd9hT5LQWcXayEEIOxaXUeS2+OW4RWVptWuUeV+Szjq3zWNaLMvGc7BttlQNdCYSP1n7EhJkuo++WTyxn+s2GhCosxY3HVlnvmP+XnAu22jrj/4J+0rJ1pAYKSFOJoZBBQLBz6/hO72QNc0szMSiB0/mBQepxTcmoOOD/R3m59Bt4UQkRYzchI7rzwI9mioXoY6yFlkiYu+yUGuaOcZSXCsAdnf1audvufmnBViORpjs257HP37su9gAzqWREDDaxaVi567X/CXHHVmbFN518yMtVqltuzNOrBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nWiZ9Bvd1COTGThcxNoV4e31AfgP+5n66B/64xcZCg=;
 b=vE8K/JvuclZzzWk4QJTB2J4H8cZW42YnbG8JJBILw631X5UQJRNxV9jJEqjHHgufhhN3BkJggr4Tda6IGPKNfIxgvMQwsA9LMOSGfZNazdqM4pAg0QJ/83HuNawuEl4oKqFbtMclvw7z3IBb8FbllxlUtdZsL+HB1Z8oqYd+kspj5xvoUSZz3/Ec3qk4NBJwRfdjKVOllf2+HAG2mQOemR9k7No/QdFDxJQ5sAVVZ/+fTqRH31BpKPOaC2oOqhthr7aDzmijU0/n5zjKiWMMEg5F8lPH+wT6CXxJgCdZFi1JD2v6FyDy6KzPujPNWqvo4fVurY1NfctiNA4QTU1ZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nWiZ9Bvd1COTGThcxNoV4e31AfgP+5n66B/64xcZCg=;
 b=iS5Ta8KgCzwIdpHgxiiZVXklfWsE4LmCQLYdg29lmhW9rZkbirbv33XaX6ya2NZUoG0P4E/QPrpZ8gDexXMebJkRxDGmBHYq4e0CgcvqpOJuhQceinejYHOhYWpebwD5R0Qtz7Xhyyq6SCM4TPNdFGE/7EXCeOU9/WKHlzCDovf1ZGMvau7WlrCrYc9PC64UyabET8a0qFikG/7mEtlbvxalLM5hp8PlZrLAJPqDElYAd7t1pVRI9TxiUwQiZsLS3wom8UFaos5bkLiEp+PCu3WMkPZHvODH6z22HdB9xG0YQZXTvNd4E6vAclG8GcBO2IN9v6Aq8F6XUagiotrBKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::19)
 by PA1PR10MB8977.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:451::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 09:03:26 +0000
Received: from VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314]) by VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ec8c:43f1:36b1:3314%4]) with mapi id 15.20.9478.004; Wed, 7 Jan 2026
 09:03:26 +0000
Message-ID: <63f7e0db-c913-46f9-a21f-38cc912c28d0@siemens.com>
Date: Wed, 7 Jan 2026 10:03:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 2/6] Move RO_ROOTFS Options to
 swupdate.inc
To: Jan Kiszka <jan.kiszka@siemens.com>, clara.kowalsky@siemens.com,
 cip-dev@lists.cip-project.org, benedikt.niedermayr@siemens.com
References: <20251219103349.1227710-1-Quirin.Gylstorff@siemens.com>
 <20251219103349.1227710-3-Quirin.Gylstorff@siemens.com>
 <d38b7078-a920-43a0-b4dc-5cf6a5410d22@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <d38b7078-a920-43a0-b4dc-5cf6a5410d22@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::6) To VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:89::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2319:EE_|PA1PR10MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc35644-0604-4942-81ea-08de4dcb9e32
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?T0kySGZ6V2d5blJIc1d6OVloNVNHUE1KbC9NN2dRM1ZEeWlFSWVWeVVuTW5V?=
 =?utf-8?B?SFE2azJmdlpYU0lRa0ErV0pqSElZVEd1RFdNTkRkN3F0N0pMNDAwRy9wTFFO?=
 =?utf-8?B?MWZJanBxZndIOUlEQkZ5V2hxdUJ4R2ZPRUtSR2ZuZ3N0R0kvU0xEVFlZTlN1?=
 =?utf-8?B?QkVHYTNGRis5Mkh5WjVjNys4Zlh3WStHL0FNbmRIOFh2ZzJhOHRob3BJVFBR?=
 =?utf-8?B?OXBFSUtJWEJoS2ZWSEdlZFhnUytOUE5YWExNVThObDZJa0Z1b0ZWYnhESkM1?=
 =?utf-8?B?czlkRXQ2L3kxSVlLT3U2cUY0NUE0Mno5dks5QXl0SW9odDRhanNoTHpWSk01?=
 =?utf-8?B?Q1ZEbzI1b3M0OGtSZEduZnhBZlJxdFdIeVpuMzdJeG1uWVo3dmlHbHBNNmQ0?=
 =?utf-8?B?RlM1MWY0ZFNGL2JJSTFXOFpDbkk3bjlRK1NITFlHRGNwTjJiNHZHVm5iRE5q?=
 =?utf-8?B?MTJCNlRoaHNCNVNVUFdUQ00yMnQrRzhYelJ2bnV0TXEyUmFpRnFlU0JkTHFi?=
 =?utf-8?B?K2JDaW5KblBrR2VZSFhqeFpuQWs0MHVNTWdkYkJKTHhSQmNUZjhWa2pyaU1p?=
 =?utf-8?B?b1NxeWVDemFnRDZMeVZuMHN5UzFqeFNJeStDWnp4cnNTNjZ3dmdYazJSZ1l6?=
 =?utf-8?B?aEdYVEROOFZvcFN1dzdUZ0Z4TEo0ei9RQ1FXVndZZVNkOWkraUtWYmJ0Mm5V?=
 =?utf-8?B?M3JPNUhnWDEwVTBXMnR3RHR0dkxaOVdtQ2ZBdEZkVkxBTmN4djNqS2hGUkd3?=
 =?utf-8?B?VkJSbDJLaDJpUWtaSnlZeGVkRXFmQjVnK1JvSzc5aU5rYXRITDRpTEsxUmZ5?=
 =?utf-8?B?Q1hpaTdpZ0hBRHhWRnZKVEV3bDc1Nm5RTUdBM3FHVGxGdURlUUN2eWFqdEpH?=
 =?utf-8?B?V1d2Y2d0cnp6K09OOFpncndrRkZPcXNzdm1wbHZ1VVpmb0RybTlDQzlCS2xD?=
 =?utf-8?B?emQwY2RBWVJHT2JwOGJ3a3JCdkxOZXEwdXBjcjZBQ0pacGRVTTk3RlZkRExJ?=
 =?utf-8?B?enBwNk1HSGJkL0JjVjUrZ0QxQzhmZU0yaU9KV21pWUgva2Faa01FeE5rQVJu?=
 =?utf-8?B?K2ZlNEl2ZFlOdmNzd2lmdTQ2ak9YZHZzdUNHMENybjliSWRPN3VLQ3FKVk9Y?=
 =?utf-8?B?SEJ5dERkekFPVEhyVENSa0VnK1cxaHBPSzZxTDRiNVYrNC8rZzM1c3Zha0JV?=
 =?utf-8?B?NG1vWS9mWVZ2c3FxbUJ3SFdhTE0yRUdUQzdUY2xiRHMvbzU3TkdVYm9DaUtN?=
 =?utf-8?B?TzFJYVl2Y2YwaWhSS1g2UVB3clZNR1JWeEJFV24xUGVuY2VVczVPSFdBbFBE?=
 =?utf-8?B?UEJGSmdMZkUwRytBcjQ3Z1ZMN1NTOGF3aDNjZFc3b2IyMER3WUxLU1Z4YlYw?=
 =?utf-8?B?Ti9FejBvZHpkZXhsNVdoMHJ3RFRjRGVaVGRNc21jOHl0UVpQcjk5bHRJNEFk?=
 =?utf-8?B?RmpNSDR2MnhpNG1FdUorU2Znai9WU1RQSjJYY2tkTlh6NitPQisrQkRvRWFV?=
 =?utf-8?B?cjNJNVY5WitpNGQ4QXphOG9YMElnWjJ4N1IwMGU5c0gvcExmbHlYdTVYY2Q5?=
 =?utf-8?B?MC93cTNzMmtuVnhCSjg4YTFBKzdBRjVsVTBTb0gxYnlBazQ3cVZtb1JuWGdQ?=
 =?utf-8?B?c2VFSlBtUlJFeC9JL2h2emVWaUZEaHVCYnZwQ0svZURUeU5rUFpGVklHSWM4?=
 =?utf-8?B?QUZPN0s5SUFhV2lvRE00WDZHa1Z2L0YvRittR3A1V2hob1pXY2gyNyswYTNk?=
 =?utf-8?B?aEVDeXN2K1llc2ZSYjVYME9SUU9oWGpac3BoeDhoVGJPdDIvdGhwbHRUa3ds?=
 =?utf-8?B?eCtqWVlibFROVWhndlhKK25tejhGUEhCQUNoZGRBWG1FNmRQdVBBN28wSVlD?=
 =?utf-8?B?WkozcWJDVWhwOUlvZ3NjQk1GM093RTM2Ny9yVGd5alhNRkZTUHZ5ZDdCRU4v?=
 =?utf-8?Q?sB/r9hA9/3ga0/hi3gM+v+fo3KHoYCjM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OEdpNnZYVERZKzJYclpqeGxMSmZ6d1VnVlpGQ2dsVDYwRmxXTDVQMGNDWnZY?=
 =?utf-8?B?YjJySy82Q2YrcCt6U2d4dU1NNFVpa1h5OVZYSk9uU3dyTkxIY2k5bVRYUURq?=
 =?utf-8?B?MVF0Um5NWnpFZVB5dTE0OVd6eER5T3BwK2dUM2pZR1dqL243dDV5a3UycHFj?=
 =?utf-8?B?QWoyZ3FuZ2hiNkRsOFU1SkRrdUp2ZHZUcWZWSERUK3VDMHNNaW0vSVFPUDJq?=
 =?utf-8?B?cGlnT1NkMFoxbG85Q3ZJN3c2ZWV4RTBJYVVBbTg2ODQwUEZZNmdFWjQwYXBP?=
 =?utf-8?B?d1d5SE54dW1EKzMxSFlMSzF2Uk45dDNFeTVJbGIwVFZJTHB4K2J5YW9WcUJs?=
 =?utf-8?B?d054UU1sWFBqbjREWFkvVTFEYUovKy9ybjhwUHp0djlDYThCK2I0M2JFSDI2?=
 =?utf-8?B?dlNUTWwyVEpBZlNwVjEyeXZVM1BTVkhRWTlRRUN5ZWVXdmlBSGhnK1liYWlC?=
 =?utf-8?B?MTBxSHlMK3VWd3lSNzB2RkV0cWRxYlNJWVNjWDVSRTVaUnNkQXJEVlNkd3RJ?=
 =?utf-8?B?dFFPc1hVLzRmRGV0V3lBYzFjTDhuVENVRlAwa2x1NXZ0TGU4ckdhaTl4Q2dE?=
 =?utf-8?B?N0dJSTRJWmRkcXNHeURDaGZSbjYxRllzYWp3a1hZTWJpOW4xZGVVblRyZHZU?=
 =?utf-8?B?SXdZNjh2cEtSYWhWaXluc21XOFVZT1JSZ3hSeS9ZcnpMOGc1aFBmZG8rVjFz?=
 =?utf-8?B?ZW5idVQwUjNTL0hZZ0ZRTDNQSDBvdkxrdHVBN2tYZTcwelg1OElmMGF1U2dG?=
 =?utf-8?B?OGFVVVJzUm8zUEQzcWdmRGhiTnZMZUlXbS8wVHdpdEdjUzUvMVlYVThCVjhR?=
 =?utf-8?B?bU55cE4rcElNU3MwRHRVWUxuMGdhVGpNOWJ6T2htSnhmSXEzQ3FZZ1pEbGlJ?=
 =?utf-8?B?VStVUGQrWXRhMnpPR0h2Y09GR3g3MGlqYmF3Qk1FQThTcEphUDJudXBWb1ox?=
 =?utf-8?B?Z1ZLMkZxSXkyVm9aY1hnbTY5ZUZGMEl4M2hRckRXSXNnRC9DVkd1Y2p4c2FQ?=
 =?utf-8?B?WUE4N0VnRUNFR0Q2OWQ2aHQzN0tULy8ybzc5dGxPQlphaXRSdDJCa2hqdzhs?=
 =?utf-8?B?RmNMbHE3MGNmdXJrYTMxaUkvTUdQVUhOWnoyZmp0dFFKMzljWEY0OUFpaUM2?=
 =?utf-8?B?SzE2aXFrdFJhU1k0NllJNEYweitiWXNLS3NZMTB0V2NNWGhHemd3U2laNXpZ?=
 =?utf-8?B?UWthc0IvdnlpODVLcVY4UjNoYjFmYlJtMFBvY0hMcGpyYjMxZStwQWFpNHVW?=
 =?utf-8?B?MnVqcWt4ZHRoTzhOQm1OTElieStDUG5OUTV5UUZtajhGWDlVcmJiQnVZNHZP?=
 =?utf-8?B?b09MbnlIMitNenNQcGQ1MUlHRGhxcG00YUxXVWJWYjF5bU5QS2xlNzhXeFRW?=
 =?utf-8?B?dmhDclo5dU9kUnpLSEUwM1lVMTQvQ0N2TG1YUWxaYUtOQllGT2ovKytPckRm?=
 =?utf-8?B?VEFNTktCd0xQazhGcEJJVlRYb3pRbzhWVlF4UW9OblhHT0QyNXNRUTJnRjJO?=
 =?utf-8?B?RHZiV09zQ2EreEZsQ2piSVJYZGRwZVRoMlJ4VkZaeWZoeUxGMUZGM29QNDdX?=
 =?utf-8?B?bDJUd0psalE3UnVUbVA1bkZ0QjBRNzQ1eFdJdC9ESzZ6bSttaEUvS2Rkdmxv?=
 =?utf-8?B?YkUrTEcwNVVKelRQa0xCem9MQ2Z5ZVhIZnRLK0tuOXZSSitSUUNhdE95K2ZF?=
 =?utf-8?B?YTNCcCthMW9IS0FYN0RLcGZkZmEzbktmN2pQYmxQMWZKT2xyN1l0ekF1dnVC?=
 =?utf-8?B?WkxnK0U4WWM1NFJVYUxmZG12eXlzWWZnNnkzb3hPM0RkMHRkbjY3THZxcmRq?=
 =?utf-8?B?Q2tGZDlTVmI5a2p4RHlMbXdEdEdCTWNMQlZjODVlQ0sycnBjRDBFYlFXWjdu?=
 =?utf-8?B?MjAzK0orYXZ0Y3lIajJ5QURVRWxsV1RvZ1hSamQzUzhVQTgrSVdGWjg4anBH?=
 =?utf-8?B?QjgwUSt4dHEvdXNpU2s2Z2J2YUdRZVBTM3hZa1ZkM05YZlFzY3ZFUjJLVUN1?=
 =?utf-8?B?eXpDWmVZRml5S1NqSzk5WGxaaHFGbkdLMmQwTjAxZGtlaFdZQ0VtMisvVXVi?=
 =?utf-8?B?L21zcnJDZjlZbXVmUGdxVk1wRmxEMzdXQjVuMlRKNk81anpPMURDdEVqUTFG?=
 =?utf-8?B?UG9WN01aWXZRL3RwbjdheHZTNC9kdG90bEYrM2NCcFRPYkZkcXFoQkRORkZI?=
 =?utf-8?B?Q0RRVmZCMzZMaW43Tyt5SzZBK1U5c3IwVHlreGxLVE5IVExvaHkzTDVERTNv?=
 =?utf-8?B?NlR1MlhFaWJ3QVZ1dzNXeGw0ZmJBcnZ4cUhEcE1Ob1NDNU9kVVozZTVFQ1NK?=
 =?utf-8?B?aXNXeGljcUYxcCtHRG9WczNhT3YrZVUyUHdLT2Jkdjk3dG51ajRJMVFhMG5L?=
 =?utf-8?Q?Rb3S/c5+4Ta9zhk0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc35644-0604-4942-81ea-08de4dcb9e32
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2319.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:03:26.2945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RorJMEs38SvjHf5qEZv+WFT3biZwljVxUeDdMfjLQg9QasU1AcdExS8zHDnXfa/1qQMpasKjjtcsaf9b7tHQLndqNda5VOqwucrVJFhiofk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8977
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 09:03:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21401



On 12/19/25 15:26, Jan Kiszka wrote:
> On 19.12.25 11:31, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> These defaults should always be set and there should not be
>> part of the kas option file.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   kas/opt/swupdate.yml                                       | 5 -----
>>   recipes-core/images/swupdate.inc                           | 6 ++++++
>>   recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb | 2 ++
>>   3 files changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
>> index f1f3f77..4a128f1 100644
>> --- a/kas/opt/swupdate.yml
>> +++ b/kas/opt/swupdate.yml
>> @@ -20,11 +20,6 @@ local_conf_header:
>>       OVERRIDES .= ":swupdate"
>>   
>>     wic-swu: |
>> -    RO_ROOTFS_TYPE ??= "squashfs"
>> -    IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
>> -    IMAGE_FSTYPES:append = " swu"
>> -    # input is already compressed
>> -    SWU_COMPRESSION_TYPE = ""
> 
> So, the scope reduction to image recipes is not problematic for any of
> these variables? Just double-checking...

Yes as we want to set these variables only if the other A/B rootfs 
variable are in place. I am currently inclined to rename 
recipes-core/images/swupdate.inc to swupdate-ab-rootfs.inc and leave a 
symbolic link
for compability.



> 
>>       WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
>>       ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
>>       ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
>> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
>> index 75be566..696ee7d 100644
>> --- a/recipes-core/images/swupdate.inc
>> +++ b/recipes-core/images/swupdate.inc
>> @@ -12,6 +12,12 @@
>>   inherit image_uuid
>>   inherit read-only-rootfs
>>   
>> +RO_ROOTFS_TYPE ??= "squashfs"
> 
> There is also a default set in swupdate.bbclass.

Will be Removed in v2.

Quirin

> 
>> +IMAGE_TYPEDEP:wic += "${RO_ROOTFS_TYPE}"
>> +IMAGE_FSTYPES:append = " swu"
>> +# input is already compressed
>> +SWU_COMPRESSION_TYPE = ""
>> +
>>   # read-only rootfs with /home and /var
>>   # as separate partitions is used
>>   # /boot is excluded as an unified kernel image
>> diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
>> index 9d53394..076f14a 100644
>> --- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
>> +++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
>> @@ -11,6 +11,8 @@
>>   
>>   inherit initramfs
>>   
>> +RO_ROOTFS_TYPE ??= "squashfs"
>> +
>>   INITRAMFS_INSTALL += " \
>>       initramfs-overlay-hook \
>>       "
> 
> Jan
> 


