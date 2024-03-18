Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378B3C54E58
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 14:08:35 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.85])
 by mx.groups.io with SMTP id smtpd.web11.45147.1710770911904435890
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Mar 2024 07:08:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RkBmtOHT;
 spf=pass (domain: siemens.com, ip: 40.107.21.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSyHOhyPZLwHGTcUlqmmtrMphSMZcx5ZqTD3Xjhyr1Y7DKCwjBLrNnhc8E27QKp3tqVCwAxuLUDO1j+hs/vGml7j42iTxl50NzJXS7O9Uyx8PzO8tg+yuLPpZn01auAcsA7PHYKtFLvvESQSSd5OCZYCmczQQG/dI6CkPor1d+ZusuuP8o8l/4bIzG4dfkovmtovCTnbO1aYn8RTnjChuHfoypf7S4v+gdClY1zrY3mWHp8V9oQgS/sxq+bmeR7Dm5WebZL38z4cgR7XKj+U0wQHqz/3mYtwyINJTDdfd7lOYTVEC+/VJALADI/zH4Sk6D/ig5B/VR6KR+EF2VNQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGzRjEzsEocXi2TVf7USdqQC+BxVLt5C9itruxgI4dw=;
 b=LW8ynjoj+hQusI4xJ8wYTbcWj5eeLr6kG6q7bW53W2K/RmaRDhdX8uezPza7frMBUDugafIttkpZJ6mbpwq7zRqAamFZnKYpUfuXkWM6ITDWKMHJTyZPjiuAzaFXLzgcZFRKmvHKpZxaGZusttUTgxID++LTfIF/8nw+epMJFVVoD2+sojISygizfAfeRmwSnaUP9CNCgYvPqcfgXhM+m6NIJlZeIajYQfAbY6Vz233YDqga0Xb0PJ3OBQL0qvUdzW7tDkDIVt96HmnxoVQmHuCF/fIaYm4n/IwOGHiYLUao5t+8Avn+6v+lfVxC8Kip2/k5lmoIUVKw4yiA2bc4ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGzRjEzsEocXi2TVf7USdqQC+BxVLt5C9itruxgI4dw=;
 b=RkBmtOHTxHOv21ZBbZkHpxZ9VAqP8qub6hj7XrRrJkhS5niwr3TXzuN3tev5TFp5C+rN6Z7+TD4UCuwbJI5ZKvMBmTPnnBAnTYPUaWo4B6PpxyxKeofIUcqur3ExsXtgV0+Z6Jv4ksZI7VBjncrvaOjFvXihjq9HJTUHz4eU8wsMOiOlnHgfnRzRW2qFUtzCNhY2Zf2ggH9PO2z6E6DjmPdmso11IHc2JozmaMRkRsR9fQkD353w9EoGptwJ9Rn64b9XN3gREugr3r40z84cvLOOZ5zRoiXpPn7h2oUBcXQSaHn1WKH7Nxm4tZUOTD0QWH2m9ucvD7j1mYGX4Tt28g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB6782.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:336::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 14:08:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 14:08:28 +0000
Message-ID: <4114f2d6-024f-4a0b-b146-f69e8f90d632@siemens.com>
Date: Mon, 18 Mar 2024 15:08:26 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v2] linux-cip: Update to 4.4.302-cip85[-rt48]
 and 5.10.212-cip45
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0253.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: 867c0163-30b7-4189-0029-08dc4754e280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jrESxSUo/Ko/zkkGeVUiToFmdzYd2jwJEzlOoVOTNxrIimONHnAYFOTEkk2r+5291uEXjBiKKt85pLvWbl8EPBqgTCHsrcrp6QnpKvY6bRdWyOvPSAd7PrDO/GMJftRnS+Mng7YutJxbll+kys4KaQLX/YC6FxIRDsqJ9WU66VLeL011BAPDeffMSW2YICUmxv5fAbivjp6idrGBNqQMquuJ367Zsx7kOQ5MijD7h2c/vgEsOimJWdxlLEXDQm/vBKcvtghJ0tg3H+mVdORhMWOXCIXBjCpTEuuU6jtocijHqcZykq/aJf5LfWphDzU7AUZtzZlf0vJwLTsIxzUxBE22Qz6Flnbdt1HoKgkveEOnHL8C1UH2hPp6IRITb64hB8BGHzTTbDq53XZlX13THka0IYJTVaaLRSyR66NXHuFVVS94HJAA8b4JHpitF7m1imn8HG02ndH4Jy74q8JhdIrb7u3o6DoQBgLrInEUGcbJf1uDVEIr15bAK/3ZarG5ejyaWdJzCFxSnZGpmlX1pUKtAl92KS5sYRmXLrn1QaWgilZxYbkqVB5VAoFQaB9dJVfDh01t/M02lBZ2fqJ2diopUH4PRNRaFIDu6cAb9HwuU3GKrEBFxKaCljXKDuEUrpjUVIUd6/P6r+dK3nJUEpYF+R/JQYkKnbBw55JZ04E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ei9ESVJYbytXZW1IbVdPZjZySCs0aEZvLzVwQ1FWeERHRTBTOWRIWkx6MFQ0?=
 =?utf-8?B?cmtWbUdjMlNxZk43RDJXWmhITHpDaTFpT29nNG9wZ0ZTcks4TFRmT0xQQndZ?=
 =?utf-8?B?UEU1SG5taEZFdmxKNVhTNmxMRkFhWjU0NHZEcFhIK3BydEF2bDkydmZFZWdT?=
 =?utf-8?B?WEdKM1diY1plSm0zOGtsUHNCS1hKc2dXci95NUdUYVA1a0VwbklOZ2tieVdh?=
 =?utf-8?B?REJsZzNmTVNhd3pmb3VrM3AyZkZrWEFNRTY1TEZGMGl5RU1GdEtieitiRyt1?=
 =?utf-8?B?QVBiYWpONHkxS3pIK2hBaVlYV3hRa0NqdWtaVlVwN0YzMitsQjNuVXM5c1pu?=
 =?utf-8?B?ZU1ITkZCMjBIUlFaUm51ZUFUNS9jMzVJWE9UZFNsU0dPWnZmalBUclpJWGhk?=
 =?utf-8?B?azNKZUx1WWJjT2lnQS9IWEQ3aGI3UitGWllUSjZOeExYRVc4N2dYYmNGY21F?=
 =?utf-8?B?ZDQ3c1llNzJXT2Noc0p0WFl4V201aW9oR0J4WnJPOTN1OG0zRll0a3ZpS1M0?=
 =?utf-8?B?LzU3NHFQVndTajZRU05MMlpPOGgrbzZuWURXakYvTFdJYS9sc3lTdHdDdm1C?=
 =?utf-8?B?c0kzZndYcXpyR0pGMU9lNFFFNk1CUUhqMlZ4V05UaEFZR2RPWkw2V0tGK1ZE?=
 =?utf-8?B?VklPaTM2RTBmR3RLQVFXZDF6bGhEclIrSFNjSDZNQTh4U3EzbW9EZVJ1RXdm?=
 =?utf-8?B?ald1ak1jbkR1TWY5UnJVQUg2UFlBcHg3VGlpZXN3UVdKbnVQVWRMeGJJeHFG?=
 =?utf-8?B?RUZwYit3eEFNQm5WSnlHUVlKTkJhYVNxT3ZmQnlsdi8yV3FlQUQxSUZMTXla?=
 =?utf-8?B?aENGMSs3VlpndEpqMkFCOGMyS3pqbitCZUdTemJWMWwzVEdjckNuS1lMQXlR?=
 =?utf-8?B?WnZTdFRuWFE0MkxRMURXUEhXbWM5aFoybnUzQ1dKakx2eW1lZlNTekhmRFlx?=
 =?utf-8?B?UFUyek1jazczQ1h0WFcxMXFzNUNLS2ZFRXZZSW1kYWpMeTFsN0hNUnVWeWhV?=
 =?utf-8?B?QzVtQWw1V2E1WVl1T1BCVmhSd1UvYmtPTW1XWVE2QTMraElqQS9CbUY2VitS?=
 =?utf-8?B?SDBBaS9hTFNJR3JJMm1abFVidFNmNllqcHIwTzlFVU9aYVNZcTdQdU85dDFC?=
 =?utf-8?B?eUxZZFpGdjlyS3I5TkpwUEF6aWdQaXIzNi9wd0JEOUc4MmdTUVdPSUV0Wkdn?=
 =?utf-8?B?aG9kQUxCWlQwbXFEUlZJTkl1QXBXUk5PSWljVmNNcllRVnBTRDFJd2lnTXNB?=
 =?utf-8?B?Zjl3cDZxR2t3YTViaTVkTHV1ZVdJSXBMOVVxNVQwK0RaSHhnUDFBMUhCQTlI?=
 =?utf-8?B?eDE0eFNkUHhCYmZZV3diTkxkQ2FPTnYyVzJ4Ymh6dWk2c1h6ZDZ0S2tMQ3NY?=
 =?utf-8?B?V3BxZVNRZ3BGQVgyaWFYeFgzdW5KWmpVUVJhR1VUbEJQbXp1MDR5S0JDekti?=
 =?utf-8?B?UnREdWVsZXBXTElOZzgvb09YVEpuY2xibVhFL0dnbC9FbVhxZ0c3L1IwbmNt?=
 =?utf-8?B?ODNJUEdpYkxnN0hBOE1QQmhrMW9Na0Y1SWRaUE9uRTZVVTNpamxBK3JnYTc3?=
 =?utf-8?B?ditLa05ISkV6aG1XMFVFT09BY3hndC9QVGdCdm9sQnFWclE5MWpNZ04wczly?=
 =?utf-8?B?cnF3WC9vSzhQR0NDdGJYQnIyZG96c05pZnJuYWwrYS9TSEx1Nmg1SVBoN1ZT?=
 =?utf-8?B?MjhWRU9ERmtxUXgyc29Ienl0WTV1c3g3Y05iQmFhL25PZytMRVloc2pNMjM3?=
 =?utf-8?B?cUdLM2gvRU5RNGl4Q29lTEdndloyTW5ENjNmQy9vRzBOc0U2ZWhDbHcvZXhR?=
 =?utf-8?B?L2hPNThCc1ZreVlZT3FpZ0RjWUgxK016UWNqZWI5M2trdzIvTm4zbDd2K1gz?=
 =?utf-8?B?WEFTUkpkODNDNGFrVGtvUVhaZVRQSVpPeUJ3QUJoWnNuUUNrMEt1NklUTU9a?=
 =?utf-8?B?bDN5TVFKdXdQNkZDNTVMUy9EeDhqRnY3V1ZKY2lCMmFDN1p5N2dYbTYxejNi?=
 =?utf-8?B?ZFE1UXRJZkQxaGdJcWRSbWpTRTlkWUJ6SDNNcWR0aWdaMS8wTmtPZG9oV0d1?=
 =?utf-8?B?V20vckVURVdNVDU5OE1HbVhqc3p1OUJ5YUpoZ1dxQmd6QUhrOERwOWdxbEJV?=
 =?utf-8?Q?v2I08EsxqJEP2tEDoLzZKhR6r?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 867c0163-30b7-4189-0029-08dc4754e280
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 14:08:28.3596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9leEGcs0wWK9ICCHTwnWv0IyrMH/W6UCa08HYTUYaCQU+x3rjtiEp04B4e3NptSN7k+mJMKvkKiyTkb1j9aggg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6782
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 14:08:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15359

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - include -rt update

 ...4.4.302-cip83-rt47.bb => linux-cip-rt_4.4.302-cip85-rt48.bb} | 2 +-
 .../{linux-cip_4.4.302-cip84.bb => linux-cip_4.4.302-cip85.bb}  | 2 +-
 ...{linux-cip_5.10.209-cip44.bb => linux-cip_5.10.212-cip45.bb} | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip83-rt47.bb => linux-cip-rt_4.4.302-cip85-rt48.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip84.bb => linux-cip_4.4.302-cip85.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.209-cip44.bb => linux-cip_5.10.212-cip45.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip83-rt47.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip85-rt48.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip83-rt47.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip85-rt48.bb
