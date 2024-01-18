Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5B3C47DAF
	for <webhook@archiver.kernel.org>; Thu, 18 Jan 2024 19:50:42 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.57])
 by mx.groups.io with SMTP id smtpd.web11.2972.1705607436758116459
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jan 2024 11:50:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JKC6zYvr;
 spf=pass (domain: siemens.com, ip: 40.107.7.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mq7NaBJqhSxqtD2qAcmKmLU1HlqUiLqMqCMHlOBW2/p3rDIt/iysGhUwSvYw4uBDg+pEfY/bUdRHdL4MHCBFCobGnPCNzf0bOdcvt7nmnFcs/c+nPRDy/4uGNrwg9coavkElbn9ktRIIUOtFiYg5c1a0C6dE8m8uKNCrXvcBtpqbxI8j295xPM7fWyR1Qz5OeGzoTrHELsu8SYL8VqnSRz1dGszE3ccl6MoLOMQxcxH6xp/HomuUryYa7yB81sgKmWFBgkKnCDicK/wcJlfd/+6JLzB6oTg/RtEIRtBHuYc7pfAiCNKdgKhCDl/pkeb6I+Oaj9/9Ga9GI85xDKEdHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyu9Z/Dl9n+BH70sAjgYpGogY7XIioD3S/TzzzIgW1s=;
 b=JWYbBLkOMkWCkXPnWoMSFfG5D0v+XIYS/ySwjX0NOeIvU1Ne+OeI59bs8kt0sSuxmOanrRNOrBmOnu2KoyTseku2gzirIaSqS/uMNtyDQpQHMqgz2WF06GvMxW2pK4IMBcOucRpx1Yz5CHHB5peSdXU4Icv90HKY9QLOfdC3PmR3cqkKaAXiTQURXfTo4ukb5WhJ29dvnp9m7XL80fC0/LmYozklOdhSdcx0w62Edklu189lnZI3HHXEs51Fxy4fl1eoIem8GkZE43yK0d9aEN+dRsW/WoFjeRUqIQbSUDlv4KrnfPBs/1292HCFmwXgaG7Lm1kLLATGTNFcCGnj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyu9Z/Dl9n+BH70sAjgYpGogY7XIioD3S/TzzzIgW1s=;
 b=JKC6zYvrt+E17q/o4THHNwTl/957RLnTfDF2lYv14iTnEiiwMTXvvtNvF2gAXK3bYqRCtkFhkxx6icGr1PeC+V3a1sLs0CBrHmaCWqy2qid8+1wTTAe9Nc6+iSM8rrCugMeLa7Ot9IZi0vEb48IeLSNE8ObetyZwYFzkxNOL8a7PBNodGC7rRVWDO8Fi4Vldtv8GSDJSzG6kJJKVkdZnFZPp9lHbjfEOfzfjAQjwoplI0p9UUmppnhyBZ0QIo72SCARxjYmZ9JMqLyYIOQ1RY64tfKPZ0MHTm32+WOQtZPyXJ0F2r0xpl5/94i85aLYipPgp/TtKEWuvKo2LeoXKsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5947.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 19:50:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 19:50:32 +0000
Message-ID: <2b28ca7e-846f-47f3-bf8d-20e98cbe08b9@siemens.com>
Date: Thu, 18 Jan 2024 20:50:30 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH v2] efibootguard: Update to latest
 debianization
