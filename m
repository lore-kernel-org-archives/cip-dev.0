Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346FAC433EF
	for <webhook@archiver.kernel.org>; Wed, 29 Jun 2022 22:51:27 +0000 (UTC)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53])
 by mx.groups.io with SMTP id smtpd.web09.18318.1656543081185957528
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jun 2022 15:51:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=rInWHjp2;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.53,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-1048b8a38bbso23388920fac.12
        for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jun 2022 15:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=lZ4sIJv7mwVtq5oB0ESeaST84iIo6/iOLURQ+gNmnLY=;
        b=rInWHjp2lPi6k1/zNTOvTcksdS2GZez7o5CmA2lHFaC3eZgb9WFOJ0Cibu0YxyLLjj
         kzE21ei5c1tqxYSWJal+A6u/TvIbrHzCgRQtmDVcMBOOVztK/hd3fbid7ftMvg1fx3B9
         3VSdNTxw0eyhY/cb3wJlLjib5cjIeM3ubYmIAMxULX0zIep4SKf4bf+ybq5pI3JYnCz+
         niMbqDthe6qz7EOxdPX1UYsxT3gUx3pR5e/XvLy/DHZ5dcSNTLbyLC2tKFkcTj/KEJmC
         ggP1GVvs92wESZFO6Adske8e4xetSa2LRgIlfd9LndvzQmsoQttWfUgGoXVULtRTFhqE
         U9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lZ4sIJv7mwVtq5oB0ESeaST84iIo6/iOLURQ+gNmnLY=;
        b=3ofzHLpV/I92S7xv2D3HoEJ9BIpyCyQKWkwFRz3AqqM40bcmc69623wUCpdHr8h3a2
         2kWD7AkTq36A5dFUH18jjBLNXb1vm+J058a8yTx9jLz2fyPx024Sffe6gaqwaW0kIUJO
         WYcysWpR+thTyXjOtL684HWL4pHKWgzX7wJeSEbDsRgr9WK6BjGQJLvho6pIrj2A5Yyv
         MZuBCSMr108Ib8fXwI2PkqnCjPupbFuX92yJf9Eu8SRDVimUIwyiTFe/pb+eFYbIqoAE
         ABHH1fsNfz93BKRWqBPrDs0KLlJY0crHdd7yEzQOSC7L+9iyIMe6grUOnfbYaIvQMYtf
         7p9Q==
X-Gm-Message-State: AJIora8vY41U50AbLSJXsnv17AfExW4zhO/0885Z40HxSHLA7Yq+qiZk
	2QvzfLdQpUU0WV1+GRc9IwFGOiVwOJPLnHA5v/0eFGNUxm2kjQ==
X-Google-Smtp-Source: 
 AGRyM1voEExE7HApRTK4DHplFjmldiVDbu5he8ivt+pujsE5xcQMpR6Aua9+/AU+o8ClPK5opoEl84SKJo7v+LVLIbM=
X-Received: by 2002:a05:6870:9a18:b0:101:3954:9730 with SMTP id
 fo24-20020a0568709a1800b0010139549730mr4426210oab.253.1656543080035; Wed, 29
 Jun 2022 15:51:20 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 30 Jun 2022 07:50:44 +0900
Message-ID: 
 <CAODzB9ophsyoc8zZ_ZdYoPcMARAryX9WsxJjyFMxChtuVH_JYQ@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Jun 2022 22:51:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8628

Hi !

It's this week's CVE report.

This week reported no new CVEs and 5 updated CVEs.

* New CVEs

No new CVEs.

* Updated CVEs

CVE-2022-0812: NFS over RDMA random memory leakage

stable 4.14, 4.19, and 4.9 were fixed this week.

Fixed status
mainline: [912288442cb2f431bf3c8cb097a5de83bc6dbac1]
stable/4.14: [4779af1ec4a6c88a7005c8aabe69f409cf926d58]
stable/4.19: [4103bc54d8684a099615ae1fbab0590cf2167024]
stable/4.9: [ca6226b5c5b4cf8c41ab7c759686c9aab43a2a33]
stable/5.4: [c8a4452da9f4b09c28d904f70247b097d4c14932]

CVE-2022-0854: swiotlb information leak with DMA_FROM_DEVICE

stable/4.9 was fixed this week.

Fixed status
mainline: [ddbd89deb7d32b1fbb879f48d68fda1a8ac58e8e,
aa6f8dcbab473f3a3c7454b74caa46d36cdc5d13]
stable/4.19: [8d9ac1b6665c73f23e963775f85d99679fd8e192,
06cb238b0f7ac1669cb06390704c61794724c191]
stable/4.9: [c132f2ba716b5ee6b35f82226a6e5417d013d753,
fd97de9c7b973f46a6103f4170c5efc7b8ef8797]
stable/5.10: [d4d975e7921079f877f828099bb8260af335508f,
f3f2247ac31cb71d1f05f56536df5946c6652f4a]
stable/5.15: [7403f4118ab94be837ab9d770507537a8057bc63,
2c1f97af38be151527380796d31d3c9adb054bf9]
stable/5.16: [270475d6d2410ec66e971bf181afe1958dad565e,
62b27d925655999350d0ea775a025919fd88d27f]

CVE-2022-1011: fuse: fix pipe buffer lifetime for direct_io

stable/4.9 was fixed this week.

