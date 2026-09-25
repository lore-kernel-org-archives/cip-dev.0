Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56540C98338
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 18:09:12 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.3])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4493.1790359740344310870
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 11:09:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=iP7+1B5N;
 spf=pass (domain: siemens.com, ip: 40.107.159.3, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqDEwx/+v1ZoC2OHH45y9PmDrsxoRqCnh5wikVMevKYklGLGrZWzs6LS1DVlqIsajA6X+jz5/BviXnGDrvDhe3Rcw32EoXvFWgVDqfIDhQz8au0Is8oI0iIcXz7uiwCirID/spj/3HLjTzshlm+hY1rbXR4as2SYLdVzkMvSRyQ+0SDYkDRrGlqrqvM2aRMs4r+uxxNHgQjAK1szsfzQ/kyUor+70/JFXYkUv+DnIWu4LwhtrNUq+A6zbA+Pn0bxdnE1B3IDZGkxOc0KZJFZ/2b1ZLFL1XJ0tHWyeszJxFDqtfD0JeSzX6BHDkgGuNbae64FPRIGHBXVqUzbpv01jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iTfCVHVFKlhQ1CAExmh5yps3bk3MA3irRMb4Mo0rnc=;
 b=bD/Mi43ckqU71sgDpqaVVuFnWvzJb/9hRm1WXOWY9oPgNOKffEMZ9iZZepfze+sJcIWfvGVmvxynioQw5WNQLsb2qws/G0jeOik2+aIFerk6B92e2HYFwAu3Fy4spKK/HsKpuxpKvDMl3Q6RyQiTJnHUr+y6NfMnTSbHlceP/MePfXsREHLTJJBgzkkjh9bEA16Iq8e5tgLuPQLtuRqzIz770mX/mgpdEJVlBQ+B90PZXdLUNq+RvekwnvyXttt4RWSUG5yqnzxlc3GGIstFGYjXUCGfiuT6KTPQej0KJzrQQWUJgMGadpJa9na8ALthszc/8RDb3V9l7SZYCwq0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iTfCVHVFKlhQ1CAExmh5yps3bk3MA3irRMb4Mo0rnc=;
 b=iP7+1B5NkmMdrz1Cp8P3ugqZDcj01JR12VvhM462opwX7q6xNinqHKunAdsOFv8nhVgpSOYtLeMDQazp+TVtVMqa2gKblJFcVX9N0+bsOESNdWQH1v6aI8amd4ClHd2sUB6SouuospVZeKCCsNpJXvtHtIlcZSrEHxtV77bbEtnsOaEuHcmR3pqNBp7JohOb7Yip2moKNLH2b0n1nH5xdqh5fDmb3k5PNt83PgRg5lNAKXM82o9ZUHmCixU3zlikqxbuKVR798RMvTNbIG1Lu2TirGSiMXhRgfhgML2KXdhe/0RDkuWWpvyr3tAjDG9rOsdCJtMw9AAxVZJM3zEggg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB9PR10MB6378.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 18:09:07 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 18:09:07 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	hirotaka.motai@miraclelinux.com,
	dinesh.kumar@toshiba-tsip.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v6 14/14] gitlab-ci: Add hardening option to build
