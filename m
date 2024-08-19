Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B382C5321E
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 11:43:17 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.50])
 by mx.groups.io with SMTP id smtpd.web11.208539.1724067786679470652
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Aug 2024 04:43:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aZDOscdb;
 spf=pass (domain: siemens.com, ip: 40.107.105.50, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iz1jbOMj0+LMTA2S8zUyyBjSYDthWEob27i9yQQmg3pYLv1MXXjw9ruheafSKKmBI5XV1yr5IE2/QO57FfBQSpTOEZpZYwc2tOvYg8WI7zHdIUQzgCDZdYRqTz+8QGIiZxBzKVLLk90qayLPc5L8K9d+P7kWE3IAJDJVeaYeQdAaGSFAa86YkPCfuHyzpn9nmc697GqsS8A+Z2jtq3Q1F8knTB8TbA4w4x9frUmUMlJqQhbUlZ6G8aOaYCeVVHOL6mREPGtoKaLj5YDfkk15VmuofqWkwyqybZo7WDf/wEEmyH/R913pQCP1p9hPN+n+2bZFbJMoGwGn6I/J7Te/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wU3/yrT/mrYV9eBcmyeQZSnfOU1xOGR93UaG4cSrpEc=;
 b=Ta4yNpcKi5u5V1CkbJxhnWGDXvJbXSS1+chKt1WYbA5d1RrkPfADa5ACkeJvEb8EqWjgvu5do/wRaCSmM0HGaWy/oM4BnejSDP7ZPz7SqAqUUjWnrRVlXxLNj+NtyIBZdSfOw0E5cy1OUL4sUb4oImQds91N9BnJZcFvEesEBNzJ9W6sbPa8IX8jDdYIoviHdHAuMwV4zn5FPlTsrpcuAbiqFDD8vKUcI7tfuDYBbdsZREGkgxtxqTmjogGOEcUsc7MaGmdwjSNQwqScB95XJpG85+BBbayKSUhb9vt/29PfAAWZD+w8pDXR4kUOVwixmjAaVSfvHITuHYR26sz7cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wU3/yrT/mrYV9eBcmyeQZSnfOU1xOGR93UaG4cSrpEc=;
 b=aZDOscdb4Xskqltf5A1j0ggkiSMEHI8lUlgLXonvXN4QQ2YH0BqiPyMPE56Tj6mFhswJVwv7O7BbS0xviyP43eFHI9yD81eY9EONpT5Lm2LVSv7wXh6V3e+shn+Gx3KfJxFVz03pmndX/6VxYZrVjEIaPiWC4pttbR8o8HjpPzyotFhASohljX0jzsuqdqZcH78nGN9wqFnrWY8LBr1u6Lb4Rdu383Oj7SAcMIUCj7VWZyj1oQ+FJqNBry4LWWOdERApAfJ5EEI5l12ulZ3X+lWJYn0Tv+wuCAEa8tMybTLpRTPblSyLTQCIf7RFfWyv1XD2HKYDnR8xZfrd8JWfMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS4PR10MB6015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 11:43:03 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%7]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 11:43:03 +0000
Message-ID: <99516661-f05d-47e1-8f13-210d5389b54c@siemens.com>
Date: Mon, 19 Aug 2024 13:43:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v6] initramfs-overlay-hook: Check
 file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 cip-dev@lists.cip-project.org, Sai.Sathujoda@toshiba-tsip.com
