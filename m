Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46450C7EE20
	for <webhook@archiver.kernel.org>; Thu, 20 Apr 2023 20:26:26 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.2082.1682022385551712677
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Apr 2023 13:26:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=5QSy5DbI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-63b60366047so1283366b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Apr 2023 13:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682022385; x=1684614385;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vg+vpSQ9HHE8YAMKZtq5ITeQLZ6x4ah7IhWENR61AG4=;
        b=5QSy5DbIYcCvsqg666stdeXKYLtiDiKH/mrvVTHZcdjyPdPWzpgOGh29FWOQSCIMyg
         gCQtznOEuH1ZcSt2/cqVA5AQRkWTpHi88X7nR/iz8eqONiuqYnyAYEe94yofNi8jb3/J
         9yoUSodnld274i8ip37uMITd5zQu+PmUhKcFkItuFblqGMhm339q9In3YSe+rkzjHGgB
         Ivujfk0Hlo8pcFLKXmKADF86LKE52GXe6wCcVAQNFGxwOJie4tPyYH3qlfsJlDU6ds2V
         5u6rs5hsFAM9FDtFFfHu99c84uLascjbThqIM3iGjW9vNVcoPv3aw9EFPgCsDOgM/Rve
         +mkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682022385; x=1684614385;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vg+vpSQ9HHE8YAMKZtq5ITeQLZ6x4ah7IhWENR61AG4=;
        b=A/z9kTQ32uYrcKbZ8vPpf0092gWos+4isvR2UkGOy8AT+0g4g8doeYa0MihePdrWuv
         c2xQMoTaqcMulOu4DKLxYC8pJ/OieYK7L0L3PT2MwdYrRsQehR17VPITHToF4rJ7fmdg
         fJuEMU9yyWaMiugl1FT9n+dAp7hLmgl7De7lrStWNYuck0jvREaOgTBP1Ht58nqCmgeT
         rto1sb6KvSGR38nS9SPTJdn/vJY7lu032GSYoIFighPDXGHrwr5TXLonFUVWvgp3pi9m
         fmKDQpCdr2YwBj0pt0zJTLD0IHHSoZrnD8K9/wx8tqgJrbs8VBKuAiJFv+33JSvQp72T
         zjZg==
X-Gm-Message-State: AAQBX9etkzCPzgH9az5ZjWqc8gei/+Zceb/6S0iPjkgci9/sP0doDlCC
	WREXE37AaqmoDndfG503w/0l/fq69uP2xVfA1xbiFO0e
X-Google-Smtp-Source: AKy350atDAYyKPJeVvxPnVcCYWy2yyIskXTfSqoWf7Lmqw7syifBe2rmNhNWgm2TKT6B5XmiKPHrSA==
X-Received: by 2002:a05:6a00:810:b0:63d:2990:deb with SMTP id m16-20020a056a00081000b0063d29900debmr2825632pfk.30.1682022384848;
        Thu, 20 Apr 2023 13:26:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o15-20020a655bcf000000b0050bc4ca9024sm1421843pgr.65.2023.04.20.13.26.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:26:24 -0700 (PDT)
Message-ID: <64419ff0.650a0220.a0a8b.3349@mx.google.com>
Date: Thu, 20 Apr 2023 13:26:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.4-st20-1100-ga8cadce4b9649
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 5 runs,
 3 regressions (v4.4-st20-1100-ga8cadce4b9649)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Apr 2023 20:26:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11271

cip-gitlab/ci/pavel/linux-test ltp-timers: 5 runs, 3 regressions (v4.4-st20=
-1100-ga8cadce4b9649)

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


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st20-1100-ga8cadce4b9649/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st20-1100-ga8cadce4b9649
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a8cadce4b9649177791a9adf0eef53ef0c90de78

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  458f3554675aace42e9750086d26799e82829f11 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644192f7e8a16d0edd2e8630

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/644192f7e8a16d0edd2=
e8631
        failing since 29 days (last pass: v4.19.277-cip94-1098-g26d9f86d942=
d, first fail: v5.10.175-cip29-rt12) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644194ad37483b64472e85eb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/644194ad37483b64472=
e85ec
        failing since 29 days (last pass: v5.10.168-cip27-456-g42a59c4e5329=
, first fail: v4.19.277-cip94-1098-g26d9f86d942d) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644194bd7b08c3c21d2e85f6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st20-1100-ga8cadce4b9649/x86_64/x86_64_defconfig+x86-chromebook/gcc-1=
0/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/644194bd7b08c3c21d2=
e85f7
        failing since 16 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v4.4.302-cip74-rt43) =

 =20

