Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027C7FA3742
	for <webhook@archiver.kernel.org>; Fri, 28 Oct 2022 15:21:37 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web12.754.1666970491807616395
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 28 Oct 2022 08:21:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=O1uhG4WG;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id k22so5055929pfd.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 28 Oct 2022 08:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ia8EqpqloeJ2zkEPutFYdTT+R47L7o42GF21rqsj1tA=;
        b=O1uhG4WGJX0/AIo2uQgsB1Wiv5FbBvvbD6ReadT4VdwuaIn1k/09lL5+YJhiEaZDI0
         jDNEGQeE+5koVviwVohzD58kkFPT6F2jQBhPegc9o7PBmWKbc8viezcgkk02/Kh9m9Fj
         BwiQy+4eE/k+m0OPh4Q2Obkp1QFKBZs8BVd0dYEyaou5qAlmULTifaq7K/EonFQWTS9N
         CATKU57oXT8/rehYrxV86gDHdkBciJI0pcqCEqZ+AcyP2E4on2K5F3RyJcwuzt9BaZC6
         s7p9tWsThh13CCoJc237PYhffs8diI3Mt2DMAth5KtKwYWk+kl3z+6tYWnCmB9Q9Crgj
         jJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ia8EqpqloeJ2zkEPutFYdTT+R47L7o42GF21rqsj1tA=;
        b=l3nyt4sKUpEPuoiuXfXUbyHSMUXx9nUEdP99ZjJDevzoonVF/odnovRZDtnUku1t2h
         3km1wnrRiUMK0aJiRfu1vACM/XaeQOyqi83H9wn0tD9cyC+xPXeUmLp9Ka7ie7f9DbjY
         BrcTORjHKNuGNiGsCF8N1BjUIhMCUuiySOufE7kqSsEBdQUKZ4sLrP4rNtiD4edKF5Ug
         sH7PHt0ljhgd1aTTwAoD2vXBOurtLZKFHgYxBz7pQeJGJsRj3TrHu0FH1MKMtooVvlRE
         zGTyo5lEJ8cEf/T8yJTjIt1IiWloGtDuqXCZu+uCIxKzJ8Chj2n5aTKs1MFG7YMXVyZA
         9tVw==
X-Gm-Message-State: ACrzQf2C+tZt6r+qlzx6ZgihL8SltGZCB+K00hoZjbaLmikVUaIKZl3k
	qhM2q19GXPiI5hQk7VpL3vrAPs+hHa765hUm
X-Google-Smtp-Source: AMsMyM4JpacMGP6WEOp7O5uLOiFqeD25BAP0uEamhEhpWgfMz+6pNhvxoruzsL3kNdc6L4TUvhsLsA==
X-Received: by 2002:a63:2547:0:b0:46f:793f:197b with SMTP id l68-20020a632547000000b0046f793f197bmr43612pgl.35.1666970491134;
        Fri, 28 Oct 2022 08:21:31 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b001783f964fe3sm591196pll.113.2022.10.28.08.21.30
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:21:30 -0700 (PDT)
Message-ID: <635bf37a.170a0220.78605.16e0@mx.google.com>
Date: Fri, 28 Oct 2022 08:21:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-468-g86403a07ae1c
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 9 runs,
 1 regressions (v5.10.147-cip18-468-g86403a07ae1c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Oct 2022 15:21:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9890

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 9 runs, 1 regressions (=
v5.10.147-cip18-468-g86403a07ae1c)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.147-cip18-468-g86403a07ae1c/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.147-cip18-468-g86403a07ae1c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      86403a07ae1c0fdab3215fcaa06d157c20aee250

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  b79157c8375cfdd2abfc59f63afe8ea09eaa8c5d =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/635be524f80b089914e7db7d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-468-g86403a07ae1c/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.147-cip18-468-g86403a07ae1c/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/635be524f80b089914e7db=
7e
        new failure (last pass: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =20

