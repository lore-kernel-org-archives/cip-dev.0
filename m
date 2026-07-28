Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E782FC54F52
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 13:13:00 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11067.1785244370667933537
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2026 06:12:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=FidSwddV;
 spf=pass (domain: siemens.com, ip: 40.107.130.47, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9hxDVD7V9+aT/Dm1cqX+bXhKw3sUPPIesTtF5Wy+FlNMLcu/lkYIgbjHQ4/BYe3Bv7M/5yGyiaALCSnXc5Vf7r7kVSvKv8JY7qV7O5NOtuNgt+mcgGHCBo18obTS3DuITSB+rWo/ffvFxpV5win2NhcTfxfWxfLUWmwzHDg3fyo9yvWgEEaz4+qv/Ef+LjemjZNf+DSdQKpwgiQ0vn7vrC6yweXzL8U7+anU8aOjfVuKbioEJAGkoVLBJYpzbyiO/8Z4EwMcD9LndGTA7FFnNZbwpM3IxsV+6ZXmwsOr6yvriYqwQsvuT0abB79TOkA5VCaVxuCAzae6PsOyuWXLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3cg1XeV0nqu9lFXOKavV+5BJE2ZAhs3wu0qcZPo1Kc=;
 b=oAvuIvb8BPeP7tsQB1GKBp2r2AOu5MI5NE/W5TE59DWlBqsZRfNARJvhJr3XgMPAvf3FfXqJ875lrSPv1evqonYDz28kBqKatI5MPEvc4sVtgekZdGR3mn9u64X1g0vn30vxsFXrMaKRYozRkWTZnHmqIKO0rcNm/fazJIgCYJDczS/uwVd+F9Fs9sA6sICaS6XfWq2Zv7NaVO2Bu1dGvCkOQ4u8C0kAwXXSErILwJqVz++rhOP0b0YwPZuVvsvJkkVeA4fA3kxk8okHPLRSKMMm9XVyuVmhH1XDb0+P0SpzU9nWd3+MywgyV3UrQsqu2LhFiPB8gSJXZVbKv0cNwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3cg1XeV0nqu9lFXOKavV+5BJE2ZAhs3wu0qcZPo1Kc=;
 b=FidSwddVhB7kThjDHowosdu+T0CdZG2oOgKUB5YsvUj4RYEgHZLPoPvZnEZ9o/Hi6XDOxAEBNbB/Z4IgnQ0BtZCBqPselHe3r4C5pmSHfZllCVd0gSl4O6OvabUS97nbsTubf6y4F6yURmAhov/gPfO5Vp6KowQoEQitkRrK45yZuwUxr6TtQdibKcFYEEqCbufH5DRM4v+p39IWUasooAieEByvm3e7kTye7dAsNDRCKSpoeBeDhb1jO6hQjjf0Rt1FuMApfCL6h1oBFmWztZcI0mLWdZ5cDkHr/XRvTMVKrIeCpYgvCaDPQwIuasUaz5KSl1slQuBd/D+0oKcMIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DU0PR10MB6083.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 13:12:46 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 13:12:46 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 0/5] switch to rootless build