Content-Language: en-US
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 "Moessbauer, Felix (T CED SES-DE)" <felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0262.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9bf7b5-8da4-4b7c-e1fc-08dc185ebb0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	T6/5wSLZ+9TKTBzjm9NI5ufB/5lVTyMcixMNpinLT1PHYSzlYZfkMVn4oDXrqRvwlHgKSaRcqY7ym4RXTpRIzL/WdnZIjC7Fh9Ku7IS7SiX5YnFMG2sqEE21nSJyn6knRauekRpTUINqhEESGauTLd8KGjefgSobX2G5PhFZHbgzshIlGxxR5XS9koFIiPUyvXjGuIkl5fEqA+95zLeDtvaHigUk7TDFn1cZFD9QVwqOyIPYewwl9OOydsjCyYHRltKwuTVExkR6CtCd96uBzuH7jxFpX+RQ8ULe+7XgQTI3GyyTrRix0LFpRMZOK2jeeO4iiGbM+LXBxmtkvOzLqRh89x2lrzB3QNnfHzNPIevWY3JA6xp9R9hPajM0gwcQIprUHDsml28VEahPBK5tpmzwVZjC/5BOwUtPdTOzR/65DrZewfXkky0XFikBayGiQWvA90t2rF7ChHW1764lvyBc34L7RVzXuI23NVYYJwRxJKwiEZm+hkTvqQEXs7dDR3Ee1AqzuYcnyxII0YhTbH/eZGVAjkVe+uLH872GsA2oLJemUBty1O8XteiAh9KOBiUn4I5prdOFTJrmPNVksp46njoqVIQdUPFfu9GgiFrni28etpmfxCBWXIl4tvMsYQGSbr+Hb6W+eREDippCSA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(83380400001)(38100700002)(478600001)(31696002)(86362001)(36756003)(82960400001)(44832011)(54906003)(316002)(6916009)(66476007)(2906002)(4326008)(8676002)(8936002)(26005)(5660300002)(66946007)(2616005)(107886003)(66556008)(966005)(6506007)(6512007)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?emFsU1lkeFdzd0cxN3oxampyOWg5UW1XQk5sWWtlZUk5aGRGd0FxcHphNmpz?=
 =?utf-8?B?VE9oQW9xRjhIcTNrWG0yQ1ZCL0wrNVluYkNuUjRVV3FkWmlJWkNIU0VHVGs0?=
 =?utf-8?B?b1dZWUVpVXNpUWQ2Um9pSk1zempYdzlockg1b3BKYVhEeXVMbDhpbmRObnhq?=
 =?utf-8?B?UTgwVldMRHMrUmJzc2hlYUk5M0p4bVFPZWF4dFppS3RSVC8yeEdoKzVpa1FD?=
 =?utf-8?B?N3dySVN3d0E5bG5xdTJpTXFWYnNOSUNvbllHMFNpN3VRWGpRM2hKNkc0MC9J?=
 =?utf-8?B?RmZ4SmpnUEZpcGFWUzlyWUtQUEp4MlEzanllVm5lcWlwOWF1K3VVb2tiYkVO?=
 =?utf-8?B?dDRicUNGMjQyUHdUMjlTUWc4T0VQU0RWeEJWTGlWS2NkQWN5NlVRZmgyYVVI?=
 =?utf-8?B?bFdRcVI3K3FIZ2s2ejJ5S0IwdTkyMVJrM1FpaTVRLzM0VENqbjVzQmR1SWxQ?=
 =?utf-8?B?K0d6aVBueXNNZkpsZTBUTUZPamhIRXFMR0JUNTJUQzh6RDNQZzljSTQvN3Ju?=
 =?utf-8?B?OG11TzhsdnBYVDNRU043MGpZV09DdS9qV2hUMWhIQXZyQUpuZVJ4NGJIb3Br?=
 =?utf-8?B?aDVlUi9MYXNOdXYvb2dyV3lpVnlYSmtnZUo0WU9kcjY4VW5rMG1UckVJZjdP?=
 =?utf-8?B?QnQwT0t1dWZzUUhIZUVYTi9KZVJod3BYU3BaMkRvZ3BNUDdkS29Cblp0OUNY?=
 =?utf-8?B?OVQrZ3dUSmpvRGFROGhJSmFNeE1DL3VPZHhlenhFVGVmNmEzSHRZcDZ0V0V0?=
 =?utf-8?B?QWhIWlRYeXZ4ZUxKcEZTeCtGdjdNVjQwVWE5czNSWlVYYXdFVTg0WjYvYytS?=
 =?utf-8?B?Wm4rTlluYTllOVNXQ2Q4NzBiYmZReHd0UmhTOFJwa2xkSzd6U2k5M290eXB3?=
 =?utf-8?B?YjRBeWlQeFJaTjJYdFRzUE43UDZ0WjJqWGRjbDAwQ3FkMDZpN0JqUlpQbjNG?=
 =?utf-8?B?QjM5WUc4OHh0SjFiKzU3dmdnZG4xUDFRNUtYRUl5VmRGdXdSS0JZNjZLOUVW?=
 =?utf-8?B?aUs1SnV1WE1UTUoybFNMRERXK3NodmhrKzMwNGp3U0I1MmxUd00ybVNpbnI2?=
 =?utf-8?B?azJEa2FQNWtOeDBpSDFsN1BrSCtvMHNyMGxsbWV5UDdhaWsvWENUbmxnd0VM?=
 =?utf-8?B?Z1orYXFmYURQRUt3MzRGYlJGMGVuS2c2MGNPeUVDM0w1NXAxOUl5UUVndDlJ?=
 =?utf-8?B?bmJyNVpIYnBZbGovbmhOZFhzblFaVnZZc1ZDb1RrRE9iMVQ4ZW8wdE9WZlhY?=
 =?utf-8?B?d1E5MU83S3hKSDc4ZlFzRjlKMGNjZWpUdG1RTElVV3hDTnlSWUxsVUg3bURW?=
 =?utf-8?B?SWFtT05ubVlqOWdCK29wSWl6eDNWZVJQSUhrR0dJSjhUV0RSZUY4MXB5bm91?=
 =?utf-8?B?VUYzR2VtYXJWUEY4Um5odXhrZ2JkcG9va2NWYVNVTWxvY21obW5zaDdseGpW?=
 =?utf-8?B?M3I5QkxhUWEwNm40emcvY2tQQ3BJMEhrREVLNWdSempSdS9TSGVtK01yNFpT?=
 =?utf-8?B?V1pIVURUYTU5N0lOOStuM2RKeWM4WjMxRENYaUZXNk9XbXZpV0RsRUhOZmxK?=
 =?utf-8?B?alpjWXZLRHBrcjNKZmNUdkd3WlZDalJZWGttUWw0TS83ZDlNbTdLUGQrc1ZQ?=
 =?utf-8?B?L2VwdGRyT3MzanFvZHBId1hmM1hPOXhKb0ZTZWFaUXBMbnhoaTgvZ21RVHFZ?=
 =?utf-8?B?VXhBY1h1QnA0VXMrRHNSUkV5czI2NVhwYjhBeVZJaGRQN2ZjRzErUUM0dnVl?=
 =?utf-8?B?N0JNTUFBcU4yajNEd2VDWnV0ZmF3cm90eUlSaWNsdHRybkNobC9vWWY0bXJP?=
 =?utf-8?B?Ti9UZlZ2eE9QWXJ4VFdnd3N6bHdzN0ZZVXVwYW9HYWtwbExMNXR4bzZVQU1p?=
 =?utf-8?B?a0xSbHpyYTV4NEpRWGlWVURDMm9kckJxQ3hIQTY5NGJhNXJpdlBJSFBGMXA1?=
 =?utf-8?B?Y3BZQzN1Njd6OEhMSm5ZNmVSL2dKTWdwK1VQdnlySnI0cG9aTHV5UC9heEhW?=
 =?utf-8?B?aElvKzFOZXhBT3QvWGt2U3RmNGRsMjJ0WjdGdDhxaE1PMFhuWGZ4aEJHRnZL?=
 =?utf-8?B?Vkx0ajVPSlBlc0lTOG16Sk94bnZTUHNPQkcyVzd1ZGRkU2k0OHhRb3Rnd1JE?=
 =?utf-8?B?RVBlME1ZZDhVcHhkMW9YMXVzZ0pYRjhCZ250TzhGWFl3aGV4QnV3dHNlbFFh?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9bf7b5-8da4-4b7c-e1fc-08dc185ebb0e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 19:50:32.5386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjKXXcXUtR90N4vEnAn9vi4AK0LSpw+Jd/Ma6ZUdEWG0YVHDIRFmDatIBqT8ZZt9VEwFa26owKdJcciZh9Mvxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5947
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jan 2024 19:50:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14408

