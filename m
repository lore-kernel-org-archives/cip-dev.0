Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9829210A3D85
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 12:05:15 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46585.1774526713436140388
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Mar 2026 05:05:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NBV1Jw5X;
 spf=pass (domain: siemens.com, ip: 52.101.84.4, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpnkXWjDL7R7pkCoj8xTVllbxt9qbgBmX+PNqJpeBMJoYwzmtdMuKBaUu4fWYs+Y3JqD+KDz8kCHCvKmH/7+rVeiLwPBB7/4KUjDKhCe8qQhKjjJKDh5TlR4v2l92Qshz4VICSA9x83V4fxMHm/9EuRzn1P3655TG1z1smvsWmYJjh2VmImeeDDPbdqBIGLqywclL3yPl1tlfk5Fc5CRCrptfwKhSgMzwk4W13E9ZiMNfpTAx08K1ZSQP49DyI3WuYZA4T6ItlNPLdasg6d6NyGfSVUrev7HOpnFUQk1WaXNcv3hFWCBDrHOqkgD2eJIZa+i9L+z/0hO+u/aHBpTSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5X3vaJk1qCwqrqOQmLEKWqeOZsqnnbjD7vyZqY72Ln0=;
 b=w1JqOUIOUUk7Lxovt8ObgT/7rD+wKm+9TGczcdxqh6F3vPDxn8zuyzAPWfyDLRgnq8DpIs5lg4hmIsjQkRXK5k3GB8Qwk2RUu7Jebv4e8tnxtGQsLIh9NJCkvaP+YmEObCVaDNd9duQ9UBQ50tLT+rhGoyYpD6PT2E4/WZKZGH1fTO0NEvWr/5UJpNFyOkEJ00db+itrkclMxnMaVsnvHr9WZs2e2kp4Dz1UNLDLmOV1nNi7U+Klioh3k1JzFzVlOmzVzcCEI2mQkEfE8NDCSigcOAHhlhmvFKTlY2M4p+yHUi5m8sRUs4incUzcFntH4nIhftHDVRuK5FnypQSAzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5X3vaJk1qCwqrqOQmLEKWqeOZsqnnbjD7vyZqY72Ln0=;
 b=NBV1Jw5X1/wEEJpaCkRlIR6xnFQuP4ufxTnZTqH23m/rYQTe31QDO+LvjiyB+SsG314apv9mNE2258E0I5Qdv9qeXMqlS/kAKkEPzH6BQ8uPfRI0dN1s9YP0yzH4dUdD1tN1M/R1JbklLHpfgyhR5OPo1ruAZMHcZUl4Yp6r/KaKQZKRUu9f68zqM2fP/+nAhW75WM5jxf8CDPDbqBw9vPnafgaabarQzwpXgkw7pFRCyFk1amz7aJBoWJcJayaiTDBtvtrNYm5sCQ3/NP5FMtd1TdxkzyRoD7nPcAZuNvPnGh179/5uNTtW2dXlRX9L7cr7ey3DAQudoB6BZEUxtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8240.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:388::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 12:05:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 12:05:08 +0000
Message-ID: <cf8bf9cd-bb30-40eb-ac4d-2a3b27dc31d6@siemens.com>
Date: Thu, 26 Mar 2026 13:05:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH isar-cip-core v2] *: Add SPDX-License-Identifier MIT
 header
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Kamlesh Gurudasani <kamlesh@ti.com>, dinesh.kumar@toshiba-tsip.com,
 cip-dev@lists.cip-project.org, pavel@denx.de,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20260324-license-v2-1-1ca6dd83f0e8@ti.com>
 <62e3e3c2-bd72-4d60-9ee9-d460371a0955@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <62e3e3c2-bd72-4d60-9ee9-d460371a0955@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a6ed95-3f5f-406a-71d6-08de8b2fec45
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	8f2jTf+/Y6WaVGMdnwuTLTwHi5lWd3ECMhzXCBBQoFIAzk4n4hejFc1qm4PnacNGD8+VZiZEWbwpJLJ2xfTYq5QpY6FMugbPYkGjrZor83fHTx4mZMgy8dFMlPodE56AVeEoPFIl5DNxDJHgwUyQ/01P7hsP1JVX9c7aYP0JFNR6U2QLnDl3uyX8KRF2Ip6KjO/wINOxbNAgx+25TxqsPyRFVDk4bjvfNkhzhK9sP3rJxZjX4xPmORCfM/W9Sc/NkDHb0xo4297afVVWikKO7+oqA6Sxkma/ijEPnkhwhKKvErY9uoJ4vAOGKOUuOUoNByWnlOB9JrXfce/I/OPKjALBw4KHbCwBdlFGtwvYCEiZQ2NmEWH7AcVhO8kAiwY6FrzuZV/lUYFO2Ci8snAMr749k1SeX3uY04zc+JTlClKMAtNBeqyM2H+XeyhUP2AjlIoS0nh2NExv9XE8X+Cen8FFkyF7bSRYvbPRsP2zAZlJRXaL1PfYhqz/SY+0atRNVduJx+iTVu3k/GRm0IPu9+39YCuC4SHR7DlE1OpObuXVdA8sqG7HwIaa/1Ep40u1jlu7zfuZQ23YiWjcr2PuAJt6fsVL14n08A2vWTmqSEIt+RNGEUi0YvDqe6rkrqP7oSjZV7cEYcSsMGNc8Tjs5B3jgpvkV4pSgMGAxiY1aNSxKRMFHQml6HnqGhaSpQVW
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RUllQVcrQjJielYvdTc5SWkzU1ZKck5rR3hiWCtOTHZKU29jcUJON09Pbjc2?=
 =?utf-8?B?czFKTkRzcDd1Z0VHMHJDdWQ0UHgwTFpram9WYXkyOENodEJxNHhha0VEZEhV?=
 =?utf-8?B?U2k4dlJsS2UydWV1QzNPZHdmaDNqQXZkZEMwSlJHRkhkZytFUjhBNlRYeFZW?=
 =?utf-8?B?R25leURza0NDMzBMSHowYkd4d24zRU5mcFBzN1pEaEJjYWdWM0dEc3pnSnE1?=
 =?utf-8?B?N0F0SGZqUVBoSUtjOEJLVDRJVGFGYlJQUFN0TmE5eW9QeGlHQ2gybTRzNFVJ?=
 =?utf-8?B?UENvdDZBRVF5ZzBVV1gweVBNTUZzbjBvTmhvbkM2MWtFK2IwMG0wWXNySC9Q?=
 =?utf-8?B?RkkrRjV4U1VzSDFnTzhqamRhMDE5TjhHODlFN1o0ZWJhcnNIOEpjS29wTmo5?=
 =?utf-8?B?TFJ2SVdkZ2R5VDVMcnAzeS9LK3AxYVVpUi8vbE9iVWZzeDJuVjVxMzNSZm03?=
 =?utf-8?B?UUE5OU1WZ0lnK3R4dXBkYlh6YnlSYitKc2MvdStrZm5mU3hCR3FJMjNCMW5D?=
 =?utf-8?B?OVprbzYybkEzYWdvaDUvOGpPdGQzbUJ5OGlhby9wSWdjd2Y3bmVhbkNDYUIw?=
 =?utf-8?B?V3NyVnFpN1BJMzZyY09uQ0RvR0JMZko4OTBJZzJBREVvK3ZlWldGb08yZlVZ?=
 =?utf-8?B?RlRYWEFuSDhtenVWbC9qZDNFZHdUeGdEYUxIb3VFaTM0RnBKcU5TWUZxVjVG?=
 =?utf-8?B?T05CQVo4VEdzZUpDMHR1dmozQUM5Z0ZsQmVteFdhSG5vTlByOWE0ZzJ4QXY0?=
 =?utf-8?B?cFpCVDhGYjVQVjBObkp2SzNVSDU1T2lKT3VScFlNT2xIMDBXK3hoZy9rNS9i?=
 =?utf-8?B?WlJQaVU1RFc4OGtBdisvMUFiOS9QRnZPM3NHMlY1VmFSd0cza2JUc2V6Rzdn?=
 =?utf-8?B?UXRtSWRDd3NtSy9nR1k0RGVXd0pzSW9NMFo3MkJDTXN0OEpBcXBqbDFPS3RW?=
 =?utf-8?B?Y3oyc0tTeWRyVEJzcG5KbnA4bzFGdHBGYm9wS0JGRDltc2ZuOXdxNlZIeElT?=
 =?utf-8?B?RmJDc2dtOVRhZEc2NlcvVi9PcUNXbFFxNHU5bVZad1FlZzVMbEZrYWF6TUZa?=
 =?utf-8?B?QTBaYjRKck9rZ2s2S1EycjRPME9pSnAwUlBhN1hTUG0rdnl3T1F0b0ZZVHYr?=
 =?utf-8?B?dG1jQ3hhYUtyMEVmY2IyMytxN2RtSERCdEtWcEQ4TDhvQVRMVmttUHpLSFZW?=
 =?utf-8?B?ZE9pY0ZwZXFIbmlkaVVubVlWdXlGZXVaMGQ1WFZaYmhoMStqQ3B5ckFmeEVr?=
 =?utf-8?B?Tm54MTJoTGlPVERPSzN4RmFWdHkzTGVsRzRyQXl5MnE2VEt3NkNVVkYxMVNn?=
 =?utf-8?B?dnBFTE5pTmQyOExnZDFVZjdQQ0JvcU82dDllUXhIMU90YjZBK2FBclc5WjBK?=
 =?utf-8?B?MmhFVk1lUmlqOGNGZ0MrYklvcVRWK0N4aGdkQ3FLOWMvL3hVaUt4MG1OLzA5?=
 =?utf-8?B?SzZVNEVZU0FiYVFWVzN2MU5XQ2xFaHhPa3YzL0J2aUh6bTZrdVNzZGVxcHdG?=
 =?utf-8?B?MDZKazlnUU56cEpMZTB2Tm9GRGJOME5wZjMzQnVWZzUyZDNSOFdZc1NhejdO?=
 =?utf-8?B?dlVnY2UxZXhhUko3cUVzMlpOR0xnZEo4SzhtMHRMdG15azJ0MGthMTltN1FX?=
 =?utf-8?B?YzNyaWljbjNDWUZvM2psMzZ2NkxyUDJQN2N1WC9MSko5cUJpQ2k2RDZqRHZt?=
 =?utf-8?B?cERXWWNyTFNsNnkxc1NwWFIyTUE0U3MrZmQ1ZHhTYU5QU0d6WTJKTjFoRFVY?=
 =?utf-8?B?aWhVZkRuTTJqYzI3aUFja0Y0YUIzUGJxaXBDcGJMQVkrT3U0MUJ6VUFNN2hJ?=
 =?utf-8?B?R1lyRmw2VjVqMnlRdHRoZWlMY3JQODN2U1NCaE1od1IrTGpYRVZFVEgyUGhk?=
 =?utf-8?B?S01uWXoxa3N6WkJsVnd1dDdNamdyNjB2dTRNZ0daTmI2TkMweDM3WktBdzdw?=
 =?utf-8?B?S1VjQXpjbXNZcUxjczRjcDc4ak1teU44R1BicHg4ekFJOEtGVWRnTzY5bU81?=
 =?utf-8?B?cU9mb0dwaE1LTEpYSzcxT0htRXFSYkdYdTB3MmgvRjZoRVZWUlFUWHpaUkJD?=
 =?utf-8?B?TWRINFY2WWViekRGamxLU3FKK0pSY2pKcVFzQWZBR2Z6cFN3SHJpVVZMQVI3?=
 =?utf-8?B?OG9nSkZSL01WQUIrWUNIbHBleFBISmovbzFYbVdoZFdwVXlGQnVrQm8rYlpO?=
 =?utf-8?B?L0JNVFl1Zkw4eGY5UHJldkRYOGhlMGVWUmE0ckJvSytoK3NZZGpTeVo0SDhs?=
 =?utf-8?B?KzRZZHc1d21naFQwMUtxcGgxZk9rUUFsQnRKazdPeFBKYndTbFFFalkzQkNJ?=
 =?utf-8?B?VEw5K1luMEhqcXhSWUtrTENZYVFoZ1MyZllwa3NPNTFCdk9rdWZlUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a6ed95-3f5f-406a-71d6-08de8b2fec45
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:05:08.0115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Omdqhaq8rIdx/g08TifFSMsi0CBQ22QA2hpa3a/0R6EVeTTrpjHAsNcuJa867AHdtoJ9qoL+Zr4XZvxBZ3r2og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8240
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Mar 2026 12:05:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22582