Cc: clara.kowalsky@siemens.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20240805091905.1818691-1-clara.kowalsky@siemens.com>
 <OS3PR01MB6103795DE9A6A06EF71DB552C28C2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <4554969f-4d97-4aed-b8b9-d78c2db6212f@siemens.com>
 <8a6f051dd26ee829b386d358569afe4036b14ddd.camel@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <8a6f051dd26ee829b386d358569afe4036b14ddd.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS4PR10MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6d88c9-b314-4a3b-7cad-08dcc044158b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Nng2OUdwUzVPT1ZSY2czN01KdjNmTEhRRVhKRnl0dTlYTVQ1RjZMMkFrMHBu?=
 =?utf-8?B?TGZxRlJlNmVMbVdJY3JHOHRuZCtNd2hucjIyNVVhYWlFcEVYR0dlbGJ5QUZL?=
 =?utf-8?B?eG8vdWtXQlZQWDJkWVdTeVlubmQyUzc2UFpwS1lYa3ppaU5ITWh1czkzaW1a?=
 =?utf-8?B?V3hqcWNaUFVUR2dyR29GbEF5WkczVys4UC9MRFgwT3pONEp0WjRycjhmWWVp?=
 =?utf-8?B?OTVpbDVRM3RhZUxvVWVyUHpHbkRQcWpDRXdSNjF5ZmhYSkZSSktMYy9yUjht?=
 =?utf-8?B?L0VNZi9sMEYyZEVUbnlyVjgzOW1EcDJZNURVbU1hbE5LNjA0WGU0OEdVQ1ZY?=
 =?utf-8?B?SUgrSm01V3NaK1JzL2JpNE9zL2FWRFRVTjZHRklueUZkd00vRTlhR3ZoVjNN?=
 =?utf-8?B?R281SlN2ZVp0NXMvR1p6U0hLbTUxUVI5cVkza3N0VzF2TCtvc3c2cTRHZDln?=
 =?utf-8?B?K0J0T2luRUxnQ3FRQ1RjRmhibjIzM2gwOEYwdHFKc1E1OU5IU3hjdDl6R25h?=
 =?utf-8?B?K3hibm9aSmFIR1R1UGpzeGRLSndxZGh3Q1EvMWVBbVNQaDdVaXZSWnhwZXpt?=
 =?utf-8?B?VzkzaWt3K1NUc1RrMTg5cmVGVE5qVkcyRUNmVFpqY1JkMjIvbmtwdEFWdVNY?=
 =?utf-8?B?T05WRkp4NE16Rnhzcy9RajBuQ1JndWs2RkZJb0VGaDZWa2pwclplWUNNMlhi?=
 =?utf-8?B?M0V2WWFJaWdFS2ZmeStJdFVtWFFsQmNBM1dPOW1ZWkxsZDdBbUp0Sm8zcG8z?=
 =?utf-8?B?RHJmRk1EVUp6S3U2RGRneXpLQUpuT29xbWhUNGVjYWxveFZwUGYxT0VKMktO?=
 =?utf-8?B?bmJmMzFQQUJTQm1ob0dKQlZTM29MaDFQZEdJQnBGdHY1enFLSG4zVGRLdW9K?=
 =?utf-8?B?WGdmV3VlclUydXVWTDY4UlFJbkhPNjc5UkNUQ3AzTk5QZEcrWkhlYnU4SXBa?=
 =?utf-8?B?MVA3RzRYVS93MUxIcHdwc2MvWTRHL1lhQUJ2NWtzSW5pMU53REt3ZjBzd0Fa?=
 =?utf-8?B?Y1VGdUx0WFJYWFlBOCtsd01sWTFhdlJSYmhqQ0lYY2poN01HM09MTzdIbHBl?=
 =?utf-8?B?NkgvK1VDMHZlZVNhUUZMYTNoVDZJSU93d2dadGp4YitOYmp3NGhyZDZ4QmIy?=
 =?utf-8?B?bklrQ0JYY28zS2w3SGpsVTlrMktPWFAzV0wybTczRlY1ZVpRNmJQL2RMRzgr?=
 =?utf-8?B?djlnQkkrbFRuMHYvdDdHVGhmU3dxVzR1VEtHQk1mR0EyS3llU2xNVTBMVzJo?=
 =?utf-8?B?MVpqb1BVc2lxOW03cW4vM0NtcDB0QS9uOEQ5S0dYSTl3NVZVZG10aUtRcFBy?=
 =?utf-8?B?bkVVc2YvUU5XbS9oa0taVU90TUdtYjVKd3IrSzNZWlhoQS9KcmJRdHJRMlFw?=
 =?utf-8?B?QVViZXpWenZFc3JZRGk0WGpqSTNKVFFrUUxITjFZcVNzcVltN0ovSzZxNWNp?=
 =?utf-8?B?b25oVEhrN2hUUzNjQ0xHNzAwMmZJZ2NkWWpYbGlXcVJXb0xBaUtXOG1hZER1?=
 =?utf-8?B?dVpRbEVrMERwL1RKSWhpNmdsa2JaR3ltanFMSkRVYysxQWgvU3d1c2JscjhK?=
 =?utf-8?B?VWRxbzBiNTY1TURtMjlrZWRhWUdYcnpMNTRlR2lnMThmdjRkdVZvUFJodWpD?=
 =?utf-8?B?OVd5aEh0Y2hMUkZsbjlUSFdtZSthTGIwVEp3TjRIdlJvblk3VmNxZzZtUjhP?=
 =?utf-8?B?dldMeSszZlRRMlVEWFVjUEFqbVdSb0ZLd0JoSjBCdXJlOVJMdDA4elVYR2V4?=
 =?utf-8?Q?CWRim7w106F0BOWaYk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SFpHWkE5Yk5taDYrQzcva2hsdWlKYnJZQzlVNTBwT1IyRkp1TGJ2VUtyNVlL?=
 =?utf-8?B?OEZ0dHhBY2U5VDJ6NHZpdThMekVBQUZPMExtaCtLcVI2bE9MZW90cCtoL3NE?=
 =?utf-8?B?K3g1QkFCc1NhWW5RSytNK2E0ZXZ4UE5FTFJBRW92eDR5TkNWckRhOEZWdnE4?=
 =?utf-8?B?SUMvbjl1Y0RIWkhLaDNYK0J2RzJsVFJUVmliN01xTmZLN0ZaTzV5eTdYN1NT?=
 =?utf-8?B?aUw0ejZVZ0xCU3JBTnFlSncrSERJUVlVS1Joa2t6STZTMExXeVVMOSsxZldC?=
 =?utf-8?B?UnE0MTBLM04vUHc0QTU5Vm1vUGpDZEkvdGk3a3VkMXRITU5TQW1ZMWkrQXRw?=
 =?utf-8?B?cmJodll4WURBTDN3bitVNFgweTZsZGJYRU5DQkQ4SDJrZm5HWENKc28za0x4?=
 =?utf-8?B?STJ6Umhoc2NwS3BnZUVyN0dHUmVDQjJFdE8xR0dmbXV2K0h3WWUyTGd1Q2Y5?=
 =?utf-8?B?VXVaKzlyTFIyRFZ2dWFoTEVWU3dEalpVdlMwN092MzFnZHlDR0pjSXZ1MlJv?=
 =?utf-8?B?bjg1dkN1YW1HL1lOMVhrSFlEcGxvWXM5akh1OEs0VGVhQWRxZTVSREZmSFl4?=
 =?utf-8?B?MHJiZlc1N2ExQzllazBFRnNLRUZnTlJrOGV3TzI1Rmx4VUtrYkd4Q1dvY2c2?=
 =?utf-8?B?OUJMblN0VW96RHFoRzYrclFHRFcyMDB5UTUxUWtCNTdWZ1l1VzJUdm4yalFs?=
 =?utf-8?B?ZFpETFdPK295WFA4MXdMUyswR0FSN2ZyUXozZWdCc1EzRjJOTmEwTDU3UTFP?=
 =?utf-8?B?Y1RoY2Uxd3pXSWhvK2hueGNhT3M3U2tqYWNtMDhRY2NZWnRkekdhL2VZT1R3?=
 =?utf-8?B?b2lEUlZveUI0TGdXcDR3YllINDhUU3RRZDFvNXBsQVdqQXBXczdCMXFSTThU?=
 =?utf-8?B?RUpvdk1EWUNvbFRFaU9IWlZ0Mi83eWMxV3l3MEc3REw1cFJrN044clFSazND?=
 =?utf-8?B?K0xrbituTlRRS0dvMi91YzJQUndQL25GTjJYbWl6Q2tvbUlSYVk1d2ZlRm5W?=
 =?utf-8?B?dmxZTVU1RWFHek9pYnVybHhqQVM2N0RxM29CY01laE9pR08yKzQxYVdSSmZh?=
 =?utf-8?B?RFkwZUpOZzF3R0hObzV1eWwzbVR6MXlhM2dhRlI3ZElBajlMTFhsSjd4ZHRQ?=
 =?utf-8?B?Q1Jxa0RFNUU4c2puZnJYSGM0TXRremtBcTQ4TER4c3d6eUhwNkQzTzBBaGky?=
 =?utf-8?B?UTdqNmRLaE5YT0R3RHl2bWdHWXVKQlpvVS9uaXZkeVdZRFNBYnkvQmo1ajBF?=
 =?utf-8?B?ZkxLYVpEemNiMTVRdjlEQnAzVTQzVTJXbmRheXgyTnRCZHh2eU1yUCs3a3Bn?=
 =?utf-8?B?V2wvOGpBQnpWSnlyZ2lRME9Cbk81Mzd5ck5HbEE1cCtMTEZDeW82Mm1xYXBu?=
 =?utf-8?B?UVdxWmJkOWVzUXdJV0Z6QmNEcFM3T25FeVlCWDloV1YxWVNMSnJtLysxWWtl?=
 =?utf-8?B?elltTUF3OFpKZisvTDErbTFSSkxZZGlxbkx2bEJYSktQL0ZsaStqSWd2QUpJ?=
 =?utf-8?B?Tzd6VDJtWXdXOHBQcE1BcU5vVFFTVXd4SXE5TGw2bk5EUGVKcWdmRHM5NFFY?=
 =?utf-8?B?MWlLeW96U0tSMkhoR2lacnlFczArODdrSWxvUUE5UjVWTFJ5RGltbTY1Sk1h?=
 =?utf-8?B?QkRJUTErU0VjczQxOGpHOXdyVWQxOFVhakk4UzNUdGNpRCsrYkpaN1lRelJl?=
 =?utf-8?B?cSsrYS9BZE9uaGR6M1dIaS9zSXNhYkFZMzVFVVpwbGw1SjJ1YkxJZWhabi9l?=
 =?utf-8?B?NUZhV1JXcmN6Q0E3S1dpVGNwZTlNN25NV0QrV2pnK3Z2UHIvWStmbzVtTzll?=
 =?utf-8?B?RFlWR2tSb0JCMStlbXZTbVozbzhVa0xONXFSdDc1RWdYNVQrRFZ4dUk4TVNm?=
 =?utf-8?B?RkN3azE0aEQwaG1IUzc5NFRqYUxTZGttUTZiTTRoU1VaVDYxYzZKSm1LSmxZ?=
 =?utf-8?B?dktmaG5qeElKYUZNVGpVNnphMEpqNXdtdkFnUk53emJQdkEwNmRtaHFhb1Qy?=
 =?utf-8?B?SGlLY0dDVWNEcHh4a3kxSnZNdDR6RkhxWGVPMGxzM0RndXVWYXdFcVhGOWVQ?=
 =?utf-8?B?TDVaZ012T0M4MURrREdnK0h2czhmSlhldFQ4Vm9LSms3TGFFZFVvaE5UV2U3?=
 =?utf-8?B?QmZZZUV4RVUvSnpnNTZuTmhlakd0a1R3VDg1YjVScnFaZUJqZU9CbVE5YkNM?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6d88c9-b314-4a3b-7cad-08dcc044158b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 11:43:03.2683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUR5eLikBqV7kk2PrB9DlDxKPuClLTVN80vsY3CLGRh4LYWSCDg3IzhHVKXsGN96UZekjrVmMURNntjf5VV5G10snhodgcIPb0wqVUnDf2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Aug 2024 11:43:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16797



