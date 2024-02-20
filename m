Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20BFC48BC4
	for <webhook@archiver.kernel.org>; Tue, 20 Feb 2024 19:34:47 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.40])
 by mx.groups.io with SMTP id smtpd.web11.22516.1708457683255353690
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Feb 2024 11:34:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Yhe65gJp;
 spf=pass (domain: siemens.com, ip: 40.107.14.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNGy35Jf7ezO9WQAM3u5JbHqazmWqTH1JQQYpGlDgKNZ25Q7dwxS1r7VvpMG03TOkaDoNPz3+MHkkTs2UxS1I92ULnEhfO9Ury51iWo+YaMkbhXm138oB+2UiuC+WaDEIzL1FIrzj3PjC9LNqaXTUpgspGAaO+26qpT6wcq8fXUtRatD7XPvoOer3O6B0wfjDa4isU2ny4cfJipeFK0HQCic2flC2YXkZhughMOs2S38sX9FxLKTSeS2UzcqOj1uA8/Sfbj6BNvgBlW3CJrO5Xxm9Diy60pmvmeKavDYmbWUhtkhf1AzuPvCCcMrdFyfmL8+0cZCgGNF8Hf2lMhW1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXp5LWgW5xVQsQq2GLgZ8iTCgRhF/fVL/D0eJVqEfdY=;
 b=BzRyKreXlcrVOROgLbLXY3P4j4Dl/1Om6yHTviKrPOw59YD1yIIU+r+EelTa2n6Nl0NUXKDL6icEUNPKtgHhy2GJcIp+7qpmkbNya6OlgKJk2m81TR2VUycS3vrTf1otBrmLcMy5GKesfAEpxdkypW1CaLqav6w5kagPKnf9C0NgSw+RrugaM/X7/JmyKxBnd7ZJB4SBoMTpG9o4WZipVwRdN//iiDc3iBvNYXgUAPqr/SRzC4rbTAJyEF0i1l3MQq9A6xmUrwSDjZOSePlFr+dFONM1LC2OZVtW4+pjN7hiY63WR2XDsTfpcwRpNPxs80STo4pMvGRruSbfM07GZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXp5LWgW5xVQsQq2GLgZ8iTCgRhF/fVL/D0eJVqEfdY=;
 b=Yhe65gJpMQvRdleorB4twQI80zEFulNOXkED4/27/Q6R/0B20MDfkQg7x73lDAA5AAfUkbuuy03FXrza9lmzVgTb1nKgRU7G00PB0hSbakqipsHfZmXGYwnB5bTy9MrV5tdb/BshQ+ZJwH0MQg9dprZT4hI+MvVRA2JxNGbisUzfVxV6uRJb/Ske9Zz0+KN3+S2u3k951cPqmE8zLAmXQP3zmoY7H9Qg4svbcCpew29NW3iERrRihtX0gYrM9+5EOfNm34tWLutOe/3FBVEyufJR4bZ7CvAlj3b2hEcXKttkI5ODooUBGSCetRtrqhDwDZndDsx0MrwqxrN2UqrEmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7283.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 19:34:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 19:34:39 +0000
Message-ID: <9592f3b5-5148-491c-be55-ea2c95cffdb6@siemens.com>
Date: Tue, 20 Feb 2024 20:34:38 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v5] update ISAR to latest next for dh-compat
 improvements
