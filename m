Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F62C05027
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 07:36:30 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.51])
 by mx.groups.io with SMTP id smtpd.web11.18123.1675236986709674327
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Jan 2023 23:36:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=D9ncYc3L;
 spf=pass (domain: siemens.com, ip: 40.107.6.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1vLTZiTJgZRXYQ7fbDxSOBlz8JixlRkRHK2z4i82TcNdkwRUbXpPWDGUSpZsgDrxd/Js6oMZ+rg9ma3hzs1iUWqAluj5tck9Jxzewp511g/vrmnAmDFE6kJ5WOAIP3cUvPwRF0QMPJnr2OzsbdtYNku5pMmX9a3RmistnAspZw1PswOc+p6wC9tpOUtB89wsYCFDyrmnODWzytUJv/R2rwzRWs0UYy/3QZWlvJYgUQXarjM7jxm/VQmxhzLXl6x+3bfXxA/XUdVi5PNOYB3NPHn6GXUBgr3v7WMwLe/8l0AiqfHjhFR7utAbv0o6ngMjqFNiPrxZj0Sf1iuwOBnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7nt0igZZmuf0X01IZw3J+AU4O09YHZYNurP/IIi0tA=;
 b=GU+5tFhBL8N2DHAH4aY6Q8yMGLP6fsv8v3G23AzRgp6fVa3dcimzDMmnHsQuk3BO9lFbC4fkKx63gzN7sJsTBYYOVhcyDslkiAcQnG/DbxI4/mf4dFvHAYkOHl/giEyHzBoHhuCNkbijpQwze2PW8TsgzdtTnIZWPI+6AxWZW6gKQgfZbmIhQ+iO2pgnaZzOoKbPT0w6i8o9/mjpzL5WYkhPcjQUWP7TWVDV28JXETBaWw4kYVwtBBVnk5NvM26Oru7OXGO9007ZCx9PuRGrUm3Cybzp3KIFHaunBNKk4GCnh2TKDMQVRYo3dHo7a5cn1rSX5wC2P2fIYvxMM2R/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7nt0igZZmuf0X01IZw3J+AU4O09YHZYNurP/IIi0tA=;
 b=D9ncYc3LtyK/w+a5jPu8i63yK1SgqpYVpe3LG7mJONk6RXMPMXgLavq9Hp4au+cSkiuwV7MHnjuQmsTQX+Lcc7WxwefXVpDGXhG6o++RRl0jpEiCGyMKQmk5ujAed9t/Reedu2KvUx1e4o0Dsk5XGl3RBeF5tyNNjQcOrO5RdS1Sd2ilYPuEi/geR9FSHnBCzEE8bBB/5lpv/O7j3+CrW7puVgqwynz9ScT2L5TnQLiCoKzx4Xyinnh6pi0vNtY3JqLuxY3VwhdRqtGuOjATopGZjGQPRkkfkW8pD3xCdiIrQelGvnsK2PpjtEOZ81PxJC7PAhWsp4UxvtSRO9JqDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5536.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:320::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 07:36:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Wed, 1 Feb 2023
 07:36:24 +0000
Message-ID: <a45a8fa0-af8e-4f3c-ab11-c6e5bb771cc1@siemens.com>
Date: Wed, 1 Feb 2023 08:36:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: How to overwrite IMAGE_FSTYPES variable in loacal.conf using
 placement of kas file wic-targz-img.yml
Content-Language: en-US
To: Venkata.Pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <OSYPR01MB5542AD9EF2424FAEB3FE588AA4D09@OSYPR01MB5542.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSYPR01MB5542AD9EF2424FAEB3FE588AA4D09@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5536:EE_
X-MS-Office365-Filtering-Correlation-Id: 08edc94d-6aad-43bb-cf6c-08db04270525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zgvhJl61R20rmAfQlbcEIo6lzf1YcpEc+D8PLBvCvBZO3Nz+9dJnMb9QieWzO8JCYnPPkQX+31ND53/lfo5IVHLFUZD9+QjkaBm4ckWYKRe6yuEhTy/lbQ97GwrNF1rfKWlzm9NA/av5VuIzb6bm0/ogmsg/7d7qzjjxJeCnMT36owpV7jFjz7nX93FbpF7YFECxiY8Q/NOvkjNelEC4Q0tLdjdPGnWgF4HC4E5N1N378bULNX9BIUJzzN8mdQtf/x+ajmumvfO0H3a8lUO8VCpQsjO0HjTcOY2AAjZhDfn6V03RPw9DL2lnowQM8xMWS84zGbiuZwpMw4z5+h3pNTTpqj6aTcMZx7TKmNB/ynyM9z7SqRfsvxAxKdoTUU7Fqxuqshx6+LJIK8bzaPN5NMlOncSAw7+3peNnu/JvaAjUnHD73Bd2R30TQNzaxuOWdrW3u/Kd/s+QS0rVQPPLORXDjFiQqWAN+FtGn3bPTp4qH0uouP7mG1ki6Y2qljQC760cN5WC/7mF4zv0hJpf0DQY/5lAkbShbli1xCG3xYTNvxR6FCR4S37gOxvLsMpCDELGJwP0cvYdATpZjXZqHF9yWaS6VoZVVnlIXlL9wnzde2/J/D88RIhsWQPkERhCTzY/xz9S4AxYR7s8+upt2zzqmmNN4R5RhtKSNy22JA9EKCHE+0If3AzM5fdDeBRBxqSsQ5aTG7ixbDahVe8hX8DHx30iCeHjGRZC8TS3IY8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199018)(31686004)(66946007)(36756003)(4326008)(316002)(66476007)(8676002)(41300700001)(82960400001)(8936002)(5660300002)(66556008)(86362001)(38100700002)(31696002)(2906002)(6666004)(6512007)(53546011)(186003)(26005)(6506007)(44832011)(6486002)(478600001)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TFZLZ2wvOElUdXhqc3dLNEFnRU5FOHNRUjRvYVFxNkJTSnJvUE14bHBXNDlQ?=
 =?utf-8?B?RHBXYkt3dy92eEx3QXpuTkpURFZwdnFwalIvcEJxSFA4NVU4V3FKaTJGMkpT?=
 =?utf-8?B?b1NqbFh2SDh2T0ZSZXNZYVZmVldPYy9zR0Izc09LbDhmVHROOWNaWEpZRVgy?=
 =?utf-8?B?bkx6OWYvaTlOSEsxTGtBMHROYXNzQjNpU3YwbjFnUFg5YngyVGpzb1RQQ1BZ?=
 =?utf-8?B?SFowK2pLS3hJS01UK1V3U0c4NjVnSXpnbDZNM0tUaDJkMWRHeG5sdnZBVVc5?=
 =?utf-8?B?Z2pJMkxLZXhvcFZOc1ZpK3NtdnA4c2lZdWpwbzR1WG1PVk92ZGNDQmY4SVdu?=
 =?utf-8?B?bnZNc25jdHdralZhV1EzUGNVTFppRHhpTGthaktwT0JJRzhsTzNsV3lHaXpp?=
 =?utf-8?B?eUx3STVUdjZPUGloNW80MzdOdVNrVW55ZkQ4ODZyQi9tZWNrTXhLR2ZGVXdM?=
 =?utf-8?B?V04vQlMzNVRqa01BMmthaTVpVEVHWWd0dzlSK0JDRDhKVmFZcUdhbGxBS3dC?=
 =?utf-8?B?blUzK3JJZzF0eVErR1hyVlcvYTVvSGo4a0xUeVRqYlBRZllicHhmTkVlVVYz?=
 =?utf-8?B?cjFJbGxNblBrcHVYY1JxcjBjZ1hKY2tHVGJCSGdjUFVUUllpVVdKZEs1TzJu?=
 =?utf-8?B?T3BLQmw3cXJlWU0zSWhFUWh3Tlh1Ymk2MnBhM2FTajhnSVlUVzg3cDZpZWt2?=
 =?utf-8?B?REVOemNpdjNtMC96UDR0M1ZwZktacitxQ0NvTTJYSTgvdXJEbzFndjVHc1Nw?=
 =?utf-8?B?dFRrUk91L2ZPS0twdzk1ZWVjTWp0Vys0UGVzTWdJakxPd1BLajRiQ29BTzVz?=
 =?utf-8?B?cCszcE5XSE5EY1NaUkMyN2R2UzFMQkpwV3JYVmR1UHA5N2NMU0M0UllRN3hZ?=
 =?utf-8?B?UVNsRExzVHRaU0U3ekI2VXUwMFRTTEdOZG1aOVRvNG90MzdjbWdCU0pzSFpx?=
 =?utf-8?B?dmVwRStsUnB1eUdZT0J3MWpiN2Z0SjdHelVsSzVObHd3OFRLUHJVTkpka2pN?=
 =?utf-8?B?RXRkOXcvOFQ1ZjdEbFgyVnFXQnhmL1hHeVdMcmlGMXN4U2pSeEtsSktCSnJa?=
 =?utf-8?B?NDI2bUdmQ2F2YU1wVVErWDJ1UWV2Mzh0ZlBzeWZDQ1U5WTdHeU1ka2FpVThK?=
 =?utf-8?B?cUI4L0hHRW1hTUNyYXo3ZC9wa25oUmJsRzZ5SEFMeFlTdjh3bXJ5dGxlRGd5?=
 =?utf-8?B?R3lIL2hzcnZlZEYraGtwTDRaVitvdHJDOTRCczM3WTVpVnRBYXRkWXhIbVND?=
 =?utf-8?B?WU80U3V4MkhKMDgrVEFvQVBVaUhUaXhWZ2N4YWttSzgxd0tTeEZjdUFRMU5K?=
 =?utf-8?B?MWkwMUFEYm9BU3ZGWk10QUd0VUFNN0d1ajlnelo4U0kyRUtqNE5WRmZOMkpM?=
 =?utf-8?B?dGgxWkJZOVVmTXVQdzZLMWZFTjhjRUxCWEx1Q0twZHBuY1M0TFBGUkRnZmVs?=
 =?utf-8?B?cVZGQkdNTldWdm5RVmZySG5lUld1M0xTNFlTUGcyVit1dlZwVWVkNk9zeUtV?=
 =?utf-8?B?YS9qMlp5QitSZW4rR2g5WE1ZRkN5eUdiS3lzN3VOSWtLRUhaVDRtbFNxem00?=
 =?utf-8?B?Um1GRXVVMk15eXhoUDlQSGJaWUNMVE83dHRJaDBtcW9Bek84VjREaUJCTkxF?=
 =?utf-8?B?QlJGWWkydlVXSlVaQmxhVnc1U1Z0TEdFTGdESEhvck9WQWZua1FOOTNZdllX?=
 =?utf-8?B?bHhqV1pWcC81KzRVN1BkSmlldCtOcm1PaXlrZ1hTQXFXbU9HMjZUbDlMRVY3?=
 =?utf-8?B?aHNKaWpES0hnQU1JWnJWUjd4RlN4N1lWdlFPZ0FPUVhjd0t4M29oeDc4L2Fz?=
 =?utf-8?B?cVpPQTlUTStDSE5Qd1BKemhUeWFySnhKbEpxaWhVeUtBTUJNbFo4Nys3ZU5J?=
 =?utf-8?B?Yi9LajNjdlFZTndsNW5zNk5wY3o4QVQ5bFdCV1BnbDUwWjlBa0R2cG95MmMx?=
 =?utf-8?B?N29LK1kxQlR6UE53Q3ZrVzI1Z2txa003dDVWUW0wVWVHOXJSMmxndmJQYjhr?=
 =?utf-8?B?SHlmSDRnTEhmdlVlSmQ4bEdseC9FVG1YSC9SNnhCWkFmNXFiUlR3YUQyUDRD?=
 =?utf-8?B?WGppUXcvM1FFaklwSXplR1o4SjJQM3NXdEQ5THp2U1B4dFBsOVFIRjU4SWdD?=
 =?utf-8?B?K045a2FMbUptQTl0RHZ1U3BLS1lrcXRXUTNqcVFyU0o5b0pUa3kwTm5ub3kx?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08edc94d-6aad-43bb-cf6c-08db04270525
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 07:36:24.0594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Bx2lhIjdZImEUBSwXxHEvVZ/WOAJyitA8yPMh+nwE39LOdM95W1f621fAZ5t731rxBbegjr5LSjcVkt9B/hbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5536
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Feb 2023 07:36:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10548

