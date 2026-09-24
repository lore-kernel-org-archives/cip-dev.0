Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23DAC9830E
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:30:40 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5720.1790249439112830547
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:30:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=kI7nVYYV;
 spf=pass (domain: siemens.com, ip: 52.101.72.13, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVj0kVBwZhFFaRk9n4fEMrMtVuI1EtErcPZPzb0aBu7KM5+mFhbiS1TOdH0D9ehD+fLgzE2Zw/v4dT7wKlPOoEhllmBZZDq9+4cYXevdU0f83NRZ99ZZHBNgl0cAy6m444V3Qu9NNnHzZZO4tYaf6MQnA8kiwsXMIjocVDCxRBdy6gei0tvNlIKuJpFLjciMcdBwxraEf5QBD/HjQ7BhvSPD3IB/VqDkpSB9PVkug/R/qrmDKAGmBKatxM6wSXiXo2M5V9JVVuAiXL+I+6X1vOskJOjeS0RAyLPKJB5j2rtKPTi7m582tatN1LP97iEd2cwfMOibbcJWHj6/2fcXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d089/A9XG8tm0myu37oI7frejU63mG0uM3tg/vtixnA=;
 b=ZG983PLmemEZo+txHl7GJla+5y5pXbDCBpMPtIZ0O9J9rpq8OJeQ/gCbXhMZmB7MzlINRTqT1/SzZD+0xycF92ifkCXtkWWoRfU0Se7WpbHppPAuhoYqKhlQl8gT6HQfD4KetckXR6tHEuXUqiWU8XrUiAlI+hyU9ZN5cJ/nRSWZ5KYm3qqvles9HGRqt9NusQsBcQbPdQEAWGPqds4/2AHmtYuzXdnnwQA818Psw/3n/sTwYNdqZThxRXgnFei235LoEoz7F7CnMsLq503p+TaktsCx6bHEh8YQi1+DAM49O3MyBkwWzTnFN9ullxek1HvC8ZvYaL76S64bfosrLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d089/A9XG8tm0myu37oI7frejU63mG0uM3tg/vtixnA=;
 b=kI7nVYYVhAE6DxweSYoyBlmN09RsnQJMgNZsXZ9/EU3MIg0rRIzFU7W6gnbdW/BD9lmf9lwCn3G8k0rKUH8P5pg1/wthrlYYdRCz6p+zHITFEoRd/1fx7WeENZE8cd5hl0VowC7Vj1ot+LO3vkOxF6kp/7pE0pDGoxKmOEu6EmhgPHPLdldFtSIr4nXicMD4RJPB04lbuKKnKuBiTI0hoE0yk9b1KrT78z/hN8UUW7BoXIukcsuNQHit0rooJIhJkHrorj6cSc/auw6dw4Cs+4dwyLniz9hNoU/0uM2IDsm1OpawcpnpCAe+q+Gqi3a0FKtsyRraUm0ICqM5ZZpi0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by DB8PR10MB3308.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Thu, 24 Sep
 2026 11:30:35 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:30:34 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	alexander.heinisch@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 0/5] Add wiping of hard disk to factory reset
