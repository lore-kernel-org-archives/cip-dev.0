Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94500CE7B05
	for <webhook@archiver.kernel.org>; Thu, 28 Sep 2023 06:53:52 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.73])
 by mx.groups.io with SMTP id smtpd.web10.8579.1695884022100810355
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Sep 2023 23:53:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dhBRF1xf;
 spf=pass (domain: siemens.com, ip: 40.107.21.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDn3QJZ9ATSVsLEprqi/7StPvhanRYde+OPSZboUR6xblKJM1ibSke1+9z9nDINijvkRNV8J7fFjlaLRTBj7OV7YDwMf/PGkZKaeAtz0Zx0kXwUy0BPBQKbxl1zcOfFJqbTfcsoNAog+vZ4cbjWsfHdlc7Q1M3FcDndRR2MZ3mu39Uzpb9mmd/QSljam/saYTKzkVN52a1Tw2qtMnj3DAnlrdYBZUNsUSSOHqJu/K33aUAnHndhZ4r1lwOFu5nyDqaJgnX7JfqIfVj3FJPT8rivw8mpm+VxI8f2DO60qe/6u27HT+yll/1hX5CEf/PxsEY+Cjspp2PNY6LFoZHJyIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZB5AugJ6sR/P3XUyb2TeI4Y8G1oCrRaKYHVdHlYksw=;
 b=NgFY6/Jw7dTtmbMv2P0RParizexGDSCmzcM0zrrbCj8374RmP9VJo13aol1HhO+D4j4cvjRdw9nc7XWPwI419miB6cCWrzb44acEpJObXy5uT0/fOzqR26ujfzamC5YUnAv8sKKxRLGISesVcf3/KASE5X1ntl56h9ajr3zR7dkTO7AY8WNcpPJfN/omhUNcpsA0yGYr268479RuPc2y108HF+HuvpejA7R/iRXXw8WMhU7w0mEHdYkcG7MhGxUJmBQVk2XjbyvtNNC6wU94JuYU5NF14z7dM1bY53kpmkS43SKWMa8hkUiQcGeCOR9/KFDcn+DV3zHPVvQhBwwlUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZB5AugJ6sR/P3XUyb2TeI4Y8G1oCrRaKYHVdHlYksw=;
 b=dhBRF1xfprw7EcQOwE8FpXL2vKekDAlSUcmdULlr2D4IEnkY/WTsE75GFOyEoLv+591+tzzasiFqvO6t8dZzQisheJLHHP1PzgTWjtedVHbwxf64aRKj4J7WgeZFlTBQxUhvdCwzgW8/PRWzdUqpByv/1uIZxeDq4GxvSXMg1dN+SYnjQggX/C0HFn9a6Q8vJ1kgCaX6d/VrvORVe1aD3I/IGrxO1n37QGEJvlwF+q8R5+dooIw8qgsNV1I7j0fUPiKGXEKkg59v8ud8NWLPSgZkB03eSgKTvh8QsGy5W7X4ik1tup3QR70CUZjoEoeqWIynkZK8zqo/A97skkRKjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5368.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Thu, 28 Sep
 2023 06:53:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 06:53:39 +0000
Message-ID: <1d2ec472-0fb4-4d3f-bdb2-a3c1ec0997cf@siemens.com>
Date: Thu, 28 Sep 2023 08:53:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v4 0/2] Add dosfstools recipe
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <1788B037A0B186C6.25332@lists.cip-project.org>
 <20230928064437.12654-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230928064437.12654-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5368:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fcbe317-0d32-4f11-781e-08dbbfefa500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jvxosfGDuM/zwkm9B0QaCaPVlAJRLvUUqeTHjUUU3FNrwYjDWtjJf1gBBNg2b9LEa0BoSvldA8aVxoyWb5XM/EijBlNzPhd70hOKUaeDYOVKMnlABKUHO6Kf3ptGhbN6KAnhv1/qE2v8PtjtlpNvpBjTTsk1WUvbqHefhUhz/LoqrvstBLnrQ03+gZyvOhbqbJD/YnBGZfZDFYLkuXjIkOcfdRazD7inZE6CjXfD8QEn11LrdFyiAaZGbgUr3zXf+Gn9hyIDimclRv5SovG44Q/sbkUI2Fl2usyef4AAV1IIMEsBs055SnR/XggiJwEG5Xtlu4UE8cTszT/1f6K/jXZae/8t2GR0BqO3EI+Q5wtFhgB57XbIX48q26SPtpBzxk0jfvUz9c8TZp99uIJr8WAm9il6omCb2QGSMvl67YAxUrPYMXqzd2v8mnDU+dXnaKiIBPWy4H6Jntv8Zx6O8+gsj64tZUReZgj9pa9MnJKw8w/LHnCHWijdGC350upL+QBoxpHeQhobDAq8Vv/5sFZGD6G65l2VNtKJFWuKpDmwruw3JsvTEDRuafv1Yit/r/f2BWchlTTxNJ/0wK7ggtgw/B9acoNSQQRyA6ErRnm0ypFng9h0zaDK/rnY+/LKq5SqBUXYgQhyDtgatizHwg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(41300700001)(5660300002)(31686004)(44832011)(4326008)(8936002)(8676002)(2906002)(86362001)(316002)(66946007)(83380400001)(31696002)(66556008)(66476007)(6506007)(53546011)(82960400001)(478600001)(6512007)(36756003)(38100700002)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M1FSRE1tYS9LZUg2OGU4STlIdG0wa1VoTERrS3VWemRjdFJZVlhUcGxGcFJW?=
 =?utf-8?B?Ylp6SlhrV0YrSjRRc3ZaeEtrcXBUNzNNU3A1dlhXQ0pPRkUrY21RaUVtT24v?=
 =?utf-8?B?RlFTL29YYXFtZ3c2bFNncnFKU3RlbWhOT0tTT2VIS1pXTlJ5NHgvcE04VDVZ?=
 =?utf-8?B?akZhVmtueWp0bnVFU3UvWFJRSDZFMzZ6M0djQ2V6SHp2UTUxZHdFMDQ1TDRZ?=
 =?utf-8?B?cE5GY2ltSnZ5aTFxSlZneVMrd1Z2OW5lWDhwVmtrUnMrZ0FJcUVPc0pwc010?=
 =?utf-8?B?OGU5eWFWbGVQQjVRcG4vNHR5Yng1ZXVwLysvV3AxSkd4My9KNnJva0tOZ2ky?=
 =?utf-8?B?eDFjaVhiaXZUcnZ0bmlZTTFYTSs1TmFFYUljcEVSczBxM0ptYkVlZEIvYlFn?=
 =?utf-8?B?WmZETXllVXhtSXgrZ0oxUWNIb0FJTDdkV0dILzlqY0VyZE83cmNOSG5ZTjBo?=
 =?utf-8?B?d3gzS2VjNjBwZWxuakY1NCtnVU1WTCtPWGFHSUVMaDlZbW9KNDZ4TWswaTFz?=
 =?utf-8?B?R2Nyb0JlTGEzTjN6NkxUaE5jU1BsVDRUVHNFM3Z5Mm1iTWtoSG9oWHg2aWtk?=
 =?utf-8?B?T1hmNEpvWkxka3VBRGNnT01FbHR5ekdUOWZiLzdJcWU5L2MvRzVmQSsrT0I4?=
 =?utf-8?B?Z1djOWpCOURrcXY4MHA3UlNNUkFLWFdyQWxMbzdpWC8vYXV1UlFYR1JQUDRI?=
 =?utf-8?B?TFhqRnczWUVVQWY3MnFNUFZ1WU5FenlpQ2FjYThkYjdxcFFKZnJtek01Qzlm?=
 =?utf-8?B?L25yOW1pUUNueVA0T3RUU3EzYTBWVkh5Tmk4ZXhOR21nS05sa2dza1puaVF6?=
 =?utf-8?B?NGZXUHVvRzNEMWo0UFZpOUo3N2VLd0FGMWpzcnhBbGNnK2N0cHBJYjR4cTNq?=
 =?utf-8?B?eFBzR0x0UTRUbHlyK0FiTzZqQmhOT1k4NXU1SDZlTXhqc1JVT00yTkd3ZDZP?=
 =?utf-8?B?dThMaWhpVDY0V0IyN0xOOXkrUmxUdlFzS3NwbXM2MnFNTXI0TUlSZnk1TGtS?=
 =?utf-8?B?NDhMb2MwYmNadzVxaWN3UlMrTUU5aU5QaUJIWVNOY2tBU3lHVmU4QjRpWldS?=
 =?utf-8?B?alRVbS9ydlo5RjZYbUVBMnBEdVFRUTRLYzdKQlM4V0Y0a3VsRHFyYUZMN3Z3?=
 =?utf-8?B?WXUwcnlUQXcvMHVCTTBDZjY1SlFJQ1J3RWo2TDRBTndWdWRuMzRqTDN4cGNL?=
 =?utf-8?B?K0dqYXhOUk53eWcyYURpSUp2Ynljb29sVElVeGxFbnpiS3NHSFVOL1lPZXFo?=
 =?utf-8?B?dVo2SlNvcVdZbmdDKzdSSDd1Q251QlZGQ1hqVXoyeXliWjY0bkgxU3BTS3du?=
 =?utf-8?B?WldmWVRHYzdJWENrU3kzb3c0eUJwbGZETDBaZkJhMkZIa0FtNDJQYTRhRjBx?=
 =?utf-8?B?Mm9Pcnk1UHRFdGdyZXIxY1RoVXR5d3NVbURVRm5iVURTazJuUUpFdkJTTU1m?=
 =?utf-8?B?TmRGSnJIeGE0UERqOVM5cjBHQ09IUzB2MElhanQ2SkpkOWkzcGxLSTFmYlpW?=
 =?utf-8?B?LzNMTUlYNTVPQmI3ZlRlK0M4NWZmNis0eW9GRVdxOE4ra3o1cVM0YXNOZ05h?=
 =?utf-8?B?V3BoQWFwTTVmcjNxM0pVUVdSeU1yU0hreGlnVWRsTHp6eTJDMkdFUFV6Qkk0?=
 =?utf-8?B?YmlUeGJDUktCZHB1YlRkcDAwS3VJV0dKc3daSWtIRXcyTWNTVDkxV3gzVk1i?=
 =?utf-8?B?MXEwc0p4dmd3Ly9XcjhDclpsT1I2cTV1Umlzc2F3eTFySlJENXF4OFRyOVN1?=
 =?utf-8?B?aEtia1NtVHRESDFoeHljOWxtRnVVdURCSUFMdjZyTGhWR24rdGRVOU8zb3NR?=
 =?utf-8?B?QUVGY0N3bGNYQk93cnl0UjVxaC9SYXk1R3RyeWZPazEwVVV2L3pVcmN0WGM4?=
 =?utf-8?B?dWNHcjNGUTlyM09yWUhDZ1hnZzRpUmp6emhJMkI1ZGF3NWJ3Z25BWW4ycU5H?=
 =?utf-8?B?NVJ2Zk5kUUVoc1VPUnVvR3RuRmNZN2JrK0tGTFdRZEFWdXJVekl1b3hkaFo0?=
 =?utf-8?B?eCtqY0c0NU5OVldwdWg2d2lVOS82RmUwOHlIaThPazVWd0lGMGo3T2x0MUlZ?=
 =?utf-8?B?ME9HYm5FQ3MvMWF3ZXFEamptdEZqQUJaZXhXZjk0UmdiVHBTaE90NS9Mb1VV?=
 =?utf-8?B?OHFpUFBlWGd3STc0c2MwMmVWSUU2Z0NOS002N1NLMDBHYmZFTWlraCt6V1Nu?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcbe317-0d32-4f11-781e-08dbbfefa500
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 06:53:39.1062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYGc6GOmgvGphhFCasI9/1ehHEJ15++omtOLjqm05xSQRz5AD8Vlb08RRp/N0VIzcIeD5cHKgQ2+n/8b1BvNsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5368
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Sep 2023 06:53:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13245

On 28.09.23 08:44, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> Hi,
> 
> This patch series add recipe that build custom dosfstools and use it for
> creating reproducible DOS images.
> 
> v4 changes:
>   - dosfstools: Add recipe to build it locally
> 	(No change)
>   - distro: Set dosfstools as build dependency
> 	Removed dependency for buster release
> 
> v3 changes:
>   - dosfstools: Add recipe to build it locally
>      (Remove dosfstools dependency from reproucible option)
>   - distro: Set dosfstools as build dependency
>      (new commit)
> 
> v2 changes:
>   dosfstools: Add recipe to build it locally
>      (modified from `dpkg-gbp` to `apt://`)
>   images: Add dosfstools as DEPENDENCY to all images
>      (new commit)
> 
>  conf/distro/cip-core-common.inc               |   3 +
>  .../dosfstools/dosfstools_latest.bb           |  28 +++
>  ...Honor-the-SOURCE_DATE_EPOCH-variable.patch | 160 ++++++++++++++++++
>  3 files changed, 191 insertions(+)
>  create mode 100644 recipes-devtools/dosfstools/dosfstools_latest.bb
>  create mode 100644 recipes-devtools/dosfstools/files/0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch
> 

Thanks, patches updated in next.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


