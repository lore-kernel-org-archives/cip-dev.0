Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C9DC77B73
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 01:46:26 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.11280.1684806384371194380
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 May 2023 18:46:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=W4/b9FxK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-64d44b198baso2078073b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 22 May 2023 18:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684806383; x=1687398383;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G7YvadmNXzmyyXPUSgm/DwMAy8Rab68KUf4c7VOAdcQ=;
        b=W4/b9FxKz1kf+756zfvdRCdUN6/ipOoGjvsRRVoU5fOByqmj1CGOkvZ6x8JRUntDWj
         a6vUZ7Vaw4jBqKwKaMx/I/sQDITb/4TX/c/aqaCjKrdV52QyYu3eec/Sb63c/JN5OeQY
         6IiQZsmA9HASo55i3PPcb74ibIoYoFK2GFKM6wev3PdIoXBJBB7In5bBN/xmKJ5jQh8P
         0WP37Z4zzp0D5ZBgK0pavBBZI9l4IZKPMya8SfACxOGkapv1gS5C7VAhvlNSVQ5CBHRa
         Z3hrArDntvn8Wf3jUWcfLJxoTGQmXy/WuuZAH7XbgqwwI+j/fx5FxX/BCtNYASg2m3mF
         Eb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684806383; x=1687398383;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7YvadmNXzmyyXPUSgm/DwMAy8Rab68KUf4c7VOAdcQ=;
        b=ifgd4v1uy8JmmrXWLovgRa27ut8XhcYCx3yIC8BpMa2mJcRDcdKDA40xzhoi42dJnK
         WLUMoeXXgdYkJZyrn5uwLf7qlmOCilNfFc3B2t/spVPJohr5kgHh9pv0VDL6hUQ++yak
         N2zIWBTiETKgQRi4n/wAU3CCKsXNFBl2YB8foEZzTHcwXcYmfjCuPxlwM7iMFZD1/94P
         XiXyGroeXQoganKbxXXApR3mLGECJq6ZWPGOP2BubB8u2SLA04t6H4ti1VwtwTGIyx6a
         1VcLAfPLgyTuKXUgLBRXZdBj3REUxiWkg9j+QYqRx9FEI5BJtXdmwatJufLVY0fz4Cf4
         kSFg==
X-Gm-Message-State: AC+VfDwPBOMuScWUc7Wsx7HAsSXjiWW2J5+anhf2emcQCSUDunzOAnJ+
	/IBh6sYlmoG9W11li3GSBwStTkw/DvN645Vhk7+05g==
X-Google-Smtp-Source: ACHHUZ511kiGFg/SyMMq41501FO53gU3YM2DDsLw+T937NmqgI52BTDbNrnVXOwVibZwKrO6Qc2uFw==
X-Received: by 2002:a05:6a00:188c:b0:64d:421c:ae43 with SMTP id x12-20020a056a00188c00b0064d421cae43mr12816750pfh.11.1684806383248;
        Mon, 22 May 2023 18:46:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x19-20020a62fb13000000b00640d80c8a2bsm4672100pfm.50.2023.05.22.18.46.22
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 18:46:22 -0700 (PDT)
Message-ID: <646c1aee.620a0220.143ec.869f@mx.google.com>
Date: Mon, 22 May 2023 18:46:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.280-cip95-rt30
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 8 runs,
 1 regressions (v4.19.280-cip95-rt30)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 01:46:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11597

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 8 runs, 1 regressions=
 (v4.19.280-cip95-rt30)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.280-cip95-rt30/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.280-cip95-rt30
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dcee20e65677ab5d0e0d47c572f2c71dae6074a1 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0b9d849d7a670b2e85e8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/646c0b9d=
849d7a670b2e85e9
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =20

