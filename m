Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297EFCF8544
	for <webhook@archiver.kernel.org>; Wed,  2 Oct 2024 22:20:30 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.web11.6748.1727907626223041955
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 15:20:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=E1caZQsY;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.182, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e29d8b9fb5so2642717b3.3
        for <cip-dev@lists.cip-project.org>; Wed, 02 Oct 2024 15:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1727907625; x=1728512425; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7k59lgrw5NqbGfFmM5NJSQDEbYUS/yBLKJqeoJMZNnc=;
        b=E1caZQsY+VTpG8YyQvueb++z8YkF7fiBC1z/+r+3X/p1yJGZko+ehuxTYb94+tYBRX
         hvERavueTM/bYZ0Yy15TDqKTw7ED1sVNYccQYhyD08VftQxHAINblX7zPq/SVd1ehAIV
         x4TiotHye6wl7cnSaVedDppsu0daEBA2E8t6U9fjAv4AEYgoiJeMJWX9Ww1ntGuRCExR
         BLjDNFt7BidLVFwnP6hyK+12tktUGuNHl2rmvAUbGSB89IybIKWhJDCyI/dGTnu4JtJN
         jpf+l0STANubyzIf/V99vWi73eOvqOzricfJ55tjSbagAA3NfxNBzZq+Sb6Hs19scxoK
         CiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727907625; x=1728512425;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7k59lgrw5NqbGfFmM5NJSQDEbYUS/yBLKJqeoJMZNnc=;
        b=SnrCZ6KkRxS9jQuse39OGfWw7G7zjMv55YPjaTo/+VUo7p8P58yLS78n1TUAbKVRIs
         B/laka9qWQw6qOQ7lM4F6WzsEQf7K++fzdqM2rNl6HXrCua2cr30hEc1dOWMXzP/6iX9
         yLIjSualaX70Y4Wiz6kHGf7/c4zNvxY9nDeuAzGFEOXnP1FT5O04VtmmQGLq9EMCclA/
         vkrR4bBpexEkGrLKP33lqu969QNFAI6Lar6gzNjIY7FGO0jIngla/B//85VSV3pY2BjC
         q3+RW5ZRKXbQ4bn0jhqkpzSPq3iEymUTU3nJRfYOEHrFcsar8QDxUN1Um5tYWEyByrux
         ouvA==
X-Gm-Message-State: AOJu0Yyun1QOvpuTXIXIWoI+GxdbUZlwoke0RueXJmPITwmd9n4NJJMB
	QBAb4ACyArFiC32qiqo+itzzhM9co+JPIW8alD9cePYMMAUnbpQK7p8D1ExzutqdnmUguED6ysC
	9nHxJNxJKc3M1GErkLEi97gxXA6nfQ5Po3ghrh5iDt8N2ejfJdQw=
X-Google-Smtp-Source: AGHT+IEuUPLi0M4vv4YBWUPTXSBeJlauXKKIqdd8DnxG51KJH7HBG6w3ZMae9afN1mKXDLbnTFlm7t3aBsxT4yqGOUY=
X-Received: by 2002:a05:690c:2d12:b0:6e2:767:8a64 with SMTP id
 00721157ae682-6e2a2e12e6cmr34190797b3.37.1727907623365; Wed, 02 Oct 2024
 15:20:23 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 3 Oct 2024 07:19:47 +0900
Message-ID: <CAODzB9oWYON_iFimAm2wmB1EhiXRaUSAizcRo00XEcAWO_w7RQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Oct 2024 22:20:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16981

Hi!

It's this week's CVE report.

This week reported 68 new CVEs and 81 updated CVEs.

* New CVEs
CVE-2024-46802: drm/amd/display: added NULL check at start of dc_validate_stream

