Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911F9C9830E
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:36:11 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.19])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5782.1790249769104585119
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:36:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=DqzO7sVG;
 spf=pass (domain: siemens.com, ip: 52.101.70.19, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxG3rPXku0o7XQJFLdBHAS2yE3ynfw6t2l/BZbwRd0OC/oxECukS8WJvdUsykHPL4CVvduxMgu3/LBT+0OY97GlI2Igk08AxaM6zsWnbGNcZMiNPMvofrarCzaAg8HBjCINMAvdNL9X6F1quoHhlwITd+WHqK+WUG2IqrPOVoBD1F3zJkoP9+LPAZ//9eAMVM5Q+9uMxpH47Br8XeEnBw85IUyG0VQoXqDxNXuEFok7PbgiWkGbO4SIKjAvMRBZhNGrQpU6S90tL7R5npPw/H4iVLM16LMnXk3EmEvFnTIte+eMYsKQ/lmNAkrRQS0n6leVDxLFTuDGil2+gJ7N1yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9mBarfqcYZm12+o+MSVIuWwZAl1fZAt9xgKQCsXB6Q=;
 b=Qa8e4dPC4vQVq4IUn6LfFzwjj8gTEdp8tbYatFAyXbRbSqT43bpGnUYAjWR5bOYUs1oQKn+IcJt/sqiXauKhPFIZDK3230odekZWncFObNtI7QzCB4+5UWaZgmkQ/0Z+Y3LHRsI4KOlSwsFvtrPfDbJr5dVKTwp+I3/M12fj5AFoY2z2j0nREK2qOF4QMlEoSIbaZGuXSbJWOPimfZJAMf07HfI1R0nywCXbS34Y7E+h+NpkASfWcJ4atHmGRFSB73xJ/642YWKumU1lnOIsxSizY0Y9omCg8J3ZTl0x1TwQ9qUTFaGeuKNPDnEwiivbLktlgqh33zZgahTDnviEZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9mBarfqcYZm12+o+MSVIuWwZAl1fZAt9xgKQCsXB6Q=;
 b=DqzO7sVGueNkY45nDRqk60dYJbbnTDoSI3QkiIfdx63hqh57aYyF5oPcMid6KHuiCoUeb33uk99OlmUr0s5pSBwdN8oTU5R1wx9wIp0TJsyBhxgRv418eF+1FFJnaAfSp5uuBhso29fTye7gDNcOXQTQ3uRtOQQqsaH8wBMI2SQ6rBjOLgfIcgDJOhn7Qd7pMpPaE4QlZoP3JldjoOsdlgALOXC99hs385RzKWs8y5TNXAmMQZSkQZXsIDL60kkJ/watdOsxx/++SUrFJJv30fniTtkRTOwsjCZt/JUxwuv6n0a+Ea4KLliQQP7KECHyhP+kMbCkrKfoXNbJT2KXVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by PA4PR10MB5514.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:36:05 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:36:04 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 00/13] Add recipes for image hardening
