Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C732BC4829C
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 03:10:12 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.13776.1707189009445284662
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 19:10:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=F3MgQLt/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d934c8f8f7so41210205ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 19:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707189008; x=1707793808; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hztld5KJXGtolnwAXyJVYwQepWa76Pd14EQRcuMYYbc=;
        b=F3MgQLt/FnpYa/VGJzbGed2grSjsZaH+wq3j2QhyD1RL3ffvtGfT5iRGBRsatiWzO7
         /re1dEQniMMeCkRDCWCbwSvw/i9uPuItCcPoYIkPuwkSJAQY1DjUt8ti7CLp16qgGG7J
         hbqTBRyI7bjqFPm1crHwrCyTDEgnpwWPEF9qVAxj1I1/NZFaXKcwFG6eAOa8bjP3Jbhw
         t8KkikpYYv9Q0dHr403LOr/hn2lxrPQmLCRMojKzJVd0IqdIVVKu/I/N71CG3pPRGe51
         9o6f1uZeqxS5gM+9JUps75Sv8iC/WZXbBOKlRIIJJs5P0KoYarQWLsV6fMzrKqFw+B38
         tp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707189008; x=1707793808;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hztld5KJXGtolnwAXyJVYwQepWa76Pd14EQRcuMYYbc=;
        b=hHbphSaG+De2QHr9pu/oNOQN1nE/uQa/c1Rk6Xlxtrj3UczvIKCzRQGBtxerkKHveU
         6nnbjFzako9Ykbcrl9DhjSvdQWIIzh4mmEw1SC09BMI+It8CwjpTljhO/8O2TCG99Jsv
         WgUAAM0MRGlO9K59LmrpTPCfeQBhN2xmxTMysd6yNc3sok0ezQvF5KBBPJ8gnhuA8uil
         CN4JTUd0Tud6UcpnBerG/b7mfJHzCDJTg+tfWyjlxzMcTEodiAxh3OdfOQ/VcuAAEnO9
         iSumfOGmf8K0WfUB+uGtsJawjiuI+vb4nT9URaZ3KpYBGhrB3D96UHo0rBsalSjVIif8
         Oc8A==
X-Gm-Message-State: AOJu0YwmlZaD2RUL6jpIjLqgsZnRGE01h/0dU2gRrW8UKX+r1okh/rgT
	9MvloWClaCC3vHgQYIP2QfJXc6OuJdahGFAXG+dAttJTtUKM3IlHs2vcVARfdHtqEoAURDd4DXk
	n
X-Google-Smtp-Source: AGHT+IHBcyHHAnbwdRvai+vP1VY4/BfNOZWaKG0UfJNMVu/NXF2kvEEl8dUOEoZjTFTttf70TZYksA==
X-Received: by 2002:a17:902:ea0b:b0:1d9:40f3:ada8 with SMTP id s11-20020a170902ea0b00b001d940f3ada8mr448088plg.3.1707189008526;
        Mon, 05 Feb 2024 19:10:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXPWifUW3iUNBR0gHO/Z6+iyEIVH4RS3PhzAGrFwDghhC5fIPFa7oKuXfB7m7oenOZUoGdjQTAbtKgQ+hHvWZxWGX1EmQu5jQ6j543PawJV0NHii3yJukHLeTd8VQj+7p3c0hCCgI+knkiBeyXTqv6eJA==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jv4-20020a170903058400b001d706912d1esm628478plb.225.2024.02.05.19.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 19:10:06 -0800 (PST)
Message-ID: <65c1a30e.170a0220.846ae.34d0@mx.google.com>
Date: Mon, 05 Feb 2024 19:10:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.209-cip44-rt18
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt ltp-mm: 10 runs,
 1 regressions (v5.10.209-cip44-rt18)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 03:10:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14772

cip/linux-5.10.y-cip-rt ltp-mm: 10 runs, 1 regressions (v5.10.209-cip44-rt1=
8)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
        | regressions
-------------------------+--------+---------------+----------+-------------=
--------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | defconfig+x8=
6-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.209-cip44-rt18/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.209-cip44-rt18
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d814befd12dcf6c81b483cb36f507d70112c1097

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
        | regressions
-------------------------+--------+---------------+----------+-------------=
--------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | defconfig+x8=
6-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c196427b8339f55d00a04b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/x86_64/defconfig+x86-board/gcc-10/lab-collabora/ltp-mm-asus-=
C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
209-cip44-rt18/x86_64/defconfig+x86-board/gcc-10/lab-collabora/ltp-mm-asus-=
C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65c196427b8339f55d00a04c
        new failure (last pass: v5.10.201-cip41-rt17) =

 =20

