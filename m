Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F22C761A6
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 14:26:24 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web11.44144.1679495176195693084
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 07:26:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=WGFXhhIW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so14831639pjl.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 07:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679495175;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FWjy9rkP9YJqQmpsZzQ21wri5nYcB8WjyOI6upDuREE=;
        b=WGFXhhIWoL+CYJSs+CF0RiRDXLJE8jLgkssYZDxUldyfLmS3LBhYOE25mVIQvwpcVq
         7yrSv9xRgvn1BlUtpHFpq5mPBq83ckAMcW39E32SKFOfwpST0qJNzrO6k44XpYOib4Z6
         bYE/uzVXidJr9M4n/V6DfLsop9G+ePnDanVCoQ4JJxRK8IUwEye3Mr4vEf8vMOh3I03s
         32r8fRqoO8ExPELZRMHjHQZ3SQs2gItDAuxULfBzxtf5RrH3pzLARRfysw+DAk19qYiE
         dix6NRTRvDQBaFqaD0YwglW9frguwWhTSJctgygbNezoLHX/Jp7871FKESftYPRGPzTs
         LcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679495175;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWjy9rkP9YJqQmpsZzQ21wri5nYcB8WjyOI6upDuREE=;
        b=rM2oqsQQ5ptt2174CXDmqYq+PrzicCsp0WdKDWGg9TTLfDlDC0BZmc44D82z8bwTE2
         2Y1/GXc385YVP/jHCrQlJCtAE5bkjUiIDmB5gpM61qh/ud1CbomX4OXzFxsNl0kTFm+f
         jj+q7+IuOJYewSPrUWlfp92Yv7vrAms4r8VcG+peE96lsd64TBPxuqiL/yaygiijrXTW
         Hr9Iy51PShM0rbzPYF6psNBM1foW9SfiNWQC4Mg0Cac2ulruS2bTcjiNSe2F9nklCvq3
         LiBtIJk2lvYQU0cF2ZbazjDGJhBQVCW6sc8eHtH2ntB4DZJJ4Dk/FwGBkb627g3yxnX0
         zfzw==
X-Gm-Message-State: AO0yUKXD7FqE4WitTTSWHA3KCyV6V1YjkM6yXA5DnFTc1jXzZi6urOtF
	bZWLYAr7PzLNZVx1oxK7xVTOyhrxflyv8OSj90t49g==
X-Google-Smtp-Source: AK7set97vwYs8Oa3J5I+lxhl4RV50BJGmaDhckSvscYLlRGY7S3Qkrny2n+x5BRRFC6PpCdmL/HciA==
X-Received: by 2002:a17:90b:4c8e:b0:23f:9196:c038 with SMTP id my14-20020a17090b4c8e00b0023f9196c038mr3858247pjb.37.1679495175358;
        Wed, 22 Mar 2023 07:26:15 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i5-20020a17090aa90500b002311c4596f6sm11886600pjq.54.2023.03.22.07.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:26:14 -0700 (PDT)
Message-ID: <641b1006.170a0220.f5a24.6271@mx.google.com>
Date: Wed, 22 Mar 2023 07:26:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29-rt12
Subject: cip/linux-5.10.y-cip-rt ltp-mm: 8 runs,
 4 regressions (v5.10.175-cip29-rt12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 14:26:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11093

cip/linux-5.10.y-cip-rt ltp-mm: 8 runs, 4 regressions (v5.10.175-cip29-rt12)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.175-cip29-rt12/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.175-cip29-rt12
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0a6a8df2de5a8e8f024b47926cff286c6ec0e31f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641afdbabed9b776429c9508

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-=
asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-=
asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/641afdbabed9b776429c9509
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641afc538dfd3d76919c952f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/641afc538dfd3d76919c9530
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/641b03ad03d58f8a8f9c957f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/641b03ad03d58f8a8f9c9580
        new failure (last pass: v5.10.162-cip24-rt10) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | defconfi=
g+x86-chromebook     | 1          =


  Details:     https://kernelci.org/test/plan/id/641b076ed55f53caa09c9505

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-=
hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
175-cip29-rt12/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-mm-=
hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/641b076ed55f53caa09c9506
        failing since 100 days (last pass: v5.10.153-cip19-rt8, first fail:=
 v5.10.158-cip22-rt9) =

 =20

