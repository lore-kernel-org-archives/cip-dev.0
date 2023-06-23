Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68311C001B0
	for <webhook@archiver.kernel.org>; Fri, 23 Jun 2023 13:13:55 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web11.41727.1687526032174172069
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Jun 2023 06:13:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ixijsiFo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-54f85f8b961so549922a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Jun 2023 06:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687526031; x=1690118031;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/YPRTcVfhEBC64Q12vDd0ZZYqxvEHYh8mi20lnSSTFo=;
        b=ixijsiFoMbdW6gESFR1E+Tp7q4FG6e33/m1Bl94SM1lebveA2DolY7PVSi3aa8d1Zi
         jMzoPS/Z1CdYTQofqc8PdTOccn1WoHB4d/29BphuTa3MQnFUiMFOwqLYKmsQkcu4H8ER
         +7WaZPihqp3oL4Xb3POkJmvvdjciffyqxmyR6/Dk6XHlPeWNCxI9JLVajN8cZJnBxdFB
         NNtTuXMT4p0zugnSGyfH72nEEwkG/72ql1aDlnmtY45sIHLDCpSs2XrA4Ft28c65I+bC
         nw04roiTOaZUuS2/ZsjceVKlw452Y9DQGZdRpQAZG034Yjhtb2dbfE4B4NVj96FJF60n
         u4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687526031; x=1690118031;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YPRTcVfhEBC64Q12vDd0ZZYqxvEHYh8mi20lnSSTFo=;
        b=jSbN/DryVuTJ+Wc3b6CyhuemBpGren2VSkC1l37l62gBJm0ygcLAvS+UXyKbNDzc3n
         g2wPQ/SXxef81vTWGh1y2EwZMPeCX+ECLtMTHk79eNk6BhukFGZNgYyO2Fdh4AxQCtc4
         FHSOIhaPR9mwVQaW9noy4SPLih01caLoylnLyT++Fg9ItVUW9qnK9s6VESWxU1Dl8ZTz
         qj0gyLo1tifAZX2iSGCWOG3kYBv4ulDtMPD2oHoZiqeDuNGdmWjF3/6++REv91AA2OI9
         aY5z92iFgOVMuS4zTEsiUktYggxWs279fqqMg08uuFnB9B5SxLZ/qcviqS5StVg/gFks
         2Y7Q==
X-Gm-Message-State: AC+VfDxTUqO8o4x95EHi7nZ7ErJ3VO0iBXWzG9uoyufhgCUo8ZWI63CZ
	4Cv+sD9Xv+oLFtYJUEMgezCdqH+OkCPuSLkLzLhO+g==
X-Google-Smtp-Source: ACHHUZ6x9CHoCvbF01pX9NzxIpI1AZLG+6V8HNtCFlAL0R8LYMGbwEZHO6jNBQdj2txOOZMZbOEH9w==
X-Received: by 2002:a17:902:9f97:b0:1b0:637e:e25a with SMTP id g23-20020a1709029f9700b001b0637ee25amr20218935plq.67.1687526031070;
        Fri, 23 Jun 2023 06:13:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902ec8900b001aaf370b1c7sm7131007plg.278.2023.06.23.06.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 06:13:50 -0700 (PDT)
Message-ID: <64959a8e.170a0220.f90c6.f83a@mx.google.com>
Date: Fri, 23 Jun 2023 06:13:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.287-cip100
Subject: cip/linux-4.19.y-cip kselftest-seccomp: 3 runs,
 1 regressions (v4.19.287-cip100)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Jun 2023 13:13:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12139

cip/linux-4.19.y-cip kselftest-seccomp: 3 runs, 1 regressions (v4.19.287-ci=
p100)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig               =
     | regressions
-----------------+------+-------------+----------+-------------------------=
-----+------------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig+kself=
test | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.287-cip100/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.287-cip100
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      843423b3724d762d5593ab9aaeb68ac695871b44 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig               =
     | regressions
-----------------+------+-------------+----------+-------------------------=
-----+------------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig+kself=
test | 1          =


  Details:     https://kernelci.org/test/plan/id/649589b16111ce74e6306197

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm/multi_v7_defconfig+kselftest/gcc-10/lab-broonie/kselftest-secco=
mp-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm/multi_v7_defconfig+kselftest/gcc-10/lab-broonie/kselftest-secco=
mp-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/armhf/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/649589b16111=
ce74e6306198
        new failure (last pass: v4.19.284-cip99) =

 =20

