Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1424CD5BD5
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 06:46:20 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.17])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5221.1779950772361983440
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 23:46:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HaRPJv+g;
 spf=pass (domain: siemens.com, ip: 52.101.70.17, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yE+Ci2Id121rzG9TTw/1AkvQ4zMF6BXtpx3B0GzzyOlkoMmnRZABgfH2Y/ACieRh/oOQtmDtDqcLg529qkDPZMGVEepaAYgnEM29QbCQR/OJJY2j8jhOg9WZBP0R5O9FSltT8wIfOFMOjmCCh+YTgXyVinCrNVTBp2p4v3C0NLlIyeHs8gAoHcV5h4IuGlAy13g9ogyEtw2nB8/h0kWLW+lNp1ZOj/UOusf/yk1E1efje9CNIgSPAE66VCm/bZlsnSj437XUrpx9ojosmVggIZCEcYieV5MDn2KLYfrDYUcnpMYAwT9bo4hK+qeGxiVHBQrEddhemSLFHesAdVhULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fN9/bW/DULGy9hLeRTOGXOgSd3Pf8zkBQD3FQVlFqnQ=;
 b=LQxX1qP/qyy+6yaIUAys8xjJTYBUKTKBUmC5lkvzKCTzwL3gU5zARDfYsyCdqO4lKOU/T06n5xLcqQOajI9u16fKlVQlQaB8amZI3KfhkRERbnfN83aZorIYKhuzkB1GFo9eNg9pP1AHcZuzkWeO58jT6+TD5h5yoBbfWeJ5BmFO/bo/LphUki64S3GeIhXIbrmZ7ji0bSmwahodogPbZj8FBc4HvmwzOejphQnyCaJeUuCymsvs/cYTL3oQWFHVW+TjrG4MbiOBZrFDmhoOknIoZus4gXtF/Ro9reAzPRYRVeMC7vYknRAC1h6pfxu5JptDHdZTQl5178nD7RI9Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fN9/bW/DULGy9hLeRTOGXOgSd3Pf8zkBQD3FQVlFqnQ=;
 b=HaRPJv+gstk8+s2MOvGy62EaYoxVgZ9Ry+mhX3Cq3394QT+4KfpaU1OENl4vx4SDPPLWDo6+wWDL9hQwv61Von6ATkgjUqnoZ7vOjogibskvZzUWQy+ogZgz7Lzi7yHSN+e/MffYsA3PLytS3ZsuxRk1U5d5AUVVqP2DQ9JrPpeTq+3ZYou9EfEwJDf3n9XQ1nLbVtCIf+hoZq55Hz5R6zMd7tMhOeZciiaAyfg1qepAelJbmwDs8LKi1YO6ZifcFBD2fWOJydud+SZgdBf1vy+7xW5q310JB48vKhNWyAPJpehy7eeRmnQYruTOKof3zJS7FNHbZScSbXxbIYnIYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8999.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 06:46:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 06:46:08 +0000
Message-ID: <6501b46f-e24d-46a0-b4d7-5d34ebb08750@siemens.com>
Date: Thu, 28 May 2026 08:46:06 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip111[-rt61] and
 6.12.90-cip24
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b0bf51b-03c3-4e4a-0a8c-08debc84cc23
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|55112099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	DSKs4UFE2GNnYn8ML0/4scuvtTFq0w+wzbpgYL8ejTpMWpvI1frDAal0MaivYysmBmGg0z+/SRT8Bz7sR/8UMYDufYo2kW9r1N3j32SZuFNN31vilvV3YQwZbeiQ7EcETFNmISZCphefbLDk+IKG6JNazKFhkbgMK5ivVt2o8RbDo2xHnPT3BcfW2QGC2wFW9q/50Z02KcvaVtqx53DU765KAEP6IJNv0V1Hj/Y0lmUGaHGC9+Q1Jz8dgZqUpgfO4CuxwKuKgwC4hBoUUMwKVqI6VWHh6aIkbFz90HC/gET3TAogr5DDMUtDrKx5EYXwipP49huwF+rCuueIVFn5d4BCqvUjRfFcnDnBc41hOqnric4KnpcmXS4RoSEY8+4Bgo1nkT1oO2eHNKBFg30gSuGT/0xLswbkCr6+VZvxAv6DJIvNDzGUjZHH7MzEzTn6Hyc0Ksi3fnFWm5Aa6buWpjYf2rECZULxRqHoEaol1F8dn/SwmyX3bZCsIXVrcB6rQQFi51FVJlydnbRtHfL7UlnH0zb4OGQbR51xmWWO7E6lhk+/pjt1/l+PlwDKhTuvv/n/A1wrrurqXr68xvV2Hz1eMu4jAG/FoP4jNgATg+0nO0jLkdSAIvrweyq71CClAiPSQObkPu4bQebD5tNOcEAa0YOUOXZnpuFm+4nA4x0qyva4r6jBGd3m1y+z4olT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YlRuWUk4ZjhmRjhnM3ZpNTVwYXYxZWtwOFJzK0V3MERHRHMvOWErQkdvRHRL?=
 =?utf-8?B?cUpqeWRZUXlHcksxSk1oRzhDR3pVaVdyZTQ2aDJWTUhpY2l5Ni9GZTBDNTMx?=
 =?utf-8?B?cytWekhpb0ZkTG9rWVZuUG1oVGRjQnozdmVEaXI0aFlnWUplVHNidHU0TGI3?=
 =?utf-8?B?MSsvNllsSjlxMk9BbGZ6c0gvV2F4K1VnU1NkZFMwZ3BnaVdZcG5PUmo4dnl4?=
 =?utf-8?B?cW5OeDlyc1FQSXpyTjY1SG8xS3N0Y2E1YTJaZG9vdWxvVWsraFVNWFovMCtT?=
 =?utf-8?B?K1llUXVKRktRWW9EaUlocVdjbE9BcGpoYU1yRTF2dkx0VXVnREZyaWR5Rk9E?=
 =?utf-8?B?bVZtbHc2Mnl0ekc5RVBYWE9td25Ed3JUdDQwWmd3VzFWQTFTTE8vbmoxeUNx?=
 =?utf-8?B?eEZQZVBNWGk0enZpYmZpdTFDYmY0dDVjdEFlK0tNZllBTENML1UxdWNXVEp6?=
 =?utf-8?B?TkJBRVRaN0l4ekpoRmFaR1JDMWE4aHh4em9iSjZwbDVxREx5OWxQZWMwYTl2?=
 =?utf-8?B?Nm1mTjczMG1DUDNoWG9lUVBaY05hMDRqSFFIZGREUkVjMmZybTcvV29EUnA1?=
 =?utf-8?B?WHNFRll3Y1QveXBQMW1iVzFoZXJYTTZJOG9Fbkp1S0lCMDY3ZVg3VUY2WjUy?=
 =?utf-8?B?Q1RlQWNBU2pWaWRmTk5hcXEvODNZU05hMUxRSDZSaVptbDg1ZlEyMVE4eWkv?=
 =?utf-8?B?cUE5MnJMdStTblV0bXJrbWExQlZWMjdSVE9VcElBZzJIRWZVbVBnckI5QVNY?=
 =?utf-8?B?MGszLzNrZ2g4bzU3NkFGYkhWNENVeEpZdGZwOHdqTE8xencvZ2JDa1RxVlVi?=
 =?utf-8?B?WHFYRGJNUVJnUVZrdkx4Vy9mTGx1RlhkZmpMa296N1Q2YjB1dmVDYlBGaG15?=
 =?utf-8?B?ZG1ncVZhR1MwRFBoMk1QU0t0TVpIT1pxanpoNG5pSlk2bW52YUJnOWI4WmJ6?=
 =?utf-8?B?VlNGZStzNzRIWDRYTUtjUTdYbXZnWHlJNUNpd0VzMUZOSUh3OW5uMUR1MWpp?=
 =?utf-8?B?T3VxaUZ0YzRjSDQ0WHNmMmM1MWlnSmJlTExaY2Q2aHJmZENXT1NjU0FUSzZo?=
 =?utf-8?B?eFRFancvZUkxME1NbWQ3Ly9uWUJvWXBaVlZVWGplRnNYQ3lpdFJOWXJ4ZCtu?=
 =?utf-8?B?TlkwRnZHMTBoZFB3cDJjQ04zYVFBRDArM1FOTWFUWWFoU0ovMGNTcWk1VU9p?=
 =?utf-8?B?cDhJWGFDSG5uMVlhM2RPS1h2cy9YTWxhSU1DRDZuRU8zb2pneS9EdnoyUnBJ?=
 =?utf-8?B?UGdQTndmano3UXpITG93bHkzakpiUGs2M0sxZ3BmTDMxWGdUWHNocU83OWNT?=
 =?utf-8?B?MFhORktUbGE0M1lmeFRxMDRHTDF4eEhYM2VDZ1VzbXBkd2daVzNvdFIwQVN3?=
 =?utf-8?B?Ukxwbi83em1KcWY0VGY1RmZKMzM2TkUvRi9CVVgySGNXRnp0azRUSzY4enZT?=
 =?utf-8?B?NlkxRCtFalJKL3MyOG9GbmlCcDdMUlRKZ0haOG1Ndk82N0pva1VWRXNJbGR5?=
 =?utf-8?B?UkxidHRCQXVrMjF5VXAyWVhrVWx1bUVkNlRycDBnT2QvWmV6UUIvdjFBUUFz?=
 =?utf-8?B?WjM2a0JyanpwbWVXS0JuZVJETkJ0VmsxcG5iczlqS1U0N2FCUG9wbHdnSENZ?=
 =?utf-8?B?VWttUzJtM1R3akxmR2F3VE9EQmwrUCtQczBsNWlEdGFSMWRMSzdYTHFJWCs3?=
 =?utf-8?B?NGFMc0d0RzJxNWxlY2wwWXlQTmU1QjhLRy95THJjMGM4bWVJWlovNjgzSm1y?=
 =?utf-8?B?RFBwMWRrcXkwWmFzeUsxV2c3M2dqVURYWC8wKy9jckI5TXhUU0FKNlFENm5H?=
 =?utf-8?B?RWo0em94RXlWRThTTHJwdkgxL3JlYW1JOWF5dTJZOUZxc3hodlZXblBEenJt?=
 =?utf-8?B?dVFaWTVPdUxHN25rbk4xMmtYK1BKWVNPN1U3Zy9oY0tWUWw1RGpYZG9kbnhj?=
 =?utf-8?B?SGFtbEhsbnFTWDVIVDVmNjJWbURuZzV4Q1UzdStWRTRpdE1jUFlpZEYvSHBl?=
 =?utf-8?B?SE5Rc3ljQVZQbFB3ckM4bjNWQnNBNEFSeDdhdlRJdjhWSWRFMitEeWxlM1JI?=
 =?utf-8?B?aHRoRHU1KzhNWU9sVm9aSC9QcHBKYmpaUTB2UjVqaVU2ZFZaQ1YwcGx2NVh0?=
 =?utf-8?B?cGc0aDJmaEdxZ0dYZ3dobnVUMk1ZSFpwbnczdFUxN3NEczlyYmZnWjZ1KzNE?=
 =?utf-8?B?NDhUVk9rQ0RDVlNZb014aExQTTNmWEZpaktEM01OWVJwZWJ4cVdpNUpYbUhO?=
 =?utf-8?B?V2FxSW0rNEVJN0I1amt5bXdHbEVpM3g4cy9Lak5lR2lsM2ljMnkyVm1ycy9z?=
 =?utf-8?B?alB5R2d1MHF0ak5JMVhFWk1vR0Z2LzZFU1IwV1AyMFZ5WHJsL3dEUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0bf51b-03c3-4e4a-0a8c-08debc84cc23
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 06:46:08.2604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nro719MZvFry1XO8kwBucniDLaxAAug5mEIYBDUq/Rt0iW/neab58iOChjJmSsprJGrP6YvjZSr+PM25hVR26A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8999
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 May 2026 06:46:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23033

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...4.302-cip109-rt60.bb => linux-cip-rt_4.4.302-cip111-rt61.bb} | 2 +-
 recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb              | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.90-cip24.bb              | 1 +
 ...{linux-cip_4.4.302-cip110.bb => linux-cip_4.4.302-cip111.bb} | 2 +-
 .../{linux-cip_6.12.88-cip23.bb => linux-cip_6.12.90-cip24.bb}  | 2 +-
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip109-rt60.bb => linux-cip-rt_4.4.302-cip111-rt61.bb} (68%)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.90-cip24.bb
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip110.bb => linux-cip_4.4.302-cip111.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.12.88-cip23.bb => linux-cip_6.12.90-cip24.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip109-rt60.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip111-rt61.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip109-rt60.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip111-rt61.bb
index 66a7fdab..af553fd2 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip109-rt60.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip111-rt61.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "8dd1e6aafa63695c51ea8d5712384881a2dfa19be8538688d779d66d207382cd"
+SRC_URI[sha256sum] = "d82994372165c85e4de9bd76b8d785beb9590c0f96404e47de92e917c408193e"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb b/recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb
deleted file mode 120000
index 306c2a9e..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.88-cip23.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.88-cip23.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.90-cip24.bb b/recipes-kernel/linux/linux-cip-rt_6.12.90-cip24.bb
new file mode 120000
index 00000000..0bbe9619
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.90-cip24.bb
@@ -0,0 +1 @@
+linux-cip_6.12.90-cip24.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip110.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip111.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip110.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip111.bb
index 55e57d98..1c00f30e 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip110.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip111.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "d4c2646e4691e59c33c95d67b0d13fe00f463f43f3ecbfbe0295ac186cb77ab0"
+SRC_URI[sha256sum] = "d3cd13883e8c7f39613840594ae37dbe6ca5a6e0c368082e95554b0d043968b2"
diff --git a/recipes-kernel/linux/linux-cip_6.12.88-cip23.bb b/recipes-kernel/linux/linux-cip_6.12.90-cip24.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.88-cip23.bb
rename to recipes-kernel/linux/linux-cip_6.12.90-cip24.bb
index f61cbf92..4f129f45 100644
--- a/recipes-kernel/linux/linux-cip_6.12.88-cip23.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.90-cip24.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "c7044d8f5135c80bb32c5f194a940b1bdf8904cd80eea1aee90588be0e12d59d"
+SRC_URI[sha256sum] = "acf2bc2fa5d793849b97bd32cd6274ba45391464492be52a2036ba8bbdc64247"
-- 
2.47.3

