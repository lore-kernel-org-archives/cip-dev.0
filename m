Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610DDC3DA6E
	for <webhook@archiver.kernel.org>; Mon, 25 Dec 2023 06:42:43 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.56430.1703486555868253609
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 24 Dec 2023 22:42:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Chx9t96R;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c6839373f8so2234903a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 24 Dec 2023 22:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703486555; x=1704091355; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e0DkPrsDHEtolEtVVBBgUfWhBjyhE8Agw+upQxCPo8E=;
        b=Chx9t96RzdbMjvKC2tiEw5UdhH7uQmBYWg216A+XBJYWVbXnTr30/tTL2tHysKE3lU
         8U7FsMyR5B5CdImpsuKhAkCURS4kzJymw5Id8TnW8ZFRGSQASfsylodHQ6iaUXb0uzdr
         az2A8LmdH0DAO2FCmaOuWMQGkrC6zEUtyp+q3ef9VMwwvVfYsv9eTlSMz1cWKvLLwDL+
         i9otYtOM5gA2Ax2SzNY7U5wckGKJTxgmQOuA+UmP0p2E2gOdg9BkI5BpgmIiMIYKOo45
         sld1z3MaGLQRyrR4wWyb6GNxioNAembFDAXMD/sIXxpf+72a2z+NFL2Liva24GOgcsWK
         ysSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703486555; x=1704091355;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0DkPrsDHEtolEtVVBBgUfWhBjyhE8Agw+upQxCPo8E=;
        b=V8UOVjv3yfyj0hMdPpKZcEDEY7YvGaaCQwsYV27SkPYS89eFTnyyqq+LpNw74n7pqY
         l8i7vk/ROEGh8bzbq8bft0CnFZKOddUZgcNqujP2vCuGcfY+T7Kvvd6BPxtgpVHpq8kW
         6EQUia8w8pF5LM3xBApBskBu+/bVwTeETOvNcRgCwfEZ7AtHhny9T+21ne6Npjxxc0dX
         dIOLNldskYIpljrpbU8rJQVDDnzoP3p7CPS93x0evwYM7BShXJVDUIfAsPMrWY3B2bJN
         PMVBKCSmtQJ/3+dOE/vqAeQEf+uXulpGVnOj0iY4ZtjGFOQza2+k6SeCqNSZu1iOGUNC
         mpNw==
X-Gm-Message-State: AOJu0YzBS7jD4SoQt6/zdey005UXbwtFiehTkkurBpbEP87xkWPt6ojL
	dNstBwseZ37J/plNMqh8OXhdA2IRgB1cjhLvXN7TMjtFOHY=
X-Google-Smtp-Source: AGHT+IGBjtxoizTyDudEJkc6x1Fu+bz8K19LjbEE44Kp9UJnziw3s+qr5YPjskbEg5vWYmwBRwctoQ==
X-Received: by 2002:a05:6a20:394b:b0:194:3af:19ca with SMTP id r11-20020a056a20394b00b0019403af19camr6144320pzg.47.1703486554630;
        Sun, 24 Dec 2023 22:42:34 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id kr15-20020a056a004b4f00b006cc02a6d18asm1946307pfb.61.2023.12.24.22.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 22:42:34 -0800 (PST)
Message-ID: <6589245a.050a0220.920b1.378d@mx.google.com>
Date: Sun, 24 Dec 2023 22:42:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.67-cip12
Subject: cip/linux-6.1.y-cip baseline-nfs: 57 runs,
 1 regressions (v6.1.67-cip12)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Dec 2023 06:42:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14193

cip/linux-6.1.y-cip baseline-nfs: 57 runs, 1 regressions (v6.1.67-cip12)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.67-cip12/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.67-cip12
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      33a81955d654c80f6f9626f5bd3def02b8e85b3a =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                | regressions
--------------------------+--------+---------------+----------+------------=
----------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
onfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65891d258dd1b25601e1349e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.67-ci=
p12/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/baseline-nfs-len=
ovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.67-ci=
p12/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/baseline-nfs-len=
ovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65891d258dd1b2560=
1e1349f
        new failure (last pass: v6.1.66-cip11-1-g2d3d776d703d7) =

 =20

