Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26442E706E3
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 08:00:44 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.43])
 by mx.groups.io with SMTP id smtpd.web11.10966.1695283239243938231
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Sep 2023 01:00:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wb0W3Mfb;
 spf=pass (domain: siemens.com, ip: 40.107.8.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lg3fM225TiUcVoLYpr7uiEj8Yw0PdqvdYwZb7ro0s1eHDhEnvB1NSG0zUnUL6Zxeeb+p2g9m1y1WYIUDxOflm5ESlrZmL09ulHZczng55hzmMcwK62g3oq7uFQ3CruTkAER+7va/44nTuzA97BO7VozI43gcUtaHT9gIPau4fstyTpH3pkP/8pcS567FUAl1vgvyNrERAKpPUIcDmAJ1uJWd7zIgGZzh2IfF0QomNA9ZNolYw4qhU17gT8Eb2MLnl8q8Sx4/NzwWD3u94dGOKksVUmog/fCKVFSR+/xS0HuW6O4lNJc7BqLmb1gkIKrvCFX9xWJUJBsNaZUg2PamsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3iiZIv4B4o6pACKocPDb0AUW4QFy5bBoyRpmd5qJJU=;
 b=lJ+S3X5VcjmqISJfnftQ1yEr8ZWab4epeg/0qrfm7IDQN9gWZDtEeM5Nf2d/Yv6mKs8PlDUPSPczsvz/mgkrm2+Na6+e3eQrO1QYSwLOR/268bNsIzOaPo0r0inQRwcAqx856P5iiOC9Gmad/TiQqzBzEenWPI/nfsKmdhvlv6X/9VlL6vgiuQKj2NaqlsQn8pmJmEQQ2Pj5+ttZTqz9hVvhWgpslZTxN3EB657EDKe7V9cC6gFv4f9fGqn/QjnYXsrIcBhiDtie0V0JwE/SKknbCwJ6swXX18XwEhDJ1YoAuIg0MaLfli6PZQbY9O5tTMNZQ7elfPi22W2aUcHq1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3iiZIv4B4o6pACKocPDb0AUW4QFy5bBoyRpmd5qJJU=;
 b=wb0W3MfbIvGmfQMNK4oGR2mGNoTE+NiQ7gjBwGLc9gAa4+UuTpfHDBZ19OKKiRKz7mFRZE8PzGdeq8DRSRF3g+ubNAtP5bVTu41JXEmdAxqVRw+07eTYTYQn9Pf/tuWXMO/XIyYH5UVdJG/UJ4L2lfekAHk6qbrZBRs9QitMDKpYTMmeFw1mYKHbHp3ThoALJKOua0ov26le+bGmu9iaLWcLO5cNu8TAjUXqD39J8Pedeie1LVAPvOIvItLUpX7eGTytBPmBXtP1UAz0AZzo9e9V3R4ov3oRebJQjvTAUC9eIudzHBecEkge4pSIWx/4vbP4RcUuUH8l6mn+tlkyHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5241.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:349::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Thu, 21 Sep
 2023 08:00:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6792.021; Thu, 21 Sep 2023
 08:00:35 +0000
Message-ID: <f06ca763-a337-40de-95e7-501c03c8bfe9@siemens.com>
Date: Thu, 21 Sep 2023 10:00:33 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a63cd0f-e461-4207-f511-08dbba78d5ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WdBbO6y8PvmNyIqAHg85ZmXDNsegXGw3qiJdJKj37U1K5xr48/Gl4sr4yv17mPiTbjT8VNv/6vhZXzlGscOI8I2avImw5RQy4NGQqNOUGLtxHr5ca+DNffgdjlX6VYrSxJLAbyctZ70Y5wbXi83byZ3max7kxdIidxVMLyzezBMuYioAFdf1+1yZorSJBltfp7jcXVzyEg9t7c8/w8BXvwjMwBUQK5Jvm6xb/4FQrXB0172SKb1Lc55JGGsRLBp60rsqAOaRMqwzJQ/sN4Ll49jfzj1Ux1SKCKV9Wj0/uQC1pegG5h8Pd44WiI647OflmlBZZ03QR5st1YYYBLyfsQ5/jyRV5Iq536jonwY9EpdK3PseZqrUTk9bwhqJJ2azb7bxxZ1mXjmoxx4lnjGfFkkz/dRQRwNtk6eBn3bSlCemHITdYvZ/e8kmSEqn7oqteoSHQ+6h0gInE2VdULs4T/iUnACONGRsffpexfmoF6fl3dTtjgp6IyJleP1RtfJqfKh1WEMArNbKi/uJqrnt3vm1Yful9cmHLgtkweG2r/iDTcoVgcTY2L0y4Yc+IUZsMBGQn4MFnww9ZqluHBLIQh0m0EtMzV4fE3tSwqvAs9A6+SvlzdTolhJaSIdRgx2XCiS3LzuFiIla+9k1fmOkYw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199024)(186009)(1800799009)(2906002)(5660300002)(44832011)(66556008)(26005)(41300700001)(316002)(66476007)(66946007)(6916009)(4744005)(478600001)(31686004)(8676002)(966005)(8936002)(6506007)(6486002)(6512007)(2616005)(36756003)(86362001)(83380400001)(31696002)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T0ttUzlmajgvQnltRExrS0JTaWlUT1N1a3dCNDhURkZaWXY4SVVLWlNDZGJU?=
 =?utf-8?B?cWhoZmRDNXMwUEo5cWhNK3NyZXM5a3AwUHk0OWt5d2pEeXpzTE9jYzZUTWxv?=
 =?utf-8?B?VXNXRGRKUHMwQnJ6MjJpZTFLRG45b2ZOeXBSbHJPd1p0M3FnM2p3cGZSOHp6?=
 =?utf-8?B?TzJKdWtGeWVXUmUzcjdwZENhODg3N2RVU3BRUkduMEVlQ29OakZPZC9jTHVH?=
 =?utf-8?B?ZS9rUjBCVXpVb3oybHJoOXhMTC9OTW4rVmcyY2t3Y3NjanpadEVjSkYrejB0?=
 =?utf-8?B?cm03eC84ekpGQUpHRUJGcjNJWDNYOGlyVUxoRVRna0Z3MUM3c3dqWk5FVHph?=
 =?utf-8?B?dENOYm9nWVV0MnNxVEFvNXVKd3lFNnNiNndFVDN6TGFqc1NYY2tTckNRYkl0?=
 =?utf-8?B?azg3V21zRkR2eXZIT2FMdjZYWEh0Tk16VThOUnlpNDJEWE9sbW5zalIxMGFD?=
 =?utf-8?B?c2w3OHlxZXVlRlVXSXhBalhpdGxJVktBaGVXc1pKWGRTTHkzWVJYdWdKM05D?=
 =?utf-8?B?MFdtcXRqZzhxTThOVHh1dFdRSUFLQW85b1VLakxreVFjTXZYTEZMa1pSaEVy?=
 =?utf-8?B?VjVjQm1pNW1yWlpMNXNHZUdLZ0dYLzdEd25acWcySGFxVUt3dDlHZnVVVm1y?=
 =?utf-8?B?S1hRejgzeUNhMlI4cFc0dUJsTFc2NDlEaFo4ZDJ1dS9rSTkzTVowOGkwaVQ3?=
 =?utf-8?B?bnM1ekoxaDY1MTNGbEE5UlE3L29rU09DR29CNnhBUWxPTlJNYUNFR01kcHdW?=
 =?utf-8?B?UjhqQURwRHRSZEIxRGNoL0FCWjEyTHNRRGdEZnhqcSt4YkRMNTNaaFU2U28w?=
 =?utf-8?B?NmZoQ0FzRFdmNGZreEdZVTdKMUlsM2lQT3pRMkdNYWFuWjBrdE9FMVJhWDRj?=
 =?utf-8?B?KzhJMm1PQWJGcGNIMkZ2K0VybXhFV0pjdU5Sa2ZWSDM4Z3RST1FuNXZ0d1du?=
 =?utf-8?B?TUhmZ0libzhpZEp3WXlWMG45SjNZbDY5QS9aTVU5WFdoVGdTYklkOVdMdURz?=
 =?utf-8?B?OExvRlZObGtlRnFMWHJtK1NleTlWclRyNUJSb2FjV3JWYW5jYXlOOHh0NGFK?=
 =?utf-8?B?dy9jcVdETVpaVjltOGFzSU4wZlBKbUNKVWxYdkp1VnpiM0NMakRkZG45elYy?=
 =?utf-8?B?emlwdWgzallqRVpWdGdiQ0dyWjhOQUJlZEhkdGc1WDlzWGF5NkRVSkg3UEtB?=
 =?utf-8?B?L1RXaGdGclhHMWo2N1hBR1Q5cHhsSjZaKzZ0WTA2b1dsUmM3cGFVV1NkOGNP?=
 =?utf-8?B?NFNFY2RiWEk2WmhhWDB4ekR6bnFzd1ZSOEMvQWtFa1ZhbDk0NFN4OS8wNnVD?=
 =?utf-8?B?dzFOcjNoOUhYbTFIOXZEOHVYczc0ekpEQTF5MEtDV2xKV0xhL2hPenYxVWRE?=
 =?utf-8?B?NUllanU1Z2RaZW9nbWdrQzVja29HcnZzUDlMZk9lZ3J4NTF3T2VQWkcwcVFB?=
 =?utf-8?B?ZllUWWdLK2dtQm90bkJ5SGE4ckRJbGloemJtbU54ZWJacWU0QVliS1FrRUhI?=
 =?utf-8?B?VHZBcmRRY0hzN21yNVRGTDRXRjdZb0dSVlEzbFo3dlkvNzVhUGlER2dZdzJ3?=
 =?utf-8?B?VVZMRVQ0cDlxWnM4TXhwTEprcnd2a3g3c0dBWGVjUXlwdi81T3p6dlNoUDRV?=
 =?utf-8?B?RWcxOUhYaURkWko4YUpmbXZSR0kzVVlaSjgyREk0SGtIRll4LzN5cmNoUzJF?=
 =?utf-8?B?Z3BCM2p0ZnI3ZGtlQkhHNGIzQkZCdXpESjVrVXFwYU1RWUVkbCt3NDlQS1BI?=
 =?utf-8?B?ZnNNU2FtZlhXd1VxQldWN2pMUnU1ZkZOZjdCeGVxWTFZM3E4allQVllBRERn?=
 =?utf-8?B?ZG1wMkpuSUt1VDJEcThsUEJwR1pWR3pXc1pMcmZMdDI4L2tYL1FJemUvZ3BF?=
 =?utf-8?B?WWlzaEJub1c0WmVtS1dtejlhMkZvOHdtWVNqaVR4NnVsWVBkVm4yd2RnTEx6?=
 =?utf-8?B?SFJFODlVUHMyTHhFaEpUbUp5Y1RiVU1zNVpDZVpSb3VvNjVJd24xOElrbDVC?=
 =?utf-8?B?eVJIdDI3REdaaUFiaGVjYmdiRlRrYnBuYk1QVXRPamtyVUJCQUMyOFJXUkRu?=
 =?utf-8?B?TnFmUWRuWlJzcmN5RlIrME4zMnYyQ3BqcklGOXJIbklTUmg5YlhVczNIb3lG?=
 =?utf-8?B?MFRrK05VUEl3OEcrKzR5Ly9BRGtNbmdOTGxrcEpHc0dTK3NTMTRlM05VMmxu?=
 =?utf-8?B?UGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a63cd0f-e461-4207-f511-08dbba78d5ac
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 08:00:34.8870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kf83x6I8xv0T1F2I214USk1uUUL3la9BgOZZiIWu+VjdAtUAXf+hYMaIE/Rr4ynMfH0fqu6vpSqDobej8j7Esg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5241
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Sep 2023 08:00:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13185

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=9&day=21&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/09/cip.2023-09-14-12.02.log.html

* Action items
  1. create kernelci pipeline for buster images (arisut)
  2. setup tarball upload and share procedure (iwamatsu-san)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB

Jan

