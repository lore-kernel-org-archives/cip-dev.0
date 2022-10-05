Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9D3C4321E
	for <webhook@archiver.kernel.org>; Wed,  5 Oct 2022 13:19:15 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web08.23374.1664975948403453176
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Oct 2022 06:19:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=G5LRoiY7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d10so15793659pfh.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Oct 2022 06:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=s0mUy6F2GxRV5rvm/4QkfBJHL7hvB63NUjlobXO+EJU=;
        b=G5LRoiY7CSth1CbkR9gX37h+TIYBu4A2KcVMI1H4ioYut67xb6s/30DbCbboo6UEyM
         DQgh0wR25k/V5ijVgxfJBGdRIigdIaLWB8i1I+11CJsALhZa50mb7/pfDX2Su5Hc4BeN
         dmq5kDK35mUpA2WfA6f6s7GgRkad3tzBlHNMbGrjCArehalbtgOO+bS85cEAWU9pP/fH
         HjT1p970IuwIIWn73pLw7S7x3KmvZI4ALDWm7PHhPTFF4CMZF0nxMvnevLkQsQc84C7S
         E80xEfvPxTJIGOSFiaV0tNs/cu7Ofu2NSO4UMMl4qPfKT0EbLJP3ZJ1lbhWLoDZyqcPg
         /iaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=s0mUy6F2GxRV5rvm/4QkfBJHL7hvB63NUjlobXO+EJU=;
        b=mr+dU+tDbwjhtMcgr5iePMavhr2C8Yri5cUOU2OiAdOpAF20YY7zzO0sjRuodquhGc
         G+lz6cMGG5aRwUrDQQ99kVPD0Z0lAK/FgLOBBS+RFBMPxVo/3XLxRtWF+BsqSnW4xanw
         /+iXLgrNuTwWf/cgvjtfBOUlmfOa9dFzsE8LruymJPxDtdScw9lPT9IoBjTfLaMKkV2q
         B2j76zcHGE33aOgt2tyroDETIjGlGN9mxCt3DBZYuJgkBOoIdZL+FuPodr49Ce6i79ov
         9VJ4A+OCRjEz1Vk005nXVnz6ufdFHUs+qFFp1nCI97l+odSqnvgBXeJWp8gTbc0OzNrf
         1/zQ==
X-Gm-Message-State: ACrzQf2N7frzrA0QKeUSPfsOXSrGggtaaMAV4C7I4FQ5s+uPuerHOHfN
	qjPZZDWAEosGDJQMvdzn53eRDVSwsxy+juI943A=
X-Google-Smtp-Source: 
 AMsMyM7IMbOl7/3HMEUKyabENYuORimWN6j1T7Y+iH1yrPLt0HBFi/4jIRLKwKiLn0n9dOhOWbcv6g==
X-Received: by 2002:a05:6a00:4c0b:b0:561:ba60:16b3 with SMTP id
 ea11-20020a056a004c0b00b00561ba6016b3mr9942728pfb.70.1664975947723;
        Wed, 05 Oct 2022 06:19:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 o190-20020a625ac7000000b0052d4b0d0c74sm10871527pfb.70.2022.10.05.06.19.06
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:19:07 -0700 (PDT)
Message-ID: <633d844b.620a0220.70fe6.35da@mx.google.com>
Date: Wed, 05 Oct 2022 06:19:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.145-cip17-192-gbe875d9d93504
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 7 runs,
 2 regressions (v5.10.145-cip17-192-gbe875d9d93504)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Oct 2022 13:19:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9648

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 7 runs, 2 reg=
ressions (v5.10.145-cip17-192-gbe875d9d93504)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | multi_v7_defconfig+=
kselftest | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.145-cip17-192-gbe875d9d93504/plan/kselfte=
st-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.145-cip17-192-gbe875d9d93504
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      be875d9d93504a4ac9c5dfc8d0bed7cc4197ab75 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | multi_v7_defconfig+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/633d763c4e69f4ebe5cab605

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-192-gbe875d9d93504/arm/multi_v7_defconfig+ksel=
ftest/gcc-10/lab-cip/kselftest-seccomp-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-192-gbe875d9d93504/arm/multi_v7_defconfig+ksel=
ftest/gcc-10/lab-cip/kselftest-seccomp-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/633d763c4e69=
f4ebe5cab606
        failing since 11 days (last pass: v5.10.138-cip15-90-gd4130d0ee3c7,=
 first fail: v5.10.140-cip16-261-g8fa62effa305f) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/633d756cf86e32dbf1cab60d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-192-gbe875d9d93504/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.t=
xt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.145-cip17-192-gbe875d9d93504/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/633d756cf86e=
32dbf1cab60e
        failing since 11 days (last pass: v5.10.138-cip15-90-gd4130d0ee3c7,=
 first fail: v5.10.140-cip16-261-g8fa62effa305f) =

 =20

