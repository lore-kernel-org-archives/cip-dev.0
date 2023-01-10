Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C1CC46467
	for <webhook@archiver.kernel.org>; Tue, 10 Jan 2023 19:47:35 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.54])
 by mx.groups.io with SMTP id smtpd.web10.3407.1673380044271025281
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Jan 2023 11:47:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kw12db8q;
 spf=pass (domain: siemens.com, ip: 40.107.7.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTdvYzHBENLEQL9sdA+cbZg4WoCtiIupSJE90R7WQ+XWMIQJgUyWoZ67B6SDAaXFd0w5cP+fpVfboxViES4zQX43QAqCZz8l+VSAZjkLZ4rylr3CL2CFrGi/JQXFwYVkEj1tb7nC/WE4cQgmHXfz5bUukD9X8I4Ibu3zpTveB3012V0Zstj+II+jiOrldxOx55OJE2keMr2x0Gmei5mfk+iClyI6IaQncpthqyui6xHFQ2OoICanDwyuM862IHUZ6Af+gwTxQTXd9BMRko9XWbwnOMAWKUBffmzDoyj8diuM5o8Wwp709GRYaZNF6eVbrXr00XoSukLEQwuOUQDmYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eba4bMVswg9OxqVCNnn3fzqZndpgvsW9SdHzeMNzoM=;
 b=oGvsrzu+i1kMgpUxpe8OK61Gdj3sp1PJIqsCK0zXW8RTwpy80IoxANz2tcc47y03nl8VRIr+WwC3rK4PTOyQ4v9B2Fwmi5u/cIPbRRJ7lumDZIEfYksMCm0OMNg9CbODoKDFA6m1jwvXNs9jwAgzb3qrjkMEg9b2qibUUpBe9thM26Wj/fXch/6H44lunnI7F5dDhf25nc5FS4qX77+X/V9yANzrxkY2F0WB4UOrMZY58h2crtjmi+9V+Xb+ZEc3jjhfxCzN/BdANmMcE8nUhS9nKjJiTwOXMax9fsOHgSpri8jGgSrGlBVT9qQBb50OzPp/mFFWQlpTY3CoKv04ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eba4bMVswg9OxqVCNnn3fzqZndpgvsW9SdHzeMNzoM=;
 b=kw12db8qPHi4Urty6utiYQ7x3GvK4gO7I8SCFr8s0tFYUuJNzTKy8COEvzQpy8WhsATeUoHCJ7bhfY38diojGHSJ20UX4qTI5Vdf2chCkYeUxhxATJyelVwIEo3o6MvM2wy+cQc+d1PfatBxUOoYdW1XoERfy5JXZLjQRQiwWdgssC7PYL7TPPnrKIvpayMtb27/l+7zgZxhZOX634TtdDQW+BTL8XhH7MvwmYCLHAboEitac8Ljcxr0XCIPLj76mmx/748KOvZFfsC8tRGNqW0/bo/MQBtA63pConMHc3AuI4nuQxMid1UFvqWGGZbE0PUpbZiDIPiEfEe+h7SNSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7296.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 19:47:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%6]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 19:47:20 +0000
