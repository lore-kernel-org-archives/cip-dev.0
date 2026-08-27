Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B06BC61DB9
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 07:43:07 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.0])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31295.1787816582434474017
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Aug 2026 00:43:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HV9xkFdN;
 spf=pass (domain: siemens.com, ip: 52.101.83.0, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoIkhvUgzqw79b/Jrob9RtFPbD5VZKwmyENbRj6p+f0M+tzqUq1kMaNJOn1PvSrZVjmFYptk1TRhYJbjUU1RW3nyN6KqI/3L6T147MY/6MK/GY0BX/yLOQ1+pXMyljcLAlFqAEWRgXeMReErqm0YQPdJBO0GAcnlSva55Okbm4t+6kZL+yAkLrZRLxgF5ZOE0e3eLdmfqeIZ4xKsAbMKbihcoPLr2N5+TAndaTyNG71qbZoBGok9nzGIS5DMj4Q2RSpPOSyaXMjX5Kx0n5+pewho6EWRZ3S5gfvfWWhEEvmSuLF9Y5JLJ8mwvDyMJnCQUdA3cazi+OtjZKZLeE+Kxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbKQVGQMnmYLgcSUhzBOPGue6MHhKG9CFg2UB3OQmkA=;
 b=o4lh1kF6cttDVP0iTOKPwfN4mbSwcB211CMyGRs23l0a3VqbYNhkj91fcssgSGhtDYsl0MWyMg+T0dnQgA5G+1QQFYmP/zeEQFzQ8YX0Lla+JzLJ/vEbp14qWTu5XuDy7hE1mbIjHn93NpCtMz3gq1q/8UNN4+xClm/FrHQPVFKvR5/5QovsAqcQuRctNL+3KwJSYWSU9IDt/2Sm3ahzsRcAQ+R171UyzIjYENYiVXiXCTTx3dE2wmPlGbeBgKgWd6Wh0FcxrvRw1ggngbRURcHcSXCkLOi2WZt8cAJHBUEUG+7feiAtKinhY8iQSola03BPiEeYCOSG9P08O/SFrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbKQVGQMnmYLgcSUhzBOPGue6MHhKG9CFg2UB3OQmkA=;
 b=HV9xkFdNZHN2Qkn/vm9lxq0Qu3tVebtX1UdCf+S9HNgRMy9aHDBhRMzPORAJCLSm+ohV4MibRdNoVMgILbnJMDt8qzqAfyhjPlpPZh56a27FmQ7YMO+YWSNONKX9faH0QX/Y+NsQ/+/0rdoT+5tKeSt5ydhgpsVQLQCScBTqY69moQHvlVqTzILC1yAUVxK/ABeWmuEOB0KZvrxmuCFxWQXEM+McexOBSaezvupN8xw/yypNv0zHMDUhPbgkJqrICvqyMTeWbey5317ThkqIjvLcY98z2RaZwBMNx5rmepclLd+kZxs7UjtL8CCFWurSw/wjAB3uC9GfxY+KMnVR+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB3PR10MB6812.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:438::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:42:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.006; Thu, 27 Aug 2026
 07:42:57 +0000
Message-ID: <cd53772a-9aba-491c-99d3-56ed03648bdd@siemens.com>
Date: Thu, 27 Aug 2026 09:42:56 +0200
User-Agent: Mozilla Thunderbird
Subject: [isar-cip-core][PATCH 8/7] doc: Update README.secureboot regarding
 recent deployment enhancements
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>
References: <cover.1787722904.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <cover.1787722904.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB3PR10MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd0618b-bf23-49f4-5aa0-08df040ecfc7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|6133799003|3023799007|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	FFy/kPsaKWnsqzQ5rXDh+0KDpKF9JJ5L67zQrPEtVwS0/1v8Z10F8fhdvRKUfoyFexF7M5YwcJjgXr/JDIB7kWu/7uNdCy/o5BGCQE5Y4UOWtwStlcVsrOgMQ4v6x54kRbme50K9verBTmgMZBYpTzC4pPznLaaqURA733rOc5kplkLkzteSE3jzRCLIrWD6YWh2mdtCM2/2Zs8MCpZAac0Xuzb/ZQR+NHTpb/p/rIVTnWagM3/UQvR90cNaVrxTAYZGC3IX8xXIg/+ULbXIHc2l47q079IeE52ERvnHU4FkLReo5kjA0QFDtllH170IvQE2NvWU7Exl/4xnwm6pTKM0Gssu6DcnJ4VKRLWPpeZkdYqOCy7QK5gdXEPt0cooBSq6tu0kl5vzF3N19jTNrV0bCLJsourumk6HoL0t9D8n/4PVhBofrhuwbAAyx4KMpDyY0K22Law2vA80t/paEO6VPjrQBAdWJwiUOQn+1QgNQwwX8kBTmPTl5Gap9Vl3UixvyCfjb0cAUus1Kx+oEk0YTuuEmA0w0hDtbE9ktMV+JfGJ4WggjCf/NHPGFdo/caUkNEXLlH8jdzjal3ns+aP/+Gosx7K/UtbzDMZWhOXvDOTwZqs4+PGvGW+HTftmdCArkHZIPHeOwsT7xOOaPebctY5fE1/1sm7Uel+Naow=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(3023799007)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VkdxYytWS1R2MEt6VmhtYVB1VzBPNnRDSG9ucHFTcDc5cnBqR3VTVEd5QnVO?=
 =?utf-8?B?SDdibHV0S0dwMjh1RlNsRUZwdjNZZE5xR0t1eWxvUFhnbUpDSTJQNGZyaEE4?=
 =?utf-8?B?aEtoaXNGcVJ6Qm9OY250enlLMUNqVzhGRHo3dlUyUmwweUZOTmI2TXNTSjlH?=
 =?utf-8?B?bG9leUpJVWhhbXJkWnI3WU0ybjlZVmR3SldrZGhqVDZUV1FMaFVtV0o3TGg1?=
 =?utf-8?B?Rk9GU2V5YWhVYkZzR2dVcG0raHZiS0V5NHhybFQvUU9QWjB3a1AvVzhPU2hF?=
 =?utf-8?B?UnhrV1IzVlY5N2hsaHRNTUZXOFZidHpYR1R2RCt4MEQrMGdRVnNYbm9pbktE?=
 =?utf-8?B?TzhzY1cyczc3TnRlNXorZTIvZ25Ka0MxY3NUVXlFV29zbFdrZmtTUnJwcFBj?=
 =?utf-8?B?L3RDSmZtSUZIa0cxQUtoZHQ2NHhibEhOMzBKbktZUTBVQzZFYW0zWDRHT2hV?=
 =?utf-8?B?R05GNkxuZ05sWTB5dGdYaWRjY1pKZHgxelo2TUZvVFpiN0x5S2dRRFlzT1R6?=
 =?utf-8?B?ZSt4ZmtIR1NhTVQ3djl5TGVXZXVkWmx6N2xmR3NpZTVLelFRUlV4QU9NSEly?=
 =?utf-8?B?YmhPVDEwQU5KRkRGVkdoQ3BudlBRaERJQ3hYQUpWTUQ5dVdqd1lHVzdMbWR2?=
 =?utf-8?B?OTRGVW5SMjlIWXZ1dGZ5aHZ3blBJaVBWWGpvcHhxUEd4dTNEMHVkUlJ1b1dR?=
 =?utf-8?B?RU5uUDdoK0lIb3EzaTF5bkg4aWFoc1JVMC9qOTB6YW1HZm5La0tBR1pxaElu?=
 =?utf-8?B?eGh0VFFCZmUvMG91N3VnN2szZkthdmVQek9Ob2UvajI2NVNsU1FzZGtQNGpQ?=
 =?utf-8?B?VWJVVVpoVC9FemJyR1BPOWFhZHoybEI3L2FldDFxYldidDg2TXBwemRpVHBy?=
 =?utf-8?B?R0N4dE1OcysyMFNtS05WWUpsMTRhZGM5WEhuaGZ0MCtwMFFxZUdTejVFUzRz?=
 =?utf-8?B?NWZhMFZzZlBXTXpHWWdlK2xkemdiZDVRWkpTcFBNTk85ZW11bDJWK0F3OUFi?=
 =?utf-8?B?SHBUVTZna1FRVHRuL2pweHRRTWxiWlMyMUxzcEFPTkJJaXpRbTVmWS96RSta?=
 =?utf-8?B?d0JURE9SMmZtblhrcmExcnNvR3NrYVBYd2Z3ekVMZXlab0x5V1UrMUhVcy9a?=
 =?utf-8?B?RDFvdCs1eXc2YlJVaHhhZ1plZkZBbXhtQm5hbVFueWZ1U1dNY3Mxa0tZMzBL?=
 =?utf-8?B?MnppekxuY0h2MHQ0ZXRyWWttb2xMMlAySkdUd0xjUS9mNElHK0dHekZRbjYv?=
 =?utf-8?B?QitDK2RwUkYvWE9JcUVybmRBaDlPbmwvdVI5SCtGalIxM3JPLzd6eEsrdHJT?=
 =?utf-8?B?M2pBVGdZbDlFeWtzWURsWSt4SkNhNnVuZEJnM3lMdXJCMXZYekZhSEJOck5z?=
 =?utf-8?B?ejJUdlYrdTc3NHdpQnowUlJvV0k2N0t3bDVoV0VrcUFPYVZNaGdKZFA1TzZp?=
 =?utf-8?B?YkF1RUJRNVVDbjViMDZQN05sWFhpa01LdGMrOUJBRlNydU1LMlY3ZzlDQlZz?=
 =?utf-8?B?STNWS3lOalZqd0g4WVpEa3FNUGtycksvN3ZhVzRMNjBTMWxSa2FXN1l6Mmhy?=
 =?utf-8?B?RDVqaUdFQ1QrYjFRRlZmMUg5dUpJRWNQUXRKb1BtWkJZQjRRWUcvS3pUd0ZI?=
 =?utf-8?B?ZVQ1TDI4eE5jbHpDbFFOc3JVVEJWNytQanRvMElHNnJ4ckJqajN0MkhhbnY2?=
 =?utf-8?B?SEFWR1BTQ3JIazVWRUpGLzBkU3A2Y3VYMGlSaFFSYkFPN1Voa3RZaU8vMW1U?=
 =?utf-8?B?cmZKRGVoZWExYnU3VjcrUVFPUmRZL3p2aVJWZytsYU83YWcwTXRTajNPbW5G?=
 =?utf-8?B?dmJRSU5EbGVHQkljMkVKMEdmdzJzcVlpRlpkaERwNG9yVWJvSWRRRHdLMFkw?=
 =?utf-8?B?djZjdXhEcHZGZm0zQ3I1SEVsWjV4eUhVU0Z0RytNdVcyUWJCc3RidWdJdzM4?=
 =?utf-8?B?M05CUFVnVjhOQ3ZFa2pqZ2JZcnlkTlVKakxTY0V3elZJV2R5MGxnZEpaQ25q?=
 =?utf-8?B?S0JQMmlTZ0ZwRnV5Z3Rmb2V3WDc1RThjcVdpZWFBanJoSCtoazB2MCtBeTFr?=
 =?utf-8?B?RkdjV0pFbWYvME9oTGw5TXBYZzNtMVlWRVltK3RUN3FEcFVLUGxZUE9wWFh4?=
 =?utf-8?B?SW5CdHM4VVN2OVB0ZjRneHB4bjVoVWJTUEpqQWhXZ28reDdCaVZqb2praFdp?=
 =?utf-8?B?emQ4L2czVy9odUZFVFV4SHp4ZkhYcGQ4T09pbFZpWGFVRjZlS09ENk1uK3Fv?=
 =?utf-8?B?b2kvVTV2SWV1bWUrU2VSak9Ed2RDSGZ2eHM5eGZxVlZROGZmU0dvaEFPRkFR?=
 =?utf-8?B?c1VjV3V6ZFM5L3JHY0VYQjREVkF2amh0bnJEMVlKbEVsdDNUTGFNQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd0618b-bf23-49f4-5aa0-08df040ecfc7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:42:57.3427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLxruNRPIjnABthIkDe3Mz9vID8dw4qOJwXoL+Vk3r+nK/Am7hLjAH+gCcS3GJm2+yZERKFj/J+AvAUMntexEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6812
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Aug 2026 07:43:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24039

From: Jan Kiszka <jan.kiszka@siemens.com>

Explain the automatic certificates deployment and its dependencies.
There is no longer the need to explain manual key creation, we can
simply reference the new single-key-to-efi-certs package. Keep the
manual deployment method for special causes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 doc/README.secureboot.md | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 3bcb3f58..2a387f07 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -273,32 +273,51 @@ lrwxrwxrwx 1 root root 0 Jun 30 13:20 sda5 -> ../../../../pci0000:00/0000:00:1f.
 Secureboot for a generic UEFI x86 target works similar to the QEMU target,
 except the enrollment of the secure boot keys.
 
-### Generate keys from Debian snakeoil keys
+### Generate keys from a single signing key
 
-For testing purposes, the snakeoil keys from OVMF package can be used to
-convert the certificate into a efi authority file use the following commands:
+The recipe `single-key-to-efi-certs` can be used to generate a Debian package
+that contains the required EFI certificates for enabling secure boot. It uses
+a single key/cert pair as basis. Unless otherwise configured, this pair will
+be taken from the corresponding Debian snakeoil set which is fine only for
+testing purposes. The package will contain the `.auth` files required for
+manual deployment:
 
-```bash
-cert-to-efi-sig-list recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1-snakeoil.pem PK.esl
-sign-efi-sig-list -k recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1-snakeoil.key -c recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1-snakeoil.pem PK PK.esl PK.auth
+```
+$ dpkg -c build/tmp/deploy/isar-apt/cip-core-trixie/apt/cip-core-trixie/pool/main/s/single-key-to-efi-certs/single-key-to-efi-certs_0.1_arm64.deb
+[...]
+-rw-r--r-- root/root      2549 1970-01-01 02:00 ./usr/share/secure-boot-efi-certs/KEK.auth
+-rw-r--r-- root/root      2549 1970-01-01 02:00 ./usr/share/secure-boot-efi-certs/PK.auth
+-rw-r--r-- root/root      2549 1970-01-01 02:00 ./usr/share/secure-boot-efi-certs/db.auth
 ```
 
-The package `efitools` needs to be installed for this.
+### Automatic secure boot certificate enrollment
 
-In this case, the PK.esl can be used as DB and KEK keys. The PK.auth file is for PK key.
+By default, isar-cip-core images contain an early boot service
+(initramfs-sbcerts-hook) which will deploy the required EFI certificates during
+first boot and restart the machine into secure boot afterwards. This will only
+happen when the machine is in Setup Mode and no other certificates have been
+deployed to the Allowed Signature Database yet. This also ensures that disk
+encryption on first boot will only take place when the machine was securely
+booted so that the encryption key is sealed against this state in the TPM.
 
-### Secure boot key enrollment
+The certificates needed for this auto-enrollment are taken from a package that
+provides `secure-boot-efi-certs`. The `single-key-to-efi-certs` package is the
+default provider of this in isar-cip-core.
+
+### Manual secure boot certificate enrollment
 
 > :exclamation:**IMPORTANT** This document is not for generating a Machine Owner Key(MOK).
 
 > :exclamation:**IMPORTANT** Enrollment of secure boot keys must occur
 > in a secure environment.
 
-The following keys need to be enrolled onto the device:
+The certificates for the following keys need to be enrolled onto the device:
  - The Platform Key (PK)
  - The Key Exchange Key (KEK)
  - Allowed Signatures Database
 
+You can obtain them from the single-key-to-efi-certs package described before.
+
 The enrollment can typically be achieved with the help of
 [efi-updatevar](https://manpages.debian.org/bookworm/efitools/efi-updatevar.1.en.html)
 on the device.
-- 
2.47.3


