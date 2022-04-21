X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web11.18549.1650526804618933460
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Apr 2022 00:40:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ApE5yjP0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id q19so3963897pgm.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 21 Apr 2022 00:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=NSSDsiSyqSuhQoKgEJkaFIvsn7HIqcuivl5SuKRWkOk=;
        b=ApE5yjP0uD9zsN/fy3d9X8XJ+o2AHclEUpuK6c/GsWmuOGceZbTENeEuuK4D+q+NVv
         4SbZx7JAUvA5MMSLzmLMgkuzRPY3ADQejBbuD8UySXtghH6YxmnJdTXHisa6yKsrebB+
         zsayH/9MHFvFB2u9HPIfJs7W+fwxByPxZZ8hMRgLrcvEwefIS/P2R6rOrRapsFeUhHCg
         J/KiW1bhz8WjvXZCm4N6ZKTWxtWzbGgkLJZdYTBKHKYnliDcP+hkQHU63fKOb4sQDsEC
         rOVk4BmmZDqh6MWxnfIIzn3+vzmN80mJwLrekM9cQ4tErjWFMUsF5gyZMUcW5kgvREIO
         nUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=NSSDsiSyqSuhQoKgEJkaFIvsn7HIqcuivl5SuKRWkOk=;
        b=prNmhq4p2ORmU4og/E+1OFrL/wtqgqSHFXfdzAQ3ZHA1gsTXW75gQ/0A+s3ZpQt2l2
         o2hfk9qIuew8DplyiivhLhpTEOec05H1p3g0JJDZA/XbQIvBvcQZrrISKFYTOOMgTEzo
         fTY8zw/sIWscl3GLaOUO4JCP7rJwcu1s8hCmqgkhjUPTdTYhtCLCBxX5689Jm/8Dz7Ph
         He9fz1ekLGaloWyXFeQZ8XvB9mmJE1T5sbv4Q3r2441JP7EO/FoZGegNORthsmq5WeFq
         IMUf6/AmsjPeNk1Wum3a8ONTeFJjnazlurwwzMPy//YL12RXdXlkIECpNrKEI7w51VoZ
         JmKw==
X-Gm-Message-State: AOAM532Si9tqrmP+DPoGULOi/Z0ip6cN5tJj9ovNdvyrysi1HfsFCsRl
	parGw7KVx+eG3JOaSGuhSpcZhUQB1YfAZ7Cq10M=
X-Google-Smtp-Source: ABdhPJwKiE70yUinZABCJVifUlAK0tzStb2TIVFrHZ7CVNH+zcb7FGkBW6BJrs1kPTRDPBqL7rGpeQ==
X-Received: by 2002:a63:4042:0:b0:3a8:c700:1f40 with SMTP id n63-20020a634042000000b003a8c7001f40mr20217328pga.318.1650526803552;
        Thu, 21 Apr 2022 00:40:03 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004fae885424dsm23642396pfx.72.2022.04.21.00.40.03
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 00:40:03 -0700 (PDT)
Message-ID: <62610a53.1c69fb81.6727.7cb6@mx.google.com>
Date: Thu, 21 Apr 2022 00:40:03 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.109-cip5-24-g4e205e4287c50
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 13 runs, 1 regressions (v5.10.109-cip5-24-g4e205e4287c50) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 13 runs, 1 regress=
ions (v5.10.109-cip5-24-g4e205e4287c50)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.109-cip5-24-g4e205e4287c50/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.109-cip5-24-g4e205e4287c50
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4e205e4287c50edfe5c1d4c9775b0670bf9bafb4 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62610377667d8c1ef98f77f1

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-24-g4e205e4287c50/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.109-cip5-24-g4e205e4287c50/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220411.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62610377667d8c1ef98f7813
        failing since 43 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-04-21T07:10:32.396019  /lava-6138274/1/../bin/lava-test-case   =

 =20

