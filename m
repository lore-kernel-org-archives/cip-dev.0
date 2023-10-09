Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D0BCD6125
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 18:47:22 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.71074.1696877238045867403
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 09 Oct 2023 11:47:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=mGpArXwo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1c877f27e8fso38492525ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 09 Oct 2023 11:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696877237; x=1697482037; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DFm5HmKKEk4Injl5iREej5BXg7ahk6/DJX+HUh0jzKY=;
        b=mGpArXwoWJ0i14soO8VHxDKdBcD7nYxIrZG/gdzrStDgjs7EVayF3GVG8lGzKFwbhQ
         it9TK0C6nvYJaVt0KC67R0kGN1O8lEckM3cD12Z4FtzEN7a/iX6pBvjCqNjHHlp6lnKU
         PDOaNkwF+0BIVmtSl1ujtfK6QrcgkXO2tUTXqH8SiUWqwVAfHqU7hinfN5SzFQc7qhX2
         k8V9WSY19ZQvbomGoHkg642mG8kI7bSdBECjD3kPV8NzLk4k3TPXcUHISZ1KpaQWpCHv
         TcbCZuXDzrDVGeYIDYm3kJWHCbIWJnyYAe8BKeZ8PS6vRDWl/36oNl9c4fVsQ7l1Wkkc
         H7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696877237; x=1697482037;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DFm5HmKKEk4Injl5iREej5BXg7ahk6/DJX+HUh0jzKY=;
        b=MruvfgWSMquIjaPRg4BdAth+7KT65xIeMgm7hXdFj/JXD5JakAePfXx7IVuH80DkI3
         fYqG/abH51GzQAH4ruvxJCMofU0zhhO6RpW/DxqnHrXFlUiW90L4vXyHBnLsm/vQ8Rar
         qnwu/KpAtaUwE/ozEW3sIPXzCKKG/Ndorza3h+1zbu52UMSETONRMLBvsg+gV5PxoDWc
         57eh8oK1+qcQQIt4U+NkVPpX++l+N9ZUmg1aaMrlAEimHFwRzG5CFuJuXkZ6VQBVQyI/
         elHPhUyvAlVm07pemSHxkqnoMk9rMo4nuUmVQiAec3isTnWepxlt5EByoP8MsAxsh54/
         Ywqg==
X-Gm-Message-State: AOJu0YxNaiaygo7Rp+lLS+WUVeDLCkEzXq1QvEOx1zyxML0koeHV+6Bo
	9nBaGbTn2DK5c32huRABdQuxcQUT8hXVC8AZgO2m1A==
X-Google-Smtp-Source: AGHT+IGls+HPi+9M3UrhetUNHs5NSQdsINNXXrdUpT9NBO+i5iendd/RuU9Xk0kyRLbOa9fD90yuqg==
X-Received: by 2002:a17:902:7246:b0:1c6:6a4:ab40 with SMTP id c6-20020a170902724600b001c606a4ab40mr14716065pll.68.1696877237077;
        Mon, 09 Oct 2023 11:47:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709028d8a00b001c5f0fe64c2sm9929333plo.56.2023.10.09.11.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:47:16 -0700 (PDT)
Message-ID: <65244ab4.170a0220.2c4cc.993c@mx.google.com>
Date: Mon, 09 Oct 2023 11:47:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-1778-g3b01feff09495
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-st kselftest-futex: 5 runs,
 1 regressions (v4.4-st20-1778-g3b01feff09495)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Oct 2023 18:47:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13331

cip/linux-4.4.y-st kselftest-futex: 5 runs, 1 regressions (v4.4-st20-1778-g=
3b01feff09495)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-1778-g3b01feff09495/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-1778-g3b01feff09495
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3b01feff09495bfdcf43283997a6ea6c6bf6c649 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65243fe62138c3d553efcf0f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
778-g3b01feff09495/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/kselftest-futex-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
778-g3b01feff09495/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/kselftest-futex-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/65243fe62138c3=
d553efcf10
        new failure (last pass: v4.4-st20-1308-ge1d2f27f3d7b0) =

 =20

