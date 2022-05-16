X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web08.61.1652717112564680850
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 16 May 2022 09:05:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=UfS/oPAF;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id i8so931642plr.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 16 May 2022 09:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=6GDHBamyCfJcrwhudfKhzBMweFdMhTbaUBKPC9qotwM=;
        b=UfS/oPAFAWgLlSpFZ/gk9ZHaKNdN4xehClyr8miInqhf7POmJeTtMZC95uymUSCPKh
         ZKfLo12ZwcR+BRnxZS2AaLXWHC/Ay+FrU0+ca3ZG8gdhRyekVGFIYSNmB5cpwYs0XSiT
         N+7oPsBfMO8k5OaX+1p5T6z1wwrZGSdZG+mrOUVRHCVLjkqiZMGbKqfAmIPA0tjMnbu2
         LeFhMMwZgnXPbEvwLk2B3Kkrvv5qWJlRYXc5h/5YQQUWPsgWasHOGdzU1Vq8oTAfpp5y
         HfA0acpLMkDYwt08fIR2CIZBOMxh6Q6bx8wajZZjhMDIcV9ZCf0DTGI06i1QKA2Gxucp
         +kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=6GDHBamyCfJcrwhudfKhzBMweFdMhTbaUBKPC9qotwM=;
        b=kJ6HYjNZziH9QOyxEfKiWf2AsyhNKmQM59EOz8rtS/JJG6boXXa3EcjNT+F2e03bBd
         Q0/8dJuOZdgrPb/uU+WUnccm2FmiwtU+KtJujojjK0FgPkoiz7GXIlsgCm75lrIU9NEo
         RW/kp5T85U3EttLFi1TDKcYk7UD2z3xNqqwu5EQWkF5kshf6BpTHrjovxBWENBgmNbLg
         MDbqVquE/3oUaiiGfO78OIuyBbp0wF36mXo60CBa6gVjW3Cu6PPNqqPffzDT/tT/iPOq
         2bcdXvkQfVLp9jQoYB15w/kKhuDiErdErDSwSrNkTlHt3BPT9o1usEb6lwJL/VTx4ps8
         P32Q==
X-Gm-Message-State: AOAM53329RxqaNsi6eCVyaEblDLsOHCJkTUt7Rjtq+nK9h3T+BBo0rm7
	rt7gr1FjcO6YsTD0wrshLItiYm10tHlNQw76oR0=
X-Google-Smtp-Source: ABdhPJwcq/acQ7cEEPU5uKaqsYmdmKuIG+pfh3l35Ewiv7SAAhpIjU5wGbgqQTbPBofHZGtWhElrQw==
X-Received: by 2002:a17:90a:9313:b0:1df:10a1:35ef with SMTP id p19-20020a17090a931300b001df10a135efmr13551167pjo.134.1652717111742;
        Mon, 16 May 2022 09:05:11 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902a3c200b001617caa6018sm2396369plb.25.2022.05.16.09.05.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 09:05:11 -0700 (PDT)
Message-ID: <62827637.1c69fb81.4fc5f.5691@mx.google.com>
Date: Mon, 16 May 2022 09:05:11 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4-st5-208-g5e70bc68d09e
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 5 runs, 4 regressions (v4.4-st5-208-g5e70bc68d09e) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 5 runs, 4 regressions=
 (v4.4-st5-208-g5e70bc68d09e)

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
nux-test/kernel/v4.4-st5-208-g5e70bc68d09e/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-208-g5e70bc68d09e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      5e70bc68d09e77ff437512cfdec26dcf5710d90e =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62826d3385ee11d2568f5764

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220513.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62826d33=
85ee11d2568f5765
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62826a4a4c0f58ecf48f575d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220513.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62826a4a=
4c0f58ecf48f575e
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62826c985d3124efef8f5720

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-filesystems-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220513.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62826c98=
5d3124efef8f5721
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62826e1d6fd768b1168f5769

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-filesystems-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-208-g5e70bc68d09e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-filesystems-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220513.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/62826e1d=
6fd768b1168f576a
        failing since 5 days (last pass: v5.10.109-cip5-384-g722204542e8a, =
first fail: v4.4-st5-23-gf7cf04ab668f1) =

 =20

