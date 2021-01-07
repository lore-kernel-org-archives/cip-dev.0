Return-Path: <SRS0=w2Jg=GK=lists.cip-project.org=bounce+64572+6052+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D36C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  7 Jan 2021 13:38:10 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 618B82223E
	for <cip-dev@archiver.kernel.org>; Thu,  7 Jan 2021 13:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618B82223E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6052+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Z4CxYY4521723xSjAcnGlPJ0; Thu, 07 Jan 2021 05:38:08 -0800
X-Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web12.2569.1609983681875169920
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Jan 2021 17:41:21 -0800
X-Received: by mail-pl1-f179.google.com with SMTP id g3so2582165plp.2
        for <cip-dev@lists.cip-project.org>; Wed, 06 Jan 2021 17:41:21 -0800 (PST)
X-Gm-Message-State: BXx4jYNm84lrBotwG042hcLcx4520388AA=
X-Google-Smtp-Source: ABdhPJzlQ8LLbxNkprKHorYB/YH0NQx6Jcd1gCIwUf0o/cVlEQCYxjYvTFVCVLtSQneazoWh3ZpSPQ==
X-Received: by 2002:a17:902:db84:b029:dc:2efb:659b with SMTP id m4-20020a170902db84b02900dc2efb659bmr6683266pld.83.1609983681113;
        Wed, 06 Jan 2021 17:41:21 -0800 (PST)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k16sm4048400pgg.87.2021.01.06.17.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 17:41:20 -0800 (PST)
Message-ID: <5ff666c0.1c69fb81.c9cc1.a514@mx.google.com>
Date: Wed, 06 Jan 2021 17:41:20 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.163-cip40-34-g2f3a6d08a3bd
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.19.y-cip ltp-ipc: 24 runs, 1 regressions (v4.19.163-cip40-34-g2f3a6d08a3bd)
To: cip-dev@lists.cip-project.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="KRxed13e4ldw1RDRiPBv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610026688;
 bh=1uD+4kJAXZ6T2bY4yeSXWLUF1DsT9PkFnT+XDWfS6IQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=nlXCDX+owkPHI5bklO0vllhXr+udzcxq+1y8bhI1Z8CxQAWvlNVnht93DwfOvFDu8xM
 RwwJS3j2NYL+DtMH4uUgM0LrOgHofNKdl9HkLPRtIH7guIQCU5jfkofw5BId8SmUE2fpX
 kajgewsPkP25G2RroWeAAQv2vByDUsDKbMc=

--KRxed13e4ldw1RDRiPBv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip ltp-ipc: 24 runs, 1 regressions (v4.19.163-cip40-34-g2=
f3a6d08a3bd)

Regressions Summary
-------------------

platform   | arch | lab           | compiler | defconfig          | regress=
ions
-----------+------+---------------+----------+--------------------+--------=
----
odroid-xu3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.163-cip40-34-g2f3a6d08a3bd/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.163-cip40-34-g2f3a6d08a3bd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2f3a6d08a3bdbf69ef164a95911e32e37b89c0d2

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  b7ca00a6faa75fee42cb63d40f709cbfe65ec378 =



Test Regressions
---------------- =



platform   | arch | lab           | compiler | defconfig          | regress=
ions
-----------+------+---------------+----------+--------------------+--------=
----
odroid-xu3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/5ff65e9245d887cde4c94cd1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-34-g2f3a6d08a3bd/arm/multi_v7_defconfig/gcc-8/lab-collabora/ltp-ipc-=
odroid-xu3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-34-g2f3a6d08a3bd/arm/multi_v7_defconfig/gcc-8/lab-collabora/ltp-ipc-=
odroid-xu3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster-ltp/=
20201221.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/5ff65e9245d887cde4c94c=
d2
        new failure (last pass: v4.19.163-cip40-5-g95fea62f9f453) =

 =20

--KRxed13e4ldw1RDRiPBv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6052): https://lists.cip-project.org/g/cip-dev/message=
/6052
Mute This Topic: https://lists.cip-project.org/mt/79498598/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--KRxed13e4ldw1RDRiPBv--