Content-Language: en-US
Cc: "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1d816f-b969-46ee-15d3-08dc324afaa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DG7Xpgyaiv6+WuLuBlzLMK/gFYYnS4y4VzaC2EIOa084EZ8EABSAHaleT/M7A74pE/8rxkQJIQKqXKwgjUY9dIo8BfkDTU6SMG2qAstrwddKVmZZJ0YZR//iU2aQFV545l+btj7ZUp71DSOVp/N/mIxdEr08GnKhpwPCU4lexXXBXjfk+S5pCpIfe4BE0jc6jYtuN+FN65tRcFsWVEGv1m1a924rqZe7zQTI7ODLVaf9kleuVW4E4S1Gp35fLLi+T2sfk3NKgmIxcsWMK6kEsrYLtZVtJBMsWWiIuUeu093Sav4ZZ/xzejqtP5w0Jspy3UHCMXjW9A4f8Oi3uGUSlfthIVR5k6x/gwfYfuKG90x4Ch80uMJPRa3PaQ6svP6bvS5iB0lsCtQZTN2wkjsyqnir0EJSZa4R8+ZU/vVNE5VAn4cx/PltiSDhsEj7cZ4BnWR8rf7ilUwR+lj6mY3/YYCU8qrfb6kVTq0Je4oTrqrJlO1JtRcNMtF/HrOnZ917cBTIS4YTP61XuQZbuOUKjw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bHpVcktDV0cyYU5GM2UyNkowbzhZMlJqQ016bHFZejZqTGRBdUtkNXFvYnds?=
 =?utf-8?B?aDB2UHVvNlZyR043b2VsT3JFOC9VVjA5aDlmM3FRbDU0MzhoaDIyTGRCeWpK?=
 =?utf-8?B?WHBtQk4wZHk5MnhKdC9rbURoWThmcWZrdTdXVUlUbUhWOGozaG5yL0FnT2Zz?=
 =?utf-8?B?ZDgvMTh1ZnlDcDl2b2pFaEdzN3R5NnBZR05nMDRBRDVPVytSSDM3bWZ2TE1p?=
 =?utf-8?B?eHVyZng2bEdTRTNQZTlDdjk5Y25lanM0bU5RMDM3VHNSNmtPN2Y4V1BhWVNz?=
 =?utf-8?B?V2tGeWVia3lSdnZScEUvZXU5Q2N1cWFLYlBvYTJQRnpsclFjRGU1Nyt4RUFQ?=
 =?utf-8?B?ZzJ0azI0em9FWGg3NVlHS1BKR3BDeUNnMzBrdVlFMmM0ODh4eHpGc1ZhWlR1?=
 =?utf-8?B?RVJpVVpJWTAxMGFhcGV3NXZsNXBMNHJWVzRUZXk2T3owQkc1ZkRqUWhMc2lk?=
 =?utf-8?B?ZUpuTG8wdy9hb1BrYXA5NCt6UTcvMlA3OGM3Z0dDQWZlNEFENlU3YmVkQ0Z4?=
 =?utf-8?B?dm5BbGhUYWk5UjhwMlFPMVcyWFhIQmw3ZmxKREFpa3E0aURrYmlHVWNsdHBN?=
 =?utf-8?B?Zis2SWlpRTNZYVFqbFY3eEROaUlqQ3dtRUVjb1VmWFFBVDA1ZDF4WjJBYzlm?=
 =?utf-8?B?YmtKcmlyQjVXTVI3UHIzdmdXVzY3Rlg1WnVVeWtpeitnT3hBcVJpa0JYYnds?=
 =?utf-8?B?ODBhMVRVeFkrZ1FiaGszQyt1Q3B5OTlraks5OWdFT1lwK0QrLzFDZWF0bGVp?=
 =?utf-8?B?czFzb09RS3lMWGNxaW5JMVlpN3ZqcldlK243ZkxxYitPZVRIZEVDT3VlcnVs?=
 =?utf-8?B?S1FkV092K1RZODhHdEN5T2sxSy9MQW9KNDVzOFVmS0M3YXpKTEZScWZHQ1RC?=
 =?utf-8?B?VXJpN3MyNW5KMEJ5ZjJRRDc1YWxJSlBUN3ZFbVJOcVNMQytVc2lDdlFVbzBx?=
 =?utf-8?B?ZXJHUU9mT3YzMEF0T0V0eWpvREE2ZExlL0lMaFZLSGE5RWpyaEZNMnVPRjdt?=
 =?utf-8?B?TS9TL0lEbDN5TGg3YTZqS1VYNG5nbDl0SW4zUmlrSmJXbWZxdFpPdCtoUExG?=
 =?utf-8?B?WGhMUXdTajZMY2RtU1MzS2hHdFZBRjdsNGtCVUlUYjlJQlFnR0twOG9KV3hm?=
 =?utf-8?B?dXc0MUJLNG14TitqWkdmTkxJWHNhNW1WK3pWSWtNT2FOSklsd3g3MmxLL2dq?=
 =?utf-8?B?aURyd1RFeEYza1JPbzk3Rk5vUXhTa3F6L1JrWFM3RnNuMUZvb2p1d3hBSjRp?=
 =?utf-8?B?YmZnT081ZVBxZE5ySVBldUpwMytzYTRIRFFISUwwSGRjNmZHNkMxbUg2dGtB?=
 =?utf-8?B?ZDRYRDU0RGptTUpUMzBmTUNnd2NhKytpVW5zcFAzY0dFb1UxMG11RlJENXNB?=
 =?utf-8?B?RTdHWHlubzk3U1hWOW96NVhqd2ZkOEJWdlZRZ3NqZGRWSXBTc25hUHdVRnlZ?=
 =?utf-8?B?QWJPemFvZmFuc3B3T0lVMUJYdEZYRW4zSTZXcmhvODB0VHIyb3lSV3JKRFBp?=
 =?utf-8?B?dFJ5NGhoZG9oUFFlTXpMdGNzRWh4azdVZUovbUM3YUtHN2dUNWQrTUVGall4?=
 =?utf-8?B?bWROVE5kWnF4RlV5WUNLbGF4S21uelEzSmcvQy85UERwaDNDcmpzRlhqRk5W?=
 =?utf-8?B?T3ozT2JSY2xhalg2VkhBZHh0N3QwRnFyMXh1TzBmUjlyRlI2b0NITC9JRHlo?=
 =?utf-8?B?bnpoeVhWNnZVcFZ4TUJkc1dXMERsdDVWcSswRU9yTmtDb25weUtZYmxQYWZT?=
 =?utf-8?B?L2VHSFFkODNmYUgzZm03aXBaZE0yeG5xTFFVbHpxUTJkRFhwanVnQlVOVExL?=
 =?utf-8?B?Q3gzU2t4TGU2OXpWWUxZeG9IZC9IRDhuMzJ6aEJVZ0VJa2hmUzdieXQ4Q29H?=
 =?utf-8?B?blp4UmtWY2RGRUVwelZ5UExGbXBHL2FmSGpSY0NMZ24rMEdMd2RZT1ZyWWZU?=
 =?utf-8?B?SXdEL3FWSUZBK2d2UXB4QitscERyYkhQYzdyeGtFbVpBL1JoL1M1WVY1QlNU?=
 =?utf-8?B?K0wzbzNJeGJlZjJLcFZzaUhmNDNCWEp3RkIyTVFtTURSTEZrMC9lUk9vUC9R?=
 =?utf-8?B?Q2NaQUE1K2pRUzcwMSs3NFd5UTVPVlZCQzZCeCtkd2NRQXZOZTVaTmlzR2g3?=
 =?utf-8?B?QytIWWZ3UURTV1pScUVnZzN2dVUzdlcyaEVYdTRXTVFVOTJkbGttWlJnZjB2?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1d816f-b969-46ee-15d3-08dc324afaa2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 19:34:39.4456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lW06WprJX0HefIeMcl4nJCrwdLqCN0OtXv4Y+j212adFoADlWtzbGnOk8DbLqRAYEShvCUMfTKMsWv+mFgTJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7283
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Feb 2024 19:34:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15043

