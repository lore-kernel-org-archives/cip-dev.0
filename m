Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5708EE9381D
	for <webhook@archiver.kernel.org>; Mon, 13 Apr 2026 05:36:49 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.265588.1776058603081926792
 for <cip-dev@lists.cip-project.org>;
 Sun, 12 Apr 2026 22:36:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kjj+sQRO;
 spf=pass (domain: siemens.com, ip: 40.107.159.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ie0bIx1COMLCSYSodLUnS06b3CCUT6c31OygniCYhdN0j0fSR/6xod8IQTCALKY9E2N0Adcf43O+hH0ZKBwdBdgh37GP21jrmloXqY61fT2m7i0TlEJb6pAPi7GTnIVW2I+ruX0al/HWrYQF5QREwlt0Z7im4tBm8s8an1Ec+jPRLjCtP176hW/qH16ksfqFew9lmbNyAhmVD7NkfdgpgV5ciyd5q8wej0+2cGlFmtMEJJaQm31HkPMDSiwQKMFjFN9CQLVcbNP9sIV3XQoaaAcHOIca92PM5gTqlVb/3PyMEhv086+aocwIdXrg2PjS371sH7jUboWe8kKSp0oiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G+qKhqrgIxefEb68v8ooI6GzyiQ9haGuvDoBnKs6h4=;
 b=hLclrs+DcHM5HmzzdRCYY68du/EsFLshB0uHcPk6Kl1btSrnOJPbNS3WEdEU4cGZJBszffcVHOE108FpPC2gVGzy/SlE9RzXseNc4aknl7PScsrX/uejV0d59mUvUFHQlGQSMf0NTeomQSHXb2FO/WdJVYO2f73dy5Y565QBhz3bt8/qp3LkvxQftjkICARA+DuurCCZOuTdE2QuhXgzn+guZzzcZEoW4hhjJIa53ectW16kkz09a4vzj6J8QKXnNGFcDdrzyvZTnnWqe2FiEPodBf+buEbxPDVDa531CLH9YcvbZUxrwMooOo5/5aFU8PJm/3VxfrXYQovZDuNGvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/G+qKhqrgIxefEb68v8ooI6GzyiQ9haGuvDoBnKs6h4=;
 b=kjj+sQROO8ZCjdCa3XScbDAzogeV8KDf+sa4QuyJQfK0PaMmMTKIfV76W/V90Thigo3HipYTFR3OHeQeGoMy9nzd9QvSXVwacipLqAtTsMnqWDnXTX511GBGsLAqRQuu1S29l+DhAi92UHxvvghlJapkkcAJz4Cv3CNtez46TxLj91NkJdIklb/5SK1S4qlK2J+25ochoOCHJf9tMpvEPYzCqBtJeGOIeRjoAMcdEsRIlQ8Uan+Q9NW1khjIpw/Pg7NOymXim3u3j6ddWyD+hP61jIwvjBq6mU707IH2kB2R7HT2TtODKY4z8eXBN7pFvWQ7qWN76l5ACwpBTaFfIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3473.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:151::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 05:36:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 05:36:39 +0000
Message-ID: <52d1c70f-ac3e-4f4c-9593-c20f08d60e9e@siemens.com>
Date: Mon, 13 Apr 2026 07:36:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] Release v4.19.325-cip131
To: Ulrich Hecht <uli@fpond.eu>, "pavel@nabladev.com" <pavel@nabladev.com>
References: <459507685.15146.1775979436923@webmail.strato.de>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
 "masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
 "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <459507685.15146.1775979436923@webmail.strato.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3473:EE_
