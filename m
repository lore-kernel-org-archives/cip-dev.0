X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web08.5380.1648553778725698798
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 29 Mar 2022 04:36:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=3x4xCC52;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id mr5-20020a17090b238500b001c67366ae93so1750009pjb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 29 Mar 2022 04:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=PimlxjmHPrcSdJxUQW//U3B0YY3G2wyOTVoIkFQFpng=;
        b=3x4xCC52gRFgIMTw+ew4VUH5ykZir7yLKJpyLGFIw1+QDFzRhGMUgE7KhLbhbSPZuw
         U5zCrOpD8ZjhiCEstGHCZ9gjcJFLKfDCOOAxaEKnI8AIEZP4lsnCJBQSl4cXMp6XD1Cb
         igLqqI0klhsaC8cCJZlj08kwBLkNYZk1A4BtrB1Od6iXNfVAjet7LjjPuerYEHLXm8Ni
         izvMef6orWVGrJ96TcGpC/4t7sA0I7AOV1n1S0d+WSpV1d69ab4zJGEd+ToH5tamyswy
         b25RHHDnSXsv/0aEheXpq+hIGUh20HRtAxkWVl/0l/A/ZuWFEcozAYmrLAApJjNdH93M
         sSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=PimlxjmHPrcSdJxUQW//U3B0YY3G2wyOTVoIkFQFpng=;
        b=cTXgxVdEQEfCU+77gZePuwKMP/8n5rO9H0/A9X2Huco2K7tCwPHTDl1aYdwEUCVhlV
         QbediDmKxIJ8+o/Peum7DLYQAHD/OCorTdiktinlEHh209clK9xmPjGhVljQBGeQkFtu
         pU2SIeFSFz4+dVLox2lC4cKYqfQdg2sgFNl+jttZJ5yK1wtaiuYsCOo8dEDi1KrTZ4ME
         ydsMEaJLDF8sI7esByzL68t6J0s2VnRTfWNazZm5hR1nX8MffGJnsym1nLCc3y1WI+Ke
         aXkj/jiDvMg51ePJB61oBwW/wiMF03QKhm8pOsU4mS0IHFUymZJWjCa1n7Ah59op1Tnl
         vVCg==
X-Gm-Message-State: AOAM532wr4tpgFS+CWs95BTAKQzjFJzPZ8W9J4sExOC6KfG9xxO7ISha
	GWJa+w8JQcOXEQHDMWWpqf+TipkXqzxXwrVI1Hw=
X-Google-Smtp-Source: ABdhPJzzo6stl9Cw/t9S73/DJYGVZuCTuhehcafcnDRQK0jJXqAIV8PaP7LJN/+5SsOSQvEkjGYmig==
X-Received: by 2002:a17:902:d48d:b0:153:a517:6ff2 with SMTP id c13-20020a170902d48d00b00153a5176ff2mr30483828plg.141.1648553777948;
        Tue, 29 Mar 2022 04:36:17 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b16-20020a056a00115000b004f6ff260c9esm18614267pfm.207.2022.03.29.04.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:36:17 -0700 (PDT)
Message-ID: <6242ef31.1c69fb81.8c70e.103f@mx.google.com>
Date: Tue, 29 Mar 2022 04:36:17 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.106-cip4
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-pty: 4 runs, 3 regressions (v5.10.106-cip4) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip ltp-pty: 4 runs, 3 regressions (v5.10.106-cip4)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.106-cip4/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.106-cip4
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8bb6e30b765989a3c0924158316d689e16317cd1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dc836ec4cd4e02e1346001f828c1f1988a8d7d54 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6242dea58b14bf7a79ae06a0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-a=
sus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-a=
sus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6242dea58b14bf7a79ae06=
a1
        new failure (last pass: v5.10.83-cip1-151-ga4163710a1dc) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6242e4a40b456963c8ae067c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-h=
p-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-pty-h=
p-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6242e4a40b456963c8ae06=
7d
        new failure (last pass: v5.10.83-cip1-151-ga4163710a1dc) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6242e36482ded63d30ae06a8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk3399-=
gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.106=
-cip4/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-pty-rk3399-=
gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6242e36482ded63d30ae06=
a9
        new failure (last pass: v5.10.83-cip1-178-g2cf1d12aab81) =

 =20

