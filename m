X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web09.893.1648506490032030319
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 28 Mar 2022 15:28:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=kRifesMZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id l129so4744153pga.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 28 Mar 2022 15:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/yeWCpUQPXlaCjlsYVI3TD5PmjfMNdbzqdL/93bCRrs=;
        b=kRifesMZroxh294h9vnvykscEK912t8i/crBkQYUVG1R3F7rkhndqHAgkhZCIWYW2U
         m5nX0RUTLyBUzoOS0gdgx1KIc2M5WePvdiHHbBPlFGo9ybBovuAYsmhw3pV50YIvVZPy
         hMsv6HrbU2dug8q43Xj0W2PEfpzRP7STmKffi712rZH1pB4jx+YFJH6iMA1tCw74F1IP
         iQPXW4uLYXwrhKGXvpVAu7DbgaJEj1oQl92abyf/bQvbkJYQOwcyyz2zapLFtEEBObcD
         i+DCXLnaBwPfoMXizalpdUaIsbAH/Qob2SXk8kMcd49voX3Fcv4Mk9IBYpUhJ4IrzMSn
         /CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/yeWCpUQPXlaCjlsYVI3TD5PmjfMNdbzqdL/93bCRrs=;
        b=VtPXLk3IlhspgJafLzmo6F3+twpm9lchGhn0Mcl4khoC+U29doi3RxIqjMPnuR4vt7
         R6qautDFwyfU6o1FY+WbPapeyJWcTmGLN89MwHJKmUROxhFAeN81tp+k8i05rH0ZYpWf
         49j74z+LftF6EB69Oqd9jPYPjKaRIdyKLe2clFcszIJjm8Yxe5RmIi+4RsFI+ohVqOUI
         T99bc8ONna6DenxZC1Oq0LL0TNoLekubbBIfj5MRasiEW/MW2dshY8w+2bUxnc5w8QA3
         YeZJUpXuS4JfPVLhFR3HMT4pDlNndCyZsv9nuzTNbUgQG/v+6rMwMX6F2bvwcd4aWga5
         VA0Q==
X-Gm-Message-State: AOAM533KdzHECIuc7mwHIb2tyldCSHw3gmZVACVvudY1AFpOOjGS7tDV
	/JnK3Dc6eKqQPt0bYztFb8GbNhWUdae1vVJ1Pi4=
X-Google-Smtp-Source: ABdhPJwJu8wsIiZP0wwNPxcSLy5ikbTiphxH41x2q+wrzn4Oq5KjV7iqTWJ1Dugc5ve7nFVtlZ4dbg==
X-Received: by 2002:a05:6a00:18a1:b0:4fb:27d:54e9 with SMTP id x33-20020a056a0018a100b004fb027d54e9mr20421058pfh.7.1648506489339;
        Mon, 28 Mar 2022 15:28:09 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d9-20020a056a00198900b004fafdb88076sm14697535pfl.117.2022.03.28.15.28.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 15:28:08 -0700 (PDT)
Message-ID: <62423678.1c69fb81.abec6.5c4a@mx.google.com>
Date: Mon, 28 Mar 2022 15:28:08 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.233-cip69-142-g40322771bdc1
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 6 runs, 4 regressions (v4.19.233-cip69-142-g40322771bdc1) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 6 runs, 4 regression=
s (v4.19.233-cip69-142-g40322771bdc1)

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


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.233-cip69-142-g40322771bdc1/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.233-cip69-142-g40322771bdc1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      40322771bdc1d32499c228464c031d6a0779e3ca

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
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/62422a44b2c5712dffae0699

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-142-g40322771bdc1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-142-g40322771bdc1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/62422a44b2c=
5712dffae069e
        failing since 19 days (last pass: v4.19.231-cip68-36-g01a8d14a9290,=
 first fail: v4.19.231-cip68-89-gd39fc5cc85ff) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/62422a44b2c=
5712dffae069e
        failing since 19 days (last pass: v4.19.231-cip68-36-g01a8d14a9290,=
 first fail: v4.19.231-cip68-89-gd39fc5cc85ff) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6242292c02acb5446bae0687

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-142-g40322771bdc1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-142-g40322771bdc1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6242292c02a=
cb5446bae068b
        failing since 12 days (last pass: v4.19.231-cip68-89-gd39fc5cc85ff,=
 first fail: v4.19.233-cip69-62-g10346bfb0fd8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6242292c02a=
cb5446bae068b
        failing since 12 days (last pass: v4.19.231-cip68-89-gd39fc5cc85ff,=
 first fail: v4.19.233-cip69-62-g10346bfb0fd8) =

 =20