Date: Fri, 25 Sep 2026 20:08:40 +0200
Message-ID: <20260925180847.622090-15-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
References: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB9PR10MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: c340dcb9-7e12-41d7-6a4b-08df1b301707
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|3023799007|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	9M9K043abeUfokJgyd2I8Sjiq/POh2fc53skVmDUmgFZvDc5/t3dQ0gD4geszgP5p9LWOE6jxYCIQfNpLqjQ7clzfCvlebQZZL3N++Wmmm1NMV6CIJCJ/DR1RNoikMolmRVRIhc8xv1/7jXlh/+z0kpSOVw3rbcjkdozTnS5q8oPfOIuQj+3irXvHj1rnibpwMes6yMKLKm5bCkfvNlHWWdjS+2sOON+8v4BALSLAy5WxXTXzNvk1pbsCjGnmgw8dplk3SR3cKrh/G2VQvtLFauLCCoxCRlrZexj7TGp82+X9jpLR1bj9OuMSPpumqRktuMwlKx7CFzm27bk6M/JTJqnSk+IRCwNsjHI9G9yca9Gb+qdlymJRahN7YGlzkVsjfDU6QqI2f/d+44ylOsXRR3kvPDGW72x3lDMslLgY24J412JB0N+akKU/2NNc57jsffEuJ1q9nrhGLDdyF2Adl/41ss462eGWTM/FGWCFL6UXu8I02PJwlno5902Tn0oSWCRHEubyyzNaoxSri0INDTNvErg0HYoDrR79o+SSu3tu605bK3XEWIBIvgGQRhiYpK5juj66jWLCx1VM3zcr4AMnU5X89owJCXxZs0PqLJR3gM6VUrnko7B9Lh7CWW+n/7d/2NgemDOzXQTD94H92t9ZAp6WiMDKZ9TnXYAfUs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tfRKYMMf+t6tbDP3coj5XPOg/cWqhAkwNvPF4ty9AZ2sNmA5NgZeGK4aoXaC?=
 =?us-ascii?Q?R1ds1y79DrDHHxGPS1DVWM6OsbcA72R9eloDmmvyW4CtfkC6CTJcjn+a6I6P?=
 =?us-ascii?Q?NsezVOSujI3Gysmr8EAGaCAfgFWlOzt+G/I4qpPdBvgGMyzU8s8JUUQaPuxg?=
 =?us-ascii?Q?BH93+XF/lQQ4PKxIia6jhxOcC8ai5iBNK/Stckn8q1nduY4AQ/2UU9HQAGxA?=
 =?us-ascii?Q?+nfGGKroXX7pKStzr7E/HK4gASSBpaeslASL89SwTY9/SVdUgOX9UZOCWpcx?=
 =?us-ascii?Q?1yS8acNEJ11gqzSMv+EyFj1INiK9PLJ4QRTG8Yk7a+mdceB5twVRdTVTw+5W?=
 =?us-ascii?Q?+q90g1Dgj51cUF+jKagPrEXUpMmxIzkvhBtWOaA19NxRZoO4RKMCVeklxf8k?=
 =?us-ascii?Q?NPtN0tVn5GWuCHBu/5K0FqyfczyDW8d/D2DKNBKnhJOMXRaEYAFeg5lLX2P2?=
 =?us-ascii?Q?b8WSM0YOyb0NvPCzwhwSm536psPnz2MoAsmbkTkX0CkahTyer5Zzy9/E+8A5?=
 =?us-ascii?Q?oQnPBNiz5mVeaRby2akl/E8dpQyLrwlTS1eURNEW1IwHdMMshhDvVZyK5FR/?=
 =?us-ascii?Q?ztcfsY0TZQ/5bdeX7CE/uODl8U2TaFp7qChFBd4/TO/fFPWEnZjugvLcslfp?=
 =?us-ascii?Q?hLir4en9O24NhMBpsi+l5AjSDH9UMWOzL9thqY+NCjEK9tJcztqF1vzyUMB5?=
 =?us-ascii?Q?M8xVN1cvVQx1gMf7gD7FP9PFsL1POpI9X9c7FzyR1AZcE0di2PSQ6pk/llJF?=
 =?us-ascii?Q?AlgtXwcut6VeKCSkJS3gRsH7nOy1w/imD0pcckXpXAXP2svVMGV+AlYHlIKh?=
 =?us-ascii?Q?cbrwL6qSszdS25rQ9jLhtPQVW4eOuzgG2NW2sc9LaWr6/AsDfQ2JlUuOnvPG?=
 =?us-ascii?Q?eb24hMToajurLRNFX54Xap+Xdv5oE98OXh57zSqbDw6L62KlXGomyoiwWKP9?=
 =?us-ascii?Q?/dGHycBMi2TMzF/Qe2WJelfLDV+dTqwLouMy6E0LTXXrNwjmmk7GNpTmQVPZ?=
 =?us-ascii?Q?VfAXxusCji02Zo2i7WV0T3bE0fuj3PDpNBBP8CN4MpQPULmH8qw/O9F0dTbV?=
 =?us-ascii?Q?CKV8AGdqD0H5fNxKRqUQgF69hpRThDRcZEHF4tX7H1gX2lOPPZNV2Kkp/Duk?=
 =?us-ascii?Q?O81hjdZndQIZDNUqFQLVANmkgp6Kn8xpb0f7/NWboSQKeQsT+dRNxWYRUuwC?=
 =?us-ascii?Q?tELLPIPaGT7d0C5s9cBYao8KsJpF+C/f+HEKz/No9KJhEPfKpb92K8msq42i?=
 =?us-ascii?Q?paef18JKIC7Xqky3uBAeBHU5EhmnQx1DyveehQyGZ9/qg9Ivc4brXhQR2feG?=
 =?us-ascii?Q?F0Q2SQCGX2c6r5SQs54sQbqsrE0iup9U7ZTfo5G34Lm+miAWS/+8DIKaj5ww?=
 =?us-ascii?Q?7w8QOa+Y1FS5VSFIMd7DyRZlpki2hGi8FaQmFD4PXAvkfXh+89KiXU61bB5m?=
 =?us-ascii?Q?hVolLeoM84C2z4pGT39YJHW1/FR6dPiyf0Y5J9kqCVEnwTOZr4qR9JvZSQFS?=
 =?us-ascii?Q?Za+Ork7+GTSSXCvMc9RiHCDX5G8vno7FVjijN+Xo+IxistsFYPcgXZl0ajKS?=
 =?us-ascii?Q?eNuCGq++XBU1sStn/q6ncE5tvgmw2XejKFUlhmmWz8i73he9PBRx/v6+aNsR?=
 =?us-ascii?Q?nwu+QzL9KWqmLrmP5ZNb5BfUqKJRwiY+lekRv5IgdvoncnltU2yaSF9VQSE0?=
 =?us-ascii?Q?C0lZM1gQC3UDeAZlo9jqKYxigfRBg8y9tYLbBKD0pgS7jajhcvVj6+jMrQN8?=
 =?us-ascii?Q?GZBjSADQ7u/lz9d+2Ty1aVaG9K3VWVc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c340dcb9-7e12-41d7-6a4b-08df1b301707
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 18:09:06.9509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwBVcZreoPU14L9FRxmiaIAYdlqX2RXGz5ee6SaYPA6uVK8h2ZR+EjUQAQUpdSKmC65bSSEnrv6o7VfGvauBIN7dgTMzID3QFRPQaxV5P5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 18:09:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24366

