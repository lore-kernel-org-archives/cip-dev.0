Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F64C3DA78
	for <webhook@archiver.kernel.org>; Sat, 14 Jan 2023 03:30:29 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web10.109134.1673667020406558079
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 13 Jan 2023 19:30:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Yah5GTjP;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id 207so1397605pfv.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 13 Jan 2023 19:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jZmqmdIFq/58tTnfxMOyCIps99i9a22hbkNJpqiG+Po=;
        b=Yah5GTjPesHmwromlT5J9pWyyZQu53SK5gzpMcIwHf4VDwAd7B6OW1PwSuWlWh+HQB
         ZapSmOskNtGEJpeHRWtxGBsVjoUgaZSmMHiQE44U/iUTx8m8LokADy6670MTPj5v+o/f
         +gk9dX6TAsgjmrL+2SVuofyxEinsguOXSyAteIchXn8NEqRHQnPQodXw3+iVqrukj2FW
         VbsSLo7dNTcbWOKtBCbloNM7VtMZT7BLsWQ9mpwKYRwVwmlAgpJjIioAoxvuB6boG1oI
         X+ZbFP3IsgThIS38Z38DovoG3r85f825KplBpvAuUxWFaMYHg7pHb52oKl7Yjs4Zj/Re
         9MGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZmqmdIFq/58tTnfxMOyCIps99i9a22hbkNJpqiG+Po=;
        b=YnrRlceNVv4w/k0MVTRc2rJqT8Z3/rmSD7KTC/lhahVJfOwPVtHn2raI7nbXkTcy97
         8fnqC0DaSDkUgiE2f7nXTCcKTeIImTCyyod8ciNdvZAzJGPkUmlCmnKyq9+6rbp8D3tA
         jjMspyyQ71/Ru/nhYuXRjpOxmj9H1+sRJ6zb1s+oXnWzmxYmSKArUbbVzXaZUzKFG1vy
         FJB2wqK9hzWlLopRJXkIY+eOTwFsX2NZsyWT/i9dCqYuHmUFqb/em+lIdpU+vnP8y2yQ
         A+gxoppiJL6N6tWYslyCbicq2ZzpGis9+KvcGt8ljQ9YAZFiqcIVvFL7A7zU9eRB1Epq
         0Bow==
X-Gm-Message-State: AFqh2kpNI7sDQjRdTV2T824Zw1Flh+ta2hIg24YF4IRXuNp2MMKGY3Cs
	G7x6pX3Seegce+WIalZ8zy0fqywP8QAs+H6V/IQ=
X-Google-Smtp-Source: AMrXdXtuN/wWBDEGmX7PdyyrTZ+y59boHaSrpH9JT2fAvyqfEzIu2Q6D18qRIC0bHN8yJhIXOT/pMw==
X-Received: by 2002:a05:6a00:5e:b0:588:eafe:ab27 with SMTP id i30-20020a056a00005e00b00588eafeab27mr13266474pfk.13.1673667019631;
        Fri, 13 Jan 2023 19:30:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 190-20020a6219c7000000b00589d91962d5sm9003129pfz.195.2023.01.13.19.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 19:30:19 -0800 (PST)
Message-ID: <63c221cb.620a0220.be827.fbac@mx.google.com>
Date: Fri, 13 Jan 2023 19:30:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.162-cip24
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-timers: 9 runs,
 6 regressions (v5.10.162-cip24)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 14 Jan 2023 03:30:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10358

cip/linux-5.10.y-cip ltp-timers: 9 runs, 6 regressions (v5.10.162-cip24)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.162-cip24/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.162-cip24
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7ef5f1fda52a95426084959dac09acdb3c81327b =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63c210d93cb323e0fd1d39f3

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230109.0/amd64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  29a4437646ddbcf389965136680e06d40cbc4722 =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c210d93cb=
323e0fd1d39f8
        failing since 28 days (last pass: v5.10.158-cip22, first fail: v5.1=
0.158-cip22-7-g92462fd9830b) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c210d93cb=
323e0fd1d39f8
        failing since 28 days (last pass: v5.10.158-cip22, first fail: v5.1=
0.158-cip22-7-g92462fd9830b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63c20ffe06485e1e291d39c3

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230109.0/amd64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  29a4437646ddbcf389965136680e06d40cbc4722 =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c20ffe064=
85e1e291d39c8
        failing since 70 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c20ffe064=
85e1e291d39c8
        failing since 70 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63c2158a771b14e07e1d39e1

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230109.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  29a4437646ddbcf389965136680e06d40cbc4722 =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c2158a771=
b14e07e1d39e6
        failing since 70 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c2158a771=
b14e07e1d39e6
        failing since 70 days (last pass: v5.10.147-cip18, first fail: v5.1=
0.147-cip18-12-gcb2b164780be) =

 =20

