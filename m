Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E4CC83F21
	for <webhook@archiver.kernel.org>; Fri, 11 Jul 2025 04:46:35 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.6])
 by mx.groups.io with SMTP id smtpd.web10.6551.1752209184852610052
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Jul 2025 21:46:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=X9yxzb99;
 spf=pass (domain: siemens.com, ip: 52.101.70.6, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euwiFQ+pMOW6fbztscjV3bPNpopMWBNiM7FabAY8+759rVcOCl/EGulFYrjSIt8xfhIYeXefb7TJSgRRdEBmUqSKNt2NX6Xk1FW9ITYyRkD/F7Oz7YpdT10dXTFjHkO5+BEHF0sav9uFV4FlGGE89DaGHa1mQPjUh5iD3DJHsYkZc/SsZlKFiL0Da6ZLGfd6a6sf5JG78GYlrxtzP2KFYWVCS4y8HLIr3ElN59kkGav8lKxXh4JQonHtOnm+b0WvtA8NYI2xKN2jFpE3pRWwaXcKlwZdHNC8x41UgQaLMT+hmzaQ2cFGHjmGZzCaD/iiko6jMhZ7Kt2k9qvEGd+9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFH5qy5JK5YvpLAPxhVHMgMbZgKqpB+14DAIjOWshP4=;
 b=rWpUKscmvKc+PZFYT9c25M2REz5VHARwqEhinl9q1Bu3eFIaW7T4fRYw4wiDJ2sbUuoK2YdlhZqUPmL8irqVFZGXi3tH1dz1BPCej61j219e/0DDwF/wW40NSNqlCUJ8oUFejsbqc0WmejwHRYLy1hQMLyXvhwQXiuJoZlW0uk/vh7iK/bfmPWp2Q/Xsngw+FV6FoyXbfWZGEY9K+OHyJsmAByiyFs0Qjlo0KZrvax1riOhD9RIan90FIKvxxbt96sU8+6bUxNazEr+CYl20hYXJOg733wXNTHSO5yiyR3foZ/PGXVWXnxHNhDzegwv9W9jhaNlNFVavB0w7wOIA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFH5qy5JK5YvpLAPxhVHMgMbZgKqpB+14DAIjOWshP4=;
 b=X9yxzb99wDNDpBoj9lKBAKimwGdADw+GhS9YjrbMjWMbvoQCmnZLL97UNXVPFuYBxryHd2uIGzwMkLEWGPbiWk1McJRIpUGVlOzMi38NDRkCQDefQORojid1RXClhnPVSbvZQSXuKooZirmvm/r3mwpkN2N82kxe7KvTc+U98o0wGGWPmX89x5OAaTqqNcRFTQbnuW1FaD+FBh2MyGNze72E6Ivl3tyO9T6lZ4cvDBG3utEqRXZKNrhDb43QDTog0WXVSGrACr9MEiJapfAix4ftO5jVBpTl1oNrCoCPq+W0xhKVuJQSzFCTvOa7pG+G41TiYXuv1CpumKbG3PXAUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7912.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Fri, 11 Jul
 2025 04:46:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 04:46:20 +0000
Message-ID: <262e19a0-84bd-488d-aef0-53ae58c16bc0@siemens.com>
Date: Fri, 11 Jul 2025 06:46:19 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update cip-kernel-config revision
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0432.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c3167b-fa26-482e-8f6d-08ddc035e17a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q0w4V1RWc3RnN25iTzZESm5JMmR5d1RDZjRTOVpaMUhBN3ZUakRCdm9uSDNW?=
 =?utf-8?B?R3NyM0JyNzlRODd6OXRzMDYzVUdaZDlrYW83M3I5WHpXSjlVWXFsdEFMN0Ur?=
 =?utf-8?B?K1QzbUo0ZC9vREJsb1Q3WEMydlBhbE92UUxUMS94bFYrbVFNUmZXTFNHM0Fz?=
 =?utf-8?B?akUzNWRnTnFiejRiMXdlNVJZeThEWDl0Skl1Q1pFQUYxWWtYNkJGVTVEdkZK?=
 =?utf-8?B?QmNreTFWRUNQMGhvcnE1YlNUNXlOaE9uSEprNDJVTkxGRGpBUHZ2OC82OVBR?=
 =?utf-8?B?bmZ0VlR0WTVhS2xZVWFTWEMyOFNTQjJmS0kvdXRzYktDVXdNQXpwcHBIVzhz?=
 =?utf-8?B?dlJJaXVyVVVmTDNIUlZwK1ZjRUxDSlEwK1l2dkhaeU9ZQk82YzE0TUtNSWRj?=
 =?utf-8?B?MUlOc2ZtRGlyd3kxUW1WdHdidCswMWFkc1YzcGxvc2U2d0Jjd3V3djVSQ2ov?=
 =?utf-8?B?ano4TU1aRFNpL2tKWG05RS9NUkl0KzgrYnlDOTVuWWR4andwQjVBVzFxYkdK?=
 =?utf-8?B?bWZDUEtFRXF4aFlGaUxRckR4cTZ3c0ZKYUprT1dNYVA0V2dJR3o5OUp6d3hN?=
 =?utf-8?B?NGQ2aEViUDlpMm0rRVdXcTk3OGNmSHVHV2xyMjZrV1pvWURQZU9TVVNmdUZ6?=
 =?utf-8?B?Y1cyV1RqRVYwSm11QjlOVmxwYXZtZmdyZ3RwY0p0c0QrajVnbndQOUN4NndS?=
 =?utf-8?B?Vngvemg5OHVWN2Q2RGNJY1FUT2tKY3VIaTNVbHFPbG1OZVk2RW9XYkFhYlk1?=
 =?utf-8?B?bXVGWjh4U01FbkFGTkRGUkVhc240eDViYjlxNm9UcUU1UTZab255ZW5VRDd0?=
 =?utf-8?B?NjdENitOUWQ5ckhPdTRTUGxKNDlwUnY0bU5wZVdhMWdwZytQT1k4M2dHUzVG?=
 =?utf-8?B?ZU1VUXN0bmpaNmthM1ZGK1pvMmFHQlc1bnM0cmlFSS9Oemh5S1FZOTFPRFd0?=
 =?utf-8?B?WmQ4VkkwdHZwUjRWTlNPdGxnSXNRMHFQTXlxdGFJYlJkRFF0cUc3TW0rNkpp?=
 =?utf-8?B?RDZiWFpMdUVxT0hyTHQxQkw4K21mbFlMM1ZtNS9sZGZwQ2ZieXh0am0zc0tP?=
 =?utf-8?B?MjJZMVhxK04yZmVrbWtQYjZ1SkRhTnpDajlqVlN1K2luMjZ6YjBOdy8xbXBV?=
 =?utf-8?B?ajkzZ2xGVXJwMWlGcXpCSEdhOExhR1phRjVUdVNIK0l2c3IzbUswcGdnckIw?=
 =?utf-8?B?ZFJteWk2dDZPNy9qNG04Tm9LY2hsSFphcGkxNUl1WlJFSXI3ZDdZV3NUYTJP?=
 =?utf-8?B?ckhvV213aFhkRmVUTlVPQUh3ai9MMjBXNHVvNGFlbHVkZnBkMmhWTXBRQUhI?=
 =?utf-8?B?MnJoazg5ZXR2bGpwTWZHSVZrd1hJTFdOei80MFMyUVZrUzRyblM2dTJHUVN2?=
 =?utf-8?B?S0tvTlBtdVY0SWZ4UDRyQkU1QzRlK2VkQmVSdTQ1eExQWHNzUmRvcGNQYXBw?=
 =?utf-8?B?ckNLRzEwdXpWTGxTK1gvL0F5UHIxM2VXTXRHWHNTSnM1RXdCaW45U1Q4Uzlo?=
 =?utf-8?B?azRFN0RERmVXVVJGU0g4dU02N0EyaDdjdm5uTGVTb0xBWUs2OHFnQSt0eVFX?=
 =?utf-8?B?VGtNaFBqUnFHSERHM0NtaDJITEl6Tk00SmZOYXNOeTE1Q213UWxDRDBzQnN0?=
 =?utf-8?B?RDBQaGwzZVc5bjl1U2M2WlVGN09zWFlWK1ZrMmdEa0VFWjRHZ1JkTjFLQUZZ?=
 =?utf-8?B?RFgva1loMXNlcVQ3UjBGOVRVdUdVQ0crQVlWdFA2ell3cVFITW04ZVpSajk0?=
 =?utf-8?B?dEhNVHI1b1hDNHBJcmJ4N29CVVpUbUppRytRemZ4MkRxVWNXNzUvNW5WT3JC?=
 =?utf-8?B?OHIzTE5pRTAwZ0pyZ0F6RUdvL2FyWWwrL1craGEyS2RpYnRzRHFlSTY2VElx?=
 =?utf-8?B?SmhtVDV3aTJGZVIycXNBODRXNHhuZU0zYUxWcUlOY2lWQm5DUFN1RXYvM2p5?=
 =?utf-8?Q?/UIk/FyC/2U=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MVhqRUtmSDFRRHFsMEN3aHduS0dTUFR3Q29sMnRhSU14dDVpeW5IemtJemlu?=
 =?utf-8?B?YXlHTng0R1lPMGxrZWJyZ1AxWEhseGlVMW9Ua2duN2pWWkNSc2xaeWJlWTNR?=
 =?utf-8?B?SVJHQ25DUUZKNk11M1lXY1gya1BNaHJCMStCLzlhY1ZGZWhvSUdWYWdlNWp2?=
 =?utf-8?B?djNrYmlvbEk3dDc2Q1dUYjdaTHNnWXp3ZmlhWmt0eDF0c1RCc1hTNExGdjgw?=
 =?utf-8?B?OVlYM1FScmV6MllYNkk1UGUvNzJETmhhd3FKSFUxVjhSdmhwVnFNemh5Ynpu?=
 =?utf-8?B?ejBqOEM3QUlOVnc3MW55ZW5rZWlKek9EL0ZLR2hTbzkvaFZLb3VNd3FyaHp2?=
 =?utf-8?B?T1crMC9Qd3ZwbVl4SmtlQmE3ZnJwSEdHdEFoeGNwTXRpYysrd0xHK05VVTZa?=
 =?utf-8?B?ajI4cHMyZVhLdEUvUzJpR2Y5Tk40NG45QzNqVzF1WmlZUGwzM2U3ZVBNeEFk?=
 =?utf-8?B?Z25BOHQ4MklWMlZlaDRDN2VCNEhsWGhrcUxXNFRUNTdWUmpGY2hjVkdmZ2hk?=
 =?utf-8?B?OXcxTERuWEduN1JtS1lzVGc5R3BrL09NNmtYNVJwU1FBNnhHZDFqcERpMm5Q?=
 =?utf-8?B?aEhtVkpiT0I4cVlFSlB2VGM3dmQxbmQ5K0syRktrVU5lTmJucCsvQVZZZ29p?=
 =?utf-8?B?ZTFhaS81UG5EcVRDcDdEM05WSXF4TFo4clIxcStXbGFuTGNyVEFJZzdzcjBU?=
 =?utf-8?B?SXRORGMzZ3dVT1FYWm94dFRGQjlVTk5Gb2ZqTk9kQ0xZWjFtRDd6eGNvWkha?=
 =?utf-8?B?c2tsd1dFd0dzNmdqZjFrY3Y3ZUNHd0hJakFwTk10UitYRm0yOHhRVmtMUzRC?=
 =?utf-8?B?ZTNHNHRCOHpFZkhTMzd6TkdmZGJGSjBBNDhTcGpaTVBpVmUwa2ZYMHNNci9V?=
 =?utf-8?B?QStPQ3ZOZ210dFBNMmRzWVpuSDh5VzRGb1cxYSsyZmtLUG1zdkNaQTg1Mkdp?=
 =?utf-8?B?bVpmYTl0WE94bG80cndrZTdaNHlyWXIrTU1PUDdTdXV3Z2xwOVpRdzlHTEpF?=
 =?utf-8?B?YlY2UmxXVjJnNjhnMTkrcHBOQTdES0I2SDB3WlZyQkcrcDA1cFB2N2pSMHAz?=
 =?utf-8?B?eE1qd3p5b0ZaSDc2RHZwR09DU1l6eGtPNW1JODMwQVB5aU51OWlZbzNuY2F4?=
 =?utf-8?B?eFFMMnFYLzBZTVhJb0E5Ti9DSnVkTmhhR0lvbytSclVoMHZUR3hyb1J1Q3ZG?=
 =?utf-8?B?endwZDg2b3ZJU1ZFMHVwQzlleFY5VVFVS2kxYVc2VmxEdTFDN0JTN1hXRkE0?=
 =?utf-8?B?YzBnM0VFQzNZOU9MWnNZbDMyTVBsWTV4cUlwdExWc3lrd0VqMzNKM3M0Tm5L?=
 =?utf-8?B?ZS81R2dtd2tlYmFqVU5GMjQ0YUlNUnRIb1R2YXg2Q1QyK3g2VnpRek10TmFH?=
 =?utf-8?B?dU92cjdmeWxObFNDS05YU0JhcjFZSjJ3R25JNzF5YnJodDZaSWU1WHRSZ3VN?=
 =?utf-8?B?SWM2UlYwbU1PdEFDZWVZb2NLbWlmVXlwZi9OUHduaTQxRkRvM2RkbDRzUUxP?=
 =?utf-8?B?ek9iQlFPTWtGekd2Ny9pYjc3QjBlS2FwV09kZ3dwWFRaUk1CVTFqZ215ZXVQ?=
 =?utf-8?B?U2VZY1RxaWhtMVZiOVpqOUZmRGg3Wkd3ZE10ek9ob2UvSzNYSHFTVWJTQ2ZR?=
 =?utf-8?B?YlI5TzZYd0c0UllKREYxajFGVDdkNkY2NmlueUJHSG1ReE54MU81b1h0enpw?=
 =?utf-8?B?d1hLTWJJc0dYeWdXQkhjREYyUXJ6TUJHd3ByM1ZrT0RtUGtLdC9lMXVPdUFW?=
 =?utf-8?B?ZFZSVHViaG82bXB0SlkzY2NyTEg2VDRIR3lhMGxLMG43ZHBKandPUTNTQW9L?=
 =?utf-8?B?TTN1cnkzU0lZbk5ITUpSbWJMVU54d2hCd0N5RVBlUlFPcnBNbjdxT3NEejF3?=
 =?utf-8?B?TmV3UnBkOVc0enI2a3hvUit3S0srRWsvUlBUb1pMYnZnUEV3b2daWGx0cWh3?=
 =?utf-8?B?cHJma1JUYllhUitRUjRXQU42M2J4aUhmTEtiZlZzSkpMZmpjZjFoN2lnM1lr?=
 =?utf-8?B?V3crNWhYRk1qRHJYZE1FNjVSSTR2TDY3TGdtOWpoMXA3LysyVlZET1pRdURI?=
 =?utf-8?B?WEFvbDFhVmNxZnlQQmp4d2lvd2Q0ckV1eVNKYk5PR3B1Vk0xOHl3UEhIK0JB?=
 =?utf-8?Q?5mtP3dH2GW7wDTlWopy4reVMM?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c3167b-fa26-482e-8f6d-08ddc035e17a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 04:46:20.6949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oBjc0u2Up6I4Wm2Y7GYGDeq/pN/Sj79W0GFs+3wBdwMdY9EsjiR+TMOVeKFp9GqjaaaTUJyCl9MoLoZ688pPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7912
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Jul 2025 04:46:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19394

From: Jan Kiszka <jan.kiszka@siemens.com>

Ensures that CONFIG_CRYPTO_USER_API_SKCIPHER is set on 6.12 and that
the BBB SDHCI driver is built-in for trixie support.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index e8eb4cc8..2e7c38e6 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -14,7 +14,7 @@ SRC_URI:append = " ${@ \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "29e3fbfb85303cc4dc9797740df5d54f77f43feb"
+SRCREV_cip-kernel-config ?= "c999bb8f530e3fc0894e2462cad10f610507c16e"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
 
-- 
2.43.0