Message-ID: <b6ae5c2f-962b-4291-4673-c26f0909fc95@siemens.com>
Date: Tue, 10 Jan 2023 20:47:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] Add recipe for EDK2 StandaloneMmRpmb
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: "Schultschik, Sven Angelo (PD PA CI R&D 4)"
 <sven.schultschik@siemens.com>,
 "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
 Christian Storm <christian.storm@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0386.namprd03.prod.outlook.com
 (2603:10b6:610:119::29) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c8b899-cbb3-4f17-25d9-08daf3437c75
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xETe3gd3u7GIGi17wxOqD1qW3DKwU5sP1h9Y1wheQ9MZ26SJnBlzzGWWzxyn5dTWXrQCnToAiUugavRxXM6nR+tBmP3WvN0DxHTVbPEQztaTRyPDg7LajokeFntcrheNX/NQTs/aAiTOLm/y6uy40A1e6V8eS3yMmkIa3Qou0XR7x2tBkoe3QsFV3gGPE8SjenMKqp9oZSN3U76UIyz7E9vErvvGZN6akaI65OgmvPM3zgWvaBKjaRL4sJsrcN3MO5HUKjpc7Y8m2hsPTnOC8BDH4iN23aOtPlaFENG2vwNtt9HxmG6mb+GXyjFIm+1CaaXuTVqkcxlyNNw0vYHjHJCHTPNoDEGswDqAyxvUQ0u3Z3E+L3Z364fAN/jNh5IZSBQ9qcWIinZQ5hnHMyuPSJcwE5fa85N45E98PyMECKUlJeANCvKx+b0yAYHIjxyhsCk/0WXoNYCFwkRpmKa4of4Uu7O9Y8rjKyFXeQDC6fD56cL3I4MeIB70ZDDcV/WHBN2p3vI2DINZINadff/M1iLL5RFSxLnc07nPcbZDR6h8/xbLg7+rcDPzHx9CgEU6cuOKSzIZ0xrP6QuG4hcz8D2CBZYvLhCDOsn6uc8v6hRuRKVr2PlvL4DRIg7Dbf3u7reH2Mftf5TctwvPa6uGT84PbJPIQXrWUnnjs+SAlu8FfhoyDf4wRVpVkCKNJWcgClZNds3KLDkGjKW9rzNHOgNWb1AtSKkXDDwaqhc17NrQR6LCpK4kx5NM8OcJgIDSGDlKrw5UMEQ9Y0yje7JIAmu5lnf1eqrtS5RpCTFKQKU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(6029001)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199015)(6506007)(38100700002)(82960400001)(31686004)(6666004)(107886003)(2906002)(478600001)(6486002)(966005)(2616005)(26005)(6512007)(186003)(44832011)(5660300002)(316002)(83380400001)(8936002)(36756003)(86362001)(41300700001)(31696002)(8676002)(54906003)(4326008)(6916009)(66946007)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QVdCV25Yb2gzczN2UjJEbm1IZE05eFVrVEx5ZTZEc01tMGNiRldVT09zOXBz?=
 =?utf-8?B?MkRnOHY0bi96TVFyVFZXQ0ZObXlaWFhiSlA5QkZKQ2kyemFPajZzTytRdkR4?=
 =?utf-8?B?Mzl6bnVvT2xXcnBBVlJ0VmVqOFlwVnB5RVh2WGE2N3ZlcUhZZU0xbkR5TkZB?=
 =?utf-8?B?YmY3Y1BJTnRVN3RmL1JZcHlZR0JIUGY3azYzZU11T1BiQ3JUbURnNnNvVFl1?=
 =?utf-8?B?TjE5QXl5alI1dkRPb3h2RGR0S0VMSFJucGJuaUZHSlZCU0s0QXlBWmZramN1?=
 =?utf-8?B?K01tS0U3L25jRkFoa2prTnJjL2E0OXR0ZGlJMHN6TWV1OTZxdU1QdXE2VmlD?=
 =?utf-8?B?cnBZZ3FQbjJCOEI0WjNONDNOaTloeWgxNzdac2RaYjdKZ2ROR0dPUFpHUEp5?=
 =?utf-8?B?T0VLL2xWN3VkZDY3NjQvSkpEdllXcHBnV01abm91eDlWYUczdEZtTkYrVCtM?=
 =?utf-8?B?OGRoMG9BcjlENm5yWHFIMzk4RGsxcGVpNEszbVN5dFF6U2l2a1FERlpnWXpn?=
 =?utf-8?B?dEQ2eUZMdjNFdkk4M3R0S3FTU2EyK0g0QjRXYUJ3NUZYdTQxQUpNWWtnLzIy?=
 =?utf-8?B?dVRxZGp1cjZyZ0oza3IzNHROQzkyM2pQYThMcUJOcy9hMlVESzc3ZldiSUJ1?=
 =?utf-8?B?QkJmZHJNaWdOdWlvejg0dVlueU01eE9WSW1aOGlwemJ2QVV2SHhLVjU4dW55?=
 =?utf-8?B?VzRnYWs2UmpHd1A3ODNKakVxSHNnRVpXcmpWVys3SmJ4b2tNc1p5amgybk5i?=
 =?utf-8?B?Z3I5REI4QlRKSzl1RjJ2YXgvNU4rZUxrdkcrZmh1eWRLS0dvbk03VCtGUUZT?=
 =?utf-8?B?SDBaL3RrbmsxTGQwZkVydDRzVTlmVTRNVTl5UytBZlU5MUk4REVDbG9BNFNI?=
 =?utf-8?B?Y010NlBqVytwMDdpS2JWVm50YnZEWFg1MDVjOUU3UWpSTUdrWW5aSWljangr?=
 =?utf-8?B?S2RUQ0Z6N0dWSy9hdlFBTERvTVVDZDNuMUQvZngvU3VqcWxwa09nanVYNXdI?=
 =?utf-8?B?U1NocmIxR0t1bzE3VXpRSHZKL2FaU2ZRd2FmTDJiYjAva2kyTlVBUjkwSkxG?=
 =?utf-8?B?QVlYa2hVNUEyR0lwSHIvRElrNy9sS2tDMWRjaTBTdXc0ZnZOUS9TRTM1ckpH?=
 =?utf-8?B?TDVRL3ZiOU5SRUYxWkFhL3lMS0UzUkNOa0pXbW1FeE1Udk1UeGRsZnFCR2x4?=
 =?utf-8?B?VHVVZ3hxbGdobFZlZ1hQSHZjZDZJa201VjVGN0gvWUtuY1dPbDdmZFJwVnpn?=
 =?utf-8?B?S3R5aHNnUFg2RGhSTWV1RG1EWVV6cEhCUHVWOE1mdm5tN0xnTmFPYUdnVjdQ?=
 =?utf-8?B?VGhTSVhQNHluWUw2YXRCaEtMOW81NW42ZDhDWTR3SER1cnhQT2FvS1hnV0d5?=
 =?utf-8?B?YzR0d3ZkV1ZYTDlodTJnSm9GamtMT20wajkzd3ZZbnI4Zk1Kc3dvR2pqMUJh?=
 =?utf-8?B?T3ZxVWZ1N1daYjJ3VFZVVEh1bm0wTklsSnNYSUlkMHprK3EvUUY4d2dPSTBX?=
 =?utf-8?B?REZnQkxxNC8ybS9oSVIxQmRCRzJRT3RBcTFHRm1YdWpwdC8wMkthRkJvd1hq?=
 =?utf-8?B?cW9VVVM4bCtHLzMxSmJubDVWelJqYWhZVjkrVkxNY3hQanJqbE9TckF1STlv?=
 =?utf-8?B?RTNkZ3p0bWNPMjZSUy9qeDFHT3ZCZEVyTmU5SktaZE5FZlM3STIveEJLTkRj?=
 =?utf-8?B?V3NiTGhqelFaVTBhY040dkttVEdYWmJGdjlXZlFTTWR6dGtQZ1kwL0g2dWJW?=
 =?utf-8?B?bUJHMGpVV3N1K3VzVG1PUXRydGNyY3lWR2VrMU5tVDBzZ3VSRURTQ3E5NVht?=
 =?utf-8?B?WDUxUk9yUElvSnBCOVlyM056WGdLWEZOaHV6VXhHRnN6WmMvVVhwUXJsQzN5?=
 =?utf-8?B?VnA0YlZtUng5QVhudzFJZUY3OWxuZ3BHRzVPSDVQZW9xcmMvUzVkbHljazhj?=
 =?utf-8?B?L1p5bE5HRHg3SFErakhQdFBJV05PaGR5c3ZqVHZ2b3lCU05rR285cGVmT3FW?=
 =?utf-8?B?SGVTRVdZcTBZUFZtZ2dHTUptYi9WWjRmTTFEWGwzemFiZEVtMkRUeS9TU0x1?=
 =?utf-8?B?M1V3ZzM4Ukw4TmJIZi9aR05aUzRtMXhsdGc4OWMxRWhER3lqMzZXNEh1WTZL?=
 =?utf-8?B?SWQ0L1M3ZnUwSE1PSFlmNmRyUHhZUWMzd2lMNmludk90UjU2L2NPR1NMK2Mr?=
 =?utf-8?B?VFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c8b899-cbb3-4f17-25d9-08daf3437c75
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 19:47:20.5100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5AChyDXdTOepkx/PM4bx9gECjDZtAUPepQmYQdB8W6eX2/DmAgyqb/8kI4Fm6Lrf2124cKzA7QBSrSuAIlp6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7296
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Jan 2023 19:47:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10339

