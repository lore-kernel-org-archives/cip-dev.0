Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFB4C3DA4B
	for <webhook@archiver.kernel.org>; Mon, 15 Jul 2024 13:46:38 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.73])
 by mx.groups.io with SMTP id smtpd.web11.38326.1721051196428950637
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jul 2024 06:46:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Kqa/AQrI;
 spf=pass (domain: siemens.com, ip: 40.107.104.73, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQiCmQnuxESMGl9oTgWAlhVqF8lYKd6oY5o/4AT5sxd/RH2V1dgbkWURDqxfP8HETt453UC3w/sBpYOSNFV1AOjguMSzolacPppVe14CE4+nbaVJwdaHalW8kKn5cQtI7ei1+pN+y/U1vmTgK/38mEBlB6HB8mIvz+qN0Ti4EyXye4/4i6CmvvHy8CbtPRSfeWacyE60BUkGmQb6oJzbTt406yRck4/fThRNgv+6leUI3kfUstLSs6QylmO4rI2qezYuW611vxC/g3DE3t6FOZsCoQhZe/j38RM748VPiQTbLDOlAt1Ud3zSvvzscEQoCGADDqN9A83CXFfVtGXUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6z7js6sYnc0wY1YDfaZV088CCCMQo3pre3jHYk9UNY=;
 b=n2rtoZXnPbR5lH2Qu5gqiueIcImisjIE532O175tiG42FO2UiFBwCOlBY9D35YAj7V3wJuPXwAHM7wVWNwJcTBaYeOHSwCOJQfzwcaD8hmmCpM1AplyKHf3jzvJs7058niiX9K41z7F3gFAki09bafBANA5nqSG3xo5N3TZltrYvFKu1U3xM3dxouy7UXDGERmR7Cd9OmO9pYa+ZQ6Yasc6bM0GiMVVOeZ2/3iIqbWvE4QbkH8cz2gt0hhBRqpRyuhdpWzV0Cb7ngDAKAc10gGiIkkrC8+pGr1/VKIS+ngB6m2wX5f/Lg5ngJqXFXE9x4irebXTVlV70c22m5qU6ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6z7js6sYnc0wY1YDfaZV088CCCMQo3pre3jHYk9UNY=;
 b=Kqa/AQrI0oeJHIihUo4NfUzuaPJL3Zz9y5YrhiV1Q1UmN7CrMdANefkb10Icesi+lQnp9X/N/cuK6sA1VxVNK3WYqnZZbr3R4VHexYvPX9/t3B2ZeSGBAGnhjsux0gNf+FNorGnEav2vTOS2yIQbj785TrSw0Gm3AyibRXS3AMq3VcMKCOlW97PJG0gQSjOVVmG88j9RgYIXOOD3melt/9kfijneJgZlssHNzNvqMOzHBrRBuEQjo430aWrgDzZNA69BZzMdW3N0QMr2pCZK/Oerfj2o4kUGZ0OqQfNff4EhLkw8muBwyhm9CEA+4ZnwRGlLWH4pTiqHOrhKxi8Flg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::14)
 by DB5PR10MB7871.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:48a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 13:46:33 +0000
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46]) by DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 13:46:33 +0000
From: Stefan Koch <stefan-koch@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	christian.storm@siemens.com,
	michael.adler@siemens.com,
	simon.sudler@siemens.com,
	stefan-koch@siemens.com
