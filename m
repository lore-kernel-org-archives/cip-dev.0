Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C349BC4332F
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 13:28:37 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web09.10666.1664890109881364182
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Oct 2022 06:28:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=JGgTzwUT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id v186so13137602pfv.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Oct 2022 06:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=wIQ9AO0YZby3mZNx3s2VdIOnlt480Xlrc/5IZ6jB3Yk=;
        b=JGgTzwUTv2riV9DPns5N6LZ82+OK/FVOQt4T247pDkzrHK7Fbi3rcH00/Ipmm8gmj5
         RLLWOvJwpyk4YtXyiYSYVyzvd2LiWqmG55+96aVaKLxqp1KcjLajRLKVQe2l8owezilr
         AkbkS0hN1NA8Fh9a62agM1beX1VkW3AZb9HHsPvn3hOR88oG7tylD3V4HvGJQ66bzdAd
         DfimpDdldxjOgptEqVy4I19Cfz+QwPkdpvCy8RRN1CHoOQQqCdNLMGaBR9YXZj69GYNA
         F7GSHWakLG4xfbBNwvIyRc5ided5OexO8Q0VAZl+eHGo3JxkU8lm1UHDGRjy2nleDf9s
         QN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=wIQ9AO0YZby3mZNx3s2VdIOnlt480Xlrc/5IZ6jB3Yk=;
        b=8RV6A+v2nwEotYd2nSPPR9u1XoJTw1KQ2HXbs6XARjIWkgCvoeW8jAbCY4N9vveVQe
         f+pxWSv87GPdZVozc5t9NX1yinJF4sklAi55Mv/qWamh5/6hcK9WGOJAOgti4CGj1yr+
         VgeuWHWExeT1EatW7yo6wJmFXWP5FQcVMMts2/vfmU1O2DIBScJ/IqLWcXfikqofHF79
         kD3wDu9WqhmDoP8ODQa2Gc4PO0MdPinrhE9W+As/hKli6Dm1mejzV5kree6SLCm9Un6z
         H7VqadnVq5LhjLbrTr3gIiOnKzhlzZMuO/REJU65eAHP0QatDkabfkdl3nAMQj5oKNzS
         gIHQ==
X-Gm-Message-State: ACrzQf2CR51oKyT04NIqTkQf1pIiR3OtO05c73TBluKT4GPUzZCAOTfA
	eNPeownw1qv73xQUr2zyDlxIsPmxn4eU5H9Lb74=
X-Google-Smtp-Source: 
 AMsMyM5Nu367/QjoAC2WTgOTRa2f7lSsl+TVjELY0Dr1lc/VOmirI/Fhs923Rlvq1dqcKPkhYb0F6g==
X-Received: by 2002:a65:6d8d:0:b0:43c:bc41:735 with SMTP id
 bc13-20020a656d8d000000b0043cbc410735mr22709348pgb.529.1664890108997;
        Tue, 04 Oct 2022 06:28:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 n10-20020a170903404a00b00172a670607asm8826232pla.300.2022.10.04.06.28.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:28:28 -0700 (PDT)
Message-ID: <633c34fc.170a0220.66a8.f204@mx.google.com>
Date: Tue, 04 Oct 2022 06:28:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.145-cip17-421-g0d804ef4a611
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 15 runs,
 1 regressions (v5.10.145-cip17-421-g0d804ef4a611)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Oct 2022 13:28:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9622

cip-gitlab/ci/pavel/linux-test baseline-nfs: 15 runs, 1 regressions (v5.10.=
145-cip17-421-g0d804ef4a611)

Regressions Summary
-------------------

platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-cip17-421-g0d804ef4a611/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-cip17-421-g0d804ef4a611
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      0d804ef4a611ef583ad77ab7fa646c19f24f99e5 =



Test Regressions
---------------- =



platform      | arch | lab         | compiler | defconfig          | regres=
sions
--------------+------+-------------+----------+--------------------+-------=
-----
at91sam9g20ek | arm  | lab-broonie | gcc-10   | multi_v5_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/633c2912111d309c8dcab608

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-421-g0d804ef4a611/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-421-g0d804ef4a611/arm/multi_v5_defconfig/gcc-10/lab-brooni=
e/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/633c2912111d309c8=
dcab609
        failing since 4 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e,=
 first fail: v5.10.145-cip17-422-g411cd76b5afe8) =

 =20

