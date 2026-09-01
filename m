Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF51DC61DD3
	for <webhook@archiver.kernel.org>; Tue,  1 Sep 2026 12:01:52 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6407.1788264105198282783
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Sep 2026 05:01:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=tLmtdL8i;
 spf=pass (domain: siemens.com, ip: 52.101.72.41, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YS7dOdPSWTlwLKfhwh86RkJbpfEpxcc9lmfgK3HmqtEBSR339qy/NBqacAJhk7fSYmLQWO7BDQJtq8QWOb053bkxgW0U6c5UJiTl038fnARLhDI5tztR6Vkew1Ph+mAc2bM1YoIG+v/kUIW7LeLIiW8Pn/EYnfDr1/2InFcP0E+BuPaNExoFHRyaZW+LH2WBMO54GrlmJLjTKcllJRXLDfRu/ACgCY+eyEvmMXSe56AE153H+By3eoTbVS4Hk4lSGH0cyC5l8ubXVKsi7MX6A7VGSDSfrWgh6yjpnjCOqNQpTE8rnz74+UxU/lTDjCuy9sWtsXXXGJva/grYNhhO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BB0iFuvRgOXqpzE1femNk9tQW/C0DcfWtCHZzlxoDJc=;
 b=T3SaVyRK6MT2TQuO24WjaFIga4zbaN7CBNxi12SGP9Lh0LRbKfDjnkxpBeBX9j8NdN63loF8oI8J+nyaXaBaM9faQD0lXbppJPpYT6z0HKfmZ/N+U2+RFZEAcwlMDpbK5xdCcBs7taZjbCDeDNwaZJVh5w2BEslA8tmHFuJ7PHsHi6XifPQ7MU7yO0QYd2GAI41LfDaXCOYS/eS2mXceV0MiRsglMA1qlLOCiakL4ZSxCB9dtwf2IqJxoLIsSEavPyKBx0AXAbxnVC8kYJXvtsqElDYnyCZWrMdsXoxNqJc+1RhImSry0S5M6HAal2Pds1LGA0mB8f9A6BFN/GooLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BB0iFuvRgOXqpzE1femNk9tQW/C0DcfWtCHZzlxoDJc=;
 b=tLmtdL8iLtzU16WQqqqL8iBLYlWsWhBn2KiuvwviHixmPbiC98bk5xxMk/rONCBfuP1DoKa4V9eYq2IzInuxxcgx2sjkSubZKbGCscu8grcaANj5rL5m3zF9e8zh5ujBiwmJH/i9OG0/Uc+SB8FpblIbnxLe7SmRMH3mM/+HiA5+w25p2p4bXj7MtWkAokg47piZKR4IlJO/t7IikkgtHK5/sVoRjDhsIkEkLphdvJoqPFIySxC09XJ6mY8nMuM171GnEiady3fEt1hekXISB9mPfcMne4kYLCospcP/PPYY9bya6OjzsfzNKSHR56m5ALhU5zh8Ebsg2BoyORLLcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS1PR10MB5578.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:476::15)
 by VI0PR10MB8936.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:239::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 12:01:35 +0000
