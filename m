Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2EEE728DE
	for <webhook@archiver.kernel.org>; Fri, 29 Sep 2023 19:40:05 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.69])
 by mx.groups.io with SMTP id smtpd.web11.27125.1696016401176929707
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 Sep 2023 12:40:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DOPWBEJk;
 spf=pass (domain: siemens.com, ip: 40.107.21.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvBicwWGXMeTMpuX0k7QJ6wi2XgqjK46w9obyqSAu+rXlE6U67kO4Xn+FAGSKiZs1/8zl8fGax/7MCiBAKLwurwi4p4tax2DlnTzmqy5iKYg5peOokP7X5G8FqBpOk5ARed0NQ7VuNAvzAFI1z7+q7UhTeJ6VbB6yROycp6MjlN/s5MYYP87FANsyWLem6wlcqo9jzme8tONIgxvjSn3deqdEHWPV8sgwM1Nsgu+jNOOz739fsAyTVPLWq5KAC3qgyewF2teBGW9/zxtkuep+HC/XcZ5ZFRrj0/CA4S4BZdExdLDmflUmczapgM5s5Kpx4J+hmXKnIX6p4HTDhMP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnODRf/kyZODINkTcz3qO9SzIoy8k4bkfH/Im9flE9U=;
 b=A/h1Y6dQL2QIx6sdHr225QAJ0oL5FyXC49kESGH/AsYQqAigCj2wy1Ndb9t0AuHIrSEmNd48graYPhleYnK7k/++6QP68blafo2GmLVfqfAsOdcQSUSRiUvrlRyFyHE9MNw1b3yrdruBJWTkMpcHOwUcyLb/L0qxKzziV5TqzOsPKW8DWD/thSfMhtFFOB5i02rLAGjK2aWIpXqT7wcURwkcdSXf+pl9xyLK9FuOwcQOlSYBqMbURXk6ruL1XC03mq34rjWo4UesisfgvYqzcchJvph94EauhN8vlbbIJbKTerFJgKfEyebADBL2tfRsZ7Z/DJmt9K9jwwSCeq9FGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnODRf/kyZODINkTcz3qO9SzIoy8k4bkfH/Im9flE9U=;
 b=DOPWBEJkrpNMxx6sycav8TuwZH3Q7htFMm0YiuTULK1gkHqw0em7r8Fb4I4/O2xVca3BGTpm1teiDjT7KdmZaGJTpQDdycD9HPF8aGk2aKRfhOzxMBsJQXiYuRi3xDXES5k3T6DMElgrvp3uD111tlG/VPIA2Sjfvi3h55FdDTBaR8bqphh9wvK/0z25i5dhd6OMUqSgTW6491jsjUSM+xSD6kY96+y+I0glAUGmZ8LS79qi8AFXSo6V8QRWKmwGLpw5YaO3PzTFGzli2iY5dr6SMusMK0Yi4+xfvol52ogwB9zrgtqNitquZeQVSimDuPiFMqcjTie2omrUwGVVfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7998.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Fri, 29 Sep
 2023 19:39:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Fri, 29 Sep 2023
 19:39:57 +0000
Message-ID: <acae8aeb-847e-433e-9777-26c344df8167@siemens.com>
Date: Fri, 29 Sep 2023 21:39:54 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.295-cip103 and
 6.1.54-cip6-rt3
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d68d5f5-0031-41ba-ad24-08dbc123dc82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4lw/31dnvrqNNX0FYk+YpHwy+wPC49Q4Yc7XqOzVanGlpQ1r92k0542L86LAZYDfx3w+xPdTwQb5fUD9Fu36mQZuBTYq0YnDerRsKXTPi8xVNYf49XQbPZEAHP3Z5kUGMVP9r9ctCQzzpOYZcyR5H7ee85Ledn52Aa+B3sP0hFtdDKIui9Y3h+wNfEapYh/fChodbklulJ8rOSDrb1QGR56BeyBA2Ijh1vBGeT8vDCU9Zgm0PLt4VzlAaddSPP/6gu12ryERXYdoSW0luG5+CjQgN8zmTHCbKH4LeiUS+ZMi8pw5UF19rTb7uK9mOQ3bDnP5GUotZrREmJjqogFdeq1nIvYqIQvd/w22Q89GdD24jc3nA/uNqPJ9/h7JlTGxcTQmabQm1oMGKK1bE8bSEKgDhzEnUFvgfCRDxI5p5sBgE/hJ+XjpPu+RZtneBf+UJNJ7tGDWa3NJrbIl/NbR8yV5bahhMEaEFhXUYQZCZX5kz0xiy/vfMla0IaJ/onj9iLIqE3AUHJn2Z0rGkIb5YeZBmkSLS/ql2BXJjPCx/crF2X8GyHeNz16YRXshJXH5zsUqKrpWlmI5eZgl9+NzgdB4PERh5lKA6BtNnWn3hSGvdahGRmZWPHr5rBAQXHYJ+MkBDbTlkoZtKzXlJibphQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6666004)(26005)(6512007)(83380400001)(6506007)(6486002)(478600001)(41300700001)(6916009)(66946007)(8676002)(8936002)(316002)(66476007)(66556008)(2616005)(31686004)(5660300002)(44832011)(2906002)(82960400001)(38100700002)(31696002)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Vis4Sm1vVE02RFltTDl3ZXN5M2Z5U0ZMVTZZaFdqeHVEbnZ2UXhmdE5HViti?=
 =?utf-8?B?TkN2S3pZbDRnbUhvS1dtb3lUalZ5cUZvZDV4TGkwTThVMDhCM0NCaG1mdHhG?=
 =?utf-8?B?VCtLVFhRalRjdUZtTUk0cHNFWEJwQS96QlZMQXdtc3BuWjNiaWdXNEM1RHJK?=
 =?utf-8?B?dSs2ZzVsUXVveDE5VWo5RmF5Mytkakpra0t5dVpnYnd5WFR1TXVNTjkrRkhs?=
 =?utf-8?B?MXJralpqcnVneS9yVm9BbnZiWit2VFowL3dLK0RTZzNmVlNMMnpzZ3NKV296?=
 =?utf-8?B?VlBwMXJyRTRBM0Z1VGNJZ3dOaFgvaUJFaEtXUWlUMVhPWlE5S0pkRnl0bTlj?=
 =?utf-8?B?Yk02OXBMQWk5Nk5FM1VVZk9mallPVmJnRnZZVVE4by9OVGFDMTc1Qk9YcHY1?=
 =?utf-8?B?UHhEcnRyVkNFL2UrZU9hNjZIQmkrSXJWckUxVUgzZE1EZzN5WE4rdlRPekJn?=
 =?utf-8?B?MDFqOEkxU3lzY3IvL29DVlgzWDR1MG5jdmR1TVJqTmFxS0ZyUWRaRXlFMDI4?=
 =?utf-8?B?MjkrOWN3eEJyV2dwakh6S0JuRUlTN2FrM3ZuY3d4bncvMnh3a2k1N2tYTjUx?=
 =?utf-8?B?ZkIvUTcveEREQWF0SHBnUGdGN0hORjZqWGtUcU1mYWF6NnhGUkZ3UlNhSmZV?=
 =?utf-8?B?eS9CMlBzQ0NZd0RZSmo1TnYwOW9lQ0kzVGlieGYxOVBlOU1US3ExaXAzTTAw?=
 =?utf-8?B?eU1PR09YZFo5ZTN6TUtodmpWZDljb1p2clBZaitaL0FIR2c5SGh4aU9iNG5y?=
 =?utf-8?B?dnFOdkNCRkVkdGd2S21HRU52R3c2SFFFRHJTYzM4QUdSR1ZCWTh1SVY5NkR1?=
 =?utf-8?B?b0JEOEtEc3NWZHRORTh0QVJoTGRpenFkZ1Ewdkg1aGRZMjJ1cHZxR2RyUCt0?=
 =?utf-8?B?ekUyY0NWN3FpWkV2ZUJnT1g5T0sxTjVSNkM4YkV3eGlQNzlQSXJHLzljL1FR?=
 =?utf-8?B?N25jMU9acWcxSHpDbVhXZkxmQWpGNmJRR1hKcFk4dUpmYUdZMGdkYlZNcXlx?=
 =?utf-8?B?SXd1ejR0dVJkRThkSUNNR1FVVlBKNXF1cjVlMEJzbGtPZmFjUTN5cnNwb2dQ?=
 =?utf-8?B?a3I3VDZ2b0xNcDUvUDRYdmJZZTFHbm9heDEvMTdKREIzUVJUVUh4MVVoQWNx?=
 =?utf-8?B?bmZ3a1JFWVdtWVMrM3B6U2tjNUUwMzhmaE1FNW5mWEhzZ3dJS1BNVXg4WnpD?=
 =?utf-8?B?eWN1bXU0eTBwb3k1cjZaa2ZVeGFUVE5ITkIxTG40ZkgxK0xpcytqS25LNVFs?=
 =?utf-8?B?VjErQ2dDeDNVRWI5eUhkb1l1WkxHdlVaQXFmbmNRaWp5b3owNDBKZllYOWcr?=
 =?utf-8?B?RkhQbnF2bG9oRHZoSlV5MFNNdHFMWFl5RjNsa2dER24vYzc2MytMTkpjRitV?=
 =?utf-8?B?aHhFbXV2eDYrME5Qd291ZVhla3V3RHoxTEVOdEtQNXZ2ZjRQK3BQamNtYWJ5?=
 =?utf-8?B?eCtGMEI2cGpzU3U2ckd6eTc5c2dJZTRJZ2JiYVgrcVhKWkdlWHU3TUJMdENW?=
 =?utf-8?B?eUNCTDZiNVdsNUJNVnh5SjQ1cjNrUFQ3TUdhOXJKczNLN1ovQ2NvT3pMNGN2?=
 =?utf-8?B?ck1wTStLMXNNUW12U3BnM3lycUdHSVRMRVFvYUZWdUc3cWVra0dRMkhmQkYy?=
 =?utf-8?B?UU9HMU1USyt4cjcyRUVibEpZUGRyS2VYcVFyd2JGalMwSlVTbUlnYzNlS1Ey?=
 =?utf-8?B?akVTai9XT0Q5c3N3eVdGdTMxZHVUNEdXNlArVGZQWldZWFFOOWplKzMrdzNx?=
 =?utf-8?B?UENpQ0FpNXBvL2VuZDdURklMYXlOUVd3NGFXR0lJbDhUVjljbktNOSsyUW54?=
 =?utf-8?B?Ni81dWVmWm16Mmw0VHJnNVBQenlLdFBrSnl3QUU5Rk83eU9JaHJXVG5Fall1?=
 =?utf-8?B?L05iUWtDYWNFVndSWkdUNGluRWUvc25lSmtBb0RleTRwLzAwRkoveFI1Z3Np?=
 =?utf-8?B?UVVLdHV3YUx5NzNIdDJ3TzdJeTVCZU1lODR1VFpsRU9SdnQxWFVSclhXdnhQ?=
 =?utf-8?B?SmhZbm9zYjBVM2lkNjNLUlh6VXhWeFhUcmVaMTBZMUtlMG9Va1Jhb2JJYmsy?=
 =?utf-8?B?d2x6SlpzakxnY0dQazNMRXVQalJ6cE5sVU9acTJVaHhZOFhiYWw0UnhaQ1U1?=
 =?utf-8?B?dDBNa1dab1J5cmlyK1g2ZS96VmpialBKYUVVSlVtMFZnRU5YL3pBNVBtWkNU?=
 =?utf-8?B?ZWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d68d5f5-0031-41ba-ad24-08dbc123dc82
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 19:39:57.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0Rdp+oJaqSy8Fj8AhAJD1kk/GlO8oH4jqqHaLGIs/BQoP4/wsTt9hcfnr6ar4zzZrMCXjrLY9xKwlGOKqp2Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7998
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Sep 2023 19:40:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13253

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...ip-rt_6.1.46-cip4-rt2.bb => linux-cip-rt_6.1.54-cip6-rt3.bb} | 2 +-
 ...inux-cip_4.19.292-cip102.bb => linux-cip_4.19.295-cip103.bb} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.46-cip4-rt2.bb => linux-cip-rt_6.1.54-cip6-rt3.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_4.19.292-cip102.bb => linux-cip_4.19.295-cip103.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.46-cip4-rt2.bb b/recipes-kernel/linux/linux-cip-rt_6.1.54-cip6-rt3.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.46-cip4-rt2.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.54-cip6-rt3.bb
index 5a00b6de..0738ba00 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.46-cip4-rt2.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.54-cip6-rt3.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "29f926c8755a503baa3e34bb967437e230075c9d9798c22415248983e9f53666"
+SRC_URI[sha256sum] = "8b578b83e7cd18c4649162d0c734e6af5c080f429f8636817ee402e195a4bdfb"
diff --git a/recipes-kernel/linux/linux-cip_4.19.292-cip102.bb b/recipes-kernel/linux/linux-cip_4.19.295-cip103.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.292-cip102.bb
rename to recipes-kernel/linux/linux-cip_4.19.295-cip103.bb
index 3df4a946..366d301b 100644
--- a/recipes-kernel/linux/linux-cip_4.19.292-cip102.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.295-cip103.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "15e962738fcf4e98189f887c4d80037b04dcaaa227a0aaa6c7447b7367f6dac2"
+SRC_URI[sha256sum] = "5b746623483df76fbe83800a3854631d2311cf5679f2207b1999fdc0e73c34f6"
-- 
2.35.3