index 6bc62752..9d4b57a8 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip83-rt47.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip85-rt48.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "cb1bdb0aafea82824d084cf3790267369d0b4bbfabed142594f15370f0538aef"
+SRC_URI[sha256sum] = "bdcbd4906a6a3869e2aede255de89c798f7eb9fb1d48426c94378f431b294e8b"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip84.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip85.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip84.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip85.bb
index 0ea0a0fd..b71ef9fd 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip84.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip85.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "aa11943e7a262482b474d205b5cf0e1ff5a7ee17aa04dca9a09fcdd154cb2840"
+SRC_URI[sha256sum] = "ea131a2e907c5cbc05fb756d00a007b1473160e4d250d7332dd050f549c09408"
diff --git a/recipes-kernel/linux/linux-cip_5.10.209-cip44.bb b/recipes-kernel/linux/linux-cip_5.10.212-cip45.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.209-cip44.bb
rename to recipes-kernel/linux/linux-cip_5.10.212-cip45.bb
index 15d45e89..111866a2 100644
--- a/recipes-kernel/linux/linux-cip_5.10.209-cip44.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.212-cip45.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "25774a60893652d1412dafc8330f8f1fa41e2e3db794c5596283d83f0496bb86"
+SRC_URI[sha256sum] = "904e4b2547eed965998236bebbfbbd60ae8bd800d11ad46fbeeeb0d67a4fcae1"
-- 
2.35.3

