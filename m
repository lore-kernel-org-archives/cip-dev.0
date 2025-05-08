Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87C4C3ABC0
	for <webhook@archiver.kernel.org>; Thu,  8 May 2025 11:57:22 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
 by mx.groups.io with SMTP id smtpd.web11.13493.1746705434970271492
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 May 2025 04:57:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=noPaCgFG;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=o7bXhjW9;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.161, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1746705414; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QpV1coSX89CyIWw7GQ0U9Gg5nWQkED3Bsmc64rFnYacN1dYXtzf8eDSsJtjjWxAmDn
    zsPlvcGpre50TFVRO+OTrGKhC6U0xDmnBNFy/UaOMq25dt1TcI6ehHhQu+Dm5QTzNJDO
    9V1yF2bGVqDZTEeCOi6DPpl0+wS0vn/2ieIHiM+sbAfGYTK5LMhs7b2V0wre/FLsltwQ
    /jSjaEofqd6pu8yg6RmNCSR+KUnFVL+s7vss84bHVIvsE3nkiKasriZBBucDvnQyZYPy
    bVYkT/lojDYxJlDDG/6IKvUZ4IiqisMTUTqw5/LbhMbL204aAUy5kC+9r/BeD8VIJMMi
    ImXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1746705414;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=XN1gkVu176BuKPxpmf+abC5xFjZd80GkpicS7xKCLrI=;
    b=l7y2LgiW+qQkE7lfEXCiry8JVSOewz3/yxujH/j6jBNfV1i5sP6y4NGBNz82RVWCXF
    zj+XsH083P+AvCnkLNuG8lBhsxxDl6OWA75mgcppPV0Jtc4vrW6eh5ryxxj3u1liALfp
    VHIoEwK8ZWHd6E71KMhm4kiUEaP/s7UCK4ApxnKLEVFwsgENgAs8LEh3iwv1OOjL2lMz
    bfMJMuKgH6aW3SEfFxNHXWUueM0uoFGeCdUzY7O2ockQIFMrBFJWxbRxW0ZvpUu8Z0HN
    eFfvRjwigmDLUjtFYIKdm9bF5IpiVsA3y5FkA7bJ80DMjtjmFKziIcwMgxs/6+wZ2XQ8
    f0uw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1746705414;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=XN1gkVu176BuKPxpmf+abC5xFjZd80GkpicS7xKCLrI=;
    b=noPaCgFGpcDKDmP1FAML+rzX36DgCMnqAHqWh7dnZY/F7qSdzJjJmP/aWYMH1Qof6s
    f7CboMbjHrsAwP4WbUkPJrc6EPlMMtm9whYf0CXJhAIuMAePjHx8TzP4sZ3Z141VJj3r
    1EtT7w++r0zkS5ZcfVIAhb5I4nmUjQFHDgcD2OlBYjF0e6qOanyLOJM3d7j2Wr7ctrqq
    i3AFjxIhJmBut+4etPsqcwUi2JxJbNtnHNhZJZsIqjFr8bdda+KQbrSA8emsnUz3B9jB
    WW7hM1VsZQUqrjsuud1RoeA/xyryiiD2Sq7JtI30zAWdMCvyJCbMzD19zC8RXOJ9gDEi
    ww2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1746705414;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=XN1gkVu176BuKPxpmf+abC5xFjZd80GkpicS7xKCLrI=;
    b=o7bXhjW9m1BE05cb2z/O2dzBN1aLuH48LzrZC3R71aQp4EFcijLRHgjl0KNuM5Umyx
    aZt+eCBmIg/PtZTafMAA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hex6fd76vq"
Received: from open-xchange-core-mw-gw-24.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a340148Bur1jy
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 8 May 2025 13:56:53 +0200 (CEST)
Date: Thu, 8 May 2025 13:56:53 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <2829441.388422.1746705413499@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.19.325-cip120
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.33.60
X-Originating-Port: 42556
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 May 2025 11:57:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18780

Hi,

the CIP kernel team has released Linux kernel v4.19.325-cip120. The linux-4.19.y-cip tree's base version has been updated to v4.19-st4. The trees are up-to-date with kernel 5.4.292.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/

  v4.19.325-cip120:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      33b79fc4625daef9e71c91db90a0808d2bc1ae23
    Fixed CVEs:
      CVE-2025-21638: sctp: sysctl: auth_enable: avoid using current->nsproxy
      CVE-2025-21640: sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
      CVE-2025-21956: drm/amd/display: Assign normalized_pix_clk when color depth = 14
      CVE-2025-21959: netfilter: nf_conncount: Fully initialize struct nf_conncount_tuple in insert_tree()
      CVE-2025-21991: x86/microcode/AMD: Fix out-of-bounds on systems with CPU-less NUMA nodes
      CVE-2025-21992: HID: ignore non-functional sensor in HP 5MP Camera
      CVE-2025-21996: drm/radeon: fix uninitialized size issue in radeon_vce_cs_parse()
      CVE-2025-22004: net: atm: fix use after free in lec_send()
      CVE-2025-22007: Bluetooth: Fix error code in chan_alloc_skb_cb()
      CVE-2023-53034: ntb_hw_switchtec: Fix shift-out-of-bounds in switchtec_ntb_mw_set_trans
      CVE-2025-21971: net_sched: Prevent creation of classes with TC_H_ROOT
      CVE-2025-21993: iscsi_ibft: Fix UBSAN shift-out-of-bounds warning in ibft_attr_show_nic()
      CVE-2025-22018: atm: Fix NULL pointer dereference
      CVE-2025-22021: netfilter: socket: Lookup orig tuple for IPv6 SNAT
      CVE-2025-22035: tracing: Fix use-after-free in print_graph_function_flags during tracer switching
      CVE-2025-22054: arcnet: Add NULL check in com20020pci_probe()
      CVE-2025-22063: netlabel: Fix NULL pointer exception caused by CALIPSO on IPv4 sockets
      CVE-2025-22071: spufs: fix a leak in spufs_create_context()
      CVE-2025-22073: spufs: fix a leak on spufs_new_file() failure
      CVE-2025-22079: ocfs2: validate l_tree_depth to avoid out-of-bounds access
      CVE-2025-22086: RDMA/mlx5: Fix mlx5_poll_one() cur_qp update flow
      CVE-2025-23136: thermal: int340x: Add NULL check for adev
      CVE-2025-38637: net_sched: skbprio: Remove overly strict queue assertions
      CVE-2025-39735: jfs: fix slab-out-of-bounds read in ea_get()

Best regards,
Ulrich Hecht