Subject: [PATCH v3 1/4] initramfs-crypt-hook: Do not attempt to repair a partially encrypted filesystem
Date: Mon, 15 Jul 2024 15:46:27 +0200
Message-ID: <20240715134630.1640160-1-stefan-koch@siemens.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::17) To DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2c2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB4953:EE_|DB5PR10MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7f5cf8-b1e6-4321-8ab4-08dca4d489b5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?UQz6vGLGjbk+8rmGkSJzENNDB7G/MDfmrYvmDROUJ3x1N5HK7DS0PAb8blPb?=
 =?us-ascii?Q?WPtvAtlGt0235H+5JQkdsy2xPn+jWr6UZPy1f0Wr3LiyBeZ8/H4AhEP3j+IB?=
 =?us-ascii?Q?ZgMuLKsIvDDiaY9O+V4rBuIbyGbomIJlOjlUwHXg3QT1MHPCk+dQUKOPJpgj?=
 =?us-ascii?Q?buoPaxB0wsvykOlJG5Ac63pwlfJ2uYe960nOI8w8ep0q9B/26Oq/+Qa7gK3L?=
 =?us-ascii?Q?j/gWGrHNZnFhz7avyAYWrYkk9V6iZH0WrM36rb9mKwMtM/G6Zh6PEWsDV0j6?=
 =?us-ascii?Q?omlDDOYU1QNWw+moC1IVAX1EnuaVQ0A8CtEUnvfmGIPV9Clp11KmS5JD8m5b?=
 =?us-ascii?Q?Nwsw4qA/o+ErlBfHvscfpSWzwkj+Q/nYI3OpfC8tsP41S1vHYp/mxYbx39VC?=
 =?us-ascii?Q?iSc8EY2MIX/m3EG0rmyI1SjXeajpXKDCBWF9NAe+nOgXz2WqQ4/xWzf3U/Ni?=
 =?us-ascii?Q?SUof28l4qvuIJz7PAJZaHbs4XStSwJLx82toqQDi9pgMRaQyN8YRbrGPQiil?=
 =?us-ascii?Q?XNFnr2PruQ8Mf1CsoovciCKQUEuSIeCqahtZwzcGaVgoyD6MSWAHmDbAdrZZ?=
 =?us-ascii?Q?oVV6T6aY8KyaEH2G39q3kDz8JCow0qR9YdKYssrdQqZ6dDovIQzG38v0jbce?=
 =?us-ascii?Q?U3s859CJ9Wh5ZOljnmC2+FM3UlFaolglnj0AdKwoZqFLS52alCUFa/FWNotl?=
 =?us-ascii?Q?X4rNPPrJZWfsGKQmKFLFsrF+v+D3kTFhIPUCXgHPHdLI8BD0+x2ME5QfUW7C?=
 =?us-ascii?Q?Qr41sqHFsjrgsLnsZmEzD0w3fZbH+SKrrPm33wVfInT+TrwKQ+60dMQWlEVg?=
 =?us-ascii?Q?RWES3sDbtoraKi5dmz99eaNvPz76lv0C4U7weCeVLHb1nSQgmYQxGX9PqUvf?=
 =?us-ascii?Q?0b7jtjvjKh/zThUJeqxNDHA0O0mb4+wNPb9/h1/oyKm0rOuhzTKlna2h613Z?=
 =?us-ascii?Q?igevtTbWLoPCvzFRjiwsylXReOecOk4IqGTgHc8liqVx2Ut/AUabRcEvFqj2?=
 =?us-ascii?Q?B03rfikZTb3Kxp5LcDBkbQ8s7iKeMREqthqIj7nudamIdhKjqdWCtRNJuU3J?=
 =?us-ascii?Q?dFfd/P3BUWJUoFGUaQvqsV36rnwBuP0e/XnMlMtCnem5qFiRXWQoyrnHqwBc?=
 =?us-ascii?Q?34G/KCkKFrpY9vpZMNXQEAnqlaaT5AcO/J0a0YqvOpv55wOAcys8L0aIXYwE?=
 =?us-ascii?Q?8fkZcaL32FrQd//urJ0TdEXFgq/YVfxx3ytKyLo+8ewAIsVkSzRVqOot+bAF?=
 =?us-ascii?Q?Yg4OcdrfoNpzR/QrbWoceMnswFgRvQlqPhVvmHnwHBHhMF4CbH4a2PduoETE?=
 =?us-ascii?Q?pdMPlAhvsYNJGU5FjRTMePpfGcO82BDFJ/0b1rGp19m7xg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VIg74C4kRUM00p8sxzcuCkVULs3e3nINBosQU3pvPb1Azmt40gTzD2HzIe92?=
 =?us-ascii?Q?eOTHUNuFn3OFHFqLGAGrpHy7nODtPq/kmMK0QcLtHoGcAFsqKHRQiZBIbkRB?=
 =?us-ascii?Q?Ru0Vz0dGzwRiem1Gc3l7rjfWbMj0ffWfOH83wh7J8mLyMEa8Piz+7yYGmlXc?=
 =?us-ascii?Q?RnV5MqG6QCp698mz95GEmFff4/9BdFwuHlbX5HBzcQ+flFKairj/SyJAddMk?=
 =?us-ascii?Q?cQyc7AoZDO3SBRCKSMfLgkvHvWqTdDMROOxYSvX0GmiS29TW9ojLdy3fyTEU?=
 =?us-ascii?Q?K1AeLGKtUJEh/OdYlNKGobYm1eKoiIjvW0iPk4mivuMUl13OvVV6d29wtR2x?=
 =?us-ascii?Q?0sC7d6VzTsJt5wcS83iShM3xsKVLhdn0PWdHOIwRcFX5P8psqgk57J7ONKlH?=
 =?us-ascii?Q?5dGkXeuRaGRKFdY9SgyXZrBevl5D2B9OkIsvuqhhubuVAUtDBp99PbquXVHt?=
 =?us-ascii?Q?8cuOIqyyPzeSaPZRWm8B7MIt0F6XuEaG0Cil+kcooFW7ks+k/ABH7JPg7myS?=
 =?us-ascii?Q?Kh+lm+lOwAA+/uEKUzMa+dZGZXk71MBD4/ZXRmo2TQcXwxmSWbnINeK3Yevd?=
 =?us-ascii?Q?03gEY29ANk++tuJzY4s6CAoG57XDIsjPOBqKa7Am/ohRQOoawb1X0itLG7XH?=
 =?us-ascii?Q?RBoZHk85XWqDARBxwbDA9XX9ekqnFNFXyHZFuDLK5AXAXUOARfjWW6Z0KvlX?=
 =?us-ascii?Q?R+TN/VmqErYBfIO6MPZfm/ynlaS0eKACsj3cAsgDmDFCul3A8BJZPypJI7kk?=
 =?us-ascii?Q?attRwBL1P8ffa/E/dwAlWoxPX4b6y6WT4j2pBh1L0bYpK31+aWxL/9TsGg7l?=
 =?us-ascii?Q?MqlX1ooRpXQbxnewSdOFUZwZLv/gmpiosjX53Ybvw4aeAof9ovrwOzvaefgA?=
 =?us-ascii?Q?+evkRzHb3VBhTuZpG/reD9tppPTeRgoVho5rr5TFpAlUFq+WkAchp9VI3+td?=
 =?us-ascii?Q?NlO4dMGKyPZ6/MdLTV9ClUXxmBNviI4G0S4xPLiA/Vk/V3yaoOySPwBgIwop?=
 =?us-ascii?Q?hNVK4Yn/fT7Q84GrDC7PMtThX1qwwJ0qO+opOjU7zi47tf/E1+jDXijSMRDD?=
 =?us-ascii?Q?Aqmof/SE3SPzB/eXacI8D0hI4Rx7rGprGsr5VRM4mcqBfCMrWNc61usFzx8D?=
 =?us-ascii?Q?gV7xD6JgxtPHSnrgSwQs0vpmZnAYl5caegCKNw+12SqnBjdlwHHON6+UW+X6?=
 =?us-ascii?Q?Zj0TeWNuuR105qRTFnjQcrzqJ2nRnjuRyFW1dFYrokjjYhPZqQdkcL2cSCJs?=
 =?us-ascii?Q?mRpiHeqUp86C21hfrExM8/+MoFkN3DwJ8A7s9CXysnCrJPdTvyG05KjlT1NO?=
 =?us-ascii?Q?CJW/Wl6W0kYWdaZko89bpqEkhfFraFXC+Om81PClLRJwc3swPsBLeTSQld87?=
 =?us-ascii?Q?MI/Z6Nmnsw8f5XGyF2kOysKOoOa/+t3KRzJWo6KhFuxnWJjyll7we9xFrHto?=
 =?us-ascii?Q?7qxBNuhDavxapQ/A7fEjugOUh+oAEhaX/Z794N4uOkMx51j3cMn9eEXfkD9n?=
 =?us-ascii?Q?R2OIPQpOEGVwFio552DhAtdeJKHl/m1Y/ua6mA7RcpWVLTbheirXOs+CDUYV?=
 =?us-ascii?Q?LE626zsfCONchY8R7QY+ny2GnJOazC+hEo0K/TIXYWxgrRd2/12vowU8wtBL?=
 =?us-ascii?Q?Ivb7QdN1T4mddbbHPomWr6PLXPqrLU14DMceOWPnfOm0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7f5cf8-b1e6-4321-8ab4-08dca4d489b5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 13:46:33.1300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDs1Ojs39Bo+vUGh+LZ78Z9GbPSeKAYIvvnluE8ONmGdswhe4pjFXtdGbTVCvYUEAUY/vgpZdIoaXY/exqcUUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7871
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Jul 2024 13:46:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16494

Avoids that e2fsck will repair the partially rencrypted
filesystem after power-loss while reencryption.

In general, cryptsetup is capable to resume a partial encryption,
but there is no key available to unlock the partial encrypted data, yet.
The key is enrolled only after fully succeeded reencryption, yet.

Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.script   | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition=
.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.sc=
ript
index ff4c135..f943aea 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
@@ -77,7 +77,13 @@ reencrypt_existing_partition() {
 [options]
 	broken_system_clock=3Dtrue
 EOF
-		e2fsck -p -f "$1"
+		# ensure that filesystem is clean otherwise resize2fs will fail
+		# do not attempt to repair a partially encrypted filesystem
+		# ensure that there is no attempt to
+		# repair a partially encrypted filesystem
+		if ! cryptsetup luksUUID "$1" &> /dev/null; then
+			e2fsck -p -f "$1"
+		fi
 		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
 			panic "reencryption of filesystem $1 cannot continue!"
 		fi
--=20
2.39.2