From: Jan Kiszka <jan.kiszka@siemens.com>

This fixes cross-building and allows to use python3-shtab in bookworm
and newer from Debian directly - at least as long as that version does
not include the Multi-Arch hint that was recently added and that also
our own shtab recipe uses. That one, in turn, is incompatible with the
:native suffix that was now added to efibootguard's dependency. We
therefore also need to switch our shtab debianization to a version
without Multi-Arch yet. What a mess.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

I was considering to hold this back until python3-shtab 1.5.5-4 has been 
uploaded by Debian but that would delay our CI testing of riscv64 
because cross-building python3-shtab for that arch is currently broken.

Note, though, that the generated swupdate image will not boot in qemu
because  the 6.1 kernel (just like other upstream kernels) is missing 
https://lore.kernel.org/lkml/42c63cb9-87d0-49db-9af8-95771b186684@siemens.com/

 ...bootguard_0.16-1+cip.bb => efibootguard_0.16-3+cip.bb} | 8 +++++---
 ...{python3-shtab_1.5.5-4.bb => python3-shtab_1.5.5-3.bb} | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)
 rename recipes-bsp/efibootguard/{efibootguard_0.16-1+cip.bb => efibootguard_0.16-3+cip.bb} (89%)
 rename recipes-python/shtab/{python3-shtab_1.5.5-4.bb => python3-shtab_1.5.5-3.bb} (91%)

