Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC818C61DA4
	for <webhook@archiver.kernel.org>; Thu,  9 Feb 2023 11:41:51 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.42])
 by mx.groups.io with SMTP id smtpd.web10.12339.1675942903304935385
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Feb 2023 03:41:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OmUw5seA;
 spf=pass (domain: siemens.com, ip: 40.107.14.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOQjgXTCIm1C42vvgzglULDzGfTNCT/ZlRR4rgs0zWlNY4D8F5a5hk3iduJPzoIm55CONk2cS7H6Rev2irbmRgovHLsFHAHlzOdCacz6VZ2/YWrtpyorRyJoe7rffiQHBP7Lhv4pfzyPshV0XVbEZpUHYXxaObgR0W6DSubNba1r54MOcL5+0CZj2/YwEwi/5a7bn1SAGF2AeiyGl+LUHzgcoSJFYlbJD8qT6+icZJEBrIYJg06QEbgeVhJaDV3Mx247fUIbUAY3TW7ZCDokaguxhbmWYY8xMgVwxnKDORiGdtL70wtNb0bF1LVLmuTwWEMqkJd6zbKQ3FS6L8TU9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7QXkdeIkrQX1nOXzUKRPSSUs6jhLaNd98t38mHWkQs=;
 b=OqtNtNs02tSrbctHKSvCsQxojK5W3Q5EFB+R2t0XPdmWnsrEy7IVK2TkqZRajmuW2uE22jFUTD8MO4MV2mY268e5erah3WrhEPGyEzG0VzlMeBi7mY6xqL/vh3p4td7cHzGAZhJAYXAmNyQqdcFb6mc+5Xd5t6QTq4mBRAPfHYxpN4gYk6qwP68Ef9Nmm375dtckrkjRaHiQ0WNSt5nrxddV15xEBjKg8Qd8hXZyeABijyFGXJn5DTXWzTewVvPV13U46QYjnWZbKiKvFv3X7WFkAfJqfX+Ym+H46Gs6sOXJovVEDbPbspxa8ktUlbTfBnryMCWl7v2ymRoRuQ4LcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7QXkdeIkrQX1nOXzUKRPSSUs6jhLaNd98t38mHWkQs=;
 b=OmUw5seA9wAyj7oX9VkABW3UVV1o2GXJurTI74sD2XsuDq8+3StAm3QellJ92YVWzaW2p3CK6y3opaLwIkK348C9CwGP26Lw8PDIo0JQUBMuNq1AYTwUHuntnqKH4vcGgwhtMnwSTz6CqFLPtvP2YWafq9UIodNnr2s7xAsxu60vfs/LuphOb5onJWwyrgyJINHtgLKbqH8/ov2moG0KfUsVIAbs+anZljWHueZyU8pkOOfMyPa2qeTdZ0SqukqTlawq5PT//k7NYgkL5sP/KCEGRwtdf6VKP+AQmRuck36Ju1qvDLAQ4XZwogpj2nel+4N007n0iP9hGaTDXPCP3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3844.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:179::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 11:41:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 11:41:40 +0000
Message-ID: <b342a16b-5b75-26c4-3228-1b3e7c07bb06@siemens.com>
Date: Thu, 9 Feb 2023 12:41:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] Mark sid/sid-ports snapshots trusted
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3844:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c41e328-1a27-45dc-8a59-08db0a929bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UKi7nA/M+Czt7kmBjnR8Evd1iIi8KOhGVCk80QUOJa23AuynQA3abUjqQz0G7H7bvc20e0UcbiFqMqvq0CbBuRjI+lusI8GEDvXIWkUMQw5tx1ORLOwm3FmkF36sqcLJE+4yneIcbmp0b7eQ1vS2Y76HGew/sj5jAQky4mkqOXffZNWZ2sm0Ea0Bfhw/sHJp4VXZfNjbGuAmW7GD9nLFRu5nq+Zlnmqiu6KxivS4Cepj3CChFVvwNpQWLpsGGUlbsgDfg+jtxLnxhltTfY7T94i+rgBZJpjqA0P9haxjuhkzoZMQf4CepveEUwqJVeDL9fdZyzZZHbbsN9QPowjJ0QzSYS3knKtCFtZQOp4UP6n/eGROs0uZCCmMifBoF9Vi/6r9fdOsXZL96gVZ5Sw2/9RdHIEgSHm3xDFSKiGP5DpmUizfrXeo2xPw/b7hRYD0UlpHBnm5O7e64A528Z7JkMmh7LD+CE9FJTM4ztgJ36TUR0MnB7NHzb9hBjVlGhdfmNzFtbgsbgfSBgEkuxoTo1xTH//BmD2E5CGbnr9g6RHuiwwOyNR3zASmYk1mPWp/v6EK8Gx2Z5j0yVR8/xIwDaUU7zDSsA22Xmb7+DlKPPCrpH6x8Rpa4XLNXlM8BkjzHY6UHhu5w/rc0ciPwX2E8rjGf82DZKxM4pGMgADIHMQzZkpe1x2Ms+QxJKzJwdaS/s3nWBDlSCB22R22pNE8SE8FTFi4TWvcnZa/naT6OSva3eCDazh4qnuHgzvII95YnYjDYzf1EY4y5g91f6p5Gs8wczkyWoMJrLFc/TMjnpTWXAgLeiRK91oqwuU+gyXC
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199018)(5660300002)(26005)(86362001)(31696002)(8936002)(2616005)(6512007)(38100700002)(83380400001)(66946007)(316002)(41300700001)(6916009)(66556008)(8676002)(66476007)(478600001)(82960400001)(6666004)(6506007)(186003)(966005)(6486002)(36756003)(31686004)(2906002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a1Z2UWpYNkdYZmJ3MUhxZzFLZGFXWVlXS2R3QWp0KzB5RUxOeEhOa0cwbC9u?=
 =?utf-8?B?UEZXM01oVWtMZnRoczViWWttTythOHhxMkVXVFFlYUsvbFMxaEozdnNxVUNV?=
 =?utf-8?B?ZVZBc2pCK3hqeVk5cmxjZmQ5VFA1MnlXbHAwZkdzM0o1eHo1bTV0dzRuY3kx?=
 =?utf-8?B?WjNQUGEvYXFROEMvWnBJcEhQaXJYTzlUNUtJaEhsNFpIMStaV1JVeWpUb21y?=
 =?utf-8?B?K0ZmK1cwRVZ3ZGVWcERDNldGRENmS3pPMGJtSEtzT05ZRTFQVXFtNTdDSWhQ?=
 =?utf-8?B?a1ZJaHpKY1g1NmVsVXROZ28zeWVtNXArMEJPMnRreVZkQzRSclNvVElCa0l2?=
 =?utf-8?B?dlVuRXZSYjZHUEJWcFJDWGtwdVZCN1JHb0ZBQWs2RFhubU9QMGtsd0kzNm0r?=
 =?utf-8?B?Z0VVaHZzTE5hTkQybU9iNmZzK0VyVVIxdERqWThGWHlXekV6aVB3b1p4L1FI?=
 =?utf-8?B?Yi9NOFBXYzZNRHp3dDJ3SDl1ekFVdG9GbU53WDZ6WFBuZ0RXWUVKNFh2cXln?=
 =?utf-8?B?SU1iaUJRM0c0SWhTK05xaE5LekxsYzVlNmQ3R1hYb08rQjFqWmxObkZRMEVq?=
 =?utf-8?B?dVRkLytvVldoTEE2OGhoMHVZNnA0cngzS3pMeG8wcGJXd0hYRzlrWTc0dUgz?=
 =?utf-8?B?bklhNVJTb1RKRktlNEd0MEF2ODhicEZQRURRUEl0RnJuVS9ZTThKeHBJY0xH?=
 =?utf-8?B?eDRoU2tzVFNkRjB2SWRZSkdyT3lWRk52c0pNdEpvNU5HMFJ5bGZnS00zMTBS?=
 =?utf-8?B?cWVBZHE4TFd2WmRVNVV3c2FZOTYwUWlBZkFvOTRHVXhYNmdVR0hpQVBBdEsr?=
 =?utf-8?B?WCtNeG5Jdlp4dmJNeTZxMnMvQStBL2x5YXorbjNjditVQk9ETG1JSUhZc29D?=
 =?utf-8?B?Vno5L2FjamNVc1d5ZkpjemJGejZYRG5qQjY1ZTkvR1dSdDA3OVM3ZVlud1ph?=
 =?utf-8?B?VUtRcVNXRndaR3Q2NXFWMFRGeVNwVWUrYkpiaXI4ZW8waUh1UUhXN2daNTZU?=
 =?utf-8?B?dTJiNFRCTnFld2VZZmRPYkpHNXRZQVFxeHVuN0U5aFhOYk9HdDBUWkU5d1Rj?=
 =?utf-8?B?ZGhzR3F4amJxTktoNkpNbmtYT0JzOEk1Nis5RE5CUENKME5lN1pTbll5UVhv?=
 =?utf-8?B?cmtvdnJRcXRlZHFSSXBMQzg2b3hoTDJYb3Frd3ZJNEh6bzF3NzFvZUk2WExX?=
 =?utf-8?B?NTNjMTlsRW9LeTJnQjJWdjdVY0NuRmhmNENYLy9SOUgzd1JBMDdKK0tTN3dU?=
 =?utf-8?B?REtCOVBIeEd2QkNNTFVuTERVNlp4TnlDWjQ1T09SdjNMVTBtN2lDZTZNeGJt?=
 =?utf-8?B?NU9NbXE5TEE5QTllWUtEV2QrcjR0Y2cwaW41d256eGdHVmVNQ1B5T3FubWs3?=
 =?utf-8?B?Y3VkODU3cmc1UHRQK1BiQkczRkFzMDhHVnByZERFWXJPYkFPTVIxMXVoZzFh?=
 =?utf-8?B?VXNpYWdmWXl0Sm4zT3dYQmp5REtjL0pBVWliVjVmWmw3a1ZOQ2RhazVYYjVr?=
 =?utf-8?B?RzJQUC9zMXNydXQzYkZRSkIwK1V0WnhoeTFSWHJKcUlPdlFjQ0hnMG9JTkZw?=
 =?utf-8?B?eWdleDZNVFhteGFialJDbTl2UWJaWEtnSFV0UDZYZkJucDNRYitYWkFKZUFy?=
 =?utf-8?B?SndRUUZtdnF0OHJwYnBlTkFwYnV3YmhBVlNIQmh5ay9aUUpFVUhWKzFwNitQ?=
 =?utf-8?B?MVRyOFRYV3plWWZKbkJEU3BmZlp0NGVVamZOWStsbU5yNkpEUGpUdVZKZ3N1?=
 =?utf-8?B?eWlBNEt6SWRacFlIK0NlOTVIMEdaMmV6VVdkcVBIQ0FPUFZyQXM3QlE3Qmp5?=
 =?utf-8?B?blBsd09lbGw5Q3lQMDNSYmNFR3ZzS3lHUzJHb0c1clVXK012bVViRTdaV0lP?=
 =?utf-8?B?OVUyVWhzZnJCS1hMcFdmTS9LbDFOZ0xLYXhkU05MZWZIQVJyNCtBanlVMUpM?=
 =?utf-8?B?VUNtU1dUYUw2SEI4Y3pZZ0d6eldHQVl1SUR4eGo0ZW1BWHUrbkZlMHYyTjRO?=
 =?utf-8?B?QVY5ejhIU1ZMQkJOaU5zbjJGdU5YR2lTL3VjRnFwT29kOHhTNnBqVTdvVGR4?=
 =?utf-8?B?eUxXWGM1MEl3aDcxNWhlaWtmK0c3NTZNK2krSmxidWs5ZENrZXAyaEQ1WnJO?=
 =?utf-8?B?OEVoS0IrVlUxeVcvOTN4VUhBRmJRbnRYSWdWNTJjN3lxbzkxWHhJQ0dOb1hj?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c41e328-1a27-45dc-8a59-08db0a929bf7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 11:41:40.2782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8yVMz0PUHYALhgEVwun24YAN55Fe6qzPT3M1GofgwFju+c8hoKK0bwa918ztU1qdEpx5pa2xGeHApKRYiWyqcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3844
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Feb 2023 11:41:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10632

From: Jan Kiszka <jan.kiszka@siemens.com>

Something went wrong on the Debian side with their keys, so we have to
mark the sources trusted now in order to continue using the snapshots.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/cip-debian-sid-ports-snapshot.list | 4 ++--
 conf/distro/cip-debian-sid-snapshot.list       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/conf/distro/cip-debian-sid-ports-snapshot.list b/conf/distro/cip-debian-sid-ports-snapshot.list
index bf0f7a27..77e0d9bb 100644
--- a/conf/distro/cip-debian-sid-ports-snapshot.list
+++ b/conf/distro/cip-debian-sid-ports-snapshot.list
@@ -1,2 +1,2 @@
-deb	[check-valid-until=no] https://snapshot.debian.org/archive/debian-ports/20220925T001806Z sid main
-deb-src	[check-valid-until=no] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
+deb	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian-ports/20220925T001806Z sid main
+deb-src	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
diff --git a/conf/distro/cip-debian-sid-snapshot.list b/conf/distro/cip-debian-sid-snapshot.list
index 46d34d76..1e68c238 100644
--- a/conf/distro/cip-debian-sid-snapshot.list
+++ b/conf/distro/cip-debian-sid-snapshot.list
@@ -1,2 +1,2 @@
-deb	[check-valid-until=no] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
-deb-src	[check-valid-until=no] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
+deb	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
+deb-src	[check-valid-until=no trusted=yes] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
-- 
2.35.3