On 8/19/24 12:04 PM, Florian Bezdeka wrote:
> On Mon, 2024-08-19 at 11:38 +0200, Jan Kiszka via lists.cip-project.org
> wrote:
>> On 19.08.24 11:34, Sai.Sathujoda@toshiba-tsip.com wrote:
>>> Hello all,
>>>
>>> File system errors are detected in `/dev/disk/by-label/var` which is triggering `mke2fs` to re-create the file system during reboot.
>>>
>>> In LAVA jobs, mke2fs is asking for proceed prompt (y/n) because of which all software update jobs get stuck leading to a timeout error. -> https://lava.ciplatform.org/scheduler/job/1180009#L1213
>>>
>>> Currently I am not sure why file system errors are detected in `/dev/disk/by-label/var` during reboot, but this needs to be handled in software update test automation may be using mke2fs -FF -t "$partition_fstype" "$ovl_partition_device".
>>>
>>> I request everyone to provide their opinions.
>>
>> So, we have two topics:
>>
>> 1. How to prevent getting stuck if /var is corrupt in way that it
>>     falls back to interactive mode (-FF?)?

This  problem occurs as e2fsck returns  a 1 in case it need to repair 
the filesystem[1].

I will post a fix later.

In case of a forced power cycle a minimal error can happen.

