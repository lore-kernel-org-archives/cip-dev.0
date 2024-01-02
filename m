Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97629C46CD2
	for <webhook@archiver.kernel.org>; Tue,  2 Jan 2024 12:32:47 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.65])
 by mx.groups.io with SMTP id smtpd.web10.27747.1704198766226360784
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jan 2024 04:32:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DJKiFTie;
 spf=pass (domain: siemens.com, ip: 40.107.6.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwNGVVcuQOSFubn4PCjBJugXQK8NbMBjziRu4X0wswGwu8h2iuexH70Nd5AfnVw1NvMo2hXSaxqdHYsjR3fpvtrtXJm4fV/UHkeLS9QlSLa/uSneVzvh1nPboRIHzObY3e9Rnc2nwVvsuir1zA81m57kAO14KJtw1EsLD+fbHInOXjxwno/sbOdMv/AoJ9FZNYdUUPtLiyxJmSeJCNs3LxoHCJ2Iiur+DnQdX6kVjE0vEGjR3OtbI2NXZqCx7iUZNq7ZiTFj9gdfXgOLbwoMBRTNK0zJg3wzCAgk0j1jy+gDM+bBw5ELlAybQyw+D3mvfnrw3xIbfzzv03a9eb1qEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KjvIOhcB4KqqCzgGfLjPFuizv8L7B80grJZOcbrtCg=;
 b=ZmkF54wySiEgxfLnsCB72rxNPOGDmLAGiw89xxKRhaycvQ2Qq1KzUs5Vkv1XsBQLwDJ5YrY5HUrIwwooGV+68cIzAn4DcH0hzS192TrYWrJegBt35BAh4IhenUncdJa9Cp6n6koYWauHdh+fCp1rmNZne3QXuktUnCfFl60FlMOaWVV9lYEyXyzROIHXE4jW48kNAWwrfR5KWLmMnqgVUXUxbMTTv/xSvD5aTltIQPGryfW7yhfY4lth3qHREPvYdrWzMjf3bG0aAQSV9tTrbQONE83FVm5DSQ4pytrOEV8sjpYMpnyMaLOGngtkL2DfLOlVW5eVMbHnVWzG6IhY8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KjvIOhcB4KqqCzgGfLjPFuizv8L7B80grJZOcbrtCg=;
 b=DJKiFTie0kEOarba0dGuZmX3cPRlyvWmwB7rpUtgbT9Wj5ibSJbLxeKIbaHQAmBKsRciv517u00hDnJrY/CQd+RsfiAMQ7g7fdCZyoWunWD83hpkRCMCSFGjv9zmF9P+mUWaMPtU1zEvGNtvQqYyYz4FUB2Xp2CZ+3wpxYouZzJJRE5um9sqnx266ZqXzuvkRNjqc8iZ0Totrl2X6gx6AIl/8LsP4TpsQBWs269OZMDjCW6Rq7wwy2X2g5Bqj4o4NQg3bS9n/1OdyRfepxCPbmQpLPaEbyRF1FCBQGhNJ7TG0BJErDvVTb+NPJ5gpFPsuZog77jSoeOrb8LrapazfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:634::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 12:32:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 12:32:39 +0000
Message-ID: <bc11f976-b2dc-49b2-9af6-35d45f1ac71a@siemens.com>
Date: Tue, 2 Jan 2024 13:32:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core 0/3] Generate CVE-reports during a tag release
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20231221120423.2388639-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231221120423.2388639-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: e96bd045-c6e9-4c39-649c-08dc0b8ee8bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5jfrUkt9ymAQJeq05jCzP04OUDCNFj2bJrwEdZbZj2OaaXmUk2HXMihJGSUPCgWQ21PZ76LbOaA+8H1v0fbDtQFiC9A9DhlHUh7igMUqlzFtZTklgQmZql2DJ7+RRsm8uGQv6s505ihGTyK9fsZJ+mscroqZeQy0CCvg1vQwrj5qAigemguTC3kJ63p4SBNe4cyX5EEfanZ+PVe1Eive9ldIwB9Uy9UqLQLdQ6bsARlqgYM+JiCY7T46tuKbCW0zI9v1NNGLgjvStztZ1WjBVgF4VrBauf8ZUn1JNbttt9neR7P1Jt7ojiknYQJTKWvU7bn8uPkqB6N/CsJnPS/DubxC3MV3ih/HJMMSkvc0h5qM1spVTVW3+s+aZh43QYFEFc5F+O9AeD3GRzxn5G5+LwtjEOyAkXit/qL0WS6qtGZ5z2+C4QCgUYdfb/tuwRvUb5XbweCytFjNgZrQiUf7NRBipLfPneCs6whZOHs4OKKoUv2m1cbjSfvXHS6WGTrFY32vb+oD8zjsgPi4NyegzZKVxdMRMQJblg8PLXs36R2ZAXSp7eGgYSy3IgMKDlXIoSkAgUTK8psVs79y3FgAHiyiLMZINSFRZeRlFM9ZX541tDOC3asVs4YouDKyAYUx43bHpNFkd8UKW37KzvKAhszyrtcGwiIVNuLp8gt0CzkdL0Xuaj3OiV+OKepdpfjuNt2gKIaFby3w0sreSyrWOw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(36756003)(66946007)(66476007)(66556008)(53546011)(6512007)(6506007)(6486002)(86362001)(31696002)(83380400001)(82960400001)(41300700001)(38100700002)(2616005)(26005)(2906002)(4326008)(5660300002)(478600001)(44832011)(316002)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QzJmN1JiZTR4S0ZrZWtUWVYzeXdVZ2wwM20rdmRpWGhPYmRGUG5RUTBiME1D?=
 =?utf-8?B?aDBKU1NFSGo4NGFuUDVpQjlFTjVuRTlvRWNrc3MyUVhKRWZWelhQaGpudmNo?=
 =?utf-8?B?SG96UjlWclBWQTY3dWRaallhekJQUzFNWVhpRkE2V1hLUkY4dTJFU3g3UnE5?=
 =?utf-8?B?YnNaL0xkUkRGVFppaHNyWnVjY0xhZTkzYUhjWGVvbHkyek5aTGdOeXNnQ0V5?=
 =?utf-8?B?WFN2Q091UU8wN05YcVlkMXZTSmdRMVpaL3RqQjllbzhlUjBEWGFnaWtMZkUw?=
 =?utf-8?B?cjE0c0hZMTlYMTJDMmFZL2lXdFRtRnNRNlRmNVg2TzBUeWhTZHVIQlRUVU90?=
 =?utf-8?B?cWFTK3pYRTVOWk5URFNKUThnRzBRQUZuL1BqcVNnRjZ6WExSUHpNSzMrYVJq?=
 =?utf-8?B?WWhOMG1MenRYR2RhS09SVUFyTEZDZVlCL2JDdUh2aCtSeFlUNVhONzZ4R21N?=
 =?utf-8?B?a1p1VnN0dXAvK0NVV3d4a3FvaktlRzRlMU9qNkt1YmpKUW5ob0RTcUFxR3pT?=
 =?utf-8?B?c1d5TnZpYnM0TjJaZWp6U3h1WDkwUDdZeHYvb1M0TmRadnlkWmNuUllmcTFW?=
 =?utf-8?B?WGNKOWVHSU55M25XVzRBU0RyWFEvL2R1TnlpWWxLNGpwQnRyS0VnL09MT0pV?=
 =?utf-8?B?aVdHbVp4Sm1abTUrc09NdWZZdlBsektUa2JnWVd3QlJCTTQxMC9hUmRsVk8x?=
 =?utf-8?B?ZXgrL200eThPS1FDa1hVcFFuZkQ0S01jR2Y5b01xcXFVVnpqc3NBckdRenJq?=
 =?utf-8?B?Vi9kUjVGRlFseHI5amNMRWVIRjk2TDlycGdLOFVTVUJERnc1M09BOEZzMGg2?=
 =?utf-8?B?YkVORUVGazdJQURQcWtSeU83WFNEMllnTytIVWJLb0FBQU4zZ2Z2aUVqNmlN?=
 =?utf-8?B?bnVmaUMvOTFrQU13WGVNYTlmVDhLYWx6aGVBa0llR3hnNWU2OVJBZ3FsZXVh?=
 =?utf-8?B?SmkvclE3dGZWWDFtbk5VejRkOUFHMjZxeGU0TFRONmhkMXlWZHh4YlUrSlNa?=
 =?utf-8?B?T3lrM1crV1BENjV2WHdUcjExWDhhajBKNUNjdWZXSVNYQ3NBS2hIeFI2eTdT?=
 =?utf-8?B?R0F6b2tkSCtRcEp3ZGQrV3lhL1RrdkNGN0xyVkN5NjdvNE5yTit3aEJhNmZC?=
 =?utf-8?B?cDJXaW5wWDAyUTBKV0pkVmpzTTMyV0svbjlveDZhRWVBTHRqMmZURTZEK3ZP?=
 =?utf-8?B?a3lwM0p4MkdEeXNaZlpoSnRkRStqc2d0bithSS93eHZGSVJVZXRLNkI0bGRW?=
 =?utf-8?B?OUR3YklaNWh0SGtBY1hZTzdKTTk3YlhJaG83TXN2TWtKQ3luNlhkd1dsaC9G?=
 =?utf-8?B?M0liWUVReUROMStFNGtVYmVkTW9XK1JNY1NCeWlOazJqcXUrZkNwUVA1Zm1D?=
 =?utf-8?B?TG9kZmlWdVFkdXpobW5QZlVKM1R0LzF3Q0NOM1ZJbFBQK3FlVWRGd09ISXli?=
 =?utf-8?B?NnFUcE9zVDVnM0ZueXdQeHMyTVluR05JTSt0eDMrYTlyWkdMN1N3WVNEYTZF?=
 =?utf-8?B?dlFOdUdOK21oZEFaeGpkWnhWUnFPYkdJTEFtTmZ6RmVXVnpwQjdSLzdkYUVo?=
 =?utf-8?B?TVpOU0ZYMnNTQWVTdmF3K2ZZaXpWTzcxQjJBYmgvOFZiM3BJME5GTXBJcHp6?=
 =?utf-8?B?WnMrd05QVVYrYkN6YWhlVHF0ZUljSTNXdjNWc1ZaQjRKcksvTUJOY3ptU3lF?=
 =?utf-8?B?TmpSaEJaVnJKYmlSeHM5Y1VJc2V3Rmp2SzdVOE05alhEYTFOMjUxNDIxR05n?=
 =?utf-8?B?N0pFTGhCOWtkcnJUM0ZkOWVic1gwRjFIWVdZdjI0eXRNWHBoTW1VL0dPd1FE?=
 =?utf-8?B?MXBQNndOcnZ0M1lzY04zZS81emllN1JpQ1lmYysyTTNObzRYTXN0cVNucURj?=
 =?utf-8?B?bEh5T1BhcVZiQ1lReGtXbjE4WEUvMlVDb05GcS9ka2Q4eGV2TmdFNEhIak1W?=
 =?utf-8?B?VnJieFdoVytscnBheW05OXBTRHBRZkRDSGhpQ1RMUzNhZEE0WXJrbklJT25B?=
 =?utf-8?B?RlZDTGttNGJsQ0dTTVFaRmtHbldNZGF1c1NNMC96blBFQ0ticW9EU2RPbnQx?=
 =?utf-8?B?VlhIbmZGclhzdHBWNHVWdE5oWTAyNkxkbklvNnRER25ZNXJnN1RFSkczbitM?=
 =?utf-8?B?UHdHbGdkTkVvTFdseFAyc2hoZ3B2TjVjNjY0bWFIZTBSZVM0MndvYWdOQ2Vs?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96bd045-c6e9-4c39-649c-08dc0b8ee8bf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 12:32:39.9210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEC1gf/Oc2Xm37OLk0kL5s1DWeYESg6U0i5iyTSZAWCQHTIhoHWnUd6Nn5emaYmzSAOExpd/RKbrYmI8ICCu6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7683
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Jan 2024 12:32:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14224

