Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676E5C001B3
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 07:26:07 +0000 (UTC)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
 by mx.groups.io with SMTP id smtpd.web11.53473.1688455561633719047
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Jul 2023 00:26:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=I1AYk7VW;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.176, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-55b1238a024so4162296a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 04 Jul 2023 00:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688455560; x=1691047560;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SSluTK/g16bS0K/VoEEQrzZ2ksemDZokHtdHs4c/55E=;
        b=I1AYk7VW6Wx5p2t5FcYJ0ZNmxH50fa76tILgAK3bLgC611l/5ATmyShN9B+skRX6s5
         VkNa24YHlWWWp35N0gwluFmdosL32KPh35qoiKRuVVi59L7qehDPTk1wZapV6oYNjKYI
         oxFMpN4puFTNWG0TcI4yjFDaOyteKzEU+e/v4E/1GT+UhQ7WxAS3GKK8LZEE8MvAmW64
         ZtgTQYj2ivuDUo5ugI2SSO8Ild0WBHlkNW/3zxhmh5A6iN9fWjtUTb9Y4FkWTS4fVRY6
         P/Doz9T71pBvXRAVUX6z5riciIq3niMYrszbjioJjD8N9pWIWJsPcbn7qjh1ng5uHyKJ
         g/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688455560; x=1691047560;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSluTK/g16bS0K/VoEEQrzZ2ksemDZokHtdHs4c/55E=;
        b=fJwRXdEC3q3AhZFWVQ0W0lNVBhy1zFVCm8V/ffoZ4Hj/yVzcrNTZfhw4ZejoJw1R5v
         TUS6JDF3F2NTnMd3Q2QTdt+3XYegXy0XrmP50fvjaMCqAGKYN74O66s2v0NvpDXuE21o
         H58s4NstyY0RTwHme6cu4rvAtW8IYqXxZsR6g1iPlJ9KH52EI5HaB0o+wcPwFIN1CW49
         f9b0m4hA8oN9LNIpBWAmVntUQrgoZtBGk+9jR3G45rnfkc9W/jmPZL9wVzVFfmETUOX9
         LiX4C55grfRhJakIvU6VTFwe9RFYFih9qQ2dc/ESqALlftb/AnLjd7ODbnKGMjlQTx+i
         Iygw==
X-Gm-Message-State: AC+VfDyZoRXQ6gxXDaXhhRfLL/CthVvOi7E8QNDWcM1ve737hRj7g/OG
	Y/qVmqQJZadueukNWQVB1LGfX4ifyVmr5Nhi2KsiJA==
X-Google-Smtp-Source: ACHHUZ6nr+Q9HGDTkVTSaAFZ1rK+PgkJb+LjZ/mwMUS8LDpKKeSiH+nHda9Pj/UF0UiN4PnFybnUJg==
X-Received: by 2002:a05:6a20:6a0c:b0:127:6bda:a2ae with SMTP id p12-20020a056a206a0c00b001276bdaa2aemr17013591pzk.10.1688455560635;
        Tue, 04 Jul 2023 00:26:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902b08800b001b8307c81c8sm10487046plr.121.2023.07.04.00.25.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:25:57 -0700 (PDT)
Message-ID: <64a3c985.170a0220.7707c.4fc5@mx.google.com>
Date: Tue, 04 Jul 2023 00:25:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-10-ga711f789c23e1
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 9 runs,
 1 regressions (v5.10.184-cip36-10-ga711f789c23e1)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 07:26:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12209

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 9 runs, 1 regressions (=
v5.10.184-cip36-10-ga711f789c23e1)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.184-cip36-10-ga711f789c23e1/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.184-cip36-10-ga711f789c23e1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a711f789c23e157efd79724aec812ad47941364b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64a3bb9ac4b42aa31dbb2acf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-pty-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-pty-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/64a3bb9ac4b42aa31dbb2a=
d0
        new failure (last pass: v5.10.182-cip35-289-g3c0549540706) =

 =20

