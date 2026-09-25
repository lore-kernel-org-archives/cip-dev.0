Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE9CC98332
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 18:09:12 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.3])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4493.1790359740344310870
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 11:09:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ekICYG0I;
 spf=pass (domain: siemens.com, ip: 40.107.159.3, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuQkkkD6zfS0Yt961z3WZBqypQPPb+laR/x50dx3HBzjRrM6GMJVd6Cibxjgi5aYcg0SilXZBQ1gCJXxdiyXuKwZDgUR7av/pR3twv9HBVE4zp0OW2sHLew6di1sx246+2s0BPyajxIG7huCAD5lYG87qIR4Lp4lK93YxJheQ+O2/JYTdRd+DwNIBQWAfa/6Nbt1coByXPDN66RJCDD64oa5CyofCcJ6e7ZhZlE9W1HfK3N+deXLO8q5a5ls+tDPkR5+88FmkjB8XkeLLWTs/XUhKONuVPXdS4sz+4bl7YWhlAXGVEk8dIEz9Ytq8BWAZE0aw7nYCUKuV4N1F3FtDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXJj7TzCT0n5JL0G2xpCdrw6rrSmFTKxiunfYIi4vvQ=;
 b=jsXrrN5n6KXwNHzX9S3hYn94UaSlD3ABkMOXjItAduMjsRAKXy9sDJep7fAO6bHIj78PRDbNMCni4kuANkBZF+BUcTQWS34pLq7NQNLDk+b6JMBDd+dx0efN1aJnlZK1U2SsX220d63VqhZZpVBdOzTeiSzUn0M/bVQwqccmL5oGn/0vy1p56GuhU67hDX9R321jWN0vWUAS9nzROjjCimrEVN1oUDsWmmcnew7O1TLcYdUO2CweTPhSqU4hXqduqHoKDkG0tkRmkJW3nQC7zAi7qusFkUXYa5Q+chAQl2o32Z5z56U2c2NB+sYiarhzSrw7HZwHXuQJ2NUl02DLxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXJj7TzCT0n5JL0G2xpCdrw6rrSmFTKxiunfYIi4vvQ=;
 b=ekICYG0Iu5a0P21Bl/lMwl4Iieb7TQUpi8DyeHFP4brkVDJe/7gMaCfsKGgY8BUCyyjiTnfznmADT3CWfDuxjSs3+Q9e32C9EvMqgGrwEiOEoXn3O1XywmuAl1RNSmqSh2xm2A4fmSehZgOL/gXTRmAQPHPOxrnkbtNuz4YgdEpBMaYGKIW32HIid+uBu/g+rWbzHMg5ZProP9thEo3Zber4y9ACjYPa3qXcUPgWGDau2ojmBV8FDOt1JP73fkKrCq7V1v3LWl/Ao4V1YFjmGGTjiIusVdT1RjqWonnJNY/o/6U0sVqYUA8x3DS7kKpOc0q0GaBr/CgA8N3uapLSag==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB9PR10MB6378.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 18:08:57 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 18:08:57 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	hirotaka.motai@miraclelinux.com,
	dinesh.kumar@toshiba-tsip.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v6 03/14] Add github.com/ovh/debian-cis for the hardening validation
