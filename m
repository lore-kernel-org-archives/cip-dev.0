Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.66])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1971.1795163170332787988
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Nov 2026 00:26:10 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=CU0h6/M/;
 spf=pass (domain: siemens.com, ip: 52.101.65.66, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKtkdvVoyoT0+9bNH5fL/EnACjyGFIfrupjd+arCZ3+S/UnlL2JEqvjdRxNpFe+3zoFzk1Cnz8WVO63VgXoQq6w/jnUWC6o0nmLzlB5l8oV0nBh8GEekyFJzdtiOpSBbJTa75oEIH+3aM7oU//vygTXUL3KamA2Ue26HBN0gDRk7BUMFzs626Ta828CDbR2XZyi5e2WkMFs8QU4daVskCrMc9dNHq/+1VhWluSdSMMEs1KumH0fcabv9YkrMmEa3E474lVfdGDXi2UpLmlqLpu8DWA7+8TsI4f/i3Am5ZwbLnA5hgbUVYZcJ3Sh29iiON/h8y6r/kmosthmnHYCsSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDaLLZCAzihSryia27HGBNx1JNXxbOfsIcXK4zr7ij4=;
 b=HJyRIeB2gt88gccXQAAiDegMk/foDBkfz4Q3UCFQ5wBknkMxPPN6otnAWc2gUoZwhw3ShFx63qoaOk0++aX5yoytJkl5MQxUHkaij5U/FlWuMID4y1yMypy9MrZOiEk+birveXnz7pZ/ByLIbwKEU9RxE/1IWNJAN2JtvwiA9hgV4UIDaBPemqS5/3xe0KzrBHoahip90t41aNSvAhaXQWY3wP12qZVk4hgIamEoGr9vngBNU+wK9wbjxbXur5/w/SQut6DuXTRi1070iryX/9cpqYmh8N6KhLMIq0EFKcCTwvxoCQ1TTryHSiajJG0KtBtw2XFVy6vuPos+pZ9YgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDaLLZCAzihSryia27HGBNx1JNXxbOfsIcXK4zr7ij4=;
 b=CU0h6/M/18lu7XjJJFlJ6RGVU3CvbEmwNewOr/w1NB//ZU5zL2iD2bGKhgbDCgeBXF0rTIEXjVwxrSoF9m1qL7kvie2pet1GwvDj2YSA7hA6tjNkYFzQZnx6WBffhi1vcNgK3bskfLQ3NZKmVKyzSF3jFu9ETycZ/axCv7jTb2Yv1l0JfYQDLQXWF8zJKrX/gKNZMF+XVBeVAbVkrHZu/iFxccuEjzGs5x0FKzzhcR+yZHZw2+W4Yi4ksalUA907Cvmo/CyB2jCeife4Rd6ulVhismahf/uZrpeJKPCak+39P5PIhccIq1rGo9f8bBeZq2oYUAp9ldAZK1bic5GBCQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA4PR10MB5705.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Fri, 20 Nov
 2026 08:26:06 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0662.001; Fri, 20 Nov 2026
 08:26:06 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	chris.paterson2@renesas.com,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [isar-cip-core][RFC PATCH 8/8] ci: run the LAVA job generator unit tests
Date: Fri, 20 Nov 2026 09:25:54 +0100
Message-ID: <20261120082554.375548-9-quirin.gylstorff@siemens.com>
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
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA4PR10MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a26b11d-ba3a-4c25-363b-08df46dfec2b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|261028144727099003|10067099003|11063799006|56012099006|261102123227099003|261009223027099003|261022105027099003|261022115727099003|261022075727099003|261021121427099003|261026140227099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: M96mBAwSttPA9ASknXqrsA+EA6mrwwvlypOHwM0yaL/M2kIVG5XlfyNwKCzsSnkvnW1BLSlz+g+WHc7Di1OzVHdzxDaYSCbQAAy1KaFEAFj2zV7xOcexo1kcYWngkdTMiMuYrru8+EkZ7HAV1T4AaTAj4IZqvt8Sn7+GLIv91qsC7fhVhU2N4jK5T/GjN1P51ri+9/q876lHLeQbgSN60P7nOLCPyPs3fhZ0fPi2Y7SiqJ34aGdY87jImsDC37EpxxIbGvKjk8XcQvQk06kAG5IfVw5pJVhonaxXTM76vx9qaGMrtd6HqT6mWZXpOK+V8JB+2KBWvsKlDvrR69US72GbssPR0waU4AwiQKDszgk1Ikd6cvZJMSwVJognlkdUDI1JG4SlpV0euTraZnZos/XiB+EXNebILbu+G9hnz03o4dB7ltxc8xt+bfTMojKGGk6zZuC1TcQ4l9pO/fnMfD8c9chX4X06FqFdX5qmKzZ1fKObeU5qVncTgRLFt+gT2aY26qrv6txPPjRW/eltYIc+ByAT8HNyZdACCJUbUwgndtD8lAahuZZSpv++edKvF2309ki61IYxsAS/iBxPBN73qxNGrumF+iXZasDQ63sK3fl0cFyj9YNyn1xfRWsFwU1x7hh8WSXGYaFJR9aHlN3HtkJ7NBNtdHpgYKO/ucU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261028144727099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261009223027099003)(261022105027099003)(261022115727099003)(261022075727099003)(261021121427099003)(261026140227099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qNm1plbt+9mD/hYU5l7ERHmfr5fEU1wOoc8Cv9Lf2AqcRY0+llEv/7HrGqXa?=
 =?us-ascii?Q?hPCH1vBsKkKlkZvv3lgNAkGNyYX8uIf4XpCmOAbfYpfySx3V/E8jXe7tMoqp?=
 =?us-ascii?Q?cTYEBQVseQTfAwEM9/0hJZXZAA8Lc/nJP0ZBXmImUH4pgcVDClglmLaogeqa?=
 =?us-ascii?Q?wj/78+4SWsP3o2LFtMBndJmTz/TK6MYeLdnOZ1hc9eeDyV+DQbpXeIKX9Y11?=
 =?us-ascii?Q?oBYxAjsBLpLAtBWlkeotTCM63xlx0YqvvpjUGzQP0DfR0eBvbWojJnEed6XM?=
 =?us-ascii?Q?9IGI2olfTDYBpUo+8ZkrpCaofndlox8qxhTS2u6w/CTARBbUzpuwu+eHN6uL?=
 =?us-ascii?Q?ZQiEKDjy1R1UMt/+RpmATgTqD0phfUH/qNqmml+gdxP4LeyaMJ+KYxF2dva0?=
 =?us-ascii?Q?ifG4CmIARGfkxUkTUJgVnhS2o/b2klEJshV3sr4Ve9q417Q5z2J7KPcc+8bE?=
 =?us-ascii?Q?r3w05RHousT4Qhb3MAVZDQHWjqO/wOz+FgMN/vCiVgYOZ5vgkRYcgr0Llcp4?=
 =?us-ascii?Q?r1jkGcL4hfZatDSBtVIag0PbY0zx05i/1hBS8Cznz78yX7ivOy4eXobGfE0x?=
 =?us-ascii?Q?0AGz65bC83w1sKO0B7HtKrhdfjmK0vyEfZb97v+RY0o4yCptM8bT05O3q1JY?=
 =?us-ascii?Q?LSi74vQLMq2toQ52axEgPwmxUmgHXS6Zx7Yr2Ij2Gl3jkR+s5XEwi914tHFk?=
 =?us-ascii?Q?WNqJsO74lqRJhJe4EGLOV9sNQCYJ8x7lhNSMhgMZgIjui18HMIDTu22etB0D?=
 =?us-ascii?Q?lQ/YU59mu76KLCQ/IL/KL/p1fP3equnzLUgKiwGG4QcTyNTZL5X6nLL8pfuW?=
 =?us-ascii?Q?AZEF9me76Vm2TbWV2zNx/TbsGZAXUJrmO4m0AArxEMXceyFbcTXIEdzmlWTc?=
 =?us-ascii?Q?3TxtoJNBUZ+UNICCd7v4UtefqC3cHj9rvcoeLI7Gsh2AH4xB67Ly9sOWhJyC?=
 =?us-ascii?Q?QkjMzIAGOwK1mJ5C4VCTDrrTYNnpLUFXRe/9HcbFnm71b3CnvXy7V5b1BN23?=
 =?us-ascii?Q?XS2I0v3yC1ADp6nF3z8KpubLjQYvabzvKLcueFoYpHMJA4I4nKbb7022zQd0?=
 =?us-ascii?Q?3JXxNgWG19wfGjEzxAoW6sVKCi9pBqWB5S1MPGjyd5xxpERMuC1mfd+KcAyB?=
 =?us-ascii?Q?8YAU45t+wbIWfiZQcn70Z70qwqysgn+OabVtfxQHf1mZjbYR7yPBWQuTIxLL?=
 =?us-ascii?Q?v7vwd8zxokGs6Wjti8dUoN6qOixbW5oWzmzO/7/HDMQmTsNvZEFYONV8rUXY?=
 =?us-ascii?Q?ulkV6ucyTm18N/i1e5TBm51gSorj1Zi7lKrYWrFJl2ZXmcVvjq5qchkhL+/K?=
 =?us-ascii?Q?CN9w/cx/T/gX6Nv6m2anckWOHLTl+g8mPEH/iXb+HqbUdF+us3J8DRwzJCQ0?=
 =?us-ascii?Q?xrNzEidQWAYFoSskApXO75pjRsKf9CwOyyX3MuXjH22SNYl8QIQhZ4phyDCw?=
 =?us-ascii?Q?Ch65t7Gte3lOzxlTflakdvLZZSqg6aXgToLEIjm5apM4w+SG8N7NrtgM56jo?=
 =?us-ascii?Q?kUIJ8riqHnfRErvdxXl0pbm0rXz4fbu76opNuzClbh37kA5YvS08e26/70IW?=
 =?us-ascii?Q?wH99CUHswbbfN2r7bT72VdMUtfveWxlu5iiLEUwtAsSl3eco4aEOOWlN74eQ?=
 =?us-ascii?Q?bxl68dXcCAr5PgWVTOx0VTAWlRzUiPtRpaUBmL+LDTv0xEfhpm3HnEeiUtjD?=
 =?us-ascii?Q?8TPGq7nrPrsv15XPNM1LPH+7VvJ54ycpMQ25rdEII8BW8HEwMOeBRrh8Z9gA?=
 =?us-ascii?Q?DuQjsa72fLyyODhZaz96uadEij2mELo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a26b11d-ba3a-4c25-363b-08df46dfec2b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:26:06.5266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n01fLad71J48V59ZtnX3LS3ELxFSVWNytoODU5OAcsJEVbmFfmVSRpZrM7fkzltzL3S2mMUuUefYzC+MXtMsUQvAlvyH/R72Q0F8w7+RnNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5705
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 20 Nov 2026 08:26:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25031
Content-Type: text/plain; charset="utf-8"

Run the unit tests of scripts/lava_jobs.py in every pipeline, so a
change to the templates or the generator fails before the images are
built and the LAVA jobs are submitted.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 1878021e..a4177118 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -968,6 +968,21 @@ cve-checks:
     paths:
       - cve-reports
=20
+lava-job-generator-tests:
+  stage: build
+  needs: []
+  image: debian:trixie
+  script:
+    - apt-get update && DEBIAN_FRONTEND=3Dnoninteractive apt-get install -=
y --no-install-recommends python3 python3-yaml
+    - python3 -m unittest discover -s tests
+  rules:
+    # Only build the lavacli container, see lavacli-container
+    - if: $LAVACLI_CONTAINER
+      when: never
+    - if: $CI_COMMIT_TAG
+      when: never
+    - when: on_success
+
 include: '.reproducible-check-ci.yml'
=20
 lavacli-container:
--=20
2.47.3

