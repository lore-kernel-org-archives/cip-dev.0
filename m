Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A8BC001B0
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 13:01:33 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.54])
 by mx.groups.io with SMTP id smtpd.web10.106955.1692018084206347248
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Aug 2023 06:01:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RmFKtedY;
 spf=pass (domain: siemens.com, ip: 40.107.20.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akAmgJMJwBMysvVgJ1i5CIcYHdeqDJd9yvfA+Y7rUwJFXY23Tqa+0W9zvKH+LChGxl6aoOcNV0T6gvqYoPNz7XV1Ryb1fNHtVyqXpr2sJnrVBV9iHQlmIQjUnHGjH94jVmhJyEJ8pAjIF1Px6JTgRe+iezcBJjWU2376VDV8rd7ZEQxoAFWG9nSrR6h6StUyo1fLDcd4BbJh7/cPYrPaz/oJtnDLXlJV4/AJcVrPzEpMKliAEMsnCeehRIFuD3lGyHr/8DMXj35k9aLFKc8iY9W5fxtRiZkEmVk29WL7+R0GaKjmzUS/JnvugBQWHUDGQ36NrvK3EMaZy3Be+Rzh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tz84PfFSz88RYDof0RaoZesJZ+PFQEYSUMt3yBBPQTc=;
 b=fR2vz1U2vmeR3NxS1xtBZ2fEPqPWRWS27rdTPlA+BQW89UZc0bACVvpGsfcDodKuqDAyadVUAW84gJ9eiHtOdP5V60o5u4TAUE40lxWno7XbKEWwLU5TExdbEEMCikJUG5OF6gxzEbw+cP+gxKpFbV51u66uIJT7if21c0oit0Yzt9LFIMrkcqNyK4nofgOyfXT6l3gleKM77WTRVyjqOtHXdDnuTr7AYFOAivV/P7AuWc1cQ8mSE5rZt2JPKyCsrYfmtYZQvMIpIQSysJtJSqEX85s4bbTrEYyNa0F5MnaZB+X3XhNfc4UP0FzFdwBbqMblCQzjdtgORnIKvJ/yOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz84PfFSz88RYDof0RaoZesJZ+PFQEYSUMt3yBBPQTc=;
 b=RmFKtedYl2iyt7vFC2ysScMGXY71uKBc7SHz89tncTb13yRT83Dx7supnXOK0+A0iNnii+tH+qyv7H1oA/tDB14+9T05LG9NLkdT1rG67kKGliub/9ntNFubM7SnUPuz0GnQCXnLx7TwCfMldDcG4moT2BMO/SuEDhbt084GtyOgnY8UP7aigSBAbf2LajIRidZ5B/AyaOpKvvCIEfsTY/TJfkxNpq72cf3Y0n4h37U7BhvauoBa+ku/VpA5Wo5AHIIwufq9LJ4C1lJ8L0Z59uxeHDzEqIOqoRjpvzVu+Hm6HEUGT5Z1RsCz+DzT1X3FANkPB1jZuD3LQk42UyGuDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6441.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 13:01:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 13:01:20 +0000
Message-ID: <953ed35c-abad-4a47-8eda-9f61a7a3c18f@siemens.com>
Date: Mon, 14 Aug 2023 15:01:18 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] efibootguard: Update to release 0.15
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: b5b80b17-f4b1-4b95-1e2d-08db9cc68e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UVZMIEJvqZokewqEpOSlJK8RTGCPIrKbZVYN2pZObhKjnHHNcqfwvTuihoo0/hHRlfTaVciInz0hL1ksaowkuH8iaN22Eof92QAOfSubCraeQi7Vs6u6MO9hXwUkqtFYIySkNPP0A1sTuscJanUK1eC4nj9ZQSpIkuFmk5cD1sJHY/eSWSv/aNtLK+6k0Ugab9mvBiDxk3tTfGbTJ9mx6Y2dOaOgmPu50/HDbnNKm4lZ6k0+elUlO20Wc8k2LbHGMJbcHL5cOK/3wvdzlK15IXZSHa8fx7NA+KfUzFSwkazl3mc2Ijl4sR+HpnZzpo0AugF9bLbgKA4+NT8wi+j/URgd1Oyan3B3mveFX4ZJr10EBI4KGU8O7ppVVQOR3AuZCEfUUTWvxKcdanagaQM+WT1LDfzsZi8SudUj39pz+dD6IEYwF5PvsCf2ibkVGRD8GcArpjGI8VoGEiz2u/IISgGkT5WckneUffjg2DE0fu8Jjeu72MpcbLQXFEWu8pcp5KdTnwkFpt2ZXUW39IIQT8+yZY4VaaYskynqYCpWSFnxcZVIUsLBAhqGLaOX66d/YOBV9vPAICQBUyLieh09oGSuq3ztNc8q0Mtv2mSf/qb0l8Iv/JNDeRQeWhsna+TL9W0juGZVAT005thQ89cYMPeMJU8UDuWXl5DpQw3ulG8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(346002)(39860400002)(136003)(186006)(451199021)(1800799006)(8936002)(6512007)(86362001)(966005)(478600001)(6506007)(6486002)(316002)(8676002)(66946007)(41300700001)(66556008)(66476007)(6916009)(5660300002)(44832011)(26005)(2616005)(31686004)(31696002)(36756003)(83380400001)(2906002)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WGlMWmFhQkVUSlFyV1hHa09Zald6MTR0d2UyZ05XUE1hVTlxa2VsZUtabk9I?=
 =?utf-8?B?K29MM0dPRDVhNmVMU2RrdWNYMWRXNnpUMDBlbGZIaTRpaWRTSEZMS0J0VXNK?=
 =?utf-8?B?cFFKMFdDRE85MzBvVnovWURBTk1jTEdEM2VReEdYbWJ3VkpNZHBpSGRQUWtE?=
 =?utf-8?B?R2lmQXBOS3p6OUU0Z3VvYjliaCtLUzQyVnE2UkRXemJLbEZLY3Mxb0dXM2dN?=
 =?utf-8?B?R1YyUXRIbC9RYTVBUjNQYzJMRUNaL3ZETG1BV0ZRdWdtL0lOSzE0aW1PN3Jo?=
 =?utf-8?B?TzRqczdXdUJPbEpEWldmQ25JOGZIcHM2YTBNMVB2SHFNV2FXdUMrWVNuYWxt?=
 =?utf-8?B?UUIwd1hmbG9JUWV0bHpzeUlMVmkrY3VNdlFoQzY3S0V2VHllNHk4cERxNjQ5?=
 =?utf-8?B?dk5mK1JPQmJtNVVNSFpSV0c1RXBIMXhTeGtGTWtRYjkzQzNwbGRTQ3lMQWRQ?=
 =?utf-8?B?dWhBT0pvN0pKdE1jaXhYRllxMXhiK0x2K1k3MVA0N2pjaUtPY29hZlRBNmRt?=
 =?utf-8?B?dS8yRWVoQjF3cTZCb2UvRXVzMEg4c3JSdUUwQ0Jqa29KUXR3Ym5sQnRhNkZF?=
 =?utf-8?B?WE85ZnJIRVE5VnozREQvTjJBZEdBd0xVY2ZEd1lNRGMxWW9lNEN5clhIbjFa?=
 =?utf-8?B?bzJTVnFPOUYxUkw4NmdoMzg2YVpUY29hRjlqN2RZWktCbjR0ZXRGUmhSVExm?=
 =?utf-8?B?KzUyVXhTU1ZnckJZSWpIK0dXMWhMZ3Z5alArN0VPaHNDWCtZYUUwYnR5RDc0?=
 =?utf-8?B?dTVhdDFDcjRmTVhNTEYrMnl0K1ByRWI1QVNnaGE4YUhTcHFyTVFoUkpiNzFk?=
 =?utf-8?B?Qm5xMXJRUmtKOG1INHltSmUrMW5hV0pMUDRnTVlsaU9ZWWxvY0NBYyttSndX?=
 =?utf-8?B?bnlqTUxZQUx2V2VPNGZyb3N5L3lOdHV0MWlOcUdPL01IdmQ4Y0JMTEJmZWNk?=
 =?utf-8?B?WFJFazQxbFphVXBuZHdYekd3UXhWODZhTFVKaWp5eXNSRmZ1amhoeXRxRDhU?=
 =?utf-8?B?YkNPbXRpZkV4aXNtMzRXTER4bG9oM1lHelUzVVRGWG10UFlYOE5mVEdYWXR4?=
 =?utf-8?B?eHg2NUpZdlp1YnlZOHRIRXREVDFSaVVoWW1XRGRZcHFwbmhlOTJrbVZuZTFX?=
 =?utf-8?B?alIxbnprc0pFV1gveXR3dGVGb08vd2taQmRhYVpaMHZRbUxGbWNIUXdoNTBa?=
 =?utf-8?B?VTA3ek0xNjVGYS9oWXNFZWF1RHVIK1lmRlZlZ21sVWxiZWdzUVNtTVg3SVAr?=
 =?utf-8?B?eFltWVk5enU4ODZrY3pFV0hLckhxOEphM1VDdFhha3FFSVpPcjVKTU1SbTFV?=
 =?utf-8?B?SHpMeTdpdnZtVEdaRGRGWEZUQjNNRy9zdnNNQ3NTVml6OUJJa0xWN3R4TVYr?=
 =?utf-8?B?bUF1SDFQNGx1OGx6WjBGK1JkaDUyalJxcXFpSjhPNkJGT2djVGdFSnh3bm5o?=
 =?utf-8?B?bDJ1Vm4zeVByck9wUFJnT3c0b1NibFR1QjV0NStVcVVQcDVlKzlWNFhVejFW?=
 =?utf-8?B?YXg5Z1ZMZlBMNHE4VXlnZTZ5d3JucG1WeHZSYWYxWkZYZEl1QWQ1MjZxZXJz?=
 =?utf-8?B?c2NjQTZMUVZGL3FIdHFBbHJzK2VWQ0lZRnh3dnRrN0todkhtcW56U2k5TmpG?=
 =?utf-8?B?MVhwMmt4Q2svRW9pSzFBSDVhclZscWwxQTNrRnRXZmt0czZBTHpTLzdwdGwy?=
 =?utf-8?B?c0dOaEdSZUUrTWwxcnFyTmpqR200OHBTQlJCSThucndtZjZNT09HRVRLcGJy?=
 =?utf-8?B?b05ENGxhYWJaTDRsZ0QzbklxTXhsS3FWM1N0VmdweVBEeTBML1psNlRBWWFM?=
 =?utf-8?B?bUNZQ3p6bEFuNU9sSmphM252YUVsMElKcXpTQStlOERBWlN0dFlJeE9yTGFN?=
 =?utf-8?B?YU9CcUlhd3BMNEhKd2VpUlpVak95aWdLRWhHdWFlOUJwb0hTUVlocjJSRHZB?=
 =?utf-8?B?SGVQbm14Y3JSNVRtVDJoQ2lGM243WEwxNjQ2L1YwYzhWR0R2Qm8wdDhEek85?=
 =?utf-8?B?c1UvaDFnVWlOc1hnald2cDlZQkdhKzRFajBGd3A1ZEt3TEZNaDZYTTlEZ0N4?=
 =?utf-8?B?MW94WDNhSVN0WlF6RTczV3dkL3pmWEpRTEN3WUpVMnhOdThCeE55UVJsbXFz?=
 =?utf-8?B?dVJiV2QvRWF2bHhGT0dOeXdCTm9xMU5TM0c1aFFTUTg5dFR0T3lzUWNRc05H?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b80b17-f4b1-4b95-1e2d-08db9cc68e4e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 13:01:20.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieHFoaNIfIsh2Jltrb6HDUXCCjXPtRrAkxU/D6goEswv3ft77Rz3YtBdl4AwkF3qCAre780c+Xn8KQ5JPNyEcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6441
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 13:01:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12649

