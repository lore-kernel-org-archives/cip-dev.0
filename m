Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E0BC64EC4
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 10:00:55 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.59])
 by mx.groups.io with SMTP id smtpd.web11.19780.1677837651234266554
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Mar 2023 02:00:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=otrnQZwc;
 spf=pass (domain: siemens.com, ip: 40.107.14.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vd+f/yBgdK/+a4ZuSkg/UJx8QbzhCA2SawjOOmXRsO7OlgoHUqvrDymQzfdBItgI9JVsZtKW/2k62w7bekXiQLgNYKcHBnrmEi0G2+Zbk+JhQFcxsM6AttcYYyEB90bDJy1E9Ch6UNIEdt0Ek6BFf7eHQf8L87/wZ0jK5FhXzCghBdSNxbNiMQ8xr7H+hT1NvP7pEoIkbE8kg6mZ6guu/8FKQAZYH4QXcbznl5sy++u95u9z4YB861t+SsnG+JrFK5sfAvPWV4aKcZVqWQrZQMrvDX4eCAdDkhQxsqXNKLJIMj8UF2m3HSq2LF1Y5U3RxNfhFTTC7J8FoSZXKLKeUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUcFu6RqhPSBTfEQMTuFIipL2+/bzyJnwjZ1B+WKvzQ=;
 b=G0S8jh0hQ6Cvrhqqk5unLMrfnx2IBOlGAzeg9jMYpdoJ925og62n6TOJiZ4N8Sxel7tRGUaXAtO1jHJMPchBS2jcZfF6OiKHWp9noow5zk2GA+u4OnO9OWoJA671eQv6aEZxdG/UAQ7vmPjkkByosCmTsJ/W1LWxkqGR4pqeFQ3k1x7pgHgL6JM/3KO6OYipc5+3AgI+dxkTP7QuHNenDE7UyexpbKK5v1HcEtftNq2r9nnvCYh7nF8ulhawxJtqpJX6s/CuRqyDrxld4/J+qCEjPHhIQva7xOPg3XWA1IzxrOLmUNlUxVpfPYjoHUKIkKUnuAhqQWFIuCdMVGL/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUcFu6RqhPSBTfEQMTuFIipL2+/bzyJnwjZ1B+WKvzQ=;
 b=otrnQZwcejM+NmeTWZG3g3f76OUI6FfNsH9MJCkjOAqygj5QFjrLMAALRJq2aYC3LQFYmNfmXfG/ICjdThaAhb+ck5265xtAdvDaZskCJRX4+QGDA3jKcUGI/UEWW+k+TCmeKWogokmrR3p2JldngOuSCcW6PCMWp44S6MK2llM92GjoEeezcG2W3wAy3f16Yl8/wOgWAHCw4Yoa1IbGI8ltmW8s9rCMBUKmR56BeSG5AmHnpzNV1dkztse7Wfpfj9VZLPPC8qb4nvrn6seBYaAr4rEWpqAJ20SGsVyAHRAauptKnaFtQ/8GML/QBBaNxnw3iZe53V97vRgzaZlKLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB8037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.10; Fri, 3 Mar
 2023 10:00:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%6]) with mapi id 15.20.6178.007; Fri, 3 Mar 2023
 10:00:47 +0000
Message-ID: <a4b6720d-0649-3e96-3758-ffa2ec90e840@siemens.com>
Date: Fri, 3 Mar 2023 11:00:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [isar-cip-core][PATCH v3 7/9] add linux 6.1 mainline kernel
To: "Moessbauer, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Bovensiepen, Daniel (bovi) (T CED INW-CN)"
 <daniel.bovensiepen@siemens.com>,
 "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>
