Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DF7C38147
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 22:25:36 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web11.31290.1674080734644659340
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 14:25:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Mv9d3P21;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id a184so69174pfa.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 14:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wDLh6wViecWE6x31GBM7iun6AkIAPkPPVW1PGbdDTPM=;
        b=Mv9d3P21T0fK6XimxYG1ehMfU5o/m/W0y/UgHtwmprkRrCjkYOM2f22Y/YQ1Gmi4i7
         iT+7rEan4imYCrmD4IZWN5160g9I+TpoW+H/QGYpFH0Pa4bD9RcFZ+wHdK1bMAhmj8+J
         FK8dWmgxhMs8WG0C31vdLAuy/x71C7/Qdjx2HZxP3MhlucfD/UcndFKxPLykzfGooN4Z
         vf820WZfIt27H4P8U7QPYWSCZfdGgj+hPZb/z/iJRGw84Edj5av18SwX9OkuJ81UMeew
         HY/Ocan1sPm8F2WfA4aJhMK8xPRoZ6MJlyNbkL360SfB9I/Fx7avfMMpmecHxITKx7pn
         eujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDLh6wViecWE6x31GBM7iun6AkIAPkPPVW1PGbdDTPM=;
        b=mnv9e85wmiXJZDqGRCLketLS1Fk5dpOLRld69SkInlsoRSzioY8v+Y3w6kb8RUszwr
         62Kxf2WtIgIVyAxnxTqMjD5rpFSatSZ2qNCXXBuOcSu5o44aaDQr7bEDw3AZxGc41zpx
         mP/Qgcrtx+SV7/31k+aWFY/M4mX35j+EgRaljNlWA2PuwsUm1HgrYFc/nX8ySDFbUYop
         teSkHWRSKnFMoPETvp9RpdFqlE5DJqvyFA/Z0eiIWBJ9yCVxo+7jTERF+WZ1lywjcdya
         MYC6o8zi8zOvJslxPG7ufoaYYrj2lrZ+n/Qezxe22hG/3M2Vh5v0Xg/qLnZHcYwVezJ7
         EqtQ==
X-Gm-Message-State: AFqh2koz0XPm1iA3K+8XIACHVkks1dKk9e/Md1IycPixalc7IaZeX1YJ
	mcESKX28rEs4RlELIxpR/wwwVMlfvqrf5KGYpBA=
X-Google-Smtp-Source: AMrXdXvLbCiedI6Vo88jODpLxw4WYuWqoniOCXqjx4xlp8qV+Tk5XZQIT+hviUFUFhLDSM2zNDCLoA==
X-Received: by 2002:a05:6a00:4c0b:b0:58d:8d8f:cc3d with SMTP id ea11-20020a056a004c0b00b0058d8d8fcc3dmr9843469pfb.23.1674080733937;
        Wed, 18 Jan 2023 14:25:33 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i15-20020aa796ef000000b0058d9623e7f1sm7093884pfq.73.2023.01.18.14.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 14:25:33 -0800 (PST)
Message-ID: <63c871dd.a70a0220.8810e.bae5@mx.google.com>
Date: Wed, 18 Jan 2023 14:25:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Kernel: v4.19.269-cip88-rt28
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip-rt ltp-timers: 5 runs,
 2 regressions (v4.19.269-cip88-rt28)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 22:25:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10411

cip/linux-4.19.y-cip-rt ltp-timers: 5 runs, 2 regressions (v4.19.269-cip88-=
rt28)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.269-cip88-rt28/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.269-cip88-rt28
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2b470889b91ffbff27aafaf122ef1ff24fa4e82c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cf59c1fb5f7181453b16171d75654ee9a1216dde =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/63c85e6c641d562a2d915ecb

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
269-cip88-rt28/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c85e6c641=
d562a2d915ed0
        failing since 63 days (last pass: v4.19.245-cip74-rt25, first fail:=
 v4.19.265-cip85-rt27) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c85e6c641=
d562a2d915ed0
        failing since 63 days (last pass: v4.19.245-cip74-rt25, first fail:=
 v4.19.265-cip85-rt27) =

 =20