Received: from AS1PR10MB5578.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9a40:4964:767e:edc4]) by AS1PR10MB5578.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9a40:4964:767e:edc4%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 12:01:35 +0000
From: Michael Adler <michael.adler@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Michael Adler <michael.adler@siemens.com>
Subject: [isar-cip-core] ci: use kaniko to build lavacli container
Date: Tue,  1 Sep 2026 14:01:11 +0200
Message-ID: <20260901120111.174696-1-michael.adler@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::24)
 To AS1PR10MB5578.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:476::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR10MB5578:EE_|VI0PR10MB8936:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d69338-b793-4ca0-150b-08df0820c4e3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|56012099006|10067099003|11063799006|6133799003|3023799007|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	h0bRvjNzqFaBwrWv+p88WOs0jy1PhD/U5SghuVX3EN1RUBlzgWxhC1m1Z86EF5uLqXF9RzBtyabxWVss7iPd/wAymgQzczzU1GmrYlRvVWQZbT+nWfQrsJbdIHq4Zo3bpg01SprFiucQHSQOv9StZ1AB7gtTz8PGFNd16Avhci4hWrsoonat8we8oWyt6mNpQwLq8ACXkhPxBownOFq23Pf8Dh6zOn0H/3Yf/1IdH6pBlI+RXF+a7gIIPVuznthR87JTpBuZhaOqZobLccdgwYzS2pPs/i/5kDuG1HIiDRMpH60B4gpWnO+qGoTDgtB7AU7glPI4w2oeQHcZUE47S2jjaIY7khJq7lZeshPQian5h3BYnaPOK2tGMkU/0pq2ugc9ESwX8PoyrE3rhs97flD6nC2zUrHrcuIGUYSPfONy4F/rD/Kl9VyUKe9rykmq3C4AcvTzrxBEvPTQwDHoGppFpewE7d7+eAv8LscGFQVYSLlj/NeMNBtCavkbxKaTMAXH3CT5/5bRtEQVu8k5Vohyy41gFlTSyAkl+GskbujCC2OSkbNqtHGdz9BsqDPZAqbVB7HJ1vUbXs/wb4V9HB52pEmAkU4aGmG10LZ1xNG+HpWNRBAC1g/yFTuAOjT8
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5578.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(10067099003)(11063799006)(6133799003)(3023799007)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OT+mmSSYcXR2snCxRXaDT5e1fM4xrRsFHMYYVZGgW7Or1/fyjHg7dgXbztqm?=
 =?us-ascii?Q?/zz29XkJ43UTMztQ1ScwdfVyCoqFtVjRStatwIHO66mjvRpAALr0OjrMJ+c1?=
 =?us-ascii?Q?xkbkPf3rEV/E93QYO2WgJsA6Y8H+8mIml1UOjjN436raz0ZnRliajIh3fmBn?=
 =?us-ascii?Q?WLV+TNlBKTCUtNOwvOFhnHpk3djQy1P7m1amrtt7zpWcBfe6obbDMuxFzPiL?=
 =?us-ascii?Q?f8q9LZHGg2upJMOOnIzpga6e7Bs4rSEXQsTmdFWYgUMZnzhgSwYrtkM1QlEE?=
 =?us-ascii?Q?YfJUF0DVcKINfOxvwj/BYrDUBdqu6ytTxbDdnd/wagVoGdX1Ny9JkLvu6FAx?=
 =?us-ascii?Q?EZ27PAg/ookAfzdFsJ/+K+IQES5/1C9M37+E6qxj3AUYINoasXdBOASDdgnZ?=
 =?us-ascii?Q?dZErM3QRY4vOCvqHDGMk9JUKWCOUzH9fMwqQ7oGBQ8mAv4Xbs6bq9bY9zFs+?=
 =?us-ascii?Q?J38KbIcy2JZO7vdp2h/d7uGW6EXNEijMB7qMb3brVSq+qtL1sSYN6Dta0NaG?=
 =?us-ascii?Q?MjIr0M6uygvgiYiQq07t5aEDQQ8fdpqyM2ukyU8yjELzEZ0utr17NVeILE4Z?=
 =?us-ascii?Q?TKUbuH21KG5hq7DOcBqE0uIINEsgOiV5Ut1rXbJr3++0/GeOzb433MqBVQSb?=
 =?us-ascii?Q?Cw5GcSOb+wVVLsFyFDm4jH1s9KUqOoI748mdCk48dMgcRp04UXwM+nh10Tq3?=
 =?us-ascii?Q?w+CJHCqP51qfP+NBT5psrcUBW5RCwaNTpaUMVyYITYrv+a/0dE2qLfuc5PLK?=
 =?us-ascii?Q?/vSgpfT/eqoMb45qls5HiGMGGQJkhYzPkC7EO6BoUTNnZf5g5MSQ85iQkDHw?=
 =?us-ascii?Q?HXItbutTxN/9rKMeUr64vUlvRc1WW27eyeXcogdMk0mZwbt5FL37NdKerLnc?=
 =?us-ascii?Q?YxnRHglxlnnTtxKaFsWthIKf8Cj8mjD1re3GfBFOmFgVbTIymbMNHfGGOD6n?=
 =?us-ascii?Q?c7JEeM92EfXJOl1WW8GpVM5AzQm7hSzHWxQtXTBBoVYMwHmuGRbqrWjsQT6V?=
 =?us-ascii?Q?x7PsRW4P3BChqJaelgxJhMu0fCN9wO1t+25fyahw766J40n2XEQd9sfKLstd?=
 =?us-ascii?Q?6ToK6OPahGS5AkBBBah+Hx63fd2WTmpI171skru0+qXh7aQ6bpljO6IYTOIU?=
 =?us-ascii?Q?tWgnlz22XRgzsyluopJUeLAas1+2d99Rj/lHoxVHrm8OB74w5IZiJwi8DNEk?=
 =?us-ascii?Q?Mp0m9bFGYyaHo7/NzY5TltaxDnCV4IwneG686zrbgtWN7WjvEqUv56hZ7UPt?=
 =?us-ascii?Q?kRvRtpyU2dvNOVgMjCvCiKeb+N2WOanA1CexLhSTxJ6oIupWOe0ShiJiE0BQ?=
 =?us-ascii?Q?nMYfu82qWJ8emD+P2CGlaS86XWGyGWftEXKMrFqjE58QiqybI0X1b/huCPks?=
 =?us-ascii?Q?UaWy5fenI3X/Dt8meMyLmYvX+CDxVkIznQfTf5ys13LvufENXUS7Xx55A0Bz?=
 =?us-ascii?Q?6B/oulUiyB9kBcjbFzH5ECJw16crmBdZlb8DNcAz2FaHgS4w2JipfT06Fp9f?=
 =?us-ascii?Q?OgSgNfl/3MV+CmE6yoGJKyXWpkyr6BkxKckoD9Olvbw8VVHt3a9u3N0Fyb9T?=
 =?us-ascii?Q?QOQyJbr+RwNmXh8C+7LxMehi3oOc+SS7l+lNVjSZaLAGh6DRcCZrVyVAdQ8p?=
 =?us-ascii?Q?GU8OtqQE8I/xh0eE7SPalbCnGloRqKx8dnQbwL/8npeHQH7FCO7F48mTn9xb?=
 =?us-ascii?Q?ORSH/MARN5mky8eHkTp6RAL8YLCdkh8sQRwp/qgUGskJMr95/XsnBDkWt21K?=
 =?us-ascii?Q?cndTJWMz1Vcovj4w1K6o/E19tNJsc6I=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d69338-b793-4ca0-150b-08df0820c4e3
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5578.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 12:01:34.9213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BtQYq84GYMpKvmkdruLbAN1qdu1yp080ocBvL1b75u8GCiIK/v+WMxcWderkCNDwm90zPayCVpYQu40egOlBDPJcqru0BYC38WJ4i2G23s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8936
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Sep 2026 12:01:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24050

