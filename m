Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC17C61D85
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 00:19:02 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web11.122238.1700785134827523741
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 16:18:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=B3Cze5SQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5c206572eedso1046372a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 16:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700785133; x=1701389933; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4t5DkoadwLss0L+GCyGiAfPVLrc893SOL1JneUngPR0=;
        b=B3Cze5SQidlhVsjff2gQ47JA6eC6RF++SujEJVxV1eteQSV7xVU4lpNI4E/Yq0OOtj
         5IraTwh2ZfOa578SlVNfta5vHoYaiHFIVGDRZkVaUdiA4Ycp6WaWA15DMOGd6UgEywSg
         5F6sgCarGY3BWTq+ZtPDxpOV4EzJ2C/3TxeEVLLgYc77tyRRbICZBnV8FIvv4i1TiHyI
         pCx+Chv2YS4T3O+1VLCR0H4mZwFcP5e3rWb8nKuOn48nW5zMGJhxoKTqjSkutKxgZSsC
         MXQl7os4XE61c1PMW3mqA251F44fXR2h26shSUeQhCtMUfNG8DSmuFyIY2YfK3mZTWl/
         yARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700785133; x=1701389933;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4t5DkoadwLss0L+GCyGiAfPVLrc893SOL1JneUngPR0=;
        b=DTFrwf7aqasEZ2slyhTBHhHMGySX6rJabu1gNpdj8eWrGoVb211HT2tiK5LQEnFtvA
         kXbg1fcPddpDyZNmhnNlQ36gxk7ASaaq6rXAPTDO7Mr3nc7CVu5Br2zWY2rzoycgB0DC
         N7H5Kt0m0ObcpgnACOatqcu3UsBOyw+RFJIpphdFlivl8Wt4/jLFDF4Os4tmeAgF2eoQ
         PI82FmNByHnmKzQpXArY32lLSxs/iqYljt1AIAYdz67e0A9Qo37kgRen/tkL9S7+aWU9
         GKMedAN/YxfNUj6BlKOV1h3n3AM9vkJgFGkeS1/t6uPJSvTqO8sbCNYqfAQWa9u/+DUj
         Eolw==
X-Gm-Message-State: AOJu0YyM5fWcTXj5Oz6kPYNErU+xWbkNi6hyGrgVGA+ePuASuKzdwXi3
	6L8dTxaTyxxv/x7nxKQq4zK3jWNO9Z82K7yAurU=
X-Google-Smtp-Source: AGHT+IFLJb40bs/ID3GxYHmJveBDZeO74uJa8rTVMrdT/HJwkWtLUZS4lig7vJBcnxCSR51+1paCww==
X-Received: by 2002:a05:6a20:1445:b0:187:d2f7:c3de with SMTP id a5-20020a056a20144500b00187d2f7c3demr1473395pzi.5.1700785133307;
        Thu, 23 Nov 2023 16:18:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h5-20020a056a00218500b00690ca67d429sm1742868pfi.100.2023.11.23.16.18.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:18:52 -0800 (PST)
Message-ID: <655febec.050a0220.ea8a8.4a56@mx.google.com>
Date: Thu, 23 Nov 2023 16:18:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.201-rt98-828-g27523c64bc5dd
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 15 runs,
 1 regressions (v5.10.201-rt98-828-g27523c64bc5dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 00:19:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13696

cip-gitlab/ci/pavel/linux-test ltp-ipc: 15 runs, 1 regressions (v5.10.201-r=
t98-828-g27523c64bc5dd)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-rt98-828-g27523c64bc5dd/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-rt98-828-g27523c64bc5dd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      27523c64bc5dd6f1af1b227b80017fea69e616b6

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/655fddefa83729d7a67e4a78

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/ltp-i=
pc-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/arm64/defconfig/gcc-10/lab-broonie/ltp-i=
pc-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/655fddefa83729d7a67e4a=
79
        new failure (last pass: v6.1.62-cip9-13-g34c303883a305) =

 =20

