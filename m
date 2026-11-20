Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2110.1795163166724666808
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Nov 2026 00:26:12 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=m49w6ulc;
 spf=pass (domain: siemens.com, ip: 52.101.83.48, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gViLyfYXAZa7NkEyZGQEeZZei/XeZPFHTR2ks2D+M8JGdSG6XaHWlpzl+9KqhuFRzxd/yhdehLzr3UJ8OfkauF7bsQbEXClfWdBhjktUk0j5TNFQJIrKG1qgabLcxQjb36nk/yK3/dW7wbClLUH2L1B9DOpJzavLdl5G27ogsPY3CIGxyFFMoawnLb9QD0GcWAmemSeqveMXR+WsqPRW+jj83A7fZgdvVbsnyhBUTICVUWgBGkQFoXylq9d5aZ0vmVuR2Q0rQqGy+nvvZoITKC/+cQDqVYbwr097wN4oE7Zan1xy4VJ+cUKdWeFufsZzb56RfW5qO5tB4JSHdQKGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukXlS6O0jkj6OFJZVbzWORc8Kn4AaHKREvIGoVCbW8U=;
 b=PtCZh+gY38ulzIXcjTjfpq5waPP048PFAkRx6VOvyIe5IXdilrwo6jP51G8ZdFw0yL0fLWTVuU0Mi0kQoa0J0Q7XVBlbJXzlkxhrfp/RrTjIY0ky22PXBLo7SWsIl8a9FaYXD4V+qAllfe7h9N9I5sgJb86E8c7F9AevmNZ5G8tzsGQkupgP4NF7TBvF98luKGPBODoexb3RVLeobfaLZ9DO/lwjYns96NiAxd1Oi2P7q8NdsrQLwA1cTnht1azJmrH9nVQa0c5NfmV5Ze7q/NkeJ6hMtekqiHaF1PkyUuXNy9zQnKR7+Gp+oBHoZISCHvzkgdfbYl9s06zr4+QZIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukXlS6O0jkj6OFJZVbzWORc8Kn4AaHKREvIGoVCbW8U=;
 b=m49w6ulcPJuePglqVWgREV/YzTHzoExh6HGTMTRdDHpnP/opZx/f4kcIRrcxVEuaVnmVeLSZW56OfMsB+MtzBLQmJoxVRG50VWubXYgV0pXYBLonWMp0MC/HyqdaT25Rl7rABPlZTAbYF8x5cIcslLbkQyvl4/WYeUJu3itsXyrGJTHkUfiZgu8KCwfzkQD45uzVqSzFdR1iqxwajzFcDQNHet63oU0DB5CXBIPS4Uyge3/yZEpBYzKHIFitw87SWMK+FA63rDRlUR0LDdYYXCdvy63PFRWb5Tky+HJy2iKmnI6TqnmtFRluP9lOYlVXnEBY3Jx4+/ennx5pxWKqcw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PR3PR10MB4077.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.2; Fri, 20 Nov
 2026 08:26:05 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0662.001; Fri, 20 Nov 2026
 08:26:05 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	chris.paterson2@renesas.com,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [isar-cip-core][RFC PATCH 6/8] ci: skip all other jobs when building the lavacli container
Date: Fri, 20 Nov 2026 09:25:52 +0100
Message-ID: <20261120082554.375548-7-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120082554.375548-1-quirin.gylstorff@siemens.com>
References: <20261120082554.375548-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::12) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PR3PR10MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: 887c2753-715d-417e-07ef-08df46dfeb6e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|11063799006|56012099006|261009223027099003|261022115727099003|261022075727099003|261021121427099003|261022105027099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FX3s1kV97Os1WuB7kRFOYVEFE4Omb4JE72nI1qNY+0aiuhRi3CXqbjgvaquP7/D+0Ofb73gKg7HXp8rrP2PW+hUKsQozlAG8H6ZYyEf4TPj2PTTfbuIEh2Q0iuMlJ4frbhs2V8pfFIc/PlXmxyMmMXhstrd8pQ3X+WDjVtCQSyPsB6+6Roxyw647xyCoXs7elnYhApuRoR6EKfEy8WWAaOzfkPeoVndx9AUe3cMdf/1HwKmwzYtMnIsUOm+c9wETQyUwB7xBQFsaAWnpOkdkJlf0uEZTsG6Y8O+A82smygq4+q4n1Lsl1EGDv5MZoRSHb7JeymlsUNMjpoerc1kSyFPSgQPbrsgSuGb/zviaRwaPjzqhCMtUTEYXTCRh21Jcn/piFJNTlMa8/0KrahSX5jiwvCCJUOKwyM7zsxcjREfe3EUa4v0yNdTWispj9RhiJmWc+iyvKwGRv1xJzJyFY1kpZ8MdsJRVcey03oEPsdPMHieuubN7FN3tgmBDJn6CdtPCTlT8cSJD3leKKy4ZA80581qPAc7S0LlGDLr63bAoa5xwZwoArqCFrdpuxNlLdcMb6tTG9i4u5oGQ3S0CqZ4iy0eUxMX4YfErUkSSwjN++4u9bBkKkfkmGtKh5M1TN9aoB2tYE3jWCYMF6bvZb9cW/usmT0mW4sUxLdz6oO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(261009223027099003)(261022115727099003)(261022075727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mYqKmyDhvMyfmw/fjpd7tTj5E6tNEsZsxJ1hEZk0jH1jn8S3wW6fbWANURii?=
 =?us-ascii?Q?LVJl1AHEspkQwVqLiZG759kgYP3qOR8BY1x47rp9UZngXTAujnV8VEiycZ03?=
 =?us-ascii?Q?FSyjd7Ffk9MinEjYZscm1pD/XaDcsu1bUGZMv1t1d5W5QWUtkkEMLC49vUZ+?=
 =?us-ascii?Q?Kym6xL61y9U36Iv5jmPsAAeT/8BWLQlaGePy6GKAinOfg/TVpDVQjCs0wFOD?=
 =?us-ascii?Q?4KwcTS7vx4j1n7z33Kj2voGbTNUBuHfNb7miaXllfsWzs9+awEpBvqJNxXox?=
 =?us-ascii?Q?i3wazQMVBbjWiBx1LyOCbyh0sDdynY7QwgsCygLz2niaphOaQfbIIFE0qccd?=
 =?us-ascii?Q?Zn2rIdRDFNm0uIAyNJTSwR6yS7/yl8V2ZpdfRYh/eFsF8Wjr5wp4YsXSacsb?=
 =?us-ascii?Q?OI/A/jD2ZQJ+k/9oNFwynqTuYEt9Rf2VKAurRg7l/DroNGPLfys0BtRbO799?=
 =?us-ascii?Q?E0FdhRa3TBGdxb3n5A+HTaf8LC4gfh4CqUuvq1P7ESlEOTvOjZtu81on+AJu?=
 =?us-ascii?Q?DXTPAFzpf2g5DMN3Idbb2dQSiWf5jJYNfOAxR/Mxs6LQvvt9m2xkgbIMATob?=
 =?us-ascii?Q?crUubaazdKpv5yM0iJuaXw1sfPbjkhjYpdJy+AjcHpFNqe/52QQVtgafyo7D?=
 =?us-ascii?Q?EWh6Lf+wxICqdRVmZWLei88h4BRLjtMzu7mGCLtuij+YxxuTGsjosHSrtL8h?=
 =?us-ascii?Q?YVHdF64AtkVAeYAK9L/cUcpuX28KTSvGhYSJDf1Kmd0zqXcF8bz7iE0Vh+U0?=
 =?us-ascii?Q?hdL2V1VromRp1mkQr12At5DLzmRXLleEZFucxeKLFOYxxUJAIPAO2KZxMOXh?=
 =?us-ascii?Q?66BLAO8TT/iFjPr3g3rdm0op3RIRMvwjApO8y9wGaEf+CQjnqrWom5G1iJf0?=
 =?us-ascii?Q?y4x3xRs2r7/8daSCOua4V1Bvufj5/zOIAQcgYk8DpWsen7PD1N/jxqd4pfX/?=
 =?us-ascii?Q?tjO4tOhO+L9gRc5zqAmjBGiQGAbgro/Eta08pOE2Nr9o8wxQe2YQ16rsnBev?=
 =?us-ascii?Q?hPx/YP290lf4U/DNzC7aKxjBszRIXehAWCo71qvPFk17LKxUIs7iXrC9WuSP?=
 =?us-ascii?Q?2on+VQoqcNyeKCqXet5NKU7sTOOPxsn/xD5Ud+MfSnoMIQUhuCJrAWICcG/0?=
 =?us-ascii?Q?qg0Q/cGmIuLwWkDAUrvvdYeL48DzrhUvSbeeot+jcUxuUUd9O+dVA1D0ioyS?=
 =?us-ascii?Q?eMtHrUvMOzHzSPJr0GIXtoBuF0AX1zij6qdJBg76Rjz8rb+bbfSjRaXfUbVj?=
 =?us-ascii?Q?a9xB01vnkQq8ct7mon9RdIusvFbB4YPYQRBzaVarqwMkviB/TW1x+dD4JSDw?=
 =?us-ascii?Q?kx+and3wLbmQhQcxoF1jQKMj7WrcRqsn6e5C6qpf9JKZQqyv4WBojyf9CRTT?=
 =?us-ascii?Q?H3nS99G8KFa2loak35w2zLmwEkduv0wn+UCdTe0o87uB4l67kuO5/pbRP8cI?=
 =?us-ascii?Q?VhvcJFTnn+QsuHs54W4qq1P5cQ5aTDtECW/aW/mMMRLcR6IAxe66+vNwmLsK?=
 =?us-ascii?Q?/llXEnP9dFEYQ1jeIwvOyB0vpcA5Ovub4b/bmXnumYAY8fpgCw6G73YGo5oc?=
 =?us-ascii?Q?kuJyyIAkW5FZHWfhtTDCunVY2OYFY54Q2t1lPd8UK8dIfkG5huvZoic+Gsat?=
 =?us-ascii?Q?WTTXCLjHQsM9f0RuL2bRgsjgCyDXvX5oSFU6rwovQ+IstvV/wyN8ChU624bc?=
 =?us-ascii?Q?MiNYLWC2v/hnAxMCFsBe3RCte7EphL5arBL2JiYzIX0qMd5E+uaxyk7CiIaO?=
 =?us-ascii?Q?KxkUNktDeN48FQIIviqhLQeLBrW9Zwg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887c2753-715d-417e-07ef-08df46dfeb6e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:26:05.2965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvzXqSFNpxQJfuLk1j2Xdc4eWs8XS1qYo1GRDPAQyhTCgfvuGVrhMs8uiRveeiXZSXZIQUDLEVvz3UOLG1ONZilx07WVsC2xGRbWTE8PRZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4077
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 20 Nov 2026 08:26:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25035
Content-Type: text/plain; charset="utf-8"

When LAVACLI_CONTAINER is set the pipeline is only meant to build and
publish the lavacli image. Add a first rule with when: never to the
build, test and cve-check job templates so a manual or scheduled
container build does not start the full pipeline.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index afbef661..1878021e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -49,6 +49,9 @@ default:
 .build_base:
   stage: build
   rules:
+    # Only build the lavacli container, see lavacli-container
+    - if: $LAVACLI_CONTAINER
+      when: never
     - if: $CI_COMMIT_TAG
       when: never
     - if: $CI_PIPELINE_SOURCE =3D=3D "schedule"
@@ -372,6 +375,9 @@ build:qemu-amd64-secure-boot-buster:
   extends:
     - .build_base
   rules:
+    # Only build the lavacli container, see lavacli-container
+    - if: $LAVACLI_CONTAINER
+      when: never
     - if: $CI_COMMIT_TAG
       when: never
     - if: '$CI_PIPELINE_SOURCE =3D=3D "schedule" && $CI_RUN_UNSTABLE'
@@ -423,6 +429,9 @@ build:qemu-arm-base-sid:
   extends:
     - .build_base
   rules:
+    # Only build the lavacli container, see lavacli-container
+    - if: $LAVACLI_CONTAINER
+      when: never
     - if: $CI_COMMIT_TAG
       when: never
     - if: '$CI_PIPELINE_SOURCE =3D=3D "schedule" && $CI_RUN_UNSTABLE'
@@ -473,6 +482,9 @@ build:qemu-arm-base-forky:
   stage: test
   image: $CI_REGISTRY_IMAGE/lavacli:$LAVACLI_TAG
   rules:
+    # Only build the lavacli container, see lavacli-container
+    - if: $LAVACLI_CONTAINER
+      when: never
     - if: $CI_COMMIT_TAG
       when: never
     - if: $CI_PIPELINE_SOURCE =3D=3D "schedule"
@@ -798,6 +810,9 @@ test:qemu-arm-swupdate-apply-same-image-swu:
   extends:
     - .test-cip-core
   rules:
+    # Only build the lavacli container, see lavacli-container
+    - if: $LAVACLI_CONTAINER
+      when: never
     - if: $CI_COMMIT_TAG
       when: never
     - if: '$CI_PIPELINE_SOURCE =3D=3D "schedule" && $CI_RUN_UNSTABLE'
@@ -839,6 +854,9 @@ test:qemu-arm-IEC-sid:
   extends:
     - .test-cip-core
   rules:
+    # Only build the lavacli container, see lavacli-container
+    - if: $LAVACLI_CONTAINER
+      when: never
     - if: $CI_COMMIT_TAG
       when: never
     - if: '$CI_PIPELINE_SOURCE =3D=3D "schedule" && $CI_RUN_UNSTABLE'
@@ -938,6 +956,9 @@ cve-checks:
   script:
     - scripts/run-cve-checks.sh
   rules:
+    # Only build the lavacli container, see lavacli-container
+    - if: $LAVACLI_CONTAINER
+      when: never
     - if: '$CI_PIPELINE_SOURCE =3D=3D "schedule"'
       when: never
     - when: manual
--=20
2.47.3

