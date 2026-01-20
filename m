Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D5FD2ECF7
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 09:10:03 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2581.1768900200987471181
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Jan 2026 01:10:01 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=RNSX8YR/;
 spf=pass (domain: siemens.com, ip: 52.101.84.1, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNgJFBYfn+Q3FKIWECNp+7F4M7kVPQs7gFhkb9RisG32eG/BSaQNqoCiazp+2cC53nq81pEIbdSS1QhU37dbF+jgPxrtKjdQuVMOn4Lc+3xxu7X76DuHEXDuCpdHYWiyVnwy3QiKqcYMD9kmXKOweeKox0GXb6/B5wGLFadgv9vI/cTU0oMCzcDgjXha5HCeSiCrVTsVn9jJNYguqKCt4w0yypn1AN3Adn1vUVmvuA1HIfsWMRgSkFfoz4bj8Nix9nYxpqGYwPPH/PKBA2D/cSZsOTSmpHQdaD7EG4AOC0faLKuS1bB853LnkArRlTRa9rq/YQ/+/oV81CKs9g6Dhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPymQL/dCav0GjwBL+X4cDo+2UTENFESPlplrNilPlg=;
 b=tZ0yNN+t30hOsg+yychDBRqKll3iCpu3NeGFTaviK73qtr6oxdvdWeRi3Eu+EgG6HYCK7Hw/uE5LT9z2AqD5Oc3Xu8e3hRaTSFApXffZh4fKZ2Y5ehWmUERUodjRP+JnnFUfZ8o44yUVchVx904ehAUOh1uBTbGfTiLwC5TjfjZSKyxt6bOyAhIFB+kZfk7h2WZh4CFirvBcA6eWLFqBI9NgBBazpUKSR8T8qFPUQmvOkX/auaVqhidjF9OPCudexc4V8oUGKaUSJDGVBfurKcjcaLwzIvR+CXzANUNbnS+uszX5xTE+LasooOmOqiyS/IZTKlmbO1UgojGgnQsDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPymQL/dCav0GjwBL+X4cDo+2UTENFESPlplrNilPlg=;
 b=RNSX8YR/SpyoDDC/LRx5Wo7wC2ch2DjpeAHgMSW1qhEb33462MTnjJ8D9uHAzRZOIwftf8Fj9sAX6DhcB7TL35uLLkIK0Qdfe/pxBiAfRtiBiYSX/C+rOWdmNV0ezx2ZVfFqf4/k13wwZUzfS9T44NJ7b8nUWyzU5KoQ75Zt42+InAAyvZxFUeFIsyZ3vm9itk9KaDALQXKVqM7Sqn3yEQqz0jGLsnQzanHDeaIhZtI+UlvKxO4SOrnvMYKEe0nfP7BBcoX4WnqCp955tFOjnb/PQzZyNowzBYMhNhiz3maSF6gczBdP+gQPQO2CZbwrbpHkzulqt0JsdwEjEwBYKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by GV2PR10MB9824.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 09:09:57 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9412:cd7f:3f72:92ab]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9412:cd7f:3f72:92ab%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 09:09:57 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Felix Moessbauer <felix.moessbauer@siemens.com>,
	Adithya.Balakumar@toshiba-tsip.com,
	jan.kiszka@siemens.com,
	michael.adler@siemens.com
Subject: [isar-cip-core][PATCH 1/1] fix(swupdate): register vardep to DELTA_ZCK_URL
Date: Tue, 20 Jan 2026 10:09:44 +0100
Message-ID: <20260120090944.1461382-1-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: CH2PR05CA0020.namprd05.prod.outlook.com (2603:10b6:610::33)
 To DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB6828:EE_|GV2PR10MB9824:EE_
