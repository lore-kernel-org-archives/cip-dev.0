Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D2DC636CC
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 13:36:31 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.54])
 by mx.groups.io with SMTP id smtpd.web11.83451.1675776986906657716
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Feb 2023 05:36:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=L6HxKa73;
 spf=pass (domain: siemens.com, ip: 40.107.104.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhHAiLvWBQRIt+OVZQcoCJaWlCISBK0gAiHm4DGl4T2O8t8H0Gsz0QVCmSWx08uR3fCLkhzgm+cEHV51PEKJ8C8NHwwtcs1KlMQ4HD80SIw/+I1TXlDxKJVcdqZKb+rGwD9VhMJknMLX23Qdebwwi3/XNStQGdjz7HgongMSFSsxG4aWuOzTo2/+4eO92wDavZY+dloRHTERdryAO1sDIzgwTSbpskjbk0fDmFy51brG4PW4iiIKJaAwpl41s7BASOTdU8/mieIAY5ZWxHwYocB0AsZGS7xnnWcS+4S0BcX5uP6Z88sY8ZmuTh9IF1y/zHmI3hx5qpmVOS6nJUpG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDZ9SgRb+rsM8dXQMjaMupiQGUgpWHtLJQUhVQ77dFI=;
 b=nZ+cVFQ6X4l1zF9dIZnmTM/8qiNmy6QNIb+4Cqta4pXXucgZ4ASNmvDEaoGaZ7LgmyJKtx0gTI+LS/nGA69XmKptG5zjTBxMnmZTXQ51BAZ5SHveZlwVh+2jEZMl2pCB7xeC6izO2Hqhw9tWiNmbBi9E/pws2XaSLVDv5ODY7rMjsZkRbcSBwOaduDPKdNOPFCsof1JEquC8pCd4LRJqqqHeN6dDeXoPcXd46CXrLKFHf7AiJQbdmFE9IjPeDvCdk9WIF4WBeFocmKtYi3godOiNjRJIVRD1djAwGvZWAQxld9eJXhHHbnm7cYM1eVKXe4D2yOrTutW0evUhLxkm9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDZ9SgRb+rsM8dXQMjaMupiQGUgpWHtLJQUhVQ77dFI=;
 b=L6HxKa731N2QNEZeSkxizdZgcpz9soAz09hnW0mmJQhWjDDoET9h2IAVnqP+y8nfHFn/+N3UMJDNKaluM3Fmct6ExQi2udIrG3TK+E2WwpLZVam+a4uvR1+l+IfWoZntOh2lJvUgOexVkAdfsvoufNJeGkKgUNL7EEX2TGbEwhDkX3oIGLx7l9RjsYCk3L7pv7fBsxYtrLXxoQf4rGdMEJX7eFlTs9Ved+i16Ejo64TmaJE8iOTNTyTWy6aN5Iuv9e/Ds1a11hB5WLryrhQgDYJXwc29cGP7j+p9ZfXLW30cuH8aqMBnUTeMoqDoIjdcARV+RgcVWn8nmPTqnCegzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7695.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:490::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Tue, 7 Feb
 2023 13:36:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.6064.035; Tue, 7 Feb 2023
 13:36:23 +0000
Message-ID: <af4a6b50-c101-bbc2-9287-63ddc6a0fcc3@siemens.com>
Date: Tue, 7 Feb 2023 14:36:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] Update Isar revision, porting to bitbake 2
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d65826-91e1-463e-2b87-08db09104e02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	l0qXItyE4u+Xjf32EATWqkW8scgQQ0oDfNRZ52nUzgYcLf78NrRVnaPclCHq1/xiBfpjFajGU+96MjJIE7NA540JEUaOC9sKVUbjp7ENH/TODdsfl6rVek49Ny273e19GZER88C/M9ZlFWuuO7PRU0rEm2oB+lsysxeL4c2OjYYj1OohJNTpqXcLOnP/ZF5PnajrBjxEVvYClRHxZhEu+2FYDZ7CoHCv2UkjQQStoSj53e4Hcb0mb5NIHDG0fFDjD+kfOrIKzvX1O2/g5FMq81dmusvaGhPmoohK2q3tCP6uvQ9jKMLWbKGPWFBToncjyaTP/q8+uSpHAZWEsjrQ4vLtH8xfwXFWsFEldWAcqBkiLwmRxCa0TBZAGIoknxe285+azk3kW1Au5/lNVMfJ9+XIKHvKuI1LtWWTsF4vXmI08BnozUZ+1dfU2Lojwl+MYWzX3SdUR2wb+wjnE4qu2nek3E4sVFqJq4j04F/vV7Mj43Oz12QsTxOjkiQVuFwICR2tEUqJ4cAyOmb1NCiOttpNap5S1j1dqbvoYqkoiTafpb3fzR5Je8doLM+6dt1bxrlPYXvE+ClC+goosoDT94W76FpfYFBgB2FkDXh9jhSFN9jbwbo3sqHTMj0iVEWuQgckeOga/J9bWpBaHvPaoces8831x/WuyTP6RcQKBOJFUGC9w5zHK96QlwkTfrOR8mrJzs53kgnaMCTWAuyu0atj6cSWr58X71B3ZQdwvABKl7JMmN4uTdGkQcZMxooWNshyngiFdEebcibGQntjKluIozpt9sDPOjIN1IiQ3PpHToIlk4D493W9IsHi7OoY7MuWVnawefPmLd5vk8uPuw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199018)(31686004)(41300700001)(316002)(6916009)(66946007)(66556008)(8676002)(8936002)(31696002)(86362001)(82960400001)(36756003)(38100700002)(186003)(6506007)(26005)(6666004)(6512007)(6486002)(15650500001)(83380400001)(5660300002)(66476007)(478600001)(30864003)(2906002)(44832011)(2616005)(966005)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eENkdmFmMk5GRUR3QXNVV1hCbjZuUnVWUHdpeWVLNU1EQnlCRHBnUXhkUHpx?=
 =?utf-8?B?YkF6M1RBNG1hZHoxL1pQbkVORFd6ZG5KRFNUSmxWdGdMQjZYWUFyRzVUdzFj?=
 =?utf-8?B?UmZEZHlBd0hMaG9SNEhyR0QzRFZ0WDV3NGlaV2oxaXprQjJYblh0cUwvRmJx?=
 =?utf-8?B?Y2RlcTJUdnczRTVkZ1dZQXEyTVJMc29lRHBMLy9mMnNGMTdCZmpWQUpJNjIr?=
 =?utf-8?B?SG5kVlZvWVNlK0VuYU12d1ZUSmRoNWgvaGc2cjJ1MUxOMFhTWklWYTNCTDlW?=
 =?utf-8?B?WEtPalhjQnZzQXBEMnRLaFVmcWpDd014WFRBTmxlTU1IM2l3ODROOGxWNjJj?=
 =?utf-8?B?aFJYcjltUmRDVk1HR2NObGRzVFc3Zm9FOSt4aTg5cFJtWExXTDNkc1M4WFRY?=
 =?utf-8?B?V3FBWmwxTXlPRjBtSXoyRlRzV3FxdWk3Z3VENFFFUGJISStFaVhVS1pCUGo2?=
 =?utf-8?B?N0YyNTAzYnl4M3gydkZOeVc0dGNTM3M0NXlVUGQ2ZjlkcGVvWEtGOWRJTndB?=
 =?utf-8?B?bTN4eFhXT002L1JwVXdWMVlCUXNqNkdRMTBDZStkNHRDaGl3c3kwaWVqWncx?=
 =?utf-8?B?UzZPb29mSG9aT0tjemlKazhYL1pKTi9FMzRVbzVuRWE5ZUs4ZlFaVm5QeE1W?=
 =?utf-8?B?ZlN1eUZPSVBmUjk5WVEvTnptN2JKRmoxakYzeDlZK1BQM2d3Uk56Q3NaUktz?=
 =?utf-8?B?U3lPQ1oycmUxYzRIanZSbzRZeHpBbGpsM3RzWmx0azh5M21xem1ZMllkYnNz?=
 =?utf-8?B?d0VTM2g2ZHZpbm1PZ0ZiaStYN2JQVklJR3k2cEZVK2pIRnpBK2J4T3QyTTd2?=
 =?utf-8?B?TTkwSXozR1gvc05DS1lod21aMWd6TW55Yk1jeGFZLzRtWUtlOVpwOWpkZmpn?=
 =?utf-8?B?NWcxenp0WUNGNEtNaWxjTTdaQlE5NmFpZjdQUXRON3pmQVdqU28vcDBRTzJk?=
 =?utf-8?B?d3pBTU94d1lIdXBHMHR4by8rQk9peDFHRjFHT2srK0J6MVIwRUk2MG1VS2lK?=
 =?utf-8?B?ODR6NE45azdDa2o5ZnR4eXE1di9sbzBnd3FxUzRnR0x3Q0gzR3ZiR0dEa2JP?=
 =?utf-8?B?dTBqZXlBaXMwNzRXMGx2cklpb3djOEpwQUdlQmxwWEdYeTBueTBhdmROcDhS?=
 =?utf-8?B?SkVyT0hMejN1ZXVqb3plcVFFWjBBRUw0eWNWKzZZcHA2ZGhCY0lsSldDK29m?=
 =?utf-8?B?SkZuMkg1LzBzRVo4Tm5VVVpKMXY2UEs2bnZHUEJWaFhQYWJlRnVnUUFzN2VK?=
 =?utf-8?B?RmFybFZmTjlOdXJXbGRPOStiUUFYR3FCSUJlRDVBaStYdUx1MkswZTdNbFF2?=
 =?utf-8?B?dmZsQm5SOGpkWnNKNkVVcnRJZURTWm5SU1ByenNuWTR3ZjkwOCtieUwxTjFl?=
 =?utf-8?B?amFXTm9TSzU1ZVNEL0lwRU5qVW5VRWVtanRDMi9LNzRJMkNjNDNmN1RMbUtJ?=
 =?utf-8?B?ekpmS1BXaHlZMFl6OWxReU12SFQvbU9NeGZBU3RUY1RZbCtwckdVWkFxelBR?=
 =?utf-8?B?RmdBd2xQRTNIRXh5NGIyV2lYTDRhTWpLNWxjbS9rT0pzVHYxWXhaQzNySkVt?=
 =?utf-8?B?Uld0clhpbkFRSVE0dUhzVXZub0hXNFpKb1NnTHNiWHk4WDVHZzRTa0NOTlNq?=
 =?utf-8?B?eUNmOGZTYVV4QUdKeE95NFJZUHl5bTFsZURQNXlyVnh2M0dzOUJQK2pQQkk1?=
 =?utf-8?B?Z29JcFJvdWFZM0pwUGVldm43NnBDam9BekpRU3liUHgrZDlsb0dSazFsOXR1?=
 =?utf-8?B?R295aGRmZUtkVzB5RDRsaVpISGZLWm1tYkEzRGxxNVhhVVlkekFFWi9CSmt0?=
 =?utf-8?B?YWZnSHBZM1Jjd2FkaHk1SHI4WC9WOWlJbmVodTU0UGRNU2l3ZnRwcDF2M25O?=
 =?utf-8?B?SlpXZlEyOW01QlJDS2hpUlRUZS82K3ZlMDZUc3JtVE1XUTFxVHk5ekF6c1hX?=
 =?utf-8?B?dEIzMVlWM01Dd3M2Tk5raUZmaW1hMEozSzRiTlFHUU12Z3U0WUZBeGJpS1d1?=
 =?utf-8?B?dUxjNzNVZDJzYmNsR1RSRHB6WnF3eEs3SE5tSkhuTFgycW1wMm03bVRDRW9l?=
 =?utf-8?B?S2hnNnMyNEM0ZlhCWkFYTXpZdlcrNlJPN1JicDg0clpmZkhTbmEvKy9pY29M?=
 =?utf-8?B?V3d4MlYzRDJvRHdVckZRV2tZK3EvdE45ODVxYmdCbThQQnFGTmNpS3RUQWVh?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d65826-91e1-463e-2b87-08db09104e02
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 13:36:23.7042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHzKlRwN28RAV0QY22AadWLJOcmeyXS3Eizee7b3IU4PtvlUcNAr4OHtUn1YElbdhzS8Bea48NGWCUX45qU3oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7695
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Feb 2023 13:36:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10626