Announce: https://lore.kernel.org/linux-cve-announce/2024092706-CVE-2024-46802-c5e1@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
Affected function was added by commit 9345d98 ("drm/amd/display: Move stream
validations into seperate function.") in 4.15-rc1.

Fixed status
mainline: [26c56049cc4f1705b498df013949427692a4b0d5]
stable/6.1: [356fcce9cdbfe338a275e9e1836adfdd7f5c52a9]
stable/6.6: [154a50bf4221a6a6ccf88d565b8184da7c40a2dd]

CVE-2024-46803: drm/amdkfd: Check debug trap enable before write dbg_ev_file

Announce: https://lore.kernel.org/linux-cve-announce/2024092708-CVE-2024-46803-689b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
The kfd_dbg_trap_disable() was added by commit 0ab2d7532 ("drm/amdkfd: prepare
per-process debug enable and disable") in 6.5-rc1. The
debug_event_write_work_handler()
was added by commit 44b87bb083 ("drm/amdkfd: add raise exception event
function") in 6.5-rc1.

Fixed status
mainline: [547033b593063eb85bfdf9b25a5f1b8fd1911be2]
stable/6.6: [e6ea3b8fe398915338147fe54dd2db8155fdafd8]

CVE-2024-46804: drm/amd/display: Add array index check for hdcp ddc access

Announce: https://lore.kernel.org/linux-cve-announce/2024092708-CVE-2024-46804-c90d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
Affected functions were added by commit 4c283fdac0 ("drm/amd/display:
Add HDCP module") in 5.5-rc1. The checking msg_id logic was added by commit
59d99deb3 ("drm/amd/display: Check index msg_id before read or write")
in 6.10-rc1.

Fixed status
mainline: [4e70c0f5251c25885c31ee84a31f99a01f7cf50e]
stable/5.10: [2a63c90c7a90ab2bd23deebc2814fc5b52abf6d2]
stable/5.15: [0ee4387c5a4b57ec733c3fb4365188d5979cd9c7]
stable/6.1: [f338f99f6a04d03c802087d82a83561cbd5bdc99]
stable/6.6: [8b5ccf3d011969417be653b5a145c72dbd30472c]

CVE-2024-46805: drm/amdgpu: fix the waring dereferencing hive

Announce: https://lore.kernel.org/linux-cve-announce/2024092709-CVE-2024-46805-b06a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
Affected function was added by commit 44357a1b ("drm/amdgpu: get extended xgmi
topology data") in 5.15-rc1.

Fixed status
mainline: [1940708ccf5aff76de4e0b399f99267c93a89193]
stable/5.15: [f20d1d5cbb39802f68be24458861094f3e66f356]
stable/6.1: [01cd55b971131b07b7ff8d622fa93bb4f8be07df]
stable/6.6: [4ab720b6aa1ef5e71db1e534b5b45c80ac4ec58a]

CVE-2024-46806: drm/amdgpu: Fix the warning division or modulo by zero

Announce: https://lore.kernel.org/linux-cve-announce/2024092709-CVE-2024-46806-2cc7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit 570de94b ("drm/amdgpu: Add
auto mode for compute partition") in 6.5-rc1.

Fixed status
mainline: [1a00f2ac82d6bc6689388c7edcd2a4bd82664f3c]
stable/6.6: [d116bb921e8b104f45d1f30a473ea99ef4262b9a]

CVE-2024-46807: drm/amd/amdgpu: Check tbo resource pointer

Announce: https://lore.kernel.org/linux-cve-announce/2024092709-CVE-2024-46807-b78e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit d3116756 ("drm/ttm: rename
bo->mem and make it a pointer") in 5.14-rc1.

Fixed status
mainline: [6cd2b872643bb29bba01a8ac739138db7bd79007]
stable/5.15: [e55e3904ffeaff81715256a711b1a61f4ad5258a]
stable/6.1: [2be1eb6304d9623ba21dd6f3e68ffb753a759635]
stable/6.6: [4dfec5f5501a27e0a0da00e136d65ef9011ded4c]

CVE-2024-46808: drm/amd/display: Add missing NULL pointer check within
dpcd_extend_address_range

Announce: https://lore.kernel.org/linux-cve-announce/2024092709-CVE-2024-46808-8886@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit 30adeee5 ("drm/amd/display:
Enforce DPCD Address ranges") in 5.14-rc1.

Fixed status
mainline: [5524fa301ba649f8cf00848f91468e0ba7e4f24c]

CVE-2024-46809: drm/amd/display: Check BIOS images before it is used

Announce: https://lore.kernel.org/linux-cve-announce/2024092710-CVE-2024-46809-5b37@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
Affected file was added by commit 4562236b3bc ("drm/amd/dc: Add dc display
driver (v2)") in 4.15-rc1.

Fixed status
mainline: [8b0ddf19cca2a352b2a7e01d99d3ba949a99c84c]
stable/6.6: [e50bec62acaeec03afc6fa5dfb2426e52d049cf5]

CVE-2024-46810: drm/bridge: tc358767: Check if fully initialized
before signalling HPD event via IRQ

Announce: https://lore.kernel.org/linux-cve-announce/2024092710-CVE-2024-46810-2eb3@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
This bug was introduced by commit f25ee50 ("drm/bridge: tc358767: add IRQ and
HPD support") in 5.3-rc1.

Fixed status
mainline: [162e48cb1d84c2c966b649b8ac5c9d4f75f6d44f]
stable/5.15: [adc5674c23b8191e596ed0dbaa9600265ac896a8]
stable/6.1: [e1b121f21bbc56a6ae035aa5b77daac62bfb9be5]
stable/6.6: [9d567126474e68f959b2c2543c375f3bb32e948a]

CVE-2024-46811: drm/amd/display: Fix index may exceed array range
within fpu_update_bw_bounding_box

Announce: https://lore.kernel.org/linux-cve-announce/2024092710-CVE-2024-46811-f01c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
This CVE was introduced by following commits.
f369e4eba8 ("drm/amd/display: move FPU associated DCN302 code to DML
folder (#2266)") in 5.18-rc1.
53923e62af ("drm/amd/display: move FPU associated DCN303 code to DML
folder") in 5.18-rc1.
235c676342 ("drm/amd/display: add DCN32/321 specific files for Display
Core") in 6.0-rc1.
265280b998 ("drm/amd/display: add CLKMGR changes for DCN32/321") in 6.0-rc1.

Fixed status
mainline: [188fd1616ec43033cedbe343b6579e9921e2d898]
stable/6.6: [4003bac784380fed1f94f197350567eaa73a409d]

CVE-2024-46812: drm/amd/display: Skip inactive planes within
ModeSupportAndSystemConfiguration

Announce: https://lore.kernel.org/linux-cve-announce/2024092710-CVE-2024-46812-5954@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit dda4fb85 ("drm/amd/display:
DML changes for DCN32/321") in 6.0-rc1.

Fixed status
mainline: [a54f7e866cc73a4cb71b8b24bb568ba35c8969df]
stable/6.1: [3300a039caf850376bc3416c808cd8879da412bb]
stable/6.6: [8406158a546441b73f0b216aedacbf9a1e5748fb]

CVE-2024-46813: drm/amd/display: Check link_index before accessing dc->links[]

Announce: https://lore.kernel.org/linux-cve-announce/2024092711-CVE-2024-46813-5eb9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit 7ae1dbe
("drm/amd/display: merge
dc_link.h into dc.h and dc_types.h") in 6.4-rc1.

Fixed status
mainline: [8aa2864044b9d13e95fe224f32e808afbf79ecdf]

CVE-2024-46814: drm/amd/display: Check msg_id before processing transcation

Announce: https://lore.kernel.org/linux-cve-announce/2024092711-CVE-2024-46814-5021@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit 4c283fd ("drm/amd/display:
Add HDCP module") in 5.5-rc1.

Fixed status
mainline: [fa71face755e27dc44bc296416ebdf2c67163316]
stable/5.10: [916083054670060023d3f8a8ace895d710e268f4]
stable/5.15: [fe63daf7b10253b0faaa60c55d6153cd276927aa]
stable/6.1: [0147505f08220c89b3a9c90eb608191276e263a8]
stable/6.6: [cb63090a17d3abb87f132851fa3711281249b7d2]

CVE-2024-46815: drm/amd/display: Check num_valid_sets before accessing
reader_wm_sets[]

Announce: https://lore.kernel.org/linux-cve-announce/2024092711-CVE-2024-46815-fce2@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit 622a88c ("drm/amd/display:
move wm ranges reporting to end of init hw") in 5.5-rc1.

Fixed status
mainline: [b38a4815f79b87efb196cd5121579fc51e29a7fb]
stable/5.10: [7c47dd2e92341f2989ab73dbed07f8894593ad7b]
stable/5.15: [c4a7f7c0062fe2c73f70bb7e335199e25bd71492]
stable/5.4: [a72d4996409569027b4609414a14a87679b12267]
stable/6.1: [b36e9b3104c4ba0f2f5dd083dcf6159cb316c996]
stable/6.6: [21f9cb44f8c60bf6c26487d428b1a09ad3e8aebf]

CVE-2024-46816: drm/amd/display: Stop amdgpu_dm initialize when link
nums greater than max_links

Announce: https://lore.kernel.org/linux-cve-announce/2024092711-CVE-2024-46816-0526@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit 4562236b3b ("drm/amd/dc: Add dc
display driver (v2)") in 4.15-rc1.

Fixed status
mainline: [cf8b16857db702ceb8d52f9219a4613363e2b1cf]

CVE-2024-46817: drm/amd/display: Stop amdgpu_dm initialize when stream
nums greater than 6

Announce: https://lore.kernel.org/linux-cve-announce/2024092712-CVE-2024-46817-7a2c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if this bug was introduced by commit 54087768 ("drm/amd/display:
Only put primary planes into the mode_info->planes list") in 5.2-rc1.

Fixed status
mainline: [84723eb6068c50610c5c0893980d230d7afa2105]
stable/5.10: [754321ed63f0a4a31252ca72e0bd89a9e1888018]
stable/5.15: [21bbb39863f10f5fb4bf772d15b07d5d13590e9d]
stable/5.4: [d619b91d3c4af60ac422f1763ce53d721fb91262]
stable/6.1: [28b515c458aa9c92bfcb99884c94713a5f471cea]
stable/6.6: [94cb77700fa4ae6200486bfa0ba2ac547534afd2]

CVE-2024-46818: drm/amd/display: Check gpio_id before used as array index

Announce: https://lore.kernel.org/linux-cve-announce/2024092712-CVE-2024-46818-8d41@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
Affected file was added by commit 4562236b ("drm/amd/dc: Add dc
display driver (v2)")
in 4.15-rc1.

Fixed status
mainline: [2a5626eeb3b5eec7a36886f9556113dd93ec8ed6]
stable/5.10: [40c2e8bc117cab8bca8814735f28a8b121654a84]
stable/5.15: [0184cca30cad74d88f5c875d4e26999e26325700]
stable/5.4: [8520fdc8ecc38f240a8e9e7af89cca6739c3e790]
stable/6.1: [276e3fd93e3beb5894eb1cc8480f9f417d51524d]
stable/6.6: [08e7755f754e3d2cef7d3a7da538d33526bd6f7c]

CVE-2024-46819: drm/amdgpu: the warning dereferencing obj for nbio_v7_4

Announce: https://lore.kernel.org/linux-cve-announce/2024092712-CVE-2024-46819-d958@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit f75e94d ("drm/amdgpu: bypass
querying ras error count registers") in 5.10-rc1.

Fixed status
mainline: [d190b459b2a4304307c3468ed97477b808381011]
stable/5.10: [614564a5b28983de53b23a358ebe6c483a2aa21e]
stable/5.15: [d04ded1e73f1dcf19a71ec8b9cda3faa7acd8828]
stable/6.1: [70e8ec21fcb8c51446899d3bfe416b31adfa3661]
stable/6.6: [7d265772e44d403071a2b573eac0db60250b1c21]

CVE-2024-46820: drm/amdgpu/vcn: remove irq disabling in vcn 5 suspend

Announce: https://lore.kernel.org/linux-cve-announce/2024092712-CVE-2024-46820-6405@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
This bug was introduced by commit b6d1a06 ("drm/amdgpu: add VCN_5_0_0 IP block
support") in 6.9-rc1.

Fixed status
mainline: [10fe1a79cd1bff3048e13120e93c02f8ecd05e9d]

CVE-2024-46821: drm/amd/pm: Fix negative array index read

Announce: https://lore.kernel.org/linux-cve-announce/2024092713-CVE-2024-46821-a13a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
Affected file was added by commit b3490673f9 ("drm/amd/powerplay: introduce the
navi10 pptable implementation") in 5.3-rc1.

Fixed status
mainline: [c8c19ebf7c0b202a6a2d37a52ca112432723db5f]
stable/6.1: [60f4a4bc3329e5cb8c4df0cc961f0d5ffd96e22d]
stable/6.6: [4711b1347cb9f0c3083da6d87c624d75f9bd1d50]

CVE-2024-46822: arm64: acpi: Harden get_cpu_for_acpi_id() against
missing CPU entry

Announce: https://lore.kernel.org/linux-cve-announce/2024092749-CVE-2024-46822-b901@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit e1896249 ("arm64:
numa: rework ACPI
NUMA initialization") in 4.19-rc1.

Fixed status
mainline: [2488444274c70038eb6b686cba5f1ce48ebb9cdd]
stable/5.10: [4c3b21204abb4fa3ab310fbbb5cf7f0e85f3a1bc]
stable/5.15: [945be49f4e832a9184c313fdf8917475438a795b]
stable/5.4: [f57769ff6fa7f97f1296965f20e8a2bb3ee9fd0f]
stable/6.1: [40cae0df42e5e7f7a1c0f32deed9c4027c1ba94e]
stable/6.6: [62ca6d3a905b4c40cd942f3cc645a6718f8bc7e7]

CVE-2024-46823: kunit/overflow: Fix UB in overflow_allocation_test

Announce: https://lore.kernel.org/linux-cve-announce/2024092750-CVE-2024-46823-b19e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc4.
It looks as if this bug was introduced by commit ca90800a
("test_overflow: Add memory
allocation overflow tests") in 4.18-rc1.

Fixed status
mainline: [92e9bac18124682c4b99ede9ee3bcdd68f121e92]

CVE-2024-46824: iommufd: Require drivers to supply the cache_invalidate_user ops

Announce: https://lore.kernel.org/linux-cve-announce/2024092750-CVE-2024-46824-03d9@gregkh/

Introduced by commit 8c6eaba ("iommufd: Add IOMMU_HWPT_INVALIDATE") in v6.8-rc1.
Fixed in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a11dda723c6493bb1853bbc61c093377f96e2d47]

CVE-2024-46825: wifi: iwlwifi: mvm: use IWL_FW_CHECK for link ID check

Announce: https://lore.kernel.org/linux-cve-announce/2024092750-CVE-2024-46825-a5aa@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
Vulnerable function was added by commit d464550b ("wifi: iwlwifi: mvm: use link
ID in missed beacon notification") in 6.5-rc1.

Fixed status
mainline: [9215152677d4b321801a92b06f6d5248b2b4465f]
stable/6.6: [415f3634d53c7fb4cf07d2f5a0be7f2e15e6da33]

CVE-2024-46826: ELF: fix kernel.randomize_va_space double read

Announce: https://lore.kernel.org/linux-cve-announce/2024092750-CVE-2024-46826-7b80@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
All stable/LTS kernels are affected.

Fixed status
mainline: [2a97388a807b6ab5538aa8f8537b2463c6988bd2]
stable/6.1: [1f81d51141a234ad0a3874b4d185dc27a521cd27]
stable/6.6: [53f17409abf61f66b6f05aff795e938e5ba811d1]

CVE-2024-46827: wifi: ath12k: fix firmware crash due to invalid peer nss

Announce: https://lore.kernel.org/linux-cve-announce/2024092751-CVE-2024-46827-0300@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
Vulnerable function was added by commit d8899132 ("wifi: ath12k: driver for
Qualcomm Wi-Fi 7 devices") in 6.3-rc1.

Fixed status
mainline: [db163a463bb93cd3e37e1e7b10b9726fb6f95857]
stable/6.6: [838c2cfdb6be7d7d8c06c711edf893eb34ca2e7c]

CVE-2024-46828: sched: sch_cake: fix bulk flow accounting logic for
host fairness

Announce: https://lore.kernel.org/linux-cve-announce/2024092751-CVE-2024-46828-2184@gregkh/

Introduced by commit 7126399 ("sch_cake: Make the dual modes fairer")
in v5.1-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [546ea84d07e3e324644025e2aae2d12ea4c5896e]
stable/5.10: [7725152b54d295b7da5e34c2f419539b30d017bd]
stable/5.15: [cde71a5677971f4f1b69b25e854891dbe78066a4]
stable/5.4: [4a4eeefa514db570be025ab46d779af180e2c9bb]
stable/6.1: [549e407569e08459d16122341d332cb508024094]
stable/6.6: [d4a9039a7b3d8005b90c7b1a55a306444f0e5447]

CVE-2024-46829: rtmutex: Drop rt_mutex::wait_lock before scheduling

Announce: https://lore.kernel.org/linux-cve-announce/2024092751-CVE-2024-46829-da70@gregkh/

Introduced by commit 3d5c934 ("rtmutex: Handle deadlock detection
smarter") in v3.16-rc2.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d33d26036a0274b472299d7dcdaa5fb34329f91b]
stable/4.19: [432efdbe7da5ecfcbc0c2180cfdbab1441752a38]
stable/5.10: [1401da1486dc1cdbef6025fd74a3977df3a3e5d0]
stable/5.15: [93f44655472d9cd418293d328f9d141ca234ad83]
stable/5.4: [6a976e9a47e8e5b326de671811561cab12e6fb1f]
stable/6.1: [a92d81c9efec9280681c27a2c0a963fd0f1338e0]
stable/6.6: [85f03ca98e07cd0786738b56ae73740bce0ac27f]

CVE-2024-46830: KVM: x86: Acquire kvm->srcu when handling KVM_SET_VCPU_EVENTS

Announce: https://lore.kernel.org/linux-cve-announce/2024092751-CVE-2024-46830-deac@gregkh/

Introduced by commit f7e5707 ("KVM: x86: Forcibly leave nested virt
when SMM state is toggled") in v5.17-rc2.
Fixed in v6.11-rc7.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [4bcdd831d9d01e0fb64faea50732b59b2ee88da1]
stable/6.1: [fa297c33faefe51e10244e8a378837fca4963228]
stable/6.6: [939375737b5a0b1bf9b1e75129054e11bc9ca65e]

CVE-2024-46831: net: microchip: vcap: Fix use-after-free error in kunit test

Announce: https://lore.kernel.org/linux-cve-announce/2024092752-CVE-2024-46831-06bf@gregkh/

Introduced by commit c956b9b ("net: microchip: sparx5: Adding KUNIT
tests of key/action values in VCAP API") in v6.2-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3c1e45156ad39f225cd7ddae0f81230a3b1e657]
stable/6.6: [b0804c286ccfcf5f5c004d5bf8a54c0508b5e86b]

CVE-2024-46832: MIPS: cevt-r4k: Don't call get_c0_compare_int if timer
irq is installed

Announce: https://lore.kernel.org/linux-cve-announce/2024092752-CVE-2024-46832-3ad0@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc5.
CIP does not support MIPS architecture

Fixed status
mainline: [50f2b98dc83de7809a5c5bf0ccf9af2e75c37c13]
stable/5.10: [d3ff0f98a52f0aafe35aa314d1c442f4318be3db]
stable/5.15: [e6cd871627abbb459d0ff6521d6bb9cf9d9f7522]
stable/6.1: [b1d2051373bfc65371ce4ac8911ed984d0178c98]
stable/6.6: [32ee0520159f1e8c2d6597c19690df452c528f30]

CVE-2024-46833: net: hns3: void array out of bound when loop tnl_num

Announce: https://lore.kernel.org/linux-cve-announce/2024092752-CVE-2024-46833-0fa0@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc4.
This bug was introduced by commit 8a4bda8c ("net: hns3: dump more reg info based
on ras mod") in 6.10-rc1.

Fixed status
mainline: [86db7bfb06704ef17340eeae71c832f21cfce35c]

CVE-2024-46834: ethtool: fail closed if we can't get max channel used
in indirection tables

Announce: https://lore.kernel.org/linux-cve-announce/2024092752-CVE-2024-46834-dc7b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [2899d58462ba868287d6ff3acad3675e7adf934f]

CVE-2024-46835: drm/amdgpu: Fix smatch static checker warning

Announce: https://lore.kernel.org/linux-cve-announce/2024092753-CVE-2024-46835-4f99@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
Vulnerable function was added by commit 3d879e81f ("drm/amdgpu: add init support
for GFX11 (v2)") in 5.19-rc1.

Fixed status
mainline: [bdbdc7cecd00305dc844a361f9883d3a21022027]
stable/6.1: [d40c2c3dd0395fe7fdc19bd96551e87251426d66]
stable/6.6: [8bc7b3ce33e64c74211ed17aec823fc4e523426a]

CVE-2024-46836: usb: gadget: aspeed_udc: validate endpoint index for ast udc

Announce: https://lore.kernel.org/linux-cve-announce/2024092753-CVE-2024-46836-acff@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
Vulnerable function was added by commit 055276c1 ("usb: gadget: add Aspeed
ast2600 udc driver") in 6.0-rc1.

Fixed status
mainline: [ee0d382feb44ec0f445e2ad63786cd7f3f6a8199]
stable/6.1: [31bd4fab49c0adc6228848357c1b1df9395858af]
stable/6.6: [b2a50ffdd1a079869a62198a8d1441355c513c7c]

CVE-2024-46837: drm/panthor: Restrict high priorities on group_create

Announce: https://lore.kernel.org/linux-cve-announce/2024092753-CVE-2024-46837-c69f@gregkh/

Introduced by commit de85488 ("drm/panthor: Add the scheduler logical
block") in v6.10-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f7762042f8a5377bd8a32844db353c0311a7369]

CVE-2024-46838: userfaultfd: don't BUG_ON() if khugepaged yanks our page table

Announce: https://lore.kernel.org/linux-cve-announce/2024092753-CVE-2024-46838-5fa5@gregkh/

Introduced by commit 1d65b77 ("mm/khugepaged: retract_page_tables()
without mmap or vma lock") in v6.6-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4828d207dc5161dc7ddf9a4f6dcfd80c7dd7d20a]
stable/6.6: [4a594acc12d5954cdc71d4450a386748bf3d136a]

CVE-2024-46839: workqueue: Improve scalability of workqueue watchdog touch

Announce: https://lore.kernel.org/linux-cve-announce/2024092754-CVE-2024-46839-cfab@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.

Fixed status
mainline: [98f887f820c993e05a12e8aa816c80b8661d4c87]
stable/5.15: [9d08fce64dd77f42e2361a4818dbc4b50f3c7dad]
stable/6.1: [a2abd35e7dc55bf9ed01e2b3481fa78e086d3bf4]
stable/6.6: [241bce1c757d0587721512296952e6bba69631ed]

CVE-2024-46840: btrfs: clean up our handling of refs == 0 in snapshot delete

Announce: https://lore.kernel.org/linux-cve-announce/2024092754-CVE-2024-46840-fc44@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It seems as if 4.4 is affected.

Fixed status
mainline: [b8ccef048354074a548f108e51d0557d6adfd3a3]
stable/4.19: [c847b28a799733b04574060ab9d00f215970627d]
stable/5.10: [c60676b81fab456b672796830f6d8057058f029c]
stable/5.15: [728d4d045b628e006b48a448f3326a7194c88d32]
stable/5.4: [71291aa7246645ef622621934d2067400380645e]
stable/6.1: [9cc887ac24b7a0598f4042ae9af6b9a33072f75b]
stable/6.6: [7d1df13bf078ffebfedd361d714ff6cee1ff01b9]

CVE-2024-46841: btrfs: don't BUG_ON on ENOMEM from
btrfs_lookup_extent_info() in walk_down_proc()

Announce: https://lore.kernel.org/linux-cve-announce/2024092754-CVE-2024-46841-7572@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
This bug was introduced by commit 79787eaa ("btrfs: replace many BUG_ONs with
proper error handling") in 3.4-rc1.

Fixed status
mainline: [a580fb2c3479d993556e1c31b237c9e5be4944a3]

CVE-2024-46842: scsi: lpfc: Handle mailbox timeouts in lpfc_get_sfp_info

Announce: https://lore.kernel.org/linux-cve-announce/2024092754-CVE-2024-46842-e52c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit 479b0917e ("scsi:
lpfc: Create a
sysfs entry called lpfc_xcvr_data for transceiver info") in 6.2-rc1.

Fixed status
mainline: [ede596b1434b57c0b3fd5c02b326efe5c54f6e48]

CVE-2024-46843: scsi: ufs: core: Remove SCSI host only if added

Announce: https://lore.kernel.org/linux-cve-announce/2024092755-CVE-2024-46843-82c5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
It looks as if this bug was introduced by commit 0cab4023 ("scsi: ufs:
core: Defer
adding host to SCSI if MCQ is supported") in 6.3-rc1.

Fixed status
mainline: [7cbff570dbe8907e23bba06f6414899a0fbb2fcc]
stable/6.6: [2f49e05d6b58d660f035a75ff96b77071b4bd5ed]

CVE-2024-46844: um: line: always fill *error_out in setup_one_line()

Announce: https://lore.kernel.org/linux-cve-announce/2024092755-CVE-2024-46844-af64@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc1.
CIP does not support um architecture.

Fixed status
mainline: [824ac4a5edd3f7494ab1996826c4f47f8ef0f63d]
stable/4.19: [3bedb7ce080690d0d6172db790790c1219bcbdd5]
stable/5.10: [c8944d449fda9f58c03bd99649b2df09948fc874]
stable/5.15: [43f782c27907f306c664b6614fd6f264ac32cce6]
stable/5.4: [96301fdc2d533a196197c055af875fe33d47ef84]
stable/6.1: [289979d64573f43df1d0e6bc6435de63a0d69cdf]
stable/6.6: [ec5b47a370177d79ae7773858042c107e21f8ecc]

CVE-2024-46845: tracing/timerlat: Only clear timer if a kthread exists

Announce: https://lore.kernel.org/linux-cve-announce/2024092755-CVE-2024-46845-a529@gregkh/

Introduced by commit e88ed22 ("tracing/timerlat: Add user-space
interface") in v6.5-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6a53481da292d970d1edf0d8831121d1c5e2f0d]
stable/6.6: [8c72f0b2c45f21cb8b00fc37f79f632d7e46c2ed]

CVE-2024-46846: spi: rockchip: Resolve unbalanced runtime PM / system
PM handling

Announce: https://lore.kernel.org/linux-cve-announce/2024092755-CVE-2024-46846-f264@gregkh/

Introduced by commit e882575 ("spi: rockchip: Suspend and resume the
bus during NOIRQ_SYSTEM_SLEEP_PM ops") in v5.18-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be721b451affbecc4ba4eaac3b71cdbdcade1b1b]
stable/6.1: [14f970a8d03d882b15b97beb83bd84ac8ba6298c]
stable/6.6: [d034bff62faea1a2219e0d2f3d17263265f24087]

CVE-2024-46847: mm: vmalloc: ensure vmap_block is initialised before
adding to queue

Announce: https://lore.kernel.org/linux-cve-announce/2024092756-CVE-2024-46847-e469@gregkh/

Introduced by commit 8c61291 ("mm: fix incorrect vbq reference in
purge_fragmented_block") in v6.10-rc6.
Fixed in v6.11-rc7.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [3e3de7947c751509027d26b679ecd243bc9db255]
stable/6.6: [1b2770e27d6d952f491bb362b657e5b2713c3efd]

CVE-2024-46848: perf/x86/intel: Limit the period on Haswell

Announce: https://lore.kernel.org/linux-cve-announce/2024092756-CVE-2024-46848-bbd4@gregkh/

Introduced by commit 3a632cb ("perf/x86/intel: Add simple Haswell PMU
support") in v3.11-rc1.
Fixed in v6.11-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25dfc9e357af8aed1ca79b318a73f2c59c1f0b2b]
stable/6.1: [15210b7c8caff4929f25d049ef8404557f8ae468]
stable/6.6: [0eaf812aa1506704f3b78be87036860e5d0fe81d]

CVE-2024-46849: ASoC: meson: axg-card: fix 'use-after-free'

Announce: https://lore.kernel.org/linux-cve-announce/2024092741-CVE-2024-46849-93c5@gregkh/

Introduced by commit 7864a79 ("ASoC: meson: add axg sound card
support") in v4.19-rc1.
Fixed in v6.11.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f9a71435953f941969a4f017e2357db62d85a86]
stable/6.1: [e1a199ec31617242e1a0ea8f312341e682d0c037]
stable/6.6: [e43364f578cdc2f8083abbc0cb743ea55e827c29]

CVE-2024-46850: drm/amd/display: Avoid race between dcn35_set_drr()
and dc_state_destruct()

Announce: https://lore.kernel.org/linux-cve-announce/2024092742-CVE-2024-46850-186e@gregkh/

Introduced by commit 06ad7e1 ("drm/amd/display: Destroy DC context
while keeping DML and DML2") in v6.7-rc1.
Fixed in v6.11.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e835d5144f5ef78e4f8828c63e2f0d61144f283a]

CVE-2024-46851: drm/amd/display: Avoid race between dcn10_set_drr()
and dc_state_destruct()

Announce: https://lore.kernel.org/linux-cve-announce/2024092742-CVE-2024-46851-125b@gregkh/

Introduced by commit 06ad7e1 ("drm/amd/display: Destroy DC context
while keeping DML and DML2") in v6.7-rc1.
Fixed in v6.11.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7aeb03888b92304e2fc7d4d1c242f54a312561b]

CVE-2024-46852: dma-buf: heaps: Fix off-by-one in CMA heap fault handler

Announce: https://lore.kernel.org/linux-cve-announce/2024092742-CVE-2024-46852-91a5@gregkh/

Introduced by commit a5d2d29 ("dma-buf: heaps: Move heap-helper logic
into the cma_heap implementation") in v5.11-rc1.
Fixed in v6.11.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea5ff5d351b520524019f7ff7f9ce418de2dad87]
stable/6.1: [84175dc5b2c932266a50c04e5ce342c30f817a2f]
stable/6.6: [eb7fc8b65cea22f9038c52398c8b22849e9620ea]

CVE-2024-46853: spi: nxp-fspi: fix the KASAN report out-of-bounds bug

Announce: https://lore.kernel.org/linux-cve-announce/2024092742-CVE-2024-46853-ab04@gregkh/

Introduced by commit a5356ae ("spi: spi-mem: Add driver for NXP
FlexSPI controller") in v5.1-rc1.
Fixed in v6.11.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a8787c1cdc7be24fdd8953ecd1a8743a1006235]
stable/6.1: [09af8b0ba70072be831f3ec459f4063d570f9e24]
stable/6.6: [af9ca9ca3e44f48b2a191e100d452fbf850c3d87]

CVE-2024-46854: net: dpaa: Pad packets to ETH_ZLEN

Announce: https://lore.kernel.org/linux-cve-announce/2024092743-CVE-2024-46854-3404@gregkh/

Introduced by commit 9ad1a37 ("dpaa_eth: add support for DPAA
Ethernet") in v4.10-rc1.
Fixed in v6.11.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbd7ec083413c6a2e0c326d49e24ec7d12c7a9e0]
stable/6.1: [f43190e33224c49e1c7ebbc25923ff400d87ec00]
stable/6.6: [34fcac26216ce17886af3eb392355b459367af1a]

CVE-2024-46855: netfilter: nft_socket: fix sk refcount leaks

Announce: https://lore.kernel.org/linux-cve-announce/2024092743-CVE-2024-46855-4382@gregkh/

Introduced by commit 039b1f4 ("netfilter: nft_socket: fix erroneous
socket assignment") in v5.3.
Fixed in v6.11.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt stable/4.19

Fixed status
mainline: [8b26ff7af8c32cb4148b3e147c52f9e4c695209c]
stable/6.1: [33c2258bf8cb17fba9e58b111d4c4f4cf43a4896]
stable/6.6: [83e6fb59040e8964888afcaa5612cc1243736715]

CVE-2024-46856: net: phy: dp83822: Fix NULL pointer dereference on
DP83825 devices

Announce: https://lore.kernel.org/linux-cve-announce/2024092743-CVE-2024-46856-c304@gregkh/

Introduced by commit 9ef9ecf ("net: phy: dp8382x: keep WOL settings
across suspends") in v6.10-rc1.
Fixed in v6.11.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f62ea572b3e8e3f10c39a9cb4f04ca9ae5f2952]

CVE-2024-46857: net/mlx5: Fix bridge mode operations when there are no VFs

Announce: https://lore.kernel.org/linux-cve-announce/2024092743-CVE-2024-46857-3bc3@gregkh/

Introduced by commit 4b89251 ("net/mlx5: Support ndo bridge_setlink
and getlink") in v5.1-rc1.
Fixed in v6.11.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1d305abef4640af1b4f1b4774d513cd81b10cfc]
stable/6.1: [52c4beb79e095e0631b5cac46ed48a2aefe51985]
stable/6.6: [65feee671e37f3b6eda0b6af28f204b5bcf7fa50]

CVE-2024-46858: mptcp: pm: Fix uaf in __timer_delete_sync

Announce: https://lore.kernel.org/linux-cve-announce/2024092744-CVE-2024-46858-dab6@gregkh/

Introduced by commit 00cfd77 ("mptcp: retransmit ADD_ADDR when
timeout") in v5.10-rc1.
Fixed in v6.11.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4cd80b0338945a94972ac3ed54f8338d2da2076]
stable/6.1: [67409b358500c71632116356a0b065f112d7b707]
stable/6.6: [6452b162549c7f9ef54655d3fb9977b9192e6e5b]

CVE-2024-46859: platform/x86: panasonic-laptop: Fix SINF array out of
bounds accesses

Announce: https://lore.kernel.org/linux-cve-announce/2024092744-CVE-2024-46859-e785@gregkh/

Introduced by commit e424fb8 ("panasonic-laptop: avoid overflow in
acpi_pcc_hotkey_add()") in v3.3.
Fixed in v6.11.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f52e98d16e9bd7dd2b3aef8e38db5cbc9899d6a4]
stable/6.1: [9291fadbd2720a869b1d2fcf82305648e2e62a16]
stable/6.6: [6821a82616f60aa72c5909b3e252ad97fb9f7e2a]

CVE-2024-46860: wifi: mt76: mt7921: fix NULL pointer access in
mt7921_ipv6_addr_change

Announce: https://lore.kernel.org/linux-cve-announce/2024092744-CVE-2024-46860-1dfc@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc4.
Vulnerable function was added by commit 5fc201aa ("mt76: mt7921: add
ipv6 NS offload
support") in 5.19-rc1.

Fixed status
mainline: [479ffee68d59c599f8aed8fa2dcc8e13e7bd13c3]
stable/6.6: [4bfee9346d8c17d928ef6da2b8bffab88fa2a553]

CVE-2024-46861: usbnet: ipheth: do not stop RX on failing RX callback

Announce: https://lore.kernel.org/linux-cve-announce/2024092744-CVE-2024-46861-f2f9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.11-rc4.

Fixed status
mainline: [74efed51e0a4d62f998f806c307778b47fc73395]
stable/6.6: [4d1cfa3afb8627435744ecdc6d8b58bc72ee0f4c]

CVE-2024-46862: ASoC: Intel: soc-acpi-intel-mtl-match: add missing empty item

Announce: https://lore.kernel.org/linux-cve-announce/2024092745-CVE-2024-46862-eb45@gregkh/

Introduced by commit f77ae7f ("ASoC: Intel: soc-acpi-intel-mtl-match:
add cs42l43 only support") in v6.10-rc1.
Fixed in v6.11.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf6d7a44a144aa9c476dee83c23faf3151181bab]

CVE-2024-46863: ASoC: Intel: soc-acpi-intel-lnl-match: add missing empty item

Announce: https://lore.kernel.org/linux-cve-announce/2024092745-CVE-2024-46863-407d@gregkh/

Introduced by commit dd3bd9d ("ASoC: Intel: soc-acpi-intel-lnl-match:
add cs42l43 only support") in v6.10-rc1.
Fixed in v6.11.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4246f1fe9f24f8dcd97887ed67d8fcfd91f4796]

CVE-2024-46864: x86/hyperv: fix kexec crash due to VP assist page corruption

Announce: https://lore.kernel.org/linux-cve-announce/2024092745-CVE-2024-46864-0343@gregkh/

Introduced by commit 9636be8 ("x86/hyperv: Fix hyperv_pcpu_input_arg
handling when CPUs go online/offline") in v6.4.
Fixed in v6.11.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b9af6418279c4cf73ca073f8ea024992b38be8ab]
stable/6.6: [2ae1beb3ab4f28868cc5d1541d05e1fbee3ad825]

CVE-2024-46865: fou: fix initialization of grc

Announce: https://lore.kernel.org/linux-cve-announce/2024092745-CVE-2024-46865-c6a7@gregkh/

None
It introduced by commit 7e4196935 ("fou: Fix null-ptr-deref in GRO.")
in 6.11-rc7.
Bug introduced commit was backported to following branches.
cip/6.1 stable/5.10 stable/5.15 stable/6.1 stable/6.10 stable/6.6

Fixed status
mainline: [4c8002277167125078e6b9b90137bdf443ebaa08]
stable/6.1: [5d537b8d900514509622ce92330b70d2e581d409]
stable/6.6: [7ae890ee19479eeeb87724cca8430b5cb3660c74]

CVE-2024-46866: drm/xe/client: add missing bo locking in show_meminfo()

Announce: https://lore.kernel.org/linux-cve-announce/2024092746-CVE-2024-46866-c414@gregkh/

Introduced by commit 0845233 ("drm/xe: Implement fdinfo memory stats
printing") in v6.8-rc1.
Fixed in v6.11.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94c4aa266111262c96c98f822d1bccc494786fee]

CVE-2024-46867: drm/xe/client: fix deadlock in show_meminfo()

Announce: https://lore.kernel.org/linux-cve-announce/2024092746-CVE-2024-46867-7fe4@gregkh/

Introduced by commit 0845233 ("drm/xe: Implement fdinfo memory stats
printing") in v6.8-rc1.
Fixed in v6.11.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9bd7ff293fc84792514aeafa06c5a17f05cb5f4b]

CVE-2024-46868: firmware: qcom: uefisecapp: Fix deadlock in qcuefi_acquire()

Announce: https://lore.kernel.org/linux-cve-announce/2024092746-CVE-2024-46868-f3a3@gregkh/

Introduced by commit 759e7a2 ("firmware: Add support for Qualcomm UEFI
Secure Application") in v6.7-rc1.
Fixed in v6.11.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db213b0cfe3268d8b1d382b3bcc999c687a2567f]

CVE-2024-46869: Bluetooth: btintel_pcie: Allocate memory for driver private data

Announce: https://lore.kernel.org/linux-cve-announce/2024093004-CVE-2024-46869-8a60@gregkh/

Introduced by commit 6e65a09 ("Bluetooth: btintel_pcie: Add *setup*
function to download firmware") in v6.10-rc1.
Fixed in v6.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ffaa200251871980af12e57649ad57c70bf0f43]

* Updated CVEs

CVE-2022-3566: tcp: Fix data races around icsk->icsk_af_ops.

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [3f54a6a7702d875a5331f8546c1a6138f35a5ebd]
cip/4.4-rt: [3f54a6a7702d875a5331f8546c1a6138f35a5ebd]
cip/4.4-st: [3f54a6a7702d875a5331f8546c1a6138f35a5ebd]
stable/4.19: [5bb642cc3355ffd3c8bca0a8bd8e6e65bcc2091c]
stable/5.10: [3b32f265805a49071e2c4568a524398ba22bf93c]
stable/5.15: [fcd31dd8291b23d713245947ec2b2d99ef07aef2]
stable/5.4: [d529193eae979a7bf2255cd9fe68b7af7a1c91b3]

CVE-2022-3567: ipv6: Fix data races around sk->sk_prot.

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [5c12cc6581e30b07ce31c6af049df89b3494b2c5]
cip/4.4-rt: [5c12cc6581e30b07ce31c6af049df89b3494b2c5]
cip/4.4-st: [5c12cc6581e30b07ce31c6af049df89b3494b2c5]
stable/4.19: [fda6d62642a9c544a293d7ad7cb058f8c7f8f3dd]
stable/5.10: [ea2ed3f78ab238865b9b9e19a85c1de16d570ab7]
stable/5.15: [5088b4d4f91f15f02f52f3f3d4eb5968a6a3cb51]
stable/5.4: [f194e63054458b8f5019b294529409875be13c0c]

CVE-2023-52803: SUNRPC: Fix RPC client cleaned up the freed pipefs dentries

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [410fcd8ea8f7b421568195217f949d7fb03a26b7]
cip/4.4-rt: [410fcd8ea8f7b421568195217f949d7fb03a26b7]
cip/4.4-st: [410fcd8ea8f7b421568195217f949d7fb03a26b7]
stable/4.19: [17866066b8ac1cc38fb449670bc15dc9fee4b40a]
stable/5.10: [dedf2a0eb9448ae73b270743e6ea9b108189df46]
stable/5.15: [194454afa6aa9d6ed74f0c57127bc8beb27c20df]
stable/5.4: [7d61d1da2ed1f682c41cae0c8d4719cdaccee5c5]
stable/6.1: [7749fd2dbef72a52b5c9ffdbf877691950ed4680]
stable/6.6: [cc2e7ebbeb1d0601f7f3c8d93b78fcc03a95e44a]

CVE-2024-27017: netfilter: nft_set_pipapo: walk over current view on
netlink dump

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [52735a010f37580b3a569a996f878fdd87425650]
stable/6.6: [f24d8abc2bb8cbf31ec713336e402eafa8f42f60]
stable/6.8: [721715655c72640567e8742567520c99801148ed]

CVE-2024-36484: net: relax socket state check at accept time.

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [c7ec2b3b28888ad20be7f139f9b88930b793594c]
cip/4.4-rt: [c7ec2b3b28888ad20be7f139f9b88930b793594c]
cip/4.4-st: [c7ec2b3b28888ad20be7f139f9b88930b793594c]
stable/4.19: [7de00adc9bd035d861ba4177848ca0bfa5ed1e04]
stable/5.10: [6e03006548c66b979f4e5e9fc797aac4dad82822]
stable/5.15: [21c14c556cccd0cb54b71ec5e901e64ba84c7165]
stable/5.4: [59801e88c99f7c3f44a4d20af6ba6417aa359b5d]
stable/6.1: [c09ddc605893df542c6cf8dde6a57a93f7cf0adb]
stable/6.6: [87bdc9f6f58b4417362d6932b49b828e319f97dc]
stable/6.9: [5f9a04a94fd1894d7009055ab8e5832a0242dba3]

CVE-2024-36894: usb: gadget: f_fs: Fix race between aio_cancel() and
AIO request complete

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [3e81dbc5a4e437c32ab06976ee3370c2b358788e]
cip/4.4-rt: [3e81dbc5a4e437c32ab06976ee3370c2b358788e]
cip/4.4-st: [3e81dbc5a4e437c32ab06976ee3370c2b358788e]
stable/4.19: [f71a53148ce34898fef099b75386a3a9f4449311]
stable/5.10: [e500b1c4e29ad0bd1c1332a1eaea2913627a92dd]
stable/5.15: [3613e5023f09b3308545e9d1acda86017ebd418a]
stable/5.4: [9e72ef59cbe61cd1243857a6418ca92104275867]
stable/6.1: [a0fdccb1c9e027e3195f947f61aa87d6d0d2ea14]
stable/6.6: [73c05ad46bb4fbbdb346004651576d1c8dbcffbb]

CVE-2024-37078: nilfs2: fix potential kernel bug due to lack of
writeback flag waiting

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [1e7f203b63f441656b9cae0ca555017a80798f03]
cip/4.4-rt: [1e7f203b63f441656b9cae0ca555017a80798f03]
cip/4.4-st: [1e7f203b63f441656b9cae0ca555017a80798f03]
stable/4.19: [95f6f81e50d858a7c9aa7c795ec14a0ac3819118]
stable/5.10: [0ecfe3a92869a59668d27228dabbd7965e83567f]
stable/5.15: [33900d7eae616647e179eee1c66ebe654ee39627]
stable/5.4: [a75b8f493dfc48aa38c518430bd9e03b53bffebe]
stable/6.1: [271dcd977ccda8c7a26e360425ae7b4db7d2ecc0]
stable/6.6: [614d397be0cf43412b3f94a0f6460eddced8ce92]
stable/6.9: [1f3bff69f1214fe03a02bc650d5bbfaa6e65ae7d]

CVE-2024-38619: usb-storage: alauda: Check whether the media is initialized

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [0df99958f148819719e8360edca9d013dbfd3325]
cip/4.4-rt: [0df99958f148819719e8360edca9d013dbfd3325]
cip/4.4-st: [0df99958f148819719e8360edca9d013dbfd3325]
stable/4.19: [e0aab7b07a9375337847c9d74a5ec044071e01c8]
stable/5.10: [f68820f1256b21466ff094dd97f243b7e708f9c1]
stable/5.15: [3eee13ab67f65606faa66e0c3c729e4f514838fd]
stable/5.4: [51fe16c058acb22f847e69bc598066ed0bcd5c15]
stable/6.1: [e0e2eec76920a133dd49a4fbe4656d83596a1361]
stable/6.6: [2cc32639ec347e3365075b130f9953ef16cb13f1]
stable/6.9: [24bff7f714bdff97c2a75a0ff6a368cdf8ad5af4]

CVE-2024-39469: nilfs2: fix nilfs_empty_dir() misjudgment and long
loop on I/O errors

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [65ea5a47714a3c763788660142a8b19b1863cb11]
cip/4.4-rt: [65ea5a47714a3c763788660142a8b19b1863cb11]
cip/4.4-st: [65ea5a47714a3c763788660142a8b19b1863cb11]
stable/4.19: [2ac8a2fe22bdde9eecce2a42cf5cab79333fb428]
stable/5.10: [c77ad608df6c091fe64ecb91f41ef7cb465587f1]
stable/5.15: [11a2edb70356a2202dcb7c9c189c8356ab4752cd]
stable/5.4: [405b71f1251e5ae865f53bd27c45114e6c83bee3]
stable/6.1: [129dcd3e7d036218db3f59c82d82004b9539ed82]
stable/6.6: [d18b05eda7fa77f02114f15b02c009f28ee42346]
stable/6.9: [59f14875a96ef93f05b82ad3c980605f2cb444b5]

CVE-2024-39487: bonding: Fix out-of-bounds read in
bond_option_arp_ip_targets_set()

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [7aa46ac8326ddf242d76f1fc86a4af47fb6f7da4]
cip/4.4-rt: [7aa46ac8326ddf242d76f1fc86a4af47fb6f7da4]
cip/4.4-st: [7aa46ac8326ddf242d76f1fc86a4af47fb6f7da4]
stable/4.19: [6a8a4fd082c439e19fede027e80c79bc4c84bb8e]
stable/5.10: [707c85ba3527ad6aa25552033576b0f1ff835d7b]
stable/5.15: [bfd14e5915c2669f292a31d028e75dcd82f1e7e9]
stable/5.4: [6b21346b399fd1336fe59233a17eb5ce73041ee1]
stable/6.1: [c8eb8ab9a44ff0e73492d0a12a643c449f641a9f]
stable/6.6: [b75e33eae8667084bd4a63e67657c6a5a0f8d1e8]
stable/6.9: [9f835e48bd4c75fdf6a9cff3f0b806a7abde78da]

CVE-2024-39499: vmci: prevent speculation leaks by sanitizing event in
event_deliver()

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [6f6ce9e70228216d326b84bea958213a7677b816]
cip/4.4-rt: [6f6ce9e70228216d326b84bea958213a7677b816]
cip/4.4-st: [6f6ce9e70228216d326b84bea958213a7677b816]
stable/4.19: [58730dfbd4ae01c1b022b0d234a8bf8c02cdfb81]
stable/5.10: [f70ff737346744633e7b655c1fb23e1578491ff3]
stable/5.15: [95ac3e773a1f8da83c4710a720fbfe80055aafae]
stable/5.4: [681967c4ff210e06380acf9b9a1b33ae06e77cbd]
stable/6.1: [95bac1c8bedb362374ea1937b1d3e833e01174ee]
stable/6.6: [e293c6b38ac9029d76ff0d2a6b2d74131709a9a8]
stable/6.9: [757804e1c599af5d2a7f864c8e8b2842406ff4bb]

CVE-2024-39501: drivers: core: synchronize really_probe() and dev_uevent()

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [3aab177a1bec463f4b13a3504c6530e7a5887f40]
cip/4.4-rt: [3aab177a1bec463f4b13a3504c6530e7a5887f40]
cip/4.4-st: [3aab177a1bec463f4b13a3504c6530e7a5887f40]
stable/4.19: [bb3641a5831789d83a58a39ed4a928bcbece7080]
stable/5.10: [760603e30bf19d7b4c28e9d81f18b54fa3b745ad]
stable/5.15: [ec772ed7cb21b46fb132f89241682553efd0b721]
stable/5.4: [13d25e82b6d00d743c7961dcb260329f86bedf7c]
stable/6.1: [08891eeaa97c079b7f95d60b62dcf0e3ce034b69]
stable/6.6: [a42b0060d6ff2f7e59290a26d5f162a3c6329b90]
stable/6.9: [95d03d369ea647b89e950667f1c3363ea6f564e6]

CVE-2024-39509: HID: core: remove unnecessary WARN_ON() in implement()

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [dff699deb33958ea317f0e29f1f1a0e777085d46]
cip/4.4-rt: [dff699deb33958ea317f0e29f1f1a0e777085d46]
cip/4.4-st: [dff699deb33958ea317f0e29f1f1a0e777085d46]
stable/4.19: [955b3764671f3f157215194972d9c01a3a4bd316]
stable/5.10: [33f6832798dd3297317901cc1db556ac3ae80c24]
stable/5.15: [8bac61934cd563b073cd30b8cf6d5c758ab5ab26]
stable/5.4: [f9db5fbeffb951cac3f0fb1c2eeffb79785399ca]
stable/6.1: [bfd546fc7fd76076f81bf41b85b51ceda30949fd]
stable/6.6: [30f76bc468b9b2cbbd5d3eb482661e3e4798893f]
stable/6.9: [655c6de2f215b61d0708db6b06305eee9bbfeba2]

CVE-2024-40902: jfs: xattr: fix buffer overflow for invalid xattr

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [88840af6e4f2111c425c262cd529589c00691a02]
cip/4.4-rt: [88840af6e4f2111c425c262cd529589c00691a02]
cip/4.4-st: [88840af6e4f2111c425c262cd529589c00691a02]
stable/4.19: [f0dedb5c511ed82cbaff4997a8decf2351ba549f]
stable/5.10: [fc745f6e83cb650f9a5f2c864158e3a5ea76dad0]
stable/5.15: [480e5bc21f2c42d90c2c16045d64d824dcdd5ec7]
stable/5.4: [1e84c9b1838152a87cf453270a5fa75c5037e83a]
stable/6.1: [33aecc5799c93d3ee02f853cb94e201f9731f123]
stable/6.6: [4598233d9748fe4db4e13b9f473588aa25e87d69]
stable/6.9: [b537cb2f4c4a1357479716a9c339c0bda03d873f]

CVE-2024-40904: USB: class: cdc-wdm: Fix CPU lockup caused by
excessive log messages

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [524f2530dd2fb31e63e7f7dd07e3bf47e105261e]
cip/4.4-rt: [524f2530dd2fb31e63e7f7dd07e3bf47e105261e]
cip/4.4-st: [524f2530dd2fb31e63e7f7dd07e3bf47e105261e]
stable/4.19: [217d1f44fff560b3995a685a60aa66e55a7f0f56]
stable/5.10: [c0747d76eb05542b5d49f67069b64ef5ff732c6c]
stable/5.15: [53250b54c92fe087fd4b0c48f85529efe1ebd879]
stable/5.4: [05b2cd6d33f700597e6f081b53c668a226a96d28]
stable/6.1: [02a4c0499fc3a02e992b4c69a9809912af372d94]
stable/6.6: [72a3fe36cf9f0d030865e571f45a40f9c1e07e8a]
stable/6.9: [82075aff7ffccb1e72b0ac8aa349e473624d857c]

CVE-2024-40912: wifi: mac80211: Fix deadlock in
ieee80211_sta_ps_deliver_wakeup()

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [8d15b74b7db8a550df489145eb43b71d34ed2538]
cip/4.4-rt: [8d15b74b7db8a550df489145eb43b71d34ed2538]
cip/4.4-st: [8d15b74b7db8a550df489145eb43b71d34ed2538]
stable/4.19: [e51637e0c66a6f72d134d9f95daa47ea62b43c7e]
stable/5.10: [e7e916d693dcb5a297f40312600a82475f2e63bc]
stable/5.15: [d90bdff79f8e40adf889b5408bfcf521528b169f]
stable/5.4: [28ba44d680a30c51cf485a2f5a3b680e66ed3932]
stable/6.1: [9c49b58b9a2bed707e7638576e54c4bccd97b9eb]
stable/6.6: [456bbb8a31e425177dc0e8d4f98728a560c20e81]
stable/6.9: [47d176755d5c0baf284eff039560f8c1ba0ea485]

CVE-2024-40932: drm/exynos/vidi: fix memory leak in .get_modes()

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [bd47c85672600303dff05f9ea950fe0005d72c36]
cip/4.4-rt: [bd47c85672600303dff05f9ea950fe0005d72c36]
cip/4.4-st: [bd47c85672600303dff05f9ea950fe0005d72c36]
stable/4.19: [540ca99729e28dbe902b01039a3b4bd74520a819]
stable/5.10: [0acc356da8546b5c55aabfc2e2c5caa0ac9b0003]
stable/5.15: [777838c9b571674ef14dbddf671f372265879226]
stable/5.4: [ebcf81504fef03f701b9711e43fea4fe2d82ebc8]
stable/6.1: [dcba6bedb439581145d8aa6b0925209f23184ae1]
stable/6.6: [a269c5701244db2722ae0fce5d1854f5d8f31224]
stable/6.9: [cb3ac233434dba130281db330c4b15665b2d2c4d]

CVE-2024-40942: wifi: mac80211: mesh: Fix leak of mesh_preq_queue objects

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [6d5d4645521663af261e7b90bd8e463106693785]
cip/4.4-rt: [6d5d4645521663af261e7b90bd8e463106693785]
cip/4.4-st: [6d5d4645521663af261e7b90bd8e463106693785]
stable/4.19: [377dbb220edc8421b7960691876c5b3bef62f89b]
stable/5.10: [7518e20a189f8659b8b83969db4d33a4068fcfc3]
stable/5.15: [c4c865f971fd4a255208f57ef04d814c2ae9e0dc]
stable/5.4: [ec79670eae430b3ffb7e0a6417ad7657728b8f95]
stable/6.1: [617dadbfb2d3e152c5753e28356d189c9d6f33c0]
stable/6.6: [63d5f89bb5664d60edbf8cf0df911aaae8ed96a4]
stable/6.9: [d81e244af521de63ad2883e17571b789c39b6549]

CVE-2024-40943: ocfs2: fix races between hole punching and AIO+DIO

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [9436fbd75e462b68135dbbcfa0545f709cec4585]
cip/4.4-rt: [9436fbd75e462b68135dbbcfa0545f709cec4585]
cip/4.4-st: [9436fbd75e462b68135dbbcfa0545f709cec4585]
stable/4.19: [3c26b5d21b1239e9c7fd31ba7d9b2d7bdbaa68d9]
stable/5.10: [050ce8af6838c71e872e982b50d3f1bec21da40e]
stable/5.15: [38825ff9da91d2854dcf6d9ac320a7e641e10f25]
stable/5.4: [e8e2db1adac47970a6a9225f3858e9aa0e86287f]
stable/6.1: [ea042dc2bea19d72e37c298bf65a9c341ef3fff3]
stable/6.6: [3c361f313d696df72f9bccf058510e9ec737b9b1]
stable/6.9: [117b9c009b72a6c2ebfd23484354dfee2d9570d2]

CVE-2024-40959: xfrm6: check ip6_dst_idev() return value in xfrm6_get_saddr()

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [b6e894e8ebf75230761fd8ac9a7f778ad30c0a7a]
cip/4.4-rt: [b6e894e8ebf75230761fd8ac9a7f778ad30c0a7a]
cip/4.4-st: [b6e894e8ebf75230761fd8ac9a7f778ad30c0a7a]
stable/4.19: [c71761292d4d002a8eccb57b86792c4e3b3eb3c7]
stable/5.10: [20427b85781aca0ad072851f6907a3d4b2fed8d1]
stable/5.15: [9f30f1f1a51d91e19f5a09236bb0b59e6a07ad08]
stable/5.4: [caf0bec84c62fb1cf6f7c9f0e8c857c87f8adbc3]
stable/6.1: [83c02fb2cc0afee5bb53cddf3f34f045f654ad6a]
stable/6.6: [f897d7171652fcfc76d042bfec798b010ee89e41]
stable/6.9: [600a62b4232ac027f788c3ca395bc2333adeaacf]

CVE-2024-40968: MIPS: Octeon: Add PCIe link status check

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [1b6ce29b701c06f4bed6e244b1489bb47504b4ff]
cip/4.4-rt: [1b6ce29b701c06f4bed6e244b1489bb47504b4ff]
cip/4.4-st: [1b6ce29b701c06f4bed6e244b1489bb47504b4ff]
stable/4.19: [6bff05aaa32c2f7e1f6e68e890876642159db419]
stable/5.10: [6c1b9fe148a4e03bbfa234267ebb89f35285814a]
stable/5.15: [25998f5613159fe35920dbd484fcac7ea3ad0799]
stable/5.4: [64845ac64819683ad5e51b668b2ed56ee3386aee]
stable/6.1: [d996deb80398a90dd3c03590e68dad543da87d62]
stable/6.6: [1c33fd17383f48f679186c54df78542106deeaa0]
stable/6.9: [38d647d509543e9434b3cc470b914348be271fe9]

CVE-2024-40974: powerpc/pseries: Enforce hcall result buffer validity and size

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [8e628c289ac83353cac4121de9cef849b110d3a9]
cip/4.4-rt: [8e628c289ac83353cac4121de9cef849b110d3a9]
cip/4.4-st: [8e628c289ac83353cac4121de9cef849b110d3a9]
stable/4.19: [acf2b80c31c37acab040baa3cf5f19fbd5140b18]
stable/5.10: [a8c988d752b3d98d5cc1e3929c519a55ef55426c]
stable/5.15: [262e942ff5a839b9e4f3302a8987928b0c8b8a2d]
stable/5.4: [19c166ee42cf16d8b156a6cb4544122d9a65d3ca]
stable/6.1: [8aa11aa001576bf3b00dcb8559564ad7a3113588]
stable/6.6: [3ad0034910a57aa88ed9976b1431b7b8c84e0048]
stable/6.9: [aa6107dcc4ce9a3451f2d729204713783b657257]

CVE-2024-40981: batman-adv: bypass empty buckets in batadv_purge_orig_ref()

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [da45256c36eb08076790b80237b9a2571f9208ed]
cip/4.4-rt: [da45256c36eb08076790b80237b9a2571f9208ed]
cip/4.4-st: [da45256c36eb08076790b80237b9a2571f9208ed]
stable/4.19: [79636f636126775436a11ee9cf00a9253a33ac11]
stable/5.10: [82cdea8f3af1e36543c937df963d108c60bea030]
stable/5.15: [92176caf9896572f00e741a93cecc0ef1172da07]
stable/5.4: [154e3f862ba33675cf3f4abf0a0a309a89df87d2]
stable/6.1: [fed7914858a1f1f3e6350bb0f620d6ef15107d16]
stable/6.6: [2685008a5f9a636434a8508419cee8158a2f52c8]
stable/6.9: [ae7f3cffe86aea3da0e8e079525a1ae619b8862a]

CVE-2024-40984: ACPICA: Revert "ACPICA: avoid Info: mapping multiple
BARs. Your kernel is fine."

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [c5c5b28cc15a48efa91f5f9585608bf0a71b4749]
cip/4.4-rt: [c5c5b28cc15a48efa91f5f9585608bf0a71b4749]
cip/4.4-st: [c5c5b28cc15a48efa91f5f9585608bf0a71b4749]
stable/4.19: [435ecc978c3d5d0c4e172ec5b956dc1904061d98]
stable/5.10: [6eca23100e9030725f69c1babacd58803f29ec8d]
stable/5.15: [dc5017c57f5eee80020c73ff8b67ba7f9fd08b1f]
stable/5.4: [ae465109d82f4fb03c5adbe85f2d6a6a3d59124c]
stable/6.1: [ddc1f5f124479360a1fd43f73be950781d172239]
stable/6.6: [434c6b924e1f4c219aab2d9e05fe79c5364e37d3]
stable/6.9: [e21a4c9129c72fa54dd00f5ebf71219b41d43c04]

CVE-2024-40987: drm/amdgpu: fix UBSAN warning in kv_dpm.c

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [d285a56b23662c34dbb542192a1b848a65e13a8a]
cip/4.4-rt: [d285a56b23662c34dbb542192a1b848a65e13a8a]
cip/4.4-st: [d285a56b23662c34dbb542192a1b848a65e13a8a]
stable/4.19: [4ad7d49059358ceadd352b4e2511425bdb68f400]
stable/5.10: [d8a04a6bfa75251ba7bcc3651ed211e82f13f388]
stable/5.15: [4d020c1dbd2b2304f44d003e6de956ae570049dc]
stable/5.4: [1c44f7759a5650acf8f13d3e0a184d09e03be9e4]
stable/6.1: [fc5cb952e6723c5c55e47b8cf94a891bd4af1a86]
stable/6.6: [b065d79ed06a0bb4377bc6dcc2ff0cb1f55a798f]
stable/6.9: [b0d612619ed70cab476c77b19e00d13aa414e14f]

CVE-2024-40988: drm/radeon: fix UBSAN warning in kv_dpm.c

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [ede576cd852daf76626e1b0cdbd1328158986f78]
cip/4.4-rt: [ede576cd852daf76626e1b0cdbd1328158986f78]
cip/4.4-st: [ede576cd852daf76626e1b0cdbd1328158986f78]
stable/4.19: [07e8f15fa16695cf4c90e89854e59af4a760055b]
stable/5.10: [febe794b83693257f21a23d2e03ea695a62449c8]
stable/5.15: [cf1cc8fcfe517e108794fb711f7faabfca0dc855]
stable/5.4: [a8c6df9fe5bc390645d1e96eff14ffe414951aad]
stable/6.1: [f803532bc3825384100dfc58873e035d77248447]
stable/6.6: [9e57611182a817824a17b1c3dd300ee74a174b42]
stable/6.9: [468a50fd46a09bba7ba18a11054ae64b6479ecdc]

CVE-2024-41006: netrom: Fix a memory leak in nr_heartbeat_expiry()

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [feae50bfb78cac81efe947043b1bee5b617a4836]
cip/4.4-rt: [feae50bfb78cac81efe947043b1bee5b617a4836]
cip/4.4-st: [feae50bfb78cac81efe947043b1bee5b617a4836]
stable/4.19: [d616876256b38ecf9a1a1c7d674192c5346bc69c]
stable/5.10: [5391f9db2cab5ef1cb411be1ab7dbec728078fba]
stable/5.15: [280cf1173726a7059b628c610c71050d5c0b6937]
stable/5.4: [e07a9c2a850cdebf625e7a1b8171bd23a8554313]
stable/6.1: [a02fd5d775cf9787ee7698c797e20f2fa13d2e2b]
stable/6.6: [b6ebe4fed73eedeb73f4540f8edc4871945474c8]
stable/6.9: [d377f5a28332954b19e373d36823e59830ab1712]

CVE-2024-41012: filelock: Remove locks reliably when fcntl/close race
is detected

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [f45b899adc6bf0c737310c6703f3cd83e2c00ab6]
cip/4.4-rt: [f45b899adc6bf0c737310c6703f3cd83e2c00ab6]
cip/4.4-st: [f45b899adc6bf0c737310c6703f3cd83e2c00ab6]
stable/4.19: [d30ff33040834c3b9eee29740acd92f9c7ba2250]
stable/5.10: [5661b9c7ec189406c2dde00837aaa4672efb6240]
stable/5.15: [52c87ab18c76c14d7209646ccb3283b3f5d87b22]
stable/5.4: [dc2ce1dfceaa0767211a9d963ddb029ab21c4235]
stable/6.1: [ef8fc41cd6f95f9a4a3470f085aecf350569a0b3]
stable/6.6: [5f5d0799eb0a01d550c21b7894e26b2d9db55763]
stable/6.9: [b6d223942c34057fdfd8f149e763fa823731b224]

CVE-2024-41015: ocfs2: add bounds checking to ocfs2_check_dir_entry()

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [f92bfcc25e7a23b921fed6d6bf80652f774948a9]
cip/4.4-rt: [f92bfcc25e7a23b921fed6d6bf80652f774948a9]
cip/4.4-st: [f92bfcc25e7a23b921fed6d6bf80652f774948a9]
stable/4.19: [13d38c00df97289e6fba2e54193959293fd910d2]
stable/5.10: [77495e5da5cb110a8fed27b052c77853fe282176]
stable/5.15: [53de17ad01cb5f6f8426f597e9d5c87d4cf53bb7]
stable/5.4: [564d23cc5b216211e1694d53f7e45959396874d0]
stable/6.1: [fd65685594ee707cbf3ddf22ebb73697786ac114]
stable/6.10: [edb2e67dd4626b06fd7eb37252d5067912e78d59]
stable/6.6: [e05a24289db90f76ff606086aadd62d068a88dcd]

CVE-2024-41016: ocfs2: strict bound check before memcmp in
ocfs2_xattr_find_entry()

stable/6.1, stable/6.10, stable/6.6 were fixed.

Fixed status
stable/6.1: [cfb926051fab19b10d1e65976211f364aa820180]
stable/6.10: [e4ffea01adf3323c821b6f37e9577d2d400adbaa]
stable/6.6: [c726dea9d0c806d64c26fcef483b1fb9474d8c5e]

CVE-2024-41017: jfs: don't walk off the end of ealist

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [af1a2788b6039dd6de3eb30b6ef04847b7a80d1a]
cip/4.4-rt: [af1a2788b6039dd6de3eb30b6ef04847b7a80d1a]
cip/4.4-st: [af1a2788b6039dd6de3eb30b6ef04847b7a80d1a]
stable/4.19: [7f91bd0f2941fa36449ce1a15faaa64f840d9746]
stable/5.10: [6386f1b6a10e5d1ddd03db4ff6dfc55d488852ce]
stable/5.15: [7e21574195a45fc193555fa40e99fed16565ff7e]
stable/5.4: [fc16776a82e8df97b6c4f9a10ba95aa44cef7ba5]
stable/6.1: [4e034f7e563ab723b93a59980e4a1bb33198ece8]
stable/6.10: [dbde7bc91093fa9c2410e418b236b70fde044b73]
stable/6.6: [17440dbc66ab98b410514b04987f61deedb86751]

CVE-2024-41020: filelock: Fix fcntl/close race recovery compat path

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [6ebd8367c352a40130a7224b34d78df9b9f2f9de]
cip/4.4-rt: [6ebd8367c352a40130a7224b34d78df9b9f2f9de]
cip/4.4-st: [6ebd8367c352a40130a7224b34d78df9b9f2f9de]
stable/4.19: [a561145f3ae973ebf3e0aee41624e92a6c5cb38d]
stable/5.10: [911cc83e56a2de5a40758766c6a70d6998248860]
stable/5.15: [53e21cfa68a7d12de378b7116c75571f73e0dfa2]
stable/5.4: [4c43ad4ab41602201d34c66ac62130fe339d686f]
stable/6.1: [f4d0775c6e2f1340ca0725f0337de149aaa989ca]
stable/6.10: [ed898f9ca3fa32c56c858b463ceb9d9936cc69c4]
stable/6.6: [73ae349534ebc377328e7d21891e589626c6e82c]

CVE-2024-41035: USB: core: Fix duplicate endpoint bug by clearing
reserved bits in the descriptor

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [c9b70ed4ae1f5b96d1fe3db7a65b4c8a68072113]
cip/4.4-rt: [c9b70ed4ae1f5b96d1fe3db7a65b4c8a68072113]
cip/4.4-st: [c9b70ed4ae1f5b96d1fe3db7a65b4c8a68072113]
stable/4.19: [d8418fd083d1b90a6c007cf8dcf81aeae274727b]
stable/5.10: [d09dd21bb5215d583ca9a1cb1464dbc77a7e88cf]
stable/5.15: [2bd8534a1b83c65702aec3cab164170f8e584188]
stable/5.4: [60abea505b726b38232a0ef410d2bd1994a77f78]
stable/6.1: [9edcf317620d7c6a8354911b69b874cf89716646]
stable/6.10: [a368ecde8a5055b627749b09c6218ef793043e47]
stable/6.6: [647d61aef106dbed9c70447bcddbd4968e67ca64]

CVE-2024-41044: ppp: reject claimed-as-LCP but actually malformed packets

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [7a6b9c818d25ba6faaf6089b7291bcdded0627c8]
cip/4.4-rt: [7a6b9c818d25ba6faaf6089b7291bcdded0627c8]
cip/4.4-st: [7a6b9c818d25ba6faaf6089b7291bcdded0627c8]
stable/4.19: [97d1efd8be26615ff680cdde86937d5943138f37]
stable/5.10: [3ba12c2afd933fc1bf800f6d3f6c7ec8f602ce56]
stable/5.15: [ebc5c630457783d17d0c438b0ad70b232a64a82f]
stable/5.4: [6e8f1c21174f9482033bbb59f13ce1a8cbe843c3]
stable/6.1: [3134bdf7356ed952dcecb480861d2afcc1e40492]
stable/6.10: [f2aeb7306a898e1cbd03963d376f4b6656ca2b55]
stable/6.6: [099502ca410922b56353ccef2749bc0de669da78]

CVE-2024-41046: net: ethernet: lantiq_etop: fix double free in detach

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [e824e225f11dcb60bd1dba8dac08d4611cf09199]
cip/4.4-rt: [e824e225f11dcb60bd1dba8dac08d4611cf09199]
cip/4.4-st: [e824e225f11dcb60bd1dba8dac08d4611cf09199]
stable/4.19: [1a2db00a554cfda57c397cce79b2804bf9633fec]
stable/5.10: [22b16618a80858b3a9d607708444426948cc4ae1]
stable/5.15: [69ad5fa0ce7c548262e0770fc2b726fe7ab4f156]
stable/5.4: [907443174e76b854d28024bd079f0e53b94dc9a1]
stable/6.1: [c2b66e2b3939af63699e4a4bd25a8ac4a9b1d1b3]
stable/6.10: [e1533b6319ab9c3a97dad314dd88b3783bc41b69]
stable/6.6: [9d23909ae041761cb2aa0c3cb1748598d8b6bc54]

CVE-2024-41059: hfsplus: fix uninit-value in copy_name

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [8e50795a5df1640900d539bc70c27c9d0aa6088f]
cip/4.4-rt: [8e50795a5df1640900d539bc70c27c9d0aa6088f]
cip/4.4-st: [8e50795a5df1640900d539bc70c27c9d0aa6088f]
stable/4.19: [72805debec8f7aa342da194fe0ed7bc8febea335]
stable/5.10: [34f8efd2743f2d961e92e8e994de4c7a2f9e74a0]
stable/5.15: [d02d8c1dacafb28930c39e16d48e40bb6e4cbc70]
stable/5.4: [c733e24a61cbcff10f660041d6d84d32bb7e4cb4]
stable/6.1: [22999936b91ba545ce1fbbecae6895127945e91c]
stable/6.10: [0570730c16307a72f8241df12363f76600baf57d]
stable/6.6: [f08956d8e0f80fd0d4ad84ec917302bb2f3a9c6a]

CVE-2024-41063: Bluetooth: hci_core: cancel all works upon hci_unregister_dev()

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [ff842781bb5663edbbe34f1c7a7c79fdd5e0a13e]
cip/4.4-rt: [ff842781bb5663edbbe34f1c7a7c79fdd5e0a13e]
cip/4.4-st: [ff842781bb5663edbbe34f1c7a7c79fdd5e0a13e]
stable/4.19: [48542881997e17b49dc16b93fe910e0cfcf7a9f9]
stable/5.10: [ddeda6ca5f218b668b560d90fc31ae469adbfd92]
stable/5.15: [d2ce562a5aff1dcd0c50d9808ea825ef90da909f]
stable/5.4: [9cfc84b1d464cc024286f42a090718f9067b80ed]
stable/6.1: [96600c2e5ee8213dbab5df1617293d8e847bb4fa]
stable/6.6: [d6cbce18370641a21dd889e8613d8153df15eb39]

CVE-2024-41068: s390/sclp: Fix sclp_init() cleanup on failure

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [22fe3a43d95996126f2ca600ae49c220ddf3c193]
cip/4.4-rt: [22fe3a43d95996126f2ca600ae49c220ddf3c193]
cip/4.4-st: [22fe3a43d95996126f2ca600ae49c220ddf3c193]
stable/4.19: [a778987afc36d5dc02a1f82d352a81edcaf7eb83]
stable/5.10: [2e51db7ab71b89dc5a17068f5e201c69f13a4c9a]
stable/5.15: [cf521049fcd07071ed42dc9758fce7d5ee120ec6]
stable/5.4: [455a6653d8700a81aa8ed2b6442a3be476007090]
stable/6.1: [79b4be70d5a160969b805f638ac5b4efd0aac7a3]
stable/6.6: [0a31b3fdc7e735c4f8c65fe4339945c717ed6808]

CVE-2024-41072: wifi: cfg80211: wext: add extra SIOCSIWSCAN data check

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [3f4641034c5b4f954ccc6951da94be773011c53c]
cip/4.4-rt: [3f4641034c5b4f954ccc6951da94be773011c53c]
cip/4.4-st: [3f4641034c5b4f954ccc6951da94be773011c53c]
stable/4.19: [b02ba9a0b55b762bd04743a22f3d9f9645005e79]
stable/5.10: [6295bad58f988eaafcf0e6f8b198a580398acb3b]
stable/5.15: [a43cc0558530b6c065976b6b9246f512f8d3593b]
stable/5.4: [de5fcf757e33596eed32de170ce5a93fa44dd2ac]
stable/6.1: [001120ff0c9e3557dee9b5ee0d358e0fc189996f]
stable/6.6: [fe9644efd86704afe50e56b64b609de340ab7c95]

CVE-2024-41089: drm/nouveau/dispnv04: fix null pointer dereference in
nv17_tv_get_hd_modes

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [9055a2b1109d7c8c785754aeffaba21b3e9ad782]
cip/4.4-rt: [9055a2b1109d7c8c785754aeffaba21b3e9ad782]
cip/4.4-st: [9055a2b1109d7c8c785754aeffaba21b3e9ad782]
stable/4.19: [ffabad4aa91e33ced3c6ae793fb37771b3e9cb51]
stable/5.10: [56fc4d3b0bdef691831cd95715a7ca3ebea98b2d]
stable/5.15: [5eecb49a6c268dc229005bf6e8167d4001dc09a0]
stable/5.4: [1c9f2e60150b4f13789064370e37f39e6e060f50]
stable/6.1: [30cbf6ffafbbdd8a6e4e5f0a2e9a9827ee83f3ad]
stable/6.6: [7ece609b0ce7a7ea8acdf512a77d1fee26621637]

CVE-2024-41095: drm/nouveau/dispnv04: fix null pointer dereference in
nv17_tv_get_ld_modes

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [e620ef43938192a82fb3c1e76e132a1c566e07a6]
cip/4.4-rt: [e620ef43938192a82fb3c1e76e132a1c566e07a6]
cip/4.4-st: [e620ef43938192a82fb3c1e76e132a1c566e07a6]
stable/4.19: [9289cd3450d1da3e271ef4b054d4d2932c41243e]
stable/5.10: [259549b2ccf795b7f91f7b5aba47286addcfa389]
stable/5.15: [0d17604f2e44b3df21e218fe8fb3b836d41bac49]
stable/5.4: [dbd75f32252508ed6c46c3288a282c301a57ceeb]
stable/6.1: [f95ed0f54b3d3faecae1140ddab854f904a6e7c8]
stable/6.6: [cb751e48bbcffd292090f7882b23b215111b3d72]

CVE-2024-41097: usb: atm: cxacru: fix endpoint checking in cxacru_bind()

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [0857b805a755b25c1d07df5338e14e4cbaef4716]
cip/4.4-rt: [0857b805a755b25c1d07df5338e14e4cbaef4716]
cip/4.4-st: [0857b805a755b25c1d07df5338e14e4cbaef4716]
stable/4.19: [5159a81924311c1ec786ad9fdef784ead8676a6a]
stable/5.10: [75ddbf776dd04a09fb9e5267ead5d0c989f84506]
stable/5.15: [1aac4be1aaa5177506219f01dce5e29194e5e95a]
stable/5.4: [23926d316d2836315cb113569f91393266eb5b47]
stable/6.1: [5584c776a1af7807ca815ee6265f2c1429fc5727]
stable/6.6: [f536f09eb45e4de8d1b9accee9d992aa1846f1d4]

CVE-2024-42070: netfilter: nf_tables: fully validate NFT_DATA_VALUE on
store to data registers

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [4f0f312fefd1be25d4a11dbdad9d90f34e15e480]
cip/4.4-rt: [4f0f312fefd1be25d4a11dbdad9d90f34e15e480]
cip/4.4-st: [4f0f312fefd1be25d4a11dbdad9d90f34e15e480]
stable/4.19: [40188a25a9847dbeb7ec67517174a835a677752f]
stable/5.10: [5d43d789b57943720dca4181a05f6477362b94cf]
stable/5.15: [461302e07f49687ffe7d105fa0a330c07c7646d8]
stable/5.4: [23752737c6a618e994f9a310ec2568881a6b49c4]
stable/6.1: [efb27ad05949403848f487823b597ed67060e007]
stable/6.6: [952bf8df222599baadbd4f838a49c4fef81d2564]

CVE-2024-42084: ftruncate: pass a signed offset

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [9f3440427ed7ed494d55fc0059c8f194a9f7d13e]
cip/4.4-rt: [9f3440427ed7ed494d55fc0059c8f194a9f7d13e]
cip/4.4-st: [9f3440427ed7ed494d55fc0059c8f194a9f7d13e]
stable/4.19: [c329760749b5419769e57cb2be80955d2805f9c9]
stable/5.10: [84bf6b64a1a0dfc6de7e1b1c776d58d608e7865a]
stable/5.15: [dbb226d81cd02cee140139c2369791e6f61f2007]
stable/5.4: [f531d4bc6c5588d713359e42ed65e46816d841d8]
stable/6.1: [5ae6af68410bdad6181ec82104bb9985a7a6a0fa]
stable/6.6: [836359247b0403e0634bfbc83e5bb8063fad287a]

CVE-2024-42089: ASoC: fsl-asoc-card: set priv->pdev before using it

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [ff3cd6c29df0c5a8cb101c9d96d35037e3bed807]
cip/4.4-rt: [ff3cd6c29df0c5a8cb101c9d96d35037e3bed807]
cip/4.4-st: [ff3cd6c29df0c5a8cb101c9d96d35037e3bed807]
stable/4.19: [ae81535ce2503aabc4adab3472f4338070cdeb6a]
stable/5.10: [3662eb2170e59b58ad479982dc1084889ba757b9]
stable/5.15: [544ab46b7ece6d6bebbdee5d5659c0a0f804a99a]
stable/5.4: [8896e18b7c366f8faf9344abfd0971435f1c723a]
stable/6.1: [8faf91e58425c2f6ce773250dfd995f1c2d461ac]
stable/6.6: [29bc9e7c75398b0d12fc30955f2e9b2dd29ffaed]

CVE-2024-42090: pinctrl: fix deadlock in create_pinctrl() when
handling -EPROBE_DEFER

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [4a51a2ca90eb9ff5776b89a17d9a85e3b3828b99]
cip/4.4-rt: [4a51a2ca90eb9ff5776b89a17d9a85e3b3828b99]
cip/4.4-st: [4a51a2ca90eb9ff5776b89a17d9a85e3b3828b99]
stable/4.19: [e65a0dc2e85efb28e182aca50218e8a056d0ce04]
stable/5.10: [b813e3fd102a959c5b208ed68afe27e0137a561b]
stable/5.15: [01fe2f885f7813f8aed5d3704b384a97b1116a9e]
stable/5.4: [420ce1261907e5dbeda1e4daffd5b6c76f8188c0]
stable/6.1: [b36efd2e3e22a329444b6b24fa48df6d20ae66e6]
stable/6.6: [4038c57bf61631219b31f1bd6e92106ec7f084dc]

CVE-2024-42096: x86: stop playing stack games in profile_pc()

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [8470f12539c176094144cec1203fb096ceb4a6ee]
cip/4.4-rt: [8470f12539c176094144cec1203fb096ceb4a6ee]
cip/4.4-st: [8470f12539c176094144cec1203fb096ceb4a6ee]
stable/4.19: [65ebdde16e7f5da99dbf8a548fb635837d78384e]
stable/5.10: [49c09ca35a5f521d7fa18caf62fdf378f15e8aa4]
stable/5.15: [2d07fea561d64357fb7b3f3751e653bf20306d77]
stable/5.4: [27c3be840911b15a3f24ed623f86153c825b6b29]
stable/6.1: [161cef818545ecf980f0e2ebaf8ba7326ce53c2b]
stable/6.6: [16222beb9f8e5ceb0beeb5cbe54bef16df501a92]

CVE-2024-42097: ALSA: emux: improve patch ioctl data validation

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [ccb1d69b9ffcddf1bf4249541433917d6f625ee0]
cip/4.4-rt: [ccb1d69b9ffcddf1bf4249541433917d6f625ee0]
cip/4.4-st: [ccb1d69b9ffcddf1bf4249541433917d6f625ee0]
stable/4.19: [40d7def67841343c10f8642a41031fecbb248bab]
stable/5.10: [d23982ea9aa438f35a8c8a6305943e98a8db90f6]
stable/5.15: [7a18293fd8d8519c2f7a03753bc1583b18e3db69]
stable/5.4: [79d9a000f0220cdaba1682d2a23c0d0c61d620a3]
stable/6.1: [d0ff2443fcbb472206d45a5d2a90cc694065804e]
stable/6.6: [d8f5ce3cb9adf0c72e2ad6089aba02d7a32469c2]

CVE-2024-42101: drm/nouveau: fix null pointer dereference in
nouveau_connector_get_modes

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [a597901aae85f34f7ed32e82ee21cfbff1415fbc]
cip/4.4-rt: [a597901aae85f34f7ed32e82ee21cfbff1415fbc]
cip/4.4-st: [a597901aae85f34f7ed32e82ee21cfbff1415fbc]
stable/4.19: [9baf60323efa992b7c915094529f0a1882c34e7e]
stable/5.10: [274cba8d2d1b48c72d8bd90e76c9e2dc1aa0a81d]
stable/5.15: [f48dd3f19614022f2e1b794fbd169d2b4c398c07]
stable/5.4: [e36364f5f3785d054a94e57e971385284886d41a]
stable/6.1: [1f32535238493008587a8c5cb17eb2ca097592ef]
stable/6.6: [744b229f09134ccd091427a6f9ea6d97302cfdd9]

CVE-2024-42102: Revert "mm/writeback: fix possible divide-by-zero in
wb_dirty_limits(), again"

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [087c0e236cfc37fb08ec40a5a54085e35aaef031]
cip/4.4-rt: [087c0e236cfc37fb08ec40a5a54085e35aaef031]
cip/4.4-st: [087c0e236cfc37fb08ec40a5a54085e35aaef031]
stable/4.19: [253f9ea7e8e53a5176bd80ceb174907b10724c1a]
stable/5.10: [145faa3d03688cbb7bbaaecbd84c01539852942c]
stable/5.15: [2820005edae13b140f2d54267d1bd6bb23915f59]
stable/5.4: [23a28f5f3f6ca1e4184bd0e9631cd0944cf1c807]
stable/6.1: [cbbe17a324437c0ff99881a3ee453da45b228a00]
stable/6.6: [f6620df12cb6bdcad671d269debbb23573502f9d]

CVE-2024-42104: nilfs2: add missing check for inode numbers on directory entries

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [8586190cdd6dbc1e301f37d8ac9bee6bae65f637]
cip/4.4-rt: [8586190cdd6dbc1e301f37d8ac9bee6bae65f637]
cip/4.4-st: [8586190cdd6dbc1e301f37d8ac9bee6bae65f637]
stable/4.19: [c33c2b0d92aa1c2262d999b2598ad6fbd53bd479]
stable/5.10: [2f2fa9cf7c3537958a82fbe8c8595a5eb0861ad7]
stable/5.15: [b11e8fb93ea5eefb2e4e719497ea177a58ff6131]
stable/5.4: [07c176e7acc5579c133bb923ab21316d192d0a95]
stable/6.1: [1b7d549ed2c1fa202c751b69423a0d3a6bd5a180]
stable/6.6: [3ab40870edb883b9633dc5cd55f5a2a11afa618d]

CVE-2024-42105: nilfs2: fix inode number range checks

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [bc1d4ada7379db8d87bfa1922a295b66853bd4c3]
cip/4.4-rt: [bc1d4ada7379db8d87bfa1922a295b66853bd4c3]
cip/4.4-st: [bc1d4ada7379db8d87bfa1922a295b66853bd4c3]
stable/4.19: [57235c3c88bb430043728d0d02f44a4efe386476]
stable/5.10: [731011ac6c37cbe97ece229fc6daa486276052c5]
stable/5.15: [3be4dcc8d7bea52ea41f87aa4bbf959efe7a5987]
stable/5.4: [08cab183a624ba71603f3754643ae11cab34dbc4]
stable/6.1: [fae1959d6ab2c52677b113935e36ab4e25df37ea]
stable/6.6: [9194f8ca57527958bee207919458e372d638d783]

CVE-2024-42106: inet_diag: Initialize pad field in struct inet_diag_req_v2

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [9b6e6ce1551431d4d8d3a5c9b82dc0d2c5b7cc4b]
cip/4.4-rt: [9b6e6ce1551431d4d8d3a5c9b82dc0d2c5b7cc4b]
cip/4.4-st: [9b6e6ce1551431d4d8d3a5c9b82dc0d2c5b7cc4b]
stable/4.19: [7094a5fd20ab66028f1da7f06e0f2692d70346f9]
stable/5.10: [7ef519c8efde152e0d632337f2994f6921e0b7e4]
stable/5.15: [8366720519ea8d322a20780debdfd23d9fc0904a]
stable/5.4: [0184bf0a349f4cf9e663abbe862ff280e8e4dfa2]
stable/6.1: [d6f487e0704de2f2d15f8dd5d7d723210f2b2fdb]
stable/6.6: [76965648fe6858db7c5f3c700fef7aa5f124ca1c]

CVE-2024-42115: jffs2: Fix potential illegal address access in jffs2_free_inode

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [954b56c37665e341bf6f53fb983f9e59aecc034e]
cip/4.4-rt: [954b56c37665e341bf6f53fb983f9e59aecc034e]
cip/4.4-st: [954b56c37665e341bf6f53fb983f9e59aecc034e]
stable/4.19: [b6c8b3e31eb88c85094d848a0bd8b4bafe67e4d8]
stable/5.10: [6d6d94287f6365282bbf41e9a5b5281985970789]
stable/5.15: [5ca26334fc8a3711fed14db7f9eb1c621be4df65]
stable/5.4: [0b3246052e01e61a55bb3a15b76acb006759fe67]
stable/6.1: [751987a5d8ead0cc405fad96e83ebbaa51c82dbc]
stable/6.6: [d0bbbf31462a400bef4df33e22de91864f475455]

CVE-2024-42131: mm: avoid overflows in dirty throttling logic

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [311ee740029733c173a7fc7636929b884964ad02]
cip/4.4-rt: [311ee740029733c173a7fc7636929b884964ad02]
cip/4.4-st: [311ee740029733c173a7fc7636929b884964ad02]
stable/4.19: [2b2d2b8766db028bd827af34075f221ae9e9efff]
stable/5.10: [7a49389771ae7666f4dc3426e2a4594bf23ae290]
stable/5.15: [a25e8536184516b55ef89ab91dd2eea429de28d2]
stable/5.4: [4d3817b64eda07491bdd86a234629fe0764fb42a]
stable/6.1: [c83ed422c24f0d4b264f89291d4fabe285f80dbc]
stable/6.6: [bd16a7ee339aef3ee4c90cb23902afb6af379ea0]

CVE-2024-42145: IB/core: Implement a limit on UMAD receive List

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [a066f0cb6e0885a26b667430f63bf846ff3ecf11]
cip/4.4-rt: [a066f0cb6e0885a26b667430f63bf846ff3ecf11]
cip/4.4-st: [a066f0cb6e0885a26b667430f63bf846ff3ecf11]
stable/4.19: [1288cf1cceb0e6df276e182f5412370fb4169bcb]
stable/5.10: [62349fbf86b5e13b02721bdadf98c29afd1e7b5f]
stable/5.15: [d73cb8862e4d6760ccc94d3b57b9ef6271400607]
stable/5.4: [b4913702419d064ec4c4bbf7270643c95cc89a1b]
stable/6.1: [63d202d948bb6d3a28cd8e8b96b160fa53e18baa]
stable/6.6: [b8c5f635997f49c625178d1a0cb32a80ed33abe6]

CVE-2024-42148: bnx2x: Fix multiple UBSAN array-index-out-of-bounds

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [7a3feeac7dda4074d16ca08e22131ede1043c417]
cip/4.4-rt: [7a3feeac7dda4074d16ca08e22131ede1043c417]
cip/4.4-st: [7a3feeac7dda4074d16ca08e22131ede1043c417]
stable/4.19: [cfb04472ce33bee2579caf4dc9f4242522f6e26e]
stable/5.10: [8b17cec33892a66bbd71f8d9a70a45e2072ae84f]
stable/5.15: [0edae06b4c227bcfaf3ce21208d49191e1009d3b]
stable/5.4: [cbe53087026ad929cd3950508397e8892a6a2a0f]
stable/6.1: [9504a1550686f53b0bab4cab31d435383b1ee2ce]
stable/6.6: [f1313ea92f82451923e28ab45a4aaa0e70e80b98]

CVE-2024-42153: i2c: pnx: Fix potential deadlock warning from
del_timer_sync() call in isr

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [761475562f9c4369ce439eb6fa4c2bee4ee71e39]
cip/4.4-rt: [761475562f9c4369ce439eb6fa4c2bee4ee71e39]
cip/4.4-st: [761475562f9c4369ce439eb6fa4c2bee4ee71e39]
stable/4.19: [a349e5ab4dc9954746e836cd10b407ce48f9b2f6]
stable/5.10: [2849a1b747cf37aa5b684527104d3a53f1e296d2]
stable/5.15: [3503372d0bf7b324ec0bd6b90606703991426176]
stable/5.4: [effe0500afda017a86c94482b1e36bc37586c9af]
stable/6.1: [3d32327f5cfc087ee3922a3bcdcc29880dcdb50f]
stable/6.6: [92e494a7568b60ae80d57fc0deafcaf3a4029ab3]

CVE-2024-42154: tcp_metrics: validate source addr length

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [b8617719d306c31426d3d6958895d7f67b8e1196]
cip/4.4-rt: [b8617719d306c31426d3d6958895d7f67b8e1196]
cip/4.4-st: [b8617719d306c31426d3d6958895d7f67b8e1196]
stable/4.19: [19d997b59fa1fd7a02e770ee0881c0652b9c32c9]
stable/5.10: [cdffc358717e436bb67122bb82c1a2a26e050f98]
stable/5.15: [ef7c428b425beeb52b894e16f1c4b629d6cebfb6]
stable/5.4: [2a2e79dbe2236a1289412d2044994f7ab419b44c]
stable/6.1: [31f03bb04146c1c6df6c03e9f45401f5f5a985d3]
stable/6.6: [8c2debdd170e395934ac0e039748576dfde14e99]

CVE-2024-42223: media: dvb-frontends: tda10048: Fix integer overflow

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [2d534b531321282393d7c75864e9594c7d555966]
cip/4.4-rt: [2d534b531321282393d7c75864e9594c7d555966]
cip/4.4-st: [2d534b531321282393d7c75864e9594c7d555966]
stable/4.19: [8167e4d7dc086d4f7ca7897dcff3827e4d22c99a]
stable/5.10: [e1ba22618758e95e09c9fd30c69ccce38edf94c0]
stable/5.15: [bd5620439959a7e02012588c724c6ff5143b80af]
stable/5.4: [5c72587d024f087aecec0221eaff2fe850d856ce]
stable/6.1: [1663e2474e4d777187d749a5c90ae83232db32bd]
stable/6.6: [8ac224e9371dc3c4eb666033e6b42d05cf5184a1]

CVE-2024-42232: libceph: fix race between delayed_work() and ceph_monc_stop()

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [2a1697e925071b330bb9a66a8c200ea4d0dfc18e]
cip/4.4-rt: [2a1697e925071b330bb9a66a8c200ea4d0dfc18e]
cip/4.4-st: [2a1697e925071b330bb9a66a8c200ea4d0dfc18e]
stable/4.19: [1177afeca833174ba83504688eec898c6214f4bf]
stable/5.10: [34b76d1922e41da1fa73d43b764cddd82ac9733c]
stable/5.15: [20cf67dcb7db842f941eff1af6ee5e9dc41796d7]
stable/5.4: [63e5d035e3a7ab7412a008f202633c5e6a0a28ea]
stable/6.1: [2d33654d40a05afd91ab24c9a73ab512a0670a9a]
stable/6.6: [9525af1f58f67df387768770fcf6d6a8f23aee3d]

CVE-2024-42236: usb: gadget: configfs: Prevent OOB read/write in
usb_string_copy()

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [635be42972505074c0d89fdc98a0ff5708c9a54f]
cip/4.4-rt: [635be42972505074c0d89fdc98a0ff5708c9a54f]
cip/4.4-st: [635be42972505074c0d89fdc98a0ff5708c9a54f]
stable/4.19: [a444c3fc264119801575ab086e03fb4952f23fd0]
stable/5.10: [e8474a10c535e6a2024c3b06e37e4a3a23beb490]
stable/5.15: [72b8ee0d9826e8ed00e0bdfce3e46b98419b37ce]
stable/5.4: [c95fbdde87e39e5e0ae27f28bf6711edfb985caa]
stable/6.1: [2d16f63d8030903e5031853e79d731ee5d474e70]
stable/6.6: [d1205033e912f9332c1dbefa812e6ceb0575ce0a]

CVE-2024-42265: protect the fetch of ->fd[fd] in do_dup2() from mispredictions

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [40f3e5b0f39c49db1e0b03afcae4692c5e9152e1]
cip/4.4-rt: [40f3e5b0f39c49db1e0b03afcae4692c5e9152e1]
cip/4.4-st: [40f3e5b0f39c49db1e0b03afcae4692c5e9152e1]
stable/4.19: [ed42e8ff509d2a61c6642d1825032072dab79f26]
stable/5.10: [08775b3d6ed117cf4518754ec7300ee42b6a5368]
stable/5.15: [3f480493550b6a23d3a65d095d6569d4a7f56a0f]
stable/5.4: [41a6c31df77bd8e050136b0a200b537da9e1084a]
stable/6.1: [5db999fff545b924b24c9afd368ef5c17279b176]
stable/6.10: [1171ceccabfd596ca370c5d2cbb47d110c3f2fe1]
stable/6.6: [da72e783afd27d9f487836b2e6738146c0edd149]

CVE-2024-42271: net/iucv: fix use after free in iucv_sock_close()

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [7096f812168f1243c77323d84d6e23e908ae3803]
cip/4.4-rt: [7096f812168f1243c77323d84d6e23e908ae3803]
cip/4.4-st: [7096f812168f1243c77323d84d6e23e908ae3803]
stable/4.19: [84f40b46787ecb67c7ad08a5bb1376141fa10c01]
stable/5.10: [c65f72eec60a34ace031426e04e9aff8e5f04895]
stable/5.15: [ac758e1f663fe9bc64f6b47212a2aa18697524f5]
stable/5.4: [37652fbef9809411cea55ea5fa1a170e299efcd0]
stable/6.1: [8b424c9e44111c5a76f41c6b741f8d4c4179d876]
stable/6.10: [69620522c48ce8215e5eb55ffbab8cafee8f407d]
stable/6.6: [01437282fd3904810603f3dc98d2cac6b8b6fc84]

CVE-2024-42280: mISDN: Fix a use after free in hfcmulti_tx()

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [9ee375d7e5ef48c57b78eba35188a57dcc166128]
cip/4.4-rt: [9ee375d7e5ef48c57b78eba35188a57dcc166128]
cip/4.4-st: [9ee375d7e5ef48c57b78eba35188a57dcc166128]
stable/4.19: [70db2c84631f50e02e6b32b543700699dd395803]
stable/5.10: [9460ac3dd1ae033bc2b021a458fb535a0c36ddb2]
stable/5.15: [8f4030277dfb9dbe04fd78566b19931097c9d629]
stable/5.4: [d3e4d4a98c5629ccdcb762a0ff6c82ba9738a0c3]
stable/6.1: [4d8b642985ae24f4b3656438eb8489834a17bb80]
stable/6.10: [7e4a539bca7d8d20f2c5d93c18cce8ef77cd78e0]
stable/6.6: [ddc79556641ee070d36be0de4a1f0a16a71f1fc7]

CVE-2024-42284: tipc: Return non-zero value from tipc_udp_addr2str() on error

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [067c903b48150396dc47ffa310cc5d2c38cf2dc4]
cip/4.4-rt: [067c903b48150396dc47ffa310cc5d2c38cf2dc4]
cip/4.4-st: [067c903b48150396dc47ffa310cc5d2c38cf2dc4]
stable/4.19: [7ec3335dd89c8d169e9650e4bac64fde71fdf15b]
stable/5.10: [aa38bf74899de07cf70b50cd17f8ad45fb6654c8]
stable/5.15: [5eea127675450583680c8170358bcba43227bd69]
stable/5.4: [253405541be2f15ffebdeac2f4cf4b7e9144d12f]
stable/6.1: [728734352743a78b4c5a7285b282127696a4a813]
stable/6.10: [2abe350db1aa599eeebc6892237d0bce0f1de62a]
stable/6.6: [76ddf84a52f0d8ec3f5db6ccce08faf202a17d28]

CVE-2024-42295: nilfs2: handle inconsistent state in nilfs_btnode_create_block()

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [59de81bedb893c7b00f7c4e519da0d6c00308f71]
cip/4.4-rt: [59de81bedb893c7b00f7c4e519da0d6c00308f71]
cip/4.4-st: [59de81bedb893c7b00f7c4e519da0d6c00308f71]
stable/4.19: [19cce46238ffe3546e44b9c74057103ff8b24c62]
stable/5.10: [5f0a6800b8aec1b453c7fe4c44fcaac5ffe9d52e]
stable/5.15: [e34191cce3ee63dfa5fb241904aaf2a042d5b6d8]
stable/5.4: [02b87e6334a38c65eef49848d3f1ac422f0b2a44]
stable/6.1: [012be828a118bf496e666ef1fc47fc0e7358ada2]
stable/6.10: [366c3f688dd0288cbe38af1d3a886b5c62372e4a]
stable/6.6: [be56dfc9be0604291267c07b0e27a69a6bda4899]

CVE-2024-42305: ext4: check dot and dotdot of dx_root before making dir indexed

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [288371badca6bc2b5d8f2d61476fe400418663a3]
cip/4.4-rt: [288371badca6bc2b5d8f2d61476fe400418663a3]
cip/4.4-st: [288371badca6bc2b5d8f2d61476fe400418663a3]
stable/4.19: [b80575ffa98b5bb3a5d4d392bfe4c2e03e9557db]
stable/5.10: [42d420517072028fb0eb852c358056b7717ba5aa]
stable/5.15: [8afe06ed3be7a874b3cd82ef5f8959aca8d6429a]
stable/5.4: [19e13b4d7f0303186fcc891aba8d0de7c8fdbda8]
stable/6.1: [abb411ac991810c0bcbe51c2e76d2502bf611b5c]
stable/6.10: [cdd345321699042ece4a9d2e70754d2397d378c5]
stable/6.6: [9d241b7a39af192d1bb422714a458982c7cc67a2]

CVE-2024-42309: drm/gma500: fix null pointer dereference in
psb_intel_lvds_get_modes

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [d7612431834ee6ff544676f830774ccac47bfc97]
cip/4.4-rt: [d7612431834ee6ff544676f830774ccac47bfc97]
cip/4.4-st: [d7612431834ee6ff544676f830774ccac47bfc97]
stable/4.19: [13b5f3ee94bdbdc4b5f40582aab62977905aedee]
stable/5.10: [6735d02ead7dd3adf74eb8b70aebd09e0ce78ec9]
stable/5.15: [7e52c62ff029f95005915c0a11863b5fb5185c8c]
stable/5.4: [d6ad202f73f8edba0cbc0065aa57a79ffe8fdcdc]
stable/6.1: [f70ffeca546452d1acd3a70ada56ecb2f3e7f811]
stable/6.10: [475a5b3b7c8edf6e583a9eb59cf28ea770602e14]
stable/6.6: [46d2ef272957879cbe30a884574320e7f7d78692]

CVE-2024-42310: drm/gma500: fix null pointer dereference in
cdv_intel_lvds_get_modes

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [742f39fc8f70286ec17c4a23a2d0870dd0557dea]
cip/4.4-rt: [742f39fc8f70286ec17c4a23a2d0870dd0557dea]
cip/4.4-st: [742f39fc8f70286ec17c4a23a2d0870dd0557dea]
stable/4.19: [f392c36cebf4c1d6997a4cc2c0f205254acef42a]
stable/5.10: [b6ac46a00188cde50ffba233e6efb366354a1de5]
stable/5.15: [08f45102c81ad8bc9f85f7a25e9f64e128edb87d]
stable/5.4: [a658ae2173ab74667c009e2550455e6de5b33ddc]
stable/6.1: [e74eb5e8089427c8c49e0dd5067e5f39ce3a4d56]
stable/6.10: [977ee4fe895e1729cd36cc26916bbb10084713d6]
stable/6.6: [2d209b2f862f6b8bff549ede541590a8d119da23]

CVE-2024-42311: hfs: fix to initialize fields of hfs_inode_info after
hfs_alloc_inode()

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [7f9b1662b09a1b8c368842bd7a560124cf206fd2]
cip/4.4-rt: [7f9b1662b09a1b8c368842bd7a560124cf206fd2]
cip/4.4-st: [7f9b1662b09a1b8c368842bd7a560124cf206fd2]
stable/4.19: [f7316b2b2f11cf0c6de917beee8d3de728be24db]
stable/5.10: [10f7163bfb5f8b4e0c9c05a939f20b8540e33c65]
stable/5.15: [d55aae5c1730d6b70d5d8eaff00113cd34772ea3]
stable/5.4: [4a52861cd76e79f1a593beb23d096523eb9732c2]
stable/6.1: [58d83fc160505a7009c39dec64effaac5129b971]
stable/6.10: [d3493d6f0dfb1ab5225b62faa77732983f2187a1]
stable/6.6: [9c4e40b9b731220f9464975e49da75496e3865c4]

CVE-2024-43839: bna: adjust 'name' buf size of bna_tcb and bna_ccb structures

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [67ff40d801c47b54bd85188a2295d9dae3699851]
cip/4.4-rt: [67ff40d801c47b54bd85188a2295d9dae3699851]
cip/4.4-st: [67ff40d801c47b54bd85188a2295d9dae3699851]
stable/4.19: [f121740f69eda4da2de9a20a6687a13593e72540]
stable/5.10: [6ce46045f9b90d952602e2c0b8886cfadf860bf1]
stable/5.15: [6d20c4044ab4d0e6a99aa35853e66f0aed5589e3]
stable/5.4: [c90b1cd7758fd4839909e838ae195d19f8065d76]
stable/6.1: [ab748dd10d8742561f2980fea08ffb4f0cacfdef]
stable/6.10: [e0f48f51d55fb187400e9787192eda09fa200ff5]
stable/6.6: [b0ff0cd0847b03c0a0abe20cfa900eabcfcb9e43]

CVE-2024-43858: jfs: Fix array-index-out-of-bounds in diFree

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [75c2d85f2f4c4f0b7449048c1750a40650aebc39]
cip/4.4-rt: [75c2d85f2f4c4f0b7449048c1750a40650aebc39]
cip/4.4-st: [75c2d85f2f4c4f0b7449048c1750a40650aebc39]
stable/4.19: [55b732c8b09b41148eaab2fa8e31b0af47671e00]
stable/5.10: [538a27c8048f081a5ddd286f886eb986fbbc7f80]
stable/5.15: [63f7fdf733add82f126ea00e2e48f6eba15ac4b9]
stable/5.4: [9b3a4345957f5372041bc4f59de322f62653e862]
stable/6.1: [8d8f9a477de0d7962342eedf2a599215b7c63d28]
stable/6.10: [6aa6892a90a5a7fabffe5692ab9f06a7a46c6e42]
stable/6.6: [ff14eadc278663cac69d57d3ca7fb2f394e1f8a7]

CVE-2024-43882: exec: Fix ToCToU between perm check and set-uid/gid usage

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [dc94c7ed18b093f47bf32ea94ea768345cdf4ee4]
cip/4.4-rt: [dc94c7ed18b093f47bf32ea94ea768345cdf4ee4]
cip/4.4-st: [dc94c7ed18b093f47bf32ea94ea768345cdf4ee4]
stable/4.19: [d5c3c7e26275a2d83b894d30f7582a42853a958f]
stable/5.10: [15469d46ba34559bfe7e3de6659115778c624759]
stable/5.15: [9b424c5d4130d56312e2a3be17efb0928fec4d64]
stable/5.4: [368f6985d46657b8b466a421dddcacd4051f7ada]
stable/6.1: [f6cfc6bcfd5e1cf76115b6450516ea4c99897ae1]
stable/6.10: [90dfbba89ad4f0d9c9744ecbb1adac4aa2ff4f3e]
stable/6.6: [d2a2a4714d80d09b0f8eb6438ab4224690b7121e]

CVE-2024-43883: usb: vhci-hcd: Do not drop references before new
references are gained

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [851f3d2f24d29037983055159644be5047315fdc]
cip/4.4-rt: [851f3d2f24d29037983055159644be5047315fdc]
cip/4.4-st: [851f3d2f24d29037983055159644be5047315fdc]
stable/4.19: [5a3c473b28ae1c1f7c4dc129e30cb19ae6e96f89]
stable/5.10: [4dacdb9720aaab10b6be121eae55820174d97174]
stable/5.15: [e8c1e606dab8c56cf074b43b98d0805de7322ba2]
stable/5.4: [9c3746ce8d8fcb3a2405644fc0eec7fc5312de80]
stable/6.1: [585e6bc7d0a9bf73a8be3d3fb34e86b90cc61a14]
stable/6.10: [c3d0857b7fc2c49f68f89128a5440176089a8f54]
stable/6.6: [128e82e41cf7d74a562726c1587d9d2ede1a0a37]

CVE-2024-43893: serial: core: check uartclk for zero to avoid divide by zero

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [5f00eb3fc53d99633b99afb1ace18ee3a65a91ff]
cip/4.4-rt: [5f00eb3fc53d99633b99afb1ace18ee3a65a91ff]
cip/4.4-st: [5f00eb3fc53d99633b99afb1ace18ee3a65a91ff]
stable/4.19: [3bbd90fca824e6fd61fb20f6dd2b0fa5f8b14bba]
stable/5.10: [52b138f1021113e593ee6ad258ce08fe90693a9e]
stable/5.15: [9196e42a3b8eeff1707e6ef769112b4b6096be49]
stable/5.4: [55b2a5d331a6ceb1c4372945fdb77181265ba24f]
stable/6.1: [e13ba3fe5ee070f8a9dab60029d52b1f61da5051]
stable/6.10: [68dc02f319b9ee54dc23caba742a5c754d1cccc8]
stable/6.6: [e3ad503876283ac3fcca922a1bf243ef9eb0b0e2]

CVE-2024-43914: md/raid5: avoid BUG_ON() while continue reshape after
reassembling

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [18d531fff4a7fa4eb0888b871f1810a9e172f5d5]
cip/4.4-rt: [18d531fff4a7fa4eb0888b871f1810a9e172f5d5]
cip/4.4-st: [18d531fff4a7fa4eb0888b871f1810a9e172f5d5]
stable/4.19: [2c92f8c1c456d556f15cbf51667b385026b2e6a0]
stable/5.10: [c384dd4f1fb3b14a2fd199360701cc163ea88705]
stable/5.15: [bf0ff69a42a3d2d46876d0514ecf13dffc516666]
stable/5.4: [6b33c468d543f6a83de2d61f09fec74b27e19fd2]
stable/6.1: [3b33740c1750a39e046339ff9240e954f0156707]
stable/6.10: [4811d6e5d9f4090c3e0ff9890eb24077108046ab]
stable/6.6: [775a9ba16c9ffe98fe54ebf14e55d5660f2bf600]

CVE-2024-44931: gpio: prevent potential speculation leaks in
gpio_device_get_desc()

stable/6.1 was fixed.

Fixed status
stable/6.1: [672c19165fc96dfad531a5458e0b3cdab414aae4]
stable/6.10: [d776c0486b03a5c4afca65b8ff44573592bf93bb]
stable/6.6: [1b955f786a4bcde8c0ccb2b7d519def2acb6f3cc]

CVE-2024-44944: netfilter: ctnetlink: use helper function to calculate expect ID

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [0b0ff680bfcb450ab4896f9c79c547e6d5832445]
cip/4.4-rt: [0b0ff680bfcb450ab4896f9c79c547e6d5832445]
cip/4.4-st: [0b0ff680bfcb450ab4896f9c79c547e6d5832445]
stable/4.19: [66e7650dbbb8e236e781c670b167edc81e771450]
stable/5.10: [eb4ca1a97e08ff5b920664ba292e576257e2d184]
stable/5.15: [5e2c24f7b0911b15c29aefce760bcf770542fb61]
stable/5.4: [64c0b8e64be8368617ef08dfc59a3160563a1435]
stable/6.1: [24f407042cf90b0872de667460230d8d50c06c39]
stable/6.10: [74de442b8e12a207c07953ee068009a7701aff8f]
stable/6.6: [27662b46f2adaa52c1665a82af4b21c42c4337fd]

CVE-2024-44948: x86/mtrr: Check if fixed MTRRs exist before saving them

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [37bc154f61c9e697fe619eeb4fc40d24951a7417]
cip/4.4-rt: [37bc154f61c9e697fe619eeb4fc40d24951a7417]
cip/4.4-st: [37bc154f61c9e697fe619eeb4fc40d24951a7417]
stable/4.19: [34f36e6ee5bd7eff8b2adcd9fcaef369f752d82e]
stable/5.10: [450b6b22acdaac67a18eaf5ed498421ffcf10051]
stable/5.15: [ca7d00c5656d1791e28369919e3e10febe9c3b16]
stable/5.4: [06c1de44d378ec5439db17bf476507d68589bfe9]
stable/6.1: [8aa79dfb216b865e96ff890bc4ea71650f9bc8d7]
stable/6.10: [388f1c954019f253a8383f7eb733f38d541e10b6]
stable/6.6: [8a90d3fc7c24608548d3a750671f9dac21d1a462]

CVE-2024-44954: ALSA: line6: Fix racy access to midibuf

cip/4.4-rt was fixed.

Fixed status
cip/4.4: [1ac1b3829b4de84fed73b581b68d3d101c91b267]
cip/4.4-rt: [1ac1b3829b4de84fed73b581b68d3d101c91b267]
cip/4.4-st: [1ac1b3829b4de84fed73b581b68d3d101c91b267]
stable/4.19: [643293b68fbb6c03f5e907736498da17d43f0d81]
stable/5.10: [e7e7d2b180d8f297cea6db43ea72402fd33e1a29]
stable/5.15: [a54da4b787dcac60b598da69c9c0072812b8282d]
stable/5.4: [40f3d5cb0e0cbf7fa697913a27d5d361373bdcf5]
stable/6.1: [c80f454a805443c274394b1db0d1ebf477abd94e]
stable/6.10: [51d87f11dd199bbc6a85982b088ff27bde53b48a]
stable/6.6: [535df7f896a568a8a1564114eaea49d002cb1747]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

