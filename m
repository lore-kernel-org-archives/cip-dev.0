Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295DAC3F6B0
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 18:19:19 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web12.178.1659550747146786407
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 11:19:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=x1KRRMPv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id h28so10838296pfq.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 11:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=0yBqqAGz+Caji8HQMsnVquA9/4tykGp9sGU9mkynTqQ=;
        b=x1KRRMPv+k8R7ENOixk9kFRDlavLTIWkE8vsIbTmMO6Ar5P5WwJMTvtxv0H60LrNX9
         t7Tdj5+SW4XiO4S9eMKDNfwnfpnHKzqh3kfYiIIUmfDf9KunKTa68lChiIt9et1Q9YD7
         J2VvomGmryJnrmjgCgZZRydkN4cYYbOm5THrqaLVLi+9cSLO+VP2332+3lwklIvZe14x
         QAKaqDwysY9imAnoujdElT/jyO66T46e4vVv1d4RgXXqP3mT9M8WgRqC573fGn4RCai6
         Oes1j3eY4eaCOB0mQO8P8hpzEl8kVAjpzgdupOCCdU+CLYF8q35SprLxzMp81GHHctu2
         EwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=0yBqqAGz+Caji8HQMsnVquA9/4tykGp9sGU9mkynTqQ=;
        b=V5hL1M9Ld4XcdmHfS6RDQfNocAb+1RVPEA0XOVRljapfbxc/fMrNDf6g1SmoRJAUBd
         FTSwlvGSixvqXKlKdS0E4+fWCSkRNmQWZLausVwEfaVLzeiG2aIUAmTROMlSuhEbdTeQ
         PSiRMTdXPInjyBBBAsLJr+gkRDpzHMZjl4Ouam4olkZQfPh1TKL4k+v3xC97b2lse1Ax
         WLmSYd2HVH1KAEGMj6xHLi6ZMSd3L/0CO5d6unUsjc24y3zmqpwk/L9NI0roA6DishG2
         wuIpJzAw2751MaDXzhkj9WhOn+ZjZS1xhuDyA+5nBLnM6MFX9Zw0JpWQVGyvPB9gHlxU
         NI3w==
X-Gm-Message-State: ACgBeo27+aPYHqO3q4mFUSX0ch3bRT5uokU38auj7mID5Z9VNCoXDpwq
	lvXnG/QXf1IZBERmcQLV2P7sDZpi0VoXC0FJxB8=
X-Google-Smtp-Source: 
 AA6agR66j552EWFDggj7bhQhskrj84pm+BDD+AuR3aPy/t7nAhu19Lqqo8zBycKrRU3EGU4hoq/w1g==
X-Received: by 2002:a63:5b21:0:b0:41c:2292:b2e7 with SMTP id
 p33-20020a635b21000000b0041c2292b2e7mr12086677pgb.46.1659550744985;
        Wed, 03 Aug 2022 11:19:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 p14-20020a170902780e00b0016bfafffa0esm2281855pll.227.2022.08.03.11.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 11:19:04 -0700 (PDT)
Message-ID: <62eabc18.170a0220.cb3d.40c6@mx.google.com>
Date: Wed, 03 Aug 2022 11:19:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-24-ga6f4ea41fe167
Subject: cip/linux-5.10.y-cip kselftest-lkdtm: 6 runs,
 2 regressions (v5.10.131-cip13-24-ga6f4ea41fe167)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 18:19:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9102

cip/linux-5.10.y-cip kselftest-lkdtm: 6 runs, 2 regressions (v5.10.131-cip1=
3-24-ga6f4ea41fe167)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-24-ga6f4ea41fe167/plan/kselftest-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-24-ga6f4ea41fe167
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a6f4ea41fe167f956d4000eaf276a1e383603071 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62eaa93a3f80260175daf05b

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62eaa93a3f80260175daf061
        failing since 36 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62eaadc184fe21b455daf067

  Results:     37 PASS, 17 FAIL, 25 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-24-ga6f4ea41fe167/x86_64/x86_64_defconfig+x86-chromebook+kselftest/g=
cc-10/lab-collabora/kselftest-lkdtm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_STACK_FRAME_FROM_sh: https://kernelci.or=
g/test/case/id/62eaadc184fe21b455daf06d
        failing since 36 days (last pass: v5.10.121-cip9, first fail: v5.10=
.125-cip10) =

 =20

