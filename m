Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D79C35FF3
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 07:10:23 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.46])
 by mx.groups.io with SMTP id smtpd.web10.8194.1741936217948732508
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Mar 2025 00:10:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dUaUn//h;
 spf=pass (domain: siemens.com, ip: 40.107.20.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHG886Ir1/j+cC1NW0rbPDdExL9ZvWyEhsocwROUCLoe5Wiae+kbAif0Txz/PkDFXrtrFqW1QYdJPmxwnbVgqojT9Ubf2mPeAkBozRpfFgAVhttoONS3pX/wrK0JxUamWFptD+8/eTRDJy8e7DiMVYdb2q6A99oTwq+H/hYNwtFOSt+9zEgQ3MXMVt7VyQIyTB5Cm0g9d4tKq3O7t61uo34WJ5fjbM93Tb1g4K+s97pj7ET281YxxTdv/oUZoa4tGjvSg4bL3CrOpM5WSiXueYxy1VyiVTeIbfQdRyIlsw+EWpq8g2HI5XdHZAEcbHS6+r/tFcwocQcvtF6mCumoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=156dcPtNxnZt7KYvwb4TW09oXsv18M6KGdcsgdlk1sY=;
 b=FPbczGcQi7xt1Gn7x1F+juqT1W0i3WKFucC6AMMkmhMppWGvhmV2r2UpWy8F2NBKVqOfXGVgoLMp/wFFdXjyiVW+W3U2sn2NCMeNUgTjvi84iWhu/AhOIaKvbiX/KU643EFp/bzLFsB4aI31yqHl8H4RFC+PYBLjyXb0l0eh20ZrliLKTNxtCkibtvSEf5Ua0m3FNN98W/VryKlixJjXH/cvSlsGShvH+kxjB5ami4NyuxilBhxBKTo9y0D4F0RoE6BjDdHZMcldEuYRrN12/qUDkCjilTPHk+AEB5p4iO4No/CmojfGG4eDyWIZCY8SnYUWGrsaU6GkSoi8BcKjWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=156dcPtNxnZt7KYvwb4TW09oXsv18M6KGdcsgdlk1sY=;
 b=dUaUn//hvzMRtL0P7ZWolRLsPycH5WhziCxoU/Hqj7DDbZDdElpdteFyOZJXQ6xD1ua3STKWPkmri0QunfCPXtwmiwiHaufrpETHReXyiw07OGoziZr26ZtILgzFT8DxLiwpg93CXw2jnKyA5sWSp1Joqnl52p+BOhaYB62kalXqP+B94v9votSvXkhESvbfJUyTM7b54YFUwf309ooO+ITUUZmbAu7ebZCLJVEWS+r7N/G8hlkVubW/H+KFL7vd99IUr0P3sXBpsuLwmgxkswNKzIponaxIEAciYZyfPhTptL35LI90bfvXhTLNyLVHNUJK0gPackrSIv92TySY7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:568::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.30; Fri, 14 Mar
 2025 07:10:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 07:10:14 +0000
Message-ID: <d2af08d7-f0e0-448c-92c4-cd41b8841ed5@siemens.com>
Date: Fri, 14 Mar 2025 08:10:13 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] trixie: Use a working snapshot for now
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4a04e2-24a5-47e2-0cc7-08dd62c74462
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RHczWS8xNiswM0VoSGNTQ2VpbytZV3hVZzU1eW9EV2FydFVsKzU2Tjc3Umdn?=
 =?utf-8?B?dGgxUUZ0SVBZeSsvY1JxTk9HYi82dkUwRkJmdnFPcitub2lsVVA3cUhUQ3lH?=
 =?utf-8?B?NU9DT09UVDYyY2hWTW5qbElrUEYrczBzdTlnSEROcWE5akFBMzREUFd0bmNp?=
 =?utf-8?B?TnFzR0ttbFRWVlNzNFg1OEE2WVZpZ0JtbU5wSVNBenlLZ1RmdWUwZmg3RVdx?=
 =?utf-8?B?VWhLTlFUT3NjQVAxZUVnbXRtZnIwZTBWalRWYWg2d3JCK0VzNWdFT3B2SXY2?=
 =?utf-8?B?amNvMW1DMmMxSTBmRE9qUVJIY3JZems1elB6UXpOZm95VVpYNUlSakxpbVkw?=
 =?utf-8?B?Nm5aYzJPSWJqZWt2ck0zdnpQNkpVR0ZZQ2VDdVU2VHZBT2J5SGtJWGxOTDBy?=
 =?utf-8?B?alVLd2N0NDdJYUtZQU8xM3VpejAxdklqTjJZamN5TTczODcrdXZZU0VuRHgw?=
 =?utf-8?B?bnhZNU41bTZ5OXk0SVNLYTFCaDN3ekt2NUlCQU1tL3ArZkJsd0VmU09EUmRN?=
 =?utf-8?B?RzY5cEpvUkdNOXVqckw4WkJmV1Noei9haUViOE1tK2hyczhCQ1JueC9TWFhE?=
 =?utf-8?B?cjJhZ1BwWkltK0t6RkF3dVNycGs4K2pRRnk0cThWMU9OaE1rMkR5TjJSTldn?=
 =?utf-8?B?M0MwRWtIZk1ONWJOZ0gydFk0cWt1LytFTUh5WG5zNTJqZ1NrZyt3WEFCMklS?=
 =?utf-8?B?SWNUdXhaYW9xdlo3a0FJYXhEYURhSWlPTFAwMUcySmZQV1NHQ3BibTM0TWd6?=
 =?utf-8?B?ZC9lRFpYQ3ZlZjVKSzdiZ3Z4dmUwNUlGb2NnOXpmMkZTaGNGZERyZjAwUXB6?=
 =?utf-8?B?cExIV1FVR05ocDdNZHl4bHc1VzBRUTZrYnYzT3RPNS85dkh3QlM2Z3FLeTli?=
 =?utf-8?B?bElkT1ZUb3RWalR3WXZNTEF4NHU1MmNEK2tHc2FFVm5DNG96bitlb2Fpam9r?=
 =?utf-8?B?R1gxdTJRWHJ6bnBQenpHSDY3UzhaSjhsTUFGY3hlZytvck5kaDRLQ0JKWisx?=
 =?utf-8?B?RlZsWFQrRzVuUkdKZEM5QnpYcGxoSkdxbzNzWlAyQ1g5bGEyczFVZ2ZOYWpX?=
 =?utf-8?B?c0g4ZTBhS3dVWU80dmVCRERkU24wUzJNL2Z3eEYvQjlrMHU0NGhoMDREOVVp?=
 =?utf-8?B?bzFVNEZZUjYzUG0yQnkyOGNJV0NiZmhwZXB1V1JuWWRqZWxPT1B6c1hidmZ1?=
 =?utf-8?B?bkF4MXFZMEhaazRoTDRJcHdxRStuUnBaeWtPdG9tSmh6NFYzamI4RHFBaCtU?=
 =?utf-8?B?MTN3STkvMnZkZEoxcFBYZ1pKN05kdTJkZHdpZ3VxazZOL3RFcUpSWWsxL2RG?=
 =?utf-8?B?T0JNTEg3eUh3bU1HRmFiTFVZT2x4OUN2dENtL3N5Mzc1TnlUWXhzQkcwakFh?=
 =?utf-8?B?SXlTcURnSlEvYTF5N0JQc2FqNkFCd0s1eU10WDQ4dUs4ZFRsU1V6QlNGR2hW?=
 =?utf-8?B?N2RCazJOajVlRllyaWYrOVVwUEFncXEyZXBnMVVpK3dscmNTK2NXSDVGYklo?=
 =?utf-8?B?aUFZc3JSc0NVWUMzems2a0YrdXJwT2RMSHdGQ3o1TytFVW5DUDJnVHBBVVcx?=
 =?utf-8?B?TmdqS25VUXVSY0lwSjJ6UWV2L2hHK2ZPUlBDcFZIcGpsVXFxM2FvVklnM0N4?=
 =?utf-8?B?WjFXY3pvYlFzSXVTTXhNVWRxK0VlYXZiWXArSVFqTVQvRzdTWGFYM3JNU0hL?=
 =?utf-8?B?Unp3U3JSMDNqRTFKOGhGbEJuVUJUV2FZQUlEVC9yS1FLVjRSVU9KZXJlUC9F?=
 =?utf-8?B?UHJVWWdCZFgwQ0R1cGUxWkhmY3Y3REtxaFhIVFFWRkVWWSt1OWRCQmlFeTQ2?=
 =?utf-8?B?OS9NajZvQVhuM1JZOGlHMk5WaDJIVXEwVi81RTJZN2ZSejJnSm5DZ1BLdUgv?=
 =?utf-8?Q?QmTbNJ5s4f3IP?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aVhIM0hmMTZxNXQydnU4UVRpNkVyTW9hOXR1b1hDS3JsbnJLZStBeHZpRWFO?=
 =?utf-8?B?cnV4U0hBajFRMGlza21zMFVKZS9tZHRzSmNDMG9tMmQrdk9VVWszMm5XQk9E?=
 =?utf-8?B?Zk82eVVoV2dHcHNLdUhhL2ZWc0VVQkI3dEg2MzlqU0lGbngyY0o0dWxSYi9p?=
 =?utf-8?B?M3dzMmQ1d0pKMVhtMi9OcTI3NHFUOGtrR2JGQWd0RWE2SVR3ZUlnVUZLUXNy?=
 =?utf-8?B?MEhLbEdMei9CdUxRWkRsaFVCOU1zWTJVWExJOUozcGJSQzFOR215Vm9nb1JB?=
 =?utf-8?B?cGRHUEViVlhQWnpWemR4WmZCNkNBNWx2V1NyQmRSRUVwVFZJckJtZE13WUM3?=
 =?utf-8?B?S1ZmSkJOQmtlWGVPRFlTaFlINUFyOW92Y3FkdllPWDhvVER1UG45WU9EVHZr?=
 =?utf-8?B?ZkdjU1l2bkRERTJvZ3ltU2Zzb3RpYVFpSENnUGgxM3pTSmtVdGVqc3hvMU43?=
 =?utf-8?B?MTgvTmpFdU00NjZSTVhqM0ZxUS9Fc1E1cXJrTDBsa2FaMHJpd1RnVW1rdExL?=
 =?utf-8?B?YlFKdmd6VFVONGUxd2lwN24ybm1Vc2s2aUZBb1RFNk1FS1lUaEN0Q1V3T0to?=
 =?utf-8?B?cElLMFY5cy9wdEZuOTdyZzlDZWFQemkvNlhiZVpvNnNubWhLOWY1eFlRWnEr?=
 =?utf-8?B?bTVhRk9jV0tHcGZXVXNTanVFZHFCc2owWk1SakFiN1hsSFJLekFVYlhiS1Nj?=
 =?utf-8?B?WlgwMzRjeERDcWtjeVpPTkJoVTNZMmFDdis2dEF4SndjM3JkUFI5TkliQ0dD?=
 =?utf-8?B?OEl6U0lveDFHa3pIeGtYb2s5YjZDUlpnbExRUzBrYVk2QXhKTlp4eGczVW5Z?=
 =?utf-8?B?My9pdVZaK2xXdmpCeU1OMXpQMnZvY1psMnZvSmpqT25DVzFXcThWRGF6VWV4?=
 =?utf-8?B?czlEY3hhMGg0NlFtaWF4Q2RxcDB1NTIzelF5WUp5SE50VUpWdXJSVVluWXlH?=
 =?utf-8?B?L0ZXMklmNDNvSXpMdno4bHpBbmFnb0ZDWWV4dnB3c2pVSXAvRmtCbmcrOGxa?=
 =?utf-8?B?UlVDTDBXcDcwTUVEbDhPS29MUzNJV1JMNEI0TDJwOEhMbmM5dGtwUGZwdHZw?=
 =?utf-8?B?U2NINWFNdlJJRUp0bjNMa2lFRHlJU0crOHJINjcwTFVhU0QrTXQ2Mm56Umht?=
 =?utf-8?B?cmdpdHp2eHg0VFBDMmtpUzFNWWJUV1M1bFZ1cHNOTkhUdGI4U1VydHV6WmpD?=
 =?utf-8?B?cTlEazg0NXg4UUIwdWhmZlMzOEtmd1dUVzc3K1UwN2JIMFhpRE5CdTFyQmx4?=
 =?utf-8?B?WjZNbkxtOENTZHRzK05yYjByR0k3UU1SNE5LSTJ6QjNmZk44eTZ2VVpqdSty?=
 =?utf-8?B?NDVNSVVCSTBBM1hCcmlVejY4QlJCckJVaEY0ZUl4MDZ5Y1Rkc3JiRnhKM0lM?=
 =?utf-8?B?dUkxZGRxZ0wrTmxVNjRwSkNOMFNkZGNROE8zQlpNRG4zcGJ1Z0VERXE2ZnVt?=
 =?utf-8?B?Mmx1akxLYVhwd2c1czVsQ2x6bXdsbXo4Q0hWNTV6NURVbWVnQUNLM1lOMCs0?=
 =?utf-8?B?VGNJR21UQ3pIRWdlZ3lDT3lkQjFZNkhvZmdQMVJ6NkdSR1BUL1RNajc1Y0kw?=
 =?utf-8?B?WHBHZ2praFZLMHFId0dRMUdBTnErSGdyOXpaSUxuT0NLR1hVTWVJZG5GZ2Vv?=
 =?utf-8?B?QWh4UGgzQlphdGNQanZ1S3FkVTd6b2doV0JIdXBUemMxNUt0OWVTUTJ0dVIx?=
 =?utf-8?B?L1RGdGhOc0wrcU5oWTZUbTF2ZlBzYVd2UTRTSmkwaGRJTEtVOEFUUXhwcnFw?=
 =?utf-8?B?SVhscmxlRFNKaVpBVTJBUUg2WWxrczBkcTNkaTVhNElBaVhSekpsQXZZVWNy?=
 =?utf-8?B?anA5eFlKSlhqazhWTTdNdHVoN1hKNHRLTzJNakticW83Q3YrcWcwVlhqeXZs?=
 =?utf-8?B?QjNTYTdrZEI2dGl3SmdHRGtZTDNPdFRrZnRJUDk1U1Z4cjJZL0hjeVBxMVZX?=
 =?utf-8?B?VXRxSnZpL3IzSDRMRUp2eUVqSUpkMmRLQy9vSHFTZjBKR2gxSmNteXBNbUMw?=
 =?utf-8?B?ZGt1dnZyd1I4RkFxRVZUaWowOVZ4cVgveHYwbEFhRDc5UjhHa3N0Y0h0KzNh?=
 =?utf-8?B?aDNtS253bTNZM3p3STVBRUdTNHU3a0o0ZkRhUVFXa0M4UEFyT0FlRmdmUzlS?=
 =?utf-8?B?Y3ZRZHR1a1JGaWpJYmlhVUlIYnJLNTdiTytHUU1nRU9UN1JaN3BzVmttUDFV?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4a04e2-24a5-47e2-0cc7-08dd62c74462
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 07:10:14.2883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGZ4nIR+705BeW3uuWlOLDWZRyUNW2/1czVLh21cNaGO1vAAMN0fWi30xz9iWsh3mNImBnjPgNH/517Wm/tI8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9096
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Mar 2025 07:10:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18204

From: Jan Kiszka <jan.kiszka@siemens.com>

Cross build became broken due to imbalanced update of gcc-14. Freeze the
package set over a known-to-work snapshot date for now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/cip-core-trixie.conf | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-trixie.conf
index 58999d1b..723a3d70 100644
--- a/conf/distro/cip-core-trixie.conf
+++ b/conf/distro/cip-core-trixie.conf
@@ -14,3 +14,7 @@ require cip-core-common.inc
 
 PREFERRED_VERSION_linux-cip ?= "6.1.%"
 PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
+
+# cross build currently broken, use working snapshot
+ISAR_USE_APT_SNAPSHOT = "1"
+ISAR_APT_SNAPSHOT_DATE = "20250309T000000Z"
-- 
2.43.0

