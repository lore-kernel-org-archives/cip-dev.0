X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web08.26016.1653837577295555768
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 29 May 2022 08:19:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=MPk8I9Y1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so8451695pjq.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 29 May 2022 08:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=+8i4ChiIN/V2s3fwHYTu0UCypBnwapQj27YmilABNiQ=;
        b=MPk8I9Y1a5JTIQJQtDGHjhP2uDs2CaStD9a5z7T0PAZQcGlGk/ZVoKrMsXbxwxTOrM
         +9roelylJJ3jZQJTVGeaNrdLyZgztKCSESd6ia1Ph9hkm58HUfAlWreHB5jKzNoy6iSt
         h6N9UF8036QjnuYzUDSx6i2itZb9JFMh0HrXo09TWo3CCazOf0rHsA4hhRYOqBF3p9L9
         gO4og5u9p1ARP1YbyYIlbdj/zJfHfUYaZV8P1wULMDpAt7gFOR7W2r96oQ88j1ceHJXP
         pe/ULxbvQPIkWOPid1nc8c5DI10v2cUtAYxr1dZA2MVDd/ZQ3BziSHuq8YASn63sCdvO
         oOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=+8i4ChiIN/V2s3fwHYTu0UCypBnwapQj27YmilABNiQ=;
        b=eNF67d4KQKyBjhYjJvTNhF6ZbMqRV5jWeeoT2wFrqAMUAxyQtnflCP8SX/EatCyAJI
         MCJfhiS/a4kbvBkEX+iH2CK1TVBRhZTn3L/DbXJ2AplV4wXCAtbEHDtvbjtecUc2Yccd
         LN97aTIlG71mFCuTbUuDiMmAfdR4fIa5f84H+vX8SXL3H/aBspbMUXxnkXYkcSJunCAn
         +rVtkRqlu7Ogs//JqasOISkb/3tWoLU3WXVpmB2vfWapQhCSzo7+BiwG5o/bUJDbj/Sx
         P5NNaK4DiwssOq56io18Bp+eaMEyAj5oh3qfqPyInIUuJn6mvWlcabniUfQuQdvu6nuf
         Rpbg==
X-Gm-Message-State: AOAM533zMVIUWkpXOimICXtO7R9qsBBygLhxHKT809Hwdo0KxtNrP4h7
	Q/biKGfoZDJ2rzXf/AT96XJth1vxupDg31iaDU4=
X-Google-Smtp-Source: ABdhPJz1Q6VCJkkHt8P4iIWOVlau+ZUTtelmg3FP7MrKWt+jVkztk8UGFUHEOBL1NeUAT1+oMnMTog==
X-Received: by 2002:a17:903:124c:b0:15f:179c:981b with SMTP id u12-20020a170903124c00b0015f179c981bmr52002532plh.103.1653837577601;
        Sun, 29 May 2022 08:19:37 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d20-20020a056a00199400b0051829b1595dsm7358769pfl.130.2022.05.29.08.19.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 08:19:36 -0700 (PDT)
Message-ID: <62938f08.1c69fb81.bf48d.fed2@mx.google.com>
Date: Sun, 29 May 2022 08:19:36 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-297-gc0d53c2a5c03d
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs, 4 regressions (v4.4-st5-297-gc0d53c2a5c03d) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-mm: 4 runs, 4 regressions (v4.4-st5-297-=
gc0d53c2a5c03d)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-297-gc0d53c2a5c03d/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-297-gc0d53c2a5c03d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c0d53c2a5c03d0b2672a56140f211b51b3e047c1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  17e9ae697a340242c49188ace12a60cd3bc95a53 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62937a941d3b5a920ba39bd1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62937a941d3b5a920ba39bd2
        new failure (last pass: v5.10.112-cip6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62937992903f0eaf0aa39be3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62937993903f0eaf0aa39be4
        new failure (last pass: v5.10.112-cip6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/629379b22c990460eea39bec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/629379b22c990460eea39bed
        new failure (last pass: v5.10.112-cip6) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62937aa31d3b5a920ba39be8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-297-gc0d53c2a5c03d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-mm-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220513.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62937aa31d3b5a920ba39be9
        new failure (last pass: v5.10.112-cip6) =

 =20

