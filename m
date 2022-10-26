Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B15BC433FE
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 18:56:55 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.11525.1666810614000869923
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 26 Oct 2022 11:56:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=T41tohIL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id u6so15053679plq.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 26 Oct 2022 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jCNNilCQIbt2MP8QbhvaTHl7KgkQ0pITrVZRBKGAI/U=;
        b=T41tohILeiq+Fv1tc5M6gR/uflfCEHJCkeRhfUPEDTLwiWaNuhVn/ZPPWhIB5+siRQ
         JLclHh7OwI5toqcgzQNQYCW/Ia4lCrBQK8/Ox8/9wTSj2dB8+cCMANKIO2pl0MTxuf3i
         fc0Xs3Tn/wFnBMtGCe2TjIKuslwheoBN6E+ByOf9mHLV5MrI4+mQD6frn5TUiXRswK19
         kHmW9tX90Emp39Xx37pZWFRFpdL9OpHvWRxsfBpfmgB+R2G2+oSIWjb3cJo7E1US1om2
         w706973gNqQ3oZkTGUjEzzgZFgeFGf3ITISErjrick+uiloEwz/TPnenjWzDveHLbAYv
         AvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCNNilCQIbt2MP8QbhvaTHl7KgkQ0pITrVZRBKGAI/U=;
        b=O6MoenxevZ+BfX/rCHc/y9j+S3OPO09MEr0wlAzIHrPmW2X8d3TqiXMXU5qJLlUis2
         tbASZyqV0OOpxCMkwtuTk/o3wicKfMF1jpW1TfYeiCS4dlt0VEDSs3HfSnORVBGXD4Cd
         ib7cOGiMgf9DC6TjWvfdxFQIjcjXWo907XOPj+1/wGJduHaO7+Wp0qpU406cBCVrnX0G
         8wo6yOrMqSs2JbuOWF7dil4oGmqZw8cKCYrLRPKUbFZNCyQ3wNEZDskNHEOWS8SbrttR
         uWFsZSiQjc+GPo/wpg0uviTMQkAua5qyCsVLm/OCRp7cH1kEepzEp52qXcPM0GN7CrVs
         PFOg==
X-Gm-Message-State: ACrzQf2Dfnr3s6vMDz5AWADKHwYcOg6GHGgeW3uwPQo4pWnql9A4zFkA
	PM2eu72L80nt+6ZJq1h+vsL7XvMfTsiOFbtK
X-Google-Smtp-Source: AMsMyM5YyrVHYBnfZb9OE0yQ0mb3NEz2xuq8od5yy+kWUCVy/f23StgGm/BF7fW/IXElY6w7r/VgaA==
X-Received: by 2002:a17:90a:6845:b0:210:7ef5:ab99 with SMTP id e5-20020a17090a684500b002107ef5ab99mr5743526pjm.80.1666810613286;
        Wed, 26 Oct 2022 11:56:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ij7-20020a170902ab4700b00179eb1576bbsm3218258plb.190.2022.10.26.11.56.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 11:56:53 -0700 (PDT)
Message-ID: <635982f5.170a0220.b8612.6ec8@mx.google.com>
Date: Wed, 26 Oct 2022 11:56:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-451-g87ba4bc77ca06
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 5 runs,
 6 regressions (v5.10.147-cip18-451-g87ba4bc77ca06)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 18:56:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9872

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 5 runs, 6 regression=
s (v5.10.147-cip18-451-g87ba4bc77ca06)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.147-cip18-451-g87ba4bc77ca06/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.147-cip18-451-g87ba4bc77ca06
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      87ba4bc77ca0665b0965e4fd545904bc2f92617b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  b79157c8375cfdd2abfc59f63afe8ea09eaa8c5d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6359747741ec0e6f35e7db5a

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-451-g87ba4bc77ca06/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-451-g87ba4bc77ca06/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6359747741e=
c0e6f35e7db5f
        new failure (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6359747741e=
c0e6f35e7db5f
        new failure (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63597c14128d47a07be7db5b

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-451-g87ba4bc77ca06/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-451-g87ba4bc77ca06/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63597c14128=
d47a07be7db60
        new failure (last pass: v5.10.147-cip18-56-g87bd4289362be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63597c14128=
d47a07be7db60
        new failure (last pass: v5.10.147-cip18-56-g87bd4289362be) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63597432a1ced02594e7dbea

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-451-g87ba4bc77ca06/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-451-g87ba4bc77ca06/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63597432a1c=
ed02594e7dbef
        new failure (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63597432a1c=
ed02594e7dbef
        new failure (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f) =

 =20

