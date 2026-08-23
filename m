Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D071DC5DF81
	for <webhook@archiver.kernel.org>; Sun, 23 Aug 2026 14:42:19 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.15])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15569.1787496138932023910
 for <cip-dev@lists.cip-project.org>;
 Sun, 23 Aug 2026 07:42:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lFhiBRUU;
 spf=pass (domain: siemens.com, ip: 52.101.72.15, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJleE1SnH9jQ6AMuY8uLmKuhj2MozO5xeCE0+swqZyx76FMswicYNqul1CI4+yGUWz35+FuVjz2OPdg//KCjnKz9xeZY4Mmbk4nqhqR6/oSCMH9YQAipDmoz3SRtaHPyc2/y0iAU8WyYlhWWX1huy+1zzGkWxVy3B1OjQ/+3A/287rLrq2AFTMTlHuIR5TAF5eCyd1JAMBxRpTZK3TIKzvB4wNQiRMp6V/fKLWNefoQFvxmdDW2t+EUjon2Xna1slKE8iN6nWfLldiP89ZetHNv9SllpkjvuIaJre0EQ46rZPYrnWedwXSYJ08Meq86uqEXCnHE1rPrduNlZ8rr6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ezy19J3EByxhKAevqdCnsA6LKBckK5a76EzG9mAU+IU=;
 b=B1pirATgZBZ6gXzYzKiQoG3wn/2tbBJxP78TpRj3qXGRRuX/DBwSgowSZtWnaSRwKtLoKdUZZhAx9WIGzY+lrRVzQv1fNKnk/XUVz35jPJOJOcyYf2kwUbDrYwwpUSobg1FwlcIr2t+ZJ293PAcUUJrzVHWUiLr9LjF2dWTJbkT05yX/v/q1UhJKG0LnwDgYSHH7H3zotN0PpBefhEcHBm8KrOPct0cZAuYEIUBnq5QtiSFtxVsrmoa+GCd9t1twIrB/N4dSlTiTdJkX7mti8HuT7OCFuMrioIy+MGprWHgKxqnhpmLgEECAXACXEAW4uZktrNoMp/WyySR+53IEIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ezy19J3EByxhKAevqdCnsA6LKBckK5a76EzG9mAU+IU=;
 b=lFhiBRUUlMnJguhCvdeJtoAjVq3HGI29l47D087ouD6/U2Z5WPJn53KU2Ws7QVtN6tCVHMGfbBgUmhEi+9BVOsZF0F2hy87ZYwJ8wz2gNL+EDlHqx3UfvyFZRWMptX2KDi3zVh4A9lU8f2uV3D+gOvSip+AdLpQNe8gYT7dvG+BIjdBCekCtHgFf71aLhD+ysQtt+kBlYdhH8yOhxnBOPIIvbAjlEChCeLKcrTQUi6ABFd4Co2AS/RFIFjVhf/65yKHumNRWUSEonSG4ZnKc5sOpNZZR7QNUPFkaB1uo38eEhCHvqacwPj+o4uvTsWtV5OmR8N+dDGX4/Kr9O32+FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by MI9PR10MB992257.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:ce::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 14:42:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 14:42:13 +0000
Message-ID: <0f91dadd-efed-471d-8bd7-00c5e16975ef@siemens.com>
Date: Sun, 23 Aug 2026 16:42:12 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] initramfs-crypt-hook: Fix TPM shutdown to
 prevent invalid PCR states
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|MI9PR10MB992257:EE_
X-MS-Office365-Filtering-Correlation-Id: 9325037f-ffea-4736-55c6-08df0124b876
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|55112099003|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	bS/+WNDhR5dn59E7vJMNQkvVZH5ewOMgZsIEiklYvLMxfaisgPS3tNpxrWm6hNuWUdqrwWw4vIkENiBR2FVcMRPAuEKvqbqavfntpFZ6Ne0g8TdP7dmsdndnHKOAEQvIoo5OY1fwBD7RuqbSypIW5xN4ri8T/q2/5wydHKts5hILmVyo36tBgQlVzhYGi1XEyNL1s2m5PoaPLiJWsuvKqUVRIZe2HO6zAJ62JUttWaABxwBL5S9VVdibqKN6+LU/3dOdOvFcmcxvbs9pFygWMX529vF8nIsibv/ojvW2/sNbmPGN2qK4K+Es1HulRjfd4qgxohtoHssiTZprrPuDtqeVEQ0j7yFTeMF6szRMII/CvUQXObHHyiHsfoqTSQ7GW3qa+huieiCxa15v4HH1KrLo4854h5GdfLvZF6Bme83R2rCDW1ojcZvjGmiOuajEsR4BREdrf9yoR3J5IjKmY+p5VLXKvzElc1diWcPFxvTEcz0KYAv95+q9hTo5lupj45RX1I5FCwpXpbQAxWYyLhCMU03SChKi6bmC6QXTFG00bNTxo7tmObXlZK+MQHVwMjl2o0rckcbS44ZUINoOqiUbA5nC3EbtLW0QRG8reMg3OPVqrhqx3GMmGiqllBl14jscyUPwOu+cP3RKrMwaO+jJWZpVq5lHID72N/p7JdU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(55112099003)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MUlGcWE3UnVKaStuMmFOQkNvS2FZbnFjcVQ2Y2V2L2xSMjRndnpqdS95Tkg0?=
 =?utf-8?B?aFpPb3A2YmNkenN3RmxCNi9WT0hhaEZLaG9JTzNMeWpSU0VIY2NDMjdaVWg0?=
 =?utf-8?B?ejd2aVpGTDJaV2l5N0N6UFpoMHhoWHJkTm10SDVPbE9wRkJlLzFDRlYrSSsz?=
 =?utf-8?B?TndRbkNSK1N6T05VUm9rSjgwbVVpYjlwdEdJSW9hWU90NGlFVVJHamlXc2lm?=
 =?utf-8?B?Tzg5eXRaYkxvU0ZzbGRnUlp6djNBbmRWTjdKZHJFOGJjdFlrdTRaMHdpZGZw?=
 =?utf-8?B?N1IrWW5BRmNyejhINHlzbVNkZHRaczN6STlNeHA3a2pRWEgzbTRURlpnR1RS?=
 =?utf-8?B?bnNaOVFVUllRK1FId1kxbzBZVUhWWTF3QlFUSG4vTURuUVFoUUpuOEwxVjV3?=
 =?utf-8?B?SkEvN1RtZ1QzWUovTnVzV1hpTXkyVlI1b0NDZ3FubHpiSDkzR2pESy8wQjNP?=
 =?utf-8?B?MHhBekxicWhoVXh5MVZoWDFUeTVLeE1mMUU4Mko1cUg1aDl2TS9pRzBYU21j?=
 =?utf-8?B?bnprMk5vbkRseC9XNzRHUXFYa3cwcFlQQWlUelpEVzVZaUpmdWMyeGZabUlP?=
 =?utf-8?B?V2trZ2Y1MlVjcnhBU052eTRTaDBJYjlZeGlWRTdobU1JMEZ1R0lESFZxRlVt?=
 =?utf-8?B?Q0JkaTZSMDA0aHFhdEhIM3YrTjV3VnJTenhxUHRiOTQ2YkJnYTBKdzdsdE9P?=
 =?utf-8?B?Qk8yRXFLUkdwY3Yrd2E5ZEg5c1JTVXN6S3M4RFNaR2U5WmZlTzF4V1pWam5G?=
 =?utf-8?B?OU92U2xPWHZjVnhJMlprVG1TTEIrZy85VUFYY0RHbGZabUtpOEhad0RSUnYx?=
 =?utf-8?B?Rm01cHVEWU5RVStOY0EzL3c5RHJaZ2htV09RRjNCMGM5ejl6VkI4Tm9wSTFr?=
 =?utf-8?B?cVpzUjR0NjJNTGVVVXVRb1hOSEo4ajFKNW5IRk1TbTJ3QUcxTlVFNWhsUTRF?=
 =?utf-8?B?YnRncDRsVHpsaENFRFlKMGxiQnJLZ1hDS05pd1U1MTA2bnZYUEZ6U08vUDFk?=
 =?utf-8?B?NGJzNENGaUtLeTFlZlpoSmpJaVUxK0J4NW02Y0NzTjY1S05TWDJVQXZjOVcw?=
 =?utf-8?B?VEFwWGlWQVpTMFMrbjBib1BsWFA3S2pDclN2TCtXQmx2Nk0vM2NFMEMyeXA5?=
 =?utf-8?B?UHR2NFN4SmlBc2lOQzRXcllPYnRvN1RxczZNMTlHZ2dVWk9GQXBOdGgyWmFv?=
 =?utf-8?B?L0JBQmE1bzdoV0lvYlBIeGJYUGlxZmJDR0pFeTFuTzRJZXJnMHhTS3FyY2FF?=
 =?utf-8?B?RG9YLzg4elNyd1JuOTRkUEQ1dmx3M3RaTWk1bFhpN3J3ZFR3VTUwOVhZSmhm?=
 =?utf-8?B?QzdvMVVEczJqY2duTkxocUVJcHRodkxSaDRDOGRveHlEMGthdzdzOU5aTi9m?=
 =?utf-8?B?a0pnSVRxMy9pNVRtTUk2eWVPenpJUXNNL0YxUFY3TG1uTGRsTmllK1luNy9W?=
 =?utf-8?B?OG5BTExGM3dwTHRla1JVNGUzZStJQUovdVpGdVZETHRkRUFIUmdXcUhwdHBs?=
 =?utf-8?B?RWhNR1FicitUMFhRUXdjS1dLNHRHSlQzNW5WT3Z4ZmlQeWp1RzgzRTVkb0w4?=
 =?utf-8?B?L21zNTRLdTR3Q0MzUU9wNDlLNFVKVXB3QTMwdjcxVjZCN0NON2JvTWU1S3Yw?=
 =?utf-8?B?N0JwbXYrRWxuOGVvNXBDcVZzM1JSNm1IR0FUTGNHQ1FuVUtpUVE5Y3F6NFVM?=
 =?utf-8?B?M0FLaFNkY0drdGdGTkMrbWhobkw0RXFsNVdKQXRGS2FteExzazFWYTg0cjkx?=
 =?utf-8?B?cGU2c1VQUTRtdVI4L0gwUjR0RlFpV2k5eHlZMG5Dcys2MEcvV2FJS0xDTlMw?=
 =?utf-8?B?SHByS0V3d01pWUNKVFNOU2syRE9UZmpPWllhUHZZS3prV0dYTnk4NEFVQTJP?=
 =?utf-8?B?OXMwd2dJRk1oeDRwUVFsbThXbFVsTUZrWEFrT1dHNjBST1dTSXdFQzgyNVZv?=
 =?utf-8?B?Q0NwbnA3aHBMVDk4eHRsdm5Qc0tlWE5acXdTODhjeUpSc0lBY3hKbXArb0Fu?=
 =?utf-8?B?TjRBOTNYRUREME9ybjFHVXB1VnY2REM0S3lkSzdTZCtQdWdvMFNpWUVaTFJl?=
 =?utf-8?B?aUlRLzRQMTJHRk92SVFabDRlOFNzUjIzcUJzOHViTFZHNHdGTHZ5TDhnK3VO?=
 =?utf-8?B?WGhRVVg3MG1ic0UzMWhKN2trTkViZTRmSXpBK3pNRTFiblMza3haWHBvR0R1?=
 =?utf-8?B?cG9hOUdHT3RQL2NaNkx0WTFJR3ZHT1VpOTdyT0xrR1ppUlZtY1k2YkVlaWQ1?=
 =?utf-8?B?bnFtK2I5TnpyQVRtTjdha0w1VTVFc0k1OE5ZYjZOSTJDM0MzaUZmZzU4SEJE?=
 =?utf-8?B?WUlmWjFlMjFHQWdRNlFYT0RwYTI0T1BrbXNLUjhiVElHYllNY3NGdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9325037f-ffea-4736-55c6-08df0124b876
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 14:42:13.7157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3qbv/XFcDIceftRxFsJVJbHcnDZPqlc62bJ8orZrQaslECMznLf3PWopv7VJDO51CMIZuZlkG3HeOmD9Ly8jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR10MB992257
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 23 Aug 2026 14:42:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23978

