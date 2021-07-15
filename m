Return-Path: <SRS0=orKS=MH=lists.cip-project.org=bounce+64572+6621+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EF9C12002
	for <cip-dev@archiver.kernel.org>; Thu, 15 Jul 2021 01:01:27 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20BD1613CC
	for <cip-dev@archiver.kernel.org>; Thu, 15 Jul 2021 01:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BD1613CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6621+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id h4sSYY4521723xPsxMTwBsR3; Wed, 14 Jul 2021 18:01:26 -0700
X-Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
 by mx.groups.io with SMTP id smtpd.web08.1918.1626310884144603996
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jul 2021 18:01:25 -0700
X-Received: by mail-ot1-f50.google.com with SMTP id 42-20020a9d012d0000b02904b98d90c82cso4456516otu.5
        for <cip-dev@lists.cip-project.org>; Wed, 14 Jul 2021 18:01:24 -0700 (PDT)
X-Gm-Message-State: Ovhg7wbV6PWurVCDarCBEErSx4520388AA=
X-Google-Smtp-Source: ABdhPJyWyELCoPs7r15ggoKqRBCn4fdrleQsPuoB959wjFiD5NSfzfnqNq0XbweIQLz1Sm+Lvir48s7vuPsf2VG/BvM=
X-Received: by 2002:a9d:12ce:: with SMTP id g72mr752753otg.179.1626310882965;
 Wed, 14 Jul 2021 18:01:22 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?5biC5bed5q2j576O?= <masami.ichikawa@miraclelinux.com>
Date: Thu, 15 Jul 2021 10:00:47 +0900
Message-ID: <CAODzB9rgNngZ9GMZgJYGNr-+ruYxhYSr7q4dXCKgrO89PAAfWA@mail.gmail.com>
Subject: [cip-dev] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="Wrd3zNsFaBBwiD84WXVU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1626310886;
 bh=145NVaFGjBs6Ec9EChu0PPl21r7o2eTvzhduhtz/Bh4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=cxqEiim7g8FKaovM8sWRqtrTTfAyx7Up2q4jgwUx7YDsMBIAsKf7tGFsUrlgNx4t6ms
 U61KS9p8QhbtIh1Oz89idPjRUtcncl4PUXfYISMgA0gfR5WitoM85ymjiFKsA37m6s7Jc
 n/rv/9u/IwyvybioJLVFPHEFi6pfGIhScg8=

--Wrd3zNsFaBBwiD84WXVU
Content-Type: text/plain; charset="UTF-8"

Hi !

It's this week's CVE report.

CVE Summary

There is one new CVE.

CVE-2021-22555: Affects all CIP kernels

There is two updated CVEs

CVE-2021-34693: CIP kernel 4.19, 4.19-rt, 4.4 are fixed
CVE-2021-35039: CIP kernel 4.19 and 4.4 are fixed

From last week CVEs

CVE-2020-28097: CIP kernels are fixed
CVE-2021-29256: it seems not fixed in mainline yet
CVE-2021-31615: it seems not fixed in mainline yet
CVE-2021-35039: CIP kernel 4.4 and 4.4-rt aren't affected. 4.19 is fixed

* New CVEs detail

- 2021/07/12

CVE-2021-22555 -- Heap Out-Of-Bounds Write in xt_compat_target_from_user

The compat IPT_SO_SET_REPLACE/IP6T_SO_SET_REPLACE setsockopt
implementation in the netfilter subsystem in the Linux kernel allows
local users to gain privileges or cause a denial of service (heap
memory corruption) via user namespace.

This vulnerability affects from v2.6.19-rc1 to v5.11.

Fixed status.
cip/4.19: [12ec80252edefff00809d473a47e5f89c7485499]
cip/4.19-rt: [12ec80252edefff00809d473a47e5f89c7485499]
cip/4.4: [b0d98b2193a38ef93c92e5e1953d134d0f426531]
cip/4.4-rt: not fixed yet
cip/5.10: not fixed yet

* Updated CVEs detail

CVE-2021-34693 -- can: bcm: fix infoleak in struct bcm_msg_head

Fixed status

cip/4.19: [8899857d7e450805e6410de5004126491f197146]
cip/4.19-rt: not fixed yet
cip/4.4: [f638caa211e7a121a5596986d29ebbdaf9156398]
cip/4.4-rt: not fixed yet
cip/5.10: not fixed yet

CVE-2021-35039 -- module: limit enabling module.sig_enforce

Fixed status

cip/4.19: [ff660863628fb144badcb3395cde7821c82c13a6]
cip/4.19-rt: not fixed yet
cip/4.4: not affected
cip/4.4-rt: not affected
cip/5.10: not fixed yet

* From last week CVE report

CVE-2020-28097 -- vgacon_scrolldelta out-of-bounds read

This vulnerability affects before v5.9-rc6, so v5.10 kernel doesn't affect.

Fixed status

cip/4.19: [f5fa64c8daf7b97280865c73903edc0a3eea819e]
cip/4.19-rt: [f5fa64c8daf7b97280865c73903edc0a3eea819e]
cip/4.4: [5f76b4c6ac297ce836abe17f495123f45bfc4fb3]
cip/4.4-rt: [5f76b4c6ac297ce836abe17f495123f45bfc4fb3]
cip/5.10: not affected

Since CONFIG_VGACON_SOFT_SCROLLBACK option has been removed by this
CVE fix, we can remove this option from these configs in
cip-kernel-config repo.

- 4.19.y-cip/x86/cip_qemu_defconfig
- 4.19.y-cip/x86/plathome_obsvx2.config
- 4.19.y-cip-rt/x86/siemens_i386-rt.config
- 4.4.y-cip/x86/cip_qemu_defconfig


CVE-2021-29256.yml -- Mali GPU Kernel Driver elevates CPU RO pages to writable

According to the
https://developer.arm.com/support/arm-security-updates/mali-gpu-kernel-driver
, it said "This issue is fixed in Bifrost and Valhall GPU Kernel
Driver r30p0. It will be fixed in future Midgard release. Users are
recommended to upgrade if they are impacted by this issue." so it
seems that CVE hasn't been fixed yet.

CVE-2021-31615 -- InjectaBLE: Injecting malicious traffic into
established Bluetooth Low Energy connections

According to the
https://developer.arm.com/support/arm-security-updates/mali-gpu-kernel-driver
, it said "This issue is fixed in Bifrost and Valhall GPU Kernel
Driver r30p0. It will be fixed in future Midgard release. Users are
recommended to upgrade if they are impacted by this issue." so it
seems that CVE hasn't been fixed yet.

CVE-2021-35039 -- Without CONFIG_MODULE_SIG, verification that a
kernel module is signed, for loading via init_module, does not occur
for a module.sig_enforce=1 command-line argument.

Fixed status

cip/4.19: [ff660863628fb144badcb3395cde7821c82c13a6]
cip/linux-4.4: not affected
cip/linux-4.4-rt: not affected
cip/5.10: not fixed yet

Regards,

-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--Wrd3zNsFaBBwiD84WXVU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6621): https://lists.cip-project.org/g/cip-dev/message=
/6621
Mute This Topic: https://lists.cip-project.org/mt/84216032/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Wrd3zNsFaBBwiD84WXVU--
