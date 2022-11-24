Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5828C433FE
	for <webhook@archiver.kernel.org>; Thu, 24 Nov 2022 07:36:58 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.58])
 by mx.groups.io with SMTP id smtpd.web10.18128.1669275407626496112
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Nov 2022 23:36:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=T8JMoykQ;
 spf=pass (domain: siemens.com, ip: 40.107.21.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLCrB0EIaQzfXIdGjdVI6B6VEdqTbJaa4VPOrqjcPSYOFxz9SNAj4wsNP7uyeAMgbxbPvCaM8QN9w0KbOncnm7bP28LqKkQJIBuTVOlxvP/9ih7+4pua4TaHc2vlzqzYQepJS5ggfSRkYJL/Vwa8cPbqHfOYJ3SttMHflpxBjq204676FiepXyfS3zEKJ9T9IFKyGaim3QxlAaRaZM7Te9qlzSwS4z+ajwyVzOCvsdPkfcWdoa8s8/lrTWF1xrYcqDkL5wqJEU1HPm407e1cxySigLmjyZ8ff50BqmSSX8p7/CQI1MREXfM+X59AB0tack/t7ABKl/eWe0j0UH0+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chxbS/UHcCfQyarXpsNSl3gksoB/q3Xib1l/KPHTAzk=;
 b=lWdk5wGK4ku9jy85QM/Uh5OP63qPkNvDwqj4mRRBl4TXn9HttU1DCLTo5Irls1wEd5PMpwDKCEWCFJy1StBoq9SNBSIysW/A3UYUxylCaej7l8pHxpYzrH7w4n0oYJqhHD8RgSz1guJBwJ0hk74zKDNWFum8ueaVPBaPlIL01RL7dN6/buYWY/SOtlgOI0yg0YpCSnTRc5yCboIVkLyihKV6blmklV8MMR5hZ3q0xruafhbQPAzEZXRVcQz0TObugdP+nGeVUK9TmJ7gCWKQYYhcJ7eLlwAOeq6RV52SM5ZGy7j0Q9qSdE6RsZPngNK5EERmUwKkqJyCWGZOrFXLng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chxbS/UHcCfQyarXpsNSl3gksoB/q3Xib1l/KPHTAzk=;
 b=T8JMoykQ+N91RyX6rMbXmhvG33s1KDDWeInI/DtRk3YAj2AO0lGw5fMw39SZ8IleiZV855WXyx35WGK5KcLxmie0o0FNMU4LYwESuN0XrQcf8lHxROOEUPJPogeCGeNs5TNfZ9PqqM9+In+xUUzV9O9BSG0V4bAwrcANlvEYZWiujLtaLrHadS7YRvd+t+HNSb37FdhfF/4sJkdtG2HhserdGs4Vv22iVeVUWFqOGF7FcFSQ1UHK54nxFSSh+ObgbbSTsNS1kuX6YOgO3gRIiMIrK2nTuFWczJwnWpK9eexAJhq7EcFJkDYXSKBF6nFbDz45cY+KDaNCa1AdSW+4zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB5878.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:526::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 07:36:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 07:36:43 +0000
Message-ID: <319f7f4f-748b-862a-b1fe-d6158701beda@siemens.com>
Date: Thu, 24 Nov 2022 08:36:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: f47cd657-7533-413e-414c-08dacdeea26f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Vq5aNp5VCooLlhNKs70lKp0t19s3dcTxhTYWEA/0euks6cyiyj+7H7OSjJX9ooZRx0AJ1lLQnpGycOLt6dnqQSJhfrbRwDXhONj6TU3GNd29ngXfMhuSqgrY0hC72E9Uq+t1OzOe86szdHVnaNQJbFooTTxCK3Qxk1fppdyjQgpcsCLl45kuaDFqQmflCnu+ABtdAEHdeZ+DtvGgMFBjx19RR4I8StiMhZJDgnz9b3L/CIPHZMRRKGveVK1hjf7TxEMhnpver9cJdMHgWMcNHuS9bNyXuw8Xmkv/oKdZsPXvl+7A5r+KMgYGmgp+fVZBILUFyBFLhKwm049pkHFW2ym/jodKPIzNWHAirqwKrDCsU60Y1dIKBCMzcK0WesEqHgdOEj4/3vT3TCg/wYXZpqNl1dnqUrAEdJ0dm8vV1ZJV/E84E8JxrxsN+9gL1or+31boJ0RbAbHI/dBhT2rFsqLMp4/0HXK9v0H7KoN/u9gLz6fCGVMhmIQLmxBXR5ZWcPk0vPq1YoWVuzBzO4gG8YaSzt/8Jmm+tG29XmEmhs2+oaRjhL70oNVYaSyYDwpEpDAa1cEYn/qsnaSvIog0f7D4leCqtzDsXttFEonAFCesGsheHpU0evObYeTW+l28fczHwjv65etJ3qPdNgkpEKdkItgUTgDBFZv1h+oHkojB+KptqnFOvE+Ayv3jw2wOe3VgoRGlFEUWHG3f6Per921CdTZvgWxldt2n8o+Dr2NTrTYZBVJH41yLQIvdALnKd9LkP+rMlXBCbGRj1DcmcFgwbm0BoSAsHD2tsdBsd0Y=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199015)(38100700002)(83380400001)(86362001)(2906002)(8676002)(31696002)(82960400001)(66946007)(4001150100001)(8936002)(4744005)(41300700001)(44832011)(5660300002)(66556008)(6512007)(26005)(2616005)(6506007)(186003)(316002)(6916009)(478600001)(966005)(66476007)(6486002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z0FWNjhCTW1Hd0ZnRHF2TFo2UXpIYzI5dnhYSGgycTB3RXVqL05mTmtzT216?=
 =?utf-8?B?NGMxOFhzcGdqdXgzdUpobzhXWCtIZTlsVnA0cmFwckZsM1VQZUg0OUpEZld3?=
 =?utf-8?B?SEQ4YUhNOHNwMjlna09ZUlNzRzkySVBQQmFCUWpVbGpTdVlIZGhnbFpHTUlD?=
 =?utf-8?B?VWRVWmtkbUtNNldaWVVWeVFTRU1hTm5HSEVwTTBPWjVSRmVoR2ZRSk94OU5Z?=
 =?utf-8?B?VFFlSXQxVEFIWk1aanlLQ3dHVnlsMGMwWE9oWWRDbUlDblVTRG9mdGd5bEhk?=
 =?utf-8?B?NTdJVE1tK1NOZnlJcFVxc0R5cUpjL3RDN3Y3dWNncmkxWHNGcGEzbkt4NWF2?=
 =?utf-8?B?QkRaWVBLNlkvbGhyVEF1RmZFVVlFdEhxQUsvYXVpVG04R29zb2xvR1hEdEpm?=
 =?utf-8?B?ZG1xMEg5eUhvR3g2WkhkOU9mSGVKM2pVUk9JSlBURTg5QzluZDlGRjczOGgv?=
 =?utf-8?B?M0drMHZPQkxkWlpJVzFHRUpGNmEwK1dwN240dzM1SjhPU0svaytEbVAzNUln?=
 =?utf-8?B?WUdHdzBWaWh4R0I0V1VRMy9jQmlySzY0UWJuNmErQkVYSExEWjg3QlRHTzJ2?=
 =?utf-8?B?cHFVOTlDQjdkVnlxQy9yN1dCVjFPZitBV05PZVpZY3JSeXBEZkFCWWtPeWxi?=
 =?utf-8?B?QmYyaXdwaXJwdjllY3Y1SjdmckVTelBhTEYwa0o5NytLWWNnU0IrWTJ1eFh3?=
 =?utf-8?B?NEJrRVNZc1NPUURndWJuSElrOUt2NlpaeG95SUFOcy91ejYzZUhRMERudWhy?=
 =?utf-8?B?aDhqOTloSTFDY2dQTFMvbk5LcUpKUGhwTy85ZGFGQkRvMWVlbzZvb2tyL0Js?=
 =?utf-8?B?Qk1JbVpSZi8vQVN6MWE3RmdKbnJIck5hMFJHZ2xONWdQWCtUTk1KcUlMUmNn?=
 =?utf-8?B?L1QrYUNZMVExRXdBd0tjcElUTXlMSDRJQjRpa04vak96L1VuMkR5ZGVZRHI0?=
 =?utf-8?B?Z0I1QndqLzN3TzlUWHUwOVZnM2VxdncxcitZM3hUZS9wWnFaN3FxcjBCTy9E?=
 =?utf-8?B?Y1VEYk9NTCttbUVOdEREZklsZmdaMTJQWG5rOTQxeEpJSkQrK1JrUENiVU9G?=
 =?utf-8?B?a0szK1o1anRtY2Q2dXhlZzhEWjltNmhORXZhellEVlpyVDM4T1F5Tm13QVdn?=
 =?utf-8?B?SnpHQWEyekVUOGt3eDV3VERmbU1oNkVERnRWZXMrYUhDNmVzNVQvRFVEVTAv?=
 =?utf-8?B?TmZOVW9RelpDanB3YjhPZms4LzZRb0U1RS9iVkxtQ2JnNFBoRTRxZm82V3Vt?=
 =?utf-8?B?MTc2ZU9zK1VuMHZ1NmhJL0huVmlPeDIxc3hncWlPVW1xTThoNEJoaGtBTnIr?=
 =?utf-8?B?T2pLVUF2TjVUWC9HOGlIZmJEcXVhV3RvTjBVMXNIZGxnK1pvVmg2Z3FuMzV6?=
 =?utf-8?B?SjNad2JEckVwZlVWUGtKSU5vU1RmRTNSdkNQOE5KY25neGhkOUxBVmhtZ0J6?=
 =?utf-8?B?d3B2cXdaQ1pLWGNHNzFudk1rWWZ5b0JYeXFYMnlWOXJkSlNKRzZNVjhDa0Nn?=
 =?utf-8?B?Mi9iNU8vQW93WmNOVVBqQmF4SDl2eUJrUW1hNEpyRm1LOWcvN2p5b0t2eFps?=
 =?utf-8?B?VHcxL3BiMklwUmxwYVllRTJmVk5ja085ZTkrU0NuNDd4WEtWbzRPaWhoSkxB?=
 =?utf-8?B?VjJtWVVRN0hRZlliT3phdHJTNFNYMzNDN3liOGtPb2lzZ1MvVkZteTdHaGZz?=
 =?utf-8?B?SlRwZkl3Qmd4MzZjUHJLUWxkaGlJc2hBWVpMWHFrYTl3cG03dUZNZzNOVDBW?=
 =?utf-8?B?NUFERkgyTnptemxrdkxrbjgzVTdiZ0ZzYWFaN3NrK3VWQTRYN0dySWcrZ2R3?=
 =?utf-8?B?S0xGWW5wSGFuSGtUSEVRUW1nRmh5YnJWNEZhVmlUcDFUd3haMEp5RlFoLzN3?=
 =?utf-8?B?OFdRVDdXZm1VaUQvVkxEL1BYS3N6SDRPVFhrM1dOS09hbks4R1JyN091SWN4?=
 =?utf-8?B?aWRQQTAwQ3FZbXpPaHk4eGl0NkczMmFacWozWjdwYndHN0hyZC9MeWkzRHd1?=
 =?utf-8?B?QkJzTnkxTWkyRkxnUEUycjh2UFpWY3YzRVZCRVZYc053UnkzUjJVZzkzaVMw?=
 =?utf-8?B?OHhGRnpwZENSQUh3R3cxbzZWVjZCMGxKaFpQdTJaUi9VNkNkSCsvN25lNTFh?=
 =?utf-8?B?b2ZtMnNhNDZ3WTN4QjZSQTc2MnBzY0o5ZGM3QmtqTVNqUmhWakcwQXJaUkND?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47cd657-7533-413e-414c-08dacdeea26f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 07:36:43.8707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txzMiybUjwTutgwbF5W3QQamJXytTKWgivv6O4hfXpo98yteojzdju4D3pWjdchPLLhaaRQi8ogX+LptC4P+8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5878
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Nov 2022 07:36:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10099

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=11&day=24&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/11/cip.2022-11-17-12.05.log.html

* Action items
  1. Add qemu-riscv to cip-kernel-config - patersonc
  2. Create MR for disabling smc test in qemu - alicef
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB

Jan

