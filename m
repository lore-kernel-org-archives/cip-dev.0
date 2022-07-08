Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D43C43334
	for <webhook@archiver.kernel.org>; Fri,  8 Jul 2022 16:46:20 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web11.1413.1657298771224282471
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 09:46:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=VA0/Qpii;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id s21so13952018pjq.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Jul 2022 09:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=/7LlKi8FOSGnBYzZiFgtsLFZdbjSszFA+z2OPZ+A0OM=;
        b=VA0/QpiiF024c2qZPcYVnCHct/6swSUsV8idLwr4kkiA3NP84MKxyZGFzk54fCeD4I
         Ik13bOpJdsH+6o1X4ewTj6Q91JTVdBnVFDss32fu9Y9MoMgIEdsfPMkZBMAnqpkLnZ/x
         Zj9/fMZege0Emvnejk/E3Z2sF2X9R0lQXI5lC51L9yDRIWQhEdLvmU9NkfmNdotSzGpa
         WwRX9yYDU0hf1wyod228XVzx+2duvrVWwK6DVEROKyN0q4+wTYWf3a0s6UVspuYRp6gx
         3FEEDQtNM1ID7vZ902FE3OXNlg/TG6q5mIIpjinlWj50g62mMEvgIkp2PI1waE3qzi62
         H/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=/7LlKi8FOSGnBYzZiFgtsLFZdbjSszFA+z2OPZ+A0OM=;
        b=A5BDlBIPleyDoeN2F/G9vWljcqgDwhZ7aceENSjUpNAHNG6gUKni2dAxGvQL9QkR0X
         aUg5aTQC2ET7SS9rrLQ3icNBQ8MnaNHfoA2vtrrdDiUNmwIQCo78nBc202jO9bxqwsgL
         A39uoXE27keMBloX6Q40n2vxVkksdeiutPW+HFpHdydWelqn/rrfHfjV/nxLP6RXeuoa
         gud+9hCvwYYfaAAgZ4C0XXSY2Jb0Auj5FKi6UcVA2JsRmUnLOCKSvTpbkc8h5f7lcCy2
         N8Ol8jzfQ6RBNRLwp44yPwSvO/bMcatnFZpOY4MUQhILsHh5SiG88Vrqek+75epJpW+d
         1d3Q==
X-Gm-Message-State: AJIora+Z+01fMlEVLgetZtTxKXpvm6Y2MfKxSdpsH7huyOCSae5tx3An
	bKtnu9eqcl/zBwHVZRYq0Q5KwfOPEblBr+gt
X-Google-Smtp-Source: 
 AGRyM1tmYKbzDXBL49Pib98o2htnCtxxqSyuGJKIKm0bFqTQz2kf2gr5xouMinWbEBFAOc3k8xkiTA==
X-Received: by 2002:a17:90b:240e:b0:1e0:775b:f8fc with SMTP id
 nr14-20020a17090b240e00b001e0775bf8fcmr817984pjb.132.1657298770439;
        Fri, 08 Jul 2022 09:46:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 j3-20020a655583000000b003fd1deccd4dsm1343550pgs.59.2022.07.08.09.46.09
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:46:10 -0700 (PDT)
Message-ID: <62c85f52.1c69fb81.87c24.1e68@mx.google.com>
Date: Fri, 08 Jul 2022 09:46:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.249-cip76-57-gef3cc1b9e556
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc smc: 11 runs,
 2 regressions (v4.19.249-cip76-57-gef3cc1b9e556)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Jul 2022 16:46:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8725

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc smc: 11 runs, 2 regressions (v4.=
19.249-cip76-57-gef3cc1b9e556)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.249-cip76-57-gef3cc1b9e556/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.249-cip76-57-gef3cc1b9e556
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ef3cc1b9e55646468f12d0c0a8caf8874a9e7156 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/62c5807fcc71d7cec0a39be0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-57-gef3cc1b9e556/arm64/defconfig/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-57-gef3cc1b9e556/arm64/defconfig/gcc-10/lab-br=
oonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62c5807fcc71d7cec0a39be1
        failing since 30 days (last pass: v4.19.239-cip72-68-g407458469172,=
 first fail: v4.19.245-cip74-32-g2d021d7a9e637) =

 =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c59252d7c7254ecba39be8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-57-gef3cc1b9e556/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.249-cip76-57-gef3cc1b9e556/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62c59252d7c7254ecba39be9
        failing since 30 days (last pass: v4.19.239-cip72-68-g407458469172,=
 first fail: v4.19.245-cip74-32-g2d021d7a9e637) =

 =20

