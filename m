Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD29AC54E58
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 13:45:34 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.22877.1709646327768900023
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Mar 2024 05:45:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=QUYq+snj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6da9c834646so5121120b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 05 Mar 2024 05:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709646327; x=1710251127; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zRo0kWOg0eI149LZdnPqzP/OFgrY1K06aOaVSRrGcE4=;
        b=QUYq+snjDKPrGMZKbcE/spYy359MtUiNce5gBdr1y5+LtXFj7FsKDggrilQz8OwCAA
         mnCKxFc8pwhR2KxOVaaxY/gOb5IZvYkqbsFJM0pwbyB/vG//M1XLBdHbOl9ma27/aNCU
         tmhEyqOmn8auxgK7OO5K+TxTF2RdhfI6I6miK0hsaQ55Of6Ti4rK4+QG2fDBzLboNyj5
         Wo5uEXrLCIeIGl2+lYvblF9Cx/xmtC52KYfJa+aI1Vrva2UCNrjDXVn1Xse4FipGWRti
         v4RBaOqYAVKtyQ5LwWb7xSAX5t3+zbESmXP85COHL8iJ4qCdvrj1kQnyEW190M2rRCNS
         +ErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709646327; x=1710251127;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRo0kWOg0eI149LZdnPqzP/OFgrY1K06aOaVSRrGcE4=;
        b=vfLXa36EoDcwGKabZ5uXABMiaul0P4cVejgvGhrZ0uw3gQYZX/k4WchaXps+5Xpjpu
         1EmYxnVxYkAwhEc34MpA1zPIsRzVZP/Patlc4AXwLrRSPSOzGX7iyWzkTwe7x7+A50g6
         XTW7YOmTOHnr19N3aAhMENTKDRVUqQsd5xYMJzyF6BVAhJl0hI4/X3L0wMBHnJgMM3t+
         pxhVaERh1bQ+sAKlcdl+nduhiQKrgEAsWJkW8qPXJBp5Swgdc2MVCEXk+ovG+KTrF4MD
         rbj7D+ZbGMJG9BbeJQaqCTg5W2Pypy+5pWsf1pbs+28eQa6kxmDpCaB7NKyah6NNERcG
         bV3A==
X-Gm-Message-State: AOJu0Yx8bgNXrjkTYE1RhFTMuUevywJEMzFTplZY4a8P+AVTTusG/Axj
	vPiiGip/3n6pyLDqyRXQwzglOqrrP4fjWmv39EN4OBKOjMxGvn1XweEHUrx6LTYmTrnUJZrXbFI
	CzoM=
X-Google-Smtp-Source: AGHT+IGdBeipCKAMWX2TkphnLd2f0FzKs+n3apEbvytNrcDdgZXs0qOHu/M/PuP1r0ugTYQm1ly77A==
X-Received: by 2002:a05:6a20:3d8b:b0:1a1:50c3:d562 with SMTP id s11-20020a056a203d8b00b001a150c3d562mr2211338pzi.20.1709646324863;
        Tue, 05 Mar 2024 05:45:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y16-20020a056a00181000b006e63039486esm2230711pfa.189.2024.03.05.05.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:45:24 -0800 (PST)
Message-ID: <65e721f4.050a0220.6580e.9066@mx.google.com>
Date: Tue, 05 Mar 2024 05:45:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-2247-g140bf69dc64d
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-pty: 1 runs,
 1 regressions (v4.4-st20-2247-g140bf69dc64d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 13:45:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15224

cip/linux-4.4.y-st-rc ltp-pty: 1 runs, 1 regressions (v4.4-st20-2247-g140bf=
69dc64d)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-2247-g140bf69dc64d/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-2247-g140bf69dc64d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      140bf69dc64d0cace758052e3af9e9cc3e90a09f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e71d12233b888c274c42da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-2247-g140bf69dc64d/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora=
/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-2247-g140bf69dc64d/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora=
/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65e71d12233b888c274c42=
db
        failing since 89 days (last pass: v4.4-st20-1872-g0dd3085de20bc, fi=
rst fail: v4.4-st20-1987-g9e48fc479c400) =

 =20