Date: Fri, 25 Sep 2026 20:08:29 +0200
Message-ID: <20260925180847.622090-4-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 46231d70-c63f-4294-3c3c-08df1b301152
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|3023799007|18002099003|55112099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	qfUUGnFPTFOPrPq3S35WLbrhA1C9ZwTkyZFQMRBDgcQzQIm0cntqmSG+AZbORUMMklkXdDfxsQeTnCvWkC4VKq6RaX0EBEzyoahnCB4bjzqEvwr6MUq7YZKP4tkf5MQZ3C6fkcVXijVc28hEzbHL6Gv9pYkHOFLiABwXiR4IOV7OK1fXJehYkOssUrOgzyrAH1Q9zVYb3t3FK/ZKdujUN8beiA+kRMaXMXhDWOU2OJ4lzH6szIR1S1fmFsOgIVk8F6PSOhIJQMdrytzJrm5v1Oneo9JB8lSKvPp4lCsCnpbyQiiffJg0Fmjyvgn6EyOA3WysHU00R9VhuFH57xVf2kncZsmvJC/oyWLB6ab69g9WMgrsmivGkT3nyBFFp9s9Rh3vXuc6xrBolvECk1uNqLTRfZm0ChfQCJ5VK+RLjHw5dTZk4MOpPnCSBH3G9BsvPKqBD/MRACIwbkNv9cfOKbIlA0MyWI2JaJMh3lOJS8IgOROa3ZAhxnKVHvrMsHfWEWxzA15KokJVjAgSr7jjRgUCAYrH5K4vfah+G7GgE0EKCmHIqjaTpfM2f8tRh6LU7r4sW31RUd4zUzO8PBNQePiISik2ve6Bdt+cd53MgOOr1Je5wdwqqnt2WTq8kC+hEPs4HK5ijCc520vKqgD7cbipsPKhnufvadgd+XJKcBI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(55112099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?99nu+kJ8hY1lKpuqOyqbwMgvtk7gFRrH0vzBnYEMUEqurX0RMYzwaEV6Zi72?=
 =?us-ascii?Q?bS3ezSTtFfQMUW3AuZDInNp3zl1NJJRaiGV9j0fLbsCNjO7spQ+iW89D48Xq?=
 =?us-ascii?Q?TJEc8AeVzvNM4cE0tFog5hTLy9xUm9cggq4APbb2niKCYEm9sqZLdrEMIc+J?=
 =?us-ascii?Q?bRk5VTxWjKAwCaAWmVXQOPtYNo2AD3BOXwCj7xmCERbF9tTx1oQaeZNigxdi?=
 =?us-ascii?Q?/SBuuI5jGCHolIGBPeQSei93auIAwDzFFHbNjiFJlWFkBPPBgiVMNpE6H2D+?=
 =?us-ascii?Q?cZ79CQnK01YbT6O4ObYnHEL94RqDSqlyCnv74JHcr4WT0hMLxFGBXfO6z5iD?=
 =?us-ascii?Q?bcXCN5KG3+ox5DwLkDBNrPVQ88vMoWDh0/tnzyZB1xF62mFwR4wikuh6fNhA?=
 =?us-ascii?Q?fedcv/OJW1pBX7heqGpt9hJ26VqAng3BqKClDtIZHwk4l13TmbxLDXDt6mBX?=
 =?us-ascii?Q?Stn0wvrmeYBzw65wxvdXOnW7z1iqlCFxkMap4qzD7UKPBgeiOzaBT8pnFXyk?=
 =?us-ascii?Q?bOiHFToder/3syr1hoefBfroS3ttzO1I1on5lOHtFrKLLtk0P5xVCJ0deowb?=
 =?us-ascii?Q?DYbh50ezvfdNec8XDuMHg0oQpiK9MoG8BsvEUBsY4hDU9f8ud+bNLKatZIFt?=
 =?us-ascii?Q?IHX6MdaqzQXbKqancL66nDMp3s3w1hwsEt1ZBeMaW41jg8+olw2YHiRIUk/g?=
 =?us-ascii?Q?4n20RwJz41BXnmFwc1N4s43L1Epj0v4RPb+tv5NLCwH3Dhv79g5e5UaMGR2Y?=
 =?us-ascii?Q?HMG9+V8HEnK60znuSfHesR1YJStPZ2dXeDwD5auvfAGK18RxM2MMuN87UIvY?=
 =?us-ascii?Q?RFO7KiT+JFFkyoLbDXshyjiWGJJRZjCd879J1tKyIjLq6mTM44a2IUYDvw0N?=
 =?us-ascii?Q?6NV2EmT37hrGiYx+DXlJd3hQx8P8ariwwsqbW24gtY3No1xlLQvtglWVb273?=
 =?us-ascii?Q?hiQVb4PFIKOfwdtWw+MOOrttPiZuawx4mLKbCwIq6ErmNCOq0Sm86j9q5VY5?=
 =?us-ascii?Q?lI1cl8NdzaL0FDgruZFo0NGuLJtRoilEXUqYKV4oqqqf15++oIkuj/6E9NIz?=
 =?us-ascii?Q?/NIvDmRdeh5DVB1zw1zaB/zpeBXVXwqem58ssy7hExnu17av3eHASzVjSc2s?=
 =?us-ascii?Q?7aSdKj5pZZXVvR41v0NqN21VYFMr/O2YL8th69WJhf52z1fO8z04cgNHQbVL?=
 =?us-ascii?Q?0E/pDeGjstJARKxNes2A6A4s8vxty9FqMga7+V/np2NrIsuIrIY4pvUbY4iy?=
 =?us-ascii?Q?5TQd2ZPfTogZJaO1GIH2cOIZmlTAocPTD8dj9pe8iD9vamo+XxI8sfdMDOmB?=
 =?us-ascii?Q?+UJ/dfQnACa5NM99nsFhDL4K7p/fAyi0p+qnJOXYNlCiUQ11n9MI740RhglW?=
 =?us-ascii?Q?zQLUmDfu537c6CUu/JNCCoqwlatLLAEkCaEshU7lWnxwp6EhDAwsvFUWNbHE?=
 =?us-ascii?Q?Ve/TASkodkYJAD93nUmYUUyUxZg7Sel6ZEGeiKjFmd6Ga8+WiQGc6jo0Sm21?=
 =?us-ascii?Q?j7VVuKyBU/hARHdNWiXgVOlvZrAdy/tYfv3S9h6z4+ADk0Ri042qQzgva0fV?=
 =?us-ascii?Q?lUBfhP4Dvga7Bf+pRgYEwr1X4edk5pQDXgdQUtP8g6IOhHmH7/+OgzDYeMe1?=
 =?us-ascii?Q?EwBh4AAA5bVX0L75Q1A4I2AkcbZ5u5v6KyiT7mtoxZBH+nzEZJ9Lq1nbWSej?=
 =?us-ascii?Q?AAtoKAKugwJYfE0zxDt6yZBX36nVXuggeCH1RqlG2uRtGq1fQC6eah6q/DYg?=
 =?us-ascii?Q?SKMxP+yyN1TB3sPEWLYrVm0kkmk3UP4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46231d70-c63f-4294-3c3c-08df1b301152
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 18:08:57.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+67rh3sFhaq1aOuI5Z9cdjZPbjsiGkQTqL8Gmf7/8vyIPnxyJnz2VihSZroDM1pWV/4TNzWW5BK8KVc4Ywi7LiGaiPOu03Xz979Wo1AFvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 18:09:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24355

This creates a Debian package out of https://github.com/ovh/debian-cis/
to validate the hardening level during runtime.

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../cis-hardening/cis-hardening_4.1-6.bb        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 recipes-security/cis-hardening/cis-hardening_4.1-6.bb

diff --git a/recipes-security/cis-hardening/cis-hardening_4.1-6.bb b/recipe=
s-security/cis-hardening/cis-hardening_4.1-6.bb
new file mode 100644
index 00000000..4245c45a
--- /dev/null
+++ b/recipes-security/cis-hardening/cis-hardening_4.1-6.bb
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg
+
+DPKG_ARCH =3D "all"
+
+SRC_URI =3D "git://github.com/ovh/debian-cis.git;protocol=3Dhttps;destsuff=
ix=3D${P};nobranch=3D1"
+SRCREV =3D "efbd5b35ba32226e8950d52bd3f3444c702bbd84"
--=20
2.55.0


