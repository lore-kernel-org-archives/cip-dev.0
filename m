Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FB810A3D9C
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 15:10:44 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50720.1774537834390148276
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Mar 2026 08:10:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=aJbTyGeD;
 spf=pass (domain: siemens.com, ip: 52.101.66.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuGMcNmod6VM8BWQ6c0mVOQBtZ8eNqZkF0ke6rQ9/SQSBLgU+f8TkDKSflgVzmndvw4d+ze5gatwrWA6GQc8Qq1/Q+PPrjFO/AdrQ+NMLK+x6k88oJfZew8tF86VOuuOqFiTbcFMxbiSFgI/pXlK1mJttG+eglXRrSBWp3zguJNbO4Tg6mMe45bhJY3gkg51Da4SY1/gJetWyT8TnZGy67cuYd/7y7TJt4qfOQ2696kgqxCV+vdgdWFGKoV6wKX4OzuFHdJHcr+uXTdsbe3kDj8swO1M51HRTxn0HTVyoDhECoK8ri2CO9QxQsyyzhJfYPjFK0vxm5p3gfHaSsQkQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SlTzpcDjB/e1qhfUuOX+MpF9UI+YBagoDsW5k4nKw0=;
 b=Ns5YZv0sM3JLGG0GZpVDDPecQMpsW4XFVQwNaI1tG2TZATxexTLgZlaJnoGUGYKDJDVePyym9QX8KCYuo512oAVzUjzfgdZtJgcxqG18uiKrd6ABBH8o5WH/WdC6PMGTtGA3rqT3syAur+16T7QoFINdHEfZgUfpgOJsirzokMBDLxtexdY1zskoNfJqety3+BZN3aUiwfZezC3ljUDWAfusT0HgRUuj/RTxKgyCMy32DiqXZTAZq3tyvyFFOQvER0w3tdMmiVNdEM2esFQqSvKF5pz0AjsioYwipq0BZZbT6AuER+YzE2TiNhAbnYk38YWUx1C2+UGeQ3SYdipT9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SlTzpcDjB/e1qhfUuOX+MpF9UI+YBagoDsW5k4nKw0=;
 b=aJbTyGeD1+tRMD5LEymTEhdTsa/abCR4Wh6aER+TSOxTUtp9e7Pc0vROr6RnmqgbpIt2tQOc3165nkZ3D1UwK8Cg0ZM3viVFTsN7URyr6B7+iIceMO9On7YyI8DFkS4bh2AyBxO92+eNG5aupBEX6yyxdhmQjHws4TRIq01AkXu2lc/oy5AWmMz1Q6RRkTBdtJeeG9dxTz+sXr5sdyxzRDsY6xFAW41r+odOg8O16lT77vDvaOgELLYVBFePe6AI0FimQjTPEke9mW954qKD/oOZSBk1PO0OZC0bvDZzAmRgKqvS/wtKtdblq6s6yIdY7JwLHj362STWWIjSQ6El2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB8018.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:568::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 15:10:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 15:10:29 +0000
Message-ID: <93a682d4-ce36-4ec2-b35e-dd5e42aef1a3@siemens.com>
Date: Thu, 26 Mar 2026 16:10:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH isar-cip-core v2] *: Add SPDX-License-Identifier MIT
 header
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Kamlesh Gurudasani <kamlesh@ti.com>, dinesh.kumar@toshiba-tsip.com,
 cip-dev@lists.cip-project.org, pavel@denx.de,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20260324-license-v2-1-1ca6dd83f0e8@ti.com>
 <62e3e3c2-bd72-4d60-9ee9-d460371a0955@siemens.com>
 <cf8bf9cd-bb30-40eb-ac4d-2a3b27dc31d6@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <cf8bf9cd-bb30-40eb-ac4d-2a3b27dc31d6@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0722.namprd03.prod.outlook.com
 (2603:10b6:408:110::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: fe831cac-ee3e-413d-64f8-08de8b49d160
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|55112099003|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	7QHjaZN7A4rGuidLHOuFMKYyPCrfEmbApZqFueFf1q5pV+J4I6Gk4ObBS5AJbCrWYI7K99TooT4h/YAr3HRhjWl1wi4NPYgq6eDUxygcEGgs6h6fusZJFwyP6NTdReyK5oHP84SjeoPTE6ylZxNSvmyI5TumP+UBnEGDVKT0rMDcAaj2Zh6lIyHYjRMNFANYNklB2xBNXjY1xOSQjWGLs3GUkma5GBwMSy8yXAylUmBE0AHEJVbNLA/mYUxrycWbpnVrIZ9sMLJg2JtNK0k2GnLGPeRH1kIhf6LhHDqKiLUOmz3U76WxbHs4ZnoqNyYt1uwX34RT8sN62WyqWSW3KeP22gtYud/934v0slIa2USzO80S0imoFqLKZG9pURY7AFDQY8FsetWXvaIrn0F1QpJyN74e3McM4puay9HbwUViCPpqMoO9N6tx02VFvGKyXCMvSxwcOeYZBjJVuRZI38YYBktld4MlWYeEm9rqeZjvRco+vA+ehylzwB2r3bxoiGah9LvYCZzzpSyOzePB9axPo+hTbOrbKiyMCnKmH3GMMrPNTnsUXUz0cEHtOVET+QPaYtyl+TkLDexk5d9qvk+2F/e98/hgseVMvjqGZeEBFPp6soN9kf7rNYkyWG41fVigYxgolcW0MgsqL+eGW2TuNBe3fW7osLsW1MIcScuJbqwiW9amwj1LprrNVpZm
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MzZRTmY3MHVOMEpGSzk5eVFBM3Vodk5VbmxuMzlqajhOeThDK2M5NVRUTE5B?=
 =?utf-8?B?VWlxaHVZTmN1WmQ5VisyU1o3azZIWXZqUUJuREZ3WWhmS0lHNUk2UUl1RzFB?=
 =?utf-8?B?RXhZUUJJNExmbVk0OTltM3IxaWdtb2JDc1NlU1NWRkdCYWdwZHlQSjBMWVlW?=
 =?utf-8?B?RUZaZ3htdjF2aFRqQko5cWgyY3BMdXozVEdZY0g2YkpQV1pFdlUrdGlyMWd5?=
 =?utf-8?B?SzYvdnU1RFlvNk4xcS9EQnNGSmFvNlhVQ21JYlpSc1U4dDJ5Z0tPSlIwVGQ3?=
 =?utf-8?B?NjY1alFZZmhRTnZqODVrOWFORFBtT2tYa0ZtYlBYQkFpL05oanNFU3VYbzU0?=
 =?utf-8?B?S2lkWW1nd1hLYWhEL0REeUN4OVMxWS83aWdsM2FGalQxL0FpbTBtcFNUWi8z?=
 =?utf-8?B?R0ZKTzlmTzZIbHh5dTRvMC9ZNDhDbG5BSGxaYmd3OVpHSXArQTNLZ2svRnE4?=
 =?utf-8?B?N2pIdm1tZTVnanBvTHVxNUh1SFYzMzd3ZVM0elFvNzl1K3FsS0NlQVM2R09t?=
 =?utf-8?B?bnU0Rks1aVRYM05naXJxSlB0QnprWnpRbjNHZmszd0RzNUdVSjhObG82YmJ3?=
 =?utf-8?B?RnE2UGRRdmlQV1Yvc1ZwdzJJMVJzNTRaVHgrNEpWekxzdFhGbzQ4MTYrQ3Zj?=
 =?utf-8?B?b3NsemV6OHB5Z0NaUy90OFlHZDV1WWpxSnM2QzRwYW5BWXlmREczQXl3Ti9X?=
 =?utf-8?B?SWNBTStOSzFneFMxYlRtcnZwdjNySFdjV3dDTU1BK2w2N3crdHR2RHI5VTNm?=
 =?utf-8?B?VEpUWE41M01hRzNyWlNOODNMRTVjYjdiVFc1dDVpQnJOOGNkejNpMVJxb25T?=
 =?utf-8?B?emw1aXZZYkNxWjV4RHYrZXdMYXE3ZVZHdkcvM2xhRFpQZHBjWEZqR3FDWUoy?=
 =?utf-8?B?UzZ0N1J3Q0x3U29IZDI3a2srYVNlM3dpUmN5YUo2SER4OXgrUXN1NS9lYnZq?=
 =?utf-8?B?THF1U0FYMjlOQVoyNTAwSXVmS0cxQ3NYd3JqTXAzQXNRdDRHZWIySkx3N2ZG?=
 =?utf-8?B?Qit1cUJ6azVPNm9NczF3QjNERWJ3R3hKdlorYVpkT3FEdERUYjRTdUU4SDhF?=
 =?utf-8?B?bDhCblArcGpyQnAybzJEUnpBWWp1c2NicEd4Yms1NnRCUGN4ZjVDNVdONkNt?=
 =?utf-8?B?blp6SkRNOW9JbU1raENJdGh5Qk1LeElIRzNnZEhRQTlweTZZdnpqdUhSTkZ4?=
 =?utf-8?B?bEYxWlJTWjlwVTFRZGpzUVBJMmFTSElPOFZTZ2JwZTcwVEZ6SnFWWHhyMjc5?=
 =?utf-8?B?UllSMmZ1WTZCOVZkR2JIOTFJVjJvM1N6OUp5TEd1WEg1OUVhelJqSHhRelZS?=
 =?utf-8?B?N2owa0pOVWQ5enRjUjVvQUdqUTJ2TzZOYnova2dCMGtKZWJ3SUtpcmdLOGxx?=
 =?utf-8?B?amxQVVBTQk84TEtTYWdLRlFHbE5peG44VW1kTjRiS0xYamJDYVVCbmljLzlW?=
 =?utf-8?B?UG5RRDBoaWJqbkc3ZHl1U2xFL2g5dENJUjRQM25LWmo2S3JKTjgyKzNJRTJX?=
 =?utf-8?B?bVZzdmIwY0EvL1pOYTNma1BCOWhRSVhQcTFEc0pud3pZUGRiUjVRTlZsd2Rl?=
 =?utf-8?B?b2paamJoanp1SUhxSnhLRW1kKytyOGdkazJkV1ZRSTRDNTZZMEVBbUZ0YmJ4?=
 =?utf-8?B?MjNEWDlJTmVNUE10WEMzRXhDT2FwNTgwaE4wdGN4Q2FJTFI2S0VKZTV6cXRR?=
 =?utf-8?B?Qzd3dEpXeGRSRnlpWlhUblNiRzNiRklHdFB0ditaUXJrRmxGVTg4SlBhZzEz?=
 =?utf-8?B?dUFRMXJzdVNIeXY1WVYza2tHQkxrazJCT0lUN1FNclZmMjMrN0VTYm84Z1pL?=
 =?utf-8?B?ODNKdmhvTnIvNjkzMVZUT0RHVUduSzhVYkVvZU1DTC9tU1JoekZEc2QwQ3lr?=
 =?utf-8?B?d1Uvdjh2SXFaTWZ1SC92azR4NHVkc3BJeVp0by9YMUljcEhjUFJyc0ZIcmhY?=
 =?utf-8?B?VHpmRmpyQVgybkJ6eld2U0dlY0dtNTRORWM3cmlHWDNiTStsVTgxR0pNRWdJ?=
 =?utf-8?B?dHNHZWF4WGV4QVhsYURjRFQ0UmVrazA2UlNUbTVnV05acGpaanFkRytWckdv?=
 =?utf-8?B?ZGd3R253UHVpdDdRVHhDTys2T1E2S2M4cDh4cmprT1pZRWtXREdNalpsem5k?=
 =?utf-8?B?TnRBTVF2Slg4VDNSak9KVkdPMDQyRzk4NktPdHFWRktmRHRKek1RRWNMNEpy?=
 =?utf-8?B?R1NteHFuYnlnUTZTcWJ2ajYwTWZUcFUxd1FqSDdRRkM0d2tNYUNRby8rYjN2?=
 =?utf-8?B?ZEJLUmZYRS9uZFp5N3NIMG80WDAwY3dxaUxFYVkxbm4zaVFURzJ6c2dwU1RK?=
 =?utf-8?B?WXpUbDFkNEtBOFc1VXJZRWxsUXFhK0JqbTR3RHl2R2REYnNLNUJNQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe831cac-ee3e-413d-64f8-08de8b49d160
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 15:10:29.7483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwNUEWCBbTZDTmqqgkKNske+aUx8d8aDNKrA/Cg2Phj+zX8THjF4jngZdTJ5QAxZHjGPuYX9KsN++SSY+y8haA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB8018
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Mar 2026 15:10:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22586

On 26.03.26 13:05, Jan Kiszka wrote:
> On 24.03.26 15:39, Jan Kiszka wrote:
>> On 24.03.26 09:40, Kamlesh Gurudasani wrote:
>>> Add missing license headers to configuration, template, script,
>>> and wic partition layout files to make licensing consistent
>>> across the repository.
>>>
>>> Command Used:
>>> git ls-files | xargs grep -rL SPDX-License-Identifier
>>>
>>> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
>>> ---
>>> Changes in v2:
>>> - added license to remaining files
>>> - Link to v1: https://lore.kernel.org/r/20260316-license-v1-1-5bb039f50c05@ti.com
>>> ---
>>>  conf/distro/debian-bullseye-backports.list                                       | 3 +++
>>>  conf/distro/debian-buster-backports.list                                         | 3 +++
>>>  conf/distro/preferences.ovmf-snakeoil.conf                                       | 3 +++
>>>  conf/distro/preferences.swupdate-bullseye-backports.conf                         | 3 +++
>>>  recipes-bsp/u-boot/files/ftpm-stmm.cfg                                           | 3 +++
>>>  recipes-bsp/u-boot/files/no-grub-workaround.cfg                                  | 3 +++
>>>  recipes-bsp/u-boot/files/qemu-extra.cfg                                          | 3 +++
>>>  recipes-bsp/u-boot/files/secure-boot.cfg                                         | 3 +++
>>>  recipes-bsp/u-boot/files/ti-extra.cfg                                            | 3 +++
>>>  recipes-core/customizations/files/99-silent-printk.conf                          | 3 +++
>>>  recipes-core/customizations/files/99-watchdog.conf                               | 3 +++
>>>  recipes-core/customizations/files/ssh-permit-root.conf                           | 3 +++
>>>  recipes-core/home-fs/files/home.mount                                            | 3 +++
>>>  recipes-core/home-fs/files/postinst                                              | 3 +++
>>>  recipes-core/immutable-rootfs/files/95-disable-package-updates.preset            | 3 +++
>>>  recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl               | 3 +++
>>>  recipes-core/immutable-rootfs/files/postinst                                     | 3 +++
>>>  recipes-core/journald-config/files/persistent-journal.conf                       | 3 +++
>>>  recipes-core/kernel-panic/files/sysrq-panic.service                              | 3 +++
>>>  recipes-core/ltp/files/debian/control.tmpl                                       | 3 +++
>>>  recipes-core/ltp/files/debian/rules                                              | 3 +++
>>>  recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl               | 3 +++
>>>  recipes-core/security-customizations/files/postinst                              | 2 ++
>>>  recipes-core/security-customizations/files/ssh-pam-remote.conf                   | 3 +++
>>>  recipes-core/security-customizations/files/ssh-remote-session-term.conf          | 3 +++
>>>  recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl                   | 3 +++
>>>  recipes-core/swupdate-config/files/hwrevision.tmpl                               | 3 +++
>>>  recipes-core/swupdate-config/files/swupdate.cfg                                  | 3 +++
>>>  recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini | 3 +++
>>>  recipes-core/tmp-fs/files/postinst                                               | 3 +++
>>>  recipes-devtools/swupdate-signer/files/sign-swu-cms                              | 3 +++
>>>  recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl          | 3 +++
>>>  recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf                      | 3 +++
>>>  recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl   | 2 ++
>>>  recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl              | 3 +++
>>>  recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl                 | 2 ++
>>>  recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script    | 2 ++
>>>  recipes-kernel/linux/files/no-module-signing.cfg                                 | 3 +++
>>>  recipes-kernel/linux/files/no-tpm-hwrng.cfg                                      | 3 +++
>>>  recipes-kernel/linux/files/preempt-rt.cfg                                        | 3 +++
>>>  recipes-security/fail2ban-config/files/systemd-defaults.conf                     | 3 +++
>>>  scripts/deploy-cip-core.sh                                                       | 3 +++
>>>  scripts/generate-sb-db-from-existing-certificate.sh                              | 3 +++
>>>  scripts/generate_secure_boot_keys.sh                                             | 3 +++
>>>  scripts/start-efishell.sh                                                        | 3 +++
>>>  scripts/submit_lava.sh                                                           | 3 +++
>>>  scripts/update-linux-cip.sh                                                      | 3 +++
>>>  scripts/update-ltp.sh                                                            | 3 +++
>>>  tests/templates/IEC_template.yml                                                 | 3 +++
>>>  tests/templates/secureboot_corrupt_rootfs_steps.yml                              | 3 +++
>>>  tests/templates/secureboot_negative_test.yml                                     | 3 +++
>>>  tests/templates/secureboot_template.yml                                          | 3 +++
>>>  tests/templates/secureboot_unsigned_bootloader_steps.yml                         | 3 +++
>>>  tests/templates/secureboot_unsigned_kernel_steps.yml                             | 3 +++
>>>  tests/templates/swupdate-test-action-M-COM.yml                                   | 3 +++
>>>  tests/templates/swupdate_corrupt_swu_artifact_steps.yml                          | 3 +++
>>>  tests/templates/swupdate_corrupt_swu_steps.yml                                   | 3 +++
>>>  tests/templates/swupdate_negative_test.yml                                       | 3 +++
>>>  tests/templates/swupdate_reboot_without_confirm.yml                              | 3 +++
>>>  tests/templates/swupdate_same_uuid_steps.yml                                     | 3 +++
>>>  tests/templates/swupdate_template.yml                                            | 3 +++
>>>  wic/ebg-signed-sysparts.inc                                                      | 3 +++
>>>  wic/ebg-sysparts.inc                                                             | 3 +++
>>>  wic/hihope-rzg2m-efibootguard.wks.in                                             | 3 +++
>>>  wic/qemu-arm64-efibootguard-secureboot.wks.in                                    | 3 +++
>>>  wic/qemu-arm64-efibootguard.wks.in                                               | 3 +++
>>>  wic/qemu-riscv64-efibootguard.wks.in                                             | 3 +++
>>>  wic/x86-uefi-efibootguard-secureboot.wks.in                                      | 3 +++
>>>  wic/x86-uefi-efibootguard.wks.in                                                 | 3 +++
>>>  69 files changed, 203 insertions(+)
>>>
>>> diff --git a/conf/distro/debian-bullseye-backports.list b/conf/distro/debian-bullseye-backports.list
>>> index 1594907..6107928 100644
>>> --- a/conf/distro/debian-bullseye-backports.list
>>> +++ b/conf/distro/debian-bullseye-backports.list
>>> @@ -1 +1,4 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  deb http://archive.debian.org/debian bullseye-backports main contrib non-free
>>> diff --git a/conf/distro/debian-buster-backports.list b/conf/distro/debian-buster-backports.list
>>> index 7134a35..842019e 100644
>>> --- a/conf/distro/debian-buster-backports.list
>>> +++ b/conf/distro/debian-buster-backports.list
>>> @@ -1 +1,4 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  deb http://archive.debian.org/debian buster-backports main contrib non-free
>>> diff --git a/conf/distro/preferences.ovmf-snakeoil.conf b/conf/distro/preferences.ovmf-snakeoil.conf
>>> index b51d1d4..25b7da4 100644
>>> --- a/conf/distro/preferences.ovmf-snakeoil.conf
>>> +++ b/conf/distro/preferences.ovmf-snakeoil.conf
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  Package: ovmf
>>>  Pin: release n=buster-backports
>>>  Pin-Priority: 801
>>> diff --git a/conf/distro/preferences.swupdate-bullseye-backports.conf b/conf/distro/preferences.swupdate-bullseye-backports.conf
>>> index c5f6685..da307cd 100644
>>> --- a/conf/distro/preferences.swupdate-bullseye-backports.conf
>>> +++ b/conf/distro/preferences.swupdate-bullseye-backports.conf
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  Package: dh-nodejs
>>>  Pin: release n=bullseye-backports
>>>  Pin-Priority: 801
>>> diff --git a/recipes-bsp/u-boot/files/ftpm-stmm.cfg b/recipes-bsp/u-boot/files/ftpm-stmm.cfg
>>> index af5da93..a6fe2a3 100644
>>> --- a/recipes-bsp/u-boot/files/ftpm-stmm.cfg
>>> +++ b/recipes-bsp/u-boot/files/ftpm-stmm.cfg
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  ### Enable OPTEE, fTPM and StMM
>>>  CONFIG_TEE=y
>>>  CONFIG_OPTEE=y
>>> diff --git a/recipes-bsp/u-boot/files/no-grub-workaround.cfg b/recipes-bsp/u-boot/files/no-grub-workaround.cfg
>>> index dc09edd..8a01ff6 100644
>>> --- a/recipes-bsp/u-boot/files/no-grub-workaround.cfg
>>> +++ b/recipes-bsp/u-boot/files/no-grub-workaround.cfg
>>> @@ -1,2 +1,5 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  ### Disable grub workaround
>>>  # CONFIG_EFI_GRUB_ARM32_WORKAROUND is not set
>>> diff --git a/recipes-bsp/u-boot/files/qemu-extra.cfg b/recipes-bsp/u-boot/files/qemu-extra.cfg
>>> index e643db7..5380ad8 100644
>>> --- a/recipes-bsp/u-boot/files/qemu-extra.cfg
>>> +++ b/recipes-bsp/u-boot/files/qemu-extra.cfg
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  ### QEMU extra config
>>>  CONFIG_MMC=y
>>>  CONFIG_SUPPORT_EMMC_RPMB=y
>>> diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg b/recipes-bsp/u-boot/files/secure-boot.cfg
>>> index 694356f..7b09a53 100644
>>> --- a/recipes-bsp/u-boot/files/secure-boot.cfg
>>> +++ b/recipes-bsp/u-boot/files/secure-boot.cfg
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  ### Secure boot config
>>>  # CONFIG_BOOTSTD_DEFAULTS is not set
>>>  # CONFIG_BOOTMETH_CROS is not set
>>> diff --git a/recipes-bsp/u-boot/files/ti-extra.cfg b/recipes-bsp/u-boot/files/ti-extra.cfg
>>> index c10d046..9500055 100644
>>> --- a/recipes-bsp/u-boot/files/ti-extra.cfg
>>> +++ b/recipes-bsp/u-boot/files/ti-extra.cfg
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  ### FTPM + RPMB + StandaloneMM setup
>>>  CONFIG_OPTEE_SERVICE_DISCOVERY=y
>>>  CONFIG_TPM=y
>>> diff --git a/recipes-core/customizations/files/99-silent-printk.conf b/recipes-core/customizations/files/99-silent-printk.conf
>>> index ad24d3a..c5b3799 100644
>>> --- a/recipes-core/customizations/files/99-silent-printk.conf
>>> +++ b/recipes-core/customizations/files/99-silent-printk.conf
>>> @@ -1 +1,4 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  kernel.printk = 3 4 1 3
>>> diff --git a/recipes-core/customizations/files/99-watchdog.conf b/recipes-core/customizations/files/99-watchdog.conf
>>> index c02756d..1f38c55 100644
>>> --- a/recipes-core/customizations/files/99-watchdog.conf
>>> +++ b/recipes-core/customizations/files/99-watchdog.conf
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  [Manager]
>>>  RuntimeWatchdogSec=60s
>>>  ShutdownWatchdogSec=60s
>>> diff --git a/recipes-core/customizations/files/ssh-permit-root.conf b/recipes-core/customizations/files/ssh-permit-root.conf
>>> index 1073982..ab26ab5 100644
>>> --- a/recipes-core/customizations/files/ssh-permit-root.conf
>>> +++ b/recipes-core/customizations/files/ssh-permit-root.conf
>>> @@ -1 +1,4 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  PermitRootLogin yes
>>> diff --git a/recipes-core/home-fs/files/home.mount b/recipes-core/home-fs/files/home.mount
>>> index 062517a..653495c 100644
>>> --- a/recipes-core/home-fs/files/home.mount
>>> +++ b/recipes-core/home-fs/files/home.mount
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  [Unit]
>>>  Description=Mount /home partition
>>>  Before=local-fs.target
>>> diff --git a/recipes-core/home-fs/files/postinst b/recipes-core/home-fs/files/postinst
>>> index ab0db84..904aa73 100755
>>> --- a/recipes-core/home-fs/files/postinst
>>> +++ b/recipes-core/home-fs/files/postinst
>>> @@ -1,4 +1,7 @@
>>>  #!/bin/sh
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  
>>>  set -e
>>>  
>>> diff --git a/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset b/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset
>>> index 7e6e9ef..b3b52ce 100644
>>> --- a/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset
>>> +++ b/recipes-core/immutable-rootfs/files/95-disable-package-updates.preset
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  disable apt-daily.timer
>>>  disable apt-daily-upgrade.timer
>>>  disable dpkg-db-backup.timer
>>> diff --git a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
>>> index e6d25d2..4cdfc6f 100644
>>> --- a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
>>> +++ b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  L /var/lib/dpkg - - - - ${IMMUTABLE_DATA_DIR}/var/lib/dpkg
>>>  d /var/log/audit 0700 root adm -
>>>  d /var/lib/apt 0755 root root -
>>> diff --git a/recipes-core/immutable-rootfs/files/postinst b/recipes-core/immutable-rootfs/files/postinst
>>> index a6e1962..3b8071e 100644
>>> --- a/recipes-core/immutable-rootfs/files/postinst
>>> +++ b/recipes-core/immutable-rootfs/files/postinst
>>> @@ -1,4 +1,7 @@
>>>  #!/bin/sh
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  
>>>  set -e
>>>  
>>> diff --git a/recipes-core/journald-config/files/persistent-journal.conf b/recipes-core/journald-config/files/persistent-journal.conf
>>> index 21dfde0..3e3419f 100644
>>> --- a/recipes-core/journald-config/files/persistent-journal.conf
>>> +++ b/recipes-core/journald-config/files/persistent-journal.conf
>>> @@ -1,2 +1,5 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  [Journal]
>>>  Storage=persistent
>>> diff --git a/recipes-core/kernel-panic/files/sysrq-panic.service b/recipes-core/kernel-panic/files/sysrq-panic.service
>>> index 4f199fe..e892165 100644
>>> --- a/recipes-core/kernel-panic/files/sysrq-panic.service
>>> +++ b/recipes-core/kernel-panic/files/sysrq-panic.service
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  [Unit]
>>>  Description=sysrq panic
>>>  
>>> diff --git a/recipes-core/ltp/files/debian/control.tmpl b/recipes-core/ltp/files/debian/control.tmpl
>>> index 0bfc0c2..a7d0087 100644
>>> --- a/recipes-core/ltp/files/debian/control.tmpl
>>> +++ b/recipes-core/ltp/files/debian/control.tmpl
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  Source: ltp-full
>>>  Section: embedded
>>>  Priority: optional
>>> diff --git a/recipes-core/ltp/files/debian/rules b/recipes-core/ltp/files/debian/rules
>>> index 4e1747c..32d3c29 100755
>>> --- a/recipes-core/ltp/files/debian/rules
>>> +++ b/recipes-core/ltp/files/debian/rules
>>> @@ -1,4 +1,7 @@
>>>  #!/usr/bin/make -f
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  export DEB_CFLAGS_MAINT_APPEND  = -Wall  -Wno-format-security
>>>  export DEB_BUILD_MAINT_OPTIONS=hardening=-branch
>>>  
>>> diff --git a/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl b/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
>>> index 92e4a30..1821f92 100644
>>> --- a/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
>>> +++ b/recipes-core/move-homedir-var/files/move-homedir-var.tmpfiles.tmpl
>>> @@ -1,2 +1,5 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  L /home - - - - /var/home
>>>  C /var/home - - - - ${IMMUTABLE_DATA_DIR}/home
>>> diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
>>> index f8ebf9e..788e225 100755
>>> --- a/recipes-core/security-customizations/files/postinst
>>> +++ b/recipes-core/security-customizations/files/postinst
>>> @@ -3,6 +3,8 @@
>>>  # CIP Security, generic profile
>>>  # Security Package configurations
>>>  #
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  
>>>  set -e
>>>  
>>> diff --git a/recipes-core/security-customizations/files/ssh-pam-remote.conf b/recipes-core/security-customizations/files/ssh-pam-remote.conf
>>> index d460b0c..ea120b2 100644
>>> --- a/recipes-core/security-customizations/files/ssh-pam-remote.conf
>>> +++ b/recipes-core/security-customizations/files/ssh-pam-remote.conf
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  # Enable PAM configuration for Remote Session
>>>  ChallengeResponseAuthentication yes
>>>  KbdInteractiveAuthentication yes
>>> diff --git a/recipes-core/security-customizations/files/ssh-remote-session-term.conf b/recipes-core/security-customizations/files/ssh-remote-session-term.conf
>>> index d11b92e..171ea9b 100644
>>> --- a/recipes-core/security-customizations/files/ssh-remote-session-term.conf
>>> +++ b/recipes-core/security-customizations/files/ssh-remote-session-term.conf
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  # CR2.6: Remote session termination
>>>  # Terminate remote session after inactive time period
>>>  
>>> diff --git a/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl b/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
>>> index 744b426..f750f3d 100644
>>> --- a/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
>>> +++ b/recipes-core/swupdate-config-wfx/files/suricatta_wfx.conf.tmpl
>>> @@ -1 +1,4 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  SWUPDATE_SURICATTA_ARGS="--server lua -u ${WFX_URL} -i $(cat /etc/machine-id)"
>>> diff --git a/recipes-core/swupdate-config/files/hwrevision.tmpl b/recipes-core/swupdate-config/files/hwrevision.tmpl
>>> index 1eb0996..b937200 100644
>>> --- a/recipes-core/swupdate-config/files/hwrevision.tmpl
>>> +++ b/recipes-core/swupdate-config/files/hwrevision.tmpl
>>> @@ -1 +1,4 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  cip-${MACHINE} ${MACHINE_HW_VERSION}
>>> diff --git a/recipes-core/swupdate-config/files/swupdate.cfg b/recipes-core/swupdate-config/files/swupdate.cfg
>>> index 3e2b45c..5c05fbe 100644
>>> --- a/recipes-core/swupdate-config/files/swupdate.cfg
>>> +++ b/recipes-core/swupdate-config/files/swupdate.cfg
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  globals :
>>>  {
>>>      bootloader = "ebg";
>>> diff --git a/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
>>> index 58271da..8f93cc9 100644
>>> --- a/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
>>> +++ b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  [image]
>>>  chainhandler=raw
>>>  
>>> diff --git a/recipes-core/tmp-fs/files/postinst b/recipes-core/tmp-fs/files/postinst
>>> index 39067f1..ae0f74a 100755
>>> --- a/recipes-core/tmp-fs/files/postinst
>>> +++ b/recipes-core/tmp-fs/files/postinst
>>> @@ -1,4 +1,7 @@
>>>  #!/bin/sh
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  
>>>  set -e
>>>  
>>> diff --git a/recipes-devtools/swupdate-signer/files/sign-swu-cms b/recipes-devtools/swupdate-signer/files/sign-swu-cms
>>> index cb0cd4a..bc1ec13 100644
>>> --- a/recipes-devtools/swupdate-signer/files/sign-swu-cms
>>> +++ b/recipes-devtools/swupdate-signer/files/sign-swu-cms
>>> @@ -1,4 +1,7 @@
>>>  #!/bin/sh
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  in_file=$1
>>>  out_file=$2
>>>  inkey="/usr/share/swupdate-signing/swupdate-sign.key"
>>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>>> index bb93361..452714d 100644
>>> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  PARTITIONS="${CRYPT_PARTITIONS}"
>>>  CREATE_FILE_SYSTEM_CMD="${CRYPT_CREATE_FILE_SYSTEM_CMD}"
>>>  SETUP_TIMEOUT="${CRYPT_SETUP_TIMEOUT}"
>>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf b/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf
>>> index d4c8981..8e087f2 100644
>>> --- a/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf
>>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/pwquality.conf
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  # we don't have a dictionary in the initramfs
>>>  # this solves the error "Password generation failed - required entropy too low for settings"
>>>  dictcheck = 0
>>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
>>> index f0ad40c..94b5f8b 100644
>>> --- a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
>>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
>>> @@ -7,6 +7,8 @@
>>>  # Authors:
>>>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>  #
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  . /usr/share/factory-reset/reset-env
>>>  
>>>  . /scripts/cip-initramfs-functions
>>> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
>>> index d3e18a2..07e2376 100644
>>> --- a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
>>> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
>>> @@ -1,3 +1,6 @@
>>>  #!/bin/sh
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  INITRAMFS_FACTORY_RESET_DEVICES="${INITRAMFS_FACTORY_RESET_DEVICES}"
>>>  INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE="${INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE}"
>>> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
>>> index bce588c..8a697f8 100644
>>> --- a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
>>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
>>> @@ -7,6 +7,8 @@
>>>  #  Jan Kiszka <jan.kiszka@siemens.com>
>>>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>  #
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  
>>>  ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
>>>  ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
>>> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
>>> index 0cd084b..11ca731 100644
>>> --- a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
>>> +++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
>>> @@ -7,6 +7,8 @@
>>>  # Authors:
>>>  #  Clara Kowalsky <clara.kowalsky@siemens.com>
>>>  #
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  
>>>  partition_fstype="$1"
>>>  ovl_partition_device="$2"
>>> diff --git a/recipes-kernel/linux/files/no-module-signing.cfg b/recipes-kernel/linux/files/no-module-signing.cfg
>>> index ab54f68..064ef9c 100644
>>> --- a/recipes-kernel/linux/files/no-module-signing.cfg
>>> +++ b/recipes-kernel/linux/files/no-module-signing.cfg
>>> @@ -1,2 +1,5 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  # CONFIG_SECURITY_LOCKDOWN_LSM is not set
>>>  # CONFIG_MODULE_SIG is not set
>>> diff --git a/recipes-kernel/linux/files/no-tpm-hwrng.cfg b/recipes-kernel/linux/files/no-tpm-hwrng.cfg
>>> index ab46cd8..08e98ff 100644
>>> --- a/recipes-kernel/linux/files/no-tpm-hwrng.cfg
>>> +++ b/recipes-kernel/linux/files/no-tpm-hwrng.cfg
>>> @@ -1,2 +1,5 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  # see https://lore.kernel.org/lkml/bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com/
>>>  # CONFIG_HW_RANDOM_TPM is not set
>>> diff --git a/recipes-kernel/linux/files/preempt-rt.cfg b/recipes-kernel/linux/files/preempt-rt.cfg
>>> index afbf53d..f558365 100644
>>> --- a/recipes-kernel/linux/files/preempt-rt.cfg
>>> +++ b/recipes-kernel/linux/files/preempt-rt.cfg
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  # >= 5.10
>>>  CONFIG_EXPERT=y
>>>  CONFIG_PREEMPT_RT=y
>>> diff --git a/recipes-security/fail2ban-config/files/systemd-defaults.conf b/recipes-security/fail2ban-config/files/systemd-defaults.conf
>>> index 16e0d5e..32a8e48 100644
>>> --- a/recipes-security/fail2ban-config/files/systemd-defaults.conf
>>> +++ b/recipes-security/fail2ban-config/files/systemd-defaults.conf
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  [DEFAULT]
>>>  
>>>  syslog_backend = systemd
>>> diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
>>> index 623c216..1e08e47 100755
>>> --- a/scripts/deploy-cip-core.sh
>>> +++ b/scripts/deploy-cip-core.sh
>>> @@ -1,4 +1,7 @@
>>>  #!/bin/sh
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  
>>>  set -e
>>>  
>>> diff --git a/scripts/generate-sb-db-from-existing-certificate.sh b/scripts/generate-sb-db-from-existing-certificate.sh
>>> index dddd9b5..42d09dd 100755
>>> --- a/scripts/generate-sb-db-from-existing-certificate.sh
>>> +++ b/scripts/generate-sb-db-from-existing-certificate.sh
>>> @@ -1,4 +1,7 @@
>>>  #!/bin/sh
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  
>>>  set -e
>>>  
>>> diff --git a/scripts/generate_secure_boot_keys.sh b/scripts/generate_secure_boot_keys.sh
>>> index 8be0569..28ae34c 100755
>>> --- a/scripts/generate_secure_boot_keys.sh
>>> +++ b/scripts/generate_secure_boot_keys.sh
>>> @@ -1,4 +1,7 @@
>>>  #!/bin/sh
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  
>>>  set -e
>>>  
>>> diff --git a/scripts/start-efishell.sh b/scripts/start-efishell.sh
>>> index fff8a6a..86e2ddd 100755
>>> --- a/scripts/start-efishell.sh
>>> +++ b/scripts/start-efishell.sh
>>> @@ -1,4 +1,7 @@
>>>  #!/bin/sh
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  
>>>  set -e
>>>  
>>> diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
>>> index b3180a1..a4d20ec 100755
>>> --- a/scripts/submit_lava.sh
>>> +++ b/scripts/submit_lava.sh
>>> @@ -1,4 +1,7 @@
>>>  #!/bin/bash
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  # Copyright (C) 2024, Renesas Electronics Europe GmbH
>>>  # Chris Paterson <chris.paterson2@renesas.com>
>>>  # Sai Ashrith <sai.sathujoda@toshiba-tsip.com>
>>> diff --git a/scripts/update-linux-cip.sh b/scripts/update-linux-cip.sh
>>> index 5fbfa57..df306b2 100755
>>> --- a/scripts/update-linux-cip.sh
>>> +++ b/scripts/update-linux-cip.sh
>>> @@ -1,4 +1,7 @@
>>>  #!/bin/bash
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  REPO_ROOT=$(git rev-parse --show-toplevel)
>>>  pushd "${REPO_ROOT}"/recipes-kernel/linux >/dev/null || exit 1
>>>  
>>> diff --git a/scripts/update-ltp.sh b/scripts/update-ltp.sh
>>> index dc8b947..321cc3c 100755
>>> --- a/scripts/update-ltp.sh
>>> +++ b/scripts/update-ltp.sh
>>> @@ -1,4 +1,7 @@
>>>  #!/bin/bash
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  
>>>  REPO_ROOT=$(git rev-parse --show-toplevel)
>>>  pushd "${REPO_ROOT}"/recipes-core/ltp > /dev/null || exit
>>> diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
>>> index f8558cd..148f07e 100644
>>> --- a/tests/templates/IEC_template.yml
>>> +++ b/tests/templates/IEC_template.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  device_type: qemu
>>>  job_name: #architecture# IEC layer testing
>>>  timeouts:
>>> diff --git a/tests/templates/secureboot_corrupt_rootfs_steps.yml b/tests/templates/secureboot_corrupt_rootfs_steps.yml
>>> index b6f6628..5c47b30 100644
>>> --- a/tests/templates/secureboot_corrupt_rootfs_steps.yml
>>> +++ b/tests/templates/secureboot_corrupt_rootfs_steps.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>            - "apt-get update"
>>>            - "apt install -y fdisk"
>>>            - "rootfs_start_sector=$(fdisk -l -o Name,Start cip-core-image-security-cip-core-#distribution#-#architecture#.wic | awk -v name=systema '$0 ~ name {print $2}')"
>>> diff --git a/tests/templates/secureboot_negative_test.yml b/tests/templates/secureboot_negative_test.yml
>>> index 2fcdbfa..a8e4226 100644
>>> --- a/tests/templates/secureboot_negative_test.yml
>>> +++ b/tests/templates/secureboot_negative_test.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  device_type: qemu
>>>  job_name: #architecture# secure boot testing
>>>  timeouts:
>>> diff --git a/tests/templates/secureboot_template.yml b/tests/templates/secureboot_template.yml
>>> index e29b64a..0a075e2 100644
>>> --- a/tests/templates/secureboot_template.yml
>>> +++ b/tests/templates/secureboot_template.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  device_type: qemu
>>>  job_name: #architecture# secure boot testing
>>>  timeouts:
>>> diff --git a/tests/templates/secureboot_unsigned_bootloader_steps.yml b/tests/templates/secureboot_unsigned_bootloader_steps.yml
>>> index 8d64b05..f4f4043 100644
>>> --- a/tests/templates/secureboot_unsigned_bootloader_steps.yml
>>> +++ b/tests/templates/secureboot_unsigned_bootloader_steps.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>            - "apt-get update"
>>>            - "apt install --yes guestfish sbsigntool"
>>>            - "guestfish add cip-core-image-security-cip-core-#distribution#-#architecture#.wic : run : mount /dev/sda1 / : copy-out /EFI/BOOT/bootx64.efi ."
>>> diff --git a/tests/templates/secureboot_unsigned_kernel_steps.yml b/tests/templates/secureboot_unsigned_kernel_steps.yml
>>> index f097ed6..6ab334a 100644
>>> --- a/tests/templates/secureboot_unsigned_kernel_steps.yml
>>> +++ b/tests/templates/secureboot_unsigned_kernel_steps.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>            - "apt-get update"
>>>            - "apt install --yes guestfish sbsigntool"
>>>            - "guestfish add cip-core-image-security-cip-core-#distribution#-#architecture#.wic : run : mount /dev/sda2 / : copy-out /linux.efi ."
>>> diff --git a/tests/templates/swupdate-test-action-M-COM.yml b/tests/templates/swupdate-test-action-M-COM.yml
>>> index 56ff106..69c9cb7 100644
>>> --- a/tests/templates/swupdate-test-action-M-COM.yml
>>> +++ b/tests/templates/swupdate-test-action-M-COM.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  # TEST BLOCK 1
>>>  # Fail the job if software update application failed
>>>  - test:
>>> diff --git a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml b/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>>> index 2fad3fd..043867e 100644
>>> --- a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>>> +++ b/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#architecture#.swu --output /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
>>>              - mkdir -p swu
>>>              - cpio -ivd --directory=/root/swu < /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
>>> diff --git a/tests/templates/swupdate_corrupt_swu_steps.yml b/tests/templates/swupdate_corrupt_swu_steps.yml
>>> index 74c9217..3cdb793 100644
>>> --- a/tests/templates/swupdate_corrupt_swu_steps.yml
>>> +++ b/tests/templates/swupdate_corrupt_swu_steps.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#architecture#.swu --output /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
>>>              - mkdir -p swu
>>>              - dd if=/dev/zero of=/root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu bs=1M count=5
>>> diff --git a/tests/templates/swupdate_negative_test.yml b/tests/templates/swupdate_negative_test.yml
>>> index bb79b07..250eaa8 100644
>>> --- a/tests/templates/swupdate_negative_test.yml
>>> +++ b/tests/templates/swupdate_negative_test.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  device_type: qemu
>>>  job_name: #architecture# software update testing
>>>  timeouts:
>>> diff --git a/tests/templates/swupdate_reboot_without_confirm.yml b/tests/templates/swupdate_reboot_without_confirm.yml
>>> index bfad106..074eb1a 100644
>>> --- a/tests/templates/swupdate_reboot_without_confirm.yml
>>> +++ b/tests/templates/swupdate_reboot_without_confirm.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  # qemu-swtpm.sock will be gone after soft reboot.
>>>  # So the swtpm socket need to be started again for proper reboot
>>>  # To start the swtpm daemon, first the existing one should be killed
>>> diff --git a/tests/templates/swupdate_same_uuid_steps.yml b/tests/templates/swupdate_same_uuid_steps.yml
>>> index 3ff2e02..8329055 100644
>>> --- a/tests/templates/swupdate_same_uuid_steps.yml
>>> +++ b/tests/templates/swupdate_same_uuid_steps.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>              - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#architecture#.swu --output /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
>>>              - mkdir -p swu
>>>              - cpio -ivd --directory=/root/swu < /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
>>> diff --git a/tests/templates/swupdate_template.yml b/tests/templates/swupdate_template.yml
>>> index e1f71a9..9a3366b 100644
>>> --- a/tests/templates/swupdate_template.yml
>>> +++ b/tests/templates/swupdate_template.yml
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  device_type: qemu
>>>  job_name: #architecture# software update testing
>>>  timeouts:
>>> diff --git a/wic/ebg-signed-sysparts.inc b/wic/ebg-signed-sysparts.inc
>>> index c35878f..8210598 100644
>>> --- a/wic/ebg-signed-sysparts.inc
>>> +++ b/wic/ebg-signed-sysparts.inc
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  # default partition layout EFI Boot Guard usage, signed version
>>>  
>>>  # EFI partition containing efibootguard bootloader binary
>>> diff --git a/wic/ebg-sysparts.inc b/wic/ebg-sysparts.inc
>>> index 0290024..b7f1afa 100644
>>> --- a/wic/ebg-sysparts.inc
>>> +++ b/wic/ebg-sysparts.inc
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  # default partition layout EFI Boot Guard usage
>>>  
>>>  # EFI partition containing efibootguard bootloader binary
>>> diff --git a/wic/hihope-rzg2m-efibootguard.wks.in b/wic/hihope-rzg2m-efibootguard.wks.in
>>> index fdbad14..99c8d10 100644
>>> --- a/wic/hihope-rzg2m-efibootguard.wks.in
>>> +++ b/wic/hihope-rzg2m-efibootguard.wks.in
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  # short-description: RZ/G2M image with EFI Boot Guard and SWUpdate
>>>  # long-description: Disk image for HiHope RZ/G2M board with EFI Boot Guard and SWUpdate
>>>  
>>> diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
>>> index 941a552..88eb91c 100644
>>> --- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
>>> +++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  include ebg-signed-sysparts.inc
>>>  
>>>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
>>> diff --git a/wic/qemu-arm64-efibootguard.wks.in b/wic/qemu-arm64-efibootguard.wks.in
>>> index 21c0b24..117c47c 100644
>>> --- a/wic/qemu-arm64-efibootguard.wks.in
>>> +++ b/wic/qemu-arm64-efibootguard.wks.in
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  # short-description: arm64 with EFI Boot Guard and SWUpdate
>>>  # long-description: Disk image for arm64 machines with EFI Boot Guard and SWUpdate
>>>  
>>> diff --git a/wic/qemu-riscv64-efibootguard.wks.in b/wic/qemu-riscv64-efibootguard.wks.in
>>> index 948c67d..a5dd09b 100644
>>> --- a/wic/qemu-riscv64-efibootguard.wks.in
>>> +++ b/wic/qemu-riscv64-efibootguard.wks.in
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  # short-description: riscv64 with EFI Boot Guard and SWUpdate
>>>  # long-description: Disk image for riscv64 machines with EFI Boot Guard and SWUpdate
>>>  
>>> diff --git a/wic/x86-uefi-efibootguard-secureboot.wks.in b/wic/x86-uefi-efibootguard-secureboot.wks.in
>>> index 2af3e58..f15f9e0 100644
>>> --- a/wic/x86-uefi-efibootguard-secureboot.wks.in
>>> +++ b/wic/x86-uefi-efibootguard-secureboot.wks.in
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  include ebg-signed-sysparts.inc
>>>  
>>>  part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
>>> diff --git a/wic/x86-uefi-efibootguard.wks.in b/wic/x86-uefi-efibootguard.wks.in
>>> index 3640ecf..982a87a 100644
>>> --- a/wic/x86-uefi-efibootguard.wks.in
>>> +++ b/wic/x86-uefi-efibootguard.wks.in
>>> @@ -1,3 +1,6 @@
>>> +#
>>> +# SPDX-License-Identifier: MIT
>>> +#
>>>  # short-description: x86 with EFI Boot Guard and SWUpdate
>>>  # long-description: Disk image for x86 machines with EFI Boot Guard and SWUpdate
>>>  
>>>
>>> ---
>>> base-commit: e3158569eee297f1837a6d3fd7e0f1a0534c2b8b
>>> change-id: 20260316-license-c5fcde3618d2
>>>
>>> Best regards,
>>
>> Thanks, applied. Will follow up with fixing two more spots so that we
>> are only left with files that cannot receive headers.
>>
> 
> Quirin spotted that modifying hwrevision.tmpl is causing our red
> pipeline rigth now. I've dropped that changed and force-pushed the update.
> 

Two more files dropped (swupdate.cfg and
swupdate.handler.efibootguard.ini) in the hope to get green lights
again. Who expected funtional breakages from license tagged? :D

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