Also enable hardening for qemu-amd64-swupdate

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml                 |  5 +++++
 kas/opt/cis-hardening-test.yml | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 kas/opt/cis-hardening-test.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 10f97843..0f751751 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -27,6 +27,7 @@ variables:
   separate_home_partition: disable
   factory_reset: disable
   no_kernel: disable
+  cis_hardening: disable
=20
 stages:
   - build
@@ -72,6 +73,9 @@ default:
     - if [ "${security_test}" =3D "enable" ]; then base_yaml=3D"${base_yam=
l}:kas/opt/security_test.yml"; fi
     - if [ "${swupdate_version}" =3D "2022.12" ]; then base_yaml=3D"${base=
_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
     - if [ "${no_kernel}" =3D "enable" ]; then base_yaml=3D"${base_yaml}:k=
as/opt/no_kernel.yml:kas/opt/targz.yml"; fi
+    - if [ "${cis_hardening}" =3D "enable" ]; then
+          base_yaml=3D"${base_yaml}:kas/opt/cis-hardening.yml:kas/opt/cis-=
hardening-test.yml";
+      fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
     - if [ "${deploy}" =3D "enable" ]; then scripts/deploy-cip-core.sh ${r=
elease} ${target} ${extension} ${no_kernel} ${dtb} ${CI_PIPELINE_ID} wic; f=
i
@@ -255,6 +259,7 @@ build:qemu-amd64-swupdate:
     extension: ebg-swu
     use_rt: disable
     factory_reset: enable
+    cis_hardening: enable
=20
 build:ti-am62px-sk-secure-boot:
   extends:
diff --git a/kas/opt/cis-hardening-test.yml b/kas/opt/cis-hardening-test.ym=
l
new file mode 100644
index 00000000..17d9f14c
--- /dev/null
+++ b/kas/opt/cis-hardening-test.yml
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorf <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  use-generated-ci-config: |
+    OVERRIDES .=3D ":ci"
--=20
2.55.0