Date: Tue, 28 Jul 2026 15:12:14 +0200
Message-ID: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::9) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DU0PR10MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3dcf7b-f67e-473f-7818-08deeca9eacd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|56012099006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	OR5u/xvVzNoBAT2O0GotSu0I3TpNKNMORElCHrLVaupxR6hN92htClkO8wL7X9KRwAKdnd41sckYxmbrl1wKUeFAL/Le+047L4Uton+MiuoUhmmySIz3+31ycKdci8rihivYggQbtZaJlm7aLxKV6Ld40+Sv0/GKFwQJjh4nBVIhv1zmgM4lnjVRgsRkVZBj8WjESlS96FUuAyUA9iTZsGYls69PRuqIUd0r0hfaVa67maE+FYAs89WfLxUdU1PxCJMrKuAEbGHrVcIiL0dngSJGg1uQILazRBweyU6eZ3et1XE3wZJRjZctHUP+RSSkx+8ptvakdL0O5ol9iWqFde49MqCYRc8kRZ8QoCJ7xkUKs/vpJIQ8xeT3MWqWcZW1L1hAPdnrTjWm1a1soaN7SO8q8/MOsO7OUKNevnNtVVgZr6r3Uu9RAGlcLqSPGuvfIsqSr+TG5mK/RkH7Fqtd9UdTwu7nNNGDi42jf3+yPMa+eEqaBzJd7QtWaYMkewb3yKT41UVy0vNQ3p7fNZ27xen0n9Bn0zijHysW9Ws+yVhotGjuB3MmzBS3i1iNeBWvEdywX6NZsDBt3wKQgcVcUp6pMXxXvg+0ejmMcKPVlxqxoJFwKN/XRXbrLdzBYq1BZZlnqcsUnjmolJdV+4tVam6ANRTDpCbqq7GfXLS4S0o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HaEt2Jz6J67SH7ABULrCG/crA5cK/PuCdK5OF001Srjs6HYAemUjqRKNGrLn?=
 =?us-ascii?Q?nq93GjDa1pZCiX5OFSiPbBD2KP27VIpzSsn3kRfFkPwjt9QyoWDD7o4HJL9g?=
 =?us-ascii?Q?ieVgKFudO2rSkrPvbkTmS+j0+0pWoYY529z/1+rLHpfACbDzNZYbY4ZIZYFN?=
 =?us-ascii?Q?GBxLFXNeycx+ZaRy/v6+dlGq8+NhkMLaT0q4oVGI9MN/FcHvhvB21Rt7PF/8?=
 =?us-ascii?Q?6mKrzzZ6AwNmAjQU1hlShE48H8YcOxcnhP6fNzz3IQTUiQgQVFD0z4Z9NtqB?=
 =?us-ascii?Q?f41hAg2HG9KYRANLqZHjz6l4Avjf4BzVaXoTieLweSd8y4qj+RNxl/ZAtqWR?=
 =?us-ascii?Q?6gKoOyKHTRtFW7kgXUEyMnJqqm6fbhLLo+PG9CCnfqT8l6aKI6y7QjXZx8/u?=
 =?us-ascii?Q?aIAkFfWZ2/Sew29ASJ736WKTFXSoGu5Zizp4af/0QenCh1fzjCuqXa4VnDMX?=
 =?us-ascii?Q?utAAziW/xi7iR7Xrr/U8rLbRIuGAKghlDHiQZYDDIitl8/HJ0ZAPAWB16oWe?=
 =?us-ascii?Q?DUB0MrthlgEk0UDDESY0qGxGMDtLRAIH0e/BDwj5yFu0fPRvk2c4ib1vkA4r?=
 =?us-ascii?Q?24gc4JPzMg2nJxz40tmlXH7Y4WvSqY9syfMuoq+wqIIRXiObX6aRfTMw4lAF?=
 =?us-ascii?Q?9qTscTC4J2WO1ER1GP8vSP4t6ov8JV1x/BAmuAuwnII8EX+PnyaktIizWoIT?=
 =?us-ascii?Q?mHtoLWIbMBRBc+J3+BxGUj0Ucdu3jP0Qf3xt6DGYFvdeShKMQdCJirRuDi60?=
 =?us-ascii?Q?mkKOst2l3oodDQo8S/FJffN45PRIqfSKGX3c5D+Hpks3VTesO5X5J6U6gv71?=
 =?us-ascii?Q?j2h6C9BG335ISEcdEbcjMCJ8X2S8Ot84Rro2AIdczHbjKW9JujCigDr8hIzI?=
 =?us-ascii?Q?A2/FyFiobrrrvIuKXBd+zcetR/lQuTWt33/W285yQV48HKBG3IcqiSs1T7Jj?=
 =?us-ascii?Q?bCKRkIVtmeLc4wRJ7RH49JamwpeUGL9za4jdY70klAGBOpPA0nVk88IMg87Z?=
 =?us-ascii?Q?asgX8iWrjNAjMxiqISZaX9id9JQraIG/DfsDhnSnSV0ioEbnG/EgRzfKe3JG?=
 =?us-ascii?Q?j09NXRC2Ni0frJgf301nTkGN8ezs7k5lVrC3pQ/0BxHQcpqLHukip1X1iGD/?=
 =?us-ascii?Q?n4Gf/jVLfKs9LCoyuoYm3uln8zh4Dg2G2GdFHeDDQtQPin0stlQeiNmyywGS?=
 =?us-ascii?Q?Jkoi86fExjT3HF0Lxa3Du/z6uerAJgktbq7m5EY+dutkU4btAM+lWUZu8TKR?=
 =?us-ascii?Q?6iQJEYh8po1SxEZqKJ8S/IFkFX3KlxVOCjL7AWe4Bzf7o9ZSVSXv6pQojnSU?=
 =?us-ascii?Q?aGxRhePiGFhiQRj7+/Kp/wTv4Ovqz5Tv7Kv1bX/a0K+T9S8iqAJ5Xebqz6iK?=
 =?us-ascii?Q?5CyZliJwlkSmyvQ1RBEiPdbJ9Fuwu9Rqb6M9wyG3fc1wSXvD95enP8S16DHK?=
 =?us-ascii?Q?Y3kyAjfFvL2igmbavVwqWpYHV3upaSqJQ9cs6UoLHODdW5CTEFWPHYQbko/X?=
 =?us-ascii?Q?6T2XPVOmvWKN/o1enqalBrRxwT03dIpJKpPXkk0R+TWYxKgyDtKpz0iK+UFS?=
 =?us-ascii?Q?boUa/skY2nrhVtJXfhpAkICTW9CEsOzJXo4TDhOmH4tXV9BYBS3eivk2psue?=
 =?us-ascii?Q?vpevCN2/WEMch/f1RUOwLchI5WCLRegWtiGfatrC6L65OX7wwmTwc6G0UTTE?=
 =?us-ascii?Q?vhpxvK7kMIFf9svXQicZM+r61d6Jf1LgjelADnwCffCXJo1lB6B43aAjXWVR?=
 =?us-ascii?Q?v2RMT1qQCb2AneM+92ujHtJkfTihHuY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3dcf7b-f67e-473f-7818-08deeca9eacd
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 13:12:46.8322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwEj/NMnXXgB+hH5MSAQgGGWo42W+jJl3cDrvyzABJkEezae15hbWsajXc7o3obECDTaTHPPdq8NY2dL2tYEPMI5aBJJc5wJwy4JfGhOsvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6083
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 13:13:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23797

This patchset contains the necessary changes to switch
isar-cip-core to the new rootless build.

Changes v2:
 - add Debian release requirement for rootless builds
 - use kas purge in .reproducible-check-ci.yml
 - use correct kas-container

Quirin Gylstorff (5):
  update to kas 5.4
  update Isar to contain rootless changes
  use run_priviledged instead of sudo
  switch to isar-rootless
  update README.md for rootless build

 .gitlab-ci.yml                          |   2 +-
 .reproducible-check-ci.yml              |   3 +-
 Kconfig                                 |   2 +-
 README.md                               |   8 +-
 classes-recipe/image_uuid.bbclass       |   4 +-
 classes-recipe/read-only-rootfs.bbclass |   8 +-
 kas-cip.yml                             |   4 +-
 kas-container                           | 300 +++++++++++++-----------
 8 files changed, 176 insertions(+), 155 deletions(-)

--=20
2.53.0