On 21.12.23 13:04, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
> 
> This series of patches enables generation of CVE-reports from a latest copy of
> dpkg-status files stored in CIP project's s3 bucket whenever a tag is released.
> This is to follow IEC 62443-4-1 SM-11 requirement where security related issues
> are addressed along with their severity prior a release.

Will that mean that users is CIP need to take Debian packages of that
day when isar-cip-core is released in order to benefit from the
(pre-)certification? Won't that get us to the point where we actually
pin packages to specific versions to make use of the argumentation?

If not and if this is only about having the processes in place, then I
wonder why this series not only ships tools but also tries to apply them
on specific dates.

Jan

> 
> debian-cve-checker repository [1] is used to generate the CVE-reports from the
> dpkg-status of repsective targets.
> 
> Sai Sathujoda (3):
>   scripts/run-cve-checks.sh: Add script to generate CVE report
>   scripts/deploy-cip-core.sh: Upload dpkg-status files to aws s3 bucket
>   .gitlab-ci.yml: Add cve-checks job which runs when a tag is pushed
> 
>  .gitlab-ci.yml             |  7 +++++++
>  scripts/deploy-cip-core.sh | 12 ++++++++++++
>  scripts/run-cve-checks.sh  | 40 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+)
>  create mode 100755 scripts/run-cve-checks.sh
> 

-- 
Siemens AG, Technology
Linux Expert Center


