X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web09.5454.1649726078071016279
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Apr 2022 18:14:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=6ige7xMw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d15so15360093pll.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Apr 2022 18:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=eHlmuE1/lGZ/zkzgqWbjjUbd7CbqcxAJnZTL/tZAQwA=;
        b=6ige7xMwSzS01EzG4V8VIwZEQxCYHdmtYpR51xDYixlQQQTSxV1Ib0kWyo9mL6CEY/
         1jfujp1Y9c2F2t2DXJkdeRJ9bgmP6yOelGQ8eCrNRGyWDjkdbxPhm/jrbHGwu6Ok6i3P
         oSWoREABumhbpcmWWW0K3mI+JWV0F9AjxbQx5Yf7kloI4wNG//v4/833dwLyc0jVIuL8
         SDcudfReb6i3J56pEI2yHAEYO6e7gD3ZWdXCIeUqqS5zpicstCdOiBBkBeqQqgeuPvYo
         2RB2c/xMZ9RxC0RDLtqJkPz2wsw5W5iKzQMdEDEABvsHzLQxukzy/0NS1HTDbK14FxnV
         ytbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=eHlmuE1/lGZ/zkzgqWbjjUbd7CbqcxAJnZTL/tZAQwA=;
        b=pkdvYJ0OwnlaEw0WoynTTbmuPyepTcN56JVOySf3jlH1vEAM6o8ot2tcv4gKX+fwfr
         KptJ8Yuo39xoCV/UXqsv++6qYYB9Y23wC/JpsR42l6nXHQyISWMTGHz08o7WIK1K0Zcx
         eDiId5d5m/FY6pU4qIINLfniVjr+Iid/M169y3gJxamcvGVQtNQOirM2DhjXKtyele3O
         BZt6gjg/iwqa/8pNkHOon795rARK93m/24uNkRfbT+Gn+6cfLzmvLV9PTNzvpbzDdDjA
         SGEtBWSkj6C7315T0dkTROBhhgQTHIFgM0CKt5UzA63vWUTE8KFFW3Isy4Kng6caTSBx
         Xw3Q==
X-Gm-Message-State: AOAM530Um6361fnxYGLFciyVeq2GLDEdVda5QYLrjseEXVU8KZuTRAgD
	B4Ra8aJ8SaxuL0pDA4tCfIM5ip3bcW2rKNxU
X-Google-Smtp-Source: ABdhPJy1Ifh4wuGfiJ+hHbuoRYlLNuJHr3QkUdXiopMZdPhDAlNiu9xTV47aZBnBM7yzLkJ4FgPUSg==
X-Received: by 2002:a17:90a:4890:b0:1bf:654e:e1a0 with SMTP id b16-20020a17090a489000b001bf654ee1a0mr2146252pjh.113.1649726077227;
        Mon, 11 Apr 2022 18:14:37 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id qe15-20020a17090b4f8f00b001c6f4991cd4sm648805pjb.45.2022.04.11.18.14.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 18:14:36 -0700 (PDT)
Message-ID: <6254d27c.1c69fb81.c5bd7.28d8@mx.google.com>
Date: Mon, 11 Apr 2022 18:14:36 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-2498-g49524d978f8eb
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 7 runs, 5 regressions (v4.4-st5-2498-g49524d978f8eb) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test ltp-ipc: 7 runs, 5 regressions (v4.4-st5-249=
8-g49524d978f8eb)

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
nux-test/kernel/v4.4-st5-2498-g49524d978f8eb/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-2498-g49524d978f8eb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      49524d978f8eb9de24ce93fcca8d5a39522876c3

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  163cca9acb71d06492836a667a53554ceec37639 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c612bddcf98c18ae0696

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6254c612bddcf98c18ae06=
97
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254ce182982e6bc4eae06e4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6254ce182982e6bc4eae06=
e5
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-cx9400-volteer       | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c4a411e16fe7d7ae067c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6254c4a411e16fe7d7ae06=
7d
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254ccfecc7dc6456bae069a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6254ccfecc7dc6456bae06=
9b
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6254c7fb7d1f1b6cd6ae0689

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-2498-g49524d978f8eb/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-ipc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220401.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6254c7fb7d1f1b6cd6ae06=
8a
        new failure (last pass: v5.10.106-cip4-69-g05f5682c2c593) =

 =20

