X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web12.5092.1648551015638605340
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 29 Mar 2022 03:50:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=YtnStCbT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id bx5so16997120pjb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 29 Mar 2022 03:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=4RJtXDQoSJeg22p+gXZ0OSULCNzDkB9mXmy6aGhKWHA=;
        b=YtnStCbTDzvrZnlMAl1uWVHo4PUFzMVRzcVh+IQNqzbYmyyQ2RJzQLlG8h96RWDjdt
         p1hmVpxGLJvQcOct6JSNGXPU4HbC2cCNs0YJmIXIQlDGAaZ3ETL/OxClpH87Cd/X4II7
         888cISN4nZ6KVud5HTsjtFqUFeCLgq1nAcXQCP9KPOSL3CsrkbRpZNQ71fHrZboysI0D
         dx1klYcPqlVzP90xqTMwxKmkyCDPPY2ryiu3JufXdbdUpY+7wIhSy4b9aWuX2AkzrNjX
         0WExDf6dfRvDzYymR09bU2bzoSif9agwdhgsdG/96AtRK1XB92SWQGsqmVqLtWHKJMAj
         scmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=4RJtXDQoSJeg22p+gXZ0OSULCNzDkB9mXmy6aGhKWHA=;
        b=8QAZlvOKs2JkMpuRrutDS+d+1S6SCdJBtsUhItxGoHPph9QAakxV+SqadIt4Yc0g6d
         z6I1Sw2PUElPa6ojBTopKUJw3zuES4O2j8gN57ysdlG9evpyTM7cANQD6oLbPACtR9Ir
         S8vpZdQh73dGpeJm1FidrV40ZxkB8ShGDrCu2/jU77dClsq0JJo48nNAUhD5egbEFQmh
         HiSVqPYbxsirILB/5eOG4T7rxMBkuVTWh3RJqjgWNCom6+bC7vSWIHjyycxvF9ypA6yp
         vg75wilUYz/83zvZJ/rpZvIgDEzit+T1DnwkScjC6LnGxk4+XJHGT51zCmgdh+7GSeNb
         /VEQ==
X-Gm-Message-State: AOAM5332ufdAnOA5VG9XRuFr22ZDDbsl6NQv/dAz2Di+QkLSboFmFjZd
	1Y5wpxE4evFyw8yVr98DIz/0A2k264IGGRiGLcA=
X-Google-Smtp-Source: ABdhPJyUJA4U6fW7M7+NHKDg8MbwVWXjHqXUkfRw4QhOWuCrA9pWTkD9yk/N5Rd+CBSv1xDGMavP5A==
X-Received: by 2002:a17:902:d884:b0:153:ce8e:66fe with SMTP id b4-20020a170902d88400b00153ce8e66femr10386985plz.157.1648551014819;
        Tue, 29 Mar 2022 03:50:14 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d25-20020a639919000000b00364f999aed5sm15641474pge.20.2022.03.29.03.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 03:50:14 -0700 (PDT)
Message-ID: <6242e466.1c69fb81.15132.8e91@mx.google.com>
Date: Tue, 29 Mar 2022 03:50:14 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.235-cip70
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-fcntl-locktests: 3 runs, 1 regressions (v4.19.235-cip70) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip ltp-fcntl-locktests: 3 runs, 1 regressions (v4.19.235-=
cip70)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.235-cip70/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.235-cip70
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      91567a6adc2cb5217b6d7aabf7da3ac9ae6f1a79

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dc836ec4cd4e02e1346001f828c1f1988a8d7d54 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6242d793a1ae15b33eae068d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.235=
-cip70/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-fcntl-lock=
tests-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.235=
-cip70/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-fcntl-lock=
tests-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/6242d793a1=
ae15b33eae068e
        new failure (last pass: v4.19.229-cip67) =

 =20

