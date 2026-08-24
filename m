Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9385C61DBC
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 09:47:51 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13172.1787564853370840972
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Aug 2026 02:47:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=vwY0tkTV;
 spf=pass (domain: siemens.com, ip: 52.101.65.55, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFLn+sfUYTio4fMIhK6JZH+5GNqNszj9jkzje93DmlZDZOrX/YBT9Z/Csrad/Gdyq4/5u6s5xbDhJCIsPN4koroPvEA4/ZaDo4LDwyX/c39GRd4K33VOw8LSQNoFzRmWcUIgf6ZoIcvsuICc3NaPjr3yqdfiFiAFRmLMNJfQWfdzu/xScHMEp+O0mmtmeR+3ILlypNSqHOlBFTp0LqnRJAG5kLo5Pcfy88FXIDnO96B5d7qe+d7MxlBAFyuxF8QwzPS2qdPSUc2O/sZiadBWw5lBKvQxMjHlsAkQL/13vPIL+ztD1j0fp9kPzFkDGfLMoDTouz9ts5WMQZVhdNBTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JB4nCE4rxZSxEI5h1iG+DguUVX/kmi+h6mBxBtIbuLo=;
 b=dwIQyOKYAK5kQ2q0v+AQx4VtbIl+2GzllbsrEcX9HCKY7AvnenueI3BgAq+C4ZA+oJ6yXOBswUYjkmfqaObKNK6S9cqYewZys5pOJkcUweWkB+AHSIu/wTxpZzNlBQOwiYu2zQOIDeqJYoLq9wwyGLKwaicRMY8pHgGxGw02pULau2DScatbsY7Kmc8thDCAsek3Q/gNmmVpDMcn9FFu2Ssb5uUNIgxknmuolfsZrRVsnFvAeh0Xnk/uYsAUsIlhdD3N53fNiAOnu7Klzyh+yCh3xN/Z6afLadp8VGC7Wu+vzxInHiM6bxRNXE4WHhS5ekJ1YoxIVQ3dR7/TNMkh0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JB4nCE4rxZSxEI5h1iG+DguUVX/kmi+h6mBxBtIbuLo=;
 b=vwY0tkTVgAor8tmhuQndy3iui2SyMg0OCSXa7IT9CSDmkp4coju2d1tWcPFm+uTAtLrgWXLXGOgyjB7szESNf68bfxGToewFMd6bggkTo3zHd9izNnerapObT29UP9ItGyN3EJMKKrTGCWaDdddRcOgRZokNwTgyXmAPNFmXir4N9UbugsXViRig55UP5Ynug+R0lIxaKimaR+xXlxfvBV39V15VM1i2X0SKHoXbQlcIqwSNKxth9jnNiSQOdHsyx69by21hY6/Em9dsTqmdRSVqkX+oG1RGsOfe5a7rXRNLoIphck60tQR8tw6kUXc4CdMHXarzsNwYvkLU88MaAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PAXPR10MB5760.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:24a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 09:47:29 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 09:47:28 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v3 00/12] Add recipes for image hardening