From: Sven Schultschik <sven.schultschik@siemens.com>

Provide a recipe to create the BL32_AP_MM.fd binary from EDK2. This
binary provides a stand-alone version for securely managing the access
to EFI variables stored in RPMB. It needs to run in a Trusted Execution
Environment (e.g. under OPTEE on ARM), thus will become a dependency of
firmware build that what to provide UEFI secure boot with keys
provisioned into secure storage.

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
[Jan: refactorings]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes to Sven's last version:
 - renamed recipe
 - dropped .inc
 - updated to 202211
 - avoid copying sub-module folders around
 - fetch edk2-plaform as archive
 - added bash as build dependency
 - smaller cleanups

I did not try fetching the openssl sources from Debian. That may work 
today with bullseye, because at least fragile with buster and will fail 
with bookworm (no more OpenSSL 1.x). We need to vendor.

As explained in the other thread, I would accelerate the merge of this 
even though we don't have in-tree users. meta-iot2050 will soon become 
the first external user while creating a useful QEMU target 
unfortunately requires creating an eMMC+RPMB model in QEMU first. :(

 recipes-bsp/edk2/edk2-standalonemm-rpmb/rules | 64 +++++++++++++++++++
 .../edk2/edk2-standalonemm-rpmb_202211.bb     | 57 +++++++++++++++++
 2 files changed, 121 insertions(+)
 create mode 100755 recipes-bsp/edk2/edk2-standalonemm-rpmb/rules
 create mode 100644 recipes-bsp/edk2/edk2-standalonemm-rpmb_202211.bb

diff --git a/recipes-bsp/edk2/edk2-standalonemm-rpmb/rules b/recipes-bsp/edk2/edk2-standalonemm-rpmb/rules
new file mode 100755
index 00000000..4161e6ca
--- /dev/null
+++ b/recipes-bsp/edk2/edk2-standalonemm-rpmb/rules
@@ -0,0 +1,64 @@
+#!/usr/bin/make -f
+#
+# Copyright (c) Siemens AG, 2022-2023
+#
+# Authors:
+#  Sven Schultschik <sven.schultschik@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
+export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
+endif
+
+export WORKSPACE=$(shell pwd)
+export PACKAGES_PATH=$(WORKSPACE)/edk2:$(WORKSPACE)/edk2-platforms
+export ACTIVE_PLATFORM="Platform/StandaloneMm/PlatformStandaloneMmPkg/PlatformStandaloneMmRpmb.dsc"
+
+# https://github.com/tianocore/edk2-platforms/blob/master/Readme.md#if-cross-compiling
+ifeq (arm64,$(DEB_TARGET_ARCH))
+export TARGET_ARCH = 'AARCH64'
+else ifeq ((armhf,$(DEB_TARGET_ARCH))
+export TARGET_ARCH = 'ARM'
+else ifeq ((amd64,$(DEB_TARGET_ARCH))
+export TARGET_ARCH = 'X64'
+else ifeq ((i386,$(DEB_TARGET_ARCH))
+export TARGET_ARCH = 'IA32'
+else
+$(error DEB_TARGET_ARCH $(DEB_TARGET_ARCH) unsupported)
+endif
+
+export SHELL=/bin/bash
+
+# ENV Vars which should get set by edksetup.sh
+export PYTHON_COMMAND=python3
+export PYTHONHASHSEED=1
+export CONF_PATH=$(WORKSPACE)/edk2/Conf
+export EDK_TOOLS_PATH=$(WORKSPACE)/edk2/BaseTools
+export PATH=$(WORKSPACE)/edk2/BaseTools/Bin/Linux-$(TARGET_ARCH):$(WORKSPACE)/edk2/BaseTools/BinWrappers/PosixLike::/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
+
+# When cross-compiling, or building with a different version of the compiler than
+# the default `gcc`, we additionally need to inform the
+# build command which toolchain to use. We do this by setting the environment
+# variable `{TOOL_CHAIN_TAG}_{TARGET_ARCH}_PREFIX` - in the case above,
+# **GCC5_AARCH64_PREFIX**.
+# export GCC5_AARCH64_PREFIX=aarch64-linux-gnu-
+# using export here at TOP Level does not work, because
+# GCC5_$(TARGET_ARCH)_PREFIX gets deleted again for what reason ever
+# Therefore it is set right before the build command
+# export GCC5_$(TARGET_ARCH)_PREFIX=$(DEB_HOST_GNU_TYPE)-
+
+override_dh_auto_build:
+	source edk2/edksetup.sh --reconfig
+
+	CFLAGS= LDFLAGS=  make -C edk2/BaseTools
+
+	(export GCC5_$(TARGET_ARCH)_PREFIX=$(DEB_HOST_GNU_TYPE)- && \
+		build -p $(ACTIVE_PLATFORM) -b RELEASE -a $(TARGET_ARCH) -t GCC5 -n $(shell nproc))
+
+override_dh_auto_install:
+
+override_dh_auto_test:
+
+%:
+	dh $@ --no-parallel
diff --git a/recipes-bsp/edk2/edk2-standalonemm-rpmb_202211.bb b/recipes-bsp/edk2/edk2-standalonemm-rpmb_202211.bb
new file mode 100644
index 00000000..40d979d9
--- /dev/null
+++ b/recipes-bsp/edk2/edk2-standalonemm-rpmb_202211.bb
@@ -0,0 +1,57 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022-2023
+#
+# Authors:
+#  Sven Schultschik <sven.schultschik@siemens.com>
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+HOMEPAGE = "https://github.com/tianocore/edk2"
+MAINTAINER = "Sven Schultschik <sven.schultschik@siemens.com>"
+
+inherit dpkg
+
+SRC_URI = " \
+    https://github.com/tianocore/edk2/archive/refs/tags/edk2-stable${PV}.tar.gz;subdir=${S} \
+    https://github.com/tianocore/edk2-platforms/archive/${SRCREV-edk2-platforms}.tar.gz;name=edk2-platforms;subdir=${S} \
+    https://github.com/google/brotli/archive/${SRCREV-brotli}.tar.gz;name=brotli;subdir=${S} \
+    https://github.com/openssl/openssl/archive/refs/tags/${PV-openssl}.tar.gz;name=openssl;subdir=${S} \
+    file://rules \
+    "
+SRC_URI[sha256sum] = "b7276c0496bf4983265bf3f9886b563af1ae6e93aade91f4634ead2b1338d1b4"
+SRC_URI[edk2-platforms.sha256sum] = "b0f5b6d832e4dcc1d47a98ae0560e0b955433e32e8ac6d12c946c66d5fa6f51a"
+SRC_URI[brotli.sha256sum] = "6d6cacce05086b7debe75127415ff9c3661849f564fe2f5f3b0383d48aa4ed77"
+SRC_URI[openssl.sha256sum] = "6b2d2440ced8c802aaa61475919f0870ec556694c466ebea460e35ea2b14839e"
+
+# according to edk2 submodules
+SRCREV-brotli = "f4153a09f87cbb9c826d8fc12c74642bb2d879ea"
+
+# revision closest to edk2 release
+SRCREV-edk2-platforms = "4ad557e494d8055f5ea16009d6e565cace6571d6"
+
+PV-openssl = "OpenSSL_1_1_1n"
+
+DEBIAN_BUILD_DEPENDS = "bash, python3:native, dh-python, uuid-dev:native"
+
+do_prepare_build() {
+    deb_debianize
+
+    ln -sf edk2-edk2-stable${PV} ${S}/edk2
+    ln -sf edk2-platforms-${SRCREV-edk2-platforms} ${S}/edk2-platforms
+
+    rm -rf ${S}/edk2/BaseTools/Source/C/BrotliCompress/brotli
+    ln -s ../../../../../brotli-${SRCREV-brotli} ${S}/edk2/BaseTools/Source/C/BrotliCompress/brotli
+
+    rm -rf ${S}/edk2/MdeModulePkg/Library/BrotliCustomDecompressLib/brotli
+    ln -s ../../../../brotli-${SRCREV-brotli} ${S}/edk2/MdeModulePkg/Library/BrotliCustomDecompressLib/brotli
+
+    rm -rf ${S}/edk2/CryptoPkg/Library/OpensslLib/openssl
+    ln -s ../../../../openssl-${PV-openssl} ${S}/edk2/CryptoPkg/Library/OpensslLib/openssl
+
+    echo "Build/MmStandaloneRpmb/RELEASE_GCC5/FV/BL32_AP_MM.fd /usr/lib/edk2/" > \
+        ${S}/debian/edk2-standalonemm-rpmb.install
+}
-- 
2.35.3

