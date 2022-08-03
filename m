Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B936C48BE4
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 15:39:44 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web12.10375.1659541179871674420
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 08:39:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=POXZrNwV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id
 15-20020a17090a098f00b001f305b453feso2430667pjo.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=V6o1lPKwizDCWCJBnAgzmixGHEj0GNIBbjH4GrqLmaY=;
        b=POXZrNwVRl8KfRnJGEizoglmbpCtN28uCcn3lYaMknGENwMvK6Pczkk0ipqPCF6koz
         5x3X/BvJDlfcnFI0MXiAM+GFSxqIctL6ISEZkuNqnmYVmKRqkYpopkFe7RFbcayo4loA
         zxlNmS3xj+UmevjmMzRpnF7J5rHfQBUzXH25+ckg/xUIzYUeip/m+gcU+PoYwNbtXtF4
         +GqWYVR4MqcOCLEUyZxLfZeo/gZXvPk+ggEn7AYHPEh3WcDHjdrEfQWIVKIn1Dvvoqg4
         ykeOQyd9uBxvPdC49VDvMMFnUMB/+YYBkiQE+EvHOdS/ettZko93FgPjcIB+lHGjx4IJ
         8Dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=V6o1lPKwizDCWCJBnAgzmixGHEj0GNIBbjH4GrqLmaY=;
        b=lp1aQ4qLEE2ojvhCD3XRpR2rl2kK4rOCocTwoYGYR+z22LdUxxzpjr6KyWRkzKodS4
         0k9K+Mwu8R8Ql6+j7BGKKbMwSUFZpZ9xiKwH3Nqa8kMCJRYLxBaauA8gUFghs06vseNA
         Lt0lAij6pEX57i1pn+lmUzeMItWXxviMSsxES6UBoDVQP8/kLY1259Npmn+NJbEAq9SB
         GBOVYDJwSB0J2F4Hxu1ix4eL+xn3MMimHIRITSr//07jt1En0nh9cK1pJGjQBxnLYQBg
         zaPZ11uDZ9fpdVRFj5j/lzmO0auQRzB2CxC19EcCgreVoTV399/pwIGXTWv4NjW/U7mf
         tt5A==
X-Gm-Message-State: ACgBeo393zfCUHv+yyLmUJVoqggkiwt9R/I3xXVIMKsLuL0JAtmtmaYW
	UBtdVNyGT75Gdz336WNaZeoPOZzfY1jydt+/GgI=
X-Google-Smtp-Source: 
 AA6agR7r+Zce5aWgiSDAolmIFTstDlF/VMs37W7X0epL75knQ2zztWLdcbgs6s5YaLM4sOy94gY2bQ==
X-Received: by 2002:a17:902:a586:b0:16c:3182:a9b with SMTP id
 az6-20020a170902a58600b0016c31820a9bmr26609180plb.44.1659541179075;
        Wed, 03 Aug 2022 08:39:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 13-20020a17090a034d00b001f10c959aa2sm1769072pjf.42.2022.08.03.08.39.38
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 08:39:38 -0700 (PDT)
Message-ID: <62ea96ba.170a0220.3fd14.2db2@mx.google.com>
Date: Wed, 03 Aug 2022 08:39:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip70-rt40
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 6 runs,
 4 regressions (v4.4.302-cip70-rt40)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 15:39:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9061

cip-gitlab/ci/pavel/linux-test ltp-timers: 6 runs, 4 regressions (v4.4.302-=
cip70-rt40)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip70-rt40/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip70-rt40
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6b137ed6ca3666fa2abde3e184426bbb203b5bfb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea7ff20758650fd1daf07d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62ea7ff20758650fd1d=
af07e
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea80f55ff45a72b1daf063

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62ea80f55ff45a72b1d=
af064
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea80b91431f01924daf090

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62ea80b91431f01924d=
af091
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea7ff11117c59bf8daf05f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip70-rt40/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/62ea7ff11117c59bf8d=
af060
        new failure (last pass: v5.10.131-cip13-24-ga6f4ea41fe167) =

 =20

