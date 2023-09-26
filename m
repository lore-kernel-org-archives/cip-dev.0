Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3060E7E637
	for <webhook@archiver.kernel.org>; Tue, 26 Sep 2023 13:53:43 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.57])
 by mx.groups.io with SMTP id smtpd.web11.19403.1695736422480428815
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Sep 2023 06:53:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XoYcDEth;
 spf=pass (domain: siemens.com, ip: 40.107.105.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1eE7qoZTFnE7Tr+/G3bnhpJ7BZrVZqKZK2Z8sod6yVEdOqaqILAvPjTSZT4uKzCE+xkAm50H5D1trRuUayF3ahqwWyiRpHJM2mzL1Eb+oEZGzoO0xEig7Ajtf2lNtt7moRj2jj6DeKYE8828GcYUr5+9R9dqxoddSJqI/2c2Mql7L31m6REw80fisLCQMgaRefteMIpVtMX2TE8BhXdYGJ36wJ/wfG/56kWhGpAWzn7JXdAk33CBaWMUiwJ2YfuKfiInT7T0Jzxv8xK0YSlIoirkNjBftJXLjWtN/8SOZrxrXpOa6QxWxXccn+goARWqAqggWHgy8LxtW3XdAKtHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQf92Ye0y7uMs8LR06xKkjmlO0drQbglUSzJ0S46uMA=;
 b=DbFCGSfBd9z6ghLfKMMChVVrgW0GuDl2a8c+gcABbFCtXaUUkg5A6dTbT/L/IwI+gJSOaJHADMWrF6w519vDoyUOMvFZTLG/Slhytsso7vI6mwCrwLduMckJXMs4CyDjH19TfkFbxUUKvAimXJRwsT440NwYMxvUsQdOnwKNSMoFHi21VTW4MIscc4VweKDVWXslT18NHiOhsaQ5Mtb2VV6VrdipMnWwuMGE1C0WxZfMi4kW8GG6OFkcNTTYjRG8FrP3/NXjdR3yXwI8HytwIo3Xo8HR4GHa5QpUk3r9OVLNJlW1DVbhG+YtIf0sPuWJ1C9/NMp/Xm60XBZIa/T4lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQf92Ye0y7uMs8LR06xKkjmlO0drQbglUSzJ0S46uMA=;
 b=XoYcDEthxnI6jI+Quq7LvjROXmx0WbjHTWUI4y0JKWCDFR4RdNiGjzato7Ybgq2hq2GsZI4zMklR2k0bz+nZQMF3ulRcVa/Ze32pBXlk5yBDaWmbxI/E3l03qwFBwhNLepM+D6tPoU6VMsT9qZYNFBDxM6yVZTRkqw1mCCjJPAMcfWSTO0TW1zcBw58D3QgLA3yD0MlRzymEi3dHGOcWc7qI/w9YzDKGoj/VBinlc2+MaXGy/C6Eb75EymiIpY2YyllwlvvxMrp66H4V+x1NDNs09YKCf6/r/qBLN2JmtDYYV97H08kVBT0XoSOgw7Ve9XgT6NJ56ZF5vDrnGgz9dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6909.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:328::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 13:53:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 13:53:38 +0000
Message-ID: <ed42752c-3a2e-4e47-9d48-f10b2c89da13@siemens.com>
Date: Tue, 26 Sep 2023 15:53:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: projected EOL v4.4 SLTS
Content-Language: en-US
To: "Kadel, Michael" <Michael.Kadel@karlstorz.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <DS7PR19MB5976CF5A1AE42B817D05116EEFFFA@DS7PR19MB5976.namprd19.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <DS7PR19MB5976CF5A1AE42B817D05116EEFFFA@DS7PR19MB5976.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 433b75e2-b959-434b-33c0-08dbbe97fc29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9pkj1GqdYgdRoYKUOW0gXsCytsM5ALrOZcCU0CcUcpWB6uhWV1saUc5d+gOzOzae0euQqXgrFzcAyXymMJnof3WA4Ie7hNAE1l9qKCMfZ6rAcP4zRqzHm9KgXnpY4GGc16tVc9ArGbQkLE9QKniIWbXf7z9Blxgtc9B1gjdMP3/UP+w81A/KtTsHv8uyVIjwgm5wp2h6KNmXSEnYPEDZHNt47ZyTw6H3whCXy2IolM8DL6x8a/aYrmR9jEMYVMQNl22GC7ESSPJwj4+GS4j32DKc9lpq+U1QP5dmun2ph5F/1xWoKNr9LktYP6lYGmkQjGYg4I6BLG2rQEC5fyAoZpmh2dIQ1r6g0pN0zQ9gMDnQeIGgDtDA7XlaFvwUaKI7Kfk34UbToJxsPwXPdwsO51JXjX9TOUEGVX8msLOUojjAoOqCwlIHk/OuUWzgjt/zbPDlaqoQax/ViKmi9TL7Sa41amHXHOd7MMpUSitTgWcaUfZKT5joecO0xBYfh+R0JyfAnpjE9Tef+IdxRGeJJKJagnOcepjdtS9WVEt9XwK+I/i2eThlm0REkqNZQGQeOaaFch2DfR4J7+S/DWcMyO5WbdxWhPN4QTur+xqE5oGaEBGS41OFRw/OFaSLirxD
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230922051799003)(186009)(451199024)(1800799009)(86362001)(31696002)(36756003)(31686004)(6506007)(6486002)(5660300002)(26005)(966005)(53546011)(6512007)(110136005)(66476007)(66556008)(66946007)(2616005)(41300700001)(316002)(478600001)(44832011)(8676002)(8936002)(2906002)(82960400001)(38100700002)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YjErUDNDQkN0Qk5UMWE2UjlOeUhYUzh5bTRGOVZ4ZHZrZzlld2dNVlNZcHY1?=
 =?utf-8?B?NWh5YURMMDhTR2lzeVRCdE0rcGRybXB4dCtORm80U3lvbjNNaGVOZDNsY3A3?=
 =?utf-8?B?WXRKYjlHNXZ3VGc1QVhKN2Z3RVNwQVNuMis5ZXZhbjdxWFliT1lIRkF1R3Rr?=
 =?utf-8?B?R1phUFRWY3U2VTlDcTlvNGRqdEZia0t4UzF5VjBvQnQ0ZEg3cXdXVndvbk1N?=
 =?utf-8?B?a0xETnRVMytwSVdJR3RRK1dqUHY4b3N5RTA0S044NzVGME8rNTVHTTdsRjNu?=
 =?utf-8?B?c2pTYmsyQkZGT3dLcWdPT1ZLRStGTGJIUGx4TXZEMGdEbUY3eGxMT2ZpRnpx?=
 =?utf-8?B?RlkwdCt4Sm1GTklmcnRuZlNxUEdhVmpkc0Z6aWRnL0MvOVVMbVJnMDhQZnVW?=
 =?utf-8?B?QnZ6c3VnaDJqakJOSnJ1TitRcDV6MU43RUJ6QU1HOEVDWXExcFZtRnlZZi9a?=
 =?utf-8?B?eDJBTzdEMlpOSzFlcWcvK042cFU5UDByOFlkRE5idUQ3OHN3NzNoaDdTL2c3?=
 =?utf-8?B?RVVLbzBsSnZRRFZQWElHU0hUazFWVkNlUU1LTCtGNW5NNDBhSnVvZm9Oa1FF?=
 =?utf-8?B?Qys1R1RyNWtyNjFDQmVZcU9NVEN1MHAvSEhuQnBQL0ZBY1Jsd1dybllZK0ZX?=
 =?utf-8?B?OGdXVmt2RThzbDZjNHNhenZwOFdrakZlTEM5Q2JBNnVEb3IrV0JKSXN0YjZl?=
 =?utf-8?B?SWp3OW96aTkrT0EwWkRKb0h5NEdqTmhBeHBFaE5ya1F0WjI5TGdxMXBpaEhD?=
 =?utf-8?B?VUd5TzNpK2lZYk02M0tha3BXK1FnWldvTHZCanVCc3lHNllhNCt3bm5SL0NO?=
 =?utf-8?B?MUZMT04rY0F6aUdlS1RNYUI5WXVHVnhDUTFGRzZXN3pyaG1CRDUvSHh6Y1Iv?=
 =?utf-8?B?L1EzWnd3YkhvdHJJa09IT3lTK3dJWDJYL0xMT2h2N2tKZkFwcXNIZmRXQlVP?=
 =?utf-8?B?SUROTXZiV05oSmEvcndIbStDeXBGbFhLWmx6WFV6eTd5b2hEb2I1TlNMY3NF?=
 =?utf-8?B?Qm5CL2Fsd1A4OEYrRVlrZ2JGd2J3SkNWUjI5bDZpb1Irbk5SOUhDSHR6VTFW?=
 =?utf-8?B?cU8wYk9VMUs4TlpkTGxnVXlaOG5VU0huczlhN1Jld3g5MEE4Mlc1c00zSEI1?=
 =?utf-8?B?VkxLdGt5aWtodk9QSG04OU44SkUzMURMTGJIdU9QZW9kK0UzYWJwQmhyQlN3?=
 =?utf-8?B?WnNCRmZQRnZxb2VKa1VmUzlNSGp3NGVhVnN4b0JNbTV2bW1wOGU1K0EzM2lp?=
 =?utf-8?B?dWc5Wi9tUU5zWWlLb00zSGpGMDk1MGV6RzJrVFlSZDFyZmNNbDVCaGZzaThn?=
 =?utf-8?B?eGs4azlWamRHclNMWGY4TzQ2T2RCQjJqL3ZPcTRPeVY2MzZ5V3MzSy8yM3hD?=
 =?utf-8?B?Zi85SEY5OWpNSGV0cEx4eGkrZXBlc1QvYTZwZ0hubmpWUFpiWk45bWU2cVBk?=
 =?utf-8?B?L0ZhMStubG9mSVlCZVZpQktDNmJ2MFdEZVk3Ymd3MmZ4UDBoOWpNNm9WcHps?=
 =?utf-8?B?ajdqM3VyMk9uOEx6NzRETFd1b09JbzhjU0pUUEpIWFNSWVp6Rmd3RWxlMTVr?=
 =?utf-8?B?cDVOZUk1L0RGUCt5K2MxRkFYK3hxOW1FcWhIY0FYVUIyMjcwL0haR1pISmhC?=
 =?utf-8?B?T3UyVERkNXZ0UVpBcnhoRU9xR0s3K0Y5YzdFSVFDL2xBODU0ZzJxdzMzQlkz?=
 =?utf-8?B?N1c4VTlscU9jM0wyMWUxQjJDek53VmtnVi9zZGFwcjhIRXJ0all6R3MyMzVG?=
 =?utf-8?B?Wi9Jci9DVVpKTEFPemdMdXNQNXljaGxwZHRTbUI2eHhpaHRURjlNWVU4YmVl?=
 =?utf-8?B?ZHIyVGpRbUhOSlJLRG8zZm1Sc05sUmJweVdtdVo2RUcyU2dNZ1czbDFWYVRM?=
 =?utf-8?B?a0tiQVEyQTVaK3ZZdG10ZG5DVkdVVzZNUm4rQnJSVkdzL1Vnd2hmZFAzeE1L?=
 =?utf-8?B?dlNYdUU1Q2NRWUxMT2tBYkJRc2hDRjQrUU9PUEpEeXRmeXhHanJZNnpDajhn?=
 =?utf-8?B?ZnNtN1R6ZTdKckZheW5PWU1udEhySVc4OHR5RFlxVEhLTlVjSUVmMWJUcmhy?=
 =?utf-8?B?RmdsaUFrN1BZaWwzdTVRVFlVMnc1NHJ0b0xtWWVoNmZZcXFBL0FlLzVneTl6?=
 =?utf-8?B?NStnMkZ6amxETWljM29OODI2eTc2OWJiNFZoTEpWZThTTUxOTHgyTWgxT2xk?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433b75e2-b959-434b-33c0-08dbbe97fc29
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 13:53:38.5912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0H2jfQhUoUg1fCtW1bhrIHArNSc33NcHsNYq9AjTQJ2wHDiiHH3zP1AdtrV2sC9/umHv8WtwmaK1hA26d6Wbyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6909
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Sep 2023 13:53:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13230

On 22.09.23 16:10, Kadel, Michael wrote:
> Hello cip-dev group,
> 
> I do have a question regarding the projected EOL v4.4 SLST.
> 
> It is said that the projected EOL v4.4 SLTS is 2027, */possibly 2036./*

Where exactly was it stated that we may do 20 years kernel support? Or
current maintenance commitment is documented here:

https://wiki.linuxfoundation.org/civilinfrastructureplatform/start#kernel_maintainership

> When can we expect a decision that the v4.4 SLTS is extended to 2036 or not?
> 

So far, no one asked us to do such a long support. Are you aware of such
use cases and tell us more about them?

But also note that CIP as project and with its current contributor base
is not growing at a pace that would allow us to extend the kernel
support that long. CIP is not for free, and can only use this chance to
remind our users to contribute to it to ensure that we can continue to
achieve our goals.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


