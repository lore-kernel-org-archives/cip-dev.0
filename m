Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA3FC433FE
	for <webhook@archiver.kernel.org>; Wed, 16 Nov 2022 14:14:54 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web09.7698.1668608090616025384
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Nov 2022 06:14:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=KzgUJ2wd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso2489296pjc.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Nov 2022 06:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=78o04Pv0rU56ADdImQAh2+rwfOhUheZ9Evnvw+dgCjk=;
        b=KzgUJ2wd9Wr9VVgMKYnvLQkKQdP7RFAUwUPQ9h1TYyeoBYEq/bmufTaroYaCfe9vd8
         7S/jIyrYat+BaVcWRT54QyuyooWxlWBwZiUupJiC+9KqolRPjmKu3O3H+vCdQ9jOMkMM
         IG38C8WJWT9uSyJSkARmbV3+BaXaLX0Pg5aDJeTI0Fp4io33dtTH26x+9cokOuH3E4VN
         zoZCY4lQ8vhGT0Ye0oXS0lSdNOmuvn/vi3luQGZzv0UqSTndW3W/0Y1zu++UtNH68MgG
         aXRmbGcmkJTL0w3aq90fwft4xa7vE654+Qz/RC4L8l0TcBIanqMR7kAYaQG04f1/FbcA
         Q4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=78o04Pv0rU56ADdImQAh2+rwfOhUheZ9Evnvw+dgCjk=;
        b=kNe5Fnv8iRLar78PDrakCYP6Yfgz6YGtYX5YTzo2I4+cx2GUZsl79+6B487bHtl8B2
         mFOgCDScwmTuPnfGqIIG8qdcm+SEE48VqIICCG1/EzUvqOV5NM23ImTr08qe+qROcH+s
         to/HkAmH1gBw9+w7iVH26vDQAUbVi6LiIjOyipcU0FEgGacCJKdH8eLWX31oEwDlzVzD
         uiA48j3XtwCMOYmqQzl8y3JGWFht/1IHTpOwZjcbUNLYda0KLdJx4j+UQbwzkMPQJ3m7
         InXAmF+0GwM4E+eVDqnVI3zqlYMpwTHkN+Pw2fICrrg9c1hN1OGLgCeKH7UAC7DzPbX2
         NsEQ==
X-Gm-Message-State: ANoB5pnlW9z9eQDykG9yjdrnqshj8hwLBR+sfhpV+lZfKz6WUHJ1/oND
	Pr3bPyJ+UXywZQA/dHpq91QK8856u6ZlgOFEidY=
X-Google-Smtp-Source: AA0mqf61IYQAnBnPJZwy7lIQGkjilFPXXL1nKhpoFh8JUTmZT+lcpKvX24Adj8+GeBKwlr2LFh5kqw==
X-Received: by 2002:a17:90a:2b44:b0:213:d66b:4973 with SMTP id y4-20020a17090a2b4400b00213d66b4973mr4011220pjc.85.1668608089908;
        Wed, 16 Nov 2022 06:14:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l14-20020a17090a49ce00b0020d9df9610bsm1624910pjm.19.2022.11.16.06.14.49
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:14:49 -0800 (PST)
Message-ID: <6374f059.170a0220.160ea.2279@mx.google.com>
Date: Wed, 16 Nov 2022 06:14:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.154-cip20-99-g0e320e4d37e4
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 26 runs,
 1 regressions (v5.10.154-cip20-99-g0e320e4d37e4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Nov 2022 14:14:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10047

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 26 runs, 1 regress=
ions (v5.10.154-cip20-99-g0e320e4d37e4)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.154-cip20-99-g0e320e4d37e4/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.154-cip20-99-g0e320e4d37e4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0e320e4d37e4f142f91e122ae645a9aea854c7a1 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6374e0c8a11387022f2abd2b

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.154-cip20-99-g0e320e4d37e4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.154-cip20-99-g0e320e4d37e4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221107.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/6374e0c8a11387022f2abd48
        failing since 252 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-11-16T13:08:09.169513  <8>[   36.113524] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-11-16T13:08:10.211659  /lava-8000103/1/../bin/lava-test-case   =

 =20

