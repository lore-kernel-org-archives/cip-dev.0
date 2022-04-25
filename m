X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.31377.1650901718460658085
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Apr 2022 08:48:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=b6s9FMYJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id y14so14391715pfe.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 25 Apr 2022 08:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=9M7HV/PzlycsCz6UhKV6euv+XGWjfk67ho9nc9ZEt3g=;
        b=b6s9FMYJJtEYWsB4R19e/E5VLpuf+KrdJHr2/mlo6d+SnKXRKG+f9622ffrq/0djwE
         WNyC5G3ZPxXePubyQJZgW+KrhYBZ8uSfA2HxklfwN9jVZJV1sAAmdoylvYgyKIcQT9Qv
         AavznK49UlfLZ7RjQ6vYAOY7GaMscQJtzlnd7uj8hiiPhNJWUqOPFWwC0rzi1vH6jrsy
         PDNn6tZi+dfFS/p9QkWTHs9hqR94LEIw8brg0JPlqiIP6jDLIN3Nfcj/6GUDUNdioLBn
         ZY5Cr/Q/WK1NfEwkNX2ZgfiqIXjslMVuYsuyZ+PTSVi1gDTb5UI/jVuTA6apbSqieQIw
         K/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=9M7HV/PzlycsCz6UhKV6euv+XGWjfk67ho9nc9ZEt3g=;
        b=XbQ93+rF2gEu+7BsfjXaAE4cZOPwMcHGNZi6hZdMKrVSuJ9e0ZLz6CwaECvnXiB+VN
         ZLxaM0X12Wp9MEWQ1oQy3xPeZT++0PuomR7gTsIOVw0ZJ2nAbSe3tdFBp9OKqIlErnfe
         rPyJb7XJtwBM1bGpEqzkUWrSsA/ZLKRK1LWsed8Kda4x/7XMEQdknrAWsd0eY+CAFJDZ
         sarN90Ov22g21H7OOwP8u1gx3cE8JiGYpBqj5//f8jD7zSft5g0X4hNB0C7EXo/YVnrM
         eN2fBJTUssyXw+Kdjk+qepSdp3L58Wdu9Le0FtDcemqJ6Jhc1p9iLBxpXSdVa7260nz1
         q/+w==
X-Gm-Message-State: AOAM530NBpNFe/LE3ETF4d3F1NGEi8YUhcncwA19fvIDYRMtBxg84N/F
	eaCVvZc5MwzLKxNX50xJrIPPA041BDjWphGs/0U=
X-Google-Smtp-Source: ABdhPJw3r+VnFWbn1WrbNv3Qxu12QnyiZs/UDvWX2ipyLFt8p1WYtowPFY4wPF1+MrZRmzLZFuadcw==
X-Received: by 2002:a63:788f:0:b0:386:3116:818c with SMTP id t137-20020a63788f000000b003863116818cmr15439980pgc.414.1650901717682;
        Mon, 25 Apr 2022 08:48:37 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h18-20020a056a001a5200b0050a43bb7ae6sm12402767pfv.161.2022.04.25.08.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:48:37 -0700 (PDT)
Message-ID: <6266c2d5.1c69fb81.ed71f.cd2a@mx.google.com>
Date: Mon, 25 Apr 2022 08:48:37 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v5.10.112-cip6
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 5 runs, 3 regressions (v5.10.112-cip6) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-5.10.y-cip kselftest-seccomp: 5 runs, 3 regressions (v5.10.112-ci=
p6)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.112-cip6/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.112-cip6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c8f6747dcd02a8f87731c324f4bc37bd120a8982 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6266ae965106035435ff9462

  Results:     83 PASS, 4 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora=
/kselftest-seccomp-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora=
/kselftest-seccomp-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220422.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/6266ae965106035435ff9469
        failing since 27 days (last pass: v5.10.100-cip2, first fail: v5.10=
.106-cip4) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6266b1d13e60e86a00ff9480

  Results:     83 PASS, 4 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora=
/kselftest-seccomp-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora=
/kselftest-seccomp-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220422.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/6266b1d13e60e86a00ff9486
        failing since 27 days (last pass: v5.10.100-cip2, first fail: v5.10=
.106-cip4) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6266c0ecf6dcdc25a6ff945d

  Results:     83 PASS, 4 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora=
/kselftest-seccomp-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.112=
-cip6/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabora=
/kselftest-seccomp-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220422.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_bpf_TSYNC_siblings_fail_prctl: https:=
//kernelci.org/test/case/id/6266c0ecf6dcdc25a6ff9464
        failing since 27 days (last pass: v5.10.100-cip2, first fail: v5.10=
.106-cip4) =

 =20

