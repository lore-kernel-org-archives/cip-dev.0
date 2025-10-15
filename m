Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816FACCD193
	for <webhook@archiver.kernel.org>; Wed, 15 Oct 2025 22:46:11 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
 by mx.groups.io with SMTP id smtpd.web10.346.1760568361542159597
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Oct 2025 15:46:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=C/OzvhP3;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.181, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-781421f5be8so1038067b3.1
        for <cip-dev@lists.cip-project.org>; Wed, 15 Oct 2025 15:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1760568360; x=1761173160; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E7Lp/lI3fGxw4pioEjKVakbOMbvPDdZh2oMyrkOFfjM=;
        b=C/OzvhP3U/DTKZPfF3hfPuE05axmTf4Iw6h5tPpa26U0tJasNA/ZKc+11pQ6RYoEf8
         INQ12I2sebruqNuOdbu3Coi6l3yEsd/yeJzo/6BpVYP/VgI+mlRJwGUMGLhFUnRg4Bqq
         NJbq0npSuMs8SaVpTMDvf+kUqIjuLqa9uTOoduOilsbg9idVOUFZXHea5IBIMCYz1sDL
         zD80aQ4AFpDhfS8wKHY936OC4HoxvTkJ5koLrW00z8/6onxF8EGiOPVBL5feEtHqOfPt
         TdHMtLL4cvkJpPN4K/viwE238+woV/fJAyhIdmKIFLOBSQ3Q8zSlwh8yNzI6vx1gPJFn
         6a1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760568360; x=1761173160;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E7Lp/lI3fGxw4pioEjKVakbOMbvPDdZh2oMyrkOFfjM=;
        b=B/LzXQY5d4LuF4eoqssSr8QhxFiqSj0Eio6SArXvZxKymoUVg84mHLN+eovWbDmfxK
         4Piq6sNginh/SmI1D8yHZ+5YiiQJXGkBwqNESU7Sgiu6A8FDz3TtnEKvXLOv9uDGlVjw
         ua7bdEqg1cFVYsSYTFdU7IjFXPcZND3Z0zw53CSSgH+YfTnFijxQFGRa4BEwokAqMPsP
         fDHsGFGSBl3zhnzHzu/7OBxVrtxib1N5KUn+EyOxWHQ079BXgz0J0O3xnPhGodi3KJxQ
         Vlj5Zzv7iyvO1m1tY9VO41m/zzhAQYRcUnJxe8pDc3CHQfm6rhPynTkICjL6pS8BnMRV
         deuw==
X-Gm-Message-State: AOJu0Yy58bNIVJ58M59QwxmoFXddoqnumBHSFfYlR6ncpDLl65y0Yp5l
	QF4bgy/pOE25M73qvKbuIrb5yPccrCO9Te97Kgtzo9o8vMDUROXNUHlg9yxwVnSbWGI0adhQe9U
	aLFp4DzvvSvgVBOVNw0qii1AOha4QIAJqFputeRmRUdcLfaryyiY88Y4=
X-Gm-Gg: ASbGncuvS/6LqYB+JHvtRp3Al0KTPxLfOM1hanvumLfqfSdsJkfsTpDtz7cAMpepfCT
	Vw1kakV0n70xND7VomVMGhrZp0u+a07Qh54HreJYGsBiQ4UNvB+MytcJ3bnb3SOJ2C3QmgiVall
	zJ593wuzxqDw3pOpIT1Hagor1gKqRSlihIiXcfoylhnx1N1gKU/hrIQJWGQ1m07KyUDktOOLo+J
	SdhY1B3eGJMXVBvOVVryfmoWM3xvRjXm0lzLdDAqfpjifmObMYkLj0iyG0xCA==
X-Google-Smtp-Source: AGHT+IHMoZVogfbmqJWPSY2luTNyQ20IpnyEnmjkJHhWka3zAkfJGulZZqmLbxB0p69Y2nvYPS7yiWIj9rkQGSWRPXA=
X-Received: by 2002:a05:690e:1699:b0:63e:d1f:d683 with SMTP id
 956f58d0204a3-63e0d1fd881mr217720d50.45.1760568359638; Wed, 15 Oct 2025
 15:45:59 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 16 Oct 2025 07:45:23 +0900