X-MS-Office365-Filtering-Correlation-Id: 7980fd98-68ff-46ad-7679-08de991ea2c0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	WpypWQWmqJ65ujND9SSlrXs7Z9WOcL7WqIjux2TkMDTmsz1tRKREE5FuAzsk2LHknpNeEXwfc9g5oPn0cYwBYIO5gtyr3L4dCSKoXP6xwX0ImV3QtI6fTxVFoIzsbUbp4x4VrfL3Z3Sa8AQyC5Na7lg8vnoHuUnx9dEgyLm6ChxYH7NCrdzxLYWw8iIX7hGUoL0Bvs56st6kKLO2nouPd581RijXk1RM/zDOknqou5Zw5NSuyRHSfMVVXB7Oy907NzBMeM3juDn5bvpN9j9h0nS+rdQ0hPAD92ZOBemQE9TZQOF9ZyZv/02EnWu8W8q5vSHL0+5mXoDdDg8D+Mx7nC3LumUgClSHhycFgxYITvWksv1B6FCz5/wnyIFy3OVmGZFHvF3zFyX47H4qRGAQ8EOXv45dpI2dNn6XBuEavYvdoZVyMt0qJJ6xScp5mCvyO+eO9t0e5JU/m5AAKOHO6LZo5lINUEOwLd4+MiyqLUofKBHIs5h6TNrySdodiT/Vuwlxg+dqVzS2x9SovNKZADpo5cxmnvTibSbZPAOLzKO9dVGkQgs/ty+pj7/SxAgTLfzPbnIn9FQyIG7YbYHrm3GXv3ICRSRjwLoUipjZLGyuDQ9x3j+QlHW1qcNQ67Rzp95nP3DjpIAS1HEBmBgeJECnFD8ysH1qa44fRvNiz3wp8k81l8yEGiLKAvHfDkYbK909uLg/ilwnMx4j3LuWntR0ZETQ0c0aqAvzhax0aAE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Mlo4dFR2cjBzNzFqYmlrV1FKUFB5YVVTbWx5bWs0TlF4Q3IxUUk0azdEVjht?=
 =?utf-8?B?Um90bFFVOHFzVXltNHA0VDFTYmdrMEZHdmpDdStBYjIwc0N5YlowUmlDZGtG?=
 =?utf-8?B?WWhVUmpOSWwzeFQvcmxOY1NwZ1FJV1AvbHhyTFJNekpqMGZ4ZCtmR3QyVW10?=
 =?utf-8?B?L0JDY01QNmwveFBkc0FRaFZQOFA3UlFkeS8reUk5alBpbzk5TzRka1dLTHFs?=
 =?utf-8?B?Q2Zna2tlMDhvbGZTTW12Z1V5bXdQM1JPMzBobDJaSGprNzBYbjB2clNZYVpU?=
 =?utf-8?B?d0h4RGNvNDVFUG9ZTGZMczlMQ1YxMEptdVRyNkVHWmZaNS9BYzJBVEN0S3Bo?=
 =?utf-8?B?Mit1UkZzYzRyd0Jlb2hocXJNUm1taCtnRFdxWTVSR3pCNHQ0bHVqRjFDS05q?=
 =?utf-8?B?M1ZQVjR3a1lJU2M3M2QreHBtcUNzakI1TGdPRlEyNzFmUnhyZDU5emJPREl3?=
 =?utf-8?B?RS9MdVhjclBqYlNrMmZ2K2JYSDRneFJHWGt2YzhCNW9NMjVuZHRPMktGOEh5?=
 =?utf-8?B?aExVUVlPblNsQjlWNDNQYVBCRi9Mb0QwRjFKdkRJdHRoeE5lUG84Q2R1cVZ1?=
 =?utf-8?B?YWdESFR4UDRYSTVoYjE1OFdHSHQxdmJjWGJqMFQreGhoMDZKNXBKbi95ajQw?=
 =?utf-8?B?VVRueXpubm1xY1VuaGd5Wlh1b1ZuVkI3a0o2eFFidDBxQ1ZMUWV6YnQrYTN4?=
 =?utf-8?B?M243Rkh0THdwZTloM0ZsWGNCZjFSdlpRdW9RZDRRdFVrWGUvQUxkWnlyaEdO?=
 =?utf-8?B?RFY1blo4UVVJNVFjQ3VES3E0b0dWUlUxQi80V3p2cXVyb0NlU3hJMkIxbWlz?=
 =?utf-8?B?NU1JNit2c0U4dEJ4UEpjOEJmcHl6YXMxRVdXenl1bGF1eldNRlNuem5zbE5N?=
 =?utf-8?B?RGlJcjhWRUVrL2dNRFpNUFdyZ1pmNXA1WVRIVTdKMEo3SjZpNWlWcW1XbUls?=
 =?utf-8?B?TEhmK0gvYmdIMjZzd1ZzaEpXVFhZZGJnTHNRSXJrUitLRWVWblpwblMvaDFs?=
 =?utf-8?B?Mm93WDdSbEZ2QXpOQnFJV0IvYmlxT0gyTUdKaWNZZ0FJaHp1QWorRUlFRnBn?=
 =?utf-8?B?L3hGWmV4SFhaNGQyYWoydVMzNExMQ2FsR29ka0FabXpJS3RHWGtSWkNPZVM1?=
 =?utf-8?B?QllpQWhxT3ZyLzdIejMrbWNWb0xwVG1zdlN6SlFMMVluMFpzUlllQjZFbjlE?=
 =?utf-8?B?aHV4R0o3UTljeVdla0UwZ3dRYWtqVmc3WFZRTmFKaXNRWUk2cGhHcUhuYzFS?=
 =?utf-8?B?dWlpVytyc3ZXK1BIT1B6a3Y3WGllVFREam5rdS80VEQ0TEdjSFM5QU9LQzdh?=
 =?utf-8?B?TXdqRDY1Z0szRngxZ2RiTEU2U09NL3FvZ0VqVGI0djdwRHYvL2p2RGw5OXhP?=
 =?utf-8?B?OFVDZXdzSyt5cmlaTVN1MDQxWTIrQWt5U093Z1hoUm9ZTjYzMDU3aFYyMjcx?=
 =?utf-8?B?UkMvek5GR0JvckVEZXpVVytoS0NHK3JzeE96MHN1Z1Fkd3F1ZkVwb09ZNUFx?=
 =?utf-8?B?N1Q1THJlc3MxZW41cjFBZ1lxYTFBdVJVZXdteWJoY3k5Y3NtYzUzTmlOUWpZ?=
 =?utf-8?B?M0txYzB3Sks5eVBxUG5yWHJadGRsSC9xU1RjNm8yM2JMMFdSRU0yMFFoRk9z?=
 =?utf-8?B?U1Qrc1c2d202cG5Oa2h1QUpBV29SalNIVkJ5b1RIVnlmUzFId3EzWFY5b0pl?=
 =?utf-8?B?Ky84QlNkMjNyK2JzUWgyMUhmcksyUld5Q1RpK1JSbGVMTmVMQ1VlZnhma25n?=
 =?utf-8?B?b3hid08wR2JTblU4NU5QVWV0bm9PQ28zRWR2MUpiSnBBMDVNUzlWbGtwY3NR?=
 =?utf-8?B?ODdUbWJxMUZLbFhUN0RFMzRHQjY3ZjIrN05Vd1hwcXRvelR6a1hvcUxNbTdT?=
 =?utf-8?B?WXN5SUhseWNxaEk5c0FaMmMwSVFBUWoydlloaDAwVzkxaDZZRjB2TEJ2SVdw?=
 =?utf-8?B?NDB2QUIyaTlsNmljdUZOK1J6ZllpNmpKRGVFV2hoVXVwL2s5T0JjT0dMNkhi?=
 =?utf-8?B?N0RDbGY3ZTRwWGVrWVdpdnVmZm9YZzJtai82RkVGbC9RcGVpTVVwSndPTWpQ?=
 =?utf-8?B?T2RDMS84SlN4R1VXMU1ia3hIUWN4b1FCUklMVXdBU21Rc1pxNGoxNWxreHlE?=
 =?utf-8?B?eXkrVzRjMjNDdjhiSEYyZnRwSFdTSlJndG8xeEl5N1V1bEE0S1ZlbTdBMlBu?=
 =?utf-8?B?NDlmZ3lBVENQVWF1TExjbmxvVDQwdW04NG1tVyswdkFIdkQ4Nk96R2dXTXlt?=
 =?utf-8?B?NkZpd082WHdkMjZxNTRsbWRiV1BYalFpMWdna25ENWV1bml5ODJwaytrSlB6?=
 =?utf-8?B?d1FnQXgzRjFIWU5nSHloQ1ZqSWFPUGR3RDNjbU8zR25jRU01WnFxZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7980fd98-68ff-46ad-7679-08de991ea2c0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 05:36:39.3466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLNL7uYRSpDXE0N3TYXhd3h01VsGnA3HXnyHLI4aOgtI9ZXmn9E3af02FtvmuqOEjclatYphUVJsDfo2Ckj19A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3473
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Apr 2026 05:36:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22676

On 12.04.26 09:37, Ulrich Hecht wrote:
> Hi,
> 
> the CIP kernel team has released Linux kernel v4.19.325-cip131. The linux-4.19.y-cip tree's base version has been updated to v4.19-st15. The trees are up-to-date with kernel 5.10.252.
> 
> You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/
> 
>   v4.19.325-cip131:
>     repository:
>       https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>     branch:
>       linux-4.19.y-cip
>     commit hash:
>       7aeff6c7984c582f96916d12bd33eefbd746459c
>     Fixed CVEs:
>       CVE-2025-39889: Bluetooth: l2cap: Check encryption key size on incoming connection
>       CVE-2025-71239: audit: add fchmodat2() to change attributes class
>       CVE-2026-23241: audit: add missing syscalls to read class
>       CVE-2026-23243: RDMA/umad: Reject negative data_len in ib_umad_write
>       CVE-2026-23273: macvlan: observe an RCU grace period in macvlan_common_newlink() error path
>       CVE-2026-31411: net: atm: fix crash due to unvalidated vcc pointer in sigd_send()
> 

Looks like we are phase-shifted on 4.19 between regular (-cip131) and RT
(-cip130-rt47) again. Was there a particular reason for timing things
like this?

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