[1] https://man7.org/linux/man-pages/man8/e2fsck.8.html#EXIT_CODE

Quirin
>> 2. What is causing this issue in our test case?
>>
>> Before fixing 1. we should understand 2., I would say.
> 
> Is there a device reboot involved? If yes, make sure that you "sync"
> your file system to disk before returning from the LAVA test suite.
> 
> It might happen that LAVA powers the device off too early (due to
> incorrect timeout settings, ...) before all changes were written.
> 
> HTH,
> Florian
> 
>>
>> Jan
>>
>>>
>>> Thanks and regards,
>>> Sai Ashrith Sathujoda (T S I P)
>>>
>>> -----Original Message-----
>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Behalf Of Clara Kowalsky via lists.cip-project.org
>>> Sent: Monday, August 5, 2024 2:49 PM
>>> To: jan.kiszka@siemens.com; cip-dev@lists.cip-project.org
>>> Cc: quirin.gylstorff@siemens.com; Clara Kowalsky <clara.kowalsky@siemens.com>
>>> Subject: [cip-dev] [isar-cip-core][PATCH v6] initramfs-overlay-hook: Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
>>>
>>> In case of ext*, this detects and fixes file system errors in the partition device before doing the partition mount.
>>> If the partition turns out to be broken, the factory state is recovered.
>>>
>>> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
>>> ---
>>>   .../initramfs-overlay-hook/files/overlay.hook      | 11 +++++++++--
>>>   .../files/overlay.script.tmpl                      | 11 ++++++++++-
>>>   .../files/overlay_recovery_action.script           | 14 ++++++++++++++
>>>   .../initramfs-overlay-hook_0.1.bb                  |  8 +++++++-
>>>   4 files changed, 40 insertions(+), 4 deletions(-)  create mode 100644 recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
>>>
>>> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>>> index 8b00ecf..6f634c5 100644
>>> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
>>> @@ -22,6 +22,13 @@ esac
>>>   
>>>   . /usr/share/initramfs-tools/hook-functions
>>>   
>>> +hook_error() {
>>> +    echo "(ERROR): $1" >&2
>>> +    exit 1
>>> +}
>>> +
>>>   manual_add_modules overlay
>>> -copy_exec /usr/bin/mountpoint
>>> -copy_exec /usr/bin/awk
>>> +copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not found"
>>> +copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
>>> +copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
>>> +copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
>>> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>>> index 42eb59c..c655a4f 100644
>>> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
>>> @@ -31,12 +31,21 @@ ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
>>>   ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
>>>   ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
>>>   ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
>>> +ovl_recovery_script="/scripts/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}"
>>>   
>>>   root_mount_storage=${rootmnt}${ovl_storage_path}
>>>   storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
>>> +partition_fstype=$(get_fstype "${ovl_partition_device}")
>>>   
>>>   if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
>>> -	if ! mount -t $(get_fstype ${ovl_partition_device}) \
>>> +	case $partition_fstype in
>>> +	ext*)
>>> +		if ! e2fsck -p -f "$ovl_partition_device" && [ -x "$ovl_recovery_script" ]; then
>>> +			"$ovl_recovery_script" "$partition_fstype" "$ovl_partition_device"
>>> +		fi
>>> +		;;
>>> +	esac
>>> +	if ! mount -t ${partition_fstype} \
>>>   		 -o ${ovl_mount_option} \
>>>   		 ${ovl_partition_device} \
>>>   		 ${rootmnt}${storage_mount_point}; then diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
>>> new file mode 100644
>>> index 0000000..d13111d
>>> --- /dev/null
>>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_ac
>>> +++ tion.script
>>> @@ -0,0 +1,14 @@
>>> +#!/bin/sh
>>> +#
>>> +# CIP Core, generic profile
>>> +#
>>> +# Copyright (c) Siemens AG, 2024
>>> +#
>>> +# Authors:
>>> +#  Clara Kowalsky <clara.kowalsky@siemens.com> #
>>> +
>>> +partition_fstype="$1"
>>> +ovl_partition_device="$2"
>>> +
>>> +mke2fs -t "$partition_fstype" "$ovl_partition_device"
>>> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
>>> index 955748f..7097130 100644
>>> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
>>> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.
>>> +++ 1.bb
>>> @@ -12,9 +12,12 @@
>>>   
>>>   inherit dpkg-raw
>>>   
>>> +INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??= "overlay_recovery_action.script"
>>> +
>>>   SRC_URI += " \
>>>       file://overlay.hook \
>>>       file://overlay.script.tmpl \
>>> +    file://${INITRAMFS_OVERLAY_RECOVERY_SCRIPT} \
>>>       "
>>>   
>>>   # The variable INITRAMFS_OVERLAY_PATHS contains the directories which are @@ -35,7 +38,8 @@ TEMPLATE_FILES = "overlay.script.tmpl"
>>>   TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
>>>       INITRAMFS_OVERLAY_PATHS \
>>>       INITRAMFS_OVERLAY_STORAGE_DEVICE \
>>> -    INITRAMFS_OVERLAY_MOUNT_OPTION"
>>> +    INITRAMFS_OVERLAY_MOUNT_OPTION \
>>> +    INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
>>>   
>>>   DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils, util-linux"
>>>   
>>> @@ -48,4 +52,6 @@ do_install() {
>>>           "${D}/usr/share/initramfs-tools/hooks/overlay"
>>>       install -m 0755 "${WORKDIR}/overlay.script" \
>>>           "${D}/usr/share/initramfs-tools/scripts/local-bottom/overlay"
>>> +    install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
>>> +        "${D}/usr/share/initramfs-tools/scripts"
>>>   }
>>> --
>>> 2.46.0
>>>
>>>
>>
>> -- 
>> Siemens AG, Technology
>> Linux Expert Center
> 

