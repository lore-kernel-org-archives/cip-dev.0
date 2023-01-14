Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB076C6379F
	for <webhook@archiver.kernel.org>; Sat, 14 Jan 2023 14:17:22 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web11.116366.1673705841841408998
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 14 Jan 2023 06:17:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=0ezzIg5A;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so3219002pjg.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 14 Jan 2023 06:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TI8OQ9GjUFR4zcmcx5RFUvSriUBSHkRUP1uVC/UN25c=;
        b=0ezzIg5AyMBeDQPc5CkxjYrlMz06Ddc/7POSo68/gfusB2ClfB/5pE6HLxajrWNhyL
         BSs8W0srqDlGHRamDCv0J5jlJXklYWYe7ayrbskicNbgacx6AmTBo+h35Dun9Ven9Pnh
         BYRC0gmj36hH1g5g9rR7pr5qKlVIcS4E1ZUkb9WKRa6QzOyNu67V6IthlbAfRTjZWyOE
         ZA9xAElPXcGW9S2k5/5jsfaxhzc7sqpRyyZMj8kplWWQ42qAoy3+EoBc3fcmSV06vYP2
         48YdL2eJuTNiyjA8TYSYsBcl1X4LrxB118hIn4et4p0d8iQOW7Fk0KSYSasSYM0uJuDw
         GJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TI8OQ9GjUFR4zcmcx5RFUvSriUBSHkRUP1uVC/UN25c=;
        b=kUbbn5VTK7d5ioBCvqbHzVW7FHoCJMfsVfq0eWkvtWAAee3Mg6aAnhaDN/JwcYlKG8
         zSmXonzc1Io2hHHzfwDH1C0GTAdE4ni+GHm640My6i3K46b8HBDsGFhj5PLEJFuXB+Pw
         aBoY8Zq/AUolFQ/KKoXoqkTrTZrgcw/VL9KZfpku/5WGkc/H0+fdKe8Fy1RuHhuBbtrn
         tXOQ4rCG8ug1oUZlBP5sigztmmvFi0ug9PKznhVmBRcRdzPaJ7N/De0VXW9UFtvWUD4A
         5W+vRCn11rGA1wZPcP6ewTQq9n4sGf0zgKpfd0DUYi93yfhfQIe42syfVh0zwLOtEQSD
         eRXQ==
X-Gm-Message-State: AFqh2kqOMN3aXgMDx4vZmeEE+xWS/ocOCWMq+i0YbhuLeAOcEseoF6o/
	uYJ/ymEmXYlxzq4j02tk4yOjzNjBMiOUMUGoDdKAVw==
X-Google-Smtp-Source: AMrXdXvkp/0laxx7LyMz3cc+GtmsOdRm5BiNvOo2zKSN1KNTmLG7b5kw67tqTDvWrIyVOk3T2BiG/Q==
X-Received: by 2002:a17:902:74c1:b0:193:2bc9:eb25 with SMTP id f1-20020a17090274c100b001932bc9eb25mr23978397plt.20.1673705841068;
        Sat, 14 Jan 2023 06:17:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902d2c900b00183c6784704sm15891039plc.291.2023.01.14.06.17.20
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 06:17:20 -0800 (PST)
Message-ID: <63c2b970.170a0220.d50aa.957f@mx.google.com>
Date: Sat, 14 Jan 2023 06:17:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.162-cip24-788-g63c30712099cf
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 11 runs,
 8 regressions (v5.10.162-cip24-788-g63c30712099cf)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 14 Jan 2023 14:17:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10366

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 11 runs, 8 regressio=
ns (v5.10.162-cip24-788-g63c30712099cf)

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

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.162-cip24-788-g63c30712099cf/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.162-cip24-788-g63c30712099cf
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      63c30712099cff890a9fa023533c2971e6a4f87e =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63c2a90e630bcf7fa81d39cf

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-788-g63c30712099cf/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-788-g63c30712099cf/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230109.0/amd64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  29a4437646ddbcf389965136680e06d40cbc4722 =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c2a90e630=
bcf7fa81d39d4
        failing since 79 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c2a90e630=
bcf7fa81d39d4
        failing since 79 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63c2a80ab440c633351d39cf

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-788-g63c30712099cf/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-788-g63c30712099cf/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230109.0/amd64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  29a4437646ddbcf389965136680e06d40cbc4722 =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c2a80ab44=
0c633351d39d4
        failing since 79 days (last pass: v5.10.147-cip18-56-g87bd4289362be=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c2a80ab44=
0c633351d39d4
        failing since 79 days (last pass: v5.10.147-cip18-56-g87bd4289362be=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63c2aa76fd4717cfaa1d39e0

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-788-g63c30712099cf/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-788-g63c30712099cf/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230109.0/amd64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  29a4437646ddbcf389965136680e06d40cbc4722 =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c2aa76fd4=
717cfaa1d39e5
        failing since 79 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c2aa76fd4=
717cfaa1d39e5
        failing since 79 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63c2b61dc8269fd13b1d39c2

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-788-g63c30712099cf/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-788-g63c30712099cf/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230109.0/amd64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  29a4437646ddbcf389965136680e06d40cbc4722 =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c2b61dc82=
69fd13b1d39c7
        failing since 79 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c2b61dc82=
69fd13b1d39c7
        failing since 79 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =20

