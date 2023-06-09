Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEE2C7EE2E
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 12:40:38 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web11.12323.1686314432044741518
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Jun 2023 05:40:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=RnPO9MXT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6513e7e5d44so1410977b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Jun 2023 05:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686314431; x=1688906431;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2HGjGpIxuHX+AmQ3rHHN/7m3RnWFcRAGEACiibuKjL8=;
        b=RnPO9MXTRCkYbC7cgTaxLNTIVtLr+A3VukLUm46FRUm5tKAH7QtQS4NTT3nF/jqM9x
         OL4kedpScq6RiKj17Rx8VWuBEH7MAWQHIwjf4hlTKb+ZdAGtRjEdINAFAQVrAMgw/iq8
         GU6LoN+fEgOknO9BFHb3lQ/P8V/7BgVHEnLtqrQHVjhMMe75nS6zEgsxbyOox81Rzvm8
         QijyYuK3b15zIkZ/MrEYY7+Oo+eDyyBng6RT5nxG1XgjAp/xzWNRjGYGF7ikkn+2hO2V
         BN0nJTkaDyTridg/4ZTR+Tfum0/h/Wex8JoZ97Wa22rPIC+iMaDW+CzZxliWYpmK76Ns
         niHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686314431; x=1688906431;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2HGjGpIxuHX+AmQ3rHHN/7m3RnWFcRAGEACiibuKjL8=;
        b=Tv8rOgotmg1czgwq0FMnyGaFqIzT+JakIg8G4CfTWMYovHxyXEpkltTcteNLJuSiPt
         w27ZJYZdf5vtFuGD6P0zxbKE1IWOj2ZSMelrSjym57qhGFbEqiwVifomJm33loJUUOmO
         b2T+vHgEz4+SwzbM5rpy44FXQKM9RNoMBHYQk3uM24VBzq3NTkYDhTMPV8YfA4fZi34V
         h++/e2xcbL/l4dDmnh9CqF9k/EFSQhpMlPWgbPntp37XpAal4nVSbY2UNTbBd0Vm4tCx
         tA8p9VQt0fUtES8yGrVnliqtJ2Olx6ykRjLnhSTRwozIX4+f+mQ1MSCBdoGDqKLznoFE
         XjCA==
X-Gm-Message-State: AC+VfDxJlASprsL8wucm2UoFjlhk3WcagDZ0KMUdc3Cms8L/1aOFRTOY
	ZPCCxhDSZKvoSweXehzrGE8r9ffBRUkSSzNiHN+DDA==
X-Google-Smtp-Source: ACHHUZ4D9RaN03MoOpBtDeoGOnEslOs7WPiEQovsEGOjciwF4czUwF44VdMfqp67W603aBjmfgYByg==
X-Received: by 2002:a17:902:f691:b0:1b2:5d5b:e871 with SMTP id l17-20020a170902f69100b001b25d5be871mr954749plg.59.1686314430787;
        Fri, 09 Jun 2023 05:40:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o6-20020a170902778600b001a1b66af22fsm3202158pll.62.2023.06.09.05.40.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 05:40:30 -0700 (PDT)
Message-ID: <64831dbe.170a0220.d01ce.659d@mx.google.com>
Date: Fri, 09 Jun 2023 05:40:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.283-cip98-224-g5f5303d7920a9
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-futex: 7 runs,
 1 regressions (v4.19.283-cip98-224-g5f5303d7920a9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 12:40:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11938

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-futex: 7 runs, 1 regre=
ssions (v4.19.283-cip98-224-g5f5303d7920a9)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.283-cip98-224-g5f5303d7920a9/plan/kselfte=
st-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.283-cip98-224-g5f5303d7920a9
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      5f5303d7920a98db8e84681ee6f1318ae918ab84 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64830af6e726b9792a30614f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-224-g5f5303d7920a9/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/kselftest-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/64830af6e726b9=
792a306150
        new failure (last pass: v4.19.283-cip98-135-g4ed206c5dc11) =

 =20