From: Jan Kiszka <jan.kiszka@siemens.com>

A plain tpm2_shutdown means TPM_SU_STATE, and that means "save volatile
TPM state for later restoration". And that is actually done then by the
TPM also after cold boot (power-cut, hard reset), leading the non-zero
PCRs that are then extended by the firmware as usual but, due to the
non-zero base values, to inconsistent new values. This is breaking the
unsealing of the disk encryption key and other secrets stored in the
TPM.

Fix it by clearing the state on shutdown instead.

Fixes: e96ea24b4269 ("fix: Shutdown the TPM after disk are decrypted")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Seen with virtual fTPM (plus extra patches as the current firmware does 
not support measuring yet), but it may effect dTPMs and real deployments 
as well. The issue is normally "healed" by the panic-reboot that the 
initramfs will trigger if unlocking fails.

 recipes-initramfs/initramfs-crypt-hook/files/local-top-complete | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 963f82fb..7bc08e55 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -367,7 +367,7 @@ done
 
 if [ -x /usr/bin/tpm2_shutdown ]; then
 	# shutdown the TPM to avoid DA lockout due to powerfailure
-	tpm2_shutdown
+	tpm2_shutdown -c
 fi
 
 if [ -n "$watchdog_pid" ]; then
-- 
2.47.3

