X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web12.1781.1646795168595336834
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Mar 2022 19:06:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=bI9udPBR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id v1-20020a17090a088100b001bf25f97c6eso3408193pjc.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Mar 2022 19:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=qAXXoFiBhayudZsVjyp+u1rz5pwkUisf8v/Uyj8fvHA=;
        b=bI9udPBRzhTfEj9cj8j3shXmgFo4WRhVBj6CMSwTST/ZTML5cHVVE8rYK1SBGIZu+i
         LcSmGybU3VJrvOnU3WySBGEITwBcvhSw2fG1OnJT64iwmUlgzmwrm2V28Rr4O09rkjMK
         hRNPj/qRij767OXaNm5PtXXkqUsypcl+LdjKM+tDohNxevDFPEP65O//2aZNwizvP8MG
         dwOWP54hP6OVnZMBzZRojb7ewRmB/P6sjJovUvqasof6Xmi2RqvDUIJhjzWcEnI99tg9
         yu+7nojDBcdCCSDdRrPYxwn4VbNTIrsEIrTcwa0s6nxl5NdiTDlluYLsUfi+dwAEp6w5
         G9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=qAXXoFiBhayudZsVjyp+u1rz5pwkUisf8v/Uyj8fvHA=;
        b=AJg2aydLAnHxEAzN9BsOR9fiOp0vk/HwSjLOooM13X5P+ILfnR6XyWQNX7YR9t3tKR
         nzdtrwu6X0jpOw6+dpyFi0VUFf1jrQjgpOdpcVGUGt/BuleBXknEeuN3FoMR81pJojd7
         Dt/sGMK7QvZ7CluOPzOF2AD1K6tFvbohpxCSKiIRck8nZgrXuWBFnUoCNwyYJEOjcgP1
         n+9ef1tzoCuitupZPmmUsOAF/AeIVEq4ewZ1pBtj4LJAcgXxmAX67vi9cjqq4S+qg01M
         vS3Zqy8Eg3H1m5dd34Qj+K2qw2yTwH4jB7Qgm1ZE5o+TcGXTHVXRyOf1rVbAL6WbUtKZ
         c1DQ==
X-Gm-Message-State: AOAM533YdtWHHxe95C17rADQajv3kbA/yE4KTw5wkxBXBhUU8BtqsPlO
	r9ja6Z8DO0HipM82c1hiKiFps2iiivfcVo5OSoQ=
X-Google-Smtp-Source: ABdhPJxldBl+5faa+wlxoxTSzeLRXANvjm/i+8iYBLIC/LY68+Ey+W8meUWgOcUOO1fy749AY+5tYw==
X-Received: by 2002:a17:90b:1e01:b0:1bf:5f6e:cbef with SMTP id pg1-20020a17090b1e0100b001bf5f6ecbefmr8094329pjb.130.1646795167757;
        Tue, 08 Mar 2022 19:06:07 -0800 (PST)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z16-20020a056a00241000b004f3a647ae89sm501572pfh.174.2022.03.08.19.06.07
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 19:06:07 -0800 (PST)
Message-ID: <6228199f.1c69fb81.c12ba.218e@mx.google.com>
Date: Tue, 08 Mar 2022 19:06:07 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.100-cip2-425-g0a0d92194f39
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 8 runs, 2 regressions (v5.10.100-cip2-425-g0a0d92194f39) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 8 runs, 2 regression=
s (v5.10.100-cip2-425-g0a0d92194f39)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.100-cip2-425-g0a0d92194f39/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.100-cip2-425-g0a0d92194f39
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0a0d92194f399a5095878cd6edf9060eb4244d81

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  67eccca54eb68a1bc91cf1f140fc43fa8085d8ed =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/622804c6fadea7eeb2c62999

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-425-g0a0d92194f39/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.100-cip2-425-g0a0d92194f39/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220228.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/622804c6fad=
ea7eeb2c6299e
        new failure (last pass: v5.10.100-cip2-319-gcbff87047566) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/622804c6fad=
ea7eeb2c6299e
        new failure (last pass: v5.10.100-cip2-319-gcbff87047566) =

 =20

