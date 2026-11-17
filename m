Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15531.1794914931770418210
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:28:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=WgK/Bvy2;
 spf=pass (domain: siemens.com, ip: 52.101.72.43, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUh33AVSnjsm6DdaGZaflNGyvTngDcgokGP3LJDKUobX2rriyeqZGoqWbmwKQfA67lI0k20cD+7Ha/2gKmTuMjBrAYvt0YKxe+1cevDgGjNXTclenZV3xY3lKRHLBcdeBIhbBFcpJt80hqgvWwBfrI5aIFkg3ZqKuqdwqmIksynF5Jz8vRU5iVxZQLC4reYBs2t7DKoxOaoRgEvKA2tH3BfiBnwoPF0KA/U2mFtoCTS/azotV9Xo6jXbuG9GxQSGNsboa3WgqR67TdtiWYzzGjcZpSgg0Z6xmAIYjDjO6f8oeu+kttkx6qdUC/e1sIMKKBdcHYXr0kejU0JEnp1eRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaETRIzwuSgPF76kjcFbzdpaBLpPlhUXMpNA2cZJ4tA=;
 b=cUHeGGOgfi0+R8sBG6kG6W7JYQTJpWkQ1NWTPKv7C4HIB8PDVYh1KOpQAVKZ6rFiYyfv+LmhCV/eEKS2b0gqbjEVhRfGpZsggBoSOYVwBcRNYyr9KpLizZgkMv7/D/ms9X0iwSYrZLOCs9mKP9X4IrAGwv3CiHYN0IL1wexnqnwS6Tu11Q4iUydbrfbmwf9qdzapk0OPPA4pBnfmaSFup0bFPQA6LtAvl2a2FfA/PS7YlLS+Z7QUzlVPCwvF9T0Dst1o448w5NtaLXtsSaoJRBdqy3k3Y2uq1N0h9/cTVB0NgifOGzfi007vJqtez99Qb0xOA/PSWAA0KAOzySK5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaETRIzwuSgPF76kjcFbzdpaBLpPlhUXMpNA2cZJ4tA=;
 b=WgK/Bvy22wrBebsDcYwJBWnKSPmnvht52/IdehqNhOcVrQ5HSFfRc7nuztz6DBUDPJY0xw5CO+b7og2q7f6fmSNz4UqnTJIJfriW15YSJJKbCYbV35uGUP24iFE09QtpgFErwxb55HU0aneA8m7Y3lYLW76SWjMCLwhjEbt+knnA9YJLpDsv2qyDuQeIPGTvjSBImk4Mx7n60MAF2M7Hwu34bZQo7d6GjrNUR9a2Qs5kpjkK/p+JbVcafXH8Wa3T0dS8oeGxo99gXpPux4LPaB5GwZzk73FA966ykNnobo47d/BWwEm43OK9SXvYP8X4Zzv4MJw4r2uGQFyW2l1GEg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AM7PR10MB3144.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 11:28:48 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Tue, 17 Nov 2026
 11:28:47 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v3 11/19] factory-reset-helper-efi: use systemd FactoryReset variable with dracut
