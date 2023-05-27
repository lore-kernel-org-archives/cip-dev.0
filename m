Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AE6C77B73
	for <webhook@archiver.kernel.org>; Sat, 27 May 2023 17:01:21 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.43])
 by mx.groups.io with SMTP id smtpd.web10.13769.1685206874185336709
 for <cip-dev@lists.cip-project.org>;
 Sat, 27 May 2023 10:01:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ouMAm+do;
 spf=pass (domain: siemens.com, ip: 40.107.14.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgNb8NCrbsBK8PfaQ4tWrJ/CTej+fMPKCFiZG1peF7Uc4eF+llmCDGPC/fFQd3rUVelkr7yMjbA1edH7tO5OeQTuJ/yFxEhv4M3DS1ttFsQbSpufK0cyZ2N94bkiJZLsWuN7sA1u1YTNNAzvZpDGYHDRx2gyAQ90p8ec2s/BUNTSaAXxBexTvUYLBK0YI4bCb+VZSGq+EXU6Skb4oKgSSq08IQ9GFAidWBU/atdigBd375shBjSxB/hZvPtIJmXJX2CAZTnaCF9SBo9uw2zqzdO0culrvq15kYnIMWTocylfZETJH2IUB0bK0SRjWChoifRe7hMFx5K/RRRoiP96EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sc8l9vj0+Em5DJ9ZGQgNPybjCVXOy/pGRcXBxF0TCw=;
 b=LNcQ2xbrQWRTPM60lUexU45Gpp7WGpBor7ITVtOeU+yeuqSePBt496ELnwp+lZVlYBegVtqfGLRVpPy2HIPD9IIKWtN9hAmrHsc6kE2SgIIyjVBOpzv3AFj+4V6zkow6ElZJPyWzccIDzv64Pz8rDwMGOsyf64NCtfnXB0XxMv/qTIgkjB5I9EwRvZ0sQfl4UCwuLT3rqde22AkncqSeVMPVpcU4d196wJw7MC+maj/+e/RDiidfMDyym67kn+e6cId+AciaNrPDiVIe3hkqwNeU3Er0tdsEPZ92qyDuweG0C+0DyC7FzVDs4PqURuiyCZB/aUq7hYOY6ZrZuqLHUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sc8l9vj0+Em5DJ9ZGQgNPybjCVXOy/pGRcXBxF0TCw=;
 b=ouMAm+do5gr0kaGwi+QRZcm2XWJE9LrrcYZXVl+FeGVP/C/jO/+OldGcfZREZ37SP1b4Mjk2FJEESUZq4I/tcY0uIxUKUoWPWgtr3FKo6naWzgYe4TeLhYb8P40mMe1xmGONQ0jpWDTYYXJYyAntcd1fb9y/3lNsFMjoJe7ST9BhJZsLjdt9dKx2sav0NYeO37qPaW14aJ5p+4VAotkTlQh1TxNG2rmeu12RFftwk+/I/vPbjDVQvq1jCJ4xVoeiSeBG3qQYNhHHtHIXcPV+AuA7DOgyFBCYK5v/7pmn0JZcYX3a9taTluXK2ZCWmkE+EiO8DG/pGU0qsjaZwMECmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8196.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Sat, 27 May
 2023 17:01:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.018; Sat, 27 May 2023
 17:01:10 +0000
Message-ID: <2abda6f2-56cd-8104-9b0b-468f624340b9@siemens.com>
Date: Sat, 27 May 2023 19:01:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core 0/2] Test different artifacts are bit identical
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230523135611.31234-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230523135611.31234-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 354ca058-26ae-4fe3-ce58-08db5ed3f888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ssbs8NniwGW/qg9dxIcfmspseY2UD4rEgzeLYNBdnubb8YMaBGGEygw3oTvmZ4gtiPyeFq3scChYaSA9sjU9ZPqlRqjddbxoWEuKMWh7N+RJfmy2qFFtMPVeuW5tr68ayXs9U8JZzpKS7jCFYzTZDtA5LiTlChjdHdkzjnk5ElKFCJ9HqYwyxPdNfkI/Hdje/6DObAz31QWgwHgPJPMCpFpfXeXYLoSMLr8e8Lx76B/sn/gqxo8GtlMnjbO6RCknXfmspZrG7MuX/EK8TlJwPnTV/rz1fRMN+gzjWkPkPMO6n4MFHm9UVpgkQ12tmbr0CwZFwuifowWPz8/Xoq8yRVCfj9ksdtZYVmJ+UcJO9yHOLll+EzlzhpNTs2bUb/3QqnLSfcgkcKwEwcwRPfUWvOpXZsQ484tVRkOALi5gkdVK8F/gscXwU6q/+Q2ZHMAChG6wj27Ai7NRab3yC9/9OMwBPbPSxxsF8HQLQEqYKYjatyEniehpmNEhmNAg7J4351O7oPfl7waQk6eveo1j8Ovlp82tUiqv7EJKpwNPal2kLWGZlOPSPTkzJmiGqx/WSWA4QeYmG2NdAbtmcwCRU2VbbzV+jLbxdL7b6eHeWC9LQYm342yt8Ds9sqWV+AGJE4HfiY6UG1au65fBaISb+w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(86362001)(2616005)(4744005)(31686004)(2906002)(186003)(66476007)(66946007)(66556008)(36756003)(4326008)(82960400001)(6506007)(53546011)(26005)(6512007)(31696002)(83380400001)(44832011)(8936002)(8676002)(5660300002)(38100700002)(6486002)(316002)(41300700001)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UXcyUGZKUitGcEFWRm9jM2RiZ21DTElnNHRmaFhJcjlBdGxyM01jRGRQWXpW?=
 =?utf-8?B?TitsTmRaVU5WV1lHOUVnNy96SHkwZzBrblBYVGl0SGxFVkF4N3FQbUQ1WkFs?=
 =?utf-8?B?S3VSSUVhMzBTeUhOOTVWcnYwTlZTeUp3TUo0NnAwNDZuSzNOVnBHKy9SYm5p?=
 =?utf-8?B?bFhQazVmWmlVOHppQzVXVUdWS0xlZ0xna2RlL0tPOHA3NWZLWlRMRzVjcTh1?=
 =?utf-8?B?WEh5dEpjU2Roci9yYlhVL0xtZjhhbUhhNmd5aUpkMXZ5b3VqNFFNMUNLSG5a?=
 =?utf-8?B?anRCZkhueWhUU2xoVStuRDlJQi9vTzZjYWNnWTlMdmdZTERYWjJ1eFNvY2w1?=
 =?utf-8?B?Z2Uycjg4dGpDdkZrSEFNRnFnbjZ3c25rb0NVUEMrZlhuc0tuQ1dReGEvRFVP?=
 =?utf-8?B?UXBQTFdHTEVLT1crdENTU0cyOHpQMy9IZGV2eThYNjFWZnRVQU13WFoyZVIw?=
 =?utf-8?B?SHp6SW1HTDBBdEFYbFhmSy9MRDg3ZGdzWDhhL2V1UUJ5dmhGYVNDWVlCaXhv?=
 =?utf-8?B?RVo2RE5tUTY5dE9iVndQR2EyN0N4YzhwdDh6eUUxNVhrOGNqZFovK2JJdk4x?=
 =?utf-8?B?c2F3MmtCTDVSNG01VVByK0JsMWtLcWthR2VFUUk4V0xtTzg0cXE2UFZCZVd1?=
 =?utf-8?B?cjJJSENIck9qREZoVTVSWXZ6TllNS1EzNUk4dWUwQlN4Vy9JRmJETjcrSS9T?=
 =?utf-8?B?WmNPRndSaStSK0dPRW8zNnViTEVGM3pNZDQ0S0o4WnpOVng2LzdnTFhTNGRQ?=
 =?utf-8?B?QWhqRWdSc2x0bVZtdlF2c0FKV21sWHVEZTlOcVRSV3hQWTFRMTY0eTJZVEE4?=
 =?utf-8?B?WGM5QkJaOU94ZzBPaDZsdzltSndJQVhlUkpKanZQRkY5QnBWNHdQVVI5eXJv?=
 =?utf-8?B?NlZJNnJpcFZYalhsU2lyQ3Vvb0NFZ2h4dmtLNXZJZXNlRnN1dHhyK1A4YmQ0?=
 =?utf-8?B?Q1hMUGdWemhZVlgraGZ0RXpvVjU4QWJXbVA1SVFiSUJJN2g3U3EzaWVGbnNR?=
 =?utf-8?B?KzZUc3VLK1J2RWxqRVpJQUUyaE9WQU4zS0U5QWtQMzl0SEQ2bnh3SElkQ0R6?=
 =?utf-8?B?cllFSkt3cWZ6eEd1UHo2MkdLZlJxelpISVdFMW52OVhqMnkvRXZyZkJzRk54?=
 =?utf-8?B?WGYxT1N1YkRyRlA4MTlWK0hSK2RsdUhndGdEWnZPZTFISTdia3pzT1YvL1VX?=
 =?utf-8?B?SEtCV0p3djdkZkpuZGozZ2RSWWtPcDBqSExWUHZvQWJiRXVraFlJY2J0SnpN?=
 =?utf-8?B?MS80YnI3MXQ3d1NhNDJ3dGpKTE92VlhoSmQvUmxDLzZXYzNqMmMxMXVlMXBK?=
 =?utf-8?B?akNXK3B1THRUQkVKRjVtODM3bnYrMHBrNGpOdTFhd0svU1hZUEJ4Ry9XNzFl?=
 =?utf-8?B?eEpFclBpeEJ6YnlXc1BvQ1owUDdXQVlOY0pXT21TRXdtclNlenRxSE1uaGNp?=
 =?utf-8?B?bmlXbHlUVVN6MWk0R1UrNEpvdW1BcmRMOEwzeW9LTWE4WVZqWkwwRXBIQ0g4?=
 =?utf-8?B?Um9uQmZpbUFrTGdxTVFrOTNsSnI1ZHpMZnE4ckxvdkdkTGJ6QkNaUTZwK2xk?=
 =?utf-8?B?cHFZdWxUZUpjd0JTZkpwNEhUV0k1REswWDBBOVZwK1VKcHdobzAyVHh0R1h5?=
 =?utf-8?B?Q1c4UXpuMnVhOGJVYk5uMTlHSUJreUtTek5zS0xtODB6K1NmUkZaYzRuaDhU?=
 =?utf-8?B?Sy9xbU9WNVNXc2s3eEs3bit0WnhocjRYR2RJU2VGMDBKdkFYWUdJeDNHbzlw?=
 =?utf-8?B?UWtaZU9MYkJTUzBVZE5vbWN6TDQ5Yjd0Z3VwZk5rTzNiYWZ4eVZmTVNTRDV5?=
 =?utf-8?B?eDFxblVkK1hjL2IwQ051dnZWRmlteUJZa3lRR3g3RzdoRWdzZVlmNWtlZjNH?=
 =?utf-8?B?Yk9YVVJjY0paczVtQXJEanFiZGxNd0Q4eVNNS2JCQjl5ODdoN0U4QTFmdVd3?=
 =?utf-8?B?ZGVmaTNmdVdWRW1iQXRibVBka2EzWHRTSG1YYU5yOFdxTllMWG13SFRiTXBP?=
 =?utf-8?B?Q2R0Rmc4VTVhTWFrV2ZBZjZQSTh3MC83RGNlcWNrK0hZTS94TXk4NjJQS29w?=
 =?utf-8?B?UWxKaVNKcW1iZFFiaDdMTGZmamJmZlhObGpUWU12ZDVtcmtTRVI4MUlGdGZz?=
 =?utf-8?Q?uvwU2wzpS00lp4v09l0Zwgzbu?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354ca058-26ae-4fe3-ce58-08db5ed3f888
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 17:01:10.6575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SnRN6wIwg8v1Eeg6fw3JrahaxraGiYnXfQn9Hpo/pq1lpkK0ZrypEq6B1zzHDSCFVF3t6Wc0HAlULOjyeS/p+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8196
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 27 May 2023 17:01:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11669

On 23.05.23 15:56, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> This patch series enhances the reproducible check CI that include
> different artifacts in the build image are verified against bit identical
> artifacts.
> 
> venkata pyla (2):
>   scripts: Add script to test different artifacts in the image are bit
>     identical
>   .reproducible-check-ci.yml: use repro-tests.sh in the CI check
> 
>  .reproducible-check-ci.yml | 15 +++++--
>  scripts/repro-tests.sh     | 91 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+), 4 deletions(-)
>  create mode 100755 scripts/repro-tests.sh
> 

Thanks, both applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