Fixed status
mainline: [0c4bcfdecb1ac0967619ee7ff44871d93c08c909]
stable/4.14: [0ab55e14cf5fd40c39109969c8b04a25870f5d1e]
stable/4.19: [99db28212be68030c1db3a525f6bbdce39b039e9]
stable/4.9: [b79d4d0da659a3c7bd1d5913e62188ceb9be9c49]
stable/5.10: [ab5595b45f732212b3b1974041b43a257153edb7]
stable/5.15: [ca62747b38f59d4e75967ebf63c992de8852ca1b]
stable/5.16: [58a9bdff32fde29137731e574b17c42592875fd0]
stable/5.4: [a9174077febfb1608ec3361622bf5f91e2668d7f]

CVE-2022-1012: secure_seq: use the 64 bits of the siphash for port
offset calculation

stable 4.14, 4.9, 5.4 were fixed this week.
stable 4.19 and 5.10 were added more patches.

Fixed status
mainline: [b2d057560b8107c633b39aabe517ff9d93f285e3,
9e9b70ae923baf2b5e8a0ea4fd0c8451801ac526,
  4dfa9b438ee34caca4e6a4e5e961641807367f6f,
ca7af0402550f9a0b3316d5f1c30904e42ed257d,
  e9261476184be1abd486c9434164b2acbe0ed6c2,
4c2c8f03a5ab7cb04ec64724d7d176d00bcc91e5,
  e8161345ddbb66e449abde10d2fdce93f867eba9]
stable/4.14: [40d20f3186ddd9b6b94598f4ef3d07644b0fa43c,
f1e99d0a7dbb313c0059d3b4c9d834759541b3ac,
  a14619ff0dcc034024256f4a4de87202bac88e78,
43995cd1fec2da248ff60be3baba8ed730f03a66,
  9c251cc4f664a4ae922c9431f2eb4559cb3c737a,
9044e70fadec49482c3cb3c2f49e81825796ea6d,
  6a2659e2e940b405895c4e19a683aa7fa846a785]
stable/4.19: [abcf4e1277d169b82dd7ee290006487ed16016ce,
695309c5c71526d32f5539f008bbf20ed2218528,
  11abd17d923c041441f7346a4811735b86318773,
22788ee7230772f5040113d53fe757b682f790da,
  9b8fba5d9e19548ecf7538917a04071c3c432985,
514cd2859c5017fdc487165b093b328e24afe954,
  9b40c2b72362a5ea92128ca7b83307986ac6246f]
stable/4.9: [576696ed0dee677ec868960c39d96ae3b8c95a3f,
2ed413f140bbb527745e3b42550f44d07c9dfd2a,
  aa7722529f6d7f3be1dd7b94dcce3f2689ba9756,
dd82067bd6cabbc25aa0f459e91a8e5e08fa4782,
  3c78eea640f69e2198b69128173e6d65a0bcdc02,
a81a6b204a303116e64e0a6288b701cbda9d4de7]
stable/5.10: [d254309aab27fdcdc68e6bc9c663e51f3e7b37dc,
a5c68f457fbf52c5564ca4eea03f84776ef14e41,
  dd46a868fcfdf3aac8ffb20b2321e174a0156fb2,
d28e64b1c63eced06aedadcacb0be4997c10c7c1,
  24b922a5da0055f1bb8b391b83e494d2e5d56508,
9429b75bc271b6f29e50dbb0ee0751800ff87dd9,
  7ccb026ecb997405b59d391140c25ee347891504]
stable/5.15: [1a8ee547da2b64d6a2aedbd38a691578eff14718,
ff01554d8755bdbe2aec2e2cff322d95f328cb89,
  f41f6336bfc43500e4e94ada703cd5aebb91789e,
b763fce193b42048444afd85d066b136288ad2c8,
  4a3eefa399e675c4a5239497832a72733281a20f,
952a238d779eea4ecb2f8deb5004c8f56be79bc9,
  f26c6f9404e1d6f3bfc9780ffba82a01a595d147]
stable/5.17: [6976724355f5fdada89de528730f9a7b4928f2e3,
27003fa8b581098aa9768bc03f82d5654368cb02,
  3a8081f81323e1550c241157244318db166b660e,
c2cef1db8f8aa81330fee4538a1158e1f6fd5bd1,
  01e16c23823a057667feb5cf26ba0c963fef6afd,
e3ee7bb47d6509c3e8a3e96e5d8e3bf21549b6e8,
  5034cbb361e1c447911a15b1d3982d5df7aa17b9]
stable/5.4: [ab5b00cfe0500f5f5a3648ca945b892156b839fb,
53c5de3092ade55f82ed4f5373d8a8ca115df818,
  6e34ee5b5b921d25992f54141aaaf9859733863f,
7c0a777b7dbdcd39eb45996afe6df7770f7926ac,
  77d29f3b18c466a6b88bdfceccec3085961a7d0e,
c26e1addf15763ae404f4bbf131719a724e768ab,
  2e1591c27b954f1f60ef8ce5d214e8fee1b4d304]

CVE-2022-32296: tcp: increase source port perturb table to 2^16

stable 4.14, 4.19, 4.9, 5.10, and 5.4 were fixed this week.

Fixed status
mainline: [4c2c8f03a5ab7cb04ec64724d7d176d00bcc91e5]
stable/4.14: [9044e70fadec49482c3cb3c2f49e81825796ea6d]
stable/4.19: [514cd2859c5017fdc487165b093b328e24afe954]
stable/4.9: [3c78eea640f69e2198b69128173e6d65a0bcdc02]
stable/5.10: [9429b75bc271b6f29e50dbb0ee0751800ff87dd9]
stable/5.15: [952a238d779eea4ecb2f8deb5004c8f56be79bc9]
stable/5.17: [e3ee7bb47d6509c3e8a3e96e5d8e3bf21549b6e8]
stable/5.4: [c26e1addf15763ae404f4bbf131719a724e768ab]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

