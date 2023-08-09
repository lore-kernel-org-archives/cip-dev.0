Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB65C001DE
	for <webhook@archiver.kernel.org>; Wed,  9 Aug 2023 00:35:03 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web11.78041.1691541294451330040
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 08 Aug 2023 17:34:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=QfKbUTbs;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6877eb31261so4633054b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 08 Aug 2023 17:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691541293; x=1692146093;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TUjeRvcF5RvJChqwgXaXxK2Z8BIOevsAbgzf1iJvqwo=;
        b=QfKbUTbsrFnNyqzIvFLbDripZ1XmlmIgUO5K+xo5e9J5uFXrFX2fuVFZ6umkCu0Kdr
         hhYhJb0Hsh7z83aI+AbIwTyHFIlqp0omYXb3Pzx9010hgEIdbvGYuhN6mlAsLACcXaoc
         HlvRw+wlTnHMChUpEAcmnFhUlm28RmAj1WCCu3jEP8UjdM3ue/lnFwR8VBT/ApNqcmJu
         gQQJQUvtZACFdLdv9Yza28Aj+KaUQgBNxUJldCPXPaNVMWhL829KCt9EH7/DzFH/fYQh
         kZQAw5a0QkhEawLPaU/ltyuHkO9HXBIVbCL9jqL7GXz0CwHV/wCO3F2O8H9+4INqByVB
         CQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691541293; x=1692146093;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUjeRvcF5RvJChqwgXaXxK2Z8BIOevsAbgzf1iJvqwo=;
        b=I1cmsUvwUf0bYVwzoiJNtB/5+1T2KLdJEctoBUOUh87neR+cbtBwqWZEbPta6ey/am
         hBMyhMpdO9gofVOviqseMCn83+U73E/kPV1pr/bz5U5d3ALDbz+afl0zdUK1bgGIGfRC
         dMyGefd5fitUQUgu4XWHLnA1JwWGy2ysvTdYE8FOg7Y20qBS6/L4hsFWKNTGjK0z5OMk
         CHyFgQIM/HkHKfVCXHrta44fsB/waVf9PpVUkrKiPuwywmt21fOF3txhKtsXioc3gCnh
         QWXPjxBprCqZfw/C0W0pops1LVXJrXRuwBPOwaM2kV+GDhbjG1sxzTyMtT6kPDRKb2bt
         nrLg==
X-Gm-Message-State: AOJu0YyqflTikUJ9NFFEdjCidhBdU+yyooRBdLxddqz7S/GeIrmiHd9R
	2z0N+2G4PzpR+wD1dHQpTACR9wPIQjXoeZep4TuGZA==
X-Google-Smtp-Source: AGHT+IEDEl87zMcAg39FXK3E6HEsPR+VaolnVvSrcZ8jrMBelU8i2XhM2L6tRnR7/W9Dy9cDj6Vjjw==
X-Received: by 2002:a05:6a21:3b44:b0:13d:df16:cf29 with SMTP id zy4-20020a056a213b4400b0013ddf16cf29mr890720pzb.15.1691541293013;
        Tue, 08 Aug 2023 17:34:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q8-20020a17090311c800b001bc675068e2sm5786995plh.111.2023.08.08.17.34.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 17:34:52 -0700 (PDT)
Message-ID: <64d2df2c.170a0220.577d6.b17a@mx.google.com>
Date: Tue, 08 Aug 2023 17:34:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-566-g36076316ef049
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 42 runs,
 8 regressions (v5.10.186-cip37-566-g36076316ef049)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Aug 2023 00:35:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12567

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 42 runs, 8 regress=
ions (v5.10.186-cip37-566-g36076316ef049)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.186-cip37-566-g36076316ef049/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.186-cip37-566-g36076316ef049
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      36076316ef0496f258d98ea65b29aa2c5b0bc603 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d1e19da58e2cca35b1f8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oc=
topus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oc=
topus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d2d1e19da58e2cca35b1fd
        failing since 110 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-08T23:38:32.652001  + set<8>[   22.715149] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11238017_1.5.2.3.1>

    2023-08-08T23:38:32.652529   +x

    2023-08-08T23:38:32.758079  / # #

    2023-08-08T23:38:32.860942  export SHELL=3D/bin/sh

    2023-08-08T23:38:32.861676  #

    2023-08-08T23:38:32.963180  / # export SHELL=3D/bin/sh. /lava-11238017/=
environment

    2023-08-08T23:38:32.964023  =


    2023-08-08T23:38:33.065644  / # . /lava-11238017/environment/lava-11238=
017/bin/lava-test-runner /lava-11238017/1

    2023-08-08T23:38:33.066905  =


    2023-08-08T23:38:33.071599  / # /lava-11238017/bin/lava-test-runner /la=
va-11238017/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d1d49da58e2cca35b1ea

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d2d1d49da58e2cca35b1ef
        failing since 110 days (last pass: v5.10.168-cip27-109-g23841ec76be=
c, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-08T23:37:37.316330  + set<8>[   20.178875] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11238029_1.5.2.3.1>

    2023-08-08T23:37:37.316417   +x

    2023-08-08T23:37:37.421682  / # #

    2023-08-08T23:37:37.523564  export SHELL=3D/bin/sh

    2023-08-08T23:37:37.523722  #

    2023-08-08T23:37:37.624323  / # export SHELL=3D/bin/sh. /lava-11238029/=
environment

    2023-08-08T23:37:37.624978  =


    2023-08-08T23:37:37.726117  / # . /lava-11238029/environment/lava-11238=
029/bin/lava-test-runner /lava-11238029/1

    2023-08-08T23:37:37.726427  =


    2023-08-08T23:37:37.731850  / # /lava-11238029/bin/lava-test-runner /la=
va-11238029/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d61ed8fcb8e27735b21f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.=
txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64d2d61ed8fcb8e27735b224
        failing since 110 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-08T23:56:03.665641  + set +x

    2023-08-08T23:56:03.672641  <8>[   22.126570] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11238134_1.5.2.3.1>

    2023-08-08T23:56:03.782547  / # #

    2023-08-08T23:56:03.884911  export SHELL=3D/bin/sh

    2023-08-08T23:56:03.885704  #

    2023-08-08T23:56:03.987052  / # export SHELL=3D/bin/sh. /lava-11238134/=
environment

    2023-08-08T23:56:03.987753  =


    2023-08-08T23:56:04.089173  / # . /lava-11238134/environment/lava-11238=
134/bin/lava-test-runner /lava-11238134/1

    2023-08-08T23:56:04.090397  =


    2023-08-08T23:56:04.095518  / # /lava-11238134/bin/lava-test-runner /la=
va-11238134/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d89208a3ef9eaf35b220

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64d2d89208a3ef9ea=
f35b221
        failing since 12 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2d8e63c43f4f08f35b229

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64d2d8e63c43f4f08=
f35b22a
        failing since 12 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64d2da399eed9a268135b218

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig/gcc-10/lab-=
cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig/gcc-10/lab-=
cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64d2da399eed9a268=
135b219
        failing since 12 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64d2da41a68df2d79635b1d9

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-566-g36076316ef049/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64d2da41a68df2d79635b1df
        failing since 110 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-09T00:13:35.354734  /lava-11238282/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64d2da41a68df2d79635b1e0
        failing since 110 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-09T00:13:34.277352  /lava-11238282/1/../bin/lava-test-case

    2023-08-09T00:13:34.305815  <8>[   94.362837] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

