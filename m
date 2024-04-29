Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6700DC4345F
	for <webhook@archiver.kernel.org>; Mon, 29 Apr 2024 15:46:49 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.57])
 by mx.groups.io with SMTP id smtpd.web10.25012.1714405606994369676
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Apr 2024 08:46:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iSzZos19;
 spf=pass (domain: siemens.com, ip: 40.107.105.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmEzQM+dq2heT4N5igqXoO7BpKtWObw2tlUa8durz5y+Z1Xxuvdw8AilDd07yCAswzCJUnZH1WsvDdJB14d4IUr32AVqLb1zW+kS0BIEsBm1Bgrbe5QbW9JsN4G8H1L7eZ2I0xnMKu5k7//elyb8Ubdrbe27a+X8BPDVE30ZV+u7AyHZz4ypzSONQM5hrt/bAh/Tz0Y95VBSzMYHAJCpE0g9kFYAIt1dPuQ/U1+eovmedJ4Z8NFm0ok2qcrzTRNB6iLAIOhmEYdkfTvVL9tv9XekajJ/6Gz/PbohCt8jGBsH4swO0NayGV1xGR3KLbQiy8WmCOenM/ON+Nx47RUbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jfr0gSQorkyrtm3D9dh0k2zSob1stAJISJ2QrDWyKbg=;
 b=lGf54rpxaQDgi95IK8LARgNsTLxkweuid7Z56TwfgSRyZLkCJoOfdA7RmrN7YbzlIj6rsEEZG6vhfzoMWKn6BNifJWuR3fJQ636ZZyqb1Bm0EiPhvgFT/gzjEWiov9jcdNrOEBWiJ1Rh8ly9pfgJ59o1kgHU/daeI/V2fPIFg7VFYHeGh5EnLQbIEBipvfMGVecqV2JkoGphSrFPMuhTbZiHvz967yzHCsyFN3QFXhAOdhXHbSYcCYAzsgMfqkk+PmsdRXognnmO/xufTxlfw8r2onf26RkibTd2yckph2ZvOCjgmdAe+BmdwCtoQfttXRlTIBTnXsFxu7u7uKZ7Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jfr0gSQorkyrtm3D9dh0k2zSob1stAJISJ2QrDWyKbg=;
 b=iSzZos19fe4KQeAQ7E9J0YmAE8C7obHIWeAnARZZnV+LvXu/ITdHzcZYpNIFFr7bRoDHVOZ+RaHFny/n80eHWoNpcodFINsD8FiojenK3VqpQZEwYdQHjpwnRqAbVttqB3hBUFYArhf0WgdV1lbQyu1kVfKrTY0Whz9EpLgeZyOE2SK8Ttj7XTXTgdRgUyNkV2fGUCPMjKDewvehrL5t//ZMeKn6oqBWFWz/MEuajrHC1yVrLK+oj+xZPIXY3quc0frXz4Z/gYx9b3hVcTb6tZYOefp11OktWWwiuVfsmbryJgqcQJuoyQLW48NFQzLhfglJr0oZZx6T/zDW6IjElw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4043.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 15:46:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 15:46:44 +0000
Message-ID: <e4ce9f4d-5b4b-44cc-abc7-03d083114b97@siemens.com>
Date: Mon, 29 Apr 2024 17:46:42 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] dosfstools: Use BPN instead of PN
Content-Language: en-US
Cc: Rakesh Kumar <kumar.rakesh@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be1a6cf-07bd-4462-07e3-08dc6863920f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RU5mK25MbWxiL3h1eDVNUmU4ZHc2eFcxUm9oL3RBZ2cvL2JjeFNic0huZnZ5?=
 =?utf-8?B?U3NpRU94dm1jSG9PN3hEVStBMjRLZytzMDc5REd6U3V2VHplMzhrZ3BKL3Ey?=
 =?utf-8?B?VWtueDRDRzdKNldwb01GNjZqV2JXVFBLampzQnBvYWhtNHc4cUNHd3VGMHpC?=
 =?utf-8?B?NGpTZlFXdGFKSnhyVDY4NmxkNzRWYVRMT3o1cEppUlh2MmFGRmVzWnRRLzBa?=
 =?utf-8?B?Q2pkay94cVpHOGtQNHpsWGVYTkZLSC9RZ2FoR3BudFhzK2ordjIya1l3S1V6?=
 =?utf-8?B?VFV0UFdoNUI1OVVzVjY0Z3NzR01tc3hONzU5c2RnNXlwV3dEUjZHVCt2Yy9j?=
 =?utf-8?B?UjRGbnlEM0ljWDNvOHlVY2dHN1o2T3VqQi81TE9PYXRreDhXT3p1Q1Yyc2xE?=
 =?utf-8?B?endwM09xRDRyZCtYcmhTRjB4RXpYT2c0WHdjcW9PVXFvNUJtYmplOVU1VTdi?=
 =?utf-8?B?Q1VtTi9Wc1JuUFIxNlVBVU9OM290YWNUUitEb1dMdlhjRFhIdlV6VVB5NUZP?=
 =?utf-8?B?eENQWE1YdEpKaWdZNVhqNkQ4WlRhL0gvY1dVOVcxMW52RU1TWjFvNGVNblFQ?=
 =?utf-8?B?M0labnNXUXVhUDlpQWpVVU5NZUFKUlVDa2JxcFQ4OFFHcFpkaWNRRmJIU3po?=
 =?utf-8?B?TFEvejFOMXNsTUlhQ1hpTXZOdDRsNGo2Q0pNZmtEd2xFWUM1QlJmQXIyRG0y?=
 =?utf-8?B?aGhLOGwzeXgvaUk1U2pTclFYaGtPQjJOa1V3dm5uK09RYzczNjBGd3hUb3B6?=
 =?utf-8?B?amxQY2ZKRDFGSEhTdkF2TmpuV3BTS09TWk0vZlRFOTZ4M1hMRFVQMHZKSjBa?=
 =?utf-8?B?dGJJRGJiQzhUZk5VTEZSTzdJZFhDZU4rSWxXbnFkUFBzU21uVkZlMHJ0VHV4?=
 =?utf-8?B?SVhLSmFERzE2RUt4U1dmbzV4eVVJOHNJUjhNSDRrK3ZZNXorRDloUWgzT1J0?=
 =?utf-8?B?OE9TbHFkTGw4dFFaeEgvd21TbkFVNS9WZ09XMkJkVVpUUXNGYUhPa3hIa1ZQ?=
 =?utf-8?B?RE9CQUJWM2w2MTFTV3JxbmFUQ2xZMW5ZeWxiY1JvQ1N5Wm4ydFc1anhRRDFv?=
 =?utf-8?B?VGZ3OHlUMEhZSkdWOXhxU1FTKzVLVkZNVTYwNE5wd1FjNUlHYUxxTG5icVlJ?=
 =?utf-8?B?a1FQZFBlcERSZHZnQjZQRm5tRllVSmhHRmxNQ1U4VUIvY244UVFEb2d0YWJu?=
 =?utf-8?B?MEtwS3ZtZWZ3ZUlETmsrVUcrQzBlUHZyTDFROHNIS0VNY2t0WTVZK3o5UWgw?=
 =?utf-8?B?clVNLzdRSlBGRGsxSHE2cTNMSDJtNmRHc09UeStjNXBnc0RaOXp2WjJYdHZQ?=
 =?utf-8?B?YXRGZUtrdk1RWUo4WkU2NUh6Ly9jbTh0cEhTaWdNZ3dLWis0d3Jjdlk1STJZ?=
 =?utf-8?B?YkExVkNDemgvcWszOENPeVI4eTBHQXZqd1lSREZFZ1l0ME8zQ2tTVDZicjBR?=
 =?utf-8?B?aVVMbWhqQXJUWUI4U2pUYVRDQVFzVXpIMjN5aXBlWWZ0TVBMOW1GL3c4NXdv?=
 =?utf-8?B?OEEvRGZSVGU1OEUvZ3htejJNYW1wMEJaL2xYbjNJVXN3TWVYZG80Tm5LUUMv?=
 =?utf-8?B?ZityZ21rcjYvQkVHOG03bXJyTXZmdFFEWGw3b0dSS0M5elFRaHBjaVI1MGEv?=
 =?utf-8?B?dUhkRWh2aUhBblRTQUF3R25NVFoyZ05idnZCRk9KK1NlWExzNG1hd2YzTWNE?=
 =?utf-8?B?NHpYNXBEU3FpTTFDUmNIZllrQzRwb2p2RzZkZnFtSlI3ek9FQXZwTXRBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SHBUdENyMysyeXBlSGJuN2hKM1JUay9HYVFIRWdHNld0WG5ZZ0YwSUE3bEt4?=
 =?utf-8?B?SVNhRU02VGhMYWJUYWs1cjNISyswNVlYNzREdTZrRG1zUGdYekJMN09KSGE5?=
 =?utf-8?B?MTE0eTB2RFVnTGVGbWg1dmxMVjFGZDhCSnJuL0NFUmF1NDA0QnU3Z1RjSTNX?=
 =?utf-8?B?a2NXZGdjY0UwaGtxczFpZzR6bFU4NmpEdjFFVDBEbE9aVU9jZDZBWnA5azcr?=
 =?utf-8?B?N2tZOVp3Nmt1Uzc4ekxTdytNL0hlb3lHR0ZpUWlHcEtjREtvSjVqcC8rR2Zu?=
 =?utf-8?B?MStpNEdBRTZTU3NDOFdCK0VuQ0FKN3ZhSE9Pb29iQjVVVHI5UmtSc0Q3T0Nz?=
 =?utf-8?B?QTVjUmRuMDNrZnVzZWI3OGtYTUJ1K2JZUjMzdUsxZ2MzclZ5MFpQc2ZFaTVO?=
 =?utf-8?B?RmF5b2o5M054MWNJZ0F3dE5hUmFiOXhlQ3VnSEpTV0tiSTJIcm50cDRzWFNa?=
 =?utf-8?B?a1lqMGxyWVJmelRHSDhYeERYVFh4QjR5TTRGOUIwVWhEaEZncE4zR0VPQzBt?=
 =?utf-8?B?NytFb3ZPYTVvMTFzUFNQTjJnQ2F3R3hMaCtpdmtoQjVYc051QXRHSGx4UW40?=
 =?utf-8?B?ZS9BREVnSVNOc3Z5VGZWdkpsNmVZVEpIajZiTS9RcmpyRnB6bDdLQkxrdllh?=
 =?utf-8?B?QUlSUXpMb0lMZ1NLMmU2eGZ0VSttNS9vbjExOVNOWjNsQnMwVFJHdDlueHhZ?=
 =?utf-8?B?OUhlR0VQN1dmaTdkQ25xVEVzbHhRQ2pmWTE5NVU1Y0pZN1hyU1hGYTVaKzZo?=
 =?utf-8?B?K2pMWEd5cHNGTkFtZGVSZGVWbkdTeCtFdWNGUUJNWnpEOHF5eGNLNi91NC9L?=
 =?utf-8?B?eHhJa0RiemZiMjRSTkN4dkNLWktnRHlWM1RtTDJiZHdnNUVsMEpxaDVtUVUr?=
 =?utf-8?B?bEFFbWVTMW0yVHlBazFVTmJ2VEhEUnp0N0w1dXErY051Z2JDVndIZFEweU93?=
 =?utf-8?B?SmdaZ2xtay9HN2ZDSVo5Y1Q3UkRVblhoTS9DREs1Z3owZm1VUTZtaWZWcFo3?=
 =?utf-8?B?OStXSTB2QzA4TGZzYjhrNzFGVGxjeEV5dnBESnNSYjdhaGJzYjQvQkZzclF2?=
 =?utf-8?B?cW1VSldqb21rS0lFVzBJK2wwZy9zWmFOTmduaHcvYjZNYXpRTWdCOUZrUXJ6?=
 =?utf-8?B?dDNLMTdGU1JXRDBvNllSMEdZRnNaeDRwdDJkZm04QWlnWVN4SlN1clpudWtn?=
 =?utf-8?B?bE5jWU5IMGVHWDFIbW4ydEwwa052M1lFZmJxRnByZjNDMFhPVnlteGZXeDRu?=
 =?utf-8?B?aGplUlBwb0hLbnhhempHNjhmUHNOUnRxSFkzSXNkRnFqVWdnQVY1VE9ScUF5?=
 =?utf-8?B?Qk51VmlQMGc0U2RGQmZDd2MrVGxJL29EeWFPd1NyQ3pVN1B1NWlQeTEvQmlG?=
 =?utf-8?B?R0NYdjhCYmZDWHFvNU9SVWIyTHNKRGNETzJzL1F1OFNwL3FHTXFkQWorM08y?=
 =?utf-8?B?MzNEcVVxY0E0Kzk2WitkQ2JKUC81VWpZZXVGMG41Q2pTU1ZtVkFTYVppMkpW?=
 =?utf-8?B?VjJxTGJETW45a24xNklwWkVWck1SbUMyQjNOQm5IcU5LZkF1dDdodzcwajJo?=
 =?utf-8?B?SWhxeFl4Y1hwcHVwWXFnaXZkTnlsMGpNNlpUUnduVjNYN0o0SkFKQXhjVXdn?=
 =?utf-8?B?Z05pa1JXTFR1emxxZ0JpclJaSC8rNTZJczcvZlJIbVZjSzJJQWNjT2JHRjkx?=
 =?utf-8?B?TWNSWkNEZjhwNGZsS2ExTnBpZGhzZStuMjgxSDJCMVlJNm4rZkEyYW8yNXpK?=
 =?utf-8?B?MzMvZHNxb1JXMnRjN253eHBBd2hZN3BwUE1pL2xKNzI0NURkWWNWaitXR1Zn?=
 =?utf-8?B?YnRzZVBINEdEK0VJaG52OXhDYVltd2FqZkw1WkVMQjlDMTVqSnhsUGcrZlhj?=
 =?utf-8?B?TjM1cWdRaHVGTkZTNjk5SnRpWG1OU3dzV09WVEc4SVVMcFlBRWQvUmRscTIv?=
 =?utf-8?B?STkzZTRnalZXY2ZrSDd4NjJzbHpjRmMxalIramRKL2wvN1NFTHlDMklNZUt3?=
 =?utf-8?B?NXdCR3dCV3FGUmQxOGY2N2RjV1A3WGw2YUNkVEQ2bmdZME90c3ZzcitGdCs4?=
 =?utf-8?B?Tkc5UDJvTWdTZFV4TW50NCtBQzlYQjBFb3g3aXNpYk5BV3ZnTTBHNjRyUWZr?=
 =?utf-8?B?K2FCakM1TjVmMlRqOGRSTDJMVkJvR3ZBZmVmMWRSNWt5L01mbHJya1RaeVhM?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be1a6cf-07bd-4462-07e3-08dc6863920f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 15:46:44.2398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qw+I8jYqwCb1jLTtkHGhJOPrCMUqb3sqFbIvgYW8BOQ0I5dpaH8+rROTICAVQT+ZLgXTr6X4OAWP3fMkHSyuUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4043
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Apr 2024 15:46:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15782

From: Jan Kiszka <jan.kiszka@siemens.com>

With upcoming changes in isar, this will become critical when building
-native.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This needs to go in before the isar update. Already in next now to fix 
our pipeline.

 recipes-devtools/dosfstools/dosfstools_latest.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-devtools/dosfstools/dosfstools_latest.bb b/recipes-devtools/dosfstools/dosfstools_latest.bb
index f42ff18a..37a8f420 100644
--- a/recipes-devtools/dosfstools/dosfstools_latest.bb
+++ b/recipes-devtools/dosfstools/dosfstools_latest.bb
@@ -13,7 +13,7 @@ inherit dpkg
 
 CHANGELOG_V="<orig-version>+cip"
 
-SRC_URI = "apt://${PN}"
+SRC_URI = "apt://${BPN}"
 SRC_URI += "file://0001-Honor-the-SOURCE_DATE_EPOCH-variable.patch;apply=no"
 
 do_prepare_build() {
-- 
2.35.3

