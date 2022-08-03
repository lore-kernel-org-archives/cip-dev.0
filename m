Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749FBC19F2C
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 16:25:01 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web10.209.1659543893947954986
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 09:24:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=KKI7sigq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id
 15-20020a17090a098f00b001f305b453feso2563962pjo.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 09:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=QtH7utFIVradG6sJd4rDFCu7seNQh8Mb5Z9PvtgDy/Y=;
        b=KKI7sigqEa5LficdWB7BpQK6xtzJd14tUIdoKnB1Lx8f0hcZ+5JJ+H/e5lWBabe1ER
         j33Hm0PLPa0oDznYUiSfE2heivwy/Oe6yM7DsE55jp+MeeoO2zFtEPYjPepS5k42P9Ko
         Y16McgtxBevoXNI9rzeXwE/wvEDuPPXXtlACwdfEt4fTs2velZjwtO/gb0Mqwofo7sEK
         hYYkEjEhOyiPE+ORRUC6AYfMG6jMj4TfNGq2Sm1LVgVvPgTt4yuWpslDWVNkGjpllqlD
         hiA84kkUY1JmBJfSVbSuTsKbdZ8F3XvejMxnAmJ5G/UQLDFZ7nEItoR2LFm7a8cwcUz/
         yoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=QtH7utFIVradG6sJd4rDFCu7seNQh8Mb5Z9PvtgDy/Y=;
        b=TeFlKnYfI+Gv5yiUc23YCfxb6FUtzYuB0n/i7BkVu4fOBraBBq7q2vv7Kk8coPNtOp
         Ioxix+ieUVi5azBWhaLwtdmoyecjdRTDXIlP36NqDbmqZpipgL0QGIO9gpEgHDBgNY8i
         N08Gob0Y9/MRIg20N643Hrrf3pvZAwCYQ+TXJdt1SITW0CwVTUrErOVfT/FyscUFZoGy
         RsNZB8Gzo84UuVaA3/wcr0V33cz68lc09mY716LaIW+P2Ko1MN7BxhJWI/M3RrGZblI3
         vRoPyAtVzMWaluCcv+SBPkTQTWcTIub4cXuD0rTlV5G8phvKnqE1eSyDNLfsV8CdW29S
         o1sg==
X-Gm-Message-State: ACgBeo1vhS3RDnXzgFwqIU8OVTEDjF64cK87/7CvHMb7/BEPlLCk3JEx
	arDgCEobvQMBusN6rsmtLLjLOQjZeSqucWbcqFQ=
X-Google-Smtp-Source: 
 AA6agR4ibqfk73LTnPv9R/Yd9tMNBkh1M58aDhO88zEoxPcz9AWc4p9wSLTi2zRMvXU1yLpFNc6Jew==
X-Received: by 2002:a17:90b:4b4a:b0:1ef:fc95:3c4f with SMTP id
 mi10-20020a17090b4b4a00b001effc953c4fmr5604736pjb.138.1659543893120;
        Wed, 03 Aug 2022 09:24:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 m68-20020a625847000000b00528c3ad8e09sm13290558pfb.66.2022.08.03.09.24.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 09:24:52 -0700 (PDT)
Message-ID: <62eaa154.620a0220.bb78c.4c94@mx.google.com>
Date: Wed, 03 Aug 2022 09:24:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-431-g420b8f43ddc46
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 10
 runs, 1 regressions (v5.10.131-cip13-431-g420b8f43ddc46)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 16:25:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9065

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 10 runs, =
1 regressions (v5.10.131-cip13-431-g420b8f43ddc46)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.131-cip13-431-g420b8f43ddc46/plan/kselfte=
st-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.131-cip13-431-g420b8f43ddc46
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      420b8f43ddc46ea18870caf6aa2052c5602729a5 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea9816fe5edb1f2edaf060

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62ea9816=
fe5edb1f2edaf061
        failing since 13 days (last pass: v5.10.126-cip11-116-gef362fbbff52=
8, first fail: v5.10.129-cip12-12-ge4e007863cc76) =

 =20

