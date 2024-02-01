Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427A0C4828F
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 15:05:32 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.17692.1706799923012482662
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 01 Feb 2024 07:05:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=JZ4EWUU1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6dfebe2ed0bso395321b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 01 Feb 2024 07:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706799922; x=1707404722; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5PXFIG1SckmAHjpUyGqECrawsusAP350nMVmczslmC0=;
        b=JZ4EWUU1Mw4TDZtwkH4QcU3FqrU9mIj9tm/lcOCY7R9GltZo1CTIfGy13X5eYgbGZM
         Zqw5oTG/lxhj7r2ldnbd3wOvIPgoNx456Ai2/24QEfiy38gEirW8XgAjpB97qZZA4b4C
         ZG1/p5/IPrppNc+PmlMZmIgRE+blzahGBgBU1+/fORLcSl/E+9KCP1xFw+eb7inqc35I
         d1BjaiaAfsZte72qGSNRceWqnk3K8Kiq17tfBZVVk9LJNulDvO/q9xg05epsTJivf3yO
         1ms23FFnXmiPZTKK1aim3LIa9rSxpG520xZzRbFgle85n9OtFkERJcRnIrTFDUTE8gnE
         sAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706799922; x=1707404722;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PXFIG1SckmAHjpUyGqECrawsusAP350nMVmczslmC0=;
        b=dqZ/Xyf1xLLXVw3OB1AAwXRvkhn02BkbJBkI9qSOmvp+SQrJIT1vl5BpE7nVbxtHPE
         LYBY0rLQz7wLpOVeDMZvULCEzSoCYAXp1bpMKpkXAO+aPjmz13nZXL2+o/6mJr+xyCui
         aUPT4Mmm+22dGZIHXi5GEg8wfYchLoCAuYoN/j/K1P2vyht5zxr9RLyCXubzwwywToKY
         cQMhSaMEChYreuAwvXxT37ognTTDwdY3/YopAJ9he7fYXdz+gaVgQSj5QRhiwScemlTm
         i/EfOGwhFMzvSYWPa0KXQzYCt/pN1yQ08h3UFbQFVkW3pedyvJgBu107tfC8Cxd+lIu1
         Vafw==
X-Gm-Message-State: AOJu0YzZLdoLqvV7ttL4xcLd88NroBxMC62w3geE1DtvAvqG6ZFp2j+w
	XF5i5rS5ccmFUKHLn2Z9BkD4Yp15ZSZ3G9fjIGzibhVteArR0X4Wfv+HqD1oE7lhcQ2GV+fqh+A
	b
X-Google-Smtp-Source: AGHT+IFxMGdxnpQbINL7VDjAqgwxta9HHuF9M24V8aJKFZ+M4T17NFBKRLTmNiThNdj0KebDpfeBaw==
X-Received: by 2002:a05:6a00:810:b0:6dd:a32c:d7ef with SMTP id m16-20020a056a00081000b006dda32cd7efmr9736397pfk.8.1706799921842;
        Thu, 01 Feb 2024 07:05:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVCwqQQnnDISXv95hPJ/r4HsMMYtDBwbXUeHvSpaiijdmHnh6vH2Zneh72giNATXis1alJr8SMDSZ+h+buQ+44cOgmzF2znn/zTD4aiA6Wr60kcBHDhDmI9axBCZmDEosEp/mnHfunlSxCyaX1gQR9KOg==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t42-20020a056a0013aa00b006dde0724247sm12309212pfg.149.2024.02.01.07.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:05:20 -0800 (PST)
Message-ID: <65bbb330.050a0220.abb2c.7d5b@mx.google.com>
Date: Thu, 01 Feb 2024 07:05:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.72-cip13-31-g9539320ac89dc
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip ltp-timers: 15 runs,
 4 regressions (v6.1.72-cip13-31-g9539320ac89dc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 15:05:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14585

cip/linux-6.1.y-cip ltp-timers: 15 runs, 4 regressions (v6.1.72-cip13-31-g9=
539320ac89dc)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =

mt8173-elm-hana          | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook | 1          =

qemu_smp8_riscv64        | riscv  | lab-broonie   | gcc-10   | defconfig   =
               | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.72-cip13-31-g9539320ac89dc/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.72-cip13-31-g9539320ac89dc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9539320ac89dc2caf6bf646eca56ac33ae7c615b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65bbaa5e75c7c89f0100a047

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-31-g9539320ac89dc/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabor=
a/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-31-g9539320ac89dc/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabor=
a/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65bbaa5e75c7c89f010=
0a048
        new failure (last pass: v6.1.67-cip12) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
mt8173-elm-hana          | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65bbaafef73d46c22c00a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-31-g9539320ac89dc/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/ltp-timers-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-31-g9539320ac89dc/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/ltp-timers-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65bbaafef73d46c22c0=
0a03a
        new failure (last pass: v6.1.72-cip13-30-g79e2886a5da69) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
qemu_smp8_riscv64        | riscv  | lab-broonie   | gcc-10   | defconfig   =
               | 2          =


  Details:     https://kernelci.org/test/plan/id/65bba4a7851b1e092500a424

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-31-g9539320ac89dc/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_sm=
p8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-31-g9539320ac89dc/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_sm=
p8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65bba4a7851=
b1e092500a429
        failing since 38 days (last pass: v6.1.66-cip11-1-g2d3d776d703d7, f=
irst fail: v6.1.67-cip12) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65bba4a7851=
b1e092500a429
        failing since 38 days (last pass: v6.1.66-cip11-1-g2d3d776d703d7, f=
irst fail: v6.1.67-cip12) =

 =20