From: Felix Moessbauer <felix.moessbauer@siemens.com>

This patch updates ISAR to the latest version on next which includes
enhanced support for debhelper-compat. While doing so, we switch from
ISAR/master to next and also add this branch to the kas file for easier
tracking.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
[Jan: upgrade ltp recipe to debhelper-compat]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml                           | 2 +-
 recipes-core/ltp/files/debian/control | 2 +-
 recipes-core/ltp/ltp.inc              | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index b255c977..0b209141 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 30471bb3f787fb0aa822d15e141ecce2f3b99860
+    commit: 07573d7a6030b8b381518387867b6406b1441f09
     layers:
       meta:
 
diff --git a/recipes-core/ltp/files/debian/control b/recipes-core/ltp/files/debian/control
index 9caaf38d..b43cd6f4 100644
--- a/recipes-core/ltp/files/debian/control
+++ b/recipes-core/ltp/files/debian/control
@@ -2,7 +2,7 @@ Source: ltp-full
 Section: embedded
 Priority: optional
 Maintainer: Gylstorff Quirin <quirin.gylstorff@siemens.com>
-Build-Depends: debhelper (>= 11), autotools-dev, pkg-config
+Build-Depends: debhelper-compat (= 11), autotools-dev, pkg-config
 Standards-Version: 4.1.3
 Homepage: https://linux-test-project.github.io/
 
diff --git a/recipes-core/ltp/ltp.inc b/recipes-core/ltp/ltp.inc
index d3350cbf..c8f1199e 100644
--- a/recipes-core/ltp/ltp.inc
+++ b/recipes-core/ltp/ltp.inc
@@ -20,6 +20,5 @@ SRC_URI = " \
 
 do_prepare_build() {
         cp -R ${WORKDIR}/debian ${S}
-        deb_create_compat
         deb_add_changelog
 }
-- 
2.35.3

