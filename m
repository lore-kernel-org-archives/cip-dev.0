Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAEBC38142
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 09:38:23 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.40])
 by mx.groups.io with SMTP id smtpd.web11.8514.1675157897876669837
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Jan 2023 01:38:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LFCkf4Rv;
 spf=pass (domain: siemens.com, ip: 40.107.21.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAfm/fsp56jRkriFuGy8S2ZBZZ01eBHuXS9cqXdhNVpKA6PgIQUcLjGM3fvNCixSzg5YXTO2v5nsyQ02V+46V1DoYkMz+uhWoO/0/l2zWH1Iuinlqa+sVLURefeyn+NEpTAamlXzA6rSfJpIgCVGkdn3/MOJgQn8haikUmG+C7tl5rsPoGERL6MrlxdzyW58mYpdYM0Gt8ep5lh/8SnWXfGxGAMuajYdOt80y3u4E+KWb+oR8A3mOR2s/PYkWLyorKXFLBACQ4MKr/jb2qorU+/mFepWg+IUv4k7A2UlpZFhOrKCdeM7TfgDdO8nhjL8jEmGB5mVY+XKrrjHpSQ2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/jTIgxB68xrkvNl8JllkxDWB1JKPhjCvUIO+1PBHuw=;
 b=J1jXULSE+XjxI+hNiiIlJal22Okl/I0D5MZ4VOZ5YB03j+yM8v8tnUsQnOXAn4J34To1qD30+Rzbx/TWiwcNWpJGyKVUdrBbqo1Yk2qLwBBb5uJN7rV/nDY52V2Z4SHtfFtdK3gyhNPTGSk6VTz0VHGagoZagCdtjKfKwMiJuuG1EAk93/FfnpdPFfytnJk7r2oFGGH87wJSW8DAcg+lRkFLyfnuSs9baKNl0ACbN5elzjJvX7fCn6yBUrT0ZsXshHgU2wOVP+hsUDVTdpIr3TCpkuprceHMHoYhKYXvvO1W1z11jT89EnY+AHAK0Y6PHckkGOzlQPLiR6k/Q7cx8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/jTIgxB68xrkvNl8JllkxDWB1JKPhjCvUIO+1PBHuw=;
 b=LFCkf4RvKS+QhsRMYEQWRAR4r6JQc6wLOXjjpmSHHAMtBzti34uli2TsSCOK9LGH4a6/qkz45zVgzRFZ05z6hLXny+tkIYv+y3UP4wYnhaeB152ZfuldMeOEUvc6y6FKcX/5t+kwslo1l1qm3EdBoH7JItdSnhoctfWiR2qWHzCzl0pC/dSoX8VQqM8aCpls+BONNxMgiCqd1y4Xv1tQfiM4nDzLYwkDIWyChjmcAathlisFUaeK3e63plTdh2O8uzvjaRySzAaQ5nrjXAv7ddmusbaDuspn6ezwi2yJMQRtPV5h9QFnEAIX0oIVhSV8+LRs+gsDXLBs2p7jgAsA2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5336.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Tue, 31 Jan
 2023 09:38:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Tue, 31 Jan 2023
 09:38:13 +0000
Message-ID: <56d6a637-5654-7923-4f47-e76b554d578f@siemens.com>
Date: Tue, 31 Jan 2023 10:38:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: isar-cip-core: Heading for a release cycle
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: 1edfbdcb-b350-4af8-eb8b-08db036edf71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FMSl03ZG2ixERNOHzLnRbixp+1qvg6kinuWvMEqs8B9xckOqE/xHmKQJdPuFICVRJXV4bFczgcEWNodVEX+akiI6jK24twnds1dCzUTtGLKQnjZEDto78iWojXEWieksaPgf2iTmOicqKxPetXSn6aGac4R9usx63U+nlphrQ18Mwhtt30PalPN7zO+XYXknwVCT4FQD9xmRWk3dPMtc/aW+QcPLyDNc7+wWT5z7iY2wYhoqviE/huffj4jrr54sXgZOLGWb/IuS4TntzHdTASt9O1b9wjZxV4mF5VeYkKGGb/lhT2kcPUzhkiN7d8vZ8U9b7kfNV16qfa6pS0ym8zou5XeMUDge5VzyoWYhfIOK8aQ6g5dJnWwp+3g+yf5BUCQbumIvTkzNhU8/5KQfRE6Ju4LliI7vmRtByAlYKHWRPtC6Fhq8FBBM6DhNXpkb7dw9Wl+LYvnnglcP7rpMUH1/S0W31DWciyitT6xBM2OE8NUuwwfJa4XQPgcfP1a0/VNRPLyMxeOpv4gVO1a9l0FwIxvG37uFyiy2mobQyo/T1hCNBriZmwHoxowXRzWCEhShM76x/JONGLXeEQzpzLTEps+FJrpHskHCE4zi/ooG4rTE8gwAeQp8nRi3lYj+S+/6oXKOZ8DHmAWrrPaqEIFpvS+5cLy+jCPxSkjVdx9KHmijm4QGMulDxPZz1BJmLlxaH3xI5/LQh5ilW6/WsvjXJ81D73tJv2BinOtHA80=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199018)(31686004)(26005)(186003)(8676002)(6916009)(66476007)(66946007)(66556008)(6512007)(2616005)(86362001)(2906002)(36756003)(31696002)(66899018)(8936002)(41300700001)(478600001)(6486002)(38100700002)(316002)(6506007)(5660300002)(82960400001)(44832011)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NEo2TGFxWXB4RXdGZmNMQWJuWmVNTzVUaDltSGNjNjJMVEljT0NCU29RaGEr?=
 =?utf-8?B?bkpTS0xrZXlGdDV0MjVhdTFubE0rdFBxQ2hzTWdYS3M0V2NweWp4T0h3bEE4?=
 =?utf-8?B?WjNqTGRhUGY0TWFLbkh3czNjV0pJOU12c0dLbnJGRkNycEtIbnhicmpqUVVo?=
 =?utf-8?B?Rm9ZRkRONURVT3pPbVNHYmdBZ2t1NmlhY2w1TndZOHUwL1VvbUJqTWd3MmF5?=
 =?utf-8?B?VjBTYlBsQ21BQnUzUmt0SW1lMUVYbitsRmFNM1NNYzFmVit2YSswMUtSc1Fq?=
 =?utf-8?B?Yk9DVTNIT2RxeldBMWtSWEd3Slk1UlM4amtLU2Z5MUJrY1QzampQdEQ3WExV?=
 =?utf-8?B?d0xqSDR3ZzUxanVGSEFOVXhwby9uSElBSlRjTDdEcGVPV3hCRG9mSlEzZXRx?=
 =?utf-8?B?WnlqbGdtZU5XVDhTK1ljbk9vdUEvenRkRnFDNEhneng5WVExY0dhelkzUnB0?=
 =?utf-8?B?ZjRpKzlsOVErMnBaeGJmOU9rcGRFVVJiaDlvK0I4WlljMi94blh2Y0FpOU5v?=
 =?utf-8?B?b0hWQ0JRU0VyY1JJUmdLeWlzUkttWDF0UFladVo4a2JpdmFpRUY2S0J3ZWNV?=
 =?utf-8?B?SVgzTnZEQUxXSXFENkhYSjJtSStOdktFZFc0aytnOVZJT0tqV3M1dnl1RGo1?=
 =?utf-8?B?QlppamVhbjdiVzRPcnlpMWNQTXdlKzk3elpJNFNENXZ3b21GS2lKak1PR3Vn?=
 =?utf-8?B?cHhiRnRBNi84V1d2WDVTalkxeFprZnVTUzdHWGZsVFJjQ3VOMG9kQjVHbEVV?=
 =?utf-8?B?VzJiTDJsR0wxNkxJL3l0bDREK2FmOWoyMDl0QVcxcnE5dTdFZFkvcExyRjNR?=
 =?utf-8?B?NDI2YnB5aWh3OS9RSVFXQS9IeXVEZUJpaUtrK2RnTVlnN0FsaDlLUGs4MEd2?=
 =?utf-8?B?aGpkTFl1ZURBV0VtTnIrSlZoYmlTT2ZadUZOa1o5eWttVk4wMHlRK0MzdU5k?=
 =?utf-8?B?MzV3R0hZWVpTRXJVL01SZS85Yy90R1FyU2MwOXdWUDdyak1vQnZSL25NYlU3?=
 =?utf-8?B?bW15K1RES05RNEVQSTNZaXpPZ0NGSXhJUmJ2T0JkQU9TYi9xU3loY3VZWGxH?=
 =?utf-8?B?NDc4R1J4cm5ybUJmZE9maXk4VkNyN09yWkVVK2NJVC9kTmVVRGtZZEtYUHNF?=
 =?utf-8?B?R2xrRjEzRmUxaVFBOTNtYmNVMFI5RmhDQXJjU0E3QzFNUHUybTBTK3Z0cDZS?=
 =?utf-8?B?TThlWUl0RDBGOE94VHpEQ1VpUUU0QlZFQzA5bC9maXB3cXU4TnVMRmZ1TjRM?=
 =?utf-8?B?UHR5R29Edk1wbmNiMHRBNjZXclUvdkQ1UTRzSldIVEw1VU9KNVhXa3IzaTA4?=
 =?utf-8?B?VU5PUWpTN2JCMVNhMFBzNWsySU9Od0dCVXVHNk82WDgrTVh2OXR0NEVFR2Vj?=
 =?utf-8?B?bUNpTzhuNnBIY1dtaVZ6QmEwRDJ0dE1ZbVN6eWdNL3I5WGppelB2M1lDRWlR?=
 =?utf-8?B?cXJxcS8wb29TV1JMU3I1dXJNR0x3eTZmRDdObFNJNlFFdm0xSDI4NEVRSEE2?=
 =?utf-8?B?R2h5ZzYwelV2TTFGN1hCbVpNVE5ZMzd6dEhkNnRIbXB3RkhuN1VlckNBWWxZ?=
 =?utf-8?B?Y2x1NlppRXBLWmMwQ3RhcGdTWXo1bXQrNk84VUx0TGd4OGVIUE8wUXRsRitt?=
 =?utf-8?B?a2l6NE9SaHNYOGtTamNYVHBtZGg0aTJEUXJiUTM1cXdCaGp0NVV5UGtHTWlr?=
 =?utf-8?B?bUd1RW9JQVc3WFVtcC9CMHdKdE96c3ZOaENrZ1lvczlKL0tIbEUxWG9Ea3hn?=
 =?utf-8?B?YmJ0V08xWFNvNFFjRFlLS0hJMUVFbjZva1Y0NkVkcVNUUGR3MzhlOUtrV05T?=
 =?utf-8?B?eDNrVWdqcVp2eE9UQk9ZbzBvZ1ZZZ0hDU2FOcndRalhGdXk3bTQya1pSTEw0?=
 =?utf-8?B?MDRJem1ZeHIrejRUcXZJS1M4blFDU1ZDZFdSdDRPRGF6L0MvdjlpSmlnMzNj?=
 =?utf-8?B?TE9pdnI1eWNaZGJGVnYxeWhTTWg2dS9HSHhmc0RqOXNuNWRzNnk2NmFVUjFI?=
 =?utf-8?B?aDhNekhlRWIvTkJvSUFNUVVKVmk2ZEgxbW5sMjhPL21RMzkrUXl0YWJGcExz?=
 =?utf-8?B?Qy9SSTdrL1d2OG5EMGgrWmlMRW4xKzZNZ1V5clIrcnVaRFBPT1dvUVgwQmwx?=
 =?utf-8?B?dzZSdDNhR1JkRVZoNHgxYU9obGlyYUc0QnVkVmhPMmdVQnFXK2E4NURBeXVB?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edfbdcb-b350-4af8-eb8b-08db036edf71
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 09:38:13.4221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9kv3lL00+bITaL2Rj3HUGBZxeRjm0V+I0elmEEf0XaUIBnKMl7886pCTWoRMgQRSAMSG+YEvNf8BUIcR6H+4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5336
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 09:38:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10518

Hi all,

at least some of the isar-cip-core users are in a need for formal
release of the layer. The plan so far is to follow the Debian
point-release cycles, means basically having one every 3 months. First
one would then be after 11.7, likely mid to end of March.

What all that would mean for the layer recipes is to be defined. Already
clear is that we will offer snapshots of the Debian package sets via
snapshot.debian.org as build option. Beyond that, I plan to declare a
feature freeze at the end of February and only accept fixes before the
final release.

Long-term, we will also have to think about what kind of recipe changes
we consider as so breaking that they should be addressed with a "major
release" and how to continue maintenance of older branches after that.
But I would like to postpone that until we hit such a point AND hear
clear demands for such a branch.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