References: <20230302152659.2096307-1-felix.moessbauer@siemens.com>
 <20230302152659.2096307-8-felix.moessbauer@siemens.com>
 <d75f99a2-c08a-c309-e2f9-b013c2a25af2@siemens.com>
 <c75becc16061aad113a342b0597a82720a60a9bc.camel@siemens.com>
 <1fa52523-4d52-dae0-5a5a-9ca2afca5047@siemens.com>
 <b8289090a694b8b9fab70db6195759cb7ce02e2a.camel@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <b8289090a694b8b9fab70db6195759cb7ce02e2a.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: 9807494d-7223-4b6b-e1c6-08db1bce296b
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QZ+Snp5zM33ALaclO2uTrAoup4i8rL7btobyMUmlvxbfqBLn4nMs2Pcq6nJ2Ielb5xlR25h0rCvIA4bqOK6tIMvYuYDmHR6HyzRUUnmBPwtYKLB/W9YA+orXkJepe7rcvUilqLxkAVr6zqe4yaQlK3d8Ovr9L9UyB80IrQVuhdigd0aXqCHRGn44pf38I+I9sMfyzQmWY4dT63Qbu17J9adU7jtPPpBwsYVY3mktADyra6W0WtcLoixEPVDhWMcVOdCj6beL2kzeZAa0YuTx8KiE9MzFdbBT3BP/x9tZP+Do2PVWkRjSIzyWzcFpr97gbILCihE3L2d0+bnxNlvbWnDMhAXd/QDVfYdQ45EfQkZaynE2O5ZlfjZUn9A2k45zIUNQPWbxCTFGif+qiieVg+jHweo5Y9yiMJrcO+QD4a2QIhrSxjznz6q9UzsZinc2d5ZbuiPPDNY6Tvj+syM1OjxpTn/OTasUQZee0ATR8E+1foe/8mLbNQdx/xs3kienprvN0obJl5aOZx76oJzT6HN8PgVu3KKvWCy86OKSrrv30iXe/ezx5FvTtzINOEuUnDbdUK70rbTp3ufYu9FwCQQKGUgw2AB46oPSpZZCrT1YqIhsMNzOT/FijQ/XV7rNM+3CxcFtNinKZmWYauUOB5ZrT/zucH/FQDHj7bjShqeUSP1J52YLBHsk/I1UQj2JYVl0CKAu1TeK+ZJIjgkbdQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199018)(4326008)(8676002)(66556008)(66946007)(66476007)(31696002)(6512007)(86362001)(2616005)(38100700002)(186003)(82960400001)(83380400001)(26005)(36756003)(54906003)(110136005)(107886003)(53546011)(6506007)(478600001)(966005)(6486002)(316002)(5660300002)(66899018)(44832011)(31686004)(2906002)(41300700001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?czk0SjhxclQ0d09uV2RoK3RTczFqQnBQdys0VlR1blZPQS9GL1ViZmVRNDB1?=
 =?utf-8?B?SWdWRzg3TFJmM2pSQXIrSDBWMFVaQ2d4SEZNc0JXNHJCQVRXamNZNldWdVNm?=
 =?utf-8?B?bTNXTDNBZXRzZm9YLzRnL2N5bjcyeDBTdUJYc3o4QndwUGV3MkJNdk5EckZV?=
 =?utf-8?B?Q2ZEUVFJSExSempIbGNKb2tYb2FmS0dvR3NZeW1oRFAycU9QV0dFSVgrYTY3?=
 =?utf-8?B?L0dyOXd2WFVFU2Nycm1Rczl6UFUvS29QSjdPYVZjVGpmK3M4WWdEQyszZmt1?=
 =?utf-8?B?UFpXZlZESCtWaWJHc2pSZUloZ2tBeDhQaC9aajA4UENLYklDYVpVREZXdDJY?=
 =?utf-8?B?eVd3NFdlWHo1NGpWRHlYNDdiR2grTXh0Y2haRDhPbDl2T00yTFR2c0N2bURQ?=
 =?utf-8?B?ZE11MlJLM0draU1jckcvQUpPcDRxSDdYaDlCaHJxQk10dVQ5MnhqVUZ1VENI?=
 =?utf-8?B?Yi9tYnVGancrWWQ2dGl0anZWVy9oNXFUcUdWcS9UbEo4akdQZ1I5YUJLeXNP?=
 =?utf-8?B?NlBWb1BQNHcrRm9NZ3J3NlJUTm5HZ3NYcTNZZWhBVEZQa3RRVjFsczhWVXF2?=
 =?utf-8?B?S2NNa2xFWmxrbUFqRTNMZityalJqR3hOV0h0Z2Z5NlBZc2xyRXJLWUhmUk5r?=
 =?utf-8?B?ZWxpTTlEQkZwODBOLzNnc3YwYmU4aXhubk9LWUNTTDUwb3I3ektyL1JLckds?=
 =?utf-8?B?VFQyOXlzU0lHUlR3VVJjQkZUVlg2TStLYzIreGIrMENFTEtVV2FCVkFlbUZr?=
 =?utf-8?B?Ni9VY21nTnRLVURWNzk0MW8xdTF0RjhtQjdXTjFaZklhWjdEcFY4RmF4ZzBT?=
 =?utf-8?B?OVV4enZBZW5RODg2MUZRUkJjS085Qkt3S2xoVFhoUnM1aUd5a2FhVXZENHg4?=
 =?utf-8?B?T0l3K1JvalY3Zm9vdXFydXNkQWtORVRWSlJRNnNHYVJTTkNOYlZSYmRIem5W?=
 =?utf-8?B?OVp1US9ldHdqaXJuWFF4UGdFcGROWm1BNFZhTmI1Q0o1SWlwcjM3eTBna3Ir?=
 =?utf-8?B?U1Z0SkVFQ1B2czRQNmt3L3pROTFvc0FOY0ptd0VscVliZk9LcS82V2R5b1hZ?=
 =?utf-8?B?QVpwc3pITFJMbGdHQVZYbkorK2tqZU1LN3NqaHFFVlY2Q2laSnRPaDJMeVJl?=
 =?utf-8?B?T0tlZUp4U20wY3Fpci9vS3k5anE0Ry9UQTBWMnhZaEFSWU53QThwcWtjSjFt?=
 =?utf-8?B?S1JxVDh5c3ZkaFFTTWJvUWtneGZyUEVkZlRaTFlLNkhvN0dzc2M1THJDRmZr?=
 =?utf-8?B?VGQ1bDRkYk85Q0V4ZWdsT0RqcHlUMGZxQ0YvcmxNQWsxVUdPTzI0MmdJREt4?=
 =?utf-8?B?UkFzVHJnbFlNc3dRMnBCVHdGWU1adTUzR2d6VHJMQXQ2K2R1QnAyTEhqZmow?=
 =?utf-8?B?dDhzelNVcnpweWdOKzJDcllVVGdTKzVRbENGSXh4dDFzQnJuRGh0M0l4elRR?=
 =?utf-8?B?VnZYcW9vbWtTdjBxajdkbHpaRDFKWERwbWcrN0hDb1habGdHWDVld1d6Z2ZN?=
 =?utf-8?B?MHpIc2ZVaGRnSGMzMmNvL09PbmNTVEl4d3hsbjgyNHZ1M1RreFdHdUtDQlhk?=
 =?utf-8?B?cEE1YlBjYVAvOUdxRlVFWFpxT2lqUDFoV0FJOEllRDA2UnBXeGx0QlRySjRZ?=
 =?utf-8?B?WlFqZzRmbWlYekZhcFhCSTRhVTRRdzJYeThnV0hxTnQ3Um54Q3lrTTJLd3pP?=
 =?utf-8?B?MkVSeDM2bmtSL3p5U1hSeE8yWkQ3YXdWRXM5S1RWM1N1SnJTOHpSMTFUZGww?=
 =?utf-8?B?RU5KVTBxdHEwQmNTZEN6N21PN0VoZmF0K3hEejBoVmZrR25qM2hLV1hoNFcx?=
 =?utf-8?B?Q2JiYk04aUUxSXFuYlBqdlJhakd1S2VTSUFvMkd1M2lkWEZQZTZFOHNMaUhC?=
 =?utf-8?B?R2FFamlSWGhUNXgrR2F6RUV6dVd4eFA1QzV3bG1uMjRxQ3Z0aHdtZjR2dFU3?=
 =?utf-8?B?MXlkSEwxZXJVcm5lRnkrZmdaL0V5UjFjcDdPWkRWWGJ6Ni9TQ25Tb2UxbEhh?=
 =?utf-8?B?anhlQVEwMWVFMzJrYUE3Y2hsY0k5dTZkY0FucjhiM0RIMEFjb0ZmRFRiWWta?=
 =?utf-8?B?STJNcFpMTWJMOU9lYXJQd3FIN2JkbHVwN0svVmorZTBBcWRKM1R1d0VJRXkr?=
 =?utf-8?B?eDBGcnBLL3BrVG9jMDUxZzJVWTdPV0xDQUlyYjNkVzhnclAwUXhpZjkrOWxo?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9807494d-7223-4b6b-e1c6-08db1bce296b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 10:00:47.6768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tml7CTuoX3AghJngmYat19pj1/d3Ga6zaHKrlCcYiKjKGzMN/hBy0DXocfIQ+y70rjPvff7jZUDLFJCLGtFYAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB8037
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 10:00:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10899

On 03.03.23 09:59, Moessbauer, Felix (T CED INW-CN) wrote:
> On Fri, 2023-03-03 at 09:46 +0100, Jan Kiszka wrote:
>> On 03.03.23 09:40, Moessbauer, Felix (T CED INW-CN) wrote:
>>> On Fri, 2023-03-03 at 08:19 +0100, Jan Kiszka wrote:
>>>> On 02.03.23 16:26, Felix Moessbauer wrote:
>>>>> This patch adds the vanilla 6.1 linux kernel for testing and
>>>>> for
>>>>> boards
>>>>> which need a more recent kernel than what CIP can offer.
>>>>> The kernel can be selected from the menu, similar to the other
>>>>> kernels.
>>>>> As defconfig, we always use the kernels internal configuration,
>>>>> because
>>>>> there is no cip-kernel-config for that version yet. In
>>>>> addition,
>>>>> the
>>>>> squashfs knob is selected to support the swupdate pattern
>>>>> without
>>>>> any
>>>>> modifications.
>>>>
>>>> We just decided in CIP to start 6.1-cip development, so we could
>>>> also
>>>> start filling cip-kernel-config with related 6.1 entries, already
>>>> including additional knobs we need. Actually, I suspect you could
>>>> add
>>>> squashfs to the 5.10 riscv defconfig and use that for now,
>>>> avoiding
>>>> the
>>>> snippet here.
>>>
>>> I could, but I don't like to mix up versions here: Having a 6.1
>>> kernel
>>> with a defconfig that is written for 5.10 feels somehow strange.
>>> That's
>>> why I decided to start with the plain defconfig from the kernel and
>>> just add what was missing.
>>>
>>> As this squashfs=m default bit us now for many times (e.g. required
>>> distro kernels), I'm thinking about simply always adding the
>>> initramfs
>>> hook. In case squashfs is already enabled, a modprobe does not hurt
>>> anyways.
>>
>> Makes sense.
> 
> I just saw that we already do it this way (it was different in the
> past), but the vanilla defconfig has SQUASHFS=n. By that, we somewhere
> have to flip the switch. If we will get the 6.1 cip-kernel-config
> rather soon, I vote for waiting. Otherwise I would just keep it as it
> currently is (dedicated file).

You can accelerate the former by creating an MR on
https://gitlab.com/cip-project/cip-kernel/cip-kernel-config.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