From: Jan Kiszka <jan.kiszka@siemens.com>

Lift isar-cip-core over the bitbake 2 barrier in order to update Isar
and benefit for latest upstream fixes. This requires the override and
append/remove conversions but also a few taggings of sudo-tasks.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/image_uuid.bbclass                       |  1 +
 classes/squashfs.bbclass                         |  6 +++---
 classes/swupdate.bbclass                         |  1 +
 classes/verity.bbclass                           |  7 ++++---
 doc/README.secureboot.md                         |  4 ++--
 doc/README.security-testing.md                   |  2 +-
 kas-cip.yml                                      |  2 +-
 kas/opt/ebg-secure-boot-snakeoil.yml             |  6 +++---
 kas/opt/ebg-swu.yml                              | 16 ++++++++--------
 kas/opt/kernel-panic.yml                         |  2 +-
 kas/opt/swupdate.yml                             |  6 +++---
 kas/opt/test.yml                                 |  4 ++--
 recipes-bsp/efibootguard/efibootguard_0.13.bb    |  4 ++--
 recipes-bsp/u-boot/u-boot-bbb_2022.07.bb         |  2 +-
 recipes-bsp/u-boot/u-boot-common.inc             | 12 ++++++------
 recipes-core/customizations/common.inc           |  2 +-
 recipes-core/customizations/customizations.bb    |  2 +-
 recipes-core/images/cip-core-image-security.bb   |  4 ++--
 recipes-core/images/efibootguard.inc             |  5 ++---
 recipes-core/images/swupdate.inc                 |  2 +-
 .../kernelci-customizations.bb                   |  2 +-
 .../swupdate/swupdate_2021.11-1+debian-gbp.bb    |  4 ++--
 .../secure-boot-secrets/secure-boot-secrets.inc  |  6 +++---
 recipes-kernel/linux/linux-cip-common.inc        |  4 ++--
 24 files changed, 54 insertions(+), 52 deletions(-)

diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
index 3e2e3dee..2bd530f5 100644
--- a/classes/image_uuid.bbclass
+++ b/classes/image_uuid.bbclass
@@ -45,6 +45,7 @@ TARGET_IMAGE_UUID = "${@read_target_image_uuid(d)}"
 do_generate_image_uuid[vardeps] += "IMAGE_UUID"
 do_generate_image_uuid[depends] = "buildchroot-target:do_build"
 do_generate_image_uuid[dirs] = "${DEPLOY_DIR_IMAGE}"
+do_generate_image_uuid[network] = "${TASK_USE_SUDO}"
 do_generate_image_uuid() {
     sudo sed -i '/^IMAGE_UUID=.*/d' '${IMAGE_ROOTFS}/etc/os-release'
     echo "IMAGE_UUID=\"${IMAGE_UUID}\"" | \
diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
index 99436bcb..a06c5013 100644
--- a/classes/squashfs.bbclass
+++ b/classes/squashfs.bbclass
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-IMAGER_INSTALL_squashfs += "squashfs-tools"
+IMAGER_INSTALL:squashfs += "squashfs-tools"
 
 SQUASHFS_EXCLUDE_DIRS ?= ""
 SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
@@ -27,8 +27,8 @@ python __anonymous() {
     d.appendVar('SQUASHFS_CREATION_ARGS', args)
 }
 
-IMAGE_CMD_squashfs[depends] = "${PN}:do_transform_template"
-IMAGE_CMD_squashfs() {
+IMAGE_CMD:squashfs[depends] = "${PN}:do_transform_template"
+IMAGE_CMD:squashfs() {
     ${SUDO_CHROOT} /bin/mksquashfs \
         '${SQUASHFS_CONTENT}' '${IMAGE_FILE_CHROOT}' \
         -noappend ${SQUASHFS_CREATION_ARGS}
diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 451239e0..5eb49364 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -23,6 +23,7 @@ IMAGER_INSTALL += "${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) e
 
 do_swupdate_binary[stamp-extra-info] = "${DISTRO}-${MACHINE}"
 do_swupdate_binary[cleandirs] += "${WORKDIR}/swu"
+do_swupdate_binary[network] = "${TASK_USE_SUDO}"
 do_swupdate_binary() {
     rm -f '${SWU_IMAGE_FILE}'
     cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}' '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
diff --git a/classes/verity.bbclass b/classes/verity.bbclass
index b6b06f41..154b9e1e 100644
--- a/classes/verity.bbclass
+++ b/classes/verity.bbclass
@@ -13,8 +13,8 @@ VERITY_IMAGE_TYPE ?= "squashfs"
 
 inherit ${VERITY_IMAGE_TYPE}
 
-IMAGE_TYPEDEP_verity = "${VERITY_IMAGE_TYPE}"
-IMAGER_INSTALL_verity += "cryptsetup"
+IMAGE_TYPEDEP:verity = "${VERITY_IMAGE_TYPE}"
+IMAGER_INSTALL:verity += "cryptsetup"
 
 VERITY_INPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}"
 VERITY_OUTPUT_IMAGE ?= "${IMAGE_FULLNAME}.verity"
@@ -53,9 +53,10 @@ python calculate_verity_data_blocks() {
     d.setVar("VERITY_INPUT_IMAGE_SIZE", str(size))
     d.setVar("VERITY_DATA_BLOCKS", str(size // data_block_size))
 }
+
 do_image_verity[cleandirs] = "${WORKDIR}/verity"
 do_image_verity[prefuncs] = "calculate_verity_data_blocks"
-IMAGE_CMD_verity() {
+IMAGE_CMD:verity() {
     rm -f ${DEPLOY_DIR_IMAGE}/${VERITY_OUTPUT_IMAGE}
     rm -f ${WORKDIR}/${VERITY_IMAGE_METADATA}
 
diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 7dff37d3..50562e11 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -154,9 +154,9 @@ local_conf_header:
     IMAGE_CLASSES += "verity"
     IMAGE_FSTYPES = "wic"
     WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
-    INITRAMFS_INSTALL_append = " initramfs-verity-hook"
+    INITRAMFS_INSTALL:append = " initramfs-verity-hook"
     # abrootfs cannot be installed together with verity
-    INITRAMFS_INSTALL_remove = " initramfs-abrootfs-hook"
+    INITRAMFS_INSTALL:remove = " initramfs-abrootfs-hook"
 
 local_conf_header:
   secure-boot: |
diff --git a/doc/README.security-testing.md b/doc/README.security-testing.md
index e3d16023..c9540beb 100644
--- a/doc/README.security-testing.md
+++ b/doc/README.security-testing.md
@@ -10,7 +10,7 @@ This document explains how to verify basic implementations of [CIP security requ
     ```
     local_conf_header:
         security_testing: |
-            IMAGE_PREINSTALL_append=" sshpass"
+            IMAGE_PREINSTALL:append=" sshpass"
             ROOTFS_EXTRA="5120"
     ```
 
diff --git a/kas-cip.yml b/kas-cip.yml
index b970f39c..e999fe21 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: fc4f004eb67237d9d09b1ffad0de1a19217fa94a
+    refspec: 36ecd2fe9048829347225e90eb52ab0ca767b05a
     layers:
       meta:
 
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index e92ea5e0..a182a671 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -18,11 +18,11 @@ local_conf_header:
   secure-boot-image: |
     IMAGE_CLASSES += "verity"
     IMAGE_FSTYPES = "wic"
-    IMAGE_TYPEDEP_wic += "verity"
+    IMAGE_TYPEDEP:wic += "verity"
     WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
-    INITRAMFS_INSTALL_append = " initramfs-verity-hook"
+    INITRAMFS_INSTALL:append = " initramfs-verity-hook"
     # abrootfs cannot be installed together with verity
-    INITRAMFS_INSTALL_remove = " initramfs-abrootfs-hook"
+    INITRAMFS_INSTALL:remove = " initramfs-abrootfs-hook"
 
   secure-boot: |
     IMAGER_BUILD_DEPS += "ebg-secure-boot-signer"
diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index 6aa411b0..6bc893b3 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -18,17 +18,17 @@ local_conf_header:
   ebg_swu_bootloader: |
     WKS_FILE ?= "${MACHINE}-efibootguard.wks.in"
     SWUPDATE_BOOTLOADER = "efibootguard"
-    IMAGE_INSTALL_remove = "u-boot-script"
+    IMAGE_INSTALL:remove = "u-boot-script"
   ebg_swu_image_options: |
-    CIP_IMAGE_OPTIONS_append = " efibootguard.inc"
+    CIP_IMAGE_OPTIONS:append = " efibootguard.inc"
   initramfs: |
-    INITRAMFS_INSTALL_append = " initramfs-abrootfs-hook"
+    INITRAMFS_INSTALL:append = " initramfs-abrootfs-hook"
   firmware-binaries: |
     # Add ovmf binaries for qemu
-    IMAGER_BUILD_DEPS_append_qemu-amd64 += "ovmf-binaries"
+    IMAGER_BUILD_DEPS:append:qemu-amd64 = " ovmf-binaries"
     # not needed for Debian 11 and later
-    DISTRO_APT_SOURCES_append_qemu-amd64_buster = " conf/distro/debian-buster-backports.list"
-    DISTRO_APT_PREFERENCES_append_qemu-amd64_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
+    DISTRO_APT_SOURCES:append:qemu-amd64:buster = " conf/distro/debian-buster-backports.list"
+    DISTRO_APT_PREFERENCES:append:qemu-amd64:buster = " conf/distro/preferences.ovmf-snakeoil.conf"
     # Add U-Boot for qemu
-    IMAGER_BUILD_DEPS_append_qemu-arm64 += "u-boot-qemu-arm64"
-    IMAGER_BUILD_DEPS_append_qemu-arm += "u-boot-qemu-arm"
+    IMAGER_BUILD_DEPS:append:qemu-arm64 = " u-boot-qemu-arm64"
+    IMAGER_BUILD_DEPS:append:qemu-arm = " u-boot-qemu-arm"
diff --git a/kas/opt/kernel-panic.yml b/kas/opt/kernel-panic.yml
index 9aac8b24..fe17982b 100644
--- a/kas/opt/kernel-panic.yml
+++ b/kas/opt/kernel-panic.yml
@@ -15,4 +15,4 @@ header:
 
 local_conf_header:
   kernel-panic: |
-    IMAGE_INSTALL_append = " kernel-panic"
+    IMAGE_INSTALL:append = " kernel-panic"
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index 60a4aec3..ae5e3a16 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -16,14 +16,14 @@ header:
 
 local_conf_header:
   image-option-swupdate: |
-    CIP_IMAGE_OPTIONS_append = " swupdate.inc"
+    CIP_IMAGE_OPTIONS:append = " swupdate.inc"
 
   wic-swu: |
     IMAGE_CLASSES += "squashfs"
-    IMAGE_TYPEDEP_wic += "squashfs"
+    IMAGE_TYPEDEP:wic += "squashfs"
     IMAGE_FSTYPES = "wic"
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
-    INITRAMFS_INSTALL_append = " initramfs-squashfs-hook"
+    INITRAMFS_INSTALL:append = " initramfs-squashfs-hook"
     WIC_DEPLOY_PARTITIONS = "1"
     ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
     ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
diff --git a/kas/opt/test.yml b/kas/opt/test.yml
index 411582bd..7dd55364 100644
--- a/kas/opt/test.yml
+++ b/kas/opt/test.yml
@@ -15,5 +15,5 @@ local_conf_header:
   testing: |
     IMAGE_INSTALL += "ltp-full"
     IMAGE_PREINSTALL += "rt-tests stress-ng"
-    DESCRIPTION_append = " with test packages"
-    IMAGE_FULLNAME_append = "-test"
+    DESCRIPTION:append = " with test packages"
+    IMAGE_FULLNAME:append = "-test"
diff --git a/recipes-bsp/efibootguard/efibootguard_0.13.bb b/recipes-bsp/efibootguard/efibootguard_0.13.bb
index 79f784b0..32798540 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.13.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.13.bb
@@ -27,8 +27,8 @@ PROVIDES += "${PN}-dev"
 
 DEPENDS = "python3-shtab"
 BUILD_DEB_DEPENDS = "debhelper,autoconf-archive,check,gnu-efi,libpci-dev,pkg-config,python3-shtab,zlib1g-dev"
-BUILD_DEB_DEPENDS_append_amd64 = ",libc6-dev-i386"
-BUILD_DEB_DEPENDS_append_i386 = ",libc6-dev-i386"
+BUILD_DEB_DEPENDS:append:amd64 = ",libc6-dev-i386"
+BUILD_DEB_DEPENDS:append:i386 = ",libc6-dev-i386"
 
 inherit dpkg
 
diff --git a/recipes-bsp/u-boot/u-boot-bbb_2022.07.bb b/recipes-bsp/u-boot/u-boot-bbb_2022.07.bb
index 3be09dc1..6632bb6c 100644
--- a/recipes-bsp/u-boot/u-boot-bbb_2022.07.bb
+++ b/recipes-bsp/u-boot/u-boot-bbb_2022.07.bb
@@ -16,7 +16,7 @@ U_BOOT_BIN = "all"
 
 EFI_ARCH = "arm"
 
-do_prepare_build_append() {
+do_prepare_build:append() {
     echo "MLO u-boot.img /usr/lib/u-boot/${MACHINE}" > \
         ${S}/debian/u-boot-${MACHINE}.install
 }
diff --git a/recipes-bsp/u-boot/u-boot-common.inc b/recipes-bsp/u-boot/u-boot-common.inc
index 60f0da36..0486cdaf 100644
--- a/recipes-bsp/u-boot/u-boot-common.inc
+++ b/recipes-bsp/u-boot/u-boot-common.inc
@@ -16,21 +16,21 @@ SRC_URI += " \
     file://rules.tmpl;subdir=debian"
 SRC_URI[sha256sum] = "92b08eb49c24da14c1adbf70a71ae8f37cc53eeb4230e859ad8b6733d13dcf5e"
 
-SRC_URI_append_secureboot = " \
+SRC_URI:append:secureboot = " \
     file://secure-boot.cfg.tmpl"
 
 S = "${WORKDIR}/u-boot-${PV}"
 
 DEBIAN_BUILD_DEPENDS += ", libssl-dev:native, libssl-dev:${DISTRO_ARCH}"
 
-DEBIAN_BUILD_DEPENDS_append_secureboot = ", \
+DEBIAN_BUILD_DEPENDS:append:secureboot = ", \
     openssl, pesign, secure-boot-secrets, python3-openssl:native"
-DEPENDS_append_secureboot = " secure-boot-secrets"
+DEPENDS:append:secureboot = " secure-boot-secrets"
 
-TEMPLATE_FILES_append_secureboot = " secure-boot.cfg.tmpl"
-TEMPLATE_VARS_append_secureboot = " EFI_ARCH"
+TEMPLATE_FILES:append:secureboot = " secure-boot.cfg.tmpl"
+TEMPLATE_VARS:append:secureboot = " EFI_ARCH"
 
-do_prepare_build_append_secureboot() {
+do_prepare_build:append:secureboot() {
     sed -ni '/### Secure boot config/q;p' ${S}/configs/${U_BOOT_CONFIG}
     cat ${WORKDIR}/secure-boot.cfg >> ${S}/configs/${U_BOOT_CONFIG}
 }
diff --git a/recipes-core/customizations/common.inc b/recipes-core/customizations/common.inc
index 24c862c3..93f2fbe6 100644
--- a/recipes-core/customizations/common.inc
+++ b/recipes-core/customizations/common.inc
@@ -11,7 +11,7 @@
 
 inherit dpkg-raw
 
-FILESPATH_append := ":${FILE_DIRNAME}/files"
+FILESPATH:append := ":${FILE_DIRNAME}/files"
 
 SRC_URI = " \
     file://postinst \
diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/customizations/customizations.bb
index c057d576..ad16a906 100644
--- a/recipes-core/customizations/customizations.bb
+++ b/recipes-core/customizations/customizations.bb
@@ -13,7 +13,7 @@ require common.inc
 
 DESCRIPTION = "CIP Core image demo & customizations"
 
-do_prepare_build_prepend_qemu-riscv64() {
+do_prepare_build:prepend:qemu-riscv64() {
 	if ! grep -q serial-getty@hvc0.service ${WORKDIR}/postinst; then
 		# suppress SBI console - overlaps with serial console
 		echo >> ${WORKDIR}/postinst
diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
index 58a0f98c..bfd91bd3 100644
--- a/recipes-core/images/cip-core-image-security.bb
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -41,5 +41,5 @@ IMAGE_PREINSTALL += " \
 "
 
 # Package names based on the distro version
-IMAGE_PREINSTALL_append_buster = " libtss2-esys0"
-IMAGE_PREINSTALL_append_bullseye = " libtss2-esys-3.0.2-0"
+IMAGE_PREINSTALL:append:buster = " libtss2-esys0"
+IMAGE_PREINSTALL:append:bullseye = " libtss2-esys-3.0.2-0"
diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
index eace4fd4..26026dcf 100644
--- a/recipes-core/images/efibootguard.inc
+++ b/recipes-core/images/efibootguard.inc
@@ -9,10 +9,9 @@
 # SPDX-License-Identifier: MIT
 #
 
-IMAGE_INSTALL_append = " efibootguard"
+IMAGE_INSTALL:append = " efibootguard"
 
-WIC_IMAGER_INSTALL_append = " efibootguard"
+WIC_IMAGER_INSTALL:append = " efibootguard"
 WDOG_TIMEOUT ?= "60"
 WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
 IMAGE_FSTYPES += "wic"
-
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 9b2aedcf..ee893dd2 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -18,7 +18,7 @@ IMAGE_INSTALL += " swupdate-handler-roundrobin"
 
 ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.p4.gz"
 
-FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
+FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 
 SRC_URI += "file://sw-description.tmpl"
 TEMPLATE_FILES += "sw-description.tmpl"
diff --git a/recipes-core/kernelci-customizations/kernelci-customizations.bb b/recipes-core/kernelci-customizations/kernelci-customizations.bb
index 91ad929a..f972be5b 100644
--- a/recipes-core/kernelci-customizations/kernelci-customizations.bb
+++ b/recipes-core/kernelci-customizations/kernelci-customizations.bb
@@ -17,7 +17,7 @@ DESCRIPTION = "CIP Core KernelCI image customizations"
 
 SRC_URI += "file://dmesg.sh"
 
-do_install_append() {
+do_install:append() {
   install -v -d ${D}/opt/kernelci
   install -v -m 744 ${WORKDIR}/dmesg.sh ${D}/opt/kernelci/
 }
diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
index eb0a735f..48b5c2d0 100644
--- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
@@ -40,11 +40,11 @@ DEB_BUILD_PROFILES += "cross nocheck"
 # DEB_BUILD_PROFILES += "pkg.swupdate.embeddedlua"
 
 # modify for debian buster build
-SRC_URI_append_buster = " file://0006-debian-prepare-build-for-isar-debian-buster.patch"
+SRC_URI:append:buster = " file://0006-debian-prepare-build-for-isar-debian-buster.patch"
 
 # disable create filesystem due to missing symbols in debian buster
 # disable webserver due to missing symbols in debian buster
-DEB_BUILD_PROFILES_append_buster = " \
+DEB_BUILD_PROFILES:append:buster = " \
                                    pkg.swupdate.bpo \
                                    pkg.swupdate.nocreatefs \
                                    pkg.swupdate.nowebserver "
diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
index f53435ac..76233b34 100644
--- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
+++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
@@ -16,8 +16,8 @@ PROVIDES += "secure-boot-secrets"
 SB_KEY ??= ""
 SB_CERT ??= ""
 
-SRC_URI_append = " ${@ "file://"+d.getVar('SB_KEY') if d.getVar('SB_KEY') else '' }"
-SRC_URI_append = " ${@ "file://"+d.getVar('SB_CERT') if d.getVar('SB_CERT') else '' }"
+SRC_URI:append = " ${@ "file://"+d.getVar('SB_KEY') if d.getVar('SB_KEY') else '' }"
+SRC_URI:append = " ${@ "file://"+d.getVar('SB_CERT') if d.getVar('SB_CERT') else '' }"
 
 do_install() {
     if [ -z ${SB_KEY} ] || [ -z ${SB_CERT} ]; then
@@ -29,6 +29,6 @@ do_install() {
     install -m 0700 ${WORKDIR}/${SB_CERT} ${TARGET}/secure-boot.pem
 }
 
-do_prepare_build_append() {
+do_prepare_build:append() {
     echo "Provides: secure-boot-secrets" >> ${S}/debian/control
 }
diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 9b6cd3b0..7148a985 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -9,7 +9,7 @@
 # SPDX-License-Identifier: MIT
 #
 
-FILESEXTRAPATHS_prepend := "${FILE_DIRNAME}/files:"
+FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 
 KERNEL_DEFCONFIG ?= "${MACHINE}_defconfig"
 
@@ -19,7 +19,7 @@ SRC_URI += " \
     https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/snapshot/linux-cip-${PV}.tar.gz \
     "
 
-SRC_URI_append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protocol=https;destsuffix=cip-kernel-config;name=cip-kernel-config" \
+SRC_URI:append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protocol=https;branch=master;destsuffix=cip-kernel-config;name=cip-kernel-config" \
     if d.getVar('USE_CIP_KERNEL_CONFIG') == '1' else '' \
     }"
 
-- 
2.35.3