X-MS-Office365-Filtering-Correlation-Id: d15ebe1d-e94f-46ea-4922-08de5803aec4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ldmcUOm3dbwVGSNaepKiVLb6rHL9D1YljJUPo14zqQpX2v5ESLREa76+/wnB?=
 =?us-ascii?Q?TDh2OEpDxJOoUP5h+Zx2ciT1zjt86xvAtUkd2iQjV+IzE3Z6LO9JIm8DOsRY?=
 =?us-ascii?Q?4DSh7DgThEMCyiBfP0lT0Eaq+JOOtu8+nkur4KnMu7NYAyzMxFzQHyhHBzN6?=
 =?us-ascii?Q?oEVeY9HabY2YD9kHSRlyllXkkW0unfBiC+jSxRztBYRayjUMvKez/yNIOqsP?=
 =?us-ascii?Q?+EgA5JpAE9K6IpTpuWFWutIvQ7ecS/xP+H90fSuyZU2lpwg+FYj8LUgmrENm?=
 =?us-ascii?Q?TOupZZEJMZCFV89hp7BNZCwunD9qdrB7ReoXT5+ogvWuha1v38Uto0rBY8oQ?=
 =?us-ascii?Q?+XF5a+cTq/07XCqucTm03QqhYt4Bh9VBObpFTg3/YAtc8ffGBnbFueHzjQO/?=
 =?us-ascii?Q?NX9tWQkK5g/itpUcYvldOYsRGVTdU+RrLBWeuEEMqPr/Ge+U4FYMr7g/Z0ZB?=
 =?us-ascii?Q?pk25vSqVPenS7qEtnUMD2EcxAXsBqqdAQ3TiDqfoLmkACZciicwJGYKdWu3n?=
 =?us-ascii?Q?WC3EZQjfu0MQVT4hasKodLhEjobo87KYzKCnNYvu5RIszln8S+ynswVENtQK?=
 =?us-ascii?Q?D4z9+4ZQ2IAxFmFBbemKpFsATKfgnCbFnaUpS2QPPhAMT8uzV2Coc/4ut8TM?=
 =?us-ascii?Q?2dWf9reNpaW3JoWEmq0Pnnb5liS2dao4FHHGZkPn0mDY8ruRoMcWi79aPuU5?=
 =?us-ascii?Q?F3MOSuJm5PwwXBwcMSlT168yR3hODORqpCtyMJale2TkrP6S3m7iSpqVqU8+?=
 =?us-ascii?Q?lwNL+mjPiPVTQsecxSmjvawgn+eMKrrVPQ/zhpgWRxmxAp4tRUnq4sXn7hhH?=
 =?us-ascii?Q?J5JrBN3OzVio92l96lzc02xir8MMEOWWOq046qFsgUSsCjev3d0ce+tdl3VN?=
 =?us-ascii?Q?gAXx5CDJj+hbCGwwYNZDJguiuogSF06OZ2dotkWyzwocjmq1VioS7DbTOic0?=
 =?us-ascii?Q?XDXpjbLg/phmkWk1qm4H3bM+aeNxGTUmrkFuOHKaOfRXjUs+ry37Hj/FwaEn?=
 =?us-ascii?Q?LILc94Q1vlwtD1SfDpDeKYnYcrcW8NdBfFema3dlz+l+PuzyNhW+8WT7G8cH?=
 =?us-ascii?Q?Dx3jTmgxzM0U6aHRMNoTLjOTaydc0KEEboM8xB685z5AgRrjgNLtyy3x3K+F?=
 =?us-ascii?Q?u/S2VdAlO0OGALsg8VYgMtGx8NQdoaU7dsxGvZIdgrLBHt7u9nbbyItHYsQF?=
 =?us-ascii?Q?KoU4fUSHRZQCCIgbviyLcTQ3Z5/jtZQtSu5ONN3Io884Jt++InQ36Iq7Jk6k?=
 =?us-ascii?Q?7xsatLaAY/0O8pWi0DrKeXNLviFpLeZey2UmZlGsI131H74xvnwK66G7VpxY?=
 =?us-ascii?Q?kF0bst1e3DFiY4zTptWznyBTOVr8C3dKWdFo2N9RfPyw9SxK/1Xy3+zgIA9j?=
 =?us-ascii?Q?A3eB9hMN2lX0eiUB/6kURCcHSyQMqqi2p/w48c/bfA0aUMkfw/61SADsPwpH?=
 =?us-ascii?Q?HIk4UajVHCyqCxK7sIIhIwPAo6sEBEqRuouC1+KBdf7leIjlt0gdUl78KudN?=
 =?us-ascii?Q?Pkcc/CsGRqXLE4GTqjrqMJo/I0ISDJH055G/84tXb86Hb6at73Aumsf6PuQV?=
 =?us-ascii?Q?lZJo6G49bF/77iH6E9s=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xowNUtywIgfvvl7VK2PoWkjki9okoEOJzLje6spZXJmtLGXyE0iiGa5K7g5B?=
 =?us-ascii?Q?zIkeZ4aVnvbnAFPks09+yE6Uz33YNUX8ZPFi/HohZwOhbIUe35Q601kGdU4i?=
 =?us-ascii?Q?y0JLPUBhBEUwgdF66+1ArxJACjHZQtXRliwvLivBDMPzS9Lls2yHf6wLCIfZ?=
 =?us-ascii?Q?H/CrbVF8F3RzzxTNFb7zqXCTfSINjxbjZIJMULaZnRrQttoCpUsxQtYPgY41?=
 =?us-ascii?Q?M0l/ezTidnx3flZc0FzRORsQ8M67MLMT3TB9pWM8dPxMKgP4n3JiRr9kX/9T?=
 =?us-ascii?Q?a/CE/XchTUhyrymEL1pgJWAlx36TRlQGA3a7y67kLEXjQfvnOb8oAc5G5OvL?=
 =?us-ascii?Q?ctwn9/b189epH0MWZBBC3fHqWnBf1HqrLScMci1ZgREfIENqKAsMeeClfWqv?=
 =?us-ascii?Q?yP35WWQg3n7jjbLfikqk7ggQcboZsZ8MFWS/Z3IarnfNZ0S7eMjPHRPhg4WH?=
 =?us-ascii?Q?4XcVp9qzhHn3aCWkYaduHdcznVA0jwrI/EtdcyWer4vBPAq0ymtsIi9zmsBn?=
 =?us-ascii?Q?eh+Bn/zJTs4wCKrKmisnJx7vqq/gfwON7e/o92Lu81i7OeJHJZz4JTdBYaQi?=
 =?us-ascii?Q?j0d+C/3+dJuBo6rA8J7+Xm+ZK/WEBnJ3LW8jUfBahNrcu3RHfa+icMjXW3yH?=
 =?us-ascii?Q?HceYHi0SL4aWvdPu4AmbT+PbLdZNF9ic/FE5l0vfmrMOyjeadsUxfwLjEqtt?=
 =?us-ascii?Q?A5YaK0WvuzLsLgh2wO/fXjI3ua5zZ+wj3LqibQkNxWlueCneSadVf+MYvu0O?=
 =?us-ascii?Q?4ExT4Fto+sO91vn7WikJjW+uHBTjUCWDLLm8QHG6kFhS4drwxjGbXJYTgCW3?=
 =?us-ascii?Q?l9K79jh2he4jDk68gcRh594DkqlPQFvDu3QR6YQZVwKOPhrjTniBAkHfBfLP?=
 =?us-ascii?Q?okqpZF708OQPVXPRZFPx+vM1aPBszNMvMeKjLpq7rZ4mtghHBllYMXDCM84K?=
 =?us-ascii?Q?szK6ir+LCh0G52UiVAT81dGoaXMiVzsSUE2ARt10vgFwEiWdVl2IuEiI7aFo?=
 =?us-ascii?Q?OwZFNJy2OjbidfhWsup3qkJGpcmd3E8A5Q1rRqWVKu5grPTO896Gk2ulUP0e?=
 =?us-ascii?Q?PdsLnKQs1BxVBV9KFttfWkc3BOUsU+UAw9GKdBvG2GSvqir2gXFWXVlpgU8p?=
 =?us-ascii?Q?bp0FY5HGhFTtXCh7fGmEYfLHPqbtSLaAt1EONxp4HvqWMA47cUhnies4bFqm?=
 =?us-ascii?Q?iYFJC7E0TMFyqD3Sgnlro4lLNUNDNy3nku3ELNNi3Ed9isx51yYo+mbkMpEl?=
 =?us-ascii?Q?r7w1qYW+WdzqeEL2Vvi9Z0uPhdO6ROqxOwKaWcteBVIiSs9DRfLPQR/XsWIY?=
 =?us-ascii?Q?tMeEIESqk9nglnjuGg/tRDkUa+jjizbSAYluyRKHYVe6eRt9zOaiIrw6glZv?=
 =?us-ascii?Q?5YYSc0hmcU/ExOXfHpCIftFw7OezpqbpeBj5vFTPiz0ZqljmJ7i4CmhXUL7m?=
 =?us-ascii?Q?kXXP6S1gQugdBii+pis04TmcKHlpCYkXMGC+zupUESz/Zkxaubb2Wyme7ovD?=
 =?us-ascii?Q?RBZcRfwzDJ28GhB5JR95PhmNGE0By+nlNAfaF4RbYjGuEf0U932IYxIjQrHn?=
 =?us-ascii?Q?UAvz7n8I+n0gdw5mOJ3PKDdgRHu4+D/KN3vjYki5xUN7xDDHH4MY1xzgfDHq?=
 =?us-ascii?Q?CD7KBjuuNVSzXZ3VlAK6cUjuhNv5X2mFqNQUc1C1lw8DyxDs6jO7iJs8W+DQ?=
 =?us-ascii?Q?v55AHit+v4/8NaU6ztIM2rtxyZ40cr5uqQQSdShhf27JCrwAsvrHm/0hfQlV?=
 =?us-ascii?Q?ngiZQL0LyAqQtx5n+QJdrip2hhhJcpY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15ebe1d-e94f-46ea-4922-08de5803aec4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 09:09:57.6687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RVIIyH9QogscrsBe3MIVUwMXnmvBVlto9ylfSlRFnWAuIaga5UrGPauCgqV+WtWQJ1rvclCAsAPQGDpI6F45x+qw+GlG5RD6NTHOJ7JZX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9824
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Jan 2026 09:10:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21685

Changes in the DELTA_ZCK_URL were previously not detected, as this
variable is evaluated in a python function. By explicitly registering
the vardep, we ensure changes are detected.

Fixes: 599d36b ("swupdate.bbclass: Generate swu for delta updates")
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes-recipe/swupdate.bbclass | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/classes-recipe/swupdate.bbclass b/classes-recipe/swupdate.bbcl=
ass
index 21d881d..59dab9f 100644
--- a/classes-recipe/swupdate.bbclass
+++ b/classes-recipe/swupdate.bbclass
@@ -80,7 +80,10 @@ IMAGE_TEMPLATE_VARS:swu =3D " \
 # TARGET_IMAGE_UUID needs to be generated before completing the template
 addtask transform_template after do_generate_image_uuid
=20
-do_extend_sw_description[vardeps] +=3D "SWU_HW_COMPAT"
+do_extend_sw_description[vardeps] +=3D " \
+    SWU_HW_COMPAT \
+    DELTA_ZCK_URL \
+"
 python do_extend_sw_description() {
     cmds =3D d.getVar("SWU_EXTEND_SW_DESCRIPTION")
     if cmds is None or not cmds.strip():
--=20
2.51.0