X-Gm-Features: AS18NWDSb0xEzIwswRYxSlS3Brc7mc4DIfPVg8_GUaEKuiS1lCr3jyfiF0xTGck
Message-ID: <CAODzB9qcm0ye-waPrBxq-AtVJGBRQSxTXViWMMpcOKMrqTiW3A@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Oct 2025 22:46:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20180

Hi!

It's this week's CVE report.

This week reported 47 new CVEs and 2 updated CVEs.

* New CVEs
CVE-2025-39954: clk: sunxi-ng: mp: Fix dual-divider clock rate readback

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39954

Introduced by commit 4571780 ("clk: sunxi-ng: mp: introduce
dual-divider clock") in v6.15-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25fbbaf515acd13399589bd5ee6de5f35740cef2]

CVE-2025-39955: tcp: Clear tcp_sk(sk)->fastopen_rsk in tcp_disconnect().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39955

Introduced by commit 8336886 ("tcp: TCP Fast Open Server - support TFO
listeners") in v3.7-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [45c8a6cc2bcd780e634a6ba8e46bffbdf1fc5c01]
stable/5.10: [a4378dedd6e07e62f2fccb17d78c9665718763d0]
stable/5.15: [33a4fdf0b4a25f8ce65380c3b0136b407ca57609]
stable/5.4: [7ec092a91ff351dcde89c23e795b73a328274db6]
stable/6.1: [17d699727577814198d744d6afe54735c6b54c99]
stable/6.12: [fa4749c065644af4db496b338452a69a3e5147d9]
stable/6.6: [dfd06131107e7b699ef1e2a24ed2f7d17c917753]

CVE-2025-39956: igc: don't fail igc_probe() on LED setup error

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39956

Introduced by commit ea57870 ("igc: Add support for LEDs on
i225/i226") in v6.9-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [528eb4e19ec0df30d0c9ae4074ce945667dde919]
stable/6.12: [bec504867acc7315de9cd96ef9161fa52a25abe8]

CVE-2025-39957: wifi: mac80211: increase scan_ies_len for S1G

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39957

Introduced commit is not determined.Fixed in v6.17-rc5.


Fixed status
mainline: [7e2f3213e85eba00acb4cfe6d71647892d63c3a1]
stable/6.1: [16c9244a62116fe148f6961753b68e7160799f97]
stable/6.12: [32adb020b0c32939da1322dcc87fc0ae2bc935d1]
stable/6.6: [93e063f15e17acb8cd6ac90c8f0802c2624e1a74]

CVE-2025-39958: iommu/s390: Make attach succeed when the device was
surprise removed

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39958

Introduced commit is not determined.Fixed in v6.17-rc7.


Fixed status
mainline: [9ffaf5229055fcfbb3b3d6f1c7e58d63715c3f73]

CVE-2025-39959: ASoC: amd: acp: Fix incorrect retrival of acp_chip_info

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39959

Introduced by commit e393368 ("ASoC: amd: acp: Remove redundant
acp_dev_data structure") in v6.15-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7871f400cad1da376f1d7724209a1c49226c456]

CVE-2025-39960: gpiolib: acpi: initialize acpi_gpio_info struct

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39960

Introduced by commit 7c010d4 ("gpiolib: acpi: Make sure we fill struct
acpi_gpio_info") in v6.16-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19c839a98c731169f06d32e7c9e00c78a0086ebe]

CVE-2025-39961: iommu/amd/pgtbl: Fix possible race while increase page
table level

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39961

Introduced by commit 754265b ("iommu/amd: Fix race in
increase_address_space()") in v5.3-rc8.
Fixed in v6.17-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [1e56310b40fd2e7e0b9493da9ff488af145bdd0c]
stable/6.12: [cd92c8ab336c3a633d46e6f35ebcd3509ae7db3b]
stable/6.6: [075abf0b1a958acfbea2435003d228e738e90346]

CVE-2025-39962: rxrpc: Fix untrusted unsigned subtract

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39962

Introduced by commit 9d1d2b5 ("rxrpc: rxgk: Implement the yfs-rxgk
security class (GSSAPI)") in v6.16-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2429a197648178cd4dc930a9d87c13c547460564]

CVE-2025-39963: io_uring: fix incorrect io_kiocb reference in io_link_skb

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39963

Introduced by commit 6fe4220 ("io_uring/notif: implement notification
stacking") in v6.10-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c139a47eff8de24e3350dadb4c9d5e3426db826]
stable/6.12: [a89c34babc2e5834aa0905278f26f4dbe4b26b76]

CVE-2023-53642: x86: fix clear_user_rep_good() exception handling annotation

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53642

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
mainline: [e046fe5a36a970bc14fbfbcb2074a48776f6b671]
stable/6.1: [76ce32682635fe907e0f8e64e039e773e5c7508f]

CVE-2025-39964: crypto: af_alg - Disallow concurrent writes in af_alg_sendmsg

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39964

Introduced by commit 8ff5909 ("crypto: algif_skcipher - User-space
interface for skcipher operations") in v2.6.38-rc1.
Fixed in v6.17-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b34cbbf4f011a121ef7b2d7d6e6920a036d5285]
stable/5.10: [0f28c4adbc4a97437874c9b669fd7958a8c6d6ce]
stable/5.15: [e4c1ec11132ec466f7362a95f36a506ce4dc08c9]
stable/6.1: [1f323a48e9b5ebfe6dc7d130fdf5c3c0e92a07c8]
stable/6.12: [9aee87da5572b3a14075f501752e209801160d3d]
stable/6.6: [7c4491b5644e3a3708f3dbd7591be0a570135b84]

CVE-2025-39965: xfrm: xfrm_alloc_spi shouldn't use 0 as SPI

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39965

Introduced by commit 94f3980 ("xfrm: Duplicate SPI Handling") in v6.17-rc1.
Fixed in v6.17.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [cd8ae32e4e4652db55bce6b9c79267d8946765a9]
stable/6.12: [9fcedabaae0096f712bbb4ccca6a8538af1cd1c8]
stable/6.6: [0baf92d0b1590b903c1f4ead75e61715e50e8146]

CVE-2025-39966: iommufd: Fix race during abort for file descriptors

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39966

Introduced by commit 07838f7 ("iommufd: Add iommufd fault object") in v6.11-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e034bf045b12852a24d5d33f2451850818ba0c1]
stable/6.12: [17195a7d754a5c6a31888702ca93f6f08f3383ad]

CVE-2025-39967: fbcon: fix integer overflow in fbcon_do_set_font

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39967

Introduced by commit 39b3cff ("fbcon: prevent user font height or
width change from causing potential out-of-bounds access") in
v5.9-rc3.
Fixed in v6.17.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st stable/5.4

Fixed status
mainline: [1a194e6c8e1ee745e914b0b7f50fa86c89ed13fe]
stable/5.10: [9c8ec14075c5317edd6b242f1be8167aa1e4e333]
stable/5.15: [b8a6e85328aeb9881531dbe89bcd2637a06c3c95]
stable/5.4: [994bdc2d23c79087fbf7dcd9544454e8ebcef877]
stable/6.1: [a6eb9f423b3db000aaedf83367b8539f6b72dcfc]
stable/6.12: [4a4bac869560f943edbe3c2b032062f6673b13d3]
stable/6.6: [adac90bb1aaf45ca66f9db8ac100be16750ace78]

CVE-2025-39968: i40e: add max boundary check for VF filters

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39968

Introduced by commit e284fc2 ("i40e: Add and delete cloud filter") in v4.17-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb79fa7118c150c3c76a327894bb2eb878c02619]
stable/5.10: [e490d8c5a54e0dd1ab22417d72c3a7319cf0f030]
stable/5.15: [77a35be582dff4c80442ebcdce24d45eed8a6ce4]
stable/5.4: [9176e18681cb0d34c5acc87bda224f5652af2ab8]
stable/6.1: [02aae5fcdd34c3a55a243d80a1b328a35852a35c]
stable/6.12: [d33e5d6631ac4fddda235a7815babc9d3f124299]
stable/6.6: [edecce7abd7152b48e279b4fa0a883d1839bb577]

CVE-2025-39969: i40e: fix validation of VF state in get resources

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39969

Introduced by commit 61125b8 ("i40e: Fix failed opcode appearing if
handling messages from VF") in v5.16-rc5.
Fixed in v6.17.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [877b7e6ffc23766448236e8732254534c518ba42]
stable/5.10: [f47876788a23de296c42ef9d505b5c1630f0b4b8]
stable/5.15: [8e35c80f8570426fe0f0cc92b151ebd835975f22]
stable/5.4: [185745d56ec958bf8aa773828213237dfcc32f5a]
stable/6.1: [6c3981fd59ef11a75005ac9978f034da5a168b6a]
stable/6.12: [6128bbc7adc25c87c2f64b5eb66a280b78ef7ab7]
stable/6.6: [e748f1ee493f88e38b77363a60499f979d42c58a]

CVE-2025-39970: i40e: fix input validation logic for action_meta

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39970

Introduced by commit e284fc2 ("i40e: Add and delete cloud filter") in v4.17-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9739d5830497812b0bdeaee356ddefbe60830b88]
stable/5.10: [28465770ca3b694286ff9ed6dfd558413f57d98f]
stable/5.15: [f8c8e11825b24661596fa8db2f0981ba17ed0817]
stable/5.4: [a88c1b2746eccf00e2094b187945f0f1e990b400]
stable/6.1: [461e0917eedcd159d87f3ea846754a1e07d7e78a]
stable/6.12: [3118f41d8fa57b005f53ec3db2ba5eab1d7ba12b]
stable/6.6: [3883e9702b6a4945e93b16c070f338a9f5b496f9]

CVE-2025-39971: i40e: fix idx validation in config queues msg

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39971

Introduced by commit c27eac4 ("i40e: Enable ADq and create queue
channel/s on VF") in v4.17-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f1ad24c5abe1eaef69158bac1405a74b3c365115]
stable/5.10: [f5f91d164af22e7147130ef8bebbdb28d8ecc6e2]
stable/5.15: [1fa0aadade34481c567cdf4a897c0d4e4d548bd1]
stable/5.4: [a6ff2af78343eceb0f77ab1a2fe802183bc21648]
stable/6.1: [8b9c7719b0987b1c6c5fc910599f3618a558dbde]
stable/6.12: [bfcc1dff429d4b99ba03e40ddacc68ea4be2b32b]
stable/6.6: [2cc26dac0518d2fa9b67ec813ee60e183480f98a]

CVE-2025-39972: i40e: fix idx validation in i40e_validate_queue_map

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39972

Introduced by commit c27eac4 ("i40e: Enable ADq and create queue
channel/s on VF") in v4.17-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa68d3c3ac8d1dcec40d52ae27e39f6d32207009]
stable/5.10: [6f15a7b34fae75e745bdc2ec05e06ddfd0dd2f3c]
stable/5.15: [34dfac0c904829967d500c51f216916ce1452957]
stable/5.4: [b6cb93a7ff208f324c7ec581d72995f80e115e0e]
stable/6.1: [4d5e804a9e19b639b18fd13664dbad3c03c79e61]
stable/6.12: [cc4191e8ef40d2249c1b9a8617d22ec8a976b574]
stable/6.6: [50a1e2f50f6c22b93b94eb8d168a1be3c05bf5cd]

CVE-2025-39973: i40e: add validation for ring_len param

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39973

Introduced by commit 5c3c48a ("i40e: implement virtual device
interface") in v3.12-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [55d225670def06b01af2e7a5e0446fbe946289e8]
stable/5.10: [7d749e38dd2b7e8a80da2ca30c93e09de95bfcf9]
stable/5.15: [45a7527cd7da4cdcf3b06b5c0cb1cae30b5a5985]
stable/5.4: [0543d40d6513cdf1c7882811086e59a6455dfe97]
stable/6.1: [d3b0d3f8d11fa957171fbb186e53998361a88d4e]
stable/6.12: [05fe81fb9db20464fa532a3835dc8300d68a2f84]
stable/6.6: [c0c83f4cd074b75cecef107bfc349be7d516c9c4]

CVE-2025-39974: tracing/osnoise: Fix slab-out-of-bounds in
_parse_integer_limit()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39974

Introduced by commit 17f8910 ("tracing/osnoise: Allow arbitrarily long
CPU string") in v6.16-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a2501032de0d1bc7971b2e43c03da534ac10ee9b]

CVE-2025-39975: smb: client: fix wrong index reference in smb2_compound_op()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39975

Introduced by commit 3681c74 ("smb: client: handle lack of EA support
in smb2_query_path_info()") # 6.14 in v6.14-rc1.
Fixed in v6.17.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [fbe2dc6a9c7318f7263f5e4d50f6272b931c5756]
stable/6.12: [bfb1e2aad1fecef8320fd71332acde0d53a8d699]
stable/6.6: [ba7bcfd52c66dd1c2dfa5142aca7e4a70b62dfa5]

CVE-2025-39976: futex: Use correct exit on failure from
futex_hash_allocate_default()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39976

Introduced by commit 7c4f75a ("futex: Allow automatic allocation of
process wide futex hash") in v6.16-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ec3c15462b9f44562f45723a92e2807746ba7d1]

CVE-2025-39977: futex: Prevent use-after-free during requeue-PI

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39977

Introduced by commit 07d91ef ("futex: Prevent requeue_pi() lock
nesting issue on RT") in v5.15-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b549113738e8c751b613118032a724b772aa83f2]
stable/6.1: [cb5d19a61274b51b49601214a87af573b43d60fa]
stable/6.12: [a170b9c0dde83312b8b58ccc91509c7c15711641]
stable/6.6: [348736955ed6ca6e99ca24b93b1d3fbfe352c181]

CVE-2025-39978: octeontx2-pf: Fix potential use after free in otx2_tc_add_flow()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39978

Introduced by commit 68fbff6 ("octeontx2-pf: Add police action for TC
flower") in v5.14-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9c70e93ec5988ab07ad2a92d9f9d12867f02c56]
stable/6.1: [5723120423a753a220b8b2954b273838b9d7e74a]
stable/6.12: [c41b2941a024d4ec7c768e16ffb10a74b188fced]
stable/6.6: [df2c071061ed52d2225d97b212d27ecedf456b8a]

CVE-2025-39979: net/mlx5: fs, fix UAF in flow counter release

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39979

Introduced by commit b581f42 ("net/mlx5: fs, manage flow counters HWS
action sharing by refcount") in v6.14-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6043819e707cefb1c9e59d6e431dcfa735c4f975]

CVE-2025-39980: nexthop: Forbid FDB status change while nexthop is in a group

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39980

Introduced by commit 38428d6 ("nexthop: support for fdb ecmp
nexthops") in v5.8-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [390b3a300d7872cef9588f003b204398be69ce08]
stable/5.10: [e1e87ac0daacd51f522ecd1645cd76b5809303ed]
stable/5.15: [0e7bfe7a268ccbd7859730c529161cafbf44637c]
stable/6.1: [ec428fff792b7bd15b248dafca2e654b666b1304]
stable/6.12: [f0e49fd13afe9dea7a09a1c9537fd00cea22badb]
stable/6.6: [24046d31f6f92220852d393d510b6062843e3fbd]

CVE-2025-39981: Bluetooth: MGMT: Fix possible UAFs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39981

Introduced by commit cf75ad8 ("Bluetooth: hci_sync: Convert
MGMT_SET_POWERED") in v5.17-rc1.
Introduced by commit 2bd1b23 ("Bluetooth: hci_sync: Convert
MGMT_OP_SET_DISCOVERABLE to use cmd_sync") in v5.17-rc1.
Introduced by commit f056a65 ("Bluetooth: hci_sync: Convert
MGMT_OP_SET_CONNECTABLE to use cmd_sync") in v5.17-rc1.
Introduced by commit 3244845 ("Bluetooth: hci_sync: Convert
MGMT_OP_SSP") in v5.17-rc1.
Introduced by commit d81a494 ("Bluetooth: hci_sync: Convert
MGMT_OP_SET_LE") in v5.17-rc1.
Introduced by commit b338d91 ("Bluetooth: Implement support for Mesh")
in v6.1-rc1.
Introduced by commit 6f6ff38 ("Bluetooth: hci_sync: Convert
MGMT_OP_SET_LOCAL_NAME") in v5.17-rc1.
Introduced by commit 71efbb0 ("Bluetooth: hci_sync: Convert
MGMT_OP_SET_PHY_CONFIGURATION") in v5.17-rc1.
Introduced by commit b747a83 ("Bluetooth: hci_sync: Refactor add Adv
Monitor") in v6.0-rc1.
Introduced by commit abfeea4 ("Bluetooth: hci_sync: Convert
MGMT_OP_START_DISCOVERY") in v5.17-rc1.
Introduced by commit 26ac4c5 ("Bluetooth: hci_sync: Convert
MGMT_OP_SET_ADVERTISING") in v5.17-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [302a1f674c00dd5581ab8e493ef44767c5101aab]

CVE-2025-39982: Bluetooth: hci_event: Fix UAF in hci_acl_create_conn_sync

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39982

Introduced by commit aef2aa4 ("Bluetooth: hci_event: Fix creating
hci_conn object on error status") in v5.18-rc5.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9e622804d57e2d08f0271200606bd1270f75126f]
stable/6.1: [6243bda271a628c48875e3e473206e7f584892ce]
stable/6.12: [484c7d571a3d1b3fd298fa691b660438c4548a53]
stable/6.6: [bcce99f613163a43de24674b717e7a6c135fc879]

CVE-2025-39983: Bluetooth: hci_event: Fix UAF in hci_conn_tx_dequeue

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39983

Introduced by commit 134f4b3 ("Bluetooth: add support for skb TX
SND/COMPLETION timestamping") in v6.15-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2e128683176a56459cef8705fc7c35f438f88abd]

CVE-2025-39984: net: tun: Update napi->skb after XDP process

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39984

Introduced by commit e6d5dbd ("xdp: add multi-buff support for xdp
running in generic mode") in v6.9-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1091860a16a86ccdd77c09f2b21a5f634f5ab9ec]
stable/6.12: [953200d56fc23eebf80a5ad9eed6e2e8a3065093]

CVE-2025-39985: can: mcba_usb: populate ndo_change_mtu() to prevent
buffer overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39985

Introduced by commit 51f3baa ("can: mcba_usb: Add support for
Microchip CAN BUS Analyzer") in v4.12-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [17c8d794527f01def0d1c8b7dc2d7b8d34fed0e6]
stable/5.10: [37aed407496bf6de8910e588edb04d2435fa7011]
stable/5.15: [6eec67bfb25637f9b51e584cf59ddace59925bc8]
stable/5.4: [0fa9303c4b9493727e0d3a6ac3729300e3013930]
stable/6.1: [ca4e51359608e1f29bf1f2c33c3ddf775b6b7ed1]
stable/6.12: [6b9fb82df8868dbe9ffea5874b8d35f951faedbb]
stable/6.6: [3664ae91b26d1fd7e4cee9cde17301361f4c89d5]

CVE-2025-39986: can: sun4i_can: populate ndo_change_mtu() to prevent
buffer overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39986

Introduced by commit 0738eff ("can: Allwinner A10/A20 CAN Controller
support - Kernel module") in v4.4-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61da0bd4102c459823fbe6b8b43b01fb6ace4a22]
stable/5.10: [4f382cc887adca8478b9d3e6b81aa6698a95fff4]
stable/5.15: [60463a1c138900494cb3adae41142a11cd8feb3c]
stable/5.4: [063539db42203b29d5aa2adf0cae3d68c646a6b6]
stable/6.1: [a61ff7ac93270d20ca426c027d6d01c8ac8e904c]
stable/6.12: [de77841652e57afbc46e9e1dbf51ee364fc008e1]
stable/6.6: [2e423e1990f3972cbea779883fef52c2f2acb858]

CVE-2025-39987: can: hi311x: populate ndo_change_mtu() to prevent
buffer overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39987

Introduced by commit 57e83fb ("can: hi311x: Add Holt HI-311x CAN
driver") in v4.12-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac1c7656fa717f29fac3ea073af63f0b9919ec9a]
stable/5.10: [8f351db6b2367991f0736b2cff082f5de4872113]
stable/5.15: [7ab85762274c0fa997f0ef9a2307b2001aae43c4]
stable/5.4: [f2c247e9581024d8b3dd44cbe086bf2bebbef42c]
stable/6.1: [57d332ce8c921d0e340650470bb0c1d707f216ee]
stable/6.12: [def814b4ba31b563584061d6895d5ff447d5bc14]
stable/6.6: [be1b25005fd0f9d4e78bec6695711ef87ee33398]

CVE-2025-39988: can: etas_es58x: populate ndo_change_mtu() to prevent
buffer overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39988

Introduced by commit 8537257 ("can: etas_es58x: add core support for
ETAS ES58X CAN USB interfaces") in v5.13-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38c0abad45b190a30d8284a37264d2127a6ec303]
stable/5.15: [72de0facc50afdb101fb7197d880407f1abfc77f]
stable/6.1: [c4e582e686c4d683c87f2b4a316385b3d81d370f]
stable/6.12: [b26cccd87dcddc47b450a40f3b1ac3fe346efcff]
stable/6.6: [cbc1de71766f326a44bb798aeae4a7ef4a081cc9]

CVE-2025-39990: bpf: Check the helper function is valid in get_helper_proto

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39990

Introduced commit is not determined.Fixed in v6.17-rc6.
The get_helper_proto was added by 45cbc7a ("bpf: add a
get_helper_proto() utility function") in 6.12-rc1. It looks as
versions prior to 6.12 appear to be affected as well.

Fixed status
mainline: [e4414b01c1cd9887bbde92f946c1ba94e40d6d64]
stable/6.12: [3d429cb1278e995e22995ef117fa96d223a67e93]

CVE-2025-39991: wifi: ath11k: fix NULL dereference in ath11k_qmi_m3_load()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39991

Introduced by commit 7db88b9 ("wifi: ath11k: add firmware-2.bin
support") in v6.7-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3fd2ef2ae2b5c955584a3bee8e83ae7d7a98f782]
stable/6.12: [1f52119809b76d43759fc47da1cf708690b740a1]

CVE-2025-39992: mm: swap: check for stable address space before
operating on the VMA

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39992

Introduced by commit d240629 ("fork: use __mt_dup() to duplicate maple
tree in dup_mmap()") in v6.8-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1367da7eb875d01102d2ed18654b24d261ff5393]
stable/6.12: [4e5f060d7347466f77aaff1c0d5a6c4f1fb217ac]

CVE-2025-39993: media: rc: fix races with imon_disconnect()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39993

Introduced by commit 21677cf ("V4L/DVB: ir-core: add imon driver") in
v2.6.35-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa0f61cc1d828178aa921475a9b786e7fbb65ccb]
stable/6.1: [71096a6161a25e84acddb89a9d77f138502d26ab]
stable/6.12: [fd5d3e6b149ec8cce045d86a2b5e3664d6b32ba5]
stable/6.6: [71da40648741d15b302700b68973fe8b382aef3c]

CVE-2025-39994: media: tuner: xc5000: Fix use-after-free in xc5000_release

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39994

Introduced by commit f7a27ff ("[media] xc5000: delay tuner sleep to 5
seconds") in v3.16-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40b7a19f321e65789612ebaca966472055dab48c]
stable/6.1: [df0303b4839520b84d9367c2fad65b13650a4d42]
stable/6.12: [effb1c19583bca7022fa641a70766de45c6d41ac]
stable/6.6: [71ed8b81a4906cb785966910f39cf7f5ad60a69e]

CVE-2025-39995: media: i2c: tc358743: Fix use-after-free bugs caused
by orphan timer in probe

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39995

Introduced by commit 869f38a ("media: i2c: tc358743: Fix crash in the
probe error path when using polling") in v6.13-rc1.
Introduced by commit d32d986 ("[media] Driver for Toshiba TC358743
HDMI to CSI-2 bridge") in v4.3-rc1.
Fixed in v6.18-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/5.4 stable/6.1
stable/6.12 stable/6.6

Fixed status
mainline: [79d10f4f21a92e459b2276a77be62c59c1502c9d]
stable/6.1: [3d17701c156579969470e58b3a906511f8bc018d]
stable/6.12: [f92181c0e13cad9671d07b15be695a97fc2534a3]
stable/6.6: [228d06c4cbfc750f1216a3fd91b4693b0766d2f6]

CVE-2025-39996: media: b2c2: Fix use-after-free causing by
irq_check_work in flexcop_pci_remove

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39996

Introduced by commit 382c554 ("V4L/DVB (10694): [PATCH] software IRQ
watchdog for Flexcop B2C2 DVB PCI cards") in v2.6.29-rc7.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01e03fb7db419d39e18d6090d4873c1bff103914]
stable/6.1: [d502df8a716d993fa0f9d8c00684f1190750e28e]
stable/6.12: [514a519baa9e2be7ddc2714bd730bc5a883e1244]
stable/6.6: [bb10a9ddc8d6c5dbf098f21eb1055a652652e524]

CVE-2025-39997: ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39997

Introduced by commit 0718a78 ("ALSA: usb-audio: Kill timer properly at
removal") in v6.16-rc1.
Fixed in v6.18-rc1.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.6

Fixed status
mainline: [9f2c0ac1423d5f267e7f1d1940780fc764b0fee3]
stable/6.12: [647d6b8d22be12842fde6ed0c56859ebc615f21e]
stable/6.6: [dc4874366cf6cf4a31d8fa4b7f0e2a5b2d7647ba]

CVE-2025-39998: scsi: target: target_core_configfs: Add length check
to avoid buffer overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39998

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [27e06650a5eafe832a90fd2604f0c5e920857fae]
stable/6.1: [e73fe0eefac3e15bf88fb5b4afae4c76215ee4d4]
stable/6.12: [53c6351597e6a17ec6619f6f060d54128cb9a187]
stable/6.6: [f03aa5e39da7d045615b3951d2a6ca1d7132f881]

CVE-2025-39999: blk-mq: fix blk_mq_tags double free while nr_requests grown

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39999

Introduced by commit f5a6604 ("block: fix lockdep warning caused by
lock dependency in elv_iosched_store") in v6.17-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba28afbd9eff2a6370f23ef4e6a036ab0cfda409]

CVE-2025-40000: wifi: rtw89: fix use-after-free in
rtw89_core_tx_kick_off_and_wait()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40000

Introduced by commit 1ae5ca6 ("wifi: rtw89: add function to wait for
completion of TX skbs") in v6.4-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e31a6bc07312b448fad3b45de578471f86f0e77]
stable/6.12: [895cccf639ac015f3d5f993218cf098db82ac145]


* Updated CVEs

CVE-2025-40364: io_uring: fix io_req_prep_async with provided buffers

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [a1b17713b32c75a90132ea2f92b1257f3bbc20f3,
233b210a678bddf8b49b02a070074a52b87e6d43]
stable/6.12: [35ae7910c349fb3c60439992e2e0e79061e95382]
stable/6.6: [a94592ec30ff67dc36c424327f1e0a9ceeeb9bd3,
b86f1d51731e621e83305dc9564ae14c9ef752bf]

CVE-2025-38105: ALSA: usb-audio: Kill timer properly at removal

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [c611b9e55174e439dcd85a72969b43a95f3827a4]
stable/6.6: [647410a7da46067953a53c0d03f8680eff570959]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