Date: Thu, 24 Sep 2026 13:30:16 +0200
Message-ID: <20260924113028.3191076-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0091.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::6) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|DB8PR10MB3308:EE_
X-MS-Office365-Filtering-Correlation-Id: 77839e01-b5ae-4b99-10f3-08df1a2f3fdb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|11063799006|56012099006|3023799007|55112099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	B6/fFUcdk6q4lx6m8N4L1SSKvDWkXQqiIoM1KCaHP1WiXZC0y2MxOoMpcpyhixuCGNIf8K3rY62L4x29WAIbG9w6ZkxTmBU9yMSUFvd5E61/pxyHjcp3vtCEJK2/T0lpefgf1N0DBTlDPsEhmazVEkIkiJUM4Y4GbaLAn7fAT+5jDd3Ttht73SINGpd4K6UcZslcpwMS9YahrwsbpM5Ku2helmq3bCW5dv1e7s9bVbl0nz10hkLQBZ+oYN9xHceHExL9+QQ/LXZUBxzZu8oivtAlEfb/PAbOzSab+aUaJBd0rdyWJSULMyFJENT2EjYEC5sAI6secKV2nuSTSYER5INLjtgxaGZQasuI+uyrw7m+SUxMb4StPUR0fj+9ueIAN/sC4rhBZL3Rmp4dznRCAmqWymgYG5qZEkCMi0xpGYD0Icjb2B6SPstZnaO/ee4nuaBaHqaF4TCYsQ02C2X5iAoOpTIvTVnVAzSxtSETqpGkFgQyxSOcV4SnT04181s7j0xxV3pDBDeoo2YGnh0hval3awzq+SGcdHVTQ7YZdBoKwaDPzbUwkASXnMdqdwJn5CMaSluwfJVzdGTVAoHJx0UF79taB7yh7qj7xbhij0rosspGYff+mVAHo6o56J6n
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(3023799007)(55112099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0zrt2LH4ebeIeDyl1eA08UNp+oeCR4VANioi0jnQCtwqj3NN5cvyPj0w18oc?=
 =?us-ascii?Q?ywFgZh5G6gcwrmJS4pjiaAFrk+qKFbG1zKjdawrys7a6JyQaLvPO6yQ+/IPk?=
 =?us-ascii?Q?ifhrT8/Cpc/e7Ni5G/ICqHyA9jVzySTU+wHFW/ycKGkhN87WMDNl86XSZSST?=
 =?us-ascii?Q?/of3OSvJ77DgvX8WYb10bDOpSP2HRVTeJwiGlNo9w9++qxQVYNqwwj53S1Sn?=
 =?us-ascii?Q?Rsxtzg6lQKcoscQQBGeECdP9TYKRuS7RYSEdAc30G0+48troT24yR9p9DT26?=
 =?us-ascii?Q?y9kFMLFAvh5AGIaAAfHLOex6xZDYAOFXOJJstH3O8yZItXtj8Ov4unDF19Gu?=
 =?us-ascii?Q?SpYgXXw6JUX5u2VfEWTHWcBQsQzY2QqGLnWstnVHngoplbdMdQyLkT9yBspQ?=
 =?us-ascii?Q?5Wyfp0ZqymfOEpvd2GyGUYVY5v5toIKNcI6Py4Befev4w3MH6tuS7boq9TQ6?=
 =?us-ascii?Q?tyENAQkl/swsqh+WpGn3jACypIdFF1eElQR5VI4kqpQuDKHu392sLMJAtnaZ?=
 =?us-ascii?Q?P8W3OFMHZcVL6WwvMoHLf/klT4togYjoKdLBl9dBNatCDP3SicaIJ8tLEf64?=
 =?us-ascii?Q?SCKWPLO/RtCy/oHWTB8stFVPadG8UfxgCTO4QvhR1LyVkfcjSivPpuLEjmpS?=
 =?us-ascii?Q?vHaeHOgCop5ZKd0cJ0DLERrQjOQXBkCVfEeFUtsFt89eFthKPKuyF62wyKOE?=
 =?us-ascii?Q?+h5S+vYDWl0sXQtsGcGR+E74iyhwjn9UfWOrU0I2+a8EJyAOP2cfkRWDgQip?=
 =?us-ascii?Q?Uap1p9tqOMKeMnv1zelE4a1GCU5eyo9H9LG1Q+Sj3czyLV8uzXwTVyfDrpwB?=
 =?us-ascii?Q?fGWEwUHcsczcFR5AkvJHd4k9Y3bpZd2AEKtFyoAZirD67h+phQl+7tJBBQCi?=
 =?us-ascii?Q?O8wwLeQuKktxHJjLovFLdJAk43w19luIIyvN3EPXDhgBJIL+YkQycjbUMc/0?=
 =?us-ascii?Q?iVBNBNvot3ZJYHNf0YF9MV7+wDUU/jGkSrhtzz3PokUukaD45sG7uUmZPJF8?=
 =?us-ascii?Q?u5mpJblzR7qpeABxxGzgo0JVLNgqKk7mm0g9ZlYAo3XrKQVVPlMxT6Hk+kmT?=
 =?us-ascii?Q?ZxJFHr4biZFTO0qzGdP47KsWXOKZFQPVNPVWfkjGQwzLkI4OU6jfV6RjJGYa?=
 =?us-ascii?Q?yR4VGdfTsnidMER2n3rjQ7ab0+1eMX0oN4wDxUh3Jm7Kcbt6aOODwc3mCTB/?=
 =?us-ascii?Q?GHyoSMUSiSL0XT5enL8Pt8Zs4xkpfcpLn+9oTUGdxd8kYjvrXhXhm3TH01Ki?=
 =?us-ascii?Q?ltmuF6rCS8WO1KzNeHNnP0nqQZkMwJ3mBk/9Ce+OyrEsKQam9Vqc3nmLWD5l?=
 =?us-ascii?Q?fnHsryYe560I/9R5kTkWdxie4aWxfnNtt/ru4XAhvKFpEMnGp5RIg8bij9Rt?=
 =?us-ascii?Q?ppPFr/IZCfmGsHt4mpKIlxS+l6b7yuu2+vbm9dEXAKE++iqyqaeVxiMmhzsC?=
 =?us-ascii?Q?hYNi8Z9EvquDqnmR0+eCEBHWp9xwe67YL/wOgAQJvWG+KPVsQ2gDYbtnCnlD?=
 =?us-ascii?Q?KnXlRgvjM0GQyun9QyWxIZcWVR7GTX1d2g7czREDNG1nAtt095gEle0tBjct?=
 =?us-ascii?Q?tpK3swMcDKf8JIj+TjIDgsUtCXpaaKKQYBRiWKWySweQXEfrNBkfkl/RgRRp?=
 =?us-ascii?Q?uqJVfxEJ76vobIjU6GADvFh6azIoVDGacgG6d1VjV4yRxAtm9vg076W4qKA2?=
 =?us-ascii?Q?uRND26KgG8/aikgdsyYU4RElY5ANZeTfesvUIagvTnLM2v0P5MTTFaVBk3ep?=
 =?us-ascii?Q?9VKIj9HZtFCTeTX1z7fOfZJ1jJRGITA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77839e01-b5ae-4b99-10f3-08df1a2f3fdb
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:30:34.8472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfXywoQO/vH0mW6Lh/tnM+v1GeEoA3DkZNSRVzLP1HzN1PdcsHbb1fzFCQYRJYJHg633GPcK+Pf38NtxD7GFACjB4yMbyaS/fLgBiLL2pNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3308
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:30:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24308

With this patch set a partition marked for factory reset is wiped if
- disk encryption is disabled, or
- disk encryption is enabled and the TPM is *not* cleared.

If the TPM is cleared, the LUKS key is gone and the old data is
inaccessible anyway, so the partition is only reformatted.

This fixes the missing wiping from issue [1].

[1]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/164=
#2-no-proper-wiping-of-disks-if-not-encrypted

Changes since v2:
 - Move the TPM clear fix to the front of the series and rename
   INITRAMFS_FACTORY_RESET_CLEAR_TPM_VAR to
   INITRAMFS_FACTORY_RESET_CLEAR_TPM_BOOL.
 - Keep CRYPT_SETUP_TIMEOUT instead of renaming it, it now defaults to
   the new global INITRAMFS_SETUP_TIMEOUT (default 600).
   - Add INITRAMFS_FACTORY_RESET_TIMEOUT, also defaulting to
   INITRAMFS_SETUP_TIMEOUT.
 - Move the INITRAMFS_WATCHDOG_DEVICE default (including the ftpm-stmm
   case from b31ad236d5d9) into the distro configuration so that both
   hooks use the same logic. Recipes only keep an empty fallback.
 - Split the target -> target_device rename into a separate patch.
 - Fix commit messages.

Changes since v1 (RFC):
 - Wipe automatically depending on disk encryption and on whether the
   TPM is cleared, instead of requiring an opt-in ':clear' suffix in
   INITRAMFS_FACTORY_RESET_DEVICES.
 - start_watchdog(): check both parameters, use log_warning_msg()
   instead of echo.
 - Drop /run/watchdog.pid, the shell variable watchdog_pid is
   sufficient as start_watchdog() and stop_watchdog() are always called
   from the same script.
 - Do not add the psmisc dependency and do not copy fuser into the
   initramfs, both were unused.
 - Keep the blank line after wait_30sec_for_condition.
 - Add fix that the TPM clear was enabled instead of disabled when
   setting INITRAMFS_FACTORY_RESET_CLEAR_TPM to '0'.
 - Drop the RFC prefix.

Quirin Gylstorff (4):
  initramfs-factory-reset: Ensure that '0' disables the TPM clear
    instead of enabling it
  initramfs-crypt-hook: Move service watchdog to cip functions
  initramfs-factory-reset: Rename target to target_device
  initramfs-factory-reset: Wipe partition before creating a new fs

Shivanand Kunijadar (1):
  Fix file timestamps are not reproducible for EFI certificates

 conf/distro/cip-core-common.inc               |  9 +++-
 .../single-key-to-efi-certs_0.1.bb            |  7 +++
 .../files/cip-initramfs-functions             | 36 ++++++++++++-
 ..._0.1.bb =3D> initramfs-cip-functions_0.2.bb} |  0
 .../files/local-top-complete                  | 23 +--------
 ...k_0.11.bb =3D> initramfs-crypt-hook_0.12.bb} | 14 +++---
 .../files/factory-reset-script.tmpl           | 50 +++++++++++++------
 .../files/reset-env.tmpl                      |  2 +
 ...bb =3D> initramfs-factory-reset-hook_0.4.bb} | 17 +++++--
 9 files changed, 110 insertions(+), 48 deletions(-)
 rename recipes-initramfs/initramfs-cip-functions/{initramfs-cip-functions_=
0.1.bb =3D> initramfs-cip-functions_0.2.bb} (100%)
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.11.b=
b =3D> initramfs-crypt-hook_0.12.bb} (92%)
 rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-r=
eset-hook_0.3.bb =3D> initramfs-factory-reset-hook_0.4.bb} (72%)

--=20
2.55.0


