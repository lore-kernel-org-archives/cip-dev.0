X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web10.9593.1648044139641838091
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 23 Mar 2022 07:02:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=v/l73WDs;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id h19so585785pfv.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 23 Mar 2022 07:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ZWLgqXOcfLnoviRZtoMw0XFwZMt04+calgRgkO5TyLM=;
        b=v/l73WDs7VIAPUNAH1Q86sxDD2Xz/g5gB0VU+OX6IIffq630dh+Nt9b0JiUS7qQB/T
         29mZQ3hsjti+obgyd94s+L1AypcyXPL3yZXnY452ecHt4OQGY3rxwG19qbUbcO5kvTsM
         ycgy4NloEqKEmpHnIh/9eRThG5SiEJxrfJNKHOXzpMgv4LY1qA13PjtrkQnDo2gtudMc
         hwfCQaF2S//YRrU/27bxfJmeVLgNp3EtJv5pKl6NrLVduLrcQgZNhS+5r3acXQ77LPY5
         ixZDzgbxlcguXF+bPDLPbdu+FLLCGIOOtQoMQ6TVKNHGLGrLItpmM4f3+J0EgUThvwMr
         IvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ZWLgqXOcfLnoviRZtoMw0XFwZMt04+calgRgkO5TyLM=;
        b=8FDDY5wcUUGEB0ixKoliZLXkGhYnpAVycwHmWKDkhk6k02sQW26dn6ox1IVyrQMzVA
         XIFiJsrH55PvFO8WEvBDGf0kTlKhLT0Z1S2p98wxQHqKJTBBGWguOJ7ZpIdIHyAhmRjQ
         ppBFquD8W/QnWJY3GG8XY7W2eaE0SuAwQB6+0t3mr+foXoLJ7uuownE9Iup5gc/VkNaM
         +XrJLA7fIvqzM+uyeI4b+GiY5yu9tc4DBfdrhZPk9SafRIBFJPTpBF7zT3XxWnJE95eo
         q5cwjxrFmpoPzXf6GTkzxh/jYNy7OKCFqmLdiHRpZrhGfC8rWmmoQBEz759Vca/3DneG
         1JuA==
X-Gm-Message-State: AOAM533lRljo3MzpP0j5C+C2ubMjU/Jt2ARdlVaSOVBK3Ut7XEM/RnnE
	Frr/bE9Joo2gnvpX+LzIaTFWcXAxLvYwWuJjGkQ=
X-Google-Smtp-Source: ABdhPJx/Tsqxi+o6LsVM8+lX+XYbq379XyIxVJRhK77/1aMdfNpwpS4m3h2PtZvvW25OCmX2GJr9Lw==
X-Received: by 2002:a05:6a00:1943:b0:4cb:79c9:fa48 with SMTP id s3-20020a056a00194300b004cb79c9fa48mr34446501pfk.47.1648044138729;
        Wed, 23 Mar 2022 07:02:18 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id f19-20020a056a001ad300b004f7661b0b5esm57599pfv.215.2022.03.23.07.02.18
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:02:18 -0700 (PDT)
Message-ID: <623b286a.1c69fb81.c9457.023b@mx.google.com>
Date: Wed, 23 Mar 2022 07:02:18 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.233-cip69-120-ga36ab9aceb93
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-pty: 3 runs, 3 regressions (v4.19.233-cip69-120-ga36ab9aceb93) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-pty: 3 runs, 3 regressions (=
v4.19.233-cip69-120-ga36ab9aceb93)

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

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.233-cip69-120-ga36ab9aceb93/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.233-cip69-120-ga36ab9aceb93
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a36ab9aceb937b317b1eb65a1405f5290fbdc6f8

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


  Details:     https://kernelci.org/test/plan/id/623b1bd1fa6e4a4818bd9189

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-120-ga36ab9aceb93/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-120-ga36ab9aceb93/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/623b1bd1fa6e4a4818bd91=
8a
        new failure (last pass: v4.19.233-cip69-62-g10346bfb0fd8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/623b1c5cde34ec6f94bd91ae

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-120-ga36ab9aceb93/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-120-ga36ab9aceb93/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/623b1c5cde34ec6f94bd91=
af
        new failure (last pass: v4.19.233-cip69-62-g10346bfb0fd8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/623b2177293ff5cbcebd9183

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-120-ga36ab9aceb93/arm64/defconfig/gcc-10/lab-c=
ip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.233-cip69-120-ga36ab9aceb93/arm64/defconfig/gcc-10/lab-c=
ip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/623b2177293ff5cbcebd91=
84
        new failure (last pass: v4.19.233-cip69-62-g10346bfb0fd8) =

 =20

