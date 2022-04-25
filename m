X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web09.31193.1650899916664787056
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Apr 2022 08:18:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=CDtrveOn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id a15so15068847pfv.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 25 Apr 2022 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=QbeS5cYkAjv1OLw4nXGAPIh+esCSga5/rlc1sf+zvD8=;
        b=CDtrveOn79EYmuQBqtS9H87BGph/z9wXZRA3Yx7Zh6hCezFxiihKP9ZkeK4k577244
         PA8+26v/FJLvpKzpLDsjzIgw1cbOeRNNi+h+riesHXm8eGx4VjsZRgOw7O1GUVU1YO0o
         wCu/FuXau/BYK3Au5KMUy4Fx7CxeI6G15sVmJpyPKTbaGahEuwkAmG3dc+ScFY3mghgv
         T/rB8WQsR7zFZNUXqGl9yiCddS2JuY/gyo/eDmInJIudtF/oLWdBahItDECxZQbCTB26
         4oWTRbpA4CYDKTTJ0bUu+UfhArnqZLxo7tLZycIOSPYU29jw8erQgK1Ymz5bTUsgkoe9
         9EPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=QbeS5cYkAjv1OLw4nXGAPIh+esCSga5/rlc1sf+zvD8=;
        b=5X6PDbZWjX0H9nRUi/7LPZlUpjLNH+66Ebb1X5Y1Z2dvp78lOuFjeKG+KHHYIi++tI
         klBqaGevTyESJc3BSJyX9Zp/8xK9StnsL7amws3pHJqZH5G3B4RMW5EjPuir1ulNdzVi
         4HFyPP8Rw8mAE7dCJUv4rbmkYr95BNS4i9A5uS+pnuG/snig4Na0+HK9XYzG8+Hs0AEr
         84/IUrmbLVEalXDOSciVrwlyHjVW6T5sKjcD9xc0iUURwAvZ0l+KrSQK6bEfAcoBdJ/l
         wx9glBlQtEqzEXQUfC6HF/G7mmIkZlisGWR1Qb0oBz1LH8pUEhFu1/rlN19tkr4X6hpt
         afbA==
X-Gm-Message-State: AOAM531wfWaxUrslodHbGFwz1/zocpB4uPkjjaje+XbDKESIjV4t0hqh
	Y3ZoE74R3k2uAongtjg0uGHmvMB2SOrXpWz/H/Q=
X-Google-Smtp-Source: ABdhPJz/1ZRo3Xn9uITRcJrcNAmKqwJVXQ5qKCSsBAJWy6iZTvD4tbELpnLSOACb0/3SNgACIx52IQ==
X-Received: by 2002:a63:1d54:0:b0:3ab:754f:be08 with SMTP id d20-20020a631d54000000b003ab754fbe08mr1401919pgm.80.1650899915909;
        Mon, 25 Apr 2022 08:18:35 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o64-20020a62cd43000000b0050d416200e6sm3435364pfg.5.2022.04.25.08.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:18:35 -0700 (PDT)
Message-ID: <6266bbcb.1c69fb81.a60ed.7a5b@mx.google.com>
Date: Mon, 25 Apr 2022 08:18:35 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.112-cip6
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 23 runs, 1 regressions (v5.10.112-cip6) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip baseline-nfs: 23 runs, 1 regressions (v5.10.112-cip6)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.112-cip6/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.112-cip6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c8f6747dcd02a8f87731c324f4bc37bd120a8982 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6266b14b87db828697ff9467

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-rk=
3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-rk=
3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220422.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/6266b14b87db828697ff9488
        failing since 27 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.106-cip4)

    2022-04-25T14:33:30.551381  /lava-6171419/1/../bin/lava-test-case
    2022-04-25T14:33:30.578149  <8>[   96.759756] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