From: Jan Kiszka <jan.kiszka@siemens.com>

This fixes CVE-2023-39950.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...{efibootguard_0.14-1+cip.bb => efibootguard_0.15-1+cip.bb} | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.14-1+cip.bb => efibootguard_0.15-1+cip.bb} (88%)

diff --git a/recipes-bsp/efibootguard/efibootguard_0.14-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.15-1+cip.bb
similarity index 88%
rename from recipes-bsp/efibootguard/efibootguard_0.14-1+cip.bb
rename to recipes-bsp/efibootguard/efibootguard_0.15-1+cip.bb
index f58a3200..0cfb6daa 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.14-1+cip.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.15-1+cip.bb
@@ -17,11 +17,11 @@ LIC_FILES_CHKSUM = "file://${LAYERDIR_isar}/licenses/COPYING.GPLv2;md5=751419260
 MAINTAINER = "Jan Kiszka <jan.kiszka@siemens.com>"
 
 SRC_URI = " \
-    https://github.com/siemens/efibootguard/archive/refs/tags/v0.14.tar.gz;downloadfilename=efibootguard_0.14.orig.tar.gz;unpack=0;name=tarball \
+    https://github.com/siemens/efibootguard/archive/refs/tags/v0.15.tar.gz;downloadfilename=efibootguard_0.15.orig.tar.gz;unpack=0;name=tarball \
     git://salsa.debian.org/debian/efibootguard.git;protocol=https;branch=master;name=debian \
     file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
     "
-SRC_URI[tarball.sha256sum] = "80452a9e37460708113292daf0050d3f4fa7d3d4b8b2308620701112cf18eaa1"
+SRC_URI[tarball.sha256sum] = "9d2d46913ed8013056a3c2b080a997e68d78d92a1051ced06fbfefa93353bb7f"
 SRCREV_debian = "e39728f63946d1af2d5edbecd89a30706dc31a9a"
 
 PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
-- 
2.35.3

