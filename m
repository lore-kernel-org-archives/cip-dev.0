Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975FFC04A94
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 11:06:48 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.87])
 by mx.groups.io with SMTP id smtpd.web11.157937.1692184001215341761
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 04:06:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AHy0Fl/i;
 spf=pass (domain: siemens.com, ip: 40.107.104.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiB/5D9riLo+d0K7lSlQWOMbWlH7IpnWDxNg4OPH3OuW/BsE80OtkDGy70yRj3JWocnCkzT9pHu8aFRMnCDt445PYI71wdom3hpQHL9W0aG173c/n3AUDjPOY5HFXPwFNuQAvIUlNLO0Xn7zI5Pd9MsAtQGtaD+XA1I1iA18radDHVOe5x/IJ7NyYgc8hWmtecH9mSMJElacx+Ju/rXVeFiEZJMImsmGjKzUJh/baMPzW5M0dWFDHlGYjgRzhWUGyaHgH5+ALsmScmXv7V5QzZMhPzFsxonI+YwTvPesa5SjoVtwmhWymjj7FMMJmS6NDKagiqnpq0XjC4eNyujTPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbkubTdZ73RuT/j90uI1yN0Ja7TOD82u7O1BNtgNvXE=;
 b=g2J0HQ01ZZVkXbh/UbBwaMHCJ2VwYYcVbjouzO1/RTVrUlyy046uCK9/1tmXiXiZqT1ArqwNAkswEp8kyCnX6IgpQkNTSdK5ApkJAfq3R3ocVcdYxXSPx246Wovs2zmaOWbvchx2J+RVlXo9Q0GDA/NU3vuPUSFibTHdbpaxMZry9yhxMXsmlL1JS5cuv7It2uF+Td3AuafwSVm748IvOpk7am9AAZoC6X3yTOfE86Gx3r8mrHbTzwnsTkjbzDzI9X5AQOW+Pqbj9AFU/9d3dVbEr4SEfkwhtMvm2CPANbvtLWMqZaz3ZKGTSuTQjyFBbvLj9wD/Ap6bIZ8tGleYag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbkubTdZ73RuT/j90uI1yN0Ja7TOD82u7O1BNtgNvXE=;
 b=AHy0Fl/isATTM7UEPRsDxBh8CHY0m1tOSZvm+mfv5APzJ6H51m3kD/Eur3gkZaTFnlD03XB9thL5+N0IEmkxF4G009V6jUHn+9jIQn4FrgorOYMjftJo3UThD91q5KqATiBVIlQeT45TjOIsebyjKSbVolHWt1LN3hkK97iKTp8QKKP700+BsLJ1PJ/DcIQ0eo31Z/zGcrujgvCEYLYWaA/gPQbWjPt3zUbEmB195r7c8Fg7kt8iwfy0Q/JN8rOn8dKF//KsUmMx3FS5PADfiDobAHWcSmdghi8/1tB4+eEUJcprABaR7e0CGArFyHmCiP/6N+KdMa5pYqImFrEUmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB6985.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:306::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 11:06:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 11:06:38 +0000
Message-ID: <3194beff-4831-4531-aad5-a3ba30879507@siemens.com>
Date: Wed, 16 Aug 2023 13:06:36 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] Fix required version in kas header
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0223.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: c04b9630-2ca7-4ffb-b816-08db9e48dc89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	S0uuPlE/n14W6pIrLwElWTp6PAqTRTd2sCF1NI74UJbug9E2RHg/M12mb4uFwRZV6vPkUwo5h2K8hiEq6p1MAyvNNBpyc1DkTZm97x5SzfJtO+dFCIGVJrlDWT36HqXnB1HmeFi5AGZn3D8b125+gc4RNYUuFdK7bmNHI7PS63HLrf/dDdqr1ME62TDZQF7h5DVZKIKodfPj1phorQufDpu8VxcD7Oh2ca0E/VdDXFjw6KIzjkFAcqYgi1wCIo7NKD+3Y0y66NlkpgSs2W4v19Y7B3/4McVTWt7YT0PeDtCrUcuY4hNmKTE9STss/nWqOvwMKTCwQbLt8O3Fz08fZ9aB8zGZDfLSyLd4yaY4G7t6vuxz9dTzU+7yLv91bbGPcYEZj6yT6Ho76u29syNoY+norx3AbBEBGRn6O0zSNpcEgKIkMrOA4QQzBO+G73kYScmzyZQsb1P1PeS/OqcDusE/1HEpo4vwH4oqW6xV6EK+e81qObOxu8kcB+tnqwXXMM0+5ZD17zpr4kGhT4Mpx7WjDmJqW8y5iQc7DF3hGbapnnQAIuLVlFI8xFlwgTYqyZRz9mD1Fne6rRyuLAA9vRqlqOkFBQnKKQuSlBgYTqNHQMQTo1AYqsqdzVhwDaaLdVNRxK54A9GVTVlxZupagg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38100700002)(31686004)(8676002)(8936002)(82960400001)(2906002)(4744005)(83380400001)(26005)(478600001)(86362001)(6512007)(31696002)(6506007)(36756003)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MVVUcEZRQWNTYWc2Q25CMzlHTlZDN3Y1S005TmxicFlPcjBuVXRzZmhZTisw?=
 =?utf-8?B?UzJPandPQXp6SVRNQU5LM213VkJ4N01kMDJmdldqMXJ3QmJqTmFBVk91Zmw2?=
 =?utf-8?B?ZXhIU1FnZ3RoS3FmQkZ1V3N5cUJMd0ltMDFKcWJyenE3SnM2YzBER3o1SlM1?=
 =?utf-8?B?UTJBay84TFU2Q0h6Yjc2ODdRb3RIQjhZbnhmaUVJMTdmZDhUM2MxcGtLc3Mz?=
 =?utf-8?B?RElwVmhTVE1hekE0dCtLREVtZDVUbUw0NXBWdmFDNEFVbTJNa3NZcXFjWFQz?=
 =?utf-8?B?eXUyTnJ3MDBIbWloNHQyNUpvU0xRbGdYOGJNL0phNWdpL1hIQ2pVcEVFcnNz?=
 =?utf-8?B?SnNGeE5UUWxBVWdrNm51eW5iSkprY2psek5nSGRwU3BXZkhNMmFqaXpycDAr?=
 =?utf-8?B?T1ZqeEtOKzl6UktDNFNMUk82aEZPZVFiWm82dmFXYXU2MndVbnRlSmxjVmZh?=
 =?utf-8?B?NW5LWTRvWHZoZFY5RUlZbW5aUGRRR0p5c1JWS296azNHS0MzQ2JJSDNUdHVV?=
 =?utf-8?B?VWd5K1ZvQUlQN1A0eU1peUhkNmt5TktMZDEzeGI2dm9tODhLV2NPNFA3cWtE?=
 =?utf-8?B?eHNRNm12UWpKTE8ySXlxSkFFM0JPcE8ybjJWM1VYSUkzTkJqelZMVFZ0TXkv?=
 =?utf-8?B?dGNhejJaZ0NLL0ozQWxSRkJiN3FFNy93NjNVa3dJQ0s1b2NBTjl0UEZrN2oz?=
 =?utf-8?B?SmpVU3pyVDFTeDl0Q3pQT3ZkOXRkTkhsdE9RRTc2dnU0Rnd6YXRsK0p2MWd5?=
 =?utf-8?B?Vms0L1lHTzgyaVVINXp0Z0VJZWR1UHM2dFh1U1FEMzlWSEpJYVowN0hiY3pk?=
 =?utf-8?B?aFkyb2dsY1lmTUlMRXN3VFllTnVOQjhvcGc4Si9zamN0V1JGN0t4OWg2YXNx?=
 =?utf-8?B?c2tJZEppUGYzNVdicTBLaHZJNWY3TlFHTWs3SHl5ekwrbWI5ckovelcrcUpZ?=
 =?utf-8?B?L2wrNFFRNTd4anh1djNsWTN4eUZLN3lzYk9qRlJOZ0FyRW53Q0RJY3JTZDZk?=
 =?utf-8?B?R095Wmp0d2ZQc0paZkJLSHBJMG5kZzJUTEFoWGRuWVlNc3d0V25KWVkwU1BG?=
 =?utf-8?B?czE5WmlJV2oxeHhySlRRQ0tGUkRPQTNNQlgvS25XenpMSHhJWHJXeGN0TWho?=
 =?utf-8?B?d2pNY3hZcnVSYi8zT1RucS9aOU9jTks5YzhQUXlXeVFZUlprdFdKYTM1alIv?=
 =?utf-8?B?Qlc4TXdjbXNDMWNBS2dnNHVTYTBNUlNObCtRY2tpeXBFb1A5V01QM29rcnJG?=
 =?utf-8?B?cnNrYytuSEZPeTA2b0c3Z0owRytLTkE0b092cko2YWxIZFZSaHozT3gwckdr?=
 =?utf-8?B?dE5WZnR0WEdxVUptQjAzL3Z6YkNXYWdSNzlRdTRiRHhyNWFodDVnZm9LNE5q?=
 =?utf-8?B?bjJIaTFHQXhuMUJnbVJwaWpJYmxWZjJpWXc3TVZMSnQzbTZ3aENCdVpNWUJC?=
 =?utf-8?B?ajZHWWR5Sk5aa2NXSG1CSjdCbFE3bE1tMzEyUWU4cFE2V2lDb2lremxvcHZn?=
 =?utf-8?B?cmpJdG13YTlKLzkwRXhoUEtEQU9kaG80WlZBQzUrV2hlNFl6SHNia2FnSHI5?=
 =?utf-8?B?dGJSNWl6YXNkNW9vZmU2TlcySHF6cWdHNU55b0kwV1ZtVXFkd2Uvc3JEUDd5?=
 =?utf-8?B?bGhkQkEzTTIrMDJNOURQQ0t5STFldlpOY1FxeXRMMXFUVnk0LzhUV2JyTEJo?=
 =?utf-8?B?dmdmZkpjRTBldm9jVFVwazUxM1cyUFQ0bnQ3aS91eVdQL3dwVVBQRHI0WWIx?=
 =?utf-8?B?Q3VGbXluUmxHT0dKWW8rN2J2OXVXZUhuRUV6UlJNVS9mTmo5VTR2Z01DRzFR?=
 =?utf-8?B?RGJqUHN6eU9INnlwamZwaWROakFYMXozSGN5Wnh0R2kyZTN3L3YxOC9tYTdN?=
 =?utf-8?B?TVRQa1UyL0N1bmg1VTJkRlB3MlkvaWZJNkJwV1Q5b2JGcFhTeU9oRHJlRyt5?=
 =?utf-8?B?QUVrS2FoMWxYeENuRmFuR1pKNWdYakVNazBOWmlrTG05Y1dnOVRFZzZtckpW?=
 =?utf-8?B?MTcvWWw0OXdXVkwxSW90UEJsNHRvd21tMVluQ1lmcXN2QXYyalZYcVhscFh5?=
 =?utf-8?B?MXYrNXI5QW1YajYwRXhXWnZTVFpwbDQvWTF6VCtONGgzTmRwOHp6MzZlVjNi?=
 =?utf-8?B?c3FCNmVXaGJkdGVqa2xLWFRFYlB0QXlSekxUTG5hS2ljTEUvODhwbFRxVXpR?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04b9630-2ca7-4ffb-b816-08db9e48dc89
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 11:06:37.9531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJrfRX0t8xvG/l1fsaJL4Sz5d9qZRRs6rnkpUJqFsKph5svZEy69s28vex6pwBidLYsaVQoF+LROKxil0Lw3AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6985
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 11:06:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12668

From: Jan Kiszka <jan.kiszka@siemens.com>

It's 14, now that we use 'commit'.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index c213439a..59d7ac25 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -10,7 +10,7 @@
 #
 
 header:
-  version: 12
+  version: 14
 
 distro: cip-core-bullseye
 target: cip-core-image
-- 
2.35.3

