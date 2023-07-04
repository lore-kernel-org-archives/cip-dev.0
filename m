Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCFDC0015E
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 07:26:07 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web10.53523.1688455558197052657
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Jul 2023 00:25:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=xReGjYyW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1b89bc52cd1so7049185ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 04 Jul 2023 00:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688455557; x=1691047557;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kmq5MvVKUDjUzuQDZ/TLeqeFAL5KhKCg4Z1Jb7r3GTc=;
        b=xReGjYyWbL1r4nsZBa0hBZXCgx3Vsg/wL+Yp/c0IUTTc4enUuWSOMcDPy7Mm3BvGr8
         bP5sJ3TH91fPgquAHEcI32EksmsjeJKb85zcD9Jq4D2zCWlPpVYwEBbI4QK7d7xiWB76
         +0jjKIo8vTj5358tY+BskfPe+DxQ83kh6ilpeiKu6dBf26yCUh7U/0nMC95fkTv4woJj
         +t1PbQVcbCKCsGuY/w776HuBw08BhT6lBJiqMU/zCDww7t/mjJ9UIxyMDZ3ywIdlsvM+
         Mp4q84kYWfAaf9Jhg/63NUENACYD5WoHRivW0Ht28Y56tk2dR43WGsxgfjcVK96Vli3e
         G7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688455557; x=1691047557;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmq5MvVKUDjUzuQDZ/TLeqeFAL5KhKCg4Z1Jb7r3GTc=;
        b=CMLikSOSq5xtsQIABnJCVld3x8gOHzha5/kKeuGWgymRMabhZ3DIAy7GA6RhWnos8n
         d5hhobasueV2RGJgDP8zo0SmoAHpDX3wA/sI99Cc3pLPM+wQaUsztIUu5N+FZkoRLpQZ
         +UiOdQ9x/tQ8hLkr1Eozk6nzK0JwoTSgkRSOJKx8EzWlwe4wtyAMaFT1GAKXza9PhFz2
         1XLJSOjzftBNoidtg5Le7FVwTgEVBpiV02FR5ZORbcecYnV0psOMZRkd8nIO/PuY4osR
         ihXug86NNTTgVXePMoDYfdCU/MpHdzwjq1PVg8YWOLBSbauH2Ua9j4E37vVdhVnKIAAv
         nqBg==
X-Gm-Message-State: ABy/qLYBmx9sMkQcavnUWo1Yx9ZFfZhxixlD4CZMUcFmmtunjjSgCaVr
	ZLkP9TauRNjnzuOODmXHKaYO081fDuKOv4STr+SCPw==
X-Google-Smtp-Source: APBJJlG3tZl72o60QQJQj6OLFJS454iaZ7v1MihYdFx+a1UWCVkv7VTFY4vrQEMtHxN3REUoFjCcgA==
X-Received: by 2002:a17:902:f68c:b0:1b7:eebc:884 with SMTP id l12-20020a170902f68c00b001b7eebc0884mr11792987plg.64.1688455557009;
        Tue, 04 Jul 2023 00:25:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jw21-20020a170903279500b001b80ed7b66fsm13424617plb.94.2023.07.04.00.25.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:25:56 -0700 (PDT)
Message-ID: <64a3c984.170a0220.8c79f.ba56@mx.google.com>
Date: Tue, 04 Jul 2023 00:25:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-10-ga711f789c23e1
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 11 runs,
 1 regressions (v5.10.184-cip36-10-ga711f789c23e1)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 07:26:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12205

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 11 runs, 1 regres=
sions (v5.10.184-cip36-10-ga711f789c23e1)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.184-cip36-10-ga711f789c23e1/plan/kselftes=
t-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.184-cip36-10-ga711f789c23e1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a711f789c23e157efd79724aec812ad47941364b =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3c3925fad83bf0abb2a75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/kselftest-lib-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/kselftest-lib-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/64a3c3925fad83bf=
0abb2a76
        new failure (last pass: v5.10.182-cip35-289-g3c0549540706) =

 =20