diff --git a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
similarity index 89%
rename from recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
rename to recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
index a7ffb00b..83be2a4d 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020-2023
+# Copyright (c) Siemens AG, 2020-2024
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -24,7 +24,7 @@ SRC_URI = " \
     file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
     "
 SRC_URI[tarball.sha256sum] = "d6d37c59aed17489d02b4f0b63db16994dfb8f9f70f54be4d65c366f58c6be9d"
-SRCREV_debian = "2e80fafa87f8f6fd093f49ff33ad7cac61592871"
+SRCREV_debian = "22b173a3293c976c9dff2ae92085d7ed995f6768"
 
 PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
 
@@ -34,7 +34,9 @@ PATCHTOOL = "git"
 
 inherit dpkg
 
-DEPENDS = "python3-shtab"
+DEPENDS:buster = "python3-shtab"
+DEPENDS:bullseye = "python3-shtab"
+
 # needed for buster, bullseye could use compat >= 13
 python() {
     arch = d.getVar('DISTRO_ARCH')
diff --git a/recipes-python/shtab/python3-shtab_1.5.5-4.bb b/recipes-python/shtab/python3-shtab_1.5.5-3.bb
similarity index 91%
rename from recipes-python/shtab/python3-shtab_1.5.5-4.bb
rename to recipes-python/shtab/python3-shtab_1.5.5-3.bb
index 7a5cfd2d..f20cdcf7 100644
--- a/recipes-python/shtab/python3-shtab_1.5.5-4.bb
+++ b/recipes-python/shtab/python3-shtab_1.5.5-3.bb
@@ -19,7 +19,7 @@ SRC_URI += " \
 SRC_URI:append:buster = " \
     file://0001-Lower-requirements-on-setuptools.patch"
 
-SRCREV ="8db4615b2c3ee0a9332b6030687e1179fcfc8670"
+SRCREV ="3cdca7c8f4ead23c194c4e8a84e2631989e26b3c"
 
 # We don't have pristine-tar in this tree hence use this option
 GBP_EXTRA_OPTIONS = "--git-no-pristine-tar"
-- 
2.35.3