On 31.01.23 17:55, Venkata.Pyla@toshiba-tsip.com wrote:
> Hi,
> 
> I am trying to overwrite the IMAGE_FSTYPES variable with the values in wic-targz-img.yml by keeping at the end in kas file definition as shown in below command, but it is not overwriting.
> 
> $ kas-container build kas-cip.yml:kas/opt/ebg-swu.yml:kas/opt/wic-targz-img.yml
> 
> kas/opt/ebg-swu.yml include local_conf_header as below
> -----------------------------------------
> local_conf_header:
>    ...
>     wic-swu: |
>          ...
>           IMAGE_FSTYPES = "wic"
>          ...
> -----------------------------------------
> 
> 
> kas/opt/wic-targz-img.yml include local_conf_header as below
> -----------------------------------------
> local_conf_header:
>    ...
>     image-type: |
>          ...
>           IMAGE_FSTYPES = "wic tar.gz"
>          ...
> -----------------------------------------
> 
> Final conf/local.conf generate as below
> -----------------------------------------
> # image-type
> IMAGE_FSTYPES = "wic tar.gz"
> 
> ...
> 
> # wic-swu
> IMAGE_FSTYPES = "wic"
> -----------------------------------------
> 
> 
> Expecting conf/local.conf
> -----------------------------------------
> # wic-swu
> IMAGE_FSTYPES = "wic"
> 
> ...
> 
> # image-type
> IMAGE_FSTYPES = "wic tar.gz"
> -----------------------------------------
> 
> The above is possible when I use name with higher in alphabetical order like 'zimage-type:' in the wic-targz-img.yml
> kas/opt/wic-targz-img.yml with 
> -----------------------------------------
> local_conf_header:
>    ...
>     zimage-type: |
>          ...
>           IMAGE_FSTYPES = "wic tar.gz"
>          ...
> -----------------------------------------
> 
> Is this the only solution to set the order of the variable assignment in local_conf_header?
> 

local.conf nodes are alphabetically sorted as you already found out - we
should probably document that in kas. Generally spoken, you can make use
of that to achieve append behaviour, or you overwrite the original node
you are competing with.

In case of isar-cip-core, we can rearrange or kas option files so that
your use case becomes possible (though I'm unsure if it makes any sense:
the content of the tar.gz will be only a subset of the wic swupdate image).

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