Date: Thu, 24 Sep 2026 13:35:00 +0200
Message-ID: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|PA4PR10MB5514:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cfc95f3-1142-4459-9cff-08df1a3003f8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|5023799004|3023799007|6133799003|10067099003|56012099006|11063799006|18002099003|55112099003|20046099003;
X-Microsoft-Antispam-Message-Info: 
	KB/GO5kn11aLU8jZOUdQYllWwExGPun88e4X8IZEt07dbs5SMSnZAgf0Byaq4Of4jX2uRjJapiE0d0V/+iey/javUDB5C5Ng3FAzL1lnfLg/PczEaiE83cWAte71m8F5PGXaImJwpyIomNKAiFnoju9dMlNYKqVrd1+VjgCctascywaIQXD5ZS7H/pcqWfm9Ts/W+TmX1cK/27eSvgztl4CMmAB8vgPcbYqHl+CaUQEq9G5wH5Dnbu15pcvROajfpOv8SlhhfsBvq6WlSCa0I7OHah2Nnmkhr2FdaqcxUudLBFGSz+zu/9oUmWAzbYDDjyNtjUy/TPft7VagG6ggeHZifpVk5k1denvZxXj9c4UJ6q69leMAndB2/nIR4k+gWoPXA91xLcYMZDYq2szXyoya1n2h0g7gU+TTTnpPH72jzLn50d2ZRQL9/EUDt/vIW1iZ0qCdi1IW5ihaCraF4DVwE955wkxNwSiaN3mKWZohN/DMbBrorTg3rsvPfW4RGR22R+JYCqd3Gydfpv7X8ep7dMu4GiCIRh/li1CgOh/J7uOgo7GM0w/1/oKnYWyzu5c0fzw47ixgg0JfbqbhMMecyOJqfzTsnmBQ9jWm0zwX/MQc3GIgDZATm1daFYS1qUsVE1C7HyTNvpXEhdyCoT/ULxNE96AS2lsCYd94KrA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(5023799004)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(55112099003)(20046099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?97e6zHIwg1ZfHUNR4JD8WyC3zV/sN9YigFlgUeSF4x3FDMIk5WdXHpwz+inT?=
 =?us-ascii?Q?wtYYu3S+K01Qqj9XVVO8sqWXaKugTRzSniWesKPkyQs4dvpLQcv8g0HvKPUT?=
 =?us-ascii?Q?NAMQf7bQ4wFnFURYRxdoikkGG4+WvdiZPZvYcwOHIfO2pwh+dZBYPHUQJiFv?=
 =?us-ascii?Q?YC32Dr/pswfuYjbwJVYoCZ7sUpmkhP8fHUXvz6Ddf8WalIXabBIuz2aCMlkO?=
 =?us-ascii?Q?ktdpk3fXrPuWysbaa26Rgl17w8/UKmxnON5Pw8ONEB/ZQxjJ5aCwmfkqDto5?=
 =?us-ascii?Q?TVijO8kZo0N1thwVottXh69XB2p2vu/IUyO4BXuGsCov8QYVExMRn8yV4wFY?=
 =?us-ascii?Q?0wJCyk5sfUW44TXSVmYxMLhNAx2G09Fnq2fHQCs42mJ6+uPf3IpyC0Vpup9u?=
 =?us-ascii?Q?xa4zFCX5auwATnyHUMQUJjtJ8AXzoU4aQFS8HsDSFj59inrH9ND35s6sfnEE?=
 =?us-ascii?Q?LGEubw+L1YBQNFqKfQUcvf6wfWqDl4Ml8NrdseyhmvPXRwVqbYBiuwQnQn8h?=
 =?us-ascii?Q?KSt+/fGeaPOlTpDLvuegpK2usZ+iVI7IOJ84Gg9zJcJCd4lOxz8NTVnTZ0jj?=
 =?us-ascii?Q?AXivkCEilK+3pyBm+R+2C7q/71RWzi5H9VIYbcZI5B/zaf/wgociBziEpFxK?=
 =?us-ascii?Q?FzpFCX28advImeTYfD5+Z3z7pNhI1wA6Uc53HWe8L71MxlBHIMBHz8JsYzet?=
 =?us-ascii?Q?ip0brJ2nrl+P8kymqy+Q7UWNlsx9JW4wPTy2syfDjxg2Im4VJqYZB3TZs0Hy?=
 =?us-ascii?Q?+vbxD/8ZBYR5oZ/yhxoUkWafxkcIYd2qJry/0pN1LeHmJfLyxTYdFzw6lbCc?=
 =?us-ascii?Q?33WClwlZTf6/yU/GVrcBp1Xn8lTQ0n6UmqBIhZl79VEe9g9wOvnPg+VoU+5A?=
 =?us-ascii?Q?1aZX8ka+7Hyq8ef2zDmNrjtqZZxQQPCrDLJGQngfYU2iUKZx+qzOf5tbam4R?=
 =?us-ascii?Q?l8lc1R+yr3UZUrhJqUcUjxhkrrIIZr+THI9Cu16XlQ2pad1dsiPgaFnKDvd7?=
 =?us-ascii?Q?nABnTbhuuhiMEMUZnAKG/37W0D7/AJy5linhu0MeJZ/iBQ2JPpxPf0WrtXBB?=
 =?us-ascii?Q?7litEtK2V45VVwOv3xoxWMckZzPtOERMM2vEtGf/LbqM0bciOdccy2y9j8aY?=
 =?us-ascii?Q?WcEZX4JUJbx0Sd5z/K1BAV8OfOiVDB2XEMInG4qxY2JRYynkj6yv9/OUlvNJ?=
 =?us-ascii?Q?c76YJK5LkbXyoANzGAuchkpFmxP+chlgIlXS1XOIuOE+emBVOklguYPeG+ZN?=
 =?us-ascii?Q?iFB1tD+J3eRMYrrNgAF8HsvmKO3cRh2hE3wbDVeqhqj9Aew/zr6VNavt1bST?=
 =?us-ascii?Q?8QRl1ujmlb6qmFZaf2B0U7U1802yfjL3uuRh3/2/xvW87HKV3kvshla6u3Jk?=
 =?us-ascii?Q?NrmrkFDesH225PCH3JLJ/q3WSYfLgNFl7Iq9tXK5qHboQZz3RCjM+KVyqcsL?=
 =?us-ascii?Q?AyEkgjAU6tzibmHQ6t2JQZFTws93RIFTApwGeT1v3U4ie/UzWSHInKW9ovtQ?=
 =?us-ascii?Q?3QKULkYC4TG+jPC/a2roSKSGOs0aiEC9164QrIa14uNSHTmNF9A/V0TGzC7u?=
 =?us-ascii?Q?af26GpTJ6f7u/JFgAMMxKXuyvQVBsGMp1d4JV/BEEgOvKfVXpT1hplocNMKt?=
 =?us-ascii?Q?vLd0KMiVXDo2j9+XzvlkE4mW35ZEmaTQC4iKT7PzzPdoS8z+51U5ERoq7XaU?=
 =?us-ascii?Q?ieQOf3+/jIJ14a20jwSb0xQcAv1o1RDPv6b+APfa8aB2M3JQpY5Bpt/qwUht?=
 =?us-ascii?Q?LG/X3jHhA29X18c+WgzLryqAAztQrLk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfc95f3-1142-4459-9cff-08df1a3003f8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:36:04.4583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otZZ3s00kOOY2zwEWfkZerllK7xtA7u8baQx2aQN9tHQeb0TZOKU+tBMjwpmFgdNvxzYiUSVpd6dwQY12rTeupLgvpcD5QTZne9h2Ib7OqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5514
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:36:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24314

This patch series adds the option to harden the build image according to
the guidelines published by CIS. The patch introduces the following package=
s:

cip-cis-rules-config: user-facing configuration, stored in .config.json and
configurable interactively via Kconfig.

cip-cis-rules: uses the configuration from cip-cis-rules-config to generate
a custom Debian package containing the necessary hardening configuration.

cis-validation: an optional package to validate the hardening rules.

Additionally, the kernel configuration is checked against the hardening rul=
es.
This patch set is currently developed and tested for hardening level 2.

Changes v5:
    - rebase onto commit 75c3ed7cfebf8ec5c79329abaeb7a9a50ca546b1
Changes v4:
 - rebase onto commit 6ced51c2993421738c86838832fcf37b9b2076f3
 - Remove redundant addtask for prepare_build
 - Switch cis-validation.service Type from oneshot to exec
 - move validation to kernel recipe to avoid issues with kernel config not
   being available during rootfs install or validation of a upstream kernel

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

Quirin Gylstorff (11):
  Add doc/README.cis-hardening.md
  Add cip-cis-rules to apply hardening configuration to the system
  Add github.com/ovh/debian-cis for the hardening validation
  layer.conf: use variables to control path of hardening config
  Add cip-cis-rules-config to configure the hardening according to CIS
  Apply hardening configuration to the kernel
  Add class for validating the CIS options in the kernel config
  Add class cis-hardening for post rootfs generation fixups
  Integrate cis-hardening into cip-core-image
  Integrate kernel validation into linux-cip
  Kconfig: add option to enable CIS hardening

 Kconfig                                       |  13 +
 README.md                                     |   1 +
 classes-recipe/cis-hardening.bbclass          |  52 ++
 .../cis-kernel-hardening-validation.bbclass   | 260 ++++++++
 conf/layer.conf                               |   4 +
 doc/README.cis-hardening.md                   | 283 ++++++++
 kas/opt/cis-hardening.yml                     |  19 +
 recipes-core/images/cip-core-image.inc        |   3 +
 recipes-kernel/linux/kernel-hardening.inc     |  18 +
 recipes-kernel/linux/linux-cip-common.inc     |   1 +
 .../cip-cis-rules-config.bb                   | 157 +++++
 .../cip-cis-rules-config/files/postinst       |  31 +
 .../cip-cis-rules-config/files/rules.tmpl     |  19 +
 .../files/scripts/cis-hardening-to-kconfig.py | 350 ++++++++++
 .../files/scripts/config.schema.json          | 124 ++++
 .../files/scripts/enable-cis-rules.py         | 333 ++++++++++
 .../files/scripts/gen-kernel-config.py        | 165 +++++
 .../files/scripts/select-hardenings.py        | 616 ++++++++++++++++++
 .../cip-cis-rules/cip-cis-rules_1.0.0.bb      |  23 +
 .../cis-hardening/cis-hardening_4.1-6.bb      |  17 +
 .../cis-validation/cis-validation_1.0.bb      |  52 ++
 .../files/cis-validation.service              |  11 +
 .../cis-validation/files/cis-validation.tmpl  |  65 ++
 .../files/generate-overrides.py               | 103 +++
 .../cis-validation/files/postinst             |  52 ++
 25 files changed, 2772 insertions(+)
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


