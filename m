Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.0])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2495.1793957536132147865
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Nov 2026 01:32:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eqRge8yt;
 spf=pass (domain: siemens.com, ip: 52.101.69.0, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZD4DEULJgKOHdhoU1XueQ79uCtPwfu9MTTcE1HE9nOFVJ0S+YqbjDcIZHMTPcHEJ004M/H1cUJ2yWeceuYLuDocxC9GqOVgCZD9PwkgjvV2WdPOvWGrneRQ+N4u68HZL+nqmVJZ+hx4YtVY73dv5SaGAnKFnegwsYaNO3HFlGACKcaWcANxDoEsiLWA2KqyDVKqK7Y42NYGyGz10Vbknd3r0cMo9Y2xccW+o1L6HRTP2Uml7dIO8a/Prv0E1g+iS7JT5X6z5qOrodVyRVJDPpuqotNQU7+acdfixxAMXh9m/KIzO68pJQYRDqLTFNtQBqtERfCbhndskwlQmdQTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkvD4f4mdt+wsj9Gh+Dfr6IBOmxTQjfrI8kEh92a/og=;
 b=VifcqckMyQOLeUaZ4fCRaXHdSHA/g2UfjyAYGZcO6ReLptrDHpcSR0cG3iQ59+OgJ/Qqrxmdi3cvYJoMqA5NRg6BfhjXtKENijdoytp/K//aed2KIfjNfuThyOtzpE5KhWJmfWmJclPGtsXwe8OHoN02JRAgpWbHZnaRw4+hEs1EiDyxeYrfJZ5x8Z42yUTuNtSDEGq8b8swIvFlTBAVelFkcXx/heon+AyxTr4Y9yvT3r6XFvrvyaDmqawsK8Sal6331HsX2RMA1ZQy8AyYzOg44JBV2LIitq687jJ2QJANzdzRTAhTs9ycCk6ky/kMnzl1nkwf8oinkQ2IcfRWCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkvD4f4mdt+wsj9Gh+Dfr6IBOmxTQjfrI8kEh92a/og=;
 b=eqRge8ytNZryEcSHgAnJAvxLn85DLzK1q+WQBaK9Q1ZUKYlSe9iVaCcU0g9DOLkNe/p4b74qsMozD6BuAMSJGygYu3bcUkkJRahdRf+vh7HsO+pNyX0aOX9riuZFzE2vRK/AgniOo7bF6BwtOPYBU/+V8F//yQ57QR3oIE4KPzPVlGAmiGv9TXdhDk9BQohfnE//OF4qQcSPEILUpvkMs5z/WJKoLe5Ap/Ob2UQdB41mWY/u/oDgQkoX1Mbzd0d0tlWq6hVuTGLWcMH7O2JxklXrvLJUB81CEiupeoYEZYoo/Bqk3Ladl/NJWL9BFBWQtlZyXJfhqAnayVOz3OYPLw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS8PR10MB7088.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5ec::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 09:32:11 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.003; Fri, 6 Nov 2026
 09:32:11 +0000
Message-ID: <c30f288d-19fc-4319-811d-ac98e853ef13@siemens.com>
Date: Fri, 6 Nov 2026 10:32:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC PATCH 0/4] Fix build images for buster
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Cc: cip-dev@lists.cip-project.org
References: <1793956065-3316-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1793956065-3316-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0250.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::8) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS8PR10MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: deba7e99-a206-475d-351c-08df3be8d57f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|18002099003|22082099003|55112099003|11063799006|261026121527099003|261022075727099003|261021121427099003|56012099006|261102123227099003|261022115727099003;
X-Microsoft-Antispam-Message-Info: n9l/LyeJiOb92T9aWvp25jcbY033zZxd+Vvmq7Iz5Wcj92xMr/8pS+WTNqo/NbPGn3s+EYQjCbkwaI5+0Mly6Ex7onBlbxw9YT+DD1mLMn/8OgASw35nmTY0a9w+TQKSHo6TgM2F9TfxgjpcL/XPCNPpKL6uzxPl3MOl2l4RmZHn23+JVgyE3y5m5etK/4EN6g/pDXXe1yzO0E7D5opwNj7DqhPZc4ST3pQanR52ILCWouyehrzo/PCeMNuWB6GGGJqC8+G9d4P/0EfITfs70K+NdFQVtbtRlrw8t8CJMZwC0CeF0iy0h3XlkXtdlB9J2UjIk5h/rgE8bKSJZwjKF/cLTb4pTKPlE41gRyj6lY5o9c7PjSiwZrn9FgvWD3qJDEOM2bk7WzYPOVYeEahGbvgiu39cDACWgXiLCMgiE3M+Rj52z8SGQ6MyM/4C2M1TBwm97CswlBZSeFM0z7/MUiABTP4I5k3DNCdAKmsWZEgyYWDm2yDjF+cTzbR8e1V4UG4Vp4lAG6/K+RKxrJj44UYlHbDowChV5Ee0XEwzYqK28QgN3CATt9oXi8kEQ6XHBDhwqPOTX80EKPUFudl9cKLDOUkR5A94jdnepPo9N9+Km7Oqk1pQ8lzZXAR2TAdUcG4fhsdijoIaUrAkgHT+LE8O1e59ulC3yp6jAhZwBp0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(55112099003)(11063799006)(261026121527099003)(261022075727099003)(261021121427099003)(56012099006)(261102123227099003)(261022115727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1RYdWwvS0ptQ3BTaloveWQrK0twQ2d0NFRLbTBoMzcrK21FU2ZUTGhXYys5?=
 =?utf-8?B?RFlIVlIrV0VVM1A3MEM2R3ZpTXVRbEg3TjRqTnQ3WjB0RWkrK2U1U3I0ejFX?=
 =?utf-8?B?ZU4vYlhFVkFRNXFqUVM0T2JjY082cWNORENXV2hOREdBTVU1SVhOd0ZTL1Zq?=
 =?utf-8?B?OGZVVzJHU2pkTjVORk10WWx0Y3NUclRPZStob0JGTm5zdHdxMU5OMC9OdVVt?=
 =?utf-8?B?ZWVjWTNvREg4TFZvQjVrenlVeGpaSVBMZm82TE1ySzlDU0lzN3ZyMVVnUnR6?=
 =?utf-8?B?c21YTjZzVjd0UGlIMkU2bjRackdlamJaaysyRFNYZWNRemFxSDFpSFdhYVQv?=
 =?utf-8?B?MU1HM0w3Sm9yL0ZEcS9sUXhrOHE0TXhvb0FhRkdKSGNEeXpRV1EzL2d6TUla?=
 =?utf-8?B?RTgvTGJNUVBJRi92ZUlGdEFYZWRwRmpLN25xc0Jhb1E2R1VHZFFsenVMbmFq?=
 =?utf-8?B?NVJiUlhFaE0yYWlRT2NrbFBVL1dsZ1AyMXh1Nnh3ZWxLRE9OUTFieFl5YjNL?=
 =?utf-8?B?Z1FZVkNVWHYvU3I1S2JNZitHSkpFVFMrV284Tzd0MkJPZUZLdzdkOGg2Z0p6?=
 =?utf-8?B?b3JVNzFhaWtTalYrQUEyM3ZwTkYybFFZbVI0K2xxSW5uYW1pYTRqRHc4Z2wr?=
 =?utf-8?B?UmhlZ3IvanZmSkNuWUhZaVBjM1U1VGJraExIdkQ3SzlmT2pWN2xwdklvYUFo?=
 =?utf-8?B?YmlmOVljZW05NzQ5RmV4WXVRRnFpaVl1Vy9LZDBZdy84ckdHbWFGeG00SVMy?=
 =?utf-8?B?U3YxOUptMENrVlA0MHNhOXFzMHVhNDFQMnozMXV6VmUzbEhpV1UrUE1lT2k4?=
 =?utf-8?B?eVRaQUhzZDkwdUE4VzV3N0lxcklmdE5abkJPc21FY2xPejVVZ0p3K2t0Y2NQ?=
 =?utf-8?B?QyttSmJlNUhVWTU2b0h5OHdoUVJENWtUbnNEdXUxUnM4bGRNSFgzNVVNMWdL?=
 =?utf-8?B?MXVpc0EwdHhiSjJ3c1FCcERtTnI3VGNFSis4S2tjZ0QrM2QydDhjWDFic0Zh?=
 =?utf-8?B?aGlqUFFVeC9MQVNzeWVFYktOZ3Q0YmRKa0dLdXlMbU9OVnp3S25YWXNTSVVP?=
 =?utf-8?B?b09BSFhjVFh2L2UzdkRvdVNLem5MbDBVNHRtZms4UlZXTDdlbCswTnpyRUdo?=
 =?utf-8?B?eVhsVHcvSXBZNUg3RDMyMFpXNk8rWmVGWWthT1ZQVjNob0w5VTdQa0NFb0ht?=
 =?utf-8?B?QXFzT0JVUTRnaFE0N0hjL01wdXdWb2xieTBtOWg0UjIxbWFWeTd5K1JaWW5k?=
 =?utf-8?B?bW1td1NaVk1BU2NxZlp5dFpYM2owL0R6RG51YTdUNkFFZmw3WTlmbjZES01s?=
 =?utf-8?B?bWszeHRIeGJKNkVsL203V0hBakxNWHdiYmp3VGU1Q1djdEZ5bDdDRjFWUk13?=
 =?utf-8?B?d3NJd1RSMkd4elN1cWJVVFV5UUJ6eExVODl2Z3ZsL1NEM0UxemNHNzB1VGxR?=
 =?utf-8?B?VU9ZR2cwYzBlK21pNWhuQm5FdXF2K3dlMkVJbUw2SHlETWdGT2lvR3B6ZURl?=
 =?utf-8?B?TEdIOFNpdTh0dlM3Z3dRUnRka3UzSkJENXAyeW5jeXQ1RzFTY2lqYnZQVFhi?=
 =?utf-8?B?a1lrclFSbVNlS21HN0xaS1VFRC9nQVN6U2o4Q3IyemNpOGtJUm01elpSK1li?=
 =?utf-8?B?d092REhJWkl3OHp3R2FBYmZwUUZsUlFRRHpxT0pMUTZrMitzM2piY0pnQmpx?=
 =?utf-8?B?ZkE0dkIxaU0zT2t6SUoyTmNEODJubExxUVRTYmRSeVJTYk0wNThFN3lXanJj?=
 =?utf-8?B?c1g2RlE0WEtSMFNTT0dKM1o1Q2lCSmkrRmE0V3JUYTh6NjNGSnJLQUNkRkZZ?=
 =?utf-8?B?c0NjSVN5Vy8rTFo2RU5WdURRVklNOHBJeXhjOGg4NzNxTFdtRmJnckVDYjd4?=
 =?utf-8?B?ZmFHYnM2SHFIbHlnZXNwOFpzU2lLYk1GMnpWRURWZ0htUTRZenZmT3FmdjY2?=
 =?utf-8?B?NytjQlV3QlJycmRISG93L0xjNFZGVk1CYmlKWDl1aU1IN1B6WHdKWDhydGl2?=
 =?utf-8?B?ai9tMmNHS3k2RFFHWGYyNVVYaWFQQUo0d1Z5Yk5ZWVZOT2Ywdm44UFA0OTJX?=
 =?utf-8?B?TzZnQW1BamlZdVJiVUtrVzJwL2xsaTV1MFdSaWJTVDBKYWh6U1NPbWtwMnEr?=
 =?utf-8?B?ZEZ1SGdvZ2MwZlVFelQ3eVoxbG5KMFlXU3VUWHVqWGFWenNTczYwMHhvQmZI?=
 =?utf-8?B?QVZDV0F3RW9DdUNuVlRqNXhmT25PdVhzYkZwQmFiMGk1dUxEZFM5NXdRekp4?=
 =?utf-8?B?STRwS1htb3FsOFpSaTEyMlBucEdVTHV6NjdwSnh6d3NSRzZGUkczM21EOTlv?=
 =?utf-8?B?d1h5RmFvRUFWOFhQTStUdHRRcWY4aE15ZlJSWGFhemxRTWw3TWt3dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deba7e99-a206-475d-351c-08df3be8d57f
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:32:11.0954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FV+njXOxxtAkVEYxcB5xJN2mvfMgJDoD8m5V3IATCFlcwTDXcibB+rG9znMeMAskfGWJ95pe/9O3K1TInQoVtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7088
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 06 Nov 2026 09:32:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24662

On 06.11.26 10:07, Nobuhiro Iwamatsu wrote:
> This patch series fixes U-Boot build errors for images targeting buster.
> The build errors occur because the version of GCC provided in 'buster' is 
> incompatible with the requirements of U-Boot 2026.01.
> This change reverts U-Boot to version 2025.07. And when building 'buster'
> images for the BBB or de0-nano-soc, version 2025.07 will be used.

No, we cannot revert, we must move forward for full-featured targets
(I'm actually planning to jump to 2026.10 to get rid of some of our
patches at least). All we can do is provide a legacy U-Boot for legacy
buster.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