Date: Mon, 24 Aug 2026 11:46:37 +0200
Message-ID: <20260824094721.2636375-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0341.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::16) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PAXPR10MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: a8dc37cd-6577-4d11-f557-08df01c4b5dd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|20046099003|55112099003|18002099003|5023799004|11063799006|3023799007|6133799003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	iNHZh1eVfD/43WnBbM8wsiYmQzhnl0FCKtagvuc/bMitCkvBWgzYhfrW/7l8uNaoheutuUlBe1IfUfeGMu6fiuG0sVRXqBq+ACL3u4cLfEaAoy33sQ49dAGEJOwIGwpDpUwsnK6+/D9gVfhuthp6w2tEp8P82v9Gl54Xhy24dnH1i2qoV07lpaqDJ+9eIU4T4SpPZBpfHUKoLEkmnLWdJaL4gWA2lSLlGnZje791EiLXZwfQ0//q5FVyamt4YUOefIEmoH3Oc3VYS4b8UjgzlFgloVqwM7YR2rJhHiaSDkzG5Xf64qLZL2RJKVQrbjCjwKk7KaGibpJKnaHBnc8trhe7Uc8TRthKEaFVQgBiv87rdTOAKuJ+Q+4/S76bIcWT413b3U5IdysoGgwpNapj0GLme2e2BiDq+FPPHPlcJ3o9rSxQ27lVKqD4ZasVV60Ojts5X8DgcdB4STMTG100T5D2Rtq52Pj5aJDfPLVK7lIVIaje6m45HAH+84Mwm4AwxKDD+bJ9vtvW1S3+wh/TG+qnGNYGc6pFi9j/2VIOrb//IrsLjJ3rP7aJNm9GB/u4zRzRHveCFLxlxAdHkQ/R5JzmpbeQy0N0/BPM5bRSHQ4bJ1+KE9LoNmme84OCXkk7
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(20046099003)(55112099003)(18002099003)(5023799004)(11063799006)(3023799007)(6133799003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CWzJpz55aKg3owVuSeiHfvuf/lzQHJ4neLke2x9wraGHBl9Qcda77SJFN7Si?=
 =?us-ascii?Q?tp4I7cRWtyN/GfrpviEPuXBlIhQOvlg6Tz0VEeX7ApMAC3x5DxoQxgPG5pFP?=
 =?us-ascii?Q?qEGIKfPEt9nnIk6CN3oUahzdC3QwbkcrVvJXE+k3x4qLbHLG46CkG1XVmSsg?=
 =?us-ascii?Q?9aZ9IY3/nE1LddYM5QWT028n+gBquma2EvmgRJjG5ne9kTV2VIi4NYcb9Grz?=
 =?us-ascii?Q?NX/gsYu0GHimrd0dPXYOTiGeaXq0CCeg9GCdTdGIb8u61t54aSOXlogWkWcD?=
 =?us-ascii?Q?SqIIjcx/Lg9TkXtr0kWHXBUSgxqGr508uSjvuSAFyuQ+ZnPXYTamWb1XGYBE?=
 =?us-ascii?Q?Srlgbd75R/gVg/HMxHrj0xYoOkoa6fWaaLfte6hcE+k/swxJOhc1y0vDTdYz?=
 =?us-ascii?Q?pf9JW0VhQ5GKKPFIoTDtEOCNvSne/BDU/vX7GZXHX01HwPjdyAYmQdEIjea8?=
 =?us-ascii?Q?CPa1iKLbrSYVWqfuUACwb7n6roCCK3zprwBaqD5h5bxko7UwmMteQ5UvXqsK?=
 =?us-ascii?Q?6PB+JyKiZBC0MKKkMiabyNeQjqtyHGdNu39JT35jn16rvXCZX61IXqGSiI0t?=
 =?us-ascii?Q?EMlF/X6cHHe+HWncYc+D+MoJ+Z9oEHhmtSW5+dVUWD+DVD8UJjStkDdeyIj4?=
 =?us-ascii?Q?32KLeZ94yPkO4GG8ii6UGCnyi6tOlrtpAvx/hGdfgbgL/CfbH6XBhLRXDHdN?=
 =?us-ascii?Q?DV0sLcV7ndb1EmLRr9qLleeT3a7+fyvM+T14uy8tWtzzdVFa/LBBXxrdXrll?=
 =?us-ascii?Q?v26tisjnVqZKn4ddnupVshvLNMcG8+gm38crbuzDNWmxMxwsCzRzfN3CfdRB?=
 =?us-ascii?Q?1Vaw+QDzxxwMlk51xeu1ZI7AQpc3dGfP0kSa8tTVluP3+CY1PevD6ufna54V?=
 =?us-ascii?Q?/48NQS97zqhS93HQplcezXLRsI0aE41qFLDYOrw5eaeWE+k7lMSx/4yItKYx?=
 =?us-ascii?Q?APKfrTnBbOiOaL9uk6LBSMMlX0FGPE13962agGnUSfqmA59NUrAgNcphip0n?=
 =?us-ascii?Q?IQwQ/I6ZUi8COH4GuUmw7uwh0yzUI07HdiGWoR2hYy42qF2fj/EQhzA7CkQO?=
 =?us-ascii?Q?9huFpGRJspyD3EBL6ZiIE+Lz93c7bQk9zFh6g48+2RWlL5wdH0RYkEDaEY+f?=
 =?us-ascii?Q?yvb8SO7f5xqqHylf1Fcr86tYNsTisZuUTooJ6EUmFU9JksA5GSdsOrkoktJC?=
 =?us-ascii?Q?N2qvSjulyqUhl28M6CLThVq1lYmDK7QcD9pmsCO4W8gmBeUKjDBeFqOF6PqM?=
 =?us-ascii?Q?A/flXl0sqfLKYgI00h1F+j65HJwoq1m4ukJ1Dm8wqYvaeT9TJv6xf+Gq8W0T?=
 =?us-ascii?Q?HwInEzRapHQLSL+m4V+TDiuKAcm9wiYQR3lhvV393Tu5CaIrGJ4+vL5VttyJ?=
 =?us-ascii?Q?2pOC9055LI4ko0Bp9WqOPNoea42wNNA9IfTS1AFcBNl8VKteG0Gvayi51BRt?=
 =?us-ascii?Q?clGsndOKyO2h67du0QYaLrEMy/2ce2X1/w5iRx5hVSweYQ2I4WWloWHanfDH?=
 =?us-ascii?Q?sP72BJ8aE/DGVVAtbXojqWJwg0rOEZxeEUt0dHkFoek0KAIsOw/DocUmoZG+?=
 =?us-ascii?Q?556GE1tK98wvPCLdHnkMkaVclHEEkfX2xP30MOH8mtdoiwq5B+GvUru9kWxd?=
 =?us-ascii?Q?+ZnrX9AmDN261jDLWCKJVjdbPGRJKKV2MLhvmDZQgPhIO56v0p0XvYRIGZJA?=
 =?us-ascii?Q?sFNejRD5cGzBjIcb2kPt48AOPu2oxMUrY7v4PHyY+y7QYmlOddqG6v9bJ8la?=
 =?us-ascii?Q?2NpTwbk9ND1NmevJU+iDvCj9f56sK/Y=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8dc37cd-6577-4d11-f557-08df01c4b5dd
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 09:47:28.7846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzzWNYCqJ2LsHhujAkY1O88cVSKr26JP3j0dyXsTN072SeDRruDQPH1dM4YNbrYT7MB3hoEzHLcwEs8fNMDPjfQgI4T7/C5LsXCBs4mp4U0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5760
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Aug 2026 09:47:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23981

This patch series adds the option to harden the build image according to th=
e guidelines published by CIS.
The patch introduces the following packages:

cip-cis-rules-config: user-facing configuration, stored in .config.json and=
 configurable interactively via Kconfig.
cip-cis-rules: uses the configuration from cip-cis-rules-config to generate=
 a custom Debian package containing the necessary hardening configuration.
cis-validation: an optional package to validate the hardening rules.

Additionally, the kernel configuration is checked against the hardening rul=
es.
This patch set is currently developed and tested for hardening level 2.

Changes v3:
 - switch cip-cis-rules-config to dpkg instead of dpkg-raw as it allows
   better task dependency management
 - remove json schemata validation during menuconfig read to avoid a
   issue were outdated config cannot be updated.

Changes v2:

- rebased onto commit 73d8558efc2fb49436aafac36126564c6a725565
- reorder patches
  - README is now first to explain architecture
  - layer.conf before arming
  - kernel and image are armed together
- use external repo for cip-cis-rules https://gitlab.com/cip-playground/cip=
-cis-rules
- menuconfig now uses devshell to be independent from kas environment
- generate config.json and kconfig on the fly
- bugfixes
- rename cip-cis-validation to cis-validation
- remove CIP_ prefix from variables
- rework readme

Clara Kowalsky (2):
  Add cis-validation to validate the hardening based on the CIS rules
  Add kas file for hardening configuration

Quirin Gylstorff (10):
  Add doc/README.cis-hardening.md
  Add cip-cis-rules to apply hardening configuration to the system
  Add github.com/ovh/debian-cis for the hardening validation
  Add cip-cis-rules-config to configure the hardening according to CIS
  Apply hardening configuration to the kernel
  Add class for validating the CIS options in the kernel config
  Add class cis-hardening for post rootfs generation fixups
  layer.conf: use variables to control path of hardening config
  Integrate cis-hardening into cip-core-image
  Add Kconfig option to select cis-validation

 Kconfig                                       |  10 +
 README.md                                     |   1 +
 classes-recipe/cis-hardening.bbclass          |  47 ++
 .../cis-kernel-hardening-validation.bbclass   | 110 ++++
 conf/layer.conf                               |   3 +
 doc/README.cis-hardening.md                   | 229 +++++++
 kas/opt/cis-hardening.yml                     |  19 +
 recipes-core/images/cip-core-image.inc        |   4 +
 recipes-kernel/linux/kernel-hardening.inc     |  16 +
 recipes-kernel/linux/linux-cip-common.inc     |   1 +
 .../cip-cis-rules-config.bb                   | 159 +++++
 .../cip-cis-rules-config/files/postinst       |  32 +
 .../cip-cis-rules-config/files/rules.tmpl     |  19 +
 .../files/scripts/cis-hardening-to-kconfig.py | 350 ++++++++++
 .../files/scripts/config.schema.json          | 124 ++++
 .../files/scripts/enable-cis-rules.py         | 333 ++++++++++
 .../files/scripts/gen-kernel-config.py        | 165 +++++
 .../files/scripts/select-hardenings.py        | 616 ++++++++++++++++++
 .../cip-cis-rules/cip-cis-rules_1.0.0.bb      |  23 +
 .../cis-hardening/cis-hardening_4.1-6.bb      |  17 +
 .../cis-validation/cis-validation_1.0.bb      |  51 ++
 .../files/cis-validation.service              |  13 +
 .../cis-validation/files/cis-validation.tmpl  |  65 ++
 .../files/generate-overrides.py               | 103 +++
 .../cis-validation/files/postinst             |  52 ++
 25 files changed, 2562 insertions(+)
 create mode 100644 classes-recipe/cis-hardening.bbclass
 create mode 100644 classes-recipe/cis-kernel-hardening-validation.bbclass
 create mode 100644 doc/README.cis-hardening.md
 create mode 100644 kas/opt/cis-hardening.yml
 create mode 100644 recipes-kernel/linux/kernel-hardening.inc
 create mode 100644 recipes-security/cip-cis-rules-config/cip-cis-rules-con=
fig.bb
 create mode 100644 recipes-security/cip-cis-rules-config/files/postinst
 create mode 100644 recipes-security/cip-cis-rules-config/files/rules.tmpl
 create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/cis=
-hardening-to-kconfig.py
 create mode 100644 recipes-security/cip-cis-rules-config/files/scripts/con=
fig.schema.json
 create mode 100644 recipes-security/cip-cis-rules-config/files/scripts/ena=
ble-cis-rules.py
 create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/gen=
-kernel-config.py
 create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/sel=
ect-hardenings.py
 create mode 100644 recipes-security/cip-cis-rules/cip-cis-rules_1.0.0.bb
 create mode 100644 recipes-security/cis-hardening/cis-hardening_4.1-6.bb
 create mode 100644 recipes-security/cis-validation/cis-validation_1.0.bb
 create mode 100644 recipes-security/cis-validation/files/cis-validation.se=
rvice
 create mode 100644 recipes-security/cis-validation/files/cis-validation.tm=
pl
 create mode 100755 recipes-security/cis-validation/files/generate-override=
s.py
 create mode 100644 recipes-security/cis-validation/files/postinst

--=20
2.55.0


