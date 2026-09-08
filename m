Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E1CC79F82
	for <webhook@archiver.kernel.org>; Tue,  8 Sep 2026 17:31:59 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.870.1788888710127798272
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Sep 2026 10:31:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LRzCSDf4;
 spf=pass (domain: siemens.com, ip: 52.101.83.39, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTNb9eXkn74G3S9JYZyZVXhzKVVbzFbqGfTrewGOaNUMoKoaYRFe86CptOTtLIHgWiiObMz6tvYRhFolVvRMslZ7wNwWf5fEKscBJlL7QtLPZum8NsfMpvCB5Ted69n/mGau5fXp0mit1vkuUVlEGjimIsse7yq7qM8YMuBLK2MT4QlOGQWzIFDXJnrBTEke0bCgrKWf/a1y/giGYet1K8gGrg/RMwEHc+XUACdlPjJ0frlQhlydPGFFdOy/Dwr4ecp2jKytiXMC8GQcFCBnqMzj0/zJPUN6toi6BS+x4XUjHnCigEBFjtzhoEBg2wBkVWsuE//xGDjqrL9fLHJrKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJcpmuMOglAaDAWl5ybukkJxs2E5ZjHfEDeM+UQzAzU=;
 b=bHpliureaDtdYbdXAwTTLC0Dx7WS+zzXAh7Z1R2fkFdNg2wGKcLlZZD9t+t59IhXHTBixi+gM6VtNFPyARC+ts4zP8g1zbGm/cbmB+ibflMQwethaFoScR/Ayp41g08f9dsuz8m5g3dnr7B8KPfNlEDM3+9S+B2NyMR+v7XEx9JAZrbIvraDtWKDvYVK8fW64IG0YHp3t6Cooro8iX21qm6/0NDR3DhP6TeJSvC3i6rzF9N5lAnx49/GmK5B4kKjOn9MWD4uN4vYkAnvxb5Qf7tDIMhRbW77XHRsBFC01alP3tYaIEq68OBKUFhRZCnP1pFlgmXucFWlLr+eLNwGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJcpmuMOglAaDAWl5ybukkJxs2E5ZjHfEDeM+UQzAzU=;
 b=LRzCSDf4GL1VzVTcO+gF1lXVfYk1MfhATcL+wEQPmh8jjqXRhkEnPAlXiD9HHRmXZN3En0dlsS3/DkWcIz2PrfCDyFa1JLwwBB6JU86t1s529WIoa2P8JrXjREqKlytY1z6BrznNr+Aex2hYFam9qckLxItIKrL3AArbFk93XD4RE9zdwmQZC6GQmqnh35+HQ5ihtOO7Hev5cOCWdweynQotOdVU+JA1zOlAZfSyqADaWnBHmOuThmJ/0QGrnJL81NrS9vlfOANQL2vnM0LW19gMfsZZPNWVZggjBkaqOjY2pHFbwBli5kJWMzkSpkGxaq8ivQJczPxm4yYPqwJ4hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GVXPR10MB5984.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:16::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 17:31:45 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 17:31:45 +0000
Message-ID: <5e3f44e0-ad5e-45b3-9b68-b476cec7a05e@siemens.com>
Date: Tue, 8 Sep 2026 19:31:43 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] ci: Use debian:stable for reproducibility test
Content-Language: en-US
Cc: Shivanand Kunijadar <shivanand.kunijadar.v45@mail.toshiba>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0384.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::18) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GVXPR10MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: fa668572-fc3c-4203-c6db-08df0dcf0dd4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|55112099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	jJQx10+uDbjMe+e4CkW7H8gpQDEaZw+UAku5l8uejL0vsu03oP4UQvW+67Fbz4wDdz9wjhfapGULU5vuzpx3itagda7p9EuzQ4jSr+9FNP+HwloZ6imd477a4xLjJ1BVVy3UC+9Hzx+8bcC+/GCSdWh5Iz4vSrlroulSkZua4nFBEUtJwILQCR17kfbEeuzHcb7BFtUweGMdyJ1q9r10OlndrMgfIfbNpv2o6kAuFRkezm1u85puVTcOkpjPkMqr4yzMML1dXCF5ihdUxL/060OXQVn4KrghtgZkRuG6urrGf03NGSzUoIzxlEFdgghFM4WAvd7AQ5Uo81yxGCwLrlCM1C7pJoFryCVtoK7nH4kVC8bLg/5HwcW56WSdI3mG3FRmrOgqnv8fA8oT16WD5y76uP7FUnguDniZYjU50U2TKJzzPwjlnGJCbNuu02KLXAkIPFVjOm8aSRyqNAeeaZwffS6Z+645c7TNHzW6JJBRSmMtWmXoYBbzhpQvkfJqFBw1nKz0X+VvaQa83Y3rMhx7adFam0G8pe3H7P92f5D1gJHl2MvbnHcqoiu/da/XMOyqSGLn08uCsmy3yvN+h7PRlkmVexidg2TRQ3qOkwDlm/MLbf40jofutgPocFEnB6o1oXQ+fVx7AZLJo/EuJoKGyWG9UxJrbNI/YPr/0c4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(55112099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YjY2UU5KZG9oQjhqLy9TUHBBVzJDNVRGU1BoQXlJT3pwbnZXZ0VMNWpNdmxW?=
 =?utf-8?B?SjRaVVB6VFkrd0dTcHFyRi9mMmh5Tm1KQ1NkRGpVWm9kS0cvaE90cm1OVFAr?=
 =?utf-8?B?YUNhQlhMdHFObTdxQUR0NDlMbFNFVWVHeCt0ZWZDckgwNUpmRm1pVytKR1J4?=
 =?utf-8?B?UlErdU1OVGRtNDJUVTF2RWFFaWhQdzNXd1BKTnA1UHlKWUcwRStiMUZJM2JI?=
 =?utf-8?B?SVUzaG1MMlRMaUk4R05KcUNtSUo2THZTeUJVQXJNd05RSTR2OU93ZDdLTDFX?=
 =?utf-8?B?WXlSTE5ZaDBZbTdyK1g2b2xxcW01cmJKUzIzU05zbXJZbWJrdUk0aUROUFow?=
 =?utf-8?B?R2JKaWl0V21XSk54Z1l6NHNDT2hJTm5zWFAvS2xkOGdzbFlCbTFwNTJybUUw?=
 =?utf-8?B?eGJmc004TTdRQktielhIK0FvVXJiTFk4UkREM0ZtdENWN2Y2enk2QW5uSkpZ?=
 =?utf-8?B?VWRQS2ZQazNSbk9Hdklkek1iUTdlQ0hsTHFsckkrbk9OV3FPZHB0amFzM21M?=
 =?utf-8?B?cGVla2RGdTRpZEk2WnN5RkFOQUp1aW5oTTRTU3VTQ1lBRUh1VXVxNnA5WHZn?=
 =?utf-8?B?Tm5UY1BRbVpWRER4MVBWUFBPeDJHWjBuVUQwcVErc0owYXFSUXpLa3RpYlhn?=
 =?utf-8?B?Sk4wSjFvNll2UmJnaHRtbkZmMWZsZ1VnbmtwMnduekhBalBOOXJIYk1MOXJq?=
 =?utf-8?B?Mld2MXVKWGRmaXlrckFSSVFGZWdRMThQalRIbGNsZ0tnRTlXRUJieUthZFEz?=
 =?utf-8?B?dWFKdk5nUCtrbkFjdUtHTWxranhZUlVJOTVJcHRYYUV4UW9lTVJ1UzVPQ3Ft?=
 =?utf-8?B?dlgxS0lESHJaT0tVMzdlRGI5TjdwVDhrWGdUeUJVcGY0b2xRdDMwVEc2dHlH?=
 =?utf-8?B?WlJOQkVsSkVMZjBra1dnWkgrdVBEUEpaZXU0OHRiczArY0t2ZGVMODVyUWp2?=
 =?utf-8?B?dll2MEp1b09rb3ZCYXlKRXpDV3NqWXB5MlN3YndYdWEwaWUvSnhVMzdxY0JP?=
 =?utf-8?B?blVNZE9zQmg2cHpjY0lVcC9DTXptUFpuVFBmY3BMM3pHVVRjRWFjSll2bDBj?=
 =?utf-8?B?SFd0cTR3YVYwZ3F4Mk5pZDg1VjBQN0lnQU1TMUZLa2RWMVNYeCtYRjYrZnhG?=
 =?utf-8?B?UGZsY3p6YnFkdUVyaElHMVZlMEdGMnVYYWdWN1cvS2FvZDFVYkx0MnVzZWR3?=
 =?utf-8?B?UE9LMjYzL050QVB5YXFrN2VuRVo1eW0vMFZKOFVXak9iWDBoWUVFQXpNandB?=
 =?utf-8?B?U3FuNWRsQzd4S3VDUzFtL2sybkc2VnRkQk52ODJic05GNTg0dG5jc2hRUkxI?=
 =?utf-8?B?eHgyM1JYbUJQQnhnbkwzYWFYMUJTUHNKb2E1ZlRTaTRsVDBJVXhuUmpNa1g5?=
 =?utf-8?B?bjN1aXRhZXRtbGF6RVVyRDhMd25Pc29SUWVlcmptNi9FYVg1R2R2T2htcHhm?=
 =?utf-8?B?aWNlaHNrZ0Fza20xNmdEcXZNcFdIUGxxU2ZySXJwak1KTVdxSksvR1k1aVNv?=
 =?utf-8?B?b0wzUTV3RkQ1STF2bXdxNDBLREU1MGFkWmRFRnZZcHg5RzBhWGN6TWVFeFJJ?=
 =?utf-8?B?dEczWld2NzBOZXEvaXJ4NnFRYnZOVmtrNXJxUVFaTkFmZW1zNHpWNHhwTC9V?=
 =?utf-8?B?S2taRTl3UVVITURQajBIWWllNVVITW5ucE5tOG5qV3czNmpjRU81a1lOUVBM?=
 =?utf-8?B?aW5LcDNMYmVoU08zZnBmOEpDSUpjYSsvd1ZBSkJzWW5RamxQNEc4UTF2YVJp?=
 =?utf-8?B?U1R4bnZZYzRoRVRFRDdPYTI1a0Z0OVZxRHh2OEFrYzFlWGw0YjFCYVF0VEJn?=
 =?utf-8?B?K0lGa1dwa0JRdUtvWitYMzJOdWxwQm55MS8wNm9GUUlrSUlhSGdTbmhOejIx?=
 =?utf-8?B?VUJWcjB5bnpvQnp4Tk5LaXJQU25PQUpyV2lGa1R4b1dTclB3aFJmK1NwZENK?=
 =?utf-8?B?VnBHOTN6cGJMT0JEVjFCeGFHRnUzc216NndJR2FWd2RHRUtLYXM1YStmQzZZ?=
 =?utf-8?B?cWhUeUxtaGZwSUtwWjk0Nm5ZVG5zeHAxWExydWlTNlh2dzk2U09IeHluaXhx?=
 =?utf-8?B?M0FnK3NlZDNYeGIvZDIxSzlWU3VkQU1RYWp3UlVKWUpFK29nWFY5TzBMTEZ6?=
 =?utf-8?B?ZnhnVEpFcHdUK3NaM1IrbXNjalZ2OXlXYVRNWXlzN2k2MWNYSjJ3RDRPanl3?=
 =?utf-8?B?VHVRcnJoZ3hyVElUSzBrUFlNSlpoYnhPVyt2TldpMDR5dmpKSU1Bbm40V0ZX?=
 =?utf-8?B?YXpkcFluaGVEdFl5VmZTVWFtWXNSVkhiWUhnVXJnR0VNekFsYkxjK2ozbHRD?=
 =?utf-8?B?K0FaSzI0dVIwSFBxenEzWUxjaWRqRVArTGpjRklmTFdCS2F4bGh2UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa668572-fc3c-4203-c6db-08df0dcf0dd4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 17:31:45.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1DVB6lKOxokeNTf2yif/sjHKcEQInj0OtynKKsGa1LSnNXYOwROJ5kn95Y1zDiahnHBujUzQpg8iqbFE5Tl7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5984
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Sep 2026 17:31:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24104

From: Jan Kiszka <jan.kiszka@siemens.com>

That should save us from future surprises of suddenly retired releases
while also providing a more recent diffoscope version.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .reproducible-check-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index de9f3fbd..f8a79527 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -51,7 +51,7 @@
 
 .repro-test:
   image:
-    name: debian:bullseye
+    name: debian:stable
   tags:
     - large
   stage: test
-- 
2.47.3