Avoid privileged image builds and run the job on cheaper small runners.
(note that large runners cannot override the Kaniko entrypoint required
 by kas-isar because of a GitLab limitation).

Signed-off-by: Michael Adler <michael.adler@siemens.com>
---
 .gitlab-ci.yml | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8dbe62d..75f88e0 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -934,13 +934,18 @@ include: '.reproducible-check-ci.yml'
=20
 lavacli-container:
   stage: build
-  image: quay.io/buildah/stable:v1.41.4
+  image:
+    name: ghcr.io/osscontainertools/kaniko:v1.28.4-debug
+    entrypoint: [""]
   tags:
-    - large-rootless
+    - small
   before_script:
-    - buildah login -u $CI_REGISTRY_USER --password $CI_REGISTRY_PASSWORD =
$CI_REGISTRY
+    - mkdir -p /kaniko/.docker
+    - umask 077; printf '{"auths":{"%s":{"username":"%s","password":"%s"}}=
}\n' "$CI_REGISTRY" "$CI_REGISTRY_USER" "$CI_REGISTRY_PASSWORD" > /kaniko/.=
docker/config.json
   script:
-    - buildah build -f scripts/Dockerfile.lavacli -t $CI_REGISTRY_IMAGE/la=
vacli .
-    - buildah push $CI_REGISTRY_IMAGE/lavacli
+    - /kaniko/executor
+      --context $CI_PROJECT_DIR/scripts
+      --dockerfile $CI_PROJECT_DIR/scripts/Dockerfile.lavacli
+      --destination $CI_REGISTRY_IMAGE/lavacli:latest
   rules:
     - if: '$CI_PIPELINE_SOURCE =3D=3D "schedule" && $LAVACLI_CONTAINER'
--=20
2.55.0