Date: Tue, 17 Nov 2026 12:28:25 +0100
Message-ID: <20261117112833.316234-12-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
References: <20261117112833.316234-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::18) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AM7PR10MB3144:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d879cc-3f9e-4f96-0919-08df449df13d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261022075727099003|11063799006|56012099006|261026121527099003|10067099003|261021121427099003|261102123227099003|261009223027099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: +PuQ5G1OEjiciK1xTWZX/ABg2w6vKGcUPfI9gt+TqdlK0553fZuls81I3vqoq1JKh1CXhE0a3HMX7YIMaA/aYmkocUR1l0kqRaF8cQaIxo6KXDCZSURrXuQ/ibvytATqTD3aE85sUrZtcH8F9WJXMN1tLx1OyHvrEWoEk2swBKGQiTec8K9jXIBA1AKVFrS+Rqrx2ttnLmBDTWbc0xfehWTUeccor5zhwDFVEoaX+DsrnxgA0YdY61jLu0VY1veB5JGy8XjTLET1ZV/EgrLOsQg9JgFyOk6gJ1tHsEzXv0UHLHXCYBgNAUmbogAwK6lRJiy+wR7BgT1WdpWhUPZKkoAYNHap/MrHnYKRUwLdIYTthtdqIHSDtAO9+66Vnk/2KV/cmehHvFBYc0H8cA6j07iSieGsZ/7Cl18gcUHgYJQpu1eZBcv3zY89jUc/tn9ffVORlT4scyPOZy54aivty9iU2sxvYUWBix60618dFmBKpcggfJrZua6sj6XnLiUhSyhKz0uyNBuvDBjsrn9QvCGbHmXglyxb/6F8vnLngPoxQgl2u7SQ+yL1IKgfMh4Ndmajo/hILjywA0FaFlnE2GLZIcmgm45wdqJGAJeFKLp0BvDNayFmiLlYbay9mHmd4Z/itsUaEIr7A7S02kctx5sId8wcIaFB3JR2hd+oqwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261022075727099003)(11063799006)(56012099006)(261026121527099003)(10067099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LTVPKBoTs09wUAnTmSSt4yOFJd5kzk+iCnlOIx7OrJNmKG+O7kfp4rQip5z9?=
 =?us-ascii?Q?1pBjWog+Fy7uCq9nl4qbGQ5rDzJowHNDoFY5+40ZKYGlO3Da0YqKcl5lGlfC?=
 =?us-ascii?Q?3jCaWzWCP8QvmF3RV3wJJNnarkHPi0Cm+J3qpvohioaGI6MSp9FnKeeWwLBN?=
 =?us-ascii?Q?cyKQuUF+VRkphwqDna2BvuIzy5MbASGaTblDYAgdPCaFTe/HOPgsQ9GsL7hd?=
 =?us-ascii?Q?l0ek98Sfj4DW8GYGB9kjQqkdzY4hZqKL6yKTpk14/jujUtNRAzJNCXP0xXq0?=
 =?us-ascii?Q?PIISolxL/vgVtvg9J9Ps/ODbpstdb2ZpbgFL9RisGx0UsnTGbEfJpvylGE7Y?=
 =?us-ascii?Q?jL5PqpJMgi00aP6xABmrvtFeBKzVVvTO2cmi+AlpBAQ0YV468koIJ9c+40S1?=
 =?us-ascii?Q?bRBMoPGJpSWKtf8kYRabM/W4BctQ8eZ+wkGBHJdFS38YLB6TQG2LYWh/Crd9?=
 =?us-ascii?Q?50yCfegXJpa2C5cDDAurX/IxJ8QHOkWKpZn2Cj8A1dIrN/MwLSoRSPS1QubL?=
 =?us-ascii?Q?z0lCabqRiim8+bngzqamVXeP/Stqe40l/dar1ZtgYZ1tEamF5XpANWA8lG9j?=
 =?us-ascii?Q?wGgYsJMoaK9XYWe5Exb4uEhhW1BLCpHmOjiu256NcxrsdVcD9EifwJR5YScU?=
 =?us-ascii?Q?vMixvOlEIXgpA6fX0e3ulH0Nsmwz02lx7uAkDAaPf+HG0fyxLf/zB8jC/r8w?=
 =?us-ascii?Q?fz/t7VidjarILeFtKFTu/0169239HjqznRExDEmc6AJJK7WLAJuAeozZjSNV?=
 =?us-ascii?Q?PT4Qtdpm7K6Ohdl4VN+Vnmp2khA647mcZvakCpnLovGGdSBP2kbyeLjCk9Cq?=
 =?us-ascii?Q?k1q0Q1iT4kiJQyzrNpNxpeARcJAinzFWwv2M7InKUvyuJ81J9HS8+MH6OAUw?=
 =?us-ascii?Q?VifAlEnlzbp4fWo89FUT+/MGNqNy8ooomckw2Q2dVzFmyJCpgAT/WGMWu2PK?=
 =?us-ascii?Q?WeTTosdbeoRv4BuqW0wVpcz7LSQTnYdM6hXm/34iDHQfSkt5YkztEH27FIK3?=
 =?us-ascii?Q?Si71s3E9B0WhCqG7U+UMzoqQVYu2/U1A31o00cJ6EG2RokBr+LCTNQm6uD4+?=
 =?us-ascii?Q?o4eeGh5H2b+IX7mhPPWU3XoYLDWzNr3D6ZbabaLdPqvK3BxfuodVzyFEmV2Q?=
 =?us-ascii?Q?fF5ovVidXiZIDfZrfcyOraj4dC/j/qBKXIqfGddRudTuyQNzIDFyKXq2xqrX?=
 =?us-ascii?Q?2vBIgXkiCQC7wG1IRtoaMdFcLfHY4GBFOqiKoAgv8p1Zf6uvPXxmt1CPxHjj?=
 =?us-ascii?Q?bm29C593VtNkTc6uPWYNoebsR43+5cPsh2796rij+jhDK/9atkGuF1PQFSQo?=
 =?us-ascii?Q?gYj4OPjrGPkYR7TZae83eQ/sGuiW0K54xSkoQ44W7UJ6Y24hnuKWn9BIVspm?=
 =?us-ascii?Q?Vf3xsZY6igtkFVroXSnDtovdq2atfl4Ns7kFYnuE3b0dC25PeG8xDdUid+lP?=
 =?us-ascii?Q?0TWo9wOv7h7y5Nu1I4yJUCzoIOSrMk+JZVNXN9Yo3WMhbOy6kgHUyI88rJC4?=
 =?us-ascii?Q?nnZjNS6fAB16/GQPek61sFTT2cG4c1ZSMueQn8V7hgXLZHGZnOJY+zuhi1v3?=
 =?us-ascii?Q?v1dm7F3NqjTPznYsQ6KvwPqQgF0gfC6LcQCiw7CJtkv3nxe7ncMTepBBNWP2?=
 =?us-ascii?Q?Lg84yY6TlW+0cHEHSmJCrNa92amOT9MZlIFdIG2G36aQYCPP7aA2LdknbdZK?=
 =?us-ascii?Q?663LbtQTASPQGt4KAOeUgOeJGsZfitJTyblGL+DtP/V/I9bIPlkCzieloTrb?=
 =?us-ascii?Q?azyUxjhtg1HYk4K07+AHBNk+NWsGrN4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d879cc-3f9e-4f96-0919-08df449df13d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 11:28:45.9346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: He8imBY0DvdQ/Zr3Het8B/Kta9oDHPeJsMfLpWwsw9rnS+tUOuVS+Pgj6IlzSQbivWRYBnx5qNLtuG5qwj/x0oiHE+d019S5BGkUHD133W8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3144
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:28:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24830
Content-Type: text/plain; charset="utf-8"

The embedded-factory-reset dracut module reacts on systemd's FactoryReset
EFI variable. Keep the CIP vendor variable for initramfs-tools.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../factory-reset-helper/factory-reset-helper-efi_0.1.bb       | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-support/factory-reset-helper/factory-reset-helper-efi_=
0.1.bb b/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.=
bb
index 071b1ddb..76bed253 100644
--- a/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb
+++ b/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb
@@ -18,6 +18,9 @@ DEBIAN_CONFLICTS =3D "factory-reset-helper-file"
 FACTORY_RESET_MARKER ?=3D "FactoryResetRequest"
 # Use a new vendor id instead of the one from systemd
 FACTORY_RESET_EFIVARS_GUID ?=3D "abc688c9-fee3-41f7-87d3-1076e4a29e8f"
+# the embedded-factory-reset dracut module uses systemd's variable
+FACTORY_RESET_MARKER:dracut ?=3D "FactoryReset"
+FACTORY_RESET_EFIVARS_GUID:dracut ?=3D "8cf2644b-4b0b-428f-9387-6d876050dc=
67"
 FACTORY_RESET_TYPE =3D "efivar"
=20
 DEBIAN_DEPENDS .=3D ", coreutils, util-linux, e2fsprogs, bsdextrautils, ef=
ivar"
--=20
2.47.3

