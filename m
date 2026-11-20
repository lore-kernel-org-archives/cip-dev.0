Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2110.1795163166724666808
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Nov 2026 00:26:12 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Plp6yVi2;
 spf=pass (domain: siemens.com, ip: 52.101.83.48, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psKewZUcG8kY9lSkFXF3jw3qKBvtH8vpKtniL8Ov53JPBGQm08oa9/G5B4Cn219hrkZIocDJXzLZ/QO+4oLo1UmDD6HlZlg2HHOJDM9NojP5f0kVk6tSk/rbaAzPVD6GZlpBEnxXAWJ/IBlQ5+N2rSiHmP2WUc4fOH4/9tsDHKUecsSyXKKDLCwN80mQV3XK4QHwuNr5AmLfp6qMFpYz2+Pej0tuZzUGotWDMyQ6VAamu2jcCYaxT37RqNTTkkgL2SPGft2eUzkWl65f740p74P70x1S8J1Uk1UXhz554gs137TNkKWHcD/GZqv8lV+rz5jfApyq1g1PoLTEp2VVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBX2my4RBzmSJhyfy86WqmxwYtmfUMjC3KoWpidNcXE=;
 b=UUjb5x8usgkdpqL12h0kTO4Il0qU88ZzYeeSSVyLcLEyVqKcpseiyCDtVrzG1Kh98YdoZWgu1CPPtkgDPTpK3dtiAdy6f2z204sRqtTJ0jyw7Ttq+zQPqMes3aVUZOqyXiIF1aeXcerYYPvzW4LYp4RXIYFcN7y4vdRtXiy/tkn4Sin95TxQIxjzlqUJ9oWEYHw61ClTY6aqszev9NFbfRLPYGJJd+OKvJfc80BofCaotkAifKBGYZjIbuGNiot1T6dItulX5J9MF/uj+x7ItSprXakx+DxDiP6lAsZ4mNG6wOmrrLnCwmuxdpDr0Z3JV8Wk6A45CrtiQCtqo7JP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBX2my4RBzmSJhyfy86WqmxwYtmfUMjC3KoWpidNcXE=;
 b=Plp6yVi2laQfbSgYK2hsdhPvQLBZ0ZByjb866EBNV9OW09vmS25ELiN+qPW+Txq/1Zx5byNTD2iOY21XvuxmD6HHmQCKC+0lBmK8BOPLYn0OtF4hIhpUmDKuB29wT1seDtn+Nznmjn2qHwuTK0FDoPffQDGmgTo+K602O+nEnM90MIZPA2IbdBwdF3w+ec2jq51RmPgdpIa+4breUEtxJEEgw9/2hcQPm7HvzIkLKXTbwZgFehWeMP+dJR2CcQyOB8Kv2aFoqBYfxp+RA+tikO0ktdrVGWtuHWoFuB6y1sab4IoQrwQngKM1no49rZqUKe7EGuauNiuxKbFmRDzaNA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PR3PR10MB4077.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.2; Fri, 20 Nov
 2026 08:26:04 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0662.001; Fri, 20 Nov 2026
 08:26:04 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	chris.paterson2@renesas.com,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [isar-cip-core][RFC PATCH 5/8] ci: use a tagged lavacli image and allow manual builds
Date: Fri, 20 Nov 2026 09:25:51 +0100
Message-ID: <20261120082554.375548-6-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: c5d267ce-fa62-4ea1-4440-08df46dfeb14
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|11063799006|56012099006|261009223027099003|261022115727099003|261022075727099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hBX4y71jzVRnb1IxCU27gorQRzvuGvBECJB3ymACYMNpk+WiWMfGDKWHPqxGLzWlCgMXgNDFoRfo15KBB3CsFOv4dJUT8hLWTxxdER0GXuGHzJ9FPSuA6NXkNnNL5k5XGaSbC85qsju30s/hztgCiNqpVjpXBW1RWsWYp29x6ersoIEYuMrX9jL437vPiT7+p0Wn6t6ysVjWctBBZ/ljzBdUfpJNL7VY0FMrgu/ECxX4uxSaMS0Y2fl8PzURJLS89usUThjFA3PoWbw1QFvqqJiX9v/WdM7r8woqeoyQH5fVEuYEssVShqKmzjy5Zv6tv8q2nAoPxn2IwgL+JHgeKGve/gUm5srhRXZqaC6tCosMMAtJg32XeUs5demlYUi35woPKEHSa6K8L0zbWaXW/3egBf52SGj7nNR6V9iyPu+bqclxpG4dGSyPhFgBd+q0liNosgiA3JzZaHQArCwF130iZLf7mwgkhcSdXNhhvx71CWyMu9N+I/OkXXKphkyjpaiNsH5bZAd2SPkB+UKAewePrWfI7gQUNi8REzXLWJzGBzUSvyov8zox466IqpUm2FwMP8/Ac3QhEG9yfNx404r0LkIVtKBNziTnK4mvcG/zwpYvRIPWuEbDODmD5Armf0rM/fhX7dN6AWZ0oXntsOyDXs5bcGg2MTowKaO+z5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(261009223027099003)(261022115727099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5FikjmMiZQwa/RCZgLIMcgg+wig9NBjYXgbsVYV9y0fB6Qo0hgy/koClNV8n?=
 =?us-ascii?Q?Lo1Obox3ORIWQZ6huZy5uyEwLaxZI4S/FCMW10vjnNxOMVyCjzsUP7YGcmmq?=
 =?us-ascii?Q?lnB5rp5JXg3AMVhiEulevLGzuJ8ZEN29FtwvdpTgbZWYzTkv40AmoBmR64Tf?=
 =?us-ascii?Q?TK7CiX9yQY+u7BW7ShteGgBfDgwnH6h5QH1aserZVt7O0zEPVE4CB7CMmAeV?=
 =?us-ascii?Q?VtRr4ArMLP5rf96Ye6kd/lrHZQnYloPz6LhMcwZtRZmWYzcCEvvBvi5ZZa5l?=
 =?us-ascii?Q?+ZMbr/D3kn2V9i57PuwcGq/9z4+qrLDioVygZI80GTqL7AIdKD/pUP8tpzLd?=
 =?us-ascii?Q?ug0Gfs8aqF2ZasGcRG/baLEbES6qC8hv1MXrWYM719HRsbUXHoMKmYLsvooa?=
 =?us-ascii?Q?kxIMDNkCPW3skVDTa8iPR3NI6OZBMfxTXh+9c2TSvuQOibsZYMxepT1f2Nmm?=
 =?us-ascii?Q?ruB/A0GzJOTbkadI5pd8OaSS3AppWY5080urtB7cfx+2mbsA2C6Qj/PNrqPD?=
 =?us-ascii?Q?ysAoBXf4MaBjyVbulfwmOVXEj3H4SEjbnCiJPrXV9Xd+YhoMAqy1fKynWklF?=
 =?us-ascii?Q?XVf9FvA5ifZCUZeEHtGlcQYjsTlAcE7XzwSu36w03bHnoqR1yZNfoXGNZWZt?=
 =?us-ascii?Q?Y6dzGTCqjM32w3T/VY+4R8a+mVqfheABGIsLbGD7u7VxGq8iIEwfEWsu+fJR?=
 =?us-ascii?Q?nczXz23EaOnBdAx23pO2y6mqWHX1i4N1xKqQAtwAljQI3VqZj6XKEAcHw8uK?=
 =?us-ascii?Q?tDDb0VnZBWv2M9fwstwAEv1IohAAsJyi8otE4x6b34OKCm39fLpCo1l+exiS?=
 =?us-ascii?Q?zaPMVz8UOdSyHkHSvCHPf1jL2O9NSWTue3V0aLI+Nn1G1ahd9bSeVDqRRfwI?=
 =?us-ascii?Q?Q5dLNJg7cfGNUu9WUrR7oYaz5P1l/T7sztoaFPKc3ZL+rSmCjQC9oRAqFad/?=
 =?us-ascii?Q?085Ppp6cRJxSyQGnLOFgbSkzInQVzEMrs86yZxDlqT2hc5PFMgh8UnNFUZqN?=
 =?us-ascii?Q?Gbyur9Mgvl56HDILpti5jiNXFkUTuJqmlpKzgg07dhUhH6VNgWQvbnRJeKKc?=
 =?us-ascii?Q?IupnahvekJ8LCoLVogYVqIDbRX1N7XqehlE+tFiYkf9P2GELf2SspjeHnzu2?=
 =?us-ascii?Q?RyjcQ1rlV5KYx3l4alMmgdzD9IlzXbEyzyqqZlKZlHoLaIPJRlLSxjl6Vcgc?=
 =?us-ascii?Q?ZylV/qxMfg6k67HW2Ct9exR1mBJtNwaN07JJquG2NyR8Ssi2DLfswgtz0Vvx?=
 =?us-ascii?Q?atexgJ3o2dhNzluZgS5KeS0ywprFITRnmFYoBZZziMvmapZtJFOjEyOOgyJ5?=
 =?us-ascii?Q?xrYOHpd5zRvszBERzVFNh4X5coLFYAJUVy3MrNE+sI+9FXb3GftSRMoWKit3?=
 =?us-ascii?Q?8FWIJKjkSzicl8m6XW3h6Q4Zn39I/5Lc4155mMQSuos33K+u3hqf451eRzvg?=
 =?us-ascii?Q?RGu1YIi3HrjqVCqW4wI6DR04bgQ/drt3/jyw7tfJMky24ucY4davmJFdEDsl?=
 =?us-ascii?Q?TYjXRLu8gi5uStFBNIqfs7VjHhBjYSAqUYn+EGlq2bhHIxOH5NImYysLOLAP?=
 =?us-ascii?Q?vILNmaao/+Gl8VZDxUyVCknI2BWskHepqePUgva0s2eEoSwjn5leqIBOuccq?=
 =?us-ascii?Q?wI7DMPnL4PJKhKf4QpflZv0iyvl12uIbTepEtcfpS721TFR9jAezAGo6m5cY?=
 =?us-ascii?Q?850GHPBdol2h1A/g6qKViYZVQ+RyHO9nc25aUQQz2DAYZbyyg7psWwubn12R?=
 =?us-ascii?Q?fT3u1uvf/LoI7qHuNEWSrsoL3odeE2o=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d267ce-fa62-4ea1-4440-08df46dfeb14
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:26:04.6668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avJ96zQ9CfVSBzEpirlYQlsGBTyc+3ce7m3ZxoYbdI6kGzeuOq+SQhDmCPMAlYhhpQ43vHPx2iYavdE4bD6peyiHIYsFmNkp/aWih5jlL80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4077
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 20 Nov 2026 08:26:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25034
Content-Type: text/plain; charset="utf-8"

Build and use the lavacli image under a configurable tag
(LAVACLI_TAG, default "latest"), so a branch that changes the image
can publish and test it under its own tag without replacing the shared
"latest" image used by other branches.

Also build the image from a web pipeline when LAVACLI_CONTAINER is
set, not only from a schedule.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index bf21e744..afbef661 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -27,6 +27,8 @@ variables:
   separate_home_partition: disable
   factory_reset: disable
   no_kernel: disable
+  # Tag of the lavacli container image used by the LAVA test jobs
+  LAVACLI_TAG: latest
=20
 stages:
   - build
@@ -469,7 +471,7 @@ build:qemu-arm-base-forky:
=20
 .test-cip-core:
   stage: test
-  image: $CI_REGISTRY_IMAGE/lavacli
+  image: $CI_REGISTRY_IMAGE/lavacli:$LAVACLI_TAG
   rules:
     - if: $CI_COMMIT_TAG
       when: never
@@ -957,7 +959,9 @@ lavacli-container:
   before_script:
     - echo $CI_REGISTRY_PASSWORD | buildah login -u $CI_REGISTRY_USER --pa=
ssword-stdin $CI_REGISTRY
   script:
-    - buildah build -f scripts/Dockerfile.lavacli -t $CI_REGISTRY_IMAGE/la=
vacli .
-    - buildah push $CI_REGISTRY_IMAGE/lavacli
+    - buildah build -f scripts/Dockerfile.lavacli -t $CI_REGISTRY_IMAGE/la=
vacli:$LAVACLI_TAG .
+    - buildah push $CI_REGISTRY_IMAGE/lavacli:$LAVACLI_TAG
   rules:
     - if: '$CI_PIPELINE_SOURCE =3D=3D "schedule" && $LAVACLI_CONTAINER'
+    # Manual build: Run pipeline in the web UI with LAVACLI_CONTAINER set
+    - if: '$CI_PIPELINE_SOURCE =3D=3D "web" && $LAVACLI_CONTAINER'
--=20
2.47.3

