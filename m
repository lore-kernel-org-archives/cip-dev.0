X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web11.6198.1651121163069424691
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 27 Apr 2022 21:46:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=wYIcWF7O;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id d23-20020a17090a115700b001d2bde6c234so5072826pje.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 27 Apr 2022 21:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ve41y8ULp8xQOuMJlxqcRCA6QOy0eX+i90m4YW7eBps=;
        b=wYIcWF7OqWJ0dQ1TCvuqlz1SPhAYox5ffVfDd+Q8PQB5TiA2diBKma3dR5p6RSBQQS
         pE2G3Sd85/Ke1mZBGYxpLV+pzwHhq9YrgB9gDek+efZ08nJ0XPaMsL0acYmCTVg4eWW0
         vKzy43ttecsP9kW/wm22uxp4p31S0K6DgHU+qQp2vNQ5u3jHDuoZIzLKdgcajA/vqFFP
         qAq3TrSzapl/Ea4VPS5RKoWX9KIwO3HmC6qpDE2cPkaDxb/6orsOvrTeOhATphtaxjZt
         vd+LmOk+n1Mf5jwtMSfkoZDPfW9aKfJ88w9PUYA7xXVLn1OzcDYMHZfLth+I3SMkPnEA
         b70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ve41y8ULp8xQOuMJlxqcRCA6QOy0eX+i90m4YW7eBps=;
        b=ck8uTGgw0RcOsvMYcwnlhoruYQsRYhm1WpVUSZOZNsdW/Bqu1nEqIQA2AeKxN120BF
         9t2vNiYELsJXoJdFbcWksHdJXZJxA3z59OVMXz+KUYhmYYh6gxf5DrEICWJPzUrx5m23
         u3CR23rA0j5bqVMof6VsZoBgVyOze4Sp9IMkwHA46TRf2I5CMSvJHdq/jZpNu8vY9qff
         rdDxJzSbtWQJGyURY5o/IlsOnb0kTXkA5U804Jf+qHIHbsBUS/8EjfTR071QD7jqM0Fg
         qdxtiV6pemJ56LgEpBPeU4uZr4Q4Po6QEg+QYGHYRCJpglVQ02aTNzOYgxxWqBdd+Emr
         zElQ==
X-Gm-Message-State: AOAM530S/SpIc/jEvImOpgt0mkjsuDYR8BSAhm3xzPI9WB5sSGsoxR7R
	rcBcxNOmvhtC6bkqDeqtcYbdFDVjPXr6V4sQLHY=
X-Google-Smtp-Source: ABdhPJz8aAtqzrT5MXgCbdlMpu5jZYkEm5WxzlSP2TDb0yG23yf+Jib1wHWwckm4LwiJvkC1bu5wkA==
X-Received: by 2002:a17:90b:4a41:b0:1d9:a24f:51a1 with SMTP id lb1-20020a17090b4a4100b001d9a24f51a1mr15701246pjb.240.1651121162331;
        Wed, 27 Apr 2022 21:46:02 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f19-20020a17090a639300b001d945337442sm9028673pjj.10.2022.04.27.21.46.01
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 21:46:01 -0700 (PDT)
Message-ID: <626a1c09.1c69fb81.a6300.55ff@mx.google.com>
Date: Wed, 27 Apr 2022 21:46:01 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.112-cip6-88-gf3397cadb2dd6
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 19 runs, 1 regressions (v5.10.112-cip6-88-gf3397cadb2dd6) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 19 runs, 1 regress=
ions (v5.10.112-cip6-88-gf3397cadb2dd6)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.112-cip6-88-gf3397cadb2dd6/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.112-cip6-88-gf3397cadb2dd6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f3397cadb2dd665a16905355cbc6717f52d196a3 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/626a133ba44d9bea15ff946e

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-88-gf3397cadb2dd6/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.112-cip6-88-gf3397cadb2dd6/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220422.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/626a133ba44d9bea15ff9494
        failing since 50 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-04-28T04:08:16.299271  /lava-6196822/1/../bin/lava-test-case   =

 =20

