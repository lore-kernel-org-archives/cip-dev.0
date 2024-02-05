Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811FCC4829B
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 18:21:28 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.1297.1707157282336851160
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 10:21:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=WQsFTEsq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e054f674b3so96273b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 10:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707157281; x=1707762081; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=az++tOxkwLfrvsDOWkT0UpaO9VRZUggPWPfHGvVqYiY=;
        b=WQsFTEsqpJRoYdNSe3NLf0W4BfTZ//QY66RrcDOuuP2PI+j9grE+Z2OhgPrG8nrieZ
         BMB5aXnTWsMhY47W5lvNDDX41l5LwQ+8Oz46uunpd01gMhzXqh+jyZUg0jw8TgOhbEXP
         KWDoZTFA1ags9uOtLhuAjyrVViEEv0CMoxo23dWrXzJwtWS2vc5Vo9gNen/dZ5k30do7
         ambkw7pIcHPDY5GM2XHK91Urg4dlRtE0fDtIbG23FFjRrBJm9Agbd6z8QZc509nfRJGp
         4ARmHzwkqdTIjXdizH4bqimWvqipK+vZ5yRUTL7aI4TXFFqBwNkh4f4DjedmXFAiiWG3
         R4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157281; x=1707762081;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=az++tOxkwLfrvsDOWkT0UpaO9VRZUggPWPfHGvVqYiY=;
        b=jvl8v+mq/RitKp0rzX81TlnK6Y2Ph4VQkTHK8KKURHUXMAnP4f0l1aAPGgZvcaonHN
         2tI35Ofe6TGDr2SQ8hgh66E95zDk7JtfL42YhaNt73bwGZIt7Pjxru2yJkmR2JSJzGb/
         xAFRp3qX6Z8bTK/bWvsB4NiS1gqujTjLoeSPRwWtpsRlEHwAdA8GFjiQqYfa+Vu0Ku7E
         nzWg1dmN25Iy15qFAlgu8gLhOZrR1A6z1+uhcAQ8NESfVcHJ8r80k5qqDWCwmZgd2reT
         fy8X3ibLi8BGdlHTk9MZBWQiVHUojtzm8FXYBZgpkHMg0ouRfe/8tSxhiDVC7NuDizLH
         oL7w==
X-Gm-Message-State: AOJu0YzC8bk7W5M+qjSwls3zbqQ3y5JDwFSD4xj623lU0BCVXGft/X0R
	8gGnBbG9px/LuojkecOlyr6FwizdAG7DMdGRJ6SQa8UCHu/bwEjc3wjVSH6krZncQFrLAw2QZd7
	l
X-Google-Smtp-Source: AGHT+IFTg/lUSAN5GcO3I+9tJDEmp8TSEXJptQCgy+3Jl9BrlrC6rFG8ewJvC8mzcFjkCdYaH+uFbw==
X-Received: by 2002:aa7:86cd:0:b0:6db:ce79:a2f with SMTP id h13-20020aa786cd000000b006dbce790a2fmr324357pfo.1.1707157280779;
        Mon, 05 Feb 2024 10:21:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUl5L7V+qxTNAXp7uiWua14UxHZQpUGctK4X+GAEyfbqlxATF1ThTOAbPTCzoe2bjMOKvF25+vnkUDNCtIV/e1QQ6np895UHQZsm+qXAogi6QYajo8EkEWmrF5T6N/cJ70k4vlXe0nMU6FA82QhLhcg5g==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u3-20020a62d443000000b006e025e1fa61sm170491pfl.14.2024.02.05.10.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:21:19 -0800 (PST)
Message-ID: <65c1271f.620a0220.c9775.14b8@mx.google.com>
Date: Mon, 05 Feb 2024 10:21:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-mm: 7 runs, 3 regressions (v5.10.209-cip44)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 18:21:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14751

cip/linux-5.10.y-cip ltp-mm: 7 runs, 3 regressions (v5.10.209-cip44)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2fa4c25ee66abaa707e8d165c790bb96e883cca4

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c119f929d33f537a00a047

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ltp-mm-hp-x36=
0-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ltp-mm-hp-x36=
0-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65c119f929d33f537a00a048
        new failure (last pass: v5.10.208-cip43-4-g1c63c70fb18b8) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c118c2fc59e3c74100a03f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hiho=
pe-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65c118c2fc59e3c74100a040
        failing since 754 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c1196ff2453463f300a044

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65c1196ff2453463f300a045
        failing since 754 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

