X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.11326.1652275472103423297
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 11 May 2022 06:24:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=5q6gr4Vr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id n8so1900753plh.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 11 May 2022 06:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=01wduC4H2vxhUJvW3vaDgEsnnUk5DZsM3lF6v/7iTlw=;
        b=5q6gr4VrmElx95fusMggMop0SEPV5DHdt9hsnTAQOeGfwB8vxd2MLJ7VxXnemy9h4l
         8Vf9vuSEhu5RpHARkSOlhp6uVORPEN+rCZqKbGRxjxvlUfmSIzm/u1RfHel+yFNqH6HE
         qG5sINSTDqgfCkG4a2lNTQTXpi85DB6pmWGYJO0rCjTi0MFzNQD/phbn9xCgUTDnsYKM
         iey4FqSeXBzlQoaDeGAzOQ75nAsyhWuYh2BLUaBO42HQn1bavQ8n3VeZn4CXMiK4qS8E
         s4NRRwO80sjeuN/e/P2hrRs+Ff3bpSBwAeOQv0YyTRtO4r0dEeoopA35eMe2zWhiaHQx
         Ogwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=01wduC4H2vxhUJvW3vaDgEsnnUk5DZsM3lF6v/7iTlw=;
        b=AtSK7bCaAtgarwa9Wx+ZtNgUkqbldbPhWUqNtOveBYr1XpoQYDSlponsgykpo0/jkV
         x6w8/ZpqDGBY+WaW9Z+cXNhZFaEMemPolL7yCYVmiu9i2NCOVNkiINOdQMO1PLNi4rxf
         COm6RqV6HNWLM1pLsv5tz7cY9b8Pxj1UEwp1aqSmZycgjRXjFGS+kKaPkDbYFMnvlUIN
         f36jtIixU+oPqUgWoolz79YaR6ZEX95mc3NYqpWntew8qLii+t+8GapAO3WFQlmh7M9t
         YB6ICJFeabuurl/J8BJ7htfK5wfkTnzd0h68QN5aqYm53Xyy5q57hZJYgqABup5RzjMI
         3LYQ==
X-Gm-Message-State: AOAM5325lFByl3zKzMxd4Qxj/jaTWZQimbePCxWJerSBP6geswG+OPDk
	3TPc6cJUtPmX+oeCqP+i/oxiwuyQ3MfBmLrHE7M=
X-Google-Smtp-Source: ABdhPJz/x4twKgSl3u+m3ha8tatvCkAj2Cpcl0/4rQ47c/lzpQVp/tt2vt6kERBDXqezrzOpXLjE+A==
X-Received: by 2002:a17:902:dacd:b0:15e:a53e:3239 with SMTP id q13-20020a170902dacd00b0015ea53e3239mr25269548plx.7.1652275471408;
        Wed, 11 May 2022 06:24:31 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902e88300b0015e8d4eb289sm1879960plg.211.2022.05.11.06.24.30
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 06:24:31 -0700 (PDT)
Message-ID: <627bb90f.1c69fb81.afc83.3e33@mx.google.com>
Date: Wed, 11 May 2022 06:24:31 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-23-gf7cf04ab668f1
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 5 runs, 5 regressions (v4.4-st5-23-gf7cf04ab668f1) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-ipc: 5 runs, 5 regressions (v4.4-st5-23-=
gf7cf04ab668f1)

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

asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-23-gf7cf04ab668f1/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-23-gf7cf04ab668f1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f7cf04ab668f124b54f47c93fca7625e6eff3cfe

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  0f67c9851a9043d0ad68cef4648d103ba7908480 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb5fd1e16ff97648f5742

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/627bb5fd1e16ff97648f57=
43
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb1d17440689a788f5762

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/627bb1d17440689a788f57=
63
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bac13609d8a64628f573f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/627bac13609d8a64628f57=
40
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bad45c7261edf2b8f5717

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/627bad45c7261edf2b8f57=
18
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/627bb15e65a05c8fa88f5720

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-23-gf7cf04ab668f1/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/ltp-ipc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220506.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/627bb15e65a05c8fa88f57=
21
        new failure (last pass: v5.10.109-cip5-384-g722204542e8a) =

 =20

