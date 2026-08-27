Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F33AC61DC2
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 07:44:37 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31305.1787816668272890232
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Aug 2026 00:44:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tI6wRb42;
 spf=pass (domain: siemens.com, ip: 52.101.72.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPSP89jfn5zmPIDCGWsajzPI6b9pA1O3QYCMHC3sbU3XG54aoKcASdCn0Fp049hhCk5wsercwW+VbbxfLNuyPqkQ1SeKajN7qI6RwJC5SbVkbA2GOWeEulq6ad061NtP9PhSC21L5qNiuAe0SUgZ95f8dqwK6ZG6ESK3Ub2U0pEtXQNJBOXBqFyZgG3WsOhR/sqIIucYzrmRiKr9day2gT7whykZJ2Lzm1k24CXexVBQsRTHQBvr6HXxMVbYkORkcL9m92hhZgHvbfdG0CeAfl07/cO01x7JEp+2nCl4n3Prf/092+0pIhkZsxno/Xsxj9AZ2b9PR9pb5b+dBcBghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TO23f/O+alTfHV8ehMBc7t8lQYOCHbiTr/ysyPrYAw=;
 b=rTYcQGvwDXl4xFKbsr97k0frc3ljksdUtjhMqLB3/qQffO46kfWNN6Ug6XJ6c7m9IDTw5qC7UyF5lpMTXUiRIhVIPnv2jPuEoVflJ5Z4AhZ3GtW7rKZ9BbVdT1oFqqpSiY8rQMutaiH6tQCcoVIrsi83TbgwYX7eOWOcVBDD0mzQeKZxVbVQMXUvewzGh9JarYoKqjIxCE2WLy5reuaaGghTZ8CeNc9hvnG8XPmkwgztSvnK32NsJz1O2wIfBwf7hn6hZMI2vjjVX5WLVoGzmMcKKGwpEqYtSesQ2f2BF9NQtwrQHT6VkK8x6eLFStY45zL6vO4g2LdgLRnLtRpB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TO23f/O+alTfHV8ehMBc7t8lQYOCHbiTr/ysyPrYAw=;
 b=tI6wRb42PM3kcoifQRvwDq8IZXPdncgKaAZn50IvMXy2Dc2bBjRsxEzz5d5aR5oBY1h4RKoVtXHX6JxDiFBQv5zXHCe3fWzV1G71+t4m85PRKrHzvIoTOPmWD7j2FbJlKv8NCKvjyFTaCvEQpHuPCMbMtb+IX6qzo/GzJTySlMcPSmEVNHnjajyNhJR00zdeOjW2jPVOICbZRgDE+wrfhGzaBK83OH2eMnyoxb1/u+KV0+KLXjS2IiXgnSL3K25ceY23cfdFqhQuo1DAdONiAvZA4Cs7t0ia/lIdZ8bhm90ivKqYfpo1tg3Ez/9wX7CG8RltCZTPsixm3jCiixkc/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB3PR10MB6812.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:438::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:44:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0360.006; Thu, 27 Aug 2026
 07:44:22 +0000
Message-ID: <369c5862-54c1-429c-83fc-100b287f209e@siemens.com>
Date: Thu, 27 Aug 2026 09:44:21 +0200
User-Agent: Mozilla Thunderbird
Subject: [isar-cip-core][PATCH v2 8/7] doc: Update README.secureboot regarding
 recent deployment enhancements
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>
References: <cover.1787757655.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <cover.1787757655.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB3PR10MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: d8394940-23e7-411d-cc53-08df040f02b4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|6133799003|3023799007|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	gn+oi9+d7KgV+wfiLTfcd4nDGiIaF0+XvscxvqVVbwBXiY1kwkULuoq+bsUhRIFns9aI3bwz1yDO4q4WirNRArpQ9n5XAMpZ4cpbUxUtCtDxh8YdSpId0KkQ7wOFsPmLt3IfXJt1cUBjXdk8IVM2AzH5THLGNVYORBbTGU1nnoWvqBbUH3mPLA0ZX0IoXnhaXU1cddNl0Csc8ENA8toX9RMGpgpGk83ceNilKVVUeF9Al9hPQUIoSO3tAjh7qRFRWVorSQ03M0DLwSNQ8WpHPUpULrSRyn7Gzr4fOGFwKBG2jC7DDAQdBnxe4JYNLwbs8FvigvghSsHFBzjEcuVhSwg7AWALFfG2PuBdtlPagKC07dTuh2KoEsuYhQccXK1d4ZJeeZy2h1rPNlNt3EptwdIuH1+wuYr51HIhC02iJIboe4ic1K/NngECZHfsufxUnJ3d2Tyxu+RdfMPtsjmrDjFFV+k5XDquOTY1gWqehnX+l2IlrnmokHgQGAmM9NRiK+mYTubX0pnl/tkWn5r8+SHTNIWAlQcmUy4pN/qx+LcZEjFY+GJDRSUfGKE3jT01JV4TzP4m0p+hoqQNY+XenxIypCZf9rphUj1w5Csa2h7QahCSvkuf+E1wR38knT7EYW5PsrUH4YpdGf6+fyx4/UDM1I5Oqsxl+UYIG4sgJqE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(3023799007)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MDRobkF3UnUzbTZPdTNJWXZyR1hLVjJCRktDclpPNFFrYzlobVFEYTdnc3ls?=
 =?utf-8?B?QlhoM3F3cCsxaEZvaEpTY2ZaMGJqRmRGcjdocVIwamxuc2I0Qlk1c09Hb1pu?=
 =?utf-8?B?SUtlNWRrT2oyS1AyWmY0QjB4dHJVYU5JdllKWXZRL2NnR3lDUkV1dU1keU44?=
 =?utf-8?B?bWQzU1M4NElQbmZRb040ZWs0eC9xdXBRaGhPZ3pnK0VXQytPSS9GL2t0eWVB?=
 =?utf-8?B?aGkza2NiWmhzS3JGRWRnZWF1cVR5L3BGRnhKTy82R3QzQVRxVEw3TWRHenl1?=
 =?utf-8?B?K25tRkQ2NHBtZzVIRS82UlZ2djlVa1BSUEQ2YlpPYWFuUzFjWEUvaFk0eXRr?=
 =?utf-8?B?QTRxS25OaW5TaDFJNnhQOFI4R29Jb1hiRmY3bkRteXpQL1hkdEJSYkQ5cTlk?=
 =?utf-8?B?Uklkd1F3K0VibHkrbDRYNUxEUUN2WkFjZFF2SVJPVFdNbERROXYwejV5a3Na?=
 =?utf-8?B?RHcvaFRvbjluei83UDY5ZTN5eG9CT3FaL25QTUlaUlp5cS9FVmtEZkN0R0Np?=
 =?utf-8?B?NVhvNVNRQWZ3VGRob2dObnZHelErak1IZ3dBc2JVU3Rsam5qamNqd0tEWXg4?=
 =?utf-8?B?Vm94VzNHKys3U1JKVXlUNVFkRk5Vdzdxc3h3WHltenBDNTFFM0dwVlA5Zy91?=
 =?utf-8?B?cU5qeU9TRnlIV3l2QUNaNXM5eTFFMVVQQWNPT2hJVmJYVVpydDlQRE5UbDBX?=
 =?utf-8?B?T1ZTemliLzVlUWtzT1lNamJCbUNhQTlncW5uOHpnc2J0Q0dtTUp0Uk11c3ZF?=
 =?utf-8?B?cVRjbWMxaVkxb0VsT2pBcEZCNThTdDFnVC96ODVGbUlzMVd3dzdVRk9pYVlx?=
 =?utf-8?B?TENlT1hBQ0JLWDVrbG0yZ0FUR1hNS3dDaUVQL2xreG8xVVB5eDJXR3dwQ01z?=
 =?utf-8?B?WEZ5NUJTaWNOeXBISDlmck05U0s4VTRNVEFYV01JZ1Nocm1yNWJvb2hQK0R4?=
 =?utf-8?B?NURGNG5mb0w4NkJIdWdOWjh5UGtTb1V4YjVNQ0o2VmNqZE1uU1hoUFpGTmlZ?=
 =?utf-8?B?QjlrYkFoRlJZZ3F3T21MWU05ZVkwczF6K1NHU0tXWUlxa2xGZTJidTdQYlFw?=
 =?utf-8?B?UmY5aGNkWFd5OFplUGFVUTBVMWZ0cVlsb0tsT0VtOU1lWENFN282SDlRbzFm?=
 =?utf-8?B?Mzl6ZWFGT2FUMXp0YWFHTDhsRVFwd21ZMEU3bE4wWVE5M0lreWNDWTFXYnZO?=
 =?utf-8?B?NEhYcVRWM3lQNHV1Q1M5V2VoQlROb01kVXg0MzdvNVY1dmVYT2p1QlZDU1cv?=
 =?utf-8?B?T3VHRDBqdHpJekMzMnN2d0lFWG00alFleGwxRHoxU1J3bHNkK3J0YlhKeU8v?=
 =?utf-8?B?Y2V2Q2E3YndNNWRzdmFVREhEZjZPQUM0am9tZjFTWExtVWhjY0owNjBKd0RV?=
 =?utf-8?B?dDhEWFkwZmxtU0hXT3RpdWpVTjBYK0l5RHNSYVgrTDMyRlAzUSt6Vnp3RDk0?=
 =?utf-8?B?MHBoRFBrMFhXY0FOYjdGUDh2cWlLRldPVVA3WUpzTERPQzQ4a0VlcktiME0r?=
 =?utf-8?B?eWUwY2tHRDlSTisrZ0RjcmpVMEVxTGVIVnVhSmhUSTM0TDdDS0c1KzVUaVY3?=
 =?utf-8?B?aVd6RmF1REVmUldqS25FcWNnSi9PcXdKTm9QdmlSeGRGNG1maEQzVzlnYmN2?=
 =?utf-8?B?MGFpTVRhNDhLbWdzbWp0cXVMZUVCKzlPeUpjRUZHS1A5UXE3M2k2a3k4SjJm?=
 =?utf-8?B?RTJnSE1Yd1JVamRiaGdzK3U5bTVJZ0wrOHh3SFNlRkd2bXRjd3ZWRHRHZ1Zh?=
 =?utf-8?B?eVA4Z21VcGgzNUpSTGlsN0lOUGkvNGlIa1dJRVBLWWI4R0gwM1J4S3NOUlRk?=
 =?utf-8?B?QzhwejhocmJSTGpaREhacVVmeWtmcDdZdDVDdWlTUmpwdVcrS0tQOWlvbXZr?=
 =?utf-8?B?OUpGcEw0WXRIOUxuRmJLaHBGRWNPU1RHSFlRYU4vL3RzU3owSWZxd3F5SXRh?=
 =?utf-8?B?Qk82T0RwRzJJNDA0UnYzVXo3dlU2Zk90K0xpNitFZW8xM2VwYVgrcVNNTE5E?=
 =?utf-8?B?eHhGMms3WnJTVCtZRWU5RXdnTjZCb2NYYndxU0ZJREVaVWZoUFI0d1RWNVJG?=
 =?utf-8?B?bVlyT1UxSEFETEpldVcvT3VIQzNNR1pxdEJsSG5JdjRxeVQxSDZxTjFQeDlW?=
 =?utf-8?B?SjhPeGNmTmNMSmNyamN4NE9Sc3FveFR0N25Ib2kxenQ2VGhSd0JaRXZxMGl1?=
 =?utf-8?B?ME9QMmNlZDlYR1hUeG92d0Zob2g4QTliekxCWkM3SHpyYWllTm1ReUJDMTFH?=
 =?utf-8?B?YTFUSWN1eEtqc1FEVE8rMnJoMitlKyt4TTZXZXVGSmJIZXBzbk45MHRaV3o2?=
 =?utf-8?B?ZFRhUktTK3VKMnhJcEVySS82aEZzZ3pUVE54OVdaNy82L041djAydz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8394940-23e7-411d-cc53-08df040f02b4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:44:22.7644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+N1LQOI8ZZe84HJJFA+fVKW10rrSbNvvkegK88TOMtehgFmmEl+KHlw4mX3tLVYVK3LavK1Mx2IeoZ90vW5mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6812
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Aug 2026 07:44:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24040

[reposted against the correct series version, sorry]

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


