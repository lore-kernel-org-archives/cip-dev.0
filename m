Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262C8C54E41
	for <webhook@archiver.kernel.org>; Thu, 29 Feb 2024 09:57:02 +0000 (UTC)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
 by mx.groups.io with SMTP id smtpd.web10.21178.1709200618716591960
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 29 Feb 2024 01:56:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=hwpK0vrN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.160.50, mailfrom: bot@kernelci.org)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21e6be74db4so304045fac.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 29 Feb 2024 01:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709200617; x=1709805417; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p/429+Z2vLPu/MunRmx+tRWKAa5LLckrg4n2FAebLeg=;
        b=hwpK0vrNEZWEfi+mBOAors2Zx7L03UuIFT5Qqh+PannCPWeJG0oM6f6gUORmM0ggHL
         XuAj4T00FE1PwtqUJFHbbkNQg3yHCuxYC72uevyFeLDQcevxN9kwNMRoB2L8qJNNPMeQ
         leQUt45Pb8rxh6GcqKppmt2TxSJgIzgUH+P/zKaMXmAp4wYInZfWCgxPZLjl2KMvmnU5
         ORcdf8RAMYjDwwBuPOyJE4ZpSfn5b2/Q6V44o2nElQlEVXfyBMs++bFpp9aUvcylNS5t
         YHiBX/cnMgr8zxzMBXelAdOY+B7Hv6x1z8XbjjnRL2y53IXquxxbSl5HB/ITtgfhlb1h
         Kfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709200617; x=1709805417;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/429+Z2vLPu/MunRmx+tRWKAa5LLckrg4n2FAebLeg=;
        b=nNblERvxlFUPeaFJOE7CAW7WoY+7Ao/uSdf2YjBFOhETVpJG5+R18vtqdR1IlMwX7f
         jLMwD4OyDd7R+3OuDOrzE69Svv6zqt6ZLyo5JBcodQ3aAL78FZFlagaznF6eke3IQi1c
         M8ob9odATG+W51+ywooZbzedBCBA/q9w4UUNQ2y40A9RnfuX7Cl35AfKC7tHK+gSGeic
         76m+BehAaiuybEjVCbT5NQ9TQaEHoN/nve0QwtMhRmj1WMFZZKGJeiAm76eT8jV/ugt0
         bsN78wxdYx3Ea0SRumBSjM1RMfPMbeMoupcSJePEjDyCBT/bMGkW7BTzbYmdWlHR2MJc
         z/fQ==
X-Gm-Message-State: AOJu0Yx162KfkXC665q9r6ROE0OZ1bTh6lKV4VQGQRPBt8dNtyawcpXf
	sPP0EMjz6bjHXpmHlZizdSHV6lWZtJnfpr0+NnRBu3Mc25NMTOZPWq63WeIMCJnKndAzpf/GjC1
	I2p8=
X-Google-Smtp-Source: AGHT+IFDP8JCBmr9dr21mZIcEd2Bal/DafEvrfO2KsnI6q/c0YMSfEq3/wXABBe46Eel7K1zJnpHqg==
X-Received: by 2002:a05:6870:d1d1:b0:21f:412a:87a8 with SMTP id b17-20020a056870d1d100b0021f412a87a8mr1338241oac.41.1709200617068;
        Thu, 29 Feb 2024 01:56:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id ka15-20020a056a00938f00b006e4d545519dsm895372pfb.62.2024.02.29.01.56.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:56:53 -0800 (PST)
Message-ID: <65e054e5.050a0220.ad1a8.2549@mx.google.com>
Date: Thu, 29 Feb 2024 01:56:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-56-g55117716ac0fd
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 9 runs,
 3 regressions (v5.10.209-cip44-56-g55117716ac0fd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Feb 2024 09:57:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15110

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 9 runs, 3 regressions (=
v5.10.209-cip44-56-g55117716ac0fd)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =

qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig   =
               | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
               | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-56-g55117716ac0fd/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-56-g55117716ac0fd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      55117716ac0fd541adb5a35e66eb21c45107b040 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e04540ed8b61b8cb637050

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/x86_64/x86_64_defconfig+x86-=
board/gcc-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/x86_64/x86_64_defconfig+x86-=
board/gcc-10/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-pty.login: https://kernelci.org/test/case/id/65e04540ed8b61b8cb6370=
51
        new failure (last pass: v5.10.209-cip44-424-g38943e302f8c8) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig   =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/65e03f702a5a3c4e1e637076

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-pty-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-pty-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



  * ltp-pty.login: https://kernelci.org/test/case/id/65e03f702a5a3c4e1e6370=
77
        failing since 5 days (last pass: v5.10.205-905-gb40421b142370, firs=
t fail: v5.10.209-cip44-424-g38943e302f8c8) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/65e04552ed8b61b8cb637098

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-pty.login: https://kernelci.org/test/case/id/65e04552ed8b61b8cb6370=
99
        failing since 70 days (last pass: v5.10.201-cip41-69-g8f7b450fc28ed=
, first fail: v5.10.201-cip41-540-g3640150b3b169) =

 =20