On 24.03.26 15:39, Jan Kiszka wrote:
> On 24.03.26 09:40, Kamlesh Gurudasani wrote:
>> Add missing license headers to configuration, template, script,
>> and wic partition layout files to make licensing consistent
>> across the repository.
>>
>> Command Used:
>> git ls-files | xargs grep -rL SPDX-License-Identifier
>>
>> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
>> ---
>> Changes in v2:
>> - added license to remaining files
>> - Link to v1: https://lore.kernel.org/r/20260316-license-v1-1-5bb039f50c05@ti.com
>> ---
>>  conf/distro/debian-bullseye-backports.list                                       | 3 +++
>>  conf/distro/debian-buster-backports.list                                         | 3 +++
>>  conf/distro/preferences.ovmf-snakeoil.conf                                       | 3 +++
>>  conf/distro/preferences.swupdate-bullseye-backports.conf                         | 3 +++
>>  recipes-bsp/u-boot/files/ftpm-stmm.cfg                                           | 3 +++
>>  recipes-bsp/u-boot/files/no-grub-workaround.cfg                                  | 3 +++
>>  recipes-bsp/u-boot/files/qemu-extra.cfg                                          | 3 +++
>>  recipes-bsp/u-boot/files/secure-boot.cfg                                         | 3 +++
>>  recipes-bsp/u-boot/files/ti-extra.cfg                                            | 3 +++
>>  recipes-core/customizations/files/99-silent-printk.conf                          | 3 +++
>>  recipes-core/customizations/files/99-watchdog.conf                               | 3 +++
>>  recipes-core/customizations/files/ssh-permit-root.conf                           | 3 +++
>>  recipes-core/home-fs/files/home.mount                                            | 3 +++
>>  recipes-core/home-fs/files/postinst                                              | 3 +++
>>  recipes-core/immutable-rootfs/files/95-disable-package-updates.preset            | 3 +++
>>  recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl               | 3 +++
>>  recipes-core/immutable-rootfs/files/postinst                                     | 3 +++
>>  recipes-core/journald-config/files/persistent-journal.conf                       | 3 +++
>>  recipes-core/kernel-panic/files/sysrq-panic.service                              | 3 +++
>>  recipes-core/ltp/files/debian/control.tmpl                                       | 3 +++
>>  recipes-core/ltp/files/debian/rules                                              | 3 +++
>>  recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl               | 3 +++
>>  recipes-core/security-customizations/files/postinst                              | 2 ++
>>  recipes-core/security-customizations/files/ssh-pam-remote.conf                   | 3 +++
>>  recipes-core/security-customizations/files/ssh-remote-session-term.conf          | 3 +++
>>  recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl                   | 3 +++
>>  recipes-core/swupdate-config/files/hwrevision.tmpl                               | 3 +++
>>  recipes-core/swupdate-config/files/swupdate.cfg                                  | 3 +++
>>  recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini | 3 +++
>>  recipes-core/tmp-fs/files/postinst                                               | 3 +++
>>  recipes-devtools/swupdate-signer/files/sign-swu-cms                              | 3 +++
>>  recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl          | 3 +++
>>  recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf                      | 3 +++
>>  recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl   | 2 ++
>>  recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl              | 3 +++
>>  recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl                 | 2 ++
>>  recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script    | 2 ++
>>  recipes-kernel/linux/files/no-module-signing.cfg                                 | 3 +++
>>  recipes-kernel/linux/files/no-tpm-hwrng.cfg                                      | 3 +++
>>  recipes-kernel/linux/files/preempt-rt.cfg                                        | 3 +++
>>  recipes-security/fail2ban-config/files/systemd-defaults.conf                     | 3 +++
>>  scripts/deploy-cip-core.sh                                                       | 3 +++
>>  scripts/generate-sb-db-from-existing-certificate.sh                              | 3 +++
>>  scripts/generate_secure_boot_keys.sh                                             | 3 +++
>>  scripts/start-efishell.sh                                                        | 3 +++
>>  scripts/submit_lava.sh                                                           | 3 +++
>>  scripts/update-linux-cip.sh                                                      | 3 +++
>>  scripts/update-ltp.sh                                                            | 3 +++
>>  tests/templates/IEC_template.yml                                                 | 3 +++
>>  tests/templates/secureboot_corrupt_rootfs_steps.yml                              | 3 +++
>>  tests/templates/secureboot_negative_test.yml                                     | 3 +++
>>  tests/templates/secureboot_template.yml                                          | 3 +++
>>  tests/templates/secureboot_unsigned_bootloader_steps.yml                         | 3 +++
>>  tests/templates/secureboot_unsigned_kernel_steps.yml                             | 3 +++
>>  tests/templates/swupdate-test-action-M-COM.yml                                   | 3 +++
>>  tests/templates/swupdate_corrupt_swu_artifact_steps.yml                          | 3 +++
>>  tests/templates/swupdate_corrupt_swu_steps.yml                                   | 3 +++
>>  tests/templates/swupdate_negative_test.yml                                       | 3 +++
>>  tests/templates/swupdate_reboot_without_confirm.yml                              | 3 +++
>>  tests/templates/swupdate_same_uuid_steps.yml                                     | 3 +++
>>  tests/templates/swupdate_template.yml                                            | 3 +++
>>  wic/ebg-signed-sysparts.inc                                                      | 3 +++
>>  wic/ebg-sysparts.inc                                                             | 3 +++
>>  wic/hihope-rzg2m-efibootguard.wks.in                                             | 3 +++
>>  wic/qemu-arm64-efibootguard-secureboot.wks.in                                    | 3 +++
>>  wic/qemu-arm64-efibootguard.wks.in                                               | 3 +++
>>  wic/qemu-riscv64-efibootguard.wks.in                                             | 3 +++
>>  wic/x86-uefi-efibootguard-secureboot.wks.in                                      | 3 +++
>>  wic/x86-uefi-efibootguard.wks.in                                                 | 3 +++
>>  69 files changed, 203 insertions(+)
>>
>> diff --git a/conf/distro/debian-bullseye-backports.list b/conf/distro/debian-bullseye-backports.list
>> index 1594907..6107928 100644
>> --- a/conf/distro/debian-bullseye-backports.list
>> +++ b/conf/distro/debian-bullseye-backports.list
>> @@ -1 +1,4 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  deb http://archive.debian.org/debian bullseye-backports main contrib non-free
>> diff --git a/conf/distro/debian-buster-backports.list b/conf/distro/debian-buster-backports.list
>> index 7134a35..842019e 100644
>> --- a/conf/distro/debian-buster-backports.list
>> +++ b/conf/distro/debian-buster-backports.list
>> @@ -1 +1,4 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  deb http://archive.debian.org/debian buster-backports main contrib non-free
>> diff --git a/conf/distro/preferences.ovmf-snakeoil.conf b/conf/distro/preferences.ovmf-snakeoil.conf
>> index b51d1d4..25b7da4 100644
>> --- a/conf/distro/preferences.ovmf-snakeoil.conf
>> +++ b/conf/distro/preferences.ovmf-snakeoil.conf
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  Package: ovmf
>>  Pin: release n=buster-backports
>>  Pin-Priority: 801
>> diff --git a/conf/distro/preferences.swupdate-bullseye-backports.conf b/conf/distro/preferences.swupdate-bullseye-backports.conf
>> index c5f6685..da307cd 100644
>> --- a/conf/distro/preferences.swupdate-bullseye-backports.conf
>> +++ b/conf/distro/preferences.swupdate-bullseye-backports.conf
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  Package: dh-nodejs
>>  Pin: release n=bullseye-backports
>>  Pin-Priority: 801
>> diff --git a/recipes-bsp/u-boot/files/ftpm-stmm.cfg b/recipes-bsp/u-boot/files/ftpm-stmm.cfg
>> index af5da93..a6fe2a3 100644
>> --- a/recipes-bsp/u-boot/files/ftpm-stmm.cfg
>> +++ b/recipes-bsp/u-boot/files/ftpm-stmm.cfg
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  ### Enable OPTEE, fTPM and StMM
>>  CONFIG_TEE=y
>>  CONFIG_OPTEE=y
>> diff --git a/recipes-bsp/u-boot/files/no-grub-workaround.cfg b/recipes-bsp/u-boot/files/no-grub-workaround.cfg
>> index dc09edd..8a01ff6 100644
>> --- a/recipes-bsp/u-boot/files/no-grub-workaround.cfg
>> +++ b/recipes-bsp/u-boot/files/no-grub-workaround.cfg
>> @@ -1,2 +1,5 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  ### Disable grub workaround
>>  # CONFIG_EFI_GRUB_ARM32_WORKAROUND is not set
>> diff --git a/recipes-bsp/u-boot/files/qemu-extra.cfg b/recipes-bsp/u-boot/files/qemu-extra.cfg
>> index e643db7..5380ad8 100644
>> --- a/recipes-bsp/u-boot/files/qemu-extra.cfg
>> +++ b/recipes-bsp/u-boot/files/qemu-extra.cfg
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  ### QEMU extra config
>>  CONFIG_MMC=y
>>  CONFIG_SUPPORT_EMMC_RPMB=y
>> diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg b/recipes-bsp/u-boot/files/secure-boot.cfg
>> index 694356f..7b09a53 100644
>> --- a/recipes-bsp/u-boot/files/secure-boot.cfg
>> +++ b/recipes-bsp/u-boot/files/secure-boot.cfg
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  ### Secure boot config
>>  # CONFIG_BOOTSTD_DEFAULTS is not set
>>  # CONFIG_BOOTMETH_CROS is not set
>> diff --git a/recipes-bsp/u-boot/files/ti-extra.cfg b/recipes-bsp/u-boot/files/ti-extra.cfg
>> index c10d046..9500055 100644
>> --- a/recipes-bsp/u-boot/files/ti-extra.cfg
>> +++ b/recipes-bsp/u-boot/files/ti-extra.cfg
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  ### FTPM + RPMB + StandaloneMM setup
>>  CONFIG_OPTEE_SERVICE_DISCOVERY=y
>>  CONFIG_TPM=y
>> diff --git a/recipes-core/customizations/files/99-silent-printk.conf b/recipes-core/customizations/files/99-silent-printk.conf
>> index ad24d3a..c5b3799 100644
>> --- a/recipes-core/customizations/files/99-silent-printk.conf
>> +++ b/recipes-core/customizations/files/99-silent-printk.conf
>> @@ -1 +1,4 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  kernel.printk = 3 4 1 3
>> diff --git a/recipes-core/customizations/files/99-watchdog.conf b/recipes-core/customizations/files/99-watchdog.conf
>> index c02756d..1f38c55 100644
>> --- a/recipes-core/customizations/files/99-watchdog.conf
>> +++ b/recipes-core/customizations/files/99-watchdog.conf
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  [Manager]
>>  RuntimeWatchdogSec=60s
>>  ShutdownWatchdogSec=60s
>> diff --git a/recipes-core/customizations/files/ssh-permit-root.conf b/recipes-core/customizations/files/ssh-permit-root.conf
>> index 1073982..ab26ab5 100644
>> --- a/recipes-core/customizations/files/ssh-permit-root.conf
>> +++ b/recipes-core/customizations/files/ssh-permit-root.conf
>> @@ -1 +1,4 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  PermitRootLogin yes
>> diff --git a/recipes-core/home-fs/files/home.mount b/recipes-core/home-fs/files/home.mount
>> index 062517a..653495c 100644
>> --- a/recipes-core/home-fs/files/home.mount
>> +++ b/recipes-core/home-fs/files/home.mount
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  [Unit]
>>  Description=Mount /home partition
>>  Before=local-fs.target
>> diff --git a/recipes-core/home-fs/files/postinst b/recipes-core/home-fs/files/postinst
>> index ab0db84..904aa73 100755
>> --- a/recipes-core/home-fs/files/postinst
>> +++ b/recipes-core/home-fs/files/postinst
>> @@ -1,4 +1,7 @@
>>  #!/bin/sh
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  
>>  set -e
>>  
>> diff --git a/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset b/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset
>> index 7e6e9ef..b3b52ce 100644
>> --- a/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset
>> +++ b/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  disable apt-daily.timer
>>  disable apt-daily-upgrade.timer
>>  disable dpkg-db-backup.timer
>> diff --git a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
>> index e6d25d2..4cdfc6f 100644
>> --- a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
>> +++ b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  L /var/lib/dpkg - - - - ${IMMUTABLE_DATA_DIR}/var/lib/dpkg
>>  d /var/log/audit 0700 root adm -
>>  d /var/lib/apt 0755 root root -
>> diff --git a/recipes-core/immutable-rootfs/files/postinst b/recipes-core/immutable-rootfs/files/postinst
>> index a6e1962..3b8071e 100644
>> --- a/recipes-core/immutable-rootfs/files/postinst
>> +++ b/recipes-core/immutable-rootfs/files/postinst
>> @@ -1,4 +1,7 @@
>>  #!/bin/sh
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  
>>  set -e
>>  
>> diff --git a/recipes-core/journald-config/files/persistent-journal.conf b/recipes-core/journald-config/files/persistent-journal.conf
>> index 21dfde0..3e3419f 100644
>> --- a/recipes-core/journald-config/files/persistent-journal.conf
>> +++ b/recipes-core/journald-config/files/persistent-journal.conf
>> @@ -1,2 +1,5 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  [Journal]
>>  Storage=persistent
>> diff --git a/recipes-core/kernel-panic/files/sysrq-panic.service b/recipes-core/kernel-panic/files/sysrq-panic.service
>> index 4f199fe..e892165 100644
>> --- a/recipes-core/kernel-panic/files/sysrq-panic.service
>> +++ b/recipes-core/kernel-panic/files/sysrq-panic.service
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  [Unit]
>>  Description=sysrq panic
>>  
>> diff --git a/recipes-core/ltp/files/debian/control.tmpl b/recipes-core/ltp/files/debian/control.tmpl
>> index 0bfc0c2..a7d0087 100644
>> --- a/recipes-core/ltp/files/debian/control.tmpl
>> +++ b/recipes-core/ltp/files/debian/control.tmpl
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  Source: ltp-full
>>  Section: embedded
>>  Priority: optional
>> diff --git a/recipes-core/ltp/files/debian/rules b/recipes-core/ltp/files/debian/rules
>> index 4e1747c..32d3c29 100755
>> --- a/recipes-core/ltp/files/debian/rules
>> +++ b/recipes-core/ltp/files/debian/rules
>> @@ -1,4 +1,7 @@
>>  #!/usr/bin/make -f
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  export DEB_CFLAGS_MAINT_APPEND  = -Wall  -Wno-format-security
>>  export DEB_BUILD_MAINT_OPTIONS=hardening=-branch
>>  
>> diff --git a/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl b/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
>> index 92e4a30..1821f92 100644
>> --- a/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
>> +++ b/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
>> @@ -1,2 +1,5 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  L /home - - - - /var/home
>>  C /var/home - - - - ${IMMUTABLE_DATA_DIR}/home
>> diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
>> index f8ebf9e..788e225 100755
>> --- a/recipes-core/security-customizations/files/postinst
>> +++ b/recipes-core/security-customizations/files/postinst
>> @@ -3,6 +3,8 @@
>>  # CIP Security, generic profile
>>  # Security Package configurations
>>  #
>> +# SPDX-License-Identifier: MIT
>> +#
>>  
>>  set -e
>>  
>> diff --git a/recipes-core/security-customizations/files/ssh-pam-remote.conf b/recipes-core/security-customizations/files/ssh-pam-remote.conf
>> index d460b0c..ea120b2 100644
>> --- a/recipes-core/security-customizations/files/ssh-pam-remote.conf
>> +++ b/recipes-core/security-customizations/files/ssh-pam-remote.conf
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  # Enable PAM configuration for Remote Session
>>  ChallengeResponseAuthentication yes
>>  KbdInteractiveAuthentication yes
>> diff --git a/recipes-core/security-customizations/files/ssh-remote-session-term.conf b/recipes-core/security-customizations/files/ssh-remote-session-term.conf
>> index d11b92e..171ea9b 100644
>> --- a/recipes-core/security-customizations/files/ssh-remote-session-term.conf
>> +++ b/recipes-core/security-customizations/files/ssh-remote-session-term.conf
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  # CR2.6: Remote session termination
>>  # Terminate remote session after inactive time period
>>  
>> diff --git a/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl b/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
>> index 744b426..f750f3d 100644
>> --- a/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
>> +++ b/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
>> @@ -1 +1,4 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  SWUPDATE_SURICATTA_ARGS="--server lua -u ${WFX_URL} -i $(cat /etc/machine-id)"
>> diff --git a/recipes-core/swupdate-config/files/hwrevision.tmpl b/recipes-core/swupdate-config/files/hwrevision.tmpl
>> index 1eb0996..b937200 100644
>> --- a/recipes-core/swupdate-config/files/hwrevision.tmpl
>> +++ b/recipes-core/swupdate-config/files/hwrevision.tmpl
>> @@ -1 +1,4 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  cip-${MACHINE} ${MACHINE_HW_VERSION}
>> diff --git a/recipes-core/swupdate-config/files/swupdate.cfg b/recipes-core/swupdate-config/files/swupdate.cfg
>> index 3e2b45c..5c05fbe 100644
>> --- a/recipes-core/swupdate-config/files/swupdate.cfg
>> +++ b/recipes-core/swupdate-config/files/swupdate.cfg
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  globals :
>>  {
>>      bootloader = "ebg";
>> diff --git a/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
>> index 58271da..8f93cc9 100644
>> --- a/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
>> +++ b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  [image]
>>  chainhandler=raw
>>  
>> diff --git a/recipes-core/tmp-fs/files/postinst b/recipes-core/tmp-fs/files/postinst
>> index 39067f1..ae0f74a 100755
>> --- a/recipes-core/tmp-fs/files/postinst
>> +++ b/recipes-core/tmp-fs/files/postinst
>> @@ -1,4 +1,7 @@
>>  #!/bin/sh
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  
>>  set -e
>>  
>> diff --git a/recipes-devtools/swupdate-signer/files/sign-swu-cms b/recipes-devtools/swupdate-signer/files/sign-swu-cms
>> index cb0cd4a..bc1ec13 100644
>> --- a/recipes-devtools/swupdate-signer/files/sign-swu-cms
>> +++ b/recipes-devtools/swupdate-signer/files/sign-swu-cms
>> @@ -1,4 +1,7 @@
>>  #!/bin/sh
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  in_file=$1
>>  out_file=$2
>>  inkey="/usr/share/swupdate-signing/swupdate-sign.key"
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>> index bb93361..452714d 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  PARTITIONS="${CRYPT_PARTITIONS}"
>>  CREATE_FILE_SYSTEM_CMD="${CRYPT_CREATE_FILE_SYSTEM_CMD}"
>>  SETUP_TIMEOUT="${CRYPT_SETUP_TIMEOUT}"
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf b/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf
>> index d4c8981..8e087f2 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  # we don't have a dictionary in the initramfs
>>  # this solves the error "Password generation failed - required entropy too low for settings"
>>  dictcheck = 0
>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
>> index f0ad40c..94b5f8b 100644
>> --- a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
>> @@ -7,6 +7,8 @@
>>  # Authors:
>>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>  #
>> +# SPDX-License-Identifier: MIT
>> +#
>>  . /usr/share/factory-reset/reset-env
>>  
>>  . /scripts/cip-initramfs-functions
>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
>> index d3e18a2..07e2376 100644
>> --- a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
>> @@ -1,3 +1,6 @@
>>  #!/bin/sh
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  INITRAMFS_FACTORY_RESET_DEVICES="${INITRAMFS_FACTORY_RESET_DEVICES}"
>>  INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE="${INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE}"
>> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
>> index bce588c..8a697f8 100644
>> --- a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
>> @@ -7,6 +7,8 @@
>>  #  Jan Kiszka <jan.kiszka@siemens.com>
>>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>  #
>> +# SPDX-License-Identifier: MIT
>> +#
>>  
>>  ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
>>  ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
>> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
>> index 0cd084b..11ca731 100644
>> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
>> @@ -7,6 +7,8 @@
>>  # Authors:
>>  #  Clara Kowalsky <clara.kowalsky@siemens.com>
>>  #
>> +# SPDX-License-Identifier: MIT
>> +#
>>  
>>  partition_fstype="$1"
>>  ovl_partition_device="$2"
>> diff --git a/recipes-kernel/linux/files/no-module-signing.cfg b/recipes-kernel/linux/files/no-module-signing.cfg
>> index ab54f68..064ef9c 100644
>> --- a/recipes-kernel/linux/files/no-module-signing.cfg
>> +++ b/recipes-kernel/linux/files/no-module-signing.cfg
>> @@ -1,2 +1,5 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  # CONFIG_SECURITY_LOCKDOWN_LSM is not set
>>  # CONFIG_MODULE_SIG is not set
>> diff --git a/recipes-kernel/linux/files/no-tpm-hwrng.cfg b/recipes-kernel/linux/files/no-tpm-hwrng.cfg
>> index ab46cd8..08e98ff 100644
>> --- a/recipes-kernel/linux/files/no-tpm-hwrng.cfg
>> +++ b/recipes-kernel/linux/files/no-tpm-hwrng.cfg
>> @@ -1,2 +1,5 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  # see https://lore.kernel.org/lkml/bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com/
>>  # CONFIG_HW_RANDOM_TPM is not set
>> diff --git a/recipes-kernel/linux/files/preempt-rt.cfg b/recipes-kernel/linux/files/preempt-rt.cfg
>> index afbf53d..f558365 100644
>> --- a/recipes-kernel/linux/files/preempt-rt.cfg
>> +++ b/recipes-kernel/linux/files/preempt-rt.cfg
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  # >= 5.10
>>  CONFIG_EXPERT=y
>>  CONFIG_PREEMPT_RT=y
>> diff --git a/recipes-security/fail2ban-config/files/systemd-defaults.conf b/recipes-security/fail2ban-config/files/systemd-defaults.conf
>> index 16e0d5e..32a8e48 100644
>> --- a/recipes-security/fail2ban-config/files/systemd-defaults.conf
>> +++ b/recipes-security/fail2ban-config/files/systemd-defaults.conf
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  [DEFAULT]
>>  
>>  syslog_backend = systemd
>> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
>> index 623c216..1e08e47 100755
>> --- a/scripts/deploy-cip-core.sh
>> +++ b/scripts/deploy-cip-core.sh
>> @@ -1,4 +1,7 @@
>>  #!/bin/sh
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  
>>  set -e
>>  
>> diff --git a/scripts/generate-sb-db-from-existing-certificate.sh b/scripts/generate-sb-db-from-existing-certificate.sh
>> index dddd9b5..42d09dd 100755
>> --- a/scripts/generate-sb-db-from-existing-certificate.sh
>> +++ b/scripts/generate-sb-db-from-existing-certificate.sh
>> @@ -1,4 +1,7 @@
>>  #!/bin/sh
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  
>>  set -e
>>  
>> diff --git a/scripts/generate_secure_boot_keys.sh b/scripts/generate_secure_boot_keys.sh
>> index 8be0569..28ae34c 100755
>> --- a/scripts/generate_secure_boot_keys.sh
>> +++ b/scripts/generate_secure_boot_keys.sh
>> @@ -1,4 +1,7 @@
>>  #!/bin/sh
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  
>>  set -e
>>  
>> diff --git a/scripts/start-efishell.sh b/scripts/start-efishell.sh
>> index fff8a6a..86e2ddd 100755
>> --- a/scripts/start-efishell.sh
>> +++ b/scripts/start-efishell.sh
>> @@ -1,4 +1,7 @@
>>  #!/bin/sh
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  
>>  set -e
>>  
>> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
>> index b3180a1..a4d20ec 100755
>> --- a/scripts/submit_lava.sh
>> +++ b/scripts/submit_lava.sh
>> @@ -1,4 +1,7 @@
>>  #!/bin/bash
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  # Copyright (C) 2024, Renesas Electronics Europe GmbH
>>  # Chris Paterson <chris.paterson2@renesas.com>
>>  # Sai Ashrith <sai.sathujoda@toshiba-tsip.com>
>> diff --git a/scripts/update-linux-cip.sh b/scripts/update-linux-cip.sh
>> index 5fbfa57..df306b2 100755
>> --- a/scripts/update-linux-cip.sh
>> +++ b/scripts/update-linux-cip.sh
>> @@ -1,4 +1,7 @@
>>  #!/bin/bash
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  REPO_ROOT=$(git rev-parse --show-toplevel)
>>  pushd "${REPO_ROOT}"/recipes-kernel/linux >/dev/null || exit 1
>>  
>> diff --git a/scripts/update-ltp.sh b/scripts/update-ltp.sh
>> index dc8b947..321cc3c 100755
>> --- a/scripts/update-ltp.sh
>> +++ b/scripts/update-ltp.sh
>> @@ -1,4 +1,7 @@
>>  #!/bin/bash
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  
>>  REPO_ROOT=$(git rev-parse --show-toplevel)
>>  pushd "${REPO_ROOT}"/recipes-core/ltp > /dev/null || exit
>> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
>> index f8558cd..148f07e 100644
>> --- a/tests/templates/IEC_template.yml
>> +++ b/tests/templates/IEC_template.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  device_type: qemu
>>  job_name: #architecture# IEC layer testing
>>  timeouts:
>> diff --git a/tests/templates/secureboot_corrupt_rootfs_steps.yml b/tests/templates/secureboot_corrupt_rootfs_steps.yml
>> index b6f6628..5c47b30 100644
>> --- a/tests/templates/secureboot_corrupt_rootfs_steps.yml
>> +++ b/tests/templates/secureboot_corrupt_rootfs_steps.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>            - "apt-get update"
>>            - "apt install -y fdisk"
>>            - "rootfs_start_sector=$(fdisk -l -o Name,Start cip-core-image-security-cip-core-#distribution#-#architecture#.wic | awk -v name=systema '$0 ~ name {print $2}')"
>> diff --git a/tests/templates/secureboot_negative_test.yml b/tests/templates/secureboot_negative_test.yml
>> index 2fcdbfa..a8e4226 100644
>> --- a/tests/templates/secureboot_negative_test.yml
>> +++ b/tests/templates/secureboot_negative_test.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  device_type: qemu
>>  job_name: #architecture# secure boot testing
>>  timeouts:
>> diff --git a/tests/templates/secureboot_template.yml b/tests/templates/secureboot_template.yml
>> index e29b64a..0a075e2 100644
>> --- a/tests/templates/secureboot_template.yml
>> +++ b/tests/templates/secureboot_template.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  device_type: qemu
>>  job_name: #architecture# secure boot testing
>>  timeouts:
>> diff --git a/tests/templates/secureboot_unsigned_bootloader_steps.yml b/tests/templates/secureboot_unsigned_bootloader_steps.yml
>> index 8d64b05..f4f4043 100644
>> --- a/tests/templates/secureboot_unsigned_bootloader_steps.yml
>> +++ b/tests/templates/secureboot_unsigned_bootloader_steps.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>            - "apt-get update"
>>            - "apt install --yes guestfish sbsigntool"
>>            - "guestfish add cip-core-image-security-cip-core-#distribution#-#architecture#.wic : run : mount /dev/sda1 / : copy-out /EFI/BOOT/bootx64.efi ."
>> diff --git a/tests/templates/secureboot_unsigned_kernel_steps.yml b/tests/templates/secureboot_unsigned_kernel_steps.yml
>> index f097ed6..6ab334a 100644
>> --- a/tests/templates/secureboot_unsigned_kernel_steps.yml
>> +++ b/tests/templates/secureboot_unsigned_kernel_steps.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>            - "apt-get update"
>>            - "apt install --yes guestfish sbsigntool"
>>            - "guestfish add cip-core-image-security-cip-core-#distribution#-#architecture#.wic : run : mount /dev/sda2 / : copy-out /linux.efi ."
>> diff --git a/tests/templates/swupdate-test-action-M-COM.yml b/tests/templates/swupdate-test-action-M-COM.yml
>> index 56ff106..69c9cb7 100644
>> --- a/tests/templates/swupdate-test-action-M-COM.yml
>> +++ b/tests/templates/swupdate-test-action-M-COM.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  # TEST BLOCK 1
>>  # Fail the job if software update application failed
>>  - test:
>> diff --git a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml b/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>> index 2fad3fd..043867e 100644
>> --- a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>> +++ b/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#architecture#.swu --output /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
>>              - mkdir -p swu
>>              - cpio -ivd --directory=/root/swu < /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
>> diff --git a/tests/templates/swupdate_corrupt_swu_steps.yml b/tests/templates/swupdate_corrupt_swu_steps.yml
>> index 74c9217..3cdb793 100644
>> --- a/tests/templates/swupdate_corrupt_swu_steps.yml
>> +++ b/tests/templates/swupdate_corrupt_swu_steps.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#architecture#.swu --output /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
>>              - mkdir -p swu
>>              - dd if=/dev/zero of=/root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu bs=1M count=5
>> diff --git a/tests/templates/swupdate_negative_test.yml b/tests/templates/swupdate_negative_test.yml
>> index bb79b07..250eaa8 100644
>> --- a/tests/templates/swupdate_negative_test.yml
>> +++ b/tests/templates/swupdate_negative_test.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  device_type: qemu
>>  job_name: #architecture# software update testing
>>  timeouts:
>> diff --git a/tests/templates/swupdate_reboot_without_confirm.yml b/tests/templates/swupdate_reboot_without_confirm.yml
>> index bfad106..074eb1a 100644
>> --- a/tests/templates/swupdate_reboot_without_confirm.yml
>> +++ b/tests/templates/swupdate_reboot_without_confirm.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  # qemu-swtpm.sock will be gone after soft reboot.
>>  # So the swtpm socket need to be started again for proper reboot
>>  # To start the swtpm daemon, first the existing one should be killed
>> diff --git a/tests/templates/swupdate_same_uuid_steps.yml b/tests/templates/swupdate_same_uuid_steps.yml
>> index 3ff2e02..8329055 100644
>> --- a/tests/templates/swupdate_same_uuid_steps.yml
>> +++ b/tests/templates/swupdate_same_uuid_steps.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#architecture#.swu --output /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
>>              - mkdir -p swu
>>              - cpio -ivd --directory=/root/swu < /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
>> diff --git a/tests/templates/swupdate_template.yml b/tests/templates/swupdate_template.yml
>> index e1f71a9..9a3366b 100644
>> --- a/tests/templates/swupdate_template.yml
>> +++ b/tests/templates/swupdate_template.yml
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  device_type: qemu
>>  job_name: #architecture# software update testing
>>  timeouts:
>> diff --git a/wic/ebg-signed-sysparts.inc b/wic/ebg-signed-sysparts.inc
>> index c35878f..8210598 100644
>> --- a/wic/ebg-signed-sysparts.inc
>> +++ b/wic/ebg-signed-sysparts.inc
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  # default partition layout EFI Boot Guard usage, signed version
>>  
>>  # EFI partition containing efibootguard bootloader binary
>> diff --git a/wic/ebg-sysparts.inc b/wic/ebg-sysparts.inc
>> index 0290024..b7f1afa 100644
>> --- a/wic/ebg-sysparts.inc
>> +++ b/wic/ebg-sysparts.inc
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  # default partition layout EFI Boot Guard usage
>>  
>>  # EFI partition containing efibootguard bootloader binary
>> diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
>> index fdbad14..99c8d10 100644
>> --- a/wic/hihope-rzg2m-efibootguard.wks.in
>> +++ b/wic/hihope-rzg2m-efibootguard.wks.in
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  # short-description: RZ/G2M image with EFI Boot Guard and SWUpdate
>>  # long-description: Disk image for HiHope RZ/G2M board with EFI Boot Guard and SWUpdate
>>  
>> diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
>> index 941a552..88eb91c 100644
>> --- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
>> +++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  include ebg-signed-sysparts.inc
>>  
>>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
>> diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
>> index 21c0b24..117c47c 100644
>> --- a/wic/qemu-arm64-efibootguard.wks.in
>> +++ b/wic/qemu-arm64-efibootguard.wks.in
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  # short-description: arm64 with EFI Boot Guard and SWUpdate
>>  # long-description: Disk image for arm64 machines with EFI Boot Guard and SWUpdate
>>  
>> diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
>> index 948c67d..a5dd09b 100644
>> --- a/wic/qemu-riscv64-efibootguard.wks.in
>> +++ b/wic/qemu-riscv64-efibootguard.wks.in
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  # short-description: riscv64 with EFI Boot Guard and SWUpdate
>>  # long-description: Disk image for riscv64 machines with EFI Boot Guard and SWUpdate
>>  
>> diff --git a/wic/x86-uefi-efibootguard-secureboot.wks.in b/wic/x86-uefi-efibootguard-secureboot.wks.in
>> index 2af3e58..f15f9e0 100644
>> --- a/wic/x86-uefi-efibootguard-secureboot.wks.in
>> +++ b/wic/x86-uefi-efibootguard-secureboot.wks.in
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  include ebg-signed-sysparts.inc
>>  
>>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
>> diff --git a/wic/x86-uefi-efibootguard.wks.in b/wic/x86-uefi-efibootguard.wks.in
>> index 3640ecf..982a87a 100644
>> --- a/wic/x86-uefi-efibootguard.wks.in
>> +++ b/wic/x86-uefi-efibootguard.wks.in
>> @@ -1,3 +1,6 @@
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>>  # short-description: x86 with EFI Boot Guard and SWUpdate
>>  # long-description: Disk image for x86 machines with EFI Boot Guard and SWUpdate
>>  
>>
>> ---
>> base-commit: e3158569eee297f1837a6d3fd7e0f1a0534c2b8b
>> change-id: 20260316-license-c5fcde3618d2
>>
>> Best regards,
> 
> Thanks, applied. Will follow up with fixing two more spots so that we
> are only left with files that cannot receive headers.
> 

Quirin spotted that modifying hwrevision.tmpl is causing our red
pipeline rigth now. I've dropped that changed and force-pushed the update.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

