Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DF0C001DF
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 18:39:30 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.62368.1697827160835184940
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 20 Oct 2023 11:39:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=UUyXQ6De;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-68fb85afef4so1135971b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 20 Oct 2023 11:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697827159; x=1698431959; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=du11uts9OHDwaLIAt14I5XAW0SX/W3zO/TDv3vuy5TA=;
        b=UUyXQ6DeoeczFwDDKZkB/dBuAnElGu7A5JdhJkKA+NLuVzZcKzwenXgnrwOiiw47UJ
         crLgboa4tUfyYETm8CIEfFi3c8fc0nHij6qviQUj6IUVamu0jQuC7sT9tjExvvtn/ehS
         PFZo52ky/t3wCuA+7J1Rt2ypHFC6hj+/8wJ9yV4/fuUyyblHNPmV20r1otBrxZWX1s/x
         td6Ah2FV8vboQ49mV9ITSPH78Do1X+uOf7KQHLAJ49nFCTifNCzxfxbsMslWfmseWOCn
         4CFvawGcWkvNmUQaeXj0Qv/J6zIzw70mGWRdBic/6sxKmPH2npjewMcWW9pDfWJZASOW
         fWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697827159; x=1698431959;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=du11uts9OHDwaLIAt14I5XAW0SX/W3zO/TDv3vuy5TA=;
        b=lr6ZVHKtxbVLLbkkxHaMRyQJ6jEoarD0FzluZ8oFfdLbO6pO+8n08W+Y71vaklZ5ua
         CdY+f8Xhy4IHlFzb2XhaYx5H/Jqp6MHtvXwDY+sQKfa9ijnA5gBABH0c5oBf+FlQtHzx
         Fc9QyoPIVnXqb7S5sfCnmAXJr6kfByIwba7F16QPbcbaL6icA6YRxMn+Rmo1x1miY5iC
         dFhDwdXT54+zFPWT3GgqSA3CVuiP1tXfymW2PaKlx2t1Zj9+OoC0JewOpTzyZyu0wYcd
         +Fk9jkxgHTlEBReQneNHQBuFs0FuhDIo5SHvIGT6qBSASoKuoejZ8LOlpNwSioRzvKwn
         xhOg==
X-Gm-Message-State: AOJu0Yzj4MTqd7WEOlZQGFkEjZNOVt3e7Qpb3K1TH1/8jZ33JKpSYB0w
	hlH6qkod4Pbt7jSsict7uWQBvTOMex451z0CjvaB4Q==
X-Google-Smtp-Source: AGHT+IGKnPrvmZiCGysHNpFPIIlrnhuk/TLOnNBdQT5XYnOGcyZLmUgiVeEa9dgXbObp6LlrURc0nA==
X-Received: by 2002:a05:6a21:790b:b0:173:3ef3:236a with SMTP id bg11-20020a056a21790b00b001733ef3236amr2850377pzc.21.1697827158744;
        Fri, 20 Oct 2023 11:39:18 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h10-20020aa79f4a000000b0068c10187dc3sm1854473pfr.168.2023.10.20.11.39.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:39:10 -0700 (PDT)
Message-ID: <6532c94e.a70a0220.13cf4.7291@mx.google.com>
Date: Fri, 20 Oct 2023 11:39:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.302-cip78-rt45-338-gf468de833aa13
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs,
 3 regressions (v4.4.302-cip78-rt45-338-gf468de833aa13)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Oct 2023 18:39:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13430

cip-gitlab/ci/pavel/linux-test ltp-pty: 3 runs, 3 regressions (v4.4.302-cip=
78-rt45-338-gf468de833aa13)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip78-rt45-338-gf468de833aa13/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip78-rt45-338-gf468de833aa13
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f468de833aa13aa639d147055db4edf9931b6811

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532bc8b3a1a159708efcf2e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-pty-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6532bc8b3a1a159708efcf=
2f
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532c59b444f5caf37efcef7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6532c59b444f5caf37efce=
f8
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6532be7bc824cbe8b4efcefc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip78-rt45-338-gf468de833aa13/x86_64/x86_64_defconfig+x86-chromeb=
ook/gcc-10/lab-collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6532be7bc824cbe8b4efce=
fd
        new failure (last pass: v5.10.194-557-g2932db67f070a) =

 =20

