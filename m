Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFC0C4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 09:58:32 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.69])
 by mx.groups.io with SMTP id smtpd.web10.5068.1702288710427954938
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 01:58:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ehGI1Wdp;
 spf=pass (domain: siemens.com, ip: 40.107.249.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXStpPjjxgHBh8BOG+CmtrZbSmHo/hp4O7qcWszxlZbbLlYtJUT84mv4I6MKJdehuH61x4PCGA7Svi9hY5DJ0uvE6nnRYVQWcMimLlVN98/taRI4pmLRDuIjmcN896/C+aYdlTdUxUSN/mab5ozk1XF7I1muLZoyGjk2Tp5heBU+XD75Pdt+yZ2ripxG06y+Raxfd2bMPTPD889XWfZHTleO6DKPrjxyjfCSO8BbjEmA+LrHbMQlUubRaKpBNfpQu00Y2nYEoe/02U9+7jmKEjWoecebRZSSWvfgROrHaqYSUN052xpOTkl5YKljNydGpqKavBX76Hca9fGmLxwrHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQWJw1GK99HGOc53Ec85WAcvU5A5ATaNuBo6A01BI/U=;
 b=mB+CX24pZjJFUG4inbNkPGuBUVieysLX4FvwmaefA4N4D8bQ6lz6fuLzGbzoyfPauqrTm7fIW1R9+OMr8k6bI14aezY/45hqyRDuXKg5eOdRJzsLjIEB5NHSXveR5ud4QkSNnKDGDEY0Y+9PDzRDq2c+/NMhag0aAQXUFJhbN2Iu0Qh+8f5tIiQqoMvJbY0PUD4uNAtaEX1qycR7eSCQFIDYFdL1w+xPKB7GIv91deLLih4M6sbv8mqs2as1iOQtuKDWRYvtlJ+2X5MCyGW9j1oDIZvpxzEzCDlSCbIBV/wJlSmjP314sSYhVKSsmisb9YiNpNKUZH3cZbxKEhbHpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQWJw1GK99HGOc53Ec85WAcvU5A5ATaNuBo6A01BI/U=;
 b=ehGI1WdpCeQ4vWqRClKyEIXQPdu6O9Qf3ZMdXyyvysz5pkgI70t8MtS0Xcx6k6ptDcNUWvOSAITyWJGMwIjBrrvwlG9Mzyw5eLLzfM/Ws3Sd2iWeXlAv2oBEropRp8DpbjH3607ipv4MW0TSh5RwKtDOHVU/G/M8pL9Aa8JWS4MN+Ag3K2aLySDrz6HCNoNIGfvsPvzCBnUt8hRu8hOQQ0l+iY9DiSnpY49yxpAJYMa3U/ALfTvUhQXZ+R3hoUil/1V05ylZ1Io0QrT/F2A6XtNo49WYOmuDyHAAeSgAQZofVoNfiPPsf3403SamgYPqasAeFlkksIMRc3zZOkiXLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6818.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Mon, 11 Dec
 2023 09:58:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 09:58:27 +0000
Message-ID: <df30a458-00c9-4b64-8963-27c556603981@siemens.com>
Date: Mon, 11 Dec 2023 10:58:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Potential ext4 corruption in 6.1.64-cip10
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev <cip-dev@lists.cip-project.org>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
References: <7c9ee21e-7e50-4c3d-9d09-2368315abd16@siemens.com>
 <ZXbYD5WHuRCKNGO3@duo.ucw.cz>
 <d3b38c88-34db-42cc-8f56-7fc8b4696fd0@siemens.com>
 <ZXbb/i1HuG0yPHXi@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <ZXbb/i1HuG0yPHXi@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: c991fe99-8a34-44c0-d148-08dbfa2fb8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8KesaqWqy7+LQ7JT5rAejr6PiNpbzCcgAGunJquV4qU3/ZwqgaCYabX5T9SsK2MPYpNNdUzkNZy5LvQXfcl5EiWXFpr/4sQy63hSBnsgV1pHGugaUZT8g9mMXGZjTAst4q5r9hiAomzYxNvyXaGOfjS8kny/UwyWbfD+ZAYwn1VmDhl+s7QFkrPEPsSb6+Tn+b/wlj4MpN7dXGm5+8+CASd4bUaWyTcN+vXBfSeuohHFykBneuTVJreNoq7NYxDEVJfqAKzMtEOd93iEk6+V9rnKdO9sPxHrYnv4H6Y5RCxshB2P+LWbPr8UTOHRuDqHYqjh9lp+4FaCILZXbxRcSAluWLZtw5lRmC7xJcidiydRu8yh0FT6HUMNlfRTjB7XjsDKfWuQPWMLf+aPnHwxawUQjTYoNwcKB0jPMnt2+INPyxSsLIROhLniGP0/UkanMMTo6TD7ebFp1u01CoPbMPFNGaCZz81LUoqaiH6/4Oy/6mZ9BxA1Hx73OgeheyvQx/zC3dWKZMPb7zWIEl5wvKc+6dEjWpNINT82h6ga6c/4Z1zcs//WJ27dBggzi37V2CQybFvaBLzrUgkJKjqIaqyNILERPokdKNLtyMM9kWf8PkUtffOCtj8ihE3/1S9GoTZCpO6V5yurcbD/H9eXwQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(5660300002)(2906002)(36756003)(44832011)(2616005)(6512007)(53546011)(6506007)(26005)(6486002)(83380400001)(966005)(4326008)(8936002)(8676002)(86362001)(478600001)(82960400001)(31696002)(31686004)(6916009)(54906003)(66556008)(66946007)(66476007)(38100700002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aEduUk5YSEgrclllbk1DTUVvdU51VmdIVXNZYjhORVA1SUttbHdRd0pxQmtu?=
 =?utf-8?B?cHg2UEhqdnIyRUhVZEZNVmRoZC94ZFdsSFAwSXE1WjJGOWhFajVVc0NMb3J1?=
 =?utf-8?B?bVhhMTFKNHdJTUF6eG5xVmRoODZ5T1JqWjJyWFBuRm1iZjlwKzNZam4vREhG?=
 =?utf-8?B?WEl5QUxoNTZXT1F5ZXpFUUdGZVl4NGp4dUNONlN1NkxGUXZ4UHZYVXFkWENs?=
 =?utf-8?B?Z2ZZSDNjak9DZDlvYmh6RHN5TjAwWFQ0VkY5WkFqRWpKWC94eGZUQ0ZDdEdS?=
 =?utf-8?B?UlVyZll6N05BR2FCUjlHVHVsSE9USThNYW84bnBpZFgzaSttWXZxeXdQZlNY?=
 =?utf-8?B?Z1FjTzVWMnJWdFdvRkg1Yk5aamcvQmxITGRKZC9sYmVIKzlQNEtPdExpZFhV?=
 =?utf-8?B?dktwQzFCMHhQQXZGZm5rekIwYXlSNVhEQUFxdGNGYTFkZ0N6V3FBWlJDYUcv?=
 =?utf-8?B?VTFTeTY0Q1pLWko0Sk9Zb3R5c21telFucnRRR2FzR0ZKekpWQnlFMUh0SzZ4?=
 =?utf-8?B?NWI2bU0wdWk3YkRldXNJTXZNOFJDT05NZHhmcWt2VmFqRkVEcDBKTUhCVllp?=
 =?utf-8?B?UDg2T2xtVUduNGNaTXVaZCtVNkQ4QkVZSk80RERYZ1pFbW1LVHo5OFVhM0hF?=
 =?utf-8?B?Rll5cDVvUkR3Y0c2K1BzZm5jK1lOdDR2bnBmWTJ3Z3l3L2ZSMHVSd01HcGJs?=
 =?utf-8?B?b2pMSFNKZWFKMG81dlNiZFkzbUJTRy9pQ1BaQm40NG9GL0ZPeFY0VnhCNFJz?=
 =?utf-8?B?a3hIQ0FMWlZZNnRWNGZtMmNNTGNyRlk2NktVTUNxeEIrWGdsNkZTbGcxMm1L?=
 =?utf-8?B?ZzlsSTVMcWdzZFNEdWJUY29nZCtLbzdSZ1VHSFAyZzF6SXIvQ1JiYWpicFVQ?=
 =?utf-8?B?NlpqNEo1ZXg4TEdmVmRaWXRxQUNodU1YMmpIQk54YTBpaGtuSmE1VG5ielFG?=
 =?utf-8?B?Y0JvbUdUODhjSng5U3lWM2dRcThhUHRBbW0zZjNOTmRheC9mWXNmMnFTWHF4?=
 =?utf-8?B?YzFka3Q5VXVwTlRHTjR0c3h4MEtDOG9VY296TUxla1Z3UFVlWkZNWmhseFlO?=
 =?utf-8?B?a3kydnM2V0IrSlZFNFBWNU1KeEdreXR0TXlZV0xEZXVHS1p0ZkNGMXV4TDJz?=
 =?utf-8?B?Sm1xOWVWWGd0K0xuZmNJOExhTHVtSVl5dVQvd3hJSG54N2RHWGtiZ3FXUjlh?=
 =?utf-8?B?TlJyVFhMQ1F6ajZDNnhDaHNmQlFoSWt6T0xTRmVhblp3MXhnSm85cDNqUkdD?=
 =?utf-8?B?RWRrZWpxQjRXcUFkSnVmdE9xaWJjdythTVVNcVFBRWtwK2JEb1FFOFphYXRX?=
 =?utf-8?B?eGVQcnBWVlhxaDJCQVpDczRIdGQ2dnpUak94b2JNZE5NZk0wUWdoSmI4T0xF?=
 =?utf-8?B?Qk9zTzFJeEh0anZNNFJxQWFCd3E4MlkwWWhHa0pCSE9QNEo3d1M2M1haa2p2?=
 =?utf-8?B?Z1RaOXU4T0ZlRWR1RC9wcDBVUDI5V3RoSFRoSklTVkIyV1dNVlc2eFJJdFRG?=
 =?utf-8?B?dDlmRUZYRUFxdDRrYnNaeVoxWGVuN0FVNytBSmp4UFM1TDMxVWFnVWZmcFAy?=
 =?utf-8?B?bC9sdXBlc2NQM3JUOTN3Z29CUmdxK2VBV2VIUEpOYTVXaDhJK2VhK2xNQTB1?=
 =?utf-8?B?cHpWaUd2ZHlmRGhYNGxqMXd2bW9tYTRaZE1DTDl1dGlKTXFjazY3Q2ZUZFdY?=
 =?utf-8?B?ZUFKYlFmaXJWUERqY0NDaU5CZlNGUjIyZjZ5RVNZOVhMYzlwK04yeE9Sa0VU?=
 =?utf-8?B?SHA5MlIxUTJyYUR2RUtveUhlODVkS2M4bEtpdDZHK1dsYzg4T0l6NlJJTWFa?=
 =?utf-8?B?OVpxZ0ZSeHRyZmlhT3liblR3VVlOVlpYeGZKbTBUZHpvd3FxK2NNZ0ZRdU1m?=
 =?utf-8?B?RUh6NVFIb3NTcnFCdE9YcEROQXljT0JId2lWcGZWeDhPRWpQVVU3TTY3YkxU?=
 =?utf-8?B?REtpajZaVXRYZGQvWnB6YkFYT0JuS1hwRlFEZWg0SU05MUpkOWtiOHV0K1Q3?=
 =?utf-8?B?amtlQU56R2hwWUV2ejdwbXhRdHpQVk8vaW95dlVRTCtydXlCRno3ajUrNGVI?=
 =?utf-8?B?SUZDM1FGcmpZZVB0cDdSbkE5VjlMYXdOTmNYZXFDekdLN1VaZVhqQ0JLNk1V?=
 =?utf-8?B?R2V3NWJhdFROdWFJY1pXUUhJUlRpTkRkR29CK3BLRmI1dTVXSE1IUzJwY1pi?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c991fe99-8a34-44c0-d148-08dbfa2fb8df
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 09:58:27.6319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TBonKbCpNI9BYJETm6AZvE5HiRj6dwvBPaBt5bejjYSaPht5//TwuLJscZge62ddjBNQ9VSQ5IgeEA+cABueg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6818
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 09:58:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14004

On 11.12.23 10:53, Pavel Machek wrote:
> Hi!
> 
>>>> seems also our 6.1 CIP kernel is affected by [1]. Please do not use in
>>>> production if you have an ext4 filesystem!
>>>
>>> This seems to affect O_SYNC / O_DIRECT users, so I'm not sure how
>>> common problem that is.
>>
>> Well, Debian considered it grave:
>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1057843
> 
> Aha, thanks for a hint, there are good pointers in that.
> 
>>> 6.1.66 is out, and there's matching 6.1.66-rt. I can release one or
>>> both, but I don't see any confirmation that it is fixed in .66 or how.
>>>
>>
>> I would expect some reference to this commit in 6.1.y as well, but there
>> is nothing yet, no commit after dc4542861ec8dde92c3c8a5139bc412860aebe60
>> touching that file.
> 
> So this should be fixed in
> 
> commit ea574927fc0bc343016ea3337fcfc0b3fb26fe08
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Thu Jun 1 16:58:54 2023 +0200
> 
>     iomap: update ki_pos a little later in iomap_dio_complete
>     
>     commit 936e114a245b6e38e0dbf706a67e7611fc993da1 upstream.
>     
>     Move the ki_pos update down a bit to prepare for a better common helper
>     that invalidates pages based of an iocb.
>     
>     Link: https://lkml.kernel.org/r/20230601145904.1385409-3-hch@lst.de
> 
> ...and that's indeed in 6.1.66, and looks like it fixes relevant area.
> 

Ah, that missing dependency of the patch - subtle as it was written.

> I'll just do 6.1.66 based -cip and -cip-rt releases, unless someone
> stops me.

That sounds good.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


